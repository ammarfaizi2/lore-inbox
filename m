Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbTELRtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTELRtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:49:18 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:2198 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262393AbTELRm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:42:26 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 12 May 2003 19:26:13 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: #7 - saa7134 driver update
Message-ID: <20030512172613.GA24368@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Yet another big one (due to not being updated for a long time) --
saa7134 driver update.  Changes:

 * various bugfixes / cleanups.
 * new cards added to the cardlist.
 * started support for saa7133/35 chips.
 * make the driver check pci quirks.

Please apply,

  Gerd

diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-cards.c	2003-05-08 13:31:45.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2003-05-08 13:55:12.000000000 +0200
@@ -29,6 +29,7 @@
 static char name_mute[]    = "mute";
 static char name_radio[]   = "Radio";
 static char name_tv[]      = "Television";
+static char name_tv_mono[] = "TV (mono only)";
 static char name_comp1[]   = "Composite1";
 static char name_comp2[]   = "Composite2";
 static char name_svideo[]  = "S-Video";
@@ -61,6 +62,11 @@
 			.vmux = 1,
 			.amux = TV,
 			.tv   = 1,
+		},{
+			.name = name_tv_mono,
+			.vmux = 1,
+			.amux = LINE2,
+			.tv   = 1,
 		}},
 	},
 	[SAA7134_BOARD_FLYVIDEO3000] = {
@@ -68,27 +74,39 @@
 		.name		= "LifeView FlyVIDEO3000",
 		.audio_clock	= 0x00200000,
 		.tuner_type	= TUNER_PHILIPS_PAL,
+		.gpiomask       = 0xe000,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
 			.amux = TV,
+			.gpio = 0x8000,
+			.tv   = 1,
+                },{
+			.name = name_tv_mono,
+			.vmux = 1,
+			.amux = LINE2,
+			.gpio = 0x0000,
 			.tv   = 1,
 		},{
 			.name = name_comp1,
 			.vmux = 0,
-			.amux = LINE1,
+			.amux = LINE2,
+			.gpio = 0x4000,
 		},{
 			.name = name_comp2,
 			.vmux = 3,
-			.amux = LINE1,
+			.amux = LINE2,
+			.gpio = 0x4000,
 		},{
 			.name = name_svideo,
 			.vmux = 8,
-			.amux = LINE1,
+			.amux = LINE2,
+			.gpio = 0x4000,
 		}},
 		.radio = {
 			.name = name_radio,
 			.amux = LINE2,
+			.gpio = 0x2000,
 		},
 	},
 	[SAA7134_BOARD_FLYVIDEO2000] = {
@@ -96,7 +114,7 @@
 		.name           = "LifeView FlyVIDEO2000",
 		.audio_clock    = 0x00200000,
 		.tuner_type     = TUNER_LG_PAL_NEW_TAPC,
-		.gpiomask       = 0x6000,
+		.gpiomask       = 0xe000,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -122,10 +140,12 @@
                 .radio = {
                         .name = name_radio,
                         .amux = LINE2,
+			.gpio = 0x2000,
                 },
 		.mute = {
 			.name = name_mute,
-			.amux = LINE1,
+                        .amux = LINE2,
+			.gpio = 0x8000,
 		},
 	},
 	[SAA7134_BOARD_EMPRESS] = {
@@ -190,7 +210,7 @@
 			.tv   = 1,
 		},{
 			/* workaround for problems with normal TV sound */
-			.name = "TV (mono only)",
+			.name = name_tv_mono,
 			.vmux = 1,
 			.amux = LINE2,
 			.tv   = 1,
@@ -270,6 +290,12 @@
 			.amux = TV,
 			.tv   = 1,
 		},{
+			/* workaround for problems with normal TV sound */
+			.name = name_tv_mono,
+			.vmux = 1,
+			.amux = LINE2,
+			.tv   = 1,
+		},{
 			.name = name_comp1,
 			.vmux = 0,
 			.amux = LINE2,
@@ -302,7 +328,7 @@
                 },{
                         .name = name_tv,
                         .vmux = 1,
-                        .amux = TV,
+                        .amux = LINE2,
                         .tv   = 1,
                 }},
         },
@@ -332,7 +358,6 @@
 			.name = name_radio,
 			.amux = LINE2,
                },
-
         },
 	[SAA7134_BOARD_MD7134] = {
 		.name           = "Medion 7134",
@@ -343,7 +368,7 @@
 			.name   = name_tv,
 			.vmux   = 1,
 			.amux   = LINE2,
-			.tv     =   1,
+			.tv     = 1,
 		},{
 			.name   = name_comp1,
 			.vmux   = 0,
@@ -361,9 +386,67 @@
 			.name   = name_radio,
 			.amux   = LINE2,
 		},
-      },
+	},
+	[SAA7134_BOARD_TYPHOON_90031] = {
+		.name           = "Typhoon TV+Radio 90031",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name   = name_tv,
+			.vmux   = 1,
+			.amux   = TV,
+			.tv     = 1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 3,
+			.amux   = LINE1,
+		},{
+			.name   = name_svideo,
+			.vmux   = 8,
+			.amux   = LINE1,
+		}},
+		.radio = {
+			.name   = name_radio,
+			.amux   = LINE2,
+		},
+	},
+	[SAA7134_BOARD_ELSA] = {
+		.name           = "ELSA EX-VISION 300TV",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_HITACHI_NTSC,
+		.inputs         = {{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 0,
+			.amux   = LINE1,
+		},{
+			.name = name_tv,
+			.vmux = 4,
+			.amux = LINE2,
+			.tv   = 1,
+		}},
+        },
+	[SAA7134_BOARD_ELSA_500TV] = {
+		.name           = "ELSA EX-VISION 500TV",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_HITACHI_NTSC,
+		.inputs         = {{
+			.name = name_svideo,
+			.vmux = 7,
+			.amux = LINE1,
+		},{
+			.name = name_tv,
+			.vmux = 8,
+			.amux = TV,
+			.tv   = 1,
+		}},
+        },
+	
 };
-const int saa7134_bcount = (sizeof(saa7134_boards)/sizeof(struct saa7134_board));
+const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
 /* ------------------------------------------------------------------ */
 /* PCI ids + subsystem IDs                                            */
@@ -377,6 +460,12 @@
 		.driver_data  = SAA7134_BOARD_PROTEUS_PRO,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+		.subvendor    = PCI_VENDOR_ID_PHILIPS,
+		.subdevice    = 0x2001,
+		.driver_data  = SAA7134_BOARD_PROTEUS_PRO,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = PCI_VENDOR_ID_PHILIPS,
 		.subdevice    = 0x6752,
@@ -407,11 +496,29 @@
 		.driver_data  = SAA7134_BOARD_FLYVIDEO3000,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+		.subvendor    = 0x5168,
+		.subdevice    = 0x0138,
+		.driver_data  = SAA7134_BOARD_FLYVIDEO2000,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = 0x16be,
 		.subdevice    = 0x0003,
 		.driver_data  = SAA7134_BOARD_MD7134,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+		.subvendor    = 0x1048,
+		.subdevice    = 0x226b,
+		.driver_data  = SAA7134_BOARD_ELSA,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+		.subvendor    = 0x1048,
+		.subdevice    = 0x226b,
+		.driver_data  = SAA7134_BOARD_ELSA_500TV,
+	},{
 		
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -435,10 +542,22 @@
 		.driver_data  = SAA7134_BOARD_UNKNOWN,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+                .subvendor    = PCI_ANY_ID,
+                .subdevice    = PCI_ANY_ID,
+		.driver_data  = SAA7134_BOARD_UNKNOWN,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
                 .subvendor    = PCI_ANY_ID,
                 .subdevice    = PCI_ANY_ID,
 		.driver_data  = SAA7134_BOARD_UNKNOWN,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7135,
+                .subvendor    = PCI_ANY_ID,
+                .subdevice    = PCI_ANY_ID,
+		.driver_data  = SAA7134_BOARD_UNKNOWN,
 	},{
 		/* --- end of list --- */
 	}
@@ -446,6 +565,67 @@
 MODULE_DEVICE_TABLE(pci, saa7134_pci_tbl);
 
 /* ----------------------------------------------------------- */
+/* flyvideo tweaks                                             */
+
+#if 0
+static struct {
+	char  *model;
+	int   tuner_type;
+} fly_list[0x20] = {
+	/* default catch ... */
+	[ 0 ... 0x1f ] = {
+		.model      = "UNKNOWN",
+		.tuner_type = TUNER_ABSENT,
+	},
+	/* ... the ones known so far */
+	[ 0x05 ] = {
+		.model      = "PAL-BG",
+		.tuner_type = TUNER_LG_PAL_NEW_TAPC,
+	},
+	[ 0x10 ] = {
+		.model      = "PAL-BG / PAL-DK",
+		.tuner_type = TUNER_PHILIPS_PAL,
+	},
+	[ 0x15 ] = {
+		.model      = "NTSC",
+		.tuner_type = TUNER_ABSENT /* FIXME */,
+	},
+};
+#endif
+
+static void board_flyvideo(struct saa7134_dev *dev)
+{
+	u32 value;
+	int index;
+
+	saa_writel(SAA7134_GPIO_GPMODE0 >> 2,   0);
+	value = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
+#if 0
+	index = (value & 0x1f00) >> 8;
+	printk(KERN_INFO "%s: flyvideo: gpio is 0x%x [model=%s,tuner=%d]\n",
+	       dev->name, value, fly_list[index].model,
+	       fly_list[index].tuner_type);
+	dev->tuner_type = fly_list[index].tuner_type;
+#else
+	printk(KERN_INFO "%s: flyvideo: gpio is 0x%x\n",
+	       dev->name, value);
+#endif
+}
+
+/* ----------------------------------------------------------- */
+
+int saa7134_board_init(struct saa7134_dev *dev)
+{
+	switch (dev->board) {
+	case SAA7134_BOARD_FLYVIDEO2000:
+	case SAA7134_BOARD_FLYVIDEO3000:
+		board_flyvideo(dev);
+		break;
+	}
+	return 0;
+}
+
+/* ----------------------------------------------------------- */
 /*
  * Local variables:
  * c-basic-offset: 8
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-core.c	2003-05-08 13:30:27.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2003-05-08 13:55:12.000000000 +0200
@@ -2,7 +2,7 @@
  * device driver for philips saa7134 based TV cards
  * driver core
  *
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2001-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -67,6 +67,10 @@
 MODULE_PARM(radio_nr,"i");
 MODULE_PARM_DESC(radio_nr,"radio device number");
 
+static unsigned int oss = 0;
+MODULE_PARM(oss,"i");
+MODULE_PARM_DESC(oss,"register oss devices (default: no)");
+
 static unsigned int dsp_nr = -1;
 MODULE_PARM(dsp_nr,"i");
 MODULE_PARM_DESC(dsp_nr,"oss dsp device number");
@@ -75,20 +79,20 @@
 MODULE_PARM(mixer_nr,"i");
 MODULE_PARM_DESC(mixer_nr,"oss mixer device number");
 
-static int tuner[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = -1};
+static unsigned int tuner[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 MODULE_PARM(tuner,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(tuner,"tuner type");
 
-static int card[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = -1};
+static unsigned int card[] = {[0 ... (SAA7134_MAXBOARDS - 1)] = UNSET };
 MODULE_PARM(card,"1-" __stringify(SAA7134_MAXBOARDS) "i");
 MODULE_PARM_DESC(card,"card type");
 
-static int latency = -1;
+static unsigned int latency = UNSET;
 MODULE_PARM(latency,"i");
 MODULE_PARM_DESC(latency,"pci latency timer");
 
 struct list_head  saa7134_devlist;
-int               saa7134_devcount;
+unsigned int      saa7134_devcount;
 
 #define dprintk(fmt, arg...)	if (core_debug) \
 	printk(KERN_DEBUG "%s/core: " fmt, dev->name, ## arg)
@@ -102,7 +106,7 @@
 	"SFREQ", "GAUDIO", "SAUDIO", "SYNC", "MCAPTURE", "GMBUF", "GUNIT",
 	"GCAPTURE", "SCAPTURE", "SPLAYMODE", "SWRITEMODE", "GPLAYINFO",
 	"SMICROCODE", "GVBIFMT", "SVBIFMT" };
-#define V4L1_IOCTLS (sizeof(v4l1_ioctls)/sizeof(char*))
+#define V4L1_IOCTLS ARRAY_SIZE(v4l1_ioctls)
 
 static const char *v4l2_ioctls[] = {
 	"QUERYCAP", "1", "ENUM_PIXFMT", "ENUM_FBUFFMT", "G_FMT", "S_FMT",
@@ -116,7 +120,7 @@
 	"S_AUDOUT", "ENUMFX", "G_EFFECT", "S_EFFECT", "G_MODULATOR",
 	"S_MODULATOR"
 };
-#define V4L2_IOCTLS (sizeof(v4l2_ioctls)/sizeof(char*))
+#define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
 
 static const char *osspcm_ioctls[] = {
 	"RESET", "SYNC", "SPEED", "STEREO", "GETBLKSIZE", "SETFMT",
@@ -125,7 +129,7 @@
 	"GETIPTR", "GETOPTR", "MAPINBUF", "MAPOUTBUF", "SETSYNCRO",
 	"SETDUPLEX", "GETODELAY"
 };
-#define OSSPCM_IOCTLS (sizeof(v4l2_ioctls)/sizeof(char*))
+#define OSSPCM_IOCTLS ARRAY_SIZE(v4l2_ioctls)
 
 void saa7134_print_ioctl(char *name, unsigned int cmd)
 {
@@ -236,9 +240,9 @@
 
 /* calc max # of buffers from size (must not exceed the 4MB virtual
  * address space per DMA channel) */
