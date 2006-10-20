Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWJTOc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWJTOc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWJTOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:32:28 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:20972
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932245AbWJTOc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:32:28 -0400
Date: Fri, 20 Oct 2006 15:31:11 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: Christoph Lameter <clameter@sgi.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Mel Gorman <mel@csn.ul.ie>, Mike Kravetz <kravetz@us.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc
Message-ID: <8a76dfd735e544016c5f04c98617b87d@pinky>
References: <4538DACC.5050605@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <4538DACC.5050605@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reintroduce NODES_SPAN_OTHER_NODES for powerpc

Revert "[PATCH] Remove SPAN_OTHER_NODES config definition"
    This reverts commit f62859bb6871c5e4a8e591c60befc8caaf54db8c.
Revert "[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"
    This reverts commit a94b3ab7eab4edcc9b2cb474b188f774c331adf7.

Also update the comments to indicate that this is still required
and where its used.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8b69104..2bd9b7f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -751,6 +751,15 @@ config ARCH_MEMORY_PROBE
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
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 9828663..d2833c1 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -184,6 +184,7 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_MIGRATION=y
 CONFIG_RESOURCES_64BIT=y
 CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
+CONFIG_NODES_SPAN_OTHER_NODES=y
 # CONFIG_PPC_64K_PAGES is not set
 CONFIG_SCHED_SMT=y
 CONFIG_PROC_DEVICETREE=y
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 59855b8..ed0762b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -674,6 +674,12 @@ #define sparse_init()	do {} while (0)
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 40db96a..57fa189 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1688,6 +1688,8 @@ void __meminit memmap_init_zone(unsigned
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!early_pfn_valid(pfn))
 			continue;
+		if (!early_pfn_in_nid(pfn, nid))
+			continue;
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
 		init_page_count(page);
