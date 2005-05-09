Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVEIFtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVEIFtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 01:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVEIFtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 01:49:24 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:2465 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S263049AbVEIFtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 01:49:14 -0400
Date: Mon, 09 May 2005 09:49:09 +0400
From: Mitch <Mitch@0Bits.COM>
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Message-id: <427EF9D5.2010606@0Bits.COM>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Mail/News Client 1.0+ (X11/20050427)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied your v4 patch, and that fixes it somewhat insomuch as it it 
working, but it keeps resetting itself if i stop using it for a few 
milliseconds, so the mouse appears sluggish as it performs a reset 
whenever i use it. Here are the messages i see (100's of them).

ALPS Touchpad (Dualpoint) detected
   Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
psmouse.c: resync failed, issuing reconnect request
psmouse.c: resync failed, issuing reconnect request
ALPS Touchpad (Dualpoint) detected
   Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
psmouse.c: resync failed, issuing reconnect request
ALPS Touchpad (Dualpoint) detected
   Disabling hardware tapping
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1


Cheers
Mitch
-------- Original Message --------
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Date: Sun, 8 May 2005 12:47:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
CC: Mitch <Mitch@0Bits.COM>
References: <427E1F05.9020503@0Bits.COM>

On Sunday 08 May 2005 09:15, Mitch wrote:
> Hi Dmitry,
> 
> Your patch (applied to 2.6.11.8) hangs my touchpad mouse totally.
> The error i get on bootup
> 
> May  8 17:16:58 localhost kernel: ALPS Touchpad (Glidepoint) detected
> May  8 17:16:58 localhost kernel: alps.c: Failed to enable absolute mode
> May  8 17:16:58 localhost kernel: input: PS/2 ALPS TouchPad on 
> isa0060/serio1
> 
> without your patch
> 
> May  8 18:11:56 localhost kernel: ALPS Touchpad (Dualpoint) detected
> May  8 18:11:56 localhost kernel:   Disabling hardware tapping
> May  8 18:11:56 localhost kernel: input: AlpsPS/2 ALPS TouchPad on 
> isa0060/serio1
> 
> and the mouse works fine (except when it goes crazy and jumps all over 
> the place). I've been suffering with the problem for a long while on 
> this hardware..
> 

Ahem, yep, I broke ALPS... Please try applying the patchlet below on top
of what I have posted or grab an updated version of the patch:

http://www.geocities.com/dt_or/input/2_6_11/psmouse-resync-2.6.11-v4.patch.gz

Thanks!

-- 
Dmitry

--- drivers/input/mouse/alps.c.orig	2005-05-08 12:20:13.000000000 -0500
+++ drivers/input/mouse/alps.c	2005-05-08 12:22:37.000000000 -0500
@@ -242,7 +242,6 @@
  static int alps_passthrough_mode(struct psmouse *psmouse, int enable)
  {
  	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[3];
  	int cmd = enable ? PSMOUSE_CMD_SETSCALE21 : PSMOUSE_CMD_SETSCALE11;

  	if (ps2_command(ps2dev, NULL, cmd) ||
@@ -252,7 +251,7 @@
  		return -1;

  	/* we may get 3 more bytes, just ignore them */
-	ps2_command(ps2dev, param, 0x0300);
+	ps2_drain(ps2dev, 3, 100);

  	return 0;
  }
@@ -273,7 +272,7 @@
  	 * Switch mouse to poll (remote) mode so motion data will not
  	 * get in our way
  	 */
-	return ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETPOLL | 0x0300);
+	return ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETPOLL);
  }

  static int alps_get_status(struct psmouse *psmouse, char *param)
