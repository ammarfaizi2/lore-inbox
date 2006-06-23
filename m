Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161466AbWFWAeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161466AbWFWAeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbWFWAeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:34:09 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:56302 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1161466AbWFWAeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:34:08 -0400
Date: Thu, 22 Jun 2006 17:34:35 -0700 (PDT)
Message-Id: <200606230034.k5N0YZhE026697@calaveras.llnl.gov>
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, garlick@llnl.gov, mgrondona@llnl.gov, dsp@llnl.gov
Subject: [PATCH (repost #1)] mm: avoid unnecessary OOM kills
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a 2.6.17.1 patch that fixes a problem where the OOM killer was
unnecessarily killing system daemons in addition to memory-hogging user
processes.  The patch fixes things so that the following assertion is
satisfied:

    If a failed attempt to allocate memory triggers the OOM killer, then the
    failed attempt must have occurred _after_ any process previously shot by
    the OOM killer has cleaned out its mm_struct.

Thus we avoid situations where concurrent invocations of the OOM killer cause
more processes to be shot than necessary to resolve the OOM condition.

Signed-Off-By: David S. Peterson <dsp@llnl.gov>
---
Andrew Morton asked me to periodically repost this patch until he gets a
chance to take a closer look at it.


diff -urNp -X dontdiff linux-2.6.17.1/mm/oom_kill.c linux-2.6.17.1-oom/mm/oom_kill.c
--- linux-2.6.17.1/mm/oom_kill.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-oom/mm/oom_kill.c	2006-06-22 16:12:43.000000000 -0700
@@ -24,6 +24,23 @@
 
 /* #define DEBUG */
 
+/* Return 1 if OOM kill in progress.  Else return 0. */
+int oom_kill_active(void)
+{
+	task_t *p, *q;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(p, q) {
+		if (test_tsk_thread_flag(q, TIF_MEMDIE)) {
+			read_unlock(&tasklist_lock);
+			return 1;
+		}
+	} while_each_thread(p, q);
+	read_unlock(&tasklist_lock);
+
+	return 0;
+}
+
 /**
  * oom_badness - calculate a numeric value for how bad this task has been
  * @p: task struct of which task we should calculate
@@ -317,6 +334,7 @@ void out_of_memory(struct zonelist *zone
 {
 	task_t *p;
 	unsigned long points = 0;
+	const char *msg = NULL;
 
 	if (printk_ratelimit()) {
 		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
@@ -334,17 +352,16 @@ void out_of_memory(struct zonelist *zone
 	 */
 	switch (constrained_alloc(zonelist, gfp_mask)) {
 	case CONSTRAINT_MEMORY_POLICY:
-		oom_kill_process(current, points,
-				"No available memory (MPOL_BIND)");
+		p = current;
+		msg = "No available memory (MPOL_BIND)";
 		break;
 
 	case CONSTRAINT_CPUSET:
-		oom_kill_process(current, points,
-				"No available memory in cpuset");
+		p = current;
+		msg = "No available memory in cpuset";
 		break;
 
 	case CONSTRAINT_NONE:
-retry:
 		/*
 		 * Rambo mode: Shoot down a process and hope it solves whatever
 		 * issues we may have.
@@ -361,20 +378,16 @@ retry:
 			panic("Out of memory and no killable processes...\n");
 		}
 
-		if (oom_kill_process(p, points, "Out of memory"))
-			goto retry;
-
+		msg = "Out of memory";
 		break;
+
+	default:
+		BUG();
 	}
 
+	oom_kill_process(p, points, msg);
+
 out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
-
-	/*
-	 * Give "p" a good chance of killing itself before we
-	 * retry to allocate memory unless "p" is current
-	 */
-	if (!test_thread_flag(TIF_MEMDIE))
-		schedule_timeout_uninterruptible(1);
 }
diff -urNp -X dontdiff linux-2.6.17.1/mm/page_alloc.c linux-2.6.17.1-oom/mm/page_alloc.c
--- linux-2.6.17.1/mm/page_alloc.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1-oom/mm/page_alloc.c	2006-06-22 16:08:36.000000000 -0700
@@ -919,6 +919,56 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	return page;
 }
 
+int oom_kill_active(void);
+
+/* If an OOM kill is not already in progress, try once more to allocate
+ * memory.  If allocation fails this time, invoke the OOM killer.
+ */
+static struct page * oom_alloc(gfp_t gfp_mask, unsigned int order,
+		struct zonelist *zonelist)
+{
+	static DECLARE_MUTEX(sem);
+	struct page *page;
+
+	down(&sem);
+
+	/* Prevent parallel OOM kill operations.  This fixes a problem where
+	 * the OOM killer was observed shooting system daemons in addition to
+	 * memory-hogging user processes.
+	 */
+	if (oom_kill_active()) {
+		up(&sem);
+		goto out_sleep;
+	}
+
+	/* If we get here, we _know_ that any previous OOM killer victim has
+	 * cleaned out its mm_struct.  Therefore we should pick a victim to
+	 * shoot if this allocation fails.
+	 */
+	page = get_page_from_freelist(gfp_mask | __GFP_HARDWALL, order,
+				zonelist, ALLOC_WMARK_HIGH | ALLOC_CPUSET);
+
+	if (page) {
+		up(&sem);
+		return page;
+	}
+
+	/* Try to shoot a process. */
+	out_of_memory(zonelist, gfp_mask, order);
+	up(&sem);
+
+out_sleep:
+	/* Did we get shot by the OOM killer?  If not, sleep for a while to
+	 * avoid burning lots of CPU cycles looping in the memory allocator.
+	 * If the OOM killer shot a process, this gives the victim a good
+	 * chance to die before we retry allocation.
+	 */
+	if (!test_thread_flag(TIF_MEMDIE))
+		schedule_timeout_uninterruptible(1);
+
+	return NULL;
+}
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -1030,18 +1080,9 @@ rebalance:
 		if (page)
 			goto got_pg;
 	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
-		/*
-		 * Go through the zonelist yet one more time, keep
-		 * very high watermark here, this is only to catch
-		 * a parallel oom killing, we must fail if we're still
-		 * under heavy pressure.
-		 */
-		page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
-				zonelist, ALLOC_WMARK_HIGH|ALLOC_CPUSET);
+		page = oom_alloc(gfp_mask, order, zonelist);
 		if (page)
 			goto got_pg;
-
-		out_of_memory(zonelist, gfp_mask, order);
 		goto restart;
 	}
 
