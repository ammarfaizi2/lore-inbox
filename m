Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSIIKFR>; Mon, 9 Sep 2002 06:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSIIKDx>; Mon, 9 Sep 2002 06:03:53 -0400
Received: from smtpout.mac.com ([204.179.120.86]:63449 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316883AbSIIKCO>;
	Mon, 9 Sep 2002 06:02:14 -0400
Message-Id: <200209091006.g89A6vZH010252@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 6/10 sound/oss/dmasound/dmasound_atari.c
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- vanilla-2.5.33/sound/oss/dmasound/dmasound_atari.c	Sat Aug 10 00:03:13 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_atari.c	Mon Sep  9 01:30:08 2002
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/soundcard.h>
 #include <linux/mm.h>
-
+#include <linux/spinlock.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/atariints.h>
@@ -1262,7 +1262,7 @@
 			return;
 		}
 #endif
-
+	spin_lock(&dmasound.lock);
 	if (write_sq_ignore_int && is_falcon) {
 		/* ++TeSche: Falcon only: ignore first irq because it comes
 		 * immediately after starting a frame. after that, irqs come
@@ -1314,6 +1314,7 @@
 	/* We are not playing after AtaPlay(), so there
 	   is nothing to play any more. Wake up a process
 	   waiting for audio output to drain. */
+	spin_unlock(&dmasound.lock);
 }
 
 
@@ -1349,14 +1350,15 @@
 static int AtaMixerIoctl(u_int cmd, u_long arg)
 {
 	int data;
+	unsigned long flags;
 	switch (cmd) {
 	    case SOUND_MIXER_READ_SPEAKER:
 		    if (is_falcon || MACH_IS_TT) {
 			    int porta;
-			    cli();
+			    spin_lock_irqsave(&dmasound.lock, flags);
 			    sound_ym.rd_data_reg_sel = 14;
 			    porta = sound_ym.rd_data_reg_sel;
-			    sti();
+			    spin_unlock_irqrestore(&dmasound.lock, flags);
 			    return IOCTL_OUT(arg, porta & 0x40 ? 0 : 100);
 		    }
 		    break;
@@ -1367,12 +1369,12 @@
 		    if (is_falcon || MACH_IS_TT) {
 			    int porta;
 			    IOCTL_IN(arg, data);
-			    cli();
+			    spin_lock_irqsave(&dmasound.lock, flags);
 			    sound_ym.rd_data_reg_sel = 14;
 			    porta = (sound_ym.rd_data_reg_sel & ~0x40) |
 				    (data < 50 ? 0x40 : 0);
 			    sound_ym.wd_data = porta;
-			    sti();
+			    spin_unlock_irqrestore(&dmasound.lock, flags);
 			    return IOCTL_OUT(arg, porta & 0x40 ? 0 : 100);
 		    }
 	}

