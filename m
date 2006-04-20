Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWDTRG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWDTRG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDTRG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:06:27 -0400
Received: from mail.suse.de ([195.135.220.2]:1992 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751162AbWDTRGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:06:25 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060228202212.14172.59536.sendpatchset@linux.site>
In-Reply-To: <20060228202202.14172.60409.sendpatchset@linux.site>
References: <20060228202202.14172.60409.sendpatchset@linux.site>
Subject: [patch 1/5] mm: remap_vmalloc_range
Date: Thu, 20 Apr 2006 19:06:18 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a remap_vmalloc_range and get rid of as many remap_pfn_range and
vm_insert_page loops as possible.

remap_vmalloc_range can do a whole lot of nice range checking even
if the caller gets it wrong (which it looks like one or two do).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/media/video/cpia.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cpia.c
+++ linux-2.6/drivers/media/video/cpia.c
@@ -3750,9 +3750,7 @@ static int cpia_ioctl(struct inode *inod
 static int cpia_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct video_device *dev = file->private_data;
-	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end - vma->vm_start;
-	unsigned long page, pos;
 	struct cam_data *cam = dev->priv;
 	int retval;
 
@@ -3778,19 +3776,9 @@ static int cpia_mmap(struct file *file, 
 		}
 	}
 
-	pos = (unsigned long)(cam->frame_buf);
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
-			mutex_unlock(&cam->busy_lock);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+	if (remap_vmalloc_range(vma, cam->frame_buf, 0)) {
+		mutex_unlock(&cam->busy_lock);
+		return -EAGAIN;
 	}
 
 	DBG("cpia_mmap: %ld\n", size);
Index: linux-2.6/drivers/media/video/meye.c
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.c
+++ linux-2.6/drivers/media/video/meye.c
@@ -1699,13 +1699,10 @@ static struct vm_operations_struct meye_
 
 static int meye_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	unsigned long start = vma->vm_start;
 	unsigned long size = vma->vm_end - vma->vm_start;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long page, pos;
 
 	mutex_lock(&meye.lock);
-	if (size > gbuffers * gbufsize) {
+	if (size > gbuffers * gbufsize) { /* XXX: should be size + vm_pgoff? */
 		mutex_unlock(&meye.lock);
 		return -EINVAL;
 	}
@@ -1722,20 +1719,10 @@ static int meye_mmap(struct file *file, 
 		for (i = 0; i < gbuffers; i++)
 			meye.vma_use_count[i] = 0;
 	}
-	pos = (unsigned long)meye.grab_fbuffer + offset;
 
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
-			mutex_unlock(&meye.lock);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+	if (remap_vmalloc_range(vma, meye.grab_fbuffer, vma->vm_pgoff)) {
+		mutex_unlock(&meye.lock);
+		return -EAGAIN;
 	}
 
 	vma->vm_ops = &meye_vm_ops;
Index: linux-2.6/drivers/media/video/ov511.c
===================================================================
--- linux-2.6.orig/drivers/media/video/ov511.c
+++ linux-2.6/drivers/media/video/ov511.c
@@ -4616,10 +4616,8 @@ static int
 ov51x_v4l1_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct video_device *vdev = file->private_data;
-	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end - vma->vm_start;
 	struct usb_ov511 *ov = video_get_drvdata(vdev);
-	unsigned long page, pos;
 
 	if (ov->dev == NULL)
 		return -EIO;
@@ -4634,19 +4632,9 @@ ov51x_v4l1_mmap(struct file *file, struc
 	if (mutex_lock_interruptible(&ov->lock))
 		return -EINTR;
 
-	pos = (unsigned long)ov->fbuf;
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
-			mutex_unlock(&ov->lock);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+	if (remap_vmalloc_range(vma, ov->fbuf, 0)) {
+		mutex_unlock(&ov->lock);
+		return -EAGAIN;
 	}
 
 	mutex_unlock(&ov->lock);
Index: linux-2.6/drivers/media/video/pwc/pwc-if.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pwc/pwc-if.c
+++ linux-2.6/drivers/media/video/pwc/pwc-if.c
@@ -1602,28 +1602,16 @@ static int pwc_video_mmap(struct file *f
 {
 	struct video_device *vdev = file->private_data;
 	struct pwc_device *pdev;
-	unsigned long start = vma->vm_start;
-	unsigned long size  = vma->vm_end-vma->vm_start;
-	unsigned long page, pos;
 
-	Trace(TRACE_MEMORY, "mmap(0x%p, 0x%lx, %lu) called.\n", vdev, start, size);
+	/* XXX: should check ranges */
+	Trace(TRACE_MEMORY, "mmap(0x%p, 0x%lx, %lu) called.\n", vdev,
+				vma->vm_start, vma->vm_end - vma->vm_start);
 	pdev = vdev->priv;
 
 	vma->vm_flags |= VM_IO;
 
-	pos = (unsigned long)pdev->image_data;
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
-			return -EAGAIN;
-
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
-	}
+	if (remap_vmalloc_range(vma, pdev->image_data, 0))
+		return -EAGAIN;
 
 	return 0;
 }
Index: linux-2.6/drivers/media/video/se401.c
===================================================================
--- linux-2.6.orig/drivers/media/video/se401.c
+++ linux-2.6/drivers/media/video/se401.c
@@ -1153,9 +1153,7 @@ static int se401_mmap(struct file *file,
 {
 	struct video_device *dev = file->private_data;
 	struct usb_se401 *se401 = (struct usb_se401 *)dev;
-	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end-vma->vm_start;
-	unsigned long page, pos;
 
 	mutex_lock(&se401->lock);
 
@@ -1167,19 +1165,9 @@ static int se401_mmap(struct file *file,
 		mutex_unlock(&se401->lock);
 		return -EINVAL;
 	}
-	pos = (unsigned long)se401->fbuf;
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
-			mutex_unlock(&se401->lock);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+	if (remap_vmalloc_range(vma, se401->fbuf, 0)) {
+		mutex_unlock(&se401->lock);
+		return -EAGAIN;
 	}
 	mutex_unlock(&se401->lock);
 
Index: linux-2.6/drivers/media/video/stv680.c
===================================================================
--- linux-2.6.orig/drivers/media/video/stv680.c
+++ linux-2.6/drivers/media/video/stv680.c
@@ -1254,9 +1254,7 @@ static int stv680_mmap (struct file *fil
 {
 	struct video_device *dev = file->private_data;
 	struct usb_stv *stv680 = video_get_drvdata(dev);
-	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end-vma->vm_start;
-	unsigned long page, pos;
 
 	mutex_lock(&stv680->lock);
 
@@ -1269,19 +1267,9 @@ static int stv680_mmap (struct file *fil
 		mutex_unlock(&stv680->lock);
 		return -EINVAL;
 	}
-	pos = (unsigned long) stv680->fbuf;
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
-			mutex_unlock(&stv680->lock);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
+	if (remap_vmalloc_range(vma, stv680->fbuf, 0)) {
+		mutex_unlock(&stv680->lock);
+		return -EAGAIN;
 	}
 	mutex_unlock(&stv680->lock);
 
Index: linux-2.6/drivers/media/video/usbvideo/usbvideo.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/usbvideo.c
+++ linux-2.6/drivers/media/video/usbvideo/usbvideo.c
@@ -1068,9 +1068,7 @@ EXPORT_SYMBOL(usbvideo_RegisterVideoDevi
 static int usbvideo_v4l_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct uvd *uvd = file->private_data;
-	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end-vma->vm_start;
-	unsigned long page, pos;
 
 	if (!CAMERA_IS_OPERATIONAL(uvd))
 		return -EFAULT;
@@ -1078,19 +1076,8 @@ static int usbvideo_v4l_mmap(struct file
 	if (size > (((USBVIDEO_NUMFRAMES * uvd->max_frame_size) + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1)))
 		return -EINVAL;
 
-	pos = (unsigned long) uvd->fbuf;
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
-			return -EAGAIN;
-
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
-	}
+	if (remap_vmalloc_range(vma, uvd->fbuf, 0))
+		return -EAGAIN;
 
 	return 0;
 }
Index: linux-2.6/drivers/media/video/usbvideo/vicam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/vicam.c
+++ linux-2.6/drivers/media/video/usbvideo/vicam.c
@@ -1029,8 +1029,6 @@ static int
 vicam_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	// TODO: allocate the raw frame buffer if necessary
-	unsigned long page, pos;
-	unsigned long start = vma->vm_start;
 	unsigned long size  = vma->vm_end-vma->vm_start;
 	struct vicam_camera *cam = file->private_data;
 
@@ -1039,25 +1037,16 @@ vicam_mmap(struct file *file, struct vm_
 
 	DBG("vicam_mmap: %ld\n", size);
 
-	/* We let mmap allocate as much as it wants because Linux was adding 2048 bytes
-	 * to the size the application requested for mmap and it was screwing apps up.
-	 if (size > VICAM_FRAMES*VICAM_MAX_FRAME_SIZE)
-	 return -EINVAL;
+	/* We let mmap allocate as much as it wants because Linux was adding
+	 * 2048 bytes to the size the application requested for mmap and it was
+	 * screwing apps up.
+	 *
+	 * It shouldn't have been, so let's try this check again -np
 	 */
+	 if (size > VICAM_FRAMES*VICAM_MAX_FRAME_SIZE)
 
-	pos = (unsigned long)cam->framebuf;
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
-			return -EAGAIN;
-
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
-	}
+	if (remap_vmalloc_range(vma, cam->framebuf, 0))
+		return -EAGAIN;
 
 	return 0;
 }
Index: linux-2.6/drivers/media/video/w9968cf.c
===================================================================
--- linux-2.6.orig/drivers/media/video/w9968cf.c
+++ linux-2.6/drivers/media/video/w9968cf.c
@@ -2861,10 +2861,7 @@ static int w9968cf_mmap(struct file* fil
 	struct w9968cf_device* cam = (struct w9968cf_device*)
 				     video_get_drvdata(video_devdata(filp));
 	unsigned long vsize = vma->vm_end - vma->vm_start,
-		      psize = cam->nbuffers * cam->frame[0].size,
-		      start = vma->vm_start,
-		      pos = (unsigned long)cam->frame[0].buffer,
-		      page;
+		      psize = cam->nbuffers * cam->frame[0].size;
 
 	if (cam->disconnected) {
 		DBG(2, "Device not present")
@@ -2881,15 +2878,8 @@ static int w9968cf_mmap(struct file* fil
 	if (vsize > psize - (vma->vm_pgoff << PAGE_SHIFT))
 		return -EINVAL;
 
-	while (vsize > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page + vma->vm_pgoff,
-						PAGE_SIZE, vma->vm_page_prot))
-			return -EAGAIN;
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		vsize -= PAGE_SIZE;
-	}
+	if (remap_vmalloc_range(vma, cam->frame[0].buffer, vma->vm_pgoff))
+		return -EAGAIN;
 
 	DBG(5, "mmap method successfully called")
 	return 0;
Index: linux-2.6/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6/arch/ia64/kernel/perfmon.c
@@ -2237,25 +2237,6 @@ pfm_free_fd(int fd, struct file *file)
 	put_unused_fd(fd);
 }
 
-static int
-pfm_remap_buffer(struct vm_area_struct *vma, unsigned long buf, unsigned long addr, unsigned long size)
-{
-	DPRINT(("CPU%d buf=0x%lx addr=0x%lx size=%ld\n", smp_processor_id(), buf, addr, size));
-
-	while (size > 0) {
-		unsigned long pfn = ia64_tpa(buf) >> PAGE_SHIFT;
-
-
-		if (remap_pfn_range(vma, addr, pfn, PAGE_SIZE, PAGE_READONLY))
-			return -ENOMEM;
-
-		addr  += PAGE_SIZE;
-		buf   += PAGE_SIZE;
-		size  -= PAGE_SIZE;
-	}
-	return 0;
-}
-
 /*
  * allocate a sampling buffer and remaps it into the user address space of the task
  */
@@ -2343,7 +2324,7 @@ pfm_smpl_buffer_alloc(struct task_struct
 	DPRINT(("aligned size=%ld, hdr=%p mapped @0x%lx\n", size, ctx->ctx_smpl_hdr, vma->vm_start));
 
 	/* can only be applied to current task, need to have the mm semaphore held when called */
-	if (pfm_remap_buffer(vma, (unsigned long)smpl_buf, vma->vm_start, size)) {
+	if (remap_vmalloc_range(vma, smpl_buf, 0)) {
 		DPRINT(("Can't remap buffer\n"));
 		up_write(&task->mm->mmap_sem);
 		goto error;
Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -45,6 +45,9 @@ extern void vfree(void *addr);
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
 extern void vunmap(void *addr);
+
+extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
+							unsigned long pgoff);
  
 /*
  *	Lowlevel-APIs (not for driver use!)
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -256,6 +256,20 @@ struct vm_struct *get_vm_area_node(unsig
 	return __get_vm_area_node(size, flags, VMALLOC_START, VMALLOC_END, node);
 }
 
+static struct vm_struct *find_vm_area(void *addr)
+{
+	struct vm_struct *tmp;
+
+	write_lock(&vmlist_lock);
+	for (tmp = vmlist; tmp != NULL; tmp = tmp->next) {
+		 if (tmp->addr == addr)
+			break;
+	}
+	write_unlock(&vmlist_lock);
+
+	return tmp;
+}
+
 /* Caller must hold vmlist_lock */
 struct vm_struct *__remove_vm_area(void *addr)
 {
@@ -630,3 +644,55 @@ finished:
 	read_unlock(&vmlist_lock);
 	return buf - buf_start;
 }
+
+/**
+ *	remap_vmalloc_range  -  map vmalloc pages to userspace
+ *
+ *	@vma:		vma to cover (map full range of vma)
+ *	@addr:		vmalloc memory
+ *	@pgoff:		number of pages into addr before first page to map
+ *	@returns:	0 for success, -Exxx on failure
+ *
+ *	This function checks that addr is a valid vmalloc'ed area, and
+ *	that it is big enough to cover the vma. Will return failure if
+ *	that criteria isn't met.
+ *
+ *	Similar to remap_pfn_range (see mm/memory.c)
+ */
+int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
+						unsigned long pgoff)
+{
+	struct vm_struct *area;
+	unsigned long uaddr = vma->vm_start;
+	unsigned long usize = vma->vm_end - vma->vm_start;
+	int ret;
+
+	if ((PAGE_SIZE-1) & (unsigned long)addr)
+		return -EINVAL;
+
+	area = find_vm_area(addr);
+	if (!area)
+		return -EINVAL;
+
+	if (usize + (pgoff << PAGE_SHIFT) > area->size - PAGE_SIZE)
+		return -EINVAL;
+
+	addr = (void *)((unsigned long)addr + (pgoff << PAGE_SHIFT));
+	do {
+		struct page *page = vmalloc_to_page(addr);
+		ret = vm_insert_page(vma, uaddr, page);
+		if (ret)
+			return ret;
+
+		uaddr += PAGE_SIZE;
+		addr = (void *)((unsigned long)addr+PAGE_SIZE);
+		usize -= PAGE_SIZE;
+	} while (usize > 0);
+
+	/* Prevent "things" like memory migration? VM_flags need a cleanup... */
+	vma->vm_flags |= VM_RESERVED;
+
+	return ret;
+}
+EXPORT_SYMBOL(remap_vmalloc_range);
+
Index: linux-2.6/drivers/media/video/em28xx/em28xx-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/em28xx/em28xx-video.c
+++ linux-2.6/drivers/media/video/em28xx/em28xx-video.c
@@ -34,6 +34,7 @@
 #include <linux/version.h>
 #include <linux/video_decoder.h>
 #include <linux/mutex.h>
+#include <linux/vmalloc.h>
 
 #include "em28xx.h"
 #include <media/tuner.h>
@@ -582,9 +583,7 @@ static struct vm_operations_struct em28x
  */
 static int em28xx_v4l2_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	unsigned long size = vma->vm_end - vma->vm_start,
-	    start = vma->vm_start;
-	void *pos;
+	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
 
 	struct em28xx *dev = filp->private_data;
@@ -625,16 +624,10 @@ static int em28xx_v4l2_mmap(struct file 
 	vma->vm_flags |= VM_IO;
 	vma->vm_flags |= VM_RESERVED;	/* avoid to swap out this VMA */
 
-	pos = dev->frame[i].bufmem;
-	while (size > 0) {	/* size is page-aligned */
-		if (vm_insert_page(vma, start, vmalloc_to_page(pos))) {
-			em28xx_videodbg("mmap: vm_insert_page failed\n");
-			mutex_unlock(&dev->fileop_lock);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		size -= PAGE_SIZE;
+	if (remap_vmalloc_range(vma, dev->frame[i].bufmem, 0)) {
+		em28xx_videodbg("mmap: remap_vmalloc_range failed\n");
+		mutex_unlock(&dev->fileop_lock);
+		return -EAGAIN;
 	}
 
 	vma->vm_ops = &em28xx_vm_ops;
Index: linux-2.6/drivers/media/video/et61x251/et61x251_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/et61x251/et61x251_core.c
+++ linux-2.6/drivers/media/video/et61x251/et61x251_core.c
@@ -1464,9 +1464,7 @@ static struct vm_operations_struct et61x
 static int et61x251_mmap(struct file* filp, struct vm_area_struct *vma)
 {
 	struct et61x251_device* cam = video_get_drvdata(video_devdata(filp));
-	unsigned long size = vma->vm_end - vma->vm_start,
-		      start = vma->vm_start;
-	void *pos;
+	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
 
 	if (mutex_lock_interruptible(&cam->fileop_mutex))
@@ -1503,15 +1501,9 @@ static int et61x251_mmap(struct file* fi
 	vma->vm_flags |= VM_IO;
 	vma->vm_flags |= VM_RESERVED;
 
-	pos = cam->frame[i].bufmem;
-	while (size > 0) { /* size is page-aligned */
-		if (vm_insert_page(vma, start, vmalloc_to_page(pos))) {
-			mutex_unlock(&cam->fileop_mutex);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		size -= PAGE_SIZE;
+	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
+		mutex_unlock(&cam->fileop_mutex);
+		return -EAGAIN;
 	}
 
 	vma->vm_ops = &et61x251_vm_ops;
Index: linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/sn9c102/sn9c102_core.c
+++ linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
@@ -1728,9 +1728,7 @@ static struct vm_operations_struct sn9c1
 static int sn9c102_mmap(struct file* filp, struct vm_area_struct *vma)
 {
 	struct sn9c102_device* cam = video_get_drvdata(video_devdata(filp));
-	unsigned long size = vma->vm_end - vma->vm_start,
-		      start = vma->vm_start;
-	void *pos;
+	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
 
 	if (mutex_lock_interruptible(&cam->fileop_mutex))
@@ -1767,15 +1765,9 @@ static int sn9c102_mmap(struct file* fil
 	vma->vm_flags |= VM_IO;
 	vma->vm_flags |= VM_RESERVED;
 
-	pos = cam->frame[i].bufmem;
-	while (size > 0) { /* size is page-aligned */
-		if (vm_insert_page(vma, start, vmalloc_to_page(pos))) {
-			mutex_unlock(&cam->fileop_mutex);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		size -= PAGE_SIZE;
+	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
+		mutex_unlock(&cam->fileop_mutex);
+		return -EAGAIN;
 	}
 
 	vma->vm_ops = &sn9c102_vm_ops;
Index: linux-2.6/drivers/media/video/zc0301/zc0301_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zc0301/zc0301_core.c
+++ linux-2.6/drivers/media/video/zc0301/zc0301_core.c
@@ -929,9 +929,7 @@ static struct vm_operations_struct zc030
 static int zc0301_mmap(struct file* filp, struct vm_area_struct *vma)
 {
 	struct zc0301_device* cam = video_get_drvdata(video_devdata(filp));
-	unsigned long size = vma->vm_end - vma->vm_start,
-		      start = vma->vm_start;
-	void *pos;
+	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
 
 	if (mutex_lock_interruptible(&cam->fileop_mutex))
@@ -968,15 +966,9 @@ static int zc0301_mmap(struct file* filp
 	vma->vm_flags |= VM_IO;
 	vma->vm_flags |= VM_RESERVED;
 
-	pos = cam->frame[i].bufmem;
-	while (size > 0) { /* size is page-aligned */
-		if (vm_insert_page(vma, start, vmalloc_to_page(pos))) {
-			mutex_unlock(&cam->fileop_mutex);
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		size -= PAGE_SIZE;
+	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
+		mutex_unlock(&cam->fileop_mutex);
+		return -EAGAIN;
 	}
 
 	vma->vm_ops = &zc0301_vm_ops;
