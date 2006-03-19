Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWCSI5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCSI5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCSI5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:57:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12929 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751452AbWCSI5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:57:53 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 19 Mar 2006 00:57:49 -0800
Message-Id: <20060319085749.18843.28770.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: don't need to mark cpuset_mems_generation atomic
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Drop the atomic_t marking on the cpuset static global cpuset_mems_generation.
Since all access to it is guarded by the global manage_mutex, there is no
need for further serialization of this value.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

--- 2.6.16-rc6-mm2.orig/kernel/cpuset.c	2006-03-18 21:27:46.629134245 -0800
+++ 2.6.16-rc6-mm2/kernel/cpuset.c	2006-03-18 21:34:04.426490767 -0800
@@ -149,7 +149,7 @@ static inline int is_spread_slab(const s
 }
 
 /*
- * Increment this atomic integer everytime any cpuset changes its
+ * Increment this integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
  * number, and avoid having to lock and reload mems_allowed unless
  * the cpuset they're using changes generation.
@@ -163,8 +163,11 @@ static inline int is_spread_slab(const s
  * on every visit to __alloc_pages(), to efficiently check whether
  * its current->cpuset->mems_allowed has changed, requiring an update
  * of its current->mems_allowed.
+ *
+ * Since cpuset_mems_generation is guarded by manage_mutex,
+ * there is no need to mark it atomic.
  */
-static atomic_t cpuset_mems_generation = ATOMIC_INIT(1);
+static int cpuset_mems_generation;
 
 static struct cpuset top_cpuset = {
 	.flags = ((1 << CS_CPU_EXCLUSIVE) | (1 << CS_MEM_EXCLUSIVE)),
@@ -877,7 +880,7 @@ static int update_nodemask(struct cpuset
 
 	mutex_lock(&callback_mutex);
 	cs->mems_allowed = trialcs.mems_allowed;
-	cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+	cs->mems_generation = cpuset_mems_generation++;
 	mutex_unlock(&callback_mutex);
 
 	set_cpuset_being_rebound(cs);		/* causes mpol_copy() rebind */
@@ -1270,11 +1273,11 @@ static ssize_t cpuset_common_file_write(
 		break;
 	case FILE_SPREAD_PAGE:
 		retval = update_flag(CS_SPREAD_PAGE, cs, buffer);
-		cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+		cs->mems_generation = cpuset_mems_generation++;
 		break;
 	case FILE_SPREAD_SLAB:
 		retval = update_flag(CS_SPREAD_SLAB, cs, buffer);
-		cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+		cs->mems_generation = cpuset_mems_generation++;
 		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
@@ -1823,7 +1826,7 @@ static long cpuset_create(struct cpuset 
 	atomic_set(&cs->count, 0);
 	INIT_LIST_HEAD(&cs->sibling);
 	INIT_LIST_HEAD(&cs->children);
-	cs->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+	cs->mems_generation = cpuset_mems_generation++;
 	fmeter_init(&cs->fmeter);
 
 	cs->parent = parent;
@@ -1913,7 +1916,7 @@ int __init cpuset_init_early(void)
 	struct task_struct *tsk = current;
 
 	tsk->cpuset = &top_cpuset;
-	tsk->cpuset->mems_generation = atomic_inc_return(&cpuset_mems_generation);
+	tsk->cpuset->mems_generation = cpuset_mems_generation++;
 	return 0;
 }
 
@@ -1932,7 +1935,7 @@ int __init cpuset_init(void)
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 
 	fmeter_init(&top_cpuset.fmeter);
-	top_cpuset.mems_generation = atomic_inc_return(&cpuset_mems_generation);
+	top_cpuset.mems_generation = cpuset_mems_generation++;
 
 	init_task.cpuset = &top_cpuset;
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
