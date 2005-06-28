Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVF1TIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVF1TIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVF1TID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:08:03 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:18595 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261201AbVF1TF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 15:05:26 -0400
Message-ID: <42C19F6A.6020501@brturbo.com.br>
Date: Tue, 28 Jun 2005 16:05:14 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1]  V4L CX88 patch - against 2.6.12-mm2
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------030107090100040403080208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030107090100040403080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------030107090100040403080208
Content-Type: text/x-patch;
 name="2.6.12-mm2-cx88-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.12-mm2-cx88-update.patch"

- Add support for ADS Tech Instant TV DVB-T PCI.
- Remove obsoleted config options.
- Fix DViCO Board names 
- Remove CABLE type setting from DViCO FusionHDTV3 Gold-T.
- Fix compilation with gcc4.0.
- V4L2_TUNER_CAP_LOW implemented according with V4L2 API for Radio.
- radio range is now defined on tuner-core.c. Cleaning up.
- Fix a bug on frequency report for cx88 based cards.
- Added support for changing radio mode stereo/mono.
- Add remove for MSI TV@nywhere.

Signed-off-by: Jorik Jonker <jorik@dnd.utwente.nl>.
Signed-off-by: Didier Caillaud <mailing.cld@free.fr>
Signed-off-by: Benoit Laniel <benoit.laniel@gmail.com>.
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/cx88/cx88-cards.c |   50 +++++++---
 linux/drivers/media/video/cx88/cx88-core.c  |   21 +---
 linux/drivers/media/video/cx88/cx88-dvb.c   |    5 -
 linux/drivers/media/video/cx88/cx88-input.c |  100 +++++++++++++++++++-
 linux/drivers/media/video/cx88/cx88-video.c |   57 +++++------
 linux/drivers/media/video/cx88/cx88.h       |    9 -
 6 files changed, 173 insertions(+), 69 deletions(-)

diff -u linux-2.6.12-mm2/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.12-mm2/drivers/media/video/cx88/cx88.h	2005-06-28 00:38:08.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88.h	2005-06-28 00:40:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.62 2005/06/12 04:19:19 mchehab Exp $
+ * $Id: cx88.h,v 1.66 2005/06/22 22:58:04 mchehab Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -51,8 +51,6 @@
 /* ----------------------------------------------------------- */
 /* defines and enums                                           */
 
-#define V4L2_I2C_CLIENTS 1
-
 #define FORMAT_FLAGS_PACKED       0x01
 #define FORMAT_FLAGS_PLANAR       0x02
 
@@ -159,7 +157,7 @@
 #define CX88_BOARD_KWORLD_DVB_T            14
 #define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1 15
 #define CX88_BOARD_KWORLD_LTV883           16
-#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD 17
+#define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q  17
 #define CX88_BOARD_HAUPPAUGE_DVB_T1        18
 #define CX88_BOARD_CONEXANT_DVB_T1         19
 #define CX88_BOARD_PROVIDEO_PV259          20
@@ -167,10 +165,11 @@
 #define CX88_BOARD_PCHDTV_HD3000           22
 #define CX88_BOARD_DNTV_LIVE_DVB_T         23
 #define CX88_BOARD_HAUPPAUGE_ROSLYN        24
-#define CX88_BOARD_DIGITALLOGIC_MEC	       25
+#define CX88_BOARD_DIGITALLOGIC_MEC        25
 #define CX88_BOARD_IODATA_GVBCTV7E         26
 #define CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO 27
 #define CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T  28
+#define CX88_BOARD_ADSTECH_DVB_T_PCI          29
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
diff -u linux-2.6.12-mm2/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-cards.c	2005-06-28 00:38:08.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-06-28 00:40:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.76 2005/06/08 01:28:09 mchehab Exp $
+ * $Id: cx88-cards.c,v 1.82 2005/06/28 04:33:53 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -401,7 +401,7 @@
 		.dvb            = 1,
 	},
 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1] = {
-		.name           = "DVICO FusionHDTV DVB-T1",
+		.name           = "DViCO FusionHDTV DVB-T1",
 		.tuner_type     = TUNER_ABSENT, /* No analog tuner */
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
@@ -445,8 +445,8 @@
                         .gpio0  = 0x000007f8,
                 },
 	},
