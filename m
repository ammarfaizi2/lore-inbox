Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUHaPpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUHaPpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUHaPoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:44:37 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:32982 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268756AbUHaPmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:42:47 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 Aug 2004 17:24:05 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 3/4] v4l: bttv driver update.
Message-ID: <20040831152405.GA15658@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch is a minor update for the bttv driver.  Changes:

  * add a few new tv cards.
  * add some infrastructure needed by the dvb drivers (for bt878-based
    dvb cards).
  * improve croma line selection for planar video formats,
  * some new debug printk's

please apply,

  Gerd

diff -up linux-2.6.9-rc1/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.9-rc1/drivers/media/video/bttv-cards.c	2004-08-25 16:12:13.000000000 +0200
+++ linux/drivers/media/video/bttv-cards.c	2004-08-25 18:20:58.326475321 +0200
@@ -31,7 +31,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#ifdef CONFIG_FW_LOADER
+#if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
 # include <linux/firmware.h>
 #endif
 
@@ -74,6 +74,9 @@ static void PXC200_muxsel(struct bttv *b
 static void picolo_tetra_muxsel(struct bttv *btv, unsigned int input);
 static void picolo_tetra_init(struct bttv *btv);
 
+static void sigmaSLC_muxsel(struct bttv *btv, unsigned int input);
+static void sigmaSQ_muxsel(struct bttv *btv, unsigned int input);
+
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
 static int tea5757_write(struct bttv *btv, int value);
@@ -170,6 +173,7 @@ static struct CARD {
 
 	{ 0x6606107d, BTTV_WINFAST2000,   "Leadtek WinFast TV 2000" },
 	{ 0x6607107d, BTTV_WINFASTVC100,  "Leadtek WinFast VC 100" },
+	{ 0x6609107d, BTTV_WINFAST2000,   "Leadtek TV 2000 XP" },
 	{ 0x263610b4, BTTV_STB2,          "STB TV PCI FM, Gateway P/N 6000704" },
 	{ 0x264510b4, BTTV_STB2,          "STB TV PCI FM, Gateway P/N 6000704" },
  	{ 0x402010fc, BTTV_GVBCTV3PCI,    "I-O Data Co. GV-BCTV3/PCI" },
@@ -224,6 +228,7 @@ static struct CARD {
 	{ 0x1431aa00, BTTV_PV143,         "Provideo PV143B" },
 	{ 0x1432aa00, BTTV_PV143,         "Provideo PV143C" },
 	{ 0x1433aa00, BTTV_PV143,         "Provideo PV143D" },
+	{ 0x1433aa03, BTTV_PV143,         "Security Eyes" },
 
 	{ 0x1460aa00, BTTV_PV150,         "Provideo PV150A-1" },
 	{ 0x1461aa01, BTTV_PV150,         "Provideo PV150A-2" },
@@ -265,6 +270,7 @@ static struct CARD {
 	{ 0x01020304, BTTV_XGUARD,        "Grandtec Grand X-Guard" },
 	
 	{ 0x18501851, BTTV_CHRONOS_VS2,   "FlyVideo 98 (LR50)/ Chronos Video Shuttle II" },
+	{ 0xa0501851, BTTV_CHRONOS_VS2,   "FlyVideo 98 (LR50)/ Chronos Video Shuttle II" },
 	{ 0x18511851, BTTV_FLYVIDEO98EZ,  "FlyVideo 98EZ (LR51)/ CyberMail AV" },
 	{ 0x18521852, BTTV_TYPHOON_TVIEW, "FlyVideo 98FM (LR50)/ Typhoon TView TV/FM Tuner" },
 	{ 0x41a0a051, BTTV_FLYVIDEO_98FM, "Lifeview FlyVideo 98 LR50 Rev Q" },
@@ -297,7 +303,7 @@ static struct CARD {
 	
 	// DVB cards (using pci function .1 for mpeg data xfer)
 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
-	{ 0x07611461, BTTV_NEBULA_DIGITV, "AverMedia AverTV DVB-T" },
+	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T" },
 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
@@ -2078,6 +2084,69 @@ struct tvcard bttv_tvcards[] = {
 #if 0 /* untested */
         .has_remote     = 1,
 #endif
+},{
+	/* ---- card 0x7c ---------------------------------- */
+	/* Matt Jesson <dvb@jesson.eclipse.co.uk> */
+	/* Based on the Nebula card data - added remote and new card number - BTTV_AVDVBT_761, see also ir-kbd-gpio.c */
+	.name           = "AverMedia AverTV DVB-T 761",
+	.video_inputs   = 1,
+	.tuner          = -1,
+	.svhs           = -1,
+	.muxsel         = { 2, 3, 1, 0},
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.pll            = PLL_28,
+	.tuner_type     = -1,
+	.has_dvb        = 1,
+	.no_gpioirq     = 1,
+	.has_remote     = 1,
+},{
+	/* andre.schwarz@matrix-vision.de */
+	.name             = "MATRIX Vision Sigma-SQ",
+	.video_inputs     = 16,
+	.audio_inputs     = 0,
+	.tuner            = -1,
+	.svhs             = -1,
+	.gpiomask         = 0x0,
+	.muxsel           = { 2, 2, 2, 2, 2, 2, 2, 2,
+			      3, 3, 3, 3, 3, 3, 3, 3 },
+	.muxsel_hook      = sigmaSQ_muxsel,
+	.audiomux         = { 0 },
+	.no_msp34xx       = 1,
+	.pll              = PLL_28,
+	.tuner_type       = -1,
+},{
+	/* andre.schwarz@matrix-vision.de */
+	.name             = "MATRIX Vision Sigma-SLC",
+	.video_inputs     = 4,
+	.audio_inputs     = 0,
+	.tuner            = -1,
+	.svhs             = -1,
+	.gpiomask         = 0x0,
+	.muxsel           = { 2, 2, 2, 2 },
+	.muxsel_hook      = sigmaSLC_muxsel,
+	.audiomux         = { 0 },
+	.no_msp34xx       = 1,
+	.pll              = PLL_28,
+	.tuner_type       = -1,
+},{
+	/* BTTV_APAC_VIEWCOMP */
+	/* Attila Kondoros <attila.kondoros@chello.hu> */
+	/* bt878 TV + FM 0x00000000 subsystem ID */
+	.name           = "APAC Viewcomp 878(AMAX)",
+	.video_inputs   = 2,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = -1,
+	.gpiomask       = 0xFF,
+	.muxsel         = { 2, 3, 1, 1},
+	.audiomux       = { 2, 0, 0, 0, 10},
+	.needs_tvaudio  = 0,
+	.pll            = PLL_28,
+	.tuner_type     = TUNER_PHILIPS_PAL,
+	.has_remote     = 1,   /* miniremote works, see ir-kbd-gpio.c */
+	.has_radio      = 1,   /* not every card has radio */
 }};
 
 const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2405,6 +2474,19 @@ static void init_lmlbt4x(struct bttv *bt
 	gpio_write(0x000000);
 }
 
+static void sigmaSQ_muxsel(struct bttv *btv, unsigned int input)
+{
+	unsigned int inmux = input % 8;
+	gpio_inout( 0xf, 0xf );
+	gpio_bits( 0xf, inmux );
+}
+
+static void sigmaSLC_muxsel(struct bttv *btv, unsigned int input)
+{
+	unsigned int inmux = input % 4;
+	gpio_inout( 3<<9, 3<<9 );
+	gpio_bits( 3<<9, inmux<<9 );
+}
 
 /* ----------------------------------------------------------------------- */
 
@@ -2859,7 +2941,7 @@ static int __devinit pvr_altera_load(str
 	return 0;
 }
 
-#ifndef CONFIG_FW_LOADER
+#if !defined(CONFIG_FW_LOADER) && !defined(CONFIG_FW_LOADER_MODULE)
 /* old 2.4.x way -- via soundcore's mod_firmware_load */
    
 static char *firm_altera = "/usr/lib/video4linux/hcwamc.rbf";
@@ -4063,7 +4145,7 @@ static void PXC200_muxsel(struct bttv *b
 	  return;
 	}
 
-	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),NULL);
+	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),0);
 	if (!(rc & PX_CFG_PXC200F)) {
 	  printk(KERN_DEBUG "bttv%d: PXC200_muxsel: not PXC200F rc:%d \n", btv->c.nr,rc);
 	  return;
diff -up linux-2.6.9-rc1/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc1/drivers/media/video/bttv-driver.c	2004-08-25 16:12:57.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-08-25 18:20:58.331474387 +0200
@@ -2052,6 +2052,7 @@ static int bttv_try_fmt(struct bttv_fh *
 			f->fmt.pix.width = maxw;
 		if (f->fmt.pix.height > maxh)
 			f->fmt.pix.height = maxh;
+		f->fmt.pix.width &= ~0x03;
 		f->fmt.pix.bytesperline =
 			(f->fmt.pix.width * fmt->depth) >> 3;
 		f->fmt.pix.sizeimage =
diff -up linux-2.6.9-rc1/drivers/media/video/bttv-gpio.c linux/drivers/media/video/bttv-gpio.c
--- linux-2.6.9-rc1/drivers/media/video/bttv-gpio.c	2004-08-25 16:12:57.000000000 +0200
+++ linux/drivers/media/video/bttv-gpio.c	2004-08-25 18:20:58.333474013 +0200
@@ -106,6 +106,20 @@ void bttv_gpio_irq(struct bttv_core *cor
 	}
 }
 
+void bttv_i2c_info(struct bttv_core *core, struct i2c_client *client, int attach)
+{
+	struct bttv_sub_driver *drv;
+	struct bttv_sub_device *dev;
+	struct list_head *item;
+
+	list_for_each(item,&core->subs) {
+		dev = list_entry(item,struct bttv_sub_device,list);
+		drv = to_bttv_sub_drv(dev->dev.driver);
+		if (drv && drv->i2c_info)
+			drv->i2c_info(dev,client,attach);
+	}
+}
+
 /* ----------------------------------------------------------------------- */
 /* external: sub-driver register/unregister                                */
 
diff -up linux-2.6.9-rc1/drivers/media/video/bttv-i2c.c linux/drivers/media/video/bttv-i2c.c
--- linux-2.6.9-rc1/drivers/media/video/bttv-i2c.c	2004-08-25 16:11:07.000000000 +0200
+++ linux/drivers/media/video/bttv-i2c.c	2004-08-25 18:20:58.336473452 +0200
@@ -40,6 +40,7 @@ static void bttv_inc_use(struct i2c_adap
 static void bttv_dec_use(struct i2c_adapter *adap);
 #endif
 static int attach_inform(struct i2c_client *client);
+static int detach_inform(struct i2c_client *client);
 
 static int i2c_debug = 0;
 static int i2c_hw = 0;
@@ -114,6 +115,7 @@ static struct i2c_adapter bttv_i2c_adap_
 	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
+	.client_unregister = detach_inform,
 };
 
 /* ----------------------------------------------------------------------- */
@@ -298,6 +300,7 @@ static struct i2c_adapter bttv_i2c_adap_
 	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
 	.algo          = &bttv_algo,
 	.client_register = attach_inform,
+	.client_unregister = detach_inform,
 };
 
 /* ----------------------------------------------------------------------- */
