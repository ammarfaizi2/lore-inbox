Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVCYUrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVCYUrX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCYUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:46:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:62359 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261795AbVCYUoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:44:10 -0500
Subject: resubmit - [PATCH 4/4] sparsemem base: teach discontig about sparse ranges
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Mar 2005 12:44:06 -0800
Message-Id: <E1DEvf5-0004f5-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


discontig.c has some assumptions that mem_map[]s inside of a node are
contiguous.  Teach it to make sure that each region that it's brining
online is actually made up of valid ranges of ram.

Written-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/discontig.c |   14 ++++++++++++++
 memhotplug-dave/arch/i386/mm/init.c      |    2 +-
 memhotplug-dave/include/asm-i386/page.h  |    2 ++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff -puN arch/i386/mm/discontig.c~FROM-MM-validate-remap-pages arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~FROM-MM-validate-remap-pages	2005-03-25 08:17:10.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-03-25 08:17:10.000000000 -0800
@@ -185,6 +185,7 @@ static unsigned long calculate_numa_rema
 {
 	int nid;
 	unsigned long size, reserve_pages = 0;
+	unsigned long pfn;
 
 	for_each_online_node(nid) {
 		if (nid == 0)
@@ -208,6 +209,19 @@ static unsigned long calculate_numa_rema
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
 		size = size * PTRS_PER_PTE;
+
+		/*
+		 * Validate the region we are allocating only contains valid
+		 * pages.
+		 */
+		for (pfn = node_end_pfn[nid] - size;
+		     pfn < node_end_pfn[nid]; pfn++)
+			if (!page_is_ram(pfn))
+				break;
+
+		if (pfn != node_end_pfn[nid])
+			size = 0;
+
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
diff -puN arch/i386/mm/init.c~FROM-MM-validate-remap-pages arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~FROM-MM-validate-remap-pages	2005-03-25 08:17:10.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-03-25 08:17:10.000000000 -0800
@@ -191,7 +191,7 @@ static inline int page_kills_ppro(unsign
 
 extern int is_available_memory(efi_memory_desc_t *);
 
-static inline int page_is_ram(unsigned long pagenr)
+int page_is_ram(unsigned long pagenr)
 {
 	int i;
 	unsigned long addr, end;
diff -puN include/asm-i386/page.h~FROM-MM-validate-remap-pages include/asm-i386/page.h
--- memhotplug/include/asm-i386/page.h~FROM-MM-validate-remap-pages	2005-03-25 08:17:10.000000000 -0800
+++ memhotplug-dave/include/asm-i386/page.h	2005-03-25 08:17:10.000000000 -0800
@@ -119,6 +119,8 @@ static __inline__ int get_order(unsigned
 
 extern int sysctl_legacy_va_layout;
 
+extern int page_is_ram(unsigned long pagenr);
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
_
