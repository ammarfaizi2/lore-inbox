Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbVKYPDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbVKYPDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVKYPDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:03:38 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26010 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932692AbVKYPDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:03:37 -0500
Message-ID: <43873940.71D85208@tv-sign.ru>
Date: Fri, 25 Nov 2005 19:18:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] v2 PF_DEAD: cleanup usage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schedule() checks PF_DEAD on every context switch, and sets ->state = EXIT_DEAD
to ensure that exited task will be deactivated.

It is possible to set new ->state value in do_exit(), along with PF_DEAD flag,
and remove the check from schedule()'s hot path.

To avoid mixing ->state/->exit_state values, this patch adds new TASK_DEAD state.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/include/linux/sched.h~1_CLEAN	2005-11-25 20:58:09.000000000 +0300
+++ 2.6.15-rc2/include/linux/sched.h	2005-11-25 21:02:22.000000000 +0300
@@ -127,6 +127,7 @@ extern unsigned long nr_iowait(void);
 #define EXIT_DEAD		32
 /* in tsk->state again */
 #define TASK_NONINTERACTIVE	64
+#define TASK_DEAD		128
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
--- 2.6.15-rc2/kernel/exit.c~1_CLEAN	2005-11-25 20:58:14.000000000 +0300
+++ 2.6.15-rc2/kernel/exit.c	2005-11-25 21:04:26.000000000 +0300
@@ -875,6 +875,7 @@ fastcall NORET_TYPE void do_exit(long co
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);
 	tsk->flags |= PF_DEAD;
+	tsk->state = TASK_DEAD;
 
 	schedule();
 	BUG();
--- 2.6.15-rc2/kernel/sched.c~1_CLEAN	2005-11-25 20:58:14.000000000 +0300
+++ 2.6.15-rc2/kernel/sched.c	2005-11-25 21:04:48.000000000 +0300
@@ -3000,9 +3000,6 @@ need_resched_nonpreemptible:
 
 	spin_lock_irq(&rq->lock);
 
-	if (unlikely(prev->flags & PF_DEAD))
-		prev->state = EXIT_DEAD;
-
 	switch_count = &prev->nivcsw;
 	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
 		switch_count = &prev->nvcsw;
