Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTJGKo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 06:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJGKo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 06:44:26 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:40082 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262126AbTJGKoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 06:44:11 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Oct 2003 12:52:33 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Michael Hunold <hunold@convergence.de>
Subject: [patch] v4l: videobuf update
Message-ID: <20031007105233.GA3205@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the videobuf module used by the bttv, saa7134 and
saa7146 drivers.  Related updates for the three drivers will follow.

Changes:
  * adds support for overlays (i.e. PCI-PCI DMA transfers).
  * adds support for userspace DMA.
  * fixes bug in the read() helper function (catch I/O errors). 

Please apply,

  Gerd

diff -u linux-2.6.0-test6/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.6.0-test6/drivers/media/video/video-buf.c	2003-10-06 17:45:22.000000000 +0200
+++ linux/drivers/media/video/video-buf.c	2003-10-06 17:48:02.000000000 +0200
@@ -197,6 +197,20 @@
 	return 0;
 }
 
+int videobuf_dma_init_overlay(struct videobuf_dmabuf *dma, int direction,
+			      dma_addr_t addr, int nr_pages)
+{
+	dprintk(1,"init overlay [%d pages @ bus 0x%lx]\n",
+		nr_pages,(unsigned long)addr);
+	dma->direction = direction;
+	if (0 == addr)
+		return -EINVAL;
+
+	dma->bus_addr = addr;
+	dma->nr_pages = nr_pages;
+	return 0;
+}
+
 int videobuf_dma_pci_map(struct pci_dev *dev, struct videobuf_dmabuf *dma)
 {
 	int err;
@@ -218,12 +232,23 @@
 		dma->sglist = videobuf_vmalloc_to_sg
 			(dma->vmalloc,dma->nr_pages);
 	}
+	if (dma->bus_addr) {
+		dma->sglist = kmalloc(sizeof(struct scatterlist), GFP_KERNEL);
+		if (NULL != dma->sglist) {
+			dma->sglen  = 1;
+			sg_dma_address(&dma->sglist[0]) = dma->bus_addr & ~PAGE_MASK;
+			dma->sglist[0].offset           = dma->bus_addr & PAGE_MASK;
+			sg_dma_len(&dma->sglist[0])     = dma->nr_pages * PAGE_SIZE;
+		}
+	}
 	if (NULL == dma->sglist) {
 		dprintk(1,"scatterlist is NULL\n");
 		return -ENOMEM;
 	}
-	dma->sglen = pci_map_sg(dev,dma->sglist,dma->nr_pages,
-				dma->direction);
+
+	if (!dma->bus_addr)
+		dma->sglen = pci_map_sg(dev,dma->sglist,dma->nr_pages,
+					dma->direction);
 	return 0;
 }
 
@@ -232,7 +257,8 @@
 	if (!dma->sglen)
 		BUG();
 
-	pci_dma_sync_sg(dev,dma->sglist,dma->nr_pages,dma->direction);
+	if (!dma->bus_addr)
+		pci_dma_sync_sg(dev,dma->sglist,dma->nr_pages,dma->direction);
 	return 0;
 }
 
@@ -241,7 +267,8 @@
 	if (!dma->sglen)
 		return 0;
 
-	pci_unmap_sg(dev,dma->sglist,dma->nr_pages,dma->direction);
+	if (!dma->bus_addr)
+		pci_unmap_sg(dev,dma->sglist,dma->nr_pages,dma->direction);
 	kfree(dma->sglist);
 	dma->sglist = NULL;
 	dma->sglen = 0;
@@ -266,6 +293,9 @@
 		vfree(dma->vmalloc);
 		dma->vmalloc = NULL;
 	}
+	if (dma->bus_addr) {
+		dma->bus_addr = 0;
+	}
 	dma->direction = PCI_DMA_NONE;
 	return 0;
 }
@@ -309,27 +339,48 @@
 }
 
 int
