Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130098AbQJ1RD3>; Sat, 28 Oct 2000 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130619AbQJ1RDS>; Sat, 28 Oct 2000 13:03:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28177 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130098AbQJ1RDR>;
	Sat, 28 Oct 2000 13:03:17 -0400
Message-ID: <39FB06B5.E52682B9@mandrakesoft.com>
Date: Sat, 28 Oct 2000 13:02:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.0.10.6: video4linux API update, bttv mmap rewrite
Content-Type: multipart/mixed;
 boundary="------------FEE170067228740FBD42B904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FEE170067228740FBD42B904
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thought some people here might be interested in this too...  Description
quoted below.
-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and screaming like a cheerleader."
                        |      -Max


> This patch, against 2.4.0-test10-pre6, updates bttv to use the new and
> groovy method of supporting mmap.
> 
> Advantages:
> * Code more simple.
> * mmap now only limited to number of free pages in the system (busts vmalloc limits)
> * mmap no longer requires vmalloc, or remap_page_range.
> 
> Disadvantages:
> * Requires videodev API update (new member: mmap_vma).
> * KNOWN BUG: If your gbufsize causes a frame to cross a page boundary,
> you lose.  The code doesn't support this, and doesn't check for it
> either.  Boom.  (this is fixable though)
> * Totally untested.  I don't own any bttv hardware.
>
--------------FEE170067228740FBD42B904
Content-Type: text/plain; charset=us-ascii;
 name="bttv-mmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bttv-mmap.patch"

Index: include/linux/videodev.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/videodev.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 videodev.h
--- include/linux/videodev.h	2000/10/22 19:36:11	1.1.1.1
+++ include/linux/videodev.h	2000/10/28 07:31:20
@@ -32,6 +32,7 @@
 	int busy;
 	int minor;
 	devfs_handle_t devfs_handle;
+	int (*mmap_vma)(struct file *, struct vm_area_struct *, struct video_device *);
 };
 
 extern int videodev_init(void);
Index: drivers/media/video/bttv-driver.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/media/video/bttv-driver.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 bttv-driver.c
--- drivers/media/video/bttv-driver.c	2000/10/22 22:02:34	1.1.1.2
+++ drivers/media/video/bttv-driver.c	2000/10/28 07:31:24
@@ -142,16 +142,6 @@
 	return ret;
 }
 
-static inline unsigned long uvirt_to_bus(unsigned long adr) 
-{
-        unsigned long kva, ret;
-
-        kva = uvirt_to_kva(pgd_offset(current->mm, adr), adr);
-	ret = virt_to_bus((void *)kva);
-        MDEBUG(printk("uv2b(%lx-->%lx)", adr, ret));
-        return ret;
-}
-
 static inline unsigned long kvirt_to_bus(unsigned long adr) 
 {
         unsigned long va, kva, ret;
@@ -163,79 +153,60 @@
         return ret;
 }
 
-/* Here we want the physical address of the memory.
- * This is used when initializing the contents of the
- * area and marking the pages as reserved.
+/*
+ *	Alloc and free DMA pages for mmap(2)
  */
