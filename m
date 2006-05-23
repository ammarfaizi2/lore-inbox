Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWEWW2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWEWW2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWEWW2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:28:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29908 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932233AbWEWW2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:28:40 -0400
Date: Tue, 23 May 2006 15:28:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Rohit Seth <rohitseth@google.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: remove VM_LOCKED before remap_pfn_range and drop VM_SHM
In-Reply-To: <Pine.LNX.4.64.0605232131560.19019@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0605231524370.11985@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605222022100.11067@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0605230917390.9731@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605231937410.14985@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0605231223360.10836@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605232131560.19019@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006, Hugh Dickins wrote:

> Oh yes, I'd noticed that subject going by, and meant to speak up
> sometime.  I feel pretty strongly, and have so declared in the past,
> that VM_LOCKED should _not_ guarantee that the same physical page is
> used forever: get_user_pages is what's used to pin a physical page
> for that effect.  I remember Arjan sharing this opinion.
> 
> You might discover a problem or two in letting page migration go that
> way, I'm not saying there cannot be a problem; but I'd much rather
> you try without adding a new flag unless it's proved necessary.
> And I know Linus prefers not to go overboard with extra flags.
> 
> You mentioned in one of the mails that went past that you'd seen
> drivers enforcing VM_LOCKED in vm_flags: aren't those just drivers
> copying other drivers which did so, but achieving nothing thereby,
> to be cleaned up in due course?  (The pages aren't even on LRU.)

Ok that seems to be the case. Also VM_SHM falls out once we deal with 
this:


Remove VM_LOCKED before remap_pfn range from device drivers and get rid of 
VM_SHM.

remap_pfn_range() already sets VM_IO. There is no need to set VM_SHM since
it does nothing. VM_LOCKED is of no use since the remap_pfn_range does
not place pages on the LRU. The pages are therefore never subject to
swap anyways. Remove all the vm_flags settings before calling
remap_pfn_range.

After removing all the vm_flag settings no use of VM_SHM is left.
Drop it.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc4-mm3/drivers/video/igafb.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/video/igafb.c	2006-05-11 16:31:53.000000000 -0700
+++ linux-2.6.17-rc4-mm3/drivers/video/igafb.c	2006-05-23 15:10:31.101159381 -0700
@@ -232,9 +232,6 @@ static int igafb_mmap(struct fb_info *in
 
 	size = vma->vm_end - vma->vm_start;
 
-	/* To stop the swapper from even considering these pages. */
-	vma->vm_flags |= (VM_SHM | VM_LOCKED);
-
 	/* Each page, see which map applies */
 	for (page = 0; page < size; ) {
 		map_size = 0;
Index: linux-2.6.17-rc4-mm3/drivers/sbus/char/flash.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/sbus/char/flash.c	2006-05-11 16:31:53.000000000 -0700
+++ linux-2.6.17-rc4-mm3/drivers/sbus/char/flash.c	2006-05-23 15:10:31.102135883 -0700
@@ -71,7 +71,6 @@ flash_mmap(struct file *file, struct vm_
 	if (vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT)) > size)
 		size = vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT));
 
