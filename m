Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWBISzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWBISzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWBISyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:54:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27273 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750709AbWBISym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:54:42 -0500
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       clameter@sgi.com
Date: Thu, 09 Feb 2006 10:54:35 -0800
Message-Id: <20060209185435.8596.68760.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
References: <20060209185418.8596.90838.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2 04/07] cpuset memory spread page cache implementation and hooks
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
cpuset, this adds a call to a cpuset routine and failed bit
test of the processor state flag PF_SPREAD_PAGE.

On tasks in cpusets with "memory_spread" enabled, this adds
a call to a cpuset routine that computes which of the tasks
mems_allowed nodes should be preferred for this allocation.

If memory spreading applies to a particular allocation, then
any other NUMA mempolicy does not apply.

Signed-off-by: Paul Jackson

---

 include/linux/pagemap.h |    5 +++++
 mm/filemap.c            |   23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

--- v2.6.16-rc2.orig/include/linux/pagemap.h	2006-02-08 22:46:56.000000000 -0800
+++ v2.6.16-rc2/include/linux/pagemap.h	2006-02-08 22:47:04.000000000 -0800
@@ -51,6 +51,10 @@ static inline void mapping_set_gfp_mask(
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+#ifdef CONFIG_NUMA
+extern struct page *page_cache_alloc(struct address_space *x);
+extern struct page *page_cache_alloc_cold(struct address_space *x);
+#else
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(mapping_gfp_mask(x), 0);
@@ -60,6 +64,7 @@ static inline struct page *page_cache_al
 {
 	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
 }
+#endif
 
 typedef int filler_t(void *, struct page *);
 
--- v2.6.16-rc2.orig/mm/filemap.c	2006-02-08 22:46:56.000000000 -0800
+++ v2.6.16-rc2/mm/filemap.c	2006-02-08 22:47:04.000000000 -0800
@@ -30,6 +30,7 @@
 #include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/cpuset.h>
 #include "filemap.h"
 /*
  * FIXME: remove all knowledge of the buffer layer from the core VM
@@ -425,6 +426,28 @@ int add_to_page_cache_lru(struct page *p
 	return ret;
 }
 
+#ifdef CONFIG_NUMA
+struct page *page_cache_alloc(struct address_space *x)
+{
+	if (cpuset_do_page_mem_spread()) {
+		int n = cpuset_mem_spread_node();
+		return alloc_pages_node(n, mapping_gfp_mask(x), 0);
+	}
+	return alloc_pages(mapping_gfp_mask(x), 0);
+}
+EXPORT_SYMBOL(page_cache_alloc);
+
+struct page *page_cache_alloc_cold(struct address_space *x)
+{
+	if (cpuset_do_page_mem_spread()) {
+		int n = cpuset_mem_spread_node();
+		return alloc_pages_node(n, mapping_gfp_mask(x)|__GFP_COLD, 0);
+	}
+	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
+}
+EXPORT_SYMBOL(page_cache_alloc_cold);
+#endif
+
 /*
  * In order to wait for pages to become available there must be
  * waitqueues associated with pages. By using a hash table of

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
