Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTAHLrJ>; Wed, 8 Jan 2003 06:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267179AbTAHLrJ>; Wed, 8 Jan 2003 06:47:09 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:26771 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267089AbTAHLqZ>; Wed, 8 Jan 2003 06:46:25 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 8 Jan 2003 12:59:25 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] bttv driver update.
Message-ID: <20030108115925.GA12607@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the bttv driver.  Changes:

 * adaptions to the video-buf changes send in a previous mail.
 * adaptions to recent i2c changes in the kernel.
 * first code bits the pixelview digital camera support (not
   working yet).
 * lots of small fixes/changes for specific TV cards.

Please apply,

  Gerd

--- linux-2.5.54/drivers/media/video/bttv-cards.c	2003-01-08 10:34:28.000000000 +0100
+++ linux/drivers/media/video/bttv-cards.c	2003-01-08 10:59:58.000000000 +0100
@@ -37,15 +37,15 @@
 
 #include "bttvp.h"
 #include "tuner.h"
-#if 0
-# include "bt832.h"
-#endif
+#include "bt832.h"
 
 /* fwd decl */
 static void boot_msp34xx(struct bttv *btv, int pin);
+static void boot_bt832(struct bttv *btv);
 static void hauppauge_eeprom(struct bttv *btv);
 static void avermedia_eeprom(struct bttv *btv);
 static void osprey_eeprom(struct bttv *btv);
+static void modtec_eeprom(struct bttv *btv);
 static void init_PXC200(struct bttv *btv);
 
 static void winview_audio(struct bttv *btv, struct video_audio *v, int set);
@@ -64,12 +64,15 @@
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
 static int tea5757_write(struct bttv *btv, int value);
+int is_MM20xPCTV(unsigned char eeprom_data[256]);
 
 
 /* config variables */
 static int triton1=0;
 static int vsfx=0;
-int no_overlay=-1;
+static int no_overlay=-1;
+static int latency = -1;
+
 static unsigned int card[BTTV_MAX]  = { [ 0 ... (BTTV_MAX-1) ] = -1};
 static unsigned int pll[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = -1};
 static unsigned int tuner[BTTV_MAX] = { [ 0 ... (BTTV_MAX-1) ] = -1};
@@ -90,6 +93,8 @@
 MODULE_PARM_DESC(vsfx,"set VSFX pci config bit "
 		 "[yet another chipset flaw workaround]");
 MODULE_PARM(no_overlay,"i");
+MODULE_PARM(latency,"i");
+MODULE_PARM_DESC(latency,"pci latency timer");
 MODULE_PARM(card,"1-" __stringify(BTTV_MAX) "i");
 MODULE_PARM_DESC(card,"specify TV/grabber card model, see CARDLIST file for a list");
 MODULE_PARM(pll,"1-" __stringify(BTTV_MAX) "i");
@@ -153,7 +158,7 @@
 
 	{ 0x1200bd11, BTTV_PINNACLE,      "Pinnacle PCTV" },
 	{ 0x001211bd, BTTV_PINNACLE,      "Pinnacle PCTV" },
-	{ 0x001c11bd, BTTV_PINNACLE,      "Pinnacle PCTV Sat" },
+	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
 
 	{ 0x3000121a, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },
 	{ 0x3060121a, BTTV_STB2,	  "3Dfx VoodooTV 100/ STB OEM" },
@@ -166,21 +171,23 @@
 	{ 0x00021461, BTTV_AVERMEDIA98,   "AVermedia TVCapture 98" },
 	{ 0x00031461, BTTV_AVPHONE98,     "AVerMedia TVPhone98" },
 	{ 0x00041461, BTTV_AVERMEDIA98,   "AVerMedia TVCapture 98" },
+	{ 0x03001461, BTTV_AVERMEDIA98,   "VDOMATE TV TUNER CARD" },
 
 	{ 0x300014ff, BTTV_MAGICTVIEW061, "TView 99 (CPH061)" },
 	{ 0x300214ff, BTTV_PHOEBE_TVMAS,  "Phoebe TV Master (CPH060)" },
 
-	{ 0x1117153b, BTTV_TERRATVALUE,   "Terratec TValue" },
-	{ 0x1118153b, BTTV_TERRATVALUE,   "Terratec TValue" },
-	{ 0x1119153b, BTTV_TERRATVALUE,   "Terratec TValue" },
-	{ 0x111a153b, BTTV_TERRATVALUE,   "Terratec TValue" },
+	{ 0x1117153b, BTTV_TERRATVALUE,   "Terratec TValue (Philips PAL B/G)" },
+	{ 0x1118153b, BTTV_TERRATVALUE,   "Terratec TValue (Temic PAL B/G)" },
+	{ 0x1119153b, BTTV_TERRATVALUE,   "Terratec TValue (Philips PAL I)" },
+	{ 0x111a153b, BTTV_TERRATVALUE,   "Terratec TValue (Temic PAL I)" },
+ 
 	{ 0x1123153b, BTTV_TERRATVRADIO,  "Terratec TV Radio+" },
-	{ 0x1127153b, BTTV_TERRATV,       "Terratec TV+"    },
+	{ 0x1127153b, BTTV_TERRATV,       "Terratec TV+ (V1.05)"    },
 	// clashes with FlyVideo
