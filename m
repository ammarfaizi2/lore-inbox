Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUAOM2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUAOM2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:28:00 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:23731 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265059AbUAOMUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:20:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 15 Jan 2004 13:00:11 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l-09 saa7134 driver update
Message-ID: <20040115120011.GA16338@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a saa7134 driver update.  Changes:

 * add infrared remote support.
 * add support for more TV cards.
 * misc minor fixes.

This patch depends on the ir-input patch.

  Gerd

diff -u linux-2.6.1/drivers/media/video/saa7134/Makefile linux/drivers/media/video/saa7134/Makefile
--- linux-2.6.1/drivers/media/video/saa7134/Makefile	2004-01-14 15:07:00.000000000 +0100
+++ linux/drivers/media/video/saa7134/Makefile	2004-01-14 15:09:36.000000000 +0100
@@ -1,7 +1,7 @@
 
 saa7134-objs :=	saa7134-cards.o saa7134-core.o saa7134-i2c.o	\
 		saa7134-oss.o saa7134-ts.o saa7134-tvaudio.o	\
-		saa7134-vbi.o saa7134-video.o
+		saa7134-vbi.o saa7134-video.o saa7134-input.o
 
 obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o
 
diff -u linux-2.6.1/drivers/media/video/saa7134/saa6752hs.c linux/drivers/media/video/saa7134/saa6752hs.c
--- linux-2.6.1/drivers/media/video/saa7134/saa6752hs.c	2004-01-14 15:06:51.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa6752hs.c	2004-01-14 15:09:36.000000000 +0100
@@ -168,13 +168,13 @@
 		}
 	
 		// wait a bit
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(1);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ/100);
 	}
 
 	// delay a bit to let encoder settle
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(5);
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(HZ/20);
 	
 	// done
   	return status;
@@ -230,6 +230,7 @@
 static int saa6752hs_init(struct i2c_client* client, struct mpeg_params* params)
 {  
 	unsigned char buf[3];
+	void *data;
 
 	// check the bitrate parameters first
 	if (params != NULL) {
@@ -281,12 +282,13 @@
 	i2c_master_send(client,buf,3);
   
         // setup bitrate settings
+	data = i2c_get_clientdata(client);
 	if (params) {
 		saa6752hs_set_bitrate(client, params);
-		memcpy(client->data, params, sizeof(struct mpeg_params));
+		memcpy(data, params, sizeof(struct mpeg_params));
 	} else {
 		// parameters were not supplied. use the previous set
-   		saa6752hs_set_bitrate(client, (struct mpeg_params*) client->data);
+   		saa6752hs_set_bitrate(client, (struct mpeg_params*) data);
 	}
 	  
 	// Send SI tables
@@ -324,7 +326,7 @@
 	if (NULL == (params = kmalloc(sizeof(struct mpeg_params), GFP_KERNEL)))
 		return -ENOMEM;
 	memcpy(params,&mpeg_params_template,sizeof(struct mpeg_params));
-	client->data = params;
+	i2c_set_clientdata(client, params);
 
         i2c_attach_client(client);
   
@@ -341,8 +343,11 @@
 
 static int saa6752hs_detach(struct i2c_client *client)
 {
+	void *data;
+
+	data = i2c_get_clientdata(client);
 	i2c_detach_client(client);
-	kfree(client->data);
+	kfree(data);
 	kfree(client);
 	return 0;
 }
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-cards.c	2004-01-14 15:06:28.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2004-01-14 15:09:36.000000000 +0100
@@ -2,7 +2,7 @@
  * device driver for philips saa7134 based TV cards
  * card-specific stuff.
  *
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2001-03 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -70,6 +70,10 @@
 			.amux = LINE2,
 			.tv   = 1,
 		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+		},
 	},
 	[SAA7134_BOARD_FLYVIDEO3000] = {
 		/* "Marco d'Itri" <md@Linux.IT> */
@@ -235,7 +239,8 @@
 		},
 	},
 	[SAA7134_BOARD_TVSTATION_RDS] = {
-		.name		= "KNC One TV-Station RDS",
+                /* Typhoon TV Tuner RDS: Art.Nr. 50694 */
+		.name		= "KNC One TV-Station RDS / Typhoon TV Tuner RDS",
 		.audio_clock	= 0x00200000,
 		.tuner_type	= TUNER_PHILIPS_FM1216ME_MK3,
 		.need_tda9887   = 1,
@@ -245,18 +250,61 @@
 			.amux = TV,
 			.tv   = 1,
 		},{
+			.name = name_tv_mono,
+                        .vmux = 1,
+                        .amux   = LINE2,
+                        .tv   = 1,
+                },{
+
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		},{
 			.name = name_comp1,
-			.vmux = 2,
+			.vmux = 3,
 			.amux = LINE1,
 		},{
-			.name = name_comp2,
+
+                        .name = "CVid over SVid",
+                        .vmux = 0,
+                        .amux = LINE1,
+                }},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+		},
+	},
+	[SAA7134_BOARD_TVSTATION_DVR] = {
+		.name		= "KNC One TV-Station DVR",
+		.audio_clock	= 0x00200000,
+		.tuner_type	= TUNER_PHILIPS_FM1216ME_MK3,
+		.need_tda9887	= 1,
+		.gpiomask	= 0x820000,
+		.inputs		= {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = LINE2,
+			.tv   = 1,
+			.gpio = 0x20000,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+			.gpio = 0x20000,
+		},{
+			.name = name_comp1,
 			.vmux = 3,
 			.amux = LINE1,
+			.gpio = 0x20000,
 		}},
-		.radio = {
+		.radio		= {
 			.name = name_radio,
 			.amux = LINE2,
+			.gpio = 0x20000,
 		},
+		.i2s_rate	= 48000,
+		.has_ts		= 1,
+		.video_out	= CCIR656,
 	},
 	[SAA7134_BOARD_CINERGY400] = {
                 .name           = "Terratec Cinergy 400 TV",
@@ -283,7 +331,7 @@
         },
 	[SAA7134_BOARD_MD5044] = {
 		.name           = "Medion 5044",
-		.audio_clock    = 0x00200000,
+		.audio_clock    = 0x00187de7, // was: 0x00200000,
 		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
 		.need_tda9887   = 1,
 		.inputs         = {{
@@ -393,11 +441,11 @@
 		},
 	},
 	[SAA7134_BOARD_TYPHOON_90031] = {
-		/* Christian Rothl�nder <Christian@Rothlaender.net> */
+		/* aka Typhoon "TV+Radio", Art.Nr 90031 */
+		/* Tom Zoerner <tomzo at users sourceforge net> */
 		.name           = "Typhoon TV+Radio 90031",
 		.audio_clock    = 0x00200000,
-		//.tuner_type     = TUNER_PHILIPS_PAL,
-		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.tuner_type     = TUNER_PHILIPS_PAL,
 		.need_tda9887   = 1,
 		.inputs         = {{
 			.name   = name_tv,
@@ -450,6 +498,11 @@
 			.vmux = 8,
 			.amux = TV,
 			.tv   = 1,
+		},{
+			.name = name_tv_mono,
+			.vmux = 8,
+			.amux = LINE2,
+			.tv   = 1,
 		}},
         },
 	[SAA7134_BOARD_ASUSTeK_TVFM7134] = {
@@ -505,6 +558,45 @@
                         .tv   = 1,
                 }},
 	},
