Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUHaPsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUHaPsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUHaPsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:48:31 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33494 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268767AbUHaPmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:42:47 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 31 Aug 2004 17:31:21 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 4/4] v4l: saa7134 driver update
Message-ID: <20040831153121.GA15718@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a minor update for the saa7134 driver.  Changes:

 * i2c cleanups (i2c_add_driver return value, add __init & __exit).
 * fix radio tuning (last update broke this ...).
 * adds support for new tv cards.
 * add config info for the tda9887 (thus this one depends on the tuner
   update patch mailed earlier).
 * add configuration help printk's for some cards, for stuff which can't
   be autodetected.
 * make automute switchable via v4l2 API, without driver reload.

please apply,

  Gerd

diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa6752hs.c linux/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa6752hs.c	2004-08-25 16:13:46.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa6752hs.c	2004-08-25 18:20:58.763393636 +0200
@@ -387,13 +387,12 @@ static struct i2c_client client_template
         .driver     = &driver,
 };
 
-static int saa6752hs_init_module(void)
+static int __init saa6752hs_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void saa6752hs_cleanup_module(void)
+static void __exit saa6752hs_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-cards.c	2004-08-25 16:13:17.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2004-08-25 18:20:58.768392701 +0200
@@ -154,6 +154,26 @@ struct saa7134_board saa7134_boards[] = 
 			.gpio = 0x8000,
 		},
 	},
+	[SAA7134_BOARD_FLYTVPLATINUM] = {
+		/* "Arnaud Quette" <aquette@free.fr> */
+		.name           = "LifeView FlyTV Platinum",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_SECAM,
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
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
+		}},
+	},
 	[SAA7134_BOARD_EMPRESS] = {
 		/* "Gert Vervoort" <gert.vervoort@philips.com> */
 		.name		= "EMPRESS",
@@ -177,7 +197,6 @@ struct saa7134_board saa7134_boards[] = 
 			.name = name_radio,
 			.amux = LINE2,
 		},
-		.i2s_rate  = 48000,
 		.has_ts    = 1,
 		.video_out = CCIR656,
 	},
@@ -243,7 +262,7 @@ struct saa7134_board saa7134_boards[] = 
 		.name		= "KNC One TV-Station RDS / Typhoon TV Tuner RDS",
 		.audio_clock	= 0x00200000,
 		.tuner_type	= TUNER_PHILIPS_FM1216ME_MK3,
-		.need_tda9887   = 1,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -278,7 +297,7 @@ struct saa7134_board saa7134_boards[] = 
 		.name		= "KNC One TV-Station DVR",
 		.audio_clock	= 0x00200000,
 		.tuner_type	= TUNER_PHILIPS_FM1216ME_MK3,
-		.need_tda9887	= 1,
+		.tda9887_conf	= TDA9887_PRESENT,
 		.gpiomask	= 0x820000,
 		.inputs		= {{
 			.name = name_tv,
@@ -302,7 +321,6 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE2,
 			.gpio = 0x20000,
 		},
-		.i2s_rate	= 48000,
 		.has_ts		= 1,
 		.video_out	= CCIR656,
 	},
@@ -333,7 +351,7 @@ struct saa7134_board saa7134_boards[] = 
 		.name           = "Medion 5044",
 		.audio_clock    = 0x00187de7, // was: 0x00200000,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
-		.need_tda9887   = 1,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -414,7 +432,7 @@ struct saa7134_board saa7134_boards[] = 
 		//.audio_clock    = 0x00200000,
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
-		.need_tda9887   = 1,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.inputs = {{
 			.name   = name_tv,
 			.vmux   = 1,
@@ -440,7 +458,7 @@ struct saa7134_board saa7134_boards[] = 
 		.name           = "Typhoon TV+Radio 90031",
 		.audio_clock    = 0x00200000,
 		.tuner_type     = TUNER_PHILIPS_PAL,
-		.need_tda9887   = 1,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.inputs         = {{
 			.name   = name_tv,
 			.vmux   = 1,
@@ -503,7 +521,7 @@ struct saa7134_board saa7134_boards[] = 
                 .name           = "ASUS TV-FM 7134",
                 .audio_clock    = 0x00187de7,
                 .tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
-                .need_tda9887   = 1,
+                .tda9887_conf   = TDA9887_PRESENT,
                 .inputs         = {{
                         .name = name_tv,
                         .vmux = 1,
@@ -607,7 +625,6 @@ struct saa7134_board saa7134_boards[] = 
 			.vmux = 8,
 			.amux = LINE1,
 		}},
-		.i2s_rate  = 48000,
 		.has_ts    = 1,
 		.video_out = CCIR656,
 	},
@@ -666,7 +683,7 @@ struct saa7134_board saa7134_boards[] = 
 		.name           = "AverMedia M156 / Medion 2819",
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
-		.need_tda9887   = 1,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -709,7 +726,6 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE2,
 			.tv   = 1,
 		}},
-		.i2s_rate  = 48000,
 		.has_ts    = 1,
 		.video_out = CCIR656,
         },
