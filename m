Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUKSRGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUKSRGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbUKSRFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:05:00 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:28903 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261495AbUKSREL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:04:11 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 19 Nov 2004 17:56:04 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] video-buf oops/crash fixes
Message-ID: <20041119165603.GA2819@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some places which need adaption to the last video-buf API change
where forgotten, this patches fixes them up.  Hope I really catched
them all now.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/bttv-driver.c           |    8 ++++----
 drivers/media/video/cx88/cx88-video.c       |    2 +-
 drivers/media/video/saa7134/saa7134-video.c |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.10-rc2/drivers/media/video/saa7134/saa7134-video.c
===================================================================
--- linux-2.6.10-rc2.orig/drivers/media/video/saa7134/saa7134-video.c	2004-11-17 18:39:15.000000000 +0100
+++ linux-2.6.10-rc2/drivers/media/video/saa7134/saa7134-video.c	2004-11-19 15:42:44.383472058 +0100
@@ -1305,11 +1305,11 @@ video_poll(struct file *file, struct pol
                                 up(&fh->cap.lock);
                                 return POLLERR;
                         }
-                        if (0 != fh->cap.ops->buf_prepare(file->private_data,fh->cap.read_buf,fh->cap.field)) {
+                        if (0 != fh->cap.ops->buf_prepare(&fh->cap,fh->cap.read_buf,fh->cap.field)) {
                                 up(&fh->cap.lock);
                                 return POLLERR;
                         }
-                        fh->cap.ops->buf_queue(file->private_data,fh->cap.read_buf);
+                        fh->cap.ops->buf_queue(&fh->cap,fh->cap.read_buf);
                         fh->cap.read_off = 0;
 		}
 		up(&fh->cap.lock);
@@ -1346,7 +1346,7 @@ static int video_release(struct inode *i
 		res_free(dev,fh,RESOURCE_VIDEO);
 	}
 	if (fh->cap.read_buf) {
-		buffer_release(file->private_data,fh->cap.read_buf);
+		buffer_release(&fh->cap,fh->cap.read_buf);
 		kfree(fh->cap.read_buf);
 	}
 
Index: linux-2.6.10-rc2/drivers/media/video/cx88/cx88-video.c
===================================================================
--- linux-2.6.10-rc2.orig/drivers/media/video/cx88/cx88-video.c	2004-11-17 18:40:34.000000000 +0100
+++ linux-2.6.10-rc2/drivers/media/video/cx88/cx88-video.c	2004-11-19 15:42:40.800146428 +0100
@@ -1070,7 +1070,7 @@ static int video_release(struct inode *i
 		res_free(dev,fh,RESOURCE_VIDEO);
 	}
 	if (fh->vidq.read_buf) {
-		buffer_release(file->private_data,fh->vidq.read_buf);
+		buffer_release(&fh->vidq,fh->vidq.read_buf);
 		kfree(fh->vidq.read_buf);
 	}
 
Index: linux-2.6.10-rc2/drivers/media/video/bttv-driver.c
===================================================================
--- linux-2.6.10-rc2.orig/drivers/media/video/bttv-driver.c	2004-11-17 18:41:17.000000000 +0100
+++ linux-2.6.10-rc2/drivers/media/video/bttv-driver.c	2004-11-19 15:42:35.974054684 +0100
@@ -2418,7 +2418,7 @@ static int bttv_do_ioctl(struct inode *i
 		if (0 != retval)
 			goto fh_unlock_and_return;
 		spin_lock_irqsave(&btv->s_lock,flags);
-		buffer_queue(file->private_data,&buf->vb);
+		buffer_queue(&fh->cap,&buf->vb);
 		spin_unlock_irqrestore(&btv->s_lock,flags);
 		up(&fh->cap.lock);
 		return 0;
@@ -2881,11 +2881,11 @@ static unsigned int bttv_poll(struct fil
 			}
 			fh->cap.read_buf->memory = V4L2_MEMORY_USERPTR;
 			field = videobuf_next_field(&fh->cap);
-			if (0 != fh->cap.ops->buf_prepare(file->private_data,fh->cap.read_buf,field)) {
+			if (0 != fh->cap.ops->buf_prepare(&fh->cap,fh->cap.read_buf,field)) {
 				up(&fh->cap.lock);
 				return POLLERR;
 			}
-			fh->cap.ops->buf_queue(file->private_data,fh->cap.read_buf);
+			fh->cap.ops->buf_queue(&fh->cap,fh->cap.read_buf);
 			fh->cap.read_off = 0;
 		}
 		up(&fh->cap.lock);
@@ -2975,7 +2975,7 @@ static int bttv_release(struct inode *in
 		free_btres(btv,fh,RESOURCE_VIDEO);
 	}
 	if (fh->cap.read_buf) {
-		buffer_release(file->private_data,fh->cap.read_buf);
+		buffer_release(&fh->cap,fh->cap.read_buf);
 		kfree(fh->cap.read_buf);
 	}
 

-- 
#define printk(args...) fprintf(stderr, ## args)
