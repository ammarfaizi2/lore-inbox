Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUDEMYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUDEMYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:24:55 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:38818 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262272AbUDEMUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:20:36 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 14:20:52 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] v4l: bttv driver update
Message-ID: <20040405122052.GA29562@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the bttv driver.  Changes:

  (1) several card-specific tweaks.
  (2) make software vs. hardware i2c configurable per TV card.
  (3) reinitialize image parameters after chip reset.
  (4) make bttv quite by default on frame drops.
  (5) new insmod option: "debug_latency=1" to enable frame drop
      debug messages.

bttv is quite sensitive to irq latencies, especially when capturing
both video and vbi.  There are several reports about problems due to
this, I don't see that on my machines through.  (5) dumps a stracktrace
if the driver thinks the frame drop is is caused by high latencies as
experiment, lets see whenever that helps ...

  Gerd

diff -up linux-2.6.5/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.5/drivers/media/video/bttv-cards.c	2004-04-05 10:40:46.550267112 +0200
+++ linux/drivers/media/video/bttv-cards.c	2004-04-05 10:49:58.083249103 +0200
@@ -57,6 +57,7 @@ static void avermedia_tv_stereo_audio(st
 				      int set);
 static void terratv_audio(struct bttv *btv, struct video_audio *v, int set);
 static void gvbctv3pci_audio(struct bttv *btv, struct video_audio *v, int set);
+static void gvbctv5pci_audio(struct bttv *btv, struct video_audio *v, int set);
 static void winfast2000_audio(struct bttv *btv, struct video_audio *v, int set);
 static void pvbt878p9b_audio(struct bttv *btv, struct video_audio *v, int set);
 static void fv2000s_audio(struct bttv *btv, struct video_audio *v, int set);
