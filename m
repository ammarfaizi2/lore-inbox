Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUFOS3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUFOS3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUFOS22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:28:28 -0400
Received: from winds.org ([68.75.195.9]:20678 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S265841AbUFOS0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:26:53 -0400
Date: Tue, 15 Jun 2004 14:26:49 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Make USB process hub events in correct order
Message-ID: <Pine.LNX.4.60.0406151412430.26219@winds.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1262750147-373173186-1087323718=:26219"
Content-ID: <Pine.LNX.4.60.0406151423130.26219@winds.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1262750147-373173186-1087323718=:26219
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.60.0406151423131.26219@winds.org>

This patch fixes the USB hub module to process events in the order that they
are received. It fixes the case where multi-port devices have multiple
hubs in them--while they are detected in the correct order, they are
initialized in reverse. It is required for the Sealink 8-port USB->serial hubs
to initialize with the port numbers in the correct order.

I don't think it breaks any existing functionality, but I won't send this to
Linus yet till I know it doesn't break anything.

Patch below against 2.6.7-rc3.



--- linux/drivers/usb/core/hub.bak	2004-06-08 10:21:57.000000000 -0400
+++ linux/drivers/usb/core/hub.c	2004-06-08 10:59:34.000000000 -0400
@@ -260,7 +260,7 @@

  	/* Something happened, let khubd figure it out */
  	if (list_empty(&hub->event_list)) {
-		list_add(&hub->event_list, &hub_event_list);
+		list_add_tail(&hub->event_list, &hub_event_list);
  		wake_up(&khubd_wait);
  	}


An example without the patch (1-1.2.1 gets initialized before 1-1.1.1):

usb 1-1: new full speed USB device using address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.1: new full speed USB device using address 3
hub 1-1.1:1.0: USB hub found
hub 1-1.1:1.0: 4 ports detected
usb 1-1.2: new full speed USB device using address 4
hub 1-1.2:1.0: USB hub found
hub 1-1.2:1.0: 4 ports detected
usb 1-1.2.1: new full speed USB device using address 5
ftdi_sio 1-1.2.1:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.1: FTDI FT232BM Compatible converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 1-1.2.2: new full speed USB device using address 6
ftdi_sio 1-1.2.2:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.2: FTDI FT232BM Compatible converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 1-1.2.3: new full speed USB device using address 7
ftdi_sio 1-1.2.3:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.3: FTDI FT232BM Compatible converter now attached to ttyUSB2 (or usb/tts/2 for devfs)
usb 1-1.2.4: new full speed USB device using address 8
ftdi_sio 1-1.2.4:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.4: FTDI FT232BM Compatible converter now attached to ttyUSB3 (or usb/tts/3 for devfs)
usb 1-1.1.1: new full speed USB device using address 9
ftdi_sio 1-1.1.1:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.1: FTDI FT232BM Compatible converter now attached to ttyUSB4 (or usb/tts/4 for devfs)
usb 1-1.1.2: new full speed USB device using address 10
ftdi_sio 1-1.1.2:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.2: FTDI FT232BM Compatible converter now attached to ttyUSB5 (or usb/tts/5 for devfs)
usb 1-1.1.3: new full speed USB device using address 11
ftdi_sio 1-1.1.3:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.3: FTDI FT232BM Compatible converter now attached to ttyUSB6 (or usb/tts/6 for devfs)
usb 1-1.1.4: new full speed USB device using address 12
ftdi_sio 1-1.1.4:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.4: FTDI FT232BM Compatible converter now attached to ttyUSB7 (or usb/tts/7 for devfs)


With the patch (the correct ordering):

usb 1-1: new full speed USB device using address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1.1: new full speed USB device using address 3
hub 1-1.1:1.0: USB hub found
hub 1-1.1:1.0: 4 ports detected
usb 1-1.2: new full speed USB device using address 4
hub 1-1.2:1.0: USB hub found
hub 1-1.2:1.0: 4 ports detected
usb 1-1.1.1: new full speed USB device using address 5
ftdi_sio 1-1.1.1:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.1: FTDI FT232BM Compatible converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 1-1.1.2: new full speed USB device using address 6
ftdi_sio 1-1.1.2:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.2: FTDI FT232BM Compatible converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 1-1.1.3: new full speed USB device using address 7
ftdi_sio 1-1.1.3:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.3: FTDI FT232BM Compatible converter now attached to ttyUSB2 (or usb/tts/2 for devfs)
usb 1-1.1.4: new full speed USB device using address 8
ftdi_sio 1-1.1.4:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.1.4: FTDI FT232BM Compatible converter now attached to ttyUSB3 (or usb/tts/3 for devfs)
usb 1-1.2.1: new full speed USB device using address 9
ftdi_sio 1-1.2.1:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.1: FTDI FT232BM Compatible converter now attached to ttyUSB4 (or usb/tts/4 for devfs)
usb 1-1.2.2: new full speed USB device using address 10
ftdi_sio 1-1.2.2:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.2: FTDI FT232BM Compatible converter now attached to ttyUSB5 (or usb/tts/5 for devfs)
usb 1-1.2.3: new full speed USB device using address 11
ftdi_sio 1-1.2.3:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.3: FTDI FT232BM Compatible converter now attached to ttyUSB6 (or usb/tts/6 for devfs)
usb 1-1.2.4: new full speed USB device using address 12
ftdi_sio 1-1.2.4:1.0: FTDI FT232BM Compatible converter detected
usb 1-1.2.4: FTDI FT232BM Compatible converter now attached to ttyUSB7 (or usb/tts/7 for devfs)


  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
--1262750147-373173186-1087323718=:26219
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="usb-2.6.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0406151421580.26219@winds.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="usb-2.6.patch"

LS0tIGxpbnV4L2RyaXZlcnMvdXNiL2NvcmUvaHViLmJhawkyMDA0LTA2LTA4
IDEwOjIxOjU3LjAwMDAwMDAwMCAtMDQwMA0KKysrIGxpbnV4L2RyaXZlcnMv
dXNiL2NvcmUvaHViLmMJMjAwNC0wNi0wOCAxMDo1OTozNC4wMDAwMDAwMDAg
LTA0MDANCkBAIC0yNjAsNyArMjYwLDcgQEANCiANCiAJLyogU29tZXRoaW5n
IGhhcHBlbmVkLCBsZXQga2h1YmQgZmlndXJlIGl0IG91dCAqLw0KIAlpZiAo
bGlzdF9lbXB0eSgmaHViLT5ldmVudF9saXN0KSkgew0KLQkJbGlzdF9hZGQo
Jmh1Yi0+ZXZlbnRfbGlzdCwgJmh1Yl9ldmVudF9saXN0KTsNCisJCWxpc3Rf
YWRkX3RhaWwoJmh1Yi0+ZXZlbnRfbGlzdCwgJmh1Yl9ldmVudF9saXN0KTsN
CiAJCXdha2VfdXAoJmtodWJkX3dhaXQpOw0KIAl9DQogDQo=

--1262750147-373173186-1087323718=:26219--