-	//{ 0x18521852, BTTV_TERRATV,     "Terratec TV+"    },
-	{ 0x1134153b, BTTV_TERRATVALUE,   "Terratec TValue" },
-	{ 0x1135153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" },
-	{ 0x5018153b, BTTV_TERRATVALUE,   "Terratec TValue" },
+	//{ 0x18521852, BTTV_TERRATV,     "Terratec TV+ (V1.10)"    },
+	{ 0x1134153b, BTTV_TERRATVALUE,   "Terratec TValue (LR102)" },
+	{ 0x1135153b, BTTV_TERRATVALUER,  "Terratec TValue Radio" }, // LR102
+	{ 0x5018153b, BTTV_TERRATVALUE,   "Terratec TValue" }, // ??
 
 	{ 0x400015b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV" },
 	{ 0x400a15b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV" },
@@ -189,7 +196,7 @@
 	{ 0x401615b0, BTTV_ZOLTRIX_GENIE, "Zoltrix Genie TV / Radio" },
 
     	{ 0x010115cb, BTTV_GMV1,          "AG GMV1" },
-	{ 0x010114c7, BTTV_MODTEC_205,    "Modular Technology MM205 PCTV" },
+	{ 0x010114c7, BTTV_MODTEC_205,    "Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV" },
 	{ 0x18501851, BTTV_CHRONOS_VS2,   "FlyVideo 98 (LR50)/ Chronos Video Shuttle II" },
 	{ 0x18511851, BTTV_FLYVIDEO98EZ,  "FlyVideo 98EZ (LR51)/ CyberMail AV" },
 	{ 0x18521852, BTTV_TYPHOON_TVIEW, "FlyVideo 98FM (LR50)/ Typhoon TView TV/FM Tuner" },
@@ -198,6 +205,7 @@
 	{ 0x03116000, BTTV_SENSORAY311,   "Sensoray 311" },
 	{ 0x00790e11, BTTV_WINDVR,        "Canopus WinDVR PCI" },
 	{ 0xa0fca1a0, BTTV_ZOLTRIX,       "Face to Face Tvmax" },
+	{ 0xa0fca04f, BTTV_MAGICTVIEW063, "Guillemot Maxi TV Video 3" },
 
 	{ 0, -1, NULL }
 };
@@ -479,13 +487,14 @@
 	.pll		= PLL_28,
 	.tuner_type	= -1,
 },{
-	.name		= "Modular Technology MM205 PCTV, bt878",
-	.video_inputs	= 2,
+	.name		= "Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV, bt878",
+	.video_inputs	= 3,
 	.audio_inputs	= 1,
 	.tuner		= 0,
 	.svhs		= -1,
 	.gpiomask	= 7,
-	.muxsel		= { 2, 3 },
+	.muxsel		= { 2, 3, -1 },
+        .digital_mode   = DIGITAL_MODE_CAMERA,
 	.audiomux	= { 0, 0, 0, 0, 0 },
 	.no_msp34xx	= 1,
 	.pll            = PLL_28,
@@ -608,14 +617,15 @@
 	.tuner_type	= -1,
 },{
 	.name		= "Formac iProTV",
-	.video_inputs	= 3,
+	.video_inputs	= 4,
 	.audio_inputs	= 1,
 	.tuner		= 0,
-	.svhs		= 2,
+	.svhs		= 3,
 	.gpiomask	= 1,
 	.muxsel		= { 2, 3, 1, 1},
 	.audiomux	= { 1, 0, 0, 0, 0 },
-	.tuner_type	= -1,
+	.pll            = PLL_28,
+	.tuner_type	= TUNER_PHILIPS_PAL,
 },{
 
 /* ---- card 0x20 ---------------------------------- */
@@ -861,12 +871,13 @@
 	.audio_hook	= gvbctv3pci_audio,
 },{
 	.name		= "Prolink PV-BT878P+4E / PixelView PlayTV PAK / Lenco MXTV-9578 CP",
-	.video_inputs	= 4,
+	.video_inputs	= 5,
 	.audio_inputs	= 1,
 	.tuner		= 0,
 	.svhs		= 3,
 	.gpiomask	= 0xAA0000,
-	.muxsel		= { 2,3,1,1 },
+	.muxsel		= { 2,3,1,1,-1 },
+	.digital_mode   = DIGITAL_MODE_CAMERA,
 	.audiomux	= { 0x20000, 0, 0x80000, 0x80000, 0xa8000, 0x46000  },
 	.no_msp34xx	= 1,
 	.pll		= PLL_28,
@@ -902,7 +913,7 @@
 	.svhs           = 2,
 	.gpiomask       = 0x03000F,
 	.muxsel		= { 2, 3, 1, 1},
-	.audiomux	= { 1, 0x10001, 0, 0, 10},
+	.audiomux	= { 1, 0xd0001, 0, 0, 10},
 			/* sound path (5 sources):
 			   MUX1 (mask 0x03), Enable Pin 0x08 (0=enable, 1=disable)
 				0= ext. Audio IN
@@ -1165,10 +1176,10 @@
 	.tuner_type     = -1,
 	.pll            = PLL_28,
 	.muxsel         = { 2 },
-	.gpiomask       = 0
+	gpiomask:       0
 },{
         /* Tomasz Pyra <hellfire@sedez.iq.pl> */
-        .name           = "Prolink Pixelview PV-BT878P+ (Rev.4C)",
+        .name           = "Prolink Pixelview PV-BT878P+ (Rev.4C,8E)",
         .video_inputs   = 3,
         .audio_inputs   = 4,
         .tuner          = 0,
@@ -1252,7 +1263,7 @@
 },{
         .name           = "Powercolor MTV878/ MTV878R/ MTV878F",
         .video_inputs   = 3,
-        .audio_inputs   = 2, 
+        audio_inputs:   2, 
 	.tuner		= 0,
         .svhs           = 2,
         .gpiomask       = 0x1C800F,  // Bit0-2: Audio select, 8-12:remote control 14:remote valid 15:remote reset
@@ -1292,7 +1303,7 @@
 },{
         .name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
         .video_inputs   = 4,
-        .audio_inputs   = 3, 
+        audio_inputs:   3, 
         .tuner          = 0,
         .svhs           = 2,
         .gpiomask       = 7,
@@ -1313,7 +1324,7 @@
 		GPIO0,1:   HEF4052 A0,A1
 		GPIO2:     HEF4052 nENABLE
 		GPIO3-7:   n.c.
-		GPIO8-13:  IRDC357 data0,5 (data6 n.c. ?) [chip not present on my card]
+		GPIO8-13:  IRDC357 data0-5 (data6 n.c. ?) [chip not present on my card]
 		GPIO14,15: ??
 		GPIO16-21: n.c.
 		GPIO22,23: ??
@@ -1513,6 +1524,65 @@
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
 	.pll            = PLL_28,
+},{
+	.name           = "Pinnacle PCTV Sat",
+	.video_inputs   = 2,
+	.audio_inputs   = 0,
+	.svhs           = 1,
+	.tuner          = -1,
+	.tuner_type     = -1,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,   
+	.muxsel         = { 3, 0, 1, 2},
+	.needs_tvaudio  = 0, 
+	.pll            = PLL_28,
+},{
+        .name           = "Formac ProTV II",
+        .video_inputs   = 4,
+        .audio_inputs   = 1,
+        .tuner          = 0,
+        .svhs           = 3,
+        .gpiomask       = 2,
+	// TV, Comp1, Composite over SVID con, SVID
+        .muxsel         = { 2, 3, 1, 1},
+        .audiomux       = { 2, 2, 0, 0, 0 }, 
+        .pll            = PLL_28,
+	.has_radio      = 1,
+        .tuner_type     = TUNER_PHILIPS_PAL,
+      /* sound routing:
+           GPIO=0x00,0x01,0x03: mute (?)
+              0x02: both TV and radio (tuner: FM1216/I)
+         The card has onboard audio connectors labeled "cdrom" and "board",
+	 not soldered here, though unknown wiring.
+         Card lacks: external audio in, pci subsystem id.
+       */
+
+},{
+	/* ---- card 0x60 ---------------------------------- */
+	.name           = "MachTV",
+        .video_inputs   = 3,
+        .audio_inputs   = 1,
+        .tuner          = 0,
+        .svhs           = -1,
+        .gpiomask       = 7,
+        .muxsel         = { 2, 3, 1, 1},
+        .audiomux       = { 0, 1, 2, 3, 4},
+        .needs_tvaudio  = 1,
+        .tuner_type     = 5,
+	.pll            = 1,
+},{
+	.name           = "Euresys Picolo",
+	.video_inputs   = 3,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = 2,
+	.gpiomask       = 0,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.muxsel         = { 2, 0, 1},
+	.pll            = PLL_28,
 }};
 
 const int bttv_num_tvcards = (sizeof(bttv_tvcards)/sizeof(struct tvcard));
@@ -1556,7 +1626,7 @@
 			printk(KERN_DEBUG "please mail id, board name and "
 			       "the correct card= insmod option to kraxel@bytesex.org\n");
 		}
-	}
+	} 
 
 	/* let the user override the autodetected type */
 	if (card[btv->nr] >= 0 && card[btv->nr] < bttv_num_tvcards)
@@ -1601,6 +1671,16 @@
  * (most) board specific initialisations goes here
  */
 
