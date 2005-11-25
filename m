Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbVKYPEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbVKYPEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbVKYPEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:04:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:30874 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932697AbVKYPEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:04:11 -0500
Message-ID: <43873967.5077059B@tv-sign.ru>
Date: Fri, 25 Nov 2005 19:18:47 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] v2 PF_DEAD: kill it
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PF_DEAD has nothing to do with process state, it is just indication that
task_struct should be freed after the last schedule.

After the previous change (->flags & PF_DEAD) <=> (->state == STATE_DEAD),
so we can forget about PF_DEAD flag.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/include/linux/sched.h~2_KILL	2005-11-25 21:02:22.000000000 +0300
+++ 2.6.15-rc2/include/linux/sched.h	2005-11-25 21:15:33.000000000 +0300
@@ -891,7 +891,6 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 					/* Not implemented yet, only for 486*/
 #define PF_STARTING	0x00000002	/* being created */
 #define PF_EXITING	0x00000004	/* getting shut down */
-#define PF_DEAD		0x00000008	/* Dead */
 #define PF_FORKNOEXEC	0x00000040	/* forked but didn't exec */
 #define PF_SUPERPRIV	0x00000100	/* used super-user privileges */
 #define PF_DUMPCORE	0x00000200	/* dumped core */
--- 2.6.15-rc2/kernel/exit.c~2_KILL	2005-11-25 21:04:26.000000000 +0300
+++ 2.6.15-rc2/kernel/exit.c	2005-11-25 21:10:31.000000000 +0300
@@ -871,10 +871,8 @@ fastcall NORET_TYPE void do_exit(long co
 	tsk->mempolicy = NULL;
 #endif
 
-	/* PF_DEAD causes final put_task_struct after we schedule. */
+	/* ->state == TASK_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
-	BUG_ON(tsk->flags & PF_DEAD);
-	tsk->flags |= PF_DEAD;
 	tsk->state = TASK_DEAD;
 
 	schedule();
--- 2.6.15-rc2/kernel/sched.c~2_KILL	2005-11-25 21:04:48.000000000 +0300
+++ 2.6.15-rc2/kernel/sched.c	2005-11-25 21:16:32.000000000 +0300
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
+	task_dead = (prev->state == TASK_DEAD);
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
+	BUG_ON(tsk->state == TASK_DEAD);
 
 	get_task_struct(tsk);
 
--- 2.6.15-rc2/mm/oom_kill.c~2_KILL	2005-11-25 20:58:09.000000000 +0300
+++ 2.6.15-rc2/mm/oom_kill.c	2005-11-25 21:14:01.000000000 +0300
@@ -163,7 +163,7 @@ static struct task_struct * select_bad_p
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && !(p->flags & PF_DEAD))
+		if (releasing && (p->state != TASK_DEAD))
 			return ERR_PTR(-1UL);
 		if (p->flags & PF_SWAPOFF)
 			return p;
