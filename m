Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311656AbSCNQYh>; Thu, 14 Mar 2002 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311652AbSCNQY0>; Thu, 14 Mar 2002 11:24:26 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:12945 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S311656AbSCNQX5>; Thu, 14 Mar 2002 11:23:57 -0500
Date: Thu, 14 Mar 2002 17:23:42 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Knorr <kraxel@bytesex.org>
Subject: [BKPATCH 2.5] Port the MotionEye camera driver to the new v4l API.
Message-ID: <20020314162342.GE5794@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gerd Knorr <kraxel@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached BK patch ports the MotionEye camera driver to the
new Gerd's video4linux API.

Linus, please apply.

Stelian.


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.474, 2002-03-14 17:20:21+01:00, stelian@popies.net
  Port the MotionEye driver to the new video4linux API.


 meye.c |  223 +++++++++++++++++++++++++++++------------------------------------
 meye.h |    3 
 2 files changed, 101 insertions(+), 125 deletions(-)


diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Thu Mar 14 17:20:57 2002
+++ b/drivers/media/video/meye.c	Thu Mar 14 17:20:57 2002
@@ -868,124 +868,108 @@
 /* video4linux integration                                                  */
 /****************************************************************************/
 
-static int meye_open(struct video_device *dev, int flags) {
-	int i;
+static int meye_open(struct inode *inode, struct file *file) {
+	int i, err;
 
-	down(&meye.lock);
-	if (meye.open_count) {
-		up(&meye.lock);
-		return -EBUSY;
-	}
-	meye.open_count++;
+	err = video_exclusive_open(inode,file);
+	if (err < 0)
+		return err;
+			
 	if (mchip_dma_alloc()) {
 		printk(KERN_ERR "meye: mchip framebuffer allocation failed\n");
-		up(&meye.lock);
+		video_exclusive_release(inode,file);
 		return -ENOBUFS;
 	}
 	mchip_hic_stop();
 	meye_initq(&meye.grabq);
 	for (i = 0; i < MEYE_MAX_BUFNBRS; i++)
 		meye.grab_buffer[i].state = MEYE_BUF_UNUSED;
-	up(&meye.lock);
 	return 0;
 }
 
-static void meye_close(struct video_device *dev) {
-	down(&meye.lock);
-	meye.open_count--;
+static int meye_release(struct inode *inode, struct file *file) {
 	mchip_hic_stop();
-	up(&meye.lock);
+	video_exclusive_release(inode,file);
+	return 0;
 }
 
-static int meye_ioctl(struct video_device *dev, unsigned int cmd, void *arg) {
+static int meye_ioctl(struct inode *inode, struct file *file,
+		      unsigned int cmd, void *arg) {
 
 	switch (cmd) {
 
 	case VIDIOCGCAP: {
-		struct video_capability b;
-		strcpy(b.name,meye.video_dev.name);
-		b.type = VID_TYPE_CAPTURE;
-		b.channels = 1;
-		b.audios = 0;
-		b.maxwidth = 640;
-		b.maxheight = 480;
-		b.minwidth = 320;
-		b.minheight = 240;
-		if(copy_to_user(arg,&b,sizeof(b)))
-			return -EFAULT;
+		struct video_capability *b = arg;
+		strcpy(b->name,meye.video_dev.name);
+		b->type = VID_TYPE_CAPTURE;
+		b->channels = 1;
+		b->audios = 0;
+		b->maxwidth = 640;
+		b->maxheight = 480;
+		b->minwidth = 320;
+		b->minheight = 240;
 		break;
 	}
 
 	case VIDIOCGCHAN: {
-		struct video_channel v;
-		if(copy_from_user(&v, arg,sizeof(v)))
-			return -EFAULT;
-		v.flags = 0;
-		v.tuners = 0;
-		v.type = VIDEO_TYPE_CAMERA;
-		if (v.channel != 0)
-			return -EINVAL;
-		strcpy(v.name,"Camera");
-		if(copy_to_user(arg,&v,sizeof(v)))
-			return -EFAULT;
+		struct video_channel *v = arg;
+		v->flags = 0;
+		v->tuners = 0;
+		v->type = VIDEO_TYPE_CAMERA;
+		if (v->channel != 0)
+			return -EINVAL;
+		strcpy(v->name,"Camera");
 		break;
 	}
 
 	case VIDIOCSCHAN: {
-		struct video_channel v;
-		if(copy_from_user(&v, arg,sizeof(v)))
-			return -EFAULT;
-		if (v.channel != 0)
+		struct video_channel *v = arg;
+		if (v->channel != 0)
 			return -EINVAL;
 		break;
 	}
 
 	case VIDIOCGPICT: {
-		struct video_picture p = meye.picture;
-		if(copy_to_user(arg, &p, sizeof(p)))
-			return -EFAULT;
+		struct video_picture *p = arg;
+		*p = meye.picture;
 		break;
 	}
 
 	case VIDIOCSPICT: {
-		struct video_picture p;
-		if(copy_from_user(&p, arg,sizeof(p)))
-			return -EFAULT;
-		if (p.depth != 2)
+		struct video_picture *p = arg;
+		if (p->depth != 2)
 			return -EINVAL;
-		if (p.palette != VIDEO_PALETTE_YUV422)
+		if (p->palette != VIDEO_PALETTE_YUV422)
 			return -EINVAL;
 		down(&meye.lock);
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERABRIGHTNESS, 
-				      p.brightness >> 10);
+				      p->brightness >> 10);
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERAHUE, 
-				      p.hue >> 10);
+				      p->hue >> 10);
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERACOLOR, 
-				      p.colour >> 10);
+				      p->colour >> 10);
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERACONTRAST, 
-				      p.contrast >> 10);
-		memcpy(&meye.picture, &p, sizeof(p));
+				      p->contrast >> 10);
+		meye.picture = *p;
 		up(&meye.lock);
 		break;
 	}
 
 	case VIDIOCSYNC: {
-		int i;
+		int *i = arg;
 		DECLARE_WAITQUEUE(wait, current);
 
-		if(copy_from_user((void *)&i,arg,sizeof(int)))
-			return -EFAULT;
-		if (i < 0 || i >= gbuffers)
+		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
 
-		switch (meye.grab_buffer[i].state) {
+		switch (meye.grab_buffer[*i].state) {
 
 		case MEYE_BUF_UNUSED:
 			return -EINVAL;
 		case MEYE_BUF_USING:
 			add_wait_queue(&meye.grabq.proc_list, &wait);
 			current->state = TASK_INTERRUPTIBLE;
-			while (meye.grab_buffer[i].state == MEYE_BUF_USING) {
+			while (meye.grab_buffer[*i].state == MEYE_BUF_USING) {
 				schedule();
 				if(signal_pending(current)) {
 					remove_wait_queue(&meye.grabq.proc_list, &wait);
@@ -997,36 +981,34 @@
 			current->state = TASK_RUNNING;
 			/* fall through */
 		case MEYE_BUF_DONE:
-			meye.grab_buffer[i].state = MEYE_BUF_UNUSED;
+			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
 		}
 		break;
 	}
 
 	case VIDIOCMCAPTURE: {
-		struct video_mmap vm;
+		struct video_mmap *vm = arg;
 		int restart = 0;
 
-		if(copy_from_user((void *) &vm, (void *) arg, sizeof(vm)))
-			return -EFAULT;
-		if (vm.frame >= gbuffers || vm.frame < 0)
+		if (vm->frame >= gbuffers || vm->frame < 0)
 			return -EINVAL;
-		if (vm.format != VIDEO_PALETTE_YUV422)
+		if (vm->format != VIDEO_PALETTE_YUV422)
 			return -EINVAL;
-		if (vm.height * vm.width * 2 > gbufsize)
+		if (vm->height * vm->width * 2 > gbufsize)
 			return -EINVAL;
 		if (!meye.grab_fbuffer)
 			return -EINVAL;
-		if (meye.grab_buffer[vm.frame].state != MEYE_BUF_UNUSED)
+		if (meye.grab_buffer[vm->frame].state != MEYE_BUF_UNUSED)
 			return -EBUSY;
 
 		down(&meye.lock);
-		if (vm.width == 640 && vm.height == 480) {
+		if (vm->width == 640 && vm->height == 480) {
 			if (meye.params.subsample) {
 				meye.params.subsample = 0;
 				restart = 1;
 			}
 		}
-		else if (vm.width == 320 && vm.height == 240) {
+		else if (vm->width == 320 && vm->height == 240) {
 			if (!meye.params.subsample) {
 				meye.params.subsample = 1;
 				restart = 1;
@@ -1039,49 +1021,45 @@
 
 		if (restart || meye.mchip_mode != MCHIP_HIC_MODE_CONT_OUT)
 			mchip_continuous_start();
-		meye.grab_buffer[vm.frame].state = MEYE_BUF_USING;
-		meye_pushq(&meye.grabq, vm.frame);
+		meye.grab_buffer[vm->frame].state = MEYE_BUF_USING;
+		meye_pushq(&meye.grabq, vm->frame);
 		up(&meye.lock);
 		break;
 	}
 
 	case VIDIOCGMBUF: {
-		struct video_mbuf vm;
+		struct video_mbuf *vm = arg;
 		int i;
 
-		memset(&vm, 0 , sizeof(vm));
-		vm.size = gbufsize * gbuffers;
-		vm.frames = gbuffers;
+		memset(vm, 0 , sizeof(*vm));
+		vm->size = gbufsize * gbuffers;
+		vm->frames = gbuffers;
 		for (i = 0; i < gbuffers; i++)
-			vm.offsets[i] = i * gbufsize;
-		if(copy_to_user((void *)arg, (void *)&vm, sizeof(vm)))
-			return -EFAULT;
+			vm->offsets[i] = i * gbufsize;
 		break;
 	}
 
 	case MEYEIOC_G_PARAMS: {
-		if (copy_to_user(arg, &meye.params, sizeof(meye.params)))
-			return -EFAULT;
+		struct meye_params *p = arg;
+		*p = meye.params;
 		break;
 	}
 
 	case MEYEIOC_S_PARAMS: {
-		struct meye_params jp;
-		if (copy_from_user(&jp, arg, sizeof(jp)))
-			return -EFAULT;
-		if (jp.subsample > 1)
+		struct meye_params *jp = arg;
+		if (jp->subsample > 1)
 			return -EINVAL;
-		if (jp.quality > 10)
+		if (jp->quality > 10)
 			return -EINVAL;
-		if (jp.sharpness > 63 || jp.agc > 63 || jp.picture > 63)
+		if (jp->sharpness > 63 || jp->agc > 63 || jp->picture > 63)
 			return -EINVAL;
-		if (jp.framerate > 31)
+		if (jp->framerate > 31)
 			return -EINVAL;
 		down(&meye.lock);
-		if (meye.params.subsample != jp.subsample ||
-		    meye.params.quality != jp.quality)
+		if (meye.params.subsample != jp->subsample ||
+		    meye.params.quality != jp->quality)
 			mchip_hic_stop();	/* need restart */
-		memcpy(&meye.params, &jp, sizeof(jp));
+		meye.params = *jp;
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERASHARPNESS,
 				      meye.params.sharpness);
 		sonypi_camera_command(SONYPI_COMMAND_SETCAMERAAGC,
@@ -1093,48 +1071,43 @@
 	}
 
 	case MEYEIOC_QBUF_CAPT: {
-		int nb;
-
-		if (copy_from_user((void *) &nb, (void *) arg, sizeof(int)))
-			return -EFAULT;
+		int *nb = arg;
 
 		if (!meye.grab_fbuffer) 
 			return -EINVAL;
-		if (nb >= gbuffers)
+		if (*nb >= gbuffers)
 			return -EINVAL;
-		if (nb < 0) {
+		if (*nb < 0) {
 			/* stop capture */
 			mchip_hic_stop();
 			return 0;
 		}
-		if (meye.grab_buffer[nb].state != MEYE_BUF_UNUSED)
+		if (meye.grab_buffer[*nb].state != MEYE_BUF_UNUSED)
 			return -EBUSY;
 		down(&meye.lock);
 		if (meye.mchip_mode != MCHIP_HIC_MODE_CONT_COMP)
 			mchip_cont_compression_start();
-		meye.grab_buffer[nb].state = MEYE_BUF_USING;
-		meye_pushq(&meye.grabq, nb);
+		meye.grab_buffer[*nb].state = MEYE_BUF_USING;
+		meye_pushq(&meye.grabq, *nb);
 		up(&meye.lock);
 		break;
 	}
 
 	case MEYEIOC_SYNC: {
-		int i;
+		int *i = arg;
 		DECLARE_WAITQUEUE(wait, current);
 
-		if(copy_from_user((void *)&i,arg,sizeof(int)))
-			return -EFAULT;
-		if (i < 0 || i >= gbuffers)
+		if (*i < 0 || *i >= gbuffers)
 			return -EINVAL;
 
-		switch (meye.grab_buffer[i].state) {
+		switch (meye.grab_buffer[*i].state) {
 
 		case MEYE_BUF_UNUSED:
 			return -EINVAL;
 		case MEYE_BUF_USING:
 			add_wait_queue(&meye.grabq.proc_list, &wait);
 			current->state = TASK_INTERRUPTIBLE;
-			while (meye.grab_buffer[i].state == MEYE_BUF_USING) {
+			while (meye.grab_buffer[*i].state == MEYE_BUF_USING) {
 				schedule();
 				if(signal_pending(current)) {
 					remove_wait_queue(&meye.grabq.proc_list, &wait);
@@ -1146,11 +1119,9 @@
 			current->state = TASK_RUNNING;
 			/* fall through */
 		case MEYE_BUF_DONE:
-			meye.grab_buffer[i].state = MEYE_BUF_UNUSED;
+			meye.grab_buffer[*i].state = MEYE_BUF_UNUSED;
 		}
-		i = meye.grab_buffer[i].size;
-		if (copy_to_user(arg, (void *)&i, sizeof(int)))
-			return -EFAULT;
+		*i = meye.grab_buffer[*i].size;
 		break;
 	}
 
@@ -1172,7 +1143,7 @@
 	}
 
 	case MEYEIOC_STILLJCAPT: {
-		int len = -1;
+		int *len = arg;
 
 		if (!meye.grab_fbuffer) 
 			return -EINVAL;
@@ -1180,14 +1151,13 @@
 			return -EBUSY;
 		down(&meye.lock);
 		meye.grab_buffer[0].state = MEYE_BUF_USING;
-		while (len == -1) {
+		*len = -1;
+		while (*len == -1) {
 			mchip_take_picture();
-			len = mchip_compress_frame(meye.grab_fbuffer, gbufsize);
+			*len = mchip_compress_frame(meye.grab_fbuffer, gbufsize);
 		}
 		meye.grab_buffer[0].state = MEYE_BUF_DONE;
 		up(&meye.lock);
-		if (copy_to_user(arg, (void *)&len, sizeof(int)))
-			return -EFAULT;
 		break;
 	}
 
@@ -1199,10 +1169,10 @@
 	return 0;
 }
 
-static int meye_mmap(struct vm_area_struct *vma, struct video_device *dev, const char *adr, 
-		     unsigned long size) {
-	unsigned long start=(unsigned long) adr;
-	unsigned long page,pos;
+static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
+	unsigned long start = vma->vm_start;
+	unsigned long size  = vma->vm_end - vma->vm_start;
+	unsigned long page, pos;
 
 	down(&meye.lock);
 	if (size > gbuffers * gbufsize) {
@@ -1234,15 +1204,22 @@
 	return 0;
 }
 
+static struct file_operations meye_fops = {
+	owner:		THIS_MODULE,
+	open:		meye_open,
+	release:	meye_release,
+	mmap:		meye_mmap,
+	ioctl:		video_generic_ioctl,
+	llseek:		no_llseek,
+};
+
 static struct video_device meye_template = {
 	owner:		THIS_MODULE,
 	name:		"meye",
 	type:		VID_TYPE_CAPTURE,
 	hardware:	VID_HARDWARE_MEYE,
-	open:		meye_open,
-	close:		meye_close,
-	ioctl:		meye_ioctl,
-	mmap:		meye_mmap,
+	fops:		&meye_fops,
+	kernel_ioctl:	meye_ioctl,
 };
 
 static int __devinit meye_probe(struct pci_dev *pcidev, 
diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	Thu Mar 14 17:20:57 2002
+++ b/drivers/media/video/meye.h	Thu Mar 14 17:20:57 2002
@@ -29,7 +29,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	1
-#define MEYE_DRIVER_MINORVERSION	2
+#define MEYE_DRIVER_MINORVERSION	3
 
 /****************************************************************************/
 /* Motion JPEG chip registers                                               */
@@ -300,7 +300,6 @@
 	struct meye_grab_buffer grab_buffer[MEYE_MAX_BUFNBRS];
 
 	/* other */
-	unsigned int open_count;	/* open() count */
 	struct semaphore lock;		/* semaphore for open/mmap... */
 
 	struct meye_queue grabq;	/* queue for buffers to be grabbed */

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch2803
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
ISR^NX.%Z>'%NV,`N3Z[J=CN<\?!SL5QT7<^+`N:-S3\!F%B.VE07````
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
