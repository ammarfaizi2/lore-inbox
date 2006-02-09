Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWBISyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWBISyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWBISyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:54:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:17289 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750707AbWBISyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:54:32 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Thu, 09 Feb 2006 10:54:18 -0800
Message-Id: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2 01/07] cpuset cleanup not not operators
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Since the test_bit() bit operator is boolean (return 0 or 1),
the double not "!!" operations needed to convert a scalar
(zero or not zero) to a boolean are not needed.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Andrew,

Please drop the patches:

 cpuset-memory-spread-basic-implementation.patch
 cpuset-memory-spread-basic-implementation-fix.patch
 cpuset-memory-spread-page-cache-implementation-and-hooks.patch
 cpuset-memory-spread-slab-cache-implementation.patch
 cpuset-memory-spread-slab-cache-optimizations.patch
 cpuset-memory-spread-slab-cache-optimizations-tidy.patch
 cpuset-memory-spread-slab-cache-hooks.patch

and replace with this patch set:

 [PATCH v2 01/07] cpuset_cleanup_not_not_ops
 [PATCH v2 02/07] cpuset_combine_atomic_inc_calls
 [PATCH v2 03/07] cpuset_mem_spread_new
 [PATCH v2 04/07] cpuset_mem_spread_page_cache
 [PATCH v2 05/07] cpuset_mem_spread_slab_cache
 [PATCH v2 06/07] cpuset_mem_spread_slab_optimize
 [PATCH v2 07/07] cpuset_mem_spread_mark_some_slab_caches

Changes in patch set from first version to this version v2:
 * dropped double not (!!) operators on cpuset flag bit tests
 * use more optimal atomic_inc_return() calls
 * change from one flag for all spreading to two
	flags, one for page cache, one for slab cache
 * change name of easily misused mpol_set_task_struct_flag()
	to less inviting mpol_fix_fork_child_flag(), to minimize
	risk someone will call on another task unsafely.
 * a tidy fix and a missing EXPORT_SYMBOL, thanks to Andrew
 * added xfs slab cache hooks for slab cache memory spreading
 * comment anticipating other file systems may need same hooks
 * further optimize kernel text size, for both NUMA and non-NUMA
	cases of the page_cache_alloc*() memory spreading hooks
 * comment why !in_interrupt() test needed to use memory spreading
 * comment why we dont need to check that node returned from the
	cpuset_mem_spread_node() is online

 kernel/cpuset.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- 2.6.16-rc1-mm5.orig/kernel/cpuset.c	2006-02-06 23:17:44.536051878 -0800
+++ 2.6.16-rc1-mm5/kernel/cpuset.c	2006-02-06 23:37:02.709481506 -0800
@@ -114,27 +114,27 @@ typedef enum {
 /* convenient tests for these bits */
 static inline int is_cpu_exclusive(const struct cpuset *cs)
 {
-	return !!test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+	return test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
 }
 
 static inline int is_mem_exclusive(const struct cpuset *cs)
 {
-	return !!test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
+	return test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
 }
 
 static inline int is_removed(const struct cpuset *cs)
 {
-	return !!test_bit(CS_REMOVED, &cs->flags);
+	return test_bit(CS_REMOVED, &cs->flags);
 }
 
 static inline int notify_on_release(const struct cpuset *cs)
 {
-	return !!test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
+	return test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 }
 
 static inline int is_memory_migrate(const struct cpuset *cs)
 {
-	return !!test_bit(CS_MEMORY_MIGRATE, &cs->flags);
+	return test_bit(CS_MEMORY_MIGRATE, &cs->flags);
 }
 
 /*

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
