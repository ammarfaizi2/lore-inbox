Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276878AbSIVJHn>; Sun, 22 Sep 2002 05:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276879AbSIVJHj>; Sun, 22 Sep 2002 05:07:39 -0400
Received: from smtpout.mac.com ([204.179.120.87]:8905 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276878AbSIVJHC>;
	Sun, 22 Sep 2002 05:07:02 -0400
Date: Sat, 21 Sep 2002 22:32:56 +0200
Subject: [PATCH] 3/11 sound/oss replace cli() 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4FC4921D-CDA1-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/dmasound/dmasound_atari.c	2002-08-10 
00:03:13.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_atari.c	2002-09-09 01:30:
08.000000000 +0200
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

