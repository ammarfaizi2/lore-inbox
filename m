Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTAHK42>; Wed, 8 Jan 2003 05:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266038AbTAHK42>; Wed, 8 Jan 2003 05:56:28 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:8586 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S264715AbTAHK4Z>; Wed, 8 Jan 2003 05:56:25 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 12:14:50 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Michael Hunold <m.hunold@gmx.de>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] video-buf.c update
Message-ID: <20030108111450.GA10073@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the video-buf helper module.  It changes the field
handling a bit and adds code do deal better with alternating field
capture (= capture even and odd fields to separate video buffers).

Please apply,

  Gerd

--- linux-2.5.54/drivers/media/video/video-buf.c	2003-01-08 10:34:29.000000000 +0100
+++ linux/drivers/media/video/video-buf.c	2003-01-08 10:59:58.000000000 +0100
@@ -339,6 +339,7 @@
 		    struct pci_dev *pci,
 		    spinlock_t *irqlock,
 		    enum v4l2_buf_type type,
+		    enum v4l2_field field,
 		    int msize)
 {
 	memset(q,0,sizeof(*q));
@@ -346,6 +347,7 @@
 	q->irqlock = irqlock;
 	q->pci     = pci;
 	q->type    = type;
+	q->field   = field;
 	q->msize   = msize;
 	q->ops     = ops;
 
@@ -406,6 +408,25 @@
 
 /* --------------------------------------------------------------------- */
 
+enum v4l2_field
+videobuf_next_field(struct videobuf_queue *q)
+{
+	enum v4l2_field field = q->field;
+
+	BUG_ON(V4L2_FIELD_ANY == field);
+
+	if (V4L2_FIELD_ALTERNATE == field) {
+		if (V4L2_FIELD_TOP == q->last) {
+			field   = V4L2_FIELD_TOP;
+			q->last = V4L2_FIELD_TOP;
+		} else {
+			field   = V4L2_FIELD_BOTTOM;
+			q->last = V4L2_FIELD_BOTTOM;
+		}
+	}
+	return field;
+}
+
 void
 videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
 		enum v4l2_buf_type type)
@@ -486,6 +507,7 @@
 	      struct v4l2_buffer *b)
 {
 	struct videobuf_buffer *buf;
+	enum v4l2_field field;
 	unsigned long flags;
 	int retval;
 
@@ -507,7 +529,8 @@
 	    buf->state == STATE_ACTIVE)
 		goto done;
 
-	retval = q->ops->buf_prepare(file,buf);
+	field = videobuf_next_field(q);
+	retval = q->ops->buf_prepare(file,buf,field);
 	if (0 != retval)
 		goto done;
 	
@@ -613,6 +636,8 @@
 videobuf_read_zerocopy(struct file *file, struct videobuf_queue *q,
 		       char *data, size_t count, loff_t *ppos)
 {
+	enum v4l2_field field;
+	unsigned long flags;
         int retval;
 
         /* setup stuff */
@@ -623,12 +648,15 @@
 
 	q->read_buf->baddr = (unsigned long)data;
         q->read_buf->bsize = count;
-	retval = q->ops->buf_prepare(file,q->read_buf);
+	field = videobuf_next_field(q);
+	retval = q->ops->buf_prepare(file,q->read_buf,field);
 	if (0 != retval)
 		goto done;
 	
         /* start capture & wait */
+	spin_lock_irqsave(q->irqlock,flags);
 	q->ops->buf_queue(file,q->read_buf);
+	spin_unlock_irqrestore(q->irqlock,flags);
         retval = videobuf_waiton(q->read_buf,0,0);
         if (0 == retval) {
 		videobuf_dma_pci_sync(q->pci,&q->read_buf->dma);
@@ -646,6 +674,8 @@
 ssize_t videobuf_read_one(struct file *file, struct videobuf_queue *q,
 			  char *data, size_t count, loff_t *ppos)
 {
+	enum v4l2_field field;
+	unsigned long flags;
 	int retval, bytes, size, nbufs;
 
 	down(&q->lock);
@@ -668,10 +698,13 @@
 		q->read_buf = videobuf_alloc(q->msize);
 		if (NULL == q->read_buf)
 			goto done;
-		retval = q->ops->buf_prepare(file,q->read_buf);
+		field = videobuf_next_field(q);
+		retval = q->ops->buf_prepare(file,q->read_buf,field);
 		if (0 != retval)
 			goto done;
+		spin_lock_irqsave(q->irqlock,flags);
 		q->ops->buf_queue(file,q->read_buf);
+		spin_unlock_irqrestore(q->irqlock,flags);
 		q->read_off = 0;
 	}
 
@@ -705,6 +738,7 @@
 
 int videobuf_read_start(struct file *file, struct videobuf_queue *q)
 {
+	enum v4l2_field field;
 	unsigned long flags;
 	int count = 0, size = 0;
 	int err, i;
@@ -720,7 +754,8 @@
 	if (err)
 		return err;
 	for (i = 0; i < count; i++) {
-		err = q->ops->buf_prepare(file,q->bufs[i]);
+		field = videobuf_next_field(q);
+		err = q->ops->buf_prepare(file,q->bufs[i],field);
 		if (err)
 			return err;
 		list_add_tail(&q->bufs[i]->stream, &q->stream);
@@ -793,6 +828,7 @@
 			fc  = (unsigned int*)q->read_buf->dma.vmalloc;
 			fc += (q->read_buf->size>>2) -1;
 			*fc = q->read_buf->field_count >> 1;
+			dprintk(1,"vbihack: %d\n",*fc);
 		}
 
 		/* copy stuff */
--- linux-2.5.54/drivers/media/video/video-buf.h	2003-01-08 10:34:32.000000000 +0100
+++ linux/drivers/media/video/video-buf.h	2003-01-08 10:59:58.000000000 +0100
@@ -154,7 +154,8 @@
 
 struct videobuf_queue_ops {
 	int (*buf_setup)(struct file *file, int *count, int *size);
-	int (*buf_prepare)(struct file *file,struct videobuf_buffer *vb);
+	int (*buf_prepare)(struct file *file,struct videobuf_buffer *vb,
+			   enum v4l2_field field);
 	void (*buf_queue)(struct file *file,struct videobuf_buffer *vb);
 	void (*buf_release)(struct file *file,struct videobuf_buffer *vb);
 };
@@ -166,6 +167,8 @@
 
 	enum v4l2_buf_type         type;
 	int                        msize;
+	enum v4l2_field            field;
+	enum v4l2_field            last; /* for field=V4L2_FIELD_ALTERNATE */
 	struct videobuf_buffer     *bufs[VIDEO_MAX_FRAME];
 	struct videobuf_queue_ops  *ops;
 
@@ -186,7 +189,8 @@
 void videobuf_queue_init(struct videobuf_queue *q,
 			 struct videobuf_queue_ops *ops,
 			 struct pci_dev *pci, spinlock_t *irqlock,
-			 enum v4l2_buf_type type, int msize);
+			 enum v4l2_buf_type type,
+			 enum v4l2_field field, int msize);
 int  videobuf_queue_is_busy(struct videobuf_queue *q);
 void videobuf_queue_cancel(struct file *file, struct videobuf_queue *q);
 

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
