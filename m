Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271291AbTGPX36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271326AbTGPX35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:29:57 -0400
Received: from sponsa.its.UU.SE ([130.238.7.36]:18379 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S271307AbTGPX3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:29:22 -0400
Date: Thu, 17 Jul 2003 01:43:05 +0200 (MEST)
Message-Id: <200307162343.h6GNh5iu016584@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: vojtech@suse.cz
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 20:56:19 +0200, Vojtech Pavlik wrote:
>This is basically because the check for lost bytes wasn't present in
>2.4. Now that it is there, it works well with real lost bytes, but will
>fire also in case when the mouse interrupt was delayed for more than
>half a second, or if indeed a mouse interrupt gets lost. The 2.5 kernel
>by default programs the mouse to high speed reporting (up to 200 updates
>per second). This may, possibly make the problem show up easier.

This was interesting: 2.5 programs the mouse differently than 2.4.
I've been having ps2 mouse problems with the 2.5 input layer,
including having to move the mouse much further for a given
cursor movement, and a general jerky/unstable feeling of the mouse.

2.4's pc_keyb.c has (disabled by default) init code which puts the
mouse in 100 samples/s and 2:1 scaling, whereas 2.5 puts it into
200 samples/s and 1:1 scaling. So I hacked psmouse-base.c to mimic
2.4, and VOILA! now my mouse feels A LOT better.

The crude patch below shows what I did. (I have to set psmouse_noext
as well, to avoid misidentification, jerkiness/lost syncs, and
utter mayhem upon resume from suspend.)

Would you accept a cleaned up patch which allows the rate and
scaling to be adjusted, similarly to noext and resolution?

/Mikael

--- linux-2.6.0-test1/drivers/input/mouse/psmouse-base.c.~1~	2003-06-23 13:07:37.000000000 +0200
+++ linux-2.6.0-test1/drivers/input/mouse/psmouse-base.c	2003-07-17 01:23:57.000000000 +0200
@@ -33,7 +33,7 @@
 
 #define PSMOUSE_LOGITECH_SMARTSCROLL	1
 
-static int psmouse_noext;
+static int psmouse_noext = 1;
 int psmouse_resolution;
 int psmouse_smartscroll = PSMOUSE_LOGITECH_SMARTSCROLL;
 
@@ -435,7 +435,7 @@
 	param[0] = 100;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 
-	param[0] = 200;
+	param[0] = 100;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 
 /*
@@ -443,7 +443,8 @@
  */
 
 	psmouse_set_resolution(psmouse);
-	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
+#define PSMOUSE_CMD_SETSCALE21 0x00e7
+	psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE21);
 
 /*
  * We set the mouse into streaming mode.
