Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUFRKWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUFRKWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUFRKV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:21:59 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64455 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265060AbUFRKUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:20:50 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:59:02 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 33_saa7134-2.6.7.diff.gz
Message-ID: <20040618095902.GA24639@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is an update for the saa7134 driver.  Changes:

  * add support for more TV cards, as usual ;)
  * add support for image cropping.
  * use v4l2 API to talk to the tuner chips (thus it depends
    on the tuner/tda9887 patch).
  * fixes for the audio carrier scan.
  * make transport stream packet size configurable.

please apply,

  Gerd

diff -up linux-2.6.7/drivers/media/video/saa7134/saa6752hs.c linux/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.7/drivers/media/video/saa7134/saa6752hs.c	2004-06-17 10:31:10.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa6752hs.c	2004-06-17 13:47:59.647298383 +0200
@@ -337,7 +337,6 @@ static int saa6752hs_probe(struct i2c_ad
 {
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, saa6752hs_attach);
-
 	return 0;
 }
 
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-cards.c	2004-06-17 10:30:38.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2004-06-17 13:47:59.650297819 +0200
@@ -420,20 +420,14 @@ struct saa7134_board saa7134_boards[] = 
 			.vmux   = 1,
 			.amux   = TV,
 			.tv     = 1,
-#if 0
 		},{
 			.name   = name_comp1,
 			.vmux   = 0,
 			.amux   = LINE2,
 		},{
-			.name   = name_comp2,
-			.vmux   = 3,
-			.amux   = LINE2,
-		},{
 			.name   = name_svideo,
 			.vmux   = 8,
 			.amux   = LINE2,
-#endif
 		}},
 		.radio = {
 			.name   = name_radio,
@@ -515,24 +509,14 @@ struct saa7134_board saa7134_boards[] = 
                         .vmux = 1,
                         .amux = TV,
                         .tv   = 1,
-#if 0 /* untested */
                 },{
                         .name = name_comp1,
                         .vmux = 4,
                         .amux = LINE2,
                 },{
-                        .name = name_comp2,
-                        .vmux = 2,
-                        .amux = LINE2,
-                },{
                         .name = name_svideo,
                         .vmux = 6,
                         .amux = LINE2,
-                },{
-                        .name = "S-Video2",
-                        .vmux = 7,
-                        .amux = LINE2,
-#endif
                 }},
                 .radio = {
                         .name = name_radio,
@@ -679,7 +663,7 @@ struct saa7134_board saa7134_boards[] = 
                 }},
         },
 	[SAA7134_BOARD_MD2819] = {
-		.name           = "Medion 2819/ AverMedia M156",
+		.name           = "AverMedia M156 / Medion 2819",
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
 		.need_tda9887   = 1,
@@ -951,6 +935,96 @@ struct saa7134_board saa7134_boards[] = 
 			.vmux = 3,
 		}},
 	},
+        [SAA7134_BOARD_NOVAC_PRIMETV7133] = {
+                /* toshii@netbsd.org */
+                .name           = "Noval Prime TV 7133",
+                .audio_clock    = 0x00200000,
+                .tuner_type     = TUNER_ALPS_TSBH1_NTSC,
+                .inputs         = {{
+                        .name = name_comp1,
+                        .vmux = 3,
+                },{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+                },{
+                        .name = name_svideo,
+                        .vmux = 8,
+                }},
+        },
+	[SAA7134_BOARD_AVERMEDIA_305] = {
+		.name           = "AverMedia 305",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.need_tda9887   = 1,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = LINE2,
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
+			 .name = name_radio,
+			 .amux = LINE2,
+		 },
+		.mute = {
+			 .name = name_mute,
+			 .amux = LINE1,
+		},
+	},
+  	[SAA7133_BOARD_UPMOST_PURPLE_TV] = {
+  		.name           = "UPMOST PURPLE TV",
+  		.audio_clock    = 0x00187de7,
+  		.tuner_type     = TUNER_PHILIPS_FM1236_MK3,
+  		.need_tda9887   = 1,
+  		.inputs         = {{
+  			.name = name_tv,
+  			.vmux = 7,
+  			.amux = TV,
+  			.tv   = 1,
+  		},{
+  			.name = name_svideo,
+  			.vmux = 7,
+  			.amux = LINE1,
+  		}},
+          },
+	[SAA7134_BOARD_ITEMS_MTV005] = {
+		/* Norman Jonas <normanjonas@arcor.de> */
+		.name           = "Items MuchTV Plus / IT-005",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 3,
+			.amux = TV,
+			.tv   = 1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 1,
+			.amux   = LINE1,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+		},
+	},
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
@@ -1103,12 +1177,11 @@ struct pci_device_id saa7134_pci_tbl[] =
                 .subdevice    = 0xa70b,
 		.driver_data  = SAA7134_BOARD_MD2819,
 	},{
-		/* AverMedia Studio 305, using AverMedia M156 entry for now */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
-		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
                 .subvendor    = 0x1461, /* Avermedia Technologies Inc */
                 .subdevice    = 0x2115,
-		.driver_data  = SAA7134_BOARD_MD2819,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_305,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
@@ -1141,7 +1214,13 @@ struct pci_device_id saa7134_pci_tbl[] =
                 .subdevice    = 0x4cb5,
                 .driver_data  = SAA7134_BOARD_ECS_TVP3XP_4CB5,
         },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+ 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+                .subvendor    = 0x12ab,
+                .subdevice    = 0x0800,
+ 		.driver_data  = SAA7133_BOARD_UPMOST_PURPLE_TV,
 		
