Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWGGT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWGGT3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWGGT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:29:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58517 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932282AbWGGT3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:29:21 -0400
Date: Fri, 7 Jul 2006 12:29:56 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org, dino@us.ibm.com,
       tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: [PATCH -rt] catch put_task_struct RCU handling up to mainline
Message-ID: <20060707192955.GA2219@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Due to the separate -rt and mainline evolution of RCU signal handling,
the -rt patchset now makes each task struct go through two RCU grace
periods, with one call_rcu() in release_task() and with another
in put_task_struct().  Only the call_rcu() in release_task() is
required, since this is the one that is associated with tearing down
the task structure.

This patch removes the extra call_rcu() in put_task_struct(), synching
this up with mainline.  Tested lightly on i386.

CC: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 include/linux/sched.h |   10 ----------
 kernel/fork.c         |   21 ---------------------
 2 files changed, 31 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-rt5/include/linux/sched.h linux-2.6.17-rt5-2RCU/include/linux/sched.h
--- linux-2.6.17-rt5/include/linux/sched.h	2006-07-02 12:37:14.000000000 -0700
+++ linux-2.6.17-rt5-2RCU/include/linux/sched.h	2006-07-06 18:11:49.000000000 -0700
@@ -1105,15 +1105,6 @@ static inline int pid_alive(struct task_
 extern void free_task(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
-#ifdef CONFIG_PREEMPT_RT
-extern void __put_task_struct_cb(struct rcu_head *rhp);
-
-static inline void put_task_struct(struct task_struct *t)
-{
-	if (atomic_dec_and_test(&t->usage))
-		call_rcu(&t->rcu, __put_task_struct_cb);
-}
-#else
 extern void __put_task_struct(struct task_struct *t);
 
 static inline void put_task_struct(struct task_struct *t)
@@ -1121,7 +1112,6 @@ static inline void put_task_struct(struc
 	if (atomic_dec_and_test(&t->usage))
 		__put_task_struct(t);
 }
-#endif
 
 /*
  * Per process flags
diff -urpNa -X dontdiff linux-2.6.17-rt5/kernel/fork.c linux-2.6.17-rt5-2RCU/kernel/fork.c
--- linux-2.6.17-rt5/kernel/fork.c	2006-07-02 12:37:15.000000000 -0700
+++ linux-2.6.17-rt5-2RCU/kernel/fork.c	2006-07-07 07:44:36.000000000 -0700
@@ -120,26 +120,6 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
-#ifdef CONFIG_PREEMPT_RT
-void __put_task_struct_cb(struct rcu_head *rhp)
-{
-	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
-
-	BUG_ON(atomic_read(&tsk->usage));
-	WARN_ON(!(tsk->flags & PF_DEAD));
-	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
-	WARN_ON(tsk == current);
-
-	security_task_free(tsk);
-	free_uid(tsk->user);
-	put_group_info(tsk->group_info);
-
-	if (!profile_handoff_task(tsk))
-		free_task(tsk);
-}
-
-#else
-
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!(tsk->exit_state & (EXIT_DEAD | EXIT_ZOMBIE)));
@@ -154,7 +134,6 @@ void __put_task_struct(struct task_struc
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
 }
-#endif
 
 void __init fork_init(unsigned long mempages)
 {
