Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVCHLQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVCHLQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVCHLQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:16:38 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:29675 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262006AbVCHLFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:05:17 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 12:00:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: cx88 driver update
Message-ID: <20050308110012.GA31062@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Finally the big cx88 driver update which makes the cx88-dvb
driver compile and work for some cards.  A number of changes
accumulated over time ...

 * various new tv cards added / fixed.
 * added support for infrared remote controls.
 * some fixes in the blackbird (mpeg encoder) driver,
   starts working now.
 * configurarion for analog hauppauge cards now uses
   the tveeprom module.
 * kconfig fixups.
 * powermanagement fixups.
 * lot of tweaks for tv audio (make NICAM decoding work).
 * lot of changes in the dvb driver, still not working
   for all cards though as some more changes in the dvb
   subsystem are needed.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/Kconfig               |   10 
 drivers/media/video/cx88/Makefile         |    3 
 drivers/media/video/cx88/cx88-blackbird.c |   27 -
 drivers/media/video/cx88/cx88-cards.c     |  393 ++++++++++---------
 drivers/media/video/cx88/cx88-core.c      |   42 +-
 drivers/media/video/cx88/cx88-dvb.c       |  185 +++++---
 drivers/media/video/cx88/cx88-i2c.c       |    3 
 drivers/media/video/cx88/cx88-input.c     |  396 +++++++++++++++++++
 drivers/media/video/cx88/cx88-mpeg.c      |   44 +-
 drivers/media/video/cx88/cx88-tvaudio.c   |  455 +++++++++++++++-------
 drivers/media/video/cx88/cx88-vbi.c       |    5 
 drivers/media/video/cx88/cx88-video.c     |   34 -
 drivers/media/video/cx88/cx88.h           |   38 +
 13 files changed, 1189 insertions(+), 446 deletions(-)

Index: linux-2.6.11/drivers/media/video/cx88/cx88-cards.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-cards.c	2005-03-07 10:14:56.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-cards.c	2005-03-08 10:33:15.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.47 2004/11/03 09:04:50 kraxel Exp $
+ * $Id: cx88-cards.c,v 1.66 2005/03/04 09:12:23 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -26,14 +26,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 
-#if defined(CONFIG_VIDEO_CX88_DVB) || defined(CONFIG_VIDEO_CX88_DVB_MODULE)
-# define WITH_DVB 1
-#endif
-
 #include "cx88.h"
-#ifdef WITH_DVB
-#include "cx22702.h"
-#endif
 
 /* ------------------------------------------------------------------ */
 /* board config info                                                  */
@@ -59,6 +52,7 @@ struct cx88_board cx88_boards[] = {
 	[CX88_BOARD_HAUPPAUGE] = {
 		.name		= "Hauppauge WinTV 34xxx models",
 		.tuner_type     = UNSET,
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -91,7 +85,7 @@ struct cx88_board cx88_boards[] = {
 	},
 	[CX88_BOARD_PIXELVIEW] = {
 		.name           = "PixelView",
-		.tuner_type     = UNSET,
+		.tuner_type     = 5,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
@@ -126,7 +120,7 @@ struct cx88_board cx88_boards[] = {
                         .gpio0  = 0x03fe,
 		}},
 	},
-        [CX88_BOARD_WINFAST2000XP] = {
+        [CX88_BOARD_WINFAST2000XP_EXPERT] = {
                 .name           = "Leadtek Winfast 2000XP Expert",
                 .tuner_type     = 44,
 		.tda9887_conf   = TDA9887_PRESENT,
@@ -217,26 +211,55 @@ struct cx88_board cx88_boards[] = {
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
-                }},
+			.gpio0  = 0x0035e700,
+			.gpio1  = 0x00003004,
+			.gpio2  = 0x0035e700,
+			.gpio3  = 0x02000000,
+		},{
+
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x0035c700,
+			.gpio1  = 0x00003004,
+			.gpio2  = 0x0035c700,
+			.gpio3  = 0x02000000,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x0035c700,
+			.gpio1  = 0x0035c700,
+			.gpio2  = 0x02000000,
+			.gpio3  = 0x02000000,
+		}},
                 .radio = {
-                        .type   = CX88_RADIO,
-                },
+			.type   = CX88_RADIO,
+			.gpio0  = 0x0035d700,
+			.gpio1  = 0x00007004,
+			.gpio2  = 0x0035d700,
+			.gpio3  = 0x02000000,
+		 },
         },
         [CX88_BOARD_LEADTEK_PVR2000] = {
+		// gpio values for PAL version from regspy by DScaler
                 .name           = "Leadtek PVR 2000",
                 .tuner_type     = 38,
+		.tda9887_conf   = TDA9887_PRESENT,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
+                        .gpio0  = 0x0000bde6,
                 },{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
+                        .gpio0  = 0x0000bde6,
                 },{
                         .type   = CX88_VMUX_SVIDEO,
                         .vmux   = 2,
+                        .gpio0  = 0x0000bde6,
                 }},
                 .radio = {
                         .type   = CX88_RADIO,
+                        .gpio0  = 0x0000bd62,
                 },
 		.blackbird = 1,
         },
@@ -320,14 +343,15 @@ struct cx88_board cx88_boards[] = {
                 .name           = "KWorld/VStream XPert DVB-T",
 		.tuner_type     = TUNER_ABSENT,
                 .input          = {{
-                        .type   = CX88_VMUX_DVB,
-                        .vmux   = 0,
-                },{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
+			.gpio0  = 0x0700,
+			.gpio2  = 0x0101,
                 },{
                         .type   = CX88_VMUX_SVIDEO,
                         .vmux   = 2,
+			.gpio0  = 0x0700,
+			.gpio2  = 0x0101,
                 }},
 		.dvb            = 1,
 	},
@@ -452,6 +476,131 @@ struct cx88_board cx88_boards[] = {
 		}},
 		.dvb            = 1,
 	},
