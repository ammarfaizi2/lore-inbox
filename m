Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUIXCmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUIXCmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUIXCjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 22:39:15 -0400
Received: from holomorphy.com ([207.189.100.168]:4572 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267597AbUIXC3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 22:29:03 -0400
Date: Thu, 23 Sep 2004 19:23:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Fusco <fusco_john@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [vm 3/4] convert direct callers of remap_page_range()
Message-ID: <20040924022329.GO9106@holomorphy.com>
References: <41535AAE.6090700@yahoo.com> <20040924021735.GL9106@holomorphy.com> <20040924021954.GM9106@holomorphy.com> <20040924022123.GN9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924022123.GN9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 07:21:23PM -0700, William Lee Irwin III wrote:
> Eliminate callers of remap_page_range() via io_remap_page_range().

Eliminate direct callers of remap_page_range().

Index: mm2-2.6.9-rc2/drivers/media/video/zr36120.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/media/video/zr36120.c	2004-09-12 22:32:43.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/media/video/zr36120.c	2004-09-23 17:16:04.781739170 -0700
@@ -1475,8 +1475,8 @@
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
Index: mm2-2.6.9-rc2/drivers/video/igafb.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/video/igafb.c	2004-09-22 21:32:44.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/video/igafb.c	2004-09-23 17:14:23.788092538 -0700
@@ -262,8 +262,8 @@
 		pgprot_val(vma->vm_page_prot) &= ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
Index: mm2-2.6.9-rc2/drivers/video/sgivwfb.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/video/sgivwfb.c	2004-09-22 21:31:18.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/video/sgivwfb.c	2004-09-23 17:13:49.395321034 -0700
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
Index: mm2-2.6.9-rc2/drivers/video/aty/atyfb_base.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/video/aty/atyfb_base.c	2004-09-22 21:32:44.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/video/aty/atyfb_base.c	2004-09-23 17:12:40.124851746 -0700
@@ -1174,8 +1174,8 @@
 		    ~(par->mmap_map[i].prot_mask);
 		pgprot_val(vma->vm_page_prot) |= par->mmap_map[i].prot_flag;
 
-		if (remap_page_range(vma, vma->vm_start + page, map_offset,
-				     map_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, vma->vm_start + page,
+			map_offset >> PAGE_SHIFT, map_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		page += map_size;
Index: mm2-2.6.9-rc2/drivers/video/gbefb.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/video/gbefb.c	2004-09-22 21:31:18.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/video/gbefb.c	2004-09-23 17:13:23.384275314 -0700
@@ -1018,8 +1018,8 @@
 		else
 			phys_size = TILE_SIZE - offset;
 
-		if (remap_page_range
-		    (vma, addr, phys_addr, phys_size, vma->vm_page_prot))
+		if (remap_pfn_range(vma, addr, phys_addr >> PAGE_SHIFT,
+						phys_size, vma->vm_page_prot))
 			return -EAGAIN;
 
 		offset = 0;
Index: mm2-2.6.9-rc2/drivers/media/video/cpia.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/media/video/cpia.c	2004-09-12 22:32:56.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/media/video/cpia.c	2004-09-23 18:22:48.372100922 -0700
@@ -215,20 +215,6 @@
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
@@ -3800,8 +3786,8 @@
 
 	pos = (unsigned long)(cam->frame_buf);
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&cam->busy_lock);
 			return -EAGAIN;
 		}
Index: mm2-2.6.9-rc2/drivers/media/video/meye.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/media/video/meye.c	2004-09-12 22:32:54.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/media/video/meye.c	2004-09-23 18:21:10.792935210 -0700
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
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&meye.lock);
 			return -EAGAIN;
 		}
Index: mm2-2.6.9-rc2/drivers/media/video/zoran_driver.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/media/video/zoran_driver.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/media/video/zoran_driver.c	2004-09-23 18:26:07.463834378 -0700
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
@@ -4555,12 +4549,13 @@
 				pos =
 				    (unsigned long) fh->jpg_buffers.
 				    buffer[i].frag_tab[2 * j];
