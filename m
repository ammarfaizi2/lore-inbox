Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319447AbSH2WUL>; Thu, 29 Aug 2002 18:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319394AbSH2Vwy>; Thu, 29 Aug 2002 17:52:54 -0400
Received: from smtpout.mac.com ([204.179.120.88]:17401 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319391AbSH2Vwj>;
	Thu, 29 Aug 2002 17:52:39 -0400
Message-Id: <200208292157.g7TLv1KN026489@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 24/41 sound/oss/sys_timer.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/sys_timer.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/sys_timer.c	Thu Aug 15 14:30:00 2002
@@ -15,6 +15,7 @@
  * Thomas Sailer   : ioctl code reworked (vmalloc/vfree removed)
  * Andrew Veliath  : adapted tmr2ticks from level 1 sequencer (avoid overflow)
  */
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 static volatile int opened = 0, tmr_running = 0;
@@ -26,7 +27,7 @@
 static unsigned long prev_event_time;
 
 static void     poll_def_tmr(unsigned long dummy);
-
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 static struct timer_list def_tmr =
 {function: poll_def_tmr};
@@ -62,6 +63,7 @@
 
 		  if (tmr_running)
 		    {
+				spin_lock(&lock);
 			    tmr_ctr++;
 			    curr_ticks = ticks_offs + tmr2ticks(tmr_ctr);
 
@@ -70,6 +72,7 @@
 				      next_event_time = (unsigned long) -1;
 				      sequencer_timer(0);
 			      }
+				spin_unlock(&lock);
 		    }
 	  }
 }
@@ -79,15 +82,14 @@
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
 
 static int

