Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTELQm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTELQm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:42:27 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:28037 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262282AbTELQmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:42:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:03:34 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #1 - video-buf update
Message-ID: <20030512170334.GA23843@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Sending a batch of video4linux updates, trying to reduce my patch
backlog ...

This minor patch updates the video-buf module.  It just adds a export
for the videobuf_next_field function and adds some debug printk's.

Please apply,

  Gerd

diff -u linux-2.5.69/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.5.69/drivers/media/video/video-buf.c	2003-05-08 13:30:56.000000000 +0200
+++ linux/drivers/media/video/video-buf.c	2003-05-08 13:55:11.000000000 +0200
@@ -362,21 +363,33 @@
 {
 	int i;
 	
-	if (q->reading)
+	if (q->streaming) {
+		dprintk(1,"busy: streaming active\n");
 		return 1;
-	if (q->streaming)
+	}
+	if (q->reading) {
+		dprintk(1,"busy: pending read #1\n");
 		return 1;
-	if (q->read_buf)
+	}
+	if (q->read_buf) {
+		dprintk(1,"busy: pending read #2\n");
 		return 1;
+	}
 	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
 		if (NULL == q->bufs[i])
 			continue;
-		if (q->bufs[i]->map)
+		if (q->bufs[i]->map) {
+			dprintk(1,"busy: buffer #%d mapped\n",i);
 			return 1;
-		if (q->bufs[i]->state == STATE_QUEUED)
+		}
+		if (q->bufs[i]->state == STATE_QUEUED) {
+			dprintk(1,"busy: buffer #%d queued\n",i);
 			return 1;
-		if (q->bufs[i]->state == STATE_ACTIVE)
+		}
+		if (q->bufs[i]->state == STATE_ACTIVE) {
+			dprintk(1,"busy: buffer #%d avtive\n",i);
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -569,7 +582,7 @@
 	if (list_empty(&q->stream))
 		goto done;
 	buf = list_entry(q->stream.next, struct videobuf_buffer, stream);
-	retval = videobuf_waiton(buf,1,1);
+	retval = videobuf_waiton(buf, file->f_flags & O_NONBLOCK, 1);
 	if (retval < 0)
 		goto done;
 	switch (buf->state) {
@@ -925,6 +938,9 @@
 videobuf_vm_open(struct vm_area_struct *vma)
 {
 	struct videobuf_mapping *map = vma->vm_private_data;
+
+	dprintk(2,"vm_open %p [count=%d,vma=%08lx-%08lx]\n",map,
+		map->count,vma->vm_start,vma->vm_end);
 	map->count++;
 }
 
@@ -934,6 +950,9 @@
 	struct videobuf_mapping *map = vma->vm_private_data;
 	int i;
 
+	dprintk(2,"vm_close %p [count=%d,vma=%08lx-%08lx]\n",map,
+		map->count,vma->vm_start,vma->vm_end);
+
 	/* down(&fh->lock); FIXME */
 	map->count--;
 	if (0 == map->count) {
@@ -1081,11 +1100,11 @@
 		q->bufs[i]->map   = map;
 		q->bufs[i]->baddr = vma->vm_start + size;
 	}
-	map->count   = 1;
-	map->start   = vma->vm_start;
-	map->end     = vma->vm_end;
-	map->q       = q;
-	vma->vm_ops  = &videobuf_vm_ops;
+	map->count    = 1;
+	map->start    = vma->vm_start;
+	map->end      = vma->vm_end;
+	map->q        = q;
+	vma->vm_ops   = &videobuf_vm_ops;
 	vma->vm_flags |= VM_DONTEXPAND;
 	vma->vm_flags &= ~VM_IO; /* using shared anonymous pages */
 	vma->vm_private_data = map;
@@ -1119,6 +1138,7 @@
 EXPORT_SYMBOL_GPL(videobuf_queue_cancel);
 EXPORT_SYMBOL_GPL(videobuf_queue_is_busy);
 
+EXPORT_SYMBOL_GPL(videobuf_next_field);
 EXPORT_SYMBOL_GPL(videobuf_status);
 EXPORT_SYMBOL_GPL(videobuf_reqbufs);
 EXPORT_SYMBOL_GPL(videobuf_querybuf);
diff -u linux-2.5.69/include/media/video-buf.h linux/include/media/video-buf.h
--- linux-2.5.69/include/media/video-buf.h	2003-05-08 13:31:01.000000000 +0200
+++ linux/include/media/video-buf.h	2003-05-08 13:55:11.000000000 +0200
@@ -196,6 +196,7 @@
 int  videobuf_queue_is_busy(struct videobuf_queue *q);
 void videobuf_queue_cancel(struct file *file, struct videobuf_queue *q);
 
+enum v4l2_field videobuf_next_field(struct videobuf_queue *q);
 void videobuf_status(struct v4l2_buffer *b, struct videobuf_buffer *vb,
 		     enum v4l2_buf_type type);
 int videobuf_reqbufs(struct file *file, struct videobuf_queue *q,

-- 
sigfault
