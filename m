Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbUKHJVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbUKHJVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKHJVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:21:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18398 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261795AbUKHJAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:31 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:52:43 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 4/6] v4l: saa7134 update
Message-ID: <20041108085243.GA19262@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a update for the saa7134 driver, changes:

 * adapt to the video-buf changes.
 * add new cards.
 * split mpeg encoder card support to separare module
   (saa7134-empress), as preparation for the dvb support
   which also uses the MPEG capabilities of the card.
 * started working on dvb support (not functional yet, also
   marked 'BROKEN').
 * convert insmod options to new-style.

The patch also removes all trailing whitespaces.  I've a script to
remove them from my sources now, that should kill those no-op
whitespace changes in my patches after merging this initial cleanup.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/Kconfig                   |    7 
 drivers/media/video/saa7134/Makefile          |    6 
 drivers/media/video/saa7134/saa6752hs.c       |   94 ++--
 drivers/media/video/saa7134/saa7134-cards.c   |  124 +++++
 drivers/media/video/saa7134/saa7134-core.c    |  253 +++++++----
 drivers/media/video/saa7134/saa7134-dvb.c     |   91 ++++
 drivers/media/video/saa7134/saa7134-empress.c |  394 ++++++++++++++++++
 drivers/media/video/saa7134/saa7134-i2c.c     |   32 +
 drivers/media/video/saa7134/saa7134-input.c   |   13 
 drivers/media/video/saa7134/saa7134-oss.c     |   26 -
 drivers/media/video/saa7134/saa7134-ts.c      |  365 +---------------
 drivers/media/video/saa7134/saa7134-tvaudio.c |   47 +-
 drivers/media/video/saa7134/saa7134-vbi.c     |   37 -
 drivers/media/video/saa7134/saa7134-video.c   |  148 +++---
 drivers/media/video/saa7134/saa7134.h         |   83 ++-
 include/media/saa6752hs.h                     |    6 
 16 files changed, 1073 insertions(+), 653 deletions(-)

Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134.h
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134.h	2004-11-07 12:23:35.088406304 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134.h	2004-11-07 15:55:19.393371433 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134.h,v 1.20 2004/09/30 12:21:15 kraxel Exp $
+ * $Id: saa7134.h,v 1.27 2004/11/04 11:03:52 kraxel Exp $
  *
  * v4l2 device driver for philips saa7134 based TV cards
  *
@@ -31,11 +31,12 @@
 
 #include <asm/io.h>
 
-#include <media/video-buf.h>
 #include <media/tuner.h>
 #include <media/audiochip.h>
 #include <media/id.h>
 #include <media/ir-common.h>
+#include <media/video-buf.h>
+#include <media/video-buf-dvb.h>
 
 #ifndef TRUE
 # define TRUE (1==1)
