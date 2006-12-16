Return-Path: <linux-kernel-owner+w=401wt.eu-S1030770AbWLPIbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030770AbWLPIbb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030774AbWLPIbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:31:31 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:44197 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030770AbWLPIba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:31:30 -0500
Date: Sat, 16 Dec 2006 17:34:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, clameter@engr.sgi.com,
       apw@shadowen.org, heiko.carstens@de.ibm.com, bob.picco@hp.com
Subject: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid()
 [1/2] generic arch.
Message-Id: <20061216173432.8d2cf0b0.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for implementing optimized pfn_valid() for sparsemem_vmemmap.
By this, we can avoid accessing mem_section[] in usual codes.
(memory hotplug will access it.)

This patch checks vmem_map is mapped or not by get_user().
If fault, pfn is not valid.

Because sparsemem_vmemmap's virtual mem_map per section is always aligned to
PAGE_SIZE, pfn_valid(pfn) can assume a whole struct page is fully mapped.
So it only access the first byte.

How to use:
 1. set ARCH_SPARSEMEM_VMEMMAP_OPT_PFNVALID config in arch/Kconfig
 2. modify page fault handler in each arch to handle fault in mem_map range.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/mmzone.h |   10 ++++++++++
 mm/Kconfig             |    4 ++++
 mm/sparse.c            |    7 +++++++
 3 files changed, 21 insertions(+)

Index: devel-2.6.20-rc1-mm1/include/linux/mmzone.h
===================================================================
--- devel-2.6.20-rc1-mm1.orig/include/linux/mmzone.h	2006-12-16 13:48:52.000000000 +0900
+++ devel-2.6.20-rc1-mm1/include/linux/mmzone.h	2006-12-16 14:43:08.000000000 +0900
@@ -752,12 +752,22 @@
 	return __nr_to_section(pfn_to_section_nr(pfn));
 }
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP_OPT_PFNVALID
+extern int vmemmap_test_valid(struct page *pg);
+static inline int pfn_valid(unsigned long pfn)
+{
+	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
+		return 0;
+	return vmemmap_test_valid(pfn_to_page(pfn));
+}
+#else
 static inline int pfn_valid(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
+#endif
 
 /*
  * These are _only_ used during initialisation, therefore they
Index: devel-2.6.20-rc1-mm1/mm/Kconfig
===================================================================
--- devel-2.6.20-rc1-mm1.orig/mm/Kconfig	2006-12-16 13:48:53.000000000 +0900
+++ devel-2.6.20-rc1-mm1/mm/Kconfig	2006-12-16 13:52:06.000000000 +0900
@@ -125,6 +125,10 @@
 	def_bool y
 	depends on ARCH_SPARSEMEM_VMEMMAP_STATIC
 
+config SPARSEMEM_VMEMMAP_OPT_PFNVALID
+	def_bool y
+	depends on SPARSEMEM_VMEMMAP && ARCH_SPARSEMEM_VMEMMAP_OPT_PFN_VALID
+
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
Index: devel-2.6.20-rc1-mm1/mm/sparse.c
===================================================================
--- devel-2.6.20-rc1-mm1.orig/mm/sparse.c	2006-12-16 13:48:53.000000000 +0900
+++ devel-2.6.20-rc1-mm1/mm/sparse.c	2006-12-16 14:03:41.000000000 +0900
@@ -108,6 +108,13 @@
 	int nid;
 };
 
+int vmemmap_test_valid(struct page *pg)
+{
+	char byte;
+	/* vmemmap per section is always aligned to PAGE_SIZE */
+	return (__get_user(byte, (char __user *)pg) == 0);
+}
+
 /* call backs for memory map */
 static int
 __init pte_alloc_vmemmap_boot(pmd_t *pmd, unsigned long addr, void *data)

