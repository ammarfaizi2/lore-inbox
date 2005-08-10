Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbVHJRLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVHJRLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbVHJRLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:11:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:30148 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965216AbVHJRLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:11:16 -0400
Date: Wed, 10 Aug 2005 10:11:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com, bmark@us.ibm.com
Subject: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050810171145.GA1945@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch is an experiment in use of RCU for individual code paths that
read-acquire the tasklist lock, in this case, unicast signal delivery.
It passes five kernbenches on 4-CPU x86, but obviously needs much more
testing before it is considered for serious use, let alone inclusion.

My main question is whether I have the POSIX semantics covered.  I believe
that I do, but thought I should check with people who are more familiar
with POSIX than am I.

For the record, some shortcomings of this patch:

o	Needs lots more testing on more architectures.

o	Needs performance and stress testing.

o	Needs testing in Ingo's PREEMPT_RT environment.

o	Uses cmpxchg(), which is currently architecture dependent.
	This can be fixed, for example, by using the hashed locks
	proposed in an earlier patch from Dipankar:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=111875978502912&w=2

Thoughts?

						Thanx, Paul

---

Not-signed-off-by: paulmck@us.ibm.com

 include/linux/sched.h |   27 +++++++++++++++++++++++++--
 kernel/sched.c        |    5 +++++
 kernel/signal.c       |    8 ++++++--
 3 files changed, 36 insertions(+), 4 deletions(-)

diff -urpN -X dontdiff linux-2.6.13-rc6/include/linux/sched.h linux-2.6.13-rc6-tasklistRCU/include/linux/sched.h
--- linux-2.6.13-rc6/include/linux/sched.h	2005-08-08 19:59:23.000000000 -0700
+++ linux-2.6.13-rc6-tasklistRCU/include/linux/sched.h	2005-08-09 15:44:48.000000000 -0700
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/rcupdate.h>
 
 struct exec_domain;
 
@@ -770,6 +771,7 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+	struct rcu_head rcu;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
@@ -793,8 +795,29 @@ static inline int pid_alive(struct task_
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
-#define put_task_struct(tsk) \
-do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
+
+static inline int get_task_struct_rcu(struct task_struct *t)
+{
+	int oldusage;
+
+	do {
+		oldusage = atomic_read(&t->usage);
+		if (oldusage == 0) {
+			return 0;
+		}
+	} while (cmpxchg(&t->usage.counter,
+		 oldusage, oldusage + 1) != oldusage);
+	return 1;
+}
+
+extern void __put_task_struct_cb(struct rcu_head *rhp);
+
+static inline void put_task_struct(struct task_struct *t)
+{
+	if (atomic_dec_and_test(&t->usage)) {
+		call_rcu(&t->rcu, __put_task_struct_cb);
+	}
+}
 
 /*
  * Per process flags
diff -urpN -X dontdiff linux-2.6.13-rc6/kernel/sched.c linux-2.6.13-rc6-tasklistRCU/kernel/sched.c
--- linux-2.6.13-rc6/kernel/sched.c	2005-08-08 19:59:24.000000000 -0700
+++ linux-2.6.13-rc6-tasklistRCU/kernel/sched.c	2005-08-09 12:27:34.000000000 -0700
@@ -176,6 +176,11 @@ static unsigned int task_timeslice(task_
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
+void __put_task_struct_cb(struct rcu_head *rhp)
+{
+	__put_task_struct(container_of(rhp, struct task_struct, rcu));
+}
+
 /*
  * These are the runqueue data structures:
  */
diff -urpN -X dontdiff linux-2.6.13-rc6/kernel/signal.c linux-2.6.13-rc6-tasklistRCU/kernel/signal.c
--- linux-2.6.13-rc6/kernel/signal.c	2005-08-08 19:59:24.000000000 -0700
+++ linux-2.6.13-rc6-tasklistRCU/kernel/signal.c	2005-08-10 08:20:25.000000000 -0700
@@ -1151,9 +1151,13 @@ int group_send_sig_info(int sig, struct 
 
 	ret = check_kill_permission(sig, info, p);
 	if (!ret && sig && p->sighand) {
+		if (!get_task_struct_rcu(p)) {
+			return -ESRCH;
+		}
 		spin_lock_irqsave(&p->sighand->siglock, flags);
 		ret = __group_send_sig_info(sig, info, p);
 		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		put_task_struct(p);
 	}
 
 	return ret;
@@ -1200,12 +1204,12 @@ kill_proc_info(int sig, struct siginfo *
 	int error;
 	struct task_struct *p;
 
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	p = find_task_by_pid(pid);
 	error = -ESRCH;
 	if (p)
 		error = group_send_sig_info(sig, info, p);
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	return error;
 }
 
