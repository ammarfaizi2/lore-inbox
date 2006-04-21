Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWDUGn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWDUGn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWDUGn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:43:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:14787 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751228AbWDUGnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:43:45 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060301045930.12434.96728.sendpatchset@linux.site>
In-Reply-To: <20060301045901.12434.54077.sendpatchset@linux.site>
References: <20060301045901.12434.54077.sendpatchset@linux.site>
Subject: [patch 3/5] mm: remove rvmalloc
Date: Fri, 21 Apr 2006 08:43:37 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some distros will be using 2.6.16ish kernels, which gives us a good
chance to start getting rid of the SetPageReserved which has stuck
around until now for its ability to catch paper bag type reference
counting bugs.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/drivers/ieee1394/dv1394-private.h
===================================================================
--- linux-2.6.orig/drivers/ieee1394/dv1394-private.h
+++ linux-2.6/drivers/ieee1394/dv1394-private.h
@@ -478,7 +478,7 @@ struct video_card {
 	/* support asynchronous I/O signals (SIGIO) */
 	struct fasync_struct *fasync;
 
-	/* the large, non-contiguous (rvmalloc()) ringbuffer for DV
+	/* the large, non-contiguous (vmalloc()) ringbuffer for DV
            data, exposed to user-space via mmap() */
 	unsigned long      dv_buf_size;
 	struct dma_region  dv_buf;
Index: linux-2.6/drivers/media/video/cpia.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cpia.c
+++ linux-2.6/drivers/media/video/cpia.c
@@ -212,48 +212,6 @@ static void set_flicker(struct cam_param
 
 /**********************************************************************
  *
- * Memory management
- *
- **********************************************************************/
-static void *rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-static void rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
-/**********************************************************************
- *
  * /proc interface
  *
  **********************************************************************/
@@ -1610,7 +1568,7 @@ static int allocate_frame_buf(struct cam
 {
 	int i;
 
-	cam->frame_buf = rvmalloc(FRAME_NUM * CPIA_MAX_FRAME_SIZE);
+	cam->frame_buf = vmalloc_32_user(FRAME_NUM * CPIA_MAX_FRAME_SIZE);
 	if (!cam->frame_buf)
 		return -ENOBUFS;
 
@@ -1624,7 +1582,7 @@ static int free_frame_buf(struct cam_dat
 {
 	int i;
 
-	rvfree(cam->frame_buf, FRAME_NUM*CPIA_MAX_FRAME_SIZE);
+	vfree(cam->frame_buf);
 	cam->frame_buf = NULL;
 	for (i=0; i < FRAME_NUM; i++)
 		cam->frame[i].data = NULL;
@@ -3188,13 +3146,13 @@ static int cpia_open(struct inode *inode
 	mutex_lock(&cam->busy_lock);
 	err = -ENOMEM;
 	if (!cam->raw_image) {
-		cam->raw_image = rvmalloc(CPIA_MAX_IMAGE_SIZE);
+		cam->raw_image = vmalloc_32_user(CPIA_MAX_IMAGE_SIZE);
 		if (!cam->raw_image)
 			goto oops;
 	}
 
 	if (!cam->decompressed_frame.data) {
-		cam->decompressed_frame.data = rvmalloc(CPIA_MAX_FRAME_SIZE);
+		cam->decompressed_frame.data = vmalloc_32_user(CPIA_MAX_FRAME_SIZE);
 		if (!cam->decompressed_frame.data)
 			goto oops;
 	}
@@ -3231,11 +3189,11 @@ static int cpia_open(struct inode *inode
 
  oops:
 	if (cam->decompressed_frame.data) {
-		rvfree(cam->decompressed_frame.data, CPIA_MAX_FRAME_SIZE);
+		vfree(cam->decompressed_frame.data);
 		cam->decompressed_frame.data = NULL;
 	}
 	if (cam->raw_image) {
-		rvfree(cam->raw_image, CPIA_MAX_IMAGE_SIZE);
+		vfree(cam->raw_image);
 		cam->raw_image = NULL;
 	}
 	mutex_unlock(&cam->busy_lock);
@@ -3274,12 +3232,12 @@ static int cpia_close(struct inode *inod
 	if (--cam->open_count == 0) {
 		/* clean up capture-buffers */
 		if (cam->raw_image) {
-			rvfree(cam->raw_image, CPIA_MAX_IMAGE_SIZE);
+			vfree(cam->raw_image);
 			cam->raw_image = NULL;
 		}
 
 		if (cam->decompressed_frame.data) {
-			rvfree(cam->decompressed_frame.data, CPIA_MAX_FRAME_SIZE);
+			vfree(cam->decompressed_frame.data);
 			cam->decompressed_frame.data = NULL;
 		}
 
Index: linux-2.6/drivers/media/video/cpia2/cpia2_core.c
===================================================================
--- linux-2.6.orig/drivers/media/video/cpia2/cpia2_core.c
+++ linux-2.6/drivers/media/video/cpia2/cpia2_core.c
@@ -86,47 +86,6 @@ static inline unsigned long kvirt_to_pa(
 	return ret;
 }
 
-static void *rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	/* Round it off to PAGE_SIZE */
-	size = PAGE_ALIGN(size);
-
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size);	/* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-
-	while ((long)size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	return mem;
-}
-
-static void rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	size = PAGE_ALIGN(size);
-
-	adr = (unsigned long) mem;
-	while ((long)size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
 /******************************************************************************
  *
  *  cpia2_do_command
@@ -2300,7 +2259,8 @@ int cpia2_allocate_buffers(struct camera
 	}
 
 	if(!cam->frame_buffer) {
-		cam->frame_buffer = rvmalloc(cam->frame_size*cam->num_frames);
+		cam->frame_buffer = vmalloc_32_user(cam->frame_size *
+							cam->num_frames);
 		if (!cam->frame_buffer) {
 			ERR("couldn't vmalloc frame buffer data area\n");
 			kfree(cam->buffers);
@@ -2342,7 +2302,7 @@ void cpia2_free_buffers(struct camera_da
 		cam->buffers = NULL;
 	}
 	if(cam->frame_buffer) {
-		rvfree(cam->frame_buffer, cam->frame_size*cam->num_frames);
+		vfree(cam->frame_buffer);
 		cam->frame_buffer = NULL;
 	}
 }
Index: linux-2.6/drivers/media/video/meye.c
===================================================================
--- linux-2.6.orig/drivers/media/video/meye.c
+++ linux-2.6/drivers/media/video/meye.c
@@ -71,43 +71,6 @@ MODULE_PARM_DESC(video_nr, "video device
 /* driver structure - only one possible */
 static struct meye meye;
 
-/****************************************************************************/
-/* Memory allocation routines (stolen from bttv-driver.c)                   */
-/****************************************************************************/
-static void *rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (mem) {
-		memset(mem, 0, size);
-		adr = (unsigned long) mem;
-		while (size > 0) {
-			SetPageReserved(vmalloc_to_page((void *)adr));
-			adr += PAGE_SIZE;
-			size -= PAGE_SIZE;
-		}
-	}
-	return mem;
-}
-
-static void rvfree(void * mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (mem) {
-		adr = (unsigned long) mem;
-		while ((long) size > 0) {
-			ClearPageReserved(vmalloc_to_page((void *)adr));
-			adr += PAGE_SIZE;
-			size -= PAGE_SIZE;
-		}
-		vfree(mem);
-	}
-}
-
 /*
  * return a page table pointing to N pages of locked memory
  *
@@ -1516,12 +1479,12 @@ static int meye_do_ioctl(struct inode *i
 					mutex_unlock(&meye.lock);
 					return -EINVAL;
 				}
-			rvfree(meye.grab_fbuffer, gbuffers * gbufsize);
+			vfree(meye.grab_fbuffer);
 			meye.grab_fbuffer = NULL;
 		}
 		gbuffers = max(2, min((int)req->count, MEYE_MAX_BUFNBRS));
 		req->count = gbuffers;
-		meye.grab_fbuffer = rvmalloc(gbuffers * gbufsize);
+		meye.grab_fbuffer = vmalloc_32_user(gbuffers * gbufsize);
 		if (!meye.grab_fbuffer) {
 			printk(KERN_ERR "meye: v4l framebuffer allocation"
 					" failed\n");
@@ -1710,7 +1673,7 @@ static int meye_mmap(struct file *file, 
 		int i;
 
 		/* lazy allocation */
-		meye.grab_fbuffer = rvmalloc(gbuffers*gbufsize);
+		meye.grab_fbuffer = vmalloc_32_user(gbuffers*gbufsize);
 		if (!meye.grab_fbuffer) {
 			printk(KERN_ERR "meye: v4l framebuffer allocation failed\n");
 			mutex_unlock(&meye.lock);
@@ -1982,7 +1945,7 @@ static void __devexit meye_remove(struct
 	vfree(meye.grab_temp);
 
 	if (meye.grab_fbuffer) {
-		rvfree(meye.grab_fbuffer, gbuffers*gbufsize);
+		vfree(meye.grab_fbuffer);
 		meye.grab_fbuffer = NULL;
 	}
 
Index: linux-2.6/drivers/media/video/ov511.c
===================================================================
--- linux-2.6.orig/drivers/media/video/ov511.c
+++ linux-2.6/drivers/media/video/ov511.c
@@ -11,7 +11,6 @@
  * Original SAA7111A code by Dave Perks <dperks@ibm.net>
  * URB error messages from pwc driver by Nemosoft
  * generic_ioctl() code from videodev.c by Gerd Knorr and Alan Cox
- * Memory management (rvmalloc) code from bttv driver, by Gerd Knorr and others
  *
  * Based on the Linux CPiA driver written by Peter Pregler,
  * Scott J. Bertin and Johannes Erdfelt.
@@ -310,48 +309,6 @@ static struct symbolic_list urb_errlist[
 };
 
 /**********************************************************************
- * Memory management
- **********************************************************************/
-static void *
-rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-static void
-rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
-/**********************************************************************
  *
  * Register I/O
  *
@@ -3791,8 +3748,7 @@ ov51x_do_dealloc(struct usb_ov511 *ov)
 	PDEBUG(4, "entered");
 
 	if (ov->fbuf) {
-		rvfree(ov->fbuf, OV511_NUMFRAMES
-		       * MAX_DATA_SIZE(ov->maxwidth, ov->maxheight));
+		vfree(ov->fbuf);
 		ov->fbuf = NULL;
 	}
 
@@ -3837,7 +3793,7 @@ ov51x_alloc(struct usb_ov511 *ov)
 	if (ov->buf_state == BUF_ALLOCATED)
 		goto out;
 
-	ov->fbuf = rvmalloc(data_bufsize);
+	ov->fbuf = vmalloc_32_user(data_bufsize);
 	if (!ov->fbuf)
 		goto error;
 
Index: linux-2.6/drivers/media/video/pwc/pwc-if.c
===================================================================
--- linux-2.6.orig/drivers/media/video/pwc/pwc-if.c
+++ linux-2.6/drivers/media/video/pwc/pwc-if.c
@@ -213,47 +213,6 @@ static inline unsigned long kvirt_to_pa(
 	return ret;
 }
 
-static void * rvmalloc(unsigned long size)
-{
-	void * mem;
-	unsigned long adr;
-
-	size=PAGE_ALIGN(size);
-	mem=vmalloc_32(size);
-	if (mem)
-	{
-		memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-		adr=(unsigned long) mem;
-		while (size > 0)
-		{
-			SetPageReserved(vmalloc_to_page((void *)adr));
-			adr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-	}
-	return mem;
-}
-
-static void rvfree(void * mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (mem)
-	{
-		adr=(unsigned long) mem;
-		while ((long) size > 0)
-		{
-			ClearPageReserved(vmalloc_to_page((void *)adr));
-			adr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-		vfree(mem);
-	}
-}
-
-
-
-
 static int pwc_allocate_buffers(struct pwc_device *pdev)
 {
 	int i;
@@ -335,7 +294,7 @@ static int pwc_allocate_buffers(struct p
 	pdev->decompress_data = kbuf;
 
 	/* Allocate image buffer; double buffer for mmap() */
-	kbuf = rvmalloc(default_mbufs * pdev->len_per_image);
+	kbuf = vmalloc_32_user(default_mbufs * pdev->len_per_image);
 	if (kbuf == NULL) {
 		Err("Failed to allocate image buffer(s). needed (%d)\n",default_mbufs * pdev->len_per_image);
 		return -ENOMEM;
@@ -400,7 +359,7 @@ static void pwc_free_buffers(struct pwc_
 	/* Release image buffers */
 	if (pdev->image_data != NULL) {
 		Trace(TRACE_MEMORY, "Freeing image buffer at %p.\n", pdev->image_data);
-		rvfree(pdev->image_data, default_mbufs * pdev->len_per_image);
+		vfree(pdev->image_data);
 	}
 	pdev->image_data = NULL;
 
Index: linux-2.6/drivers/media/video/se401.c
===================================================================
--- linux-2.6.orig/drivers/media/video/se401.c
+++ linux-2.6/drivers/media/video/se401.c
@@ -60,50 +60,6 @@ module_param(video_nr, int, 0);
 static struct usb_driver se401_driver;
 
 
-/**********************************************************************
- *
- * Memory management
- *
- **********************************************************************/
-static void *rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-static void rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
-
-
 /****************************************************************************
  *
  * se401 register read/write functions
@@ -907,7 +863,7 @@ static int se401_open(struct inode *inod
 
 	if (se401->user)
 		return -EBUSY;
-	se401->fbuf = rvmalloc(se401->maxframesize * SE401_NUMFRAMES);
+	se401->fbuf = vmalloc_32_user(se401->maxframesize * SE401_NUMFRAMES);
 	if (se401->fbuf)
 		file->private_data = dev;
 	else
@@ -923,7 +879,7 @@ static int se401_close(struct inode *ino
 	struct usb_se401 *se401 = (struct usb_se401 *)dev;
 	int i;
 
-	rvfree(se401->fbuf, se401->maxframesize * SE401_NUMFRAMES);
+	vfree(se401->fbuf);
 	if (se401->removed) {
 		usb_se401_remove_disconnected(se401);
 		info("device unregistered");
Index: linux-2.6/drivers/media/video/stv680.c
===================================================================
--- linux-2.6.orig/drivers/media/video/stv680.c
+++ linux-2.6/drivers/media/video/stv680.c
@@ -100,62 +100,6 @@ module_param(swapRGB_on, int, 0);
 MODULE_PARM_DESC (swapRGB_on, "Red/blue swap: 1=always, 0=auto, -1=never");
 module_param(video_nr, int, 0);
 
-/********************************************************************
- *
- * Memory management
- *
- * This is a shameless copy from the USB-cpia driver (linux kernel
- * version 2.3.29 or so, I have no idea what this code actually does ;).
- * Actually it seems to be a copy of a shameless copy of the bttv-driver.
- * Or that is a copy of a shameless copy of ... (To the powers: is there
- * no generic kernel-function to do this sort of stuff?)
- *
- * Yes, it was a shameless copy from the bttv-driver. IIRC, Alan says
- * there will be one, but apparentely not yet -jerdfelt
- *
- * So I copied it again for the ov511 driver -claudio
- *
- * Same for the se401 driver -Jeroen
- *
- * And the STV0680 driver - Kevin
- ********************************************************************/
-static void *rvmalloc (unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32 (size);
-	if (!mem)
-		return NULL;
-
-	memset (mem, 0, size);	/* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	return mem;
-}
-
-static void rvfree (void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree (mem);
-}
-
-
 /*********************************************************************
  * pencam read/write functions
  ********************************************************************/
@@ -1037,9 +981,10 @@ static int stv_open (struct inode *inode
 	err = stv_init (stv680);	/* main initialization routine for camera */
 
 	if (err >= 0) {
-		stv680->fbuf = rvmalloc (stv680->maxframesize * STV680_NUMFRAMES);
+		stv680->fbuf = vmalloc_32_user(stv680->maxframesize *
+							STV680_NUMFRAMES);
 		if (!stv680->fbuf) {
-			PDEBUG (0, "STV(e): Could not rvmalloc frame bufer");
+			PDEBUG (0, "STV(e): Could not vmalloc frame bufer");
 			err = -ENOMEM;
 		}
 		file->private_data = dev;
@@ -1064,7 +1009,7 @@ static int stv_close (struct inode *inod
 	if ((i = stv_stop_video (stv680)) < 0)
 		PDEBUG (1, "STV(e): stop_video failed in stv_close");
 
-	rvfree (stv680->fbuf, stv680->maxframesize * STV680_NUMFRAMES);
+	vfree(stv680->fbuf);
 	stv680->user = 0;
 
 	if (stv680->removed) {
Index: linux-2.6/drivers/media/video/usbvideo/usbvideo.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/usbvideo.c
+++ linux-2.6/drivers/media/video/usbvideo/usbvideo.c
@@ -57,46 +57,6 @@ static int usbvideo_NewFrame(struct uvd 
 static void usbvideo_SoftwareContrastAdjustment(struct uvd *uvd,
 						struct usbvideo_frame *frame);
 
-/*******************************/
-/* Memory management functions */
-/*******************************/
-static void *usbvideo_rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-static void usbvideo_rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
 static void RingQueue_Initialize(struct RingQueue *rq)
 {
 	assert(rq != NULL);
@@ -120,7 +80,7 @@ static void RingQueue_Allocate(struct Ri
 
 	rq->length = rqLen;
 	rq->ri = rq->wi = 0;
-	rq->queue = usbvideo_rvmalloc(rq->length);
+	rq->queue = vmalloc_32_user(rq->length);
 	assert(rq->queue != NULL);
 }
 
@@ -135,7 +95,7 @@ static void RingQueue_Free(struct RingQu
 {
 	assert(rq != NULL);
 	if (RingQueue_IsAllocated(rq)) {
-		usbvideo_rvfree(rq->queue, rq->length);
+		vfree(rq->queue);
 		rq->queue = NULL;
 		rq->length = 0;
 	}
@@ -1122,7 +1082,7 @@ static int usbvideo_v4l_open(struct inod
 
 		/* Allocate memory for the frame buffers */
 		uvd->fbuf_size = USBVIDEO_NUMFRAMES * uvd->max_frame_size;
-		uvd->fbuf = usbvideo_rvmalloc(uvd->fbuf_size);
+		uvd->fbuf = vmalloc_32_user(uvd->fbuf_size);
 		RingQueue_Allocate(&uvd->dp, RING_QUEUE_SIZE);
 		if ((uvd->fbuf == NULL) ||
 		    (!RingQueue_IsAllocated(&uvd->dp))) {
@@ -1151,7 +1111,7 @@ static int usbvideo_v4l_open(struct inod
 		if (errCode != 0) {
 			/* Have to free all that memory */
 			if (uvd->fbuf != NULL) {
-				usbvideo_rvfree(uvd->fbuf, uvd->fbuf_size);
+				vfree(uvd->fbuf);
 				uvd->fbuf = NULL;
 			}
 			RingQueue_Free(&uvd->dp);
@@ -1219,7 +1179,7 @@ static int usbvideo_v4l_close(struct ino
 
 	mutex_lock(&uvd->lock);
 	GET_CALLBACK(uvd, stopDataPump)(uvd);
-	usbvideo_rvfree(uvd->fbuf, uvd->fbuf_size);
+	vfree(uvd->fbuf);
 	uvd->fbuf = NULL;
 	RingQueue_Free(&uvd->dp);
 
Index: linux-2.6/drivers/media/video/usbvideo/vicam.c
===================================================================
--- linux-2.6.orig/drivers/media/video/usbvideo/vicam.c
+++ linux-2.6/drivers/media/video/usbvideo/vicam.c
@@ -352,50 +352,6 @@ static unsigned char setup5[] = {
 	0x46, 0x05, 0x6C, 0x05, 0x00, 0x00
 };
 
-/* rvmalloc / rvfree copied from usbvideo.c
- *
- * Not sure why these are not yet non-statics which I can reference through
- * usbvideo.h the same as it is in 2.4.20.  I bet this will get fixed sometime
- * in the future.
- *
-*/
-static void *rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-static void rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
 struct vicam_camera {
 	u16 shutter_speed;	// capture shutter speed
 	u16 gain;		// capture gain
@@ -783,7 +739,7 @@ vicam_open(struct inode *inode, struct f
 		return -ENOMEM;
 	}
 
-	cam->framebuf = rvmalloc(VICAM_MAX_FRAME_SIZE * VICAM_FRAMES);
+	cam->framebuf = vmalloc_32_user(VICAM_MAX_FRAME_SIZE * VICAM_FRAMES);
 	if (!cam->framebuf) {
 		kfree(cam->raw_image);
 		return -ENOMEM;
@@ -792,7 +748,7 @@ vicam_open(struct inode *inode, struct f
 	cam->cntrlbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!cam->cntrlbuf) {
 		kfree(cam->raw_image);
-		rvfree(cam->framebuf, VICAM_MAX_FRAME_SIZE * VICAM_FRAMES);
+		vfree(cam->framebuf);
 		return -ENOMEM;
 	}
 
@@ -830,7 +786,7 @@ vicam_close(struct inode *inode, struct 
 	set_camera_power(cam, 0);
 
 	kfree(cam->raw_image);
-	rvfree(cam->framebuf, VICAM_MAX_FRAME_SIZE * VICAM_FRAMES);
+	vfree(cam->framebuf);
 	kfree(cam->cntrlbuf);
 
 	mutex_lock(&cam->cam_lock);
Index: linux-2.6/drivers/media/video/w9968cf.c
===================================================================
--- linux-2.6.orig/drivers/media/video/w9968cf.c
+++ linux-2.6/drivers/media/video/w9968cf.c
@@ -449,8 +449,6 @@ static int w9968cf_i2c_control(struct i2
 			       unsigned long arg);
 
 /* Memory management */
-static void* rvmalloc(unsigned long size);
-static void rvfree(void *mem, unsigned long size);
 static void w9968cf_deallocate_memory(struct w9968cf_device*);
 static int  w9968cf_allocate_memory(struct w9968cf_device*);
 
@@ -593,50 +591,6 @@ static struct w9968cf_symbolic_list urb_
 	{ -1, NULL }
 };
 
-
-
-/****************************************************************************
- * Memory management functions                                              *
- ****************************************************************************/
-static void* rvmalloc(unsigned long size)
-{
-	void* mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-
-static void rvfree(void* mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
-
 /*--------------------------------------------------------------------------
   Deallocate previously allocated memory.
   --------------------------------------------------------------------------*/
@@ -652,19 +606,19 @@ static void w9968cf_deallocate_memory(st
 
 	/* Free temporary frame buffer */
 	if (cam->frame_tmp.buffer) {
-		rvfree(cam->frame_tmp.buffer, cam->frame_tmp.size);
+		vfree(cam->frame_tmp.buffer);
 		cam->frame_tmp.buffer = NULL;
 	}
 
 	/* Free helper buffer */
 	if (cam->frame_vpp.buffer) {
-		rvfree(cam->frame_vpp.buffer, cam->frame_vpp.size);
+		vfree(cam->frame_vpp.buffer);
 		cam->frame_vpp.buffer = NULL;
 	}
 
 	/* Free video frame buffers */
 	if (cam->frame[0].buffer) {
-		rvfree(cam->frame[0].buffer, cam->nbuffers*cam->frame[0].size);
+		vfree(cam->frame[0].buffer);
 		cam->frame[0].buffer = NULL;
 	}
 
@@ -711,7 +665,7 @@ static int w9968cf_allocate_memory(struc
 	}
 
 	/* Allocate memory for the temporary frame buffer */
-	if (!(cam->frame_tmp.buffer = rvmalloc(hw_bufsize))) {
+	if (!(cam->frame_tmp.buffer = vmalloc_32_user(hw_bufsize))) {
 		DBG(1, "Couldn't allocate memory for the temporary "
 		       "video frame buffer (%lu bytes)", hw_bufsize)
 		return -ENOMEM;
@@ -721,7 +675,7 @@ static int w9968cf_allocate_memory(struc
 
 	/* Allocate memory for the helper buffer */
 	if (w9968cf_vpp) {
-		if (!(cam->frame_vpp.buffer = rvmalloc(vpp_bufsize))) {
+		if (!(cam->frame_vpp.buffer = vmalloc_32_user(vpp_bufsize))) {
 			DBG(1, "Couldn't allocate memory for the helper buffer"
 			       " (%lu bytes)", vpp_bufsize)
 			return -ENOMEM;
@@ -733,7 +687,7 @@ static int w9968cf_allocate_memory(struc
 	/* Allocate memory for video frame buffers */
 	cam->nbuffers = cam->max_buffers;
 	while (cam->nbuffers >= 2) {
-		if ((buff = rvmalloc(cam->nbuffers * vpp_bufsize)))
+		if ((buff = vmalloc_32_user(cam->nbuffers * vpp_bufsize)))
 			break;
 		else
 			cam->nbuffers--;
Index: linux-2.6/include/linux/vmalloc.h
===================================================================
--- linux-2.6.orig/include/linux/vmalloc.h
+++ linux-2.6/include/linux/vmalloc.h
@@ -32,9 +32,11 @@ struct vm_struct {
  *	Highlevel APIs for driver use
  */
 extern void *vmalloc(unsigned long size);
+extern void *vmalloc_user(unsigned long size);
 extern void *vmalloc_node(unsigned long size, int node);
 extern void *vmalloc_exec(unsigned long size);
 extern void *vmalloc_32(unsigned long size);
+extern void *vmalloc_32_user(unsigned long size);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot);
 extern void *__vmalloc_area(struct vm_struct *area, gfp_t gfp_mask,
 				pgprot_t prot);
Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -89,10 +89,9 @@ static int save_highmem_zone(struct zone
 			continue;
 		page = pfn_to_page(pfn);
 		/*
-		 * This condition results from rvmalloc() sans vmalloc_32()
-		 * and architectural memory reservations. This should be
-		 * corrected eventually when the cases giving rise to this
-		 * are better understood.
+		 * This condition results from architectural memory
+		 * reservations. This should be corrected eventually when the
+		 * cases giving rise to this are better understood.
 		 */
 		if (PageReserved(page))
 			continue;
Index: linux-2.6/mm/vmalloc.c
===================================================================
--- linux-2.6.orig/mm/vmalloc.c
+++ linux-2.6/mm/vmalloc.c
@@ -511,11 +511,24 @@ EXPORT_SYMBOL(__vmalloc);
  */
 void *vmalloc(unsigned long size)
 {
-       return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL);
 }
 EXPORT_SYMBOL(vmalloc);
 
 /**
+ *	vmalloc_user  -  allocate virtually contiguous memory which has
+ *			   been zeroed so it can be mapped to userspace without
+ *			   leaking data.
+ *
+ *	@size:		allocation size
+ */
+void *vmalloc_user(unsigned long size)
+{
+	return __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
+}
+EXPORT_SYMBOL(vmalloc_user);
+
+/**
  *	vmalloc_node  -  allocate memory on a specific node
  *
  *	@size:		allocation size
@@ -529,7 +542,7 @@ EXPORT_SYMBOL(vmalloc);
  */
 void *vmalloc_node(unsigned long size, int node)
 {
-       return __vmalloc_node(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, node);
+	return __vmalloc_node(size, GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL, node);
 }
 EXPORT_SYMBOL(vmalloc_node);
 
@@ -569,6 +582,19 @@ void *vmalloc_32(unsigned long size)
 }
 EXPORT_SYMBOL(vmalloc_32);
 
+/**
+ *	vmalloc_32_user  -  allocate virtually contiguous memory (32bit
+ *			      addressable) which is zeroed so it can be
+ *			      mapped to userspace without leaking data.
+ *
+ *	@size:		allocation size
+ */
+void *vmalloc_32_user(unsigned long size)
+{
+	return __vmalloc(size, GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL);
+}
+EXPORT_SYMBOL(vmalloc_32_user);
+
 long vread(char *buf, char *addr, unsigned long count)
 {
 	struct vm_struct *tmp;
Index: linux-2.6/arch/ia64/kernel/perfmon.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/perfmon.c
+++ linux-2.6/arch/ia64/kernel/perfmon.c
@@ -558,17 +558,6 @@ pfm_clear_task_notify(void)
 	clear_thread_flag(TIF_NOTIFY_RESUME);
 }
 
-static inline void
-pfm_reserve_page(unsigned long a)
-{
-	SetPageReserved(vmalloc_to_page((void *)a));
-}
-static inline void
-pfm_unreserve_page(unsigned long a)
-{
-	ClearPageReserved(vmalloc_to_page((void*)a));
-}
-
 static inline unsigned long
 pfm_protect_ctx_ctxsw(pfm_context_t *x)
 {
@@ -799,45 +788,6 @@ pfm_reset_msgq(pfm_context_t *ctx)
 	DPRINT(("ctx=%p msgq reset\n", ctx));
 }
 
-static void *
-pfm_rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long addr;
-
-	size = PAGE_ALIGN(size);
-	mem  = vmalloc(size);
-	if (mem) {
-		//printk("perfmon: CPU%d pfm_rvmalloc(%ld)=%p\n", smp_processor_id(), size, mem);
-		memset(mem, 0, size);
-		addr = (unsigned long)mem;
-		while (size > 0) {
-			pfm_reserve_page(addr);
-			addr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-	}
-	return mem;
-}
-
-static void
-pfm_rvfree(void *mem, unsigned long size)
-{
-	unsigned long addr;
-
-	if (mem) {
-		DPRINT(("freeing physical buffer @%p size=%lu\n", mem, size));
-		addr = (unsigned long) mem;
-		while ((long) size > 0) {
-			pfm_unreserve_page(addr);
-			addr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-		vfree(mem);
-	}
-	return;
-}
-
 static pfm_context_t *
 pfm_context_alloc(void)
 {
@@ -1455,7 +1405,7 @@ pfm_free_smpl_buffer(pfm_context_t *ctx)
 	/*
 	 * free the buffer
 	 */
-	pfm_rvfree(ctx->ctx_smpl_hdr, ctx->ctx_smpl_size);
+	vfree(ctx->ctx_smpl_hdr);
 
 	ctx->ctx_smpl_hdr  = NULL;
 	ctx->ctx_smpl_size = 0UL;
@@ -2106,12 +2056,14 @@ doit:
 	 * All memory free operations (especially for vmalloc'ed memory)
 	 * MUST be done with interrupts ENABLED.
 	 */
-	if (smpl_buf_addr)  pfm_rvfree(smpl_buf_addr, smpl_buf_size);
+	if (smpl_buf_addr)
+		vfree(smpl_buf_addr);
 
 	/*
 	 * return the memory used by the context
 	 */
-	if (free_possible) pfm_context_free(ctx);
+	if (free_possible)
+		pfm_context_free(ctx);
 
 	return 0;
 }
@@ -2270,9 +2222,9 @@ pfm_smpl_buffer_alloc(struct task_struct
 	/*
 	 * We do the easy to undo allocations first.
  	 *
-	 * pfm_rvmalloc(), clears the buffer, so there is no leak
+	 * vmalloc_user(), clears the buffer, so there is no leak
 	 */
-	smpl_buf = pfm_rvmalloc(size);
+	smpl_buf = vmalloc_user(size);
 	if (smpl_buf == NULL) {
 		DPRINT(("Can't allocate sampling buffer\n"));
 		return -ENOMEM;
@@ -2352,7 +2304,7 @@ pfm_smpl_buffer_alloc(struct task_struct
 error:
 	kmem_cache_free(vm_area_cachep, vma);
 error_kmem:
-	pfm_rvfree(smpl_buf, size);
+	vfree(smpl_buf);
 
 	return -ENOMEM;
 }
