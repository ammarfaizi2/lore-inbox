Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWHZOyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWHZOyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 10:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWHZOyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 10:54:05 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:20451 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751578AbWHZOyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 10:54:02 -0400
Date: Sat, 26 Aug 2006 23:18:17 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] introduce TASK_DEAD state
Message-ID: <20060826191817.GA173@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure about this patch, I am asking Ingo to take a decision.

task_struct->state == EXIT_DEAD is a very special case, to avoid a confusion
it makes sense to introduce a new state, TASK_DEAD, while EXIT_DEAD should
live only in ->exit_state as documented in sched.h.

Note that this state is not visible to user-space, get_task_state() masks
off unsuitable states.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/include/linux/sched.h~3_rename	2006-08-26 21:28:54.000000000 +0400
+++ 2.6.18-rc4/include/linux/sched.h	2006-08-26 23:03:44.000000000 +0400
@@ -148,6 +148,7 @@ extern unsigned long weighted_cpuload(co
 #define EXIT_DEAD		32
 /* in tsk->state again */
 #define TASK_NONINTERACTIVE	64
+#define TASK_DEAD		128
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
--- 2.6.18-rc4/kernel/exit.c~3_rename	2006-08-26 21:46:45.000000000 +0400
+++ 2.6.18-rc4/kernel/exit.c	2006-08-26 22:31:50.000000000 +0400
@@ -955,7 +955,7 @@ fastcall NORET_TYPE void do_exit(long co
 
 	preempt_disable();
 	/* causes final put_task_struct in finish_task_switch(). */
-	tsk->state = EXIT_DEAD;
+	tsk->state = TASK_DEAD;
 
 	schedule();
 	BUG();
--- 2.6.18-rc4/kernel/sched.c~3_rename	2006-08-26 21:56:46.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-26 22:37:48.000000000 +0400
@@ -1751,10 +1751,10 @@ static inline void finish_task_switch(st
 
 	/*
 	 * A task struct has one reference for the use as "current".
-	 * If a task dies, then it sets EXIT_DEAD in tsk->state and calls
+	 * If a task dies, then it sets TASK_DEAD in tsk->state and calls
 	 * schedule one last time. The schedule call will never return, and
 	 * the scheduled task must drop that reference.
-	 * The test for EXIT_DEAD must occur while the runqueue locks are
+	 * The test for TASK_DEAD must occur while the runqueue locks are
 	 * still held, otherwise prev could be scheduled on another cpu, die
 	 * there before we look at prev->state, and then the reference would
 	 * be dropped twice.
@@ -1765,7 +1765,7 @@ static inline void finish_task_switch(st
 	finish_lock_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (unlikely(prev_state == EXIT_DEAD)) {
+	if (unlikely(prev_state == TASK_DEAD)) {
 		/*
 		 * Remove function-return probe instances associated with this
 		 * task and put them back on the free list.
@@ -5116,7 +5116,7 @@ static void migrate_dead(unsigned int de
 	BUG_ON(p->exit_state != EXIT_ZOMBIE && p->exit_state != EXIT_DEAD);
 
 	/* Cannot have done final schedule yet: would have vanished. */
-	BUG_ON(p->state == EXIT_DEAD);
+	BUG_ON(p->state == TASK_DEAD);
 
 	get_task_struct(p);
 
--- 2.6.18-rc4/mm/oom_kill.c~3_rename	2006-08-26 21:34:04.000000000 +0400
+++ 2.6.18-rc4/mm/oom_kill.c	2006-08-26 22:34:35.000000000 +0400
@@ -206,7 +206,7 @@ static struct task_struct *select_bad_pr
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && (p->state != EXIT_DEAD))
+		if (releasing && (p->state != TASK_DEAD))
 			return ERR_PTR(-1UL);
 		if (p->flags & PF_SWAPOFF)
 			return p;

