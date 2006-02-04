Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946331AbWBDHTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946331AbWBDHTu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946326AbWBDHT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:19:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15498 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946327AbWBDHT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:19:27 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Fri, 03 Feb 2006 23:19:21 -0800
Message-Id: <20060204071921.10021.83884.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 3/5] cpuset memory spread slab cache implementation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Provide the slab cache infrastructure to support cpuset memory
spreading.

See the previous patches, cpuset_mem_spread, for an explanation
of cpuset memory spreading.

This patch provides a slab cache SLAB_MEM_SPREAD flag.  If set
in the kmem_cache_create() call defining a slab cache, then
any task marked with the process state flag PF_MEMSPREAD will
spread memory page allocations for that cache over all the
allowed nodes, instead of preferring the local (faulting) node.

On systems not configured with CONFIG_NUMA, this results in no
change to the page allocation code path for slab caches.

On systems with cpusets configured in the kernel, but the
"memory_spread" cpuset option not enabled for the current tasks
cpuset, this adds one failed bit test of the processor state
flag PF_MEM_SPREAD on each page allocation for slab caches.

For tasks so marked, a second inline test is done for the
slab cache flag SLAB_MEM_SPREAD, and if that is set and if
the allocation is not in_interrupt(), this adds a call to to a
cpuset routine that computes which of the tasks mems_allowed
nodes should be preferred for this allocation.

==> This patch adds another hook into the performance critical
    code path to allocating objects from the slab cache, in the
    ____cache_alloc() chunk, below.  The next patch optimizes this
    hook, reducing the impact of the combined mempolicy plus memory
    spreading hooks on this critical code path to a single check
    against the tasks task_struct flags word.

This patch provides the generic slab flags and logic needed to
apply memory spreading to a particular slab.

A subsequent patch will mark a few specific slab caches for this
placement policy.

Signed-off-by: Paul Jackson

---

 include/linux/slab.h |    1 +
 mm/slab.c            |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

--- 2.6.16-rc1-mm5.orig/include/linux/slab.h	2006-02-03 22:17:31.772404695 -0800
+++ 2.6.16-rc1-mm5/include/linux/slab.h	2006-02-03 22:17:33.545862215 -0800
@@ -47,6 +47,7 @@ typedef struct kmem_cache kmem_cache_t;
 						   what is reclaimable later*/
 #define SLAB_PANIC		0x00040000UL	/* panic if kmem_cache_create() fails */
 #define SLAB_DESTROY_BY_RCU	0x00080000UL	/* defer freeing pages to RCU */
+#define SLAB_MEM_SPREAD		0x00100000UL	/* Spread some memory over cpuset */
 
 /* flags passed to a constructor func */
 #define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
--- 2.6.16-rc1-mm5.orig/mm/slab.c	2006-02-03 22:17:31.772404695 -0800
+++ 2.6.16-rc1-mm5/mm/slab.c	2006-02-03 22:17:33.549768509 -0800
@@ -94,6 +94,7 @@
 #include	<linux/interrupt.h>
 #include	<linux/init.h>
 #include	<linux/compiler.h>
+#include	<linux/cpuset.h>
 #include	<linux/seq_file.h>
 #include	<linux/notifier.h>
 #include	<linux/kallsyms.h>
@@ -173,12 +174,12 @@
 			 SLAB_NO_REAP | SLAB_CACHE_DMA | \
 			 SLAB_MUST_HWCACHE_ALIGN | SLAB_STORE_USER | \
 			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
-			 SLAB_DESTROY_BY_RCU)
+			 SLAB_DESTROY_BY_RCU | SLAB_MEM_SPREAD)
 #else
 # define CREATE_MASK	(SLAB_HWCACHE_ALIGN | SLAB_NO_REAP | \
 			 SLAB_CACHE_DMA | SLAB_MUST_HWCACHE_ALIGN | \
 			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
-			 SLAB_DESTROY_BY_RCU)
+			 SLAB_DESTROY_BY_RCU | SLAB_MEM_SPREAD)
 #endif
 
 /*
@@ -2708,6 +2709,14 @@ static inline void *____cache_alloc(stru
 		if (nid != numa_node_id())
 			return __cache_alloc_node(cachep, flags, nid);
 	}
+	if (unlikely(cpuset_mem_spread_check() &&
+					(cachep->flags & SLAB_MEM_SPREAD) &&
+					!in_interrupt())) {
+		int nid = cpuset_mem_spread_node();
+
+		if (nid != numa_node_id())
+			return __cache_alloc_node(cachep, flags, nid);
+	}
 #endif
 
 	check_irq_off();

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
