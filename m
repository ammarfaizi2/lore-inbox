Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSCOLLx>; Fri, 15 Mar 2002 06:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOLKo>; Fri, 15 Mar 2002 06:10:44 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:56803 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S290277AbSCOLJB>; Fri, 15 Mar 2002 06:09:01 -0500
Date: Fri, 15 Mar 2002 12:08:38 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Gerd Knorr <kraxel@bytesex.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK PATCH 2.4] meye driver update to new V4L API.
Message-ID: <20020315110838.GH13625@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Gerd Knorr <kraxel@bytesex.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached BK patch (dependent on the previous videodev.c one)
backports the 2.5 version of the Motion Eye driver to 2.4 using
the recent changes in V4L API and the memory allocation cleanups,
thanks to vmalloc_to_page.

Stelian.

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.199, 2002-03-15 11:53:50+01:00, stelian@popies.net
  Backport the 2.5 meye driver thanks to the recent Gerd's work:
  	- use the new V4L API
  	- use vmalloc_to_page and clean up memory allocation


 meye.c |  279 ++++++++++++++++++++++++++---------------------------------------
 meye.h |    3 
 2 files changed, 114 insertions(+), 168 deletions(-)


diff -Nru a/drivers/media/video/meye.c b/drivers/media/video/meye.c
--- a/drivers/media/video/meye.c	Fri Mar 15 11:56:09 2002
+++ b/drivers/media/video/meye.c	Fri Mar 15 11:56:09 2002
@@ -115,58 +115,29 @@
 /* Memory allocation routines (stolen from bttv-driver.c)                   */
 /****************************************************************************/
 
-#define MDEBUG(x)	do {} while (0)
-/* #define MDEBUG(x)	x */
-
-/* Given PGD from the address space's page table, return the kernel
- * virtual mapping of the physical memory mapped at ADR.
- */
-static inline unsigned long uvirt_to_kva(pgd_t *pgd, unsigned long adr) {
-        unsigned long ret = 0UL;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-  
-	if (!pgd_none(*pgd)) {
-                pmd = pmd_offset(pgd, adr);
-                if (!pmd_none(*pmd)) {
-                        ptep = pte_offset(pmd, adr);
-                        pte = *ptep;
-                        if(pte_present(pte)) {
-				ret = (unsigned long)page_address(pte_page(pte));
-				ret |= (adr & (PAGE_SIZE - 1));
-				
-			}
-                }
-        }
-        MDEBUG(printk("uv2kva(%lx-->%lx)\n", adr, ret));
-	return ret;
-}
-
 /* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+ * This is used when initializing the contents of the area.
  */
 static inline unsigned long kvirt_to_pa(unsigned long adr) {
-        unsigned long va, kva, ret;
+        unsigned long kva, ret;
 
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
+        kva = (unsigned long) page_address(vmalloc_to_page((void *)adr));
+	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
 	ret = __pa(kva);
-        MDEBUG(printk("kv2pa(%lx-->%lx)\n", adr, ret));
         return ret;
 }
 
-static void *rvmalloc(signed long size) {
+static void *rvmalloc(unsigned long size) {
 	void *mem;
-	unsigned long adr, page;
+	unsigned long adr;
 
+	size = PAGE_ALIGN(size);
 	mem = vmalloc_32(size);
 	if (mem) {
 		memset(mem, 0, size); /* Clear the ram out, no junk to the user */
 	        adr = (unsigned long)mem;
 		while (size > 0) {
-	                page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
+			mem_map_reserve(vmalloc_to_page((void *)adr));
 			adr += PAGE_SIZE;
 			size -= PAGE_SIZE;
 		}
@@ -174,14 +145,13 @@
 	return mem;
 }
 
-static void rvfree(void * mem, signed long size) {
-        unsigned long adr, page;
-        
+static void rvfree(void * mem, unsigned long size) {
+        unsigned long adr;
+
 	if (mem) {
 	        adr = (unsigned long) mem;
-		while (size > 0) {
-	                page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
+		while ((long) size > 0) {
+			mem_map_unreserve(vmalloc_to_page((void *)adr));
 			adr += PAGE_SIZE;
 			size -= PAGE_SIZE;
 		}
@@ -898,124 +868,108 @@
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
@@ -1027,36 +981,34 @@
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
@@ -1069,49 +1021,45 @@
 
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
@@ -1123,48 +1071,43 @@
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
@@ -1176,11 +1119,9 @@
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
 
@@ -1202,7 +1143,7 @@
 	}
 
 	case MEYEIOC_STILLJCAPT: {
-		int len = -1;
+		int *len = arg;
 
 		if (!meye.grab_fbuffer) 
 			return -EINVAL;
@@ -1210,14 +1151,13 @@
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
 
@@ -1229,10 +1169,10 @@
 	return 0;
 }
 
-static int meye_mmap(struct video_device *dev, const char *adr, 
-		     unsigned long size) {
-	unsigned long start=(unsigned long) adr;
-	unsigned long page,pos;
+static int meye_mmap(struct file *file, struct vm_area_struct *vma) {
+	unsigned long start = vma->vm_start;
+	unsigned long size  = vma->vm_end - vma->vm_start;
+	unsigned long page, pos;
 
 	down(&meye.lock);
 	if (size > gbuffers * gbufsize) {
@@ -1264,15 +1204,22 @@
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
--- a/drivers/media/video/meye.h	Fri Mar 15 11:56:09 2002
+++ b/drivers/media/video/meye.h	Fri Mar 15 11:56:09 2002
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


begin 664 bkpatch1688
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
AKEF`+@:>U=^BPIB'=^5LVG.I;PW]D.G_`7(5DJH&&P``
`
end
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