+/* Some Modular Technology cards have an eeprom, but no subsystem ID */
+int is_MM20xPCTV(unsigned char eeprom_data[256])
+{
+	if (0 == strncmp(eeprom_data,"GET.MM20xPCTV",13)) {
+		printk("bttv: GET.MM20xPCTV found\n");
+		return 1; // found
+	}
+	return 0;
+}
+
 static void flyvideo_gpio(struct bttv *btv)
 { 
 	int gpio,outbits,has_remote,has_radio,is_capture_only,is_lr90,has_tda9820_tda9821;
@@ -1624,7 +1704,7 @@
 
 	ttype=(gpio&0x0f0000)>>16;
 	switch(ttype) {
-	case 0x0: tuner=4; // None
+	case 0x0: tuner=2; // NTSC, e.g. TPI8NSR11P
 		break;
         case 0x2: tuner=39;// LG NTSC (newer TAPC series) TAPC-H701P
 		break;
@@ -1647,6 +1727,9 @@
 	is_lr90             = !(gpio & 0x002000); // else LR26/LR50 (LR38/LR51 f. capture only)
         //		        gpio & 0x001000 // output bit for audio routing
 
+	if(is_capture_only) 
+		tuner=4; // No tuner present 
+
 	printk(KERN_INFO "bttv%d: FlyVideo Radio=%s RemoteControl=%s Tuner=%d gpio=0x%06x\n", 
 	       btv->nr, has_radio? "yes":"no ", has_remote? "yes":"no ", tuner, gpio); 
 	printk(KERN_INFO "bttv%d: FlyVideo  LR90=%s tda9821/tda9820=%s capture_only=%s\n",
@@ -1659,7 +1742,7 @@
 
 	// LR90 Audio Routing is done by 2 hef4052, so Audio_Mask has 4 bits: 0x001c80
         // LR26/LR50 only has 1 hef4052, Audio_Mask 0x000c00
-	// Audio options: from tuner, from tda9821/tda9821(mono,stereo.sap), from tda9874, ext., mute
+	// Audio options: from tuner, from tda9821/tda9821(mono,stereo,sap), from tda9874, ext., mute
 	if(has_tda9820_tda9821) btv->audio_hook = lt9415_audio;
 	//todo: if(has_tda9874) btv->audio_hook = fv2000s_audio;
 }
@@ -1816,6 +1899,16 @@
 {
         btv->tuner_type = -1;
 
+	if (BTTV_UNKNOWN == btv->type) {
+		printk("bttv%d: Looking for eeprom\n",btv->nr);
+		bttv_readee(btv,eeprom_data,0xa0);
+                if(is_MM20xPCTV(eeprom_data)) {
+                        btv->type = BTTV_MODTEC_205;
+			printk("bttv%d: Autodetect by eeprom:(%s) [card=%d]\n",
+			       btv->nr, bttv_tvcards[btv->type].name, btv->type);
+		}
+	}
+
 	switch (btv->type) {
 	case BTTV_MIRO:
 	case BTTV_MIROPRO:
@@ -1896,6 +1989,10 @@
 	case BTTV_IDS_EAGLE:
 		init_ids_eagle(btv);
 		break;
+	case BTTV_MODTEC_205:
+		bttv_readee(btv,eeprom_data,0xa0);
+		modtec_eeprom(btv);
+		break;
 	}
 
 	/* pll configuration */
@@ -1930,6 +2027,7 @@
                         break;
                 }
         }
+	btv->pll.pll_current = -1;
 
 	/* tuner configuration (from card list / autodetect / insmod option) */
  	if (-1 != bttv_tvcards[btv->type].tuner_type)
@@ -1947,33 +2045,12 @@
 	if (bttv_tvcards[btv->type].audio_hook)
 		btv->audio_hook=bttv_tvcards[btv->type].audio_hook;
 
-#if 0
-	/* detect Bt832 chip for quartzsight digital camera */
-	if((bttv_I2CRead(btv, I2C_BT832_ALT1, "Bt832") >=0) ||
-	   (bttv_I2CRead(btv, I2C_BT832_ALT2, "Bt832") >=0)) {
-		int outbits,databits;
-		request_module("bt832");
-
-		bttv_call_i2c_clients(btv, BT832_HEXDUMP, NULL);
-
-		printk("Reset Bt832 (0x400000 for Pixelview 4E)\n");
-		btwrite(0, BT848_GPIO_DATA);
-		outbits = btread(BT848_GPIO_OUT_EN);
-		databits= btread(BT848_GPIO_DATA);
-		btwrite(0x400000, BT848_GPIO_OUT_EN);
-		udelay(5);
-		btwrite(0x400000, BT848_GPIO_DATA);
-        	udelay(5);
-		btwrite(0, BT848_GPIO_DATA);
-		udelay(5);
-		btwrite(outbits, BT848_GPIO_OUT_EN);
-		btwrite(databits, BT848_GPIO_DATA);
-
-		// bt832 on pixelview changes from i2c 0x8a to 0x88 after
-		// being reset as above. So we must follow by this:
-		bttv_call_i2c_clients(btv, BT832_REATTACH, NULL);
+	if (bttv_tvcards[btv->type].digital_mode == DIGITAL_MODE_CAMERA) {
+		/* detect Bt832 chip for quartzsight digital camera */
+		if ((bttv_I2CRead(btv, I2C_BT832_ALT1, "Bt832") >=0) ||
+		    (bttv_I2CRead(btv, I2C_BT832_ALT2, "Bt832") >=0))
+			boot_bt832(btv);
 	}
-#endif
 
 	/* try to detect audio/fader chips */
 	if (!bttv_tvcards[btv->type].no_msp34xx &&
@@ -2069,6 +2146,16 @@
 	{ TUNER_LG_PAL_I,      "LG TAPC-I701D"}
 };
 
+static void modtec_eeprom(struct bttv *btv)
+{
+	if( strncmp(&(eeprom_data[0x1e]),"Temic 4066 FY5",14) ==0) {
+		btv->tuner_type=TUNER_TEMIC_4066FY5_PAL_I;
+		printk("bttv Modtec: Tuner autodetected %s\n",&eeprom_data[0x1e]);
+	}
+	else
+		printk("bttv Modtec: Unknown TunerString:%s\n",&eeprom_data[0x1e]);
+}
+
 static void __devinit hauppauge_eeprom(struct bttv *btv)
 {
 	int blk2,tuner,radio,model;
@@ -2316,8 +2403,8 @@
 /* AVermedia specific stuff, from  bktr_card.c                             */
 
 int tuner_0_table[] = {
-        TUNER_PHILIPS_NTSC,  TUNER_PHILIPS_PAL,
-        TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL,
+        TUNER_PHILIPS_NTSC,  TUNER_PHILIPS_PAL /* PAL-BG*/,
+        TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL /* PAL-I*/,
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL,
         TUNER_PHILIPS_SECAM, TUNER_PHILIPS_SECAM,
         TUNER_PHILIPS_SECAM, TUNER_PHILIPS_PAL};
@@ -2408,6 +2495,41 @@
 		       "init [%d]\n", btv->nr, pin);
 }
 
+static void __devinit boot_bt832(struct bttv *btv)
+{
+	int outbits,databits,resetbit=0;
+
+	switch (btv->type) {
+	case BTTV_PXELVWPLTVPAK:
+		resetbit = 0x400000;
+		break;
+	case BTTV_MODTEC_205:
+		resetbit = 1<<9;
+		break;
+	default:
+		BUG();
+	}
+
+	request_module("bt832");
+	bttv_call_i2c_clients(btv, BT832_HEXDUMP, NULL);
+
+	printk("bttv%d: Reset Bt832 [line=0x%x]\n",btv->nr,resetbit);
+	btwrite(0, BT848_GPIO_DATA);
+	outbits = btread(BT848_GPIO_OUT_EN);
+	databits= btread(BT848_GPIO_DATA);
+	btwrite(resetbit, BT848_GPIO_OUT_EN);
+	udelay(5);
+	btwrite(resetbit, BT848_GPIO_DATA);
+	udelay(5);
+	btwrite(0, BT848_GPIO_DATA);
+	udelay(5);
+	btwrite(outbits, BT848_GPIO_OUT_EN);
+	btwrite(databits, BT848_GPIO_DATA);
+
+	// bt832 on pixelview changes from i2c 0x8a to 0x88 after
+	// being reset as above. So we must follow by this:
+	bttv_call_i2c_clients(btv, BT832_REATTACH, NULL);
+}
 
 /* ----------------------------------------------------------------------- */
 /*  Imagenation L-Model PXC200 Framegrabber */
@@ -2980,13 +3102,16 @@
 	int pcipci_fail = 0;
 	struct pci_dev *dev = NULL;
 
-	/* for 2.4.x we'll use the pci quirks (drivers/pci/quirks.c) */
 	if (pci_pci_problems & PCIPCI_FAIL)
 		pcipci_fail = 1;
 	if (pci_pci_problems & (PCIPCI_TRITON|PCIPCI_NATOMA|PCIPCI_VIAETBF))
 		triton1 = 1;
 	if (pci_pci_problems & PCIPCI_VSFX)
 		vsfx = 1;
+#ifdef PCIPCI_ALIMAGIK
+	if (pci_pci_problems & PCIPCI_ALIMAGIK)
+		latency = 0x0A;
+#endif
 
 	/* print which chipset we have */
 	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
@@ -2997,7 +3122,6 @@
 		printk(KERN_INFO "bttv: Host bridge needs ETBF enabled.\n");
 	if (vsfx)
 		printk(KERN_INFO "bttv: Host bridge needs VSFX enabled.\n");
-
 	if (pcipci_fail) {
 		printk(KERN_WARNING "bttv: BT848 and your chipset may not work together.\n");
 		if (-1 == no_overlay) {
@@ -3005,30 +3129,34 @@
 			no_overlay = 1;
 		}
 	}
+	if (-1 != latency)
+		printk(KERN_INFO "bttv: pci latency fixup [%d]\n",latency);
 
 	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 				      PCI_DEVICE_ID_INTEL_82441, dev))) {
                 unsigned char b;
-                pci_read_config_byte(dev, 0x53, &b);
+		pci_read_config_byte(dev, 0x53, &b);
 		if (bttv_debug)
 			printk(KERN_INFO "bttv: Host bridge: 82441FX Natoma, "
 			       "bufcon=0x%02x\n",b);
 	}
