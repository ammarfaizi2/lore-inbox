Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUIYHtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUIYHtv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbUIYHtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:49:51 -0400
Received: from holomorphy.com ([207.189.100.168]:63461 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269262AbUIYHtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:49:20 -0400
Date: Sat, 25 Sep 2004 00:49:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 2/6] convert references to remap_page_range() under arch/ and Documentation/ to remap_pfn_range()
Message-ID: <20040925074915.GF9106@holomorphy.com>
References: <20040925074445.GD9106@holomorphy.com> <20040925074712.GE9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925074712.GE9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:47:12AM -0700, William Lee Irwin III wrote:
> This patch introduces remap_pfn_range(), destined to replace
> remap_page_range(), to which all callers of remap_page_range() are
> converted in the sequel.

This patch converts all callers of remap_page_range() under arch/ and
all references in Documentation/ to use remap_pfn_range().


Index: mm3-2.6.9-rc2/Documentation/IO-mapping.txt
===================================================================
--- mm3-2.6.9-rc2.orig/Documentation/IO-mapping.txt	2004-09-25 00:15:53.427650272 -0700
+++ mm3-2.6.9-rc2/Documentation/IO-mapping.txt	2004-09-25 00:18:07.631248224 -0700
@@ -119,9 +119,10 @@
 So why do we care about the physical address at all? We do need the physical
 address in some cases, it's just not very often in normal code.  The physical
 address is needed if you use memory mappings, for example, because the
-"remap_page_range()" mm function wants the physical address of the memory to
-be remapped (the memory management layer doesn't know about devices outside
-the CPU, so it shouldn't need to know about "bus addresses" etc). 
+"remap_pfn_range()" mm function wants the physical address of the memory to
+be remapped as measured in units of pages, a.k.a. the pfn (the memory
+management layer doesn't know about devices outside the CPU, so it
+shouldn't need to know about "bus addresses" etc). 
 
 NOTE NOTE NOTE! The above is only one part of the whole equation. The above
 only talks about "real memory", that is, CPU memory (RAM). 
Index: mm3-2.6.9-rc2/arch/arm/kernel/bios32.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/arm/kernel/bios32.c	2004-09-25 00:15:54.976414824 -0700
+++ mm3-2.6.9-rc2/arch/arm/kernel/bios32.c	2004-09-25 00:16:18.612821544 -0700
@@ -685,7 +685,7 @@
 	if (mmap_state == pci_mmap_io) {
 		return -EINVAL;
 	} else {
-		phys = root->mem_offset + (vma->vm_pgoff << PAGE_SHIFT);
+		phys = vma->vm_pgoff + (root->mem_offset >> PAGE_SHIFT);
 	}
 
 	/*
@@ -694,7 +694,7 @@
 	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_page_range(vma, vma->vm_start, phys,
+	if (remap_pfn_range(vma, vma->vm_start, phys,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
Index: mm3-2.6.9-rc2/arch/i386/pci/i386.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/i386/pci/i386.c	2004-09-25 00:15:55.127391872 -0700
+++ mm3-2.6.9-rc2/arch/i386/pci/i386.c	2004-09-25 00:16:24.702895712 -0700
@@ -295,7 +295,7 @@
 	/* Write-combine setting is ignored, it is changed via the mtrr
 	 * interfaces on this platform.
 	 */
-	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
Index: mm3-2.6.9-rc2/arch/ia64/kernel/perfmon.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/ia64/kernel/perfmon.c	2004-09-25 00:15:54.808440360 -0700
+++ mm3-2.6.9-rc2/arch/ia64/kernel/perfmon.c	2004-09-25 00:16:29.823117320 -0700
@@ -572,12 +572,6 @@
 	ClearPageReserved(vmalloc_to_page((void*)a));
 }
 
-static inline int
-pfm_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long phys_addr, unsigned long size, pgprot_t prot)
-{
-	return remap_page_range(vma, from, phys_addr, size, prot);
-}
-
 static inline unsigned long
 pfm_protect_ctx_ctxsw(pfm_context_t *x)
 {
@@ -805,18 +799,6 @@
 	DPRINT(("ctx=%p msgq reset\n", ctx));
 }
 
