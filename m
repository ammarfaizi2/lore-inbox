Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946560AbWKAFr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946560AbWKAFr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946553AbWKAFrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:47:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27817 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946560AbWKAFrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:47:22 -0500
Message-Id: <20061101054454.696256000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Andy Whitcroft <apw@shadowen.org>,
       Paul Mackerras <paulus@samba.org>, Mike Kravetz <kravetz@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mel Gorman <mel@csn.ul.ie>, Will Schmidt <will_schmidt@vnet.ibm.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 52/61] Reintroduce NODES_SPAN_OTHER_NODES for powerpc
Content-Disposition: inline; filename=reintroduce-nodes_span_other_nodes-for-powerpc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andy Whitcroft <apw@shadowen.org>

Revert "[PATCH] Remove SPAN_OTHER_NODES config definition"
    This reverts commit f62859bb6871c5e4a8e591c60befc8caaf54db8c.
Revert "[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"
    This reverts commit a94b3ab7eab4edcc9b2cb474b188f774c331adf7.

Also update the comments to indicate that this is still required
and where its used.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Mel Gorman <mel@csn.ul.ie>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/powerpc/Kconfig                   |    9 +++++++++
 arch/powerpc/configs/pseries_defconfig |    1 +
 include/linux/mmzone.h                 |    6 ++++++
 mm/page_alloc.c                        |    2 ++
 4 files changed, 18 insertions(+)

--- linux-2.6.18.1.orig/arch/powerpc/Kconfig
+++ linux-2.6.18.1/arch/powerpc/Kconfig
@@ -729,6 +729,15 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+# Some NUMA nodes have memory ranges that span
+# other nodes.  Even though a pfn is valid and
+# between a node's start and end pfns, it may not
+# reside on that node.  See memmap_init_zone()
+# for details.
+config NODES_SPAN_OTHER_NODES
+	def_bool y
+	depends on NEED_MULTIPLE_NODES
+
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on PPC64
--- linux-2.6.18.1.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-2.6.18.1/arch/powerpc/configs/pseries_defconfig
@@ -184,6 +184,7 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
 CONFIG_RESOURCES_64BIT=y
 CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
+CONFIG_NODES_SPAN_OTHER_NODES=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
--- linux-2.6.18.1.orig/include/linux/mmzone.h
+++ linux-2.6.18.1/include/linux/mmzone.h
@@ -632,6 +632,12 @@ void sparse_init(void);
 #define sparse_index_init(_sec, _nid)  do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
+#ifdef CONFIG_NODES_SPAN_OTHER_NODES
+#define early_pfn_in_nid(pfn, nid)	(early_pfn_to_nid(pfn) == (nid))
+#else
+#define early_pfn_in_nid(pfn, nid)	(1)
+#endif
+
 #ifndef early_pfn_valid
 #define early_pfn_valid(pfn)	(1)
 #endif
--- linux-2.6.18.1.orig/mm/page_alloc.c
+++ linux-2.6.18.1/mm/page_alloc.c
@@ -1673,6 +1673,8 @@ void __meminit memmap_init_zone(unsigned
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!early_pfn_valid(pfn))
 			continue;
+		if (!early_pfn_in_nid(pfn, nid))
+			continue;
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
 		init_page_count(page);

--
