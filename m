Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbUKIK6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUKIK6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUKIK4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:56:22 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:9660 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261489AbUKIKo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:44:28 -0500
Message-ID: <4190ADD7.CE7EFB7C@tv-sign.ru>
Date: Tue, 09 Nov 2004 14:45:27 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] little schedule() cleanup: use cached current value
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

schedule() can use prev/next instead of get_current().

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc1/kernel/sched.c~	2004-11-08 19:43:29.000000000 +0300
+++ 2.6.10-rc1/kernel/sched.c	2004-11-08 22:52:26.547195920 +0300
@@ -2508,7 +2508,7 @@ need_resched:
 	 * The idle thread is not allowed to schedule!
 	 * Remove this check after it has been exercised a bit.
 	 */
-	if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
+	if (unlikely(prev == rq->idle) && prev->state != TASK_RUNNING) {
 		printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 		dump_stack();
 	}
@@ -2531,8 +2531,8 @@ need_resched:
 
 	spin_lock_irq(&rq->lock);
 
-	if (unlikely(current->flags & PF_DEAD))
-		current->state = EXIT_DEAD;
+	if (unlikely(prev->flags & PF_DEAD))
+		prev->state = EXIT_DEAD;
 	/*
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
@@ -2636,7 +2636,7 @@ switch_tasks:
 	} else
 		spin_unlock_irq(&rq->lock);
 
-	reacquire_kernel_lock(current);
+	reacquire_kernel_lock(next);
 	preempt_enable_no_resched();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
