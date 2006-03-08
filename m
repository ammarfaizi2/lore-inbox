Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWCHRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWCHRNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWCHRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:13:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3816 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751133AbWCHRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:13:46 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       William Irwin <wli@holomorphy.com>, Roland McGrath <roland@redhat.com>
Subject: [PATCH] task: RCU protect task->usage
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Mar 2006 09:39:17 -0700
Message-ID: <m1fylsx556.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanup of task_struct does not happen when it's reference count drops to
zero, instead cleanup happens when release_task is called.  Tasks can only
be looked up via rcu before release_task is called.  All rcu protected members
of task_struct are freed by release_task.

Therefore we can move call_rcu from put_task_struct into release_task.
And we can modify release_task to not immediately release the reference
count but instead have it call put_task_struct from the function it gives
to call_rcu.

The end result:
- get_task_struct is safe in an rcu context where we have just looked
  up the task.
- put_task_struct simplifies into it's old pre rcu self.

This reorganization also makes put_task_struct uncallable from modules
as it is not exported but it does not appear to be called from any
modules so this should not be an issue, and is triviall fixed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 include/linux/sched.h |    4 +---
 kernel/exit.c         |    7 ++++++-
 kernel/sched.c        |    7 -------
 3 files changed, 7 insertions(+), 11 deletions(-)

0147f1b21f737305af237aa1ad1f03b9fb94dac8
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 37a5d3c..2856f52 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -908,12 +908,10 @@ extern void free_task(struct task_struct
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 
-extern void __put_task_struct_cb(struct rcu_head *rhp);
-
 static inline void put_task_struct(struct task_struct *t)
 {
 	if (atomic_dec_and_test(&t->usage))
-		call_rcu(&t->rcu, __put_task_struct_cb);
+		__put_task_struct(t);
 }
 
 /*
diff --git a/kernel/exit.c b/kernel/exit.c
index 2a7928a..806a667 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -127,6 +127,11 @@ static void __exit_signal(struct task_st
 	}
 }
 
+static void delayed_put_task_struct(struct rcu_head *rhp)
+{
+	put_task_struct(container_of(rhp, struct task_struct, rcu));
+}
+
 void release_task(struct task_struct * p)
 {
 	int zap_leader;
@@ -163,7 +168,7 @@ repeat:
 	write_unlock_irq(&tasklist_lock);
 	proc_flush_task(p);
 	release_thread(p);
-	put_task_struct(p);
+	call_rcu(&p->rcu, delayed_put_task_struct);
 
 	p = leader;
 	if (unlikely(zap_leader))
diff --git a/kernel/sched.c b/kernel/sched.c
index be211df..d901d1b 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -188,13 +188,6 @@ static inline unsigned int task_timeslic
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
-void __put_task_struct_cb(struct rcu_head *rhp)
-{
-	__put_task_struct(container_of(rhp, struct task_struct, rcu));
-}
-
-EXPORT_SYMBOL_GPL(__put_task_struct_cb);
-
 /*
  * These are the runqueue data structures:
  */
-- 
1.2.2.g709a-dirty