+	[SAA7134_BOARD_10MOONSTVMASTER] = {
+		/* "lilicheng" <llc@linuxfans.org> */
+		.name           = "10MOONS PCI TV CAPTURE CARD",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_LG_PAL_NEW_TAPC,
+		.gpiomask       = 0xe000,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = LINE2,
+			.gpio = 0x0000,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 0,
+			.amux = LINE2,
+			.gpio = 0x4000,
+		},{
+			.name = name_comp2,
+			.vmux = 3,
+			.amux = LINE2,
+			.gpio = 0x4000,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
+			.gpio = 0x4000,
+		}},
+                .radio = {
+                        .name = name_radio,
+                        .amux = LINE2,
+			.gpio = 0x2000,
+                },
+		.mute = {
+			.name = name_mute,
+                        .amux = LINE2,
+			.gpio = 0x8000,
+		},
+	},
 	[SAA7134_BOARD_BMK_MPEX_NOTUNER] = {
 		/* "Andrew de Quincey" <adq@lidskialf.net> */
 		.name		= "BMK MPEX No Tuner",
@@ -555,13 +647,224 @@
                 }},
         },
 	[SAA7134_BOARD_CRONOS_PLUS] = {
+		/* gpio pins:
+		   0  .. 3   BASE_ID
+		   4  .. 7   PROTECT_ID
+		   8  .. 11  USER_OUT
+		   12 .. 13  USER_IN
+		   14 .. 15  VIDIN_SEL */
 		.name           = "Matrox CronosPlus",
 		.tuner_type     = TUNER_ABSENT,
+		.gpiomask       = 0xcf00,
+                .inputs         = {{
+                        .name = name_comp1,
+                        .vmux = 0,
+			.gpio = 2 << 14,
+		},{
+                        .name = name_comp2,
+                        .vmux = 0,
+			.gpio = 1 << 14,
+		},{
+                        .name = name_comp3,
+                        .vmux = 0,
+			.gpio = 0 << 14,
+		},{
+                        .name = name_comp4,
+                        .vmux = 0,
+			.gpio = 3 << 14,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.gpio = 2 << 14,
+                }},
+        },
+	[SAA7134_BOARD_MD2819] = {
+		.name           = "Medion 2819/ AverMedia M156",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_FM1216ME_MK3,
+		.need_tda9887   = 1,
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
+			.amux = LINE2,
+		},
+	},
+	[SAA7134_BOARD_BMK_MPEX_TUNER] = {
+		/* "Greg Wickham <greg.wickham@grangenet.net> */
+		.name           = "BMK MPEX Tuner",
+		.audio_clock    = 0x200000,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name = name_comp1,
+			.vmux = 1,
+			.amux = LINE1,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		},{
+			.name = name_tv,
+			.vmux = 3,
+			.amux = LINE2,
+			.tv   = 1,
+		}},
+		.i2s_rate  = 48000,
+		.has_ts    = 1,
+		.video_out = CCIR656,
+        },
+        [SAA7134_BOARD_ASUSTEK_TVFM7133] = {
+                .name           = "ASUS TV-FM 7133",
+                .audio_clock    = 0x00187de7,
+                .tuner_type     = TUNER_PHILIPS_FM1236_MK3,
+                .need_tda9887   = 1,
+                .inputs         = {{
+                        .name = name_tv,
+                        .vmux = 1,
+                        .amux = TV,
+                        .tv   = 1,
+                }},
+                .radio = {
+                        .name = name_radio,
+                        .amux = LINE1,
+                },
+        },
+	[SAA7134_BOARD_PINNACLE_PCTV_STEREO] = {
+                .name           = "Pinnacle PCTV Stereo (saa7134)",
+                .audio_clock    = 0x00187de7,
+                .tuner_type     = TUNER_MT2032,
+                .need_tda9887   = 1,
                 .inputs         = {{
+                        .name = name_tv,
+                        .vmux = 3,
+                        .amux = TV,
+                        .tv   = 1,
+                },{
                         .name = name_comp1,
                         .vmux = 0,
+                        .amux = LINE2,
+                },{
+                        .name = name_comp2,
+                        .vmux = 1,
+                        .amux = LINE2,
+                },{
+                        .name = name_svideo,
+                        .vmux = 8,
+                        .amux = LINE2,
                 }},
         },
+	[SAA7134_BOARD_MANLI_MTV002] = {
+		/* Ognjen Nastic <ognjen@logosoft.ba> */
+		.name           = "Manli MuchTV M-TV002",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		},{
+			.name   = name_comp1,
+			.vmux   = 1,
+			.amux   = LINE1,
+		},{
+			.name = name_tv,
+			.vmux = 3,
+			.amux = LINE2,
+			.tv   = 1,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+		},
+	},
+	[SAA7134_BOARD_MANLI_MTV001] = {
+		/* Ognjen Nastic <ognjen@logosoft.ba> UNTESTED */
+		.name           = "Manli MuchTV M-TV001",
+		.audio_clock    = 0x00200000,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		},{			
+			.name = name_comp1,
+			.vmux = 1,
+			.amux = LINE1,
+		},{
+			.name = name_tv,
+			.vmux = 3,
+			.amux = LINE2,
+			.tv   = 1,
+		}},
+        },
+	[SAA7134_BOARD_TG3000TV] = {
+		/* TransGear 3000TV */
+		.name           = "Nagase Sangyo TransGear 3000TV",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_NTSC_M,
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
+	},
+        [SAA7134_BOARD_ECS_TVP3XP] = {
+                .name           = "Elitegroup ECS TVP3XP FM1216 Tuner Card",
+                .audio_clock    = 0x187de7,  // xtal 32.1 MHz
+                .tuner_type     = TUNER_PHILIPS_PAL,
+                .inputs         = {{
+                        .name   = name_tv,
+                        .vmux   = 1,
+                        .amux   = TV,
+                        .tv     = 1,
+                },{
+                        .name   = name_tv_mono,
+                        .vmux   = 1,
+                        .amux   = LINE2,
+                        .tv     = 1,
+                },{
+                        .name   = name_comp1,
+                        .vmux   = 3,
+                        .amux   = LINE1,
+                },{
+                        .name   = name_svideo,
+                        .vmux   = 8,
+                        .amux   = LINE1,
+		},{
+			.name   = "CVid over SVid",
+			.vmux   = 0,
+			.amux   = LINE1,
+		}},
+                .radio = {
+                        .name   = name_radio,
+                        .amux   = LINE2,
+                },
+        },
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
@@ -613,6 +916,12 @@
 		.driver_data  = SAA7134_BOARD_FLYVIDEO3000,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x4e42,				//"Typhoon PCI Capture TV Card" Art.No. 50673
