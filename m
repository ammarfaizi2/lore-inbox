Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVCRTkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVCRTkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVCRTjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:39:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:44434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262011AbVCRTjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:39:39 -0500
Date: Fri, 18 Mar 2005 11:32:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, akpm@osdl.org, davem@davemloft.net, wli@holomorphy.com,
       riel@redhat.com, kurt@garloff.de, Keir.Fraser@cl.cam.ac.uk,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: [PATCH 3/4] io_remap_pfn_range: fix some callers for XEN
Message-Id: <20050318113223.6a141d51.rddunlap@osdl.org>
In-Reply-To: <20050318112545.6f5f7635.rddunlap@osdl.org>
References: <20050318112545.6f5f7635.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(from Keir:)
I have audited the drivers/ and sound/ directories. Most uses of
remap_pfn_range are okay, but there are a small handful that are
remapping device memory (mostly AGP and DRM drivers).

Of particular driver is the HPET driver, whose mmap function is broken
even for native (non-Xen) builds. If nothing else, vmalloc_to_phys
should be used instead of __pa to convert an ioremapped virtual
address to a valid physical address. The fix in this patch is to
remember the original bus address as probed at boot time and to pass
this to io_remap_pfn_range.

 drivers/char/agp/frontend.c |    4 ++--
 drivers/char/drm/drm_vm.c   |    2 +-
 drivers/char/drm/i810_dma.c |    2 +-
 drivers/char/drm/i830_dma.c |    2 +-
 drivers/char/hpet.c         |    6 ++++--
 drivers/sbus/char/flash.c   |    2 +-
 6 files changed, 10 insertions(+), 8 deletions(-)

Signed-off-by: Keir Fraser <keir@xensource.com>


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
 					vma->vm_page_prot))
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

---
