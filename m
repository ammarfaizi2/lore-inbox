Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVKYPDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVKYPDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVKYPDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:03:08 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:21146 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932689AbVKYPDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:03:06 -0500
Message-ID: <4387391D.9DDAA718@tv-sign.ru>
Date: Fri, 25 Nov 2005 19:17:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] PF_DEAD: kill it
References: <4385E402.3F0FFE07@tv-sign.ru> <20051125052337.GC22230@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> > Perhaps it makes sense to add new TASK_DEAD flag to use it instead of
> > EXIT_DEAD, while the latter should live only in ->exit_state.
>
> yes, i'd suggest a followup patch to keep the two flag spaces totally
> disjunct - at least for testing in -mm. This area of code (when it was

Here it is.

I am also resending these 2 cleanups with EXIT_STATE changed to TASK_STATE.

Andrew, please take these new ones unless you or Ingo have any objections.

Oleg.


--- 2.6.15-rc2/include/linux/sched.h~3_RENAME	2005-11-25 21:54:07.000000000 +0300
+++ 2.6.15-rc2/include/linux/sched.h	2005-11-25 21:56:36.000000000 +0300
@@ -127,6 +127,7 @@ extern unsigned long nr_iowait(void);
 #define EXIT_DEAD		32
 /* in tsk->state again */
 #define TASK_NONINTERACTIVE	64
+#define TASK_DEAD		128
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
--- 2.6.15-rc2/kernel/exit.c~3_RENAME	2005-11-25 21:54:07.000000000 +0300
+++ 2.6.15-rc2/kernel/exit.c	2005-11-25 21:56:36.000000000 +0300
@@ -871,9 +871,9 @@ fastcall NORET_TYPE void do_exit(long co
 	tsk->mempolicy = NULL;
 #endif
 
-	/* ->state == EXIT_DEAD causes final put_task_struct after we schedule. */
+	/* ->state == TASK_DEAD causes final put_task_struct after we schedule. */
 	preempt_disable();
-	tsk->state = EXIT_DEAD;
+	tsk->state = TASK_DEAD;
 
 	schedule();
 	BUG();
--- 2.6.15-rc2/kernel/sched.c~3_RENAME	2005-11-25 21:54:07.000000000 +0300
+++ 2.6.15-rc2/kernel/sched.c	2005-11-25 21:56:36.000000000 +0300
@@ -1630,7 +1630,7 @@ static inline void finish_task_switch(ru
 	 * be dropped twice.
 	 *		Manfred Spraul <manfred@colorfullife.com>
 	 */
-	task_dead = (prev->state == EXIT_DEAD);
+	task_dead = (prev->state == TASK_DEAD);
 	finish_arch_switch(prev);
 	finish_lock_switch(rq, prev);
 	if (mm)
@@ -4711,7 +4711,7 @@ static void migrate_dead(unsigned int de
 	BUG_ON(tsk->exit_state != EXIT_ZOMBIE && tsk->exit_state != EXIT_DEAD);
 
 	/* Cannot have done final schedule yet: would have vanished. */
-	BUG_ON(tsk->state == EXIT_DEAD);
+	BUG_ON(tsk->state == TASK_DEAD);
 
 	get_task_struct(tsk);
 
--- 2.6.15-rc2/mm/oom_kill.c~3_RENAME	2005-11-25 21:54:07.000000000 +0300
+++ 2.6.15-rc2/mm/oom_kill.c	2005-11-25 21:56:36.000000000 +0300
@@ -163,7 +163,7 @@ static struct task_struct * select_bad_p
 		 */
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
-		if (releasing && (p->state != EXIT_DEAD))
+		if (releasing && (p->state != TASK_DEAD))
 			return ERR_PTR(-1UL);
 		if (p->flags & PF_SWAPOFF)
 			return p;
