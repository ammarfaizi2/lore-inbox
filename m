Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWFZSLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWFZSLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWFZSLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:11:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56293 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932598AbWFZSLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:11:46 -0400
Message-ID: <44A02331.8020903@watson.ibm.com>
Date: Mon, 26 Jun 2006 14:10:57 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@engr.sgi.com>, Andrew Morton <akpm@osdl.org>
CC: Balbir Singh <balbir@in.ibm.com>, Chris Sturtivant <csturtiv@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] delay accounting taskstats interface send tgid once
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send per-tgid data only once during exit of a thread group instead of once with
each member thread exit.

Currently, when a thread exits, besides its per-tid data, the per-tgid data of
its thread group is also sent out, if its thread group is non-empty. The
per-tgid data sent consists of the sum of per-tid stats for all *remaining*
threads of the thread group.

This patch modifies this sending in two ways:

- the per-tgid data is sent only when the last thread of a thread group exits.
This cuts down heavily on the overhead of sending/receiving per-tgid data,
especially  when other exploiters of the taskstats interface aren't interested
in per-tgid stats

- the semantics of the per-tgid data sent are changed. Instead of being the
sum of per-tid data for remaining threads, the value now sent is the true total
accumalated statistics for all threads that are/were part of the thread group.

The patch also addresses a minor issue where failure of one accounting
subsystem to fill in the taskstats structure was causing the send of taskstats
to not be sent at all.

The patch has been tested for stability and run cerberus for over 4 hours on
an SMP.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
Signed-off-by: Balbir Singh <balbir@in.ibm.com>

 Documentation/accounting/delay-accounting.txt |   13 +--
 Documentation/accounting/taskstats.txt        |   33 +++-----
 MAINTAINERS                                   |   12 +++
 include/linux/sched.h                         |    4 +
 include/linux/taskstats_kern.h                |   67 +++++++++++++-----
 kernel/exit.c                                 |    8 +-
 kernel/fork.c                                 |    4 +
 kernel/taskstats.c                            |   96 +++++++++++++++++---------
 8 files changed, 155 insertions(+), 82 deletions(-)

Index: linux-2.6.17/include/linux/sched.h
===================================================================
--- linux-2.6.17.orig/include/linux/sched.h	2006-06-23 14:03:38.000000000 -0400
+++ linux-2.6.17/include/linux/sched.h	2006-06-23 14:03:38.000000000 -0400
@@ -449,6 +449,10 @@ struct signal_struct {
 	struct key *session_keyring;	/* keyring inherited over fork */
 	struct key *process_keyring;	/* keyring private to this process */
 #endif
+#ifdef CONFIG_TASKSTATS
+	spinlock_t stats_lock;
+	struct taskstats *stats;
+#endif
 };

 /* Context switch must be unlocked if interrupts are to be enabled */
Index: linux-2.6.17/include/linux/taskstats_kern.h
===================================================================
--- linux-2.6.17.orig/include/linux/taskstats_kern.h	2006-06-23 14:03:38.000000000 -0400
+++ linux-2.6.17/include/linux/taskstats_kern.h	2006-06-23 14:21:41.000000000 -0400
@@ -19,36 +19,71 @@ enum {
 extern kmem_cache_t *taskstats_cache;
 extern struct mutex taskstats_exit_mutex;

-static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
-					struct taskstats **ptgidstats)
+static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
 {
 	*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-	*ptgidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
 }

-static inline void taskstats_exit_free(struct taskstats *tidstats,
-					struct taskstats *tgidstats)
+static inline void taskstats_exit_free(struct taskstats *tidstats)
 {
 	if (tidstats)
 		kmem_cache_free(taskstats_cache, tidstats);
-	if (tgidstats)
-		kmem_cache_free(taskstats_cache, tgidstats);
 }

-extern void taskstats_exit_send(struct task_struct *, struct taskstats *,
-				struct taskstats *);
-extern void taskstats_init_early(void);
+static inline void taskstats_tgid_init(struct signal_struct *sig)
+{
+	spin_lock_init(&sig->stats_lock);
+	sig->stats = NULL;
+}
+
+static inline void taskstats_tgid_alloc(struct signal_struct *sig)
+{
+	struct taskstats *stats;
+
+	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+	if (!stats)
+		return;
+
+	spin_lock(&sig->stats_lock);
+	if (!sig->stats) {
+		sig->stats = stats;
+		stats = NULL;
+	}
+	spin_unlock(&sig->stats_lock);
+
+	if (stats)
+		kmem_cache_free(taskstats_cache, stats);
+}