@@ -719,7 +735,7 @@ struct saa7134_board saa7134_boards[] = 
 		// probably wrong, the 7133 one is the NTSC version ...
 		// .tuner_type     = TUNER_PHILIPS_FM1236_MK3
                 .tuner_type     = TUNER_LG_NTSC_NEW_TAPC,
-                .need_tda9887   = 1,
+                .tda9887_conf   = TDA9887_PRESENT,
                 .inputs         = {{
                         .name = name_tv,
                         .vmux = 1,
@@ -743,7 +759,7 @@ struct saa7134_board saa7134_boards[] = 
                 .name           = "Pinnacle PCTV Stereo (saa7134)",
                 .audio_clock    = 0x00187de7,
                 .tuner_type     = TUNER_MT2032,
-                .need_tda9887   = 1,
+                .tda9887_conf   = TDA9887_PRESENT,
                 .inputs         = {{
                         .name = name_tv,
                         .vmux = 3,
@@ -957,7 +973,7 @@ struct saa7134_board saa7134_boards[] = 
 		.name           = "AverMedia 305",
 		.audio_clock    = 0x00187de7,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
-		.need_tda9887   = 1,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.inputs         = {{
 			.name = name_tv,
 			.vmux = 1,
@@ -989,7 +1005,7 @@ struct saa7134_board saa7134_boards[] = 
   		.name           = "UPMOST PURPLE TV",
   		.audio_clock    = 0x00187de7,
   		.tuner_type     = TUNER_PHILIPS_FM1236_MK3,
-  		.need_tda9887   = 1,
+  		.tda9887_conf   = TDA9887_PRESENT,
   		.inputs         = {{
   			.name = name_tv,
   			.vmux = 7,
@@ -1000,7 +1016,7 @@ struct saa7134_board saa7134_boards[] = 
   			.vmux = 7,
   			.amux = LINE1,
   		}},
-          },
+	},
 	[SAA7134_BOARD_ITEMS_MTV005] = {
 		/* Norman Jonas <normanjonas@arcor.de> */
 		.name           = "Items MuchTV Plus / IT-005",
@@ -1025,6 +1041,56 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE2,
 		},
 	},
+	[SAA7134_BOARD_CINERGY200] = {
+		.name           = "Terratec Cinergy 200 TV",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+       			.name = name_tv,
+			.vmux = 1,
+			.amux = LINE2,
+			.gpio = 0x0000,
+			.tv   = 1,
+		}},
+		.mute = {
+			 .name = name_mute,
+			 .amux = LINE2,
+		},
+	},
+	[SAA7134_BOARD_VIDEOMATE_TV_PVR] = {
+		/* Alain St-Denis <alain@topaze.homeip.net> */
+		.name           = "Compro VideoMate TV PVR/FM",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_NTSC_M,
+		.gpiomask	= 0x808c0080,
+                .inputs         = {{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE1,
+			.gpio = 0x00080
+                },{
+                        .name = name_comp1,
+                        .vmux = 3,
+                        .amux = LINE1,
+			.gpio = 0x00080
+                },{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = LINE2,
+                        .tv   = 1,
+			.gpio = 0x00080
+                }},
+		.radio = {
+			 .name = name_radio,
+			 .amux = LINE2,
+			.gpio = 0x80000
+		 },
+		.mute = {
+			.name = name_mute,
+                        .amux = LINE2,
+			.gpio = 0x40000,
+		},
+        },
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
@@ -1088,6 +1154,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.driver_data  = SAA7134_BOARD_FLYVIDEO2000,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7135,
+		.subvendor    = 0x5168,
+		.subdevice    = 0x0212,
+		.driver_data  = SAA7134_BOARD_FLYTVPLATINUM,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = 0x16be,
 		.subdevice    = 0x0003,
@@ -1219,6 +1291,19 @@ struct pci_device_id saa7134_pci_tbl[] =
                 .subvendor    = 0x12ab,
                 .subdevice    = 0x0800,
  		.driver_data  = SAA7133_BOARD_UPMOST_PURPLE_TV,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+		.subvendor    = 0x153B,
+		.subdevice    = 0x1152,
+		.driver_data  = SAA7134_BOARD_CINERGY200,
+		
+ 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+                .subvendor    = 0x185b,
+                .subdevice    = 0xc100,
+		.driver_data  = SAA7134_BOARD_VIDEOMATE_TV_PVR,
 		
  	},{
 		/* --- boards without eeprom + subsystem ID --- */
@@ -1297,6 +1382,7 @@ static struct {
 static void board_flyvideo(struct saa7134_dev *dev)
 {
 #if 0
+	/* non-working attempt to detect the correct tuner type ... */
 	u32 value;
 	int index;
 
@@ -1307,6 +1393,10 @@ static void board_flyvideo(struct saa713
 	       fly_list[index].tuner_type);
 	dev->tuner_type = fly_list[index].tuner_type;
 #endif
+	printk("%s: there are different flyvideo cards with different tuners\n"
+	       "%s: out there, you might have to use the tuner=<nr> insmod\n"
+	       "%s: option to override the default value.\n",
+	       dev->name, dev->name, dev->name);
 }
 
 /* ----------------------------------------------------------- */
@@ -1321,8 +1411,10 @@ int saa7134_board_init(struct saa7134_de
 	switch (dev->board) {
 	case SAA7134_BOARD_FLYVIDEO2000:
 	case SAA7134_BOARD_FLYVIDEO3000:
-		board_flyvideo(dev);
 		dev->has_remote = 1;
+		/* fall throuth */
+	case SAA7134_BOARD_FLYTVPLATINUM:
+		board_flyvideo(dev);
 		break;
 	case SAA7134_BOARD_CINERGY400:
 	case SAA7134_BOARD_CINERGY600:
@@ -1333,6 +1425,12 @@ int saa7134_board_init(struct saa7134_de
 	case SAA7134_BOARD_AVACSSMARTTV:
 		dev->has_remote = 1;
 		break;
+	case SAA7134_BOARD_MD5044:
+		printk("%s: seems there are two different versions of the MD5044\n"
+		       "%s: (with the same ID) out there.  If sound doesn't work for\n"
+		       "%s: you try the audio_clock_override=0x200000 insmod option.\n",
+		       dev->name,dev->name,dev->name);
+		break;
 	}
 	return 0;
 }
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-core.c	2004-08-25 16:11:53.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2004-08-25 18:20:58.771392140 +0200
@@ -868,7 +868,8 @@ static int __devinit saa7134_initdev(str
 		must_configure_manually();
 		dev->board = SAA7134_BOARD_UNKNOWN;
 	}
-	dev->tuner_type = saa7134_boards[dev->board].tuner_type;
+	dev->tuner_type   = saa7134_boards[dev->board].tuner_type;
+	dev->tda9887_conf = saa7134_boards[dev->board].tda9887_conf;
 	if (UNSET != tuner[saa7134_devcount])
 		dev->tuner_type = tuner[saa7134_devcount];
         printk(KERN_INFO "%s: subsystem: %04x:%04x, board: %s [card=%d,%s]\n",
@@ -919,7 +920,7 @@ static int __devinit saa7134_initdev(str
 	/* load i2c helpers */
 	if (TUNER_ABSENT != dev->tuner_type)
 		request_module("tuner");
-	if (saa7134_boards[dev->board].need_tda9887)
+	if (dev->tda9887_conf)
 		request_module("tda9887");
   	if (card_has_ts(dev))
 		request_module("saa6752hs");
@@ -949,7 +950,7 @@ static int __devinit saa7134_initdev(str
 			       dev->name);
 			goto fail4;
 		}
-		printk(KERN_INFO "%s: registered device video%d [ts]\n",
+		printk(KERN_INFO "%s: registered device video%d [mpeg]\n",
 		       dev->name,dev->ts_dev->minor & 0x1f);
 	}
 	
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-i2c.c	2004-08-25 16:11:21.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2004-08-25 18:20:58.773391767 +0200
@@ -327,8 +327,10 @@ static int attach_inform(struct i2c_clie
 {
         struct saa7134_dev *dev = client->adapter->algo_data;
 	int tuner = dev->tuner_type;
+	int conf  = dev->tda9887_conf;
 
 	saa7134_i2c_call_clients(dev,TUNER_SET_TYPE,&tuner);
+	saa7134_i2c_call_clients(dev,TDA9887_SET_CONFIG,&conf);
         return 0;
 }
 
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-input.c linux/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-input.c	2004-08-25 16:12:58.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2004-08-25 18:20:58.775391393 +0200
@@ -158,7 +158,7 @@ static IR_KEYTAB_TYPE eztv_codes[IR_KEYT
         [ 13 ] = KEY_KP7,
         [ 14 ] = KEY_KP8,
         [ 15 ] = KEY_KP9,
-
+ 
         [ 42 ] = KEY_VOLUMEUP,
         [ 17 ] = KEY_VOLUMEDOWN,
         [ 24 ] = KEY_CHANNELUP,      // CH.tracking up
@@ -172,13 +172,13 @@ static IR_KEYTAB_TYPE avacssmart_codes[I
         [ 30 ] = KEY_POWER,		// power
 	[ 28 ] = KEY_SEARCH,		// scan
         [  7 ] = KEY_SELECT,		// source
-
+        
 	[ 22 ] = KEY_VOLUMEUP,
 	[ 20 ] = KEY_VOLUMEDOWN,
         [ 31 ] = KEY_CHANNELUP,
 	[ 23 ] = KEY_CHANNELDOWN,
 	[ 24 ] = KEY_MUTE,
-
+	
 	[  2 ] = KEY_KP0,
         [  1 ] = KEY_KP1,
         [ 11 ] = KEY_KP2,
@@ -190,21 +190,21 @@ static IR_KEYTAB_TYPE avacssmart_codes[I
         [ 10 ] = KEY_KP8,
 	[ 18 ] = KEY_KP9,
 	[ 16 ] = KEY_KPDOT,
-
+	
 	[  3 ] = KEY_TUNER,		// tv/fm
         [  4 ] = KEY_REWIND,		// fm tuning left or function left
         [ 12 ] = KEY_FORWARD,		// fm tuning right or function right
-
+        
 	[  0 ] = KEY_RECORD,
         [  8 ] = KEY_STOP,
         [ 17 ] = KEY_PLAY,
-
+	
 	[ 25 ] = KEY_ZOOM,
 	[ 14 ] = KEY_MENU,		// function
 	[ 19 ] = KEY_AGAIN,		// recall
 	[ 29 ] = KEY_RESTART,		// reset
-
-// FIXME
+    
+// FIXME    
 	[ 13 ] = KEY_F21,		// mts
         [ 15 ] = KEY_F22,		// min
 	[ 26 ] = KEY_F23,		// freeze
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-oss.c	2004-08-25 16:12:14.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2004-08-25 18:21:43.806972184 +0200
@@ -776,8 +776,6 @@ int saa7134_oss_init1(struct saa7134_dev
 	dev->oss.rate = 32000;
 	if (oss_rate)
 		dev->oss.rate = oss_rate;
-	if (saa7134_boards[dev->board].i2s_rate)
-		dev->oss.rate = saa7134_boards[dev->board].i2s_rate;
 	dev->oss.rate = (dev->oss.rate > 40000) ? 48000 : 32000;
 
 	/* mixer */
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-ts.c linux/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-ts.c	2004-08-25 16:10:54.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-ts.c	2004-08-25 18:20:58.778390832 +0200
@@ -411,7 +411,7 @@ static int ts_do_ioctl(struct inode *ino
 
 	case MPEG_SETPARAMS:
 		return ts_init_encoder(dev, arg);
-
+		
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -481,7 +481,7 @@ int saa7134_ts_init1(struct saa7134_dev 
 	saa_writeb(SAA7134_TS_PARALLEL_SERIAL, (TS_PACKET_SIZE-1));
 	saa_writeb(SAA7134_TS_DMA0, ((ts_nr_packets-1)&0xff));
 	saa_writeb(SAA7134_TS_DMA1, (((ts_nr_packets-1)>>8)&0xff));
-	saa_writeb(SAA7134_TS_DMA2, ((((ts_nr_packets-1)>>16)&0x3f) | 0x00)); /* TSNOPIT=0, TSCOLAP=0 */
+	saa_writeb(SAA7134_TS_DMA2, ((((ts_nr_packets-1)>>16)&0x3f) | 0x00)); /* TSNOPIT=0, TSCOLAP=0 */	 
  
 	return 0;
 }
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-08-25 16:10:49.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-08-25 18:20:58.781390271 +0200
@@ -166,7 +166,7 @@ static void tvaudio_init(struct saa7134_
 
 	if (UNSET != audio_clock_override)
 	        clock = audio_clock_override;
-
+	
 	/* init all audio registers */
 	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x00);
 	if (need_resched())
@@ -361,13 +361,13 @@ static int tvaudio_checkcarrier(struct s
 		if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
 			return -1;
 		left = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-
+		
 		tvaudio_setcarrier(dev,scan->carr+90,scan->carr+90);
 		saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
 		if (tvaudio_sleep(dev,SCAN_SAMPLE_DELAY))
 			return -1;
 		right = saa_readl(SAA7134_LEVEL_READOUT1 >> 2);
-
+		
 		left >>= 16;
 		right >>= 16;
 		value = left > right ? left - right : right - left;
@@ -504,7 +504,8 @@ static int tvaudio_thread(void *data)
 		dprintk("tvaudio thread scan start [%d]\n",dev->thread.scan1);
 		dev->tvaudio  = NULL;
 		tvaudio_init(dev);
-		dev->automute = 1;
+		if (dev->ctl_automute)
+			dev->automute = 1;
 		mute_input_7134(dev);
 
 		/* give the tuner some time */
@@ -758,11 +759,11 @@ static int tvaudio_thread_ddep(void *dat
 	if (UNSET != audio_clock_override)
 		clock = audio_clock_override;
 	saa_writel(0x598 >> 2, clock);
-
+	
 	/* unmute */
 	saa_dsp_writel(dev, 0x474 >> 2, 0x00);
 	saa_dsp_writel(dev, 0x450 >> 2, 0x00);
-
+	
 	for (;;) {
 		tvaudio_sleep(dev,-1);
 		if (dev->thread.shutdown || signal_pending(current))
@@ -924,8 +925,9 @@ int saa7134_tvaudio_init2(struct saa7134
 	int (*my_thread)(void *data) = NULL;
 
 	/* enable I2S audio output */
-	if (saa7134_boards[dev->board].i2s_rate) {
-		int i2sform = (32000 == saa7134_boards[dev->board].i2s_rate) ? 0x00 : 0x01;
+	if (saa7134_boards[dev->board].has_ts) {
+		int i2sform = (48000 == dev->oss.rate)
+			? 0x01 : 0x00;
 		
 		/* enable I2S output */
 		saa_writeb(SAA7134_I2S_OUTPUT_SELECT,  0x80); 
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134-video.c	2004-08-25 16:11:22.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2004-08-25 18:20:58.786389337 +0200
@@ -272,7 +272,8 @@ static struct saa7134_tvnorm tvnorms[] =
 #define V4L2_CID_PRIVATE_INVERT      (V4L2_CID_PRIVATE_BASE + 0)
 #define V4L2_CID_PRIVATE_Y_ODD       (V4L2_CID_PRIVATE_BASE + 1)
 #define V4L2_CID_PRIVATE_Y_EVEN      (V4L2_CID_PRIVATE_BASE + 2)
-#define V4L2_CID_PRIVATE_LASTP1      (V4L2_CID_PRIVATE_BASE + 3)
+#define V4L2_CID_PRIVATE_AUTOMUTE    (V4L2_CID_PRIVATE_BASE + 3)
+#define V4L2_CID_PRIVATE_LASTP1      (V4L2_CID_PRIVATE_BASE + 4)
 
 static const struct v4l2_queryctrl no_ctrl = {
 	.name  = "42",
@@ -356,6 +357,13 @@ static const struct v4l2_queryctrl video
 		.maximum       = 128,
 		.default_value = 0,
 		.type          = V4L2_CTRL_TYPE_INTEGER,
+	},{
+		.id            = V4L2_CID_PRIVATE_AUTOMUTE,
+		.name          = "automute",
+		.minimum       = 0,
+		.maximum       = 1,
+		.default_value = 1,
+		.type          = V4L2_CTRL_TYPE_BOOLEAN,
 	}
 };
 static const unsigned int CTRLS = ARRAY_SIZE(video_ctrls);
@@ -433,10 +441,11 @@ void res_free(struct saa7134_dev *dev, s
 
 static void set_tvnorm(struct saa7134_dev *dev, struct saa7134_tvnorm *norm)
 {
-	int luma_control,sync_control,mux;
+	int luma_control,sync_control,mux,nosignal;
 
 	dprintk("set tv norm = %s\n",norm->name);
 	dev->tvnorm = norm;
+        nosignal = (0 == (saa_readb(SAA7134_STATUS_VIDEO1) & 0x03));
 
 	mux = card_in(dev,dev->ctl_input).vmux;
 	luma_control = norm->luma_control;
@@ -444,7 +453,7 @@ static void set_tvnorm(struct saa7134_de
 
 	if (mux > 5)
 		luma_control |= 0x80; /* svideo */
-	if (noninterlaced)
+	if (noninterlaced || nosignal)
 		sync_control |= 0x20;
 
 	/* setup cropping */
@@ -593,7 +602,7 @@ static void set_size(struct saa7134_dev 
 	v_start = dev->crop_current.top/2;
 	h_stop  = (dev->crop_current.left + dev->crop_current.width -1);
 	v_stop  = (dev->crop_current.top + dev->crop_current.height -1)/2;
-
+	
 	saa_writeb(SAA7134_VIDEO_H_START1(task), h_start &  0xff);
 	saa_writeb(SAA7134_VIDEO_H_START2(task), h_start >> 8);
 	saa_writeb(SAA7134_VIDEO_H_STOP1(task),  h_stop  &  0xff);
@@ -1043,6 +1052,9 @@ static int get_control(struct saa7134_de
 	case V4L2_CID_PRIVATE_Y_ODD:
 		c->value = dev->ctl_y_odd;
 		break;
+	case V4L2_CID_PRIVATE_AUTOMUTE:
+		c->value = dev->ctl_automute;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1118,6 +1130,17 @@ static int set_control(struct saa7134_de
 		dev->ctl_y_odd = c->value;
 		restart_overlay = 1;
 		break;
+	case V4L2_CID_PRIVATE_AUTOMUTE:
+		dev->ctl_automute = c->value;
+		if (dev->tda9887_conf) {
+			if (dev->ctl_automute)
+				dev->tda9887_conf |= TDA9887_AUTOMUTE;
+			else
+				dev->tda9887_conf &= ~TDA9887_AUTOMUTE;
+			saa7134_i2c_call_clients(dev, TDA9887_SET_CONFIG,
+						 &dev->tda9887_conf);
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1731,7 +1754,7 @@ static int video_do_ioctl(struct inode *
 	case VIDIOC_G_CROP:
 	{
 		struct v4l2_crop * crop = arg;
-
+		
 		if (crop->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
 		    crop->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
 			return -EINVAL;
@@ -1742,7 +1765,7 @@ static int video_do_ioctl(struct inode *
 	{
 		struct v4l2_crop *crop = arg;
 		struct v4l2_rect *b = &dev->crop_bounds;
-
+		
 		if (crop->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
 		    crop->type != V4L2_BUF_TYPE_VIDEO_OVERLAY)
 			return -EINVAL;
@@ -1762,7 +1785,7 @@ static int video_do_ioctl(struct inode *
 			crop->c.top = b->top + b->height;
 		if (crop->c.height > b->top - crop->c.top + b->height)
 			crop->c.height = b->top - crop->c.top + b->height;
-
+		
 		if (crop->c.left < b->left)
 			crop->c.top = b->left;
 		if (crop->c.left > b->left + b->width)
@@ -1820,7 +1843,7 @@ static int video_do_ioctl(struct inode *
 		struct v4l2_frequency *f = arg;
 
 		memset(f,0,sizeof(*f));
-		f->type = V4L2_TUNER_ANALOG_TV;
+		f->type = fh->radio ? V4L2_TUNER_RADIO : V4L2_TUNER_ANALOG_TV;
 		f->frequency = dev->ctl_freq;
 		return 0;
 	}
@@ -1830,7 +1853,9 @@ static int video_do_ioctl(struct inode *
 
 		if (0 != f->tuner)
 			return -EINVAL;
-		if (V4L2_TUNER_ANALOG_TV != f->type)
+		if (0 == fh->radio && V4L2_TUNER_ANALOG_TV != f->type)
+			return -EINVAL;
+		if (1 == fh->radio && V4L2_TUNER_RADIO != f->type)
 			return -EINVAL;
 		down(&dev->lock);
 		dev->ctl_freq = f->frequency;
@@ -2096,7 +2121,7 @@ static int radio_do_ioctl(struct inode *
 
 #ifdef V4L2_I2C_CLIENTS
 		saa7134_i2c_call_clients(dev,VIDIOC_G_TUNER,t);
-#else
+#else		
 		{
 			struct video_tuner vt;
 			memset(&vt,0,sizeof(vt));
@@ -2244,9 +2269,12 @@ int saa7134_video_init1(struct saa7134_d
 	dev->ctl_hue        = ctrl_by_id(V4L2_CID_HUE)->default_value;
 	dev->ctl_saturation = ctrl_by_id(V4L2_CID_SATURATION)->default_value;
 	dev->ctl_volume     = ctrl_by_id(V4L2_CID_AUDIO_VOLUME)->default_value;
+	dev->ctl_mute       = ctrl_by_id(V4L2_CID_AUDIO_MUTE)->default_value;
+	dev->ctl_invert     = ctrl_by_id(V4L2_CID_PRIVATE_INVERT)->default_value;
+	dev->ctl_automute   = ctrl_by_id(V4L2_CID_PRIVATE_AUTOMUTE)->default_value;
 
-	dev->ctl_invert     = 0;
-	dev->ctl_mute       = 1;
+	if (dev->tda9887_conf && dev->ctl_automute)
+		dev->tda9887_conf |= TDA9887_AUTOMUTE;
 	dev->automute       = 0;
 
         INIT_LIST_HEAD(&dev->video_q.queue);
@@ -2300,10 +2328,14 @@ void saa7134_irq_video_intl(struct saa71
 	if (0 != norm) {
 		/* wake up tvaudio audio carrier scan thread */
 		saa7134_tvaudio_do_scan(dev);
+		if (!noninterlaced)
+			saa_clearb(SAA7134_SYNC_CTRL, 0x20);
 	} else {
 		/* no video signal -> mute audio */
-		dev->automute = 1;
+		if (dev->ctl_automute)
+			dev->automute = 1;
 		saa7134_tvaudio_setmute(dev);
+		saa_setb(SAA7134_SYNC_CTRL, 0x20);
 	}
 }
 
diff -up linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.9-rc1/drivers/media/video/saa7134/saa7134.h	2004-08-25 16:12:54.000000000 +0200
+++ linux/drivers/media/video/saa7134/saa7134.h	2004-08-25 18:20:58.789388776 +0200
@@ -156,6 +156,9 @@ struct saa7134_format {
 #define SAA7134_BOARD_AVERMEDIA_305    35
 #define SAA7133_BOARD_UPMOST_PURPLE_TV 36
 #define SAA7134_BOARD_ITEMS_MTV005     37
+#define SAA7134_BOARD_CINERGY200       38
+#define SAA7134_BOARD_FLYTVPLATINUM    39
+#define SAA7134_BOARD_VIDEOMATE_TV_PVR 40
 
 #define SAA7134_INPUT_MAX 8
 
@@ -178,13 +181,12 @@ struct saa7134_board {
 	struct saa7134_input    mute;
 	
 	/* peripheral I/O */
-	unsigned int            i2s_rate;
 	unsigned int            has_ts;
 	enum saa7134_video_out  video_out;
 
 	/* i2c chip info */
 	unsigned int            tuner_type;
-	unsigned int            need_tda9887:1;
+	unsigned int            tda9887_conf;
 };
 
 #define card_has_radio(dev)   (NULL != saa7134_boards[dev->board].radio.name)
@@ -362,6 +364,7 @@ struct saa7134_dev {
 	/* config info */
 	unsigned int               board;
 	unsigned int               tuner_type;
+	unsigned int               tda9887_conf;
 	unsigned int               gpio_value;
 
 	/* i2c i/o */
@@ -397,12 +400,13 @@ struct saa7134_dev {
 	int                        ctl_mirror;
 	int                        ctl_y_odd;
 	int                        ctl_y_even;
-
+	int                        ctl_automute;
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
return -ENOSIG;