+	[CX88_BOARD_DNTV_LIVE_DVB_T] = {
+		.name	        = "digitalnow DNTV Live! DVB-T",
+		.tuner_type     = TUNER_ABSENT,
+		.input	        = {{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x00000700,
+			.gpio2  = 0x00000101,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x00000700,
+			.gpio2  = 0x00000101,
+		}},
+		.dvb            = 1,
+	},
+	[CX88_BOARD_PCHDTV_HD3000] = {
+		.name           = "pcHDTV HD3000 HDTV",
+		.tuner_type     = TUNER_THOMSON_DTT7610,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x00008484,
+			.gpio1  = 0x00000000,
+			.gpio2  = 0x00000000,
+			.gpio3  = 0x00000000,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x00008400,
+			.gpio1  = 0x00000000,
+			.gpio2  = 0x00000000,
+			.gpio3  = 0x00000000,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x00008400,
+			.gpio1  = 0x00000000,
+			.gpio2  = 0x00000000,
+			.gpio3  = 0x00000000,
+		}},
+		.radio = {
+			.type   = CX88_RADIO,
+			.vmux   = 2,
+			.gpio0  = 0x00008400,
+			.gpio1  = 0x00000000,
+			.gpio2  = 0x00000000,
+			.gpio3  = 0x00000000,
+		},
+		.dvb            = 1,
+	},
+	[CX88_BOARD_HAUPPAUGE_ROSLYN] = {
+		// entry added by Kaustubh D. Bhalerao <bhalerao.1@osu.edu>
+		// GPIO values obtained from regspy, courtesy Sean Covel
+		.name        = "Hauppauge WinTV 28xxx (Roslyn) models",
+		.tuner_type  = UNSET,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0xed12,  // internal decoder
+			.gpio2  = 0x00ff,
+		},{
+			.type   = CX88_VMUX_DEBUG,
+			.vmux   = 0,
+			.gpio0  = 0xff01,  // mono from tuner chip
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0xff02,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0xed92,
+			.gpio2  = 0x00ff,
+		}},
+		.radio = {
+			 .type   = CX88_RADIO,
+			 .gpio0  = 0xed96,
+			 .gpio2  = 0x00ff,
+		 },
+		.blackbird = 1,
+	},
+	[CX88_BOARD_DIGITALLOGIC_MEC] = {
+		/* params copied over from Leadtek PVR 2000 */
+		.name           = "Digital-Logic MICROSPACE Entertainment Center (MEC)",
+		/* not sure yet about the tuner type */
+		.tuner_type     = 38,
+		.tda9887_conf   = TDA9887_PRESENT,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x0000bde6,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x0000bde6,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x0000bde6,
+		}},
+		.radio = {
+			.type   = CX88_RADIO,
+			.gpio0  = 0x0000bd62,
+		},
+		.blackbird = 1,
+	},
+	[CX88_BOARD_IODATA_GVBCTV7E] = {
+		.name           = "IODATA GV/BCTV7E",
+		.tuner_type     = TUNER_PHILIPS_FQ1286,
+		.tda9887_conf   = TDA9887_PRESENT,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 1,
+			.gpio1  = 0x0000e03f,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 2,
+			.gpio1  = 0x0000e07f,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 3,
+			.gpio1  = 0x0000e07f,
+		}}
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -482,11 +631,11 @@ struct cx88_subid cx88_subids[] = {
 	},{
                 .subvendor = 0x107d,
                 .subdevice = 0x6611,
-                .card      = CX88_BOARD_WINFAST2000XP,
+                .card      = CX88_BOARD_WINFAST2000XP_EXPERT,
 	},{
                 .subvendor = 0x107d,
                 .subdevice = 0x6613,	/* NTSC */
-                .card      = CX88_BOARD_WINFAST2000XP,
+                .card      = CX88_BOARD_WINFAST2000XP_EXPERT,
 	},{
 		.subvendor = 0x107d,
                 .subdevice = 0x6620,
@@ -543,6 +692,30 @@ struct cx88_subid cx88_subids[] = {
 		.subvendor = 0x18AC,
 		.subdevice = 0xDB10,
 		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS,
+	},{
+                .subvendor = 0x1554,
+                .subdevice = 0x4811,
+                .card      = CX88_BOARD_PIXELVIEW,
+	},{
+		.subvendor = 0x7063,
+		.subdevice = 0x3000, /* HD-3000 card */
+		.card      = CX88_BOARD_PCHDTV_HD3000,
+	},{
+		.subvendor = 0x17DE,
+		.subdevice = 0xA8A6,
+		.card      = CX88_BOARD_DNTV_LIVE_DVB_T,
+	},{
+		.subvendor = 0x0070,
+		.subdevice = 0x2801,
+		.card      = CX88_BOARD_HAUPPAUGE_ROSLYN,
+	},{
+		.subvendor = 0x14F1,
+		.subdevice = 0x0342,
+		.card      = CX88_BOARD_DIGITALLOGIC_MEC,
+	},{
+		.subvendor = 0x10fc,
+		.subdevice = 0xd035,
+		.card      = CX88_BOARD_IODATA_GVBCTV7E,
 	}
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
@@ -552,7 +725,7 @@ const unsigned int cx88_idcount = ARRAY_
 
 static void __devinit leadtek_eeprom(struct cx88_core *core, u8 *eeprom_data)
 {
-	/* This is just for the Winfast 2000 XP board ATM; I don't have data on
+	/* This is just for the "Winfast 2000XP Expert" board ATM; I don't have data on
 	 * any others.
 	 *
 	 * Byte 0 is 1 on the NTSC board.
@@ -569,108 +742,27 @@ static void __devinit leadtek_eeprom(str
 	core->has_radio  = 1;
 	core->tuner_type = (eeprom_data[6] == 0x13) ? 43 : 38;
 
-	printk(KERN_INFO "%s: Leadtek Winfast 2000 XP config: "
+	printk(KERN_INFO "%s: Leadtek Winfast 2000XP Expert config: "
 	       "tuner=%d, eeprom[0]=0x%02x\n",
 	       core->name, core->tuner_type, eeprom_data[0]);
 }
 
 
 /* ----------------------------------------------------------------------- */
-/* some hauppauge specific stuff                                           */
-
-static struct {
-        int  id;
-        char *name;
-} hauppauge_tuner[] __devinitdata = {
-        { TUNER_ABSENT,        "" },
-        { TUNER_ABSENT,        "External" },
-        { TUNER_ABSENT,        "Unspecified" },
-        { TUNER_PHILIPS_PAL,   "Philips FI1216" },
-        { TUNER_PHILIPS_SECAM, "Philips FI1216MF" },
-        { TUNER_PHILIPS_NTSC,  "Philips FI1236" },
-        { TUNER_PHILIPS_PAL_I, "Philips FI1246" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FI1256" },
-        { TUNER_PHILIPS_PAL,   "Philips FI1216 MK2" },
-        { TUNER_PHILIPS_SECAM, "Philips FI1216MF MK2" },
-        { TUNER_PHILIPS_NTSC,  "Philips FI1236 MK2" },
-        { TUNER_PHILIPS_PAL_I, "Philips FI1246 MK2" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FI1256 MK2" },
-        { TUNER_TEMIC_NTSC,    "Temic 4032FY5" },
-        { TUNER_TEMIC_PAL,     "Temic 4002FH5" },
-        { TUNER_TEMIC_PAL_I,   "Temic 4062FY5" },
-        { TUNER_PHILIPS_PAL,   "Philips FR1216 MK2" },
-        { TUNER_PHILIPS_SECAM, "Philips FR1216MF MK2" },
-        { TUNER_PHILIPS_NTSC,  "Philips FR1236 MK2" },
-        { TUNER_PHILIPS_PAL_I, "Philips FR1246 MK2" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FR1256 MK2" },
-        { TUNER_PHILIPS_PAL,   "Philips FM1216" },
-        { TUNER_PHILIPS_SECAM, "Philips FM1216MF" },
-        { TUNER_PHILIPS_NTSC,  "Philips FM1236" },
-        { TUNER_PHILIPS_PAL_I, "Philips FM1246" },
-        { TUNER_PHILIPS_PAL_DK,"Philips FM1256" },
-        { TUNER_TEMIC_4036FY5_NTSC, "Temic 4036FY5" },
-        { TUNER_ABSENT,        "Samsung TCPN9082D" },
-        { TUNER_ABSENT,        "Samsung TCPM9092P" },
-        { TUNER_TEMIC_4006FH5_PAL, "Temic 4006FH5" },
-        { TUNER_ABSENT,        "Samsung TCPN9085D" },
-        { TUNER_ABSENT,        "Samsung TCPB9085P" },
-        { TUNER_ABSENT,        "Samsung TCPL9091P" },
-        { TUNER_TEMIC_4039FR5_NTSC, "Temic 4039FR5" },
-        { TUNER_PHILIPS_FQ1216ME,   "Philips FQ1216 ME" },
-        { TUNER_TEMIC_4066FY5_PAL_I, "Temic 4066FY5" },
-        { TUNER_PHILIPS_NTSC,        "Philips TD1536" },
-        { TUNER_PHILIPS_NTSC,        "Philips TD1536D" },
-	{ TUNER_PHILIPS_NTSC,  "Philips FMR1236" }, /* mono radio */
-        { TUNER_ABSENT,        "Philips FI1256MP" },
-        { TUNER_ABSENT,        "Samsung TCPQ9091P" },
-        { TUNER_TEMIC_4006FN5_MULTI_PAL, "Temic 4006FN5" },
-        { TUNER_TEMIC_4009FR5_PAL, "Temic 4009FR5" },
-        { TUNER_TEMIC_4046FM5,     "Temic 4046FM5" },
-	{ TUNER_TEMIC_4009FN5_MULTI_PAL_FM, "Temic 4009FN5" },
-	{ TUNER_ABSENT,        "Philips TD1536D_FH_44"},
-	{ TUNER_LG_NTSC_FM,    "LG TPI8NSR01F"},
-	{ TUNER_LG_PAL_FM,     "LG TPI8PSB01D"},
-	{ TUNER_LG_PAL,        "LG TPI8PSB11D"},
-	{ TUNER_LG_PAL_I_FM,   "LG TAPC-I001D"},
-	{ TUNER_LG_PAL_I,      "LG TAPC-I701D"}
-};
 
 static void hauppauge_eeprom(struct cx88_core *core, u8 *eeprom_data)
 {
-	unsigned int blk2,tuner,radio,model;
-
-	if (eeprom_data[0] != 0x84 || eeprom_data[2] != 0) {
-		printk(KERN_WARNING "%s: Hauppauge eeprom: invalid\n",
-		       core->name);
-		return;
-	}
-
-	/* Block 2 starts after len+3 bytes header */
-	blk2 = eeprom_data[1] + 3;
-
-	/* decode + use some config infos */
-	model = eeprom_data[12] << 8 | eeprom_data[11];
-	tuner = eeprom_data[9];
-	radio = eeprom_data[blk2-1] & 0x01;
-
-        if (tuner < ARRAY_SIZE(hauppauge_tuner))
-                core->tuner_type = hauppauge_tuner[tuner].id;
-	if (radio)
-		core->has_radio = 1;
+	struct tveeprom tv;
 
-	printk(KERN_INFO "%s: hauppauge eeprom: model=%d, "
-	       "tuner=%s (%d), radio=%s\n",
-	       core->name, model, (tuner < ARRAY_SIZE(hauppauge_tuner)
-				   ? hauppauge_tuner[tuner].name : "?"),
-	       core->tuner_type, radio ? "yes" : "no");
+	tveeprom_hauppauge_analog(&tv, eeprom_data);
+	core->tuner_type = tv.tuner_type;
+	core->has_radio  = tv.has_radio;
 }
 
-#ifdef WITH_DVB
 static int hauppauge_eeprom_dvb(struct cx88_core *core, u8 *ee)
 {
 	int model;
 	int tuner;
-	char *tname;
 
 	/* Make sure we support the board model */
 	model = ee[0x1f] << 24 | ee[0x1e] << 16 | ee[0x1d] << 8 | ee[0x1c];
@@ -689,26 +781,18 @@ static int hauppauge_eeprom_dvb(struct c
 	/* Make sure we support the tuner */
 	tuner = ee[0x2d];
 	switch(tuner) {
-	case 0x4B:
-		tname = "Thomson DTT 7595";
-		core->pll_type = PLLTYPE_DTT7595;
-		break;
-	case 0x4C:
-		tname = "Thomson DTT 7592";
-		core->pll_type = PLLTYPE_DTT7592;
+	case 0x4B: /* dtt 7595 */
+	case 0x4C: /* dtt 7592 */
 		break;
 	default:
 		printk("%s: error: unknown hauppauge tuner 0x%02x\n",
 		       core->name, tuner);
 		return -ENODEV;
 	}
-	printk(KERN_INFO "%s: hauppauge eeprom: model=%d, tuner=%s (%d)\n",
-	       core->name, model, tname, tuner);
-
-	core->pll_addr = 0x61;
-	core->demod_addr = 0x43;
+	printk(KERN_INFO "%s: hauppauge eeprom: model=%d, tuner=%d\n",
+	       core->name, model, tuner);
+	return 0;
 }
-#endif
 
 /* ----------------------------------------------------------------------- */
 /* some GDI (was: Modular Technology) specific stuff                       */
@@ -763,36 +847,6 @@ static void gdi_eeprom(struct cx88_core 
 
 /* ----------------------------------------------------------------------- */
 
-static int
-i2c_eeprom(struct i2c_client *c, unsigned char *eedata, int len)
-{
-	unsigned char buf;
-	int err;
-
-	c->addr = 0xa0 >> 1;
-	buf = 0;
-	if (1 != (err = i2c_master_send(c,&buf,1))) {
-		printk(KERN_INFO "cx88: Huh, no eeprom present (err=%d)?\n",
-		       err);
-		return -1;
-	}
-	if (len != (err = i2c_master_recv(c,eedata,len))) {
-		printk(KERN_WARNING "cx88: i2c eeprom read error (err=%d)\n",
-		       err);
-		return -1;
-	}
-#if 0
-	for (i = 0; i < len; i++) {
-		if (0 == (i % 16))
-			printk(KERN_INFO "cx88 ee: %02x:",i);
-		printk(" %02x",eedata[i]);
-		if (15 == (i % 16))
-			printk("\n");
-	}
-#endif
-	return 0;
-}
-
 void cx88_card_list(struct cx88_core *core, struct pci_dev *pci)
 {
 	int i;
@@ -823,41 +877,46 @@ void cx88_card_setup(struct cx88_core *c
 {
 	static u8 eeprom[128];
 
+	if (0 == core->i2c_rc) {
+		core->i2c_client.addr = 0xa0 >> 1;
+		tveeprom_read(&core->i2c_client,eeprom,sizeof(eeprom));
+	}
+
 	switch (core->board) {
 	case CX88_BOARD_HAUPPAUGE:
+	case CX88_BOARD_HAUPPAUGE_ROSLYN:
 		if (0 == core->i2c_rc)
-			i2c_eeprom(&core->i2c_client,eeprom,sizeof(eeprom));
-		hauppauge_eeprom(core,eeprom+8);
+			hauppauge_eeprom(core,eeprom+8);
 		break;
 	case CX88_BOARD_GDI:
 		if (0 == core->i2c_rc)
-			i2c_eeprom(&core->i2c_client,eeprom,sizeof(eeprom));
-		gdi_eeprom(core,eeprom);
+			gdi_eeprom(core,eeprom);
 		break;
-	case CX88_BOARD_WINFAST2000XP:
+	case CX88_BOARD_WINFAST2000XP_EXPERT:
 		if (0 == core->i2c_rc)
-			i2c_eeprom(&core->i2c_client,eeprom,sizeof(eeprom));
-		leadtek_eeprom(core,eeprom);
+			leadtek_eeprom(core,eeprom);
+		break;
+	case CX88_BOARD_HAUPPAUGE_DVB_T1:
+		if (0 == core->i2c_rc)
+			hauppauge_eeprom_dvb(core,eeprom);
 		break;
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
-		/* Tuner reset is hooked to  the tuner out of reset */
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
+		/* GPIO0:0 is hooked to mt352 reset pin */
 		cx_set(MO_GP0_IO, 0x00000101);
 		cx_clear(MO_GP0_IO, 0x00000001);
 		msleep(1);
 		cx_set(MO_GP0_IO, 0x00000101);
 		break;
-#ifdef WITH_DVB
-	case CX88_BOARD_HAUPPAUGE_DVB_T1:
-		if (0 == core->i2c_rc)
-			i2c_eeprom(&core->i2c_client,eeprom,sizeof(eeprom));
-		hauppauge_eeprom_dvb(core,eeprom);
-		break;
-	case CX88_BOARD_CONEXANT_DVB_T1:
-		core->pll_type   = PLLTYPE_DTT7579;
-		core->pll_addr   = 0x60;
-		core->demod_addr = 0x43;
+	case CX88_BOARD_KWORLD_DVB_T:
+	case CX88_BOARD_DNTV_LIVE_DVB_T:
+		cx_set(MO_GP0_IO, 0x00000707);
+		cx_set(MO_GP2_IO, 0x00000101);
+		cx_clear(MO_GP2_IO, 0x00000001);
+		msleep(1);
+		cx_clear(MO_GP0_IO, 0x00000007);
+		cx_set(MO_GP2_IO, 0x00000101);
 		break;
-#endif
 	}
 	if (cx88_boards[core->board].radio.type == CX88_RADIO)
 		core->has_radio = 1;
Index: linux-2.6.11/drivers/media/video/cx88/cx88-core.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-core.c	2005-03-07 10:13:16.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-core.c	2005-03-08 10:33:15.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-core.c,v 1.15 2004/10/25 11:26:36 kraxel Exp $
+ * $Id: cx88-core.c,v 1.24 2005/01/19 12:01:55 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * driver core
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
@@ -62,6 +63,10 @@ static unsigned int nicam = 0;
 module_param(nicam,int,0644);
 MODULE_PARM_DESC(nicam,"tv audio is nicam");
 
+static unsigned int nocomb = 0;
+module_param(nocomb,int,0644);
+MODULE_PARM_DESC(nocomb,"disable comb filter");
+
 #define dprintk(level,fmt, arg...)	if (core_debug >= level)	\
 	printk(KERN_DEBUG "%s: " fmt, core->name , ## arg)
 
@@ -462,6 +467,7 @@ int cx88_risc_decode(u32 risc)
 	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
+#if 0 /* currently unused, but useful for debugging */
 void cx88_risc_disasm(struct cx88_core *core,
 		      struct btcx_riscmem *risc)
 {
@@ -479,6 +485,7 @@ void cx88_risc_disasm(struct cx88_core *
 			break;
 	}
 }
+#endif
 
 void cx88_sram_channel_dump(struct cx88_core *core,
 			    struct sram_channel *ch)
@@ -579,10 +586,19 @@ void cx88_print_irqbits(char *name, char
 
 /* ------------------------------------------------------------------ */
 
-void cx88_irq(struct cx88_core *core, u32 status, u32 mask)
+int cx88_core_irq(struct cx88_core *core, u32 status)
 {
-	cx88_print_irqbits(core->name, "irq pci",
-			   cx88_pci_irqs, status, mask);
+	int handled = 0;
+
+	if (status & (1<<18)) {
+		cx88_ir_irq(core);
+		handled++;
+	}
+	if (!handled)
+		cx88_print_irqbits(core->name, "irq pci",
+				   cx88_pci_irqs, status,
+				   core->pci_irqmask);
+	return handled;
 }
 
 void cx88_wakeup(struct cx88_core *core,
@@ -800,6 +816,8 @@ int cx88_set_scale(struct cx88_core *cor
 		value |= (1 << 0); // 3-tap interpolation
 	if (width < 193)
 		value |= (1 << 1); // 5-tap interpolation
+	if (nocomb)
+		value |= (3 << 5); // disable comb filter
 
 	cx_write(MO_FILTER_EVEN,  value);
 	cx_write(MO_FILTER_ODD,   value);
@@ -887,8 +905,8 @@ static int set_tvaudio(struct cx88_core 
 	cx88_set_tvaudio(core);
 	// cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO);
 
-	cx_write(MO_AUDD_LNGTH, 128/8);  /* fifo size */
-	cx_write(MO_AUDR_LNGTH, 128/8);  /* fifo size */
+	cx_write(MO_AUDD_LNGTH,    128); /* fifo size */
+	cx_write(MO_AUDR_LNGTH,    128); /* fifo size */
 	cx_write(MO_AUD_DMACNTRL, 0x03); /* need audio fifo */
 	return 0;
 }
@@ -969,6 +987,9 @@ int cx88_set_tvnorm(struct cx88_core *co
 	cx_write(MO_VBI_PACKET, ((1 << 11) | /* (norm_vdelay(norm)   << 11) | */
 				 norm_vbipack(norm)));
 
+	// this is needed as well to set all tvnorm parameter
+	cx88_set_scale(core, 320, 240, V4L2_FIELD_INTERLACED);
+
 	// audio
 	set_tvaudio(core);
 
@@ -1105,9 +1126,10 @@ struct cx88_core* cx88_core_get(struct p
 		goto fail_unlock;
 
 	memset(core,0,sizeof(*core));
+	atomic_inc(&core->refcount);
 	core->pci_bus  = pci->bus->number;
 	core->pci_slot = PCI_SLOT(pci->devfn);
-	atomic_inc(&core->refcount);
+	core->pci_irqmask = 0x00fc00;
 
 	core->nr = cx88_devcount++;
 	sprintf(core->name,"cx88[%d]",core->nr);
@@ -1150,6 +1172,7 @@ struct cx88_core* cx88_core_get(struct p
 	cx88_reset(core);
 	cx88_i2c_init(core,pci);
 	cx88_card_setup(core);
+	cx88_ir_init(core,pci);
 
 	up(&devlist);
 	return core;
@@ -1170,6 +1193,7 @@ void cx88_core_put(struct cx88_core *cor
 		return;
 
 	down(&devlist);
+	cx88_ir_fini(core);
 	if (0 == core->i2c_rc)
 		i2c_bit_del_bus(&core->i2c_adap);
 	list_del(&core->devlist);
@@ -1187,7 +1211,7 @@ EXPORT_SYMBOL(cx88_vid_irqs);
 EXPORT_SYMBOL(cx88_mpeg_irqs);
 EXPORT_SYMBOL(cx88_print_irqbits);
 
-EXPORT_SYMBOL(cx88_irq);
+EXPORT_SYMBOL(cx88_core_irq);
 EXPORT_SYMBOL(cx88_wakeup);
 EXPORT_SYMBOL(cx88_reset);
 EXPORT_SYMBOL(cx88_shutdown);
@@ -1197,8 +1221,6 @@ EXPORT_SYMBOL(cx88_risc_databuffer);
 EXPORT_SYMBOL(cx88_risc_stopper);
 EXPORT_SYMBOL(cx88_free_buffer);
 
-EXPORT_SYMBOL(cx88_risc_disasm);
-
 EXPORT_SYMBOL(cx88_sram_channels);
 EXPORT_SYMBOL(cx88_sram_channel_setup);
 EXPORT_SYMBOL(cx88_sram_channel_dump);
Index: linux-2.6.11/drivers/media/video/cx88/cx88-blackbird.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-blackbird.c	2005-03-08 10:33:15.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-blackbird.c	2005-03-08 10:33:20.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-blackbird.c,v 1.17 2004/11/07 13:17:15 kraxel Exp $
+ * $Id: cx88-blackbird.c,v 1.26 2005/03/07 15:58:05 kraxel Exp $
  *
  *  Support for a cx23416 mpeg encoder via cx2388x host port.
  *  "blackbird" reference design.
@@ -25,6 +25,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/delay.h>
@@ -207,10 +208,6 @@ static int register_write(struct cx88_co
 	cx_read(P1_RADDR0);
 
 	return wait_ready_gpio0_bit1(core,1);
-#if 0
-	udelay(1000); /* without this, things don't go right (subsequent memory_write()'s don't get through */
-	/* ? would this be safe here? set_current_state(TASK_INTERRUPTIBLE); schedule_timeout(1); */
-#endif
 }
 
 
@@ -283,7 +280,7 @@ static int blackbird_api_cmd(struct cx88
 	timeout = jiffies + msecs_to_jiffies(10);
 	for (;;) {
 		memory_read(dev->core, dev->mailbox, &flag);
-		if (0 == (flag & 4))
+		if (0 != (flag & 4))
 			break;
 		if (time_after(jiffies,timeout)) {
 			dprintk(0, "ERROR: API Mailbox timeout\n");
@@ -324,7 +321,7 @@ static int blackbird_find_mailbox(struct
 			signaturecnt = 0;
 		if (4 == signaturecnt) {
 			dprintk(1, "Mailbox signature found\n");
-			return i;
+			return i+1;
 		}
 	}
 	dprintk(0, "Mailbox signature values not found!\n");
@@ -427,7 +424,8 @@ static void blackbird_codec_settings(str
         blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAMERATE, 1, 0, 0);
 
         /* assign frame size */
-        blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAME_SIZE, 2, 0, 480, 720);
+        blackbird_api_cmd(dev, IVTV_API_ASSIGN_FRAME_SIZE, 2, 0,
+			  dev->height, dev->width);
 
         /* assign aspect ratio */
         blackbird_api_cmd(dev, IVTV_API_ASSIGN_ASPECT_RATIO, 1, 0, 2);
@@ -629,8 +627,8 @@ static int mpeg_do_ioctl(struct inode *i
 
 		memset(f,0,sizeof(*f));
 		f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-		f->fmt.pix.width        = 720;
-		f->fmt.pix.height       = 576;
+		f->fmt.pix.width        = dev->width;
+		f->fmt.pix.height       = dev->height;
 		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
 		f->fmt.pix.sizeimage    = 1024 * 512 /* FIXME: BUFFER_SIZE */;
 	}
@@ -694,6 +692,10 @@ static int mpeg_open(struct inode *inode
 	file->private_data = fh;
 	fh->dev      = dev;
 
+	/* FIXME: locking against other video device */
+	cx88_set_scale(dev->core, dev->width, dev->height,
+		       V4L2_FIELD_INTERLACED);
+
 	videobuf_queue_init(&fh->mpegq, &blackbird_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
@@ -715,6 +717,7 @@ static int mpeg_release(struct inode *in
 	if (fh->mpegq.reading)
 		videobuf_read_stop(&fh->mpegq);
 
+	videobuf_mmap_free(&fh->mpegq);
 	file->private_data = NULL;
 	kfree(fh);
 	return 0;
@@ -821,6 +824,8 @@ static int __devinit blackbird_probe(str
 	memset(dev,0,sizeof(*dev));
 	dev->pci = pci_dev;
 	dev->core = core;
+	dev->width = 720;
+	dev->height = 480;
 
 	err = cx8802_init_common(dev);
 	if (0 != err)
@@ -852,6 +857,8 @@ static void __devexit blackbird_remove(s
 
 	/* common */
 	cx8802_fini_common(dev);
+	cx88_core_put(dev->core,dev->pci);
+	kfree(dev);
 }
 
 static struct pci_device_id cx8802_pci_tbl[] = {
Index: linux-2.6.11/drivers/media/video/Kconfig
===================================================================
--- linux-2.6.11.orig/drivers/media/video/Kconfig	2005-03-07 10:15:21.000000000 +0100
+++ linux-2.6.11/drivers/media/video/Kconfig	2005-03-08 10:33:15.000000000 +0100
@@ -305,11 +305,14 @@ config VIDEO_HEXIUM_GEMINI
 
 config VIDEO_CX88
 	tristate "Conexant 2388x (bt878 successor) support"
-	depends on VIDEO_DEV && PCI && EXPERIMENTAL
+	depends on VIDEO_DEV && PCI && I2C && EXPERIMENTAL
 	select I2C_ALGOBIT
+	select FW_LOADER
 	select VIDEO_BTCX
 	select VIDEO_BUF
 	select VIDEO_TUNER
+	select VIDEO_TVEEPROM
+	select VIDEO_IR
 	---help---
 	  This is a video4linux driver for Conexant 2388x based
 	  TV cards.
@@ -319,10 +322,11 @@ config VIDEO_CX88
 
 config VIDEO_CX88_DVB
 	tristate "DVB Support for cx2388x based TV cards"
-	depends on VIDEO_CX88 && DVB_CORE && BROKEN
+	depends on VIDEO_CX88 && DVB_CORE
 	select VIDEO_BUF_DVB
+	select DVB_MT352
 	---help---
-	  This adds support for DVB cards based on the
+	  This adds support for DVB/ATSC cards based on the
 	  Connexant 2388x chip.
 
 config VIDEO_OVCAMCHIP
Index: linux-2.6.11/drivers/media/video/cx88/cx88-video.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-video.c	2005-03-08 10:33:15.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-video.c	2005-03-08 10:33:20.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.46 2004/11/07 14:44:59 kraxel Exp $
+ * $Id: cx88-video.c,v 1.58 2005/03/07 15:58:05 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kmod.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -428,7 +429,7 @@ static int start_video_dma(struct cx8800
 	q->count = 1;
 
 	/* enable irqs */
-	cx_set(MO_PCI_INTMSK, 0x00fc01);
+	cx_set(MO_PCI_INTMSK, core->pci_irqmask | 0x01);
 	cx_set(MO_VID_INTMSK, 0x0f0011);
 
 	/* enable capture */
@@ -994,7 +995,7 @@ static int video_open(struct inode *inod
 		cx_write(MO_GP3_IO, cx88_boards[board].radio.gpio3);
 		dev->core->tvaudio = WW_FM;
 		cx88_set_tvaudio(core);
-		cx88_set_stereo(core,V4L2_TUNER_MODE_STEREO);
+		cx88_set_stereo(core,V4L2_TUNER_MODE_STEREO,1);
 		cx88_call_i2c_clients(dev->core,AUDC_SET_RADIO,NULL);
 	}
 
@@ -1002,7 +1003,7 @@ static int video_open(struct inode *inod
 }
 
 static ssize_t
-video_read(struct file *file, char __user *data, size_t count, loff_t *ppos)
+video_read(struct file *file, char *data, size_t count, loff_t *ppos)
 {
 	struct cx8800_fh *fh = file->private_data;
 
@@ -1083,6 +1084,8 @@ static int video_release(struct inode *i
 		res_free(dev,fh,RESOURCE_VBI);
 	}
 
+	videobuf_mmap_free(&fh->vidq);
+	videobuf_mmap_free(&fh->vbiq);
 	file->private_data = NULL;
 	kfree(fh);
 	return 0;
@@ -1338,7 +1341,6 @@ static int video_do_ioctl(struct inode *
 			0;
 		if (UNSET != core->tuner_type)
 			cap->capabilities |= V4L2_CAP_TUNER;
-
 		return 0;
 	}
 
@@ -1429,6 +1431,7 @@ static int video_do_ioctl(struct inode *
 		if (*i >= 4)
 			return -EINVAL;
 		down(&dev->lock);
+		cx88_newstation(core);
 		video_mux(dev,*i);
 		up(&dev->lock);
 		return 0;
@@ -1560,7 +1563,7 @@ static int video_do_ioctl(struct inode *
 			return -EINVAL;
 		if (0 != t->index)
 			return -EINVAL;
-		cx88_set_stereo(core, t->audmode);
+		cx88_set_stereo(core, t->audmode, 1);
 		return 0;
 	}
 	case VIDIOC_G_FREQUENCY:
@@ -1590,6 +1593,7 @@ static int video_do_ioctl(struct inode *
 			return -EINVAL;
 		down(&dev->lock);
 		dev->freq = f->frequency;
+		cx88_newstation(core);
 #ifdef V4L2_I2C_CLIENTS
 		cx88_call_i2c_clients(dev->core,VIDIOC_S_FREQUENCY,f);
 #else
@@ -1880,19 +1884,18 @@ static irqreturn_t cx8800_irq(int irq, v
 {
 	struct cx8800_dev *dev = dev_id;
 	struct cx88_core *core = dev->core;
-	u32 status, mask;
+	u32 status;
 	int loop, handled = 0;
 
 	for (loop = 0; loop < 10; loop++) {
-		status = cx_read(MO_PCI_INTSTAT) & (~0x1f | 0x01);
-		mask   = cx_read(MO_PCI_INTMSK);
-		if (0 == (status & mask))
+		status = cx_read(MO_PCI_INTSTAT) & (core->pci_irqmask | 0x01);
+		if (0 == status)
 			goto out;
 		cx_write(MO_PCI_INTSTAT, status);
 		handled = 1;
 
-		if (status & mask & ~0x1f)
-			cx88_irq(core,status,mask);
+		if (status & core->pci_irqmask)
+			cx88_core_irq(core,status);
 		if (status & 0x01)
 			cx8800_vid_irq(dev);
 	};
@@ -2055,6 +2058,7 @@ static int __devinit cx8800_initdev(stru
 		       core->name,pci_dev->irq);
 		goto fail_core;
 	}
+	cx_set(MO_PCI_INTMSK, core->pci_irqmask);
 
 	/* load and configure helper modules */
 	if (TUNER_ABSENT != core->tuner_type)
@@ -2156,7 +2160,7 @@ static void __devexit cx8800_finidev(str
 	kfree(dev);
 }
 
-static int cx8800_suspend(struct pci_dev *pci_dev, u32 state)
+static int cx8800_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
         struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
 	struct cx88_core *core = dev->core;
@@ -2181,7 +2185,7 @@ static int cx8800_suspend(struct pci_dev
 #endif
 
 	pci_save_state(pci_dev);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		dev->state.disabled = 1;
 	}
@@ -2197,7 +2201,7 @@ static int cx8800_resume(struct pci_dev 
 		pci_enable_device(pci_dev);
 		dev->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
 #if 1
Index: linux-2.6.11/drivers/media/video/cx88/cx88-mpeg.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-mpeg.c	2005-03-07 10:16:04.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-mpeg.c	2005-03-08 10:33:15.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-mpeg.c,v 1.14 2004/10/25 11:26:36 kraxel Exp $
+ * $Id: cx88-mpeg.c,v 1.25 2005/03/07 14:18:00 kraxel Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -24,6 +24,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -68,8 +69,14 @@ static int cx8802_start_dma(struct cx880
 	 * also: move to cx88-blackbird + cx88-dvb source files? */
 
 	if (cx88_boards[core->board].dvb) {
-		/* Setup TS portion of chip */
-		cx_write(TS_GEN_CNTRL, 0x0c);
+		/* negedge driven & software reset */
+		cx_write(TS_GEN_CNTRL, 0x40); 
+		udelay(100);
+		cx_write(MO_PINMUX_IO, 0x00);
+		cx_write(TS_HW_SOP_CNTRL,47<<16|188<<4|0x00);
+		cx_write(TS_SOP_STAT,0x00);
+		cx_write(TS_GEN_CNTRL, dev->ts_gen_cntrl); 
+		udelay(100);
 	}
 
 	if (cx88_boards[core->board].blackbird) {
@@ -93,7 +100,7 @@ static int cx8802_start_dma(struct cx880
 	q->count = 1;
 
 	/* enable irqs */
-	cx_set(MO_PCI_INTMSK, 0x00fc04);
+	cx_set(MO_PCI_INTMSK, core->pci_irqmask | 0x04);
 	cx_write(MO_TS_INTMSK,  0x1f0011);
 
 	/* start dma */
@@ -292,19 +299,18 @@ static irqreturn_t cx8802_irq(int irq, v
 {
 	struct cx8802_dev *dev = dev_id;
 	struct cx88_core *core = dev->core;
-	u32 status, mask;
+	u32 status;
 	int loop, handled = 0;
 
 	for (loop = 0; loop < 10; loop++) {
-		status = cx_read(MO_PCI_INTSTAT) & (~0x1f | 0x04);
-		mask   = cx_read(MO_PCI_INTMSK);
-		if (0 == (status & mask))
+		status = cx_read(MO_PCI_INTSTAT) & (core->pci_irqmask | 0x04);
+		if (0 == status)
 			goto out;
 		handled = 1;
 		cx_write(MO_PCI_INTSTAT, status);
 
-		if (status & mask & ~0x1f)
-			cx88_irq(core,status,mask);
+		if (status & core->pci_irqmask)
+			cx88_core_irq(core,status);
 		if (status & 0x04)
 			cx8802_mpeg_irq(dev);
 	};
@@ -323,6 +329,7 @@ static irqreturn_t cx8802_irq(int irq, v
 
 int cx8802_init_common(struct cx8802_dev *dev)
 {
+	struct cx88_core *core = dev->core;
 	int err;
 
 	/* pci init */
@@ -354,11 +361,6 @@ int cx8802_init_common(struct cx8802_dev
 	cx88_risc_stopper(dev->pci,&dev->mpegq.stopper,
 			  MO_TS_DMACNTRL,0x11,0x00);
 
-#if 0 /* FIXME */
-	/* initialize hardware */
-	cx8802_reset(dev);
-#endif
-
 	/* get irq */
 	err = request_irq(dev->pci->irq, cx8802_irq,
 			  SA_SHIRQ | SA_INTERRUPT, dev->core->name, dev);
@@ -367,11 +369,7 @@ int cx8802_init_common(struct cx8802_dev
 		       dev->core->name, dev->pci->irq);
 		return err;
 	}
-
-#if 0 /* FIXME */
-	/* register i2c bus + load i2c helpers */
-	cx88_card_setup(dev);
-#endif
+	cx_set(MO_PCI_INTMSK, core->pci_irqmask);
 
 	/* everything worked */
 	pci_set_drvdata(dev->pci,dev);
@@ -393,7 +391,7 @@ void cx8802_fini_common(struct cx8802_de
 
 /* ----------------------------------------------------------- */
 
-int cx8802_suspend_common(struct pci_dev *pci_dev, u32 state)
+int cx8802_suspend_common(struct pci_dev *pci_dev, pm_message_t state)
 {
         struct cx8802_dev *dev = pci_get_drvdata(pci_dev);
 	struct cx88_core *core = dev->core;
@@ -413,7 +411,7 @@ int cx8802_suspend_common(struct pci_dev
 #endif
 
 	pci_save_state(pci_dev);
-	if (0 != pci_set_power_state(pci_dev, state)) {
+	if (0 != pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		dev->state.disabled = 1;
 	}
@@ -429,7 +427,7 @@ int cx8802_resume_common(struct pci_dev 
 		pci_enable_device(pci_dev);
 		dev->state.disabled = 0;
 	}
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
 #if 1
Index: linux-2.6.11/drivers/media/video/cx88/cx88-tvaudio.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-tvaudio.c	2005-03-07 10:13:41.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-tvaudio.c	2005-03-08 10:33:20.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-tvaudio.c,v 1.24 2004/10/25 11:51:00 kraxel Exp $
+    $Id: cx88-tvaudio.c,v 1.34 2005/03/07 16:10:51 kraxel Exp $
 
     cx88x-audio.c - Conexant CX23880/23881 audio downstream driver driver
 
@@ -37,6 +37,7 @@
 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -56,7 +57,7 @@
 
 #include "cx88.h"
 
-static unsigned int audio_debug = 1;
+static unsigned int audio_debug = 0;
 module_param(audio_debug,int,0644);
 MODULE_PARM_DESC(audio_debug,"enable debug messages [audio]");
 
@@ -141,6 +142,13 @@ static void set_audio_finish(struct cx88
 {
 	u32 volume;
 
+	if (cx88_boards[core->board].blackbird) {
+		// 'pass-thru mode': this enables the i2s output to the mpeg encoder
+		cx_set(AUD_CTL, 0x2000);
+		cx_write(AUD_I2SOUTPUTCNTL, 1);
+		//cx_write(AUD_APB_IN_RATE_ADJ, 0);
+	}
+
 	// finish programming
 	cx_write(AUD_SOFT_RESET, 0x0000);
 
@@ -263,6 +271,7 @@ static void set_audio_standard_BTSC(stru
 	set_audio_finish(core);
 }
 
+#if 0
 static void set_audio_standard_NICAM(struct cx88_core *core)
 {
 	static const struct rlist nicam_common[] = {
@@ -335,128 +344,243 @@ static void set_audio_standard_NICAM(str
 	};
         set_audio_finish(core);
 }
+#endif
 
-static void set_audio_standard_NICAM_L(struct cx88_core *core)
+static void set_audio_standard_NICAM_L(struct cx88_core *core, int stereo)
 {
-	/* This is officially weird.. register dumps indicate windows
-	 * uses audio mode 4.. A2. Let's operate and find out. */
+        /* This is probably weird..
+         * Let's operate and find out. */
 
-	static const struct rlist nicam_l[] = {
-		// setup QAM registers
-		{ AUD_PDF_DDS_CNST_BYTE2,	   0x48 },
-		{ AUD_PDF_DDS_CNST_BYTE1,          0x3d },
-		{ AUD_PDF_DDS_CNST_BYTE0,          0xf5 },
-		{ AUD_QAM_MODE,                    0x00 },
-		{ AUD_PHACC_FREQ_8MSB,             0x3a },
-		{ AUD_PHACC_FREQ_8LSB,             0x4a },
+        static const struct rlist nicam_l_mono[] = {
+                { AUD_ERRLOGPERIOD_R,     0x00000064 },
+                { AUD_ERRINTRPTTHSHLD1_R, 0x00000FFF },
+                { AUD_ERRINTRPTTHSHLD2_R, 0x0000001F },
+                { AUD_ERRINTRPTTHSHLD3_R, 0x0000000F },
 
-		{ AUD_POLY0_DDS_CONSTANT,          0x000e4db2 },
-		{ AUD_IIR1_0_SEL,                  0x00000000 },
-		{ AUD_IIR1_1_SEL,                  0x00000002 },
-		{ AUD_IIR1_2_SEL,                  0x00000023 },
-		{ AUD_IIR1_3_SEL,                  0x00000004 },
-		{ AUD_IIR1_4_SEL,                  0x00000005 },
-		{ AUD_IIR1_5_SEL,                  0x00000007 },
-		{ AUD_IIR1_0_SHIFT,                0x00000007 },
-		{ AUD_IIR1_1_SHIFT,                0x00000000 },
-		{ AUD_IIR1_2_SHIFT,                0x00000000 },
-		{ AUD_IIR1_3_SHIFT,                0x00000007 },
-		{ AUD_IIR1_4_SHIFT,                0x00000007 },
-		{ AUD_IIR1_5_SHIFT,                0x00000007 },
-		{ AUD_IIR2_0_SEL,                  0x00000002 },
-		{ AUD_IIR2_1_SEL,                  0x00000003 },
-		{ AUD_IIR2_2_SEL,                  0x00000004 },
-		{ AUD_IIR2_3_SEL,                  0x00000005 },
-		{ AUD_IIR3_0_SEL,                  0x00000007 },
-		{ AUD_IIR3_1_SEL,                  0x00000023 },
-		{ AUD_IIR3_2_SEL,                  0x00000016 },
-		{ AUD_IIR4_0_SHIFT,                0x00000000 },
-		{ AUD_IIR4_1_SHIFT,                0x00000000 },
-		{ AUD_IIR3_2_SHIFT,                0x00000002 },
-		{ AUD_IIR4_0_SEL,                  0x0000001d },
-		{ AUD_IIR4_1_SEL,                  0x00000019 },
-		{ AUD_IIR4_2_SEL,                  0x00000008 },
-		{ AUD_IIR4_0_SHIFT,                0x00000000 },
-		{ AUD_IIR4_1_SHIFT,                0x00000007 },
-		{ AUD_IIR4_2_SHIFT,                0x00000007 },
-		{ AUD_IIR4_0_CA0,                  0x0003e57e },
-		{ AUD_IIR4_0_CA1,                  0x00005e11 },
-		{ AUD_IIR4_0_CA2,                  0x0003a7cf },
-		{ AUD_IIR4_0_CB0,                  0x00002368 },
-		{ AUD_IIR4_0_CB1,                  0x0003bf1b },
-		{ AUD_IIR4_1_CA0,                  0x00006349 },
-		{ AUD_IIR4_1_CA1,                  0x00006f27 },
-		{ AUD_IIR4_1_CA2,                  0x0000e7a3 },
-		{ AUD_IIR4_1_CB0,                  0x00005653 },
-		{ AUD_IIR4_1_CB1,                  0x0000cf97 },
-		{ AUD_IIR4_2_CA0,                  0x00006349 },
-		{ AUD_IIR4_2_CA1,                  0x00006f27 },
-		{ AUD_IIR4_2_CA2,                  0x0000e7a3 },
-		{ AUD_IIR4_2_CB0,                  0x00005653 },
-		{ AUD_IIR4_2_CB1,                  0x0000cf97 },
-		{ AUD_HP_MD_IIR4_1,                0x00000001 },
-		{ AUD_HP_PROG_IIR4_1,              0x0000001a },
-		{ AUD_DN0_FREQ,                    0x00000000 },
-		{ AUD_DN1_FREQ,                    0x00003318 },
-		{ AUD_DN1_SRC_SEL,                 0x00000017 },
-		{ AUD_DN1_SHFT,                    0x00000007 },
-		{ AUD_DN1_AFC,                     0x00000000 },
-		{ AUD_DN1_FREQ_SHIFT,              0x00000000 },
-		{ AUD_DN2_FREQ,                    0x00003551 },
-		{ AUD_DN2_SRC_SEL,                 0x00000001 },
-		{ AUD_DN2_SHFT,                    0x00000000 },
-		{ AUD_DN2_AFC,                     0x00000002 },
-		{ AUD_DN2_FREQ_SHIFT,              0x00000000 },
-		{ AUD_PDET_SRC,                    0x00000014 },
-		{ AUD_PDET_SHIFT,                  0x00000000 },
-		{ AUD_DEEMPH0_SRC_SEL,             0x00000011 },
-		{ AUD_DEEMPH1_SRC_SEL,             0x00000011 },
-		{ AUD_DEEMPH0_SHIFT,               0x00000000 },
-		{ AUD_DEEMPH1_SHIFT,               0x00000000 },
-		{ AUD_DEEMPH0_G0,                  0x00007000 },
-		{ AUD_DEEMPH0_A0,                  0x00000000 },
-		{ AUD_DEEMPH0_B0,                  0x00000000 },
-		{ AUD_DEEMPH0_A1,                  0x00000000 },
-		{ AUD_DEEMPH0_B1,                  0x00000000 },
-		{ AUD_DEEMPH1_G0,                  0x00007000 },
-		{ AUD_DEEMPH1_A0,                  0x00000000 },
-		{ AUD_DEEMPH1_B0,                  0x00000000 },
-		{ AUD_DEEMPH1_A1,                  0x00000000 },
-		{ AUD_DEEMPH1_B1,                  0x00000000 },
-		{ AUD_DMD_RA_DDS,                  0x00f5c285 },
-		{ AUD_RATE_ADJ1,                   0x00000100 },
-		{ AUD_RATE_ADJ2,                   0x00000200 },
-		{ AUD_RATE_ADJ3,                   0x00000300 },
-		{ AUD_RATE_ADJ4,                   0x00000400 },
-		{ AUD_RATE_ADJ5,                   0x00000500 },
-		{ AUD_C2_UP_THR,                   0x00005400 },
-		{ AUD_C2_LO_THR,                   0x00003000 },
-		{ AUD_C1_UP_THR,                   0x00007000 },
-		{ AUD_C2_LO_THR,                   0x00005400 },
-		{ AUD_CTL,                         0x0000100c },
-		{ AUD_DCOC_0_SRC,                  0x00000021 },
-		{ AUD_DCOC_1_SRC,                  0x00000003 },
-		{ AUD_DCOC1_SHIFT,                 0x00000000 },
-		{ AUD_DCOC_1_SHIFT_IN0,            0x0000000a },
-		{ AUD_DCOC_1_SHIFT_IN1,            0x00000008 },
-		{ AUD_DCOC_PASS_IN,                0x00000000 },
-		{ AUD_DCOC_2_SRC,                  0x0000001b },
-		{ AUD_IIR4_0_SEL,                  0x0000001d },
-		{ AUD_POLY0_DDS_CONSTANT,          0x000e4db2 },
-		{ AUD_PHASE_FIX_CTL,               0x00000000 },
-		{ AUD_CORDIC_SHIFT_1,              0x00000007 },
-		{ AUD_PLL_EN,                      0x00000000 },
-		{ AUD_PLL_PRESCALE,                0x00000002 },
-		{ AUD_PLL_INT,                     0x0000001e },
-		{ AUD_OUT1_SHIFT,                  0x00000000 },
+                { AUD_PDF_DDS_CNST_BYTE2, 0x48 },
+                { AUD_PDF_DDS_CNST_BYTE1, 0x3D },
+                { AUD_QAM_MODE,           0x00 },
+                { AUD_PDF_DDS_CNST_BYTE0, 0xf5 },
+                { AUD_PHACC_FREQ_8MSB,    0x3a },
+                { AUD_PHACC_FREQ_8LSB,    0x4a },
 
-		{ /* end of list */ },
-	};
+                { AUD_DEEMPHGAIN_R, 0x6680 },
+                { AUD_DEEMPHNUMER1_R, 0x353DE },
+                { AUD_DEEMPHNUMER2_R, 0x1B1 },
+                { AUD_DEEMPHDENOM1_R, 0x0F3D0 },
+                { AUD_DEEMPHDENOM2_R, 0x0 },
+                { AUD_FM_MODE_ENABLE, 0x7 },
+                { AUD_POLYPH80SCALEFAC, 0x3 },
+                { AUD_AFE_12DB_EN, 0x1 },
+                { AAGC_GAIN, 0x0 },
+                { AAGC_HYST, 0x18 },
+                { AAGC_DEF, 0x20 },
+                { AUD_DN0_FREQ, 0x0 },
+                { AUD_POLY0_DDS_CONSTANT, 0x0E4DB2 },
+                { AUD_DCOC_0_SRC, 0x21 },
+                { AUD_IIR1_0_SEL, 0x0 },
+                { AUD_IIR1_0_SHIFT, 0x7 },
+                { AUD_IIR1_1_SEL, 0x2 },
+                { AUD_IIR1_1_SHIFT, 0x0 },
+                { AUD_DCOC_1_SRC, 0x3 },
+                { AUD_DCOC1_SHIFT, 0x0 },
+                { AUD_DCOC_PASS_IN, 0x0 },
+                { AUD_IIR1_2_SEL, 0x23 },
+                { AUD_IIR1_2_SHIFT, 0x0 },
+                { AUD_IIR1_3_SEL, 0x4 },
+                { AUD_IIR1_3_SHIFT, 0x7 },
+                { AUD_IIR1_4_SEL, 0x5 },
+                { AUD_IIR1_4_SHIFT, 0x7 },
+                { AUD_IIR3_0_SEL, 0x7 },
+                { AUD_IIR3_0_SHIFT, 0x0 },
+                { AUD_DEEMPH0_SRC_SEL, 0x11 },
+                { AUD_DEEMPH0_SHIFT, 0x0 },
+                { AUD_DEEMPH0_G0, 0x7000 },
+                { AUD_DEEMPH0_A0, 0x0 },
+                { AUD_DEEMPH0_B0, 0x0 },
+                { AUD_DEEMPH0_A1, 0x0 },
+                { AUD_DEEMPH0_B1, 0x0 },
+                { AUD_DEEMPH1_SRC_SEL, 0x11 },
+                { AUD_DEEMPH1_SHIFT, 0x0 },
+                { AUD_DEEMPH1_G0, 0x7000 },
+                { AUD_DEEMPH1_A0, 0x0 },
+                { AUD_DEEMPH1_B0, 0x0 },
+                { AUD_DEEMPH1_A1, 0x0 },
+                { AUD_DEEMPH1_B1, 0x0 },
+                { AUD_OUT0_SEL, 0x3F },
+                { AUD_OUT1_SEL, 0x3F },
+                { AUD_DMD_RA_DDS, 0x0F5C285 },
+                { AUD_PLL_INT, 0x1E },
+                { AUD_PLL_DDS, 0x0 },
+                { AUD_PLL_FRAC, 0x0E542 },
 
-	dprintk("%s (status: unknown)\n",__FUNCTION__);
-        set_audio_start(core, 0x0004,
-			0 /* FIXME */);
-	set_audio_registers(core, nicam_l);
+                // setup QAM registers
+                { AUD_RATE_ADJ1,      0x00000100 },
+                { AUD_RATE_ADJ2,      0x00000200 },
+                { AUD_RATE_ADJ3,      0x00000300 },
+                { AUD_RATE_ADJ4,      0x00000400 },
+                { AUD_RATE_ADJ5,      0x00000500 },
+                { AUD_RATE_THRES_DMD, 0x000000C0 },
+                { /* end of list */ },
+        };
+
+        static const struct rlist nicam_l[] = {
+                // setup QAM registers
+                { AUD_RATE_ADJ1, 0x00000060 },
+                { AUD_RATE_ADJ2, 0x000000F9 },
+                { AUD_RATE_ADJ3, 0x000001CC },
+                { AUD_RATE_ADJ4, 0x000002B3 },
+                { AUD_RATE_ADJ5, 0x00000726 },
+                { AUD_DEEMPHDENOM1_R, 0x0000F3D0 },
+                { AUD_DEEMPHDENOM2_R, 0x00000000 },
+                { AUD_ERRLOGPERIOD_R, 0x00000064 },
+                { AUD_ERRINTRPTTHSHLD1_R, 0x00000FFF },
+                { AUD_ERRINTRPTTHSHLD2_R, 0x0000001F },
+                { AUD_ERRINTRPTTHSHLD3_R, 0x0000000F },
+                { AUD_POLYPH80SCALEFAC, 0x00000003 },
+                { AUD_DMD_RA_DDS, 0x00C00000 },
+                { AUD_PLL_INT, 0x0000001E },
+                { AUD_PLL_DDS, 0x00000000 },
+                { AUD_PLL_FRAC, 0x0000E542 },
+                { AUD_START_TIMER, 0x00000000 },
+                { AUD_DEEMPHNUMER1_R, 0x000353DE },
+                { AUD_DEEMPHNUMER2_R, 0x000001B1 },
+                { AUD_PDF_DDS_CNST_BYTE2, 0x06 },
+                { AUD_PDF_DDS_CNST_BYTE1, 0x82 },
+                { AUD_QAM_MODE, 0x05 },
+                { AUD_PDF_DDS_CNST_BYTE0, 0x12 },
+                { AUD_PHACC_FREQ_8MSB, 0x34 },
+                { AUD_PHACC_FREQ_8LSB, 0x4C },
+                { AUD_DEEMPHGAIN_R, 0x00006680 },
+                { AUD_RATE_THRES_DMD, 0x000000C0  },
+                { /* end of list */ },
+        } ;
+        dprintk("%s (status: devel), stereo : %d\n",__FUNCTION__,stereo);
+
+        if (!stereo) {
+		/* AM mono sound */
+                set_audio_start(core, 0x0004,
+				0x100c /* FIXME again */);
+                set_audio_registers(core, nicam_l_mono);
+        } else {
+                set_audio_start(core, 0x0010,
+				0x1924 /* FIXME again */);
+                set_audio_registers(core, nicam_l);
+        }
+        set_audio_finish(core);
+
+}
+
+static void set_audio_standard_PAL_I(struct cx88_core *core, int stereo)
+{
+       static const struct rlist pal_i_fm_mono[] = {
+            {AUD_ERRLOGPERIOD_R,       0x00000064},
+            {AUD_ERRINTRPTTHSHLD1_R,   0x00000fff},
+            {AUD_ERRINTRPTTHSHLD2_R,   0x0000001f},
+            {AUD_ERRINTRPTTHSHLD3_R,   0x0000000f},
+            {AUD_PDF_DDS_CNST_BYTE2,   0x06},
+            {AUD_PDF_DDS_CNST_BYTE1,   0x82},
+            {AUD_PDF_DDS_CNST_BYTE0,   0x12},
+            {AUD_QAM_MODE,             0x05},
+            {AUD_PHACC_FREQ_8MSB,      0x3a},
+            {AUD_PHACC_FREQ_8LSB,      0x93},
+            {AUD_DMD_RA_DDS,           0x002a4f2f},
+            {AUD_PLL_INT,              0x0000001e},
+            {AUD_PLL_DDS,              0x00000004},
+            {AUD_PLL_FRAC,             0x0000e542},
+            {AUD_RATE_ADJ1,            0x00000100},
+            {AUD_RATE_ADJ2,            0x00000200},
+            {AUD_RATE_ADJ3,            0x00000300},
+            {AUD_RATE_ADJ4,            0x00000400},
+            {AUD_RATE_ADJ5,            0x00000500},
+            {AUD_THR_FR,               0x00000000},
+            {AUD_PILOT_BQD_1_K0,       0x0000755b},
+            {AUD_PILOT_BQD_1_K1,       0x00551340},
+            {AUD_PILOT_BQD_1_K2,       0x006d30be},
+            {AUD_PILOT_BQD_1_K3,       0xffd394af},
+            {AUD_PILOT_BQD_1_K4,       0x00400000},
+            {AUD_PILOT_BQD_2_K0,       0x00040000},
+            {AUD_PILOT_BQD_2_K1,       0x002a4841},
+            {AUD_PILOT_BQD_2_K2,       0x00400000},
+            {AUD_PILOT_BQD_2_K3,       0x00000000},
+            {AUD_PILOT_BQD_2_K4,       0x00000000},
+            {AUD_MODE_CHG_TIMER,       0x00000060},
+            {AUD_AFE_12DB_EN,          0x00000001},
+            {AAGC_HYST,                0x0000000a},
+            {AUD_CORDIC_SHIFT_0,       0x00000007},
+            {AUD_CORDIC_SHIFT_1,       0x00000007},
+            {AUD_C1_UP_THR,            0x00007000},
+            {AUD_C1_LO_THR,            0x00005400},
+            {AUD_C2_UP_THR,            0x00005400},
+            {AUD_C2_LO_THR,            0x00003000},
+            {AUD_DCOC_0_SRC,           0x0000001a},
+            {AUD_DCOC0_SHIFT,          0x00000000},
+            {AUD_DCOC_0_SHIFT_IN0,     0x0000000a},
+            {AUD_DCOC_0_SHIFT_IN1,     0x00000008},
+            {AUD_DCOC_PASS_IN,         0x00000003},
+            {AUD_IIR3_0_SEL,           0x00000021},
+            {AUD_DN2_AFC,              0x00000002},
+            {AUD_DCOC_1_SRC,           0x0000001b},
+            {AUD_DCOC1_SHIFT,          0x00000000},
+            {AUD_DCOC_1_SHIFT_IN0,     0x0000000a},
+            {AUD_DCOC_1_SHIFT_IN1,     0x00000008},
+            {AUD_IIR3_1_SEL,           0x00000023},
+            {AUD_DN0_FREQ,             0x000035a3},
+            {AUD_DN2_FREQ,             0x000029c7},
+            {AUD_CRDC0_SRC_SEL,        0x00000511},
+            {AUD_IIR1_0_SEL,           0x00000001},
+            {AUD_IIR1_1_SEL,           0x00000000},
+            {AUD_IIR3_2_SEL,           0x00000003},
+            {AUD_IIR3_2_SHIFT,         0x00000000},
+            {AUD_IIR3_0_SEL,           0x00000002},
+            {AUD_IIR2_0_SEL,           0x00000021},
+            {AUD_IIR2_0_SHIFT,         0x00000002},
+            {AUD_DEEMPH0_SRC_SEL,      0x0000000b},
+            {AUD_DEEMPH1_SRC_SEL,      0x0000000b},
+            {AUD_POLYPH80SCALEFAC,     0x00000001},
+            {AUD_START_TIMER,          0x00000000},
+            { /* end of list */ },
+       };
+
+       static const struct rlist pal_i_nicam[] = {
+           { AUD_RATE_ADJ1,           0x00000010 },
+           { AUD_RATE_ADJ2,           0x00000040 },
+           { AUD_RATE_ADJ3,           0x00000100 },
+           { AUD_RATE_ADJ4,           0x00000400 },
+           { AUD_RATE_ADJ5,           0x00001000 },
+	   //     { AUD_DMD_RA_DDS,          0x00c0d5ce },
+	   { AUD_DEEMPHGAIN_R,        0x000023c2 },
+	   { AUD_DEEMPHNUMER1_R,      0x0002a7bc },
+	   { AUD_DEEMPHNUMER2_R,      0x0003023e },
+	   { AUD_DEEMPHDENOM1_R,      0x0000f3d0 },
+	   { AUD_DEEMPHDENOM2_R,      0x00000000 },
+	   { AUD_DEEMPHDENOM2_R,      0x00000000 },
+	   { AUD_ERRLOGPERIOD_R,      0x00000fff },
+	   { AUD_ERRINTRPTTHSHLD1_R,  0x000003ff },
+	   { AUD_ERRINTRPTTHSHLD2_R,  0x000000ff },
+	   { AUD_ERRINTRPTTHSHLD3_R,  0x0000003f },
+	   { AUD_POLYPH80SCALEFAC,    0x00000003 },
+	   { AUD_PDF_DDS_CNST_BYTE2,  0x06 },
+	   { AUD_PDF_DDS_CNST_BYTE1,  0x82 },
+	   { AUD_PDF_DDS_CNST_BYTE0,  0x16 },
+	   { AUD_QAM_MODE,            0x05 },
+	   { AUD_PDF_DDS_CNST_BYTE0,  0x12 },
+	   { AUD_PHACC_FREQ_8MSB,     0x3a },
+	   { AUD_PHACC_FREQ_8LSB,     0x93 },
+            { /* end of list */ },
+        };
+
+        dprintk("%s (status: devel), stereo : %d\n",__FUNCTION__,stereo);
+
+        if (!stereo) {
+		// FM mono
+		set_audio_start(core, 0x0004, EN_DMTRX_SUMDIFF | EN_A2_FORCE_MONO1);
+		set_audio_registers(core, pal_i_fm_mono);
+        } else {
+		// Nicam Stereo
+		set_audio_start(core, 0x0010, EN_DMTRX_LR | EN_DMTRX_BYPASS | EN_NICAM_AUTO_STEREO);
+		set_audio_registers(core, pal_i_nicam);
+        }
         set_audio_finish(core);
 }
 
@@ -553,13 +677,6 @@ static void set_audio_standard_A2(struct
 	set_audio_start(core, 0x0004, EN_DMTRX_SUMDIFF | EN_A2_AUTO_STEREO);
 	set_audio_registers(core, a2_common);
 	switch (core->tvaudio) {
-	case WW_NICAM_I:
-		/* gives at least mono according to the dscaler guys */
-		/* so use use that while nicam is broken ...         */
-		dprintk("%s PAL-I mono (status: unknown)\n",__FUNCTION__);
-		set_audio_registers(core, a2_table1);
-		cx_write(AUD_CTL, EN_A2_FORCE_MONO1);
-		break;
 	case WW_A2_BG:
 		dprintk("%s PAL-BG A2 (status: known-good)\n",__FUNCTION__);
 		set_audio_registers(core, a2_table1);
@@ -646,11 +763,12 @@ void cx88_set_tvaudio(struct cx88_core *
 	case WW_BTSC:
 		set_audio_standard_BTSC(core,0);
 		break;
-	// case WW_NICAM_I:
 	case WW_NICAM_BGDKL:
-		set_audio_standard_NICAM(core);
+		set_audio_standard_NICAM_L(core,0);
 		break;
 	case WW_NICAM_I:
+		set_audio_standard_PAL_I(core,0);
+		break;
 	case WW_A2_BG:
 	case WW_A2_DK:
 	case WW_A2_M:
@@ -663,7 +781,7 @@ void cx88_set_tvaudio(struct cx88_core *
 		set_audio_standard_FM(core);
 		break;
 	case WW_SYSTEM_L_AM:
-		set_audio_standard_NICAM_L(core);
+		set_audio_standard_NICAM_L(core, 1);
 		break;
 	case WW_NONE:
 	default:
@@ -674,6 +792,19 @@ void cx88_set_tvaudio(struct cx88_core *
 	return;
 }
 
+void cx88_newstation(struct cx88_core *core)
+{
+	core->audiomode_manual = UNSET;
+	
+	switch (core->tvaudio) {
+	case WW_SYSTEM_L_AM:
+		/* try nicam ... */
+		core->audiomode_current = V4L2_TUNER_MODE_STEREO;
+		set_audio_standard_NICAM_L(core, 1);
+		break;
+	}
+}
+
 void cx88_get_stereo(struct cx88_core *core, struct v4l2_tuner *t)
 {
 	static char *m[] = {"stereo", "dual mono", "mono", "sap"};
@@ -721,22 +852,37 @@ void cx88_get_stereo(struct cx88_core *c
 		}
 		break;
 	case WW_NICAM_BGDKL:
-		if (0 == mode)
+		if (0 == mode) {
 			t->audmode = V4L2_TUNER_MODE_STEREO;
+			t->rxsubchans |= V4L2_TUNER_SUB_STEREO;
+		}
 		break;
+        case WW_SYSTEM_L_AM:
+                if (0x0 == mode && !(cx_read(AUD_INIT) & 0x04)) {
+                        t->audmode = V4L2_TUNER_MODE_STEREO;
+			t->rxsubchans |= V4L2_TUNER_SUB_STEREO;
+		}
+                break ;
 	default:
-		t->rxsubchans = V4L2_TUNER_SUB_MONO;
-		t->audmode    = V4L2_TUNER_MODE_MONO;
+		/* nothing */
 		break;
 	}
 	return;
 }
 
-void cx88_set_stereo(struct cx88_core *core, u32 mode)
+void cx88_set_stereo(struct cx88_core *core, u32 mode, int manual)
 {
 	u32 ctl  = UNSET;
 	u32 mask = UNSET;
 
+	if (manual) {
+		core->audiomode_manual = mode;
+	} else {
+		if (UNSET != core->audiomode_manual)
+			return;
+	}
+	core->audiomode_current = mode;
+
 	switch (core->tvaudio) {
 	case WW_BTSC:
 		switch (mode) {
@@ -789,6 +935,28 @@ void cx88_set_stereo(struct cx88_core *c
 			break;
 		}
 		break;
+	case WW_SYSTEM_L_AM:
+		switch (mode) {
+		case V4L2_TUNER_MODE_MONO:
+		case V4L2_TUNER_MODE_LANG1:  /* FIXME */
+			set_audio_standard_NICAM_L(core, 0);
+			break;
+		case V4L2_TUNER_MODE_STEREO:
+			set_audio_standard_NICAM_L(core, 1);
+			break;
+		}
+		break;
+	case WW_NICAM_I:
+		switch (mode) {
+		case V4L2_TUNER_MODE_MONO:
+		case V4L2_TUNER_MODE_LANG1:
+			set_audio_standard_PAL_I(core, 0);
+			break;
+		case V4L2_TUNER_MODE_STEREO:
+			set_audio_standard_PAL_I(core, 1);
+			break;
+		}
+		break;
 	case WW_FM:
 		switch (mode) {
 		case V4L2_TUNER_MODE_MONO:
@@ -804,13 +972,11 @@ void cx88_set_stereo(struct cx88_core *c
 	}
 
 	if (UNSET != ctl) {
-		cx_write(AUD_SOFT_RESET, 0x0001);
-		cx_andor(AUD_CTL, mask,  ctl);
-		cx_write(AUD_SOFT_RESET, 0x0000);
 		dprintk("cx88_set_stereo: mask 0x%x, ctl 0x%x "
 			"[status=0x%x,ctl=0x%x,vol=0x%x]\n",
 			mask, ctl, cx_read(AUD_STATUS),
 			cx_read(AUD_CTL), cx_sread(SHADOW_AUD_VOL_CTL));
+		cx_andor(AUD_CTL, mask, ctl);
 	}
 	return;
 }
@@ -819,16 +985,32 @@ int cx88_audio_thread(void *data)
 {
 	struct cx88_core *core = data;
 	struct v4l2_tuner t;
+	u32 mode = 0;
 
 	dprintk("cx88: tvaudio thread started\n");
 	for (;;) {
+		msleep_interruptible(1000);
 		if (kthread_should_stop())
 			break;
 
 		/* just monitor the audio status for now ... */
 		memset(&t,0,sizeof(t));
 		cx88_get_stereo(core,&t);
-		msleep_interruptible(1000);
+
+		if (UNSET != core->audiomode_manual)
+			/* manually set, don't do anything. */
+			continue;
+
+		/* monitor signal */
+		if (t.rxsubchans & V4L2_TUNER_SUB_STEREO)
+			mode = V4L2_TUNER_MODE_STEREO;
+		else
+			mode = V4L2_TUNER_MODE_MONO;
+		if (mode == core->audiomode_current)
+			continue;
+
+		/* automatically switch to best available mode */
+		cx88_set_stereo(core, mode, 0);
 	}
 
 	dprintk("cx88: tvaudio thread exiting\n");
@@ -838,6 +1020,7 @@ int cx88_audio_thread(void *data)
 /* ----------------------------------------------------------- */
 
 EXPORT_SYMBOL(cx88_set_tvaudio);
+EXPORT_SYMBOL(cx88_newstation);
 EXPORT_SYMBOL(cx88_set_stereo);
 EXPORT_SYMBOL(cx88_get_stereo);
 EXPORT_SYMBOL(cx88_audio_thread);
Index: linux-2.6.11/drivers/media/video/cx88/cx88-dvb.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-dvb.c	2005-03-08 10:33:15.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-dvb.c	2005-03-08 10:33:20.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.19 2004/11/07 14:44:59 kraxel Exp $
+ * $Id: cx88-dvb.c,v 1.31 2005/03/07 15:58:05 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -30,10 +30,20 @@
 #include <linux/file.h>
 #include <linux/suspend.h>
 
+/* those two frontends need merging via linuxtv cvs ... */
+#define HAVE_CX22702 0
+#define HAVE_OR51132 0
+
 #include "cx88.h"
-#include "cx22702.h"
+#include "dvb-pll.h"
 #include "mt352.h"
-#include "mt352_priv.h" /* FIXME */
+#include "mt352_priv.h"
+#if HAVE_CX22702
+# include "cx22702.h"
+#endif
+#if HAVE_OR51132
+# include "or51132.h"
+#endif
 
 MODULE_DESCRIPTION("driver for cx2388x based DVB cards");
 MODULE_AUTHOR("Chris Pascoe <c.pascoe@itee.uq.edu.au>");
@@ -110,111 +120,144 @@ static int dvico_fusionhdtv_demod_init(s
 	return 0;
 }
 
-#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
-
-static int lg_z201_pll_set(struct dvb_frontend* fe,
-			   struct dvb_frontend_parameters* params, u8* pllbuf)
+static int dntv_live_dvbt_demod_init(struct dvb_frontend* fe)
 {
-	u32 div;
-	unsigned char cp = 0;
-	unsigned char bs = 0;
-
-	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
-
-	if (params->frequency < 542000000) cp = 0xbc;
-	else if (params->frequency < 830000000) cp = 0xf4;
-	else cp = 0xfc;
+	static u8 clock_config []  = { 0x89, 0x38, 0x39 };
+	static u8 reset []         = { 0x50, 0x80 };
+	static u8 adc_ctl_1_cfg [] = { 0x8E, 0x40 };
+	static u8 agc_cfg []       = { 0x67, 0x10, 0x23, 0x00, 0xFF, 0xFF,
+	                               0x00, 0xFF, 0x00, 0x40, 0x40 };
+	static u8 dntv_extra[]     = { 0xB5, 0x7A };
+	static u8 capt_range_cfg[] = { 0x75, 0x32 };
 
-	if (params->frequency == 0) bs = 0x03;
-	else if (params->frequency < 157500000) bs = 0x01;
-	else if (params->frequency < 443250000) bs = 0x02;
-	else bs = 0x04;
+	mt352_write(fe, clock_config,   sizeof(clock_config));
+	udelay(2000);
+	mt352_write(fe, reset,          sizeof(reset));
+	mt352_write(fe, adc_ctl_1_cfg,  sizeof(adc_ctl_1_cfg));
 
-	pllbuf[0] = 0xC2; /* Note: non-linux standard PLL I2C address */
-	pllbuf[1] = div >> 8;
-	pllbuf[2] = div & 0xff;
-	pllbuf[3] = cp;
-	pllbuf[4] = bs;
+	mt352_write(fe, agc_cfg,        sizeof(agc_cfg));
+	udelay(2000);
+	mt352_write(fe, dntv_extra,     sizeof(dntv_extra));
+	mt352_write(fe, capt_range_cfg, sizeof(capt_range_cfg));
 
 	return 0;
 }
 
-static int thomson_dtt7579_pll_set(struct dvb_frontend* fe,
-				   struct dvb_frontend_parameters* params,
-				   u8* pllbuf)
+static int mt352_pll_set(struct dvb_frontend* fe,
+			 struct dvb_frontend_parameters* params,
+			 u8* pllbuf)
 {
-	u32 div;
-	unsigned char cp = 0;
-	unsigned char bs = 0;
-
-	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
-
-	if (params->frequency < 542000000) cp = 0xb4;
-	else if (params->frequency < 771000000) cp = 0xbc;
-	else cp = 0xf4;
-
-        if (params->frequency == 0) bs = 0x03;
-	else if (params->frequency < 443250000) bs = 0x02;
-	else bs = 0x08;
-
-	pllbuf[0] = 0xc0; // Note: non-linux standard PLL i2c address
-	pllbuf[1] = div >> 8;
-   	pllbuf[2] = div & 0xff;
-   	pllbuf[3] = cp;
-   	pllbuf[4] = bs;
+	struct cx8802_dev *dev= fe->dvb->priv;
 
+	pllbuf[0] = dev->core->pll_addr << 1;
+	dvb_pll_configure(dev->core->pll_desc, pllbuf+1,
+			  params->frequency,
+			  params->u.ofdm.bandwidth);
 	return 0;
 }
 
-struct mt352_config dvico_fusionhdtv_dvbt1 = {
+static struct mt352_config dvico_fusionhdtv = {
 	.demod_address = 0x0F,
 	.demod_init    = dvico_fusionhdtv_demod_init,
-	.pll_set       = lg_z201_pll_set,
+	.pll_set       = mt352_pll_set,
 };
 
-struct mt352_config dvico_fusionhdtv_dvbt_plus = {
-	.demod_address = 0x0F,
-	.demod_init    = dvico_fusionhdtv_demod_init,
-	.pll_set       = thomson_dtt7579_pll_set,
+static struct mt352_config dntv_live_dvbt_config = {
+	.demod_address = 0x0f,
+	.demod_init    = dntv_live_dvbt_demod_init,
+	.pll_set       = mt352_pll_set,
+};
+
+#if HAVE_CX22702
+static struct cx22702_config connexant_refboard_config = {
+	.demod_address = 0x43,
+	.pll_address   = 0x60,
+	.pll_desc      = &dvb_pll_thomson_dtt7579,
+};
+
+static struct cx22702_config hauppauge_novat_config = {
+	.demod_address = 0x43,
+	.pll_address   = 0x61,
+	.pll_desc      = &dvb_pll_thomson_dtt759x,
+};
+#endif
+
+#if HAVE_OR51132
+static int or51132_set_ts_param(struct dvb_frontend* fe, 
+				int is_punctured)
+{
+	struct cx8802_dev *dev= fe->dvb->priv;
+	dev->ts_gen_cntrl = is_punctured ? 0x04 : 0x00;
+	return 0;
+}
+
+struct or51132_config pchdtv_hd3000 = {
+	.demod_address    = 0x15,
+	.pll_address      = 0x61,
+	.pll_desc         = &dvb_pll_thomson_dtt7610,
+	.set_ts_params    = or51132_set_ts_param,
 };
+#endif
 
 static int dvb_register(struct cx8802_dev *dev)
 {
 	/* init struct videobuf_dvb */
 	dev->dvb.name = dev->core->name;
+	dev->ts_gen_cntrl = 0x0c;
 
 	/* init frontend */
 	switch (dev->core->board) {
+#if HAVE_CX22702
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
+		dev->dvb.frontend = cx22702_attach(&hauppauge_novat_config,
+						   &dev->core->i2c_adap);
+		break;
 	case CX88_BOARD_CONEXANT_DVB_T1:
-		dev->dvb.frontend = cx22702_create(&dev->core->i2c_adap,
-						   dev->core->pll_addr,
-						   dev->core->pll_type,
-						   dev->core->demod_addr);
+		dev->dvb.frontend = cx22702_attach(&connexant_refboard_config,
+						   &dev->core->i2c_adap);
 		break;
+#endif
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
-		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv_dvbt1,
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_lg_z201;
+		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv,
 						 &dev->core->i2c_adap);
-		if (dev->dvb.frontend) {
-			dev->dvb.frontend->ops->info.frequency_min = 174000000;
-			dev->dvb.frontend->ops->info.frequency_max = 862000000;
-		}
 		break;
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
-		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv_dvbt_plus,
+		dev->core->pll_addr = 0x60;
+		dev->core->pll_desc = &dvb_pll_thomson_dtt7579;
+		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv,
+						 &dev->core->i2c_adap);
+		break;
+	case CX88_BOARD_KWORLD_DVB_T:
+	case CX88_BOARD_DNTV_LIVE_DVB_T:
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_unknown_1;
+		dev->dvb.frontend = mt352_attach(&dntv_live_dvbt_config,
 						 &dev->core->i2c_adap);
-		if (dev->dvb.frontend) {
-			dev->dvb.frontend->ops->info.frequency_min = 174000000;
-			dev->dvb.frontend->ops->info.frequency_max = 862000000;
-		}
 		break;
+#if HAVE_OR51132
+	case CX88_BOARD_PCHDTV_HD3000:
+		dev->dvb.frontend = or51132_attach(&pchdtv_hd3000,
+						 &dev->core->i2c_adap);
+		break;
+#endif
 	default:
-		printk("%s: FIXME: frontend handling not here yet ...\n",
-		       dev->core->name);
+		printk("%s: The frontend of your DVB/ATSC card isn't supported yet\n"
+		       "%s: you might want to look out for patches here:\n"
+		       "%s:     http://dl.bytesex.org/patches/\n",
+		       dev->core->name, dev->core->name, dev->core->name);
 		break;
 	}
-	if (NULL == dev->dvb.frontend)
+	if (NULL == dev->dvb.frontend) {
+		printk("%s: frontend initialization failed\n",dev->core->name);
 		return -1;
+	}
+
+	if (dev->core->pll_desc) {
+		dev->dvb.frontend->ops->info.frequency_min = dev->core->pll_desc->min;
+		dev->dvb.frontend->ops->info.frequency_max = dev->core->pll_desc->max;
+	}
 
 	/* Copy the board name into the DVB structure */
 	strlcpy(dev->dvb.frontend->ops->info.name,
@@ -222,7 +265,7 @@ static int dvb_register(struct cx8802_de
 		sizeof(dev->dvb.frontend->ops->info.name));
 
 	/* register everything */
-	return videobuf_dvb_register(&dev->dvb);
+	return videobuf_dvb_register(&dev->dvb, THIS_MODULE, dev);
 }
 
 /* ----------------------------------------------------------- */
Index: linux-2.6.11/drivers/media/video/cx88/cx88-input.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/drivers/media/video/cx88/cx88-input.c	2005-03-08 10:33:15.000000000 +0100
@@ -0,0 +1,396 @@
+/*
+ * $Id: cx88-input.c,v 1.9 2005/03/04 09:12:23 kraxel Exp $
+ *
+ * Device driver for GPIO attached remote control interfaces
+ * on Conexant 2388x based TV/DVB cards.
+ *
+ * Copyright (c) 2003 Pavel Machek
+ * Copyright (c) 2004 Gerd Knorr
+ * Copyright (c) 2004 Chris Pascoe
+ *
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
+ */
+
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <media/ir-common.h>
+
+#include "cx88.h"
+
+/* ---------------------------------------------------------------------- */
+
+/* DigitalNow DNTV Live DVB-T Remote */
+static IR_KEYTAB_TYPE ir_codes_dntv_live_dvb_t[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_ESC,         // 'go up a level?'
+	[ 0x01 ] = KEY_KP1,         // '1'
+	[ 0x02 ] = KEY_KP2,         // '2'
+	[ 0x03 ] = KEY_KP3,         // '3'
+	[ 0x04 ] = KEY_KP4,         // '4'
+	[ 0x05 ] = KEY_KP5,         // '5'
+	[ 0x06 ] = KEY_KP6,         // '6'
+	[ 0x07 ] = KEY_KP7,         // '7'
+	[ 0x08 ] = KEY_KP8,         // '8'
+	[ 0x09 ] = KEY_KP9,         // '9'
+	[ 0x0a ] = KEY_KP0,         // '0'
+	[ 0x0b ] = KEY_TUNER,       // 'tv/fm'
+	[ 0x0c ] = KEY_SEARCH,      // 'scan'
+	[ 0x0d ] = KEY_STOP,        // 'stop'
+	[ 0x0e ] = KEY_PAUSE,       // 'pause'
+	[ 0x0f ] = KEY_LIST,        // 'source'
+
+	[ 0x10 ] = KEY_MUTE,        // 'mute'
+	[ 0x11 ] = KEY_REWIND,      // 'backward <<'
+	[ 0x12 ] = KEY_POWER,       // 'power'
+	[ 0x13 ] = KEY_S,           // 'snap'
+	[ 0x14 ] = KEY_AUDIO,       // 'stereo'
+	[ 0x15 ] = KEY_CLEAR,       // 'reset'
+	[ 0x16 ] = KEY_PLAY,        // 'play'
+	[ 0x17 ] = KEY_ENTER,       // 'enter'
+	[ 0x18 ] = KEY_ZOOM,        // 'full screen'
+	[ 0x19 ] = KEY_FASTFORWARD, // 'forward >>'
+	[ 0x1a ] = KEY_CHANNELUP,   // 'channel +'
+	[ 0x1b ] = KEY_VOLUMEUP,    // 'volume +'
+	[ 0x1c ] = KEY_INFO,        // 'preview'
+	[ 0x1d ] = KEY_RECORD,      // 'record'
+	[ 0x1e ] = KEY_CHANNELDOWN, // 'channel -'
+	[ 0x1f ] = KEY_VOLUMEDOWN,  // 'volume -'
+};
+
+/* ---------------------------------------------------------------------- */
+
+/* IO-DATA BCTV7E Remote */
+static IR_KEYTAB_TYPE ir_codes_iodata_bctv7e[IR_KEYTAB_SIZE] = {
+	[ 0x40 ] = KEY_TV,              // TV
+	[ 0x20 ] = KEY_RADIO,           // FM
+	[ 0x60 ] = KEY_EPG,             // EPG
+	[ 0x00 ] = KEY_POWER,           // power
+
+	[ 0x50 ] = KEY_KP1,             // 1
+	[ 0x30 ] = KEY_KP2,             // 2
+	[ 0x70 ] = KEY_KP3,             // 3
+	[ 0x10 ] = KEY_L,               // Live
+
+	[ 0x48 ] = KEY_KP4,             // 4
+	[ 0x28 ] = KEY_KP5,             // 5
+	[ 0x68 ] = KEY_KP6,             // 6
+	[ 0x08 ] = KEY_T,               // Time Shift
+
+	[ 0x58 ] = KEY_KP7,             // 7
+	[ 0x38 ] = KEY_KP8,             // 8
+	[ 0x78 ] = KEY_KP9,             // 9
+	[ 0x18 ] = KEY_PLAYPAUSE,       // Play
+
+	[ 0x44 ] = KEY_KP0,             // 10
+	[ 0x24 ] = KEY_ENTER,           // 11
+	[ 0x64 ] = KEY_ESC,             // 12
+	[ 0x04 ] = KEY_M,               // Multi
+
+	[ 0x54 ] = KEY_VIDEO,           // VIDEO
+	[ 0x34 ] = KEY_CHANNELUP,       // channel +
+	[ 0x74 ] = KEY_VOLUMEUP,        // volume +
+	[ 0x14 ] = KEY_MUTE,            // Mute
+
+	[ 0x4c ] = KEY_S,               // SVIDEO
+	[ 0x2c ] = KEY_CHANNELDOWN,     // channel -
+	[ 0x6c ] = KEY_VOLUMEDOWN,      // volume -
+	[ 0x0c ] = KEY_ZOOM,            // Zoom
+
+	[ 0x5c ] = KEY_PAUSE,           // pause
+	[ 0x3c ] = KEY_C,               // || (red)
+	[ 0x7c ] = KEY_RECORD,          // recording
+	[ 0x1c ] = KEY_STOP,            // stop
+
+	[ 0x41 ] = KEY_REWIND,          // backward <<
+	[ 0x21 ] = KEY_PLAY,            // play
+	[ 0x61 ] = KEY_FASTFORWARD,     // forward >>
+	[ 0x01 ] = KEY_NEXT,            // skip >|
+};
+
+/* ---------------------------------------------------------------------- */
+
+struct cx88_IR {
+	struct cx88_core	*core;
+	struct input_dev        input;
+	struct ir_input_state   ir;
+	char                    name[32];
+	char                    phys[32];
+
+	/* sample from gpio pin 16 */
+	int                     sampling;
+	u32                     samples[16];
+	int                     scount;
+	unsigned long           release;
+
+	/* poll external decoder */
+	int                     polling;
+	struct work_struct      work;
+	struct timer_list       timer;
+	u32			gpio_addr;
+	u32                     last_gpio;
+	u32                     mask_keycode;
+	u32                     mask_keydown;
+	u32                     mask_keyup;
+};
+
+static int ir_debug = 0;
+module_param(ir_debug, int, 0644);    /* debug level [IR] */
+MODULE_PARM_DESC(ir_debug, "enable debug messages [IR]");
+
+#define ir_dprintk(fmt, arg...)	if (ir_debug) \
+	printk(KERN_DEBUG "%s IR: " fmt , ir->core->name, ## arg)
+
+/* ---------------------------------------------------------------------- */
+
+static void cx88_ir_handle_key(struct cx88_IR *ir)
+{
+	struct cx88_core *core = ir->core;
+	u32 gpio, data;
+
+	/* read gpio value */
+	gpio = cx_read(ir->gpio_addr);
+	if (ir->polling) {
+		if (ir->last_gpio == gpio)
+			return;
+		ir->last_gpio = gpio;
+	}
+
+	/* extract data */
+	data = ir_extract_bits(gpio, ir->mask_keycode);
+	ir_dprintk("irq gpio=0x%x code=%d | %s%s%s\n",
+		gpio, data,
+		ir->polling               ? "poll"  : "irq",
+		(gpio & ir->mask_keydown) ? " down" : "",
+		(gpio & ir->mask_keyup)   ? " up"   : "");
+
+	if (ir->mask_keydown) {
+		/* bit set on keydown */
+		if (gpio & ir->mask_keydown) {
+			ir_input_keydown(&ir->input,&ir->ir,data,data);
+		} else {
+			ir_input_nokey(&ir->input,&ir->ir);
+		}
+
+	} else if (ir->mask_keyup) {
+		/* bit cleared on keydown */
+		if (0 == (gpio & ir->mask_keyup)) {
+			ir_input_keydown(&ir->input,&ir->ir,data,data);
+		} else {
+			ir_input_nokey(&ir->input,&ir->ir);
+		}
+
+	} else {
+		/* can't distinguish keydown/up :-/ */
+		ir_input_keydown(&ir->input,&ir->ir,data,data);
+		ir_input_nokey(&ir->input,&ir->ir);
+	}
+}
+
+static void ir_timer(unsigned long data)
+{
+	struct cx88_IR *ir = (struct cx88_IR*)data;
+
+	schedule_work(&ir->work);
+}
+
+static void cx88_ir_work(void *data)
+{
+	struct cx88_IR *ir = data;
+	unsigned long timeout;
+
+	cx88_ir_handle_key(ir);
+	timeout = jiffies + (ir->polling * HZ / 1000);
+	mod_timer(&ir->timer, timeout);
+}
+
+/* ---------------------------------------------------------------------- */
+
+int cx88_ir_init(struct cx88_core *core, struct pci_dev *pci)
+{
+	struct cx88_IR *ir;
+	IR_KEYTAB_TYPE *ir_codes = NULL;
+	int ir_type = IR_TYPE_OTHER;
+
+	ir = kmalloc(sizeof(*ir),GFP_KERNEL);
+	if (NULL == ir)
+		return -ENOMEM;
+	memset(ir,0,sizeof(*ir));
+
+	/* detect & configure */
+	switch (core->board) {
+	case CX88_BOARD_DNTV_LIVE_DVB_T:
+		ir_codes         = ir_codes_dntv_live_dvb_t;
+		ir->gpio_addr    = MO_GP1_IO;
+		ir->mask_keycode = 0x1f;
+		ir->mask_keyup   = 0x60;
+		ir->polling      = 50; // ms
+		break;
+	case CX88_BOARD_HAUPPAUGE:
+	case CX88_BOARD_HAUPPAUGE_DVB_T1:
+		ir_codes         = ir_codes_hauppauge_new;
+		ir_type          = IR_TYPE_RC5;
+		ir->sampling     = 1;
+		break;
+	case CX88_BOARD_WINFAST2000XP_EXPERT:
+		ir_codes         = ir_codes_winfast;
+		ir->gpio_addr    = MO_GP0_IO;
+		ir->mask_keycode = 0x8f8; 
+		ir->mask_keyup   = 0x100;
+		ir->polling      = 1; // ms
+		break;
+	case CX88_BOARD_IODATA_GVBCTV7E:
+		ir_codes         = ir_codes_iodata_bctv7e;
+		ir->gpio_addr    = MO_GP0_IO;
+		ir->mask_keycode = 0xfd;
+		ir->mask_keydown = 0x02;
+		ir->polling      = 5; // ms
+		break;
+	}
+	if (NULL == ir_codes) {
+		kfree(ir);
+		return -ENODEV;
+	}
+
+	/* init input device */
+	snprintf(ir->name, sizeof(ir->name), "cx88 IR (%s)",
+		 cx88_boards[core->board].name);
+	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
+		 pci_name(pci));
+
+	ir_input_init(&ir->input, &ir->ir, ir_type, ir_codes);
+	ir->input.name = ir->name;
+	ir->input.phys = ir->phys;
+	ir->input.id.bustype = BUS_PCI;
+	ir->input.id.version = 1;
+	if (pci->subsystem_vendor) {
+		ir->input.id.vendor  = pci->subsystem_vendor;
+		ir->input.id.product = pci->subsystem_device;
+	} else {
+		ir->input.id.vendor  = pci->vendor;
+		ir->input.id.product = pci->device;
+	}
+
+	/* record handles to ourself */
+	ir->core = core;
+	core->ir = ir;
+
+	if (ir->polling) {
+		INIT_WORK(&ir->work, cx88_ir_work, ir);
+		init_timer(&ir->timer);
+		ir->timer.function = ir_timer;
+		ir->timer.data     = (unsigned long)ir;
+		schedule_work(&ir->work);
+	}
+	if (ir->sampling) {
+		core->pci_irqmask |= (1<<18);   // IR_SMP_INT
+		cx_write(MO_DDS_IO, 0xa80a80);  // 4 kHz sample rate
+		cx_write(MO_DDSCFG_IO,   0x5);  // enable
+	}
+
+	/* all done */
+	input_register_device(&ir->input);
+	printk("%s: registered IR remote control\n", core->name);
+
+	return 0;
+}
+
+int cx88_ir_fini(struct cx88_core *core)
+{
+	struct cx88_IR *ir = core->ir;
+
+	/* skip detach on non attached boards */
+	if (NULL == ir)
+		return 0;
+
+	if (ir->polling) {
+		del_timer(&ir->timer);
+		flush_scheduled_work();
+	}
+
+	input_unregister_device(&ir->input);
+	kfree(ir);
+
+	/* done */
+	core->ir = NULL;
+	return 0;
+}
+
+/* ---------------------------------------------------------------------- */
+
+void cx88_ir_irq(struct cx88_core *core)
+{
+	struct cx88_IR *ir = core->ir;
+	u32 samples,rc5;
+	int i;
+
+	if (NULL == ir)
+		return;
+	if (!ir->sampling)
+		return;
+
+	samples = cx_read(MO_SAMPLE_IO);
+	if (0 != samples  &&  0xffffffff != samples) {
+		/* record sample data */
+		if (ir->scount < ARRAY_SIZE(ir->samples))
+			ir->samples[ir->scount++] = samples;
+		return;
+	}
+	if (!ir->scount) {
+		/* nothing to sample */
+		if (ir->ir.keypressed && time_after(jiffies,ir->release))
+			ir_input_nokey(&ir->input,&ir->ir);
+		return;
+	}
+
+	/* have a complete sample */
+	if (ir->scount < ARRAY_SIZE(ir->samples))
+		ir->samples[ir->scount++] = samples;
+	for (i = 0; i < ir->scount; i++)
+		ir->samples[i] = ~ir->samples[i];
+	if (ir_debug)
+		ir_dump_samples(ir->samples,ir->scount);
+
+	/* decode it */
+	switch (core->board) {
+	case CX88_BOARD_HAUPPAUGE:
+	case CX88_BOARD_HAUPPAUGE_DVB_T1:
+		rc5 = ir_decode_biphase(ir->samples,ir->scount,5,7);
+		ir_dprintk("biphase decoded: %x\n",rc5);
+		if ((rc5 & 0xfffff000) != 0x3000)
+			break;
+		ir_input_keydown(&ir->input, &ir->ir, rc5 & 0x3f, rc5);
+		ir->release = jiffies + msecs_to_jiffies(120);
+		break;
+	}
+
+	ir->scount = 0;
+	return;
+}
+
+/* ---------------------------------------------------------------------- */
+
+MODULE_AUTHOR("Gerd Knorr, Pavel Machek, Chris Pascoe");
+MODULE_DESCRIPTION("input driver for cx88 GPIO-based IR remote controls");
+MODULE_LICENSE("GPL");
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
Index: linux-2.6.11/drivers/media/video/cx88/cx88-vbi.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-vbi.c	2005-03-07 10:13:49.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-vbi.c	2005-03-08 10:33:15.000000000 +0100
@@ -1,8 +1,9 @@
 /*
- * $Id: cx88-vbi.c,v 1.14 2004/11/07 13:17:15 kraxel Exp $
+ * $Id: cx88-vbi.c,v 1.16 2004/12/10 12:33:39 kraxel Exp $
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 
@@ -64,7 +65,7 @@ int cx8800_start_vbi_dma(struct cx8800_d
 	q->count = 1;
 
 	/* enable irqs */
-	cx_set(MO_PCI_INTMSK, 0x00fc01);
+	cx_set(MO_PCI_INTMSK, core->pci_irqmask | 0x01);
 	cx_set(MO_VID_INTMSK, 0x0f0088);
 
 	/* enable capture */
Index: linux-2.6.11/drivers/media/video/cx88/cx88.h
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88.h	2005-03-07 10:15:48.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88.h	2005-03-08 10:33:15.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.40 2004/11/03 09:04:51 kraxel Exp $
+ * $Id: cx88.h,v 1.56 2005/03/04 09:12:23 kraxel Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -27,6 +27,7 @@
 #include <linux/kdev_t.h>
 
 #include <media/tuner.h>
+#include <media/tveeprom.h>
 #include <media/audiochip.h>
 #include <media/video-buf.h>
 #include <media/video-buf-dvb.h>
@@ -139,7 +140,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_GDI                      2
 #define CX88_BOARD_PIXELVIEW                3
 #define CX88_BOARD_ATI_WONDER_PRO           4
-#define CX88_BOARD_WINFAST2000XP            5
+#define CX88_BOARD_WINFAST2000XP_EXPERT     5
 #define CX88_BOARD_AVERTV_303               6
 #define CX88_BOARD_MSI_TVANYWHERE_MASTER    7
 #define CX88_BOARD_WINFAST_DV2000           8
@@ -156,6 +157,11 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_CONEXANT_DVB_T1         19
 #define CX88_BOARD_PROVIDEO_PV259          20
 #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS 21
+#define CX88_BOARD_PCHDTV_HD3000           22
+#define CX88_BOARD_DNTV_LIVE_DVB_T         23
+#define CX88_BOARD_HAUPPAUGE_ROSLYN        24
+#define CX88_BOARD_DIGITALLOGIC_MEC	       25
+#define CX88_BOARD_IODATA_GVBCTV7E         26
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
@@ -238,6 +244,7 @@ struct cx88_core {
         u32                        __iomem *lmmio;
         u8                         __iomem *bmmio;
 	u32                        shadow[SHADOW_MAX];
+	int                        pci_irqmask;
 
 	/* i2c i/o */
 	struct i2c_adapter         i2c_adap;
@@ -252,16 +259,20 @@ struct cx88_core {
 	unsigned int               has_radio;
 
 	/* config info -- dvb */
-	unsigned int               pll_type;
+	struct dvb_pll_desc        *pll_desc;
 	unsigned int               pll_addr;
-	unsigned int               demod_addr;
 
 	/* state info */
 	struct task_struct         *kthread;
 	struct cx88_tvnorm         *tvnorm;
 	u32                        tvaudio;
+	u32                        audiomode_manual;
+	u32                        audiomode_current;
 	u32                        input;
 	u32                        astat;
+
+	/* IR remote control state */
+	struct cx88_IR             *ir;
 };
 
 struct cx8800_dev;
@@ -371,11 +382,16 @@ struct cx8802_dev {
 	struct list_head           devlist;
 	struct video_device        *mpeg_dev;
 	u32                        mailbox;
+	int                        width;
+	int                        height;
 
 	/* for dvb only */
 	struct videobuf_dvb        dvb;
 	void*                      fe_handle;
 	int                        (*fe_release)(void *handle);
+
+	/* for switching modulation types */
+	unsigned char              ts_gen_cntrl;
 };
 
 /* ----------------------------------------------------------- */
@@ -411,7 +427,7 @@ extern void cx88_print_irqbits(char *nam
 			       u32 bits, u32 mask);
 extern void cx88_print_ioctl(char *name, unsigned int cmd);
 
-extern void cx88_irq(struct cx88_core *core, u32 status, u32 mask);
+extern int cx88_core_irq(struct cx88_core *core, u32 status);
 extern void cx88_wakeup(struct cx88_core *core,
 			struct cx88_dmaqueue *q, u32 count);
 extern void cx88_shutdown(struct cx88_core *core);
@@ -503,11 +519,19 @@ extern void cx88_card_setup(struct cx88_
 #define WW_FM		12
 
 void cx88_set_tvaudio(struct cx88_core *core);
+void cx88_newstation(struct cx88_core *core);
 void cx88_get_stereo(struct cx88_core *core, struct v4l2_tuner *t);
-void cx88_set_stereo(struct cx88_core *core, u32 mode);
+void cx88_set_stereo(struct cx88_core *core, u32 mode, int manual);
 int cx88_audio_thread(void *data);
 
 /* ----------------------------------------------------------- */
+/* cx88-input.c                                                */
+
+int cx88_ir_init(struct cx88_core *core, struct pci_dev *pci);
+int cx88_ir_fini(struct cx88_core *core);
+void cx88_ir_irq(struct cx88_core *core);
+
+/* ----------------------------------------------------------- */
 /* cx88-mpeg.c                                                 */
 
 int cx8802_buf_prepare(struct cx8802_dev *dev, struct cx88_buffer *buf);
@@ -517,7 +541,7 @@ void cx8802_cancel_buffers(struct cx8802
 int cx8802_init_common(struct cx8802_dev *dev);
 void cx8802_fini_common(struct cx8802_dev *dev);
 
-int cx8802_suspend_common(struct pci_dev *pci_dev, u32 state);
+int cx8802_suspend_common(struct pci_dev *pci_dev, pm_message_t state);
 int cx8802_resume_common(struct pci_dev *pci_dev);
 
 /*
Index: linux-2.6.11/drivers/media/video/cx88/Makefile
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/Makefile	2005-03-07 10:13:03.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/Makefile	2005-03-08 10:33:15.000000000 +0100
@@ -1,4 +1,5 @@
-cx88xx-objs	:= cx88-cards.o cx88-core.o cx88-i2c.o cx88-tvaudio.o
+cx88xx-objs	:= cx88-cards.o cx88-core.o cx88-i2c.o cx88-tvaudio.o \
+		   cx88-input.o
 cx8800-objs	:= cx88-video.o cx88-vbi.o
 cx8802-objs	:= cx88-mpeg.o
 
Index: linux-2.6.11/drivers/media/video/cx88/cx88-i2c.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/cx88/cx88-i2c.c	2005-03-07 10:13:32.000000000 +0100
+++ linux-2.6.11/drivers/media/video/cx88/cx88-i2c.c	2005-03-08 10:33:15.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-i2c.c,v 1.18 2004/10/13 10:39:00 kraxel Exp $
+    $Id: cx88-i2c.c,v 1.20 2005/02/15 15:59:35 kraxel Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
@@ -25,6 +25,7 @@
 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
 
 #include <asm/io.h>

-- 
#define printk(args...) fprintf(stderr, ## args)