@@ -324,6 +327,7 @@ static int attach_inform(struct i2c_clie
 	if (btv->pinnacle_id != UNSET)
 		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,
 				      &btv->pinnacle_id);
+	bttv_i2c_info(&btv->c, client, 1);
 
         if (bttv_debug)
 		printk("bttv%d: i2c attach [client=%s]\n",
@@ -331,6 +335,14 @@ static int attach_inform(struct i2c_clie
         return 0;
 }
 
+static int detach_inform(struct i2c_client *client)
+{
+        struct bttv *btv = i2c_get_adapdata(client->adapter);
+
+	bttv_i2c_info(&btv->c, client, 0);
+	return 0;
+}
+
 void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg)
 {
 	if (0 != btv->i2c_rc)
diff -up linux-2.6.9-rc1/drivers/media/video/bttv-risc.c linux/drivers/media/video/bttv-risc.c
--- linux-2.6.9-rc1/drivers/media/video/bttv-risc.c	2004-08-25 16:12:16.000000000 +0200
+++ linux/drivers/media/video/bttv-risc.c	2004-08-25 18:20:58.339472891 +0200
@@ -55,6 +55,8 @@ bttv_risc_packed(struct bttv *btv, struc
 	instructions += 2;
 	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
 		return rc;
+	dprintk("bttv%d: risc packed: bpl %d lines %d instr %d size %d ptr %p\n",
+		btv->c.nr, bpl, lines, instructions, risc->size, risc->cpu);
 
 	/* sync instruction */
 	rp = risc->cpu;
@@ -99,8 +101,10 @@ bttv_risc_packed(struct bttv *btv, struc
 			offset += todo;
 		}
 		offset += padding;
+		dprintk("bttv%d: risc packed:   line %d ptr %p\n",
+			btv->c.nr, line, rp);
 	}
-	dprintk("bttv%d: risc planar: %d sglist elems\n", btv->c.nr, (int)(sg-sglist));
+	dprintk("bttv%d: risc packed: %d sglist elems\n", btv->c.nr, (int)(sg-sglist));
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
@@ -145,11 +149,26 @@ bttv_risc_planar(struct bttv *btv, struc
 		    (line >= (ylines - VCR_HACK_LINES)))
 			continue;
 		switch (vshift) {
-		case 0:  chroma = 1;           break;
-		case 1:  chroma = !(line & 1); break;
-		case 2:  chroma = !(line & 3); break;
-		default: chroma = 0;
+		case 0:
+			chroma = 1;
+			break;
+		case 1:
+			if (!yoffset)
+				chroma = (line & 1) == 0;
+			else
+				chroma = (line & 1) == 1;
+			break;
+		case 2:
+			if (!yoffset)
+				chroma = (line & 3) == 0;
+			else
+				chroma = (line & 3) == 2;
+			break;
+		default:
+			chroma = 0;
+			break;
 		}
+
 		for (todo = ybpl; todo > 0; todo -= ylen) {
 			/* go to next sg entry if needed */
 			while (yoffset && yoffset >= sg_dma_len(ysg)) {
diff -up linux-2.6.9-rc1/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.9-rc1/drivers/media/video/bttv.h	2004-08-25 16:11:16.000000000 +0200
+++ linux/drivers/media/video/bttv.h	2004-08-25 18:20:58.341472517 +0200
@@ -126,6 +126,10 @@
 #define BTTV_LMLBT4         0x76
 #define BTTV_PICOLO_TETRA_CHIP 0x79
 #define BTTV_AVDVBT_771     0x7b
+#define BTTV_AVDVBT_761     0x7c
+#define BTTV_MATRIX_VISIONSQ  0x7d
+#define BTTV_MATRIX_VISIONSLC 0x7e
+#define BTTV_APAC_VIEWCOMP  0x7f
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
@@ -298,6 +302,8 @@ struct bttv_sub_driver {
 	struct device_driver   drv;
 	char                   wanted[BUS_ID_SIZE];
 	void                   (*gpio_irq)(struct bttv_sub_device *sub);
+	void                   (*i2c_info)(struct bttv_sub_device *sub,
+					   struct i2c_client *client, int attach);
 };
 #define to_bttv_sub_drv(x) container_of((x), struct bttv_sub_driver, drv)
 
diff -up linux-2.6.9-rc1/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.9-rc1/drivers/media/video/bttvp.h	2004-08-25 16:11:59.000000000 +0200
+++ linux/drivers/media/video/bttvp.h	2004-08-25 18:20:58.344471957 +0200
@@ -225,6 +225,7 @@ extern struct bus_type bttv_sub_bus_type
 int bttv_sub_add_device(struct bttv_core *core, char *name);
 int bttv_sub_del_devices(struct bttv_core *core);
 void bttv_gpio_irq(struct bttv_core *core);
+void bttv_i2c_info(struct bttv_core *core, struct i2c_client *client, int attach);
 
 
 /* ---------------------------------------------------------- */

-- 
return -ENOSIG;
