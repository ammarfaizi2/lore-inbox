Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUIPJn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUIPJn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUIPJn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:43:58 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:29662 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266790AbUIPJk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:40:27 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 16 Sep 2004 11:15:05 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv update
Message-ID: <20040916091505.GA11528@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This update for the bttv driver fixes kernel crashes when capturing
planar yuv images.  It also added sanity checks for the bt878 risc
code buffer sizes, adds support for a new tv card and has some minor
code cleanups.

  Gerd

diff -up linux-2.6.9-rc2/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.9-rc2/drivers/media/video/bttv-cards.c	2004-09-14 10:35:26.000000000 +0200
+++ linux/drivers/media/video/bttv-cards.c	2004-09-16 10:06:33.000000000 +0200
@@ -1,4 +1,6 @@
 /*
+    $Id: bttv-cards.c,v 1.26 2004/09/15 16:15:24 kraxel Exp $
+
     bttv-cards.c
 
     this file has configuration informations - card-specific stuff
@@ -308,6 +310,7 @@ static struct CARD {
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
 	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia DVB-T 771" },
+	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
 	
 	{ 0, -1, NULL }
 };
@@ -2147,6 +2150,19 @@ struct tvcard bttv_tvcards[] = {
 	.tuner_type     = TUNER_PHILIPS_PAL,
 	.has_remote     = 1,   /* miniremote works, see ir-kbd-gpio.c */
 	.has_radio      = 1,   /* not every card has radio */
+},{
+
+	/* ---- card 0x80 ---------------------------------- */
+	/* Chris Pascoe <c.pascoe@itee.uq.edu.au> */
+	.name           = "DVICO FusionHDTV DVB-T Lite",
+	.tuner          = -1,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.pll            = PLL_28,
+	.no_video       = 1,
+	.has_dvb        = 1,
+	.tuner_type     = -1,
 }};
 
 const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2854,7 +2870,8 @@ static void __devinit hauppauge_eeprom(s
 	if (bttv_verbose)
 		printk(KERN_INFO "bttv%d: Hauppauge eeprom: model=%d, "
 		       "tuner=%s (%d), radio=%s\n",
-		       btv->c.nr, model, hauppauge_tuner[tuner].name,
+		       btv->c.nr, model, (tuner < ARRAY_SIZE(hauppauge_tuner)
+					  ? hauppauge_tuner[tuner].name : "?"),
 		       btv->tuner_type, radio ? "yes" : "no");
 }
 
@@ -4145,7 +4162,7 @@ static void PXC200_muxsel(struct bttv *b
 	  return;
 	}
 
-	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),0);
+	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),NULL);
 	if (!(rc & PX_CFG_PXC200F)) {
 	  printk(KERN_DEBUG "bttv%d: PXC200_muxsel: not PXC200F rc:%d \n", btv->c.nr,rc);
 	  return;
diff -up linux-2.6.9-rc2/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc2/drivers/media/video/bttv-driver.c	2004-09-14 10:37:08.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-09-16 10:06:33.000000000 +0200
@@ -1,4 +1,6 @@
 /*
+    $Id: bttv-driver.c,v 1.14 2004/09/15 16:15:24 kraxel Exp $
+
     bttv - Bt848 frame grabber driver
     
     Copyright (C) 1996,97,98 Ralph  Metzler <rjkm@thp.uni-koeln.de>
@@ -743,8 +745,7 @@ static void set_pll(struct bttv *btv)
         for (i=0; i<10; i++) {
 		/*  Let other people run while the PLL stabilizes */
 		vprintk(".");
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/50);
+		msleep(10);
 		
                 if (btread(BT848_DSTATUS) & BT848_DSTATUS_PLOCK) {
 			btwrite(0,BT848_DSTATUS);
diff -up linux-2.6.9-rc2/drivers/media/video/bttv-risc.c linux/drivers/media/video/bttv-risc.c
--- linux-2.6.9-rc2/drivers/media/video/bttv-risc.c	2004-09-14 10:35:33.000000000 +0200
+++ linux/drivers/media/video/bttv-risc.c	2004-09-16 10:06:33.000000000 +0200
@@ -1,4 +1,6 @@
 /*
+    $Id: bttv-risc.c,v 1.7 2004/09/16 07:05:48 kraxel Exp $
+
     bttv-risc.c  --  interfaces to other kernel modules
 
     bttv risc code handling
@@ -55,8 +57,6 @@ bttv_risc_packed(struct bttv *btv, struc
 	instructions += 2;
 	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
 		return rc;
-	dprintk("bttv%d: risc packed: bpl %d lines %d instr %d size %d ptr %p\n",
-		btv->c.nr, bpl, lines, instructions, risc->size, risc->cpu);
 
 	/* sync instruction */
 	rp = risc->cpu;
@@ -101,13 +101,11 @@ bttv_risc_packed(struct bttv *btv, struc
 			offset += todo;
 		}
 		offset += padding;
-		dprintk("bttv%d: risc packed:   line %d ptr %p\n",
-			btv->c.nr, line, rp);
 	}
-	dprintk("bttv%d: risc packed: %d sglist elems\n", btv->c.nr, (int)(sg-sglist));
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
+	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
 	return 0;
 }
 
@@ -125,6 +123,7 @@ bttv_risc_planar(struct bttv *btv, struc
 	struct scatterlist *ysg;
 	struct scatterlist *usg;
 	struct scatterlist *vsg;
+	int topfield = (0 == yoffset);
 	int rc;
 
 	/* estimate risc mem: worst case is one write per page border +
@@ -153,16 +152,16 @@ bttv_risc_planar(struct bttv *btv, struc
 			chroma = 1;
 			break;
 		case 1:
-			if (!yoffset)
-				chroma = (line & 1) == 0;
+			if (topfield)
+				chroma = ((line & 1) == 0);
 			else
-				chroma = (line & 1) == 1;
+				chroma = ((line & 1) == 1);
 			break;
 		case 2:
-			if (!yoffset)
-				chroma = (line & 3) == 0;
+			if (topfield)
+				chroma = ((line & 3) == 0);
 			else
-				chroma = (line & 3) == 2;
+				chroma = ((line & 3) == 2);
 			break;
 		default:
 			chroma = 0;
@@ -224,6 +223,7 @@ bttv_risc_planar(struct bttv *btv, struc
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
+	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
 	return 0;
 }
 
@@ -308,6 +308,7 @@ bttv_risc_overlay(struct bttv *btv, stru
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
+	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
 	kfree(skips);
 	return 0;
 }
diff -up linux-2.6.9-rc2/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.9-rc2/drivers/media/video/bttv.h	2004-09-14 10:34:45.000000000 +0200
+++ linux/drivers/media/video/bttv.h	2004-09-16 10:06:33.000000000 +0200
@@ -1,4 +1,6 @@
 /*
+ * $Id: bttv.h,v 1.9 2004/09/15 16:15:24 kraxel Exp $
+ *
  *  bttv - Bt848 frame grabber driver
  *
  *  card ID's and external interfaces of the bttv driver
@@ -130,6 +132,7 @@
 #define BTTV_MATRIX_VISIONSQ  0x7d
 #define BTTV_MATRIX_VISIONSLC 0x7e
 #define BTTV_APAC_VIEWCOMP  0x7f
+#define BTTV_DVICO_DVBT_LITE  0x80
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2

-- 
return -ENOSIG;
