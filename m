Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270237AbTGMLwp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270238AbTGMLwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:52:45 -0400
Received: from zeus.kernel.org ([204.152.189.113]:15274 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S270237AbTGMLwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:52:21 -0400
Message-ID: <3F114935.2000409@colorfullife.com>
Date: Sun, 13 Jul 2003 13:57:41 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH, RFC] remove task_cache entirely
Content-Type: multipart/mixed;
 boundary="------------060106030907010109030304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106030907010109030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

kernel/fork.c contains a disabled cache for task stuctures. task 
structures are placed into the task cache only if "tsk==current", and 
"tsk==current" is impossible. There is even a WARN_ON against that in 
__put_task_struct().

What should we do with it? I would remove it entirely - it's dead code. 
Any objections?

One problem is that order-1 allocations are not cached per-cpu - what 
about using kmem_cache_alloc for the stack?

--
    Manfred



--------------060106030907010109030304
Content-Type: text/plain;
 name="patch-remove-taskcache"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-remove-taskcache"

--- 2.5/kernel/fork.c	2003-07-13 13:15:01.000000000 +0200
+++ build-2.5/kernel/fork.c	2003-07-13 13:14:00.000000000 +0200
@@ -53,13 +53,6 @@
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
-/*
- * A per-CPU task cache - this relies on the fact that
- * the very last portion of sys_exit() is executed with
- * preemption turned off.
- */
-static task_t *task_cache[NR_CPUS] __cacheline_aligned;
-
 int nr_processes(void)
 {
 	int cpu;
@@ -80,26 +73,8 @@
 
 static void free_task(struct task_struct *tsk)
 {
-	/*
-	 * The task cache is effectively disabled right now.
-	 * Do we want it? The slab cache already has per-cpu
-	 * stuff, but the thread info (usually a order-1 page
-	 * allocation) doesn't.
-	 */
-	if (tsk != current) {
-		free_thread_info(tsk->thread_info);
-		free_task_struct(tsk);
-	} else {
-		int cpu = get_cpu();
-
-		tsk = task_cache[cpu];
-		if (tsk) {
-			free_thread_info(tsk->thread_info);
-			free_task_struct(tsk);
-		}
-		task_cache[cpu] = current;
-		put_cpu();
-	}
+	free_thread_info(tsk->thread_info);
+	free_task_struct(tsk);
 }
 
 void __put_task_struct(struct task_struct *tsk)
@@ -220,25 +195,18 @@
 {
 	struct task_struct *tsk;
 	struct thread_info *ti;
-	int cpu = get_cpu();
 
 	prepare_to_copy(orig);
 
-	tsk = task_cache[cpu];
-	task_cache[cpu] = NULL;
-	put_cpu();
-	if (!tsk) {
-		tsk = alloc_task_struct();
-		if (!tsk)
-			return NULL;
-
-		ti = alloc_thread_info(tsk);
-		if (!ti) {
-			free_task_struct(tsk);
-			return NULL;
-		}
-	} else
-		ti = tsk->thread_info;
+	tsk = alloc_task_struct();
+	if (!tsk)
+		return NULL;
+
+	ti = alloc_thread_info(tsk);
+	if (!ti) {
+		free_task_struct(tsk);
+		return NULL;
+	}
 
 	*ti = *orig->thread_info;
 	*tsk = *orig;

--------------060106030907010109030304--

