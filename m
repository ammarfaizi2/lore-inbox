Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUKHJ1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUKHJ1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUKHJ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:27:05 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19422 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261798AbUKHJAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:43 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:51:16 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Cc: Michael Hunold <hunold@linuxtv.org>
Subject: [patch 1/6] v4l: yet another video-buf interface update
Message-ID: <20041108085116.GA19146@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is one more interface fix for the video-buf.c module, the first
attempt on that wasn't that clever.  Instead of passing the driver
private data through all function calls I've just made that an element
of the videobuf_queue struct which is passed around everythere _anyway_.

That removes some reduncancy, should be less error prone and gain me
some points on rusty's interface design scala ;)

Ah, it also fixes the tvtime crashes which where caused by overviewing
one place to fixup in the first attempt.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/video-buf.c |  133 ++++++++++++++++----------------
 include/media/video-buf.h       |   53 +++++++-----
 2 files changed, 97 insertions(+), 89 deletions(-)

Index: linux-2004-11-05/include/media/video-buf.h
===================================================================
--- linux-2004-11-05.orig/include/media/video-buf.h	2004-11-07 12:22:57.000000000 +0100
+++ linux-2004-11-05/include/media/video-buf.h	2004-11-07 15:38:58.617839558 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: video-buf.h,v 1.8 2004/10/13 10:39:00 kraxel Exp $
+ * $Id: video-buf.h,v 1.9 2004/11/07 13:17:15 kraxel Exp $
  *
  * generic helper functions for video4linux capture buffers, to handle
  * memory management and PCI DMA.  Right now bttv + saa7134 use it.