-
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
- */
-static inline unsigned long
-pfm_kvirt_to_pa(unsigned long adr)
-{
-	__u64 pa = ia64_tpa(adr);
-	return pa;
-}
-
 static void *
 pfm_rvmalloc(unsigned long size)
 {
@@ -2243,14 +2225,14 @@
 static int
 pfm_remap_buffer(struct vm_area_struct *vma, unsigned long buf, unsigned long addr, unsigned long size)
 {
-	unsigned long page;
-
 	DPRINT(("CPU%d buf=0x%lx addr=0x%lx size=%ld\n", smp_processor_id(), buf, addr, size));
 
 	while (size > 0) {
-		page = pfm_kvirt_to_pa(buf);
+		unsigned long pfn = ia64_tpa(buf) >> PAGE_SHIFT;
+
 
-		if (pfm_remap_page_range(vma, addr, page, PAGE_SIZE, PAGE_READONLY)) return -ENOMEM;
+		if (remap_pfn_range(vma, addr, pfn, PAGE_SIZE, PAGE_READONLY))
+			return -ENOMEM;
 
 		addr  += PAGE_SIZE;
 		buf   += PAGE_SIZE;
Index: mm3-2.6.9-rc2/arch/ia64/pci/pci.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/ia64/pci/pci.c	2004-09-25 00:15:54.743450240 -0700
+++ mm3-2.6.9-rc2/arch/ia64/pci/pci.c	2004-09-25 00:16:35.106314152 -0700
@@ -498,7 +498,7 @@
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 
Index: mm3-2.6.9-rc2/arch/ppc/kernel/pci.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/ppc/kernel/pci.c	2004-09-25 00:15:55.277369072 -0700
+++ mm3-2.6.9-rc2/arch/ppc/kernel/pci.c	2004-09-25 00:17:33.481439784 -0700
@@ -1596,7 +1596,7 @@
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
-	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 
 	return ret;
Index: mm3-2.6.9-rc2/arch/ppc64/kernel/pci.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/ppc64/kernel/pci.c	2004-09-25 00:15:54.612470152 -0700
+++ mm3-2.6.9-rc2/arch/ppc64/kernel/pci.c	2004-09-25 00:17:13.248515656 -0700
@@ -503,7 +503,7 @@
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
-	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 
 	return ret;
Index: mm3-2.6.9-rc2/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/ppc64/kernel/proc_ppc64.c	2004-09-25 00:15:54.675460576 -0700
+++ mm3-2.6.9-rc2/arch/ppc64/kernel/proc_ppc64.c	2004-09-25 00:17:19.205610040 -0700
@@ -176,7 +176,8 @@
 	if ((vma->vm_end - vma->vm_start) > dp->size)
 		return -EINVAL;
 
-	remap_page_range( vma, vma->vm_start, __pa(dp->data), dp->size, vma->vm_page_prot );
+	remap_pfn_range(vma, vma->vm_start, __pa(dp->data) >> PAGE_SHIFT,
+						dp->size, vma->vm_page_prot);
 	return 0;
 }
 
Index: mm3-2.6.9-rc2/arch/sparc/mm/generic.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/sparc/mm/generic.c	2004-09-25 00:15:55.202380472 -0700
+++ mm3-2.6.9-rc2/arch/sparc/mm/generic.c	2004-09-25 00:17:57.633768072 -0700
@@ -41,7 +41,7 @@
 #endif
 }
 
-/* Remap IO memory, the same way as remap_page_range(), but use
+/* Remap IO memory, the same way as remap_pfn_range(), but use
  * the obio memory space.
  *
  * They use a pgprot that sets PAGE_IO and does not check the
Index: mm3-2.6.9-rc2/arch/sparc64/mm/generic.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/sparc64/mm/generic.c	2004-09-25 00:15:55.045404336 -0700
+++ mm3-2.6.9-rc2/arch/sparc64/mm/generic.c	2004-09-25 00:17:49.557995776 -0700
@@ -23,7 +23,7 @@
 	}
 }
 
-/* Remap IO memory, the same way as remap_page_range(), but use
+/* Remap IO memory, the same way as remap_pfn_range(), but use
  * the obio memory space.
  *
  * They use a pgprot that sets PAGE_IO and does not check the
Index: mm3-2.6.9-rc2/arch/um/drivers/mmapper_kern.c
===================================================================
--- mm3-2.6.9-rc2.orig/arch/um/drivers/mmapper_kern.c	2004-09-25 00:15:54.893427440 -0700
+++ mm3-2.6.9-rc2/arch/um/drivers/mmapper_kern.c	2004-09-25 00:18:00.984258720 -0700
@@ -81,10 +81,10 @@
 	size = vma->vm_end - vma->vm_start;
 	if(size > mmapper_size) return(-EFAULT);
 
-	/* XXX A comment above remap_page_range says it should only be
+	/* XXX A comment above remap_pfn_range says it should only be
 	 * called when the mm semaphore is held
 	 */
-	if (remap_page_range(vma, vma->vm_start, p_buf, size, 
+	if (remap_pfn_range(vma, vma->vm_start, p_buf >> PAGE_SHIFT, size, 
 			     vma->vm_page_prot))
 		goto out;
 	ret = 0;
