Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946323AbWBDHT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946323AbWBDHT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946326AbWBDHT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:19:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13962 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946323AbWBDHT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:19:26 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Fri, 03 Feb 2006 23:19:15 -0800
Message-Id: <20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 2/5] cpuset memory spread page cache implementation and hooks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Change the page cache allocation calls to support cpuset memory
spreading.

See the previous patch, cpuset_mem_spread, for an explanation
of cpuset memory spreading.

On systems without cpusets configured in the kernel, this is
no change.

On systems with cpusets configured in the kernel, but the
"memory_spread" cpuset option not enabled for the current tasks
cpuset, this adds one failed bit test of the processor state
flag PF_MEM_SPREAD.

On tasks in cpusets with "memory_spread" enabled, this adds
a call to a cpuset routine that computes which of the tasks
mems_allowed nodes should be preferred for this allocation.

If memory spreading applies to a particular allocation, then
any other NUMA mempolicy does not apply.

Signed-off-by: Paul Jackson

---

 include/linux/pagemap.h |    9 +++++++++
 1 files changed, 9 insertions(+)

--- 2.6.16-rc1-mm3.orig/include/linux/pagemap.h	2006-01-31 08:55:27.238487776 -0800
+++ 2.6.16-rc1-mm3/include/linux/pagemap.h	2006-01-31 08:58:25.459267700 -0800
@@ -10,6 +10,7 @@
 #include <linux/highmem.h>
 #include <linux/compiler.h>
 #include <asm/uaccess.h>
+#include <linux/cpuset.h>
 #include <linux/gfp.h>
 
 /*
@@ -53,11 +54,19 @@ void release_pages(struct page **pages, 
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
+	if (cpuset_mem_spread_check()) {
+		int n = cpuset_mem_spread_node();
+		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
+	}
 	return alloc_pages(mapping_gfp_mask(x), 0);
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
 {
+	if (cpuset_mem_spread_check()) {
+		int n = cpuset_mem_spread_node();
+		return alloc_pages_node(n, mapping_gfp_mask(x)|__GFP_COLD, 0);
+	}
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
 }
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