-	vma->vm_flags |= (VM_SHM | VM_LOCKED);
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	if (io_remap_pfn_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
Index: linux-2.6.17-rc4-mm3/drivers/char/mmtimer.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/char/mmtimer.c	2006-05-11 16:31:53.000000000 -0700
+++ linux-2.6.17-rc4-mm3/drivers/char/mmtimer.c	2006-05-23 15:10:31.103112385 -0700
@@ -329,7 +329,6 @@ static int mmtimer_mmap(struct file *fil
 	if (PAGE_SIZE > (1 << 16))
 		return -ENOSYS;
 
-	vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED );
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	mmtimer_addr = __pa(RTC_COUNTER_ADDR);
Index: linux-2.6.17-rc4-mm3/arch/xtensa/kernel/pci.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/xtensa/kernel/pci.c	2006-05-23 15:10:16.963363024 -0700
+++ linux-2.6.17-rc4-mm3/arch/xtensa/kernel/pci.c	2006-05-23 15:10:34.631214211 -0700
@@ -350,17 +350,6 @@ __pci_mmap_make_offset(struct pci_dev *d
 }
 
 /*
- * Set vm_flags of VMA, as appropriate for this architecture, for a pci device
- * mapping.
- */
-static __inline__ void
-__pci_mmap_set_flags(struct pci_dev *dev, struct vm_area_struct *vma,
-		     enum pci_mmap_state mmap_state)
-{
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
-}
-
-/*
  * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
@@ -399,7 +388,6 @@ int pci_mmap_page_range(struct pci_dev *
 	if (ret < 0)
 		return ret;
 
-	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
 	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
Index: linux-2.6.17-rc4-mm3/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/powerpc/kernel/pci_64.c	2006-05-23 15:10:16.675294926 -0700
+++ linux-2.6.17-rc4-mm3/arch/powerpc/kernel/pci_64.c	2006-05-23 15:10:34.376347182 -0700
@@ -875,7 +875,6 @@ int pci_mmap_page_range(struct pci_dev *
 		return -EINVAL;
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
 						  vma->vm_page_prot,
 						  mmap_state, write_combine);
Index: linux-2.6.17-rc4-mm3/arch/i386/pci/i386.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/i386/pci/i386.c	2006-05-23 15:10:16.427263411 -0700
+++ linux-2.6.17-rc4-mm3/arch/i386/pci/i386.c	2006-05-23 15:10:34.373417675 -0700
@@ -276,8 +276,6 @@ int pci_mmap_page_range(struct pci_dev *
 	/* Leave vm_pgoff as-is, the PCI space address is the physical
 	 * address on this platform.
 	 */
-	vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO);
-
 	prot = pgprot_val(vma->vm_page_prot);
 	if (boot_cpu_data.x86 > 3)
 		prot |= _PAGE_PCD | _PAGE_PWT;
Index: linux-2.6.17-rc4-mm3/arch/ppc/kernel/pci.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/ppc/kernel/pci.c	2006-05-23 15:10:16.782710149 -0700
+++ linux-2.6.17-rc4-mm3/arch/ppc/kernel/pci.c	2006-05-23 15:10:34.379276688 -0700
@@ -1040,7 +1040,6 @@ int pci_mmap_page_range(struct pci_dev *
 		return -EINVAL;
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
 						  vma->vm_page_prot,
 						  mmap_state, write_combine);
