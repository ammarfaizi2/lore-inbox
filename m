Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423272AbWJaNuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423272AbWJaNuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423274AbWJaNuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:50:09 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:14727 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1423272AbWJaNuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:50:07 -0500
Date: Tue, 31 Oct 2006 16:49:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] taskstats: cleanup ->signal->stats allocation
Message-ID: <20061031134954.GA3101@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate ->signal->stats on demand in taskstats_exit(), this allows us to
remove taskstats_tgid_alloc() (the last non-trivial inline) from taskstat's
public interface.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 include/linux/taskstats_kern.h |   24 ------------------------
 kernel/fork.c                  |    1 -
 kernel/taskstats.c             |   26 +++++++++++++++++++++++++-
 3 files changed, 25 insertions(+), 26 deletions(-)

--- STATS/include/linux/taskstats_kern.h~4_fork	2006-10-31 14:39:32.000000000 +0300
+++ STATS/include/linux/taskstats_kern.h	2006-10-31 16:21:54.000000000 +0300
@@ -20,28 +20,6 @@ static inline void taskstats_tgid_init(s
 	sig->stats = NULL;
 }
 
-static inline void taskstats_tgid_alloc(struct task_struct *tsk)
-{
-	struct signal_struct *sig = tsk->signal;
-	struct taskstats *stats;
-
-	if (sig->stats != NULL)
-		return;
-
-	/* No problem if kmem_cache_zalloc() fails */
-	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-
-	spin_lock_irq(&tsk->sighand->siglock);
-	if (!sig->stats) {
-		sig->stats = stats;
-		stats = NULL;
-	}
-	spin_unlock_irq(&tsk->sighand->siglock);
-
-	if (stats)
-		kmem_cache_free(taskstats_cache, stats);
-}
-
 static inline void taskstats_tgid_free(struct signal_struct *sig)
 {
 	if (sig->stats)
@@ -55,8 +33,6 @@ static inline void taskstats_exit(struct
 {}
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {}
-static inline void taskstats_tgid_alloc(struct task_struct *tsk)
-{}
 static inline void taskstats_tgid_free(struct signal_struct *sig)
 {}
 static inline void taskstats_init_early(void)
--- STATS/kernel/fork.c~4_fork	2006-10-27 02:16:30.000000000 +0400
+++ STATS/kernel/fork.c	2006-10-31 16:16:46.000000000 +0300
@@ -830,7 +830,6 @@ static inline int copy_signal(unsigned l
 	if (clone_flags & CLONE_THREAD) {
 		atomic_inc(&current->signal->count);
 		atomic_inc(&current->signal->live);
-		taskstats_tgid_alloc(current);
 		return 0;
 	}
 	sig = kmem_cache_alloc(signal_cachep, GFP_KERNEL);
--- STATS/kernel/taskstats.c~4_fork	2006-10-31 15:25:06.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-10-31 16:33:56.000000000 +0300
@@ -417,6 +417,30 @@ err:
 	return rc;
 }
 
+static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
+{
+	struct signal_struct *sig = tsk->signal;
+	struct taskstats *stats;
+
+	if (sig->stats || thread_group_empty(tsk))
+		goto ret;
+
+	/* No problem if kmem_cache_zalloc() fails */
+	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+
+	spin_lock_irq(&tsk->sighand->siglock);
+	if (!sig->stats) {
+		sig->stats = stats;
+		stats = NULL;
+	}
+	spin_unlock_irq(&tsk->sighand->siglock);
+
+	if (stats)
+		kmem_cache_free(taskstats_cache, stats);
+ret:
+	return sig->stats;
+}
+
 /* Send pid data out on exit */
 void taskstats_exit(struct task_struct *tsk, int group_dead)
 {
@@ -438,7 +462,7 @@ void taskstats_exit(struct task_struct *
 	size = nla_total_size(sizeof(u32)) +
 		nla_total_size(sizeof(struct taskstats)) + nla_total_size(0);
 
-	is_thread_group = (tsk->signal->stats != NULL);
+	is_thread_group = !!taskstats_tgid_alloc(tsk);
 	if (is_thread_group) {
 		/* PID + STATS + TGID + STATS */
 		size = 2 * size;

