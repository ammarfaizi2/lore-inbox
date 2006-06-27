Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161209AbWF0Q4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWF0Q4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWF0Q4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:56:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:61572 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161209AbWF0Q4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:56:02 -0400
Message-ID: <44A162F0.3060808@watson.ibm.com>
Date: Tue, 27 Jun 2006 12:55:12 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: Arjan van de Ven <arjan@infradead.org>, michal.k.k.piotrowski@gmail.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, balbir@in.ibm.com,
       jlan@engr.sgi.com
Subject: [PATCH] delay accounting taskstats interface: send tgid once locking
 fix
References: <200606261906.k5QJ6vCp025201@shell0.pdx.osdl.net> <1151421336.5217.28.camel@laptopd505.fenrus.org> <44A15483.30308@watson.ibm.com> <44A1576C.8090307@watson.ibm.com>
In-Reply-To: <44A1576C.8090307@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use irqsave variants of spin_lock for newly introduced tsk->signal->stats_lock
The lock is nested within tasklist_lock as part of release_task() and hence
there is possibility of a AB-BA deadlock if a timer interrupt occurs while
stats_lock is held.

Thanks to Arjan van de Ven for pointing out the lock bug.
The patch conservatively converts all use of stats_lock to irqsave variant
rather than only the call within taskstats_tgid_free which is the function
called within tasklist_lock protection.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

---

 include/linux/taskstats_kern.h |   11 +++++++----
 kernel/taskstats.c             |   16 ++++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

Index: linux-2.6.17/kernel/taskstats.c
===================================================================
--- linux-2.6.17.orig/kernel/taskstats.c	2006-06-27 12:22:45.000000000 -0400
+++ linux-2.6.17/kernel/taskstats.c	2006-06-27 12:34:16.000000000 -0400
@@ -133,6 +133,7 @@ static int fill_tgid(pid_t tgid, struct
 		struct taskstats *stats)
 {
 	struct task_struct *tsk, *first;
+	unsigned long flags;

 	/*
 	 * Add additional stats from live tasks except zombie thread group
@@ -152,10 +153,10 @@ static int fill_tgid(pid_t tgid, struct
 		get_task_struct(first);

 	/* Start with stats from dead tasks */
-	spin_lock(&first->signal->stats_lock);
+	spin_lock_irqsave(&first->signal->stats_lock, flags);
 	if (first->signal->stats)
 		memcpy(stats, first->signal->stats, sizeof(*stats));
-	spin_unlock(&first->signal->stats_lock);
+	spin_unlock_irqrestore(&first->signal->stats_lock, flags);

 	tsk = first;
 	read_lock(&tasklist_lock);
@@ -185,7 +186,9 @@ static int fill_tgid(pid_t tgid, struct

 static void fill_tgid_exit(struct task_struct *tsk)
 {
-	spin_lock(&tsk->signal->stats_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&tsk->signal->stats_lock, flags);
 	if (!tsk->signal->stats)
 		goto ret;

@@ -197,7 +200,7 @@ static void fill_tgid_exit(struct task_s
 	 */
 	delayacct_add_tsk(tsk->signal->stats, tsk);
 ret:
-	spin_unlock(&tsk->signal->stats_lock);
+	spin_unlock_irqrestore(&tsk->signal->stats_lock, flags);
 	return;
 }

@@ -268,13 +271,14 @@ void taskstats_exit_send(struct task_str
 	size_t size;
 	int is_thread_group;
 	struct nlattr *na;
+	unsigned long flags;

 	if (!family_registered || !tidstats)
 		return;

-	spin_lock(&tsk->signal->stats_lock);
+	spin_lock_irqsave(&tsk->signal->stats_lock, flags);
 	is_thread_group = tsk->signal->stats ? 1 : 0;
-	spin_unlock(&tsk->signal->stats_lock);
+	spin_unlock_irqrestore(&tsk->signal->stats_lock, flags);

 	rc = 0;
 	/*
Index: linux-2.6.17/include/linux/taskstats_kern.h
===================================================================
--- linux-2.6.17.orig/include/linux/taskstats_kern.h	2006-06-27 12:22:34.000000000 -0400
+++ linux-2.6.17/include/linux/taskstats_kern.h	2006-06-27 12:36:12.000000000 -0400
@@ -50,17 +50,18 @@ static inline void taskstats_tgid_init(s
 static inline void taskstats_tgid_alloc(struct signal_struct *sig)
 {
 	struct taskstats *stats;
+	unsigned long flags;

 	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
 	if (!stats)
 		return;

-	spin_lock(&sig->stats_lock);
+	spin_lock_irqsave(&sig->stats_lock, flags);
 	if (!sig->stats) {
 		sig->stats = stats;
 		stats = NULL;
 	}
-	spin_unlock(&sig->stats_lock);
+	spin_unlock_irqrestore(&sig->stats_lock, flags);

 	if (stats)
 		kmem_cache_free(taskstats_cache, stats);
@@ -69,12 +70,14 @@ static inline void taskstats_tgid_alloc(
 static inline void taskstats_tgid_free(struct signal_struct *sig)
 {
 	struct taskstats *stats = NULL;
-	spin_lock(&sig->stats_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sig->stats_lock, flags);
 	if (sig->stats) {
 		stats = sig->stats;
 		sig->stats = NULL;
 	}
-	spin_unlock(&sig->stats_lock);
+	spin_unlock_irqrestore(&sig->stats_lock, flags);
 	if (stats)
 		kmem_cache_free(taskstats_cache, stats);
 }
