Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945990AbWJZXWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945990AbWJZXWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWJZXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:22:18 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:6534 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1945992AbWJZXWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:22:15 -0400
Date: Fri, 27 Oct 2006 03:22:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] taskstats: kill ->taskstats_lock in favor of ->siglock
Message-ID: <20061026232203.GA532@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

signal_struct is (mostly) protected by ->sighand->siglock, I think
we don't need ->taskstats_lock to protect ->stats. This also allows
us to simplify the locking in fill_tgid().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 include/linux/sched.h          |    1 -
 include/linux/taskstats_kern.h |   15 ++++++---------
 kernel/fork.c                  |    2 +-
 kernel/taskstats.c             |   16 ++++++----------
 4 files changed, 13 insertions(+), 21 deletions(-)

--- STATS/include/linux/sched.h~5_siglock	2006-10-22 18:24:18.000000000 +0400
+++ STATS/include/linux/sched.h	2006-10-27 01:49:19.000000000 +0400
@@ -466,7 +466,6 @@ struct signal_struct {
 	struct pacct_struct pacct;	/* per-process accounting information */
 #endif
 #ifdef CONFIG_TASKSTATS
-	spinlock_t stats_lock;
 	struct taskstats *stats;
 #endif
 };
--- STATS/include/linux/taskstats_kern.h~5_siglock	2006-10-27 01:39:10.000000000 +0400
+++ STATS/include/linux/taskstats_kern.h	2006-10-27 02:13:11.000000000 +0400
@@ -23,28 +23,26 @@ static inline void taskstats_exit_free(s
 
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {
-	spin_lock_init(&sig->stats_lock);
 	sig->stats = NULL;
 }
 
-static inline void taskstats_tgid_alloc(struct signal_struct *sig)
+static inline void taskstats_tgid_alloc(struct task_struct *tsk)
 {
+	struct signal_struct *sig = tsk->signal;
 	struct taskstats *stats;
-	unsigned long flags;
 
 	if (sig->stats != NULL)
 		return;
 
+	/* No problem if kmem_cache_zalloc() fails */
 	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-	if (!stats)
-		return;
 
-	spin_lock_irqsave(&sig->stats_lock, flags);
+	spin_lock_irq(&tsk->sighand->siglock);
 	if (!sig->stats) {
 		sig->stats = stats;
 		stats = NULL;
 	}
-	spin_unlock_irqrestore(&sig->stats_lock, flags);
+	spin_unlock_irq(&tsk->sighand->siglock);
 
 	if (stats)
 		kmem_cache_free(taskstats_cache, stats);
@@ -59,7 +57,6 @@ static inline void taskstats_tgid_free(s
 extern void taskstats_exit_alloc(struct taskstats **, unsigned int *);
 extern void taskstats_exit_send(struct task_struct *, struct taskstats *, int, unsigned int);
 extern void taskstats_init_early(void);
-extern void taskstats_tgid_alloc(struct signal_struct *);
 #else
 static inline void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
 {}
@@ -71,7 +68,7 @@ static inline void taskstats_exit_send(s
 {}
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {}
-static inline void taskstats_tgid_alloc(struct signal_struct *sig)
+static inline void taskstats_tgid_alloc(struct task_struct *tsk)
 {}
 static inline void taskstats_tgid_free(struct signal_struct *sig)
 {}
--- STATS/kernel/fork.c~5_siglock	2006-10-27 01:29:28.000000000 +0400
+++ STATS/kernel/fork.c	2006-10-27 02:16:30.000000000 +0400
@@ -830,7 +830,7 @@ static inline int copy_signal(unsigned l
 	if (clone_flags & CLONE_THREAD) {
 		atomic_inc(&current->signal->count);
 		atomic_inc(&current->signal->live);
-		taskstats_tgid_alloc(current->signal);
+		taskstats_tgid_alloc(current);
 		return 0;
 	}
 	sig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
--- STATS/kernel/taskstats.c~5_siglock	2006-10-26 23:44:32.000000000 +0400
+++ STATS/kernel/taskstats.c	2006-10-27 02:00:32.000000000 +0400
@@ -241,11 +241,11 @@ static int fill_tgid(pid_t tgid, struct 
 	tsk = first;
 	read_lock(&tasklist_lock);
 	/* Start with stats from dead tasks */
-	if (first->signal) {
-		spin_lock_irqsave(&first->signal->stats_lock, flags);
+	if (first->sighand) {
+		spin_lock_irqsave(&first->sighand->siglock, flags);
 		if (first->signal->stats)
 			memcpy(stats, first->signal->stats, sizeof(*stats));
-		spin_unlock_irqrestore(&first->signal->stats_lock, flags);
+		spin_unlock_irqrestore(&first->sighand->siglock, flags);
 	}
 
 	do {
@@ -276,7 +276,7 @@ static void fill_tgid_exit(struct task_s
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tsk->signal->stats_lock, flags);
+	spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	if (!tsk->signal->stats)
 		goto ret;
 
@@ -288,7 +288,7 @@ static void fill_tgid_exit(struct task_s
 	 */
 	delayacct_add_tsk(tsk->signal->stats, tsk);
 ret:
-	spin_unlock_irqrestore(&tsk->signal->stats_lock, flags);
+	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
 }
 
@@ -464,15 +464,10 @@ void taskstats_exit_send(struct task_str
 	size_t size;
 	int is_thread_group;
 	struct nlattr *na;
-	unsigned long flags;
 
 	if (!family_registered || !tidstats)
 		return;
 
-	spin_lock_irqsave(&tsk->signal->stats_lock, flags);
-	is_thread_group = tsk->signal->stats ? 1 : 0;
-	spin_unlock_irqrestore(&tsk->signal->stats_lock, flags);
-
 	rc = 0;
 	/*
 	 * Size includes space for nested attributes
@@ -480,6 +475,7 @@ void taskstats_exit_send(struct task_str
 	size = nla_total_size(sizeof(u32)) +
 		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
 
+	is_thread_group = (tsk->signal->stats != NULL);
 	if (is_thread_group)
 		size = 2 * size;	/* PID + STATS + TGID + STATS */
 