+static inline void taskstats_tgid_free(struct signal_struct *sig)
+{
+	struct taskstats *stats = NULL;
+	spin_lock(&sig->stats_lock);
+	if (sig->stats) {
+		stats = sig->stats;
+		sig->stats = NULL;
+	}
+	spin_unlock(&sig->stats_lock);
+	if (stats)
+		kmem_cache_free(taskstats_cache, stats);
+}
+
+extern void taskstats_exit_send(struct task_struct *, struct taskstats *, int);
+extern void taskstats_init_early(void);
+extern void taskstats_tgid_alloc(struct signal_struct *);
 #else
-static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
-					struct taskstats **ptgidstats)
+static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
 {}
-static inline void taskstats_exit_free(struct taskstats *ptidstats,
-					struct taskstats *ptgidstats)
+static inline void taskstats_exit_free(struct taskstats *ptidstats)
 {}
 static inline void taskstats_exit_send(struct task_struct *tsk,
-					struct taskstats *tidstats,
-					struct taskstats *tgidstats)
+				       struct taskstats *tidstats, int)
+{}
+static inline void taskstats_tgid_init(struct signal_struct *sig)
+{}
+static inline void taskstats_tgid_alloc(struct signal_struct *sig)
+{}
+static inline void taskstats_tgid_free(struct signal_struct *sig)
 {}
 static inline void taskstats_init_early(void)
 {}
Index: linux-2.6.17/kernel/fork.c
===================================================================
--- linux-2.6.17.orig/kernel/fork.c	2006-06-23 14:03:37.000000000 -0400
+++ linux-2.6.17/kernel/fork.c	2006-06-23 14:03:38.000000000 -0400
@@ -45,6 +45,7 @@
 #include <linux/acct.h>
 #include <linux/cn_proc.h>
 #include <linux/delayacct.h>