+                .subdevice    = 0x0138,
+                .driver_data  = SAA7134_BOARD_FLYVIDEO3000,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
 		.subvendor    = 0x5168,
 		.subdevice    = 0x0138,
@@ -648,11 +957,35 @@
                 .subdevice    = 0x4830,
                 .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
         },{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+                .subvendor    = PCI_VENDOR_ID_ASUSTEK,
+                .subdevice    = 0x4843,
+                .driver_data  = SAA7134_BOARD_ASUSTEK_TVFM7133,
+	},{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = PCI_VENDOR_ID_ASUSTEK,
+                .subdevice    = 0x4840,
+                .driver_data  = SAA7134_BOARD_ASUSTeK_TVFM7134,
+        },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
 		.subvendor    = PCI_VENDOR_ID_PHILIPS,
 		.subdevice    = 0xfe01,
-		.driver_data  = SAA7134_BOARD_TYPHOON_90031,
+		.driver_data  = SAA7134_BOARD_TVSTATION_RDS,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x1894,
+		.subdevice    = 0xfe01,
+		.driver_data  = SAA7134_BOARD_TVSTATION_RDS,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x1894,
+		.subdevice    = 0xa006,
+		.driver_data  = SAA7134_BOARD_TVSTATION_DVR,
 	},{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -661,6 +994,12 @@
 		.driver_data  = SAA7134_BOARD_VA1000POWER,
         },{
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+                .subvendor    = PCI_VENDOR_ID_PHILIPS,
+                .subdevice    = 0x2001,
+		.driver_data  = SAA7134_BOARD_10MOONSTVMASTER,
+        },{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
                 .subvendor    = 0x185b,
                 .subdevice    = 0xc100,
@@ -672,6 +1011,38 @@
                 .subdevice    = 0x48d0,
 		.driver_data  = SAA7134_BOARD_CRONOS_PLUS,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x1461, /* Avermedia Technologies Inc */
+                .subdevice    = 0xa70b,
+		.driver_data  = SAA7134_BOARD_MD2819,
+	},{
+		/* AverMedia Studio 305, using AverMedia M156 entry for now */
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x1461, /* Avermedia Technologies Inc */
+                .subdevice    = 0x2115,
+		.driver_data  = SAA7134_BOARD_MD2819,
+        },{
+		/* TransGear 3000TV */
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+                .subvendor    = 0x1461, /* Avermedia Technologies Inc */
+                .subdevice    = 0x050c,
+		.driver_data  = SAA7134_BOARD_TG3000TV,
+	},{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x11bd,
+                .subdevice    = 0x002b,
+                .driver_data  = SAA7134_BOARD_PINNACLE_PCTV_STEREO,
+        },{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+                .subvendor    = 0x1019,
+                .subdevice    = 0x4cb4,
+                .driver_data  = SAA7134_BOARD_ECS_TVP3XP,
+        },{
 		
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -777,6 +1148,7 @@
 		dev->has_remote = 1;
 		break;
 	case SAA7134_BOARD_CINERGY400:
+	case SAA7134_BOARD_CINERGY600:
 		dev->has_remote = 1;
 		break;
 	}
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-core.c linux/drivers/media/video/saa7134/saa7134-core.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-core.c	2004-01-14 15:05:28.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-core.c	2004-01-14 15:09:36.000000000 +0100
@@ -599,12 +599,10 @@
 		if ((report & SAA7134_IRQ_REPORT_DONE_RA3))
 			saa7134_irq_oss_done(dev,status);
 
-#ifdef CONFIG_VIDEO_IR
 		if ((report & (SAA7134_IRQ_REPORT_GPIO16 |
 			       SAA7134_IRQ_REPORT_GPIO18)) &&
 		    dev->remote)
 			saa7134_input_irq(dev);
-#endif
 
 	};
 	if (10 == loop) {
@@ -636,9 +634,7 @@
 	saa7134_vbi_init1(dev);
 	if (card_has_ts(dev))
 		saa7134_ts_init1(dev);
-#ifdef CONFIG_VIDEO_IR
 	saa7134_input_init1(dev);
-#endif
 
 	switch (dev->pci->device) {
 	case PCI_DEVICE_ID_PHILIPS_SAA7134:
@@ -714,9 +710,7 @@
 	}
 	if (card_has_ts(dev))
 		saa7134_ts_fini(dev);
-#ifdef CONFIG_VIDEO_IR
 	saa7134_input_fini(dev);
-#endif
 	saa7134_vbi_fini(dev);
 	saa7134_video_fini(dev);
 	saa7134_tvaudio_fini(dev);
@@ -907,7 +901,7 @@
 	}
 
 	/* wait a bit, register i2c bus */
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ/10);
 	saa7134_i2c_register(dev);
 
@@ -922,6 +916,10 @@
   	if (card_has_ts(dev))
 		request_module("saa6752hs");
 
+#ifdef VIDIOC_G_PRIORITY
+	v4l2_prio_init(&dev->prio);
+#endif
+
 	/* register v4l devices */
 	dev->video_dev = vdev_init(dev,&saa7134_video_template,"video");
 	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
@@ -1041,18 +1039,7 @@
 	saa_writel(SAA7134_MAIN_CTRL,0);
 
 	/* shutdown subsystems */
-	switch (dev->pci->device) {
-	case PCI_DEVICE_ID_PHILIPS_SAA7134:
-	case PCI_DEVICE_ID_PHILIPS_SAA7133:
-	case PCI_DEVICE_ID_PHILIPS_SAA7135:
-		saa7134_oss_fini(dev);
-		break;
-	}
-	if (card_has_ts(dev))
-		saa7134_ts_fini(dev);
-	saa7134_vbi_fini(dev);
-	saa7134_video_fini(dev);
-	saa7134_tvaudio_fini(dev);
+	saa7134_hwfini(dev);
 
 	/* unregister */
 	saa7134_i2c_unregister(dev);
