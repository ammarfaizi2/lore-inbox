Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUAOLfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266587AbUAOLfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:35:40 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:46770 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266566AbUAOLfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:35:07 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 12:50:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-03 video-buf update
Message-ID: <20040115115031.GA16056@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch contains video-buf fixes, mainly remove videobuf_lock() and
videobuf_unlock() functions.  They are not needed as get_user_pages()
locks down the pages anyway.

  Gerd

diff -u linux-2.6.1/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.6.1/drivers/media/video/video-buf.c	2004-01-14 15:05:44.000000000 +0100
+++ linux/drivers/media/video/video-buf.c	2004-01-14 15:09:35.000000000 +0100
@@ -41,7 +41,7 @@
 MODULE_PARM(debug,"i");
 
 #define dprintk(level, fmt, arg...)	if (debug >= level) \
-	printk(KERN_DEBUG "vbuf: " fmt, ## arg)
+	printk(KERN_DEBUG "vbuf: " fmt , ## arg)
 
 struct scatterlist*
 videobuf_vmalloc_to_sg(unsigned char *virt, int nr_pages)
@@ -112,36 +112,6 @@
 	return NULL;
 }
 
-int videobuf_lock(struct page **pages, int nr_pages)
-{
-	int i;
-
-	dprintk(2,"lock start ...\n");
-	for (i = 0; i < nr_pages; i++)
-		if (TryLockPage(pages[i]))
-			goto err;
-	dprintk(2,"lock ok [%d pages]\n",nr_pages);
-	return 0;
-
- err:
-	dprintk(2,"lock failed, unlock ...\n");
-	while (i > 0)
-		unlock_page(pages[--i]);
-	dprintk(2,"lock quit\n");
-	return -EINVAL;
-}
-
-int videobuf_unlock(struct page **pages, int nr_pages)
-{
-	int i;
-
-	dprintk(2,"unlock start ...\n");
-	for (i = 0; i < nr_pages; i++)
-		unlock_page(pages[i]);
-	dprintk(2,"unlock ok [%d pages]\n",nr_pages);
-	return 0;
-}
-
 /* --------------------------------------------------------------------- */
 
 int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
@@ -213,20 +183,12 @@
 
 int videobuf_dma_pci_map(struct pci_dev *dev, struct videobuf_dmabuf *dma)
 {
-	int err;
-
 	if (0 == dma->nr_pages)
 		BUG();
 	
 	if (dma->pages) {
-		if (0 != (err = videobuf_lock(dma->pages, dma->nr_pages))) {
-			dprintk(1,"videobuf_lock: %d\n",err);
-			return err;
-		}
 		dma->sglist = videobuf_pages_to_sg(dma->pages, dma->nr_pages,
 						   dma->offset);
-		if (NULL == dma->sglist)
-			videobuf_unlock(dma->pages, dma->nr_pages);
 	}
 	if (dma->vmalloc) {
 		dma->sglist = videobuf_vmalloc_to_sg
@@ -236,8 +198,8 @@
 		dma->sglist = kmalloc(sizeof(struct scatterlist), GFP_KERNEL);
 		if (NULL != dma->sglist) {
 			dma->sglen  = 1;
-			sg_dma_address(&dma->sglist[0]) = dma->bus_addr & ~PAGE_MASK;
-			dma->sglist[0].offset           = dma->bus_addr & PAGE_MASK;
+			sg_dma_address(&dma->sglist[0]) = dma->bus_addr & PAGE_MASK;
+			dma->sglist[0].offset           = dma->bus_addr & ~PAGE_MASK;
 			sg_dma_len(&dma->sglist[0])     = dma->nr_pages * PAGE_SIZE;
 		}
 	}
@@ -272,8 +234,6 @@
 	kfree(dma->sglist);
 	dma->sglist = NULL;
 	dma->sglen = 0;
-	if (dma->pages)
-		videobuf_unlock(dma->pages, dma->nr_pages);
 	return 0;
 }
 
@@ -325,8 +285,8 @@
 			retval = -EAGAIN;
 			break;
 		}
-		set_current_state(intr ? TASK_INTERRUPTIBLE :
-					TASK_UNINTERRUPTIBLE);
+		set_current_state(intr  ? TASK_INTERRUPTIBLE
+					: TASK_UNINTERRUPTIBLE);
 		if (vb->state == STATE_ACTIVE || vb->state == STATE_QUEUED)
 			schedule();
 		set_current_state(TASK_RUNNING);
@@ -969,8 +929,10 @@
 			retval      += bytes;
 			q->read_off += bytes;
 		} else {
-			/* some error -- skip buffer */
+			/* some error */
 			q->read_off = q->read_buf->size;
+			if (0 == retval)
+				retval = -EIO;
 		}
 
 		/* requeue buffer when done with copying */
@@ -982,6 +944,8 @@
 			spin_unlock_irqrestore(q->irqlock,flags);
 			q->read_buf = NULL;
 		}
+		if (retval < 0)
+			break;
 	}
 
  done:
@@ -1078,7 +1042,7 @@
  */
 static struct page*
 videobuf_vm_nopage(struct vm_area_struct *vma, unsigned long vaddr,
-		  int *type)
+		   int *type)
 {
 	struct page *page;
 
@@ -1232,8 +1196,6 @@
 /* --------------------------------------------------------------------- */
 
 EXPORT_SYMBOL_GPL(videobuf_vmalloc_to_sg);
-EXPORT_SYMBOL_GPL(videobuf_lock);
-EXPORT_SYMBOL_GPL(videobuf_unlock);
 
 EXPORT_SYMBOL_GPL(videobuf_dma_init_user);
 EXPORT_SYMBOL_GPL(videobuf_dma_init_kernel);

-- 
You have a new virus in /var/mail/kraxel
