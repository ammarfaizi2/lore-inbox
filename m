Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUFRJWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUFRJWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbUFRJWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:22:44 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:3516 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265083AbUFRJUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:20:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:10:04 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: update video-buf for per-frame input switching.
Message-ID: <20040618091003.GA23646@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the video-buf module to support the per-frame input
switching added by the v4l2 API patch.

  Gerd

diff -up linux-2.6.7/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.6.7/drivers/media/video/video-buf.c	2004-06-17 10:29:10.000000000 +0200
+++ linux/drivers/media/video/video-buf.c	2004-06-17 13:47:58.729471114 +0200
@@ -491,6 +491,11 @@ videobuf_status(struct v4l2_buffer *b, s
 		break;
 	}
 
+	if (vb->input != UNSET) {
+		b->flags |= V4L2_BUF_FLAG_INPUT;
+		b->input  = vb->input;
+	}
+
 	b->field     = vb->field;
 	b->timestamp = vb->ts;
 	b->bytesused = vb->size;
@@ -574,6 +579,14 @@ videobuf_qbuf(struct file *file, struct 
 	    buf->state == STATE_ACTIVE)
 		goto done;
 
+	if (b->flags & V4L2_BUF_FLAG_INPUT) {
+		if (b->input >= q->inputs)
+			goto done;
+		buf->input = b->input;
+	} else {
+		buf->input = UNSET;
+	}
+
 	switch (b->memory) {
 	case V4L2_MEMORY_MMAP:
 		if (0 == buf->baddr)
@@ -1075,6 +1088,7 @@ int videobuf_mmap_setup(struct file *fil
 	for (i = 0; i < bcount; i++) {
 		q->bufs[i] = videobuf_alloc(q->msize);
 		q->bufs[i]->i      = i;
+		q->bufs[i]->input  = UNSET;
 		q->bufs[i]->memory = memory;
 		q->bufs[i]->bsize  = bsize;
 		switch (memory) {
diff -up linux-2.6.7/include/media/video-buf.h linux/include/media/video-buf.h
--- linux-2.6.7/include/media/video-buf.h	2004-06-17 10:29:24.000000000 +0200
+++ linux/include/media/video-buf.h	2004-06-17 13:47:58.732470549 +0200
@@ -18,6 +18,8 @@
 
 #include <linux/videodev.h>
 
+#define UNSET (-1U)
+
 /* --------------------------------------------------------------------- */
 
 /*
@@ -140,6 +142,7 @@ struct videobuf_buffer {
 	unsigned int            height;
 	unsigned int            bytesperline; /* use only if != 0 */
 	unsigned long           size;
+	unsigned int            input;
 	enum v4l2_field         field;
 	enum videobuf_state     state;
 	struct videobuf_dmabuf  dma;
@@ -174,9 +177,10 @@ struct videobuf_queue {
 	struct pci_dev             *pci;
 
 	enum v4l2_buf_type         type;
+	unsigned int               inputs; /* for V4L2_BUF_FLAG_INPUT */
 	unsigned int               msize;
 	enum v4l2_field            field;
-	enum v4l2_field            last; /* for field=V4L2_FIELD_ALTERNATE */
+	enum v4l2_field            last;   /* for field=V4L2_FIELD_ALTERNATE */
 	struct videobuf_buffer     *bufs[VIDEO_MAX_FRAME];
 	struct videobuf_queue_ops  *ops;
 

-- 
Smoking Crack Organization
