Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWDTSO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWDTSO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWDTSO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:14:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:46058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751222AbWDTSO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:14:58 -0400
Date: Thu, 20 Apr 2006 20:14:47 +0200
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Stephane Eranian <eranian@hpl.hp.com>
Subject: [patch][rfc] improve remap_vmalloc_range callers' return values
Message-ID: <20060420181446.GG21660@wotan.suse.de>
References: <20060228202202.14172.60409.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228202202.14172.60409.sendpatchset@linux.site>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not directly related to the current patchset... but does anyone
see a reason why we shouldn't try to return saner values from
remap_vmalloc_range callers?

(This patch is slightly more involved for perfmon, so Stephane
CCed. It catches insert_vm_struct errors, and moves
remap_vmalloc_range below it so we needn't have to clean up
by unmapping stuff).

--
Index: linux-2.6/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6/arch/ia64/kernel/perfmon.c
@@ -2199,6 +2199,7 @@ pfm_smpl_buffer_alloc(struct task_struct
 	struct vm_area_struct *vma = NULL;
 	unsigned long size;
 	void *smpl_buf;
+	int ret = -ENOMEM;
 
 
 	/*
@@ -2217,7 +2218,7 @@ pfm_smpl_buffer_alloc(struct task_struct
 	 * 	return -ENOMEM;
 	 */
 	if (size > task->signal->rlim[RLIMIT_MEMLOCK].rlim_cur)
-		return -ENOMEM;
+		goto out;
 
 	/*
 	 * We do the easy to undo allocations first.
@@ -2227,7 +2228,7 @@ pfm_smpl_buffer_alloc(struct task_struct
 	smpl_buf = vmalloc_user(size);
 	if (smpl_buf == NULL) {
 		DPRINT(("Can't allocate sampling buffer\n"));
-		return -ENOMEM;
+		goto out;
 	}
 
 	DPRINT(("smpl_buf @%p\n", smpl_buf));
@@ -2267,7 +2268,6 @@ pfm_smpl_buffer_alloc(struct task_struct
 	vma->vm_start = pfm_get_unmapped_area(NULL, 0, size, 0, MAP_PRIVATE|MAP_ANONYMOUS, 0);
 	if (vma->vm_start == 0UL) {
 		DPRINT(("Cannot find unmapped area for size %ld\n", size));
-		up_write(&task->mm->mmap_sem);
 		goto error;
 	}
 	vma->vm_end = vma->vm_start + size;
@@ -2275,23 +2275,24 @@ pfm_smpl_buffer_alloc(struct task_struct
 
 	DPRINT(("aligned size=%ld, hdr=%p mapped @0x%lx\n", size, ctx->ctx_smpl_hdr, vma->vm_start));
 
-	/* can only be applied to current task, need to have the mm semaphore held when called */
-	if (remap_vmalloc_range(vma, smpl_buf, 0)) {
-		DPRINT(("Can't remap buffer\n"));
-		up_write(&task->mm->mmap_sem);
-		goto error;
-	}
-
 	/*
 	 * now insert the vma in the vm list for the process, must be
 	 * done with mmap lock held
 	 */
-	insert_vm_struct(mm, vma);
+	if ((ret = insert_vm_struct(mm, vma)) {
+		DPRINT(("Can't insert vma\n"));
+		goto error;
+	}
+
+	/* can only be applied to current task, need to have the mm semaphore held when called */
+	if ((ret = remap_vmalloc_range(vma, smpl_buf, 0))) {
+		DPRINT(("Can't remap buffer\n"));
+		goto error;
+	}
 
 	mm->total_vm  += size >> PAGE_SHIFT;
 	vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
 							vma_pages(vma));
-	up_write(&task->mm->mmap_sem);
 
 	/*
 	 * keep track of user level virtual address
@@ -2299,14 +2300,17 @@ pfm_smpl_buffer_alloc(struct task_struct
 	ctx->ctx_smpl_vaddr = (void *)vma->vm_start;
 	*(unsigned long *)user_vaddr = vma->vm_start;
 
+	up_write(&task->mm->mmap_sem);
+
 	return 0;
 
 error:
+	up_write(&task->mm->mmap_sem);
 	kmem_cache_free(vm_area_cachep, vma);
 error_kmem:
 	vfree(smpl_buf);
-
-	return -ENOMEM;
+out:
+	return ret;
 }
 
 /*
Index: linux-2.6/drivers/media/video/cpia.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cpia.c
+++ linux-2.6/drivers/media/video/cpia.c
@@ -3734,9 +3734,9 @@ static int cpia_mmap(struct file *file, 
 		}
 	}
 
-	if (remap_vmalloc_range(vma, cam->frame_buf, 0)) {
+	if ((retval = remap_vmalloc_range(vma, cam->frame_buf, 0))) {
 		mutex_unlock(&cam->busy_lock);
-		return -EAGAIN;
+		return retval;
 	}
 
 	DBG("cpia_mmap: %ld\n", size);
Index: linux-2.6/drivers/media/video/em28xx/em28xx-video.c
===================================================================
--- linux-2.6.orig/drivers/media/video/em28xx/em28xx-video.c
+++ linux-2.6/drivers/media/video/em28xx/em28xx-video.c
@@ -585,6 +585,7 @@ static int em28xx_v4l2_mmap(struct file 
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
+	int ret;
 
 	struct em28xx *dev = filp->private_data;
 
@@ -593,21 +594,21 @@ static int em28xx_v4l2_mmap(struct file 
 
 	if (dev->state & DEV_DISCONNECTED) {
 		em28xx_videodbg("mmap: device not present\n");
-		mutex_unlock(&dev->fileop_lock);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	if (dev->state & DEV_MISCONFIGURED) {
 		em28xx_videodbg ("mmap: Device is misconfigured; close and "
 						"open it again\n");
-		mutex_unlock(&dev->fileop_lock);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (dev->io != IO_MMAP || !(vma->vm_flags & VM_WRITE) ||
 	    size != PAGE_ALIGN(dev->frame[0].buf.length)) {
-		mutex_unlock(&dev->fileop_lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	for (i = 0; i < dev->num_frames; i++) {
@@ -616,22 +617,23 @@ static int em28xx_v4l2_mmap(struct file 
 	}
 	if (i == dev->num_frames) {
 		em28xx_videodbg("mmap: user supplied mapping address is out of range\n");
-		mutex_unlock(&dev->fileop_lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (remap_vmalloc_range(vma, dev->frame[i].bufmem, 0)) {
+	if ((ret = remap_vmalloc_range(vma, dev->frame[i].bufmem, 0))) {
 		em28xx_videodbg("mmap: remap_vmalloc_range failed\n");
-		mutex_unlock(&dev->fileop_lock);
-		return -EAGAIN;
+		goto out;
 	}
 
 	vma->vm_ops = &em28xx_vm_ops;
 	vma->vm_private_data = &dev->frame[i];
 
 	em28xx_vm_open(vma);
+
+out:
 	mutex_unlock(&dev->fileop_lock);
-	return 0;
+	return ret;
 }
 
 /*
Index: linux-2.6/drivers/media/video/meye.c
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.c
+++ linux-2.6/drivers/media/video/meye.c
@@ -1663,11 +1663,12 @@ static struct vm_operations_struct meye_
 static int meye_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
+	int ret;
 
 	mutex_lock(&meye.lock);
 	if (size > gbuffers * gbufsize) { /* XXX: should be size + vm_pgoff? */
-		mutex_unlock(&meye.lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 	if (!meye.grab_fbuffer) {
 		int i;
@@ -1676,24 +1677,23 @@ static int meye_mmap(struct file *file, 
 		meye.grab_fbuffer = vmalloc_32_user(gbuffers*gbufsize);
 		if (!meye.grab_fbuffer) {
 			printk(KERN_ERR "meye: v4l framebuffer allocation failed\n");
-			mutex_unlock(&meye.lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 		for (i = 0; i < gbuffers; i++)
 			meye.vma_use_count[i] = 0;
 	}
 
-	if (remap_vmalloc_range(vma, meye.grab_fbuffer, vma->vm_pgoff)) {
-		mutex_unlock(&meye.lock);
-		return -EAGAIN;
-	}
+	if ((ret = remap_vmalloc_range(vma, meye.grab_fbuffer, vma->vm_pgoff)))
+		goto out;
 
 	vma->vm_ops = &meye_vm_ops;
 	vma->vm_private_data = (void *) (offset / gbufsize);
 	meye_vm_open(vma);
 
+out:
 	mutex_unlock(&meye.lock);
-	return 0;
+	return ret;
 }
 
 static struct file_operations meye_fops = {
Index: linux-2.6/drivers/media/video/ov511.c
===================================================================
--- linux-2.6.orig/drivers/media/video/ov511.c
+++ linux-2.6/drivers/media/video/ov511.c
@@ -4574,6 +4574,7 @@ ov51x_v4l1_mmap(struct file *file, struc
 	struct video_device *vdev = file->private_data;
 	unsigned long size  = vma->vm_end - vma->vm_start;
 	struct usb_ov511 *ov = video_get_drvdata(vdev);
+	int ret;
 
 	if (ov->dev == NULL)
 		return -EIO;
@@ -4588,13 +4589,10 @@ ov51x_v4l1_mmap(struct file *file, struc
 	if (mutex_lock_interruptible(&ov->lock))
 		return -EINTR;
 
-	if (remap_vmalloc_range(vma, ov->fbuf, 0)) {
-		mutex_unlock(&ov->lock);
-		return -EAGAIN;
-	}
+	ret = remap_vmalloc_range(vma, ov->fbuf, 0);
 
 	mutex_unlock(&ov->lock);
-	return 0;
+	return ret;
 }
 
 static struct file_operations ov511_fops = {
Index: linux-2.6/drivers/media/video/pwc/pwc-if.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pwc/pwc-if.c
+++ linux-2.6/drivers/media/video/pwc/pwc-if.c
@@ -1567,10 +1567,7 @@ static int pwc_video_mmap(struct file *f
 				vma->vm_start, vma->vm_end - vma->vm_start);
 	pdev = vdev->priv;
 
-	if (remap_vmalloc_range(vma, pdev->image_data, 0))
-		return -EAGAIN;
-
-	return 0;
+	return remap_vmalloc_range(vma, pdev->image_data, 0);
 }
 
 /***************************************************************************/
Index: linux-2.6/drivers/media/video/se401.c
===================================================================
--- linux-2.6.orig/drivers/media/video/se401.c
+++ linux-2.6/drivers/media/video/se401.c
@@ -1110,24 +1110,24 @@ static int se401_mmap(struct file *file,
 	struct video_device *dev = file->private_data;
 	struct usb_se401 *se401 = (struct usb_se401 *)dev;
 	unsigned long size  = vma->vm_end-vma->vm_start;
+	int ret;
 
 	mutex_lock(&se401->lock);
 
 	if (se401->dev == NULL) {
-		mutex_unlock(&se401->lock);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 	if (size > (((SE401_NUMFRAMES * se401->maxframesize) + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1))) {
-		mutex_unlock(&se401->lock);
-		return -EINVAL;
-	}
-	if (remap_vmalloc_range(vma, se401->fbuf, 0)) {
-		mutex_unlock(&se401->lock);
-		return -EAGAIN;
+		ret = -EINVAL;
+		goto out;
 	}
-	mutex_unlock(&se401->lock);
 
-	return 0;
+	ret = remap_vmalloc_range(vma, se401->fbuf, 0);
+
+out:
+	mutex_unlock(&se401->lock);
+	return ret;
 }
 
 static struct file_operations se401_fops = {
Index: linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/sn9c102/sn9c102_core.c
+++ linux-2.6/drivers/media/video/sn9c102/sn9c102_core.c
@@ -1730,27 +1730,28 @@ static int sn9c102_mmap(struct file* fil
 	struct sn9c102_device* cam = video_get_drvdata(video_devdata(filp));
 	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
+	int ret;
 
 	if (mutex_lock_interruptible(&cam->fileop_mutex))
 		return -ERESTARTSYS;
 
 	if (cam->state & DEV_DISCONNECTED) {
 		DBG(1, "Device not present");
-		mutex_unlock(&cam->fileop_mutex);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	if (cam->state & DEV_MISCONFIGURED) {
 		DBG(1, "The camera is misconfigured. Close and open it "
 		       "again.");
-		mutex_unlock(&cam->fileop_mutex);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (cam->io != IO_MMAP || !(vma->vm_flags & VM_WRITE) ||
 	    size != PAGE_ALIGN(cam->frame[0].buf.length)) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	for (i = 0; i < cam->nbuffers; i++) {
@@ -1758,23 +1759,21 @@ static int sn9c102_mmap(struct file* fil
 			break;
 	}
 	if (i == cam->nbuffers) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EAGAIN;
-	}
+	if ((ret = remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)))
+		goto out;
 
 	vma->vm_ops = &sn9c102_vm_ops;
 	vma->vm_private_data = &cam->frame[i];
 
 	sn9c102_vm_open(vma);
 
+out:
 	mutex_unlock(&cam->fileop_mutex);
-
-	return 0;
+	return ret;
 }
 
 /*****************************************************************************/
Index: linux-2.6/drivers/media/video/stv680.c
===================================================================
--- linux-2.6.orig/drivers/media/video/stv680.c
+++ linux-2.6/drivers/media/video/stv680.c
@@ -1200,25 +1200,25 @@ static int stv680_mmap (struct file *fil
 	struct video_device *dev = file->private_data;
 	struct usb_stv *stv680 = video_get_drvdata(dev);
 	unsigned long size  = vma->vm_end-vma->vm_start;
+	int ret;
 
 	mutex_lock(&stv680->lock);
 
 	if (stv680->udev == NULL) {
-		mutex_unlock(&stv680->lock);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 	if (size > (((STV680_NUMFRAMES * stv680->maxframesize) + PAGE_SIZE - 1)
 		    & ~(PAGE_SIZE - 1))) {
-		mutex_unlock(&stv680->lock);
-		return -EINVAL;
-	}
-	if (remap_vmalloc_range(vma, stv680->fbuf, 0)) {
-		mutex_unlock(&stv680->lock);
-		return -EAGAIN;
+		ret = -EINVAL;
+		goto out;
 	}
-	mutex_unlock(&stv680->lock);
 
-	return 0;
+	ret = remap_vmalloc_range(vma, stv680->fbuf, 0);
+
+out:
+	mutex_unlock(&stv680->lock);
+	return ret;
 }
 
 static ssize_t stv680_read (struct file *file, char __user *buf,
Index: linux-2.6/drivers/media/video/usbvideo/usbvideo.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/usbvideo.c
+++ linux-2.6/drivers/media/video/usbvideo/usbvideo.c
@@ -1036,10 +1036,7 @@ static int usbvideo_v4l_mmap(struct file
 	if (size > (((USBVIDEO_NUMFRAMES * uvd->max_frame_size) + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1)))
 		return -EINVAL;
 
-	if (remap_vmalloc_range(vma, uvd->fbuf, 0))
-		return -EAGAIN;
-
-	return 0;
+	return remap_vmalloc_range(vma, uvd->fbuf, 0);
 }
 
 /*
Index: linux-2.6/drivers/media/video/usbvideo/vicam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/vicam.c
+++ linux-2.6/drivers/media/video/usbvideo/vicam.c
@@ -1002,10 +1002,7 @@ vicam_mmap(struct file *file, struct vm_
 	 if (size > VICAM_FRAMES*VICAM_MAX_FRAME_SIZE)
 		return -EINVAL;
 
-	if (remap_vmalloc_range(vma, cam->framebuf, 0))
-		return -EAGAIN;
-
-	return 0;
+	return remap_vmalloc_range(vma, cam->framebuf, 0);
 }
 
 #if defined(CONFIG_VIDEO_PROC_FS)
Index: linux-2.6/drivers/media/video/w9968cf.c
===================================================================
--- linux-2.6.orig/drivers/media/video/w9968cf.c
+++ linux-2.6/drivers/media/video/w9968cf.c
@@ -2816,6 +2816,7 @@ static int w9968cf_mmap(struct file* fil
 				     video_get_drvdata(video_devdata(filp));
 	unsigned long vsize = vma->vm_end - vma->vm_start,
 		      psize = cam->nbuffers * cam->frame[0].size;
+	int ret;
 
 	if (cam->disconnected) {
 		DBG(2, "Device not present")
@@ -2832,11 +2833,10 @@ static int w9968cf_mmap(struct file* fil
 	if (vsize > psize - (vma->vm_pgoff << PAGE_SHIFT))
 		return -EINVAL;
 
-	if (remap_vmalloc_range(vma, cam->frame[0].buffer, vma->vm_pgoff))
-		return -EAGAIN;
+	ret = remap_vmalloc_range(vma, cam->frame[0].buffer, vma->vm_pgoff);
 
 	DBG(5, "mmap method successfully called")
-	return 0;
+	return ret;
 }
 
 
Index: linux-2.6/drivers/media/video/zc0301/zc0301_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/zc0301/zc0301_core.c
+++ linux-2.6/drivers/media/video/zc0301/zc0301_core.c
@@ -931,27 +931,28 @@ static int zc0301_mmap(struct file* filp
 	struct zc0301_device* cam = video_get_drvdata(video_devdata(filp));
 	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
+	int ret;
 
 	if (mutex_lock_interruptible(&cam->fileop_mutex))
 		return -ERESTARTSYS;
 
 	if (cam->state & DEV_DISCONNECTED) {
 		DBG(1, "Device not present");
-		mutex_unlock(&cam->fileop_mutex);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	if (cam->state & DEV_MISCONFIGURED) {
 		DBG(1, "The camera is misconfigured. Close and open it "
 		       "again.");
-		mutex_unlock(&cam->fileop_mutex);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (cam->io != IO_MMAP || !(vma->vm_flags & VM_WRITE) ||
 	    size != PAGE_ALIGN(cam->frame[0].buf.length)) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	for (i = 0; i < cam->nbuffers; i++) {
@@ -959,23 +960,21 @@ static int zc0301_mmap(struct file* filp
 			break;
 	}
 	if (i == cam->nbuffers) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EAGAIN;
-	}
+	if ((ret = remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)))
+		goto out;
 
 	vma->vm_ops = &zc0301_vm_ops;
 	vma->vm_private_data = &cam->frame[i];
 
 	zc0301_vm_open(vma);
 
+out:
 	mutex_unlock(&cam->fileop_mutex);
-
-	return 0;
+	return ret;
 }
 
 /*****************************************************************************/
Index: linux-2.6/drivers/media/video/et61x251/et61x251_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/et61x251/et61x251_core.c
+++ linux-2.6/drivers/media/video/et61x251/et61x251_core.c
@@ -1467,27 +1467,28 @@ static int et61x251_mmap(struct file* fi
 	struct et61x251_device* cam = video_get_drvdata(video_devdata(filp));
 	unsigned long size = vma->vm_end - vma->vm_start;
 	u32 i;
+	int ret;
 
 	if (mutex_lock_interruptible(&cam->fileop_mutex))
 		return -ERESTARTSYS;
 
 	if (cam->state & DEV_DISCONNECTED) {
 		DBG(1, "Device not present");
-		mutex_unlock(&cam->fileop_mutex);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	if (cam->state & DEV_MISCONFIGURED) {
 		DBG(1, "The camera is misconfigured. Close and open it "
 		       "again.");
-		mutex_unlock(&cam->fileop_mutex);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	if (cam->io != IO_MMAP || !(vma->vm_flags & VM_WRITE) ||
 	    size != PAGE_ALIGN(cam->frame[0].buf.length)) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	for (i = 0; i < cam->nbuffers; i++) {
@@ -1495,23 +1496,21 @@ static int et61x251_mmap(struct file* fi
 			break;
 	}
 	if (i == cam->nbuffers) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)) {
-		mutex_unlock(&cam->fileop_mutex);
-		return -EAGAIN;
-	}
+	if ((ret = remap_vmalloc_range(vma, cam->frame[i].bufmem, 0)))
+		goto out;
 
 	vma->vm_ops = &et61x251_vm_ops;
 	vma->vm_private_data = &cam->frame[i];
 
 	et61x251_vm_open(vma);
 
+out:
 	mutex_unlock(&cam->fileop_mutex);
-
-	return 0;
+	return ret;
 }
 
 /*****************************************************************************/