@@ -1099,6 +1086,10 @@
 	       (SAA7134_VERSION_CODE >> 16) & 0xff,
 	       (SAA7134_VERSION_CODE >>  8) & 0xff,
 	       SAA7134_VERSION_CODE & 0xff);
+#ifdef SNAPSHOT
+	printk(KERN_INFO "saa7130/34: snapshot date %04d-%02d-%02d\n",
+	       SNAPSHOT/10000, (SNAPSHOT/100)%100, SNAPSHOT%100);
+#endif
 	return pci_module_init(&saa7134_pci_driver);
 }
 
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-input.c linux/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-input.c	2004-01-14 15:09:36.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2004-01-14 15:09:36.000000000 +0100
@@ -0,0 +1,218 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+
+#include "saa7134-reg.h"
+#include "saa7134.h"
+
+/* ---------------------------------------------------------------------- */
+
+static IR_KEYTAB_TYPE flyvideo_codes[IR_KEYTAB_SIZE] = {
+	[   15 ] = KEY_KP0,
+	[    3 ] = KEY_KP1,
+	[    4 ] = KEY_KP2,
+	[    5 ] = KEY_KP3,
+	[    7 ] = KEY_KP4,
+	[    8 ] = KEY_KP5,
+	[    9 ] = KEY_KP6,
+	[   11 ] = KEY_KP7,
+	[   12 ] = KEY_KP8,
+	[   13 ] = KEY_KP9,
+
+	[   14 ] = KEY_TUNER,        // Air/Cable
+	[   17 ] = KEY_VIDEO,        // Video
+	[   21 ] = KEY_AUDIO,        // Audio
+	[    0 ] = KEY_POWER,        // Pover
+	[    2 ] = KEY_ZOOM,         // Fullscreen
+	[   27 ] = KEY_MUTE,         // Mute
+	[   20 ] = KEY_VOLUMEUP,
+	[   23 ] = KEY_VOLUMEDOWN,
+	[   18 ] = KEY_CHANNELUP,    // Channel +
+	[   19 ] = KEY_CHANNELDOWN,  // Channel - 
+	[    6 ] = KEY_AGAIN,        // Recal
+	[   16 ] = KEY_KPENTER,      // Enter
+
+#if 1 /* FIXME */
+	[   26 ] = KEY_F22,          // Stereo
+	[   24 ] = KEY_EDIT,         // AV Source
+#endif
+};
+
+static IR_KEYTAB_TYPE cinergy_codes[IR_KEYTAB_SIZE] = {
+	[    0 ] = KEY_KP0,
+	[    1 ] = KEY_KP1,
+	[    2 ] = KEY_KP2,
+	[    3 ] = KEY_KP3,
+	[    4 ] = KEY_KP4,
+	[    5 ] = KEY_KP5,
+	[    6 ] = KEY_KP6,
+	[    7 ] = KEY_KP7,
+	[    8 ] = KEY_KP8,
+	[    9 ] = KEY_KP9,
+
+	[ 0x0a ] = KEY_POWER,
+	[ 0x0b ] = KEY_PROG1,           // app
+	[ 0x0c ] = KEY_ZOOM,            // zoom/fullscreen
+	[ 0x0d ] = KEY_CHANNELUP,       // channel
+	[ 0x0e ] = KEY_CHANNELDOWN,     // channel-
+	[ 0x0f ] = KEY_VOLUMEUP,
+	[ 0x10 ] = KEY_VOLUMEDOWN,
+	[ 0x11 ] = KEY_TUNER,           // AV
+	[ 0x12 ] = KEY_NUMLOCK,         // -/--
+	[ 0x13 ] = KEY_AUDIO,           // audio
+	[ 0x14 ] = KEY_MUTE,
+	[ 0x15 ] = KEY_UP,
+	[ 0x16 ] = KEY_DOWN,
+	[ 0x17 ] = KEY_LEFT,
+	[ 0x18 ] = KEY_RIGHT,
+	[ 0x19 ] = BTN_LEFT,
+	[ 0x1a ] = BTN_RIGHT,
+	[ 0x1b ] = KEY_WWW,             // text
+	[ 0x1c ] = KEY_REWIND,
+	[ 0x1d ] = KEY_FORWARD,
+	[ 0x1e ] = KEY_RECORD,
+	[ 0x1f ] = KEY_PLAY,
+	[ 0x20 ] = KEY_PREVIOUSSONG,
+	[ 0x21 ] = KEY_NEXTSONG,
+	[ 0x22 ] = KEY_PAUSE,
+	[ 0x23 ] = KEY_STOP,
+};
+
+/* ---------------------------------------------------------------------- */
+
+static int build_key(struct saa7134_dev *dev)
+{
+	struct saa7134_ir *ir = dev->remote;
+	u32 gpio, data;
+
+	/* rising SAA7134_GPIO_GPRESCAN reads the status */
+	saa_clearb(SAA7134_GPIO_GPMODE3,SAA7134_GPIO_GPRESCAN);
+	saa_setb(SAA7134_GPIO_GPMODE3,SAA7134_GPIO_GPRESCAN);
+	gpio = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
+	data = ir_extract_bits(gpio, ir->mask_keycode);
+
+	printk("%s: build_key gpio=0x%x mask=0x%x data=%d\n",
+	       dev->name, gpio, ir->mask_keycode, data);
+
+	if ((ir->mask_keydown  &&  (0 != (gpio & ir->mask_keydown))) ||
+	    (ir->mask_keyup    &&  (0 == (gpio & ir->mask_keyup)))) {
+		ir_input_keydown(&ir->dev,&ir->ir,data,data);
+	} else {
+		ir_input_nokey(&ir->dev,&ir->ir);
+	}
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+void saa7134_input_irq(struct saa7134_dev *dev)
+{
+	build_key(dev);
+}
+
+int saa7134_input_init1(struct saa7134_dev *dev)
+{
+	struct saa7134_ir *ir;
+	IR_KEYTAB_TYPE *ir_codes = NULL;
+	u32 mask_keycode = 0;
+	u32 mask_keydown = 0;
+	u32 mask_keyup   = 0;
+	int ir_type      = IR_TYPE_OTHER;
+
+	/* detect & configure */
+	if (!dev->has_remote)
+		return -ENODEV;
+	switch (dev->board) {
+	case SAA7134_BOARD_FLYVIDEO2000:
+	case SAA7134_BOARD_FLYVIDEO3000:
+		ir_codes     = flyvideo_codes;
+		mask_keycode = 0xEC00000;
+		mask_keydown = 0x0040000;
+		break;
+	case SAA7134_BOARD_CINERGY400:
+	case SAA7134_BOARD_CINERGY600:
+		ir_codes     = cinergy_codes;
+		mask_keycode = 0x00003f;
+		mask_keyup   = 0x040000;
+		break;
+	}
+	if (NULL == ir_codes) {
+		printk("%s: Oops: IR config error [card=%d]\n",
+		       dev->name, dev->board);
+		return -ENODEV;
+	}
+
+	ir = kmalloc(sizeof(*ir),GFP_KERNEL);
+	if (NULL == ir)
+		return -ENOMEM;
+	memset(ir,0,sizeof(*ir));
+
+	/* init hardware-specific stuff */
+	ir->mask_keycode = mask_keycode;
+	ir->mask_keydown = mask_keydown;
+	ir->mask_keyup   = mask_keyup;
+	
+	/* init input device */
+	snprintf(ir->name, sizeof(ir->name), "saa7134 IR (%s)",
+		 saa7134_boards[dev->board].name);
+	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
+		 pci_name(dev->pci));
+
+	ir_input_init(&ir->dev, &ir->ir, ir_type, ir_codes);
+	ir->dev.name = ir->name;
+	ir->dev.phys = ir->phys;
+	ir->dev.id.bustype = BUS_PCI;
+	ir->dev.id.version = 1;
+	if (dev->pci->subsystem_vendor) {
+		ir->dev.id.vendor  = dev->pci->subsystem_vendor;
+		ir->dev.id.product = dev->pci->subsystem_device;
+	} else {
+		ir->dev.id.vendor  = dev->pci->vendor;
+		ir->dev.id.product = dev->pci->device;
+	}
+
+	/* all done */
+	dev->remote = ir;
+	input_register_device(&dev->remote->dev);
+	printk("%s: registered input device for IR\n",dev->name);
+	return 0;
+}
+
+void saa7134_input_fini(struct saa7134_dev *dev)
+{
+	if (NULL == dev->remote)
+		return;
+	
+	input_unregister_device(&dev->remote->dev);
+	kfree(dev->remote);
+	dev->remote = NULL;
+}
+
+/* ----------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-oss.c linux/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-oss.c	2004-01-14 15:05:43.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-oss.c	2004-01-14 15:09:36.000000000 +0100
@@ -40,7 +40,7 @@
 MODULE_PARM_DESC(oss_rate,"sample rate (valid are: 32000,48000)");
 
 #define dprintk(fmt, arg...)	if (oss_debug) \
-	printk(KERN_DEBUG "%s/oss: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/oss: " fmt, dev->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 
@@ -295,8 +295,10 @@
 				break;
 			}
 			up(&dev->oss.lock);
-			current->state = TASK_INTERRUPTIBLE;
-			schedule();
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (0 == dev->oss.read_count)
+				schedule();
+			set_current_state(TASK_RUNNING);
 			down(&dev->oss.lock);
 			if (signal_pending(current)) {
 				if (0 == ret)
@@ -328,7 +330,6 @@
 	}
 	up(&dev->oss.lock);
 	remove_wait_queue(&dev->oss.wq, &wait);
-	current->state = TASK_RUNNING;
 	return ret;
 }
 
@@ -777,7 +778,7 @@
 
 	spin_lock(&dev->slock);
 	if (UNSET == dev->oss.dma_blk) {
-		dprintk("irq: recording stopped%s\n","");
+		dprintk("irq: recording stopped\n");
 		goto done;
 	}
 	if (0 != (status & 0x0f000000))
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-ts.c linux/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-ts.c	2004-01-14 15:05:00.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-ts.c	2004-01-14 15:09:36.000000000 +0100
@@ -45,7 +45,7 @@
 #define TS_NR_PACKETS 312
 
 #define dprintk(fmt, arg...)	if (ts_debug) \
-	printk(KERN_DEBUG "%s/ts: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/ts: " fmt, dev->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 
@@ -173,7 +173,7 @@
 	saa_writeb(SAA7134_SPECIAL_MODE, 0x00);
 	mdelay(10);
    	saa_writeb(SAA7134_SPECIAL_MODE, 0x01);
-   	current->state = TASK_INTERRUPTIBLE;
+   	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ/10);
 }
 
@@ -196,7 +196,7 @@
 	
 	list_for_each(list,&saa7134_devlist) {
 		h = list_entry(list, struct saa7134_dev, devlist);
-		if (h->ts_dev->minor == minor)
+		if (h->ts_dev && h->ts_dev->minor == minor)
 			dev = h;
 	}
 	if (NULL == dev)
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-01-14 15:04:59.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-01-14 15:09:36.000000000 +0100
@@ -41,8 +41,16 @@
 MODULE_PARM(audio_carrier,"i");
 MODULE_PARM_DESC(audio_carrier,"audio carrier location");
 
+static unsigned int audio_ddep = 0;
+MODULE_PARM(audio_ddep,"i");
+MODULE_PARM_DESC(audio_ddep,"audio ddep overwrite");
+
+static int audio_clock_tweak = 0;
+MODULE_PARM(audio_clock_tweak, "i");
+MODULE_PARM_DESC(audio_clock_tweak, "Audio clock tick fine tuning for cards with audio crystal that's slightly off (range [-1024 .. 1024])");
+
 #define dprintk(fmt, arg...)	if (audio_debug) \
-	printk(KERN_DEBUG "%s/audio: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/audio: " fmt, dev->name , ## arg)
 #define d2printk(fmt, arg...)	if (audio_debug > 1) \
 	printk(KERN_DEBUG "%s/audio: " fmt, dev->name, ## arg)
 
@@ -50,7 +58,7 @@
 		dev->name,(SAA7134_##reg),(#reg),saa_readb((SAA7134_##reg)))
 
 #define SCAN_INITIAL_DELAY  (HZ)
-#define SCAN_SAMPLE_DELAY   (HZ/10)
+#define SCAN_SAMPLE_DELAY   (HZ/5)
 
 /* ------------------------------------------------------------------ */
 /* saa7134 code                                                       */
