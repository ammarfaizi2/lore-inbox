Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313586AbSDHIJK>; Mon, 8 Apr 2002 04:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313585AbSDHIJJ>; Mon, 8 Apr 2002 04:09:09 -0400
Received: from stingr.net ([212.193.32.15]:41608 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313586AbSDHIJF>;
	Mon, 8 Apr 2002 04:09:05 -0400
Date: Mon, 8 Apr 2002 12:09:00 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 11
Message-ID: <20020408080900.GR839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2Marcelo: the whole cleanup tree derived from yours available at
linux-stingr.bkbits.net/taskstate

2others: people says that it is nice patch, howewer it is completely
untested. But I dunno what can be broken such way so ...

This is task->state cleanup. Big part seems to be eaten my Matti Aarnio so
splitted goes below.

If you want to blame me for incorrect using of set instead of __set - feel
free to mail me and point where I should to change. Or mail me a patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.320   -> 1.321  
#	drivers/usb/usb-uhci.h	1.4     -> 1.5    
#	drivers/video/sa1100fb.c	1.8     -> 1.9    
#	     drivers/tc/zs.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.321
# task->state cleanup part 11
# finished drivers cleanup
# --------------------------------------------
#
diff -Nru a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c	Mon Apr  8 01:24:00 2002
+++ b/drivers/tc/zs.c	Mon Apr  8 01:24:00 2002
@@ -1434,7 +1434,7 @@
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1469,14 +1469,14 @@
 	if (timeout)
 		char_time = MIN(char_time, timeout);
 	while ((read_zsreg(info->zs_channel, 1) & Tx_BUF_EMP) == 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 }
 
 /*
@@ -1614,7 +1614,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/usb/usb-uhci.h b/drivers/usb/usb-uhci.h
--- a/drivers/usb/usb-uhci.h	Mon Apr  8 01:24:00 2002
+++ b/drivers/usb/usb-uhci.h	Mon Apr  8 01:24:00 2002
@@ -11,7 +11,7 @@
 {
 	if(!in_interrupt())
 	{
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1 + ms * HZ / 1000);
 	}
 	else
diff -Nru a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c	Mon Apr  8 01:24:00 2002
+++ b/drivers/video/sa1100fb.c	Mon Apr  8 01:24:00 2002
@@ -1967,7 +1967,7 @@
 	LCCR0 &= ~LCCR0_LEN;	/* Disable LCD Controller */
 
 	schedule_timeout(20 * HZ / 1000);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&fbi->ctrlr_wait, &wait);
 }
 

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
