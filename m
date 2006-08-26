Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbWHZOxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWHZOxr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHZOxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 10:53:47 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:24762 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751555AbWHZOxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 10:53:46 -0400
Date: Sat, 26 Aug 2006 23:17:56 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kill PF_DEAD flag
Message-ID: <20060826191756.GA164@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous change (->flags & PF_DEAD) <=> (->state == EXIT_DEAD),
we don't need PF_DEAD any longer.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/include/linux/sched.h~2_kill	2006-08-19 21:41:36.000000000 +0400
+++ 2.6.18-rc4/include/linux/sched.h	2006-08-26 21:28:54.000000000 +0400
@@ -1035,7 +1035,6 @@ static inline void put_task_struct(struc
 					/* Not implemented yet, only for 486*/
 #define PF_STARTING	0x00000002	/* being created */
 #define PF_EXITING	0x00000004	/* getting shut down */
-#define PF_DEAD		0x00000008	/* Dead */
 #define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
 #define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
 #define PF_DUMPCORE	0x00000200	/* dumped core */
--- 2.6.18-rc4/kernel/exit.c~2_kill	2006-08-26 20:38:04.000000000 +0400
+++ 2.6.18-rc4/kernel/exit.c	2006-08-26 21:46:45.000000000 +0400
@@ -953,10 +953,8 @@ fastcall NORET_TYPE void do_exit(long co
 	if (tsk->splice_pipe)
 		__free_pipe_info(tsk->splice_pipe);
 
-	/* PF_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
-	BUG_ON(tsk->flags & PF_DEAD);
-	tsk->flags |= PF_DEAD;
+	/* causes final put_task_struct in finish_task_switch(). */
 	tsk->state = EXIT_DEAD;
 
 	schedule();
@@ -971,7 +969,7 @@ NORET_TYPE void complete_and_exit(struct
 {
 	if (comp)
 		complete(comp);
-	
+
 	do_exit(code);
 }
 
--- 2.6.18-rc4/kernel/sched.c~2_kill	2006-08-26 20:39:02.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-26 21:56:46.000000000 +0400
@@ -1745,27 +1745,27 @@ static inline void finish_task_switch(st
 	__releases(rq->lock)
 {
 	struct mm_struct *mm = rq->prev_mm;
-	unsigned long prev_task_flags;
+	long prev_state;
 
 	rq->prev_mm = NULL;
 
 	/*
 	 * A task struct has one reference for the use as "current".
-	 * If a task dies, then it sets EXIT_ZOMBIE in tsk->exit_state and
-	 * calls schedule one last time. The schedule call will never return,
-	 * and the scheduled task must drop that reference.
-	 * The test for EXIT_ZOMBIE must occur while the runqueue locks are
+	 * If a task dies, then it sets EXIT_DEAD in tsk->state and calls
+	 * schedule one last time. The schedule call will never return, and
+	 * the scheduled task must drop that reference.
+	 * The test for EXIT_DEAD must occur while the runqueue locks are
 	 * still held, otherwise prev could be scheduled on another cpu, die
 	 * there before we look at prev->state, and then the reference would
 	 * be dropped twice.
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
-	prev_task_flags = prev->flags;
+	prev_state = prev->state;
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (unlikely(prev_task_flags & PF_DEAD)) {
+	if (unlikely(prev_state == EXIT_DEAD)) {
 		/*
 		 * Remove function-return probe instances associated with this
 		 * task and put them back on the free list.
@@ -5116,7 +5116,7 @@ static void migrate_dead(unsigned int de
 	BUG_ON(p->exit_state != EXIT_ZOMBIE && p->exit_state != EXIT_DEAD);
 
 	/* Cannot have done final schedule yet: would have vanished. */
-	BUG_ON(p->flags & PF_DEAD);
+	BUG_ON(p->state == EXIT_DEAD);
 
 	get_task_struct(p);
 
--- 2.6.18-rc4/mm/oom_kill.c~2_kill	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc4/mm/oom_kill.c	2006-08-26 21:34:04.000000000 +0400
@@ -206,7 +206,7 @@ static struct task_struct *select_bad_pr
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && !(p->flags & PF_DEAD))
+		if (releasing && (p->state != EXIT_DEAD))
 			return ERR_PTR(-1UL);
 		if (p->flags & PF_SWAPOFF)
 			return p;