@@ -186,8 +194,11 @@
 			in = &card(dev).mute;
 	}
 	if (dev->hw_mute  == mute &&
-	    dev->hw_input == in)
+	    dev->hw_input == in) {
+		dprintk("mute/input: nothing to do [mute=%d,input=%s]\n",
+			mute,in->name);
 		return;
+	}
 
 	dprintk("ctl_mute=%d automute=%d input=%s  =>  mute=%d input=%s\n",
 		dev->ctl_mute,dev->automute,dev->input->name,mute,in->name);
@@ -221,21 +232,27 @@
 			    struct saa7134_tvaudio *audio,
 			    char *note)
 {
-	if (note)
-		dprintk("tvaudio_setmode: %s %s [%d.%03d/%d.%03d MHz]\n",
-			note,audio->name,
-			audio->carr1 / 1000, audio->carr1 % 1000,
-			audio->carr2 / 1000, audio->carr2 % 1000);
+	int acpf, tweak = 0;
 
 	if (dev->tvnorm->id == V4L2_STD_NTSC) {
-		saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD0, 0xde);
-		saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD1, 0x15);
-		saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD2, 0x02);
+		acpf = 0x19066;
 	} else {
-		saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD0, 0x00);
-		saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD1, 0x80);
-		saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD2, 0x02);
+		acpf = 0x1e000;
 	}
