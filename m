Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWHPWQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWHPWQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWHPWQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:16:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:61140 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750730AbWHPWQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:16:18 -0400
Date: Wed, 16 Aug 2006 15:16:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <44E344A8.1040804@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608161515110.18878@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <44E344A8.1040804@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Manfred Spraul wrote:

> The lack of virt_to_page() on vmalloc/mempool memory. always prevented the
> slab allocator from handling such memory.

Guess you need this patch for the slabifier to make it work:

Index: linux-2.6.18-rc4/mm/slabifier.c
===================================================================
--- linux-2.6.18-rc4.orig/mm/slabifier.c	2006-08-16 14:25:18.449419152 -0700
+++ linux-2.6.18-rc4/mm/slabifier.c	2006-08-16 15:13:18.687428561 -0700
@@ -638,7 +638,12 @@ static struct page *get_object_page(cons
 {
 	struct page * page;
 
-	page = virt_to_page(x);
+	if ((unsigned long)x >= VMALLOC_START &&
+			(unsigned long)x < VMALLOC_END)
+		page = vmalloc_to_page(x);
+	else
+		page = virt_to_page(x);
+
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
 
Index: linux-2.6.18-rc4/mm/memory.c
===================================================================
--- linux-2.6.18-rc4.orig/mm/memory.c	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/mm/memory.c	2006-08-16 15:14:01.595912665 -0700
@@ -2432,7 +2432,7 @@ int make_pages_present(unsigned long add
 /* 
  * Map a vmalloc()-space virtual address to the physical page.
  */
-struct page * vmalloc_to_page(void * vmalloc_addr)
+struct page * vmalloc_to_page(const void * vmalloc_addr)
 {
 	unsigned long addr = (unsigned long) vmalloc_addr;
 	struct page *page = NULL;
Index: linux-2.6.18-rc4/include/linux/mm.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/mm.h	2006-08-06 11:20:11.000000000 -0700
+++ linux-2.6.18-rc4/include/linux/mm.h	2006-08-16 15:14:25.875663886 -0700
@@ -1013,7 +1013,7 @@ static inline unsigned long vma_pages(st
 }
 
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
-struct page *vmalloc_to_page(void *addr);
+struct page *vmalloc_to_page(const void *addr);
 unsigned long vmalloc_to_pfn(void *addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