-				page = virt_to_phys(bus_to_virt(pos));	/* should just be pos on i386 */
-				if (zr_remap_page_range
-				    (vma, start, page, todo, PAGE_SHARED)) {
+				/* should just be pos >> PAGE_SHIFT on i386 */
+				page = virt_to_phys(bus_to_virt(pos));
+				page >>= PAGE_SHIFT;
+				if (remap_pfn_range(vma, start, page, todo, PAGE_SHARED)) {
 					dprintk(1,
 						KERN_ERR
-						"%s: zoran_mmap(V4L) - remap_page_range failed\n",
+						"%s: zoran_mmap(V4L) - remap_pfn_range failed\n",
 						ZR_DEVNAME(zr));
 					res = -EAGAIN;
 					goto jpg_mmap_unlock_and_return;
@@ -4641,11 +4636,11 @@
 			if (todo > fh->v4l_buffers.buffer_size)
 				todo = fh->v4l_buffers.buffer_size;
 			page = fh->v4l_buffers.buffer[i].fbuffer_phys;
-			if (zr_remap_page_range
-			    (vma, start, page, todo, PAGE_SHARED)) {
+			page >>= PAGE_SHIFT
+			if (remap_pfn_range(vma, start, page, todo, PAGE_SHARED)) {
 				dprintk(1,
 					KERN_ERR
-					"%s: zoran_mmap(V4L)i - remap_page_range failed\n",
+					"%s: zoran_mmap(V4L)i - remap_pfn_range failed\n",
 					ZR_DEVNAME(zr));
 				res = -EAGAIN;
 				goto v4l_mmap_unlock_and_return;
Index: mm2-2.6.9-rc2/drivers/char/mem.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/mem.c	2004-09-22 21:32:14.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/mem.c	2004-09-23 18:42:29.540536026 -0700
@@ -227,8 +227,8 @@
 	 */
 	vma->vm_flags |= VM_RESERVED|VM_IO;
 
-	if (remap_page_range(vma, vma->vm_start, offset,
-			vma->vm_end-vma->vm_start, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
+				vma->vm_end-vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
 }
Index: mm2-2.6.9-rc2/drivers/char/ftape/lowlevel/ftape-ctl.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/ftape/lowlevel/ftape-ctl.c	2004-09-12 22:33:37.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/ftape/lowlevel/ftape-ctl.c	2004-09-23 18:27:51.194064986 -0700
@@ -726,9 +726,9 @@
 		ftape_reset_buffer();
 	}
 	for (i = 0; i < num_buffers; i++) {
-		TRACE_CATCH(remap_page_range(vma, vma->vm_start +
+		TRACE_CATCH(remap_pfn_range(vma, vma->vm_start +
 					     i * FT_BUFF_SIZE,
-					     virt_to_phys(ft_buffer[i]->address),
+					     virt_to_phys(ft_buffer[i]->address) >> PAGE_SHIFT,
 					     FT_BUFF_SIZE,
 					     vma->vm_page_prot),
 			    _res = -EAGAIN);
Index: mm2-2.6.9-rc2/drivers/media/video/planb.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/media/video/planb.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/media/video/planb.c	2004-09-23 18:27:05.632991322 -0700
@@ -1996,7 +1996,8 @@
 			return err;
 	}
 	for (i = 0; i < pb->rawbuf_size; i++) {
-		if (remap_page_range(vma, start, virt_to_phys((void *)pb->rawbuf[i]),
+		if (remap_pfn_range(vma, start,
+			virt_to_phys((void *)pb->rawbuf[i]) >> PAGE_SHIFT,
 						PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 		start += PAGE_SIZE;
Index: mm2-2.6.9-rc2/drivers/char/drm/i830_dma.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/drm/i830_dma.c	2004-09-22 21:31:13.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/drm/i830_dma.c	2004-09-23 18:43:08.769572306 -0700
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
Index: mm2-2.6.9-rc2/drivers/char/hpet.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/hpet.c	2004-09-12 22:32:54.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/hpet.c	2004-09-23 18:32:04.475560346 -0700
@@ -271,11 +271,11 @@
 
 	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	addr = __pa(addr);
+	addr = __pa(addr) >> PAGE_SHIFT;
 
-	if (remap_page_range
-	    (vma, vma->vm_start, addr, PAGE_SIZE, vma->vm_page_prot)) {
-		printk(KERN_ERR "remap_page_range failed in hpet.c\n");
+	if (remap_pfn_range(vma, vma->vm_start, addr, PAGE_SIZE,
+							vma->vm_page_prot)) {
+		printk(KERN_ERR "remap_pfn_range failed in hpet.c\n");
 		return -EAGAIN;
 	}
 
Index: mm2-2.6.9-rc2/drivers/char/agp/frontend.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/agp/frontend.c	2004-09-12 22:31:44.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/agp/frontend.c	2004-09-23 18:30:18.515668698 -0700
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
Index: mm2-2.6.9-rc2/drivers/char/drm/i810_dma.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/drm/i810_dma.c	2004-09-22 21:31:13.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/drm/i810_dma.c	2004-09-23 18:43:26.510875218 -0700
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
Index: mm2-2.6.9-rc2/drivers/char/drm/drm_vm.h
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/drm/drm_vm.h	2004-09-12 22:33:39.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/drm/drm_vm.h	2004-09-23 18:43:53.647749786 -0700
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
Index: mm2-2.6.9-rc2/drivers/perfctr/virtual.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/perfctr/virtual.c	2004-09-22 21:31:46.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/perfctr/virtual.c	2004-09-23 18:40:42.781765826 -0700
@@ -720,7 +720,8 @@
 	perfctr = filp->private_data;
 	if (!perfctr)
 		return -EPERM;
-	return remap_page_range(vma, vma->vm_start, virt_to_phys(perfctr),
+	return remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(perfctr) >> PAGE_SHIFT,
 				PAGE_SIZE, vma->vm_page_prot);
 }
 
Index: mm2-2.6.9-rc2/drivers/sbus/char/flash.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/sbus/char/flash.c	2004-09-22 21:31:13.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/sbus/char/flash.c	2004-09-23 18:40:15.670887306 -0700
@@ -75,7 +75,8 @@
 	pgprot_val(vma->vm_page_prot) |= _PAGE_E;
 	vma->vm_flags |= (VM_SHM | VM_LOCKED);
 
-	if (remap_page_range(vma, vma->vm_start, addr, size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
+						size, vma->vm_page_prot))
 		return -EAGAIN;
 		
 	return 0;
Index: mm2-2.6.9-rc2/drivers/usb/media/ov511.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/media/ov511.c	2004-09-22 21:31:31.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/media/ov511.c	2004-09-23 18:35:48.885444858 -0700
@@ -4771,9 +4771,8 @@
 
 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
-		page = kvirt_to_pa(pos);
-		if (remap_page_range(vma, start, page, PAGE_SIZE,
-				     PAGE_SHARED)) {
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&ov->lock);
 			return -EAGAIN;
 		}
Index: mm2-2.6.9-rc2/drivers/usb/media/se401.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/media/se401.c	2004-09-22 21:31:31.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/media/se401.c	2004-09-23 18:35:23.295335146 -0700
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
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up(&se401->lock);
 			return -EAGAIN;
 		}
Index: mm2-2.6.9-rc2/arch/ppc/kernel/pci.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/ppc/kernel/pci.c	2004-09-22 21:32:58.000000000 -0700
+++ mm2-2.6.9-rc2/arch/ppc/kernel/pci.c	2004-09-23 18:41:46.463084794 -0700
@@ -1595,7 +1595,7 @@
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
-	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 
 	return ret;
Index: mm2-2.6.9-rc2/drivers/usb/media/sn9c102_core.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/media/sn9c102_core.c	2004-09-22 21:31:31.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/media/sn9c102_core.c	2004-09-23 18:34:50.744283658 -0700
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
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, 
 		                     vma->vm_page_prot)) {
 			up(&cam->fileop_sem);
 			return -EAGAIN;
Index: mm2-2.6.9-rc2/drivers/usb/class/audio.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/class/audio.c	2004-09-22 21:31:30.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/class/audio.c	2004-09-23 18:38:32.261607906 -0700
@@ -509,7 +509,7 @@
 			return -EINVAL;
 	db->mapped = 1;
 	for(nr = 0; nr < size; nr++) {
-		if (remap_page_range(vma, start, virt_to_phys(db->sgbuf[nr]), PAGE_SIZE, prot))
+		if (remap_pfn_range(vma, start, virt_to_phys(db->sgbuf[nr]) >> PAGE_SHIFT, PAGE_SIZE, prot))
 			return -EAGAIN;
 		start += PAGE_SIZE;
 	}
Index: mm2-2.6.9-rc2/drivers/usb/media/w9968cf.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/media/w9968cf.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/media/w9968cf.c	2004-09-23 18:38:05.856622074 -0700
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
@@ -2919,8 +2904,8 @@
 		return -EINVAL;
 
 	while (vsize > 0) {
-		page = kvirt_to_pa(pos) + vma->vm_pgoff;
-		if (remap_page_range(vma, start, page, PAGE_SIZE, 
+		page = page_to_pfn(vmalloc_to_page(pos)) + vma->vm_pgoff;
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, 
 		                     vma->vm_page_prot))
 			return -EAGAIN;
 		start += PAGE_SIZE;
Index: mm2-2.6.9-rc2/drivers/ieee1394/video1394.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/ieee1394/video1394.c	2004-09-12 22:31:44.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/ieee1394/video1394.c	2004-09-23 18:39:11.813595090 -0700
@@ -1157,7 +1157,7 @@
  *
  *  FIXME:
  *  - PAGE_READONLY should suffice!?
- *  - remap_page_range is kind of inefficient for page by page remapping.
+ *  - remap_pfn_range is kind of inefficient for page by page remapping.
  *    But e.g. pte_alloc() does not work in modules ... :-(
  */
 
Index: mm2-2.6.9-rc2/net/packet/af_packet.c
===================================================================
--- mm2-2.6.9-rc2.orig/net/packet/af_packet.c	2004-09-12 22:32:55.000000000 -0700
+++ mm2-2.6.9-rc2/net/packet/af_packet.c	2004-09-23 18:41:11.100460730 -0700
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
Index: mm2-2.6.9-rc2/drivers/usb/media/vicam.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/media/vicam.c	2004-09-12 22:32:00.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/media/vicam.c	2004-09-23 18:36:41.779403754 -0700
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
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
 			return -EAGAIN;
 
 		start += PAGE_SIZE;
Index: mm2-2.6.9-rc2/drivers/char/mmtimer.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/char/mmtimer.c	2004-09-22 21:31:16.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/char/mmtimer.c	2004-09-23 18:33:49.800548514 -0700
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
 
Index: mm2-2.6.9-rc2/drivers/usb/media/stv680.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/usb/media/stv680.c	2004-09-22 21:31:31.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/usb/media/stv680.c	2004-09-23 18:37:21.838313874 -0700
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
+		page = page_to_pfn(vmalloc_to_page(pos));
+		if (remap_pfn_range (vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
 			up (&stv680->lock);
 			return -EAGAIN;
 		}
Index: mm2-2.6.9-rc2/drivers/sbus/char/jsflash.c
===================================================================
--- mm2-2.6.9-rc2.orig/drivers/sbus/char/jsflash.c	2004-09-12 22:32:26.000000000 -0700
+++ mm2-2.6.9-rc2/drivers/sbus/char/jsflash.c	2004-09-23 18:39:32.934384242 -0700
@@ -21,7 +21,7 @@
  * as a silly safeguard.
  *
  * XXX The flash.c manipulates page caching characteristics in a certain
- * dubious way; also it assumes that remap_page_range() can remap
+ * dubious way; also it assumes that remap_pfn_range() can remap
  * PCI bus locations, which may be false. ioremap() must be used
  * instead. We should discuss this.
  */
Index: mm2-2.6.9-rc2/arch/sparc/mm/generic.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/sparc/mm/generic.c	2004-09-12 22:33:23.000000000 -0700
+++ mm2-2.6.9-rc2/arch/sparc/mm/generic.c	2004-09-23 18:52:35.038486346 -0700
@@ -41,7 +41,7 @@
 #endif
 }
 
-/* Remap IO memory, the same way as remap_page_range(), but use
+/* Remap IO memory, the same way as remap_pfn_range(), but use
  * the obio memory space.
  *
  * They use a pgprot that sets PAGE_IO and does not check the
Index: mm2-2.6.9-rc2/sound/oss/es1371.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/es1371.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/es1371.c	2004-09-23 19:04:22.976863354 -0700
@@ -910,7 +910,7 @@
 		if (!db->rawbuf)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1555,7 +1555,9 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -2128,7 +2130,9 @@
 	if (size > (PAGE_SIZE << s->dma_dac1.buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(s->dma_dac1.rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
Index: mm2-2.6.9-rc2/sound/oss/forte.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/forte.c	2004-09-12 22:32:16.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/forte.c	2004-09-23 19:00:28.927444274 -0700
@@ -1409,7 +1409,8 @@
                 goto out;
 	}
 
-        if (remap_page_range (vma, vma->vm_start, virt_to_phys (channel->buf),
+        if (remap_pfn_range(vma, vma->vm_start,
+			      virt_to_phys(channel->buf) >> PAGE_SHIFT,
 			      size, vma->vm_page_prot)) {
 		DPRINTK ("%s: remap el a no worko\n", __FUNCTION__);
 		ret = -EAGAIN;
Index: mm2-2.6.9-rc2/sound/oss/cs4281/cs4281m.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/cs4281/cs4281m.c	2004-09-12 22:33:38.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/cs4281/cs4281m.c	2004-09-23 18:58:56.406509594 -0700
@@ -1755,7 +1755,7 @@
 		}
 		db->buforder = order;
 		// Now mark the pages as reserved; otherwise the 
-		// remap_page_range() in cs4281_mmap doesn't work.
+		// remap_pfn_range() in cs4281_mmap doesn't work.
 		// 1. get index to last page in mem_map array for rawbuf.
 		mapend = virt_to_page(db->rawbuf + 
 			(PAGE_SIZE << db->buforder) - 1);
@@ -1778,7 +1778,7 @@
 		}
 		s->buforder_tmpbuff = order;
 		// Now mark the pages as reserved; otherwise the 
-		// remap_page_range() in cs4281_mmap doesn't work.
+		// remap_pfn_range() in cs4281_mmap doesn't work.
 		// 1. get index to last page in mem_map array for rawbuf.
 		mapend = virt_to_page(s->tmpbuff + 
 				(PAGE_SIZE << s->buforder_tmpbuff) - 1);
@@ -3135,9 +3135,10 @@
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
 		return -EINVAL;
-	if (remap_page_range
-	    (vma, vma->vm_start, virt_to_phys(db->rawbuf), size,
-	     vma->vm_page_prot)) return -EAGAIN;
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
+		return -EAGAIN;
 	db->mapped = 1;
 
 	CS_DBGOUT(CS_FUNCTION | CS_PARMS | CS_OPEN, 4,
Index: mm2-2.6.9-rc2/arch/ia64/pci/pci.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/ia64/pci/pci.c	2004-09-22 21:32:58.000000000 -0700
+++ mm2-2.6.9-rc2/arch/ia64/pci/pci.c	2004-09-23 18:56:00.210295490 -0700
@@ -498,7 +498,7 @@
 	else
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 
Index: mm2-2.6.9-rc2/sound/oss/au1000.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/au1000.c	2004-09-12 22:32:55.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/au1000.c	2004-09-23 19:03:18.190712346 -0700
@@ -629,7 +629,7 @@
 			return -ENOMEM;
 		db->buforder = order;
 		/* now mark the pages as reserved;
-		   otherwise remap_page_range doesn't do what we want */
+		   otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf +
 				    (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
@@ -1338,7 +1338,8 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma->vm_start, virt_to_phys(db->rawbuf),
+	if (remap_pfn_range(vma->vm_start,
+			     virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
Index: mm2-2.6.9-rc2/sound/oss/cs46xx.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/cs46xx.c	2004-09-12 22:31:26.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/cs46xx.c	2004-09-23 18:57:27.361046562 -0700
@@ -1190,7 +1190,7 @@
 	dmabuf->buforder = order;
 	dmabuf->rawbuf = rawbuf;
 	// Now mark the pages as reserved; otherwise the 
-	// remap_page_range() in cs46xx_mmap doesn't work.
+	// remap_pfn_range() in cs46xx_mmap doesn't work.
 	// 1. get index to last page in mem_map array for rawbuf.
 	mapend = virt_to_page(dmabuf->rawbuf + 
 		(PAGE_SIZE << dmabuf->buforder) - 1);
@@ -1227,7 +1227,7 @@
 	dmabuf->buforder_tmpbuff = order;
 	
 	// Now mark the pages as reserved; otherwise the 
-	// remap_page_range() in cs46xx_mmap doesn't work.
+	// remap_pfn_range() in cs46xx_mmap doesn't work.
 	// 1. get index to last page in mem_map array for rawbuf.
 	mapend = virt_to_page(dmabuf->tmpbuff + 
 		(PAGE_SIZE << dmabuf->buforder_tmpbuff) - 1);
@@ -2452,7 +2452,8 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 	{
 		ret = -EAGAIN;
Index: mm2-2.6.9-rc2/sound/oss/esssolo1.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/esssolo1.c	2004-09-12 22:31:43.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/esssolo1.c	2004-09-23 18:59:24.483241282 -0700
@@ -445,7 +445,7 @@
 		if (!db->rawbuf)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1242,7 +1242,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm2-2.6.9-rc2/arch/ppc/kernel/machine_kexec.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/ppc/kernel/machine_kexec.c	2004-09-22 21:32:12.000000000 -0700
+++ mm2-2.6.9-rc2/arch/ppc/kernel/machine_kexec.c	2004-09-23 18:52:16.553296522 -0700
@@ -56,8 +56,10 @@
 	vma->vm_private_data = NULL;
 	insert_vm_struct(mm, vma);
 
-	error = remap_page_range(vma, vma->vm_start, vma->vm_start,
-		vma->vm_end - vma->vm_start, vma->vm_page_prot);
+	error = remap_pfn_range(vma,
+				vma->vm_start,
+				vma->vm_start >> PAGE_SHIFT,
+				vma->vm_end - vma->vm_start, vma->vm_page_prot);
 	if (error) {
 		goto out;
 	}
Index: mm2-2.6.9-rc2/arch/um/drivers/mmapper_kern.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/um/drivers/mmapper_kern.c	2004-09-12 22:31:43.000000000 -0700
+++ mm2-2.6.9-rc2/arch/um/drivers/mmapper_kern.c	2004-09-23 18:53:49.572155506 -0700
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
Index: mm2-2.6.9-rc2/arch/ppc64/kernel/proc_ppc64.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/ppc64/kernel/proc_ppc64.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/arch/ppc64/kernel/proc_ppc64.c	2004-09-23 18:56:34.533077634 -0700
@@ -176,7 +176,8 @@
 	if ((vma->vm_end - vma->vm_start) > dp->size)
 		return -EINVAL;
 
-	remap_page_range( vma, vma->vm_start, __pa(dp->data), dp->size, vma->vm_page_prot );
+	remap_pfn_range(vma, vma->vm_start, __pa(dp->data) >> PAGE_SHIFT,
+						dp->size, vma->vm_page_prot);
 	return 0;
 }
 
Index: mm2-2.6.9-rc2/sound/oss/ymfpci.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/ymfpci.c	2004-09-12 22:32:54.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/ymfpci.c	2004-09-23 19:02:44.629814378 -0700
@@ -334,7 +334,7 @@
 	dmabuf->dma_addr = dma_addr;
 	dmabuf->buforder = order;
 
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	mapend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (map = virt_to_page(rawbuf); map <= mapend; map++)
 		set_bit(PG_reserved, &map->flags);
@@ -1545,7 +1545,8 @@
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		return -EINVAL;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		return -EAGAIN;
 	dmabuf->mapped = 1;
Index: mm2-2.6.9-rc2/sound/oss/sonicvibes.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/sonicvibes.c	2004-09-12 22:32:26.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/sonicvibes.c	2004-09-23 19:01:33.553619602 -0700
@@ -756,7 +756,7 @@
 		if ((virt_to_bus(db->rawbuf) + (PAGE_SIZE << db->buforder) - 1) & ~0xffffff)
 			printk(KERN_DEBUG "sv: DMA buffer beyond 16MB: busaddr 0x%lx  size %ld\n", 
 			       virt_to_bus(db->rawbuf), PAGE_SIZE << db->buforder);
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1549,7 +1549,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm2-2.6.9-rc2/sound/oss/ite8172.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/ite8172.c	2004-09-12 22:31:57.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/ite8172.c	2004-09-23 18:59:58.405084378 -0700
@@ -693,7 +693,7 @@
 			return -ENOMEM;
 		db->buforder = order;
 		/* now mark the pages as reserved;
-		   otherwise remap_page_range doesn't do what we want */
+		   otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf +
 				    (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
@@ -1311,7 +1311,8 @@
 		unlock_kernel();
 		return -EINVAL;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot)) {
 		unlock_kernel();
 		return -EAGAIN;
Index: mm2-2.6.9-rc2/arch/i386/pci/i386.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/i386/pci/i386.c	2004-09-22 21:31:26.000000000 -0700
+++ mm2-2.6.9-rc2/arch/i386/pci/i386.c	2004-09-23 18:52:51.972911922 -0700
@@ -295,7 +295,7 @@
 	/* Write-combine setting is ignored, it is changed via the mtrr
 	 * interfaces on this platform.
 	 */
-	if (remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
Index: mm2-2.6.9-rc2/arch/sparc64/mm/generic.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/sparc64/mm/generic.c	2004-09-12 22:33:22.000000000 -0700
+++ mm2-2.6.9-rc2/arch/sparc64/mm/generic.c	2004-09-23 18:53:04.403022258 -0700
@@ -23,7 +23,7 @@
 	}
 }
 
-/* Remap IO memory, the same way as remap_page_range(), but use
+/* Remap IO memory, the same way as remap_pfn_range(), but use
  * the obio memory space.
  *
  * They use a pgprot that sets PAGE_IO and does not check the
Index: mm2-2.6.9-rc2/arch/ia64/kernel/perfmon.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/ia64/kernel/perfmon.c	2004-09-12 22:33:36.000000000 -0700
+++ mm2-2.6.9-rc2/arch/ia64/kernel/perfmon.c	2004-09-23 18:55:40.828242010 -0700
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
@@ -2248,9 +2230,9 @@
 	DPRINT(("CPU%d buf=0x%lx addr=0x%lx size=%ld\n", smp_processor_id(), buf, addr, size));
 
 	while (size > 0) {
-		page = pfm_kvirt_to_pa(buf);
-
-		if (pfm_remap_page_range(vma, addr, page, PAGE_SIZE, PAGE_READONLY)) return -ENOMEM;
+		page = ia64_tpa(buf) >> PAGE_SHIFT;
+		if (remap_pfn_range(vma, addr, page, PAGE_SIZE, PAGE_READONLY))
+			return -ENOMEM;
 
 		addr  += PAGE_SIZE;
 		buf   += PAGE_SIZE;
Index: mm2-2.6.9-rc2/sound/oss/soundcard.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/soundcard.c	2004-09-12 22:32:41.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/soundcard.c	2004-09-23 19:01:57.540972970 -0700
@@ -463,7 +463,8 @@
 	if (size != dmap->bytes_in_use) {
 		printk(KERN_WARNING "Sound: mmap() size = %ld. Should be %d\n", size, dmap->bytes_in_use);
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmap->raw_buf),
+	if (remap_pfn_range(vma, vma->vm_start,
+		virt_to_phys(dmap->raw_buf) >> PAGE_SHIFT,
 		vma->vm_end - vma->vm_start,
 		vma->vm_page_prot)) {
 		unlock_kernel();
Index: mm2-2.6.9-rc2/arch/ppc64/kernel/pci.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/ppc64/kernel/pci.c	2004-09-22 21:32:58.000000000 -0700
+++ mm2-2.6.9-rc2/arch/ppc64/kernel/pci.c	2004-09-23 18:56:48.930888834 -0700
@@ -502,7 +502,7 @@
 	__pci_mmap_set_flags(dev, vma, mmap_state);
 	__pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);
 
-	ret = remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,
+	ret = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
 
 	return ret;
Index: mm2-2.6.9-rc2/arch/arm/kernel/bios32.c
===================================================================
--- mm2-2.6.9-rc2.orig/arch/arm/kernel/bios32.c	2004-09-22 21:32:58.000000000 -0700
+++ mm2-2.6.9-rc2/arch/arm/kernel/bios32.c	2004-09-23 18:53:22.362292034 -0700
@@ -694,7 +694,7 @@
 	vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_page_range(vma, vma->vm_start, phys,
+	if (remap_pfn_range(vma, vma->vm_start, phys >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
Index: mm2-2.6.9-rc2/sound/oss/cmpci.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/cmpci.c	2004-09-12 22:32:48.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/cmpci.c	2004-09-23 19:02:17.763898618 -0700
@@ -1393,7 +1393,7 @@
 		if (!db->rawbuf || !db->dmaaddr)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (pstart = virt_to_page(db->rawbuf); pstart <= pend; pstart++)
 			SetPageReserved(pstart);
@@ -2301,7 +2301,7 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EINVAL;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(db->rawbuf) >> PAGE_SHIFT, size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
Index: mm2-2.6.9-rc2/sound/oss/rme96xx.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/rme96xx.c	2004-09-12 22:32:16.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/rme96xx.c	2004-09-23 19:01:00.265680138 -0700
@@ -1685,14 +1685,14 @@
 	if (vma->vm_flags & VM_WRITE) {
 		if (!s->started) rme96xx_startcard(s,1);
 
-		if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->outoffset*RME96xx_DMA_MAX_SIZE), size, vma->vm_page_prot)) {
+		if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->outoffset*RME96xx_DMA_MAX_SIZE) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
 	} 
 	else if (vma->vm_flags & VM_READ) {
 		if (!s->started) rme96xx_startcard(s,1);
-		if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->inoffset*RME96xx_DMA_MAX_SIZE), size, vma->vm_page_prot)) {
+		if (remap_pfn_range(vma, vma->vm_start, virt_to_phys(s->playbuf + dma->inoffset*RME96xx_DMA_MAX_SIZE) >> PAGE_SHIFT, size, vma->vm_page_prot)) {
 			unlock_kernel();
 			return -EAGAIN;
 		}
Index: mm2-2.6.9-rc2/sound/oss/i810_audio.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/i810_audio.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/i810_audio.c	2004-09-23 19:04:47.742098466 -0700
@@ -917,7 +917,7 @@
 	dmabuf->rawbuf = rawbuf;
 	dmabuf->buforder = order;
 	
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
@@ -1750,7 +1750,8 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
Index: mm2-2.6.9-rc2/sound/oss/maestro3.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/maestro3.c	2004-09-12 22:33:23.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/maestro3.c	2004-09-23 19:07:40.346858554 -0700
@@ -1557,7 +1557,9 @@
      * ask Jeff what the hell I'm doing wrong.
      */
     ret = -EAGAIN;
-    if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+    if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
         goto out;
 
     db->mapped = 1;
Index: mm2-2.6.9-rc2/sound/oss/ali5455.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/ali5455.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/ali5455.c	2004-09-23 19:06:23.577529266 -0700
@@ -934,7 +934,7 @@
 	dmabuf->rawbuf = rawbuf;
 	dmabuf->buforder = order;
 
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
@@ -1955,7 +1955,9 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
 	dmabuf->trigger = 0;
Index: mm2-2.6.9-rc2/sound/oss/trident.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/trident.c	2004-09-12 22:33:11.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/trident.c	2004-09-23 19:05:42.082837418 -0700
@@ -1281,7 +1281,7 @@
 	dmabuf->buforder = order;
 
 	/* now mark the pages as reserved; otherwise */ 
-	/* remap_page_range doesn't do what we want */
+	/* remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
@@ -2223,7 +2223,8 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf), 
+	if (remap_pfn_range(vma, vma->vm_start,
+			     virt_to_phys(dmabuf->rawbuf) >> PAGE_SHIFT,
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
Index: mm2-2.6.9-rc2/sound/oss/es1370.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/es1370.c	2004-09-12 22:33:38.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/es1370.c	2004-09-23 19:08:35.737437906 -0700
@@ -573,7 +573,7 @@
 		if (!db->rawbuf)
 			return -ENOMEM;
 		db->buforder = order;
-		/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+		/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 		pend = virt_to_page(db->rawbuf + (PAGE_SIZE << db->buforder) - 1);
 		for (page = virt_to_page(db->rawbuf); page <= pend; page++)
 			SetPageReserved(page);
@@ -1364,7 +1364,9 @@
 		ret = -EINVAL;
 		goto out;
 	}
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot)) {
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot)) {
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -1940,7 +1942,9 @@
 	if (size > (PAGE_SIZE << s->dma_dac1.buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(s->dma_dac1.rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(s->dma_dac1.rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	s->dma_dac1.mapped = 1;
 	ret = 0;
Index: mm2-2.6.9-rc2/sound/oss/maestro.c
===================================================================
--- mm2-2.6.9-rc2.orig/sound/oss/maestro.c	2004-09-12 22:33:23.000000000 -0700
+++ mm2-2.6.9-rc2/sound/oss/maestro.c	2004-09-23 19:07:01.021836866 -0700
@@ -2520,7 +2520,9 @@
 	if (size > (PAGE_SIZE << db->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma, vma->vm_start, virt_to_phys(db->rawbuf), size, vma->vm_page_prot))
+	if (remap_pfn_range(vma, vma->vm_start,
+				virt_to_phys(db->rawbuf) >> PAGE_SHIFT,
+				size, vma->vm_page_prot))
 		goto out;
 	db->mapped = 1;
 	ret = 0;
@@ -2953,7 +2955,7 @@
 
 	}
 
-	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
+	/* now mark the pages as reserved; otherwise remap_pfn_range doesn't do what we want */
 	pend = virt_to_page(rawbuf + (PAGE_SIZE << order) - 1);
 	for (page = virt_to_page(rawbuf); page <= pend; page++)
 		SetPageReserved(page);