+	if (audio_clock_tweak > -1024 && audio_clock_tweak < 1024)
+		tweak = audio_clock_tweak;
+
+	if (note)
+		dprintk("tvaudio_setmode: %s %s [%d.%03d/%d.%03d MHz] acpf=%d%+d\n",
+			note,audio->name,
+			audio->carr1 / 1000, audio->carr1 % 1000,
+			audio->carr2 / 1000, audio->carr2 % 1000,
+			acpf, tweak);
+
+	acpf += tweak;
+	saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD0, (acpf & 0x0000ff) >> 0);
+	saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD1, (acpf & 0x00ff00) >> 8);
+	saa_writeb(SAA7134_AUDIO_CLOCKS_PER_FIELD2, (acpf & 0x030000) >> 16);
 	tvaudio_setcarrier(dev,audio->carr1,audio->carr2);
 	
 	switch (audio->mode) {
@@ -259,18 +276,19 @@
 		saa_writeb(SAA7134_DCXO_IDENT_CTRL,           0x00);
 		saa_writeb(SAA7134_FM_DEEMPHASIS,             0x44);
 		saa_writeb(SAA7134_STEREO_DAC_OUTPUT_SELECT,  0xa1);
+		saa_writeb(SAA7134_NICAM_CONFIG,              0x00);
 		break;
 	case TVAUDIO_NICAM_AM:
 		saa_writeb(SAA7134_DEMODULATOR,               0x12);
 		saa_writeb(SAA7134_DCXO_IDENT_CTRL,           0x00);
 		saa_writeb(SAA7134_FM_DEEMPHASIS,             0x44);
 		saa_writeb(SAA7134_STEREO_DAC_OUTPUT_SELECT,  0xa1);
+		saa_writeb(SAA7134_NICAM_CONFIG,              0x00);
 		break;
 	case TVAUDIO_FM_SAT_STEREO:
 		/* not implemented (yet) */
 		break;
 	}
-	saa_writel(0x174 >> 2, 0x0001e000); /* FIXME */
 }
 
 static int tvaudio_sleep(struct saa7134_dev *dev, int timeout)
@@ -278,7 +296,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 	
 	add_wait_queue(&dev->thread.wq, &wait);
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(timeout);
 	remove_wait_queue(&dev->thread.wq, &wait);
 	return dev->thread.scan1 != dev->thread.scan2;
@@ -437,7 +455,7 @@
 	const int *carr_scan;
 	int carr_vals[4];
 	unsigned int i, audio;
-	int max1,max2,carrier,rx,mode;
+	int max1,max2,carrier,rx,mode,lastmode;
 
 	lock_kernel();
 	daemonize("%s", dev->name);
@@ -535,7 +553,7 @@
 			if (UNSET == audio)
 				audio = i;
 			tvaudio_setmode(dev,&tvaudio[i],"trying");
-			if (tvaudio_sleep(dev,HZ))
+			if (tvaudio_sleep(dev,HZ*2))
 				goto restart;
 			if (-1 != tvaudio_getstereo(dev,&tvaudio[i])) {
 				audio = i;
@@ -549,8 +567,9 @@
 		tvaudio_setstereo(dev,&tvaudio[audio],V4L2_TUNER_MODE_MONO);
 		dev->tvaudio = &tvaudio[audio];
 
+		lastmode = 42;
 		for (;;) {
-			if (tvaudio_sleep(dev,3*HZ))
+			if (tvaudio_sleep(dev,5*HZ))
 				goto restart;
 			if (dev->thread.exit || signal_pending(current))
 				break;
@@ -560,7 +579,10 @@
 			} else {
 				mode = dev->thread.mode;
 			}
-			tvaudio_setstereo(dev,&tvaudio[audio],mode);
+			if (lastmode != mode) {
+				tvaudio_setstereo(dev,&tvaudio[audio],mode);
+				lastmode = mode;
+			}
 		}
 	}
 
@@ -602,8 +624,8 @@
 	[0x1f] = "??? [in progress]",
 };
 