+#include <linux/taskstats_kern.h>

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -815,6 +816,7 @@ static inline int copy_signal(unsigned l
 	if (clone_flags & CLONE_THREAD) {
 		atomic_inc(&current->signal->count);
 		atomic_inc(&current->signal->live);
+		taskstats_tgid_alloc(current->signal);
 		return 0;
 	}
 	sig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
@@ -859,6 +861,7 @@ static inline int copy_signal(unsigned l
 	INIT_LIST_HEAD(&sig->cpu_timers[0]);
 	INIT_LIST_HEAD(&sig->cpu_timers[1]);
 	INIT_LIST_HEAD(&sig->cpu_timers[2]);
+	taskstats_tgid_init(sig);

 	task_lock(current->group_leader);
 	memcpy(sig->rlim, current->signal->rlim, sizeof sig->rlim);
@@ -879,6 +882,7 @@ static inline int copy_signal(unsigned l
 void __cleanup_signal(struct signal_struct *sig)
 {
 	exit_thread_group_keys(sig);
+	taskstats_tgid_free(sig);
 	kmem_cache_free(signal_cachep, sig);
 }

Index: linux-2.6.17/kernel/taskstats.c
===================================================================
--- linux-2.6.17.orig/kernel/taskstats.c	2006-06-23 14:03:38.000000000 -0400
+++ linux-2.6.17/kernel/taskstats.c	2006-06-26 14:03:08.000000000 -0400
@@ -132,46 +132,76 @@ static int fill_pid(pid_t pid, struct ta
 static int fill_tgid(pid_t tgid, struct task_struct *tgidtsk,
 		struct taskstats *stats)
 {
-	int rc;
 	struct task_struct *tsk, *first;

+	/*
+	 * Add additional stats from live tasks except zombie thread group
+	 * leaders who are already counted with the dead tasks
+	 */
 	first = tgidtsk;
-	read_lock(&tasklist_lock);
 	if (!first) {
+		read_lock(&tasklist_lock);
 		first = find_task_by_pid(tgid);
 		if (!first) {
 			read_unlock(&tasklist_lock);
 			return -ESRCH;
 		}
-	}
+		get_task_struct(first);
+		read_unlock(&tasklist_lock);
+	} else
+		get_task_struct(first);
+
+	/* Start with stats from dead tasks */
+	spin_lock(&first->signal->stats_lock);
+	if (first->signal->stats)
+		memcpy(stats, first->signal->stats, sizeof(*stats));
+	spin_unlock(&first->signal->stats_lock);
+
 	tsk = first;
+	read_lock(&tasklist_lock);
 	do {
+		if (tsk->exit_state == EXIT_ZOMBIE && thread_group_leader(tsk))
+			continue;
 		/*
-		 * Each accounting subsystem adds calls its functions to
+		 * Accounting subsystem can call its functions here to
 		 * fill in relevant parts of struct taskstsats as follows
 		 *
-		 *	rc = per-task-foo(stats, tsk);
-		 *	if (rc)
-		 *		break;
+		 *	per-task-foo(stats, tsk);
 		 */
-
-		rc = delayacct_add_tsk(stats, tsk);
-		if (rc)
-			break;
+		delayacct_add_tsk(stats, tsk);

 	} while_each_thread(first, tsk);
 	read_unlock(&tasklist_lock);
 	stats->version = TASKSTATS_VERSION;

-
 	/*
-	 * Accounting subsytems can also add calls here if they don't
-	 * wish to aggregate statistics for per-tgid stats
+	 * Accounting subsytems can also add calls here to modify
+	 * fields of taskstats.
 	 */

-	return rc;
+	return 0;
 }

+
+static void fill_tgid_exit(struct task_struct *tsk)
+{
+	spin_lock(&tsk->signal->stats_lock);
+	if (!tsk->signal->stats)
+		goto ret;
+
+	/*
+	 * Each accounting subsystem calls its functions here to
+	 * accumalate its per-task stats for tsk, into the per-tgid structure
+	 *
+	 *	per-task-foo(tsk->signal->stats, tsk);
+	 */
+	delayacct_add_tsk(tsk->signal->stats, tsk);
+ret:
+	spin_unlock(&tsk->signal->stats_lock);
+	return;
+}
+
+
 static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
@@ -230,7 +260,7 @@ err:

 /* Send pid data out on exit */
 void taskstats_exit_send(struct task_struct *tsk, struct taskstats *tidstats,
-			struct taskstats *tgidstats)
+			int group_dead)
 {
 	int rc;
 	struct sk_buff *rep_skb;
@@ -242,9 +272,11 @@ void taskstats_exit_send(struct task_str
 	if (!family_registered || !tidstats)
 		return;

-	is_thread_group = !thread_group_empty(tsk);
-	rc = 0;
+	spin_lock(&tsk->signal->stats_lock);
+	is_thread_group = tsk->signal->stats ? 1 : 0;
+	spin_unlock(&tsk->signal->stats_lock);

+	rc = 0;
 	/*
 	 * Size includes space for nested attributes
 	 */
@@ -268,30 +300,28 @@ void taskstats_exit_send(struct task_str
 			*tidstats);
 	nla_nest_end(rep_skb, na);

-	if (!is_thread_group || !tgidstats) {
-		send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
-		goto ret;
-	}
+	if (!is_thread_group)
+		goto send;

-	rc = fill_tgid(tsk->pid, tsk, tgidstats);
-	/*
-	 * If fill_tgid() failed then one probable reason could be that the
-	 * thread group leader has exited. fill_tgid() will fail, send out
-	 * the pid statistics collected earlier.
+	/*
+	 * tsk has/had a thread group so fill the tsk->signal->stats structure
+	 * Doesn't matter if tsk is the leader or the last group member leaving
 	 */
-	if (rc < 0) {
-		send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
-		goto ret;
-	}
+
+	fill_tgid_exit(tsk);
+	if (!group_dead)
+		goto send;

 	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
 	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
+	/* No locking needed for tsk->signal->stats since group is dead */
 	NLA_PUT_TYPE(rep_skb, struct taskstats, TASKSTATS_TYPE_STATS,
-			*tgidstats);
+			*tsk->signal->stats);
 	nla_nest_end(rep_skb, na);

+send:
 	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
-	goto ret;
+	return;

 nla_put_failure:
 	genlmsg_cancel(rep_skb, reply);
Index: linux-2.6.17/kernel/exit.c
===================================================================
--- linux-2.6.17.orig/kernel/exit.c	2006-06-23 14:03:37.000000000 -0400
+++ linux-2.6.17/kernel/exit.c	2006-06-23 14:03:38.000000000 -0400
@@ -850,7 +850,7 @@ static void exit_notify(struct task_stru
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
-	struct taskstats *tidstats, *tgidstats;
+	struct taskstats *tidstats;
 	int group_dead;

 	profile_task_exit(tsk);
@@ -889,7 +889,7 @@ fastcall NORET_TYPE void do_exit(long co
 				current->comm, current->pid,
 				preempt_count());

-	taskstats_exit_alloc(&tidstats, &tgidstats);
+	taskstats_exit_alloc(&tidstats);

 	acct_update_integrals(tsk);
 	if (tsk->mm) {
@@ -910,8 +910,8 @@ fastcall NORET_TYPE void do_exit(long co
 #endif
 	if (unlikely(tsk->audit_context))
 		audit_free(tsk);
-	taskstats_exit_send(tsk, tidstats, tgidstats);
-	taskstats_exit_free(tidstats, tgidstats);
+	taskstats_exit_send(tsk, tidstats, group_dead);
+	taskstats_exit_free(tidstats);
 	delayacct_tsk_exit(tsk);

 	exit_mm(tsk);
Index: linux-2.6.17/Documentation/accounting/delay-accounting.txt
===================================================================
--- linux-2.6.17.orig/Documentation/accounting/delay-accounting.txt	2006-06-23 14:03:38.000000000 -0400
+++ linux-2.6.17/Documentation/accounting/delay-accounting.txt	2006-06-23 14:03:38.000000000 -0400
@@ -48,9 +48,10 @@ counter (say cpu_delay_total) for a task
 experienced by the task waiting for the corresponding resource
 in that interval.

-When a task exits, records containing the per-task and per-process statistics
-are sent to userspace without requiring a command. More details are given in
-the taskstats interface description.
+When a task exits, records containing the per-task statistics
+are sent to userspace without requiring a command. If it is the last exiting
+task of a thread group, the per-tgid statistics are also sent. More details
+are given in the taskstats interface description.

 The getdelays.c userspace utility in this directory allows simple commands to
 be run and the corresponding delay statistics to be displayed. It also serves
@@ -107,9 +108,3 @@ IO	count	delay total
 	0	0
 MEM	count	delay total
 	0	0
-
-
-
-
-
-
Index: linux-2.6.17/Documentation/accounting/taskstats.txt
===================================================================
--- linux-2.6.17.orig/Documentation/accounting/taskstats.txt	2006-06-23 14:03:38.000000000 -0400
+++ linux-2.6.17/Documentation/accounting/taskstats.txt	2006-06-23 14:03:38.000000000 -0400
@@ -32,12 +32,11 @@ The response contains statistics for a t
 statistics for all tasks of the process (if tgid is specified).

 To obtain statistics for tasks which are exiting, userspace opens a multicast
-netlink socket. Each time a task exits, two records are sent by the kernel to
-each listener on the multicast socket. The first the per-pid task's statistics
-and the second is the sum for all tasks of the process to which the task
-belongs (the task does not need to be the thread group leader). The need for
-per-tgid stats to be sent for each exiting task is explained in the per-tgid
-stats section below.
+netlink socket. Each time a task exits, its per-pid statistics is always sent
+by the kernel to each listener on the multicast socket. In addition, if it is
+the last thread exiting its thread group, an additional record containing the
+per-tgid stats are also sent. The latter contains the sum of per-pid stats for
+all threads in the thread group, both past and present.

 getdelays.c is a simple utility demonstrating usage of the taskstats interface
 for reporting delay accounting statistics.
@@ -104,20 +103,14 @@ stats in userspace alone is inefficient
 of atomicity).

 However, maintaining per-process, in addition to per-task stats, within the
-kernel has space and time overheads. Hence the taskstats implementation
-dynamically sums up the per-task stats for each task belonging to a process
-whenever per-process stats are needed.
-
-Not maintaining per-tgid stats creates a problem when userspace is interested
-in getting these stats when the process dies i.e. the last thread of
-a process exits. It isn't possible to simply return some aggregated per-process
-statistic from the kernel.
-
-The approach taken by taskstats is to return the per-tgid stats *each* time
-a task exits, in addition to the per-pid stats for that task. Userspace can
-maintain task<->process mappings and use them to maintain the per-process stats
-in userspace, updating the aggregate appropriately as the tasks of a process
-exit.
+kernel has space and time overheads. To address this, the taskstats code
+accumalates each exiting task's statistics into a process-wide data structure.
+When the last task of a process exits, the process level data accumalated also
+gets sent to userspace (along with the per-task data).
+
+When a user queries to get per-tgid data, the sum of all other live threads in
+the group is added up and added to the accumalated total for previously exited
+threads of the same thread group.

 Extending taskstats
 -------------------
Index: linux-2.6.17/MAINTAINERS
===================================================================
--- linux-2.6.17.orig/MAINTAINERS	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/MAINTAINERS	2006-06-23 14:12:05.000000000 -0400
@@ -2185,6 +2185,12 @@ M:	tsbogend@alpha.franken.de
 L:	netdev@vger.kernel.org
 S:	Maintained

+PER-TASK DELAY ACCOUNTING
+P:	Shailabh Nagar
+M:	nagar@watson.ibm.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 PERSONALITY HANDLING
 P:	Christoph Hellwig
 M:	hch@infradead.org
@@ -2701,6 +2707,12 @@ P:	Christoph Hellwig
 M:	hch@infradead.org
 S:	Maintained

+TASKSTATS STATISTICS INTERFACE
+P:	Shailabh Nagar
+M:	nagar@watson.ibm.com
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 TI PARALLEL LINK CABLE DRIVER
 P:     Romain Lievin
 M:     roms@lpg.ticalc.org