-	[CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD] = {
-		.name		= "DViCO - FusionHDTV 3 Gold",
+	[CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q] = {
+		.name		= "DViCO FusionHDTV 3 Gold-Q",
 		.tuner_type     = TUNER_MICROTUNE_4042FI5,
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
@@ -464,6 +464,9 @@
 		   GPIO[3] selects RF input connector on tuner module
 		    0 - RF connector labeled CABLE
 		    1 - RF connector labeled ANT
+		   GPIO[4] selects high RF for QAM256 mode
+		    0 - normal RF
+		    1 - high RF
 		*/
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
@@ -520,7 +523,7 @@
 		.blackbird = 1,
 	},
 	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS] = {
-		.name           = "DVICO FusionHDTV DVB-T Plus",
+		.name           = "DViCO FusionHDTV DVB-T Plus",
 		.tuner_type     = TUNER_ABSENT, /* No analog tuner */
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
@@ -700,21 +703,17 @@
 		 },
 	},
         [CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T] = {
-                .name           = "DViCO - FusionHDTV 3 Gold-T",
+		.name           = "DViCO FusionHDTV 3 Gold-T",
 		.tuner_type     = TUNER_THOMSON_DTT7611,
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		/*  See DViCO FusionHDTV 3 Gold for GPIO documentation.  */
-                .input          = {{
+		/*  See DViCO FusionHDTV 3 Gold-Q for GPIO documentation.  */
+		.input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
                         .gpio0  = 0x0f0d,
                 },{
-                        .type   = CX88_VMUX_CABLE,
-                        .vmux   = 0,
-                        .gpio0  = 0x0f05,
-                },{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
                         .gpio0  = 0x0f00,
@@ -724,6 +723,25 @@
                         .gpio0  = 0x0f00,
                 }},
         },
+        [CX88_BOARD_ADSTECH_DVB_T_PCI] = {
+                .name           = "ADS Tech Instant TV DVB-T PCI",
+		.tuner_type     = TUNER_ABSENT,
+		.radio_type     = UNSET,
+		.tuner_addr	= ADDR_UNSET,
+		.radio_addr	= ADDR_UNSET,
+		.input          = {{
+                        .type   = CX88_VMUX_COMPOSITE1,
+                        .vmux   = 1,
+			.gpio0  = 0x0700,
+			.gpio2  = 0x0101,
+                },{
+                        .type   = CX88_VMUX_SVIDEO,
+                        .vmux   = 2,
+			.gpio0  = 0x0700,
+			.gpio2  = 0x0101,
+                }},
+		.dvb            = 1,
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -794,7 +812,7 @@
 	},{
 		.subvendor = 0x18ac,
 		.subdevice = 0xd810,
-		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q,
 	},{
 		.subvendor = 0x18ac,
 		.subdevice = 0xd820,
@@ -843,7 +861,11 @@
 		.subvendor = 0x10fc,
 		.subdevice = 0xd035,
 		.card      = CX88_BOARD_IODATA_GVBCTV7E,
-	}
+	},{
+		.subvendor = 0x1421,
+		.subdevice = 0x0334,
+		.card      = CX88_BOARD_ADSTECH_DVB_T_PCI,
+	},
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
 
diff -u linux-2.6.12-mm2/drivers/media/video/cx88/cx88-core.c linux/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-core.c	2005-06-28 00:38:08.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-core.c	2005-06-28 00:40:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-core.c,v 1.28 2005/06/12 04:19:19 mchehab Exp $
+ * $Id: cx88-core.c,v 1.31 2005/06/22 22:58:04 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * driver core
@@ -545,12 +545,14 @@
 	       core->name,cx_read(ch->cnt2_reg));
 }
 
+/* Used only on cx88-core */
 static char *cx88_pci_irqs[32] = {
 	"vid", "aud", "ts", "vip", "hst", "5", "6", "tm1",
 	"src_dma", "dst_dma", "risc_rd_err", "risc_wr_err",
 	"brdg_err", "src_dma_err", "dst_dma_err", "ipb_dma_err",
 	"i2c", "i2c_rack", "ir_smp", "gpio0", "gpio1"
 };
+/* Used only on cx88-video */
 char *cx88_vid_irqs[32] = {
 	"y_risci1", "u_risci1", "v_risci1", "vbi_risc1",
 	"y_risci2", "u_risci2", "v_risci2", "vbi_risc2",
@@ -558,6 +560,7 @@
 	"y_sync",   "u_sync",   "v_sync",   "vbi_sync",
 	"opc_err",  "par_err",  "rip_err",  "pci_abort",
 };