-int saa7134_buffer_count(int size, int count)
+int saa7134_buffer_count(unsigned int size, unsigned int count)
 {
-	int maxcount;
+	unsigned int maxcount;
 	
 	maxcount = 1024 / saa7134_buffer_pages(size);
 	if (count > maxcount)
@@ -277,11 +281,11 @@
 }
 
 int saa7134_pgtable_build(struct pci_dev *pci, struct saa7134_pgtable *pt,
-			  struct scatterlist *list, int length,
-			  int startpage)
+			  struct scatterlist *list, unsigned int length,
+			  unsigned int startpage)
 {
-	u32   *ptr;
-	int   i,p;
+	u32           *ptr;
+	unsigned int  i,p;
 
 	BUG_ON(NULL == pt || NULL == pt->cpu);
 
@@ -319,14 +323,25 @@
 			 struct saa7134_dmaqueue *q,
 			 struct saa7134_buf *buf)
 {
+	struct saa7134_buf *next = NULL;
 #if DEBUG_SPINLOCKS
 	BUG_ON(!spin_is_locked(&dev->slock));
 #endif
 	
 	dprintk("buffer_queue %p\n",buf);
 	if (NULL == q->curr) {
-		q->curr = buf;
-		buf->activate(dev,buf,NULL);
+		if (!q->need_two) {
+			q->curr = buf;
+			buf->activate(dev,buf,NULL);
+		} else if (list_empty(&q->queue)) {
+			list_add_tail(&buf->vb.queue,&q->queue);
+			buf->vb.state = STATE_QUEUED;
+		} else {
+			next = list_entry(q->queue.next,struct saa7134_buf,
+					  vb.queue);
+			q->curr = buf;
+			buf->activate(dev,buf,next);
+		}
 	} else {
 		list_add_tail(&buf->vb.queue,&q->queue);
 		buf->vb.state = STATE_QUEUED;
@@ -336,7 +351,7 @@
 
 void saa7134_buffer_finish(struct saa7134_dev *dev,
 			   struct saa7134_dmaqueue *q,
-			   int state)
+			   unsigned int state)
 {
 #if DEBUG_SPINLOCKS
 	BUG_ON(!spin_is_locked(&dev->slock));
@@ -388,6 +403,14 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->slock,flags);
+
+	/* try to reset the hardware (SWRST) */
+	saa_writeb(SAA7134_REGION_ENABLE, 0x00);
+	saa_writeb(SAA7134_REGION_ENABLE, 0x80);
+	saa_writeb(SAA7134_REGION_ENABLE, 0x00);
+
+	/* flag current buffer as failed,
+	   try to start over with the next one. */
 	if (q->curr) {
 		dprintk("timeout on %p\n",q->curr);
 		saa7134_buffer_finish(dev,q,STATE_ERROR);
@@ -400,7 +423,7 @@
 
 int saa7134_set_dmabits(struct saa7134_dev *dev)
 {
-	unsigned long task=0, ctrl=0, irq=0, split = 0;
+	u32 split, task=0, ctrl=0, irq=0;
 	enum v4l2_field cap = V4L2_FIELD_ANY;
 	enum v4l2_field ov  = V4L2_FIELD_ANY;
 
@@ -460,12 +483,12 @@
 	
 	/* set task conditions + field handling */
 	if (V4L2_FIELD_HAS_BOTH(cap) || V4L2_FIELD_HAS_BOTH(ov) || cap == ov) {
-		/* default config -- use full frames:
-		   odd A, even A, odd B, even B, repeat */
+		/* default config -- use full frames */
 		saa_writeb(SAA7134_TASK_CONDITIONS(TASK_A), 0x0d);
 		saa_writeb(SAA7134_TASK_CONDITIONS(TASK_B), 0x0d);
 		saa_writeb(SAA7134_FIELD_HANDLING(TASK_A),  0x02);
 		saa_writeb(SAA7134_FIELD_HANDLING(TASK_B),  0x02);
+		split = 0;
 	} else {
 		/* split fields between tasks */
 		if (V4L2_FIELD_TOP == cap) {
@@ -494,7 +517,7 @@
 		   SAA7134_MAIN_CTRL_TE5 |
 		   SAA7134_MAIN_CTRL_TE6,
 		   ctrl);
-	dprintk("dmabits: task=0x%02lx ctrl=0x%02lx irq=0x%lx split=%s\n",
+	dprintk("dmabits: task=0x%02x ctrl=0x%02x irq=0x%x split=%s\n",
 		task, ctrl, irq, split ? "no" : "yes");
 
 	return 0;
@@ -508,12 +531,12 @@
 	"AR", "PE", "PWR_ON", "RDCAP", "INTL", "FIDT", "MMC",
 	"TRIG_ERR", "CONF_ERR", "LOAD_ERR"
 };
-#define IRQBITS (sizeof(irqbits)/sizeof(char*))
+#define IRQBITS ARRAY_SIZE(irqbits)
 
 static void print_irqstatus(struct saa7134_dev *dev, int loop,
 			    unsigned long report, unsigned long status)
 {
-	int i;
+	unsigned int i;
 	
 	printk(KERN_DEBUG "%s/irq[%d,%ld]: r=0x%lx s=0x%02lx",
 	       dev->name,loop,jiffies,report,status);
@@ -536,18 +559,19 @@
 {
 	struct saa7134_dev *dev = (struct saa7134_dev*) dev_id;
 	unsigned long report,status;
-	int loop;
+	int loop, handled = 0;
 
 	for (loop = 0; loop < 10; loop++) {
 		report = saa_readl(SAA7134_IRQ_REPORT);
 		status = saa_readl(SAA7134_IRQ_STATUS);
-		saa_writel(SAA7134_IRQ_REPORT,report);
 		if (0 == report) {
 			if (irq_debug > 1)
 				printk(KERN_DEBUG "%s/irq: no (more) work\n",
 				       dev->name);
 			goto out;
 		}
+		handled = 1;
+		saa_writel(SAA7134_IRQ_REPORT,report);
 		if (irq_debug)
 			print_irqstatus(dev,loop,report,status);
 
@@ -582,8 +606,9 @@
 		saa_writel(SAA7134_IRQ1,0);
 		saa_writel(SAA7134_IRQ2,0);
 	}
-out:
-	return IRQ_HANDLED;
+
+ out:
+	return IRQ_RETVAL(handled);
 }
 
 /* ------------------------------------------------------------------ */
@@ -599,8 +624,14 @@
 	saa7134_vbi_init(dev);
 	if (card_has_ts(dev))
 		saa7134_ts_init(dev);
-	if (card_has_audio(dev))
+
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		saa7134_oss_init(dev);
+		break;
+	}
 	
 	/* RAM FIFO config */
 	saa_writel(SAA7134_FIFO_SIZE, 0x08070503);
@@ -634,12 +665,15 @@
 	/* enable peripheral devices */
 	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
 
+	/* set vertical line numbering start (vbi needs this) */
+	saa_writeb(SAA7134_SOURCE_TIMING2, 0x20);
+	
 	return 0;
 }
 
 static void __devinit must_configure_manually(void)
 {
-	int i,p;
+	unsigned int i,p;
 
 	printk(KERN_WARNING
 	       "saa7134: <rant>\n"
@@ -675,18 +709,39 @@
 		return -ENOMEM;
 	memset(dev,0,sizeof(*dev));
 
-	/* pci stuff */
+	/* pci init */
 	dev->pci = pci_dev;
 	if (pci_enable_device(pci_dev)) {
 		err = -EIO;
 		goto fail1;
 	}
 	sprintf(dev->name,"saa%x[%d]",pci_dev->device,saa7134_devcount);
-	if (-1 != latency) {
+
+	/* pci quirks */
+	if (pci_pci_problems) {
+		if (pci_pci_problems & PCIPCI_TRITON)
+			printk(KERN_INFO "%s: quirk: PCIPCI_TRITON\n", dev->name);
+		if (pci_pci_problems & PCIPCI_NATOMA)
+			printk(KERN_INFO "%s: quirk: PCIPCI_NATOMA\n", dev->name);
+		if (pci_pci_problems & PCIPCI_VIAETBF)
+			printk(KERN_INFO "%s: quirk: PCIPCI_VIAETBF\n", dev->name);
+		if (pci_pci_problems & PCIPCI_VSFX)
+			printk(KERN_INFO "%s: quirk: PCIPCI_VSFX\n",dev->name);
+#ifdef PCIPCI_ALIMAGIK
+		if (pci_pci_problems & PCIPCI_ALIMAGIK) {
+			printk(KERN_INFO "%s: quirk: PCIPCI_ALIMAGIK -- latency fixup\n",
+			       dev->name);
+			latency = 0x0A;
+		}
+#endif
+	}
+	if (UNSET != latency) {
 		printk(KERN_INFO "%s: setting pci latency timer to %d\n",
 		       dev->name,latency);
 		pci_write_config_byte(pci_dev, PCI_LATENCY_TIMER, latency);
 	}
+
+	/* print pci info */
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
         pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
         printk(KERN_INFO "%s: found at %s, rev: %d, irq: %d, "
@@ -710,7 +765,7 @@
 		dev->board = SAA7134_BOARD_UNKNOWN;
 	}
 	dev->tuner_type = saa7134_boards[dev->board].tuner_type;
-	if (-1 != tuner[saa7134_devcount])
+	if (UNSET != tuner[saa7134_devcount])
 		dev->tuner_type = tuner[saa7134_devcount];
         printk(KERN_INFO "%s: subsystem: %04x:%04x, board: %s [card=%d,%s]\n",
 	       dev->name,pci_dev->subsystem_vendor,
@@ -730,6 +785,13 @@
 	dev->lmmio = ioremap(pci_resource_start(pci_dev,0), 0x1000);
 	dev->bmmio = (__u8*)dev->lmmio;
 
+	/* register i2c bus */
+	saa7134_i2c_register(dev);
+
+	/* initialize hardware */
+	saa7134_board_init(dev);
+	saa7134_hwinit(dev);
+
 	/* get irq */
 	err = request_irq(pci_dev->irq, saa7134_irq,
 			  SA_SHIRQ | SA_INTERRUPT, dev->name, dev);
@@ -739,12 +801,8 @@
 		goto fail2;
 	}
 
-	/* initialize hardware */
-	saa7134_hwinit(dev);
-
-	/* register i2c bus + load i2c helpers */
-	saa7134_i2c_register(dev);
-	if (TUNER_ABSENT != card(dev).tuner_type)
+	/* load i2c helpers */
+	if (TUNER_ABSENT != dev->tuner_type)
 		request_module("tuner");
 	if (saa7134_boards[dev->board].need_tda9887)
 		request_module("tda9887");
@@ -793,19 +851,27 @@
 	}
 
 	/* register oss devices */
-	if (card_has_audio(dev)) {
-		dev->oss.minor_dsp = register_sound_dsp(&saa7134_dsp_fops,dsp_nr);
-		if (dev->oss.minor_dsp < 0)
-			goto fail7;
-		printk(KERN_INFO "%s: registered device dsp%d\n",
-		       dev->name,dev->oss.minor_dsp >> 4);
-		
-		dev->oss.minor_mixer =
-			register_sound_mixer(&saa7134_mixer_fops,mixer_nr);
-		if (dev->oss.minor_mixer < 0)
-			goto fail8;
-		printk(KERN_INFO "%s: registered device mixer%d\n",
-		       dev->name,dev->oss.minor_mixer >> 4);
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		if (oss) {
+			err = dev->oss.minor_dsp =
+				register_sound_dsp(&saa7134_dsp_fops,dsp_nr);
+			if (err < 0) {
+				goto fail7;
+			}
+			printk(KERN_INFO "%s: registered device dsp%d\n",
+			       dev->name,dev->oss.minor_dsp >> 4);
+			
+			err = dev->oss.minor_mixer =
+				register_sound_mixer(&saa7134_mixer_fops,mixer_nr);
+			if (err < 0)
+				goto fail8;
+			printk(KERN_INFO "%s: registered device mixer%d\n",
+			       dev->name,dev->oss.minor_mixer >> 4);
+		}
+		break;
 	}
 
 	/* everything worked */
@@ -815,8 +881,14 @@
 	return 0;
 
  fail8:
-	if (card_has_audio(dev))
-		unregister_sound_dsp(dev->oss.minor_dsp);
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		if (oss)
+			unregister_sound_dsp(dev->oss.minor_dsp);
+		break;
+	}
  fail7:
 	if (card_has_radio(dev))
 		video_unregister_device(&dev->radio_dev);
@@ -828,16 +900,21 @@
  fail4:
 	video_unregister_device(&dev->video_dev);
  fail3:
-	if (card_has_audio(dev))
+	saa7134_i2c_unregister(dev);
+	free_irq(pci_dev->irq, dev);
+ fail2:
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		saa7134_oss_fini(dev);
+		break;
+	}
 	if (card_has_ts(dev))
 		saa7134_ts_fini(dev);
 	saa7134_vbi_fini(dev);
 	saa7134_video_fini(dev);
 	saa7134_tvaudio_fini(dev);
-	saa7134_i2c_unregister(dev);
-	free_irq(pci_dev->irq, dev);
- fail2:
 	release_mem_region(pci_resource_start(pci_dev,0),
 			   pci_resource_len(pci_dev,0));
  fail1:
@@ -849,6 +926,13 @@
 {
         struct saa7134_dev *dev = pci_get_drvdata(pci_dev);
 
+	/* debugging ... */
+	if (irq_debug) {
+		u32 report = saa_readl(SAA7134_IRQ_REPORT);
+		u32 status = saa_readl(SAA7134_IRQ_STATUS);
+		print_irqstatus(dev,42,report,status);
+	}
+
 	/* disable peripheral devices */
 	saa_writeb(SAA7134_SPECIAL_MODE,0);
 
@@ -858,8 +942,13 @@
 	saa_writel(SAA7134_MAIN_CTRL,0);
 
 	/* shutdown subsystems */
-	if (card_has_audio(dev))
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
 		saa7134_oss_fini(dev);
+		break;
+	}
 	if (card_has_ts(dev))
 		saa7134_ts_fini(dev);
 	saa7134_vbi_fini(dev);
@@ -874,9 +963,15 @@
 
 	/* unregister */
 	saa7134_i2c_unregister(dev);
-	if (card_has_audio(dev)) {
-		unregister_sound_mixer(dev->oss.minor_mixer);
-		unregister_sound_dsp(dev->oss.minor_dsp);
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		if (oss) {
+			unregister_sound_mixer(dev->oss.minor_mixer);
+			unregister_sound_dsp(dev->oss.minor_dsp);
+		}
+		break;
 	}
 	if (card_has_radio(dev))
 		video_unregister_device(&dev->radio_dev);
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-i2c.c	2003-05-08 13:30:00.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2003-05-08 13:55:12.000000000 +0200
@@ -153,10 +153,7 @@
 		status = i2c_get_status(dev);
 		if (!i2c_is_busy(status))
 			break;
-		if (need_resched())
-                        schedule();
-		else
-			udelay(I2C_WAIT_DELAY);
+		saa_wait(I2C_WAIT_DELAY);
 	}
 	if (I2C_WAIT_RETRY == count)
 		return FALSE;
@@ -318,7 +315,7 @@
 static int attach_inform(struct i2c_client *client)
 {
         struct saa7134_dev *dev = client->adapter->algo_data;
-	int tuner = card(dev).tuner_type;
+	int tuner = dev->tuner_type;
 
 	saa7134_i2c_call_clients(dev,TUNER_SET_TYPE,&tuner);
         return 0;
@@ -334,9 +331,9 @@
 
 static struct i2c_adapter saa7134_adap_template = {
 	.owner         = THIS_MODULE,
+	.class         = I2C_ADAP_CLASS_TV_ANALOG,
 	I2C_DEVNAME("saa7134"),
 	.id            = I2C_ALGO_SAA7134,
-	.class         = I2C_ADAP_CLASS_TV_ANALOG,
 	.algo          = &saa7134_algo,
 	.client_register = attach_inform,
 };
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-oss.c	2003-05-08 13:30:55.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2003-05-08 13:55:12.000000000 +0200
@@ -94,8 +94,9 @@
 
 static int dsp_rec_start(struct saa7134_dev *dev)
 {
-	int err, fmt, bswap, wswap;
-	unsigned long control,flags;
+	int err, bswap, sign;
+	u32 fmt, control;
+	unsigned long flags;
 
 	/* prepare buffer */
 	if (0 != (err = videobuf_dma_pci_map(dev->pci,&dev->oss.dma)))
@@ -110,45 +111,60 @@
 
 	/* sample format */
 	switch (dev->oss.afmt) {
-	case AFMT_U8:     fmt = 0x00;         break;
-	case AFMT_S8:     fmt = 0x00 | 0x04;  break;
+	case AFMT_U8:
+	case AFMT_S8:     fmt = 0x00;  break;
 	case AFMT_U16_LE:
-	case AFMT_U16_BE: fmt = 0x01;         break;
+	case AFMT_U16_BE:
 	case AFMT_S16_LE:
-	case AFMT_S16_BE: fmt = 0x01 | 0x04;  break;
-/* 4front API specs mention these ones,
-   the (2.4.15) kernel header hasn't them ... */
-#ifdef AFMT_S32_LE
-	case AFMT_S32_LE:
-	case AFMT_S32_BE: fmt = 0x02 | 0x04;  break;
-#endif
+	case AFMT_S16_BE: fmt = 0x01;  break;
 	default:
 		err = -EINVAL;
 		goto fail2;
 	}
 
 	switch (dev->oss.afmt) {
+	case AFMT_S8:     
+	case AFMT_S16_LE:
+	case AFMT_S16_BE: sign = 1; break;
+	default:          sign = 0; break;
+	}
+
+	switch (dev->oss.afmt) {
 	case AFMT_U16_BE:
-	case AFMT_S16_BE: bswap = 1; wswap = 0; break;
-#ifdef AFMT_S32_LE
-	case AFMT_S32_BE: bswap = 1; wswap = 1; break;
-#endif
-	default:          bswap = 0; wswap = 0; break;
+	case AFMT_S16_BE: bswap = 1; break;
+	default:          bswap = 0; break;
 	}
 
-	if (1 == dev->oss.channels)
-		fmt |= (1 << 3);
-	if (2 == dev->oss.channels)
-		fmt |= (3 << 3);
-	fmt |= (TV == dev->oss.input) ? 0xc0 : 0x80;
-	
-	saa_writeb(SAA7134_NUM_SAMPLES0, (dev->oss.blksize & 0x0000ff));
-	saa_writeb(SAA7134_NUM_SAMPLES1, (dev->oss.blksize & 0x00ff00) >>  8);
-	saa_writeb(SAA7134_NUM_SAMPLES2, (dev->oss.blksize & 0xff0000) >> 16);
-	saa_writeb(SAA7134_AUDIO_FORMAT_CTRL, fmt);
-	dprintk("rec_start: afmt=%d ch=%d  =>  fmt=0x%x swap=%c%c\n",
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		if (1 == dev->oss.channels)
+			fmt |= (1 << 3);
+		if (2 == dev->oss.channels)
+			fmt |= (3 << 3);
+		if (sign)
+			fmt |= 0x04;
+		fmt |= (TV == dev->oss.input) ? 0xc0 : 0x80;
+		
+		saa_writeb(SAA7134_NUM_SAMPLES0, (dev->oss.blksize & 0x0000ff));
+		saa_writeb(SAA7134_NUM_SAMPLES1, (dev->oss.blksize & 0x00ff00) >>  8);
+		saa_writeb(SAA7134_NUM_SAMPLES2, (dev->oss.blksize & 0xff0000) >> 16);
+		saa_writeb(SAA7134_AUDIO_FORMAT_CTRL, fmt);
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		if (1 == dev->oss.channels)
+			fmt |= (1 << 4);
+		if (2 == dev->oss.channels)
+			fmt |= (2 << 4);
+		if (!sign)
+			fmt |= 0x04;
+		saa_writel(0x588 >> 2, dev->oss.blksize);
+		saa_writel(0x58c >> 2, 0x543210 | (fmt << 24));
+		break;
+	}
+	dprintk("rec_start: afmt=%d ch=%d  =>  fmt=0x%x swap=%c\n",
 		dev->oss.afmt, dev->oss.channels, fmt,
-		bswap ? 'b' : '-', wswap ? 'w' : '-');
+		bswap ? 'b' : '-');
 
 	/* dma: setup channel 6 (= AUDIO) */
 	control = SAA7134_RS_CONTROL_BURST_16 |
@@ -156,8 +172,6 @@
 		(dev->oss.pt.dma >> 12);
 	if (bswap)
 		control |= SAA7134_RS_CONTROL_BSWAP;
-	if (wswap)
-		control |= SAA7134_RS_CONTROL_WSWAP;
 	saa_writel(SAA7134_RS_BA1(6),0);
 	saa_writel(SAA7134_RS_BA2(6),dev->oss.blksize);
 	saa_writel(SAA7134_RS_PITCH(6),0);
@@ -201,7 +215,7 @@
 
 static int dsp_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = minor(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct saa7134_dev *h,*dev = NULL;
 	struct list_head *list;
 	int err;
@@ -259,7 +273,8 @@
 {
 	struct saa7134_dev *dev = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
-	int bytes,err,ret = 0;
+	unsigned int bytes;
+	int err,ret = 0;
 
 	add_wait_queue(&dev->oss.wq, &wait);
 	down(&dev->oss.lock);
@@ -390,10 +405,6 @@
 		case AFMT_U16_BE:
 		case AFMT_S16_LE:
 		case AFMT_S16_BE:
-#ifdef AFMT_S32_LE
-		case AFMT_S32_LE:
-		case AFMT_S32_BE:
-#endif
 			down(&dev->oss.lock);
 			dev->oss.afmt = val;
 			if (dev->oss.recording) {
@@ -416,11 +427,6 @@
 		case AFMT_S16_LE:
 		case AFMT_S16_BE:
 			return put_user(16, (int*)arg);
-#ifdef AFMT_S32_LE
-		case AFMT_S32_LE:
-		case AFMT_S32_BE:
-			return put_user(20, (int*)arg);
-#endif
 		default:
 			return -EINVAL;
 		}
@@ -499,14 +505,10 @@
 /* ------------------------------------------------------------------ */
 
 static int
-mixer_recsrc(struct saa7134_dev *dev, enum saa7134_audio_in src)
+mixer_recsrc_7134(struct saa7134_dev *dev)
 {
-	static const char *iname[] = { "Oops", "TV", "LINE1", "LINE2" };
 	int analog_io,rate;
 	
-	dev->oss.count++;
-	dev->oss.input = src;
-	dprintk("mixer input = %s\n",iname[dev->oss.input]);
 	switch (dev->oss.input) {
 	case TV:
 		saa_andorb(SAA7134_AUDIO_FORMAT_CTRL, 0xc0, 0xc0);
@@ -525,27 +527,78 @@
 }
 
 static int
-mixer_level(struct saa7134_dev *dev, enum saa7134_audio_in src, int level)
+mixer_recsrc_7133(struct saa7134_dev *dev)
 {
-	switch (src) {
+	u32 value = 0xbbbbbb;
+	
+	switch (dev->oss.input) {
 	case TV:
-		/* nothing */
+		value = 0xbbbb10;  /* MAIN */
 		break;
 	case LINE1:
-		saa_andorb(SAA7134_ANALOG_IO_SELECT,  0x10,
-			   (100 == level) ? 0x00 : 0x10);
+		value = 0xbbbb32;  /* AUX1 */
 		break;
 	case LINE2:
-		saa_andorb(SAA7134_ANALOG_IO_SELECT,  0x20,
-			   (100 == level) ? 0x00 : 0x20);
+		value = 0xbbbb54;  /* AUX2 */
 		break;
 	}
+	saa_dsp_writel(dev, 0x46c >> 2, value);
 	return 0;
 }
 
+static int
+mixer_recsrc(struct saa7134_dev *dev, enum saa7134_audio_in src)
+{
+	static const char *iname[] = { "Oops", "TV", "LINE1", "LINE2" };
+
+	dev->oss.count++;
+	dev->oss.input = src;
+	dprintk("mixer input = %s\n",iname[dev->oss.input]);
+
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		mixer_recsrc_7134(dev);
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		mixer_recsrc_7133(dev);
+		break;
+	}
+	return 0;
+}
+
+static int
+mixer_level(struct saa7134_dev *dev, enum saa7134_audio_in src, int level)
+{
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		switch (src) {
+		case TV:
+			/* nothing */
+			break;
+		case LINE1:
+			saa_andorb(SAA7134_ANALOG_IO_SELECT,  0x10,
+				   (100 == level) ? 0x00 : 0x10);
+			break;
+		case LINE2:
+			saa_andorb(SAA7134_ANALOG_IO_SELECT,  0x20,
+				   (100 == level) ? 0x00 : 0x20);
+			break;
+		}
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		/* nothing */
+		break;
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+
 static int mixer_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = minor(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct saa7134_dev *h,*dev = NULL;
 	struct list_head *list;
 
@@ -681,13 +734,20 @@
 
 int saa7134_oss_init(struct saa7134_dev *dev)
 {
+	/* general */
         init_MUTEX(&dev->oss.lock);
 	init_waitqueue_head(&dev->oss.wq);
-	dev->oss.line1 = 50;
-	dev->oss.line2 = 50;
-	mixer_level(dev,LINE1,dev->oss.line1);
-	mixer_level(dev,LINE2,dev->oss.line2);
-	
+
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		saa_writel(0x588 >> 2, 0x00000fff);
+		saa_writel(0x58c >> 2, 0x00543210);
+		saa_dsp_writel(dev, 0x46c >> 2, 0xbbbbbb);
+		break;
+	}
+
+	/* dsp */
 	dev->oss.rate = 32000;
 	if (oss_rate)
 		dev->oss.rate = oss_rate;
@@ -695,7 +755,13 @@
 		dev->oss.rate = saa7134_boards[dev->board].i2s_rate;
 	dev->oss.rate = (dev->oss.rate > 40000) ? 48000 : 32000;
 
+	/* mixer */
+	dev->oss.line1 = 50;
+	dev->oss.line2 = 50;
+	mixer_level(dev,LINE1,dev->oss.line1);
+	mixer_level(dev,LINE2,dev->oss.line2);
 	mixer_recsrc(dev, (dev->oss.rate == 32000) ? TV : LINE2);
+	
 	return 0;
 }
 
@@ -710,7 +776,7 @@
 	int next_blk, reg = 0;
 
 	spin_lock(&dev->slock);
-	if (-1 == dev->oss.dma_blk) {
+	if (UNSET == dev->oss.dma_blk) {
 		dprintk("irq: recording stopped%s\n","");
 		goto done;
 	}
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-reg.h linux/drivers/media/video/saa7134/saa7134-reg.h
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-reg.h	2003-05-08 13:31:33.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-reg.h	2003-05-08 13:55:12.000000000 +0200
@@ -9,9 +9,15 @@
 #ifndef PCI_DEVICE_ID_PHILIPS_SAA7130
 # define PCI_DEVICE_ID_PHILIPS_SAA7130 0x7130
 #endif
+#ifndef PCI_DEVICE_ID_PHILIPS_SAA7133
+# define PCI_DEVICE_ID_PHILIPS_SAA7133 0x7133
+#endif
 #ifndef PCI_DEVICE_ID_PHILIPS_SAA7134
 # define PCI_DEVICE_ID_PHILIPS_SAA7134 0x7134
 #endif
+#ifndef PCI_DEVICE_ID_PHILIPS_SAA7135
+# define PCI_DEVICE_ID_PHILIPS_SAA7135 0x7135
+#endif
 
 /* ------------------------------------------------------------------ */
 /*
@@ -329,6 +335,13 @@
 /* test modes */
 #define SAA7134_SPECIAL_MODE                    0x1d0
 
+/* audio -- saa7133 + saa7135 only */
+#define SAA7135_DSP_RWSTATE                     0x580
+#define SAA7135_DSP_RWSTATE_ERR                 (1 << 3)
+#define SAA7135_DSP_RWSTATE_IDA                 (1 << 2)
+#define SAA7135_DSP_RWSTATE_RDB                 (1 << 1)
+#define SAA7135_DSP_RWSTATE_WRR                 (1 << 0)
+
 /* ------------------------------------------------------------------ */
 /*
  * Local variables:
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-ts.c linux/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-ts.c	2003-05-08 13:29:45.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-ts.c	2003-05-08 13:55:12.000000000 +0200
@@ -52,8 +52,9 @@
 {
 	u32 control;
 	
-	dprintk("buffer_activate [%p]\n",buf);
+	dprintk("buffer_activate [%p]",buf);
 	buf->vb.state = STATE_ACTIVE;
+	buf->top_seen = 0;
 	
         /* dma: setup channel 5 (= TS) */
         control = SAA7134_RS_CONTROL_BURST_16 |
@@ -63,11 +64,11 @@
 	if (NULL == next)
 		next = buf;
 	if (V4L2_FIELD_TOP == buf->vb.field) {
-		dprintk("[top]     buf=%p next=%p",buf,next);
+		dprintk("- [top]     buf=%p next=%p\n",buf,next);
 		saa_writel(SAA7134_RS_BA1(5),saa7134_buffer_base(buf));
 		saa_writel(SAA7134_RS_BA2(5),saa7134_buffer_base(next));
 	} else {
-		dprintk("[bottom]  buf=%p next=%p",buf,next);
+		dprintk("- [bottom]  buf=%p next=%p\n",buf,next);
 		saa_writel(SAA7134_RS_BA1(5),saa7134_buffer_base(next));
 		saa_writel(SAA7134_RS_BA2(5),saa7134_buffer_base(buf));
 	}
@@ -86,8 +87,11 @@
 {
 	struct saa7134_dev *dev = file->private_data;
 	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	int lines, llength, size, err;
+	unsigned int lines, llength, size;
+	int err;
 	
+	dprintk("buffer_prepare [%p,%s]\n",buf,v4l2_field_names[field]);
+
 	llength = TS_PACKET_SIZE;
 	lines = TS_NR_PACKETS;
 	
@@ -116,7 +120,6 @@
 			goto oops;
 	}
 	buf->vb.state = STATE_PREPARED;
-	buf->top_seen = 0;
 	buf->activate = buffer_activate;
 	buf->vb.field = field;
 	return 0;
@@ -163,7 +166,7 @@
 
 static int ts_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = minor(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct saa7134_dev *h,*dev = NULL;
 	struct list_head *list;
 	int err;
@@ -414,6 +417,7 @@
 	dev->ts_q.timeout.function = saa7134_buffer_timeout;
 	dev->ts_q.timeout.data     = (unsigned long)(&dev->ts_q);
 	dev->ts_q.dev              = dev;
+	dev->ts_q.need_two         = 1;
 	videobuf_queue_init(&dev->ts.ts, &ts_qops, dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_ALTERNATE,
@@ -445,7 +449,7 @@
 
 	spin_lock(&dev->slock);
 	if (dev->ts_q.curr) {
-		field = dev->video_q.curr->vb.field;
+		field = dev->ts_q.curr->vb.field;
 		if (field == V4L2_FIELD_TOP) {
 			if ((status & 0x100000) != 0x100000)
 				goto done;
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-05-08 13:29:43.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-05-08 13:55:12.000000000 +0200
@@ -37,13 +37,23 @@
 MODULE_PARM(audio_debug,"i");
 MODULE_PARM_DESC(audio_debug,"enable debug messages [tv audio]");
 
+static unsigned int audio_carrier = 0;
+MODULE_PARM(audio_carrier,"i");
+MODULE_PARM_DESC(audio_carrier,"audio carrier location");
+
 #define dprintk(fmt, arg...)	if (audio_debug) \
 	printk(KERN_DEBUG "%s/audio: " fmt, dev->name, ## arg)
+#define d2printk(fmt, arg...)	if (audio_debug > 1) \
+	printk(KERN_DEBUG "%s/audio: " fmt, dev->name, ## arg)
 
 #define print_regb(reg) printk("%s:   reg 0x%03x [%-16s]: 0x%02x\n", \
 		dev->name,(SAA7134_##reg),(#reg),saa_readb((SAA7134_##reg)))
 
+#define SCAN_INITIAL_DELAY  (HZ)
+#define SCAN_SAMPLE_DELAY   (HZ/10)
+
 /* ------------------------------------------------------------------ */
+/* saa7134 code                                                       */
 
 static struct saa7134_tvaudio tvaudio[] = {
 	{
@@ -95,6 +105,12 @@
 		.carr2         = 5850,
 		.mode          = TVAUDIO_NICAM_AM,
 	},{
+		.name          = "SECAM-D/K",
+		.std           = V4L2_STD_SECAM,
+		.carr1         = 6500,
+		.carr2         = -1,
+		.mode          = TVAUDIO_FM_MONO,
+	},{
 		.name          = "NTSC-M",
 		.std           = V4L2_STD_NTSC,
 		.carr1         = 4500,
@@ -122,7 +138,7 @@
 		schedule();
 	else
 		udelay(10);
-		
+
 	saa_writeb(SAA7134_AUDIO_CLOCK0,      clock        & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK1,     (clock >>  8) & 0xff);
 	saa_writeb(SAA7134_AUDIO_CLOCK2,     (clock >> 16) & 0xff);
@@ -134,9 +150,9 @@
 	saa_writeb(SAA7134_FM_DEMATRIX,      0x80);
 }
 
-static __u32 tvaudio_carr2reg(__u32 carrier)
+static u32 tvaudio_carr2reg(u32 carrier)
 {
-	__u64 a = carrier;
+	u64 a = carrier;
 
 	a <<= 24;
 	do_div(a,12288);
@@ -152,17 +168,19 @@
 	saa_writel(SAA7134_CARRIER2_FREQ0 >> 2, tvaudio_carr2reg(secondary));
 }
 
-static void saa7134_tvaudio_do_mute_input(struct saa7134_dev *dev)
+static void mute_input_7134(struct saa7134_dev *dev)
 {
-	int mute;
+	unsigned int mute;
 	struct saa7134_input *in;
 	int reg = 0;
 	int mask;
 
 	/* look what is to do ... */
 	in   = dev->input;
-	mute = (dev->ctl_mute || dev->automute);
-	if (!card_has_audio(dev) && card(dev).mute.name) {
+	mute = (dev->ctl_mute ||
+		(dev->automute  &&  (&card(dev).radio) != in));
+	if (PCI_DEVICE_ID_PHILIPS_SAA7130 == dev->pci->device &&
+	    card(dev).mute.name) {
 		/* 7130 - we'll mute using some unconnected audio input */
 		if (mute)
 			in = &card(dev).mute;
@@ -171,14 +189,12 @@
 	    dev->hw_input == in)
 		return;
 
-#if 1
 	dprintk("ctl_mute=%d automute=%d input=%s  =>  mute=%d input=%s\n",
 		dev->ctl_mute,dev->automute,dev->input->name,mute,in->name);
-#endif
 	dev->hw_mute  = mute;
 	dev->hw_input = in;
 
-	if (card_has_audio(dev))
+	if (PCI_DEVICE_ID_PHILIPS_SAA7134 == dev->pci->device)
 		/* 7134 mute */
 		saa_writeb(SAA7134_AUDIO_MUTE_CTRL, mute ? 0xff : 0xbb);
 
@@ -199,25 +215,6 @@
 	saa7134_track_gpio(dev,in->name);
 }
 
-void saa7134_tvaudio_setmute(struct saa7134_dev *dev)
-{
-	saa7134_tvaudio_do_mute_input(dev);
-}
-
-void saa7134_tvaudio_setinput(struct saa7134_dev *dev,
-			      struct saa7134_input *in)
-{
-	dev->input = in;
-	saa7134_tvaudio_do_mute_input(dev);
-}
-
-void saa7134_tvaudio_setvolume(struct saa7134_dev *dev, int level)
-{
-	saa_writeb(SAA7134_CHANNEL1_LEVEL,     level & 0x1f);
-	saa_writeb(SAA7134_CHANNEL2_LEVEL,     level & 0x1f);
-	saa_writeb(SAA7134_NICAM_LEVEL_ADJUST, level & 0x1f);
-}
-
 static void tvaudio_setmode(struct saa7134_dev *dev,
 			    struct saa7134_tvaudio *audio,
 			    char *note)
@@ -274,8 +271,77 @@
 	saa_writel(0x174 >> 2, 0x0001e000); /* FIXME */
 }
 
-int saa7134_tvaudio_getstereo(struct saa7134_dev *dev,
-			      struct saa7134_tvaudio *audio)
+static int tvaudio_sleep(struct saa7134_dev *dev, int timeout)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	
+	add_wait_queue(&dev->thread.wq, &wait);
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(timeout);
+	remove_wait_queue(&dev->thread.wq, &wait);
+	return dev->thread.scan1 != dev->thread.scan2;
+}
+
+static int tvaudio_checkcarrier(struct saa7134_dev *dev, int carrier)
+{
+	__s32 left,right,value;
+
+	if (audio_debug > 1) {
+		int i;
+		dprintk("debug %d:",carrier);
+		for (i = -150; i <= 150; i += 30) {
+			tvaudio_setcarrier(dev,carrier+i,carrier+i);
+			saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+			if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
+				return -1;
+			value = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+			if (0 == i)
+				printk("  #  %6d  # ",value >> 16);
+			else
+				printk(" %6d",value >> 16);
+		}
+		printk("\n");
+	}
+	
+	tvaudio_setcarrier(dev,carrier-90,carrier-90);
+	saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+	if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
+		return -1;
+	left = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+
+	tvaudio_setcarrier(dev,carrier+90,carrier+90);
+	saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+	if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
+		return -1;
+	right = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+
+	left >>= 16;
+        right >>= 16;
+	value = left > right ? left - right : right - left;
+	dprintk("scanning %d.%03d MHz =>  dc is %5d [%d/%d]\n",
+		carrier/1000,carrier%1000,value,left,right);
+	return value;
+}
+
+#if 0
+static void sifdebug_dump_regs(struct saa7134_dev *dev)
+{
+	print_regb(AUDIO_STATUS);
+	print_regb(IDENT_SIF);
+	print_regb(LEVEL_READOUT1);
+	print_regb(LEVEL_READOUT2);
+	print_regb(DCXO_IDENT_CTRL);
+	print_regb(DEMODULATOR);
+	print_regb(AGC_GAIN_SELECT);
+	print_regb(MONITOR_SELECT);
+	print_regb(FM_DEEMPHASIS);
+	print_regb(FM_DEMATRIX);
+	print_regb(SIF_SAMPLE_FREQ);
+	print_regb(ANALOG_IO_SELECT);
+}
+#endif
+
+static int tvaudio_getstereo(struct saa7134_dev *dev, struct saa7134_tvaudio *audio)
 {
 	__u32 idp,nicam;
 	int retval = -1;
@@ -321,62 +387,42 @@
 	return retval;
 }
 
-static int tvaudio_sleep(struct saa7134_dev *dev, int timeout)
+static int tvaudio_setstereo(struct saa7134_dev *dev, struct saa7134_tvaudio *audio,
+			     u32 mode)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	
-	add_wait_queue(&dev->thread.wq, &wait);
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(timeout);
-	remove_wait_queue(&dev->thread.wq, &wait);
-	return dev->thread.scan1 != dev->thread.scan2;
-}
-
-static int tvaudio_checkcarrier(struct saa7134_dev *dev, int carrier)
-{
-	__s32 left,right,value;
-	
-	tvaudio_setcarrier(dev,carrier-100,carrier-100);
-	if (tvaudio_sleep(dev,HZ/10))
-		return -1;
-	left = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-	if (tvaudio_sleep(dev,HZ/10))
-		return -1;
-	left = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-
-	tvaudio_setcarrier(dev,carrier+100,carrier+100);
-	if (tvaudio_sleep(dev,HZ/10))
-		return -1;
-        right = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-	if (tvaudio_sleep(dev,HZ/10))
-		return -1;
-	right = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+	static char *name[] = {
+		[ V4L2_TUNER_MODE_MONO   ] = "mono",
+		[ V4L2_TUNER_MODE_STEREO ] = "stereo",
+		[ V4L2_TUNER_MODE_LANG1  ] = "lang1",
+		[ V4L2_TUNER_MODE_LANG2  ] = "lang2",
+	};
+	static u32 fm[] = {
+		[ V4L2_TUNER_MODE_MONO   ] = 0x00,  /* ch1  */
+		[ V4L2_TUNER_MODE_STEREO ] = 0x80,  /* auto */
+		[ V4L2_TUNER_MODE_LANG1  ] = 0x00,  /* ch1  */
+		[ V4L2_TUNER_MODE_LANG2  ] = 0x01,  /* ch2  */
+	};
+	u32 reg;
 
-	left >>= 16;
-        right >>= 16;
-	value = left > right ? left - right : right - left;
-	dprintk("scanning %d.%03d MHz =>  dc is %5d [%d/%d]\n",
-		carrier/1000,carrier%1000,value,left,right);
-	return value;
-}
-
-#if 0
-static void sifdebug_dump_regs(struct saa7134_dev *dev)
-{
-	print_regb(AUDIO_STATUS);
-	print_regb(IDENT_SIF);
-	print_regb(LEVEL_READOUT1);
-	print_regb(LEVEL_READOUT2);
-	print_regb(DCXO_IDENT_CTRL);
-	print_regb(DEMODULATOR);
-	print_regb(AGC_GAIN_SELECT);
-	print_regb(MONITOR_SELECT);
-	print_regb(FM_DEEMPHASIS);
-	print_regb(FM_DEMATRIX);
-	print_regb(SIF_SAMPLE_FREQ);
-	print_regb(ANALOG_IO_SELECT);
+	switch (audio->mode) {
+	case TVAUDIO_FM_MONO:
+		/* nothing to do ... */
+		break;
+	case TVAUDIO_FM_K_STEREO:
+	case TVAUDIO_FM_BG_STEREO:
+		dprintk("setstereo [fm] => %s\n",
+			name[ mode % ARRAY_SIZE(name) ]);
+		reg = fm[ mode % ARRAY_SIZE(fm) ];
+		saa_writeb(SAA7134_FM_DEMATRIX, reg);
+		break;
+	case TVAUDIO_FM_SAT_STEREO:
+	case TVAUDIO_NICAM_AM:
+	case TVAUDIO_NICAM_FM:
+		/* FIXME */
+		break;
+	}
+	return 0;
 }
-#endif
 
 static int tvaudio_thread(void *data)
 {
@@ -388,7 +434,8 @@
 	struct saa7134_dev *dev = data;
 	const int *carr_scan;
 	int carr_vals[4];
-	int i,max,carrier,audio;
+	unsigned int i, audio;
+	int max1,max2,carrier,rx,mode;
 
 	lock_kernel();
 	daemonize("%s", dev->name);
@@ -410,10 +457,10 @@
 		dev->tvaudio  = NULL;
 		tvaudio_init(dev);
 		dev->automute = 1;
-		saa7134_tvaudio_setmute(dev);
+		mute_input_7134(dev);
 
 		/* give the tuner some time */
-		if (tvaudio_sleep(dev,HZ/2))
+		if (tvaudio_sleep(dev,SCAN_INITIAL_DELAY))
 			goto restart;
 
 		/* find the main carrier */
@@ -433,55 +480,280 @@
 			if (dev->thread.scan1 != dev->thread.scan2)
 				goto restart;
 		}
-		for (carrier = 0, max = 0, i = 0; i < MAX_SCAN; i++) {
+		for (carrier = 0, max1 = 0, max2 = 0, i = 0; i < MAX_SCAN; i++) {
 			if (!carr_scan[i])
 				continue;
-			if (max < carr_vals[i]) {
-				max = carr_vals[i];
+			if (max1 < carr_vals[i]) {
+				max2 = max1;
+				max1 = carr_vals[i];
 				carrier = carr_scan[i];
+			} else if (max2 < carr_vals[i]) {
+				max2 = carr_vals[i];
 			}
 		}
-		if (0 == carrier) {
-			/* Oops: autoscan didn't work for some reason :-/ */
-			printk(KERN_WARNING "%s/audio: oops: audio carrier "
-			       "scan failed\n", dev->name);
+
+		if (0 != carrier && max1 > 2000 && max1 > max2*3) {
+			/* found good carrier */
+			dprintk("found %s main sound carrier @ %d.%03d MHz [%d/%d]\n",
+				dev->tvnorm->name, carrier/1000, carrier%1000,
+				max1, max2);
+			dev->last_carrier = carrier;
+		} else if (0 != audio_carrier) {
+			/* no carrier -- try insmod option as fallback */
+			carrier = audio_carrier;
+			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
+			       "using %d.%03d MHz [insmod option]\n",
+			       dev->name, carrier/1000, carrier%1000);
+		} else if (0 != dev->last_carrier) {
+			/* no carrier -- try last detected one as fallback */
+			carrier = dev->last_carrier;
+			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
+			       "using %d.%03d MHz [last detected]\n",
+			       dev->name, carrier/1000, carrier%1000);
 		} else {
-			dprintk("found %s main sound carrier @ %d.%03d MHz\n",
-				dev->tvnorm->name,
-				carrier/1000,carrier%1000);
+			/* no carrier + no fallback -- try first in list */
+			carrier = carr_scan[0];
+			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
+			       "using %d.%03d MHz [default]\n",
+			       dev->name, carrier/1000, carrier%1000);
 		}
 		tvaudio_setcarrier(dev,carrier,carrier);
 		dev->automute = 0;
+		saa_andorb(SAA7134_STEREO_DAC_OUTPUT_SELECT, 0x30, 0x00);
 		saa7134_tvaudio_setmute(dev);
 
 		/* find the exact tv audio norm */
-		for (audio = -1, i = 0; i < TVAUDIO; i++) {
-			if (dev->tvnorm->id != -1 &&
+		for (audio = UNSET, i = 0; i < TVAUDIO; i++) {
+			if (dev->tvnorm->id != UNSET &&
 			    dev->tvnorm->id != tvaudio[i].std)
 				continue;
 			if (tvaudio[i].carr1 != carrier)
 				continue;
 
-			if (-1 == audio)
+			if (UNSET == audio)
 				audio = i;
 			tvaudio_setmode(dev,&tvaudio[i],"trying");
 			if (tvaudio_sleep(dev,HZ))
 				goto restart;
-			if (-1 != saa7134_tvaudio_getstereo(dev,&tvaudio[i])) {
+			if (-1 != tvaudio_getstereo(dev,&tvaudio[i])) {
 				audio = i;
 				break;
 			}
 		}
-		if (-1 == audio)
+		saa_andorb(SAA7134_STEREO_DAC_OUTPUT_SELECT, 0x30, 0x30);
+		if (UNSET == audio)
 			continue;
 		tvaudio_setmode(dev,&tvaudio[audio],"using");
+		tvaudio_setstereo(dev,&tvaudio[audio],V4L2_TUNER_MODE_MONO);
 		dev->tvaudio = &tvaudio[audio];
 
-#if 1
 		if (tvaudio_sleep(dev,3*HZ))
 			goto restart;
-		saa7134_tvaudio_getstereo(dev,&tvaudio[i]);
+		rx = tvaudio_getstereo(dev,&tvaudio[i]);
+		mode = saa7134_tvaudio_rx2mode(rx);
+		tvaudio_setstereo(dev,&tvaudio[audio],mode);
+	}
+
+ done:
+	dev->thread.task = NULL;
+	if(dev->thread.notify != NULL)
+		up(dev->thread.notify);
+	return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* saa7133 / saa7135 code                                             */
+
+static char *stdres[0x20] = {
+	[0x00] = "no standard detected",
+	[0x01] = "B/G (in progress)",
+	[0x02] = "D/K (in progress)",
+	[0x03] = "M (in progress)",
+
+	[0x04] = "B/G A2",
+	[0x05] = "B/G NICAM",
+	[0x06] = "D/K A2 (1)",
+	[0x07] = "D/K A2 (2)",
+	[0x08] = "D/K A2 (3)",
+	[0x09] = "D/K NICAM",
+	[0x0a] = "L NICAM",
+	[0x0b] = "I NICAM",
+	
+	[0x0c] = "M Korea",
+	[0x0d] = "M BTSC ",
+	[0x0e] = "M EIAJ",
+
+	[0x0f] = "FM radio / IF 10.7 / 50 deemp",
+	[0x10] = "FM radio / IF 10.7 / 75 deemp",
+	[0x11] = "FM radio / IF sel / 50 deemp",
+	[0x12] = "FM radio / IF sel / 75 deemp",
+
+	[0x13 ... 0x1e ] = "unknown",
+	[0x1f] = "??? [in progress]",
+};
+
+#define DSP_RETRY 16
+#define DSP_DELAY 16
+
+static inline int saa_dsp_wait_bit(struct saa7134_dev *dev, int bit)
+{
+	int state, count = DSP_RETRY;
+
+	state = saa_readb(SAA7135_DSP_RWSTATE);
+	if (unlikely(state & SAA7135_DSP_RWSTATE_ERR)) {
+		printk("%s: dsp access error\n",dev->name);
+		/* FIXME: send ack ... */
+		return -EIO;
+	}
+	while (0 == (state & bit)) {
+		if (unlikely(0 == count)) {
+			printk("%s: dsp access wait timeout [bit=%s]\n",
+			       dev->name,
+			       (bit & SAA7135_DSP_RWSTATE_WRR) ? "WRR" :
+			       (bit & SAA7135_DSP_RWSTATE_RDB) ? "RDB" :
+			       (bit & SAA7135_DSP_RWSTATE_IDA) ? "IDA" :
+			       "???");
+			return -EIO;
+		}
+		saa_wait(DSP_DELAY);
+		state = saa_readb(SAA7135_DSP_RWSTATE);
+		count--;
+	}
+	return 0;
+}
+
+#if 0
+static int saa_dsp_readl(struct saa7134_dev *dev, int reg, u32 *value)
+{
+	int err;
+
+	d2printk("dsp read reg 0x%x\n", reg<<2);
+	saa_readl(reg);
+	err = saa_dsp_wait_bit(dev,SAA7135_DSP_RWSTATE_RDB);
+	if (err < 0)
+		return err;
+	*value = saa_readl(reg);
+	d2printk("dsp read   => 0x%06x\n", *value & 0xffffff);
+	err = saa_dsp_wait_bit(dev,SAA7135_DSP_RWSTATE_IDA);
+	if (err < 0)
+		return err;
+	return 0;
+}
 #endif
+
+int saa_dsp_writel(struct saa7134_dev *dev, int reg, u32 value)
+{
+	int err;
+
+	d2printk("dsp write reg 0x%x = 0x%06x\n",reg<<2,value);
+	err = saa_dsp_wait_bit(dev,SAA7135_DSP_RWSTATE_WRR);
+	if (err < 0)
+		return err;
+	saa_writel(reg,value);
+	err = saa_dsp_wait_bit(dev,SAA7135_DSP_RWSTATE_WRR);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int getstereo_7133(struct saa7134_dev *dev)
+{
+	int retval = V4L2_TUNER_SUB_MONO;
+	u32 value;
+
+	value = saa_readl(0x528 >> 2);
+	if (value & 0x20)
+		retval = V4L2_TUNER_SUB_MONO | V4L2_TUNER_SUB_STEREO;
+	if (value & 0x40)
+		retval = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
+	return retval;
+}
+
+static int mute_input_7133(struct saa7134_dev *dev)
+{
+	u32 reg = 0;
+	
+	switch (dev->input->amux) {
+	case TV:    reg = 0x02; break;
+	case LINE1: reg = 0x00; break;
+	case LINE2: reg = 0x01; break;
+	}
+	if (dev->ctl_mute)
+		reg = 0x07;
+	saa_writel(0x594 >> 2, reg);
+	return 0;
+}
+
+static int tvaudio_thread_ddep(void *data)
+{
+	struct saa7134_dev *dev = data;
+	u32 value, norms;
+
+	lock_kernel();
+	daemonize("%s", dev->name);
+	dev->thread.task = current;
+	unlock_kernel();
+	if (dev->thread.notify != NULL)
+		up(dev->thread.notify);
+
+	/* unmute */
+	saa_dsp_writel(dev, 0x474 >> 2, 0x00);
+	saa_dsp_writel(dev, 0x450 >> 2, 0x00);
+
+	for (;;) {
+		if (dev->thread.exit || signal_pending(current))
+			goto done;
+		interruptible_sleep_on(&dev->thread.wq);
+		if (dev->thread.exit || signal_pending(current))
+			goto done;
+
+	restart:
+		dev->thread.scan1 = dev->thread.scan2;
+		dprintk("tvaudio thread scan start [%d]\n",dev->thread.scan1);
+
+		norms = 0;
+		if (dev->tvnorm->id & V4L2_STD_PAL)
+			norms |= 0x2c; /* B/G + D/K + I */
+		if (dev->tvnorm->id & V4L2_STD_NTSC)
+			norms |= 0x40; /* M */
+		if (dev->tvnorm->id & V4L2_STD_SECAM)
+			norms |= 0x18; /* L + D/K */
+		if (0 == norms)
+			norms = 0x0000007c;
+
+		/* quick & dirty -- to be fixed up later ... */
+		saa_dsp_writel(dev, 0x454 >> 2, 0);
+		saa_dsp_writel(dev, 0x454 >> 2, norms | 0x80);
+		saa_dsp_writel(dev, 0x464 >> 2, 0x000000);
+		saa_dsp_writel(dev, 0x470 >> 2, 0x101010);
+
+		if (tvaudio_sleep(dev,3*HZ))
+			goto restart;
+		value = saa_readl(0x528 >> 2) & 0xffffff;
+
+		dprintk("tvaudio thread status: 0x%x [%s%s%s]\n",
+			value, stdres[value & 0x1f],
+			(value & 0x000020) ? ",stereo" : "",
+			(value & 0x000040) ? ",dual"   : "");
+		dprintk("detailed status: "
+			"%s#%s#%s#%s#%s#%s#%s#%s#%s#%s#%s#%s#%s#%s\n",
+			(value & 0x000080) ? " A2/EIAJ pilot tone "     : "",
+			(value & 0x000100) ? " A2/EIAJ dual "           : "",
+			(value & 0x000200) ? " A2/EIAJ stereo "         : "",
+			(value & 0x000400) ? " A2/EIAJ noise mute "     : "",
+
+			(value & 0x000800) ? " BTSC/FM radio pilot "    : "",
+			(value & 0x001000) ? " SAP carrier "            : "",
+			(value & 0x002000) ? " BTSC stereo noise mute " : "",
+			(value & 0x004000) ? " SAP noise mute "         : "",
+			(value & 0x008000) ? " VDSP "                   : "",
+			
+			(value & 0x010000) ? " NICST "                  : "",
+			(value & 0x020000) ? " NICDU "                  : "",
+			(value & 0x040000) ? " NICAM muted "            : "",
+			(value & 0x080000) ? " NICAM reserve sound "    : "",
+			
+			(value & 0x100000) ? " init done "              : "");
 	}
 
  done:
@@ -492,14 +764,89 @@
 }
 
 /* ------------------------------------------------------------------ */
+/* common stuff + external entry points                               */
+
+int saa7134_tvaudio_rx2mode(u32 rx)
+{
+	u32 mode;
+	
+	mode = V4L2_TUNER_MODE_MONO;
+	if (rx & V4L2_TUNER_SUB_STEREO)
+		mode = V4L2_TUNER_MODE_STEREO;
+	else if (rx & V4L2_TUNER_SUB_LANG1)
+		mode = V4L2_TUNER_MODE_LANG1;
+	else if (rx & V4L2_TUNER_SUB_LANG2)
+		mode = V4L2_TUNER_MODE_LANG2;
+	return mode;
+}
+	
+void saa7134_tvaudio_setmute(struct saa7134_dev *dev)
+{
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7130:
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		mute_input_7134(dev);
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		mute_input_7133(dev);
+		break;
+	}
+}
+
+void saa7134_tvaudio_setinput(struct saa7134_dev *dev,
+			      struct saa7134_input *in)
+{
+	dev->input = in;
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7130:
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		mute_input_7134(dev);
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		mute_input_7133(dev);
+		break;
+	}
+}
+
+void saa7134_tvaudio_setvolume(struct saa7134_dev *dev, int level)
+{
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		saa_writeb(SAA7134_CHANNEL1_LEVEL,     level & 0x1f);
+		saa_writeb(SAA7134_CHANNEL2_LEVEL,     level & 0x1f);
+		saa_writeb(SAA7134_NICAM_LEVEL_ADJUST, level & 0x1f);
+		break;
+	}
+}
+
+int saa7134_tvaudio_getstereo(struct saa7134_dev *dev)
+{
+	int retval = V4L2_TUNER_SUB_MONO;
+
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		if (dev->tvaudio)
+			retval = tvaudio_getstereo(dev,dev->tvaudio);
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		retval = getstereo_7133(dev);
+		break;
+	}
+	return retval;
+}
 
 int saa7134_tvaudio_init(struct saa7134_dev *dev)
 {
 	DECLARE_MUTEX_LOCKED(sem);
+	int (*my_thread)(void *data) = NULL;
 
 	/* enable I2S audio output */
 	if (saa7134_boards[dev->board].i2s_rate) {
-		int rate = (32000 == saa7134_boards[dev->board].i2s_rate) ? 0x01 : 0x03;
+		int rate = (32000 == saa7134_boards[dev->board].i2s_rate)
+			? 0x01 : 0x03;
 		
 		/* set rate */ 
 		saa_andorb(SAA7134_SIF_SAMPLE_FREQ, 0x03, rate);
@@ -512,13 +859,24 @@
 		saa_writeb(SAA7134_I2S_AUDIO_OUTPUT,   0x01);
 	}
 
-	/* start tvaudio thread */
-	init_waitqueue_head(&dev->thread.wq);
-	dev->thread.notify = &sem;
-	kernel_thread(tvaudio_thread,dev,0);
-	down(&sem);
-	dev->thread.notify = NULL;
-	wake_up_interruptible(&dev->thread.wq);
+	switch (dev->pci->device) {
+	case PCI_DEVICE_ID_PHILIPS_SAA7134:
+		my_thread = tvaudio_thread;
+		break;
+	case PCI_DEVICE_ID_PHILIPS_SAA7133:
+	case PCI_DEVICE_ID_PHILIPS_SAA7135:
+		my_thread = tvaudio_thread_ddep;
+		break;
+	}
+	if (my_thread) {
+		/* start tvaudio thread */
+		init_waitqueue_head(&dev->thread.wq);
+		dev->thread.notify = &sem;
+		kernel_thread(my_thread,dev,0);
+		down(&sem);
+		dev->thread.notify = NULL;
+		wake_up_interruptible(&dev->thread.wq);
+	}
 
 	return 0;
 }
@@ -541,8 +899,13 @@
 
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev)
 {
-	dev->thread.scan2++;
-	wake_up_interruptible(&dev->thread.wq);
+	if (dev->thread.task) {
+		dev->thread.scan2++;
+		wake_up_interruptible(&dev->thread.wq);
+	} else {
+		dev->automute = 0;
+		saa7134_tvaudio_setmute(dev);
+	}
 	return 0;
 }
 
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-vbi.c linux/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-vbi.c	2003-05-08 13:32:06.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-vbi.c	2003-05-08 13:55:12.000000000 +0200
@@ -85,6 +85,7 @@
 
 	dprintk("buffer_activate [%p]\n",buf);
 	buf->vb.state = STATE_ACTIVE;
+	buf->top_seen = 0;
 
 	task_init(dev,buf,TASK_A);
 	task_init(dev,buf,TASK_B);
@@ -119,7 +120,8 @@
 	struct saa7134_dev *dev = fh->dev;
 	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
 	struct saa7134_tvnorm *norm = dev->tvnorm;
-	int lines, llength, size, err;
+	unsigned int lines, llength, size;
+	int err;
 
 	lines   = norm->vbi_v_stop - norm->vbi_v_start +1;
 	if (lines > VBI_LINE_COUNT)
@@ -155,7 +157,6 @@
 			goto oops;
 	}
 	buf->vb.state = STATE_PREPARED;
-	buf->top_seen = 0;
 	buf->activate = buffer_activate;
 	buf->vb.field = field;
 	return 0;
@@ -166,7 +167,7 @@
 }
 
 static int
-buffer_setup(struct file *file, int *count, int *size)
+buffer_setup(struct file *file, unsigned int *count, unsigned int *size)
 {
 	struct saa7134_fh *fh   = file->private_data;
 	struct saa7134_dev *dev = fh->dev;
@@ -241,7 +242,7 @@
 	if (dev->vbi_q.curr) {
 		dev->vbi_fieldcount++;
 		/* make sure we have seen both fields */
-		if ((status & 0x10) == 0x10) {
+		if ((status & 0x10) == 0x00) {
 			dev->vbi_q.curr->top_seen = 1;
 			goto done;
 		}
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.5.69/drivers/media/video/saa7134/saa7134-video.c	2003-05-08 13:30:01.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2003-05-08 13:55:12.000000000 +0200
@@ -2,7 +2,7 @@
  * device driver for philips saa7134 based TV cards
  * video4linux video interface
  *
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2001-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -127,7 +127,7 @@
 		.vshift   = 1,
 	}
 };
-#define FORMATS (sizeof(formats)/sizeof(struct saa7134_format))
+#define FORMATS ARRAY_SIZE(formats)
 
 static struct saa7134_tvnorm tvnorms[] = {
 	{
@@ -141,13 +141,15 @@
 		.chroma_ctrl1  = 0x81,
 		.chroma_gain   = 0x2a,
 		.chroma_ctrl2  = 0x06,
+		.vgate_misc    = 0x1c,
 
 		.h_start       = 0,
 		.h_stop        = 719,
 		.video_v_start = 24,
 		.video_v_stop  = 311,
-		.vbi_v_start   = 7-3,  /* FIXME */
-		.vbi_v_stop    = 22-3,
+		.vbi_v_start   = 7,
+		.vbi_v_stop    = 22,
+		.src_timing    = 4,
 	},{
 		.name          = "NTSC",
 		.id            = V4L2_STD_NTSC,
@@ -159,6 +161,7 @@
 		.chroma_ctrl1  = 0x89,
 		.chroma_gain   = 0x2a,
 		.chroma_ctrl2  = 0x0e,
+		.vgate_misc    = 0x18,
 
 		.h_start       = 0,
 		.h_stop        = 719,
@@ -166,17 +169,19 @@
 		.video_v_stop  = 22+240,
 		.vbi_v_start   = 10, /* FIXME */
 		.vbi_v_stop    = 21, /* FIXME */
+		.src_timing    = 1,
 	},{
 		.name          = "SECAM",
 		.id            = V4L2_STD_SECAM,
 		.width         = 720,
 		.height        = 576,
 
-		.sync_control  = 0x58,
+		.sync_control  = 0x18, /* old: 0x58, */
 		.luma_control  = 0x1b,
 		.chroma_ctrl1  = 0xd1,
 		.chroma_gain   = 0x80,
 		.chroma_ctrl2  = 0x00,
+		.vgate_misc    = 0x1c,
 
 		.h_start       = 0,
 		.h_stop        = 719,
@@ -184,6 +189,47 @@
 		.video_v_stop  = 311,
 		.vbi_v_start   = 7,
 		.vbi_v_stop    = 22,
+		.src_timing    = 4,
+	},{
+		.name          = "PAL-M",
+		.id            = V4L2_STD_PAL_M,
+		.width         = 720,
+		.height        = 480,
+
+		.sync_control  = 0x59,
+		.luma_control  = 0x40,
+		.chroma_ctrl1  = 0xb9,
+		.chroma_gain   = 0x2a,
+		.chroma_ctrl2  = 0x0e,
+		.vgate_misc    = 0x18,
+
+		.h_start       = 0,
+		.h_stop        = 719,
+		.video_v_start = 22,
+		.video_v_stop  = 22+240,
+		.vbi_v_start   = 10, /* FIXME */
+		.vbi_v_stop    = 21, /* FIXME */
+		.src_timing    = 1,
+	},{
+		.name          = "PAL-Nc",
+		.id            = V4L2_STD_PAL_Nc,
+		.width         = 720,
+		.height        = 576,
+
+		.sync_control  = 0x18,
+		.luma_control  = 0x40,
+		.chroma_ctrl1  = 0xa1,
+		.chroma_gain   = 0x2a,
+		.chroma_ctrl2  = 0x06,
+		.vgate_misc    = 0x1c,
+
+		.h_start       = 0,
+		.h_stop        = 719,
+		.video_v_start = 24,
+		.video_v_stop  = 311,
+		.vbi_v_start   = 7,
+		.vbi_v_stop    = 22,
+		.src_timing    = 4,
 #if 0
 	},{
 		.name          = "AUTO",
@@ -196,6 +242,7 @@
 		.chroma_ctrl1  = 0x8b,
 		.chroma_gain   = 0x00,
 		.chroma_ctrl2  = 0x00,
+		.vgate_misc    = 0x18,
 
 		.h_start       = 0,
 		.h_stop        = 719,
@@ -203,11 +250,11 @@
 		.video_v_stop  = 311,
 		.vbi_v_start   = 7,
 		.vbi_v_stop    = 22,
+		.src_timing    = 4,
 #endif
 	}
 };
-#define TVNORMS (sizeof(tvnorms)/sizeof(struct saa7134_tvnorm))
-
+#define TVNORMS ARRAY_SIZE(tvnorms)
 
 #define V4L2_CID_PRIVATE_INVERT      (V4L2_CID_PRIVATE_BASE + 0)
 #define V4L2_CID_PRIVATE_Y_ODD       (V4L2_CID_PRIVATE_BASE + 1)
@@ -298,11 +345,11 @@
 		.type          = V4L2_CTRL_TYPE_INTEGER,
 	}
 };
-const int CTRLS = (sizeof(video_ctrls)/sizeof(struct v4l2_queryctrl));
+static const unsigned int CTRLS = ARRAY_SIZE(video_ctrls);
 
-static const struct v4l2_queryctrl* ctrl_by_id(int id)
+static const struct v4l2_queryctrl* ctrl_by_id(unsigned int id)
 {
-	int i;
+	unsigned int i;
 	
 	for (i = 0; i < CTRLS; i++)
 		if (video_ctrls[i].id == id)
@@ -310,9 +357,9 @@
 	return NULL;
 }
 
-static struct saa7134_format* format_by_fourcc(int  fourcc)
+static struct saa7134_format* format_by_fourcc(unsigned int fourcc)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < FORMATS; i++)
 		if (formats[i].fourcc == fourcc)
@@ -323,7 +370,7 @@
 /* ----------------------------------------------------------------------- */
 /* resource management                                                     */
 
-static int res_get(struct saa7134_dev *dev, struct saa7134_fh *fh, int bit)
+static int res_get(struct saa7134_dev *dev, struct saa7134_fh *fh, unsigned int bit)
 {
 	if (fh->resources & bit)
 		/* have it already allocated */
@@ -345,19 +392,19 @@
 }
 
 static
-int res_check(struct saa7134_fh *fh, int bit)
+int res_check(struct saa7134_fh *fh, unsigned int bit)
 {
 	return (fh->resources & bit);
 }
 
 static
-int res_locked(struct saa7134_dev *dev, int bit)
+int res_locked(struct saa7134_dev *dev, unsigned int bit)
 {
 	return (dev->resources & bit);
 }
 
 static
-void res_free(struct saa7134_dev *dev, struct saa7134_fh *fh, int bits)
+void res_free(struct saa7134_dev *dev, struct saa7134_fh *fh, unsigned int bits)
 {
 	if ((fh->resources & bits) != bits)
 		BUG();
@@ -393,7 +440,8 @@
 	saa_writeb(SAA7134_ANALOG_IN_CTRL4,       0x90);
 	saa_writeb(SAA7134_HSYNC_START,           0xeb);
 	saa_writeb(SAA7134_HSYNC_STOP,            0xe0);
-
+	saa_writeb(SAA7134_SOURCE_TIMING1,        norm->src_timing);
+	
 	saa_writeb(SAA7134_SYNC_CTRL,             norm->sync_control);
 	saa_writeb(SAA7134_LUMA_CTRL,             luma_control);
 	saa_writeb(SAA7134_DEC_LUMA_BRIGHT,       dev->ctl_bright);
@@ -410,7 +458,7 @@
 	saa_writeb(SAA7134_ANALOG_ADC,            0x01);
 	saa_writeb(SAA7134_VGATE_START,           0x11);
 	saa_writeb(SAA7134_VGATE_STOP,            0xfe);
-	saa_writeb(SAA7134_MISC_VGATE_MSB,        0x18); /* FIXME */
+	saa_writeb(SAA7134_MISC_VGATE_MSB,        norm->vgate_misc);
 	saa_writeb(SAA7134_RAW_DATA_GAIN,         0x40);
 	saa_writeb(SAA7134_RAW_DATA_OFFSET,       0x80);
 
@@ -454,7 +502,7 @@
 		{    9,  15,    0,    4,   3 },
 		{   10,  16,    1,    5,   3 },
 	};
-	static const int count = sizeof(vals)/sizeof(vals[0]);
+	static const int count = ARRAY_SIZE(vals);
 	int i;
 
 	for (i = 0; i < count; i++)
@@ -532,14 +580,14 @@
 	/* deinterlace y offsets */
 	if (interlace) {
 		y_odd  = dev->ctl_y_odd;
-		y_even = dev->ctl_y_even + yscale / 32;
+		y_even = dev->ctl_y_even;
 		saa_writeb(SAA7134_V_PHASE_OFFSET0(task), y_odd);
 		saa_writeb(SAA7134_V_PHASE_OFFSET1(task), y_even);
 		saa_writeb(SAA7134_V_PHASE_OFFSET2(task), y_odd);
 		saa_writeb(SAA7134_V_PHASE_OFFSET3(task), y_even);
 	} else {
 		y_odd  = dev->ctl_y_odd;
-		y_even = dev->ctl_y_even + yscale / 64;
+		y_even = dev->ctl_y_even;
 		saa_writeb(SAA7134_V_PHASE_OFFSET0(task), y_odd);
 		saa_writeb(SAA7134_V_PHASE_OFFSET1(task), y_even);
 		saa_writeb(SAA7134_V_PHASE_OFFSET2(task), y_odd);
@@ -688,7 +736,8 @@
 	err = verify_preview(dev,&fh->win);
 	if (0 != err)
 		return err;
-	
+
+	dev->ovfield = fh->win.field;
 	dprintk("start_preview %dx%d+%d+%d %s field=%s\n",
 		fh->win.w.width,fh->win.w.height,
 		fh->win.w.left,fh->win.w.top,
@@ -752,6 +801,7 @@
 
 	dprintk("buffer_activate buf=%p\n",buf);
 	buf->vb.state = STATE_ACTIVE;
+	buf->top_seen = 0;
 	
 	set_size(dev,TASK_A,buf->vb.width,buf->vb.height,
 		 V4L2_FIELD_HAS_BOTH(buf->vb.field));
@@ -828,7 +878,8 @@
 	struct saa7134_fh *fh = file->private_data;
 	struct saa7134_dev *dev = fh->dev;
 	struct saa7134_buf *buf = (struct saa7134_buf *)vb;
-	int size,err;
+	unsigned int size;
+	int err;
 	
 	/* sanity checks */
 	if (NULL == fh->fmt)
@@ -842,8 +893,8 @@
 	if (0 != buf->vb.baddr  &&  buf->vb.bsize < size)
 		return -EINVAL;
 
-	dprintk("buffer_prepare [size=%dx%d,bytes=%d,fields=%s,%s]\n",
-		fh->width,fh->height,size,v4l2_field_names[field],
+	dprintk("buffer_prepare [%d,size=%dx%d,bytes=%d,fields=%s,%s]\n",
+		vb->i,fh->width,fh->height,size,v4l2_field_names[field],
 		fh->fmt->name);
 	if (buf->vb.width  != fh->width  ||
 	    buf->vb.height != fh->height ||
@@ -872,7 +923,6 @@
 			goto oops;
 	}
 	buf->vb.state = STATE_PREPARED;
-	buf->top_seen = 0;
 	buf->activate = buffer_activate;
 	return 0;
 
@@ -1081,7 +1131,7 @@
 
 static int video_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = minor(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct saa7134_dev *h,*dev = NULL;
 	struct saa7134_fh *fh;
 	struct list_head *list;
@@ -1117,8 +1167,8 @@
 	fh->radio    = radio;
 	fh->type     = type;
 	fh->fmt      = format_by_fourcc(V4L2_PIX_FMT_BGR24);
-	fh->width    = 320;
-	fh->height   = 240;
+	fh->width    = 768;
+	fh->height   = 576;
 
 	videobuf_queue_init(&fh->cap, &video_qops,
 			    dev->pci, &dev->slock,
@@ -1138,7 +1188,9 @@
 
 	if (fh->radio) {
 		/* switch to radio mode */
+		u32 v = 400*16;
 		saa7134_tvaudio_setinput(dev,&card(dev).radio);
+		saa7134_i2c_call_clients(dev,VIDIOCSFREQ,&v);
 		saa7134_i2c_call_clients(dev,AUDC_SET_RADIO,NULL);
 	} else {
 		/* switch to video/vbi mode */
@@ -1185,7 +1237,7 @@
 			buf = list_entry(fh->cap.stream.next, struct videobuf_buffer, stream);
 	} else {
 		down(&fh->cap.lock);
-		if (-1 == fh->cap.read_off) {
+		if (UNSET == fh->cap.read_off) {
                         /* need to capture a new frame */
 			if (res_locked(fh->dev,RESOURCE_VIDEO)) {
                                 up(&fh->cap.lock);
@@ -1263,6 +1315,29 @@
 
 /* ------------------------------------------------------------------ */
 
+void saa7134_vbi_fmt(struct saa7134_dev *dev, struct v4l2_format *f)
+{
+	struct saa7134_tvnorm *norm = dev->tvnorm;
+
+	f->fmt.vbi.sampling_rate = 6750000 * 4;
+	f->fmt.vbi.samples_per_line = 2048 /* VBI_LINE_LENGTH */;
+	f->fmt.vbi.sample_format = V4L2_PIX_FMT_GREY;
+	f->fmt.vbi.offset = 64 * 4;
+	f->fmt.vbi.start[0] = norm->vbi_v_start;
+	f->fmt.vbi.count[0] = norm->vbi_v_stop - norm->vbi_v_start +1;
+	f->fmt.vbi.start[1] = norm->video_v_stop + norm->vbi_v_start +1;
+	f->fmt.vbi.count[1] = f->fmt.vbi.count[0];
+	f->fmt.vbi.flags = 0; /* VBI_UNSYNC VBI_INTERLACED */;
+
+#if 0
+	if (V4L2_STD_PAL == norm->id) {
+		/* FIXME */
+		f->fmt.vbi.start[0] += 3;
+		f->fmt.vbi.start[1] += 3*2;
+	}
+#endif
+}
+
 int saa7134_g_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
 		  struct v4l2_format *f)
 {
@@ -1273,27 +1348,17 @@
 		f->fmt.pix.height       = fh->height;
 		f->fmt.pix.field        = fh->cap.field;
 		f->fmt.pix.pixelformat  = fh->fmt->fourcc;
-		f->fmt.pix.sizeimage    =
-			(fh->width*fh->height*fh->fmt->depth)/8;
+		f->fmt.pix.bytesperline =
+			(f->fmt.pix.width * fh->fmt->depth) >> 3;
+		f->fmt.pix.sizeimage =
+			f->fmt.pix.height * f->fmt.pix.bytesperline;
 		return 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 		f->fmt.win = fh->win;
 		return 0;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
-	{
-		struct saa7134_tvnorm *norm = fh->dev->tvnorm;
-			
-		f->fmt.vbi.sampling_rate = 6750000 * 4;
-		f->fmt.vbi.samples_per_line = 2048 /* VBI_LINE_LENGTH */;
-		f->fmt.vbi.sample_format = V4L2_PIX_FMT_GREY;
-		f->fmt.vbi.offset = 64 * 4;
-		f->fmt.vbi.start[0] = norm->vbi_v_start;
-		f->fmt.vbi.count[0] = norm->vbi_v_stop - norm->vbi_v_start +1;
-		f->fmt.vbi.start[1] = norm->video_v_stop + norm->vbi_v_start + 1;
-		f->fmt.vbi.count[1] = f->fmt.vbi.count[0];
-		f->fmt.vbi.flags = 0; /* VBI_UNSYNC VBI_INTERLACED */;
+		saa7134_vbi_fmt(dev,f);
 		return 0;
-	}
 	default:
 		return -EINVAL;
 	}
@@ -1309,7 +1374,7 @@
 	{
 		struct saa7134_format *fmt;
 		enum v4l2_field field;
-		int maxw, maxh;
+		unsigned int maxw, maxh;
 
 		fmt = format_by_fourcc(f->fmt.pix.pixelformat);
 		if (NULL == fmt)
@@ -1336,12 +1401,18 @@
 		}
 
 		f->fmt.pix.field = field;
+		if (f->fmt.pix.width  < 48)
+			f->fmt.pix.width  = 48;
+		if (f->fmt.pix.height < 32)
+			f->fmt.pix.height = 32;
 		if (f->fmt.pix.width > maxw)
 			f->fmt.pix.width = maxw;
 		if (f->fmt.pix.height > maxh)
 			f->fmt.pix.height = maxh;
+		f->fmt.pix.bytesperline =
+			(f->fmt.pix.width * fmt->depth) >> 3;
 		f->fmt.pix.sizeimage =
-			(fh->width * fh->height * fmt->depth)/8;
+			f->fmt.pix.height * f->fmt.pix.bytesperline;
 		
 		return 0;
 	}
@@ -1350,6 +1421,9 @@
 		if (0 != err)
 			return err;
 		return 0;
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		saa7134_vbi_fmt(dev,f);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1397,6 +1471,9 @@
 		up(&dev->lock);
 		return 0;
 		break;
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		saa7134_vbi_fmt(dev,f);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1442,10 +1519,10 @@
 	case VIDIOC_ENUMSTD:
 	{
 		struct v4l2_standard *e = arg;
-		int i;
+		unsigned int i;
 
 		i = e->index;
-		if (i < 0 || i >= TVNORMS)
+		if (i >= TVNORMS)
 			return -EINVAL;
 		err = v4l2_video_std_construct(e, tvnorms[e->index].id,
 					       tvnorms[e->index].name);
@@ -1464,7 +1541,7 @@
 	case VIDIOC_S_STD:
 	{
 		v4l2_std_id *id = arg;
-		int i;
+		unsigned int i;
 
 		for(i = 0; i < TVNORMS; i++)
 			if (*id & tvnorms[i].id)
@@ -1489,7 +1566,7 @@
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
-		int n;
+		unsigned int n;
 
 		n = i->index;
 		if (n >= SAA7134_INPUT_MAX)
@@ -1557,22 +1634,8 @@
 				V4L2_TUNER_CAP_LANG1 |
 				V4L2_TUNER_CAP_LANG2;
 			t->rangehigh = 0xffffffffUL;
-			t->rxsubchans = -1;
-			if (dev->tvaudio)
-				t->rxsubchans = saa7134_tvaudio_getstereo
-					(dev,dev->tvaudio);
-			if (-1 == t->rxsubchans)
-				t->rxsubchans = V4L2_TUNER_SUB_MONO;
-#if 1
-			/* fill audmode -- FIXME: allow manual switching */
-			t->audmode = V4L2_TUNER_MODE_MONO;
-			if (t->rxsubchans & V4L2_TUNER_SUB_STEREO)
-				t->audmode = V4L2_TUNER_MODE_STEREO;
-			else if (t->rxsubchans & V4L2_TUNER_SUB_LANG1)
-				t->audmode = V4L2_TUNER_MODE_LANG1;
-			else if (t->rxsubchans & V4L2_TUNER_SUB_LANG2)
-				t->audmode = V4L2_TUNER_MODE_LANG2;
-#endif
+			t->rxsubchans = saa7134_tvaudio_getstereo(dev);
+			t->audmode = saa7134_tvaudio_rx2mode(t->rxsubchans);
 		}
 		if (0 != (saa_readb(SAA7134_STATUS_VIDEO1) & 0x03))
 			t->signal = 0xffff;
@@ -1655,14 +1718,14 @@
 	{
 		struct v4l2_fmtdesc *f = arg;
 		enum v4l2_buf_type type;
-		int index;
+		unsigned int index;
 
 		index = f->index;
 		type  = f->type;
 		switch (type) {
 		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		case V4L2_BUF_TYPE_VIDEO_OVERLAY:
-			if (index < 0 || index >= FORMATS)
+			if (index >= FORMATS)
 				return -EINVAL;
 			if (f->type == V4L2_BUF_TYPE_VIDEO_OVERLAY &&
 			    formats[index].planar)
@@ -1760,21 +1823,23 @@
 	{
 		struct video_mbuf *mbuf = arg;
 		struct videobuf_queue *q;
-		int i;
+		struct v4l2_requestbuffers req;
+		unsigned int i;
 
 		q = saa7134_queue(fh);
-		down(&q->lock);
-		err = videobuf_mmap_setup(file,q,gbuffers,gbufsize);
-		if (err < 0) {
-			up(&q->lock);
+		memset(&req,0,sizeof(req));
+		req.type  = q->type;
+		req.count = gbuffers;
+		err = videobuf_reqbufs(file,q,&req);
+		if (err < 0)
 			return err;
-		}
 		memset(mbuf,0,sizeof(*mbuf));
-		mbuf->frames = gbuffers;
-		mbuf->size   = gbuffers * gbufsize;
-		for (i = 0; i < gbuffers; i++)
-			mbuf->offsets[i] = i * gbufsize;
-		up(&q->lock);
+		mbuf->frames = req.count;
+		mbuf->size   = 0;
+		for (i = 0; i < mbuf->frames; i++) {
+			mbuf->offsets[i]  = q->bufs[i]->boff;
+			mbuf->size       += q->bufs[i]->bsize;
+		}
 		return 0;
 	}
 	case VIDIOC_REQBUFS:
@@ -1800,7 +1865,10 @@
 	case VIDIOC_STREAMOFF:
 	{
 		int res = saa7134_resource(fh);
+
 		err = videobuf_streamoff(file,saa7134_queue(fh));
+		if (err < 0)
+			return err;
 		res_free(dev,fh,res);
 		return 0;
 	}
@@ -1879,9 +1947,16 @@
 		strcpy(a->name,"Radio");
 		return 0;
 	}
+	case VIDIOC_G_STD:
+	{
+		v4l2_std_id *id = arg;
+		*id = 0;
+		return 0;
+	}
 	case VIDIOC_S_AUDIO:
 	case VIDIOC_S_TUNER:
 	case VIDIOC_S_INPUT:
+	case VIDIOC_S_STD:
 		return 0;
 
 	case VIDIOC_QUERYCTRL:
@@ -2055,7 +2130,7 @@
 		
 		if (V4L2_FIELD_HAS_BOTH(field)) {
 			/* make sure we have seen both fields */
-			if ((status & 0x10) == 0x10) {
+			if ((status & 0x10) == 0x00) {
 				dev->video_q.curr->top_seen = 1;
 				goto done;
 			}
diff -u linux-2.5.69/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.5.69/drivers/media/video/saa7134/saa7134.h	2003-05-08 13:31:35.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134.h	2003-05-08 13:55:12.000000000 +0200
@@ -28,7 +28,7 @@
 #include <media/audiochip.h>
 #include <media/id.h>
 
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,2)
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,8)
 
 #ifndef TRUE
 # define TRUE (1==1)
@@ -36,6 +36,7 @@
 #ifndef FALSE
 # define FALSE (1==0)
 #endif
+#define UNSET (-1U)
 
 /* 2.4 / 2.5 driver compatibility stuff */
 
@@ -67,50 +68,52 @@
 struct saa7134_tvnorm {
 	char          *name;
 	v4l2_std_id   id;
-	int           width;
-	int           height;
+	unsigned int  width;
+	unsigned int  height;
 
 	/* video decoder */
-	int           sync_control;
-	int           luma_control;
-	int           chroma_ctrl1;
-	int           chroma_gain;
-	int           chroma_ctrl2;
+	unsigned int  sync_control;
+	unsigned int  luma_control;
+	unsigned int  chroma_ctrl1;
+	unsigned int  chroma_gain;
+	unsigned int  chroma_ctrl2;
+	unsigned int  vgate_misc;
 
 	/* video scaler */
-	int           h_start;
-	int           h_stop;
-	int           video_v_start;
-	int           video_v_stop;
-	int           vbi_v_start;
-	int           vbi_v_stop;
+	unsigned int  h_start;
+	unsigned int  h_stop;
+	unsigned int  video_v_start;
+	unsigned int  video_v_stop;
+	unsigned int  vbi_v_start;
+	unsigned int  vbi_v_stop;
+	unsigned int  src_timing;
 };
 
 struct saa7134_tvaudio {
-	char  *name;
-	int   std;
-	enum  saa7134_tvaudio_mode mode;
-	int   carr1;
-	int   carr2;
+	char         *name;
+	v4l2_std_id  std;
+	enum         saa7134_tvaudio_mode mode;
+	int          carr1;
+	int          carr2;
 };
 
 struct saa7134_format {
-	char  *name;
-	int   fourcc;
-	int   depth;
-	int   pm;
-	int   vshift;   /* vertical downsampling (for planar yuv) */
-	int   hshift;   /* horizontal downsampling (for planar yuv) */
-	int   bswap:1;
-	int   wswap:1;
-	int   yuv:1;
-	int   planar:1;
+	char           *name;
+	unsigned int   fourcc;
+	unsigned int   depth;
+	unsigned int   pm;
+	unsigned int   vshift;   /* vertical downsampling (for planar yuv) */
+	unsigned int   hshift;   /* horizontal downsampling (for planar yuv) */
+	unsigned int   bswap:1;
+	unsigned int   wswap:1;
+	unsigned int   yuv:1;
+	unsigned int   planar:1;
 };
 
 /* ----------------------------------------------------------- */
 /* card configuration                                          */
 
-#define SAA7134_BOARD_NOAUTO           -1
+#define SAA7134_BOARD_NOAUTO        UNSET
 #define SAA7134_BOARD_UNKNOWN           0
 #define SAA7134_BOARD_PROTEUS_PRO       1
 #define SAA7134_BOARD_FLYVIDEO3000      2
@@ -124,38 +127,40 @@
 #define SAA7134_BOARD_KWORLD           10
 #define SAA7134_BOARD_CINERGY600       11
 #define SAA7134_BOARD_MD7134           12
+#define SAA7134_BOARD_TYPHOON_90031    13
+#define SAA7134_BOARD_ELSA             14
+#define SAA7134_BOARD_ELSA_500TV       15
 
 #define SAA7134_INPUT_MAX 8
 
 struct saa7134_input {
 	char                    *name;
-	int                     vmux;
+	unsigned int            vmux;
 	enum saa7134_audio_in   amux;
-	int                     gpio;
-	int                     tv:1;
+	unsigned int            gpio;
+	unsigned int            tv:1;
 };
 
 struct saa7134_board {
 	char                    *name;
-	int                     audio_clock;
+	unsigned int            audio_clock;
 
 	/* input switching */
-	int                     gpiomask;
+	unsigned int            gpiomask;
 	struct saa7134_input    inputs[SAA7134_INPUT_MAX];
 	struct saa7134_input    radio;
 	struct saa7134_input    mute;
 	
 	/* peripheral I/O */
-	int                     i2s_rate;
-	int                     has_ts;
+	unsigned int            i2s_rate;
+	unsigned int            has_ts;
 	enum saa7134_video_out  video_out;
 
 	/* i2c chip info */
-	int                     tuner_type;
-	int                     need_tda9887:1;
+	unsigned int            tuner_type;
+	unsigned int            need_tda9887:1;
 };
 
-#define card_has_audio(dev)   (dev->pci->device == PCI_DEVICE_ID_PHILIPS_SAA7134)
 #define card_has_radio(dev)   (NULL != saa7134_boards[dev->board].radio.name)
 #define card_has_ts(dev)      (saa7134_boards[dev->board].has_ts)
 #define card(dev)             (saa7134_boards[dev->board])
@@ -189,9 +194,9 @@
 	struct task_struct         *task;
 	wait_queue_head_t          wq;
 	struct semaphore           *notify;
-	int                        exit;
-	int                        scan1;
-	int                        scan2;
+	unsigned int               exit;
+	unsigned int               scan1;
+	unsigned int               scan2;
 };
 
 /* buffer for one video/vbi/ts frame */
@@ -201,7 +206,7 @@
 
 	/* saa7134 specific */
 	struct saa7134_format   *fmt;
-	int                     top_seen;
+	unsigned int            top_seen;
 	int (*activate)(struct saa7134_dev *dev,
 			struct saa7134_buf *buf,
 			struct saa7134_buf *next);
@@ -215,22 +220,23 @@
 	struct saa7134_buf         *curr;
 	struct list_head           queue;
 	struct timer_list          timeout;
+	unsigned int               need_two;
 };
 
 /* video filehandle status */
 struct saa7134_fh {
 	struct saa7134_dev         *dev;
-	int                        radio;
+	unsigned int               radio;
 	enum v4l2_buf_type         type;
 
 	struct v4l2_window         win;
 	struct v4l2_clip           clips[8];
-	int                        nclips;
-	int                        resources;
+	unsigned int               nclips;
+	unsigned int               resources;
 
 	/* video capture */
 	struct saa7134_format      *fmt;
-	int                        width,height;
+	unsigned int               width,height;
 	struct videobuf_queue      cap;
 	struct saa7134_pgtable     pt_cap;
 
@@ -241,7 +247,7 @@
 
 /* TS status */
 struct saa7134_ts {
-	int                        users;
+	unsigned int               users;
 
 	/* TS capture */
 	struct videobuf_queue      ts;
@@ -253,28 +259,28 @@
         struct semaphore           lock;
 	int                        minor_mixer;
 	int                        minor_dsp;
-	int                        users_dsp;
+	unsigned int               users_dsp;
 
 	/* mixer */
 	enum saa7134_audio_in      input;
-	int                        count;
-	int                        line1;
-	int                        line2;
+	unsigned int               count;
+	unsigned int               line1;
+	unsigned int               line2;
 
 	/* dsp */
-	int                        afmt;
-	int                        rate;
-	int                        channels;
-	int                        recording;
-	int                        blocks;
-	int                        blksize;
-	int                        bufsize;
+	unsigned int               afmt;
+	unsigned int               rate;
+	unsigned int               channels;
+	unsigned int               recording;
+	unsigned int               blocks;
+	unsigned int               blksize;
+	unsigned int               bufsize;
 	struct saa7134_pgtable     pt;
 	struct videobuf_dmabuf     dma;
 	wait_queue_head_t          wq;
-	int                        dma_blk;
-	int                        read_offset;
-	int                        read_count;
+	unsigned int               dma_blk;
+	unsigned int               read_offset;
+	unsigned int               read_count;
 };
 
 /* global device status */
@@ -284,7 +290,7 @@
        	spinlock_t                 slock;
 
 	/* various device info */
-	int                        resources;
+	unsigned int               resources;
 	struct video_device        video_dev;
 	struct video_device        ts_dev;
 	struct video_device        radio_dev;
@@ -300,8 +306,8 @@
 	__u8                       *bmmio;
 
 	/* config info */
-	int                        board;
-	int                        tuner_type;
+	unsigned int               board;
+	unsigned int               tuner_type;
 
 	/* i2c i/o */
 	struct i2c_adapter         i2c_adap;
@@ -311,19 +317,19 @@
 	/* video overlay */
 	struct v4l2_framebuffer    ovbuf;
 	struct saa7134_format      *ovfmt;
-	int                        ovenable;
+	unsigned int               ovenable;
 	enum v4l2_field            ovfield;
 
 	/* video+ts+vbi capture */
 	struct saa7134_dmaqueue    video_q;
 	struct saa7134_dmaqueue    ts_q;
 	struct saa7134_dmaqueue    vbi_q;
-	int                        vbi_fieldcount;
+	unsigned int               vbi_fieldcount;
 
 	/* various v4l controls */
 	struct saa7134_tvnorm      *tvnorm;              /* video */
 	struct saa7134_tvaudio     *tvaudio;
-	int                        ctl_input;
+	unsigned int               ctl_input;
 	int                        ctl_bright;
 	int                        ctl_contrast;
 	int                        ctl_hue;
@@ -337,11 +343,12 @@
 	int                        ctl_y_even;
 
 	/* other global state info */
-	int                        automute;
+	unsigned int               automute;
 	struct saa7134_thread      thread;
 	struct saa7134_input       *input;
 	struct saa7134_input       *hw_input;
-	int                        hw_mute;
+	unsigned int               hw_mute;
+	int                        last_carrier;
 };
 
 /* ----------------------------------------------------------- */
@@ -362,12 +369,13 @@
 #define saa_setb(reg,bit)          saa_andorb((reg),(bit),(bit))
 #define saa_clearb(reg,bit)        saa_andorb((reg),(bit),0)
 
+#define saa_wait(d) { if (need_resched()) schedule(); else udelay(d);}
 
 /* ----------------------------------------------------------- */
 /* saa7134-core.c                                              */
 
 extern struct list_head  saa7134_devlist;
-extern int               saa7134_devcount;
+extern unsigned int      saa7134_devcount;
 
 void saa7134_print_ioctl(char *name, unsigned int cmd);
 void saa7134_track_gpio(struct saa7134_dev *dev, char *msg);
@@ -376,18 +384,18 @@
 
 int saa7134_pgtable_alloc(struct pci_dev *pci, struct saa7134_pgtable *pt);
 int  saa7134_pgtable_build(struct pci_dev *pci, struct saa7134_pgtable *pt,
-			   struct scatterlist *list, int length,
-			   int startpage);
+			   struct scatterlist *list, unsigned int length,
+			   unsigned int startpage);
 void saa7134_pgtable_free(struct pci_dev *pci, struct saa7134_pgtable *pt);
 
-int saa7134_buffer_count(int size, int count);
+int saa7134_buffer_count(unsigned int size, unsigned int count);
 int saa7134_buffer_startpage(struct saa7134_buf *buf);
 unsigned long saa7134_buffer_base(struct saa7134_buf *buf);
 
 int saa7134_buffer_queue(struct saa7134_dev *dev, struct saa7134_dmaqueue *q,
 			 struct saa7134_buf *buf);
 void saa7134_buffer_finish(struct saa7134_dev *dev, struct saa7134_dmaqueue *q,
-			   int state);
+			   unsigned int state);
 void saa7134_buffer_next(struct saa7134_dev *dev, struct saa7134_dmaqueue *q);
 void saa7134_buffer_timeout(unsigned long data);
 void saa7134_dma_free(struct saa7134_dev *dev,struct saa7134_buf *buf);
@@ -398,9 +406,11 @@
 /* saa7134-cards.c                                             */
 
 extern struct saa7134_board saa7134_boards[];
-extern const int saa7134_bcount;
+extern const unsigned int saa7134_bcount;
 extern struct pci_device_id __devinitdata saa7134_pci_tbl[];
 
+extern int saa7134_board_init(struct saa7134_dev *dev);
+
 
 /* ----------------------------------------------------------- */
 /* saa7134-i2c.c                                               */
@@ -449,17 +459,19 @@
 /* ----------------------------------------------------------- */
 /* saa7134-tvaudio.c                                           */
 
+int saa7134_tvaudio_rx2mode(u32 rx);
+
 void saa7134_tvaudio_setmute(struct saa7134_dev *dev);
 void saa7134_tvaudio_setinput(struct saa7134_dev *dev,
 			      struct saa7134_input *in);
 void saa7134_tvaudio_setvolume(struct saa7134_dev *dev, int level);
-int saa7134_tvaudio_getstereo(struct saa7134_dev *dev,
-			      struct saa7134_tvaudio *audio);
+int saa7134_tvaudio_getstereo(struct saa7134_dev *dev);
 
 int saa7134_tvaudio_init(struct saa7134_dev *dev);
 int saa7134_tvaudio_fini(struct saa7134_dev *dev);
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev);
 
+int saa_dsp_writel(struct saa7134_dev *dev, int reg, u32 value);
 
 /* ----------------------------------------------------------- */
 /* saa7134-oss.c                                               */

-- 
sigfault
