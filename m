Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262433AbTC1Hvp>; Fri, 28 Mar 2003 02:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbTC1Hvo>; Fri, 28 Mar 2003 02:51:44 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:36579 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S262433AbTC1Hvl>; Fri, 28 Mar 2003 02:51:41 -0500
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF9065148@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: inw/outw performance
Date: Fri, 28 Mar 2003 09:00:54 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All!

  [ please CC me - I'm not subscribed ]

  [ do not know where else to send - so it goes here,
    I hope some-one more qualified can advice something ]

  I have a little question which comes down to two little 
  CPU instructions - inw/outw.

  I have a proprietary PCI board (PMD MC2140 motion controller with PLX).
  I have wrote device driver for it (heap of ioctl()s - not more).

  Now my company investigates possibilities to go to high-performance 
  market - and I have hit the problem with performance.

  Communication with controller (sending of the command and reading back 
  response) looks like this:

    outw(cmd_port, command);
    while( !(inw(status_port)&READY) );
    outw(data_port, param1);
    while( !(inw(status_port)&READY) );
    outw(data_port, param2);
    while( !(inw(status_port)&READY) );
    ...
    outw(data_port, paramN);
    while( !(inw(status_port)&COMMAND_DONE) );

    resp_data1 = inw(data_port);
    while( !(inw(status_port)&READY) );
    ...
    resp_dataM = inw(data_port);
    while( !(inw(status_port)&READY) );
 
  And actually what I have found that on my development P3/1GHz system
  every inw() takes more that 3us. I wasn't measuring outw() yet - but 
  I do not expect its timing to be better.

  Whole communication sequence on average takes ~55us. I need to execute 
  tens of commands for every user request - and time goes to some hefty 
  3millis just to program motion controller. And on deployment (embedded) 
  platform this is going to be even worse.

  Okay. Our motion controller has 20MHz clock inside. So for every 50 
  cycles of CPU I have only 1 cycle of motion controller. 3us ~ 1k
  commands of CPU, and at top 20MHz/3us == 6,(6) commands of motion 
  controller.

  Am I right in my calculations? I have hit the limit of our device 
  bandwidth?
  Is there any other way to communicate over PCI bus with controller?
  - I can ask our hw enginers to implement something, if there is something
  possible to implement to improve performance.

  I'm using interrupt-driven IO to communicate with user space. I have 
  to execute several commands with motion controller: and it takes 200-400us

  just to clear interrupt state of motion controller - Is it okay timing for

  interrupt handler? Or should I try move stuff to BH or something like
this?

  Thanks in advance.

--- Regards&Wishes! With respect  Ihar "Philips" Filipau, Phil for friends

- - - - - - - - - - - - - - - - - - - - - - - - -
MCS/Mathematician - System Programmer
Ihar Filipau 
Software entwickler @ SUSS MicroTec Test Systems GmbH, 
Suss-Strasse 1, D-01561 Sacka (bei Dresden)
e-mail: ifilipau@sussdd.de  tel: +49-(0)-352-4073-327
fax: +49-(0)-352-4073-700   web: http://www.suss.com/
