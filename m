Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSJaPYC>; Thu, 31 Oct 2002 10:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJaPYC>; Thu, 31 Oct 2002 10:24:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:8868 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262457AbSJaPXz>; Thu, 31 Oct 2002 10:23:55 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 31 Oct 2002 17:12:34 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] videobuf update
Message-ID: <20021031161234.GA17340@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

This patch updates the for the video-buf.c module (helper module for
video buffer management).  Some memory management fixes, also some
adaptions to the final v4l2 api.

  Gerd

--- linux-2.5.45/drivers/media/video/video-buf.c	2002-10-31 14:03:59.000000000 +0100
+++ linux/drivers/media/video/video-buf.c	2002-10-31 14:20:27.000000000 +0100
@@ -26,6 +26,11 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
+#ifndef TryLockPage
+# include "linux/page-flags.h"
+# define TryLockPage TestSetPageLocked
+#endif
+
 #include "video-buf.h"
 
 static int debug = 0;
@@ -65,12 +70,12 @@
 	return NULL;
 }
 
-struct scatterlist *
+struct scatterlist*
 videobuf_pages_to_sg(struct page **pages, int nr_pages, int offset)
 {
 	struct scatterlist *sglist;
 	int i = 0;
-	
+
 	if (NULL == pages[0])
 		return NULL;
 	sglist = kmalloc(sizeof(*sglist) * nr_pages, GFP_KERNEL);
@@ -80,21 +85,27 @@
 
 	if (PageHighMem(pages[0]))
 		/* DMA to highmem pages might not work */
-		goto err;
+		goto highmem;
 	sglist[0].page   = pages[0];
 	sglist[0].offset = offset;
 	sglist[0].length = PAGE_SIZE - offset;
 	for (i = 1; i < nr_pages; i++) {
 		if (NULL == pages[i])
-			goto err;
+			goto nopage;
 		if (PageHighMem(pages[i]))
-			goto err;
+			goto highmem;
 		sglist[i].page   = pages[i];
 		sglist[i].length = PAGE_SIZE;
 	}
 	return sglist;
 
- err:
+ nopage:
+	dprintk(2,"sgl: oops - no page\n");
+	kfree(sglist);
+	return NULL;
+
+ highmem:
+	dprintk(2,"sgl: oops - highmem page\n");
 	kfree(sglist);
 	return NULL;
 }
@@ -103,14 +114,18 @@
 {
 	int i;
 
+	dprintk(2,"lock start ...\n");
 	for (i = 0; i < nr_pages; i++)
-		if (TestSetPageLocked(pages[i]))
+		if (TryLockPage(pages[i]))
 			goto err;
+	dprintk(2,"lock ok\n");
 	return 0;
 
  err:
+	dprintk(2,"lock failed, unlock ...\n");
 	while (i > 0)
 		unlock_page(pages[--i]);
+	dprintk(2,"lock quit\n");
 	return -EINVAL;
 }
 
@@ -118,8 +133,10 @@
 {
 	int i;
 
+	dprintk(2,"unlock start ...\n");
 	for (i = 0; i < nr_pages; i++)
 		unlock_page(pages[i]);
+	dprintk(2,"unlock ok\n");
 	return 0;
 }
 
@@ -128,6 +145,7 @@
 int videobuf_dma_init_user(struct videobuf_dmabuf *dma, int direction,
 			   unsigned long data, unsigned long size)
 {
+	unsigned long first,last;
 	int err, rw = 0;
 
 	dma->direction = direction;
@@ -137,25 +155,35 @@
 	default:                 BUG();
 	}
 
-	dma->offset   = data & PAGE_MASK;
-	dma->nr_pages = ((((data+size) & ~PAGE_MASK) -
-			  (data & ~PAGE_MASK)) >> PAGE_SHIFT) +1;
-	dma->pages    = kmalloc(dma->nr_pages * sizeof(struct page*),
-				GFP_KERNEL);
+	first = (data          & PAGE_MASK) >> PAGE_SHIFT;
+	last  = ((data+size-1) & PAGE_MASK) >> PAGE_SHIFT;
+	dma->offset   = data & ~PAGE_MASK;
+	dma->nr_pages = last-first+1;
+	dma->pages = kmalloc(dma->nr_pages * sizeof(struct page*),
+			     GFP_KERNEL);
 	if (NULL == dma->pages)
 		return -ENOMEM;
