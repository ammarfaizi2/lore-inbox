Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbUKHJWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUKHJWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKHJWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:22:00 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18654 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261796AbUKHJAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:32 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:51:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 2/6] v4l: add video-buf-dvb.c
Message-ID: <20041108085140.GA19213@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new helper module for simple dvb budget cards without hardware
filtering capabilities (which just pass the complete transport stream
via DMA and let the dvb core sort everything else).  Will initially be
used by saa7134 + cx88 drivers.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/Kconfig               |    3 
 drivers/media/video/Makefile        |    3 
 drivers/media/video/video-buf-dvb.c |  248 ++++++++++++++++++++++++++++
 include/media/video-buf-dvb.h       |   34 +++
 4 files changed, 288 insertions(+)

Index: linux-2004-11-05/include/media/video-buf-dvb.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2004-11-05/include/media/video-buf-dvb.h	2004-11-07 15:48:49.571689840 +0100
@@ -0,0 +1,34 @@
+#include <dvbdev.h>
+#include <dmxdev.h>
+#include <dvb_demux.h>
+#include <dvb_net.h>
+#include <dvb_frontend.h>
+
+struct videobuf_dvb {
+	/* filling that the job of the driver */
+	char                       *name;
+	struct dvb_frontend        *frontend;
+	struct videobuf_queue      dvbq;
+
+	/* video-buf-dvb state info */
+	struct semaphore           lock;
+	struct task_struct         *thread;
+	int                        nfeeds;
+
+	/* videobuf_dvb_(un)register manges this */
+	struct dvb_adapter         *adapter;
+	struct dvb_demux           demux;
+	struct dmxdev              dmxdev;
+	struct dmx_frontend        fe_hw;
+	struct dmx_frontend        fe_mem;
+	struct dvb_net             net;
+};
+
+int videobuf_dvb_register(struct videobuf_dvb *dvb);
+void videobuf_dvb_unregister(struct videobuf_dvb *dvb);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
Index: linux-2004-11-05/drivers/media/video/video-buf-dvb.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2004-11-05/drivers/media/video/video-buf-dvb.c	2004-11-07 15:48:49.571689840 +0100
@@ -0,0 +1,248 @@
+/*
+ * $Id: video-buf-dvb.c,v 1.5 2004/11/07 13:17:15 kraxel Exp $
+ *
+ * some helper function for simple DVB cards which simply DMA the
+ * complete transport stream and let the computer sort everything else
+ * (i.e. we are using the software demux, ...).  Also uses the
+ * video-buf to manage DMA buffers.
+ *
+ * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SUSE Labs]
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kthread.h>
+#include <linux/file.h>
+#include <linux/suspend.h>
+
+#include <media/video-buf.h>
+#include <media/video-buf-dvb.h>
+
+/* ------------------------------------------------------------------ */
+
+MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
+MODULE_LICENSE("GPL");
+
+static unsigned int debug = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug,"enable debug messages");
+
+#define dprintk(fmt, arg...)	if (debug)			\
+	printk(KERN_DEBUG "%s/dvb: " fmt, dvb->name, ## arg)
+
+/* ------------------------------------------------------------------ */
+
+static int videobuf_dvb_thread(void *data)
+{
+	struct videobuf_dvb *dvb = data;
+	struct videobuf_buffer *buf;
+	unsigned long flags;
+	int err;
+
+	dprintk("dvb thread started\n");
+	videobuf_read_start(&dvb->dvbq);
+
+	for (;;) {
+		/* fetch next buffer */
+		buf = list_entry(dvb->dvbq.stream.next,
+				 struct videobuf_buffer, stream);
+		list_del(&buf->stream);
+		err = videobuf_waiton(buf,0,1);
+		BUG_ON(0 != err);
+
+		/* no more feeds left or stop_feed() asked us to quit */
+		if (0 == dvb->nfeeds)
+			break;
+		if (kthread_should_stop())
+			break;
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		/* feed buffer data to demux */
+		if (buf->state == STATE_DONE)
+			dvb_dmx_swfilter(&dvb->demux, buf->dma.vmalloc,
+					 buf->size);
+
+		/* requeue buffer */
+		list_add_tail(&buf->stream,&dvb->dvbq.stream);
+		spin_lock_irqsave(dvb->dvbq.irqlock,flags);
+		dvb->dvbq.ops->buf_queue(&dvb->dvbq,buf);
+		spin_unlock_irqrestore(dvb->dvbq.irqlock,flags);
+	}
+
+	videobuf_read_stop(&dvb->dvbq);
+	dprintk("dvb thread stopped\n");
+
+	/* Hmm, linux becomes *very* unhappy without this ... */
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+	}
+	return 0;
+}
+
+static int videobuf_dvb_start_feed(struct dvb_demux_feed *feed)
+{
+	struct dvb_demux *demux  = feed->demux;
+	struct videobuf_dvb *dvb = demux->priv;
+	int rc;
+
+	if (!demux->dmx.frontend)
+		return -EINVAL;
+
+	down(&dvb->lock);
+	dvb->nfeeds++;
+	rc = dvb->nfeeds;
+
+	if (NULL != dvb->thread)
+		goto out;
+	dvb->thread = kthread_run(videobuf_dvb_thread,
+				  dvb, "%s dvb", dvb->name);
+	if (IS_ERR(dvb->thread)) {
+		rc = PTR_ERR(dvb->thread);
+		dvb->thread = NULL;
+	}
+
+out:
+	up(&dvb->lock);
+	return rc;
+}
+
+static int videobuf_dvb_stop_feed(struct dvb_demux_feed *feed)
+{
+	struct dvb_demux *demux  = feed->demux;
+	struct videobuf_dvb *dvb = demux->priv;
+	int err = 0;
+
+	down(&dvb->lock);
+	dvb->nfeeds--;
+	if (0 == dvb->nfeeds  &&  NULL != dvb->thread) {
+		// FIXME: cx8802_cancel_buffers(dev);
+		err = kthread_stop(dvb->thread);
+		dvb->thread = NULL;
+	}
+	up(&dvb->lock);
+	return err;
+}
+
+/* ------------------------------------------------------------------ */
+
+int videobuf_dvb_register(struct videobuf_dvb *dvb)
+{
+	int result;
+
+	init_MUTEX(&dvb->lock);
+
+	/* register adapter */
+	result = dvb_register_adapter(&dvb->adapter, dvb->name, THIS_MODULE);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: dvb_register_adapter failed (errno = %d)\n",
+		       dvb->name, result);
+		goto fail_adapter;
+	}
+
+	/* register frontend */
+	result = dvb_register_frontend(dvb->adapter, dvb->frontend);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: dvb_register_frontend failed (errno = %d)\n",
+		       dvb->name, result);
+		goto fail_frontend;
+	}
+
+	/* register demux stuff */
+	dvb->demux.dmx.capabilities =
+		DMX_TS_FILTERING | DMX_SECTION_FILTERING |
+		DMX_MEMORY_BASED_FILTERING;
+	dvb->demux.priv       = dvb;
+	dvb->demux.filternum  = 256;
+	dvb->demux.feednum    = 256;
+	dvb->demux.start_feed = videobuf_dvb_start_feed;
+	dvb->demux.stop_feed  = videobuf_dvb_stop_feed;
+	result = dvb_dmx_init(&dvb->demux);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: dvb_dmx_init failed (errno = %d)\n",
+		       dvb->name, result);
+		goto fail_dmx;
+	}
+
+	dvb->dmxdev.filternum    = 256;
+	dvb->dmxdev.demux        = &dvb->demux.dmx;
+	dvb->dmxdev.capabilities = 0;
+	result = dvb_dmxdev_init(&dvb->dmxdev, dvb->adapter);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: dvb_dmxdev_init failed (errno = %d)\n",
+		       dvb->name, result);
+		goto fail_dmxdev;
+	}
+
+	dvb->fe_hw.source = DMX_FRONTEND_0;
+	result = dvb->demux.dmx.add_frontend(&dvb->demux.dmx, &dvb->fe_hw);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: add_frontend failed (DMX_FRONTEND_0, errno = %d)\n",
+		       dvb->name, result);
+		goto fail_fe_hw;
+	}
+
+	dvb->fe_mem.source = DMX_MEMORY_FE;
+	result = dvb->demux.dmx.add_frontend(&dvb->demux.dmx, &dvb->fe_mem);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: add_frontend failed (DMX_MEMORY_FE, errno = %d)\n",
+		       dvb->name, result);
+		goto fail_fe_mem;
+	}
+
+	result = dvb->demux.dmx.connect_frontend(&dvb->demux.dmx, &dvb->fe_hw);
+	if (result < 0) {
+		printk(KERN_WARNING "%s: connect_frontend failed (errno = %d)\n",
+		       dvb->name, result);
+		goto fail_fe_conn;
+	}
+
+	/* register network adapter */
+	dvb_net_init(dvb->adapter, &dvb->net, &dvb->demux.dmx);
+	return 0;
+
+fail_fe_conn:
+	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_mem);
+fail_fe_mem:
+	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_hw);
+fail_fe_hw:
+	dvb_dmxdev_release(&dvb->dmxdev);
+fail_dmxdev:
+	dvb_dmx_release(&dvb->demux);
+fail_dmx:
+	dvb_unregister_frontend(dvb->frontend);
+fail_frontend:
+	dvb_unregister_adapter(dvb->adapter);
+fail_adapter:
+	return result;
+}
+
+void videobuf_dvb_unregister(struct videobuf_dvb *dvb)
+{
+	dvb_net_release(&dvb->net);
+	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_mem);
+	dvb->demux.dmx.remove_frontend(&dvb->demux.dmx, &dvb->fe_hw);
+	dvb_dmxdev_release(&dvb->dmxdev);
+	dvb_dmx_release(&dvb->demux);
+	dvb_unregister_frontend(dvb->frontend);
+	dvb_unregister_adapter(dvb->adapter);
+}
+
+EXPORT_SYMBOL(videobuf_dvb_register);
+EXPORT_SYMBOL(videobuf_dvb_unregister);
+
+/* ------------------------------------------------------------------ */
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * compile-command: "make DVB=1"
+ * End:
+ */
Index: linux-2004-11-05/drivers/media/Kconfig
===================================================================
--- linux-2004-11-05.orig/drivers/media/Kconfig	2004-11-07 12:24:43.000000000 +0100
+++ linux-2004-11-05/drivers/media/Kconfig	2004-11-07 15:48:20.164221455 +0100
@@ -38,6 +38,9 @@ config VIDEO_TUNER
 config VIDEO_BUF
 	tristate
 
+config VIDEO_BUF_DVB
+	tristate
+
 config VIDEO_BTCX
 	tristate
 
Index: linux-2004-11-05/drivers/media/video/Makefile
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/Makefile	2004-11-07 12:22:21.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/Makefile	2004-11-07 15:48:20.164221455 +0100
@@ -46,6 +46,9 @@ obj-$(CONFIG_TUNER_3036) += tuner-3036.o
 
 obj-$(CONFIG_VIDEO_TUNER) += tuner.o tda9887.o
 obj-$(CONFIG_VIDEO_BUF)   += video-buf.o
+obj-$(CONFIG_VIDEO_BUF_DVB) += video-buf-dvb.o
 obj-$(CONFIG_VIDEO_BTCX)  += btcx-risc.o
 
 obj-$(CONFIG_VIDEO_M32R_AR_M64278) += arv.o
+
+EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core

-- 
#define printk(args...) fprintf(stderr, ## args)
