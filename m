Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276975AbSIVJMN>; Sun, 22 Sep 2002 05:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276956AbSIVJLM>; Sun, 22 Sep 2002 05:11:12 -0400
Received: from smtpout.mac.com ([204.179.120.87]:22985 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276975AbSIVJJD>;
	Sun, 22 Sep 2002 05:09:03 -0400
Date: Sat, 21 Sep 2002 22:43:31 +0200
Subject: [PATCH] 9/11 sound/oss replace cli()
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CA217890-CDA2-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/ics2101.c	2002-04-20 18:25:20.000000000 
+0200
+++ linux-2.5-cli-oss/sound/oss/ics2101.c	2002-08-16 13:59:55.000000000 
+0200
@@ -15,6 +15,7 @@
   * Bartlomiej Zolnierkiewicz : added __init to ics2101_mixer_init()
   */
  #include <linux/init.h>
+#include <linux/spinlock.h>
  #include "sound_config.h"

  #include <linux/ultrasound.h>
@@ -28,6 +29,7 @@

  extern int     *gus_osp;
  extern int      gus_base;
+extern spinlock_t lock;
  static int      volumes[ICS_MIXDEVS];
  static int      left_fix[ICS_MIXDEVS] =
  {1, 1, 1, 2, 1, 2};
@@ -85,13 +87,12 @@
  		attn_addr |= 0x03;
  	}

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
  	outb((ctrl_addr), u_MixSelect);
  	outb((selector[dev]), u_MixData);
  	outb((attn_addr), u_MixSelect);
  	outb(((unsigned char) vol), u_MixData);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static int set_volumes(int dev, int vol)

