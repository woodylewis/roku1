' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

sub init()
  m.Image       = m.top.findNode("Image")
  m.ButtonGroup = m.top.findNode("ButtonGroup")
  m.Details     = m.top.findNode("Details")
  m.Title       = m.top.findNode("Title")
  m.Video       = m.top.findNode("Video")
  m.Warning     = m.top.findNode("WarningDialog")
  m.Exiter      = m.top.findNode("Exiter")
  setContent()
  m.ButtonGroup.setFocus(true)
  m.ButtonGroup.observeField("buttonSelected","onButtonSelected")

  'm.readContentTask = createObject("roSGNode", "ContentReader")
  'm.readContentTask.observeField("content", "getContent")
  'm.readContentTask.contenturi = "http://www.sdktestinglab.com/Tutorial/content/categoriescontent.xml"
  'm.readContentTask.control = "RUN"
end sub

sub getContent()
  m.categoriespanel = m.top.panelSet.createChild("GL1ListPanel")
  m.categoriespanel.list.content = m.readContentTask.content
  m.categoriespanel.setFocus(true)
end sub

sub onButtonSelected()
  if m.ButtonGroup.buttonSelected = 0
    m.Video.visible = "true"
    m.Video.control = "play"
    m.Video.setFocus(true)
  else if m.ButtonGroup.buttonSelected = 1
    m.Video.visible = "false"
    m.Video.control = "stop"
    m.Video.setFocus(false)
  else
    m.Exiter.control = "RUN"
  end if
end sub

sub setContent()
  m.Image.uri="pkg:/images/125th.jpg"
  ContentNode = CreateObject("roSGNode", "ContentNode")
  ContentNode.streamFormat = "mp4"
  ContentNode.url = "https://gothamlane.com/video/1train.mp4"
  ContentNode.ShortDescriptionLine1 = "Gotham Lane"
  ContentNode.Description = "1 Train North of 125th Street"
  ContentNode.StarRating = 80
  ContentNode.Length = 1972
  ContentNode.Title = "1 Train North of 125th Street"
  m.Video.content = ContentNode
  Buttons = ["Play Video","Show List", "Exit"]
  m.ButtonGroup.buttons = Buttons
  m.Title.text = "Gotham Lane"
  m.Details.text =  "1 Train North of 125th Street"
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  if press then
    if key = "back"
      print "------ [back pressed] ------"
      if m.Warning.visible
        m.Warning.visible = false
        m.ButtonGroup.setFocus(true)
        return true
      else if m.Video.visible
        m.Video.control = "stop"
        m.Video.visible = false
        m.ButtonGroup.setFocus(true)
        return true
      else
        return false
      end if
    else if key = "OK"
      if m.Warning.visible
        m.Warning.visible = false
        m.ButtonGroup.setFocus(true)
        return true
      end if
    else
      return false
    end if
  end if
  return false
end function
