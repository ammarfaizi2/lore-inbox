Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269266AbUIYHwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbUIYHwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbUIYHwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:52:49 -0400
Received: from holomorphy.com ([207.189.100.168]:63973 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269266AbUIYHvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:51:14 -0400
Date: Sat, 25 Sep 2004 00:51:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 3/6] convert users of remap_page_range() under drivers/ and net/ to use remap_pfn_range()
Message-ID: <20040925075102.GG9106@holomorphy.com>
References: <20040925074445.GD9106@holomorphy.com> <20040925074712.GE9106@holomorphy.com> <20040925074915.GF9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925074915.GF9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:49:15AM -0700, William Lee Irwin III wrote:
> This patch converts all callers of remap_page_range() under arch/ and
> all references in Documentation/ to use remap_pfn_range().

This patch converts all callers of remap_page_range() under arch/ and
net/ to use remap_pfn_range() instead.


Index: mm3-2.6.9-rc2/drivers/char/agp/frontend.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/agp/frontend.c	2004-09-25 00:21:50.620348728 -0700
+++ mm3-2.6.9-rc2/drivers/char/agp/frontend.c	2004-09-25 00:21:57.535297496 -0700
@@ -627,8 +627,8 @@
 		DBG("client vm_ops=%p", kerninfo.vm_ops);
 		if (kerninfo.vm_ops) {
 			vma->vm_ops = kerninfo.vm_ops;
-		} else if (remap_page_range(vma, vma->vm_start, 
-					    (kerninfo.aper_base + offset),
+		} else if (remap_pfn_range(vma, vma->vm_start, 
+				(kerninfo.aper_base + offset) >> PAGE_SHIFT,
 					    size, vma->vm_page_prot)) {
 			goto out_again;
 		}
@@ -643,8 +643,8 @@
 		DBG("controller vm_ops=%p", kerninfo.vm_ops);
 		if (kerninfo.vm_ops) {
 			vma->vm_ops = kerninfo.vm_ops;
-		} else if (remap_page_range(vma, vma->vm_start, 
-					    kerninfo.aper_base,
+		} else if (remap_pfn_range(vma, vma->vm_start, 
+					    kerninfo.aper_base >> PAGE_SHIFT,
 					    size, vma->vm_page_prot)) {
 			goto out_again;
 		}
Index: mm3-2.6.9-rc2/drivers/char/drm/drm_vm.h
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/drm/drm_vm.h	2004-09-25 00:21:50.620348728 -0700
+++ mm3-2.6.9-rc2/drivers/char/drm/drm_vm.h	2004-09-25 00:21:57.535297496 -0700
@@ -620,8 +620,8 @@
 					vma->vm_end - vma->vm_start,
 					vma->vm_page_prot, 0))
 #else
-		if (remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-				     VM_OFFSET(vma) + offset,
+		if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+				     (VM_OFFSET(vma) + offset) >> PAGE_SHIFT,
 				     vma->vm_end - vma->vm_start,
 				     vma->vm_page_prot))
 #endif
Index: mm3-2.6.9-rc2/drivers/char/drm/i810_dma.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/drm/i810_dma.c	2004-09-25 00:21:50.621348576 -0700
+++ mm3-2.6.9-rc2/drivers/char/drm/i810_dma.c	2004-09-25 00:21:57.536297344 -0700
@@ -138,8 +138,8 @@
    	buf_priv->currently_mapped = I810_BUF_MAPPED;
 	unlock_kernel();
 
-	if (remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-			     VM_OFFSET(vma),
+	if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+			     VM_OFFSET(vma) >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot)) return -EAGAIN;
 	return 0;
Index: mm3-2.6.9-rc2/drivers/char/drm/i830_dma.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/drm/i830_dma.c	2004-09-25 00:21:50.620348728 -0700
+++ mm3-2.6.9-rc2/drivers/char/drm/i830_dma.c	2004-09-25 00:21:57.537297192 -0700
@@ -139,8 +139,8 @@
    	buf_priv->currently_mapped = I830_BUF_MAPPED;
 	unlock_kernel();
 
