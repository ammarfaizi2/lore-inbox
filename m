Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVKXOrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVKXOrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKXOrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:47:41 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:40092 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751221AbVKXOrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:47:40 -0500
Message-ID: <4385E3FF.C99DBCF5@tv-sign.ru>
Date: Thu, 24 Nov 2005 19:02:07 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] PF_DEAD: cleanup usage
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schedule() checks PF_DEAD on every context switch, and sets ->state = EXIT_DEAD
to ensure that exited task will be deactivated.

I think it is better to set EXIT_DEAD in do_exit(), along with PF_DEAD flag.

It is safe to do without task_rq() locking, because concurrent try_to_wake_up()
can't change task's ->state: the 'state' argument of try_to_wake_up() can't have
EXIT_DEAD bit. And in case when try_to_wake_up() sees stale value of ->state ==
TASK_RUNNING it will do nothing.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/kernel/exit.c~4_DEAD	2005-11-23 19:33:27.000000000 +0300
+++ 2.6.15-rc2/kernel/exit.c	2005-11-24 19:14:29.000000000 +0300
@@ -875,6 +875,7 @@ fastcall NORET_TYPE void do_exit(long co
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);
 	tsk->flags |= PF_DEAD;
+	tsk->state = EXIT_DEAD;
 
 	schedule();
 	BUG();
--- 2.6.15-rc2/kernel/sched.c~4_DEAD	2005-11-22 19:35:52.000000000 +0300
+++ 2.6.15-rc2/kernel/sched.c	2005-11-24 19:13:34.000000000 +0300
@@ -3000,9 +3000,6 @@ need_resched_nonpreemptible:
 
 	spin_lock_irq(&rq->lock);
 
-	if (unlikely(prev->flags & PF_DEAD))
-		prev->state = EXIT_DEAD;
-
 	switch_count = &prev->nivcsw;
 	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
 		switch_count = &prev->nvcsw;
