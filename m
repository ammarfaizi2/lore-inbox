Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268888AbUHLXrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268888AbUHLXrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUHLXrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:47:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12928 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268888AbUHLXrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:47:15 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] allocate page caches pages in round robin fasion
Date: Thu, 12 Aug 2004 16:46:50 -0700
User-Agent: KMail/1.6.2
Cc: steiner@sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qFAHB0vSwnhkh0f"
Message-Id: <200408121646.50740.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_qFAHB0vSwnhkh0f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[ugg, attach the patch this time]

On a NUMA machine, page cache pages should be spread out across the system 
since they're generally global in nature and can eat up whole nodes worth of 
memory otherwise.  This can end up hurting performance since jobs will have 
to make off node references for much or all of their non-file data.

The patch works by adding an alloc_page_round_robin routine that simply 
allocates on successive nodes each time its called, based on the value of a 
per-cpu variable modulo the number of nodes.  The variable is per-cpu to 
avoid cacheline contention when many cpus try to do page cache allocations at 
once.

After dd if=/dev/zero of=/tmp/bigfile bs=1G count=2 on a stock kernel:
Node 7 MemUsed:         49248 kB
Node 6 MemUsed:         42176 kB
Node 5 MemUsed:        316880 kB
Node 4 MemUsed:         36160 kB
Node 3 MemUsed:         45152 kB
Node 2 MemUsed:         50000 kB
Node 1 MemUsed:         68704 kB
Node 0 MemUsed:       2426256 kB

and after the patch:
Node 7 MemUsed:        328608 kB
Node 6 MemUsed:        319424 kB
Node 5 MemUsed:        318608 kB
Node 4 MemUsed:        321600 kB
Node 3 MemUsed:        319648 kB
Node 2 MemUsed:        327504 kB
Node 1 MemUsed:        389504 kB
Node 0 MemUsed:        744752 kB

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_qFAHB0vSwnhkh0f
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="page-cache-round-robin-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="page-cache-round-robin-3.patch"

===== include/linux/gfp.h 1.18 vs edited =====
--- 1.18/include/linux/gfp.h	2004-05-22 14:56:25 -07:00
+++ edited/include/linux/gfp.h	2004-08-12 16:27:01 -07:00
@@ -86,6 +86,8 @@
 		NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+extern struct page *alloc_page_round_robin(unsigned int gfp_mask);
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(unsigned gfp_mask, unsigned order);
 
===== include/linux/pagemap.h 1.43 vs edited =====
--- 1.43/include/linux/pagemap.h	2004-06-24 01:55:57 -07:00
+++ edited/include/linux/pagemap.h	2004-08-12 14:37:36 -07:00
@@ -52,12 +52,12 @@
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(mapping_gfp_mask(x), 0);
+	return alloc_page_round_robin(mapping_gfp_mask(x));
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
 {
-	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
+	return alloc_page_round_robin(mapping_gfp_mask(x)|__GFP_COLD);
 }
 
 typedef int filler_t(void *, struct page *);
===== mm/page_alloc.c 1.224 vs edited =====
--- 1.224/mm/page_alloc.c	2004-08-07 23:43:41 -07:00
+++ edited/mm/page_alloc.c	2004-08-12 16:27:43 -07:00
@@ -31,6 +31,7 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/percpu.h>
 
 #include <asm/tlbflush.h>
 
@@ -41,6 +42,7 @@
 long nr_swap_pages;
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
+static DEFINE_PER_CPU(int, next_rr_node);
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -577,6 +579,23 @@
 	}
 	return page;
 }
+
+/**
+ * alloc_page_round_robin - distribute pages across nodes
+ * @gfp_mask: GFP_* flags
+ *
+ * alloc_page_round_robin() will simply allocate from a different node
+ * than was allocated from in the last call using the next_rr_node variable.
+ * We use __get_cpu_var since we don't care about disabling preemption (we're
+ * using a mod function so nid will always be less than numnodes).  A per-cpu
+ * variable will make round robin allocations scale a bit better.
+ */
+struct page *alloc_page_round_robin(unsigned int gfp_mask)
+{
+	return alloc_pages_node(__get_cpu_var(next_rr_node)++ % numnodes,
+				gfp_mask, 0);
+}
+
 
 /*
  * This is the 'heart' of the zoned buddy allocator.

--Boundary-00=_qFAHB0vSwnhkh0f--
