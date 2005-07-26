Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVGZHqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVGZHqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGZHqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:46:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61879 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261669AbVGZHqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:46:46 -0400
Date: Tue, 26 Jul 2005 09:46:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050726074627.GA11975@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are small ucb1x00-ts cleanups, as suggested by Vojtech, Dmitri
and the lists.

Signed-off-by: Pavel Machek <pavel@suse.cz>

Cleanups suggested by Dmitri, Vojtech and lists.

---
commit 79c98a2279c45098d102ba69ecf940c00da3dfee
tree f15a3d27de9a84694f4588374a5e383938866a54
parent 080578bff89927c0f5aeddd588bc2f5f7373f232
author <pavel@amd.(none)> Tue, 26 Jul 2005 09:44:33 +0200
committer <pavel@amd.(none)> Tue, 26 Jul 2005 09:44:33 +0200

 drivers/misc/ucb1x00-ts.c |   87 ++++++++++++---------------------------------
 1 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/drivers/misc/ucb1x00-ts.c b/drivers/misc/ucb1x00-ts.c
--- a/drivers/misc/ucb1x00-ts.c
+++ b/drivers/misc/ucb1x00-ts.c
@@ -1,7 +1,8 @@
 /*
- *  linux/drivers/misc/ucb1x00-ts.c
+ *  Touchscreen driver for UCB1x00-based touchscreens
  *
  *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *  Copyright (C) 2005 Pavel Machek
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -30,6 +31,7 @@
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 
 #include <asm/dma.h>
 #include <asm/semaphore.h>
@@ -42,10 +44,7 @@ struct ucb1x00_ts {
 	struct ucb1x00		*ucb;
 
 	wait_queue_head_t	irq_wait;
-	struct semaphore	sem;
-	struct completion	init_exit;
 	struct task_struct	*rtask;
-	int			use_count;
 	u16			x_res;
 	u16			y_res;
 
@@ -55,20 +54,6 @@ struct ucb1x00_ts {
 
 static int adcsync;
 
-static inline void ucb1x00_ts_evt_add(struct ucb1x00_ts *ts, u16 pressure, u16 x, u16 y)
-{
-	input_report_abs(&ts->idev, ABS_X, x);
-	input_report_abs(&ts->idev, ABS_Y, y);
-	input_report_abs(&ts->idev, ABS_PRESSURE, pressure);
-	input_sync(&ts->idev);
-}
-
-static inline void ucb1x00_ts_event_release(struct ucb1x00_ts *ts)
-{
-	input_report_abs(&ts->idev, ABS_PRESSURE, 0);
-	input_sync(&ts->idev);
-}
-
 /*
  * Switch to interrupt mode.
  */
@@ -176,12 +161,6 @@ static int ucb1x00_thread(void *_ts)
 	DECLARE_WAITQUEUE(wait, tsk);
 	int valid;
 
-	ts->rtask = tsk;
-
-	daemonize("ktsd");
-	/* only want to receive SIGKILL */
-	allow_signal(SIGKILL);
-
 	/*
 	 * We could run as a real-time thread.  However, thus far
 	 * this doesn't seem to be necessary.
@@ -189,12 +168,10 @@ static int ucb1x00_thread(void *_ts)
 //	tsk->policy = SCHED_FIFO;
 //	tsk->rt_priority = 1;
 
-	complete(&ts->init_exit);
-
 	valid = 0;
 
 	add_wait_queue(&ts->irq_wait, &wait);
-	for (;;) {
+	while (!kthread_should_stop()) {
 		unsigned int x, y, p, val;
 		signed long timeout;
 
@@ -212,10 +189,7 @@ static int ucb1x00_thread(void *_ts)
 		ucb1x00_ts_mode_int(ts);
 		ucb1x00_adc_disable(ts->ucb);
 
-		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ / 100);
-		if (signal_pending(tsk))
-			break;
+		msleep(10);
 
 		ucb1x00_enable(ts->ucb);
 		val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
@@ -231,7 +205,8 @@ static int ucb1x00_thread(void *_ts)
 			 * spit out a "pen off" sample here.
 			 */
 			if (valid) {
-				ucb1x00_ts_event_release(ts);
+				input_report_abs(&ts->idev, ABS_PRESSURE, 0);
+				input_sync(&ts->idev);
 				valid = 0;
 			}
 
