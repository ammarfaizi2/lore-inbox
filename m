Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVATPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVATPm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVATPlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:41:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17316 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262160AbVATPaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:30:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 16:26:06 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: video-buf update
Message-ID: <20050120152606.GA12908@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix a memory leak in video-buf.c
- Small update for the video-buf-dvb.c module.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/video-buf-dvb.c |   11 +++++++----
 drivers/media/video/video-buf.c     |    4 +++-
 include/media/video-buf-dvb.h       |    4 +++-
 3 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-2.6.10/drivers/media/video/video-buf.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/video-buf.c	2004-12-29 23:56:51.000000000 +0100
+++ linux-2.6.10/drivers/media/video/video-buf.c	2005-01-07 16:46:42.650627658 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: video-buf.c,v 1.15 2004/11/07 14:45:00 kraxel Exp $
+ * $Id: video-buf.c,v 1.17 2004/12/10 12:33:40 kraxel Exp $
  *
  * generic helper functions for video4linux capture buffers, to handle
  * memory management and PCI DMA.  Right now bttv + saa7134 use it.
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -892,6 +893,7 @@ void videobuf_read_stop(struct videobuf_
 	int i;
 
 	videobuf_queue_cancel(q);
+	videobuf_mmap_free(q);
 	INIT_LIST_HEAD(&q->stream);
 	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
 		if (NULL == q->bufs[i])
Index: linux-2.6.10/drivers/media/video/video-buf-dvb.c
===================================================================
--- linux-2.6.10.orig/drivers/media/video/video-buf-dvb.c	2004-12-29 23:55:09.000000000 +0100
+++ linux-2.6.10/drivers/media/video/video-buf-dvb.c	2005-01-07 16:41:25.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: video-buf-dvb.c,v 1.5 2004/11/07 13:17:15 kraxel Exp $
+ * $Id: video-buf-dvb.c,v 1.7 2004/12/09 12:51:35 kraxel Exp $
  *
  * some helper function for simple DVB cards which simply DMA the
  * complete transport stream and let the computer sort everything else
@@ -35,7 +35,7 @@ module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug,"enable debug messages");
 
 #define dprintk(fmt, arg...)	if (debug)			\
-	printk(KERN_DEBUG "%s/dvb: " fmt, dvb->name, ## arg)
+	printk(KERN_DEBUG "%s/dvb: " fmt, dvb->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 
@@ -134,19 +134,22 @@ static int videobuf_dvb_stop_feed(struct
 
 /* ------------------------------------------------------------------ */
 
-int videobuf_dvb_register(struct videobuf_dvb *dvb)
+int videobuf_dvb_register(struct videobuf_dvb *dvb,
+			  struct module *module,
+			  void *adapter_priv)
 {
 	int result;
 
 	init_MUTEX(&dvb->lock);
 
 	/* register adapter */
-	result = dvb_register_adapter(&dvb->adapter, dvb->name, THIS_MODULE);
+	result = dvb_register_adapter(&dvb->adapter, dvb->name, module);
 	if (result < 0) {
 		printk(KERN_WARNING "%s: dvb_register_adapter failed (errno = %d)\n",
 		       dvb->name, result);
 		goto fail_adapter;
 	}
+	dvb->adapter->priv = adapter_priv;
 
 	/* register frontend */
 	result = dvb_register_frontend(dvb->adapter, dvb->frontend);
Index: linux-2.6.10/include/media/video-buf-dvb.h
===================================================================
--- linux-2.6.10.orig/include/media/video-buf-dvb.h	2004-12-29 23:58:34.000000000 +0100
+++ linux-2.6.10/include/media/video-buf-dvb.h	2005-01-07 16:41:25.000000000 +0100
@@ -24,7 +24,9 @@ struct videobuf_dvb {
 	struct dvb_net             net;
 };
 
-int videobuf_dvb_register(struct videobuf_dvb *dvb);
+int videobuf_dvb_register(struct videobuf_dvb *dvb,
+			  struct module *module,
+			  void *adapter_priv);
 void videobuf_dvb_unregister(struct videobuf_dvb *dvb);
 
 /*

-- 
#define printk(args...) fprintf(stderr, ## args)
