Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUHSClc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUHSClc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbUHSClc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:41:32 -0400
Received: from holomorphy.com ([207.189.100.168]:22972 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268024AbUHSCjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:39:13 -0400
Date: Wed, 18 Aug 2004 19:38:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040819023848.GY11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, pj@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818205338.GF11200@holomorphy.com> <20040818135638.4326ca02.davem@redhat.com> <20040818210503.GG11200@holomorphy.com> <20040818143029.23db8740.davem@redhat.com> <20040818214026.GL11200@holomorphy.com> <20040818220001.GN11200@holomorphy.com> <20040818225915.GQ11200@holomorphy.com> <20040818161658.49aa8de3.davem@redhat.com> <20040818233324.GT11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818233324.GT11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 04:16:58PM -0700, David S. Miller wrote:
>> There is an error in the calculations.  16TB "RAM", means "RAM".
>> On many systems, a large chunk of the physical address space is
>> taken up by I/O areas, not real memory.
>> Such areas do not take up mem_map[] array space.
>> Regardless, I think an "unsigned long" page frame number is sufficient
>> for now.  Don't even make the new type.

On Wed, Aug 18, 2004 at 04:33:24PM -0700, William Lee Irwin III wrote:
> Oh, virtualspace footprint of IO areas is far worse, as the convention
> is to direct map them into a single address space if they're ever used.
> Of course this convention is much more loosely established than e.g.
> struct page is for RAM. Some analogue of kmap_atomic() for such
> machines to multiplex virtualspace in interrupt context would help, but
> is unrelated to physical address passing issues.

remap_page_range() is the easier of the two. Here is something
approximating a patch to make that accept pfn's (untested/uncompiled).
Oddly, the sparc64 case seems to be the most difficult one for the
io_remap_page_range() sweep...

 arch/arm/kernel/bios32.c           |    2 +-
 arch/i386/pci/i386.c               |    2 +-
 arch/ia64/kernel/perfmon.c         |    2 +-
 arch/ia64/pci/pci.c                |    2 +-
 arch/ppc/kernel/pci.c              |    2 +-
 arch/ppc64/kernel/pci.c            |    2 +-
 arch/ppc64/kernel/proc_ppc64.c     |    2 +-
 arch/um/drivers/mmapper_kern.c     |    2 +-
 drivers/char/agp/frontend.c        |    4 ++--
 drivers/char/drm/drm_vm.h          |    2 +-
 drivers/char/drm/i810_dma.c        |    2 +-
 drivers/char/drm/i830_dma.c        |    2 +-
 drivers/char/hpet.c                |    2 +-
 drivers/char/mem.c                 |    2 +-
 drivers/media/video/cpia.c         |   15 +--------------
 drivers/media/video/meye.c         |   14 +-------------
 drivers/media/video/planb.c        |    2 +-
 drivers/media/video/zoran_driver.c |   15 +++++----------
 drivers/media/video/zr36120.c      |    2 +-
 drivers/perfctr/virtual.c          |    2 +-
 drivers/sbus/char/flash.c          |    2 +-
 drivers/usb/class/audio.c          |    2 +-
 drivers/usb/media/ov511.c          |   16 +---------------
 drivers/usb/media/pwc-if.c         |   15 +--------------
 drivers/usb/media/se401.c          |   15 +--------------
 drivers/usb/media/stv680.c         |   15 +--------------
 drivers/usb/media/usbvideo.c       |   16 +---------------
 drivers/usb/media/vicam.c          |   12 +-----------
 drivers/usb/media/w9968cf.c        |   16 +---------------
 drivers/video/aty/atyfb_base.c     |    4 ++--
 drivers/video/gbefb.c              |    2 +-
 drivers/video/igafb.c              |    2 +-
 drivers/video/sgivwfb.c            |    2 +-
 include/asm-alpha/pgtable.h        |    2 +-
 include/asm-arm/pgtable.h          |    2 +-
 include/asm-arm26/pgtable.h        |    2 +-
 include/asm-h8300/pgtable.h        |    3 ++-
 include/asm-i386/pgtable.h         |    3 ++-
 include/asm-ia64/pgtable.h         |    3 ++-
 include/asm-m68k/pgtable.h         |    3 ++-
 include/asm-m68knommu/pgtable.h    |    3 ++-
 include/asm-mips/pgtable.h         |    3 ++-
 include/asm-parisc/pgtable.h       |    3 ++-
 include/asm-ppc/pgtable.h          |    3 ++-
 include/asm-ppc64/pgtable.h        |    3 ++-
 include/asm-sh/pgtable.h           |    3 ++-
 include/asm-sh64/pgtable.h         |    3 ++-
 include/asm-x86_64/pgtable.h       |    3 ++-
 mm/memory.c                        |   16 +++++++---------
 net/packet/af_packet.c             |    3 ++-
 sound/oss/ali5455.c                |    2 +-
 sound/oss/au1000.c                 |    2 +-
 sound/oss/cmpci.c                  |    2 +-
 sound/oss/cs4281/cs4281m.c         |    2 +-
 sound/oss/cs46xx.c                 |    4 ++--
 sound/oss/es1370.c                 |    4 ++--
 sound/oss/es1371.c                 |    4 ++--
 sound/oss/esssolo1.c               |    2 +-
 sound/oss/forte.c                  |    2 +-
 sound/oss/i810_audio.c             |    2 +-
 sound/oss/ite8172.c                |    2 +-
 sound/oss/maestro.c                |    2 +-
 sound/oss/maestro3.c               |    2 +-
 sound/oss/rme96xx.c                |    4 ++--
 sound/oss/sonicvibes.c             |    2 +-
 sound/oss/trident.c                |    2 +-
 sound/oss/ymfpci.c                 |    2 +-
 67 files changed, 96 insertions(+), 206 deletions(-)

-- wli

Index: mm1-2.6.8.1/arch/arm/kernel/bios32.c
===================================================================
--- mm1-2.6.8.1.orig/arch/arm/kernel/bios32.c	2004-08-18 18:56:41.711353344 -0700
+++ mm1-2.6.8.1/arch/arm/kernel/bios32.c	2004-08-18 18:56:54.563399536 -0700
@@ -684,7 +684,7 @@
 	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_page_range(vma, vma->vm_start, phys,
+	if (remap_page_range(vma, vma->vm_start, phys >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
Index: mm1-2.6.8.1/arch/i386/pci/i386.c
===================================================================
--- mm1-2.6.8.1.orig/arch/i386/pci/i386.c	2004-08-18 18:56:41.711353344 -0700
+++ mm1-2.6.8.1/arch/i386/pci/i386.c	2004-08-18 18:56:54.563399536 -0700
@@ -291,7 +291,7 @@
 	/* Write-combine setting is ignored, it is changed via the mtrr
 	 * interfaces on this platform.
 	 */
-	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
Index: mm1-2.6.8.1/arch/ia64/kernel/perfmon.c
===================================================================
--- mm1-2.6.8.1.orig/arch/ia64/kernel/perfmon.c	2004-08-18 18:56:41.711353344 -0700
+++ mm1-2.6.8.1/arch/ia64/kernel/perfmon.c	2004-08-18 18:56:54.565399232 -0700
@@ -575,7 +575,7 @@
 static inline int
 pfm_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long phys_addr, unsigned long size, pgprot_t prot)
 {
-	return remap_page_range(vma, from, phys_addr, size, prot);
+	return remap_page_range(vma, from, phys_addr >> PAGE_SHIFT, size, prot);
 }
 
 static inline unsigned long
Index: mm1-2.6.8.1/arch/ia64/pci/pci.c
===================================================================
--- mm1-2.6.8.1.orig/arch/ia64/pci/pci.c	2004-08-18 18:56:41.712353192 -0700
+++ mm1-2.6.8.1/arch/ia64/pci/pci.c	2004-08-18 18:56:54.566399080 -0700
@@ -487,7 +487,7 @@
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 
Index: mm1-2.6.8.1/arch/ppc/kernel/pci.c
===================================================================
--- mm1-2.6.8.1.orig/arch/ppc/kernel/pci.c	2004-08-18 18:56:41.705354256 -0700
+++ mm1-2.6.8.1/arch/ppc/kernel/pci.c	2004-08-18 18:56:54.566399080 -0700
@@ -1601,7 +1601,7 @@
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
-	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 
 	return ret;
Index: mm1-2.6.8.1/arch/ppc64/kernel/pci.c
===================================================================
--- mm1-2.6.8.1.orig/arch/ppc64/kernel/pci.c	2004-08-18 18:56:41.712353192 -0700
+++ mm1-2.6.8.1/arch/ppc64/kernel/pci.c	2004-08-18 18:56:54.567398928 -0700
@@ -500,7 +500,7 @@
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
-	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 
 	return ret;
Index: mm1-2.6.8.1/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- mm1-2.6.8.1.orig/arch/ppc64/kernel/proc_ppc64.c	2004-08-18 18:56:41.712353192 -0700
+++ mm1-2.6.8.1/arch/ppc64/kernel/proc_ppc64.c	2004-08-18 18:56:54.567398928 -0700
@@ -176,7 +176,7 @@
 	if ((vma->vm_end - vma->vm_start) > dp->size)
 		return -EINVAL;
 
-	remap_page_range( vma, vma->vm_start, __pa(dp->data), dp->size, vma->vm_page_prot );
+	remap_page_range(vma, vma->vm_start, __pa(dp->data) >> PAGE_SHIFT, dp->size, vma->vm_page_prot );
 	return 0;
 }
 
Index: mm1-2.6.8.1/arch/um/drivers/mmapper_kern.c
===================================================================
--- mm1-2.6.8.1.orig/arch/um/drivers/mmapper_kern.c	2004-08-18 18:56:41.711353344 -0700
+++ mm1-2.6.8.1/arch/um/drivers/mmapper_kern.c	2004-08-18 18:56:54.567398928 -0700
@@ -84,7 +84,7 @@
 	/* XXX A comment above remap_page_range says it should only be
 	 * called when the mm semaphore is held
 	 */
-	if (remap_page_range(vma, vma->vm_start, p_buf, size, 
+	if (remap_page_range(vma, vma->vm_start, p_buf >> PAGE_SHIFT, size, 
 			     vma->vm_page_prot))
 		goto out;
 	ret = 0;
Index: mm1-2.6.8.1/drivers/char/agp/frontend.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/char/agp/frontend.c	2004-08-18 18:56:41.719352128 -0700
+++ mm1-2.6.8.1/drivers/char/agp/frontend.c	2004-08-18 18:56:54.568398776 -0700
@@ -628,7 +628,7 @@
 		if (kerninfo.vm_ops) {
 			vma->vm_ops = kerninfo.vm_ops;
 		} else if (remap_page_range(vma, vma->vm_start, 
-					    (kerninfo.aper_base + offset),
+				(kerninfo.aper_base + offset) >> PAGE_SHIFT,
 					    size, vma->vm_page_prot)) {
 			goto out_again;
 		}
@@ -644,7 +644,7 @@
 		if (kerninfo.vm_ops) {
 			vma->vm_ops = kerninfo.vm_ops;
 		} else if (remap_page_range(vma, vma->vm_start, 
-					    kerninfo.aper_base,
+					    kerninfo.aper_base >> PAGE_SHIFT,
 					    size, vma->vm_page_prot)) {
 			goto out_again;
 		}
Index: mm1-2.6.8.1/drivers/char/drm/drm_vm.h
===================================================================
--- mm1-2.6.8.1.orig/drivers/char/drm/drm_vm.h	2004-08-18 18:56:41.719352128 -0700
+++ mm1-2.6.8.1/drivers/char/drm/drm_vm.h	2004-08-18 18:56:54.568398776 -0700
@@ -617,7 +617,7 @@
 					vma->vm_page_prot, 0))
 #else
 		if (remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-				     VM_OFFSET(vma) + offset,
+				     vma->vm_pgoff + (offset >> PAGE_SHIFT),
 				     vma->vm_end - vma->vm_start,
 				     vma->vm_page_prot))
 #endif
Index: mm1-2.6.8.1/drivers/char/drm/i810_dma.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/char/drm/i810_dma.c	2004-08-18 18:56:41.719352128 -0700
+++ mm1-2.6.8.1/drivers/char/drm/i810_dma.c	2004-08-18 18:56:54.569398624 -0700
@@ -139,7 +139,7 @@
 	unlock_kernel();
 
 	if (remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-			     VM_OFFSET(vma),
+			     vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot)) return -EAGAIN;
 	return 0;
