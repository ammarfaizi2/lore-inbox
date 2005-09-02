Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030642AbVIBB7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbVIBB7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbVIBB7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:59:11 -0400
Received: from fmr22.intel.com ([143.183.121.14]:30154 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030642AbVIBB7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:59:10 -0400
Message-Id: <200509020158.j821wtg00465@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Dave McCracken'" <dmccr@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
Subject: RE: [PATCH 1/1] Implement shared page tables
Date: Thu, 1 Sep 2005 18:58:23 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWtsDj7hT33i8q8RK6wi49tnEe7OABr/mLA
In-Reply-To: <7C49DFF721CB4E671DB260F9@[10.1.1.4]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken wrote on Tuesday, August 30, 2005 3:13 PM
> This patch implements page table sharing for all shared memory regions that
> span an entire page table page.  It supports sharing at multiple page
> levels, depending on the architecture.
> 
> 
> This version of the patch supports i386 and x86_64.  I have additional
> patches to support ppc64, but they are not quite ready for public
> consumption.
> 
>  ....
> +		prio_tree_iter_init(&iter, &mapping->i_mmap,
> +				    vma->vm_start, vma->vm_end);


I think this is a bug.  The radix priority tree for address_space->
i_mmap is keyed on vma->vm_pgoff.  Your patch uses the vma virtual
address to find a shareable range, Which will always fail a match
even though there is one.  The following is a quick hack I did to
make it work.

- Ken

--- linux-2.6.13/mm/ptshare.c.orig	2005-09-01 18:58:12.299321918 -0700
+++ linux-2.6.13/mm/ptshare.c	2005-09-01 18:58:39.846196580 -0700
@@ -26,6 +26,11 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 
+#define RADIX_INDEX(vma)  ((vma)->vm_pgoff)
+#define VMA_SIZE(vma)	  (((vma)->vm_end - (vma)->vm_start) >> PAGE_SHIFT)
+/* avoid overflow */
+#define HEAP_INDEX(vma)	  ((vma)->vm_pgoff + (VMA_SIZE(vma) - 1))
+
 #undef	PT_DEBUG
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -173,7 +178,7 @@ pt_share_pte(struct vm_area_struct *vma,
 		       address);
 #endif
 		prio_tree_iter_init(&iter, &mapping->i_mmap,
-				    vma->vm_start, vma->vm_end);
+				    RADIX_INDEX(vma), HEAP_INDEX(vma));
 
 		while ((svma = next_shareable_vma(vma, svma, &iter))) {
 			spgd = pgd_offset(svma->vm_mm, address);