+/* Used only on cx88-mpeg */
 char *cx88_mpeg_irqs[32] = {
 	"ts_risci1", NULL, NULL, NULL,
 	"ts_risci2", NULL, NULL, NULL,
@@ -1006,21 +1009,7 @@
 	set_tvaudio(core);
 
 	// tell i2c chips
-#ifdef V4L2_I2C_CLIENTS
 	cx88_call_i2c_clients(core,VIDIOC_S_STD,&norm->id);
-#else
-	{
-		struct video_channel c;
-		memset(&c,0,sizeof(c));
-		c.channel = core->input;
-		c.norm = VIDEO_MODE_PAL;
-		if ((norm->id & (V4L2_STD_NTSC_M|V4L2_STD_NTSC_M_JP)))
-			c.norm = VIDEO_MODE_NTSC;
-		if (norm->id & V4L2_STD_SECAM)
-			c.norm = VIDEO_MODE_SECAM;
-		cx88_call_i2c_clients(core,VIDIOCSCHAN,&c);
-	}
-#endif
 
 	// done
 	return 0;
@@ -1187,7 +1176,7 @@
 		core->radio_addr = cx88_boards[core->board].radio_addr;
 
         printk(KERN_INFO "TV tuner %d at 0x%02x, Radio tuner %d at 0x%02x\n",
-		core->tuner_type, core->tuner_addr<<1,
+		core->tuner_type, core->tuner_addr<<1, 
 		core->radio_type, core->radio_addr<<1);
 
 	core->tda9887_conf = cx88_boards[core->board].tda9887_conf;
diff -u linux-2.6.12-mm2/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-video.c	2005-06-28 00:38:08.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-06-28 00:40:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.63 2005/06/12 04:19:19 mchehab Exp $
+ * $Id: cx88-video.c,v 1.70 2005/06/20 03:36:00 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -1351,9 +1351,6 @@
 			V4L2_CAP_STREAMING     |
 			V4L2_CAP_VBI_CAPTURE   |
 #if 0
-			V4L2_TUNER_CAP_LOW     |
-#endif
-#if 0
 			V4L2_CAP_VIDEO_OVERLAY |
 #endif
 			0;
@@ -1475,7 +1472,7 @@
 			}
 			break;
 		case 1:
-			if (CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD == core->board) {
+			if (CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q == core->board) {
 				strcpy(a->name,"Line In");
 				a->capability = V4L2_AUDCAP_STEREO;
 				return 0;
@@ -1588,11 +1585,11 @@
 	{
 		struct v4l2_frequency *f = arg;
 
+		memset(f,0,sizeof(*f));
+
 		if (UNSET == core->tuner_type)
 			return -EINVAL;
-		if (f->tuner != 0)
-			return -EINVAL;
-		memset(f,0,sizeof(*f));
+
 		f->type = fh->radio ? V4L2_TUNER_RADIO : V4L2_TUNER_ANALOG_TV;
 		f->frequency = dev->freq;
 		return 0;
@@ -1612,11 +1609,7 @@
 		down(&dev->lock);
 		dev->freq = f->frequency;
 		cx88_newstation(core);
-#ifdef V4L2_I2C_CLIENTS
 		cx88_call_i2c_clients(dev->core,VIDIOC_S_FREQUENCY,f);
-#else
-		cx88_call_i2c_clients(dev->core,VIDIOCSFREQ,&dev->freq);
-#endif
 		up(&dev->lock);
 		return 0;
 	}
@@ -1714,11 +1707,7 @@
 			sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s", pci_name(dev->pci));
 		cap->version = CX88_VERSION_CODE;
-		cap->capabilities = V4L2_CAP_TUNER
-#if 0
-				    | V4L2_TUNER_CAP_LOW
-#endif
-				    ;
+		cap->capabilities = V4L2_CAP_TUNER;
 		return 0;
 	}
 	case VIDIOC_G_TUNER:
@@ -1730,19 +1719,8 @@
 
 		memset(t,0,sizeof(*t));
 		strcpy(t->name, "Radio");
-                t->rangelow  = (int)(65*16);
-                t->rangehigh = (int)(108*16);
 
-#ifdef V4L2_I2C_CLIENTS
 		cx88_call_i2c_clients(dev->core,VIDIOC_G_TUNER,t);
-#else
-		{
-			struct video_tuner vt;
-			memset(&vt,0,sizeof(vt));
-			cx88_call_i2c_clients(dev,VIDIOCGTUNER,&vt);
-			t->signal = vt.signal;
-		}
-#endif
 		return 0;
 	}
 	case VIDIOC_ENUMINPUT:
@@ -1775,8 +1753,29 @@
 		*id = 0;
 		return 0;
 	}
-	case VIDIOC_S_AUDIO:
+	case VIDIOCSTUNER:
+	{
+		struct video_tuner *v = arg;
+
+		if (v->tuner) /* Only tuner 0 */
+			return -EINVAL;
+
+		cx88_call_i2c_clients(dev->core,VIDIOCSTUNER,v);
+                return 0;
+	}
 	case VIDIOC_S_TUNER:
+	{
+		struct v4l2_tuner *t = arg;
+
+		if (0 != t->index)
+			return -EINVAL;
+
+		cx88_call_i2c_clients(dev->core,VIDIOC_S_TUNER,t);
+
+		return 0;
+	}
+
+	case VIDIOC_S_AUDIO:
 	case VIDIOC_S_INPUT:
 	case VIDIOC_S_STD:
 		return 0;
diff -u linux-2.6.12-mm2/drivers/media/video/cx88/cx88-input.c linux/drivers/media/video/cx88/cx88-input.c
--- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-input.c	2005-06-28 00:38:08.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-input.c	2005-06-28 00:40:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-input.c,v 1.11 2005/05/22 20:57:56 nsh Exp $
+ * $Id: cx88-input.c,v 1.13 2005/06/13 16:07:46 nsh Exp $
  *
  * Device driver for GPIO attached remote control interfaces
  * on Conexant 2388x based TV/DVB cards.
@@ -125,6 +125,86 @@
 
 /* ---------------------------------------------------------------------- */
 