-
 }
 
 int __devinit bttv_handle_chipset(struct bttv *btv)
 {
  	unsigned char command;
 
-	if (!triton1 && !vsfx)
+	if (!triton1 && !vsfx && -1 == latency)
 		return 0;
 
 	if (bttv_verbose) {
 		if (triton1)
-			printk("bttv%d: enabling ETBF (430FX/VP3 compatibilty)\n",btv->nr);
+			printk(KERN_INFO "bttv%d: enabling ETBF (430FX/VP3 compatibilty)\n",btv->nr);
 		if (vsfx && btv->id >= 878)
-			printk("bttv%d: enabling VSFX\n",btv->nr);
+			printk(KERN_INFO "bttv%d: enabling VSFX\n",btv->nr);
+		if (-1 != latency)
+			printk(KERN_INFO "bttv%d: setting pci timer to %d\n",
+			       btv->nr,latency);
 	}
 
 	if (btv->id < 878) {
@@ -3044,6 +3172,8 @@
 			command |= BT878_EN_VSFX;
                 pci_write_config_byte(btv->dev, BT878_DEVCTRL, command);
         }
+	if (-1 != latency)
+		pci_write_config_byte(btv->dev, PCI_LATENCY_TIMER, latency);
 	return 0;
 }
 
--- linux-2.5.54/drivers/media/video/bttv-driver.c	2003-01-08 10:34:54.000000000 +0100
+++ linux/drivers/media/video/bttv-driver.c	2003-01-08 10:59:58.000000000 +0100
@@ -39,8 +39,6 @@
 #include "bttvp.h"
 #include "tuner.h"
 
-/* 2.4 / 2.5 driver compatibility stuff */
-
 int bttv_num;			/* number of Bt848s in use */
 struct bttv bttvs[BTTV_MAX];
 
@@ -58,13 +56,14 @@
 static unsigned int irq_debug = 0;
 static unsigned int gbuffers = 8;
 static unsigned int gbufsize = 0x208000;
-static unsigned int fdsr = 0;
-static unsigned int latency = -1;
 
 static int video_nr = -1;
 static int radio_nr = -1;
 static int vbi_nr = -1;
 
+static unsigned int fdsr = 0;
+static unsigned int gpint = 1;
+
 /* options */
 static unsigned int combfilter = 0;
 static unsigned int lumafilter = 0;
@@ -94,14 +93,14 @@
 MODULE_PARM_DESC(gbuffers,"number of capture buffers. range 2-32, default 8");
 MODULE_PARM(gbufsize,"i");
 MODULE_PARM_DESC(gbufsize,"size of the capture buffers, default is 0x208000");
-MODULE_PARM(fdsr,"i");
-MODULE_PARM(latency,"i");
-MODULE_PARM_DESC(latency,"pci latency timer");
 
 MODULE_PARM(video_nr,"i");
 MODULE_PARM(radio_nr,"i");
 MODULE_PARM(vbi_nr,"i");
 
+MODULE_PARM(fdsr,"i");
+MODULE_PARM(gpint,"i");
+
 MODULE_PARM(combfilter,"i");
 MODULE_PARM(lumafilter,"i");
 MODULE_PARM(automute,"i");
@@ -132,6 +131,7 @@
 {
 	/* PAL digital input over GPIO[7:0] */
 	{
+		45, // 45 bytes following
 		0x36,0x11,0x01,0x00,0x90,0x02,0x05,0x10,0x04,0x16,
 		0x12,0x05,0x11,0x00,0x04,0x12,0xC0,0x00,0x31,0x00,
 		0x06,0x51,0x08,0x03,0x89,0x08,0x07,0xC0,0x44,0x00,
@@ -140,6 +140,7 @@
 	},
 	/* NTSC digital input over GPIO[7:0] */
 	{
+		51, // 51 bytes following
 		0x0C,0xC0,0x00,0x00,0x90,0x02,0x03,0x10,0x03,0x06,
 		0x10,0x04,0x12,0x12,0x05,0x02,0x13,0x04,0x19,0x00,
 		0x04,0x39,0x00,0x06,0x59,0x08,0x03,0x83,0x08,0x07,
@@ -147,6 +148,16 @@
 		0x0D,0x02,0x03,0x11,0x01,0x05,0x37,0x00,0xAC,0x21,
 		0x00,
 	},
+	// TGB_NTSC392 // quartzsight
+	// This table has been modified to be used for Fusion Rev D
+	{
+		0x2A, // size of table = 42
+		0x06, 0x08, 0x04, 0x0a, 0xc0, 0x00, 0x18, 0x08, 0x03, 0x24,
+		0x08, 0x07, 0x02, 0x90, 0x02, 0x08, 0x10, 0x04, 0x0c, 0x10,
+		0x05, 0x2c, 0x11, 0x04, 0x55, 0x48, 0x00, 0x05, 0x50, 0x00,
+		0xbf, 0x0c, 0x02, 0x2f, 0x3d, 0x00, 0x2f, 0x3f, 0x00, 0xc3,
+		0x20, 0x00
+	}
 };
 
 const struct bttv_tvnorm bttv_tvnorms[] = {
@@ -170,7 +181,7 @@
 		.vbipack        = 255,
 		.sram           = 0,
 	},{
-		.v4l2_id        = V4L2_STD_NTSC,
+		.v4l2_id        = V4L2_STD_NTSC_M,
 		.name           = "NTSC",
 		.Fsc            = 28636363,
 		.swidth         = 768,
@@ -635,28 +646,31 @@
         btwrite(fi|BT848_PLL_X, BT848_PLL_XCI);
 }
 
-static int set_pll(struct bttv *btv)
+static void set_pll(struct bttv *btv)
 {
         int i;
 
         if (!btv->pll.pll_crystal)
-                return 0;
+                return;
+
+	if (btv->pll.pll_ofreq == btv->pll.pll_current) {
+		dprintk("bttv%d: PLL: no change required\n",btv->nr);
+                return;
+        }
 
         if (btv->pll.pll_ifreq == btv->pll.pll_ofreq) {
                 /* no PLL needed */
                 if (btv->pll.pll_current == 0)
-                        return 0;
-		vprintk("bttv%d: PLL: switching off\n",btv->nr);
+                        return;
+		vprintk(KERN_INFO "bttv%d: PLL can sleep, using XTAL (%d).\n",
+			btv->nr,btv->pll.pll_ifreq);
                 btwrite(0x00,BT848_TGCTRL);
                 btwrite(0x00,BT848_PLL_XCI);
                 btv->pll.pll_current = 0;
-                return 0;
+                return;
         }
 
-        if (btv->pll.pll_ofreq == btv->pll.pll_current)
-                return 0;
-
-	vprintk("bttv%d: PLL: %d => %d ",btv->nr,
+	vprintk(KERN_INFO "bttv%d: PLL: %d => %d ",btv->nr,
 		btv->pll.pll_ifreq, btv->pll.pll_ofreq);
 	set_pll_freq(btv, btv->pll.pll_ifreq, btv->pll.pll_ofreq);
 
@@ -672,40 +686,43 @@
                         btwrite(0x08,BT848_TGCTRL);
                         btv->pll.pll_current = btv->pll.pll_ofreq;
 			vprintk(" ok\n");
-                        return 0;
+                        return;
                 }
         }
         btv->pll.pll_current = -1;
 	vprintk("failed\n");
