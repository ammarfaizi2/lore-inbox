Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319397AbSH2Vxu>; Thu, 29 Aug 2002 17:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSH2VxT>; Thu, 29 Aug 2002 17:53:19 -0400
Received: from smtpout.mac.com ([204.179.120.97]:35544 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319355AbSH2VwP>;
	Thu, 29 Aug 2002 17:52:15 -0400
Message-Id: <200208292156.g7TLucKN026393@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 21/41 sound/oss/sound_timer.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/sound_timer.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/sound_timer.c	Thu Aug 15 14:20:44 2002
@@ -12,7 +12,7 @@
  * Thomas Sailer   : ioctl code reworked (vmalloc/vfree removed)
  */
 #include <linux/string.h>
-
+#include <linux/spinlock.h>
 
 #include "sound_config.h"
 
@@ -26,6 +26,7 @@
 static volatile unsigned long usecs_per_tmr;	/* Length of the current interval */
 
 static struct sound_lowlev_timer *tmr;
+static spinlock_t lock;
 
 static unsigned long tmr2ticks(int tmr_value)
 {
@@ -80,15 +81,14 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 	tmr_offs = 0;
 	ticks_offs = 0;
 	tmr_ctr = 0;
 	next_event_time = (unsigned long) -1;
 	prev_event_time = 0;
 	curr_ticks = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int timer_open(int dev, int mode)
@@ -278,6 +278,8 @@
 
 void sound_timer_interrupt(void)
 {
+	unsigned long flags;
+	
 	if (!opened)
 		return;
 
@@ -286,6 +288,7 @@
 	if (!tmr_running)
 		return;
 
+	spin_lock_irqsave(&lock,flags);
 	tmr_ctr++;
 	curr_ticks = ticks_offs + tmr2ticks(tmr_ctr);
 
@@ -294,6 +297,7 @@
 		next_event_time = (unsigned long) -1;
 		sequencer_timer(0);
 	}
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 void  sound_timer_init(struct sound_lowlev_timer *t, char *name)

