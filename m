Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSKBI5F>; Sat, 2 Nov 2002 03:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbSKBI5F>; Sat, 2 Nov 2002 03:57:05 -0500
Received: from smtp2.sooninternet.net ([212.246.17.84]:17025 "EHLO
	smtp2.sooninternet.net") by vger.kernel.org with ESMTP
	id <S265901AbSKBI5B>; Sat, 2 Nov 2002 03:57:01 -0500
Date: Sat, 2 Nov 2002 11:03:16 +0200
From: Kari Hameenaho <khaho@koti.soon.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech wheel and 2.5? (PS/2)
Message-Id: <20021102110316.3c60c30d.khaho@koti.soon.fi>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Gregoire Favre wrote:

> Hello,
>
> up to 2.5.45:
>
> ...
> register interface 'mouse' with class 'input
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> ...
> psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> psmouse.c: Received PS2++ packet #0, but don't know how to handle.
> ...
>
> And very regulary my mouse position is lost and reseted???
> Also the wheel don't work (don't know for the button on the left that
> I never use: the 3 regulars one and the wheel are enough for me...).

The packet #0 message is not causing any trouble.

The wheel will work in X with mouse set to imps/2, in XF86Config(-4):
Section "InputDevice"
..
    Option "Protocol"    "ImPS/2"
    Option "ZAxisMapping" "4 5"
...
EndSection

Button on left may act same as middle button, at least for me it is and
nicer to use.

Mouse position loose seems to be caused by strange messages from mouse:
is your mouse wireless too ?
Here is a patch that works for me: note that it is too ugly for real
inclusion and may cause troubles in other setups. But you can try it if
you want. I have sent it to maintainer too, maybe a better solution will
arrive in future kernels.

--- linux-2.5.45/drivers/input/mouse/psmouse.c	Thu Oct 31 02:42:20 2002
+++ linux-2.5.45-usb/drivers/input/mouse/psmouse.c	Fri Nov  1 22:28:25 2002
@@ -85,6 +85,11 @@
 
 	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP) {
 
+		/* Logitech radio/battery status or strangeness ?????? */
+		if (packet[0] == 0xd8) {
+			goto out;
+		}
+
 		if ((packet[0] & 0x40) == 0x40 && (int) packet[1] - (int) ((packet[0] & 0x10) << 4) > 191 ) {
 
 			switch (((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0xc0)) {
@@ -157,6 +162,7 @@
 	input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
 	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
 
+out:
 	input_sync(dev);
 }
 
---
Kari Hämeenaho