@@ -245,7 +220,10 @@ static int ucb1x00_thread(void *_ts)
 			 * to do any filtering they please.
 			 */
 			if (!ts->restart) {
-				ucb1x00_ts_evt_add(ts, p, x, y);
+				input_report_abs(&ts->idev, ABS_X, x);
+				input_report_abs(&ts->idev, ABS_Y, y);
+				input_report_abs(&ts->idev, ABS_PRESSURE, p);
+				input_sync(&ts->idev);
 				valid = 1;
 			}
 
@@ -256,14 +234,12 @@ static int ucb1x00_thread(void *_ts)
 		try_to_freeze();
 
 		schedule_timeout(timeout);
-		if (signal_pending(tsk))
-			break;
 	}
 
 	remove_wait_queue(&ts->irq_wait, &wait);
 
 	ts->rtask = NULL;
-	complete_and_exit(&ts->init_exit, 0);
+	return 0;
 }
 
 /*
@@ -282,14 +258,7 @@ static int ucb1x00_ts_open(struct input_
 	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
 	int ret = 0;
 
-	if (down_interruptible(&ts->sem))
-		return -EINTR;
-
-	if (ts->use_count++ != 0)
-		goto out;
-
-	if (ts->rtask)
-		panic("ucb1x00: rtask running?");
+	BUG_ON(ts->rtask);
 
 	init_waitqueue_head(&ts->irq_wait);
 	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
@@ -305,19 +274,16 @@ static int ucb1x00_ts_open(struct input_
 	ts->y_res = ucb1x00_ts_read_yres(ts);
 	ucb1x00_adc_disable(ts->ucb);
 
-	init_completion(&ts->init_exit);
-	ret = kernel_thread(ucb1x00_thread, ts, CLONE_KERNEL);
-	if (ret >= 0) {
-		wait_for_completion(&ts->init_exit);
+	ts->rtask = kthread_run(ucb1x00_thread, ts, "ktsd");
+	if (!IS_ERR(ts->rtask)) {
 		ret = 0;
 	} else {
 		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+		ts->rtask = NULL;
+		ret = -EFAULT;
 	}
 
  out:
-	if (ret)
-		ts->use_count--;
-	up(&ts->sem);
 	return ret;
 }
 
@@ -328,19 +294,13 @@ static void ucb1x00_ts_close(struct inpu
 {
 	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
 
-	down(&ts->sem);
-	if (--ts->use_count == 0) {
-		if (ts->rtask) {
-			send_sig(SIGKILL, ts->rtask, 1);
-			wait_for_completion(&ts->init_exit);
-		}
+	if (ts->rtask)
+		kthread_stop(ts->rtask);
 
-		ucb1x00_enable(ts->ucb);
-		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
-		ucb1x00_reg_write(ts->ucb, UCB_TS_CR, 0);
-		ucb1x00_disable(ts->ucb);
-	}
-	up(&ts->sem);
+	ucb1x00_enable(ts->ucb);
+	ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, 0);
+	ucb1x00_disable(ts->ucb);
 }
 
 #ifdef CONFIG_PM
@@ -379,7 +339,6 @@ static int ucb1x00_ts_add(struct ucb1x00
 
 	ts->ucb = dev->ucb;
 	ts->adcsync = adcsync ? UCB_SYNC : UCB_NOSYNC;
-	init_MUTEX(&ts->sem);
 
 	ts->idev.name       = "Touchscreen panel";
 	ts->idev.id.product = ts->ucb->id;

-- 
teflon -- maybe it is a trademark, but it should not be.