+ 	},{
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
                 .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -1251,6 +1330,9 @@ int saa7134_board_init(struct saa7134_de
 	case SAA7134_BOARD_ECS_TVP3XP_4CB5:
 		dev->has_remote = 1;
 		break;
+	case SAA7134_BOARD_AVACSSMARTTV:
+		dev->has_remote = 1;
+		break;
 	}
 	return 0;
 }
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-core.c	2004-06-17 10:28:33.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2004-06-17 13:47:59.653297254 +0200
@@ -607,10 +607,18 @@ static irqreturn_t saa7134_irq(int irq, 
 	};
 	if (10 == loop) {
 		print_irqstatus(dev,loop,report,status);
-		printk(KERN_WARNING "%s/irq: looping -- clearing enable bits\n",dev->name);
-		/* disable all irqs */
-		saa_writel(SAA7134_IRQ1,0);
-		saa_writel(SAA7134_IRQ2,0);
+		if (report & SAA7134_IRQ_REPORT_PE) {
+			/* disable all parity error */
+			printk(KERN_WARNING "%s/irq: looping -- "
+			       "clearing PE (parity error!) enable bit\n",dev->name);
+			saa_clearl(SAA7134_IRQ2,SAA7134_IRQ2_INTE_PE);
+		} else {
+			/* disable all irqs */
+			printk(KERN_WARNING "%s/irq: looping -- "
+			       "clearing all enable bits\n",dev->name);
+			saa_writel(SAA7134_IRQ1,0);
+			saa_writel(SAA7134_IRQ2,0);
+		}
 	}
 
  out:
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-input.c linux/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-input.c	2004-06-17 10:30:20.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2004-06-17 13:47:59.656296690 +0200
@@ -20,12 +20,24 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
 
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
+static unsigned int disable_ir = 0;
+MODULE_PARM(disable_ir,"i");
+MODULE_PARM_DESC(disable_ir,"disable infrared remote support");
+
+static unsigned int ir_debug = 0;
+MODULE_PARM(ir_debug,"i");
+MODULE_PARM_DESC(ir_debug,"enable debug messages [IR]");
+
+#define dprintk(fmt, arg...)	if (ir_debug) \
+	printk(KERN_DEBUG "%s/ir: " fmt, dev->name , ## arg)
+
 /* ---------------------------------------------------------------------- */
 
 static IR_KEYTAB_TYPE flyvideo_codes[IR_KEYTAB_SIZE] = {
@@ -146,7 +158,7 @@ static IR_KEYTAB_TYPE eztv_codes[IR_KEYT
         [ 13 ] = KEY_KP7,
         [ 14 ] = KEY_KP8,
         [ 15 ] = KEY_KP9,
-
+ 
         [ 42 ] = KEY_VOLUMEUP,
         [ 17 ] = KEY_VOLUMEDOWN,
         [ 24 ] = KEY_CHANNELUP,      // CH.tracking up
@@ -156,6 +168,47 @@ static IR_KEYTAB_TYPE eztv_codes[IR_KEYT
         [ 33 ] = KEY_KPDOT,          // . (decimal dot)
 };
 
+static IR_KEYTAB_TYPE avacssmart_codes[IR_KEYTAB_SIZE] = {
+        [ 30 ] = KEY_POWER,		// power
+	[ 28 ] = KEY_SEARCH,		// scan
+        [  7 ] = KEY_SELECT,		// source
+        
+	[ 22 ] = KEY_VOLUMEUP,
+	[ 20 ] = KEY_VOLUMEDOWN,
+        [ 31 ] = KEY_CHANNELUP,
+	[ 23 ] = KEY_CHANNELDOWN,
+	[ 24 ] = KEY_MUTE,
+	
+	[  2 ] = KEY_KP0,
+        [  1 ] = KEY_KP1,
+        [ 11 ] = KEY_KP2,
+        [ 27 ] = KEY_KP3,
+        [  5 ] = KEY_KP4,
+        [  9 ] = KEY_KP5,
+        [ 21 ] = KEY_KP6,
+	[  6 ] = KEY_KP7,
+        [ 10 ] = KEY_KP8,
+	[ 18 ] = KEY_KP9,
+	[ 16 ] = KEY_KPDOT,
+	
+	[  3 ] = KEY_TUNER,		// tv/fm
+        [  4 ] = KEY_REWIND,		// fm tuning left or function left
+        [ 12 ] = KEY_FORWARD,		// fm tuning right or function right
+        
+	[  0 ] = KEY_RECORD,
+        [  8 ] = KEY_STOP,
+        [ 17 ] = KEY_PLAY,
+	
+	[ 25 ] = KEY_ZOOM,
+	[ 14 ] = KEY_MENU,		// function
+	[ 19 ] = KEY_AGAIN,		// recall
+	[ 29 ] = KEY_RESTART,		// reset
+    
+// FIXME    
+	[ 13 ] = KEY_F21,		// mts
+        [ 15 ] = KEY_F22,		// min
+	[ 26 ] = KEY_F23,		// freeze
+};
 /* ---------------------------------------------------------------------- */
 
 static int build_key(struct saa7134_dev *dev)
@@ -175,8 +228,8 @@ static int build_key(struct saa7134_dev 
         }
 
  	data = ir_extract_bits(gpio, ir->mask_keycode);
-	printk("%s: build_key gpio=0x%x mask=0x%x data=%d\n",
-	       dev->name, gpio, ir->mask_keycode, data);
+	dprintk("build_key gpio=0x%x mask=0x%x data=%d\n",
+		gpio, ir->mask_keycode, data);
 
 	if ((ir->mask_keydown  &&  (0 != (gpio & ir->mask_keydown))) ||
 	    (ir->mask_keyup    &&  (0 == (gpio & ir->mask_keyup)))) {
@@ -218,9 +271,12 @@ int saa7134_input_init1(struct saa7134_d
 	int polling      = 0;
 	int ir_type      = IR_TYPE_OTHER;
 
-	/* detect & configure */
 	if (!dev->has_remote)
 		return -ENODEV;
+	if (disable_ir)
+		return -ENODEV;
+
+	/* detect & configure */
 	switch (dev->board) {
 	case SAA7134_BOARD_FLYVIDEO2000:
 	case SAA7134_BOARD_FLYVIDEO3000:
@@ -241,6 +297,12 @@ int saa7134_input_init1(struct saa7134_d
                 mask_keyup   = 0x000002;
 		polling      = 50; // ms
                 break;
+	case SAA7134_BOARD_AVACSSMARTTV:
+	        ir_codes     = avacssmart_codes;
+		mask_keycode = 0x00001F;
+		mask_keyup   = 0x000020;
+		polling      = 50; // ms
+		break;
 	}
 	if (NULL == ir_codes) {
 		printk("%s: Oops: IR config error [card=%d]\n",
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-oss.c	2004-06-17 10:29:07.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2004-06-17 13:47:59.658296313 +0200
@@ -50,7 +50,7 @@ static int dsp_buffer_conf(struct saa713
 	if (blksize < 0x100)
 		blksize = 0x100;
 	if (blksize > 0x10000)
-		blksize = 0x100;
+		blksize = 0x10000;
 
 	if (blocks < 2)
 		blocks = 2;
@@ -74,6 +74,7 @@ static int dsp_buffer_init(struct saa713
 
 	if (!dev->oss.bufsize)
 		BUG();
+	videobuf_dma_init(&dev->oss.dma);
 	err = videobuf_dma_init_kernel(&dev->oss.dma, PCI_DMA_FROMDEVICE,
 				       dev->oss.bufsize >> PAGE_SHIFT);
 	if (0 != err)
@@ -172,7 +173,7 @@ static int dsp_rec_start(struct saa7134_
 			fmt |= (2 << 4);
 		if (!sign)
 			fmt |= 0x04;
-		saa_writel(0x588 >> 2, dev->oss.blksize);
+		saa_writel(0x588 >> 2, dev->oss.blksize -4);
 		saa_writel(0x58c >> 2, 0x543210 | (fmt << 24));
 		break;
 	}
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-ts.c linux/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-ts.c	2004-06-17 10:27:37.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-ts.c	2004-06-17 13:47:59.661295749 +0200
@@ -33,6 +33,8 @@
 
 /* ------------------------------------------------------------------ */
 
+#define TS_PACKET_SIZE 188 /* TS packets 188 bytes */
+
 static unsigned int ts_debug  = 0;
 MODULE_PARM(ts_debug,"i");
 MODULE_PARM_DESC(ts_debug,"enable debug messages [ts]");
@@ -41,8 +43,9 @@ static unsigned int tsbufs = 4;
 MODULE_PARM(tsbufs,"i");
 MODULE_PARM_DESC(tsbufs,"number of ts buffers, range 2-32");
 
-#define TS_PACKET_SIZE 188 /* TS packets 188 bytes */
-#define TS_NR_PACKETS 312
+static unsigned int ts_nr_packets = 30;
+MODULE_PARM(ts_nr_packets,"i");
+MODULE_PARM_DESC(ts_nr_packets,"size of a ts buffers (in ts packets)");
 
 #define dprintk(fmt, arg...)	if (ts_debug) \
 	printk(KERN_DEBUG "%s/ts: " fmt, dev->name , ## arg)
@@ -96,7 +99,7 @@ static int buffer_prepare(struct file *f
 	dprintk("buffer_prepare [%p,%s]\n",buf,v4l2_field_names[field]);
 
 	llength = TS_PACKET_SIZE;
-	lines = TS_NR_PACKETS;
+	lines = ts_nr_packets;
 	
 	size = lines * llength;
 	if (0 != buf->vb.baddr  &&  buf->vb.bsize < size)
@@ -135,7 +138,7 @@ static int buffer_prepare(struct file *f
 static int
 buffer_setup(struct file *file, unsigned int *count, unsigned int *size)
 {
-	*size = TS_PACKET_SIZE * TS_NR_PACKETS;
+	*size = TS_PACKET_SIZE * ts_nr_packets;
 	if (0 == *count)
 		*count = tsbufs;
 	*count = saa7134_buffer_count(*size,*count);
@@ -353,7 +356,7 @@ static int ts_do_ioctl(struct inode *ino
 		f->fmt.pix.width        = 720; /* D1 */
 		f->fmt.pix.height       = 576;
 		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
-		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*TS_NR_PACKETS;
+		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*ts_nr_packets;
 		return 0;
 	}
 	
@@ -379,7 +382,7 @@ static int ts_do_ioctl(struct inode *ino
 		f->fmt.pix.width        = 720; /* D1 */
 		f->fmt.pix.height       = 576;
 		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
-		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*TS_NR_PACKETS;
+		f->fmt.pix.sizeimage    = TS_PACKET_SIZE*ts_nr_packets;
 		return 0;
 	}
 
@@ -408,7 +411,7 @@ static int ts_do_ioctl(struct inode *ino
 
 	case MPEG_SETPARAMS:
 		return ts_init_encoder(dev, arg);
-	  
+		
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -455,6 +458,10 @@ int saa7134_ts_init1(struct saa7134_dev 
 		tsbufs = 2;
 	if (tsbufs > VIDEO_MAX_FRAME)
 		tsbufs = VIDEO_MAX_FRAME;
+	if (ts_nr_packets < 4)
+		ts_nr_packets = 4;
+	if (ts_nr_packets > 312)
+		ts_nr_packets = 312;
 
 	INIT_LIST_HEAD(&dev->ts_q.queue);
 	init_timer(&dev->ts_q.timeout);
@@ -472,9 +479,9 @@ int saa7134_ts_init1(struct saa7134_dev 
 	saa_writeb(SAA7134_TS_SERIAL1, 0x00);  /* deactivate TS softreset */
 	saa_writeb(SAA7134_TS_PARALLEL, 0xec); /* TSSOP high active, TSVAL high active, TSLOCK ignored */
 	saa_writeb(SAA7134_TS_PARALLEL_SERIAL, (TS_PACKET_SIZE-1));
-	saa_writeb(SAA7134_TS_DMA0, ((TS_NR_PACKETS-1)&0xff));
-	saa_writeb(SAA7134_TS_DMA1, (((TS_NR_PACKETS-1)>>8)&0xff));
-	saa_writeb(SAA7134_TS_DMA2, ((((TS_NR_PACKETS-1)>>16)&0x3f) | 0x00)); /* TSNOPIT=0, TSCOLAP=0 */	 
+	saa_writeb(SAA7134_TS_DMA0, ((ts_nr_packets-1)&0xff));
+	saa_writeb(SAA7134_TS_DMA1, (((ts_nr_packets-1)>>8)&0xff));
+	saa_writeb(SAA7134_TS_DMA2, ((((ts_nr_packets-1)>>16)&0x3f) | 0x00)); /* TSNOPIT=0, TSCOLAP=0 */	 
  
 	return 0;
 }
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-06-17 10:27:32.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-06-17 13:47:59.666294808 +0200
@@ -37,10 +37,6 @@ static unsigned int audio_debug = 0;
 MODULE_PARM(audio_debug,"i");
 MODULE_PARM_DESC(audio_debug,"enable debug messages [tv audio]");
 
-static unsigned int audio_carrier = 0;
-MODULE_PARM(audio_carrier,"i");
-MODULE_PARM_DESC(audio_carrier,"audio carrier location");
-
 static unsigned int audio_ddep = 0;
 MODULE_PARM(audio_ddep,"i");
 MODULE_PARM_DESC(audio_ddep,"audio ddep overwrite");
@@ -67,6 +63,30 @@ MODULE_PARM_DESC(audio_clock_tweak, "Aud
 /* ------------------------------------------------------------------ */
 /* saa7134 code                                                       */
 
+static struct mainscan {
+	char         *name;
+	v4l2_std_id  std;
+	int          carr;
+} mainscan[] = {
+	{
+		.name = "M",
+		.std  = V4L2_STD_NTSC | V4L2_STD_PAL_M,
+		.carr = 4500,
+	},{
+		.name = "BG",
+		.std  = V4L2_STD_PAL_BG,
+		.carr = 5500,
+	},{
+		.name = "I",
+		.std  = V4L2_STD_PAL_I,
+		.carr = 6000,
+	},{
+		.name = "DKL",
+		.std  = V4L2_STD_PAL_DK | V4L2_STD_SECAM,
+		.carr = 6500,
+	}
+};
+
 static struct saa7134_tvaudio tvaudio[] = {
 	{
 		.name          = "PAL-B/G FM-stereo",
@@ -146,7 +166,7 @@ static void tvaudio_init(struct saa7134_
 
 	if (UNSET != audio_clock_override)
 	        clock = audio_clock_override;
-
+	
 	/* init all audio registers */
 	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x00);
 	if (need_resched())
@@ -314,15 +334,15 @@ static int tvaudio_sleep(struct saa7134_
 	return dev->thread.scan1 != dev->thread.scan2;
 }
 
-static int tvaudio_checkcarrier(struct saa7134_dev *dev, int carrier)
+static int tvaudio_checkcarrier(struct saa7134_dev *dev, struct mainscan *scan)
 {
 	__s32 left,right,value;
 
 	if (audio_debug > 1) {
 		int i;
-		dprintk("debug %d:",carrier);
+		dprintk("debug %d:",scan->carr);
 		for (i = -150; i <= 150; i += 30) {
-			tvaudio_setcarrier(dev,carrier+i,carrier+i);
+			tvaudio_setcarrier(dev,scan->carr+i,scan->carr+i);
 			saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
 			if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
 				return -1;
@@ -334,24 +354,31 @@ static int tvaudio_checkcarrier(struct s
 		}
 		printk("\n");
 	}
-	
-	tvaudio_setcarrier(dev,carrier-90,carrier-90);
-	saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-	if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
-		return -1;
-	left = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-
-	tvaudio_setcarrier(dev,carrier+90,carrier+90);
-	saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-	if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
-		return -1;
-	right = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-
-	left >>= 16;
-        right >>= 16;
-	value = left > right ? left - right : right - left;
-	dprintk("scanning %d.%03d MHz =>  dc is %5d [%d/%d]\n",
-		carrier/1000,carrier%1000,value,left,right);
+
+	if (dev->tvnorm->id & scan->std) {
+		tvaudio_setcarrier(dev,scan->carr-90,scan->carr-90);
+		saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+		if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
+			return -1;
+		left = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+		
+		tvaudio_setcarrier(dev,scan->carr+90,scan->carr+90);
+		saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+		if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
+			return -1;
+		right = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
+		
+		left >>= 16;
+		right >>= 16;
+		value = left > right ? left - right : right - left;
+		dprintk("scanning %d.%03d MHz [%4s] =>  dc is %5d [%d/%d]\n",
+			scan->carr / 1000, scan->carr % 1000,
+			scan->name, value, left, right);
+	} else {
+		value = 0;
+		dprintk("skipping %d.%03d MHz [%4s]\n",
+			scan->carr / 1000, scan->carr % 1000, scan->name);
+	}
 	return value;
 }
 
@@ -384,6 +411,7 @@ static int tvaudio_getstereo(struct saa7
 	case TVAUDIO_FM_K_STEREO:
 	case TVAUDIO_FM_BG_STEREO:
 		idp = (saa_readb(SAA7134_IDENT_SIF) & 0xe0) >> 5;
+		dprintk("getstereo: fm/stereo: idp=0x%x\n",idp);
 		if (0x03 == (idp & 0x03))
 			retval = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 		else if (0x05 == (idp & 0x05))
@@ -397,6 +425,7 @@ static int tvaudio_getstereo(struct saa7
 	case TVAUDIO_NICAM_FM:
 	case TVAUDIO_NICAM_AM:
 		nicam = saa_readb(SAA7134_NICAM_STATUS);
+		dprintk("getstereo: nicam=0x%x\n",nicam);
 		switch (nicam & 0x0b) {
 		case 0x08:
 			retval = V4L2_TUNER_SUB_MONO;
@@ -458,16 +487,10 @@ static int tvaudio_setstereo(struct saa7
 
 static int tvaudio_thread(void *data)
 {
-#define MAX_SCAN 4
-	static const int carr_pal[MAX_SCAN]     = { 5500, 6000, 6500 };
-	static const int carr_ntsc[MAX_SCAN]    = { 4500 };
-	static const int carr_secam[MAX_SCAN]   = { 6500 };
-	static const int carr_default[MAX_SCAN] = { 4500, 5500, 6000, 6500 };
 	struct saa7134_dev *dev = data;
-	const int *carr_scan;
-	int carr_vals[4];
-	unsigned int i, audio;
-	int max1,max2,carrier,rx,mode,lastmode;
+	int carr_vals[ARRAY_SIZE(mainscan)];
+	unsigned int i, audio, nscan;
+	int max1,max2,carrier,rx,mode,lastmode,default_carrier;
 
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
@@ -488,32 +511,40 @@ static int tvaudio_thread(void *data)
 		if (tvaudio_sleep(dev,SCAN_INITIAL_DELAY))
 			goto restart;
 
-		/* find the main carrier */
-		carr_scan = carr_default;
-		if (dev->tvnorm->id & V4L2_STD_PAL)
-			carr_scan = carr_pal;
-		if (dev->tvnorm->id & V4L2_STD_NTSC)
-			carr_scan = carr_ntsc;
-		if (dev->tvnorm->id & V4L2_STD_SECAM)
-			carr_scan = carr_secam;
-		saa_writeb(SAA7134_MONITOR_SELECT,0x00);
-		tvaudio_setmode(dev,&tvaudio[0],NULL);
-		for (i = 0; i < MAX_SCAN; i++) {
-			if (!carr_scan[i])
+		max1 = 0;
+		max2 = 0;
+		nscan = 0;
+		carrier = 0;
+		default_carrier = 0;
+		for (i = 0; i < ARRAY_SIZE(mainscan); i++) {
+			if (!(dev->tvnorm->id & mainscan[i].std))
 				continue;
-			carr_vals[i] = tvaudio_checkcarrier(dev,carr_scan[i]);
-			if (dev->thread.scan1 != dev->thread.scan2)
-				goto restart;
+			if (!default_carrier)
+				default_carrier = mainscan[i].carr;
+			nscan++;
 		}
-		for (carrier = 0, max1 = 0, max2 = 0, i = 0; i < MAX_SCAN; i++) {
-			if (!carr_scan[i])
-				continue;
-			if (max1 < carr_vals[i]) {
-				max2 = max1;
-				max1 = carr_vals[i];
-				carrier = carr_scan[i];
-			} else if (max2 < carr_vals[i]) {
-				max2 = carr_vals[i];
+
+		if (1 == nscan) {
+			/* only one candidate -- skip scan ;) */
+			max1 = 12345;
+			carrier = default_carrier;
+		} else {
+			/* scan for the main carrier */
+			saa_writeb(SAA7134_MONITOR_SELECT,0x00);
+			tvaudio_setmode(dev,&tvaudio[0],NULL);
+			for (i = 0; i < ARRAY_SIZE(mainscan); i++) {
+				carr_vals[i] = tvaudio_checkcarrier(dev, mainscan+i);
+				if (dev->thread.scan1 != dev->thread.scan2)
+					goto restart;
+			}
+			for (max1 = 0, max2 = 0, i = 0; i < ARRAY_SIZE(mainscan); i++) {
+				if (max1 < carr_vals[i]) {
+					max2 = max1;
+					max1 = carr_vals[i];
+					carrier = mainscan[i].carr;
+				} else if (max2 < carr_vals[i]) {
+					max2 = carr_vals[i];
+				}
 			}
 		}
 
@@ -523,21 +554,17 @@ static int tvaudio_thread(void *data)
 				dev->tvnorm->name, carrier/1000, carrier%1000,
 				max1, max2);
 			dev->last_carrier = carrier;
-		} else if (0 != audio_carrier) {
-			/* no carrier -- try insmod option as fallback */
-			carrier = audio_carrier;
-			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
-			       "using %d.%03d MHz [insmod option]\n",
-			       dev->name, carrier/1000, carrier%1000);
+
 		} else if (0 != dev->last_carrier) {
 			/* no carrier -- try last detected one as fallback */
 			carrier = dev->last_carrier;
 			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
 			       "using %d.%03d MHz [last detected]\n",
 			       dev->name, carrier/1000, carrier%1000);
+
 		} else {
-			/* no carrier + no fallback -- try first in list */
-			carrier = carr_scan[0];
+			/* no carrier + no fallback -- use default */
+			carrier = default_carrier;
 			printk(KERN_WARNING "%s/audio: audio carrier scan failed, "
 			       "using %d.%03d MHz [default]\n",
 			       dev->name, carrier/1000, carrier%1000);
@@ -550,7 +577,7 @@ static int tvaudio_thread(void *data)
 		/* find the exact tv audio norm */
 		for (audio = UNSET, i = 0; i < TVAUDIO; i++) {
 			if (dev->tvnorm->id != UNSET &&
-			    dev->tvnorm->id != tvaudio[i].std)
+			    !(dev->tvnorm->id & tvaudio[i].std))
 				continue;
 			if (tvaudio[i].carr1 != carrier)
 				continue;
@@ -722,15 +749,20 @@ static int mute_input_7133(struct saa713
 static int tvaudio_thread_ddep(void *data)
 {
 	struct saa7134_dev *dev = data;
-	u32 value, norms;
+	u32 value, norms, clock;
 
 	daemonize("%s", dev->name);
 	allow_signal(SIGTERM);
 
+	clock = saa7134_boards[dev->board].audio_clock;
+	if (UNSET != audio_clock_override)
+		clock = audio_clock_override;
+	saa_writel(0x598 >> 2, clock);
+	
 	/* unmute */
 	saa_dsp_writel(dev, 0x474 >> 2, 0x00);
 	saa_dsp_writel(dev, 0x450 >> 2, 0x00);
-
+	
 	for (;;) {
 		tvaudio_sleep(dev,-1);
 		if (dev->thread.shutdown || signal_pending(current))
@@ -769,9 +801,11 @@ static int tvaudio_thread_ddep(void *dat
 				(norms & 0x40) ? " M"    : "");
 		}
 
-		/* quick & dirty -- to be fixed up later ... */
+		/* kick automatic standard detection */
 		saa_dsp_writel(dev, 0x454 >> 2, 0);
 		saa_dsp_writel(dev, 0x454 >> 2, norms | 0x80);
+
+		/* setup crossbars */
 		saa_dsp_writel(dev, 0x464 >> 2, 0x000000);
 		saa_dsp_writel(dev, 0x470 >> 2, 0x101010);
 
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.7/drivers/media/video/saa7134/saa7134-video.c	2004-06-17 10:28:04.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2004-06-17 13:47:59.671293867 +0200
@@ -28,13 +28,15 @@
 #include "saa7134-reg.h"
 #include "saa7134.h"
 
+#define V4L2_I2C_CLIENTS 1
+
 /* ------------------------------------------------------------------ */
 
 static unsigned int video_debug   = 0;
 static unsigned int gbuffers      = 8;
 static unsigned int noninterlaced = 0;
-static unsigned int gbufsize      = 768*576*4;
-static unsigned int gbufsize_max  = 768*576*4;
+static unsigned int gbufsize      = 720*576*4;
+static unsigned int gbufsize_max  = 720*576*4;
 MODULE_PARM(video_debug,"i");
 MODULE_PARM_DESC(video_debug,"enable debug messages [video]");
 MODULE_PARM(gbuffers,"i");
@@ -148,10 +150,65 @@ static struct saa7134_format formats[] =
 };
 #define FORMATS ARRAY_SIZE(formats)
 
+#define NORM_625_50			\
+		.h_start       = 0,	\
+		.h_stop        = 719,	\
+		.video_v_start = 24,	\
+		.video_v_stop  = 311,	\
+		.vbi_v_start   = 7,	\
+		.vbi_v_stop    = 22,	\
+		.src_timing    = 4
+
+#define NORM_525_60			\
+		.h_start       = 0,	\
+		.h_stop        = 703,	\
+		.video_v_start = 22,	\
+		.video_v_stop  = 22+239, \
+		.vbi_v_start   = 10, /* FIXME */ \
+		.vbi_v_stop    = 21, /* FIXME */ \
+		.src_timing    = 1
+
 static struct saa7134_tvnorm tvnorms[] = {
 	{
-		.name          = "PAL",
+		.name          = "PAL", /* autodetect */
 		.id            = V4L2_STD_PAL,
+		NORM_625_50,
+
+		.sync_control  = 0x18,
+		.luma_control  = 0x40,
+		.chroma_ctrl1  = 0x81,
+		.chroma_gain   = 0x2a,
+		.chroma_ctrl2  = 0x06,
+		.vgate_misc    = 0x1c,
+
+	},{
+		.name          = "PAL-BG",
+		.id            = V4L2_STD_PAL_BG,
+		NORM_625_50,
+
+		.sync_control  = 0x18,
+		.luma_control  = 0x40,
+		.chroma_ctrl1  = 0x81,
+		.chroma_gain   = 0x2a,
+		.chroma_ctrl2  = 0x06,
+		.vgate_misc    = 0x1c,
+
+	},{
+		.name          = "PAL-I",
+		.id            = V4L2_STD_PAL_I,
+		NORM_625_50,
+
+		.sync_control  = 0x18,
+		.luma_control  = 0x40,
+		.chroma_ctrl1  = 0x81,
+		.chroma_gain   = 0x2a,
+		.chroma_ctrl2  = 0x06,
+		.vgate_misc    = 0x1c,
+
+	},{
+		.name          = "PAL-DK",
+		.id            = V4L2_STD_PAL_DK,
+		NORM_625_50,
 
 		.sync_control  = 0x18,
 		.luma_control  = 0x40,
@@ -160,16 +217,10 @@ static struct saa7134_tvnorm tvnorms[] =
 		.chroma_ctrl2  = 0x06,
 		.vgate_misc    = 0x1c,
 
-		.h_start       = 0,
-		.h_stop        = 719,
-		.video_v_start = 24,
-		.video_v_stop  = 311,
-		.vbi_v_start   = 7,
-		.vbi_v_stop    = 22,
-		.src_timing    = 4,
 	},{
 		.name          = "NTSC",
 		.id            = V4L2_STD_NTSC,
+		NORM_525_60,
 
 		.sync_control  = 0x59,
 		.luma_control  = 0x40,
@@ -178,16 +229,10 @@ static struct saa7134_tvnorm tvnorms[] =
 		.chroma_ctrl2  = 0x0e,
 		.vgate_misc    = 0x18,
 
-		.h_start       = 0,
-		.h_stop        = 719,
-		.video_v_start = 22,
-		.video_v_stop  = 22+240,
-		.vbi_v_start   = 10, /* FIXME */
-		.vbi_v_stop    = 21, /* FIXME */
-		.src_timing    = 1,
 	},{
 		.name          = "SECAM",
 		.id            = V4L2_STD_SECAM,
+		NORM_625_50,
 
 		.sync_control  = 0x18, /* old: 0x58, */
 		.luma_control  = 0x1b,
@@ -196,16 +241,10 @@ static struct saa7134_tvnorm tvnorms[] =
 		.chroma_ctrl2  = 0x00,
 		.vgate_misc    = 0x1c,
 
-		.h_start       = 0,
-		.h_stop        = 719,
-		.video_v_start = 24,
-		.video_v_stop  = 311,
-		.vbi_v_start   = 7,
-		.vbi_v_stop    = 22,
-		.src_timing    = 4,
 	},{
 		.name          = "PAL-M",
 		.id            = V4L2_STD_PAL_M,
+		NORM_525_60,
 
 		.sync_control  = 0x59,
 		.luma_control  = 0x40,
@@ -214,16 +253,10 @@ static struct saa7134_tvnorm tvnorms[] =
 		.chroma_ctrl2  = 0x0e,
 		.vgate_misc    = 0x18,
 
-		.h_start       = 0,
-		.h_stop        = 719,
-		.video_v_start = 22,
-		.video_v_stop  = 22+240,
-		.vbi_v_start   = 10, /* FIXME */
-		.vbi_v_stop    = 21, /* FIXME */
-		.src_timing    = 1,
 	},{
 		.name          = "PAL-Nc",
 		.id            = V4L2_STD_PAL_Nc,
+		NORM_625_50,
 
 		.sync_control  = 0x18,
 		.luma_control  = 0x40,
@@ -232,35 +265,6 @@ static struct saa7134_tvnorm tvnorms[] =
 		.chroma_ctrl2  = 0x06,
 		.vgate_misc    = 0x1c,
 
-		.h_start       = 0,
-		.h_stop        = 719,
-		.video_v_start = 24,
-		.video_v_stop  = 311,
-		.vbi_v_start   = 7,
-		.vbi_v_stop    = 22,
-		.src_timing    = 4,
-#if 0
-	},{
-		.name          = "AUTO",
-		.id            = V4L2_STD_PAL|V4L2_STD_NTSC|V4L2_STD_SECAM,
-		.width         = 768,
-		.height        = 576,
-
-		.sync_control  = 0x98,
-		.luma_control  = 0x40,
-		.chroma_ctrl1  = 0x8b,
-		.chroma_gain   = 0x00,
-		.chroma_ctrl2  = 0x00,
-		.vgate_misc    = 0x18,
-
-		.h_start       = 0,
-		.h_stop        = 719,
-		.video_v_start = 24,
-		.video_v_stop  = 311,
-		.vbi_v_start   = 7,
-		.vbi_v_stop    = 22,
-		.src_timing    = 4,
-#endif
 	}
 };
 #define TVNORMS ARRAY_SIZE(tvnorms)
@@ -429,7 +433,6 @@ void res_free(struct saa7134_dev *dev, s
 
 static void set_tvnorm(struct saa7134_dev *dev, struct saa7134_tvnorm *norm)
 {
-	struct video_channel c;
 	int luma_control,sync_control,mux;
 
 	dprintk("set tv norm = %s\n",norm->name);
@@ -489,15 +492,22 @@ static void set_tvnorm(struct saa7134_de
 	saa_writeb(SAA7134_RAW_DATA_GAIN,         0x40);
 	saa_writeb(SAA7134_RAW_DATA_OFFSET,       0x80);
 
-	/* pass down info to the i2c chips (v4l1) */
-	memset(&c,0,sizeof(c));
-	c.channel = dev->ctl_input;
-	c.norm = VIDEO_MODE_PAL;
-	if (norm->id & V4L2_STD_NTSC)
-		c.norm = VIDEO_MODE_NTSC;
-	if (norm->id & V4L2_STD_SECAM)
-		c.norm = VIDEO_MODE_SECAM;
-	saa7134_i2c_call_clients(dev,VIDIOCSCHAN,&c);
+#ifdef V4L2_I2C_CLIENTS
+	saa7134_i2c_call_clients(dev,VIDIOC_S_STD,&norm->id);
+#else
+	{
+		/* pass down info to the i2c chips (v4l1) */
+		struct video_channel c;
+		memset(&c,0,sizeof(c));
+		c.channel = dev->ctl_input;
+		c.norm = VIDEO_MODE_PAL;
+		if (norm->id & V4L2_STD_NTSC)
+			c.norm = VIDEO_MODE_NTSC;
+		if (norm->id & V4L2_STD_SECAM)
+			c.norm = VIDEO_MODE_SECAM;
+		saa7134_i2c_call_clients(dev,VIDIOCSCHAN,&c);
+	}
+#endif
 }
 
 static void video_mux(struct saa7134_dev *dev, int input)
@@ -583,7 +593,7 @@ static void set_size(struct saa7134_dev 
 	v_start = dev->crop_current.top/2;
 	h_stop  = (dev->crop_current.left + dev->crop_current.width -1);
 	v_stop  = (dev->crop_current.top + dev->crop_current.height -1)/2;
-
+	
 	saa_writeb(SAA7134_VIDEO_H_START1(task), h_start &  0xff);
 	saa_writeb(SAA7134_VIDEO_H_START2(task), h_start >> 8);
 	saa_writeb(SAA7134_VIDEO_H_STOP1(task),  h_stop  &  0xff);
@@ -593,11 +603,11 @@ static void set_size(struct saa7134_dev 
 	saa_writeb(SAA7134_VIDEO_V_STOP1(task),  v_stop  &  0xff);
 	saa_writeb(SAA7134_VIDEO_V_STOP2(task),  v_stop  >> 8);
 
-	prescale = dev->crop_defrect.width / width;
+	prescale = dev->crop_current.width / width;
 	if (0 == prescale)
 		prescale = 1;
-	xscale = 1024 * dev->crop_defrect.width / prescale / width;
-	yscale = 512 * div * dev->crop_defrect.height / height;
+	xscale = 1024 * dev->crop_current.width / prescale / width;
+	yscale = 512 * div * dev->crop_current.height / height;
        	dprintk("prescale=%d xscale=%d yscale=%d\n",prescale,xscale,yscale);
 	set_h_prescale(dev,task,prescale);
 	saa_writeb(SAA7134_H_SCALE_INC1(task),      xscale &  0xff);
@@ -909,10 +919,12 @@ static int buffer_prepare(struct file *f
 	/* sanity checks */
 	if (NULL == fh->fmt)
 		return -EINVAL;
-	if (fh->width  < 48 ||
-	    fh->height < 32 ||
-	    fh->width  > dev->crop_current.width ||
-	    fh->height > dev->crop_current.height)
+	if (fh->width    < 48 ||
+	    fh->height   < 32 ||
+	    fh->width/4  > dev->crop_current.width  ||
+	    fh->height/4 > dev->crop_current.height ||
+	    fh->width    > dev->crop_bounds.width  ||
+	    fh->height   > dev->crop_bounds.height)
 		return -EINVAL;
 	size = (fh->width * fh->height * fh->fmt->depth) >> 3;
 	if (0 != buf->vb.baddr  &&  buf->vb.bsize < size)
@@ -1192,7 +1204,7 @@ static int video_open(struct inode *inod
 	fh->radio    = radio;
 	fh->type     = type;
 	fh->fmt      = format_by_fourcc(V4L2_PIX_FMT_BGR24);
-	fh->width    = 768;
+	fh->width    = 720;
 	fh->height   = 576;
 #ifdef VIDIOC_G_PRIORITY
 	v4l2_prio_open(&dev->prio,&fh->prio);
@@ -1409,8 +1421,8 @@ int saa7134_try_fmt(struct saa7134_dev *
 			return -EINVAL;
 
 		field = f->fmt.pix.field;
-		maxw  = dev->crop_current.width;
-		maxh  = dev->crop_current.height;
+		maxw  = min(dev->crop_current.width*4,  dev->crop_bounds.width);
+		maxh  = min(dev->crop_current.height*4, dev->crop_bounds.height);
 		
 		if (V4L2_FIELD_ANY == field) {
 			field = (f->fmt.pix.height > maxh/2)
@@ -1670,10 +1682,14 @@ static int video_do_ioctl(struct inode *
 		v4l2_std_id *id = arg;
 		unsigned int i;
 
-		for(i = 0; i < TVNORMS; i++)
-			if (*id & tvnorms[i].id)
+		for (i = 0; i < TVNORMS; i++)
+			if (*id == tvnorms[i].id)
 				break;
 		if (i == TVNORMS)
+			for (i = 0; i < TVNORMS; i++)
+				if (*id & tvnorms[i].id)
+					break;
+		if (i == TVNORMS)
 			return -EINVAL;
 
 		down(&dev->lock);
@@ -1685,6 +1701,7 @@ static int video_do_ioctl(struct inode *
 			spin_unlock_irqrestore(&dev->slock,flags);
 		} else 
 			set_tvnorm(dev,&tvnorms[i]);
+		saa7134_tvaudio_do_scan(dev);
 		up(&dev->lock);
 		return 0;
 	}
@@ -1714,7 +1731,7 @@ static int video_do_ioctl(struct inode *
 	case VIDIOC_G_CROP:
 	{
 		struct v4l2_crop * crop = arg;
-
+		
 		if (crop->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
 		    crop->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
 			return -EINVAL;
@@ -1725,7 +1742,7 @@ static int video_do_ioctl(struct inode *
 	{
 		struct v4l2_crop *crop = arg;
 		struct v4l2_rect *b = &dev->crop_bounds;
-
+		
 		if (crop->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
 		    crop->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
 			return -EINVAL;
@@ -1745,7 +1762,7 @@ static int video_do_ioctl(struct inode *
 			crop->c.top = b->top + b->height;
 		if (crop->c.height > b->top - crop->c.top + b->height)
 			crop->c.height = b->top - crop->c.top + b->height;
-
+		
 		if (crop->c.left < b->left)
 			crop->c.top = b->left;
 		if (crop->c.left > b->left + b->width)
@@ -1817,7 +1834,11 @@ static int video_do_ioctl(struct inode *
 			return -EINVAL;
 		down(&dev->lock);
 		dev->ctl_freq = f->frequency;
+#ifdef V4L2_I2C_CLIENTS
+		saa7134_i2c_call_clients(dev,VIDIOC_S_FREQUENCY,f);
+#else
 		saa7134_i2c_call_clients(dev,VIDIOCSFREQ,&dev->ctl_freq);
+#endif
 		saa7134_tvaudio_do_scan(dev);
 		up(&dev->lock);
 		return 0;
@@ -2064,7 +2085,6 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_G_TUNER:
 	{
 		struct v4l2_tuner *t = arg;
-		struct video_tuner vt;
 
 		if (0 != t->index)
 			return -EINVAL;
@@ -2073,10 +2093,17 @@ static int radio_do_ioctl(struct inode *
 		strcpy(t->name, "Radio");
                 t->rangelow  = (int)(65*16);
                 t->rangehigh = (int)(108*16);
-		
-		memset(&vt,0,sizeof(vt));
-		saa7134_i2c_call_clients(dev,VIDIOCGTUNER,&vt);
-		t->signal = vt.signal;
+
+#ifdef V4L2_I2C_CLIENTS
+		saa7134_i2c_call_clients(dev,VIDIOC_G_TUNER,t);
+#else		
+		{
+			struct video_tuner vt;
+			memset(&vt,0,sizeof(vt));
+			saa7134_i2c_call_clients(dev,VIDIOCGTUNER,&vt);
+			t->signal = vt.signal;
+		}
+#endif
 		return 0;
 	}
 	case VIDIOC_ENUMINPUT:
diff -up linux-2.6.7/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.7/drivers/media/video/saa7134/saa7134.h	2004-06-17 10:30:13.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134.h	2004-06-17 13:47:59.674293303 +0200
@@ -19,7 +19,7 @@
  */
 
 #include <linux/version.h>
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,11)
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,12)
 
 #include <linux/pci.h>
 #include <linux/i2c.h>
@@ -152,6 +152,10 @@ struct saa7134_format {
 #define SAA7134_BOARD_ECS_TVP3XP_4CB5  31
 #define SAA7134_BOARD_AVACSSMARTTV     32
 #define SAA7134_BOARD_AVERMEDIA_DVD_EZMAKER 33
+#define SAA7134_BOARD_NOVAC_PRIMETV7133 34
+#define SAA7134_BOARD_AVERMEDIA_305    35
+#define SAA7133_BOARD_UPMOST_PURPLE_TV 36
+#define SAA7134_BOARD_ITEMS_MTV005     37
 
 #define SAA7134_INPUT_MAX 8
 
@@ -393,12 +397,12 @@ struct saa7134_dev {
 	int                        ctl_mirror;
 	int                        ctl_y_odd;
 	int                        ctl_y_even;
-
+	
 	/* crop */
 	struct v4l2_rect           crop_bounds;
 	struct v4l2_rect           crop_defrect;
 	struct v4l2_rect           crop_current;
-
+	
 	/* other global state info */
 	unsigned int               automute;
 	struct saa7134_thread      thread;

-- 
Smoking Crack Organization