-        return -1;
+        return;
 }
 
 /* used to switch between the bt848's analog/digital video capture modes */
 void bt848A_set_timing(struct bttv *btv)
 {
-       u8 dvsif_val = 0;
-       int table_idx = bttv_tvnorms[btv->tvnorm].sram;
-       int i;
-
-       /* timing change...reset timing generator address */
-       btwrite(0x00, BT848_TGCTRL);
-       btwrite(0x02, BT848_TGCTRL);
-       btwrite(0x00, BT848_TGCTRL);
-       
-       if (btv->digital_video  &&  -1 != table_idx) {
-               dprintk("bttv%d: load digital timing table (table_idx=%d)\n",
-		       btv->nr,table_idx);
-	       dvsif_val = 0x41;
-               for(i = 0; i < 51; i++)
-                       btwrite(SRAM_Table[table_idx][i],BT848_TGLB);
-
-	       btwrite(0x75,BT848_PLL_F_LO);
-               btwrite(0x50,BT848_PLL_F_HI);
-               btwrite(0x8B,BT848_PLL_XCI);
-               btwrite(0x11,BT848_TGCTRL);
-	       btv->pll.pll_current = 0;
-       }
-       btwrite(dvsif_val,BT848_DVSIF);
+	int i, len;
+	int table_idx = bttv_tvnorms[btv->tvnorm].sram;
+	int fsc       = bttv_tvnorms[btv->tvnorm].Fsc;
+
+	if (bttv_tvcards[btv->type].muxsel[btv->input] < 0) {
+		dprintk("bttv%d: load digital timing table (table_idx=%d)\n",
+			btv->nr,table_idx);
+
+		/* timing change...reset timing generator address */
+       		btwrite(0x00, BT848_TGCTRL);
+       		btwrite(0x02, BT848_TGCTRL);
+       		btwrite(0x00, BT848_TGCTRL);
+
+		len=SRAM_Table[table_idx][0];
+		for(i = 1; i <= len; i++)
+			btwrite(SRAM_Table[table_idx][i],BT848_TGLB);
+		btv->pll.pll_ofreq = 27000000;
+
+		set_pll(btv);
+		btwrite(0x11, BT848_TGCTRL);
+		btwrite(0x41, BT848_DVSIF);
+	} else {
+		btv->pll.pll_ofreq = fsc;
+		set_pll(btv);
+		btwrite(0x0, BT848_DVSIF);
+	}
 }
 
 /* ----------------------------------------------------------------------- */
@@ -878,13 +895,7 @@
 	      BT848_IFORM);
 	btwrite(tvnorm->vbipack, BT848_VBI_PACK_SIZE);
 	btwrite(1, BT848_VBI_PACK_DEL);
-
-	if (btv->digital_video) {
-		bt848A_set_timing(btv);
-	} else {
-		btv->pll.pll_ofreq = tvnorm->Fsc;
-		set_pll(btv);
-	}
+	bt848A_set_timing(btv);
 
 	switch (btv->type) {
 	case BTTV_VOODOOTV_FM:
@@ -1133,9 +1144,7 @@
 {
 	int need_count = 0;
 
-	if (locked_btres(btv,RESOURCE_VIDEO))
-		need_count++;
-	if (locked_btres(btv,RESOURCE_VBI))
+	if (btv->users)
 		need_count++;
 
 	if (need_count) {
@@ -1245,7 +1254,7 @@
 	}
 
 #if 0
-	if (STATE_NEEDS_INIT == buf->vb.state)
+	if (STATE_NEEDS_INIT == buf->vb.state) {
 		if (redo_dma_risc)
 			bttv_dma_free(btv,buf);
 	}
@@ -1275,7 +1284,7 @@
 {
 	struct bttv_fh *fh = file->private_data;
 	
-	*size = fh->buf.fmt->depth*fh->buf.vb.width*fh->buf.vb.height >> 3;
+	*size = fh->fmt->depth*fh->width*fh->height >> 3;
 	if (0 == *count)
 		*count = gbuffers;
 	while (*size * *count > gbuffers * gbufsize)
@@ -1284,14 +1293,14 @@
 }
 
 static int
-buffer_prepare(struct file *file, struct videobuf_buffer *vb)
+buffer_prepare(struct file *file, struct videobuf_buffer *vb,
+	       enum v4l2_field field)
 {
 	struct bttv_buffer *buf = (struct bttv_buffer*)vb;
 	struct bttv_fh *fh = file->private_data;
 
-	return bttv_prepare_buffer(fh->btv,buf,fh->buf.fmt,
-				   fh->buf.vb.width,fh->buf.vb.height,
-				   fh->buf.vb.field);
+	return bttv_prepare_buffer(fh->btv, buf, fh->fmt,
+				   fh->width, fh->height, field);
 }
 
 static void
@@ -1357,6 +1366,8 @@
 	{
 		struct video_tuner *v = arg;
 		
+		if (-1 == bttv_tvcards[btv->type].tuner)
+			return -EINVAL;
 		if (v->tuner) /* Only tuner 0 */
 			return -EINVAL;
 		strcpy(v->name, "Television");
@@ -1517,10 +1528,15 @@
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
-
-		if (i->index >= bttv_tvcards[btv->type].video_inputs)
+		int n;
+		
+		n = i->index;
+		if (n >= bttv_tvcards[btv->type].video_inputs)
 			return -EINVAL;
-		i->type = V4L2_INPUT_TYPE_CAMERA;
+		memset(i,0,sizeof(*i));
+		i->index    = n;
+		i->type     = V4L2_INPUT_TYPE_CAMERA;
+		i->audioset = 1;
 		if (i->index == bttv_tvcards[btv->type].tuner) {
 			sprintf(i->name, "Television");
 			i->type  = V4L2_INPUT_TYPE_TUNER;
@@ -1530,6 +1546,15 @@
 		} else {
                         sprintf(i->name,"Composite%d",i->index);
 		}
+		if (i->index == btv->input) {
+			__u32 dstatus = btread(BT848_DSTATUS);
+			if (0 == (dstatus & BT848_DSTATUS_PRES))
+				i->status |= V4L2_IN_ST_NO_SIGNAL;
+			if (0 == (dstatus & BT848_DSTATUS_HLOC))
+				i->status |= V4L2_IN_ST_NO_H_LOCK;
+		}
+		for (n = 0; n < BTTV_TVNORMS; n++)
+			i->std |= bttv_tvnorms[n].v4l2_id;
 		return 0;
 	}
 	case VIDIOC_G_INPUT:
@@ -1562,8 +1587,9 @@
 		down(&btv->lock);
 		memset(t,0,sizeof(*t));
 		strcpy(t->name, "Television");
+		t->type       = V4L2_TUNER_ANALOG_TV;
 		t->capability = V4L2_TUNER_CAP_NORM;
-		t->rangehigh = 0xffffffffUL;
+		t->rangehigh  = 0xffffffffUL;
 		t->rxsubchans = V4L2_TUNER_SUB_MONO;
 		if (btread(BT848_DSTATUS)&BT848_DSTATUS_HLOC)
 			t->signal = 0xffff;
@@ -1680,6 +1706,15 @@
 	if (!fixup && (win->w.width > maxw || win->w.height > maxh))
 		return -EINVAL;
 
+	if (1 /* depth < 4bpp */) {
+		/* adjust and align writes */
+		int left     = (win->w.left + 3) & ~3;
+		int width    = win->w.width & ~3;
+		while (left + width > win->w.left + win->w.width)
+			width -= 4;
+		win->w.left  = left;
+		win->w.width = width;
+	}
 	if (win->w.width > maxw)
 		win->w.width = maxw;
 	if (win->w.height > maxh)
@@ -1796,15 +1831,17 @@
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		memset(&f->fmt.pix,0,sizeof(struct v4l2_pix_format));
-		f->fmt.pix.width        = fh->buf.vb.width;
-		f->fmt.pix.height       = fh->buf.vb.height;
-		f->fmt.pix.pixelformat  = fh->buf.fmt->fourcc;
+		f->fmt.pix.width        = fh->width;
+		f->fmt.pix.height       = fh->height;
+		f->fmt.pix.field        = fh->cap.field;
+		f->fmt.pix.pixelformat  = fh->fmt->fourcc;
 		f->fmt.pix.sizeimage    =
-			(fh->buf.vb.width*fh->buf.vb.height*fh->buf.fmt->depth)/8;
+			(fh->width * fh->height * fh->fmt->depth)/8;
 		return 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 		memset(&f->fmt.win,0,sizeof(struct v4l2_window));
-		f->fmt.win.w   = fh->ov.w;
+		f->fmt.win.w     = fh->ov.w;
+		f->fmt.win.field = fh->ov.field;
 		return 0;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		bttv_vbi_fmt(fh,f);
@@ -1866,7 +1903,7 @@
 		if (f->fmt.pix.height > maxh)
 			f->fmt.pix.height = maxh;
 		f->fmt.pix.sizeimage =
-			(fh->buf.vb.width * fh->buf.vb.height * fmt->depth)/8;
+			(fh->width * fh->height * fmt->depth)/8;
 		
 		return 0;
 	}
@@ -1909,14 +1946,13 @@
 		
 		/* update our state informations */
 		down(&fh->cap.lock);
-		fh->buf.fmt             = fmt;
-		fh->buf.vb.field        = f->fmt.pix.field;
-		fh->buf.vb.width        = f->fmt.pix.width;
-		fh->buf.vb.height       = f->fmt.pix.height;
-		btv->init.buf.fmt       = fmt;
-		btv->init.buf.vb.field  = f->fmt.pix.field;
-		btv->init.buf.vb.width  = f->fmt.pix.width;
-		btv->init.buf.vb.height = f->fmt.pix.height;
+		fh->fmt              = fmt;
+		fh->cap.field        = f->fmt.pix.field;
+		fh->width            = f->fmt.pix.width;
+		fh->height           = f->fmt.pix.height;
+		btv->init.fmt        = fmt;
+		btv->init.width      = f->fmt.pix.width;
+		btv->init.height     = f->fmt.pix.height;
 		up(&fh->cap.lock);
 		
 		return 0;
@@ -1953,7 +1989,7 @@
 			       v4l1_ioctls[_IOC_NR(cmd)] : "???");
 			break;
 		case 'V':