@@ -164,8 +165,12 @@ struct saa7134_format {
 #define SAA7134_BOARD_VIDEOMATE_TV_GOLD_PLUS 41
 #define SAA7134_BOARD_SABRENT_SBTTVFM  42
 #define SAA7134_BOARD_ZOLID_XPERT_TV7134 43
-#define SAA7134_EMPIRE_PCI_TV_RADIO_LE 44
+#define SAA7134_BOARD_EMPIRE_PCI_TV_RADIO_LE 44
+#define SAA7134_BOARD_AVERMEDIA_307    45
+#define SAA7134_BOARD_AVERMEDIA_CARDBUS 46
+#define SAA7134_BOARD_CINERGY400_CARDBUS 47
 
+#define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
 
 struct saa7134_input {
@@ -176,6 +181,12 @@ struct saa7134_input {
 	unsigned int            tv:1;
 };
 
+enum saa7134_mpeg_type {
+	SAA7134_MPEG_UNUSED,
+	SAA7134_MPEG_EMPRESS,
+	SAA7134_MPEG_DVB,
+};
+
 struct saa7134_board {
 	char                    *name;
 	unsigned int            audio_clock;
@@ -185,18 +196,20 @@ struct saa7134_board {
 	struct saa7134_input    inputs[SAA7134_INPUT_MAX];
 	struct saa7134_input    radio;
 	struct saa7134_input    mute;
-	
-	/* peripheral I/O */
-	unsigned int            has_ts;
-	enum saa7134_video_out  video_out;
 
 	/* i2c chip info */
 	unsigned int            tuner_type;
 	unsigned int            tda9887_conf;
+
+	/* peripheral I/O */
+	enum saa7134_video_out  video_out;
+	enum saa7134_mpeg_type  mpeg;
 };
 
 #define card_has_radio(dev)   (NULL != saa7134_boards[dev->board].radio.name)
-#define card_has_ts(dev)      (saa7134_boards[dev->board].has_ts)
+#define card_is_empress(dev)  (SAA7134_MPEG_EMPRESS == saa7134_boards[dev->board].mpeg)
+#define card_is_dvb(dev)      (SAA7134_MPEG_DVB     == saa7134_boards[dev->board].mpeg)
+#define card_has_mpeg(dev)    (SAA7134_MPEG_UNUSED  != saa7134_boards[dev->board].mpeg)
 #define card(dev)             (saa7134_boards[dev->board])
 #define card_in(dev,n)        (saa7134_boards[dev->board].inputs[n])
 
@@ -264,7 +277,7 @@ struct saa7134_fh {
 	unsigned int               radio;
 	enum v4l2_buf_type         type;
 	unsigned int               resources;
-#ifdef VIDIOC_G_PRIORITY 
+#ifdef VIDIOC_G_PRIORITY
 	enum v4l2_priority	   prio;
 #endif
 
@@ -284,16 +297,6 @@ struct saa7134_fh {
 	struct saa7134_pgtable     pt_vbi;
 };
 
-/* TS status */
-struct saa7134_ts {
-	unsigned int               users;
-
-	/* TS capture */
-	struct videobuf_queue      ts;
-	struct saa7134_pgtable     pt_ts;
-	int			   started;
-};
-
 /* oss dsp status */
 struct saa7134_oss {
         struct semaphore           lock;
@@ -338,23 +341,37 @@ struct saa7134_ir {
         struct timer_list          timer;
 };
 
+/* ts/mpeg status */
+struct saa7134_ts {
+	/* TS capture */
+	struct saa7134_pgtable     pt_ts;
+	int                        nr_packets;
+	int                        nr_bufs;
+};
+
+/* ts/mpeg ops */
+struct saa7134_mpeg_ops {
+	enum saa7134_mpeg_type     type;
+	struct list_head           next;
+	int                        (*init)(struct saa7134_dev *dev);
+	int                        (*fini)(struct saa7134_dev *dev);
+};
+
 /* global device status */
 struct saa7134_dev {
 	struct list_head           devlist;
         struct semaphore           lock;
        	spinlock_t                 slock;
-#ifdef VIDIOC_G_PRIORITY 
+#ifdef VIDIOC_G_PRIORITY
 	struct v4l2_prio_state     prio;
 #endif
 
 	/* various device info */
 	unsigned int               resources;
 	struct video_device        *video_dev;
-	struct video_device        *ts_dev;
 	struct video_device        *radio_dev;
 	struct video_device        *vbi_dev;
 	struct saa7134_oss         oss;
-	struct saa7134_ts          ts;
 
 	/* infrared remote */
 	int                        has_remote;
@@ -362,6 +379,7 @@ struct saa7134_dev {
 
 	/* pci i/o */
 	char                       name[32];
+	int                        nr;
 	struct pci_dev             *pci;
 	unsigned char              pci_rev,pci_lat;
 	__u32                      *lmmio;
@@ -386,7 +404,6 @@ struct saa7134_dev {
 
 	/* video+ts+vbi capture */
 	struct saa7134_dmaqueue    video_q;
-	struct saa7134_dmaqueue    ts_q;
 	struct saa7134_dmaqueue    vbi_q;
 	unsigned int               video_fieldcount;
 	unsigned int               vbi_fieldcount;
@@ -420,6 +437,19 @@ struct saa7134_dev {
 	struct saa7134_input       *hw_input;
 	unsigned int               hw_mute;
 	int                        last_carrier;
+
+	/* SAA7134_MPEG_* */
+	struct saa7134_ts          ts;
+	struct saa7134_dmaqueue    ts_q;
+	struct saa7134_mpeg_ops    *mops;
+
+	/* SAA7134_MPEG_EMPRESS only */
+	struct video_device        *empress_dev;
+	struct videobuf_queue      empress_tsq;
+	unsigned int               empress_users;
+
+	/* SAA7134_MPEG_DVB only */
+	struct videobuf_dvb        dvb;
 };
 
 /* ----------------------------------------------------------- */
@@ -512,11 +542,16 @@ void saa7134_irq_video_done(struct saa71
 /* ----------------------------------------------------------- */
 /* saa7134-ts.c                                                */
 
-extern struct video_device saa7134_ts_template;
+#define TS_PACKET_SIZE 188 /* TS packets 188 bytes */
+
+extern struct videobuf_queue_ops saa7134_ts_qops;
+
 int saa7134_ts_init1(struct saa7134_dev *dev);
 int saa7134_ts_fini(struct saa7134_dev *dev);
 void saa7134_irq_ts_done(struct saa7134_dev *dev, unsigned long status);
 
+int saa7134_ts_register(struct saa7134_mpeg_ops *ops);
+void saa7134_ts_unregister(struct saa7134_mpeg_ops *ops);
 
 /* ----------------------------------------------------------- */
 /* saa7134-vbi.c                                               */
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-core.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-core.c	2004-11-07 12:22:16.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-core.c	2004-11-07 15:55:19.394371245 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-core.c,v 1.10 2004/09/15 16:15:24 kraxel Exp $
+ * $Id: saa7134-core.c,v 1.15 2004/11/07 14:44:59 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * driver core
@@ -38,64 +38,56 @@ MODULE_DESCRIPTION("v4l2 driver module f
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
 MODULE_LICENSE("GPL");
 
-#define SAA7134_MAXBOARDS 8
-
 /* ------------------------------------------------------------------ */
 
 static unsigned int irq_debug = 0;
-MODULE_PARM(irq_debug,"i");
+module_param(irq_debug, int, 0644);
 MODULE_PARM_DESC(irq_debug,"enable debug messages [IRQ handler]");
 
 static unsigned int core_debug = 0;
-MODULE_PARM(core_debug,"i");
+module_param(core_debug, int, 0644);
 MODULE_PARM_DESC(core_debug,"enable debug messages [core]");
 
 static unsigned int gpio_tracking = 0;
-MODULE_PARM(gpio_tracking,"i");
+module_param(gpio_tracking, int, 0644);
 MODULE_PARM_DESC(gpio_tracking,"enable debug messages [gpio]");
 
-static unsigned int video_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(video_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(video_nr,"video device number");
-
-static unsigned int ts_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(ts_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(ts_nr,"ts device number");
-
-static unsigned int vbi_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(vbi_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(vbi_nr,"vbi device number");
-
-static unsigned int radio_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(radio_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(radio_nr,"radio device number");
-
 static unsigned int oss = 0;
-MODULE_PARM(oss,"i");
+module_param(oss, int, 0444);
 MODULE_PARM_DESC(oss,"register oss devices (default: no)");
 
-static unsigned int dsp_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(dsp_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(dsp_nr,"oss dsp device number");
-
-static unsigned int mixer_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(mixer_nr,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(mixer_nr,"oss mixer device number");
-
-static unsigned int tuner[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(tuner,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(tuner,"tuner type");
-
-static unsigned int card[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
-MODULE_PARM(card,"1-" __stringify(SAA7134_MAXBOARDS) "i");
-MODULE_PARM_DESC(card,"card type");
-
 static unsigned int latency = UNSET;
-MODULE_PARM(latency,"i");
+module_param(latency, int, 0444);
 MODULE_PARM_DESC(latency,"pci latency timer");
 
-struct list_head  saa7134_devlist;
-unsigned int      saa7134_devcount;
+static unsigned int video_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+static unsigned int vbi_nr[]   = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+static unsigned int radio_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+static unsigned int dsp_nr[]   = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+static unsigned int mixer_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+static unsigned int tuner[]    = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+static unsigned int card[]     = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+
+module_param_array(video_nr, int, NULL, 0444);
+module_param_array(vbi_nr,   int, NULL, 0444);
+module_param_array(radio_nr, int, NULL, 0444);
+module_param_array(dsp_nr,   int, NULL, 0444);
+module_param_array(mixer_nr, int, NULL, 0444);
+module_param_array(tuner,    int, NULL, 0444);
+module_param_array(card,     int, NULL, 0444);
+
+MODULE_PARM_DESC(video_nr, "video device number");
+MODULE_PARM_DESC(vbi_nr,   "vbi device number");
+MODULE_PARM_DESC(radio_nr, "radio device number");
+MODULE_PARM_DESC(dsp_nr,   "oss dsp device number");
+MODULE_PARM_DESC(mixer_nr, "oss mixer device number");
+MODULE_PARM_DESC(tuner,    "tuner type");
+MODULE_PARM_DESC(card,     "card type");
+
+static DECLARE_MUTEX(devlist_lock);
+LIST_HEAD(saa7134_devlist);
+static LIST_HEAD(mops_list);
+static unsigned int saa7134_devcount;
 
 #define dprintk(fmt, arg...)	if (core_debug) \
 	printk(KERN_DEBUG "%s/core: " fmt, dev->name , ## arg)
@@ -246,7 +238,7 @@ int saa7134_buffer_pages(int size)
 int saa7134_buffer_count(unsigned int size, unsigned int count)
 {
 	unsigned int maxcount;
-	
+
 	maxcount = 1024 / saa7134_buffer_pages(size);
 	if (count > maxcount)
 		count = maxcount;
@@ -273,7 +265,7 @@ int saa7134_pgtable_alloc(struct pci_dev
 {
         u32          *cpu;
         dma_addr_t   dma_addr;
-	
+
 	cpu = pci_alloc_consistent(pci, SAA7134_PGTABLE_SIZE, &dma_addr);
 	if (NULL == cpu)
 		return -ENOMEM;
@@ -330,7 +322,7 @@ int saa7134_buffer_queue(struct saa7134_
 #ifdef DEBUG_SPINLOCKS
 	BUG_ON(!spin_is_locked(&dev->slock));
 #endif
-	
+
 	dprintk("buffer_queue %p\n",buf);
 	if (NULL == q->curr) {
 		if (!q->need_two) {
@@ -360,7 +352,7 @@ void saa7134_buffer_finish(struct saa713
 	BUG_ON(!spin_is_locked(&dev->slock));
 #endif
 	dprintk("buffer_finish %p\n",q->curr);
-	
+
 	/* finish current buffer */
 	q->curr->vb.state = state;
 	do_gettimeofday(&q->curr->vb.ts);
@@ -483,7 +475,7 @@ int saa7134_set_dmabits(struct saa7134_d
 			SAA7134_IRQ1_INTE_RA2_1 |
 			SAA7134_IRQ1_INTE_RA2_0;
 	}
-	
+
 	/* set task conditions + field handling */
 	if (V4L2_FIELD_HAS_BOTH(cap) || V4L2_FIELD_HAS_BOTH(ov) || cap == ov) {
 		/* default config -- use full frames */
@@ -507,7 +499,7 @@ int saa7134_set_dmabits(struct saa7134_d
 		saa_writeb(SAA7134_FIELD_HANDLING(TASK_B),  0x01);
 		split = 1;
 	}
-	
+
 	/* irqs */
 	saa_writeb(SAA7134_REGION_ENABLE, task);
 	saa_writel(SAA7134_IRQ1,          irq);
@@ -541,7 +533,7 @@ static void print_irqstatus(struct saa71
 			    unsigned long report, unsigned long status)
 {
 	unsigned int i;
-	
+
 	printk(KERN_DEBUG "%s/irq[%d,%ld]: r=0x%lx s=0x%02lx",
 	       dev->name,loop,jiffies,report,status);
 	for (i = 0; i < IRQBITS; i++) {
@@ -596,7 +588,7 @@ static irqreturn_t saa7134_irq(int irq, 
 			saa7134_irq_vbi_done(dev,status);
 
 		if ((report & SAA7134_IRQ_REPORT_DONE_RA2) &&
-		    card_has_ts(dev))
+		    card_has_mpeg(dev))
 			saa7134_irq_ts_done(dev,status);
 
 		if ((report & SAA7134_IRQ_REPORT_DONE_RA3))
@@ -643,7 +635,7 @@ static int saa7134_hwinit1(struct saa713
 	saa7134_track_gpio(dev,"pre-init");
 	saa7134_video_init1(dev);
 	saa7134_vbi_init1(dev);
-	if (card_has_ts(dev))
+	if (card_has_mpeg(dev))
 		saa7134_ts_init1(dev);
 	saa7134_input_init1(dev);
 
@@ -654,11 +646,11 @@ static int saa7134_hwinit1(struct saa713
 		saa7134_oss_init1(dev);
 		break;
 	}
-	
+
 	/* RAM FIFO config */
 	saa_writel(SAA7134_FIFO_SIZE, 0x08070503);
 	saa_writel(SAA7134_THRESHOULD,0x02020202);
-	
+
 	/* enable audio + video processing */
 	saa_writel(SAA7134_MAIN_CTRL,
 		   SAA7134_MAIN_CTRL_VPLLE |
@@ -675,7 +667,7 @@ static int saa7134_hwinit1(struct saa713
 
 	/* set vertical line numbering start (vbi needs this) */
 	saa_writeb(SAA7134_SOURCE_TIMING2, 0x20);
-	
+
 	return 0;
 }
 
@@ -719,7 +711,7 @@ static int saa7134_hwfini(struct saa7134
 		saa7134_oss_fini(dev);
 		break;
 	}
-	if (card_has_ts(dev))
+	if (card_has_mpeg(dev))
 		saa7134_ts_fini(dev);
 	saa7134_input_fini(dev);
 	saa7134_vbi_fini(dev);
@@ -760,7 +752,7 @@ static struct video_device *vdev_init(st
 				      char *type)
 {
 	struct video_device *vfd;
-	
+
 	vfd = video_device_alloc();
 	if (NULL == vfd)
 		return NULL;
@@ -782,13 +774,6 @@ static void saa7134_unregister_video(str
 			video_device_release(dev->video_dev);
 		dev->video_dev = NULL;
 	}
-	if (dev->ts_dev) {
-		if (-1 != dev->ts_dev->minor)
-			video_unregister_device(dev->ts_dev);
-		else
-			video_device_release(dev->ts_dev);
-		dev->ts_dev = NULL;
-	}
 	if (dev->vbi_dev) {
 		if (-1 != dev->vbi_dev->minor)
 			video_unregister_device(dev->vbi_dev);
@@ -805,10 +790,38 @@ static void saa7134_unregister_video(str
 	}
 }
 
+static void mpeg_ops_attach(struct saa7134_mpeg_ops *ops,
+			    struct saa7134_dev *dev)
+{
+	int err;
+
+	if (NULL != dev->mops)
+		return;
+	if (saa7134_boards[dev->board].mpeg != ops->type)
+		return;
+	err = ops->init(dev);
+	if (0 != err)
+		return;
+	dev->mops = ops;
+}
+
+static void mpeg_ops_detach(struct saa7134_mpeg_ops *ops,
+			    struct saa7134_dev *dev)
+{
+	if (NULL == dev->mops)
+		return;
+	if (dev->mops != ops)
+		return;
+	dev->mops->fini(dev);
+	dev->mops = NULL;
+}
+
 static int __devinit saa7134_initdev(struct pci_dev *pci_dev,
 				     const struct pci_device_id *pci_id)
 {
 	struct saa7134_dev *dev;
+	struct list_head *item;
+	struct saa7134_mpeg_ops *mops;
 	int err;
 
 	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
@@ -822,7 +835,9 @@ static int __devinit saa7134_initdev(str
 		err = -EIO;
 		goto fail1;
 	}
-	sprintf(dev->name,"saa%x[%d]",pci_dev->device,saa7134_devcount);
+
+	dev->nr = saa7134_devcount;
+	sprintf(dev->name,"saa%x[%d]",pci_dev->device,dev->nr);
 
 	/* pci quirks */
 	if (pci_pci_problems) {
@@ -864,21 +879,21 @@ static int __devinit saa7134_initdev(str
 
 	/* board config */
 	dev->board = pci_id->driver_data;
-	if (card[saa7134_devcount] >= 0 &&
-	    card[saa7134_devcount] < saa7134_bcount)
-		dev->board = card[saa7134_devcount];
+	if (card[dev->nr] >= 0 &&
+	    card[dev->nr] < saa7134_bcount)
+		dev->board = card[dev->nr];
 	if (SAA7134_BOARD_NOAUTO == dev->board) {
 		must_configure_manually();
 		dev->board = SAA7134_BOARD_UNKNOWN;
 	}
 	dev->tuner_type   = saa7134_boards[dev->board].tuner_type;
 	dev->tda9887_conf = saa7134_boards[dev->board].tda9887_conf;
-	if (UNSET != tuner[saa7134_devcount])
-		dev->tuner_type = tuner[saa7134_devcount];
+	if (UNSET != tuner[dev->nr])
+		dev->tuner_type = tuner[dev->nr];
         printk(KERN_INFO "%s: subsystem: %04x:%04x, board: %s [card=%d,%s]\n",
 	       dev->name,pci_dev->subsystem_vendor,
 	       pci_dev->subsystem_device,saa7134_boards[dev->board].name,
-	       dev->board, card[saa7134_devcount] == dev->board ?
+	       dev->board, card[dev->nr] == dev->board ?
 	       "insmod option" : "autodetected");
 
 	/* get mmio */
@@ -925,17 +940,19 @@ static int __devinit saa7134_initdev(str
 		request_module("tuner");
 	if (dev->tda9887_conf)
 		request_module("tda9887");
-  	if (card_has_ts(dev))
+  	if (card_is_empress(dev)) {
+		request_module("saa7134-empress");
 		request_module("saa6752hs");
+	}
+  	if (card_is_dvb(dev))
+		request_module("saa7134-dvb");
 
-#ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_init(&dev->prio);
-#endif
 
 	/* register v4l devices */
 	dev->video_dev = vdev_init(dev,&saa7134_video_template,"video");
 	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
-				    video_nr[saa7134_devcount]);
+				    video_nr[dev->nr]);
 	if (err < 0) {
 		printk(KERN_INFO "%s: can't register video device\n",
 		       dev->name);
@@ -944,22 +961,9 @@ static int __devinit saa7134_initdev(str
 	printk(KERN_INFO "%s: registered device video%d [v4l2]\n",
 	       dev->name,dev->video_dev->minor & 0x1f);
 
-	if (card_has_ts(dev)) {
-		dev->ts_dev = vdev_init(dev,&saa7134_ts_template,"ts");
-		err = video_register_device(dev->ts_dev,VFL_TYPE_GRABBER,
-					    ts_nr[saa7134_devcount]);
-		if (err < 0) {
-			printk(KERN_INFO "%s: can't register video device\n",
-			       dev->name);
-			goto fail4;
-		}
-		printk(KERN_INFO "%s: registered device video%d [mpeg]\n",
-		       dev->name,dev->ts_dev->minor & 0x1f);
-	}
-	
 	dev->vbi_dev = vdev_init(dev,&saa7134_vbi_template,"vbi");
 	err = video_register_device(dev->vbi_dev,VFL_TYPE_VBI,
-				    vbi_nr[saa7134_devcount]);
+				    vbi_nr[dev->nr]);
 	if (err < 0)
 		goto fail4;
 	printk(KERN_INFO "%s: registered device vbi%d\n",
@@ -968,7 +972,7 @@ static int __devinit saa7134_initdev(str
 	if (card_has_radio(dev)) {
 		dev->radio_dev = vdev_init(dev,&saa7134_radio_template,"radio");
 		err = video_register_device(dev->radio_dev,VFL_TYPE_RADIO,
-					    radio_nr[saa7134_devcount]);
+					    radio_nr[dev->nr]);
 		if (err < 0)
 			goto fail4;
 		printk(KERN_INFO "%s: registered device radio%d\n",
@@ -983,16 +987,16 @@ static int __devinit saa7134_initdev(str
 		if (oss) {
 			err = dev->oss.minor_dsp =
 				register_sound_dsp(&saa7134_dsp_fops,
-						   dsp_nr[saa7134_devcount]);
+						   dsp_nr[dev->nr]);
 			if (err < 0) {
 				goto fail4;
 			}
 			printk(KERN_INFO "%s: registered device dsp%d\n",
 			       dev->name,dev->oss.minor_dsp >> 4);
-			
+
 			err = dev->oss.minor_mixer =
 				register_sound_mixer(&saa7134_mixer_fops,
-						     mixer_nr[saa7134_devcount]);
+						     mixer_nr[dev->nr]);
 			if (err < 0)
 				goto fail5;
 			printk(KERN_INFO "%s: registered device mixer%d\n",
@@ -1002,9 +1006,16 @@ static int __devinit saa7134_initdev(str
 	}
 
 	/* everything worked */
-	list_add_tail(&dev->devlist,&saa7134_devlist);
 	pci_set_drvdata(pci_dev,dev);
 	saa7134_devcount++;
+
+	down(&devlist_lock);
+	list_for_each(item,&mops_list) {
+		mops = list_entry(item, struct saa7134_mpeg_ops, next);
+		mpeg_ops_attach(mops, dev);
+	}
+	list_add_tail(&dev->devlist,&saa7134_devlist);
+	up(&devlist_lock);
 	return 0;
 
  fail5:
@@ -1034,6 +1045,8 @@ static int __devinit saa7134_initdev(str
 static void __devexit saa7134_finidev(struct pci_dev *pci_dev)
 {
         struct saa7134_dev *dev = pci_get_drvdata(pci_dev);
+	struct list_head *item;
+	struct saa7134_mpeg_ops *mops;
 
 	/* debugging ... */
 	if (irq_debug) {
@@ -1054,6 +1067,15 @@ static void __devexit saa7134_finidev(st
 	saa7134_hwfini(dev);
 
 	/* unregister */
+	down(&devlist_lock);
+	list_del(&dev->devlist);
+	list_for_each(item,&mops_list) {
+		mops = list_entry(item, struct saa7134_mpeg_ops, next);
+		mpeg_ops_detach(mops, dev);
+	}
+	up(&devlist_lock);
+	saa7134_devcount--;
+
 	saa7134_i2c_unregister(dev);
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:
@@ -1079,11 +1101,45 @@ static void __devexit saa7134_finidev(st
 	pci_set_drvdata(pci_dev, NULL);
 
 	/* free memory */
-	list_del(&dev->devlist);
-	saa7134_devcount--;
 	kfree(dev);
 }
 
+/* ----------------------------------------------------------- */
+
+int saa7134_ts_register(struct saa7134_mpeg_ops *ops)
+{
+	struct list_head *item;
+	struct saa7134_dev *dev;
+
+	down(&devlist_lock);
+	list_for_each(item,&saa7134_devlist) {
+		dev = list_entry(item, struct saa7134_dev, devlist);
+		mpeg_ops_attach(ops, dev);
+	}
+	list_add_tail(&ops->next,&mops_list);
+	up(&devlist_lock);
+	return 0;
+}
+
+void saa7134_ts_unregister(struct saa7134_mpeg_ops *ops)
+{
+	struct list_head *item;
+	struct saa7134_dev *dev;
+
+	down(&devlist_lock);
+	list_del(&ops->next);
+	list_for_each(item,&saa7134_devlist) {
+		dev = list_entry(item, struct saa7134_dev, devlist);
+		mpeg_ops_detach(ops, dev);
+	}
+	up(&devlist_lock);
+}
+
+EXPORT_SYMBOL(saa7134_ts_register);
+EXPORT_SYMBOL(saa7134_ts_unregister);
+
+/* ----------------------------------------------------------- */
+
 static struct pci_driver saa7134_pci_driver = {
         .name     = "saa7134",
         .id_table = saa7134_pci_tbl,
@@ -1114,6 +1170,13 @@ module_init(saa7134_init);
 module_exit(saa7134_fini);
 
 /* ----------------------------------------------------------- */
+
+EXPORT_SYMBOL(saa7134_print_ioctl);
+EXPORT_SYMBOL(saa7134_i2c_call_clients);
+EXPORT_SYMBOL(saa7134_devlist);
+EXPORT_SYMBOL(saa7134_boards);
+
+/* ----------------------------------------------------------- */
 /*
  * Local variables:
  * c-basic-offset: 8
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-cards.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-cards.c	2004-11-07 12:23:54.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-cards.c	2004-11-07 15:55:19.395371057 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-cards.c,v 1.27 2004/09/30 14:17:12 kraxel Exp $
+ * $Id: saa7134-cards.c,v 1.35 2004/11/07 14:44:59 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * card-specific stuff.
@@ -199,7 +199,7 @@ struct saa7134_board saa7134_boards[] = 
 			.name = name_radio,
 			.amux = LINE2,
 		},
-		.has_ts    = 1,
+		.mpeg      = SAA7134_MPEG_EMPRESS,
 		.video_out = CCIR656,
 	},
 	[SAA7134_BOARD_MONSTERTV] = {
@@ -323,7 +323,7 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE2,
 			.gpio = 0x20000,
 		},
-		.has_ts		= 1,
+		.mpeg           = SAA7134_MPEG_EMPRESS,
 		.video_out	= CCIR656,
 	},
 	[SAA7134_BOARD_CINERGY400] = {
@@ -628,7 +628,7 @@ struct saa7134_board saa7134_boards[] = 
 			.vmux = 8,
 			.amux = LINE1,
 		}},
-		.has_ts    = 1,
+		.mpeg      = SAA7134_MPEG_EMPRESS,
 		.video_out = CCIR656,
 	},
 	[SAA7134_BOARD_VIDEOMATE_TV] = {
@@ -752,7 +752,7 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE2,
 			.tv   = 1,
 		}},
-		.has_ts    = 1,
+		.mpeg      = SAA7134_MPEG_EMPRESS,
 		.video_out = CCIR656,
         },
         [SAA7134_BOARD_ASUSTEK_TVFM7133] = {
@@ -785,7 +785,7 @@ struct saa7134_board saa7134_boards[] = 
                 .name           = "Pinnacle PCTV Stereo (saa7134)",
                 .audio_clock    = 0x00187de7,
                 .tuner_type     = TUNER_MT2032,
-                .tda9887_conf   = TDA9887_PRESENT,
+                .tda9887_conf   = TDA9887_PRESENT | TDA9887_INTERCARRIER,
                 .inputs         = {{
                         .name = name_tv,
                         .vmux = 3,
@@ -838,7 +838,7 @@ struct saa7134_board saa7134_boards[] = 
 			.name = name_svideo,
 			.vmux = 8,
 			.amux = LINE1,
-		},{			
+		},{
 			.name = name_comp1,
 			.vmux = 1,
 			.amux = LINE1,
@@ -1075,7 +1075,6 @@ struct saa7134_board saa7134_boards[] = 
        			.name = name_tv,
 			.vmux = 1,
 			.amux = LINE2,
-			.gpio = 0x0000,
 			.tv   = 1,
                 },{
                         .name = name_comp1,
@@ -1174,7 +1173,7 @@ struct saa7134_board saa7134_boards[] = 
                         .tv   = 1,
                 }},
 	},
-	[SAA7134_EMPIRE_PCI_TV_RADIO_LE] = {
+	[SAA7134_BOARD_EMPIRE_PCI_TV_RADIO_LE] = {
 		/* "Matteo Az" <matte.az@nospam.libero.it> ;-) */
 		.name           = "Empire PCI TV-Radio LE",
 		.audio_clock    = 0x00187de7,
@@ -1208,6 +1207,77 @@ struct saa7134_board saa7134_boards[] = 
 			 .gpio =0x8000,
 		 }
 	},
+        [SAA7134_BOARD_AVERMEDIA_307] = {
+		/* Nickolay V. Shmyrev <nshmyrev@yandex.ru> */
+		.name           = "Avermedia AVerTV Studio 307",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.tda9887_conf   = TDA9887_PRESENT,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 0,
+			.amux = LINE2,
+		},{
+			.name = name_comp2,
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = TV,
+		},
+        },
+	[SAA7134_BOARD_AVERMEDIA_CARDBUS] = {
+		/* Jon Westgate <oryn@oryn.fsck.tv> */
+		.name           = "AVerMedia Cardbus TV/Radio",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = LINE2,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
+		}},
+		.radio = {
+                	.name = name_radio,
+			.amux = LINE1,
+		},
+	},
+	[SAA7134_BOARD_CINERGY400_CARDBUS] = {
+		.name           = "Terratec Cinergy 400 mobile",
+		.audio_clock    = 0x187de7,
+		.tuner_type     = UNSET /* not supported yet :/ */,
+		.inputs         = {{
+       			.name = name_tv,
+			.vmux = 5,
+			.tv   = 1,
+                },{
+                        .name = name_comp1,
+                        .vmux = 3,
+                        .amux = LINE1,
+                },{
+                        .name = name_svideo,
+                        .vmux = 4,
+                        .amux = LINE1,
+		}},
+	},
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
@@ -1253,6 +1323,12 @@ struct pci_device_id saa7134_pci_tbl[] =
                 .driver_data  = SAA7134_BOARD_CINERGY600,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = 0x153b,
+		.subdevice    = 0x1162,
+		.driver_data  = SAA7134_BOARD_CINERGY400_CARDBUS,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = 0x5168,
 		.subdevice    = 0x0138,
@@ -1384,6 +1460,13 @@ struct pci_device_id saa7134_pci_tbl[] =
                 .subdevice    = 0x10ff,
 		.driver_data  = SAA7134_BOARD_AVERMEDIA_DVD_EZMAKER,
         },{
+		/* AVerMedia CardBus */
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x1461, /* Avermedia Technologies Inc */
+                .subdevice    = 0xd6ee,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_CARDBUS,
+	},{
 		/* TransGear 3000TV */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
@@ -1399,6 +1482,12 @@ struct pci_device_id saa7134_pci_tbl[] =
         },{
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
                 .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x11bd,
+                .subdevice    = 0x002d, /* 300i DVB-T + PAL */
+                .driver_data  = SAA7134_BOARD_PINNACLE_PCTV_STEREO,
+        },{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
                 .subvendor    = 0x1019,
                 .subdevice    = 0x4cb4,
                 .driver_data  = SAA7134_BOARD_ECS_TVP3XP,
@@ -1427,7 +1516,14 @@ struct pci_device_id saa7134_pci_tbl[] =
                 .subvendor    = 0x185b,
                 .subdevice    = 0xc100,
 		.driver_data  = SAA7134_BOARD_VIDEOMATE_TV_PVR,
-		
+
+ 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+               .subvendor    = 0x1461, /* Avermedia Technologies Inc */
+               .subdevice    = 0x9715,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_307,
+
  	},{
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -1442,7 +1538,7 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0,
 		.driver_data  = SAA7134_BOARD_NOAUTO,
 	},{
-		
+
 		/* --- default catch --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
@@ -1544,6 +1640,7 @@ int saa7134_board_init1(struct saa7134_d
 	case SAA7134_BOARD_ECS_TVP3XP:
 	case SAA7134_BOARD_ECS_TVP3XP_4CB5:
 	case SAA7134_BOARD_MD2819:
+	case SAA7134_BOARD_AVERMEDIA_307:
 		dev->has_remote = 1;
 		break;
 	case SAA7134_BOARD_AVACSSMARTTV:
@@ -1555,6 +1652,11 @@ int saa7134_board_init1(struct saa7134_d
 		       "%s: you try the audio_clock_override=0x200000 insmod option.\n",
 		       dev->name,dev->name,dev->name);
 		break;
+	case SAA7134_BOARD_CINERGY400_CARDBUS:
+		/* power-up tuner chip */
+		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0x00040000, 0x00040000);
+		saa_andorl(SAA7134_GPIO_GPSTATUS0 >> 2, 0x00040000, 0x00000000);
+		break;
 	}
 	return 0;
 }
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-i2c.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-i2c.c	2004-11-07 12:21:44.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-i2c.c	2004-11-07 15:55:19.395371057 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-i2c.c,v 1.5 2004/10/06 17:30:51 kraxel Exp $
+ * $Id: saa7134-i2c.c,v 1.7 2004/11/07 13:17:15 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * i2c interface support
@@ -34,11 +34,11 @@
 /* ----------------------------------------------------------- */
 
 static unsigned int i2c_debug = 0;
-MODULE_PARM(i2c_debug,"i");
+module_param(i2c_debug, int, 0644);
 MODULE_PARM_DESC(i2c_debug,"enable debug messages [i2c]");
 
 static unsigned int i2c_scan = 0;
-MODULE_PARM(i2c_scan,"i");
+module_param(i2c_scan, int, 0444);
 MODULE_PARM_DESC(i2c_scan,"scan i2c bus at insmod time");
 
 #define d1printk if (1 == i2c_debug) printk
@@ -88,7 +88,7 @@ enum i2c_attr {
 static inline enum i2c_status i2c_get_status(struct saa7134_dev *dev)
 {
 	enum i2c_status status;
-	
+
 	status = saa_readb(SAA7134_I2C_ATTR_STATUS) & 0x0f;
 	d2printk(KERN_DEBUG "%s: i2c stat <= %s\n",dev->name,
 		 str_i2c_status[status]);
@@ -184,7 +184,7 @@ static int i2c_reset(struct saa7134_dev 
 
 	if (!i2c_is_idle(status))
 		return FALSE;
-	
+
 	i2c_set_attr(dev,NOP);
 	return TRUE;
 }
@@ -210,7 +210,7 @@ static inline int i2c_send_byte(struct s
 	saa_writel(SAA7134_I2C_ATTR_STATUS >> 2, dword);
 #endif
 	d2printk(KERN_DEBUG "%s: i2c data => 0x%x\n",dev->name,data);
-	
+
 	if (!i2c_is_busy_wait(dev))
 		return -EIO;
 	status = i2c_get_status(dev);
@@ -223,7 +223,7 @@ static inline int i2c_recv_byte(struct s
 {
 	enum i2c_status status;
 	unsigned char data;
-	
+
 	i2c_set_attr(dev,CONTINUE);
 	if (!i2c_is_busy_wait(dev))
 		return -EIO;
@@ -302,7 +302,7 @@ static int saa7134_i2c_xfer(struct i2c_a
 
 /* ----------------------------------------------------------- */
 
-static int algo_control(struct i2c_adapter *adapter, 
+static int algo_control(struct i2c_adapter *adapter,
 			unsigned int cmd, unsigned long arg)
 {
 	return 0;
@@ -313,6 +313,18 @@ static u32 functionality(struct i2c_adap
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
+#ifndef I2C_PEC
+static void inc_use(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void dec_use(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+#endif
+
 static int attach_inform(struct i2c_client *client)
 {
         struct saa7134_dev *dev = client->adapter->algo_data;
@@ -419,10 +431,10 @@ int saa7134_i2c_register(struct saa7134_
 	strcpy(dev->i2c_adap.name,dev->name);
 	dev->i2c_adap.algo_data = dev;
 	i2c_add_adapter(&dev->i2c_adap);
-	
+
 	dev->i2c_client = saa7134_client_template;
 	dev->i2c_client.adapter = &dev->i2c_adap;
-	
+
 	saa7134_i2c_eeprom(dev,dev->eedata,sizeof(dev->eedata));
 	if (i2c_scan)
 		do_i2c_scan(dev->name,&dev->i2c_client);
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-tvaudio.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-11-07 12:21:12.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-11-07 15:55:19.396370869 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-tvaudio.c,v 1.13 2004/09/22 11:47:11 kraxel Exp $
+ * $Id: saa7134-tvaudio.c,v 1.17 2004/11/07 13:17:15 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * tv audio decoder (fm stereo, nicam, ...)
@@ -36,18 +36,18 @@
 /* ------------------------------------------------------------------ */
 
 static unsigned int audio_debug = 0;
-MODULE_PARM(audio_debug,"i");
+module_param(audio_debug, int, 0644);
 MODULE_PARM_DESC(audio_debug,"enable debug messages [tv audio]");
 
 static unsigned int audio_ddep = 0;
-MODULE_PARM(audio_ddep,"i");
+module_param(audio_ddep, int, 0644);
 MODULE_PARM_DESC(audio_ddep,"audio ddep overwrite");
 
 static int audio_clock_override = UNSET;
-MODULE_PARM(audio_clock_override, "i");
+module_param(audio_clock_override, int, 0644);
 
 static int audio_clock_tweak = 0;
-MODULE_PARM(audio_clock_tweak, "i");
+module_param(audio_clock_tweak, int, 0644);
 MODULE_PARM_DESC(audio_clock_tweak, "Audio clock tick fine tuning for cards with audio crystal that's slightly off (range [-1024 .. 1024])");
 
 #define dprintk(fmt, arg...)	if (audio_debug) \
@@ -284,7 +284,7 @@ static void tvaudio_setmode(struct saa71
 	saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD1, (acpf & 0x00ff00) >> 8);
 	saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD2, (acpf & 0x030000) >> 16);
 	tvaudio_setcarrier(dev,audio->carr1,audio->carr2);
-	
+
 	switch (audio->mode) {
 	case TVAUDIO_FM_MONO:
 	case TVAUDIO_FM_BG_STEREO:
@@ -324,14 +324,21 @@ static void tvaudio_setmode(struct saa71
 static int tvaudio_sleep(struct saa7134_dev *dev, int timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	
+
 	add_wait_queue(&dev->thread.wq, &wait);
 	if (dev->thread.scan1 == dev->thread.scan2 && !dev->thread.shutdown) {
 		if (timeout < 0) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
-		} else
+		} else {
+#if 0
+			/* hmm, that one doesn't return on wakeup ... */
 			msleep_interruptible(timeout);
+#else
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(msecs_to_jiffies(timeout));
+#endif
+		}
 	}
 	remove_wait_queue(&dev->thread.wq, &wait);
 	return dev->thread.scan1 != dev->thread.scan2;
@@ -407,7 +414,7 @@ static int tvaudio_getstereo(struct saa7
 {
 	__u32 idp,nicam;
 	int retval = -1;
-	
+
 	switch (audio->mode) {
 	case TVAUDIO_FM_MONO:
 		return V4L2_TUNER_SUB_MONO;
@@ -644,7 +651,7 @@ static char *stdres[0x20] = {
 	[0x09] = "D/K NICAM",
 	[0x0a] = "L NICAM",
 	[0x0b] = "I NICAM",
-	
+
 	[0x0c] = "M Korea",
 	[0x0d] = "M BTSC ",
 	[0x0e] = "M EIAJ",
@@ -739,7 +746,7 @@ static int mute_input_7133(struct saa713
 {
 	u32 reg = 0;
 	int mask;
-	
+
 	switch (dev->input->amux) {
 	case TV:    reg = 0x02; break;
 	case LINE1: reg = 0x00; break;
@@ -845,12 +852,12 @@ static int tvaudio_thread_ddep(void *dat
 			(value & 0x002000) ? " BTSC stereo noise mute " : "",
 			(value & 0x004000) ? " SAP noise mute "         : "",
 			(value & 0x008000) ? " VDSP "                   : "",
-			
+
 			(value & 0x010000) ? " NICST "                  : "",
 			(value & 0x020000) ? " NICDU "                  : "",
 			(value & 0x040000) ? " NICAM muted "            : "",
 			(value & 0x080000) ? " NICAM reserve sound "    : "",
-			
+
 			(value & 0x100000) ? " init done "              : "");
 	}
 
@@ -865,7 +872,7 @@ static int tvaudio_thread_ddep(void *dat
 int saa7134_tvaudio_rx2mode(u32 rx)
 {
 	u32 mode;
-	
+
 	mode = V4L2_TUNER_MODE_MONO;
 	if (rx & V4L2_TUNER_SUB_STEREO)
 		mode = V4L2_TUNER_MODE_STEREO;
@@ -875,7 +882,7 @@ int saa7134_tvaudio_rx2mode(u32 rx)
 		mode = V4L2_TUNER_MODE_LANG2;
 	return mode;
 }
-	
+
 void saa7134_tvaudio_setmute(struct saa7134_dev *dev)
 {
 	switch (dev->pci->device) {
@@ -940,14 +947,14 @@ int saa7134_tvaudio_init2(struct saa7134
 	int (*my_thread)(void *data) = NULL;
 
 	/* enable I2S audio output */
-	if (saa7134_boards[dev->board].has_ts) {
+	if (card_is_empress(dev)) {
 		int i2sform = (48000 == dev->oss.rate)
 			? 0x01 : 0x00;
-		
+
 		/* enable I2S output */
-		saa_writeb(SAA7134_I2S_OUTPUT_SELECT,  0x80); 
-		saa_writeb(SAA7134_I2S_OUTPUT_FORMAT,  i2sform); 
-		saa_writeb(SAA7134_I2S_OUTPUT_LEVEL,   0x0F);	
+		saa_writeb(SAA7134_I2S_OUTPUT_SELECT,  0x80);
+		saa_writeb(SAA7134_I2S_OUTPUT_FORMAT,  i2sform);
+		saa_writeb(SAA7134_I2S_OUTPUT_LEVEL,   0x0F);
 		saa_writeb(SAA7134_I2S_AUDIO_OUTPUT,   0x01);
 	}
 
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-video.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-video.c	2004-11-07 12:21:46.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-video.c	2004-11-07 15:55:19.398370493 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-video.c,v 1.15 2004/10/11 14:53:13 kraxel Exp $
+ * $Id: saa7134-video.c,v 1.19 2004/11/07 14:44:59 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
@@ -39,11 +39,11 @@ static unsigned int gbuffers      = 8;
 static unsigned int noninterlaced = 0;
 static unsigned int gbufsize      = 720*576*4;
 static unsigned int gbufsize_max  = 720*576*4;
-MODULE_PARM(video_debug,"i");
+module_param(video_debug, int, 0644);
 MODULE_PARM_DESC(video_debug,"enable debug messages [video]");
-MODULE_PARM(gbuffers,"i");
+module_param(gbuffers, int, 0444);
 MODULE_PARM_DESC(gbuffers,"number of capture buffers, range 2-32");
-MODULE_PARM(noninterlaced,"i");
+module_param(noninterlaced, int, 0644);
 MODULE_PARM_DESC(noninterlaced,"video input is noninterlaced");
 
 #define dprintk(fmt, arg...)	if (video_debug) \
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(noninterlaced,"video in
 static int video_out[][9] = {
 	[CCIR656] = { 0x00, 0xb1, 0x00, 0xa1, 0x00, 0x04, 0x06, 0x00, 0x00 },
 };
-		
+
 static struct saa7134_format formats[] = {
 	{
 		.name     = "8 bpp gray",
@@ -373,7 +373,7 @@ static const unsigned int CTRLS = ARRAY_
 static const struct v4l2_queryctrl* ctrl_by_id(unsigned int id)
 {
 	unsigned int i;
-	
+
 	for (i = 0; i < CTRLS; i++)
 		if (video_ctrls[i].id == id)
 			return video_ctrls+i;
@@ -482,12 +482,12 @@ static void set_tvnorm(struct saa7134_de
 	saa_writeb(SAA7134_HSYNC_START,           0xeb);
 	saa_writeb(SAA7134_HSYNC_STOP,            0xe0);
 	saa_writeb(SAA7134_SOURCE_TIMING1,        norm->src_timing);
-	
+
 	saa_writeb(SAA7134_SYNC_CTRL,             sync_control);
 	saa_writeb(SAA7134_LUMA_CTRL,             luma_control);
 	saa_writeb(SAA7134_DEC_LUMA_BRIGHT,       dev->ctl_bright);
 	saa_writeb(SAA7134_DEC_LUMA_CONTRAST,     dev->ctl_contrast);
- 
+
 	saa_writeb(SAA7134_DEC_CHROMA_SATURATION, dev->ctl_saturation);
 	saa_writeb(SAA7134_DEC_CHROMA_HUE,        dev->ctl_hue);
 	saa_writeb(SAA7134_CHROMA_CTRL1,          norm->chroma_ctrl1);
@@ -570,7 +570,7 @@ static void set_h_prescale(struct saa713
 static void set_v_scale(struct saa7134_dev *dev, int task, int yscale)
 {
 	int val,mirror;
-	
+
 	saa_writeb(SAA7134_V_SCALE_RATIO1(task), yscale &  0xff);
 	saa_writeb(SAA7134_V_SCALE_RATIO2(task), yscale >> 8);
 
@@ -624,7 +624,7 @@ static void set_size(struct saa7134_dev 
 	saa_writeb(SAA7134_H_SCALE_INC1(task),      xscale &  0xff);
 	saa_writeb(SAA7134_H_SCALE_INC2(task),      xscale >> 8);
 	set_v_scale(dev,task,yscale);
-	
+
 	saa_writeb(SAA7134_VIDEO_PIXELS1(task),     width  & 0xff);
 	saa_writeb(SAA7134_VIDEO_PIXELS2(task),     width  >> 8);
 	saa_writeb(SAA7134_VIDEO_LINES1(task),      height/div & 0xff);
@@ -651,7 +651,7 @@ static void sort_cliplist(struct cliplis
 {
 	struct cliplist swap;
 	int i,j,n;
-	
+
 	for (i = entries-2; i >= 0; i--) {
 		for (n = 0, j = 0; j <= i; j++) {
 			if (cl[j].position > cl[j+1].position) {
@@ -846,7 +846,7 @@ static int buffer_activate(struct saa713
 	dprintk("buffer_activate buf=%p\n",buf);
 	buf->vb.state = STATE_ACTIVE;
 	buf->top_seen = 0;
-	
+
 	set_size(dev,TASK_A,buf->vb.width,buf->vb.height,
 		 V4L2_FIELD_HAS_BOTH(buf->vb.field));
 	if (buf->fmt->yuv)
@@ -918,15 +918,16 @@ static int buffer_activate(struct saa713
 	return 0;
 }
 
-static int buffer_prepare(void *priv, struct videobuf_buffer *vb,
+static int buffer_prepare(struct videobuf_queue *q,
+			  struct videobuf_buffer *vb,
 			  enum v4l2_field field)
 {
-	struct saa7134_fh *fh = priv;
+	struct saa7134_fh *fh = q->priv_data;
 	struct saa7134_dev *dev = fh->dev;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
 	unsigned int size;
 	int err;
-	
+
 	/* sanity checks */
 	if (NULL == fh->fmt)
 		return -EINVAL;
@@ -980,9 +981,9 @@ static int buffer_prepare(void *priv, st
 }
 
 static int
-buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
-	struct saa7134_fh *fh = priv;
+	struct saa7134_fh *fh = q->priv_data;
 
 	*size = fh->fmt->depth * fh->width * fh->height >> 3;
 	if (0 == *count)
@@ -991,19 +992,19 @@ buffer_setup(void *priv, unsigned int *c
 	return 0;
 }
 
-static void buffer_queue(void *priv, struct videobuf_buffer *vb)
+static void buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct saa7134_fh *fh = priv;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	
+	struct saa7134_fh *fh = q->priv_data;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
+
 	saa7134_buffer_queue(fh->dev,&fh->dev->video_q,buf);
 }
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct saa7134_fh *fh = priv;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	
+	struct saa7134_fh *fh = q->priv_data;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
+
 	saa7134_dma_free(fh->dev,buf);
 }
 
@@ -1160,7 +1161,7 @@ static int set_control(struct saa7134_de
 static struct videobuf_queue* saa7134_queue(struct saa7134_fh *fh)
 {
 	struct videobuf_queue* q = NULL;
-	
+
 	switch (fh->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		q = &fh->cap;
@@ -1177,7 +1178,7 @@ static struct videobuf_queue* saa7134_qu
 static int saa7134_resource(struct saa7134_fh *fh)
 {
 	int res = 0;
-	
+
 	switch (fh->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		res = RESOURCE_VIDEO;
@@ -1199,7 +1200,7 @@ static int video_open(struct inode *inod
 	struct list_head *list;
 	enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	int radio = 0;
-	
+
 	list_for_each(list,&saa7134_devlist) {
 		h = list_entry(list, struct saa7134_dev, devlist);
 		if (h->video_dev && (h->video_dev->minor == minor))
@@ -1231,24 +1232,21 @@ static int video_open(struct inode *inod
 	fh->fmt      = format_by_fourcc(V4L2_PIX_FMT_BGR24);
 	fh->width    = 720;
 	fh->height   = 576;
-#ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_open(&dev->prio,&fh->prio);
-#endif
 
 	videobuf_queue_init(&fh->cap, &video_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_INTERLACED,
-			    sizeof(struct saa7134_buf));
-	init_MUTEX(&fh->cap.lock);
-	saa7134_pgtable_alloc(dev->pci,&fh->pt_cap);
-
+			    sizeof(struct saa7134_buf),
+			    fh);
 	videobuf_queue_init(&fh->vbi, &saa7134_vbi_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VBI_CAPTURE,
 			    V4L2_FIELD_SEQ_TB,
-			    sizeof(struct saa7134_buf));
-        init_MUTEX(&fh->vbi.lock);
+			    sizeof(struct saa7134_buf),
+			    fh);
+	saa7134_pgtable_alloc(dev->pci,&fh->pt_cap);
 	saa7134_pgtable_alloc(dev->pci,&fh->pt_vbi);
 
 	if (fh->radio) {
@@ -1271,13 +1269,13 @@ video_read(struct file *file, char __use
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		if (res_locked(fh->dev,RESOURCE_VIDEO))
 			return -EBUSY;
-		return videobuf_read_one(file->private_data, saa7134_queue(fh),
+		return videobuf_read_one(saa7134_queue(fh),
 					 data, count, ppos,
 					 file->f_flags & O_NONBLOCK);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		if (!res_get(fh->dev,fh,RESOURCE_VBI))
 			return -EBUSY;
-		return videobuf_read_stream(file->private_data, saa7134_queue(fh),
+		return videobuf_read_stream(saa7134_queue(fh),
 					    data, count, ppos, 1,
 					    file->f_flags & O_NONBLOCK);
 		break;
@@ -1294,8 +1292,7 @@ video_poll(struct file *file, struct pol
 	struct videobuf_buffer *buf = NULL;
 
 	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type)
-		return videobuf_poll_stream(file, file->private_data,
-					    &fh->vbi, wait);
+		return videobuf_poll_stream(file, &fh->vbi, wait);
 
 	if (res_check(fh,RESOURCE_VIDEO)) {
 		if (!list_empty(&fh->cap.stream))
@@ -1345,7 +1342,7 @@ static int video_release(struct inode *i
 
 	/* stop video capture */
 	if (res_check(fh, RESOURCE_VIDEO)) {
-		videobuf_streamoff(file->private_data,&fh->cap);
+		videobuf_streamoff(&fh->cap);
 		res_free(dev,fh,RESOURCE_VIDEO);
 	}
 	if (fh->cap.read_buf) {
@@ -1356,18 +1353,16 @@ static int video_release(struct inode *i
 	/* stop vbi capture */
 	if (res_check(fh, RESOURCE_VBI)) {
 		if (fh->vbi.streaming)
-			videobuf_streamoff(file->private_data,&fh->vbi);
+			videobuf_streamoff(&fh->vbi);
 		if (fh->vbi.reading)
-			videobuf_read_stop(file->private_data,&fh->vbi);
+			videobuf_read_stop(&fh->vbi);
 		res_free(dev,fh,RESOURCE_VBI);
 	}
 
 	saa7134_pgtable_free(dev->pci,&fh->pt_cap);
 	saa7134_pgtable_free(dev->pci,&fh->pt_vbi);
 
-#ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_close(&dev->prio,&fh->prio);
-#endif
 	file->private_data = NULL;
 	kfree(fh);
 	return 0;
@@ -1377,8 +1372,8 @@ static int
 video_mmap(struct file *file, struct vm_area_struct * vma)
 {
 	struct saa7134_fh *fh = file->private_data;
-	
-	return videobuf_mmap_mapper(vma,saa7134_queue(fh));
+
+	return videobuf_mmap_mapper(saa7134_queue(fh), vma);
 }
 
 /* ------------------------------------------------------------------ */
@@ -1436,7 +1431,7 @@ int saa7134_try_fmt(struct saa7134_dev *
 		    struct v4l2_format *f)
 {
 	int err;
-	
+
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	{
@@ -1451,7 +1446,7 @@ int saa7134_try_fmt(struct saa7134_dev *
 		field = f->fmt.pix.field;
 		maxw  = min(dev->crop_current.width*4,  dev->crop_bounds.width);
 		maxh  = min(dev->crop_current.height*4, dev->crop_bounds.height);
-		
+
 		if (V4L2_FIELD_ANY == field) {
 			field = (f->fmt.pix.height > maxh/2)
 				? V4L2_FIELD_INTERLACED
@@ -1481,7 +1476,7 @@ int saa7134_try_fmt(struct saa7134_dev *
 			(f->fmt.pix.width * fmt->depth) >> 3;
 		f->fmt.pix.sizeimage =
 			f->fmt.pix.height * f->fmt.pix.bytesperline;
-		
+
 		return 0;
 	}
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
@@ -1502,13 +1497,13 @@ int saa7134_s_fmt(struct saa7134_dev *de
 {
 	unsigned long flags;
 	int err;
-	
+
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		err = saa7134_try_fmt(dev,fh,f);
 		if (0 != err)
 			return err;
-			
+
 		fh->fmt       = format_by_fourcc(f->fmt.pix.pixelformat);
 		fh->width     = f->fmt.pix.width;
 		fh->height    = f->fmt.pix.height;
@@ -1550,7 +1545,7 @@ int saa7134_common_ioctl(struct saa7134_
 			 unsigned int cmd, void *arg)
 {
 	int err;
-	
+
 	switch (cmd) {
 	case VIDIOC_QUERYCTRL:
 	{
@@ -1617,7 +1612,7 @@ int saa7134_common_ioctl(struct saa7134_
 	case VIDIOC_S_INPUT:
 	{
 		int *i = arg;
-		
+
 		if (*i < 0  ||  *i >= SAA7134_INPUT_MAX)
 			return -EINVAL;
 		if (NULL == card_in(dev,*i).name)
@@ -1631,6 +1626,7 @@ int saa7134_common_ioctl(struct saa7134_
 	}
 	return 0;
 }
+EXPORT_SYMBOL(saa7134_common_ioctl);
 
 /*
  * This function is _not_ called directly, but from
@@ -1648,7 +1644,6 @@ static int video_do_ioctl(struct inode *
 	if (video_debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
 
-#ifdef VIDIOC_G_PRIORITY
 	switch (cmd) {
 	case VIDIOC_S_CTRL:
 	case VIDIOC_S_STD:
@@ -1659,13 +1654,12 @@ static int video_do_ioctl(struct inode *
 		if (0 != err)
 			return err;
 	}
-#endif
 
 	switch (cmd) {
 	case VIDIOC_QUERYCAP:
 	{
 		struct v4l2_capability *cap = arg;
-		
+
 		memset(cap,0,sizeof(*cap));
                 strcpy(cap->driver, "saa7134");
 		strlcpy(cap->card, saa7134_boards[dev->board].name,
@@ -1677,7 +1671,7 @@ static int video_do_ioctl(struct inode *
 			V4L2_CAP_VIDEO_OVERLAY |
 			V4L2_CAP_VBI_CAPTURE |
 			V4L2_CAP_TUNER |
-			V4L2_CAP_READWRITE | 
+			V4L2_CAP_READWRITE |
 			V4L2_CAP_STREAMING;
 		return 0;
 	}
@@ -1727,7 +1721,7 @@ static int video_do_ioctl(struct inode *
 			set_tvnorm(dev,&tvnorms[i]);
 			start_preview(dev,fh);
 			spin_unlock_irqrestore(&dev->slock,flags);
-		} else 
+		} else
 			set_tvnorm(dev,&tvnorms[i]);
 		saa7134_tvaudio_do_scan(dev);
 		up(&dev->lock);
@@ -1873,7 +1867,7 @@ static int video_do_ioctl(struct inode *
 		up(&dev->lock);
 		return 0;
 	}
-		
+
 	/* --- control ioctls ---------------------------------------- */
 	case VIDIOC_ENUMINPUT:
 	case VIDIOC_G_INPUT:
@@ -1900,7 +1894,6 @@ static int video_do_ioctl(struct inode *
                 return 0;
         }
 
-#ifdef VIDIOC_G_PRIORITY
         case VIDIOC_G_PRIORITY:
         {
                 enum v4l2_priority *p = arg;
@@ -1914,7 +1907,6 @@ static int video_do_ioctl(struct inode *
 
                 return v4l2_prio_change(&dev->prio, &fh->prio, *prio);
         }
-#endif
 
 	/* --- preview ioctls ---------------------------------------- */
 	case VIDIOC_ENUM_FMT:
@@ -1949,7 +1941,7 @@ static int video_do_ioctl(struct inode *
 			strcpy(f->description,"vbi data");
 			break;
 		default:
-			return -EINVAL;	
+			return -EINVAL;
 		}
 		return 0;
 	}
@@ -1965,7 +1957,7 @@ static int video_do_ioctl(struct inode *
 	{
 		struct v4l2_framebuffer *fb = arg;
 		struct saa7134_format *fmt;
-		
+
 		if(!capable(CAP_SYS_ADMIN) &&
 		   !capable(CAP_SYS_RAWIO))
 			return -EPERM;
@@ -2021,7 +2013,7 @@ static int video_do_ioctl(struct inode *
 		struct v4l2_format *f = arg;
 		return saa7134_try_fmt(dev,fh,f);
 	}
-	
+
 	case VIDIOCGMBUF:
 	{
 		struct video_mbuf *mbuf = arg;
@@ -2034,7 +2026,7 @@ static int video_do_ioctl(struct inode *
 		req.type   = q->type;
 		req.count  = gbuffers;
 		req.memory = V4L2_MEMORY_MMAP;
-		err = videobuf_reqbufs(file->private_data,q,&req);
+		err = videobuf_reqbufs(q,&req);
 		if (err < 0)
 			return err;
 		memset(mbuf,0,sizeof(*mbuf));
@@ -2047,16 +2039,16 @@ static int video_do_ioctl(struct inode *
 		return 0;
 	}
 	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(file->private_data,saa7134_queue(fh),arg);
+		return videobuf_reqbufs(saa7134_queue(fh),arg);
 
 	case VIDIOC_QUERYBUF:
 		return videobuf_querybuf(saa7134_queue(fh),arg);
 
 	case VIDIOC_QBUF:
-		return videobuf_qbuf(file->private_data,saa7134_queue(fh),arg);
+		return videobuf_qbuf(saa7134_queue(fh),arg);
 
 	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(file->private_data,saa7134_queue(fh),arg,
+		return videobuf_dqbuf(saa7134_queue(fh),arg,
 				      file->f_flags & O_NONBLOCK);
 
 	case VIDIOC_STREAMON:
@@ -2065,13 +2057,13 @@ static int video_do_ioctl(struct inode *
 
                 if (!res_get(dev,fh,res))
 			return -EBUSY;
-		return videobuf_streamon(file->private_data,saa7134_queue(fh));
+		return videobuf_streamon(saa7134_queue(fh));
 	}
 	case VIDIOC_STREAMOFF:
 	{
 		int res = saa7134_resource(fh);
 
-		err = videobuf_streamoff(file->private_data,saa7134_queue(fh));
+		err = videobuf_streamoff(saa7134_queue(fh));
 		if (err < 0)
 			return err;
 		res_free(dev,fh,res);
@@ -2096,7 +2088,7 @@ static int radio_do_ioctl(struct inode *
 {
 	struct saa7134_fh *fh = file->private_data;
 	struct saa7134_dev *dev = fh->dev;
-	
+
 	if (video_debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
 	switch (cmd) {
@@ -2140,7 +2132,7 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
-		
+
 		if (i->index != 0)
 			return -EINVAL;
 		strcpy(i->name,"Radio");
@@ -2194,7 +2186,7 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_G_FREQUENCY:
 	case VIDIOC_S_FREQUENCY:
 		return video_do_ioctl(inode,file,cmd,arg);
-		
+
 	default:
 		return v4l_compat_translate_ioctl(inode,file,cmd,arg,
 						  radio_do_ioctl);
@@ -2302,7 +2294,7 @@ int saa7134_video_init1(struct saa7134_d
 		saa_writeb(SAA7134_VIDEO_PORT_CTRL7, video_out[vo][7]);
 		saa_writeb(SAA7134_VIDEO_PORT_CTRL8, video_out[vo][8]);
 	}
- 
+
 	return 0;
 }
 
@@ -2330,7 +2322,7 @@ void saa7134_irq_video_intl(struct saa71
 
 	norm = saa_readb(SAA7134_STATUS_VIDEO1) & 0x03;
 	dprintk("DCSDT: %s\n",st[norm]);
-	
+
 	if (0 != norm) {
 		/* wake up tvaudio audio carrier scan thread */
 		saa7134_tvaudio_do_scan(dev);
@@ -2348,7 +2340,7 @@ void saa7134_irq_video_intl(struct saa71
 void saa7134_irq_video_done(struct saa7134_dev *dev, unsigned long status)
 {
 	enum v4l2_field field;
-	
+
 	spin_lock(&dev->slock);
 	if (dev->video_q.curr) {
 		dev->video_fieldcount++;
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-vbi.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-vbi.c	2004-11-07 12:24:10.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-vbi.c	2004-11-07 15:55:19.398370493 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-vbi.c,v 1.3 2004/09/23 13:58:19 kraxel Exp $
+ * $Id: saa7134-vbi.c,v 1.5 2004/11/07 13:17:15 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
@@ -33,11 +33,11 @@
 /* ------------------------------------------------------------------ */
 
 static unsigned int vbi_debug  = 0;
-MODULE_PARM(vbi_debug,"i");
+module_param(vbi_debug, int, 0644);
 MODULE_PARM_DESC(vbi_debug,"enable debug messages [vbi]");
 
 static unsigned int vbibufs = 4;
-MODULE_PARM(vbibufs,"i");
+module_param(vbibufs, int, 0444);
 MODULE_PARM_DESC(vbibufs,"number of vbi buffers, range 2-32");
 
 #define dprintk(fmt, arg...)	if (vbi_debug) \
@@ -53,7 +53,7 @@ static void task_init(struct saa7134_dev
 		      int task)
 {
 	struct saa7134_tvnorm *norm = dev->tvnorm;
-	
+
 	/* setup video scaler */
 	saa_writeb(SAA7134_VBI_H_START1(task), norm->h_start     &  0xff);
 	saa_writeb(SAA7134_VBI_H_START2(task), norm->h_start     >> 8);
@@ -115,12 +115,13 @@ static int buffer_activate(struct saa713
 	return 0;
 }
 
-static int buffer_prepare(void *priv, struct videobuf_buffer *vb,
+static int buffer_prepare(struct videobuf_queue *q,
+			  struct videobuf_buffer *vb,
 			  enum v4l2_field field)
 {
-	struct saa7134_fh *fh   = priv;
+	struct saa7134_fh *fh   = q->priv_data;
 	struct saa7134_dev *dev = fh->dev;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
 	struct saa7134_tvnorm *norm = dev->tvnorm;
 	unsigned int lines, llength, size;
 	int err;
@@ -169,12 +170,12 @@ static int buffer_prepare(void *priv, st
 }
 
 static int
-buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
-	struct saa7134_fh *fh   = priv;
+	struct saa7134_fh *fh   = q->priv_data;
 	struct saa7134_dev *dev = fh->dev;
 	int llength,lines;
-	
+
 	lines   = dev->tvnorm->vbi_v_stop - dev->tvnorm->vbi_v_start +1;
 #if 1
 	llength = VBI_LINE_LENGTH;
@@ -190,21 +191,21 @@ buffer_setup(void *priv, unsigned int *c
 	return 0;
 }
 
-static void buffer_queue(void *priv, struct videobuf_buffer *vb)
+static void buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct saa7134_fh *fh = priv;
+	struct saa7134_fh *fh = q->priv_data;
 	struct saa7134_dev *dev = fh->dev;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
+
 	saa7134_buffer_queue(dev,&dev->vbi_q,buf);
 }
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct saa7134_fh *fh   = priv;
+	struct saa7134_fh *fh   = q->priv_data;
 	struct saa7134_dev *dev = fh->dev;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
+
 	saa7134_dma_free(dev,buf);
 }
 
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-oss.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-oss.c	2004-11-07 12:22:46.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-oss.c	2004-11-07 15:55:19.399370304 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-oss.c,v 1.9 2004/09/15 16:15:24 kraxel Exp $
+ * $Id: saa7134-oss.c,v 1.11 2004/11/07 13:17:15 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * oss dsp interface
@@ -34,11 +34,11 @@
 /* ------------------------------------------------------------------ */
 
 static unsigned int oss_debug  = 0;
-MODULE_PARM(oss_debug,"i");
+module_param(oss_debug, int, 0644);
 MODULE_PARM_DESC(oss_debug,"enable debug messages [oss]");
 
 static unsigned int oss_rate  = 0;
-MODULE_PARM(oss_rate,"i");
+module_param(oss_rate, int, 0444);
 MODULE_PARM_DESC(oss_rate,"sample rate (valid are: 32000,48000)");
 
 #define dprintk(fmt, arg...)	if (oss_debug) \
@@ -140,7 +140,7 @@ static int dsp_rec_start(struct saa7134_
 	}
 
 	switch (dev->oss.afmt) {
-	case AFMT_S8:     
+	case AFMT_S8:
 	case AFMT_S16_LE:
 	case AFMT_S16_BE: sign = 1; break;
 	default:          sign = 0; break;
@@ -161,7 +161,7 @@ static int dsp_rec_start(struct saa7134_
 		if (sign)
 			fmt |= 0x04;
 		fmt |= (TV == dev->oss.input) ? 0xc0 : 0x80;
-		
+
 		saa_writeb(SAA7134_NUM_SAMPLES0, (dev->oss.blksize & 0x0000ff));
 		saa_writeb(SAA7134_NUM_SAMPLES1, (dev->oss.blksize & 0x00ff00) >>  8);
 		saa_writeb(SAA7134_NUM_SAMPLES2, (dev->oss.blksize & 0xff0000) >> 16);
@@ -193,7 +193,7 @@ static int dsp_rec_start(struct saa7134_
 	saa_writel(SAA7134_RS_BA2(6),dev->oss.blksize);
 	saa_writel(SAA7134_RS_PITCH(6),0);
 	saa_writel(SAA7134_RS_CONTROL(6),control);
-	
+
 	/* start dma */
 	dev->oss.recording_on = 1;
 	spin_lock_irqsave(&dev->slock,flags);
@@ -369,7 +369,7 @@ static int dsp_ioctl(struct inode *inode
 	void __user *argp = (void __user *) arg;
 	int __user *p = argp;
 	int val = 0;
-	
+
 	if (oss_debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
         switch (cmd) {
@@ -412,7 +412,7 @@ static int dsp_ioctl(struct inode *inode
 		/* fall through */
         case SOUND_PCM_READ_CHANNELS:
 		return put_user(dev->oss.channels, p);
-		
+
         case SNDCTL_DSP_GETFMTS: /* Returns a mask */
 		return put_user(AFMT_U8     | AFMT_S8     |
 				AFMT_U16_LE | AFMT_U16_BE |
@@ -535,7 +535,7 @@ static int
 mixer_recsrc_7134(struct saa7134_dev *dev)
 {
 	int analog_io,rate;
-	
+
 	switch (dev->oss.input) {
 	case TV:
 		saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, 0xc0);
@@ -557,7 +557,7 @@ static int
 mixer_recsrc_7133(struct saa7134_dev *dev)
 {
 	u32 value = 0xbbbbbb;
-	
+
 	switch (dev->oss.input) {
 	case TV:
 		value = 0xbbbb10;  /* MAIN */
@@ -655,7 +655,7 @@ static int mixer_ioctl(struct inode *ino
 	int val,ret;
 	void __user *argp = (void __user *) arg;
 	int __user *p = argp;
-	
+
 	if (oss_debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
         switch (cmd) {
@@ -786,7 +786,7 @@ int saa7134_oss_init1(struct saa7134_dev
 	mixer_level(dev,LINE1,dev->oss.line1);
 	mixer_level(dev,LINE2,dev->oss.line2);
 	mixer_recsrc(dev, (dev->oss.rate == 32000) ? TV : LINE2);
-	
+
 	return 0;
 }
 
@@ -840,7 +840,7 @@ void saa7134_irq_oss_done(struct saa7134
 	dev->oss.dma_blk = (dev->oss.dma_blk + 1) % dev->oss.blocks;
 	dev->oss.read_count += dev->oss.blksize;
 	wake_up(&dev->oss.wq);
-	
+
  done:
 	spin_unlock(&dev->slock);
 }
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-ts.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-ts.c	2004-11-07 12:21:20.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-ts.c	2004-11-07 15:55:19.399370304 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-ts.c,v 1.9 2004/10/11 14:53:13 kraxel Exp $
+ * $Id: saa7134-ts.c,v 1.12 2004/11/07 13:17:15 kraxel Exp $
  *
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
@@ -31,24 +31,12 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
-#include <media/saa6752hs.h>
-
 /* ------------------------------------------------------------------ */
 
-#define TS_PACKET_SIZE 188 /* TS packets 188 bytes */
-
 static unsigned int ts_debug  = 0;
-MODULE_PARM(ts_debug,"i");
+module_param(ts_debug, int, 0644);
 MODULE_PARM_DESC(ts_debug,"enable debug messages [ts]");
 
-static unsigned int tsbufs = 4;
-MODULE_PARM(tsbufs,"i");
-MODULE_PARM_DESC(tsbufs,"number of ts buffers, range 2-32");
-
-static unsigned int ts_nr_packets = 30;
-MODULE_PARM(ts_nr_packets,"i");
-MODULE_PARM_DESC(ts_nr_packets,"size of a ts buffers (in ts packets)");
-
 #define dprintk(fmt, arg...)	if (ts_debug) \
 	printk(KERN_DEBUG "%s/ts: " fmt, dev->name , ## arg)
 
@@ -59,11 +47,11 @@ static int buffer_activate(struct saa713
 			   struct saa7134_buf *next)
 {
 	u32 control;
-	
+
 	dprintk("buffer_activate [%p]",buf);
 	buf->vb.state = STATE_ACTIVE;
 	buf->top_seen = 0;
-	
+
         /* dma: setup channel 5 (= TS) */
         control = SAA7134_RS_CONTROL_BURST_16 |
                 SAA7134_RS_CONTROL_ME |
@@ -85,24 +73,24 @@ static int buffer_activate(struct saa713
 
 	/* start DMA */
 	saa7134_set_dmabits(dev);
-	
+
 	mod_timer(&dev->ts_q.timeout, jiffies+BUFFER_TIMEOUT);
 	return 0;
 }
 
-static int buffer_prepare(void *priv, struct videobuf_buffer *vb,
+static int buffer_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 			  enum v4l2_field field)
 {
-	struct saa7134_dev *dev = priv;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
+	struct saa7134_dev *dev = q->priv_data;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
 	unsigned int lines, llength, size;
 	int err;
-	
+
 	dprintk("buffer_prepare [%p,%s]\n",buf,v4l2_field_names[field]);
 
 	llength = TS_PACKET_SIZE;
-	lines = ts_nr_packets;
-	
+	lines = dev->ts.nr_packets;
+
 	size = lines * llength;
 	if (0 != buf->vb.baddr  &&  buf->vb.bsize < size)
 		return -EINVAL;
@@ -138,323 +126,51 @@ static int buffer_prepare(void *priv, st
 }
 
 static int
-buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
-	*size = TS_PACKET_SIZE * ts_nr_packets;
+	struct saa7134_dev *dev = q->priv_data;
+
+	*size = TS_PACKET_SIZE * dev->ts.nr_packets;
 	if (0 == *count)
-		*count = tsbufs;
+		*count = dev->ts.nr_bufs;
 	*count = saa7134_buffer_count(*size,*count);
 	return 0;
 }
 
-static void buffer_queue(void *priv, struct videobuf_buffer *vb)
+static void buffer_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct saa7134_dev *dev = priv;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	
+	struct saa7134_dev *dev = q->priv_data;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
+
 	saa7134_buffer_queue(dev,&dev->ts_q,buf);
 }
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct saa7134_dev *dev = priv;
-	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	
+	struct saa7134_dev *dev = q->priv_data;
+	struct saa7134_buf *buf = container_of(vb,struct saa7134_buf,vb);
+
 	saa7134_dma_free(dev,buf);
 }
 
-static struct videobuf_queue_ops ts_qops = {
+struct videobuf_queue_ops saa7134_ts_qops = {
 	.buf_setup    = buffer_setup,
 	.buf_prepare  = buffer_prepare,
 	.buf_queue    = buffer_queue,
 	.buf_release  = buffer_release,
 };
-
-
-/* ------------------------------------------------------------------ */
-
-static void ts_reset_encoder(struct saa7134_dev* dev) 
-{
-	saa_writeb(SAA7134_SPECIAL_MODE, 0x00);
-	msleep(10);
-   	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
-	msleep(100);
-}
-
-static int ts_init_encoder(struct saa7134_dev* dev, void* arg) 
-{
-	ts_reset_encoder(dev);
-	saa7134_i2c_call_clients(dev, MPEG_SETPARAMS, arg);
- 	return 0;
-}
-
-
-/* ------------------------------------------------------------------ */
-
-static int ts_open(struct inode *inode, struct file *file)
-{
-	int minor = iminor(inode);
-	struct saa7134_dev *h,*dev = NULL;
-	struct list_head *list;
-	int err;
-	
-	list_for_each(list,&saa7134_devlist) {
-		h = list_entry(list, struct saa7134_dev, devlist);
-		if (h->ts_dev && h->ts_dev->minor == minor)
-			dev = h;
-	}
-	if (NULL == dev)
-		return -ENODEV;
-
-	dprintk("open minor=%d\n",minor);
-	down(&dev->ts.ts.lock);
-	err = -EBUSY;
-	if (dev->ts.users)
-		goto done;
-
-	dev->ts.started = 0;
-	dev->ts.users++;
-	file->private_data = dev;
-	err = 0;
-
- done:
-	up(&dev->ts.ts.lock);
-	return err;
-}
-
-static int ts_release(struct inode *inode, struct file *file)
-{
-	struct saa7134_dev *dev = file->private_data;
-
-	if (dev->ts.ts.streaming)
-		videobuf_streamoff(file->private_data,&dev->ts.ts);
-	down(&dev->ts.ts.lock);
-	if (dev->ts.ts.reading)
-		videobuf_read_stop(file->private_data,&dev->ts.ts);
-	dev->ts.users--;
-
-	/* stop the encoder */
-	if (dev->ts.started)
-	      	ts_reset_encoder(dev);
-  
-	up(&dev->ts.ts.lock);
-	return 0;
-}
-
-static ssize_t
-ts_read(struct file *file, char __user *data, size_t count, loff_t *ppos)
-{
-	struct saa7134_dev *dev = file->private_data;
-
-	if (!dev->ts.started) {
-		ts_init_encoder(dev, NULL);
-		dev->ts.started = 1;
-	}
-  
-	return videobuf_read_stream(file->private_data,
-				    &dev->ts.ts, data, count, ppos, 0,
-				    file->f_flags & O_NONBLOCK);
-}
-
-static unsigned int
-ts_poll(struct file *file, struct poll_table_struct *wait)
-{
-	struct saa7134_dev *dev = file->private_data;
-
-	return videobuf_poll_stream(file, file->private_data,
-				    &dev->ts.ts, wait);
-}
-
-
-static int
-ts_mmap(struct file *file, struct vm_area_struct * vma)
-{
-	struct saa7134_dev *dev = file->private_data;
-
-	return videobuf_mmap_mapper(vma, &dev->ts.ts);
-}
-
-/*
- * This function is _not_ called directly, but from
- * video_generic_ioctl (and maybe others).  userspace
- * copying is done already, arg is a kernel pointer.
- */
-static int ts_do_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, void *arg)
-{
-	struct saa7134_dev *dev = file->private_data;
-
-	if (ts_debug > 1)
-		saa7134_print_ioctl(dev->name,cmd);
-	switch (cmd) {
-	case VIDIOC_QUERYCAP:
-	{
-		struct v4l2_capability *cap = arg;
-
-		memset(cap,0,sizeof(*cap));
-                strcpy(cap->driver, "saa7134");
-		strlcpy(cap->card, saa7134_boards[dev->board].name,
-			sizeof(cap->card));
-		sprintf(cap->bus_info,"PCI:%s",pci_name(dev->pci));
-		cap->version = SAA7134_VERSION_CODE;
-		cap->capabilities =
-			V4L2_CAP_VIDEO_CAPTURE |
-			V4L2_CAP_READWRITE |
-			V4L2_CAP_STREAMING;
-		return 0;
-	}
-
-	/* --- input switching --------------------------------------- */
-	case VIDIOC_ENUMINPUT:
-	{
-		struct v4l2_input *i = arg;
-		
-		if (i->index != 0)
-			return -EINVAL;
-		i->type = V4L2_INPUT_TYPE_CAMERA;
-		strcpy(i->name,"CCIR656");
-		return 0;
-	}
-	case VIDIOC_G_INPUT:
-	{
-		int *i = arg;
-		*i = 0;
-		return 0;
-	}
-	case VIDIOC_S_INPUT:
-	{
-		int *i = arg;
-		
-		if (*i != 0)
-			return -EINVAL;
-		return 0;
-	}
-	/* --- capture ioctls ---------------------------------------- */
-	
-	case VIDIOC_ENUM_FMT:
-	{
-		struct v4l2_fmtdesc *f = arg;
-		int index;
-
-		index = f->index;
-		if (index != 0)
-			return -EINVAL;
-		
-		memset(f,0,sizeof(*f));
-		f->index = index;
-		strlcpy(f->description, "MPEG TS", sizeof(f->description));
-		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		f->pixelformat = V4L2_PIX_FMT_MPEG;
-		return 0;
-	}
-
-	case VIDIOC_G_FMT:
-	{
-		struct v4l2_format *f = arg;
-
-		memset(f,0,sizeof(*f));
-		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		
-		/* FIXME: translate subsampling type EMPRESS into
-		 *        width/height: */
-		f->fmt.pix.width        = 720; /* D1 */
-		f->fmt.pix.height       = 576;
-		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
-		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*ts_nr_packets;
-		return 0;
-	}
-	
-	case VIDIOC_S_FMT:
-	{
-		struct v4l2_format *f = arg;
-
-		if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
-		    return -EINVAL;
-
-		/* 
-		  FIXME: translate and round width/height into EMPRESS
-		  subsample type:
-		 
-		          type  |   PAL   |  NTSC 
-			---------------------------
-			  SIF   | 352x288 | 352x240
-			 1/2 D1 | 352x576 | 352x480
-			 2/3 D1 | 480x576 | 480x480
-			  D1    | 720x576 | 720x480
-		*/
-
-		f->fmt.pix.width        = 720; /* D1 */
-		f->fmt.pix.height       = 576;
-		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
-		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*ts_nr_packets;
-		return 0;
-	}
-
-	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(file->private_data,&dev->ts.ts,arg);
-
-	case VIDIOC_QUERYBUF:
-		return videobuf_querybuf(&dev->ts.ts,arg);
-
-	case VIDIOC_QBUF:
-		return videobuf_qbuf(file->private_data,&dev->ts.ts,arg);
-
-	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(file->private_data,&dev->ts.ts,arg,
-				      file->f_flags & O_NONBLOCK);
-
-	case VIDIOC_STREAMON:
-		return videobuf_streamon(file->private_data,&dev->ts.ts);
-
-	case VIDIOC_STREAMOFF:
-		return videobuf_streamoff(file->private_data,&dev->ts.ts);
-
-	case VIDIOC_QUERYCTRL:
-	case VIDIOC_G_CTRL:
-	case VIDIOC_S_CTRL:
-		return saa7134_common_ioctl(dev, cmd, arg);
-
-	case MPEG_SETPARAMS:
-		return ts_init_encoder(dev, arg);
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
-static int ts_ioctl(struct inode *inode, struct file *file,
-		     unsigned int cmd, unsigned long arg)
-{
-	return video_usercopy(inode, file, cmd, arg, ts_do_ioctl);
-}
-
-
-static struct file_operations ts_fops =
-{
-	.owner	  = THIS_MODULE,
-	.open	  = ts_open,
-	.release  = ts_release,
-	.read	  = ts_read,
-	.poll	  = ts_poll,
-	.mmap	  = ts_mmap,
-	.ioctl	  = ts_ioctl,
-	.llseek   = no_llseek,
-};
-
+EXPORT_SYMBOL_GPL(saa7134_ts_qops);
 
 /* ----------------------------------------------------------- */
 /* exported stuff                                              */
 
-struct video_device saa7134_ts_template =
-{
-	.name          = "saa7134-ts",
-	.type          = 0 /* FIXME */,
-	.type2         = 0 /* FIXME */,
-	.hardware      = 0,
-	.fops          = &ts_fops,
-	.minor	       = -1,
-};
+static unsigned int tsbufs = 4;
+module_param(tsbufs, int, 0444);
+MODULE_PARM_DESC(tsbufs,"number of ts buffers, range 2-32");
+
+static unsigned int ts_nr_packets = 30;
+module_param(ts_nr_packets, int, 0444);
+MODULE_PARM_DESC(ts_nr_packets,"size of a ts buffers (in ts packets)");
 
 int saa7134_ts_init1(struct saa7134_dev *dev)
 {
@@ -467,6 +183,8 @@ int saa7134_ts_init1(struct saa7134_dev 
 		ts_nr_packets = 4;
 	if (ts_nr_packets > 312)
 		ts_nr_packets = 312;
+	dev->ts.nr_bufs    = tsbufs;
+	dev->ts.nr_packets = ts_nr_packets;
 
 	INIT_LIST_HEAD(&dev->ts_q.queue);
 	init_timer(&dev->ts_q.timeout);
@@ -474,26 +192,21 @@ int saa7134_ts_init1(struct saa7134_dev 
 	dev->ts_q.timeout.data     = (unsigned long)(&dev->ts_q);
 	dev->ts_q.dev              = dev;
 	dev->ts_q.need_two         = 1;
-	videobuf_queue_init(&dev->ts.ts, &ts_qops, dev->pci, &dev->slock,
-			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
-			    V4L2_FIELD_ALTERNATE,
-			    sizeof(struct saa7134_buf));
 	saa7134_pgtable_alloc(dev->pci,&dev->ts.pt_ts);
 
 	/* init TS hw */
 	saa_writeb(SAA7134_TS_SERIAL1, 0x00);  /* deactivate TS softreset */
 	saa_writeb(SAA7134_TS_PARALLEL, 0xec); /* TSSOP high active, TSVAL high active, TSLOCK ignored */
 	saa_writeb(SAA7134_TS_PARALLEL_SERIAL, (TS_PACKET_SIZE-1));
-	saa_writeb(SAA7134_TS_DMA0, ((ts_nr_packets-1)&0xff));
-	saa_writeb(SAA7134_TS_DMA1, (((ts_nr_packets-1)>>8)&0xff));
-	saa_writeb(SAA7134_TS_DMA2, ((((ts_nr_packets-1)>>16)&0x3f) | 0x00)); /* TSNOPIT=0, TSCOLAP=0 */
- 
+	saa_writeb(SAA7134_TS_DMA0, ((dev->ts.nr_packets-1)&0xff));
+	saa_writeb(SAA7134_TS_DMA1, (((dev->ts.nr_packets-1)>>8)&0xff));
+	saa_writeb(SAA7134_TS_DMA2, ((((dev->ts.nr_packets-1)>>16)&0x3f) | 0x00)); /* TSNOPIT=0, TSCOLAP=0 */
+
 	return 0;
 }
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
-	/* nothing */
 	saa7134_pgtable_free(dev->pci,&dev->ts.pt_ts);
 	return 0;
 }
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-input.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa7134-input.c	2004-11-07 12:24:50.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-input.c	2004-11-07 15:55:19.400370116 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-input.c,v 1.9 2004/09/15 16:15:24 kraxel Exp $
+ * $Id: saa7134-input.c,v 1.12 2004/11/07 13:17:15 kraxel Exp $
  *
  * handle saa7134 IR remotes via linux kernel input layer.
  *
@@ -30,11 +30,11 @@
 #include "saa7134.h"
 
 static unsigned int disable_ir = 0;
-MODULE_PARM(disable_ir,"i");
+module_param(disable_ir, int, 0444);
 MODULE_PARM_DESC(disable_ir,"disable infrared remote support");
 
 static unsigned int ir_debug = 0;
-MODULE_PARM(ir_debug,"i");
+module_param(ir_debug, int, 0644);
 MODULE_PARM_DESC(ir_debug,"enable debug messages [IR]");
 
 #define dprintk(fmt, arg...)	if (ir_debug) \
@@ -63,7 +63,7 @@ static IR_KEYTAB_TYPE flyvideo_codes[IR_
 	[   20 ] = KEY_VOLUMEUP,
 	[   23 ] = KEY_VOLUMEDOWN,
 	[   18 ] = KEY_CHANNELUP,    // Channel +
-	[   19 ] = KEY_CHANNELDOWN,  // Channel - 
+	[   19 ] = KEY_CHANNELDOWN,  // Channel -
 	[    6 ] = KEY_AGAIN,        // Recal
 	[   16 ] = KEY_KPENTER,      // Enter
 
@@ -353,6 +353,7 @@ int saa7134_input_init1(struct saa7134_d
 		polling      = 50; // ms
 		break;
 	case SAA7134_BOARD_MD2819:
+	case SAA7134_BOARD_AVERMEDIA_307:
 		ir_codes     = md2819_codes;
 		mask_keycode = 0x0007C8;
 		mask_keydown = 0x000010;
@@ -378,7 +379,7 @@ int saa7134_input_init1(struct saa7134_d
 	ir->mask_keydown = mask_keydown;
 	ir->mask_keyup   = mask_keyup;
         ir->polling      = polling;
-	
+
 	/* init input device */
 	snprintf(ir->name, sizeof(ir->name), "saa7134 IR (%s)",
 		 saa7134_boards[dev->board].name);
@@ -417,7 +418,7 @@ void saa7134_input_fini(struct saa7134_d
 {
 	if (NULL == dev->remote)
 		return;
-	
+
 	input_unregister_device(&dev->remote->dev);
 	if (dev->remote->polling)
 		del_timer_sync(&dev->remote->timer);
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-empress.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-empress.c	2004-11-07 15:55:19.400370116 +0100
@@ -0,0 +1,394 @@
+/*
+ * $Id: saa7134-empress.c,v 1.3 2004/11/07 13:17:15 kraxel Exp $
+ *
+ * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include "saa7134-reg.h"
+#include "saa7134.h"
+
+#include <media/saa6752hs.h>
+
+/* ------------------------------------------------------------------ */
+
+MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
+MODULE_LICENSE("GPL");
+
+static unsigned int empress_nr[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
+module_param_array(empress_nr, int, NULL, 0444);
+MODULE_PARM_DESC(empress_nr,"ts device number");
+
+static unsigned int debug = 0;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug,"enable debug messages");
+
+#define dprintk(fmt, arg...)	if (debug)			\
+	printk(KERN_DEBUG "%s/empress: " fmt, dev->name , ## arg)
+
+/* ------------------------------------------------------------------ */
+
+static void ts_reset_encoder(struct saa7134_dev* dev)
+{
+	saa_writeb(SAA7134_SPECIAL_MODE, 0x00);
+	msleep(10);
+   	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
+	msleep(100);
+}
+
+static int ts_init_encoder(struct saa7134_dev* dev, void* arg)
+{
+	ts_reset_encoder(dev);
+	saa7134_i2c_call_clients(dev, MPEG_SETPARAMS, arg);
+ 	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+
+static int ts_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct saa7134_dev *h,*dev = NULL;
+	struct list_head *list;
+	int err;
+
+	list_for_each(list,&saa7134_devlist) {
+		h = list_entry(list, struct saa7134_dev, devlist);
+		if (h->empress_dev && h->empress_dev->minor == minor)
+			dev = h;
+	}
+	if (NULL == dev)
+		return -ENODEV;
+
+	dprintk("open minor=%d\n",minor);
+	down(&dev->empress_tsq.lock);
+	err = -EBUSY;
+	if (dev->empress_users)
+		goto done;
+
+	dev->empress_users++;
+	file->private_data = dev;
+	ts_init_encoder(dev, NULL);
+	err = 0;
+
+ done:
+	up(&dev->empress_tsq.lock);
+	return err;
+}
+
+static int ts_release(struct inode *inode, struct file *file)
+{
+	struct saa7134_dev *dev = file->private_data;
+
+	if (dev->empress_tsq.streaming)
+		videobuf_streamoff(&dev->empress_tsq);
+	down(&dev->empress_tsq.lock);
+	if (dev->empress_tsq.reading)
+		videobuf_read_stop(&dev->empress_tsq);
+	dev->empress_users--;
+
+	/* stop the encoder */
+	ts_reset_encoder(dev);
+
+	up(&dev->empress_tsq.lock);
+	return 0;
+}
+
+static ssize_t
+ts_read(struct file *file, char __user *data, size_t count, loff_t *ppos)
+{
+	struct saa7134_dev *dev = file->private_data;
+
+	return videobuf_read_stream(&dev->empress_tsq,
+				    data, count, ppos, 0,
+				    file->f_flags & O_NONBLOCK);
+}
+
+static unsigned int
+ts_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct saa7134_dev *dev = file->private_data;
+
+	return videobuf_poll_stream(file, &dev->empress_tsq, wait);
+}
+
+
+static int
+ts_mmap(struct file *file, struct vm_area_struct * vma)
+{
+	struct saa7134_dev *dev = file->private_data;
+
+	return videobuf_mmap_mapper(&dev->empress_tsq, vma);
+}
+
+/*
+ * This function is _not_ called directly, but from
+ * video_generic_ioctl (and maybe others).  userspace
+ * copying is done already, arg is a kernel pointer.
+ */
+static int ts_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
+{
+	struct saa7134_dev *dev = file->private_data;
+
+	if (debug > 1)
+		saa7134_print_ioctl(dev->name,cmd);
+	switch (cmd) {
+	case VIDIOC_QUERYCAP:
+	{
+		struct v4l2_capability *cap = arg;
+
+		memset(cap,0,sizeof(*cap));
+                strcpy(cap->driver, "saa7134");
+		strlcpy(cap->card, saa7134_boards[dev->board].name,
+			sizeof(cap->card));
+		sprintf(cap->bus_info,"PCI:%s",pci_name(dev->pci));
+		cap->version = SAA7134_VERSION_CODE;
+		cap->capabilities =
+			V4L2_CAP_VIDEO_CAPTURE |
+			V4L2_CAP_READWRITE |
+			V4L2_CAP_STREAMING;
+		return 0;
+	}
+
+	/* --- input switching --------------------------------------- */
+	case VIDIOC_ENUMINPUT:
+	{
+		struct v4l2_input *i = arg;
+
+		if (i->index != 0)
+			return -EINVAL;
+		i->type = V4L2_INPUT_TYPE_CAMERA;
+		strcpy(i->name,"CCIR656");
+		return 0;
+	}
+	case VIDIOC_G_INPUT:
+	{
+		int *i = arg;
+		*i = 0;
+		return 0;
+	}
+	case VIDIOC_S_INPUT:
+	{
+		int *i = arg;
+
+		if (*i != 0)
+			return -EINVAL;
+		return 0;
+	}
+	/* --- capture ioctls ---------------------------------------- */
+
+	case VIDIOC_ENUM_FMT:
+	{
+		struct v4l2_fmtdesc *f = arg;
+		int index;
+
+		index = f->index;
+		if (index != 0)
+			return -EINVAL;
+
+		memset(f,0,sizeof(*f));
+		f->index = index;
+		strlcpy(f->description, "MPEG TS", sizeof(f->description));
+		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		f->pixelformat = V4L2_PIX_FMT_MPEG;
+		return 0;
+	}
+
+	case VIDIOC_G_FMT:
+	{
+		struct v4l2_format *f = arg;
+
+		memset(f,0,sizeof(*f));
+		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+		/* FIXME: translate subsampling type EMPRESS into
+		 *        width/height: */
+		f->fmt.pix.width        = 720; /* D1 */
+		f->fmt.pix.height       = 576;
+		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
+		f->fmt.pix.sizeimage    = TS_PACKET_SIZE * dev->ts.nr_packets;
+		return 0;
+	}
+
+	case VIDIOC_S_FMT:
+	{
+		struct v4l2_format *f = arg;
+
+		if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		    return -EINVAL;
+
+		/*
+		  FIXME: translate and round width/height into EMPRESS
+		  subsample type:
+
+		          type  |   PAL   |  NTSC
+			---------------------------
+			  SIF   | 352x288 | 352x240
+			 1/2 D1 | 352x576 | 352x480
+			 2/3 D1 | 480x576 | 480x480
+			  D1    | 720x576 | 720x480
+		*/
+
+		f->fmt.pix.width        = 720; /* D1 */
+		f->fmt.pix.height       = 576;
+		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
+		f->fmt.pix.sizeimage    = TS_PACKET_SIZE* dev->ts.nr_packets;
+		return 0;
+	}
+
+	case VIDIOC_REQBUFS:
+		return videobuf_reqbufs(&dev->empress_tsq,arg);
+
+	case VIDIOC_QUERYBUF:
+		return videobuf_querybuf(&dev->empress_tsq,arg);
+
+	case VIDIOC_QBUF:
+		return videobuf_qbuf(&dev->empress_tsq,arg);
+
+	case VIDIOC_DQBUF:
+		return videobuf_dqbuf(&dev->empress_tsq,arg,
+				      file->f_flags & O_NONBLOCK);
+
+	case VIDIOC_STREAMON:
+		return videobuf_streamon(&dev->empress_tsq);
+
+	case VIDIOC_STREAMOFF:
+		return videobuf_streamoff(&dev->empress_tsq);
+
+	case VIDIOC_QUERYCTRL:
+	case VIDIOC_G_CTRL:
+	case VIDIOC_S_CTRL:
+		return saa7134_common_ioctl(dev, cmd, arg);
+
+	case MPEG_SETPARAMS:
+		return ts_init_encoder(dev, arg);
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+static int ts_ioctl(struct inode *inode, struct file *file,
+		     unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, ts_do_ioctl);
+}
+
+static struct file_operations ts_fops =
+{
+	.owner	  = THIS_MODULE,
+	.open	  = ts_open,
+	.release  = ts_release,
+	.read	  = ts_read,
+	.poll	  = ts_poll,
+	.mmap	  = ts_mmap,
+	.ioctl	  = ts_ioctl,
+	.llseek   = no_llseek,
+};
+
+/* ----------------------------------------------------------- */
+
+static struct video_device saa7134_empress_template =
+{
+	.name          = "saa7134-empress",
+	.type          = 0 /* FIXME */,
+	.type2         = 0 /* FIXME */,
+	.hardware      = 0,
+	.fops          = &ts_fops,
+	.minor	       = -1,
+};
+
+static int empress_init(struct saa7134_dev *dev)
+{
+	int err;
+
+	dprintk("%s: %s\n",dev->name,__FUNCTION__);
+	dev->empress_dev = video_device_alloc();
+	if (NULL == dev->empress_dev)
+		return -ENOMEM;
+	*(dev->empress_dev) = saa7134_empress_template;
+	dev->empress_dev->dev     = &dev->pci->dev;
+	dev->empress_dev->release = video_device_release;
+	snprintf(dev->empress_dev->name, sizeof(dev->empress_dev->name),
+		 "%s empress (%s)", dev->name,
+		 saa7134_boards[dev->board].name);
+
+	err = video_register_device(dev->empress_dev,VFL_TYPE_GRABBER,
+				    empress_nr[dev->nr]);
+	if (err < 0) {
+		printk(KERN_INFO "%s: can't register video device\n",
+		       dev->name);
+		video_device_release(dev->empress_dev);
+		dev->empress_dev = NULL;
+		return err;
+	}
+	printk(KERN_INFO "%s: registered device video%d [mpeg]\n",
+	       dev->name,dev->empress_dev->minor & 0x1f);
+
+	videobuf_queue_init(&dev->empress_tsq, &saa7134_ts_qops,
+			    dev->pci, &dev->slock,
+			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_ALTERNATE,
+			    sizeof(struct saa7134_buf),
+			    dev);
+	return 0;
+}
+
+static int empress_fini(struct saa7134_dev *dev)
+{
+	dprintk("%s: %s\n",dev->name,__FUNCTION__);
+
+	if (NULL == dev->empress_dev)
+		return 0;
+	video_unregister_device(dev->empress_dev);
+	dev->empress_dev = NULL;
+	return 0;
+}
+
+static struct saa7134_mpeg_ops empress_ops = {
+	.type          = SAA7134_MPEG_EMPRESS,
+	.init          = empress_init,
+	.fini          = empress_fini,
+};
+
+static int __init empress_register(void)
+{
+	return saa7134_ts_register(&empress_ops);
+}
+
+static void __exit empress_unregister(void)
+{
+	saa7134_ts_unregister(&empress_ops);
+}
+
+module_init(empress_register);
+module_exit(empress_unregister);
+
+/* ----------------------------------------------------------- */
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
Index: linux-2004-11-05/drivers/media/video/saa7134/saa7134-dvb.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2004-11-05/drivers/media/video/saa7134/saa7134-dvb.c	2004-11-07 15:55:19.401369928 +0100
@@ -0,0 +1,91 @@
+/*
+ * $Id: saa7134-dvb.c,v 1.4 2004/11/07 14:44:59 kraxel Exp $
+ *
+ * (c) 2004 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/suspend.h>
+
+#include "saa7134-reg.h"
+#include "saa7134.h"
+
+MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
+MODULE_LICENSE("GPL");
+
+/* ------------------------------------------------------------------ */
+
+static int dvb_init(struct saa7134_dev *dev)
+{
+	printk("%s: %s\n",dev->name,__FUNCTION__);
+
+	/* init struct videobuf_dvb */
+	dev->dvb.name = dev->name;
+	videobuf_queue_init(&dev->dvb.dvbq, &saa7134_ts_qops,
+			    dev->pci, &dev->slock,
+			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_TOP,
+			    sizeof(struct saa7134_buf),
+			    dev);
+
+	/* TODO: init frontend */
+	if (NULL == dev->dvb.frontend)
+		return -1;
+
+	/* register everything else */
+	return videobuf_dvb_register(&dev->dvb);
+}
+
+static int dvb_fini(struct saa7134_dev *dev)
+{
+	printk("%s: %s\n",dev->name,__FUNCTION__);
+	videobuf_dvb_unregister(&dev->dvb);
+	return 0;
+}
+
+static struct saa7134_mpeg_ops dvb_ops = {
+	.type          = SAA7134_MPEG_DVB,
+	.init          = dvb_init,
+	.fini          = dvb_fini,
+};
+
+static int __init dvb_register(void)
+{
+	return saa7134_ts_register(&dvb_ops);
+}
+
+static void __exit dvb_unregister(void)
+{
+	saa7134_ts_unregister(&dvb_ops);
+}
+
+module_init(dvb_register);
+module_exit(dvb_unregister);
+
+/* ------------------------------------------------------------------ */
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * compile-command: "make DVB=1"
+ * End:
+ */
Index: linux-2004-11-05/include/media/saa6752hs.h
===================================================================
--- linux-2004-11-05.orig/include/media/saa6752hs.h	2004-11-07 12:24:50.000000000 +0100
+++ linux-2004-11-05/include/media/saa6752hs.h	2004-11-07 15:51:24.589532030 +0100
@@ -1,4 +1,4 @@
-/* 
+/*
     saa6752hs.h - definition for saa6752hs MPEG encoder
 
     Copyright (C) 2003 Andrew de Quincey <adq@lidskialf.net>
@@ -31,14 +31,14 @@ enum mpeg_bitrate_mode {
 enum mpeg_audio_bitrate {
 	MPEG_AUDIO_BITRATE_256 = 0, /* 256 kBit/sec */
 	MPEG_AUDIO_BITRATE_384 = 1, /* 384 kBit/sec */
-    
+
 	MPEG_AUDIO_BITRATE_MAX
 };
 
 #define MPEG_VIDEO_TARGET_BITRATE_MAX 27000
 #define MPEG_VIDEO_MAX_BITRATE_MAX 27000
 #define MPEG_TOTAL_BITRATE_MAX 27000
-    
+
 struct mpeg_params {
 	enum mpeg_bitrate_mode bitrate_mode;
 	unsigned int video_target_bitrate;
Index: linux-2004-11-05/drivers/media/video/saa7134/saa6752hs.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/saa6752hs.c	2004-11-07 12:24:24.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/saa6752hs.c	2004-11-07 15:51:24.589532030 +0100
@@ -36,7 +36,7 @@ enum saa6752hs_command {
     	SAA6752HS_COMMAND_RECONFIGURE = 4,
     	SAA6752HS_COMMAND_SLEEP = 5,
 	SAA6752HS_COMMAND_RECONFIGURE_FORCE = 6,
-    
+
 	SAA6752HS_COMMAND_MAX
 };
 
@@ -46,24 +46,24 @@ enum saa6752hs_command {
 static u8 PAT[] = {
 	0xc2, // i2c register
 	0x00, // table number for encoder
-  
+
 	0x47, // sync
 	0x40, 0x00, // transport_error_indicator(0), payload_unit_start(1), transport_priority(0), pid(0)
 	0x10, // transport_scrambling_control(00), adaptation_field_control(01), continuity_counter(0)
-     
+
 	0x00, // PSI pointer to start of table
-    
+
 	0x00, // tid(0)
 	0xb0, 0x0d, // section_syntax_indicator(1), section_length(13)
-    
+
 	0x00, 0x01, // transport_stream_id(1)
-    
+
 	0xc1, // version_number(0), current_next_indicator(1)
-    
+
 	0x00, 0x00, // section_number(0), last_section_number(0)
 
 	0x00, 0x01, // program_number(1)
-	
+
 	0xe0, 0x10, // PMT PID(0x10)
 
 	0x76, 0xf1, 0x44, 0xd1 // CRC32
@@ -72,29 +72,29 @@ static u8 PAT[] = {
 static u8 PMT[] = {
 	0xc2, // i2c register
 	0x01, // table number for encoder
-  
+
 	0x47, // sync
 	0x40, 0x10, // transport_error_indicator(0), payload_unit_start(1), transport_priority(0), pid(0x10)
 	0x10, // transport_scrambling_control(00), adaptation_field_control(01), continuity_counter(0)
-     
+
 	0x00, // PSI pointer to start of table
-    
+
 	0x02, // tid(2)
 	0xb0, 0x17, // section_syntax_indicator(1), section_length(23)
 
 	0x00, 0x01, // program_number(1)
-    
+
 	0xc1, // version_number(0), current_next_indicator(1)
-    
+
 	0x00, 0x00, // section_number(0), last_section_number(0)
-    
+
 	0xe1, 0x04, // PCR_PID (0x104)
-   
+
 	0xf0, 0x00, // program_info_length(0)
-    
+
 	0x02, 0xe1, 0x00, 0xf0, 0x00, // video stream type(2), pid(0x100)
 	0x04, 0xe1, 0x03, 0xf0, 0x00, // audio stream type(4), pid(0x103)
-    
+
 	0xa1, 0xca, 0x0f, 0x82 // CRC32
 };
 
@@ -106,7 +106,7 @@ static struct mpeg_params mpeg_params_te
 	.total_bitrate = 6000,
 };
 
-  
+
 /* ---------------------------------------------------------------------- */
 
 
@@ -122,11 +122,11 @@ static int saa6752hs_chip_command(struct
   	case SAA6752HS_COMMAND_RESET:
   		buf[0] = 0x00;
 		break;
-	  
+
 	case SAA6752HS_COMMAND_STOP:
 		  	buf[0] = 0x03;
 		break;
-	  
+
 	case SAA6752HS_COMMAND_START:
   		buf[0] = 0x02;
 		break;
@@ -134,11 +134,11 @@ static int saa6752hs_chip_command(struct
 	case SAA6752HS_COMMAND_PAUSE:
   		buf[0] = 0x04;
 		break;
-	  
+
 	case SAA6752HS_COMMAND_RECONFIGURE:
 		buf[0] = 0x05;
 		break;
-	  
+
   	case SAA6752HS_COMMAND_SLEEP:
   		buf[0] = 0x06;
 		break;
@@ -146,11 +146,11 @@ static int saa6752hs_chip_command(struct
   	case SAA6752HS_COMMAND_RECONFIGURE_FORCE:
 		buf[0] = 0x07;
 		break;
-	
+
 	default:
-		return -EINVAL;  
+		return -EINVAL;
 	}
-	
+
   	// set it and wait for it to be so
 	i2c_master_send(client, buf, 1);
 	timeout = jiffies + HZ * 3;
@@ -166,14 +166,14 @@ static int saa6752hs_chip_command(struct
 			status = -ETIMEDOUT;
 			break;
 		}
-	
+
 		// wait a bit
 		msleep(10);
 	}
 
 	// delay a bit to let encoder settle
 	msleep(50);
-	
+
 	// done
   	return status;
 }
@@ -183,12 +183,12 @@ static int saa6752hs_set_bitrate(struct 
 				 struct mpeg_params* params)
 {
   	u8 buf[3];
-  
+
 	// set the bitrate mode
 	buf[0] = 0x71;
 	buf[1] = params->bitrate_mode;
 	i2c_master_send(client, buf, 2);
-	  
+
 	// set the video bitrate
 	if (params->bitrate_mode == MPEG_BITRATE_MODE_VBR) {
 		// set the target bitrate
@@ -209,24 +209,24 @@ static int saa6752hs_set_bitrate(struct 
 	  	buf[2] = params->video_target_bitrate & 0xff;
 		i2c_master_send(client, buf, 3);
 	}
-	  
+
 	// set the audio bitrate
  	buf[0] = 0x94;
   	buf[1] = params->audio_bitrate;
 	i2c_master_send(client, buf, 2);
-	
+
 	// set the total bitrate
 	buf[0] = 0xb1;
   	buf[1] = params->total_bitrate >> 8;
   	buf[2] = params->total_bitrate & 0xff;
 	i2c_master_send(client, buf, 3);
-  
+
 	return 0;
 }
 
 
 static int saa6752hs_init(struct i2c_client* client, struct mpeg_params* params)
-{  
+{
 	unsigned char buf[3];
 	void *data;
 
@@ -244,41 +244,41 @@ static int saa6752hs_init(struct i2c_cli
         		return -EINVAL;
 		if (params->bitrate_mode         == MPEG_BITRATE_MODE_MAX &&
 		    params->video_target_bitrate <= params->video_max_bitrate)
-			return -EINVAL; 
+			return -EINVAL;
 	}
-  
+
     	// Set GOP structure {3, 13}
 	buf[0] = 0x72;
 	buf[1] = 0x03;
 	buf[2] = 0x0D;
 	i2c_master_send(client,buf,3);
-  
+
     	// Set minimum Q-scale {4}
 	buf[0] = 0x82;
 	buf[1] = 0x04;
 	i2c_master_send(client,buf,2);
-  
+
     	// Set maximum Q-scale {12}
 	buf[0] = 0x83;
 	buf[1] = 0x0C;
 	i2c_master_send(client,buf,2);
-  
+
     	// Set Output Protocol
 	buf[0] = 0xD0;
 	buf[1] = 0x01;
 	i2c_master_send(client,buf,2);
-  
+
     	// Set video output stream format {TS}
 	buf[0] = 0xB0;
 	buf[1] = 0x05;
 	i2c_master_send(client,buf,2);
-  
+
     	// Set Audio PID {0x103}
 	buf[0] = 0xC1;
 	buf[1] = 0x01;
 	buf[2] = 0x03;
 	i2c_master_send(client,buf,3);
-  
+
         // setup bitrate settings
 	data = i2c_get_clientdata(client);
 	if (params) {
@@ -288,18 +288,18 @@ static int saa6752hs_init(struct i2c_cli
 		// parameters were not supplied. use the previous set
    		saa6752hs_set_bitrate(client, (struct mpeg_params*) data);
 	}
-	  
+
 	// Send SI tables
   	i2c_master_send(client,PAT,sizeof(PAT));
   	i2c_master_send(client,PMT,sizeof(PMT));
-	  
+
 	// mute then unmute audio. This removes buzzing artefacts
 	buf[0] = 0xa4;
 	buf[1] = 1;
 	i2c_master_send(client, buf, 2);
   	buf[1] = 0;
 	i2c_master_send(client, buf, 2);
-	  
+
 	// start it going
 	saa6752hs_chip_command(client, SAA6752HS_COMMAND_START);
 
@@ -320,14 +320,14 @@ static int saa6752hs_attach(struct i2c_a
                 return -ENOMEM;
         memcpy(client,&client_template,sizeof(struct i2c_client));
 	strlcpy(client->name, "saa6752hs", sizeof(client->name));
-   
+
 	if (NULL == (params = kmalloc(sizeof(struct mpeg_params), GFP_KERNEL)))
 		return -ENOMEM;
 	memcpy(params,&mpeg_params_template,sizeof(struct mpeg_params));
 	i2c_set_clientdata(client, params);
 
         i2c_attach_client(client);
-  
+
 	return 0;
 }
 
@@ -362,7 +362,7 @@ saa6752hs_command(struct i2c_client *cli
 		/* nothing */
 		break;
 	}
-	
+
 	return 0;
 }
 
Index: linux-2004-11-05/drivers/media/video/saa7134/Makefile
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/saa7134/Makefile	2004-11-07 12:24:37.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/saa7134/Makefile	2004-11-07 15:58:43.792843832 +0100
@@ -3,6 +3,8 @@ saa7134-objs :=	saa7134-cards.o saa7134-
 		saa7134-oss.o saa7134-ts.o saa7134-tvaudio.o	\
 		saa7134-vbi.o saa7134-video.o saa7134-input.o
 
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o saa6752hs.o
+obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o saa7134-empress.o saa6752hs.o
+obj-$(CONFIG_VIDEO_SAA7134_DVB) += saa7134-dvb.o
 
-EXTRA_CFLAGS = -I$(src)/..
+EXTRA_CFLAGS += -I$(src)/..
+EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
Index: linux-2004-11-05/drivers/media/video/Kconfig
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/Kconfig	2004-11-07 12:24:07.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/Kconfig	2004-11-07 16:00:38.239242292 +0100
@@ -245,6 +245,13 @@ config VIDEO_SAA7134
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa7134.
 
+config VIDEO_SAA7134_DVB
+	tristate "DVB Support for saa7134 based TV cards"
+	depends on VIDEO_SAA7134 && DVB_CORE && BROKEN
+	---help---
+	  This adds support for DVB cards based on the
+	  Philips saa7134 chip.
+
 config VIDEO_MXB
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
 	depends on VIDEO_DEV && PCI

-- 
#define printk(args...) fprintf(stderr, ## args)