+	dprintk(1,"init user [0x%lx+0x%lx => %d pages]\n",
+		data,size,dma->nr_pages);
+
 	down_read(&current->mm->mmap_sem);
         err = get_user_pages(current,current->mm,
-			     data, dma->nr_pages,
-			     rw == READ, 0, /* don't force */
+			     data & PAGE_MASK, dma->nr_pages,
+			     rw == READ, 1, /* force */
 			     dma->pages, NULL);
 	up_read(&current->mm->mmap_sem);
-	return err;
+	if (err != dma->nr_pages) {
+		dma->nr_pages = (err >= 0) ? err : 0;
+		dprintk(1,"get_user_pages: err=%d [%d]\n",err,dma->nr_pages);
+		return err < 0 ? err : -EINVAL;
+	}
+	return 0;
 }
 
 int videobuf_dma_init_kernel(struct videobuf_dmabuf *dma, int direction,
 			     int nr_pages)
 {
+	dprintk(1,"init kernel [%d pages]\n",nr_pages);
 	dma->direction = direction;
 	dma->vmalloc = vmalloc_32(nr_pages << PAGE_SHIFT);
 	if (NULL == dma->vmalloc) {
@@ -176,13 +204,14 @@
 	
 	if (dma->pages) {
 		if (0 != (err = videobuf_lock(dma->pages, dma->nr_pages))) {
-			dprintk(1,"videobuf_lock_pages: %d\n",err);
+			dprintk(1,"videobuf_lock: %d\n",err);
 			return err;
 		}
 		dma->sglist = videobuf_pages_to_sg(dma->pages, dma->nr_pages,
 						   dma->offset);
+		if (NULL == dma->sglist)
+			videobuf_unlock(dma->pages, dma->nr_pages);
 	}
-
 	if (dma->vmalloc) {
 		dma->sglist = videobuf_vmalloc_to_sg
 			(dma->vmalloc,dma->nr_pages);
@@ -215,7 +244,7 @@
 	dma->sglist = NULL;
 	dma->sglen = 0;
 	if (dma->pages)
-		videobuf_lock(dma->pages, dma->nr_pages);
+		videobuf_unlock(dma->pages, dma->nr_pages);
 	return 0;
 }
 
@@ -231,7 +260,6 @@
 		kfree(dma->pages);
 		dma->pages = NULL;
 	}
-
 	if (dma->vmalloc) {
 		vfree(dma->vmalloc);
 		dma->vmalloc = NULL;
@@ -286,16 +314,12 @@
 	if (0 == vb->baddr) {
 		/* no userspace addr -- kernel bounce buffer */
 		pages = PAGE_ALIGN(vb->size) >> PAGE_SHIFT;
-		dprintk(1,"kernel buf size=%ld (%d pages)\n",
-			vb->size,pages);
 		err = videobuf_dma_init_kernel(&vb->dma,PCI_DMA_FROMDEVICE,
 					       pages);
 		if (0 != err)
 			return err;
 	} else {
 		/* dma directly to userspace */
-		dprintk(1,"user buf addr=%08lx size=%ld\n",
-			vb->baddr,vb->bsize);
 		err = videobuf_dma_init_user(&vb->dma,PCI_DMA_FROMDEVICE,
 					     vb->baddr,vb->bsize);
 		if (0 != err)
@@ -314,7 +338,7 @@
 		    struct videobuf_queue_ops *ops,
 		    struct pci_dev *pci,
 		    spinlock_t *irqlock,
-		    int type,
+		    enum v4l2_buf_type type,
 		    int msize)
 {
 	memset(q,0,sizeof(*q));
@@ -329,6 +353,30 @@
 	INIT_LIST_HEAD(&q->stream);
 }
 
+int 
+videobuf_queue_is_busy(struct videobuf_queue *q)
+{
+	int i;
+	
+	if (q->reading)
+		return 1;
+	if (q->streaming)
+		return 1;
+	if (q->read_buf)
+		return 1;
+	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
+		if (NULL == q->bufs[i])
+			continue;
+		if (q->bufs[i]->map)
+			return 1;
+		if (q->bufs[i]->state == STATE_QUEUED)
+			return 1;
+		if (q->bufs[i]->state == STATE_ACTIVE)
+			return 1;
+	}
+	return 0;
+}
+
 void
 videobuf_queue_cancel(struct file *file, struct videobuf_queue *q)
 {
@@ -358,15 +406,15 @@
 
 /* --------------------------------------------------------------------- */
 
-#ifdef HAVE_V4L2
 void
-videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb, int type)
+videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
+		enum v4l2_buf_type type)
 {
-	b->index  = vb->i;
-	b->type   = type;
-	b->offset = vb->boff;
-	b->length = vb->bsize;
-	b->flags  = 0;
+	b->index    = vb->i;
+	b->type     = type;
+	b->m.offset = vb->boff;
+	b->length   = vb->bsize;
+	b->flags    = 0;
 	if (vb->map)
 		b->flags |= V4L2_BUF_FLAG_MAPPED;
 	switch (vb->state) {
@@ -384,12 +432,7 @@
 		/* nothing */
 		break;
 	}
-	if (!(vb->field & VBUF_FIELD_INTER)) {
-		if (vb->field & VBUF_FIELD_ODD)
-			b->flags |= V4L2_BUF_FLAG_TOPFIELD;
-		if (vb->field & VBUF_FIELD_EVEN)
-			b->flags |= V4L2_BUF_FLAG_BOTFIELD;
-	}
+	b->field     = vb->field;
 	b->timestamp = vb->ts;
 	b->bytesused = vb->size;
 	b->sequence  = vb->field_count >> 1;
@@ -401,7 +444,7 @@
 {
 	int size,count,retval;
 
-	if ((req->type & V4L2_BUF_TYPE_field) != q->type)
+	if (req->type != q->type)
 		return -EINVAL;
 	if (req->count < 1)
 		return -EINVAL;
@@ -428,11 +471,11 @@
 int
 videobuf_querybuf(struct videobuf_queue *q, struct v4l2_buffer *b)
 {
-	if ((b->type & V4L2_BUF_TYPE_field) != q->type)
+	if (unlikely(b->type != q->type))
 		return -EINVAL;
-	if (b->index < 0 || b->index >= VIDEO_MAX_FRAME)
+	if (unlikely(b->index < 0 || b->index >= VIDEO_MAX_FRAME))
 		return -EINVAL;
-	if (NULL == q->bufs[b->index])
+	if (unlikely(NULL == q->bufs[b->index]))
 		return -EINVAL;
 	videobuf_status(b,q->bufs[b->index],q->type);
 	return 0;
@@ -444,7 +487,6 @@
 {
 	struct videobuf_buffer *buf;
 	unsigned long flags;
-	int field = 0;
 	int retval;
 
 	down(&q->lock);
@@ -452,7 +494,7 @@
 	if (q->reading)
 		goto done;
 	retval = -EINVAL;
-	if ((b->type & V4L2_BUF_TYPE_field) != q->type)
+	if (b->type != q->type)
 		goto done;
 	if (b->index < 0 || b->index >= VIDEO_MAX_FRAME)
 		goto done;
@@ -465,11 +507,7 @@
 	    buf->state == STATE_ACTIVE)
 		goto done;
 
-	if (b->flags & V4L2_BUF_FLAG_TOPFIELD)
-		field |= VBUF_FIELD_ODD;
-	if (b->flags & V4L2_BUF_FLAG_BOTFIELD)
-		field |= VBUF_FIELD_EVEN;
-	retval = q->ops->buf_prepare(file,buf,field);
+	retval = q->ops->buf_prepare(file,buf);
 	if (0 != retval)
 		goto done;
 	
@@ -498,7 +536,7 @@
 	if (q->reading)
 		goto done;
 	retval = -EINVAL;
-	if ((b->type & V4L2_BUF_TYPE_field) != q->type)
+	if (b->type != q->type)
 		goto done;
 	if (list_empty(&q->stream))
 		goto done;
@@ -526,7 +564,6 @@
 	up(&q->lock);
 	return retval;
 }
-#endif /* HAVE_V4L2 */
 
 int videobuf_streamon(struct file *file, struct videobuf_queue *q)
 {
@@ -586,7 +623,7 @@
 
 	q->read_buf->baddr = (unsigned long)data;
         q->read_buf->bsize = count;
-	retval = q->ops->buf_prepare(file,q->read_buf,0);
+	retval = q->ops->buf_prepare(file,q->read_buf);
 	if (0 != retval)
 		goto done;
 	
@@ -631,7 +668,7 @@
 		q->read_buf = videobuf_alloc(q->msize);
 		if (NULL == q->read_buf)
 			goto done;
-		retval = q->ops->buf_prepare(file,q->read_buf,0);
+		retval = q->ops->buf_prepare(file,q->read_buf);
 		if (0 != retval)
 			goto done;
 		q->ops->buf_queue(file,q->read_buf);
@@ -683,7 +720,7 @@
 	if (err)
 		return err;
 	for (i = 0; i < count; i++) {
-		err = q->ops->buf_prepare(file,q->bufs[i],0);
+		err = q->ops->buf_prepare(file,q->bufs[i]);
 		if (err)
 			return err;
 		list_add_tail(&q->bufs[i]->stream, &q->stream);
@@ -1008,6 +1045,8 @@
 /* --------------------------------------------------------------------- */
 
 EXPORT_SYMBOL_GPL(videobuf_vmalloc_to_sg);
+EXPORT_SYMBOL_GPL(videobuf_lock);
+EXPORT_SYMBOL_GPL(videobuf_unlock);
 
 EXPORT_SYMBOL_GPL(videobuf_dma_init_user);
 EXPORT_SYMBOL_GPL(videobuf_dma_init_kernel);
@@ -1022,14 +1061,13 @@
 
 EXPORT_SYMBOL_GPL(videobuf_queue_init);
 EXPORT_SYMBOL_GPL(videobuf_queue_cancel);
+EXPORT_SYMBOL_GPL(videobuf_queue_is_busy);
 
-#ifdef HAVE_V4L2
 EXPORT_SYMBOL_GPL(videobuf_status);
 EXPORT_SYMBOL_GPL(videobuf_reqbufs);
 EXPORT_SYMBOL_GPL(videobuf_querybuf);
 EXPORT_SYMBOL_GPL(videobuf_qbuf);
 EXPORT_SYMBOL_GPL(videobuf_dqbuf);
-#endif
 EXPORT_SYMBOL_GPL(videobuf_streamon);
 EXPORT_SYMBOL_GPL(videobuf_streamoff);
 
--- linux-2.5.45/drivers/media/video/video-buf.h	2002-10-31 14:04:05.000000000 +0100
+++ linux/drivers/media/video/video-buf.h	2002-10-31 14:20:27.000000000 +0100
@@ -28,12 +28,14 @@
 struct scatterlist* videobuf_vmalloc_to_sg(unsigned char *virt, int nr_pages);
 
 /*
- * Return a scatterlist for a an array of userpages (NULL on errors).  Memory
- * for the scatterlist is allocated using kmalloc.  The caller must
- * free the memory.
+ * Return a scatterlist for a an array of userpages (NULL on errors).
+ * Memory for the scatterlist is allocated using kmalloc.  The caller
+ * must free the memory.
  */
-struct scatterlist *videobuf_pages_to_sg(struct page **pages, int nr_pages,
+struct scatterlist* videobuf_pages_to_sg(struct page **pages, int nr_pages,
 					 int offset);
+int videobuf_lock(struct page **pages, int nr_pages);
+int videobuf_unlock(struct page **pages, int nr_pages);
 
 /* --------------------------------------------------------------------- */
 
@@ -58,8 +60,8 @@
 
 struct videobuf_dmabuf {
 	/* for userland buffer */
-	struct page         **pages;
 	int                 offset;
+	struct page         **pages;
 
 	/* for kernel buffers */
 	void                *vmalloc;
@@ -115,10 +117,6 @@
 	struct videobuf_queue *q;
 };
 
-#define VBUF_FIELD_EVEN  1
-#define VBUF_FIELD_ODD   2
-#define VBUF_FIELD_INTER 4
-
 enum videobuf_state {
 	STATE_NEEDS_INIT = 0,
 	STATE_PREPARED   = 1,
@@ -136,30 +134,27 @@
 	int                     width;
 	int                     height;
 	long                    size;
-	int                     field;
+	enum v4l2_field         field;
 	enum videobuf_state     state;
 	struct videobuf_dmabuf  dma;
 	struct list_head        stream;  /* QBUF/DQBUF list */
 
 	/* for mmap'ed buffers */
-	unsigned long  boff;             /* buffer offset (mmap) */
-	unsigned long  bsize;            /* buffer size */
-	unsigned long  baddr;            /* buffer addr (userland ptr!) */
+	off_t                   boff;    /* buffer offset (mmap) */
+	size_t                  bsize;   /* buffer size */
+	unsigned long           baddr;   /* buffer addr (userland ptr!) */
 	struct videobuf_mapping *map;
 
 	/* touched by irq handler */
 	struct list_head        queue;
 	wait_queue_head_t       done;
 	int                     field_count;
-#ifdef HAVE_V4L2
-	stamp_t                 ts;
-#endif
+	struct timeval          ts;
 };
 
 struct videobuf_queue_ops {
 	int (*buf_setup)(struct file *file, int *count, int *size);
-	int (*buf_prepare)(struct file *file,struct videobuf_buffer *vb,
-			   int field);
+	int (*buf_prepare)(struct file *file,struct videobuf_buffer *vb);
 	void (*buf_queue)(struct file *file,struct videobuf_buffer *vb);
 	void (*buf_release)(struct file *file,struct videobuf_buffer *vb);
 };
@@ -169,7 +164,7 @@
 	spinlock_t                 *irqlock;
 	struct pci_dev             *pci;
 
-	int                        type;
+	enum v4l2_buf_type         type;
 	int                        msize;
 	struct videobuf_buffer     *bufs[VIDEO_MAX_FRAME];
 	struct videobuf_queue_ops  *ops;
@@ -191,12 +186,12 @@
 void videobuf_queue_init(struct videobuf_queue *q,
 			 struct videobuf_queue_ops *ops,
 			 struct pci_dev *pci, spinlock_t *irqlock,
-			 int type, int msize);
+			 enum v4l2_buf_type type, int msize);
+int  videobuf_queue_is_busy(struct videobuf_queue *q);
 void videobuf_queue_cancel(struct file *file, struct videobuf_queue *q);
 
-#ifdef HAVE_V4L2
 void videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
-		     int type);
+		     enum v4l2_buf_type type);
 int videobuf_reqbufs(struct file *file, struct videobuf_queue *q,
 		     struct v4l2_requestbuffers *req);
 int videobuf_querybuf(struct videobuf_queue *q, struct v4l2_buffer *b);
@@ -204,7 +199,6 @@
 		  struct v4l2_buffer *b);
 int videobuf_dqbuf(struct file *file, struct videobuf_queue *q,
 		   struct v4l2_buffer *b);
-#endif
 int videobuf_streamon(struct file *file, struct videobuf_queue *q);
 int videobuf_streamoff(struct file *file, struct videobuf_queue *q);
 

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
