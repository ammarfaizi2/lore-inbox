Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319427AbSILEGg>; Thu, 12 Sep 2002 00:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319428AbSILEGg>; Thu, 12 Sep 2002 00:06:36 -0400
Received: from server10.safepages.com ([216.127.146.24]:55057 "EHLO
	server10.safepages.com") by vger.kernel.org with ESMTP
	id <S319427AbSILEGf>; Thu, 12 Sep 2002 00:06:35 -0400
To: linux-kernel@vger.kernel.org
Subject: fix to drivers/sound/mad16.c cleanup 2.4.19 [PATCH] 
From: Greg Alexander <galexand@yossman.net>
Date: Thu, 12 Sep 2002 00:14:17 -0400
Message-Id: <E17pLMv-0000MT-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

drivers/sound/mad16.c failed to cleanup the gameport when removing
the module, resulting in the ioport never getting freed up and
   cat /proc/ioports
causes a kernel OOPS from then on.

I am not a veteran kernel hacker but I'm pretty sure the attached
patch is sound...

This patch is against 2.4.19 but my suspicion is that it's relevant
in 2.5 as well (probably no changes).  It's not in 2.2 because the
joystick driver in that setup is completely separate from the mad16
driver.

Please email me if you have any questions/comments.  I do not
generally read lkml.

While we're on this note, anyone care to guess why my SBPCD drive
stopped working when I upgraded from 2.2.19 to 2.4.19?  It looks like
I'm passing the correct params to mad16 to initialize the cd-rom drive..
i don't want to have to go out and buy a new cd-rom so soon! :)

Thanks everybody!  - greg

p.s. isn't it about time for a feature freeze on 2.4.19?  I would
have thought after waiting so long all the details should be settling
down by now.

I hope it's alright to plain-text attach...

--- drivers/sound/mad16.c	2002/09/12 02:15:25
+++ drivers/sound/mad16.c	2002/09/12 02:19:49
@@ -1051,6 +1051,12 @@
 {
 	if (found_mpu)
 		unload_mad16_mpu(&cfg_mpu);
+	if (gameport.io) {
+		/* the gameport was initialized so we must free it up */
+		gameport_unregister_port(&gameport);
+		gameport.io = 0;
+		release_region(0x201, 1);
+	}
 	unload_mad16(&cfg);
 }
 