+/* ADS Tech Instant TV DVB-T PCI Remote */
+static IR_KEYTAB_TYPE ir_codes_adstech_dvb_t_pci[IR_KEYTAB_SIZE] = {
+	[ 0x5b ] = KEY_POWER,
+	[ 0x5f ] = KEY_MUTE,
+	[ 0x57 ] = KEY_1,
+	[ 0x4f ] = KEY_2,
+	[ 0x53 ] = KEY_3,
+	[ 0x56 ] = KEY_4,
+	[ 0x4e ] = KEY_5,
+	[ 0x5e ] = KEY_6,
+	[ 0x54 ] = KEY_7,
+	[ 0x4c ] = KEY_8,
+	[ 0x5c ] = KEY_9,
+	[ 0x4d ] = KEY_0,
+	[ 0x55 ] = KEY_GOTO,
+	[ 0x5d ] = KEY_SEARCH,
+	[ 0x17 ] = KEY_EPG,             // Guide
+	[ 0x1f ] = KEY_MENU,
+	[ 0x0f ] = KEY_UP,
+	[ 0x46 ] = KEY_DOWN,
+	[ 0x16 ] = KEY_LEFT,
+	[ 0x1e ] = KEY_RIGHT,
+	[ 0x0e ] = KEY_SELECT,          // Enter
+	[ 0x5a ] = KEY_INFO,
+	[ 0x52 ] = KEY_EXIT,
+	[ 0x59 ] = KEY_PREVIOUS,
+	[ 0x51 ] = KEY_NEXT,
+	[ 0x58 ] = KEY_REWIND,
+	[ 0x50 ] = KEY_FORWARD,
+	[ 0x44 ] = KEY_PLAYPAUSE,
+	[ 0x07 ] = KEY_STOP,
+	[ 0x1b ] = KEY_RECORD,
+	[ 0x13 ] = KEY_TUNER,           // Live
+	[ 0x0a ] = KEY_A,
+	[ 0x12 ] = KEY_B,
+	[ 0x03 ] = KEY_PROG1,           // 1
+	[ 0x01 ] = KEY_PROG2,           // 2
+	[ 0x00 ] = KEY_PROG3,           // 3
+	[ 0x06 ] = KEY_DVD,
+	[ 0x48 ] = KEY_AUX,             // Photo
+	[ 0x40 ] = KEY_VIDEO,
+	[ 0x19 ] = KEY_AUDIO,           // Music
+	[ 0x0b ] = KEY_CHANNELUP,
+	[ 0x08 ] = KEY_CHANNELDOWN,
+	[ 0x15 ] = KEY_VOLUMEUP,
+	[ 0x1c ] = KEY_VOLUMEDOWN,
+};
+
+/* ---------------------------------------------------------------------- */
+
+/* MSI TV@nywhere remote */
+static IR_KEYTAB_TYPE ir_codes_msi_tvanywhere[IR_KEYTAB_SIZE] = {
+       [ 0x00 ] = KEY_0,           /* '0' */          
+       [ 0x01 ] = KEY_1,           /* '1' */
+       [ 0x02 ] = KEY_2,           /* '2' */
+       [ 0x03 ] = KEY_3,           /* '3' */
+       [ 0x04 ] = KEY_4,           /* '4' */
+       [ 0x05 ] = KEY_5,           /* '5' */
+       [ 0x06 ] = KEY_6,           /* '6' */
+       [ 0x07 ] = KEY_7,           /* '7' */
+       [ 0x08 ] = KEY_8,           /* '8' */
+       [ 0x09 ] = KEY_9,           /* '9' */
+       [ 0x0c ] = KEY_MUTE,        /* 'Mute' */
+       [ 0x0f ] = KEY_SCREEN,      /* 'Full Screen' */
+       [ 0x10 ] = KEY_F,           /* 'Funtion' */
+       [ 0x11 ] = KEY_T,           /* 'Time shift' */
+       [ 0x12 ] = KEY_POWER,       /* 'Power' */
+       [ 0x13 ] = KEY_MEDIA,       /* 'MTS' */
+       [ 0x14 ] = KEY_SLOW,        /* 'Slow' */
+       [ 0x16 ] = KEY_REWIND,      /* 'backward <<' */
+       [ 0x17 ] = KEY_ENTER,       /* 'Return' */
+       [ 0x18 ] = KEY_FASTFORWARD, /* 'forward >>' */
+       [ 0x1a ] = KEY_CHANNELUP,   /* 'Channel+' */
+       [ 0x1b ] = KEY_VOLUMEUP,    /* 'Volume+' */
+       [ 0x1e ] = KEY_CHANNELDOWN, /* 'Channel-' */
+       [ 0x1f ] = KEY_VOLUMEDOWN,  /* 'Volume-' */
+};
+
+/* ---------------------------------------------------------------------- */
+
 struct cx88_IR {
 	struct cx88_core	*core;
 	struct input_dev        input;
@@ -251,7 +331,7 @@
 	case CX88_BOARD_WINFAST2000XP_EXPERT:
 		ir_codes         = ir_codes_winfast;
 		ir->gpio_addr    = MO_GP0_IO;
-		ir->mask_keycode = 0x8f8;
+		ir->mask_keycode = 0x8f8; 
 		ir->mask_keyup   = 0x100;
 		ir->polling      = 1; // ms
 		break;
@@ -265,10 +345,24 @@
 	case CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO:
 		ir_codes         = ir_codes_pixelview;
 		ir->gpio_addr    = MO_GP1_IO;
-		ir->mask_keycode = 0x1f;
+		ir->mask_keycode = 0x1f; 
 		ir->mask_keyup   = 0x80;
 		ir->polling      = 1; // ms
 		break;
+	case CX88_BOARD_ADSTECH_DVB_T_PCI:
+		ir_codes         = ir_codes_adstech_dvb_t_pci;
+		ir->gpio_addr    = MO_GP1_IO;
+		ir->mask_keycode = 0xbf;
+		ir->mask_keyup   = 0x40;
+		ir->polling      = 50; // ms
+		break;
+        case CX88_BOARD_MSI_TVANYWHERE_MASTER:
+                ir_codes         = ir_codes_msi_tvanywhere;
+                ir->gpio_addr    = MO_GP1_IO;
+                ir->mask_keycode = 0x1f;
+                ir->mask_keyup   = 0x40;
+                ir->polling      = 1;
+                break;
 	}
 
 	if (NULL == ir_codes) {
diff -u linux-2.6.12-mm2/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.12-mm2/drivers/media/video/cx88/cx88-dvb.c	2005-06-28 00:38:08.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-06-28 00:40:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.33 2005/06/12 04:19:19 mchehab Exp $
+ * $Id: cx88-dvb.c,v 1.36 2005/06/21 06:08:12 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -183,7 +183,7 @@
 #endif
 
 #if HAVE_OR51132
-static int or51132_set_ts_param(struct dvb_frontend* fe,
+static int or51132_set_ts_param(struct dvb_frontend* fe, 
 				int is_punctured)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
@@ -231,6 +231,7 @@
 		break;
 	case CX88_BOARD_KWORLD_DVB_T:
 	case CX88_BOARD_DNTV_LIVE_DVB_T:
+	case CX88_BOARD_ADSTECH_DVB_T_PCI:
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_unknown_1;
 		dev->dvb.frontend = mt352_attach(&dntv_live_dvbt_config,

--------------030107090100040403080208--
