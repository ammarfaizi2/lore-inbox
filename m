Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319199AbSIKQMn>; Wed, 11 Sep 2002 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQLF>; Wed, 11 Sep 2002 12:11:05 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:16566 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S319203AbSIKQG7> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:06:59 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (9/10): ctc driver.
Date: Wed, 11 Sep 2002 18:09:21 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111806.23188.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
replace old style bottom half by a tasklet in the ctc driver.

blue skies,
  Martin.

diff -urN linux-2.5.34/drivers/s390/net/ctcmain.c linux-2.5.34-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.34/drivers/s390/net/ctcmain.c	Mon Sep  9 19:35:08 2002
+++ linux-2.5.34-s390/drivers/s390/net/ctcmain.c	Tue Jun 25 11:36:46 2002
@@ -49,6 +49,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
+#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
diff -urN linux-2.5.34/drivers/s390/net/ctctty.c linux-2.5.34-s390/drivers/s390/net/ctctty.c
--- linux-2.5.34/drivers/s390/net/ctctty.c	Mon Sep  9 19:35:12 2002
+++ linux-2.5.34-s390/drivers/s390/net/ctctty.c	Tue Jul  2 10:14:04 2002
@@ -86,7 +86,7 @@
   wait_queue_head_t	open_wait;
   wait_queue_head_t	close_wait;
   struct semaphore      write_sem;
-  struct tq_struct      tq;
+  struct tasklet_struct tasklet;
   struct timer_list     stoptimer;
 } ctc_tty_info;
 
@@ -272,8 +272,7 @@
 	 */
 	skb_queue_tail(&info->rx_queue, skb);
 	/* Schedule dequeuing */
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static int
@@ -390,8 +389,7 @@
 	skb_reserve(skb, skb_res);
 	*(skb_put(skb, 1)) = c;
 	skb_queue_head(&info->tx_queue, skb);
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -400,8 +398,7 @@
 	if (ctc_tty_shuttingdown)
 		return;
 	info->flags |= CTC_ASYNC_TX_LINESTAT;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -562,8 +559,7 @@
 	}
 	if (skb_queue_len(&info->tx_queue)) {
 		info->lsr &= ~UART_LSR_TEMT;
-		queue_task(&info->tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		tasklet_schedule(&info->tasklet);
 	}
 	if (from_user)
 		up(&info->write_sem);
@@ -628,8 +624,7 @@
 		return;
 	if (tty->stopped || tty->hw_stopped || (!skb_queue_len(&info->tx_queue)))
 		return;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 /*
@@ -1170,8 +1165,9 @@
  * the lower levels.
  */
 static void
-ctc_tty_task(ctc_tty_info *info)
+ctc_tty_task(unsigned long arg)
 {
+	ctc_tty_info *info = (void *)arg;
 	unsigned long saveflags;
 	int again;
 
@@ -1182,8 +1178,7 @@
 			info->lsr |= UART_LSR_TEMT;
 		again |= ctc_tty_readmodem(info);
 		if (again) {
-			queue_task(&info->tq, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			tasklet_schedule(&info->tasklet);
 		}
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
@@ -1243,14 +1238,8 @@
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++) {
 		info = &driver->info[i];
 		init_MUTEX(&info->write_sem);
-#if LINUX_VERSION_CODE >= 0x020400
-		INIT_LIST_HEAD(&info->tq.list);
-#else
-		info->tq.next    = NULL;
-#endif
-		info->tq.sync    = 0;
-		info->tq.routine = (void *)(void *)ctc_tty_task;
-		info->tq.data    = info;
+		tasklet_init(&info->tasklet, ctc_tty_task,
+				(unsigned long) info);
 		info->magic = CTC_ASYNC_MAGIC;
 		info->line = i;
 		info->tty = 0;
@@ -1331,10 +1320,6 @@
 		kfree(driver);
 		driver = NULL;
 	} else {
-		int i;
-
-		for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
-			driver->info[i].tq.routine = NULL;
 		tty_unregister_driver(&driver->ctc_tty_device);
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);

