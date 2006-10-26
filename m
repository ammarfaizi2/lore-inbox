Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945984AbWJZXVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945984AbWJZXVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWJZXVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:21:41 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:902 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1945984AbWJZXVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:21:39 -0400
Date: Fri, 27 Oct 2006 03:21:28 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] taskstats_tgid_free: fix usage
Message-ID: <20061026232128.GA526@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

taskstats_tgid_free() is called on copy_process's error path. This is wrong.

	IF (clone_flags & CLONE_THREAD)
		We should not clear ->signal->taskstats, current uses it,
		it probably has a valid accumulated info.
	ELSE
		taskstats_tgid_init() set ->signal->taskstats = NULL,
		there is nothing to free.

Move the callsite to __exit_signal(). We don't need any locking, entire
thread group is exiting, nobody should have a reference to soon to be
released ->signal.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/include/linux/taskstats_kern.h~3_free	2006-07-29 05:05:59.000000000 +0400
+++ STATS/include/linux/taskstats_kern.h	2006-10-27 01:28:31.000000000 +0400
@@ -49,17 +49,8 @@ static inline void taskstats_tgid_alloc(
 
 static inline void taskstats_tgid_free(struct signal_struct *sig)
 {
-	struct taskstats *stats = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sig->stats_lock, flags);
-	if (sig->stats) {
-		stats = sig->stats;
-		sig->stats = NULL;
-	}
-	spin_unlock_irqrestore(&sig->stats_lock, flags);
-	if (stats)
-		kmem_cache_free(taskstats_cache, stats);
+	if (sig->stats)
+		kmem_cache_free(taskstats_cache, sig->stats);
 }
 
 extern void taskstats_exit_alloc(struct taskstats **, unsigned int *);
--- STATS/kernel/fork.c~3_free	2006-10-25 01:07:22.000000000 +0400
+++ STATS/kernel/fork.c	2006-10-27 01:29:28.000000000 +0400
@@ -897,7 +897,6 @@ static inline int copy_signal(unsigned l
 void __cleanup_signal(struct signal_struct *sig)
 {
 	exit_thread_group_keys(sig);
-	taskstats_tgid_free(sig);
 	kmem_cache_free(signal_cachep, sig);
 }
 
--- STATS/kernel/exit.c~3_free	2006-10-22 18:24:03.000000000 +0400
+++ STATS/kernel/exit.c	2006-10-27 01:34:15.000000000 +0400
@@ -128,6 +128,7 @@ static void __exit_signal(struct task_st
 	flush_sigqueue(&tsk->pending);
 	if (sig) {
 		flush_sigqueue(&sig->shared_pending);
+		taskstats_tgid_free(sig);
 		__cleanup_signal(sig);
 	}
 }