-static inline unsigned long kvirt_to_pa(unsigned long adr) 
-{
-        unsigned long va, kva, ret;
-
-        va = VMALLOC_VMADDR(adr);
-        kva = uvirt_to_kva(pgd_offset_k(va), va);
-	ret = __pa(kva);
-        MDEBUG(printk("kv2pa(%lx-->%lx)", adr, ret));
-        return ret;
-}
-
-static void * rvmalloc(signed long size)
+ 
+static void free_dmabuffers(struct bttv *btv)
 {
-	void * mem;
-	unsigned long adr, page;
+	unsigned int i;
 
-	mem=vmalloc_32(size);
-	if (mem) 
-	{
-		memset(mem, 0, size); /* Clear the ram out, no junk to the user */
-	        adr=(unsigned long) mem;
-		while (size > 0) 
-                {
-	                page = kvirt_to_pa(adr);
-			mem_map_reserve(virt_to_page(__va(page)));
-			adr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
+	if (btv->page) {
+		for (i = 0; i < btv->n_pages; i++)
+			if (btv->page[i].cpuaddr)
+				pci_free_consistent (btv->dev, PAGE_SIZE,
+						     btv->page[i].cpuaddr,
+						     btv->page[i].handle);
+		memset(btv->page, 0, sizeof(btv->page) * btv->n_pages);
+		btv->n_pages = 0;
+		kfree(btv->page);
+		btv->page = NULL;
 	}
-	return mem;
 }
 
-static void rvfree(void * mem, signed long size)
+static int alloc_dmabuffers(struct bttv *btv)
 {
-        unsigned long adr, page;
-        
-	if (mem) 
-	{
-	        adr=(unsigned long) mem;
-		while (size > 0) 
-                {
-	                page = kvirt_to_pa(adr);
-			mem_map_unreserve(virt_to_page(__va(page)));
-			adr+=PAGE_SIZE;
-			size-=PAGE_SIZE;
-		}
-		vfree(mem);
-	}
-}
+	unsigned int i;
 
+	if (btv->page) {
+		printk(KERN_ERR "bttv%d: Double alloc of DMA pages!\n",	btv->nr);
+		return 0;
+	}
 
+	btv->n_pages = (gbuffers * gbufsize) >> PAGE_SHIFT;
+	if ((gbuffers * gbufsize) % PAGE_SIZE)
+		btv->n_pages++;
 
-/*
- *	Create the giant waste of buffer space we need for now
- *	until we get DMA to user space sorted out (probably 2.3.x)
- *
- *	We only create this as and when someone uses mmap
- */
- 
-static int fbuffer_alloc(struct bttv *btv)
-{
-	if(!btv->fbuffer)
-		btv->fbuffer=(unsigned char *) rvmalloc(gbuffers*gbufsize);
-	else
-		printk(KERN_ERR "bttv%d: Double alloc of fbuffer!\n",
-			btv->nr);
-	if(!btv->fbuffer)
-		return -ENOBUFS;
+	btv->page = kmalloc (sizeof(btv->page) * btv->n_pages, GFP_KERNEL);
+	if (!btv->page) {
+		btv->n_pages = 0;
+		return -ENOMEM;
+	}
+	memset (btv->page, 0, sizeof(btv->page) * btv->n_pages);
+		
+	for (i = 0; i < btv->n_pages; i++) {
+		btv->page[i].cpuaddr = pci_alloc_consistent (
+			btv->dev, PAGE_SIZE, &btv->page[i].handle);
+		if (!btv->page[i].cpuaddr)
+			goto err_out;
+		memset(btv->page[i].cpuaddr, 0, PAGE_SIZE);
+	}
+	
 	return 0;
+
+err_out:
+	free_dmabuffers(btv);
+	return -ENOMEM;
 }
 
 
@@ -1265,13 +1236,13 @@
 static int vgrab(struct bttv *btv, struct video_mmap *mp)
 {
 	unsigned int *ro, *re;
-	unsigned int *vbuf;
+	unsigned int *vbuf, page, page_ofs;
 	unsigned long flags;
 	
-	if(btv->fbuffer==NULL)
+	if (btv->page == NULL)
 	{
-		if(fbuffer_alloc(btv))
-			return -ENOBUFS;
+		int rc = alloc_dmabuffers(btv);
+		if (rc) return rc;
 	}
 
 	if(mp->frame >= gbuffers || mp->frame < 0)
@@ -1294,7 +1265,9 @@
 	 *	Ok load up the BT848
 	 */
 	 
-	vbuf=(unsigned int *)(btv->fbuffer+gbufsize*mp->frame);
+	page = (gbufsize * mp->frame) >> PAGE_SHIFT;
+	page_ofs = (gbufsize * mp->frame) % PAGE_SIZE;
+	vbuf = (unsigned int *) (btv->page[page].cpuaddr + page_ofs);
 	ro=btv->gbuf[mp->frame].risc;
 	re=ro+2048;
         make_vrisctab(btv, ro, re, vbuf, mp->width, mp->height, mp->format);
@@ -1433,9 +1406,8 @@
 	if (btv->user)
 		goto out_unlock;
 	
-	btv->fbuffer=(unsigned char *) rvmalloc(gbuffers*gbufsize);
-	ret = -ENOMEM;
-	if (!btv->fbuffer)
+	ret = alloc_dmabuffers(btv);
+	if (ret)
 		goto out_unlock;
 
         btv->gq_in = 0;
@@ -1495,9 +1467,8 @@
 	 *	We have allowed it to drain.
 	 */
 
-	if(btv->fbuffer)
-		rvfree((void *) btv->fbuffer, gbuffers*gbufsize);
-	btv->fbuffer=0;
+	if (btv->page)
+		free_dmabuffers(btv);
 	up(&btv->lock);
 	MOD_DEC_USE_COUNT;  
 }
@@ -2166,45 +2137,81 @@
 	return 0;
 }
 
+static struct page * bttv_mm_nopage (struct vm_area_struct * vma,
+				     unsigned long address, int write_access)
+{
+	struct bttv *btv = vma->vm_private_data;
+	struct page *dmapage;
+	unsigned long pgoff;
+
+        if (address > vma->vm_end) return NOPAGE_SIGBUS; /* Disallow mremap */
+        if (!btv) return NOPAGE_OOM;	/* Nothing allocated */
+
+	pgoff = vma->vm_pgoff + ((address - vma->vm_start) >> PAGE_SHIFT);
+	if (pgoff > btv->n_pages) return NOPAGE_SIGBUS;
+
+	dmapage = virt_to_page (btv->page[pgoff].cpuaddr);
+	get_page (dmapage);
+	return dmapage;
+}
+
+#ifndef VM_RESERVE
+static int bttv_mm_swapout (struct page *page, struct file *filp)
+{
+	return 0;
+}
+#endif /* VM_RESERVE */
+
+struct vm_operations_struct bttv_mm_ops = {
+	nopage:		bttv_mm_nopage,
+#ifndef VM_RESERVE
+	swapout:	bttv_mm_swapout,
+#endif
+};
+
 /*
  *	This maps the vmalloced and reserved fbuffer to user space.
- *
- *  FIXME: 
- *  - PAGE_READONLY should suffice!?
- *  - remap_page_range is kind of inefficient for page by page remapping.
- *    But e.g. pte_alloc() does not work in modules ... :-(
  */
 
-static int do_bttv_mmap(struct bttv *btv, const char *adr, unsigned long size)
+static int do_bttv_mmap (struct file *file, struct vm_area_struct *vma,
+			 struct bttv *btv)
 {
-        unsigned long start=(unsigned long) adr;
-        unsigned long page,pos;
+	int rc = -EINVAL;
+	unsigned long max_size, size, start, offset;
 
-        if (size>gbuffers*gbufsize)
-                return -EINVAL;
-        if (!btv->fbuffer) {
-                if(fbuffer_alloc(btv))
-                        return -EINVAL;
-        }
-        pos=(unsigned long) btv->fbuffer;
-        while (size > 0) {
-                page = kvirt_to_pa(pos);
-                if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
-                        return -EAGAIN;
-                start+=PAGE_SIZE;
-                pos+=PAGE_SIZE;
-                size-=PAGE_SIZE;
-        }
-        return 0;
+	max_size = (gbuffers * gbufsize);
+
+	start = vma->vm_start;
+	offset = (vma->vm_pgoff << PAGE_SHIFT);
+	size = vma->vm_end - vma->vm_start;
+
+	/* some basic size/offset sanity checks */
+	if (size > max_size)
+		goto out;
+	if (offset > max_size - size)
+		goto out;
+
+	vma->vm_ops = &bttv_mm_ops;
+	vma->vm_private_data = btv;
+
+#ifdef VM_RESERVE
+	vma->vm_flags |= VM_RESERVE;
+#endif
+
+	rc = 0;
+
+out:
+	return rc;
 }
 
-static int bttv_mmap(struct video_device *dev, const char *adr, unsigned long size)
+static int bttv_mmap_vma(struct file *file, struct vm_area_struct *vma,
+			 struct video_device *dev)
 {
         struct bttv *btv=(struct bttv *)dev;
         int r;
 
         down(&btv->lock);
-        r=do_bttv_mmap(btv, adr, size);
+        r=do_bttv_mmap(file, vma, btv);
         up(&btv->lock);
         return r;
 }
@@ -2212,20 +2219,18 @@
 
 static struct video_device bttv_template=
 {
-	"UNSET",
-	VID_TYPE_TUNER|VID_TYPE_CAPTURE|VID_TYPE_OVERLAY|VID_TYPE_TELETEXT,
-	VID_HARDWARE_BT848,
-	bttv_open,
-	bttv_close,
-	bttv_read,
-	bttv_write,
-	NULL,
-	bttv_ioctl,
-	bttv_mmap,
-	bttv_init_done,
-	NULL,
-	0,
-	-1
+	name:		"UNSET",
+	type:		VID_TYPE_TUNER|VID_TYPE_CAPTURE|
+			VID_TYPE_OVERLAY|VID_TYPE_TELETEXT,
+	hardware:	VID_HARDWARE_BT848,
+	open:		bttv_open,
+	close:		bttv_close,
+	read:		bttv_read,
+	write:		bttv_write,
+	ioctl:		bttv_ioctl,
+	mmap_vma:	bttv_mmap_vma,
+	initialize:	bttv_init_done,
+	minor:		-1,
 };
 
 
@@ -2753,7 +2758,8 @@
 	memset(btv->vbibuf, 0, VBIBUF_SIZE); /* We don't want to return random
 	                                        memory to the user */
 
-	btv->fbuffer=NULL;
+	btv->page = NULL;
+	btv->n_pages = 0;
 
 	bt848_muxsel(btv, 1);
 	bt848_set_winsize(btv);
Index: drivers/media/video/bttv.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/media/video/bttv.h,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 bttv.h
--- drivers/media/video/bttv.h	2000/10/22 22:02:34	1.1.1.2
+++ drivers/media/video/bttv.h	2000/10/28 07:31:24
@@ -251,6 +251,13 @@
 	unsigned long re;
 };
 