-	if (remap_page_range(DRM_RPR_ARG(vma) vma->vm_start,
-			     VM_OFFSET(vma),
+	if (remap_pfn_range(DRM_RPR_ARG(vma) vma->vm_start,
+			     VM_OFFSET(vma) >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot)) return -EAGAIN;
 	return 0;
Index: mm3-2.6.9-rc2/drivers/char/ftape/lowlevel/ftape-ctl.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/ftape/lowlevel/ftape-ctl.c	2004-09-25 00:21:50.621348576 -0700
+++ mm3-2.6.9-rc2/drivers/char/ftape/lowlevel/ftape-ctl.c	2004-09-25 00:21:57.537297192 -0700
@@ -726,9 +726,12 @@
 		ftape_reset_buffer();
 	}
 	for (i = 0; i < num_buffers; i++) {
-		TRACE_CATCH(remap_page_range(vma, vma->vm_start +
+		unsigned long pfn;
+
+		pfn = virt_to_phys(ft_buffer[i]->address) >> PAGE_SHIFT;
+		TRACE_CATCH(remap_pfn_range(vma, vma->vm_start +
 					     i * FT_BUFF_SIZE,
-					     virt_to_phys(ft_buffer[i]->address),
+					     pfn,
 					     FT_BUFF_SIZE,
 					     vma->vm_page_prot),
 			    _res = -EAGAIN);
Index: mm3-2.6.9-rc2/drivers/char/hpet.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/hpet.c	2004-09-25 00:21:50.621348576 -0700
+++ mm3-2.6.9-rc2/drivers/char/hpet.c	2004-09-25 00:21:57.538297040 -0700
@@ -273,9 +273,9 @@
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	addr = __pa(addr);
 
-	if (remap_page_range
-	    (vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
-		printk(KERN_ERR "remap_page_range failed in hpet.c\n");
+	if (remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
+					PAGE_SIZE, vma->vm_page_prot)) {
+		printk(KERN_ERR "remap_pfn_range failed in hpet.c\n");
 		return -EAGAIN;
 	}
 
Index: mm3-2.6.9-rc2/drivers/char/mem.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/mem.c	2004-09-25 00:21:50.622348424 -0700
+++ mm3-2.6.9-rc2/drivers/char/mem.c	2004-09-25 00:21:57.538297040 -0700
@@ -227,7 +227,7 @@
 	 */
 	vma->vm_flags |= VM_RESERVED|VM_IO;
 
-	if (remap_page_range(vma, vma->vm_start, offset,
+	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
 			vma->vm_end-vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
Index: mm3-2.6.9-rc2/drivers/char/mmtimer.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/mmtimer.c	2004-09-25 00:21:50.622348424 -0700
+++ mm3-2.6.9-rc2/drivers/char/mmtimer.c	2004-09-25 00:21:57.538297040 -0700
@@ -139,7 +139,7 @@
  * @file: file structure for the device
  * @vma: VMA to map the registers into
  *
- * Calls remap_page_range() to map the clock's registers into
+ * Calls remap_pfn_range() to map the clock's registers into
  * the calling process' address space.
  */
 static int mmtimer_mmap(struct file *file, struct vm_area_struct *vma)
@@ -162,9 +162,9 @@
 	mmtimer_addr &= ~(PAGE_SIZE - 1);
 	mmtimer_addr &= 0xfffffffffffffffUL;
 
-	if (remap_page_range(vma, vma->vm_start, mmtimer_addr, PAGE_SIZE,
-			     vma->vm_page_prot)) {
-		printk(KERN_ERR "remap_page_range failed in mmtimer.c\n");
+	if (remap_pfn_range(vma, vma->vm_start, mmtimer_addr >> PAGE_SHIFT,
+					PAGE_SIZE, vma->vm_page_prot)) {
+		printk(KERN_ERR "remap_pfn_range failed in mmtimer.c\n");
 		return -EAGAIN;
 	}
 
Index: mm3-2.6.9-rc2/drivers/ieee1394/video1394.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/ieee1394/video1394.c	2004-09-25 00:21:50.622348424 -0700
+++ mm3-2.6.9-rc2/drivers/ieee1394/video1394.c	2004-09-25 00:21:57.539296888 -0700
@@ -1157,7 +1157,7 @@
  *
  *  FIXME:
  *  - PAGE_READONLY should suffice!?
- *  - remap_page_range is kind of inefficient for page by page remapping.
+ *  - remap_pfn_range is kind of inefficient for page by page remapping.
  *    But e.g. pte_alloc() does not work in modules ... :-(
  */
 
Index: mm3-2.6.9-rc2/drivers/media/video/cpia.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/media/video/cpia.c	2004-09-25 00:21:50.623348272 -0700
+++ mm3-2.6.9-rc2/drivers/media/video/cpia.c	2004-09-25 00:21:57.541296584 -0700
@@ -216,20 +216,6 @@
  * Memory management
  *
  **********************************************************************/
-
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
@@ -3795,8 +3781,8 @@
 
 	pos = (unsigned long)(cam->frame_buf);
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&cam->busy_lock);
 			return -EAGAIN;
 		}
Index: mm3-2.6.9-rc2/drivers/media/video/meye.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/media/video/meye.c	2004-09-25 00:21:50.623348272 -0700
+++ mm3-2.6.9-rc2/drivers/media/video/meye.c	2004-09-25 00:21:57.542296432 -0700
@@ -115,19 +115,6 @@
 /****************************************************************************/
 /* Memory allocation routines (stolen from bttv-driver.c)                   */
 /****************************************************************************/
-
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
@@ -1201,8 +1188,8 @@
 	pos = (unsigned long)meye.grab_fbuffer;
 
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&meye.lock);
 			return -EAGAIN;
 		}
Index: mm3-2.6.9-rc2/drivers/media/video/planb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/media/video/planb.c	2004-09-25 00:21:50.624348120 -0700
+++ mm3-2.6.9-rc2/drivers/media/video/planb.c	2004-09-25 00:21:57.543296280 -0700
@@ -1995,8 +1995,10 @@
 			return err;
 	}
 	for (i = 0; i < pb->rawbuf_size; i++) {
-		if (remap_page_range(vma, start, virt_to_phys((void *)pb->rawbuf[i]),
-						PAGE_SIZE, PAGE_SHARED))
+		unsigned long pfn;
+
+		pfn = virt_to_phys((void *)pb->rawbuf[i]) >> PAGE_SHIFT;
+		if (remap_pfn_range(vma, start, pfn, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 		if (size <= PAGE_SIZE)
Index: mm3-2.6.9-rc2/drivers/media/video/zoran_driver.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/media/video/zoran_driver.c	2004-09-25 00:21:50.625347968 -0700
+++ mm3-2.6.9-rc2/drivers/media/video/zoran_driver.c	2004-09-25 00:21:57.544296128 -0700
@@ -4448,12 +4448,6 @@
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
@@ -4553,12 +4547,14 @@
 				pos =
 				    (unsigned long) fh->jpg_buffers.
 				    buffer[i].frag_tab[2 * j];
-				page = virt_to_phys(bus_to_virt(pos));	/* should just be pos on i386 */
-				if (zr_remap_page_range
-				    (vma, start, page, todo, PAGE_SHARED)) {
+				/* should just be pos on i386 */
+				page = virt_to_phys(bus_to_virt(pos))
+								>> PAGE_SHIFT;
+				if (remap_pfn_range(vma, start, page,
+							todo, PAGE_SHARED)) {
 					dprintk(1,
 						KERN_ERR
-						"%s: zoran_mmap(V4L) - remap_page_range failed\n",
+						"%s: zoran_mmap(V4L) - remap_pfn_range failed\n",
 						ZR_DEVNAME(zr));
 					res = -EAGAIN;
 					goto jpg_mmap_unlock_and_return;
@@ -4639,11 +4635,11 @@
 			if (todo > fh->v4l_buffers.buffer_size)
 				todo = fh->v4l_buffers.buffer_size;
 			page = fh->v4l_buffers.buffer[i].fbuffer_phys;
-			if (zr_remap_page_range
-			    (vma, start, page, todo, PAGE_SHARED)) {
+			if (remap_pfn_range(vma, start, page >> PAGE_SHIFT,
+							todo, PAGE_SHARED)) {
 				dprintk(1,
 					KERN_ERR
-					"%s: zoran_mmap(V4L)i - remap_page_range failed\n",
+					"%s: zoran_mmap(V4L)i - remap_pfn_range failed\n",
 					ZR_DEVNAME(zr));
 				res = -EAGAIN;
 				goto v4l_mmap_unlock_and_return;
Index: mm3-2.6.9-rc2/drivers/media/video/zr36120.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/media/video/zr36120.c	2004-09-25 00:21:50.625347968 -0700
+++ mm3-2.6.9-rc2/drivers/media/video/zr36120.c	2004-09-25 00:21:57.545295976 -0700
@@ -1474,8 +1474,8 @@
 	/* start mapping the whole shabang to user memory */
 	pos = (unsigned long)ztv->fbuffer;
 	while (size>0) {
-		unsigned long page = virt_to_phys((void*)pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+		unsigned long pfn = virt_to_phys((void*)pos) >> PAGE_SHIFT;
+		if (remap_pfn_range(vma, start, pfn, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 		pos += PAGE_SIZE;
Index: mm3-2.6.9-rc2/drivers/perfctr/virtual.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/perfctr/virtual.c	2004-09-25 00:21:50.626347816 -0700
+++ mm3-2.6.9-rc2/drivers/perfctr/virtual.c	2004-09-25 00:21:57.546295824 -0700
@@ -720,7 +720,8 @@
 	perfctr = filp->private_data;
 	if (!perfctr)
 		return -EPERM;
-	return remap_page_range(vma, vma->vm_start, virt_to_phys(perfctr),
+	return remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(perfctr) >> PAGE_SHIFT,
 				PAGE_SIZE, vma->vm_page_prot);
 }
 
Index: mm3-2.6.9-rc2/drivers/sbus/char/flash.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/sbus/char/flash.c	2004-09-25 00:21:50.626347816 -0700
+++ mm3-2.6.9-rc2/drivers/sbus/char/flash.c	2004-09-25 00:21:57.546295824 -0700
@@ -66,7 +66,7 @@
 
 	if ((vma->vm_pgoff << PAGE_SHIFT) > size)
 		return -ENXIO;
-	addr += (vma->vm_pgoff << PAGE_SHIFT);
+	addr = vma->vm_pgoff + (addr >> PAGE_SHIFT);
 
 	if (vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT)) > size)
 		size = vma->vm_end - (vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT));
@@ -75,7 +75,7 @@
 	pgprot_val(vma->vm_page_prot) |= _PAGE_E;
 	vma->vm_flags |= (VM_SHM | VM_LOCKED);
 
-	if (remap_page_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
 		return -EAGAIN;
 		
 	return 0;
Index: mm3-2.6.9-rc2/drivers/sbus/char/jsflash.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/sbus/char/jsflash.c	2004-09-25 00:21:50.626347816 -0700
+++ mm3-2.6.9-rc2/drivers/sbus/char/jsflash.c	2004-09-25 00:21:57.546295824 -0700
@@ -21,7 +21,7 @@
  * as a silly safeguard.
  *
  * XXX The flash.c manipulates page caching characteristics in a certain
- * dubious way; also it assumes that remap_page_range() can remap
+ * dubious way; also it assumes that remap_pfn_range() can remap
  * PCI bus locations, which may be false. ioremap() must be used
  * instead. We should discuss this.
  */
Index: mm3-2.6.9-rc2/drivers/usb/class/audio.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/class/audio.c	2004-09-25 00:21:50.627347664 -0700
+++ mm3-2.6.9-rc2/drivers/usb/class/audio.c	2004-09-25 00:21:57.548295520 -0700
@@ -509,7 +509,10 @@
 			return -EINVAL;
 	db->mapped = 1;
 	for(nr = 0; nr < size; nr++) {
-		if (remap_page_range(vma, start, virt_to_phys(db->sgbuf[nr]), PAGE_SIZE, prot))
+		unsigned long pfn;
+
+		pfn = virt_to_phys(db->sgbuf[nr]) >> PAGE_SHIFT;
+		if (remap_pfn_range(vma, start, pfn, PAGE_SIZE, prot))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 	}
Index: mm3-2.6.9-rc2/drivers/usb/media/ov511.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/ov511.c	2004-09-25 00:21:50.628347512 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/ov511.c	2004-09-25 00:21:57.550295216 -0700
@@ -324,21 +324,6 @@
 /**********************************************************************
  * Memory management
  **********************************************************************/
-
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
@@ -4771,9 +4756,8 @@
 
 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE,
-				     PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&ov->lock);
 			return -EAGAIN;
 		}
Index: mm3-2.6.9-rc2/drivers/usb/media/se401.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/se401.c	2004-09-25 00:21:50.628347512 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/se401.c	2004-09-25 00:21:57.551295064 -0700
@@ -65,20 +65,6 @@
  * Memory management
  *
  **********************************************************************/
-
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
@@ -1182,8 +1168,8 @@
 	}
 	pos = (unsigned long)se401->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&se401->lock);
 			return -EAGAIN;
 		}
Index: mm3-2.6.9-rc2/drivers/usb/media/sn9c102_core.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/sn9c102_core.c	2004-09-25 00:21:50.628347512 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/sn9c102_core.c	2004-09-25 00:21:57.552294912 -0700
@@ -101,18 +101,6 @@
 };
 
 /*****************************************************************************/
-
-static inline unsigned long kvirt_to_pa(unsigned long adr)
-{
-	unsigned long kva, ret;
-
-	kva = (unsigned long)page_address(vmalloc_to_page((void *)adr));
-	kva |= adr & (PAGE_SIZE-1);
-	ret = __pa(kva);
-	return ret;
-}
-
-
 static void* rvmalloc(size_t size)
 {
 	void* mem;
@@ -1568,8 +1556,8 @@
 
 	pos = (unsigned long)cam->frame[i].bufmem;
 	while (size > 0) { /* size is page-aligned */
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, 
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, 
 		                     vma->vm_page_prot)) {
 			up(&cam->fileop_sem);
 			return -EAGAIN;
Index: mm3-2.6.9-rc2/drivers/usb/media/stv680.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/stv680.c	2004-09-25 00:21:50.629347360 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/stv680.c	2004-09-25 00:21:57.553294760 -0700
@@ -118,20 +118,6 @@
  *
  * And the STV0680 driver - Kevin
  ********************************************************************/
-
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
@@ -1291,8 +1277,8 @@
 	}
 	pos = (unsigned long) stv680->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa (pos);
-		if (remap_page_range (vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up (&stv680->lock);
 			return -EAGAIN;
 		}
Index: mm3-2.6.9-rc2/drivers/usb/media/usbvideo.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/usbvideo.c	2004-09-25 00:21:50.629347360 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/usbvideo.c	2004-09-25 00:21:57.554294608 -0700
@@ -60,21 +60,6 @@
 /*******************************/
 /* Memory management functions */
 /*******************************/
-
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
@@ -1168,8 +1153,8 @@
 
 	pos = (unsigned long) uvd->fbuf;
 	while (size > 0) {
-		page = usbvideo_kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 
 		start += PAGE_SIZE;
Index: mm3-2.6.9-rc2/drivers/usb/media/vicam.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/vicam.c	2004-09-25 00:21:50.630347208 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/vicam.c	2004-09-25 00:21:57.554294608 -0700
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
@@ -1055,8 +1045,8 @@
 
 	pos = (unsigned long)cam->framebuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 
 		start += PAGE_SIZE;
Index: mm3-2.6.9-rc2/drivers/usb/media/w9968cf.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/usb/media/w9968cf.c	2004-09-25 00:21:50.630347208 -0700
+++ mm3-2.6.9-rc2/drivers/usb/media/w9968cf.c	2004-09-25 00:21:57.556294304 -0700
@@ -457,7 +457,6 @@
                                unsigned long arg);
 
 /* Memory management */
-static inline unsigned long kvirt_to_pa(unsigned long adr);
 static void* rvmalloc(unsigned long size);
 static void rvfree(void *mem, unsigned long size);
 static void w9968cf_deallocate_memory(struct w9968cf_device*);
@@ -611,20 +610,6 @@
 /****************************************************************************
  * Memory management functions                                              *
  ****************************************************************************/
-
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
@@ -2919,9 +2904,9 @@
 		return -EINVAL;
 
 	while (vsize > 0) {
-		page = kvirt_to_pa(pos) + vma->vm_pgoff;
-		if (remap_page_range(vma, start, page, PAGE_SIZE, 
-		                     vma->vm_page_prot))
+		page = page_to_pfn(vmalloc_to_page((void *)pos));
+		if (remap_pfn_range(vma, start, page + vma->vm_pgoff,
+						PAGE_SIZE, vma->vm_page_prot))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 		pos += PAGE_SIZE;
Index: mm3-2.6.9-rc2/drivers/video/aty/atyfb_base.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/aty/atyfb_base.c	2004-09-25 00:21:53.509909448 -0700
+++ mm3-2.6.9-rc2/drivers/video/aty/atyfb_base.c	2004-09-25 00:22:01.383712448 -0700
@@ -1174,8 +1174,8 @@
 		    ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
Index: mm3-2.6.9-rc2/drivers/video/gbefb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/gbefb.c	2004-09-25 00:15:57.556022664 -0700
+++ mm3-2.6.9-rc2/drivers/video/gbefb.c	2004-09-25 00:22:23.818301872 -0700
@@ -1018,8 +1018,8 @@
 		else
 			phys_size = TILE_SIZE - offset;
 
-		if (remap_page_range
-		    (vma, addr, phys_addr, phys_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, addr, phys_addr >> PAGE_SHIFT,
+						phys_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		offset = 0;
Index: mm3-2.6.9-rc2/drivers/video/igafb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/igafb.c	2004-09-25 00:15:56.984109608 -0700
+++ mm3-2.6.9-rc2/drivers/video/igafb.c	2004-09-25 00:22:27.153794800 -0700
@@ -262,8 +262,8 @@
 		pgprot_val(vma->vm_page_prot) &= ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
Index: mm3-2.6.9-rc2/drivers/video/sgivwfb.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/video/sgivwfb.c	2004-09-25 00:15:57.032102312 -0700
+++ mm3-2.6.9-rc2/drivers/video/sgivwfb.c	2004-09-25 00:22:31.619115968 -0700
@@ -719,8 +719,8 @@
 	pgprot_val(vma->vm_page_prot) =
 	    pgprot_val(vma->vm_page_prot) | _PAGE_PCD;
 	vma->vm_flags |= VM_IO;
-	if (remap_page_range
-	    (vma, vma->vm_start, offset, size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
+						size, vma->vm_page_prot))
 		return -EAGAIN;
 	vma->vm_file = file;
 	printk(KERN_DEBUG "sgivwfb: mmap framebuffer P(%lx)->V(%lx)\n",
Index: mm3-2.6.9-rc2/net/packet/af_packet.c
===================================================================
--- mm3-2.6.9-rc2.orig/net/packet/af_packet.c	2004-09-25 00:15:55.365355696 -0700
+++ mm3-2.6.9-rc2/net/packet/af_packet.c	2004-09-25 00:28:17.338558624 -0700
@@ -1729,7 +1729,8 @@
 	start = vma->vm_start;
 	err = -EAGAIN;
 	for (i=0; i<po->pg_vec_len; i++) {
-		if (remap_page_range(vma, start, __pa(po->pg_vec[i]),
+		if (remap_pfn_range(vma, start,
+				     __pa(po->pg_vec[i]) >> PAGE_SHIFT,
 				     po->pg_vec_pages*PAGE_SIZE,
 				     vma->vm_page_prot))
 			goto out;