-			printk("bttv%d: ioctl 0x%x (v4l2, VIDIOC_%s)\n",
+			printk("bttv%d: ioctl 0x%x (v4l2, %s)\n",
 			       btv->nr, cmd,  v4l2_ioctl_names[_IOC_NR(cmd)]);
 			break;
 		default:
@@ -2002,9 +2038,9 @@
 		pic->contrast   = btv->contrast;
 		pic->hue        = btv->hue;
 		pic->colour     = btv->saturation;
-		if (fh->buf.fmt) {
-			pic->depth   = fh->buf.fmt->depth;
-			pic->palette = fh->buf.fmt->palette;
+		if (fh->fmt) {
+			pic->depth   = fh->fmt->depth;
+			pic->palette = fh->fmt->palette;
 		}
 		return 0;
 	}
@@ -2021,9 +2057,9 @@
 		if (fmt->depth != pic->depth && !sloppy)
 			goto fh_unlock_and_return;
 		fh->ovfmt   = fmt;
-		fh->buf.fmt = fmt;
+		fh->fmt     = fmt;
 		btv->init.ovfmt   = fmt;
-		btv->init.buf.fmt = fmt;
+		btv->init.fmt     = fmt;
 		if (bigendian) {
 			/* dirty hack time:  swap bytes for overlay if the
 			   display adaptor is big endian (insmod option) */
@@ -2067,10 +2103,10 @@
 		retval = setup_window(fh, btv, &w2, 0);
 		if (0 == retval) {
 			/* on v4l1 this ioctl affects the read() size too */
-			fh->buf.vb.width  = fh->ov.w.width;
-			fh->buf.vb.height = fh->ov.w.height;
-			btv->init.buf.vb.width  = fh->ov.w.width;
-			btv->init.buf.vb.height = fh->ov.w.height;
+			fh->width  = fh->ov.w.width;
+			fh->height = fh->ov.w.height;
+			btv->init.width  = fh->ov.w.width;
+			btv->init.height = fh->ov.w.height;
 		}
 		return retval;
 	}
@@ -2120,10 +2156,10 @@
 			}
 			if (NULL == fmt)
 				goto fh_unlock_and_return;
-			fh->ovfmt   = fmt;
-			fh->buf.fmt = fmt;
-			btv->init.ovfmt   = fmt;
-			btv->init.buf.fmt = fmt;
+			fh->ovfmt = fmt;
+			fh->fmt   = fmt;
+			btv->init.ovfmt = fmt;
+			btv->init.fmt   = fmt;
 		} else {
 			if (15 == fbuf->depth)
 				fbuf->depth = 16;
@@ -2266,11 +2302,6 @@
 	case VIDIOCSAUDIO:
 		return bttv_common_ioctls(btv,cmd,arg);
 
-	/* vbi/teletext ioctls */
-	case BTTV_VBISIZE:
-		bttv_switch_type(fh,V4L2_BUF_TYPE_VBI_CAPTURE);
-		return fh->lines * 2 * 2048;
-
 	/* ***  v4l2  *** ************************************************ */
 	case VIDIOC_QUERYCAP:
 	{
@@ -2295,8 +2326,24 @@
 	case VIDIOC_ENUM_FMT:
 	{
 		struct v4l2_fmtdesc *f = arg;
+		enum v4l2_buf_type type;
 		int i, index;
 
+		type  = f->type;
+		if (V4L2_BUF_TYPE_VBI_CAPTURE == type) {
+			/* vbi */
+			index = f->index;
+			if (0 != index)
+				return -EINVAL;
+			memset(f,0,sizeof(*f));
+			f->index       = index;
+			f->type        = type;
+			f->pixelformat = V4L2_PIX_FMT_GREY;
+			strcpy(f->description,"vbi data");
+			return 0;
+		}
+
+		/* video capture + overlay */
 		index = -1;
 		for (i = 0; i < BTTV_FORMATS; i++) {
 			if (bttv_formats[i].fourcc != -1)
@@ -2318,9 +2365,10 @@
 			return -EINVAL;
 		}
 		memset(f,0,sizeof(*f));
-		f->index = index;
-		strncpy(f->description,bttv_formats[i].name,31);
+		f->index       = index;
+		f->type        = type;
 		f->pixelformat = bttv_formats[i].fourcc;
+		strncpy(f->description,bttv_formats[i].name,31);
 		return 0;
 	}
 
@@ -2438,7 +2486,6 @@
 
 		if (!check_alloc_btres(btv,fh,res))
 			return -EBUSY;
-		bttv_field_count(btv);
 		return videobuf_streamon(file,bttv_queue(fh));
 	}
 	case VIDIOC_STREAMOFF:
@@ -2449,7 +2496,6 @@
 		if (retval < 0)
 			return retval;
 		free_btres(btv,fh,res);
-		bttv_field_count(btv);
 		return 0;
 	}
 
@@ -2540,7 +2586,15 @@
 static int bttv_ioctl(struct inode *inode, struct file *file,
 		      unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, bttv_do_ioctl);
