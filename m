Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265090AbUFRJns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbUFRJns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUFRJlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:41:02 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:9151 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265089AbUFRJkP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:40:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:14:44 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: video-buf fixes.
Message-ID: <20040618091444.GA23700@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch has some minor bugfixes for the video-buf module.

  Gerd

diff -up linux-2.6.7/drivers/media/video/video-buf.c linux/drivers/media/video/video-buf.c
--- linux-2.6.7/drivers/media/video/video-buf.c	2004-06-17 13:47:58.810455873 +0200
+++ linux/drivers/media/video/video-buf.c	2004-06-17 13:47:58.883442137 +0200
@@ -5,10 +5,10 @@
  * The functions expect the hardware being able to scatter gatter
  * (i.e. the buffers are not linear in physical memory, but fragmented
  * into PAGE_SIZE chunks).  They also assume the driver does not need
- * to touch the video data (thus it is probably not useful for USB as
- * data often must be uncompressed by the drivers).
+ * to touch the video data (thus it is probably not useful for USB 1.1
+ * as data often must be uncompressed by the drivers).
  * 
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org>
+ * (c) 2001-2004 Gerd Knorr <kraxel@bytesex.org> [SUSE Labs]
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -181,7 +181,7 @@ int videobuf_dma_init_overlay(struct vid
 	dma->direction = direction;
 	if (0 == addr)
 		return -EINVAL;
-
+	
 	dma->bus_addr = addr;
 	dma->nr_pages = nr_pages;
 	return 0;
@@ -536,6 +536,11 @@ videobuf_reqbufs(struct file *file, stru
 	    req->memory != V4L2_MEMORY_OVERLAY)
 		return -EINVAL;
 
+	if (q->streaming)
+		return -EBUSY;
+	if (!list_empty(&q->stream))
+		return -EBUSY;
+
 	down(&q->lock);
 	count = req->count;
 	if (count > VIDEO_MAX_FRAME)
@@ -614,6 +619,8 @@ videobuf_qbuf(struct file *file, struct 
 	case V4L2_MEMORY_USERPTR:
 		if (b->length < buf->bsize)
 			goto done;
+		if (STATE_NEEDS_INIT != buf->state && buf->baddr != b->m.userptr)
+			q->ops->buf_release(file,buf);
 		buf->baddr = b->m.userptr;
 		break;
 	case V4L2_MEMORY_OVERLAY:
@@ -1118,7 +1125,7 @@ int videobuf_mmap_setup(struct file *fil
 		case V4L2_MEMORY_OVERLAY:
 			/* nothing */
 			break;
-		};
+		}
 	}
 	dprintk(1,"mmap setup: %d buffers, %d bytes each\n",
 		bcount,bsize);
diff -up linux-2.6.7/include/media/video-buf.h linux/include/media/video-buf.h
--- linux-2.6.7/include/media/video-buf.h	2004-06-17 13:47:58.812455497 +0200
+++ linux/include/media/video-buf.h	2004-06-17 13:47:58.885441761 +0200
@@ -36,8 +36,6 @@ struct scatterlist* videobuf_vmalloc_to_
  */
 struct scatterlist* videobuf_pages_to_sg(struct page **pages, int nr_pages,
 					 int offset);
-int videobuf_lock(struct page **pages, int nr_pages);
-int videobuf_unlock(struct page **pages, int nr_pages);
 
 /* --------------------------------------------------------------------- */
 

-- 
Smoking Crack Organization