@@ -68,6 +69,8 @@ static void xguard_muxsel(struct bttv *b
 static void ivc120_muxsel(struct bttv *btv, unsigned int input);
 static void gvc1100_muxsel(struct bttv *btv, unsigned int input);
 
+static void PXC200_muxsel(struct bttv *btv, unsigned int input);
+
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
 static int tea5757_write(struct bttv *btv, int value);
@@ -118,7 +121,7 @@ MODULE_PARM(remote,"1-" __stringify(BTTV
 
 MODULE_PARM(gpiomask,"i");
 MODULE_PARM(audioall,"i");
-MODULE_PARM(audiomux,"1-5i");
+MODULE_PARM(audiomux,"1-6i");
 
 /* kernel args */
 #ifndef MODULE
@@ -169,7 +172,7 @@ static struct CARD {
  	{ 0x402010fc, BTTV_GVBCTV3PCI,    "I-O Data Co. GV-BCTV3/PCI" },
 	{ 0x405010fc, BTTV_GVBCTV4PCI,    "I-O Data Co. GV-BCTV4/PCI" },
 	{ 0x407010fc, BTTV_GVBCTV5PCI,    "I-O Data Co. GV-BCTV5/PCI" },
- 	{ 0xd01810fc, BTTV_GVBCTV3PCI,    "I-O Data Co. GV-BCTV3/PCI" },
+ 	{ 0xd01810fc, BTTV_GVBCTV5PCI,    "I-O Data Co. GV-BCTV5/PCI" },
 
 	{ 0x001211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
 	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
@@ -204,7 +207,8 @@ static struct CARD {
 	//{ 0x18521852, BTTV_TERRATV,     "Terratec TV+ (V1.10)"    },
 	{ 0x1134153b, BTTV_TERRATVALUE,   "Terratec TValue (LR102)" },
 	{ 0x1135153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, // LR102
-	{ 0x5018153b, BTTV_TERRATVALUE,   "Terratec TValue" }, // ??
+	{ 0x5018153b, BTTV_TERRATVALUE,   "Terratec TValue" },       // ??
+	{ 0xff3b153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, // ??
 
 	{ 0x400015b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV" },
 	{ 0x400a15b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV" },
@@ -270,6 +274,8 @@ static struct CARD {
 	{ 0xa0fca1a0, BTTV_ZOLTRIX,       "Face to Face Tvmax" },
 	{ 0x20007063, BTTV_PC_HDTV,       "pcHDTV HD-2000 TV"},
 	{ 0x82b2aa6a, BTTV_SIMUS_GVC1100, "SIMUS GVC1100" },
+	{ 0x146caa0c, BTTV_PV951,         "ituner spectra8" },
+ 	{ 0x200a1295, BTTV_PXC200,        "ImageNation PXC200A" },
 
 	{ 0x40111554, BTTV_PV_BT878P_9B,  "Prolink Pixelview PV-BT" },
 	{ 0x17de0a01, BTTV_KWORLD,        "Mecer TV/FM/Video Tuner" },
@@ -281,6 +287,7 @@ static struct CARD {
 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
+	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
 	
 	{ 0, -1, NULL }
 };
@@ -597,6 +604,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
+	.has_remote     = 1,
 },{
 	.name           = "Terratec TerraTV+ Version 1.0 (Bt848)/ Terra TValue Version 1.0/ Vobis TV-Boostar",
 	.video_inputs	= 3,
@@ -688,6 +696,8 @@ struct tvcard bttv_tvcards[] = {
 	.audiomux	= { 0 },
 	.needs_tvaudio	= 1,
 	.tuner_type	= -1,
+	.muxsel_hook    = PXC200_muxsel,
+
 },{
 	.name		= "Lifeview FlyVideo 98 LR50",
 	.video_inputs	= 4,
@@ -741,9 +751,15 @@ struct tvcard bttv_tvcards[] = {
 	.audio_inputs	= 1,
 	.tuner		= 0,
 	.svhs		= 2,
-	.gpiomask	= 0xc33000,
 	.muxsel		= { 2, 3, 1, 1, 0}, // TV, CVid, SVid, CVid over SVid connector
-	.audiomux	= { 0x422000,0x1000,0x0000,0x620000,0x800000},
+#if 0
+	.gpiomask	= 0xc33000,
+	.audiomux	= { 0x422000,0x1000,0x0000,0x620000,0x800000 },
+#else
+	/* Alexander Varakin <avarakin@hotmail.com> [stereo version] */
+	.gpiomask	= 0xb33000,
+	.audiomux	= { 0x122000,0x1000,0x0000,0x620000,0x800000 },
+#endif
 	/* Audio Routing for "WinFast 2000 XP" (no tv stereo !)
 		gpio23 -- hef4052:nEnable (0x800000)
 		gpio12 -- hef4052:A1
@@ -810,6 +826,7 @@ struct tvcard bttv_tvcards[] = {
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= 1,
+	.has_remote     = 1,
 },{
 	.name		= "Pinnacle PCTV Studio/Rave",
 	.video_inputs	= 3,
@@ -819,7 +836,7 @@ struct tvcard bttv_tvcards[] = {
 	.gpiomask	= 0x03000F,
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 2, 0, 0, 0, 1},
-	.needs_tvaudio	= 1,
+	.needs_tvaudio	= 0,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
 },{
@@ -968,6 +985,7 @@ struct tvcard bttv_tvcards[] = {
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= TUNER_PHILIPS_PAL_I,
+	.has_remote	= 1,
 	/* GPIO wiring: (different from Rev.4C !)
 		GPIO17: U4.A0 (first hef4052bt)
 		GPIO19: U4.A1
@@ -1009,7 +1027,7 @@ struct tvcard bttv_tvcards[] = {
 			   MUX2 (mask 0x30000):
 				0,2,3= from MSP34xx
 				1= FM stereo Radio from Tuner */
-	.needs_tvaudio  = 1,
+	.needs_tvaudio  = 0,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
 },{
@@ -1448,11 +1466,11 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 2,
 	.gpiomask       = 0x0f0f80,
 	.muxsel         = {2, 3, 1, 0},
-	.audiomux       = {0x030000, 0x010000, 0x030000, 0, 0x020000, 0},
+	.audiomux       = {0x030000, 0x010000, 0, 0, 0x020000, 0},
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_PHILIPS_NTSC_M,
-	.audio_hook     = gvbctv3pci_audio,
+	.audio_hook     = gvbctv5pci_audio,
 	.has_radio      = 1,
 },{
 	.name           = "Osprey 100/150 (878)", /* 0x1(2|3)-45C6-C1 */
@@ -1774,6 +1792,8 @@ struct tvcard bttv_tvcards[] = {
 
 	/* ---- card 0x68 ---------------------------------- */
 	.name           = "Nebula Electronics DigiTV",
+	.video_inputs   = 1,
+        .tuner          = -1,
 	.svhs           = -1,
 	.muxsel         = { 2, 3, 1, 0},
 	.no_msp34xx     = 1,
@@ -1961,6 +1981,37 @@ struct tvcard bttv_tvcards[] = {
         .no_tda9875     = 1,
         .no_tda7432     = 1,
         .needs_tvaudio  = 0,
+},{
+	/* Helmroos Harri <harri.helmroos@pp.inet.fi> */
+	.name           = "Tekram M205 PRO",
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.tuner_type     = TUNER_PHILIPS_PAL,
+	.svhs           = 2,
+	.needs_tvaudio  = 0,
+	.gpiomask       = 0x68,
+	.muxsel         = { 2, 3, 1},
+	.audiomux       = { 0x68, 0x68, 0x61, 0x61, 0x00 },
+	.pll            = PLL_28,
+},{
+
+	/* ---- card 0x78 ---------------------------------- */
+	/* Javier Cendan Ares <jcendan@lycos.es> */
+	/* bt878 TV + FM without subsystem ID */
+	.name           = "Conceptronic CONTVFMi",
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0x008007,
+	.muxsel         = { 2, 3, 1, 1 },
+	.audiomux       = { 0, 1, 2, 2, 3 },
+	.needs_tvaudio  = 0,
+	.pll            = PLL_28,
+	.tuner_type     = TUNER_PHILIPS_PAL,
+	.has_remote     = 1,
+	.has_radio      = 1,
 }};
 
 const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2329,6 +2380,9 @@ void __devinit bttv_init_card1(struct bt
 	case BTTV_HAUPPAUGEPVR:
 		pvr_boot(btv);
 		break;
+	case BTTV_TWINHAN_DST:
+		btv->use_i2c_hw = 1;
+		break;
 	}
 }
 
@@ -3032,7 +3086,7 @@ static void __devinit init_PXC200(struct
 	u32 val;
 	
 	/* Initialise GPIO-connevted stuff */
-	gpio_bits(0xffffff, (1<<13));
+	gpio_inout(0xffffff, (1<<13));
 	gpio_write(0);
 	udelay(3);
 	gpio_write(1<<13);
@@ -3340,6 +3394,61 @@ gvbctv3pci_audio(struct bttv *btv, struc
 	}
 }
 
+static void
+gvbctv5pci_audio(struct bttv *btv, struct video_audio *v, int set)
+{
+	unsigned int val, con;
+
+#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
+	if (btv->radio_user)
+		return;
+#else
+	if (btv->radio)
+		return;
+#endif
+
+	val = gpio_read();
+	if (set) {
+		con = 0x000;
+		if (v->mode & VIDEO_SOUND_LANG2) {
+			if (v->mode & VIDEO_SOUND_LANG1) {
+				/* LANG1 + LANG2 */
+				con = 0x100;
+			}
+			else {
+				/* LANG2 */
+				con = 0x300;
+			}
+		}
+		if (con != (val & 0x300)) {
+			gpio_bits(0x300, con);
+			if (bttv_gpio)
+				bttv_gpio_tracking(btv,"gvbctv5pci");
+		}
+	} else {
+		switch (val & 0x70) {
+		  case 0x10:
+			v->mode = VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
+			break;
+		  case 0x30:
+			v->mode = VIDEO_SOUND_LANG2;
+			break;
+		  case 0x50:
+			v->mode = VIDEO_SOUND_LANG1;
+			break;
+		  case 0x60:
+			v->mode = VIDEO_SOUND_STEREO;
+			break;
+		  case 0x70:
+			v->mode = VIDEO_SOUND_MONO;
+			break;
+		  default:
+			v->mode = VIDEO_SOUND_MONO | VIDEO_SOUND_STEREO |
+				  VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
+		}
+	}
+}
+
 /*
  * Mario Medina Nussbaum <medisoft@alohabbs.org.mx>
  *  I discover that on BT848_GPIO_DATA address a byte 0xcce enable stereo,
@@ -3830,6 +3939,86 @@ int __devinit bttv_handle_chipset(struct
 }
 
 
+/* PXC200 muxsel helper 
+ * luke@syseng.anu.edu.au
+ * another transplant 
+ * from Alessandro Rubini (rubini@linux.it)
+ *
+ * There are 4 kinds of cards:
+ * PXC200L which is bt848 
+ * PXC200F which is bt848 with PIC controlling mux
+ * PXC200AL which is bt878 
+ * PXC200AF which is bt878 with PIC controlling mux
+ */
+#define PX_CFG_PXC200F 0x01
+#define PX_FLAG_PXC200A  0x00001000 /* a pxc200A is bt-878 based */
+#define PX_I2C_PIC       0x0f
+#define PX_PXC200A_CARDID 0x200a1295
+#define PX_I2C_CMD_CFG   0x00
+
+static void PXC200_muxsel(struct bttv *btv, unsigned int input)
+{
+        int rc;
+	long mux;
+	int bitmask;
+        unsigned char buf[2];
+
+	/* Read PIC config to determine if this is a PXC200F */
+	/* PX_I2C_CMD_CFG*/
+	buf[0]=0;
+	buf[1]=0;
+	rc=bttv_I2CWrite(btv,(PX_I2C_PIC<<1),buf[0],buf[1],1);
+	if (rc) {
+	  printk(KERN_DEBUG "bttv%d: PXC200_muxsel: pic cfg write failed:%d\n", btv->c.nr,rc);
+	  /* not PXC ? do nothing */
+	  return;
+	}
+
+	rc=bttv_I2CRead(btv,(PX_I2C_PIC<<1),0);
+	if (!(rc & PX_CFG_PXC200F)) {
+	  printk(KERN_DEBUG "bttv%d: PXC200_muxsel: not PXC200F rc:%d \n", btv->c.nr,rc);
+	  return;
+	}
+
+
+	/* The multiplexer in the 200F is handled by the GPIO port */
+	/* get correct mapping between inputs  */
+	/*  mux = bttv_tvcards[btv->type].muxsel[input] & 3; */
+	/* ** not needed!?   */
+	mux = input;
+  
+	/* make sure output pins are enabled */
+	/* bitmask=0x30f; */
+	bitmask=0x302; 
+	/* check whether we have a PXC200A */
+ 	if (btv->cardid == PX_PXC200A_CARDID)  {
+	   bitmask ^= 0x180; /* use 7 and 9, not 8 and 9 */
+	   bitmask |= 7<<4; /* the DAC */
+	}
+	btwrite(bitmask, BT848_GPIO_OUT_EN);
+
+	bitmask = btread(BT848_GPIO_DATA);
+ 	if (btv->cardid == PX_PXC200A_CARDID) 
+	  bitmask = (bitmask & ~0x280) | ((mux & 2) << 8) | ((mux & 1) << 7);
+	else /* older device */
+	  bitmask = (bitmask & ~0x300) | ((mux & 3) << 8);
+	btwrite(bitmask,BT848_GPIO_DATA);
+
+	/*
+	 * Was "to be safe, set the bt848 to input 0"
+	 * Actually, since it's ok at load time, better not messing
+	 * with these bits (on PXC200AF you need to set mux 2 here)
+	 * 
+	 * needed because bttv-driver sets mux before calling this function
+	 */
+ 	if (btv->cardid == PX_PXC200A_CARDID) 
+	  btaor(2<<5, ~BT848_IFORM_MUXSEL, BT848_IFORM);
+	else /* older device */
+	  btand(~BT848_IFORM_MUXSEL,BT848_IFORM);
+
+	printk(KERN_DEBUG "bttv%d: setting input channel to:%d\n", btv->c.nr,(int)mux);
+}
+
 /*
  * Local variables:
  * c-basic-offset: 8
diff -up linux-2.6.5/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.5/drivers/media/video/bttv-driver.c	2004-04-05 10:42:21.954266410 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-04-05 10:49:58.091247596 +0200
@@ -59,6 +59,7 @@ static unsigned int gbufsize = 0x208000;
 static int video_nr = -1;
 static int radio_nr = -1;
 static int vbi_nr = -1;
+static int debug_latency = 0;
 
 static unsigned int fdsr = 0;
 
@@ -98,6 +99,7 @@ MODULE_PARM_DESC(gbufsize,"size of the c
 MODULE_PARM(video_nr,"i");
 MODULE_PARM(radio_nr,"i");
 MODULE_PARM(vbi_nr,"i");
+MODULE_PARM(debug_latency,"i");
 
 MODULE_PARM(fdsr,"i");
 
@@ -795,6 +797,7 @@ static void bt848_bright(struct bttv *bt
 {
 	int value;
 
+	// printk("bttv: set bright: %d\n",bright); // DEBUG
 	btv->bright = bright;
 
 	/* We want -128 to 127 we get 0-65535 */
@@ -1048,6 +1051,11 @@ static void init_bt848(struct bttv *btv)
 	btwrite(whitecrush_upper, BT848_WC_UP);
 	btwrite(whitecrush_lower, BT848_WC_DOWN);
 
+	bt848_bright(btv,   btv->bright);
+	bt848_hue(btv,      btv->hue);
+	bt848_contrast(btv, btv->contrast);
+	bt848_sat(btv,      btv->saturation);
+
 	if (btv->opt_lumafilter) {
 		btwrite(0, BT848_E_CONTROL);
 		btwrite(0, BT848_O_CONTROL);
@@ -2170,13 +2178,13 @@ static int bttv_do_ioctl(struct inode *i
 				VID_TYPE_OVERLAY|
 				VID_TYPE_CLIPPING|
 				VID_TYPE_SCALES;
-			cap->channels  = bttv_tvcards[btv->c.type].video_inputs;
-			cap->audios    = bttv_tvcards[btv->c.type].audio_inputs;
 			cap->maxwidth  = bttv_tvnorms[btv->tvnorm].swidth;
 			cap->maxheight = bttv_tvnorms[btv->tvnorm].sheight;
 			cap->minwidth  = 48;
 			cap->minheight = 32;
 		}
+		cap->channels  = bttv_tvcards[btv->c.type].video_inputs;
+		cap->audios    = bttv_tvcards[btv->c.type].audio_inputs;
                 return 0;
 	}
 
@@ -3155,10 +3163,27 @@ static struct video_device radio_templat
 /* ----------------------------------------------------------------------- */
 /* irq handler                                                             */
 
-static char *irq_name[] = { "FMTCHG", "VSYNC", "HSYNC", "OFLOW", "HLOCK",
-			    "VPRES", "6", "7", "I2CDONE", "GPINT", "10",
-			    "RISCI", "FBUS", "FTRGT", "FDSR", "PPERR",
-			    "RIPERR", "PABORT", "OCERR", "SCERR" };
+static char *irq_name[] = {
+	"FMTCHG",  // format change detected (525 vs. 625)
+	"VSYNC",   // vertical sync (new field)
+	"HSYNC",   // horizontal sync
+	"OFLOW",   // chroma/luma AGC overflow
+	"HLOCK",   // horizontal lock changed
+	"VPRES",   // video presence changed
+	"6", "7",
+	"I2CDONE", // hw irc operation finished
+	"GPINT",   // gpio port triggered irq
+	"10",
+	"RISCI",   // risc instruction triggered irq
+	"FBUS",    // pixel data fifo dropped data (high pci bus latencies)
+	"FTRGT",   // pixel data fifo overrun
+	"FDSR",    // fifo data stream resyncronisation
+	"PPERR",   // parity error (data transfer)
+	"RIPERR",  // parity error (read risc instructions)
+	"PABORT",  // pci abort
+	"OCERR",   // risc instruction error
+	"SCERR",   // syncronisation error
+};
 
 static void bttv_print_irqbits(u32 print, u32 mark)
 {
@@ -3188,6 +3213,28 @@ static void bttv_print_riscaddr(struct b
 	       btv->screen ? (unsigned long long)btv->screen->bottom.dma : 0);
 }
 
+static void bttv_irq_debug_low_latency(struct bttv *btv, u32 rc)
+{
+	printk("bttv%d: irq: skipped frame [main=%lx,o_vbi=%lx,o_field=%lx,rc=%lx]\n",
+	       btv->c.nr,
+	       (unsigned long)btv->main.dma,
+	       (unsigned long)btv->main.cpu[RISC_SLOT_O_VBI+1],
+	       (unsigned long)btv->main.cpu[RISC_SLOT_O_FIELD+1],
+	       (unsigned long)rc);
+
+	if (0 == (btread(BT848_DSTATUS) & BT848_DSTATUS_HLOC)) {
+		printk("bttv%d: Oh, there (temporarely?) is no input signal. "
+		       "Ok, then this is harmless, don't worry ;)",
+		       btv->c.nr);
+		return;
+	}
+	printk("bttv%d: Uhm. Looks like we have unusual high IRQ latencies.\n",
+	       btv->c.nr);
+	printk("bttv%d: Lets try to catch the culpit red-handed ...\n",
+	       btv->c.nr);
+	dump_stack();
+}
+
 static int
 bttv_irq_next_set(struct bttv *btv, struct bttv_buffer_set *set)
 {
@@ -3306,8 +3353,8 @@ static void bttv_irq_timeout(unsigned lo
 	unsigned long flags;
 	
 	if (bttv_verbose) {
-		printk(KERN_INFO "bttv%d: timeout: irq=%d/%d, risc=%08x, ",
-		       btv->c.nr, btv->irq_me, btv->irq_total,
+		printk(KERN_INFO "bttv%d: timeout: drop=%d irq=%d/%d, risc=%08x, ",
+		       btv->c.nr, btv->framedrop, btv->irq_me, btv->irq_total,
 		       btread(BT848_RISC_COUNT));
 		bttv_print_irqbits(btread(BT848_INT_STAT),0);
 		printk("\n");
@@ -3376,14 +3423,9 @@ bttv_irq_switch_fields(struct bttv *btv)
 	bttv_irq_next_set(btv, &new);
 	rc = btread(BT848_RISC_COUNT);
 	if (rc < btv->main.dma || rc > btv->main.dma + 0x100) {
-		if (1 /* irq_debug */)
-			printk("bttv%d: skipped frame. no signal? high irq latency? "
-			       "[main=%lx,o_vbi=%lx,o_field=%lx,rc=%lx]\n",
-			       btv->c.nr,
-			       (unsigned long)btv->main.dma,
-			       (unsigned long)btv->main.cpu[RISC_SLOT_O_VBI+1],
-			       (unsigned long)btv->main.cpu[RISC_SLOT_O_FIELD+1],
-			       (unsigned long)rc);
+		btv->framedrop++;
+		if (debug_latency)
+			bttv_irq_debug_low_latency(btv, rc);
 		spin_unlock(&btv->s_lock);
 		return;
 	}
@@ -3870,11 +3912,6 @@ static int bttv_resume(struct pci_dev *p
 	gpio_inout(0xffffff, btv->state.gpio_enable);
 	gpio_write(btv->state.gpio_data);
 
-	bt848_bright(btv,   btv->bright);
-	bt848_hue(btv,      btv->hue);
-	bt848_contrast(btv, btv->contrast);
-	bt848_sat(btv,      btv->saturation);
-
 	/* restart dma */
 	spin_lock_irqsave(&btv->s_lock,flags);
 	btv->curr = btv->state.set;
diff -up linux-2.6.5/drivers/media/video/bttv-i2c.c linux/drivers/media/video/bttv-i2c.c
--- linux-2.6.5/drivers/media/video/bttv-i2c.c	2004-04-05 10:39:01.000000000 +0200
+++ linux/drivers/media/video/bttv-i2c.c	2004-04-05 10:49:58.096246654 +0200
@@ -414,12 +414,12 @@ void __devinit bttv_readee(struct bttv *
 /* init + register i2c algo-bit adapter */
 int __devinit init_bttv_i2c(struct bttv *btv)
 {
-	int use_hw = (btv->id == 878) && i2c_hw;
-
 	memcpy(&btv->i2c_client, &bttv_i2c_client_template,
 	       sizeof(bttv_i2c_client_template));
 
-	if (use_hw) {
+	if (i2c_hw)
+		btv->use_i2c_hw = 1;
+	if (btv->use_i2c_hw) {
 		/* bt878 */
 		memcpy(&btv->c.i2c_adap, &bttv_i2c_adap_hw_template,
 		       sizeof(bttv_i2c_adap_hw_template));
@@ -435,12 +435,13 @@ int __devinit init_bttv_i2c(struct bttv 
 
 	btv->c.i2c_adap.dev.parent = &btv->c.pci->dev;
 	snprintf(btv->c.i2c_adap.name, sizeof(btv->c.i2c_adap.name),
-		 "bt%d #%d [%s]", btv->id, btv->c.nr, use_hw ? "hw" : "sw");
+		 "bt%d #%d [%s]", btv->id, btv->c.nr,
+		 btv->use_i2c_hw ? "hw" : "sw");
 
         i2c_set_adapdata(&btv->c.i2c_adap, btv);
         btv->i2c_client.adapter = &btv->c.i2c_adap;
 
-	if (use_hw) {
+	if (btv->use_i2c_hw) {
 		btv->i2c_rc = i2c_add_adapter(&btv->c.i2c_adap);
 	} else {
 		bttv_bit_setscl(btv,1);
@@ -452,12 +453,10 @@ int __devinit init_bttv_i2c(struct bttv 
 
 int __devexit fini_bttv_i2c(struct bttv *btv)
 {
-	int use_hw = (btv->id == 878) && i2c_hw;
-
 	if (0 != btv->i2c_rc)
 		return 0;
 
-	if (use_hw) {
+	if (btv->use_i2c_hw) {
 		return i2c_del_adapter(&btv->c.i2c_adap);
 	} else {
 		return i2c_bit_del_bus(&btv->c.i2c_adap);
diff -up linux-2.6.5/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.5/drivers/media/video/bttvp.h	2004-04-05 10:40:16.129007364 +0200
+++ linux/drivers/media/video/bttvp.h	2004-04-05 10:50:14.831092839 +0200
@@ -25,7 +25,7 @@
 #define _BTTVP_H_
 
 #include <linux/version.h>
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,12)
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,14)
 
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -298,6 +298,7 @@ struct bttv {
 	struct bttv_pll_info pll;
 	int triton1;
 	int gpioirq;
+	int use_i2c_hw;
 
 	/* old gpio interface */
 	wait_queue_head_t gpioq;
@@ -384,9 +385,10 @@ struct bttv {
 	struct bttv_suspend_state state;
 
 	/* stats */
+	unsigned int errors;
+	unsigned int framedrop;
 	unsigned int irq_total;
 	unsigned int irq_me;
-	unsigned int errors;
 
 	unsigned int users;
 	struct bttv_fh init;

-- 
http://bigendian.bytesex.org