+	struct bttv_fh *fh  = file->private_data;
+
+	switch (cmd) {
+	case BTTV_VBISIZE:
+		bttv_switch_type(fh,V4L2_BUF_TYPE_VBI_CAPTURE);
+		return fh->lines * 2 * 2048;
+	default:
+		return video_usercopy(inode, file, cmd, arg, bttv_do_ioctl);
+	}
 }
 
 static ssize_t bttv_read(struct file *file, char *data,
@@ -2561,6 +2615,8 @@
 		retval = videobuf_read_one(file, &fh->cap, data, count, ppos);
 		break;
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		if (!check_alloc_btres(fh->btv,fh,RESOURCE_VBI))
+			return -EBUSY;
 		retval = videobuf_read_stream(file, &fh->vbi, data, count, ppos, 1);
 		break;
 	default:
@@ -2574,8 +2630,11 @@
 	struct bttv_fh *fh = file->private_data;
 	struct bttv_buffer *buf;
 
-	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type)
+	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
+		if (!check_alloc_btres(fh->btv,fh,RESOURCE_VBI))
+			return -EBUSY;
 		return videobuf_poll_stream(file, &fh->vbi, wait);
+	}
 
 	if (check_btres(fh,RESOURCE_VIDEO)) {
 		/* streaming capture */
@@ -2596,7 +2655,7 @@
 				up(&fh->cap.lock);
 				return POLLERR;
 			}
-			if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf)) {
+			if (0 != fh->cap.ops->buf_prepare(file,fh->cap.read_buf,fh->cap.field)) {
 				up(&fh->cap.lock);
 				return POLLERR;
 			}
@@ -2652,14 +2711,18 @@
 	videobuf_queue_init(&fh->cap, &bttv_video_qops,
 			    btv->dev, &btv->s_lock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
+			    V4L2_FIELD_INTERLACED,
 			    sizeof(struct bttv_buffer));
 	videobuf_queue_init(&fh->vbi, &bttv_vbi_qops,
 			    btv->dev, &btv->s_lock,
 			    V4L2_BUF_TYPE_VBI_CAPTURE,
+			    V4L2_FIELD_SEQ_TB,
 			    sizeof(struct bttv_buffer));
-	
 	i2c_vidiocschan(btv);
-        return 0;
+
+	btv->users++;
+	bttv_field_count(btv);
+	return 0;
 }
 
 static int bttv_release(struct inode *inode, struct file *file)
@@ -2667,7 +2730,7 @@
 	struct bttv_fh *fh = file->private_data;
 	struct bttv *btv = fh->btv;
 
-	/* turn off overlay, stop outstanding captures */
+	/* turn off overlay */
 	if (check_btres(fh, RESOURCE_OVERLAY))
 		bttv_switch_overlay(btv,fh,NULL);
 	
@@ -2675,7 +2738,6 @@
 	if (check_btres(fh, RESOURCE_VIDEO)) {
 		videobuf_streamoff(file,&fh->cap);
 		free_btres(btv,fh,RESOURCE_VIDEO);
-		bttv_field_count(btv);
 	}
 	if (fh->cap.read_buf) {
 		buffer_release(file,fh->cap.read_buf);
@@ -2683,13 +2745,19 @@
 	}
 
 	/* stop vbi capture */
-	if (fh->vbi.streaming)
-		videobuf_streamoff(file,&fh->vbi);
-	if (fh->vbi.reading)
-		videobuf_read_stop(file,&fh->vbi);
+	if (check_btres(fh, RESOURCE_VBI)) {
+		if (fh->vbi.streaming)
+			videobuf_streamoff(file,&fh->vbi);
+		if (fh->vbi.reading)
+			videobuf_read_stop(file,&fh->vbi);
+		free_btres(btv,fh,RESOURCE_VBI);
+	}
 
 	file->private_data = NULL;
 	kfree(fh);
+
+	btv->users--;
+	bttv_field_count(btv);
 	return 0;
 }
 
@@ -2719,7 +2787,7 @@
 static struct video_device bttv_video_template =
 {
 	.name     = "UNSET",
-	.type     = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
+	type:     VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
 	          VID_TYPE_CLIPPING|VID_TYPE_SCALES,
 	.hardware = VID_HARDWARE_BT848,
 	.fops     = &bttv_fops,
@@ -2965,6 +3033,7 @@
 {
 	struct bttv_buffer *o_bottom,*o_top,*o_vcurr;
 	struct bttv_buffer *capture;
+	dma_addr_t rc;
 	int irqflags = 0;
 	struct timeval ts;
 
@@ -3032,9 +3101,17 @@
 	}
 
 	if (irq_debug)
-		printk(KERN_DEBUG
-		       "bttv: irq top=%p bottom=%p screen=%p vbi=%p\n",
-		       btv->top,btv->bottom,btv->screen,btv->vcurr);
+		printk(KERN_DEBUG "bttv%d: irq top=0x%08x bottom=0x%08x"
+		       " vbi=0x%08x/0x%08x\n", btv->nr,
+		       btv->top    ? btv->top->top.dma       : 0,
+		       btv->bottom ? btv->bottom->bottom.dma : 0,
+		       btv->vcurr  ? btv->vcurr->top.dma     : 0,
+		       btv->vcurr  ? btv->vcurr->bottom.dma  : 0);
+
+	rc = btread(BT848_RISC_COUNT);
+	if (rc < btv->main.dma || rc > btv->main.dma + 0x100)
+		printk("bttv%d: Huh? IRQ latency? main=0x%x rc=0x%x\n",
+		       btv->nr,btv->main.dma,rc);
 	
 	/* activate new fields */
 	bttv_buffer_activate(btv,btv->top,btv->bottom);
@@ -3270,11 +3347,6 @@
 		goto fail1;
 	}
 