Index: mm1-2.6.8.1/drivers/char/drm/i830_dma.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/char/drm/i830_dma.c	2004-08-18 18:56:41.714352888 -0700
+++ mm1-2.6.8.1/drivers/char/drm/i830_dma.c	2004-08-18 18:56:54.569398624 -0700
@@ -140,7 +140,7 @@
 	unlock_kernel();
 
 	if (remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-			     VM_OFFSET(vma),
+			     vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot)) return -EAGAIN;
 	return 0;
Index: mm1-2.6.8.1/drivers/char/hpet.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/char/hpet.c	2004-08-18 18:56:41.720351976 -0700
+++ mm1-2.6.8.1/drivers/char/hpet.c	2004-08-18 18:56:54.569398624 -0700
@@ -271,7 +271,7 @@
 
 	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	addr = __pa(addr);
+	addr = __pa(addr) >> PAGE_SHIFT;
 
 	if (remap_page_range
 	    (vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
Index: mm1-2.6.8.1/drivers/char/mem.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/char/mem.c	2004-08-18 18:56:41.720351976 -0700
+++ mm1-2.6.8.1/drivers/char/mem.c	2004-08-18 18:56:54.570398472 -0700
@@ -236,7 +236,7 @@
 		cursor++;
 	}
 
-	if (remap_page_range(vma, vma->vm_start, offset,
+	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff,
 			vma->vm_end-vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
Index: mm1-2.6.8.1/drivers/media/video/cpia.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/media/video/cpia.c	2004-08-18 18:56:41.713353040 -0700
+++ mm1-2.6.8.1/drivers/media/video/cpia.c	2004-08-18 18:56:54.571398320 -0700
@@ -206,19 +206,6 @@
  *
  **********************************************************************/
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-static inline unsigned long kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
 static void *rvmalloc(unsigned long size)
 {
 	void *mem;
@@ -3785,7 +3772,7 @@
 
 	pos = (unsigned long)(cam->frame_buf);
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&cam->busy_lock);
 			return -EAGAIN;
Index: mm1-2.6.8.1/drivers/media/video/meye.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/media/video/meye.c	2004-08-18 18:56:41.713353040 -0700
+++ mm1-2.6.8.1/drivers/media/video/meye.c	2004-08-18 18:56:54.572398168 -0700
@@ -116,18 +116,6 @@
 /* Memory allocation routines (stolen from bttv-driver.c)                   */
 /****************************************************************************/
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-static inline unsigned long kvirt_to_pa(unsigned long adr) {
-        unsigned long kva, ret;
-
-        kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-        return ret;
-}
-
 static void *rvmalloc(unsigned long size) {
 	void *mem;
 	unsigned long adr;
@@ -1201,7 +1189,7 @@
 	pos = (unsigned long)meye.grab_fbuffer;
 
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&meye.lock);
 			return -EAGAIN;
Index: mm1-2.6.8.1/drivers/media/video/planb.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/media/video/planb.c	2004-08-18 18:56:41.714352888 -0700
+++ mm1-2.6.8.1/drivers/media/video/planb.c	2004-08-18 18:56:54.572398168 -0700
@@ -1996,7 +1996,7 @@
 			return err;
 	}
 	for (i = 0; i < pb->rawbuf_size; i++) {
-		if (remap_page_range(vma, start, virt_to_phys((void *)pb->rawbuf[i]),
+		if (remap_page_range(vma, start, __pa((void *)pb->rawbuf[i]) >> PAGE_SHIFT,
 						PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
Index: mm1-2.6.8.1/drivers/media/video/zoran_driver.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/media/video/zoran_driver.c	2004-08-18 18:56:41.714352888 -0700
+++ mm1-2.6.8.1/drivers/media/video/zoran_driver.c	2004-08-18 18:56:54.573398016 -0700
@@ -4450,12 +4450,6 @@
 	.close = zoran_vm_close,
 };
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#define zr_remap_page_range(a,b,c,d,e) remap_page_range(b,c,d,e)
-#else
-#define zr_remap_page_range(a,b,c,d,e) remap_page_range(a,b,c,d,e)
-#endif
-
 static int
 zoran_mmap (struct file           *file,
 	    struct vm_area_struct *vma)
@@ -4555,8 +4549,9 @@
 				pos =
 				    (unsigned long) fh->jpg_buffers.
 				    buffer[i].frag_tab[2 * j];
-				page = virt_to_phys(bus_to_virt(pos));	/* should just be pos on i386 */
-				if (zr_remap_page_range
+				page = __pa(bus_to_virt(pos)) >> PAGE_SHIFT;
+				/* should just be pos on i386 */
+				if (remap_page_range
 				    (vma, start, page, todo, PAGE_SHARED)) {
 					dprintk(1,
 						KERN_ERR
@@ -4640,8 +4635,8 @@
 			todo = size;
 			if (todo > fh->v4l_buffers.buffer_size)
 				todo = fh->v4l_buffers.buffer_size;
-			page = fh->v4l_buffers.buffer[i].fbuffer_phys;
-			if (zr_remap_page_range
+			page = fh->v4l_buffers.buffer[i].fbuffer_phys >> PAGE_SHIFT;
+			if (remap_page_range
 			    (vma, start, page, todo, PAGE_SHARED)) {
 				dprintk(1,
 					KERN_ERR
Index: mm1-2.6.8.1/drivers/media/video/zr36120.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/media/video/zr36120.c	2004-08-18 18:56:41.713353040 -0700
+++ mm1-2.6.8.1/drivers/media/video/zr36120.c	2004-08-18 18:56:54.574397864 -0700
@@ -1475,7 +1475,7 @@
 	/* start mapping the whole shabang to user memory */
 	pos = (unsigned long)ztv->fbuffer;
 	while (size>0) {
-		unsigned long page = virt_to_phys((void*)pos);
+		unsigned long page = __pa(pos) >> PAGE_SHIFT;
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
Index: mm1-2.6.8.1/drivers/perfctr/virtual.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/perfctr/virtual.c	2004-08-18 18:56:41.726351064 -0700
+++ mm1-2.6.8.1/drivers/perfctr/virtual.c	2004-08-18 18:56:54.575397712 -0700
@@ -720,7 +720,7 @@
 	perfctr = filp->private_data;
 	if (!perfctr)
 		return -EPERM;
-	return remap_page_range(vma, vma->vm_start, virt_to_phys(perfctr),
+	return remap_page_range(vma, vma->vm_start, __pa(perfctr) >> PAGE_SHIFT,
 				PAGE_SIZE, vma->vm_page_prot);
 }
 
Index: mm1-2.6.8.1/drivers/sbus/char/flash.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/sbus/char/flash.c	2004-08-18 18:56:41.726351064 -0700
+++ mm1-2.6.8.1/drivers/sbus/char/flash.c	2004-08-18 18:56:54.575397712 -0700
@@ -65,7 +65,7 @@
 
 	if ((vma->vm_pgoff << PAGE_SHIFT) > size)
 		return -ENXIO;
-	addr += (vma->vm_pgoff << PAGE_SHIFT);
+	addr = (addr >> PAGE_SHIFT) + vma->vm_pgoff;
 
 	if (vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT)) > size)
 		size = vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT));
Index: mm1-2.6.8.1/drivers/usb/class/audio.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/class/audio.c	2004-08-18 18:56:41.725351216 -0700
+++ mm1-2.6.8.1/drivers/usb/class/audio.c	2004-08-18 18:56:54.576397560 -0700
@@ -509,7 +509,7 @@
 			return -EINVAL;
 	db->mapped = 1;
 	for(nr = 0; nr < size; nr++) {
-		if (remap_page_range(vma, start, virt_to_phys(db->sgbuf[nr]), PAGE_SIZE, prot))
+		if (remap_page_range(vma, start, __pa(db->sgbuf[nr]) >> PAGE_SHIFT, PAGE_SIZE, prot))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 	}
Index: mm1-2.6.8.1/drivers/usb/media/ov511.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/ov511.c	2004-08-18 18:56:41.723351520 -0700
+++ mm1-2.6.8.1/drivers/usb/media/ov511.c	2004-08-18 18:56:54.578397256 -0700
@@ -325,20 +325,6 @@
  * Memory management
  **********************************************************************/
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-static inline unsigned long
-kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
 static void *
 rvmalloc(unsigned long size)
 {
@@ -4771,7 +4757,7 @@
 
 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE,
 				     PAGE_SHARED)) {
 			up(&ov->lock);
Index: mm1-2.6.8.1/drivers/usb/media/pwc-if.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/pwc-if.c	2004-08-18 18:56:41.724351368 -0700
+++ mm1-2.6.8.1/drivers/usb/media/pwc-if.c	2004-08-18 18:56:54.579397104 -0700
@@ -191,19 +191,6 @@
 /***************************************************************************/
 /* Private functions */
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-static inline unsigned long kvirt_to_pa(unsigned long adr) 
-{
-        unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-        return ret;
-}
-
 static void * rvmalloc(unsigned long size)
 {
 	void * mem;
@@ -1588,7 +1575,7 @@
 
 	pos = (unsigned long)pdev->image_data;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 
Index: mm1-2.6.8.1/drivers/usb/media/se401.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/se401.c	2004-08-18 18:56:41.720351976 -0700
+++ mm1-2.6.8.1/drivers/usb/media/se401.c	2004-08-18 18:56:54.579397104 -0700
@@ -66,19 +66,6 @@
  *
  **********************************************************************/
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-static inline unsigned long kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
 static void *rvmalloc(unsigned long size)
 {
 	void *mem;
@@ -1182,7 +1169,7 @@
 	}
 	pos = (unsigned long)se401->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&se401->lock);
 			return -EAGAIN;
Index: mm1-2.6.8.1/drivers/usb/media/stv680.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/stv680.c	2004-08-18 18:56:41.724351368 -0700
+++ mm1-2.6.8.1/drivers/usb/media/stv680.c	2004-08-18 18:56:54.580396952 -0700
@@ -119,19 +119,6 @@
  * And the STV0680 driver - Kevin
  ********************************************************************/
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-static inline unsigned long kvirt_to_pa (unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
 static void *rvmalloc (unsigned long size)
 {
 	void *mem;
@@ -1292,7 +1279,7 @@
 	}
 	pos = (unsigned long) stv680->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa (pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range (vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up (&stv680->lock);
 			return -EAGAIN;
Index: mm1-2.6.8.1/drivers/usb/media/usbvideo.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/usbvideo.c	2004-08-18 18:56:41.725351216 -0700
+++ mm1-2.6.8.1/drivers/usb/media/usbvideo.c	2004-08-18 18:56:54.580396952 -0700
@@ -61,20 +61,6 @@
 /* Memory management functions */
 /*******************************/
 
-/*
- * Here we want the physical address of the memory.
- * This is used when initializing the contents of the area.
- */
-unsigned long usbvideo_kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
 static void *usbvideo_rvmalloc(unsigned long size)
 {
 	void *mem;
@@ -1168,7 +1154,7 @@
 
 	pos = (unsigned long) uvd->fbuf;
 	while (size > 0) {
-		page = usbvideo_kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 
Index: mm1-2.6.8.1/drivers/usb/media/vicam.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/vicam.c	2004-08-18 18:56:41.724351368 -0700
+++ mm1-2.6.8.1/drivers/usb/media/vicam.c	2004-08-18 18:56:54.581396800 -0700
@@ -351,16 +351,6 @@
 	0x46, 0x05, 0x6C, 0x05, 0x00, 0x00
 };
 
-static unsigned long kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
 /* rvmalloc / rvfree copied from usbvideo.c
  *
  * Not sure why these are not yet non-statics which I can reference through
@@ -1055,7 +1045,7 @@
 
 	pos = (unsigned long)cam->framebuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
 		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 
Index: mm1-2.6.8.1/drivers/usb/media/w9968cf.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/usb/media/w9968cf.c	2004-08-18 18:56:41.724351368 -0700
+++ mm1-2.6.8.1/drivers/usb/media/w9968cf.c	2004-08-18 18:56:54.582396648 -0700
@@ -457,7 +457,6 @@
                                unsigned long arg);
 
 /* Memory management */
-static inline unsigned long kvirt_to_pa(unsigned long adr);
 static void* rvmalloc(unsigned long size);
 static void rvfree(void *mem, unsigned long size);
 static void w9968cf_deallocate_memory(struct w9968cf_device*);
@@ -612,19 +611,6 @@
  * Memory management functions                                              *
  ****************************************************************************/
 
-/* Here we want the physical address of the memory.
-   This is used when initializing the contents of the area. */
-static inline unsigned long kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
-	ret = __pa(kva);
-	return ret;
-}
-
-
 static void* rvmalloc(unsigned long size)
 {
 	void* mem;
@@ -2919,7 +2905,7 @@
 		return -EINVAL;
 
 	while (vsize > 0) {
-		page = kvirt_to_pa(pos) + vma->vm_pgoff;
+		page = page_to_pfn(vmalloc_to_page((void *)pos))+vma->vm_pgoff;
 		if (remap_page_range(vma, start, page, PAGE_SIZE, 
 		                     vma->vm_page_prot))
 			return -EAGAIN;
Index: mm1-2.6.8.1/drivers/video/aty/atyfb_base.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/video/aty/atyfb_base.c	2004-08-18 18:56:41.712353192 -0700
+++ mm1-2.6.8.1/drivers/video/aty/atyfb_base.c	2004-08-18 18:56:54.583396496 -0700
@@ -1174,8 +1174,8 @@
 		    ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_page_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
Index: mm1-2.6.8.1/drivers/video/gbefb.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/video/gbefb.c	2004-08-18 18:56:41.712353192 -0700
+++ mm1-2.6.8.1/drivers/video/gbefb.c	2004-08-18 18:56:54.583396496 -0700
@@ -1019,7 +1019,7 @@
 			phys_size = TILE_SIZE - offset;
 
 		if (remap_page_range
-		    (vma, addr, phys_addr, phys_size, vma->vm_page_prot))
+		    (vma, addr, phys_addr >> PAGE_SHIFT, phys_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		offset = 0;
Index: mm1-2.6.8.1/drivers/video/igafb.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/video/igafb.c	2004-08-18 18:56:41.713353040 -0700
+++ mm1-2.6.8.1/drivers/video/igafb.c	2004-08-18 18:56:54.584396344 -0700
@@ -262,7 +262,7 @@
 		pgprot_val(vma->vm_page_prot) &= ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
+		if (remap_page_range(vma, vma->vm_start + page, map_offset >> PAGE_SHIFT,
 				     map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
Index: mm1-2.6.8.1/drivers/video/sgivwfb.c
===================================================================
--- mm1-2.6.8.1.orig/drivers/video/sgivwfb.c	2004-08-18 18:56:41.713353040 -0700
+++ mm1-2.6.8.1/drivers/video/sgivwfb.c	2004-08-18 18:56:54.584396344 -0700
@@ -723,7 +723,7 @@
 	    pgprot_val(vma->vm_page_prot) | _PAGE_PCD;
 	vma->vm_flags |= VM_IO;
 	if (remap_page_range
-	    (vma, vma->vm_start, offset, size, vma->vm_page_prot))
+	    (vma, vma->vm_start, offset >> PAGE_SHIFT, size, vma->vm_page_prot))
 		return -EAGAIN;
 	vma->vm_file = file;
 	printk(KERN_DEBUG "sgivwfb: mmap framebuffer P(%lx)->V(%lx)\n",
Index: mm1-2.6.8.1/include/asm-alpha/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-alpha/pgtable.h	2004-08-18 19:22:28.537200072 -0700
+++ mm1-2.6.8.1/include/asm-alpha/pgtable.h	2004-08-18 19:28:38.124014336 -0700
@@ -328,7 +328,7 @@
 #endif
 
 #define io_remap_page_range(vma, start, busaddr, size, prot) \
-    remap_page_range(vma, start, virt_to_phys(__ioremap(busaddr, size)), size, prot)
+    remap_page_range(vma, start, virt_to_phys(__ioremap(busaddr, size)) >> PAGE_SHIFT, size, prot)
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
Index: mm1-2.6.8.1/include/asm-arm/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-arm/pgtable.h	2004-08-18 18:56:41.705354256 -0700
+++ mm1-2.6.8.1/include/asm-arm/pgtable.h	2004-08-18 19:22:28.536200224 -0700
@@ -412,7 +412,7 @@
  * into virtual address `from'
  */
 #define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_page_range(vma,from,phys,size,prot)
+		remap_page_range(vma,from,(phys) >> PAGE_SHIFT,size,prot)
 
 #define pgtable_cache_init() do { } while (0)
 
Index: mm1-2.6.8.1/include/asm-arm26/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-arm26/pgtable.h	2004-08-18 19:22:28.537200072 -0700
+++ mm1-2.6.8.1/include/asm-arm26/pgtable.h	2004-08-18 19:31:42.539978848 -0700
@@ -288,7 +288,7 @@
  * into virtual address `from'
  */
 #define io_remap_page_range(vma,from,phys,size,prot) \
-		remap_page_range(vma,from,phys,size,prot)
+		remap_page_range(vma, from, (phys) >> PAGE_SHIFT, size, prot)
 
 #endif /* !__ASSEMBLY__ */
 
Index: mm1-2.6.8.1/include/asm-h8300/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-h8300/pgtable.h	2004-08-14 03:55:19.000000000 -0700
+++ mm1-2.6.8.1/include/asm-h8300/pgtable.h	2004-08-18 19:31:13.949325288 -0700
@@ -50,7 +50,8 @@
  * No page table caches to initialise
  */
 #define pgtable_cache_init()   do { } while (0)
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /*
  * All 32bit addresses are effectively valid for vmalloc...
Index: mm1-2.6.8.1/include/asm-i386/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-i386/pgtable.h	2004-08-16 23:47:17.000000000 -0700
+++ mm1-2.6.8.1/include/asm-i386/pgtable.h	2004-08-18 19:29:03.099217528 -0700
@@ -404,7 +404,8 @@
 #define kern_addr_valid(addr)	(1)
 #endif /* !CONFIG_DISCONTIGMEM */
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
Index: mm1-2.6.8.1/include/asm-ia64/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-ia64/pgtable.h	2004-08-16 23:47:15.000000000 -0700
+++ mm1-2.6.8.1/include/asm-ia64/pgtable.h	2004-08-18 19:27:11.994108072 -0700
@@ -452,7 +452,8 @@
 #define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
 #define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
 
-#define io_remap_page_range remap_page_range	/* XXX is this right? */
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
Index: mm1-2.6.8.1/include/asm-m68k/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-m68k/pgtable.h	2004-08-14 03:56:01.000000000 -0700
+++ mm1-2.6.8.1/include/asm-m68k/pgtable.h	2004-08-18 19:26:19.867032592 -0700
@@ -138,7 +138,8 @@
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /* MMU-specific headers */
 
Index: mm1-2.6.8.1/include/asm-m68knommu/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-m68knommu/pgtable.h	2004-08-14 03:55:33.000000000 -0700
+++ mm1-2.6.8.1/include/asm-m68knommu/pgtable.h	2004-08-18 19:27:40.079838392 -0700
@@ -54,7 +54,8 @@
  * No page table caches to initialise.
  */
 #define pgtable_cache_init()	do { } while (0)
-#define io_remap_page_range	remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /*
  * All 32bit addresses are effectively valid for vmalloc...
Index: mm1-2.6.8.1/include/asm-mips/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-mips/pgtable.h	2004-08-14 03:55:09.000000000 -0700
+++ mm1-2.6.8.1/include/asm-mips/pgtable.h	2004-08-18 19:25:56.131640920 -0700
@@ -245,7 +245,8 @@
  */
 #define HAVE_ARCH_UNMAPPED_AREA
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm1-2.6.8.1/include/asm-parisc/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-parisc/pgtable.h	2004-08-14 03:56:01.000000000 -0700
+++ mm1-2.6.8.1/include/asm-parisc/pgtable.h	2004-08-18 19:24:03.762723592 -0700
@@ -505,7 +505,8 @@
 
 #endif /* !__ASSEMBLY__ */
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /* We provide our own get_unmapped_area to provide cache coherency */
 
Index: mm1-2.6.8.1/include/asm-ppc/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-ppc/pgtable.h	2004-08-14 03:54:51.000000000 -0700
+++ mm1-2.6.8.1/include/asm-ppc/pgtable.h	2004-08-18 19:26:44.779245360 -0700
@@ -714,7 +714,8 @@
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm1-2.6.8.1/include/asm-ppc64/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-ppc64/pgtable.h	2004-08-14 03:56:22.000000000 -0700
+++ mm1-2.6.8.1/include/asm-ppc64/pgtable.h	2004-08-18 19:25:21.695875952 -0700
@@ -485,7 +485,8 @@
  */
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range 
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		 remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 void pgtable_cache_init(void);
 
Index: mm1-2.6.8.1/include/asm-sh/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-sh/pgtable.h	2004-08-14 03:56:24.000000000 -0700
+++ mm1-2.6.8.1/include/asm-sh/pgtable.h	2004-08-18 19:32:10.602712664 -0700
@@ -274,7 +274,8 @@
 
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 /*
  * No page table caches to initialise
Index: mm1-2.6.8.1/include/asm-sh64/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-sh64/pgtable.h	2004-08-14 03:55:48.000000000 -0700
+++ mm1-2.6.8.1/include/asm-sh64/pgtable.h	2004-08-18 19:28:13.228798984 -0700
@@ -479,7 +479,8 @@
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 #endif /* !__ASSEMBLY__ */
 
 /*
Index: mm1-2.6.8.1/include/asm-x86_64/pgtable.h
===================================================================
--- mm1-2.6.8.1.orig/include/asm-x86_64/pgtable.h	2004-08-14 03:55:48.000000000 -0700
+++ mm1-2.6.8.1/include/asm-x86_64/pgtable.h	2004-08-18 19:24:36.079810648 -0700
@@ -421,7 +421,8 @@
 
 extern int kern_addr_valid(unsigned long addr); 
 
-#define io_remap_page_range remap_page_range
+#define io_remap_page_range(vma, vaddr, phys, size, prot) \
+		 remap_page_range(vma, vaddr, (phys) >> PAGE_SHIFT, size, prot)
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
Index: mm1-2.6.8.1/mm/memory.c
===================================================================
--- mm1-2.6.8.1.orig/mm/memory.c	2004-08-18 18:56:41.704354408 -0700
+++ mm1-2.6.8.1/mm/memory.c	2004-08-18 18:56:54.585396192 -0700
@@ -931,16 +931,14 @@
  * in null mappings (currently treated as "copy-on-access")
  */
 static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+	unsigned long pfn, pgprot_t prot)
 {
 	unsigned long end;
-	unsigned long pfn;
 
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
-	pfn = phys_addr >> PAGE_SHIFT;
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
@@ -952,7 +950,7 @@
 }
 
 static inline int remap_pmd_range(struct mm_struct *mm, pmd_t * pmd, unsigned long address, unsigned long size,
-	unsigned long phys_addr, pgprot_t prot)
+	unsigned long pfn, pgprot_t prot)
 {
 	unsigned long base, end;
 
@@ -961,12 +959,12 @@
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
-	phys_addr -= address;
+	pfn -= address >> PAGE_SHIFT;
 	do {
 		pte_t * pte = pte_alloc_map(mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		remap_pte_range(pte, base + address, end - address, address + phys_addr, prot);
+		remap_pte_range(pte, base + address, end - address, pfn + (address >> PAGE_SHIFT), prot);
 		pte_unmap(pte);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
@@ -975,7 +973,7 @@
 }
 
 /*  Note: this is only safe if the mm semaphore is held when called. */
-int remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long phys_addr, unsigned long size, pgprot_t prot)
+int remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	int error = 0;
 	pgd_t * dir;
@@ -983,7 +981,7 @@
 	unsigned long end = from + size;
 	struct mm_struct *mm = vma->vm_mm;
 
-	phys_addr -= from;
+	pfn -= from >> PAGE_SHIFT;
 	dir = pgd_offset(mm, from);
 	flush_cache_range(vma, beg, end);
 	if (from >= end)
@@ -995,7 +993,7 @@
 		error = -ENOMEM;
 		if (!pmd)
 			break;
-		error = remap_pmd_range(mm, pmd, from, end - from, phys_addr + from, prot);
+		error = remap_pmd_range(mm, pmd, from, end - from, pfn + (from >> PAGE_SHIFT), prot);
 		if (error)
 			break;
 		from = (from + PGDIR_SIZE) & PGDIR_MASK;
Index: mm1-2.6.8.1/net/packet/af_packet.c
===================================================================
--- mm1-2.6.8.1.orig/net/packet/af_packet.c	2004-08-18 18:56:41.726351064 -0700
+++ mm1-2.6.8.1/net/packet/af_packet.c	2004-08-18 18:56:54.585396192 -0700
@@ -1720,7 +1720,8 @@
 	start = vma->vm_start;
 	err = -EAGAIN;
 	for (i=0; i<po->pg_vec_len; i++) {
-		if (remap_page_range(vma, start, __pa(po->pg_vec[i]),
+		if (remap_page_range(vma, start,
+				     __pa(po->pg_vec[i]) >> PAGE_SHIFT,
 				     po->pg_vec_pages*PAGE_SIZE,
 				     vma->vm_page_prot))
 			goto out;
Index: mm1-2.6.8.1/sound/oss/ali5455.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/ali5455.c	2004-08-18 18:56:41.730350456 -0700
+++ mm1-2.6.8.1/sound/oss/ali5455.c	2004-08-18 18:56:54.587395888 -0700
@@ -1956,7 +1956,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(dmabuf->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
 	dmabuf->trigger = 0;
Index: mm1-2.6.8.1/sound/oss/au1000.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/au1000.c	2004-08-18 18:56:41.729350608 -0700
+++ mm1-2.6.8.1/sound/oss/au1000.c	2004-08-18 18:56:54.587395888 -0700
@@ -1338,7 +1338,7 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf),
+	if (remap_page_range(vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
Index: mm1-2.6.8.1/sound/oss/cmpci.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/cmpci.c	2004-08-18 18:56:41.728350760 -0700
+++ mm1-2.6.8.1/sound/oss/cmpci.c	2004-08-18 18:56:54.588395736 -0700
@@ -2301,7 +2301,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EINVAL;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm1-2.6.8.1/sound/oss/cs4281/cs4281m.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/cs4281/cs4281m.c	2004-08-18 18:56:41.727350912 -0700
+++ mm1-2.6.8.1/sound/oss/cs4281/cs4281m.c	2004-08-18 18:56:54.590395432 -0700
@@ -3136,7 +3136,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		return -EINVAL;
 	if (remap_page_range
-	    (vma, vma->vm_start, virt_to_phys(db->rawbuf), size,
+	    (vma, vma->vm_start, virt_to_phys(db->rawbuf) >> PAGE_SHIFT, size,
 	     vma->vm_page_prot)) return -EAGAIN;
 	db->mapped = 1;
 
Index: mm1-2.6.8.1/sound/oss/cs46xx.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/cs46xx.c	2004-08-18 18:56:41.727350912 -0700
+++ mm1-2.6.8.1/sound/oss/cs46xx.c	2004-08-18 18:56:54.591395280 -0700
@@ -2453,8 +2453,8 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
-			     size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start,
+		__pa(dmabuf->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 	{
 		ret = -EAGAIN;
 		goto out;
Index: mm1-2.6.8.1/sound/oss/es1370.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/es1370.c	2004-08-18 18:56:41.731350304 -0700
+++ mm1-2.6.8.1/sound/oss/es1370.c	2004-08-18 18:56:54.592395128 -0700
@@ -1364,7 +1364,7 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -1940,7 +1940,7 @@
 	if (size > (PAGE_SIZE << s->dma_dac1.buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(s->dma_dac1.rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
Index: mm1-2.6.8.1/sound/oss/es1371.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/es1371.c	2004-08-18 18:56:41.729350608 -0700
+++ mm1-2.6.8.1/sound/oss/es1371.c	2004-08-18 18:56:54.593394976 -0700
@@ -1555,7 +1555,7 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -2128,7 +2128,7 @@
 	if (size > (PAGE_SIZE << s->dma_dac1.buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(s->dma_dac1.rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
Index: mm1-2.6.8.1/sound/oss/esssolo1.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/esssolo1.c	2004-08-18 18:56:41.727350912 -0700
+++ mm1-2.6.8.1/sound/oss/esssolo1.c	2004-08-18 18:56:54.594394824 -0700
@@ -1242,7 +1242,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm1-2.6.8.1/sound/oss/forte.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/forte.c	2004-08-18 18:56:41.728350760 -0700
+++ mm1-2.6.8.1/sound/oss/forte.c	2004-08-18 18:56:54.594394824 -0700
@@ -1410,7 +1410,7 @@
                 goto out;
 	}
 
-        if (remap_page_range (vma, vma->vm_start, virt_to_phys (channel->buf),
+        if (remap_page_range (vma, vma->vm_start, __pa(channel->buf) >> PAGE_SHIFT,
 			      size, vma->vm_page_prot)) {
 		DPRINTK ("%s: remap el a no worko\n", __FUNCTION__);
 		ret = -EAGAIN;
Index: mm1-2.6.8.1/sound/oss/i810_audio.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/i810_audio.c	2004-08-18 18:56:41.730350456 -0700
+++ mm1-2.6.8.1/sound/oss/i810_audio.c	2004-08-18 18:56:54.595394672 -0700
@@ -1751,7 +1751,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, __pa(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
Index: mm1-2.6.8.1/sound/oss/ite8172.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/ite8172.c	2004-08-18 18:56:41.727350912 -0700
+++ mm1-2.6.8.1/sound/oss/ite8172.c	2004-08-18 18:56:54.596394520 -0700
@@ -1311,7 +1311,7 @@
 		unlock_kernel();
 		return -EINVAL;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot)) {
 		unlock_kernel();
 		return -EAGAIN;
Index: mm1-2.6.8.1/sound/oss/maestro.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/maestro.c	2004-08-18 18:56:41.731350304 -0700
+++ mm1-2.6.8.1/sound/oss/maestro.c	2004-08-18 18:56:54.597394368 -0700
@@ -2520,7 +2520,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm1-2.6.8.1/sound/oss/maestro3.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/maestro3.c	2004-08-18 18:56:41.731350304 -0700
+++ mm1-2.6.8.1/sound/oss/maestro3.c	2004-08-18 18:56:54.598394216 -0700
@@ -1557,7 +1557,7 @@
      * ask Jeff what the hell I'm doing wrong.
      */
     ret = -EAGAIN;
-    if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+    if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
         goto out;
 
     db->mapped = 1;
Index: mm1-2.6.8.1/sound/oss/rme96xx.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/rme96xx.c	2004-08-18 18:56:41.728350760 -0700
+++ mm1-2.6.8.1/sound/oss/rme96xx.c	2004-08-18 18:56:54.599394064 -0700
@@ -1685,14 +1685,14 @@
 	if (vma->vm_flags & VM_WRITE) {
 		if (!s->started) rme96xx_startcard(s,1);
 
-		if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->outoffset*RME96xx_DMA_MAX_SIZE), size, vma->vm_page_prot)) {
+		if (remap_page_range(vma, vma->vm_start, __pa(s->playbuf + dma->outoffset*RME96xx_DMA_MAX_SIZE) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
 	} 
 	else if (vma->vm_flags & VM_READ) {
 		if (!s->started) rme96xx_startcard(s,1);
-		if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->inoffset*RME96xx_DMA_MAX_SIZE), size, vma->vm_page_prot)) {
+		if (remap_page_range(vma, vma->vm_start, __pa(s->playbuf + dma->inoffset*RME96xx_DMA_MAX_SIZE) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
Index: mm1-2.6.8.1/sound/oss/sonicvibes.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/sonicvibes.c	2004-08-18 18:56:41.728350760 -0700
+++ mm1-2.6.8.1/sound/oss/sonicvibes.c	2004-08-18 18:56:54.600393912 -0700
@@ -1549,7 +1549,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_page_range(vma, vma->vm_start, __pa(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm1-2.6.8.1/sound/oss/trident.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/trident.c	2004-08-18 18:56:41.730350456 -0700
+++ mm1-2.6.8.1/sound/oss/trident.c	2004-08-18 18:56:54.601393760 -0700
@@ -2224,7 +2224,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf), 
+	if (remap_page_range(vma, vma->vm_start, __pa(dmabuf->rawbuf) >> PAGE_SHIFT, 
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
Index: mm1-2.6.8.1/sound/oss/ymfpci.c
===================================================================
--- mm1-2.6.8.1.orig/sound/oss/ymfpci.c	2004-08-18 18:56:41.729350608 -0700
+++ mm1-2.6.8.1/sound/oss/ymfpci.c	2004-08-18 18:56:54.602393608 -0700
@@ -1545,7 +1545,7 @@
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		return -EINVAL;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, __pa(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		return -EAGAIN;
 	dmabuf->mapped = 1;