Index: linux-2.6.17-rc4-mm3/arch/powerpc/kernel/proc_ppc64.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/powerpc/kernel/proc_ppc64.c	2006-05-23 15:10:16.678224432 -0700
+++ linux-2.6.17-rc4-mm3/arch/powerpc/kernel/proc_ppc64.c	2006-05-23 15:10:34.377323684 -0700
@@ -115,8 +115,6 @@ static int page_map_mmap( struct file *f
 {
 	struct proc_dir_entry *dp = PDE(file->f_dentry->d_inode);
 
-	vma->vm_flags |= VM_SHM | VM_LOCKED;
-
 	if ((vma->vm_end - vma->vm_start) > dp->size)
 		return -EINVAL;
 
Index: linux-2.6.17-rc4-mm3/drivers/sbus/char/vfc_dev.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/drivers/sbus/char/vfc_dev.c	2006-05-23 15:08:28.409538512 -0700
+++ linux-2.6.17-rc4-mm3/drivers/sbus/char/vfc_dev.c	2006-05-23 15:10:34.634143717 -0700
@@ -623,7 +623,7 @@ static int vfc_mmap(struct file *file, s
 		map_size = sizeof(struct vfc_regs);
 
 	vma->vm_flags |=
-		(VM_SHM | VM_LOCKED | VM_IO | VM_MAYREAD | VM_MAYWRITE | VM_MAYSHARE);
+		(VM_MAYREAD | VM_MAYWRITE | VM_MAYSHARE);
 	map_offset = (unsigned int) (long)dev->phys_regs;
 	ret = io_remap_pfn_range(vma, vma->vm_start,
 				  MK_IOSPACE_PFN(dev->which_io,
Index: linux-2.6.17-rc4-mm3/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/powerpc/kernel/pci_32.c	2006-05-23 15:10:16.674318424 -0700
+++ linux-2.6.17-rc4-mm3/arch/powerpc/kernel/pci_32.c	2006-05-23 15:10:34.375370679 -0700
@@ -1654,7 +1654,6 @@ int pci_mmap_page_range(struct pci_dev *
 		return -EINVAL;
 
 	vma->vm_pgoff = offset >> PAGE_SHIFT;
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
 						  vma->vm_page_prot,
 						  mmap_state, write_combine);
Index: linux-2.6.17-rc4-mm3/arch/cris/arch-v32/drivers/pci/bios.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/cris/arch-v32/drivers/pci/bios.c	2006-05-23 15:10:16.278835103 -0700
+++ linux-2.6.17-rc4-mm3/arch/cris/arch-v32/drivers/pci/bios.c	2006-05-23 15:10:34.372441173 -0700
@@ -27,8 +27,6 @@ int pci_mmap_page_range(struct pci_dev *
 	/* Leave vm_pgoff as-is, the PCI space address is the physical
 	 * address on this platform.
 	 */
-	vma->vm_flags |= (VM_SHM | VM_LOCKED | VM_IO);
-
 	prot = pgprot_val(vma->vm_page_prot);
 	vma->vm_page_prot = __pgprot(prot);
 
Index: linux-2.6.17-rc4-mm3/arch/arm/kernel/bios32.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/arm/kernel/bios32.c	2006-05-23 15:10:16.265164074 -0700
+++ linux-2.6.17-rc4-mm3/arch/arm/kernel/bios32.c	2006-05-23 15:10:34.369511667 -0700
@@ -702,7 +702,6 @@ int pci_mmap_page_range(struct pci_dev *
 	/*
 	 * Mark this as IO
 	 */
-	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	if (remap_pfn_range(vma, vma->vm_start, phys,
Index: linux-2.6.17-rc4-mm3/arch/ia64/pci/pci.c
===================================================================
--- linux-2.6.17-rc4-mm3.orig/arch/ia64/pci/pci.c	2006-05-23 15:10:16.497571557 -0700
+++ linux-2.6.17-rc4-mm3/arch/ia64/pci/pci.c	2006-05-23 15:20:27.401143385 -0700
@@ -602,8 +602,6 @@ pci_mmap_page_range (struct pci_dev *dev
 	 * Leave vm_pgoff as-is, the PCI space address is the physical
 	 * address on this platform.
 	 */
-	vma->vm_flags |= (VM_SHM | VM_RESERVED | VM_IO);
-
 	if (write_combine && efi_range_is_wc(vma->vm_start,
 					     vma->vm_end - vma->vm_start))
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
@@ -666,7 +664,6 @@ pci_mmap_legacy_page_range(struct pci_bu
 
 	vma->vm_pgoff += (unsigned long)addr >> PAGE_SHIFT;
 	vma->vm_page_prot = prot;
-	vma->vm_flags |= (VM_SHM | VM_RESERVED | VM_IO);
 
 	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			    size, vma->vm_page_prot))
Index: linux-2.6.17-rc4-mm3/include/linux/mm.h
===================================================================
--- linux-2.6.17-rc4-mm3.orig/include/linux/mm.h	2006-05-23 15:10:21.641784240 -0700
+++ linux-2.6.17-rc4-mm3/include/linux/mm.h	2006-05-23 15:14:41.099348991 -0700
@@ -145,7 +145,6 @@ extern unsigned int kobjsize(const void 
 
 #define VM_GROWSDOWN	0x00000100	/* general info on the segment */
 #define VM_GROWSUP	0x00000200
-#define VM_SHM		0x00000000	/* Means nothing: delete it later */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
 #define VM_DENYWRITE	0x00000800	/* ETXTBSY on write attempts.. */
 