@@ -121,7 +121,6 @@ struct videobuf_queue;
 
 struct videobuf_mapping {
 	unsigned int count;
-	int highmem_ok;
 	unsigned long start;
 	unsigned long end;
 	struct videobuf_queue *q;
@@ -167,12 +166,15 @@ struct videobuf_buffer {
 };
 
 struct videobuf_queue_ops {
-	int (*buf_setup)(void *priv,
+	int (*buf_setup)(struct videobuf_queue *q,
 			 unsigned int *count, unsigned int *size);
-	int (*buf_prepare)(void *priv,struct videobuf_buffer *vb,
+	int (*buf_prepare)(struct videobuf_queue *q,
+			   struct videobuf_buffer *vb,
 			   enum v4l2_field field);
-	void (*buf_queue)(void *priv,struct videobuf_buffer *vb);
-	void (*buf_release)(void *priv,struct videobuf_buffer *vb);
+	void (*buf_queue)(struct videobuf_queue *q,
+			  struct videobuf_buffer *vb);
+	void (*buf_release)(struct videobuf_queue *q,
+			    struct videobuf_buffer *vb);
 };
 
 struct videobuf_queue {
@@ -196,6 +198,9 @@ struct videobuf_queue {
 	unsigned int               reading;
 	unsigned int               read_off;
 	struct videobuf_buffer     *read_buf;
+
+	/* driver private data */
+	void                       *priv_data;
 };
 
 void* videobuf_alloc(unsigned int size);
@@ -205,44 +210,46 @@ int videobuf_iolock(struct pci_dev *pci,
 
 void videobuf_queue_init(struct videobuf_queue *q,
 			 struct videobuf_queue_ops *ops,
-			 struct pci_dev *pci, spinlock_t *irqlock,
+			 struct pci_dev *pci,
+			 spinlock_t *irqlock,
 			 enum v4l2_buf_type type,
 			 enum v4l2_field field,
-			 unsigned int msize);
+			 unsigned int msize,
+			 void *priv);
 int  videobuf_queue_is_busy(struct videobuf_queue *q);
-void videobuf_queue_cancel(void *priv, struct videobuf_queue *q);
+void videobuf_queue_cancel(struct videobuf_queue *q);
 
 enum v4l2_field videobuf_next_field(struct videobuf_queue *q);
 void videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
 		     enum v4l2_buf_type type);
-int videobuf_reqbufs(void *priv, struct videobuf_queue *q,
+int videobuf_reqbufs(struct videobuf_queue *q,
 		     struct v4l2_requestbuffers *req);
 int videobuf_querybuf(struct videobuf_queue *q, struct v4l2_buffer *b);
-int videobuf_qbuf(void *priv, struct videobuf_queue *q,
+int videobuf_qbuf(struct videobuf_queue *q,
 		  struct v4l2_buffer *b);
-int videobuf_dqbuf(void *priv, struct videobuf_queue *q,
+int videobuf_dqbuf(struct videobuf_queue *q,
 		   struct v4l2_buffer *b, int nonblocking);
-int videobuf_streamon(void *priv, struct videobuf_queue *q);
-int videobuf_streamoff(void *priv, struct videobuf_queue *q);
+int videobuf_streamon(struct videobuf_queue *q);
+int videobuf_streamoff(struct videobuf_queue *q);
 
-int videobuf_read_start(void *priv, struct videobuf_queue *q);
-void videobuf_read_stop(void *priv, struct videobuf_queue *q);
-ssize_t videobuf_read_stream(void *priv, struct videobuf_queue *q,
+int videobuf_read_start(struct videobuf_queue *q);
+void videobuf_read_stop(struct videobuf_queue *q);
+ssize_t videobuf_read_stream(struct videobuf_queue *q,
 			     char __user *data, size_t count, loff_t *ppos,
 			     int vbihack, int nonblocking);
-ssize_t videobuf_read_one(void *priv, struct videobuf_queue *q,
+ssize_t videobuf_read_one(struct videobuf_queue *q,
 			  char __user *data, size_t count, loff_t *ppos,
 			  int nonblocking);
-unsigned int videobuf_poll_stream(struct file *file, void *priv,
+unsigned int videobuf_poll_stream(struct file *file,
 				  struct videobuf_queue *q,
 				  poll_table *wait);
 
-int videobuf_mmap_setup(void *priv, struct videobuf_queue *q,
+int videobuf_mmap_setup(struct videobuf_queue *q,
 			unsigned int bcount, unsigned int bsize,
 			enum v4l2_memory memory);
-int videobuf_mmap_free(void *priv, struct videobuf_queue *q);
-int videobuf_mmap_mapper(struct vm_area_struct *vma,
-			 struct videobuf_queue *q);
+int videobuf_mmap_free(struct videobuf_queue *q);
+int videobuf_mmap_mapper(struct videobuf_queue *q,
+			 struct vm_area_struct *vma);
 
 /* --------------------------------------------------------------------- */
 
Index: linux-2004-11-05/drivers/media/video/video-buf.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/video-buf.c	2004-11-07 12:22:48.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/video-buf.c	2004-11-07 15:48:15.881027141 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: video-buf.c,v 1.13 2004/10/13 10:39:00 kraxel Exp $
+ * $Id: video-buf.c,v 1.15 2004/11/07 14:45:00 kraxel Exp $
  *
  * generic helper functions for video4linux capture buffers, to handle
  * memory management and PCI DMA.  Right now bttv + saa7134 use it.
@@ -36,11 +36,11 @@
 	{ printk(KERN_ERR "magic mismatch: %x (expected %x)\n",is,should); BUG(); }
 
 static int debug = 0;
+module_param(debug, int, 0644);
 
 MODULE_DESCRIPTION("helper module to manage video4linux pci dma buffers");
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug,"i");
 
 #define dprintk(level, fmt, arg...)	if (debug >= level) \
 	printk(KERN_DEBUG "vbuf: " fmt , ## arg)
@@ -361,23 +361,23 @@ videobuf_iolock(struct pci_dev *pci, str
 
 /* --------------------------------------------------------------------- */
 
-void
-videobuf_queue_init(struct videobuf_queue *q,
-		    struct videobuf_queue_ops *ops,
-		    struct pci_dev *pci,
-		    spinlock_t *irqlock,
-		    enum v4l2_buf_type type,
-		    enum v4l2_field field,
-		    unsigned int msize)
+void videobuf_queue_init(struct videobuf_queue* q,
+			 struct videobuf_queue_ops *ops,
+			 struct pci_dev *pci,
+			 spinlock_t *irqlock,
+			 enum v4l2_buf_type type,
+			 enum v4l2_field field,
+			 unsigned int msize,
+			 void *priv)
 {
 	memset(q,0,sizeof(*q));
-
 	q->irqlock = irqlock;
 	q->pci     = pci;
 	q->type    = type;
 	q->field   = field;
 	q->msize   = msize;
 	q->ops     = ops;
+	q->priv_data = priv;
 
 	init_MUTEX(&q->lock);
 	INIT_LIST_HEAD(&q->stream);
@@ -420,7 +420,7 @@ videobuf_queue_is_busy(struct videobuf_q
 }
 
 void
-videobuf_queue_cancel(void *priv, struct videobuf_queue *q)
+videobuf_queue_cancel(struct videobuf_queue *q)
 {
 	unsigned long flags;
 	int i;
@@ -441,7 +441,7 @@ videobuf_queue_cancel(void *priv, struct
 	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
 		if (NULL == q->bufs[i])
 			continue;
-		q->ops->buf_release(priv,q->bufs[i]);
+		q->ops->buf_release(q,q->bufs[i]);
 	}
 	INIT_LIST_HEAD(&q->stream);
 }
@@ -523,7 +523,7 @@ videobuf_status(struct v4l2_buffer *b, s
 }
 
 int
-videobuf_reqbufs(void *priv, struct videobuf_queue *q,
+videobuf_reqbufs(struct videobuf_queue *q,
 		 struct v4l2_requestbuffers *req)
 {
 	unsigned int size,count;
@@ -548,12 +548,12 @@ videobuf_reqbufs(void *priv, struct vide
 	if (count > VIDEO_MAX_FRAME)
 		count = VIDEO_MAX_FRAME;
 	size = 0;
-	q->ops->buf_setup(priv,&count,&size);
+	q->ops->buf_setup(q,&count,&size);
 	size = PAGE_ALIGN(size);
 	dprintk(1,"reqbufs: bufs=%d, size=0x%x [%d pages total]\n",
 		count, size, (count*size)>>PAGE_SHIFT);
 
-	retval = videobuf_mmap_setup(priv,q,count,size,req->memory);
+	retval = videobuf_mmap_setup(q,count,size,req->memory);
 	if (retval < 0)
 		goto done;
 
@@ -578,7 +578,7 @@ videobuf_querybuf(struct videobuf_queue 
 }
 
 int
-videobuf_qbuf(void *priv, struct videobuf_queue *q,
+videobuf_qbuf(struct videobuf_queue *q,
 	      struct v4l2_buffer *b)
 {
 	struct videobuf_buffer *buf;
@@ -622,7 +622,7 @@ videobuf_qbuf(void *priv, struct videobu
 		if (b->length < buf->bsize)
 			goto done;
 		if (STATE_NEEDS_INIT != buf->state && buf->baddr != b->m.userptr)
-			q->ops->buf_release(priv,buf);
+			q->ops->buf_release(q,buf);
 		buf->baddr = b->m.userptr;
 		break;
 	case V4L2_MEMORY_OVERLAY:
@@ -633,14 +633,14 @@ videobuf_qbuf(void *priv, struct videobu
 	}
 
 	field = videobuf_next_field(q);
-	retval = q->ops->buf_prepare(priv,buf,field);
+	retval = q->ops->buf_prepare(q,buf,field);
 	if (0 != retval)
 		goto done;
 
 	list_add_tail(&buf->stream,&q->stream);
 	if (q->streaming) {
 		spin_lock_irqsave(q->irqlock,flags);
-		q->ops->buf_queue(priv,buf);
+		q->ops->buf_queue(q,buf);
 		spin_unlock_irqrestore(q->irqlock,flags);
 	}
 	retval = 0;
@@ -651,7 +651,7 @@ videobuf_qbuf(void *priv, struct videobu
 }
 
 int
-videobuf_dqbuf(void *priv, struct videobuf_queue *q,
+videobuf_dqbuf(struct videobuf_queue *q,
 	       struct v4l2_buffer *b, int nonblocking)
 {
 	struct videobuf_buffer *buf;
@@ -691,7 +691,7 @@ videobuf_dqbuf(void *priv, struct videob
 	return retval;
 }
 
-int videobuf_streamon(void *priv, struct videobuf_queue *q)
+int videobuf_streamon(struct videobuf_queue *q)
 {
 	struct videobuf_buffer *buf;
 	struct list_head *list;
@@ -710,7 +710,7 @@ int videobuf_streamon(void *priv, struct
 	list_for_each(list,&q->stream) {
 		buf = list_entry(list, struct videobuf_buffer, stream);
 		if (buf->state == STATE_PREPARED)
-			q->ops->buf_queue(priv,buf);
+			q->ops->buf_queue(q,buf);
 	}
 	spin_unlock_irqrestore(q->irqlock,flags);
 
@@ -719,14 +719,14 @@ int videobuf_streamon(void *priv, struct
 	return retval;
 }
 
-int videobuf_streamoff(void *priv, struct videobuf_queue *q)
+int videobuf_streamoff(struct videobuf_queue *q)
 {
 	int retval = -EINVAL;
 
 	down(&q->lock);
 	if (!q->streaming)
 		goto done;
-	videobuf_queue_cancel(priv,q);
+	videobuf_queue_cancel(q);
 	q->streaming = 0;
 	retval = 0;
 
@@ -736,8 +736,8 @@ int videobuf_streamoff(void *priv, struc
 }
 
 static ssize_t
-videobuf_read_zerocopy(void *priv, struct videobuf_queue *q,
-		       char __user *data, size_t count, loff_t *ppos)
+videobuf_read_zerocopy(struct videobuf_queue *q, char __user *data,
+		       size_t count, loff_t *ppos)
 {
 	enum v4l2_field field;
 	unsigned long flags;
@@ -753,13 +753,13 @@ videobuf_read_zerocopy(void *priv, struc
 	q->read_buf->baddr  = (unsigned long)data;
         q->read_buf->bsize  = count;
 	field = videobuf_next_field(q);
-	retval = q->ops->buf_prepare(priv,q->read_buf,field);
+	retval = q->ops->buf_prepare(q,q->read_buf,field);
 	if (0 != retval)
 		goto done;
 
         /* start capture & wait */
 	spin_lock_irqsave(q->irqlock,flags);
-	q->ops->buf_queue(priv,q->read_buf);
+	q->ops->buf_queue(q,q->read_buf);
 	spin_unlock_irqrestore(q->irqlock,flags);
         retval = videobuf_waiton(q->read_buf,0,0);
         if (0 == retval) {
@@ -772,13 +772,13 @@ videobuf_read_zerocopy(void *priv, struc
 
  done:
 	/* cleanup */
-	q->ops->buf_release(priv,q->read_buf);
+	q->ops->buf_release(q,q->read_buf);
 	kfree(q->read_buf);
 	q->read_buf = NULL;
 	return retval;
 }
 
-ssize_t videobuf_read_one(void *priv, struct videobuf_queue *q,
+ssize_t videobuf_read_one(struct videobuf_queue *q,
 			  char __user *data, size_t count, loff_t *ppos,
 			  int nonblocking)
 {
@@ -790,11 +790,11 @@ ssize_t videobuf_read_one(void *priv, st
 	down(&q->lock);
 
 	nbufs = 1; size = 0;
-	q->ops->buf_setup(priv,&nbufs,&size);
+	q->ops->buf_setup(q,&nbufs,&size);
 	if (NULL == q->read_buf  &&
 	    count >= size        &&
 	    !nonblocking) {
-		retval = videobuf_read_zerocopy(priv,q,data,count,ppos);
+		retval = videobuf_read_zerocopy(q,data,count,ppos);
 		if (retval >= 0  ||  retval == -EIO)
 			/* ok, all done */
 			goto done;
@@ -809,11 +809,11 @@ ssize_t videobuf_read_one(void *priv, st
 			goto done;
 		q->read_buf->memory = V4L2_MEMORY_USERPTR;
 		field = videobuf_next_field(q);
-		retval = q->ops->buf_prepare(priv,q->read_buf,field);
+		retval = q->ops->buf_prepare(q,q->read_buf,field);
 		if (0 != retval)
 			goto done;
 		spin_lock_irqsave(q->irqlock,flags);
-		q->ops->buf_queue(priv,q->read_buf);
+		q->ops->buf_queue(q,q->read_buf);
 		spin_unlock_irqrestore(q->irqlock,flags);
 		q->read_off = 0;
 	}
@@ -826,7 +826,7 @@ ssize_t videobuf_read_one(void *priv, st
 
 	if (STATE_ERROR == q->read_buf->state) {
 		/* catch I/O errors */
-		q->ops->buf_release(priv,q->read_buf);
+		q->ops->buf_release(q,q->read_buf);
 		kfree(q->read_buf);
 		q->read_buf = NULL;
 		retval = -EIO;
@@ -845,7 +845,7 @@ ssize_t videobuf_read_one(void *priv, st
 	q->read_off += bytes;
 	if (q->read_off == q->read_buf->size) {
 		/* all data copied, cleanup */
-		q->ops->buf_release(priv,q->read_buf);
+		q->ops->buf_release(q,q->read_buf);
 		kfree(q->read_buf);
 		q->read_buf = NULL;
 	}
@@ -855,43 +855,43 @@ ssize_t videobuf_read_one(void *priv, st
 	return retval;
 }
 
-int videobuf_read_start(void *priv, struct videobuf_queue *q)
+int videobuf_read_start(struct videobuf_queue *q)
 {
 	enum v4l2_field field;
 	unsigned long flags;
 	int count = 0, size = 0;
 	int err, i;
 
-	q->ops->buf_setup(priv,&count,&size);
+	q->ops->buf_setup(q,&count,&size);
 	if (count < 2)
 		count = 2;
 	if (count > VIDEO_MAX_FRAME)
 		count = VIDEO_MAX_FRAME;
 	size = PAGE_ALIGN(size);
 
-	err = videobuf_mmap_setup(priv, q, count, size, V4L2_MEMORY_USERPTR);
+	err = videobuf_mmap_setup(q, count, size, V4L2_MEMORY_USERPTR);
 	if (err)
 		return err;
 	for (i = 0; i < count; i++) {
 		field = videobuf_next_field(q);
-		err = q->ops->buf_prepare(priv,q->bufs[i],field);
+		err = q->ops->buf_prepare(q,q->bufs[i],field);
 		if (err)
 			return err;
 		list_add_tail(&q->bufs[i]->stream, &q->stream);
 	}
 	spin_lock_irqsave(q->irqlock,flags);
 	for (i = 0; i < count; i++)
-		q->ops->buf_queue(priv,q->bufs[i]);
+		q->ops->buf_queue(q,q->bufs[i]);
 	spin_unlock_irqrestore(q->irqlock,flags);
 	q->reading = 1;
 	return 0;
 }
 
-void videobuf_read_stop(void *priv, struct videobuf_queue *q)
+void videobuf_read_stop(struct videobuf_queue *q)
 {
 	int i;
 
-	videobuf_queue_cancel(priv,q);
+	videobuf_queue_cancel(q);
 	INIT_LIST_HEAD(&q->stream);
 	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
 		if (NULL == q->bufs[i])
@@ -903,7 +903,7 @@ void videobuf_read_stop(void *priv, stru
 	q->reading  = 0;
 }
 
-ssize_t videobuf_read_stream(void *priv, struct videobuf_queue *q,
+ssize_t videobuf_read_stream(struct videobuf_queue *q,
 			     char __user *data, size_t count, loff_t *ppos,
 			     int vbihack, int nonblocking)
 {
@@ -917,7 +917,7 @@ ssize_t videobuf_read_stream(void *priv,
 	if (q->streaming)
 		goto done;
 	if (!q->reading) {
-		retval = videobuf_read_start(priv,q);
+		retval = videobuf_read_start(q);
 		if (retval < 0)
 			goto done;
 	}
@@ -977,7 +977,7 @@ ssize_t videobuf_read_stream(void *priv,
 			list_add_tail(&q->read_buf->stream,
 				      &q->stream);
 			spin_lock_irqsave(q->irqlock,flags);
-			q->ops->buf_queue(priv,q->read_buf);
+			q->ops->buf_queue(q,q->read_buf);
 			spin_unlock_irqrestore(q->irqlock,flags);
 			q->read_buf = NULL;
 		}
@@ -990,7 +990,7 @@ ssize_t videobuf_read_stream(void *priv,
 	return retval;
 }
 
-unsigned int videobuf_poll_stream(struct file *file, void *priv,
+unsigned int videobuf_poll_stream(struct file *file,
 				  struct videobuf_queue *q,
 				  poll_table *wait)
 {
@@ -1004,7 +1004,7 @@ unsigned int videobuf_poll_stream(struct
 					 struct videobuf_buffer, stream);
 	} else {
 		if (!q->reading)
-			videobuf_read_start(priv,q);
+			videobuf_read_start(q);
 		if (!q->reading) {
 			rc = POLLERR;
 		} else if (NULL == q->read_buf) {
@@ -1045,29 +1045,30 @@ static void
 videobuf_vm_close(struct vm_area_struct *vma)
 {
 	struct videobuf_mapping *map = vma->vm_private_data;
+	struct videobuf_queue *q = map->q;
 	int i;
 
 	dprintk(2,"vm_close %p [count=%d,vma=%08lx-%08lx]\n",map,
 		map->count,vma->vm_start,vma->vm_end);
 
-	/* down(&fh->lock); FIXME */
 	map->count--;
 	if (0 == map->count) {
-		dprintk(1,"munmap %p\n",map);
+		dprintk(1,"munmap %p q=%p\n",map,q);
+		down(&q->lock);
 		for (i = 0; i < VIDEO_MAX_FRAME; i++) {
-			if (NULL == map->q->bufs[i])
+			if (NULL == q->bufs[i])
 				continue;
-			if (map->q->bufs[i])
+			if (q->bufs[i])
 				;
-			if (map->q->bufs[i]->map != map)
+			if (q->bufs[i]->map != map)
 				continue;
-			map->q->bufs[i]->map   = NULL;
-			map->q->bufs[i]->baddr = 0;
-			map->q->ops->buf_release(vma->vm_file,map->q->bufs[i]);
+			q->bufs[i]->map   = NULL;
+			q->bufs[i]->baddr = 0;
+			q->ops->buf_release(q,q->bufs[i]);
 		}
+		up(&q->lock);
 		kfree(map);
 	}
-	/* up(&fh->lock); FIXME */
 	return;
 }
 
@@ -1103,14 +1104,14 @@ static struct vm_operations_struct video
 	.nopage   = videobuf_vm_nopage,
 };
 
-int videobuf_mmap_setup(void *priv, struct videobuf_queue *q,
+int videobuf_mmap_setup(struct videobuf_queue *q,
 			unsigned int bcount, unsigned int bsize,
 			enum v4l2_memory memory)
 {
 	unsigned int i;
 	int err;
 
-	err = videobuf_mmap_free(priv,q);
+	err = videobuf_mmap_free(q);
 	if (0 != err)
 		return err;
 
@@ -1135,7 +1136,7 @@ int videobuf_mmap_setup(void *priv, stru
 	return 0;
 }
 
-int videobuf_mmap_free(void *priv, struct videobuf_queue *q)
+int videobuf_mmap_free(struct videobuf_queue *q)
 {
 	int i;
 
@@ -1145,15 +1146,15 @@ int videobuf_mmap_free(void *priv, struc
 	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
 		if (NULL == q->bufs[i])
 			continue;
-		q->ops->buf_release(priv,q->bufs[i]);
+		q->ops->buf_release(q,q->bufs[i]);
 		kfree(q->bufs[i]);
 		q->bufs[i] = NULL;
 	}
 	return 0;
 }
 
-int videobuf_mmap_mapper(struct vm_area_struct *vma,
-			 struct videobuf_queue *q)
+int videobuf_mmap_mapper(struct videobuf_queue *q,
+			 struct vm_area_struct *vma)
 {
 	struct videobuf_mapping *map;
 	unsigned int first,last,size,i;
@@ -1222,8 +1223,8 @@ int videobuf_mmap_mapper(struct vm_area_
 	vma->vm_flags |= VM_DONTEXPAND | VM_RESERVED;
 	vma->vm_flags &= ~VM_IO; /* using shared anonymous pages */
 	vma->vm_private_data = map;
-	dprintk(1,"mmap %p: %08lx-%08lx pgoff %08lx bufs %d-%d\n",
-		map,vma->vm_start,vma->vm_end,vma->vm_pgoff,first,last);
+	dprintk(1,"mmap %p: q=%p %08lx-%08lx pgoff %08lx bufs %d-%d\n",
+		map,q,vma->vm_start,vma->vm_end,vma->vm_pgoff,first,last);
 	retval = 0;
 
  done:

-- 
#define printk(args...) fprintf(stderr, ## args)