-videobuf_iolock(struct pci_dev *pci, struct videobuf_buffer *vb)
+videobuf_iolock(struct pci_dev *pci, struct videobuf_buffer *vb,
+		struct v4l2_framebuffer *fbuf)
 {
 	int err,pages;
+	dma_addr_t bus;
 
-	if (0 == vb->baddr) {
-		/* no userspace addr -- kernel bounce buffer */
+	switch (vb->memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_USERPTR:
+		if (0 == vb->baddr) {
+			/* no userspace addr -- kernel bounce buffer */
+			pages = PAGE_ALIGN(vb->size) >> PAGE_SHIFT;
+			err = videobuf_dma_init_kernel(&vb->dma,PCI_DMA_FROMDEVICE,
+						       pages);
+			if (0 != err)
+				return err;
+		} else {
+			/* dma directly to userspace */
+			err = videobuf_dma_init_user(&vb->dma,PCI_DMA_FROMDEVICE,
+						     vb->baddr,vb->bsize);
+			if (0 != err)
+				return err;
+		}
+		break;
+	case V4L2_MEMORY_OVERLAY:
+		if (NULL == fbuf)
+			return -EINVAL;
+		/* FIXME: need sanity checks for vb->boff */
+		bus   = (dma_addr_t)fbuf->base + vb->boff;
 		pages = PAGE_ALIGN(vb->size) >> PAGE_SHIFT;
-		err = videobuf_dma_init_kernel(&vb->dma,PCI_DMA_FROMDEVICE,
-					       pages);
-		if (0 != err)
-			return err;
-	} else {
-		/* dma directly to userspace */
-		err = videobuf_dma_init_user(&vb->dma,PCI_DMA_FROMDEVICE,
-					     vb->baddr,vb->bsize);
+		err = videobuf_dma_init_overlay(&vb->dma,PCI_DMA_FROMDEVICE,
+						bus, pages);
 		if (0 != err)
 			return err;
+		break;
+	default:
+		BUG();
 	}
 	err = videobuf_dma_pci_map(pci,&vb->dma);
 	if (0 != err)
 		return err;
+		
 	return 0;
 }
 
@@ -447,11 +498,26 @@
 {
 	b->index    = vb->i;
 	b->type     = type;
-	b->m.offset = vb->boff;
-	b->length   = vb->bsize;
+
+	b->memory   = vb->memory;
+	switch (b->memory) {
+	case V4L2_MEMORY_MMAP:
+		b->m.offset  = vb->boff;
+		b->length    = vb->bsize;
+		break;
+	case V4L2_MEMORY_USERPTR:
+		b->m.userptr = vb->baddr;
+		b->length    = vb->bsize;
+		break;
+	case V4L2_MEMORY_OVERLAY:
+		b->m.offset  = vb->boff;
+		break;
+	}
+
 	b->flags    = 0;
 	if (vb->map)
 		b->flags |= V4L2_BUF_FLAG_MAPPED;
+
 	switch (vb->state) {
 	case STATE_PREPARED:
 	case STATE_QUEUED:
@@ -467,6 +533,7 @@
 		/* nothing */
 		break;
 	}
+
 	b->field     = vb->field;
 	b->timestamp = vb->ts;
 	b->bytesused = vb->size;
@@ -484,6 +551,10 @@
 		return -EINVAL;
 	if (req->count < 1)
 		return -EINVAL;
+	if (req->memory != V4L2_MEMORY_MMAP     &&
+	    req->memory != V4L2_MEMORY_USERPTR  &&
+	    req->memory != V4L2_MEMORY_OVERLAY)
+		return -EINVAL;
 
 	down(&q->lock);
 	count = req->count;
@@ -495,10 +566,10 @@
 	dprintk(1,"reqbufs: bufs=%d, size=0x%x [%d pages total]\n",
 		count, size, (count*size)>>PAGE_SHIFT);
 
-	retval = videobuf_mmap_setup(file,q,count,size);
+	retval = videobuf_mmap_setup(file,q,count,size,req->memory);
 	if (retval < 0)
 		goto done;
-	req->type  = q->type;
+
 	req->count = count;
 
  done:
@@ -540,12 +611,29 @@
 	buf = q->bufs[b->index];
 	if (NULL == buf)
 		goto done;
-	if (0 == buf->baddr)
+	if (buf->memory != b->memory)
 		goto done;
 	if (buf->state == STATE_QUEUED ||
 	    buf->state == STATE_ACTIVE)
 		goto done;
 
+	switch (b->memory) {
+	case V4L2_MEMORY_MMAP:
+		if (0 == buf->baddr)
+			goto done;
+		break;
+	case V4L2_MEMORY_USERPTR:
+		if (b->length < buf->bsize)
+			goto done;
+		buf->baddr = b->m.userptr;
+		break;
+	case V4L2_MEMORY_OVERLAY:
+		buf->boff = b->m.offset;
+		break;
+	default:
+		goto done;
+	}
+
 	field = videobuf_next_field(q);
 	retval = q->ops->buf_prepare(file,buf,field);
 	if (0 != retval)
@@ -663,8 +751,9 @@
 	if (NULL == q->read_buf)
 		goto done;
 
-	q->read_buf->baddr = (unsigned long)data;
-        q->read_buf->bsize = count;
+	q->read_buf->memory = V4L2_MEMORY_USERPTR;
+	q->read_buf->baddr  = (unsigned long)data;
+        q->read_buf->bsize  = count;
 	field = videobuf_next_field(q);
 	retval = q->ops->buf_prepare(file,q->read_buf,field);
 	if (0 != retval)
@@ -719,6 +808,7 @@
 		q->read_buf = videobuf_alloc(q->msize);
 		if (NULL == q->read_buf)
 			goto done;
+		q->read_buf->memory = V4L2_MEMORY_USERPTR;
 		field = videobuf_next_field(q);
 		retval = q->ops->buf_prepare(file,q->read_buf,field);
 		if (0 != retval)
@@ -780,7 +870,7 @@
 		count = VIDEO_MAX_FRAME;
 	size = PAGE_ALIGN(size);
 
-	err = videobuf_mmap_setup(file, q, count, size);
+	err = videobuf_mmap_setup(file, q, count, size, V4L2_MEMORY_USERPTR);
 	if (err)
 		return err;
 	for (i = 0; i < count; i++) {
@@ -850,31 +940,36 @@
 			break;
 		}
 
-		if (vbihack) {
-			/* dirty, undocumented hack -- pass the frame counter
-			 * within the last four bytes of each vbi data block.
-			 * We need that one to maintain backward compatibility
-			 * to all vbi decoding software out there ... */
-			fc  = (unsigned int*)q->read_buf->dma.vmalloc;
-			fc += (q->read_buf->size>>2) -1;
-			*fc = q->read_buf->field_count >> 1;
-			dprintk(1,"vbihack: %d\n",*fc);
-		}
-
-		/* copy stuff */
-		bytes = count;
-		if (bytes > q->read_buf->size - q->read_off)
-			bytes = q->read_buf->size - q->read_off;
-		if (copy_to_user(data + retval,
-				 q->read_buf->dma.vmalloc + q->read_off,
-				 bytes)) {
-			if (0 == retval)
-				retval = -EFAULT;
-			break;
+		if (q->read_buf->state == STATE_DONE) {
+			if (vbihack) {
+				/* dirty, undocumented hack -- pass the frame counter
+				 * within the last four bytes of each vbi data block.
+				 * We need that one to maintain backward compatibility
+				 * to all vbi decoding software out there ... */
+				fc  = (unsigned int*)q->read_buf->dma.vmalloc;
+				fc += (q->read_buf->size>>2) -1;
+				*fc = q->read_buf->field_count >> 1;
+				dprintk(1,"vbihack: %d\n",*fc);
+			}
+			
+			/* copy stuff */
+			bytes = count;
+			if (bytes > q->read_buf->size - q->read_off)
+				bytes = q->read_buf->size - q->read_off;
+			if (copy_to_user(data + retval,
+					 q->read_buf->dma.vmalloc + q->read_off,
+					 bytes)) {
+				if (0 == retval)
+					retval = -EFAULT;
+				break;
+			}
+			count       -= bytes;
+			retval      += bytes;
+			q->read_off += bytes;
+		} else {
+			/* some error -- skip buffer */
+			q->read_off = q->read_buf->size;
 		}
-		count       -= bytes;
-		retval      += bytes;
-		q->read_off += bytes;
 
 		/* requeue buffer when done with copying */
 		if (q->read_off == q->read_buf->size) {
@@ -1004,7 +1099,8 @@
 };
 
 int videobuf_mmap_setup(struct file *file, struct videobuf_queue *q,
-			unsigned int bcount, unsigned int bsize)
+			unsigned int bcount, unsigned int bsize,
+			enum v4l2_memory memory)
 {
 	unsigned int i;
 	int err;
@@ -1012,12 +1108,21 @@
 	err = videobuf_mmap_free(file,q);
 	if (0 != err)
 		return err;
-	
+
 	for (i = 0; i < bcount; i++) {
 		q->bufs[i] = videobuf_alloc(q->msize);
-		q->bufs[i]->i     = i;
-		q->bufs[i]->boff  = bsize * i;
-		q->bufs[i]->bsize = bsize;
+		q->bufs[i]->i      = i;
+		q->bufs[i]->memory = memory;
+		q->bufs[i]->bsize  = bsize;
+		switch (memory) {
+		case V4L2_MEMORY_MMAP:
+			q->bufs[i]->boff  = bsize * i;
+			break;
+		case V4L2_MEMORY_USERPTR:
+		case V4L2_MEMORY_OVERLAY:
+			/* nothing */
+			break;
+		};
 	}
 	dprintk(1,"mmap setup: %d buffers, %d bytes each\n",
 		bcount,bsize);
@@ -1063,6 +1168,8 @@
 	for (first = 0; first < VIDEO_MAX_FRAME; first++) {
 		if (NULL == q->bufs[first])
 			continue;
+		if (V4L2_MEMORY_MMAP != q->bufs[first]->memory)
+			continue;
 		if (q->bufs[first]->boff == (vma->vm_pgoff << PAGE_SHIFT))
 			break;
 	}
@@ -1076,6 +1183,8 @@
 	for (size = 0, last = first; last < VIDEO_MAX_FRAME; last++) {
 		if (NULL == q->bufs[last])
 			continue;
+		if (V4L2_MEMORY_MMAP != q->bufs[last]->memory)
+			continue;
 		if (q->bufs[last]->map) {
 			retval = -EBUSY;
 			goto done;
@@ -1124,6 +1233,7 @@
 
 EXPORT_SYMBOL_GPL(videobuf_dma_init_user);
 EXPORT_SYMBOL_GPL(videobuf_dma_init_kernel);
+EXPORT_SYMBOL_GPL(videobuf_dma_init_overlay);
 EXPORT_SYMBOL_GPL(videobuf_dma_pci_map);
 EXPORT_SYMBOL_GPL(videobuf_dma_pci_sync);
 EXPORT_SYMBOL_GPL(videobuf_dma_pci_unmap);
diff -u linux-2.6.0-test6/include/media/video-buf.h linux/include/media/video-buf.h
--- linux-2.6.0-test6/include/media/video-buf.h	2003-10-06 17:45:24.000000000 +0200
+++ linux/include/media/video-buf.h	2003-10-06 17:48:02.000000000 +0200
@@ -43,17 +43,17 @@
  * A small set of helper functions to manage buffers (both userland
  * and kernel) for DMA.
  *
- * videobuf_init_*_dmabuf()
+ * videobuf_dma_init_*()
  *	creates a buffer.  The userland version takes a userspace
  *	pointer + length.  The kernel version just wants the size and
  *	does memory allocation too using vmalloc_32().
  *
- * videobuf_pci_*_dmabuf()
+ * videobuf_dma_pci_*()
  *	see Documentation/DMA-mapping.txt, these functions to
  *	basically the same.  The map function does also build a
  *	scatterlist for the buffer (and unmap frees it ...)
  *
- * videobuf_free_dmabuf()
+ * videobuf_dma_free()
  *	no comment ...
  *
  */
@@ -66,6 +66,9 @@
 	/* for kernel buffers */
 	void                *vmalloc;
 
+	/* for overlay buffers (pci-pci dma) */
+	dma_addr_t          bus_addr;
+
 	/* common */
 	struct scatterlist  *sglist;
 	int                 sglen;
@@ -77,6 +80,8 @@
 			   unsigned long data, unsigned long size);
 int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
 			     int nr_pages);
+int videobuf_dma_init_overlay(struct videobuf_dmabuf *dma, int direction,
+			      dma_addr_t addr, int nr_pages);
 int videobuf_dma_pci_map(struct pci_dev *dev, struct videobuf_dmabuf *dma);
 int videobuf_dma_pci_sync(struct pci_dev *dev,
 			  struct videobuf_dmabuf *dma);
@@ -133,6 +138,7 @@
 	/* info about the buffer */
 	unsigned int            width;
 	unsigned int            height;
+	unsigned int            bytesperline; /* use only if != 0 */
 	unsigned long           size;
 	enum v4l2_field         field;
 	enum videobuf_state     state;
@@ -140,7 +146,8 @@
 	struct list_head        stream;  /* QBUF/DQBUF list */
 
 	/* for mmap'ed buffers */
-	size_t                  boff;    /* buffer offset (mmap) */
+	enum v4l2_memory        memory;
+	size_t                  boff;    /* buffer offset (mmap + overlay) */
 	size_t                  bsize;   /* buffer size */
 	unsigned long           baddr;   /* buffer addr (userland ptr!) */
 	struct videobuf_mapping *map;
@@ -185,7 +192,8 @@
 
 void* videobuf_alloc(unsigned int size);
 int videobuf_waiton(struct videobuf_buffer *vb, int non_blocking, int intr);
-int videobuf_iolock(struct pci_dev *pci, struct videobuf_buffer *vb);
+int videobuf_iolock(struct pci_dev *pci, struct videobuf_buffer *vb,
+		    struct v4l2_framebuffer *fbuf);
 
 void videobuf_queue_init(struct videobuf_queue *q,
 			 struct videobuf_queue_ops *ops,
@@ -221,7 +229,8 @@
 				  poll_table *wait);
 
 int videobuf_mmap_setup(struct file *file, struct videobuf_queue *q,
-			unsigned int bcount, unsigned int bsize);
+			unsigned int bcount, unsigned int bsize,
+			enum v4l2_memory memory);
 int videobuf_mmap_free(struct file *file, struct videobuf_queue *q);
 int videobuf_mmap_mapper(struct vm_area_struct *vma,
 			 struct videobuf_queue *q);

-- 
You have a new virus in /var/mail/kraxel