-	if (-1 != latency) {
-		printk(KERN_INFO "bttv%d: setting pci latency timer to %d\n",
-		       bttv_num,latency);
-		pci_write_config_byte(dev, PCI_LATENCY_TIMER, latency);
-	}
         pci_read_config_byte(dev, PCI_CLASS_REVISION, &btv->revision);
         pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
         printk(KERN_INFO "bttv%d: Bt%d (rev %d) at %s, ",
@@ -3315,14 +3387,13 @@
 	btv->opt_adc_crush  = adc_crush;
 	
 	/* fill struct bttv with some useful defaults */
-	btv->init.btv = btv;
-	btv->init.ov.w.width    = 320;
-	btv->init.ov.w.height   = 240;
-	btv->init.buf.fmt       = format_by_palette(VIDEO_PALETTE_RGB24);
-	btv->init.buf.vb.width  = 320;
-	btv->init.buf.vb.height = 240;
-	btv->init.buf.vb.field  = V4L2_FIELD_BOTTOM;
-	btv->init.lines         = 16;
+	btv->init.btv         = btv;
+	btv->init.ov.w.width  = 320;
+	btv->init.ov.w.height = 240;
+	btv->init.fmt         = format_by_palette(VIDEO_PALETTE_RGB24);
+	btv->init.width       = 320;
+	btv->init.height      = 240;
+	btv->init.lines       = 16;
 	btv->input = 0;
 
 	/* initialize hardware */
@@ -3341,7 +3412,7 @@
         /* interrupt */
         btwrite(0xfffffUL, BT848_INT_STAT);
         btwrite((btv->triton1) |
-                BT848_INT_GPINT|
+                (gpint ? BT848_INT_GPINT : 0) |
                 BT848_INT_SCERR|
                 (fdsr ? BT848_INT_FDSR : 0) |
                 BT848_INT_RISCI|BT848_INT_OCERR|BT848_INT_VPRES|
--- linux-2.5.54/drivers/media/video/bttv-if.c	2003-01-08 10:33:57.000000000 +0100
+++ linux/drivers/media/video/bttv-if.c	2003-01-08 10:59:58.000000000 +0100
@@ -54,7 +54,7 @@
 /*                      gpio ports (IR for example)                        */
 /*                      see bttv.h for comments                            */
 
-int bttv_get_cardinfo(unsigned int card, int *type, int *cardid)
+int bttv_get_cardinfo(unsigned int card, int *type, unsigned *cardid)
 {
 	if (card >= bttv_num) {
 		return -1;
@@ -194,6 +194,7 @@
 	return state;
 }
 
+
 static int attach_inform(struct i2c_client *client)
 {
         struct bttv *btv = (struct bttv*)client->adapter->data;
@@ -262,7 +263,7 @@
 };
 
 static struct i2c_adapter bttv_i2c_adap_template = {
-	.owner		   = THIS_MODULE,
+	.owner          = THIS_MODULE,
 	.name              = "bt848",
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
--- linux-2.5.54/drivers/media/video/bttv-risc.c	2003-01-08 10:34:29.000000000 +0100
+++ linux/drivers/media/video/bttv-risc.c	2003-01-08 10:59:58.000000000 +0100
@@ -453,7 +453,7 @@
 	int totalwidth   = tvnorm->totalwidth;
 	int scaledtwidth = tvnorm->scaledtwidth;
 
-	if (btv->digital_video) {
+	if (bttv_tvcards[btv->type].muxsel[btv->input] < 0) {
 		swidth       = 720;
 		totalwidth   = 858;
 		scaledtwidth = 858;
@@ -764,15 +764,15 @@
 		case V4L2_FIELD_INTERLACED:
 			bttv_calc_geo(btv,&buf->geo,buf->vb.width,
 				      buf->vb.height,1,buf->tvnorm);
-			lines     = buf->vb.height >> 1;
-			ypadding  = buf->vb.width;
+			lines    = buf->vb.height >> 1;
+			ypadding = buf->vb.width;
 			cpadding = buf->vb.width >> buf->fmt->hshift;
 			bttv_risc_planar(btv,&buf->top,
 					 buf->vb.dma.sglist,
 					 0,buf->vb.width,ypadding,lines,
 					 uoffset,voffset,
 					 buf->fmt->hshift,
-					 buf->fmt->vshift >> 1,
+					 buf->fmt->vshift,
 					 cpadding);
 			bttv_risc_planar(btv,&buf->bottom,
 					 buf->vb.dma.sglist,
@@ -780,7 +780,7 @@
 					 uoffset+cpadding,
 					 voffset+cpadding,
 					 buf->fmt->hshift,
-					 buf->fmt->vshift >> 1,
+					 buf->fmt->vshift,
 					 cpadding);
 			break;
 		default:
--- linux-2.5.54/drivers/media/video/bttv-vbi.c	2003-01-08 10:34:39.000000000 +0100
+++ linux/drivers/media/video/bttv-vbi.c	2003-01-08 10:59:58.000000000 +0100
@@ -65,14 +65,17 @@
 static int vbi_buffer_setup(struct file *file, int *count, int *size)
 {
 	struct bttv_fh *fh = file->private_data;
+	struct bttv *btv = fh->btv;
 
 	if (0 == *count)
 		*count = vbibufs;
 	*size = fh->lines * 2 * 2048;
+	dprintk("setup: lines=%d\n",fh->lines);
 	return 0;
 }
 
-static int vbi_buffer_prepare(struct file *file, struct videobuf_buffer *vb)
+static int vbi_buffer_prepare(struct file *file, struct videobuf_buffer *vb,
+			      enum v4l2_field field)
 {
 	struct bttv_fh *fh = file->private_data;
 	struct bttv *btv = fh->btv;
@@ -90,8 +93,10 @@
 			goto fail;
 	}
 	buf->vb.state = STATE_PREPARED;
-	dprintk("buf prepare %p: top=%p bottom=%p\n",
-		vb,&buf->top,&buf->bottom);
+	buf->vb.field = field;
+	dprintk("buf prepare %p: top=%p bottom=%p field=%s\n",
+		vb, &buf->top, &buf->bottom,
+		v4l2_field_names[buf->vb.field]);
 	return 0;
 
  fail:
--- linux-2.5.54/drivers/media/video/bttv.h	2003-01-08 10:33:58.000000000 +0100
+++ linux/drivers/media/video/bttv.h	2003-01-08 10:59:58.000000000 +0100
@@ -90,6 +90,7 @@
 #define BTTV_SENSORAY311    0x49
 #define BTTV_RV605          0x4a
 #define BTTV_WINDVR         0x4c
+#define BTTV_KWORLD         0x4e
 #define BTTV_HAUPPAUGEPVR   0x50
 #define BTTV_GVBCTV5PCI     0x51
 #define BTTV_OSPREY1x0      0x52
@@ -104,6 +105,9 @@
 #define BTTV_OSPREY540      0x5b
 #define BTTV_OSPREY2000     0x5c
 #define BTTV_IDS_EAGLE      0x5d
+#define BTTV_PINNACLESAT    0x5e
+#define BTTV_FORMAC_PROTV   0x5f
+#define BTTV_EURESYS_PICOLO 0x61
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
@@ -132,6 +136,10 @@
 #define WINVIEW_PT2254_DATA 0x20
 #define WINVIEW_PT2254_STROBE 0x80
 
+/* digital_mode */
+#define DIGITAL_MODE_VIDEO 1
+#define DIGITAL_MODE_CAMERA 2
+
 struct bttv;
 
 struct tvcard
@@ -141,6 +149,7 @@
         int audio_inputs;
         int tuner;
         int svhs;
+	int digital_mode; // DIGITAL_MODE_CAMERA or DIGITAL_MODE_VIDEO
         u32 gpiomask;
         u32 muxsel[16];
         u32 audiomux[6]; /* Tuner, Radio, external, internal, mute, stereo */
@@ -191,7 +200,8 @@
    for possible values see lines below beginning with #define BTTV_UNKNOWN
    returns negative value if error occurred 
 */
-extern int bttv_get_cardinfo(unsigned int card, int *type, int *cardid);
+extern int bttv_get_cardinfo(unsigned int card, int *type,
+			     unsigned int *cardid);
 extern struct pci_dev* bttv_get_pcidev(unsigned int card);
 
 /* obsolete, use bttv_get_cardinfo instead */
--- linux-2.5.54/drivers/media/video/bttvp.h	2003-01-08 10:34:21.000000000 +0100
+++ linux/drivers/media/video/bttvp.h	2003-01-08 10:59:58.000000000 +0100
@@ -24,7 +24,7 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,1)
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,4)
 
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -55,7 +55,7 @@
 
 #define RESOURCE_OVERLAY       1
 #define RESOURCE_VIDEO         2
-#define RESOURCE_VBI           3
+#define RESOURCE_VBI           4
 
 #define RAW_LINES            640
 #define RAW_BPL             1024
@@ -136,7 +136,10 @@
 
 	/* video capture */
 	struct videobuf_queue    cap;
-	struct bttv_buffer       buf;
+	/* struct bttv_buffer       buf; */
+	const struct bttv_format *fmt;
+	int                      width;
+	int                      height;
 
 	/* current settings */
 	const struct bttv_format *ovfmt;
@@ -255,7 +258,7 @@
 	/* card configuration info */
         unsigned int nr;       /* dev nr (for printk("bttv%d: ...");  */
 	char name[8];          /* dev name */
-	int cardid;            /* pci subsystem id (bt878 based ones) */
+	unsigned int cardid;   /* pci subsystem id (bt878 based ones) */
 	int type;              /* card type (pointer into tvcards[])  */
         int tuner_type;        /* tuner chip type */
 	struct bttv_pll_info pll;
@@ -291,7 +294,6 @@
 	int tvnorm,hue,contrast,bright,saturation;
 	struct video_buffer fbuf;
 	int field_count;
-	int digital_video;
 
 	/* various options */
 	int opt_combfilter;
@@ -334,7 +336,7 @@
 	struct timer_list timeout;
 	int errors;
 
-	int user;
+	int users;
 	struct bttv_fh init;
 };
 

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
