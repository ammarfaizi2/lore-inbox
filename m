Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVCPLvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVCPLvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVCPLvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:51:15 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:63175 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261172AbVCPLty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:49:54 -0500
To: linux-kernel@vger.kernel.org, akpm@osdl.org
cc: riel@redhat.com, kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH] Xen/i386 cleanups - io_remap_pfn_range
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <8527.1110973791.0@cl.cam.ac.uk>
Date: Wed, 16 Mar 2005 11:49:51 +0000
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DBX27-0000te-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8527.1110973791.1@cl.cam.ac.uk>

This patch introduces a new interface function for mapping bus/device
memory: io_remap_pfn_range. This accepts the same parameters as
remap_pfn_range (indeed, by default it is implemented by this existing
function) but should be used in any situation where the caller is not
simply remapping ordinary RAM. For example, when mapping device
registers the new function should be used. 

The distinction between remapping device memory and ordinary RAM is
critical for the Xen hypervisor. This may also serve as a starting
point for cleaning up remaining users of io_remap_page_range (in
particular, the several sparc-specific sections in various drivers
that use a special form of io_remap_page_range).

I have audited the drivers/ and sound/ directories. Most uses of
remap_pfn_range are okay, but there are a small handful that are
remapping device memory (mostly AGP and DRM drivers).

Of particular driver is the HPET driver, whose mmap function is broken
even for native (non-Xen) builds. If nothing else, vmalloc_to_phys
should be used instead of __pa to convert an ioremapped virtual
address to a valid physical address. The fix in this patch is to
remember the original bus address as probed at boot time and to pass
this to io_remap_pfn_range.

Signed-off-by: Keir Fraser <keir@xensource.com>


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="iomap.patch"; charset="us-ascii"
Content-ID: <8527.1110973791.2@cl.cam.ac.uk>
Content-Description: iomap patch

--- linux-2.6-old/drivers/char/agp/frontend.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/agp/frontend.c	2005-03-16 10:34:58 +00:00
@@ -628,7 +628,7 @@
 		DBG("client vm_ops=%p", kerninfo.vm_ops);
 		if (kerninfo.vm_ops) {
 			vma->vm_ops = kerninfo.vm_ops;
-		} else if (remap_pfn_range(vma, vma->vm_start,
+		} else if (io_remap_pfn_range(vma, vma->vm_start,
 				(kerninfo.aper_base + offset) >> PAGE_SHIFT,
 					    size, vma->vm_page_prot)) {
 			goto out_again;
@@ -644,7 +644,7 @@
 		DBG("controller vm_ops=%p", kerninfo.vm_ops);
 		if (kerninfo.vm_ops) {
 			vma->vm_ops = kerninfo.vm_ops;
-		} else if (remap_pfn_range(vma, vma->vm_start,
+		} else if (io_remap_pfn_range(vma, vma->vm_start,
 					    kerninfo.aper_base >> PAGE_SHIFT,
 					    size, vma->vm_page_prot)) {
 			goto out_again;
--- linux-2.6-old/drivers/char/drm/drm_vm.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/drm/drm_vm.c	2005-03-16 10:34:58 +00:00
@@ -630,7 +630,7 @@
 					vma->vm_end - vma->vm_start,
 					vma->vm_page_prot, 0))
 #else
-		if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+		if (io_remap_pfn_range(vma, vma->vm_start,
 				     (VM_OFFSET(vma) + offset) >> PAGE_SHIFT,
 				     vma->vm_end - vma->vm_start,
 				     vma->vm_page_prot))
--- linux-2.6-old/drivers/char/drm/i810_dma.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/drm/i810_dma.c	2005-03-16 10:34:58 +00:00
@@ -119,7 +119,7 @@
    	buf_priv->currently_mapped = I810_BUF_MAPPED;
 	unlock_kernel();
 
-	if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+	if (io_remap_pfn_range(vma, vma->vm_start,
 			     VM_OFFSET(vma) >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot)) return -EAGAIN;
--- linux-2.6-old/drivers/char/drm/i830_dma.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/drm/i830_dma.c	2005-03-16 10:34:58 +00:00
@@ -121,7 +121,7 @@
    	buf_priv->currently_mapped = I830_BUF_MAPPED;
 	unlock_kernel();
 
-	if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+	if (io_remap_pfn_range(vma, vma->vm_start,
 			     VM_OFFSET(vma) >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot)) return -EAGAIN;
--- linux-2.6-old/drivers/char/hpet.c	2005-03-16 10:30:25 +00:00
+++ linux-2.6-new/drivers/char/hpet.c	2005-03-16 10:34:58 +00:00
@@ -76,6 +76,7 @@
 struct hpets {
 	struct hpets *hp_next;
 	struct hpet __iomem *hp_hpet;
+	unsigned long hp_hpet_phys;
 	struct time_interpolator *hp_interpolator;
 	unsigned long hp_period;
 	unsigned long hp_delta;
@@ -265,7 +266,7 @@
 		return -EINVAL;
 
 	devp = file->private_data;
-	addr = (unsigned long)devp->hd_hpet;
+	addr = devp->hd_hpets->hp_hpet_phys;
 
 	if (addr & (PAGE_SIZE - 1))
 		return -ENOSYS;
@@ -274,7 +275,7 @@
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	addr = __pa(addr);
 
-	if (remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
+	if (io_remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
 					PAGE_SIZE, vma->vm_page_prot)) {
 		printk(KERN_ERR "remap_pfn_range failed in hpet.c\n");
 		return -EAGAIN;
@@ -795,6 +796,7 @@
 
 	hpetp->hp_which = hpet_nhpet++;
 	hpetp->hp_hpet = hdp->hd_address;
+	hpetp->hp_hpet_phys = hdp->hd_phys_address;
 
 	hpetp->hp_ntimer = hdp->hd_nirqs;
 
--- linux-2.6-old/drivers/sbus/char/flash.c	2005-03-16 10:30:37 +00:00
+++ linux-2.6-new/drivers/sbus/char/flash.c	2005-03-16 10:34:58 +00:00
@@ -75,7 +75,7 @@
 	pgprot_val(vma->vm_page_prot) |= _PAGE_E;
 	vma->vm_flags |= (VM_SHM | VM_LOCKED);
 
-	if (remap_pfn_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
+	if (io_remap_pfn_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
 		return -EAGAIN;
 		
 	return 0;
--- linux-2.6-old/include/linux/mm.h	2005-03-16 10:31:07 +00:00
+++ linux-2.6-new/include/linux/mm.h	2005-03-16 10:34:58 +00:00
@@ -815,6 +815,10 @@
 extern int check_user_page_readable(struct mm_struct *mm, unsigned long address);
 int remap_pfn_range(struct vm_area_struct *, unsigned long,
 		unsigned long, unsigned long, pgprot_t);
+/* Allow arch override for mapping of device and I/O (non-RAM) pages. */
+#ifndef io_remap_pfn_range
+#define io_remap_pfn_range remap_pfn_range
+#endif
 
 #ifdef CONFIG_PROC_FS
 void __vm_stat_account(struct mm_struct *, unsigned long, struct file *, long);

------- =_aaaaaaaaaa0--