-#define DSP_RETRY 30
-#define DSP_DELAY 10
+#define DSP_RETRY 32
+#define DSP_DELAY 16
 
 static inline int saa_dsp_wait_bit(struct saa7134_dev *dev, int bit)
 {
@@ -721,15 +743,34 @@
 		dev->thread.scan1 = dev->thread.scan2;
 		dprintk("tvaudio thread scan start [%d]\n",dev->thread.scan1);
 
-		norms = 0;
-		if (dev->tvnorm->id & V4L2_STD_PAL)
-			norms |= 0x2c; /* B/G + D/K + I */
-		if (dev->tvnorm->id & V4L2_STD_NTSC)
-			norms |= 0x40; /* M */
-		if (dev->tvnorm->id & V4L2_STD_SECAM)
-			norms |= 0x18; /* L + D/K */
-		if (0 == norms)
-			norms = 0x0000007c;
+		if (audio_ddep >= 0x04 && audio_ddep <= 0x0e) {
+			/* insmod option override */
+			norms = (audio_ddep << 2) | 0x01;
+			dprintk("ddep override: %s\n",stdres[audio_ddep]);
+		} else{
+			/* (let chip) scan for sound carrier */
+			norms = 0;
+			if (dev->tvnorm->id & V4L2_STD_PAL) {
+				dprintk("PAL scan\n");
+				norms |= 0x2c; /* B/G + D/K + I */
+			}
+			if (dev->tvnorm->id & V4L2_STD_NTSC) {
+				dprintk("NTSC scan\n");
+				norms |= 0x40; /* M */
+			}
+			if (dev->tvnorm->id & V4L2_STD_SECAM) {
+				dprintk("SECAM scan\n");
+				norms |= 0x18; /* L + D/K */
+			}
+			if (0 == norms)
+				norms = 0x7c; /* all */
+			dprintk("scanning:%s%s%s%s%s\n",
+				(norms & 0x04) ? " B/G"  : "",
+				(norms & 0x08) ? " D/K"  : "",
+				(norms & 0x10) ? " L/L'" : "",
+				(norms & 0x20) ? " I"    : "",
+				(norms & 0x40) ? " M"    : "");
+		}
 
 		/* quick & dirty -- to be fixed up later ... */
 		saa_dsp_writel(dev, 0x454 >> 2, 0);
@@ -856,17 +897,12 @@
 
 	/* enable I2S audio output */
 	if (saa7134_boards[dev->board].i2s_rate) {
-		int rate = (32000 == saa7134_boards[dev->board].i2s_rate)
-			? 0x01 : 0x03;
+		int i2sform = (32000 == saa7134_boards[dev->board].i2s_rate) ? 0x00 : 0x01;
 		
-		/* set rate */ 
-		saa_andorb(SAA7134_SIF_SAMPLE_FREQ, 0x03, rate);
-
 		/* enable I2S output */
-		saa_writeb(SAA7134_DSP_OUTPUT_SELECT,  0x80);
-		saa_writeb(SAA7134_I2S_OUTPUT_SELECT,  0x80);
-		saa_writeb(SAA7134_I2S_OUTPUT_FORMAT,  0x01);
-		saa_writeb(SAA7134_I2S_OUTPUT_LEVEL,   0x00);	
+		saa_writeb(SAA7134_I2S_OUTPUT_SELECT,  0x80); 
+		saa_writeb(SAA7134_I2S_OUTPUT_FORMAT,  i2sform); 
+		saa_writeb(SAA7134_I2S_OUTPUT_LEVEL,   0x0F);	
 		saa_writeb(SAA7134_I2S_AUDIO_OUTPUT,   0x01);
 	}
 
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-vbi.c linux/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-vbi.c	2004-01-14 15:06:47.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-vbi.c	2004-01-14 15:09:36.000000000 +0100
@@ -39,7 +39,7 @@
 MODULE_PARM_DESC(vbibufs,"number of vbi buffers, range 2-32");
 
 #define dprintk(fmt, arg...)	if (vbi_debug) \
-	printk(KERN_DEBUG "%s/vbi: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/vbi: " fmt, dev->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134-video.c linux/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.6.1/drivers/media/video/saa7134/saa7134-video.c	2004-01-14 15:05:02.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-video.c	2004-01-14 15:09:36.000000000 +0100
@@ -40,7 +40,7 @@
 MODULE_PARM_DESC(gbuffers,"number of capture buffers, range 2-32");
 
 #define dprintk(fmt, arg...)	if (video_debug) \
-	printk(KERN_DEBUG "%s/video: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/video: " fmt, dev->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 /* data structs for video                                             */
@@ -83,6 +83,12 @@
 		.depth    = 24,
 		.pm       = 0x11,
 	},{
+		.name     = "24 bpp RGB, be",
+		.fourcc   = V4L2_PIX_FMT_RGB24,
+		.depth    = 24,
+		.pm       = 0x11,
+		.bswap    = 1,
+	},{
 		.name     = "32 bpp RGB, le",
 		.fourcc   = V4L2_PIX_FMT_BGR32,
 		.depth    = 32,
@@ -125,6 +131,16 @@
 		.planar   = 1,
 		.hshift   = 1,
 		.vshift   = 1,
+	},{
+		.name     = "4:2:0 planar, Y-Cb-Cr",
+		.fourcc   = V4L2_PIX_FMT_YVU420,
+		.depth    = 12,
+		.pm       = 0x0a,
+		.yuv      = 1,
+		.planar   = 1,
+		.uvswap   = 1,
+		.hshift   = 1,
+		.vshift   = 1,
 	}
 };
 #define FORMATS ARRAY_SIZE(formats)
@@ -788,7 +804,7 @@
 			   struct saa7134_buf *next)
 {
 	unsigned long base,control,bpl;
-	unsigned long bpl_uv,lines_uv,base2,base3; /* planar */
+	unsigned long bpl_uv,lines_uv,base2,base3,tmp; /* planar */
 
 	dprintk("buffer_activate buf=%p\n",buf);
 	buf->vb.state = STATE_ACTIVE;
@@ -834,6 +850,8 @@
 		lines_uv = buf->vb.height >> buf->fmt->vshift;
 		base2    = base + bpl * buf->vb.height;
 		base3    = base2 + bpl_uv * lines_uv;
+		if (buf->fmt->uvswap)
+			tmp = base2, base2 = base3, base3 = tmp;
 		dprintk("uv: bpl=%ld lines=%ld base2/3=%ld/%ld\n",
 			bpl_uv,lines_uv,base2,base3);
 		if (V4L2_FIELD_HAS_BOTH(buf->vb.field)) {
@@ -1160,6 +1178,9 @@
 	fh->fmt      = format_by_fourcc(V4L2_PIX_FMT_BGR24);
 	fh->width    = 768;
 	fh->height   = 576;
+#ifdef VIDIOC_G_PRIORITY
+	v4l2_prio_open(&dev->prio,&fh->prio);
+#endif
 
 	videobuf_queue_init(&fh->cap, &video_qops,
 			    dev->pci, &dev->slock,
@@ -1268,7 +1289,7 @@
 
 	/* stop video capture */
 	if (res_check(fh, RESOURCE_VIDEO)) {
-		videobuf_queue_cancel(file,&fh->cap);
+		videobuf_streamoff(file,&fh->cap);
 		res_free(dev,fh,RESOURCE_VIDEO);
 	}
 	if (fh->cap.read_buf) {
@@ -1287,7 +1308,10 @@
 
 	saa7134_pgtable_free(dev->pci,&fh->pt_cap);
 	saa7134_pgtable_free(dev->pci,&fh->pt_vbi);
-	
+
+#ifdef VIDIOC_G_PRIORITY
+	v4l2_prio_close(&dev->prio,&fh->prio);
+#endif
 	file->private_data = NULL;
 	kfree(fh);
 	return 0;
@@ -1568,6 +1592,20 @@
 
 	if (video_debug > 1)
 		saa7134_print_ioctl(dev->name,cmd);
+
+#ifdef VIDIOC_G_PRIORITY
+	switch (cmd) {
+	case VIDIOC_S_CTRL:
+	case VIDIOC_S_STD:
+	case VIDIOC_S_INPUT:
+	case VIDIOC_S_TUNER:
+	case VIDIOC_S_FREQUENCY:
+		err = v4l2_prio_check(&dev->prio,&fh->prio);
+		if (0 != err)
+			return err;
+	}
+#endif
+
 	switch (cmd) {
 	case VIDIOC_QUERYCAP:
 	{
@@ -1697,6 +1735,7 @@
 		down(&dev->lock);
 		dev->ctl_freq = f->frequency;
 		saa7134_i2c_call_clients(dev,VIDIOCSFREQ,&dev->ctl_freq);
+		saa7134_tvaudio_do_scan(dev);
 		up(&dev->lock);
 		return 0;
 	}
@@ -1727,6 +1766,22 @@
                 return 0;
         }
 
+#ifdef VIDIOC_G_PRIORITY
+        case VIDIOC_G_PRIORITY:
+        {
+                enum v4l2_priority *p = arg;
+
+                *p = v4l2_prio_max(&dev->prio);
+                return 0;
+        }
+        case VIDIOC_S_PRIORITY:
+        {
+                enum v4l2_priority *prio = arg;
+
+                return v4l2_prio_change(&dev->prio, &fh->prio, *prio);
+        }
+#endif
+
 	/* --- preview ioctls ---------------------------------------- */
 	case VIDIOC_ENUM_FMT:
 	{
@@ -2148,8 +2203,8 @@
 	
 	spin_lock(&dev->slock);
 	if (dev->video_q.curr) {
+		dev->video_fieldcount++;
 		field = dev->video_q.curr->vb.field;
-		
 		if (V4L2_FIELD_HAS_BOTH(field)) {
 			/* make sure we have seen both fields */
 			if ((status & 0x10) == 0x00) {
@@ -2165,6 +2220,7 @@
 			if ((status & 0x10) != 0x00)
 				goto done;
 		}
+		dev->video_q.curr->vb.field_count = dev->video_fieldcount;
 		saa7134_buffer_finish(dev,&dev->video_q,STATE_DONE);
 	}
 	saa7134_buffer_next(dev,&dev->video_q);
diff -u linux-2.6.1/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.1/drivers/media/video/saa7134/saa7134.h	2004-01-14 15:06:18.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134.h	2004-01-14 15:09:36.000000000 +0100
@@ -29,14 +29,11 @@
 
 #include <asm/io.h>
 
-#ifdef CONFIG_VIDEO_IR
-#include "ir-common.h"
-#endif
-
 #include <media/video-buf.h>
 #include <media/tuner.h>
 #include <media/audiochip.h>
 #include <media/id.h>
+#include <media/ir-common.h>
 
 #ifndef TRUE
 # define TRUE (1==1)
@@ -116,6 +113,7 @@
 	unsigned int   wswap:1;
 	unsigned int   yuv:1;
 	unsigned int   planar:1;
+	unsigned int   uvswap:1;
 };
 
 /* ----------------------------------------------------------- */
@@ -143,6 +141,16 @@
 #define SAA7134_BOARD_BMK_MPEX_NOTUNER 18
 #define SAA7134_BOARD_VIDEOMATE_TV     19
 #define SAA7134_BOARD_CRONOS_PLUS      20
+#define SAA7134_BOARD_10MOONSTVMASTER  21
+#define SAA7134_BOARD_MD2819           22
+#define SAA7134_BOARD_BMK_MPEX_TUNER   23
+#define SAA7134_BOARD_TVSTATION_DVR    24
+#define SAA7134_BOARD_ASUSTEK_TVFM7133	25
+#define SAA7134_BOARD_PINNACLE_PCTV_STEREO 26
+#define SAA7134_BOARD_MANLI_MTV002     27
+#define SAA7134_BOARD_MANLI_MTV001     28
+#define SAA7134_BOARD_TG3000TV         29
+#define SAA7134_BOARD_ECS_TVP3XP       30
 
 #define SAA7134_INPUT_MAX 8
 
@@ -242,11 +250,15 @@
 	struct saa7134_dev         *dev;
 	unsigned int               radio;
 	enum v4l2_buf_type         type;
+	unsigned int               resources;
+#ifdef VIDIOC_G_PRIORITY 
+	enum v4l2_priority	   prio;
+#endif
 
+	/* video overlay */
 	struct v4l2_window         win;
 	struct v4l2_clip           clips[8];
 	unsigned int               nclips;
-	unsigned int               resources;
 
 	/* video capture */
 	struct saa7134_format      *fmt;
@@ -298,7 +310,6 @@
 	unsigned int               read_count;
 };
 
-#ifdef CONFIG_VIDEO_IR
 /* IR input */
 struct saa7134_ir {
 	struct input_dev           dev;
@@ -307,14 +318,17 @@
 	char                       phys[32];
 	u32                        mask_keycode;
 	u32                        mask_keydown;
+	u32                        mask_keyup;
 };
-#endif
 
 /* global device status */
 struct saa7134_dev {
 	struct list_head           devlist;
         struct semaphore           lock;
        	spinlock_t                 slock;
+#ifdef VIDIOC_G_PRIORITY 
+	struct v4l2_prio_state     prio;
+#endif
 
 	/* various device info */
 	unsigned int               resources;
@@ -327,9 +341,7 @@
 
 	/* infrared remote */
 	int                        has_remote;
-#ifdef CONFIG_VIDEO_IR
 	struct saa7134_ir          *remote;
-#endif
 
 	/* pci i/o */
 	char                       name[32];
@@ -358,6 +370,7 @@
 	struct saa7134_dmaqueue    video_q;
 	struct saa7134_dmaqueue    ts_q;
 	struct saa7134_dmaqueue    vbi_q;
+	unsigned int               video_fieldcount;
 	unsigned int               vbi_fieldcount;
 
 	/* various v4l controls */
@@ -403,9 +416,7 @@
 #define saa_setb(reg,bit)          saa_andorb((reg),(bit),(bit))
 #define saa_clearb(reg,bit)        saa_andorb((reg),(bit),0)
 
-//#define saa_wait(d) { if (need_resched()) schedule(); else udelay(d);}
 #define saa_wait(d) { udelay(d); }
-//#define saa_wait(d) { schedule_timeout(HZ*d/1000 ?:1); }
 
 /* ----------------------------------------------------------- */
 /* saa7134-core.c                                              */

-- 
You have a new virus in /var/mail/kraxel
