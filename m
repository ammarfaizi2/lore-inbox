Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWIWFbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWIWFbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 01:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWIWFbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 01:31:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751057AbWIWFbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 01:31:00 -0400
Date: Fri, 22 Sep 2006 22:30:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V4L] Support for SAA7134-based AVerTV Hybrid A16AR
Message-Id: <20060922223031.7cc7619c.akpm@osdl.org>
In-Reply-To: <20060923001246.GB11916@pasky.or.cz>
References: <20060923001246.GB11916@pasky.or.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 02:12:46 +0200
Petr Baudis <pasky@ucw.cz> wrote:

> This adds support for a hybrid PAL/DVB/FM card. Unfortunately I tested
> only the DVB since I don't have any proper antenna available and I can
> receive even the DVB just barely so; I can hear noise in the FM part
> but I couldn't catch any station, then again I don't have an FM antenna
> either.
> 
> The PAL/FM and IR control data are based on what I harvested on the 'net.
> Perhaps I or someone else will fix them if they turn out to be wrong.
>
> ...
>
> The patch is against linux-2.6.18.

2.6.18 is ancient ;)

There have been two new cards adding in the DVB git tree.  It looks like
you got #96.


diff -puN Documentation/video4linux/CARDLIST.saa7134~v4l-support-for-saa7134-based-avertv-hybrid-a16ar Documentation/video4linux/CARDLIST.saa7134
--- a/Documentation/video4linux/CARDLIST.saa7134~v4l-support-for-saa7134-based-avertv-hybrid-a16ar
+++ a/Documentation/video4linux/CARDLIST.saa7134
@@ -96,3 +96,4 @@
  95 -> LifeView FlyVIDEO3000 (NTSC)             [5169:0138]
  96 -> Medion Md8800 Quadro                     [16be:0007,16be:0008]
  97 -> LifeView FlyDVB-S /Acorp TV134DS         [5168:0300,4e42:0300]
+ 98 -> AVerTV Hybrid A16AR                      [1461:2c00]
diff -puN drivers/media/video/saa7134/saa7134-cards.c~v4l-support-for-saa7134-based-avertv-hybrid-a16ar drivers/media/video/saa7134/saa7134-cards.c
--- a/drivers/media/video/saa7134/saa7134-cards.c~v4l-support-for-saa7134-based-avertv-hybrid-a16ar
+++ a/drivers/media/video/saa7134/saa7134-cards.c
@@ -2934,7 +2934,35 @@ struct saa7134_board saa7134_boards[] = 
 			.amux = LINE1,
 		}},
 	},
-
+	[SAA7134_BOARD_AVERMEDIA_A16AR] = {
+		/* Petr Baudis <pasky@ucw.cz> */
+		.name           = "AVerMedia TV Hybrid A16AR",
+		.audio_clock    = 0x187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290, /* untested */
+		.radio_type     = TUNER_TEA5767, /* untested */
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.tda9887_conf	= TDA9887_PRESENT,
+		.mpeg           = SAA7134_MPEG_DVB,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE1,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE1,
+		},
+	},
 };
 
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
@@ -3526,6 +3554,12 @@ struct pci_device_id saa7134_pci_tbl[] =
 		.subdevice    = 0x0502,                /* Cardbus version */
 		.driver_data  = SAA7134_BOARD_FLYDVBT_DUO_CARDBUS,
 	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
+		.subvendor    = 0x1461,
+		.subdevice    = 0x2c00,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_A16AR,
+	},{
 		/* --- boards without eeprom + subsystem ID --- */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
 		.device       = PCI_DEVICE_ID_PHILIPS_SAA7134,
@@ -3666,6 +3700,7 @@ int saa7134_board_init1(struct saa7134_d
 		saa_writeb(SAA7134_GPIO_GPMODE3, 0x08);
 		saa_writeb(SAA7134_GPIO_GPSTATUS3, 0x00);
 		break;
+	case SAA7134_BOARD_AVERMEDIA_A16AR:
 	case SAA7134_BOARD_AVERMEDIA_CARDBUS:
 		/* power-up tuner chip */
 		saa_andorl(SAA7134_GPIO_GPMODE0 >> 2,   0xffffffff, 0xffffffff);
diff -puN drivers/media/video/saa7134/saa7134-dvb.c~v4l-support-for-saa7134-based-avertv-hybrid-a16ar drivers/media/video/saa7134/saa7134-dvb.c
--- a/drivers/media/video/saa7134/saa7134-dvb.c~v4l-support-for-saa7134-based-avertv-hybrid-a16ar
+++ a/drivers/media/video/saa7134/saa7134-dvb.c
@@ -1055,6 +1055,7 @@ static int dvb_init(struct saa7134_dev *
 		}
 		break;
 	case SAA7134_BOARD_AVERMEDIA_777:
+	case SAA7134_BOARD_AVERMEDIA_A16AR:
 		printk("%s: avertv 777 dvb setup\n",dev->name);
 		dev->dvb.frontend = dvb_attach(mt352_attach, &avermedia_777,
 					       &dev->i2c_adap);
diff -puN drivers/media/video/saa7134/saa7134.h~v4l-support-for-saa7134-based-avertv-hybrid-a16ar drivers/media/video/saa7134/saa7134.h
--- a/drivers/media/video/saa7134/saa7134.h~v4l-support-for-saa7134-based-avertv-hybrid-a16ar
+++ a/drivers/media/video/saa7134/saa7134.h
@@ -225,6 +225,7 @@ struct saa7134_format {
 #define SAA7134_BOARD_FLYVIDEO3000_NTSC 95
 #define SAA7134_BOARD_MEDION_MD8800_QUADRO 96
 #define SAA7134_BOARD_FLYDVBS_LR300 97
+#define SAA7134_BOARD_AVERMEDIA_A16AR   98
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
diff -puN drivers/media/video/saa7134/saa7134-input.c~v4l-support-for-saa7134-based-avertv-hybrid-a16ar drivers/media/video/saa7134/saa7134-input.c
--- a/drivers/media/video/saa7134/saa7134-input.c~v4l-support-for-saa7134-based-avertv-hybrid-a16ar
+++ a/drivers/media/video/saa7134/saa7134-input.c
@@ -185,6 +185,7 @@ int saa7134_input_init1(struct saa7134_d
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_305:
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
 	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
+	case SAA7134_BOARD_AVERMEDIA_A16AR:
 		ir_codes     = ir_codes_avermedia;
 		mask_keycode = 0x0007C8;
 		mask_keydown = 0x000010;
_