+
+struct bttv_dma {
+	void *cpuaddr;
+	dma_addr_t handle;
+};
+
+
 struct bttv {
 	struct video_device video_dev;
 	struct video_device radio_dev;
@@ -312,7 +319,9 @@
 	struct bttv_gbuf *gbuf;
 	int gqueue[MAX_GBUFFERS];
 	int gq_in,gq_out,gq_grab,gq_start;
-        char *fbuffer;
+	
+	struct bttv_dma *page;
+	unsigned int n_pages;
 
 	struct bttv_pll_info pll;
 	unsigned int Fsc;
Index: drivers/media/video/videodev.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/media/video/videodev.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 videodev.c
--- drivers/media/video/videodev.c	2000/10/22 21:28:40	1.1.1.1
+++ drivers/media/video/videodev.c	2000/10/28 07:31:24
@@ -227,7 +227,9 @@
 {
 	int ret = -EINVAL;
 	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
-	if(vfl->mmap) {
+	if (vfl->mmap_vma)
+		return vfl->mmap_vma (file, vma, vfl);
+	if (vfl->mmap) {
 		lock_kernel();
 		ret = vfl->mmap(vfl, (char *)vma->vm_start, 
 				(unsigned long)(vma->vm_end-vma->vm_start));

--------------FEE170067228740FBD42B904--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
