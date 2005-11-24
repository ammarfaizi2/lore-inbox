Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVKXOsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVKXOsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVKXOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:47:44 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:41628 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751215AbVKXOrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:47:41 -0500
Message-ID: <4385E402.3F0FFE07@tv-sign.ru>
Date: Thu, 24 Nov 2005 19:02:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] PF_DEAD: kill it
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous change (->flags & PF_DEAD) <=> (->state == EXIT_DEAD),
so we can forget about PF_DEAD flag.

In my opinion PF_DEAD has nothing to do with process state, it is just
indication that task_struct should be freed after the last schedule.

Perhaps it makes sense to add new TASK_DEAD flag to use it instead of
EXIT_DEAD, while the latter should live only in ->exit_state.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/include/linux/sched.h~5_KILL	2005-11-22 19:35:52.000000000 +0300
+++ 2.6.15-rc2/include/linux/sched.h	2005-11-24 20:06:19.000000000 +0300
@@ -890,7 +890,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 					/* Not implemented yet, only for 486*/
 #define PF_STARTING	0x00000002	/* being created */
 #define PF_EXITING	0x00000004	/* getting shut down */
-#define PF_DEAD		0x00000008	/* Dead */
 #define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
 #define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
 #define PF_DUMPCORE	0x00000200	/* dumped core */
--- 2.6.15-rc2/kernel/exit.c~5_KILL	2005-11-24 19:14:29.000000000 +0300
+++ 2.6.15-rc2/kernel/exit.c	2005-11-24 20:12:34.000000000 +0300
@@ -871,10 +871,8 @@ fastcall NORET_TYPE void do_exit(long co
 	tsk->mempolicy = NULL;
 #endif
 
-	/* PF_DEAD causes final put_task_struct after we schedule. */
+	/* ->state == EXIT_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
-	BUG_ON(tsk->flags & PF_DEAD);
-	tsk->flags |= PF_DEAD;
 	tsk->state = EXIT_DEAD;
 
 	schedule();
--- 2.6.15-rc2/kernel/sched.c~5_KILL	2005-11-24 19:13:34.000000000 +0300
+++ 2.6.15-rc2/kernel/sched.c	2005-11-24 21:12:46.000000000 +0300
@@ -1615,7 +1615,7 @@ static inline void finish_task_switch(ru
 	__releases(rq->lock)
 {
 	struct mm_struct *mm = rq->prev_mm;
-	unsigned long prev_task_flags;
+	int task_dead;
 
 	rq->prev_mm = NULL;
 
@@ -1630,12 +1630,12 @@ static inline void finish_task_switch(ru
 	 * be dropped twice.
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
-	prev_task_flags = prev->flags;
+	task_dead = (prev->state == EXIT_DEAD);
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
 	if (mm)
 		mmdrop(mm);
-	if (unlikely(prev_task_flags & PF_DEAD))
+	if (unlikely(task_dead))
 		put_task_struct(prev);
 }
 
@@ -4711,7 +4711,7 @@ static void migrate_dead(unsigned int de
 	BUG_ON(tsk->exit_state != EXIT_ZOMBIE && tsk->exit_state != EXIT_DEAD);
 
 	/* Cannot have done final schedule yet: would have vanished. */
-	BUG_ON(tsk->flags & PF_DEAD);
+	BUG_ON(tsk->state == EXIT_DEAD);
 
 	get_task_struct(tsk);
 
--- 2.6.15-rc2/mm/oom_kill.c~5_KILL	2005-10-11 16:22:42.000000000 +0400
+++ 2.6.15-rc2/mm/oom_kill.c	2005-11-24 20:16:34.000000000 +0300
@@ -163,7 +163,7 @@ static struct task_struct * select_bad_p
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && !(p->flags & PF_DEAD))
+		if (releasing && (p->state != EXIT_DEAD))
 			return ERR_PTR(-1UL);
 		if (p->flags & PF_SWAPOFF)
 			return p;
