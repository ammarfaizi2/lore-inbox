Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUJZCED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUJZCED (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUJZCC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:02:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11152 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261900AbUJZBbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:31:53 -0400
Date: Mon, 25 Oct 2004 18:31:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V2 [7/8]: sh64 arch modifications
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410251830370.12962@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Provide huge_update_mmu_cache through update_mmu_cache (which is just counting
	  the number of calls)
	* Extend flush_dcache_page to handle compound pages
	* Not build and not tested


Index: linux-2.6.9/include/asm-sh64/pgtable.h
===================================================================
--- linux-2.6.9.orig/include/asm-sh64/pgtable.h	2004-10-21 12:01:24.000000000 -0700
+++ linux-2.6.9/include/asm-sh64/pgtable.h	2004-10-25 14:55:29.000000000 -0700
@@ -462,6 +462,7 @@

 extern void update_mmu_cache(struct vm_area_struct * vma,
 			     unsigned long address, pte_t pte);
+#define huge_update_mmu_cache update_mmu_cache

 /* Encode and decode a swap entry */
 #define __swp_type(x)			(((x).val & 3) + (((x).val >> 1) & 0x3c))
Index: linux-2.6.9/arch/sh64/mm/cache.c
===================================================================
--- linux-2.6.9.orig/arch/sh64/mm/cache.c	2004-10-25 15:02:58.000000000 -0700
+++ linux-2.6.9/arch/sh64/mm/cache.c	2004-10-25 15:03:16.000000000 -0700
@@ -990,7 +990,16 @@

 void flush_dcache_page(struct page *page)
 {
-	sh64_dcache_purge_phy_page(page_to_phys(page));
+	if (likely(!PageCompound))
+		sh64_dcache_purge_phy_page(page_to_phys(page));
+	else {
+		int nr;
+
+		page = page->private;
+		nr = 1 << page[1].index;
+		while (nr--)
+			sh64_dcache_purge_phy_page(page_to_phys(page++));
+	}
 	wmb();
 }


