Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbUKHJXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbUKHJXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKHJWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:22:45 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18910 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261797AbUKHJAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:32 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:52:27 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 6/6] v4l: saa7146 update
Message-ID: <20041108085226.GA19247@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt saa7134 driver to video-buf changes.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/common/saa7146_fops.c  |    4 +--
 drivers/media/common/saa7146_vbi.c   |   21 ++++++++--------
 drivers/media/common/saa7146_video.c |   34 ++++++++++++++-------------
 3 files changed, 31 insertions(+), 28 deletions(-)

Index: linux-2004-11-05/drivers/media/common/saa7146_video.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/common/saa7146_video.c	2004-11-07 12:23:17.000000000 +0100
+++ linux-2004-11-05/drivers/media/common/saa7146_video.c	2004-11-07 16:28:09.000000000 +0100
@@ -1137,7 +1137,7 @@ int saa7146_video_do_ioctl(struct inode 
 	case VIDIOC_REQBUFS: {
 		struct v4l2_requestbuffers *req = arg;
 		DEB_D(("VIDIOC_REQBUFS, type:%d\n",req->type));
-		return videobuf_reqbufs(file,q,req);
+		return videobuf_reqbufs(q,req);
 	}
 	case VIDIOC_QUERYBUF: {
 		struct v4l2_buffer *buf = arg;
@@ -1147,14 +1147,14 @@ int saa7146_video_do_ioctl(struct inode 
 	case VIDIOC_QBUF: {
 		struct v4l2_buffer *buf = arg;
 		int ret = 0;
-		ret = videobuf_qbuf(file,q,buf);
+		ret = videobuf_qbuf(q,buf);
 		DEB_D(("VIDIOC_QBUF: ret:%d, index:%d\n",ret,buf->index));
 		return ret;
 	}
 	case VIDIOC_DQBUF: {
 		struct v4l2_buffer *buf = arg;
 		int ret = 0;
-		ret = videobuf_dqbuf(file,q,buf,file->f_flags & O_NONBLOCK);
+		ret = videobuf_dqbuf(q,buf,file->f_flags & O_NONBLOCK);
 		DEB_D(("VIDIOC_DQBUF: ret:%d, index:%d\n",ret,buf->index));
 		return ret;
 	}
@@ -1166,7 +1166,7 @@ int saa7146_video_do_ioctl(struct inode 
 		if( 0 != err) {
 				return err;
 			}
-		err = videobuf_streamon(file,q);
+		err = videobuf_streamon(q);
 		return err;
 	}
 	case VIDIOC_STREAMOFF: {
@@ -1187,7 +1187,7 @@ int saa7146_video_do_ioctl(struct inode 
 			return -EBUSY;
 		}
 
-		err = videobuf_streamoff(file,q);
+		err = videobuf_streamoff(q);
 		if (0 != err) {
 			DEB_D(("warning: videobuf_streamoff() failed.\n"));
 		video_end(fh, file);
@@ -1210,7 +1210,7 @@ int saa7146_video_do_ioctl(struct inode 
 
 		q = &fh->video_q;
 		down(&q->lock);
-		err = videobuf_mmap_setup(file,q,gbuffers,gbufsize,
+		err = videobuf_mmap_setup(q,gbuffers,gbufsize,
 					  V4L2_MEMORY_MMAP);
 		if (err < 0) {
 			up(&q->lock);
@@ -1247,9 +1247,10 @@ static int buffer_activate (struct saa71
 	return 0;
 }
 
-static int buffer_prepare(void *priv, struct videobuf_buffer *vb, enum v4l2_field field)
+static int buffer_prepare(struct videobuf_queue *q,
+			  struct videobuf_buffer *vb, enum v4l2_field field)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -1330,9 +1331,9 @@ static int buffer_prepare(void *priv, st
 	return err;
 }
 
-static int buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+static int buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh = file->private_data;
 
 	if (0 == *count || *count > MAX_SAA7146_CAPTURE_BUFFERS)
@@ -1350,9 +1351,9 @@ static int buffer_setup(void *priv, unsi
 	return 0;
 }
 
-static void buffer_queue(void *priv, struct videobuf_buffer *vb)
+static void buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -1363,9 +1364,9 @@ static void buffer_queue(void *priv, str
 }
 
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_buf *buf = (struct saa7146_buf *)vb;
@@ -1419,7 +1420,8 @@ static int video_open(struct saa7146_dev
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_INTERLACED,
-			    sizeof(struct saa7146_buf));
+			    sizeof(struct saa7146_buf),
+			    file);
 
 	init_MUTEX(&fh->video_q.lock);
 
@@ -1485,7 +1487,7 @@ static ssize_t video_read(struct file *f
 		goto out;
 	}
 
-	ret = videobuf_read_one(file,&fh->video_q , data, count, ppos,
+	ret = videobuf_read_one(&fh->video_q, data, count, ppos,
 				file->f_flags & O_NONBLOCK);
 	if (ret != 0) {
 	video_end(fh, file);
Index: linux-2004-11-05/drivers/media/common/saa7146_vbi.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/common/saa7146_vbi.c	2004-11-07 12:21:14.000000000 +0100
+++ linux-2004-11-05/drivers/media/common/saa7146_vbi.c	2004-11-07 16:31:31.000000000 +0100
@@ -213,9 +213,9 @@ static int buffer_activate(struct saa714
 	return 0;
 }
 
-static int buffer_prepare(void *priv, struct videobuf_buffer *vb,enum v4l2_field field)
+static int buffer_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,enum v4l2_field field)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_buf *buf = (struct saa7146_buf *)vb;
@@ -265,7 +265,7 @@ static int buffer_prepare(void *priv, st
 	return err;
 }
 
-static int buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+static int buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
 	int llength,lines;
 	
@@ -280,9 +280,9 @@ static int buffer_setup(void *priv, unsi
 	return 0;
 }
 
-static void buffer_queue(void *priv, struct videobuf_buffer *vb)
+static void buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
@@ -292,9 +292,9 @@ static void buffer_queue(void *priv, str
 	saa7146_buffer_queue(dev,&vv->vbi_q,buf);
 }
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct file *file = priv;
+	struct file *file = q->priv_data;
 	struct saa7146_fh *fh   = file->private_data;
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_buf *buf = (struct saa7146_buf *)vb;
@@ -334,7 +334,7 @@ static void vbi_stop(struct saa7146_fh *
 		saa7146_buffer_finish(dev,&vv->vbi_q,STATE_DONE);
 	}
 
-	videobuf_queue_cancel(file,&fh->vbi_q);
+	videobuf_queue_cancel(&fh->vbi_q);
 
 	vv->vbi_streaming = NULL;
 
@@ -407,7 +407,8 @@ static int vbi_open(struct saa7146_dev *
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VBI_CAPTURE,
 			    V4L2_FIELD_SEQ_TB, // FIXME: does this really work?
-			    sizeof(struct saa7146_buf));
+			    sizeof(struct saa7146_buf),
+			    file);
 	init_MUTEX(&fh->vbi_q.lock);
 
 	init_timer(&fh->vbi_read_timeout);
@@ -483,7 +484,7 @@ static ssize_t vbi_read(struct file *fil
 	}
 
 	mod_timer(&fh->vbi_read_timeout, jiffies+BUFFER_TIMEOUT);
-	ret = videobuf_read_stream(file, &fh->vbi_q, data, count, ppos, 1,
+	ret = videobuf_read_stream(&fh->vbi_q, data, count, ppos, 1,
 				   file->f_flags & O_NONBLOCK);
 /*
 	printk("BASE_ODD3:      0x%08x\n", saa7146_read(dev, BASE_ODD3));
Index: linux-2004-11-05/drivers/media/common/saa7146_fops.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/common/saa7146_fops.c	2004-11-07 12:22:51.000000000 +0100
+++ linux-2004-11-05/drivers/media/common/saa7146_fops.c	2004-11-07 16:23:14.000000000 +0100
@@ -349,7 +349,7 @@ static int fops_mmap(struct file *file, 
 		BUG();
 		return 0;
 	}
-	return videobuf_mmap_mapper(vma,q);
+	return videobuf_mmap_mapper(q,vma);
 }
 
 static unsigned int fops_poll(struct file *file, struct poll_table_struct *wait)
@@ -362,7 +362,7 @@ static unsigned int fops_poll(struct fil
 
 	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
 		if( 0 == fh->vbi_q.streaming )
-			return videobuf_poll_stream(file, file->private_data, &fh->vbi_q, wait);
+			return videobuf_poll_stream(file, &fh->vbi_q, wait);
 		q = &fh->vbi_q;
 	} else {
 		DEB_D(("using video queue.\n"));

-- 
#define printk(args...) fprintf(stderr, ## args)
