Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWHZOxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWHZOxc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWHZOxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 10:53:32 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:22714 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750852AbWHZOxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 10:53:32 -0400
Date: Sat, 26 Aug 2006 23:17:41 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] set EXIT_DEAD state in do_exit(), not in schedule()
Message-ID: <20060826191741.GA157@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schedule() checks PF_DEAD on every context switch and sets ->state = EXIT_DEAD
to ensure that the exiting task will be deactivated. Note that this EXIT_DEAD
is in fact a "random" value, we can use any bit except normal TASK_XXX values.

It is better to set this state in do_exit() along with PF_DEAD flag and remove
that check in schedule().

We are safe wrt concurrent try_to_wake_up() (for example ptrace, tkill), it can
not change task's ->state: the 'state' argument of try_to_wake_up() can't have
EXIT_DEAD bit. And in case when try_to_wake_up() sees a stale value of ->state
== TASK_RUNNING it will do nothing.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/exit.c~1_state	2006-08-19 23:47:01.000000000 +0400
+++ 2.6.18-rc4/kernel/exit.c	2006-08-26 20:38:04.000000000 +0400
@@ -957,6 +957,7 @@ fastcall NORET_TYPE void do_exit(long co
 	preempt_disable();
 	BUG_ON(tsk->flags & PF_DEAD);
 	tsk->flags |= PF_DEAD;
+	tsk->state = EXIT_DEAD;
 
 	schedule();
 	BUG();
--- 2.6.18-rc4/kernel/sched.c~1_state	2006-08-20 00:37:27.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-26 20:39:02.000000000 +0400
@@ -3311,9 +3311,6 @@ need_resched_nonpreemptible:
 
 	spin_lock_irq(&rq->lock);
 
-	if (unlikely(prev->flags & PF_DEAD))
-		prev->state = EXIT_DEAD;
-
 	switch_count = &prev->nivcsw;
 	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
 		switch_count = &prev->nvcsw;

