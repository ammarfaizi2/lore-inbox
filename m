Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262912AbVEHRro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbVEHRro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 13:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVEHRro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 13:47:44 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:54414 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262912AbVEHRrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 13:47:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Date: Sun, 8 May 2005 12:47:34 -0500
User-Agent: KMail/1.8
Cc: Mitch <Mitch@0Bits.COM>
References: <427E1F05.9020503@0Bits.COM>
In-Reply-To: <427E1F05.9020503@0Bits.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505081247.34791.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
