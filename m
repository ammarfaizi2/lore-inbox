Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265092AbUFRKZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265092AbUFRKZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUFRKZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:25:55 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:65223 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265092AbUFRKUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:20:51 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 12:02:29 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: cx88 driver update
Message-ID: <20040618100229.GA24865@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the cx88 tv card driver.  Changes:

  * finally make it build with gcc 2.95 ;)
  * add new tv cards.
  * plenty of fixes for the TV sound code.
  * use v4l2 API for communication with tuner + tda9887
  * misc other minor stuff.

please apply,

  Gerd

diff -up linux-2.6.7/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.7/drivers/media/video/cx88/cx88-cards.c	2004-06-17 10:30:25.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88-cards.c	2004-06-17 13:47:59.785272417 +0200
@@ -99,6 +99,10 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
+                        .gpio0  = 0x000003ff,
+                        .gpio1  = 0x000000ff,
+                        .gpio2  = 0x000000ff,
+                        .gpio3  = 0x00000000,
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
@@ -111,6 +115,7 @@ struct cx88_board cx88_boards[] = {
         [CX88_BOARD_WINFAST2000XP] = {
                 .name           = "Leadtek Winfast 2000XP Expert",
                 .tuner_type     = 44,
+		.needs_tda9887  = 1,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
@@ -149,22 +154,33 @@ struct cx88_board cx88_boards[] = {
 			.vmux   = 0,
 		}},
 	},
-	[CX88_BOARD_MSI_TVANYWHERE] = {
+	[CX88_BOARD_MSI_TVANYWHERE_MASTER] = {	
+		//added gpio values thanks to Torsten Seeboth
+		//values for PAL from DScaler
 		.name           = "MSI TV-@nywhere Master",
 		.tuner_type     = 33,
+		.needs_tda9887	= 1,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
+			.gpio0  = 0x000040bf,
+			.gpio1  = 0x000080c0,
+			.gpio2  = 0x0000ff40,
+                   	.gpio3  = 0x00000000,
 		},{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
-		},{
-			 // temporarly for testing ...
-                        .type   = CX88_VMUX_COMPOSITE2,
-                        .vmux   = 2,
+			.gpio0  = 0x000040bf,
+			.gpio1  = 0x000080c0,
+			.gpio2  = 0x0000ff40,
+			.gpio3  = 0x00000000,
 		},{
                         .type   = CX88_VMUX_SVIDEO,
                         .vmux   = 2,
+			.gpio0  = 0x000040bf,
+			.gpio1  = 0x000080c0,
+			.gpio2  = 0x0000ff40,
+			.gpio3  = 0x00000000,
                 }},
                 .radio = {
                         .type   = CX88_RADIO,
@@ -199,8 +215,97 @@ struct cx88_board cx88_boards[] = {
                         .type   = CX88_RADIO,
                 },
         },
-
-
+	[CX88_BOARD_IODATA_GVVCP3PCI] = {
+ 		.name		= "IODATA GV-VCP3/PCI",
+		.tuner_type     = TUNER_ABSENT,
+		.needs_tda9887  = 0,
+ 		.input          = {{
+ 			.type   = CX88_VMUX_COMPOSITE1,
+ 			.vmux   = 0,
+ 		},{
+ 			.type   = CX88_VMUX_COMPOSITE2,
+ 			.vmux   = 1,
+ 		},{
+ 			.type   = CX88_VMUX_SVIDEO,
+ 			.vmux   = 2,
+ 		}},
+ 	},
+	[CX88_BOARD_PROLINK_PLAYTVPVR] = {
+                .name           = "Prolink PlayTV PVR",
+                .tuner_type     = 43,
+		.needs_tda9887	= 1,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0xff00,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0xff03,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0xff03,
+		}},
+		.radio = {
+			.type   = CX88_RADIO,
+			.gpio0  = 0xff00,
+		},
+	},
+	[CX88_BOARD_ASUS_PVR_416] = {
+		.name		= "ASUS PVR-416",
+		.tuner_type     = 43,
+                .needs_tda9887  = 1,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x0000fde6,
+			.gpio1  = 0x00000000, // possibly for mpeg data
+			.gpio2  = 0x000000e9,
+                   	.gpio3  = 0x00000000,
+ 		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x0000fde6, // 0x0000fda6 L,R RCA audio in?
+			.gpio1  = 0x00000000, // possibly for mpeg data
+			.gpio2  = 0x000000e9,
+                   	.gpio3  = 0x00000000,
+		}},
+                .radio = {
+                        .type   = CX88_RADIO,
+			.gpio0  = 0x0000fde2,
+			.gpio1  = 0x00000000,
+			.gpio2  = 0x000000e9,
+                   	.gpio3  = 0x00000000,
+                },
+	},
+	[CX88_BOARD_MSI_TVANYWHERE] = { 
+		.name           = "MSI TV-@nywhere",
+		.tuner_type     = 33,
+		.needs_tda9887  = 1,
+		.input          = {{
+			.type   = CX88_VMUX_TELEVISION,
+			.vmux   = 0,
+			.gpio0  = 0x00000fbf,
+			.gpio1  = 0x000000c0,
+			.gpio2  = 0x0000fc08,
+			.gpio3  = 0x00000000,
+		},{
+  			.type   = CX88_VMUX_COMPOSITE1,
+  			.vmux   = 1,
+			.gpio0  = 0x00000fbf,
+			.gpio1  = 0x000000c0,
+			.gpio2  = 0x0000fc68,
+			.gpio3  = 0x00000000,
+		},{
+  			.type   = CX88_VMUX_SVIDEO,
+  			.vmux   = 2,
+			.gpio0  = 0x00000fbf,
+			.gpio1  = 0x000000c0,
+			.gpio2  = 0x0000fc68,
+			.gpio3  = 0x00000000,
+  		}},
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -242,6 +347,10 @@ struct cx88_subid cx88_subids[] = {
                 .card      = CX88_BOARD_WINFAST_DV2000,
         },{
                 .subvendor = 0x107d,
+                .subdevice = 0x663b,
+                .card      = CX88_BOARD_LEADTEK_PVR2000,
+        },{
+                .subvendor = 0x107d,
                 .subdevice = 0x663C,
                 .card      = CX88_BOARD_LEADTEK_PVR2000,
         },{
@@ -251,12 +360,19 @@ struct cx88_subid cx88_subids[] = {
 	},{
 		.subvendor = 0x1462,
 		.subdevice = 0x8606,
-		.card      = CX88_BOARD_MSI_TVANYWHERE,
-	}
+		.card      = CX88_BOARD_MSI_TVANYWHERE_MASTER,
+	},{
+ 		.subvendor = 0x10fc,
+ 		.subdevice = 0xd003,
+ 		.card      = CX88_BOARD_IODATA_GVVCP3PCI,
+	},{
+ 		.subvendor = 0x1043,
+ 		.subdevice = 0x4823,  /* with mpeg encoder */
+ 		.card      = CX88_BOARD_ASUS_PVR_416,
+ 	}
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
 
-
 /* ----------------------------------------------------------------------- */
 /* some leadtek specific stuff                                             */
 
@@ -269,7 +385,7 @@ static void __devinit leadtek_eeprom(str
 	 */
 
 	if (eeprom_data[4] != 0x7d ||
-	    eeprom_data[5] != 0x10 ||
+	    eeprom_data[5] != 0x10 || 
 	    eeprom_data[7] != 0x66) {
 		printk(KERN_WARNING "%s Leadtek eeprom invalid.\n", dev->name);
 		return;
@@ -277,7 +393,7 @@ static void __devinit leadtek_eeprom(str
 
 	dev->has_radio  = 1;
 	dev->tuner_type = (eeprom_data[6] == 0x13) ? 43 : 38;
-
+	
 	printk(KERN_INFO "%s: Leadtek Winfast 2000 XP config: "
 	       "tuner=%d, eeprom[0]=0x%02x\n",
 	       dev->name, dev->tuner_type, eeprom_data[0]);
@@ -386,20 +502,22 @@ static struct {
 	[ 0x02 ] = { .id   = TUNER_ABSENT,
 		     .name = "PAL_B" },
 	[ 0x03 ] = { .id   = TUNER_ABSENT,
-		     .name = "BAL_I" },
+		     .name = "PAL_I" },
 	[ 0x04 ] = { .id   = TUNER_ABSENT,
 		     .name = "PAL_D" },
 	[ 0x05 ] = { .id   = TUNER_ABSENT,
 		     .name = "SECAM" },
 
-	[ 0x10 ] = { .id   = TUNER_ABSENT, .fm = 1, 
+	[ 0x10 ] = { .id   = TUNER_ABSENT,
+		     .fm   = 1, 
 		     .name = "TEMIC_4049" },
 	[ 0x11 ] = { .id   = TUNER_TEMIC_4136FY5,
 		     .name = "TEMIC_4136" },
 	[ 0x12 ] = { .id   = TUNER_ABSENT,
 		     .name = "TEMIC_4146" },
 
-	[ 0x20 ] = { .id   = TUNER_PHILIPS_FQ1216ME, .fm = 1,
+	[ 0x20 ] = { .id   = TUNER_PHILIPS_FQ1216ME,
+		     .fm   = 1,
 		     .name = "PHILIPS_FQ1216_MK3" },
 	[ 0x21 ] = { .id   = TUNER_ABSENT, .fm = 1,
 		     .name = "PHILIPS_FQ1236_MK3" },
@@ -454,7 +572,33 @@ i2c_eeprom(struct i2c_client *c, unsigne
 	return 0;
 }
 
-void __devinit cx88_card_setup(struct cx8800_dev *dev)
+void cx88_card_list(struct cx8800_dev *dev)
+{
+	int i;
+
+	if (0 == dev->pci->subsystem_vendor &&
+	    0 == dev->pci->subsystem_device) {
+		printk("%s: Your board has no valid PCI Subsystem ID and thus can't\n"
+		       "%s: be autodetected.  Please pass card=<n> insmod option to\n"
+		       "%s: workaround that.  Redirect complaints to the vendor of\n"
+		       "%s: the TV card.  Best regards,\n"
+		       "%s:         -- tux\n",
+		       dev->name,dev->name,dev->name,dev->name,dev->name);
+	} else {
+		printk("%s: Your board isn't known (yet) to the driver.  You can\n"
+		       "%s: try to pick one of the existing card configs via\n"
+		       "%s: card=<n> insmod option.  Updating to the latest\n"
+		       "%s: version might help as well.\n",
+		       dev->name,dev->name,dev->name,dev->name);
+	}
+	printk("%s: Here is a list of valid choices for the card=<n> insmod option:\n",
+	       dev->name);
+	for (i = 0; i < cx88_bcount; i++)
+		printk("%s:    card=%d -> %s\n",
+		       dev->name, i, cx88_boards[i].name);
+}
+
+void cx88_card_setup(struct cx8800_dev *dev)
 {
 	static u8 eeprom[128];
 		
@@ -474,6 +618,9 @@ void __devinit cx88_card_setup(struct cx
 			i2c_eeprom(&dev->i2c_client,eeprom,sizeof(eeprom));
 		leadtek_eeprom(dev,eeprom);
 		break;
+        case CX88_BOARD_ASUS_PVR_416:
+		dev->has_radio = 1;
+                break;
 	}
 }
 
@@ -483,6 +630,7 @@ EXPORT_SYMBOL(cx88_boards);
 EXPORT_SYMBOL(cx88_bcount);
 EXPORT_SYMBOL(cx88_subids);
 EXPORT_SYMBOL(cx88_idcount);
+EXPORT_SYMBOL(cx88_card_list);
 EXPORT_SYMBOL(cx88_card_setup);
 
 /*
diff -up linux-2.6.7/drivers/media/video/cx88/cx88-i2c.c linux/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.7/drivers/media/video/cx88/cx88-i2c.c	2004-06-17 10:28:38.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88-i2c.c	2004-06-17 13:47:59.787272041 +0200
@@ -22,8 +22,6 @@
     
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/module.h>
 #include <linux/init.h>
 
diff -up linux-2.6.7/drivers/media/video/cx88/cx88-reg.h linux/drivers/media/video/cx88/cx88-reg.h
--- linux-2.6.7/drivers/media/video/cx88/cx88-reg.h	2004-06-17 10:28:53.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88-reg.h	2004-06-17 13:47:59.790271476 +0200
@@ -599,10 +599,20 @@
 #define EN_I2SIN_STR2DAC        0x00004000
 #define EN_I2SIN_ENABLE         0x00008000
 
+#if 0
+/* old */
 #define EN_DMTRX_SUMDIFF        0x00000800
 #define EN_DMTRX_SUMR           0x00000880
 #define EN_DMTRX_LR             0x00000900
 #define EN_DMTRX_MONO           0x00000980
+#else
+/* dscaler cvs */
+#define EN_DMTRX_SUMDIFF        (0 << 7)
+#define EN_DMTRX_SUMR           (1 << 7)
+#define EN_DMTRX_LR             (2 << 7)
+#define EN_DMTRX_MONO           (3 << 7)
+#define EN_DMTRX_BYPASS         (1 << 11)
+#endif
 
 // Video 
 #define VID_CAPTURE_CONTROL		0x310180
diff -up linux-2.6.7/drivers/media/video/cx88/cx88-tvaudio.c linux/drivers/media/video/cx88/cx88-tvaudio.c
--- linux-2.6.7/drivers/media/video/cx88/cx88-tvaudio.c	2004-06-17 10:28:49.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88-tvaudio.c	2004-06-17 13:47:59.794270724 +0200
@@ -48,6 +48,7 @@
 #include <linux/interrupt.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 
 #include "cx88.h"
 
@@ -60,6 +61,33 @@ MODULE_PARM_DESC(audio_debug,"enable deb
 
 /* ----------------------------------------------------------- */
 
+static char *aud_ctl_names[64] =
+{
+	[ EN_BTSC_FORCE_MONO       ] = "BTSC_FORCE_MONO",
+	[ EN_BTSC_FORCE_STEREO     ] = "BTSC_FORCE_STEREO",
+	[ EN_BTSC_FORCE_SAP        ] = "BTSC_FORCE_SAP",
+	[ EN_BTSC_AUTO_STEREO      ] = "BTSC_AUTO_STEREO",
+	[ EN_BTSC_AUTO_SAP         ] = "BTSC_AUTO_SAP",
+	[ EN_A2_FORCE_MONO1        ] = "A2_FORCE_MONO1",
+	[ EN_A2_FORCE_MONO2        ] = "A2_FORCE_MONO2",
+	[ EN_A2_FORCE_STEREO       ] = "A2_FORCE_STEREO",
+	[ EN_A2_AUTO_MONO2         ] = "A2_AUTO_MONO2",
+	[ EN_A2_AUTO_STEREO        ] = "A2_AUTO_STEREO",
+	[ EN_EIAJ_FORCE_MONO1      ] = "EIAJ_FORCE_MONO1",
+	[ EN_EIAJ_FORCE_MONO2      ] = "EIAJ_FORCE_MONO2",
+	[ EN_EIAJ_FORCE_STEREO     ] = "EIAJ_FORCE_STEREO",
+	[ EN_EIAJ_AUTO_MONO2       ] = "EIAJ_AUTO_MONO2",
+	[ EN_EIAJ_AUTO_STEREO      ] = "EIAJ_AUTO_STEREO",
+	[ EN_NICAM_FORCE_MONO1     ] = "NICAM_FORCE_MONO1",
+	[ EN_NICAM_FORCE_MONO2     ] = "NICAM_FORCE_MONO2",
+	[ EN_NICAM_FORCE_STEREO    ] = "NICAM_FORCE_STEREO",
+	[ EN_NICAM_AUTO_MONO2      ] = "NICAM_AUTO_MONO2",
+	[ EN_NICAM_AUTO_STEREO     ] = "NICAM_AUTO_STEREO",
+	[ EN_FMRADIO_FORCE_MONO    ] = "FMRADIO_FORCE_MONO",
+	[ EN_FMRADIO_FORCE_STEREO  ] = "FMRADIO_FORCE_STEREO",
+	[ EN_FMRADIO_AUTO_STEREO   ] = "FMRADIO_AUTO_STEREO",
+};
+
 struct rlist {
 	u32 reg;
 	u32 val;
@@ -125,26 +153,116 @@ static void set_audio_finish(struct cx88
 static void set_audio_standard_BTSC(struct cx8800_dev *dev, unsigned int sap)
 {
 	static const struct rlist btsc[] = {
-		/* Magic stuff from leadtek driver + datasheet.*/
-		{ AUD_DBX_IN_GAIN,   0x4734 },
-		{ AUD_DBX_WBE_GAIN,  0x4640 },
-		{ AUD_DBX_SE_GAIN,   0x8D31 },
-		{ AUD_DEEMPH0_G0,    0x1604 },
-		{ AUD_PHASE_FIX_CTL, 0x0020 },
-
+		/* from dscaler */
+		{ AUD_OUT1_SEL,                0x00000013 },
+		{ AUD_OUT1_SHIFT,              0x00000000 },
+		{ AUD_POLY0_DDS_CONSTANT,      0x0012010c },
+		{ AUD_DMD_RA_DDS,              0x00c3e7aa },
+		{ AUD_DBX_IN_GAIN,             0x00004734 },
+		{ AUD_DBX_WBE_GAIN,            0x00004640 },
+		{ AUD_DBX_SE_GAIN,             0x00008d31 },
+		{ AUD_DCOC_0_SRC,              0x0000001a },
+		{ AUD_IIR1_4_SEL,              0x00000021 },
+		{ AUD_DCOC_PASS_IN,            0x00000003 },
+		{ AUD_DCOC_0_SHIFT_IN0,        0x0000000a },
+		{ AUD_DCOC_0_SHIFT_IN1,        0x00000008 },
+		{ AUD_DCOC_1_SHIFT_IN0,        0x0000000a },
+		{ AUD_DCOC_1_SHIFT_IN1,        0x00000008 },
+		{ AUD_DN0_FREQ,                0x0000283b },
+		{ AUD_DN2_SRC_SEL,             0x00000008 },
+		{ AUD_DN2_FREQ,                0x00003000 },
+		{ AUD_DN2_AFC,                 0x00000002 },
+		{ AUD_DN2_SHFT,                0x00000000 },
+		{ AUD_IIR2_2_SEL,              0x00000020 },
+		{ AUD_IIR2_2_SHIFT,            0x00000000 },
+		{ AUD_IIR2_3_SEL,              0x0000001f },
+		{ AUD_IIR2_3_SHIFT,            0x00000000 },
+		{ AUD_CRDC1_SRC_SEL,           0x000003ce },
+		{ AUD_CRDC1_SHIFT,             0x00000000 },
+		{ AUD_CORDIC_SHIFT_1,          0x00000007 },
+		{ AUD_DCOC_1_SRC,              0x0000001b },
+		{ AUD_DCOC1_SHIFT,             0x00000000 },
+		{ AUD_RDSI_SEL,                0x00000008 },
+		{ AUD_RDSQ_SEL,                0x00000008 },
+		{ AUD_RDSI_SHIFT,              0x00000000 },
+		{ AUD_RDSQ_SHIFT,              0x00000000 },
+		{ AUD_POLYPH80SCALEFAC,        0x00000003 },
                 { /* end of list */ },
 	};
-
-	dprintk("%s (status: unknown)\n",__FUNCTION__);
-	set_audio_start(dev, 0x0001,
-			EN_BTSC_AUTO_STEREO);
-        set_audio_registers(dev, btsc);
+	static const struct rlist btsc_sap[] = {
+		{ AUD_DBX_IN_GAIN,             0x00007200 },
+		{ AUD_DBX_WBE_GAIN,            0x00006200 },
+		{ AUD_DBX_SE_GAIN,             0x00006200 },
+		{ AUD_IIR1_1_SEL,              0x00000000 },
+		{ AUD_IIR1_3_SEL,              0x00000001 },
+		{ AUD_DN1_SRC_SEL,             0x00000007 },
+		{ AUD_IIR1_4_SHIFT,            0x00000006 },
+		{ AUD_IIR2_1_SHIFT,            0x00000000 },
+		{ AUD_IIR2_2_SHIFT,            0x00000000 },
+		{ AUD_IIR3_0_SHIFT,            0x00000000 },
+		{ AUD_IIR3_1_SHIFT,            0x00000000 },
+		{ AUD_IIR3_0_SEL,              0x0000000d },
+		{ AUD_IIR3_1_SEL,              0x0000000e },
+		{ AUD_DEEMPH1_SRC_SEL,         0x00000014 },
+		{ AUD_DEEMPH1_SHIFT,           0x00000000 },
+		{ AUD_DEEMPH1_G0,              0x00004000 },
+		{ AUD_DEEMPH1_A0,              0x00000000 },
+		{ AUD_DEEMPH1_B0,              0x00000000 },
+		{ AUD_DEEMPH1_A1,              0x00000000 },
+		{ AUD_DEEMPH1_B1,              0x00000000 },
+		{ AUD_OUT0_SEL,                0x0000003f },
+		{ AUD_OUT1_SEL,                0x0000003f },
+		{ AUD_DN1_AFC,                 0x00000002 },
+		{ AUD_DCOC_0_SHIFT_IN0,        0x0000000a },
+		{ AUD_DCOC_0_SHIFT_IN1,        0x00000008 },
+		{ AUD_DCOC_1_SHIFT_IN0,        0x0000000a },
+		{ AUD_DCOC_1_SHIFT_IN1,        0x00000008 },
+		{ AUD_IIR1_0_SEL,              0x0000001d },
+		{ AUD_IIR1_2_SEL,              0x0000001e },
+		{ AUD_IIR2_1_SEL,              0x00000002 },
+		{ AUD_IIR2_2_SEL,              0x00000004 },
+		{ AUD_IIR3_2_SEL,              0x0000000f },
+		{ AUD_DCOC2_SHIFT,             0x00000001 },
+		{ AUD_IIR3_2_SHIFT,            0x00000001 },
+		{ AUD_DEEMPH0_SRC_SEL,         0x00000014 },
+		{ AUD_CORDIC_SHIFT_1,          0x00000006 },
+		{ AUD_POLY0_DDS_CONSTANT,      0x000e4db2 },
+		{ AUD_DMD_RA_DDS,              0x00f696e6 },
+		{ AUD_IIR2_3_SEL,              0x00000025 },
+		{ AUD_IIR1_4_SEL,              0x00000021 },
+		{ AUD_DN1_FREQ,                0x0000c965 },
+		{ AUD_DCOC_PASS_IN,            0x00000003 },
+		{ AUD_DCOC_0_SRC,              0x0000001a },
+		{ AUD_DCOC_1_SRC,              0x0000001b },
+		{ AUD_DCOC1_SHIFT,             0x00000000 },
+		{ AUD_RDSI_SEL,                0x00000009 },
+		{ AUD_RDSQ_SEL,                0x00000009 },
+		{ AUD_RDSI_SHIFT,              0x00000000 },
+		{ AUD_RDSQ_SHIFT,              0x00000000 },
+		{ AUD_POLYPH80SCALEFAC,        0x00000003 },
+                { /* end of list */ },
+	};
+	
+	// dscaler: exactly taken from driver,
+	// dscaler: don't know why to set EN_FMRADIO_EN_RDS
+	if (sap) {
+		dprintk("%s SAP (status: unknown)\n",__FUNCTION__);
+		set_audio_start(dev, 0x0001,
+				EN_FMRADIO_EN_RDS | EN_BTSC_FORCE_SAP);
+		set_audio_registers(dev, btsc_sap);
+	} else {
+		dprintk("%s (status: known-good)\n",__FUNCTION__);
+		set_audio_start(dev, 0x0001,
+				EN_FMRADIO_EN_RDS | EN_BTSC_AUTO_STEREO);
+		set_audio_registers(dev, btsc);
+	}
 	set_audio_finish(dev);
 }
 
 static void set_audio_standard_NICAM(struct cx8800_dev *dev)
 {
-	static const struct rlist nicam[] = {
+	static const struct rlist nicam_common[] = {
+		/* from dscaler */
     		{ AUD_RATE_ADJ1,           0x00000010 },
     		{ AUD_RATE_ADJ2,           0x00000040 },
     		{ AUD_RATE_ADJ3,           0x00000100 },
@@ -152,21 +270,64 @@ static void set_audio_standard_NICAM(str
     		{ AUD_RATE_ADJ5,           0x00001000 },
     //		{ AUD_DMD_RA_DDS,          0x00c0d5ce },
 
+		// Deemphasis 1:
+		{ AUD_DEEMPHGAIN_R,        0x000023c2 },
+		{ AUD_DEEMPHNUMER1_R,      0x0002a7bc },
+		{ AUD_DEEMPHNUMER2_R,      0x0003023e },
+		{ AUD_DEEMPHDENOM1_R,      0x0000f3d0 },
+		{ AUD_DEEMPHDENOM2_R,      0x00000000 },
+		
+#if 0
+		// Deemphasis 2: (other tv norm?)
+		{ AUD_DEEMPHGAIN_R,        0x0000c600 },
+		{ AUD_DEEMPHNUMER1_R,      0x00066738 },
+		{ AUD_DEEMPHNUMER2_R,      0x00066739 },
+		{ AUD_DEEMPHDENOM1_R,      0x0001e88c },
+		{ AUD_DEEMPHDENOM2_R,      0x0001e88c },
+#endif
+
+		{ AUD_DEEMPHDENOM2_R,      0x00000000 },
+		{ AUD_ERRLOGPERIOD_R,      0x00000fff },
+		{ AUD_ERRINTRPTTHSHLD1_R,  0x000003ff },
+		{ AUD_ERRINTRPTTHSHLD2_R,  0x000000ff },
+		{ AUD_ERRINTRPTTHSHLD3_R,  0x0000003f },
+		{ AUD_POLYPH80SCALEFAC,    0x00000003 },
+
 		// setup QAM registers
 		{ AUD_PDF_DDS_CNST_BYTE2,  0x06 },
 		{ AUD_PDF_DDS_CNST_BYTE1,  0x82 },
 		{ AUD_PDF_DDS_CNST_BYTE0,  0x16 },
 		{ AUD_QAM_MODE,            0x05 },
+
+                { /* end of list */ },
+        };
+	static const struct rlist nicam_pal_i[] = {
+		{ AUD_PDF_DDS_CNST_BYTE0,  0x12 },
+		{ AUD_PHACC_FREQ_8MSB,     0x3a },
+		{ AUD_PHACC_FREQ_8LSB,     0x93 },
+
+                { /* end of list */ },
+	};
+	static const struct rlist nicam_default[] = {
+		{ AUD_PDF_DDS_CNST_BYTE0,  0x16 },
 		{ AUD_PHACC_FREQ_8MSB,     0x34 },
 		{ AUD_PHACC_FREQ_8LSB,     0x4c },
 
                 { /* end of list */ },
-        };
+	};
 
-	dprintk("%s (status: unknown)\n",__FUNCTION__);
         set_audio_start(dev, 0x0010,
-			EN_DMTRX_LR | EN_NICAM_FORCE_STEREO);
-        set_audio_registers(dev, nicam);
+			EN_DMTRX_LR | EN_DMTRX_BYPASS | EN_NICAM_AUTO_STEREO);
+        set_audio_registers(dev, nicam_common);
+	switch (dev->tvaudio) {
+	case WW_NICAM_I:
+		dprintk("%s PAL-I NICAM (status: unknown)\n",__FUNCTION__);
+		set_audio_registers(dev, nicam_pal_i);
+	case WW_NICAM_BGDKL:
+		dprintk("%s PAL NICAM (status: unknown)\n",__FUNCTION__);
+		set_audio_registers(dev, nicam_default);
+		break;
+	};
         set_audio_finish(dev);
 }
 
@@ -185,104 +346,104 @@ static void set_audio_standard_NICAM_L(s
 		{ AUD_PHACC_FREQ_8LSB,             0x4a },
 
 		{ AUD_POLY0_DDS_CONSTANT,          0x000e4db2 },
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
+		{ AUD_IIR1_0_SEL,                  0x00000000 },                
+		{ AUD_IIR1_1_SEL,                  0x00000002 },                
+		{ AUD_IIR1_2_SEL,                  0x00000023 },                
+		{ AUD_IIR1_3_SEL,                  0x00000004 },                
+		{ AUD_IIR1_4_SEL,                  0x00000005 },                
+		{ AUD_IIR1_5_SEL,                  0x00000007 },                
+		{ AUD_IIR1_0_SHIFT,                0x00000007 },                
+		{ AUD_IIR1_1_SHIFT,                0x00000000 },              
+		{ AUD_IIR1_2_SHIFT,                0x00000000 },                
+		{ AUD_IIR1_3_SHIFT,                0x00000007 },              
+		{ AUD_IIR1_4_SHIFT,                0x00000007 },              
+		{ AUD_IIR1_5_SHIFT,                0x00000007 },              
+		{ AUD_IIR2_0_SEL,                  0x00000002 },              
 		{ AUD_IIR2_1_SEL,                  0x00000003 },
 		{ AUD_IIR2_2_SEL,                  0x00000004 },
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
+		{ AUD_IIR2_3_SEL,                  0x00000005 },         
+		{ AUD_IIR3_0_SEL,                  0x00000007 },         
+		{ AUD_IIR3_1_SEL,                  0x00000023 },         
+		{ AUD_IIR3_2_SEL,                  0x00000016 },         
+		{ AUD_IIR4_0_SHIFT,                0x00000000 },         
+		{ AUD_IIR4_1_SHIFT,                0x00000000 },         
+		{ AUD_IIR3_2_SHIFT,                0x00000002 },         
+		{ AUD_IIR4_0_SEL,                  0x0000001d },         
+		{ AUD_IIR4_1_SEL,                  0x00000019 },         
+		{ AUD_IIR4_2_SEL,                  0x00000008 },         
+		{ AUD_IIR4_0_SHIFT,                0x00000000 },         
+		{ AUD_IIR4_1_SHIFT,                0x00000007 },         
+		{ AUD_IIR4_2_SHIFT,                0x00000007 },         
+		{ AUD_IIR4_0_CA0,                  0x0003e57e },         
+		{ AUD_IIR4_0_CA1,                  0x00005e11 },         
+		{ AUD_IIR4_0_CA2,                  0x0003a7cf },         
+		{ AUD_IIR4_0_CB0,                  0x00002368 },     
+		{ AUD_IIR4_0_CB1,                  0x0003bf1b },         
+		{ AUD_IIR4_1_CA0,                  0x00006349 },         
+		{ AUD_IIR4_1_CA1,                  0x00006f27 },         
+		{ AUD_IIR4_1_CA2,                  0x0000e7a3 },         
 		{ AUD_IIR4_1_CB0,                  0x00005653 },
-		{ AUD_IIR4_1_CB1,                  0x0000cf97 },
-		{ AUD_IIR4_2_CA0,                  0x00006349 },
-		{ AUD_IIR4_2_CA1,                  0x00006f27 },
-		{ AUD_IIR4_2_CA2,                  0x0000e7a3 },
-		{ AUD_IIR4_2_CB0,                  0x00005653 },
-		{ AUD_IIR4_2_CB1,                  0x0000cf97 },
-		{ AUD_HP_MD_IIR4_1,                0x00000001 },
-		{ AUD_HP_PROG_IIR4_1,              0x0000001a },
+		{ AUD_IIR4_1_CB1,                  0x0000cf97 },         
+		{ AUD_IIR4_2_CA0,                  0x00006349 },         
+		{ AUD_IIR4_2_CA1,                  0x00006f27 },         
+		{ AUD_IIR4_2_CA2,                  0x0000e7a3 },         
+		{ AUD_IIR4_2_CB0,                  0x00005653 },         
+		{ AUD_IIR4_2_CB1,                  0x0000cf97 },         
+		{ AUD_HP_MD_IIR4_1,                0x00000001 },           
+		{ AUD_HP_PROG_IIR4_1,              0x0000001a },         
 		{ AUD_DN0_FREQ,                    0x00000000 },
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
+		{ AUD_DN1_FREQ,                    0x00003318 },         
+		{ AUD_DN1_SRC_SEL,                 0x00000017 },         
+		{ AUD_DN1_SHFT,                    0x00000007 },         
+		{ AUD_DN1_AFC,                     0x00000000 },         
+		{ AUD_DN1_FREQ_SHIFT,              0x00000000 },         
+		{ AUD_DN2_FREQ,                    0x00003551 },         
+		{ AUD_DN2_SRC_SEL,                 0x00000001 },         
+		{ AUD_DN2_SHFT,                    0x00000000 },         
+		{ AUD_DN2_AFC,                     0x00000002 },         
+		{ AUD_DN2_FREQ_SHIFT,              0x00000000 },         
+		{ AUD_PDET_SRC,                    0x00000014 },         
+		{ AUD_PDET_SHIFT,                  0x00000000 },         
+		{ AUD_DEEMPH0_SRC_SEL,             0x00000011 },         
+		{ AUD_DEEMPH1_SRC_SEL,             0x00000011 },         
+		{ AUD_DEEMPH0_SHIFT,               0x00000000 },         
+		{ AUD_DEEMPH1_SHIFT,               0x00000000 },         
+		{ AUD_DEEMPH0_G0,                  0x00007000 },         
+		{ AUD_DEEMPH0_A0,                  0x00000000 },         
+		{ AUD_DEEMPH0_B0,                  0x00000000 },         
+		{ AUD_DEEMPH0_A1,                  0x00000000 },         
+		{ AUD_DEEMPH0_B1,                  0x00000000 },         
+		{ AUD_DEEMPH1_G0,                  0x00007000 },         
+		{ AUD_DEEMPH1_A0,                  0x00000000 },         
+		{ AUD_DEEMPH1_B0,                  0x00000000 },         
+		{ AUD_DEEMPH1_A1,                  0x00000000 },         
+		{ AUD_DEEMPH1_B1,                  0x00000000 },         
+		{ AUD_DMD_RA_DDS,                  0x00f5c285 },         
+		{ AUD_RATE_ADJ1,                   0x00000100 },         
+		{ AUD_RATE_ADJ2,                   0x00000200 },         
+		{ AUD_RATE_ADJ3,                   0x00000300 },         
+		{ AUD_RATE_ADJ4,                   0x00000400 },         
+		{ AUD_RATE_ADJ5,                   0x00000500 },              
+		{ AUD_C2_UP_THR,                   0x00005400 },              
+		{ AUD_C2_LO_THR,                   0x00003000 },              
+		{ AUD_C1_UP_THR,                   0x00007000 },              
+		{ AUD_C2_LO_THR,                   0x00005400 },              
+		{ AUD_CTL,                         0x0000100c },    
+		{ AUD_DCOC_0_SRC,                  0x00000021 },        
+		{ AUD_DCOC_1_SRC,                  0x00000003 },      
+		{ AUD_DCOC1_SHIFT,                 0x00000000 },      
+		{ AUD_DCOC_1_SHIFT_IN0,            0x0000000a },          
+		{ AUD_DCOC_1_SHIFT_IN1,            0x00000008 },         
+		{ AUD_DCOC_PASS_IN,                0x00000000 },           
+		{ AUD_DCOC_2_SRC,                  0x0000001b },             
+		{ AUD_IIR4_0_SEL,                  0x0000001d },            
+		{ AUD_POLY0_DDS_CONSTANT,          0x000e4db2 },         
+		{ AUD_PHASE_FIX_CTL,               0x00000000 },        
 		{ AUD_CORDIC_SHIFT_1,              0x00000007 },
-		{ AUD_PLL_EN,                      0x00000000 },
+		{ AUD_PLL_EN,                      0x00000000 },        
 		{ AUD_PLL_PRESCALE,                0x00000002 },
-		{ AUD_PLL_INT,                     0x0000001e },
-		{ AUD_OUT1_SHIFT,                  0x00000000 },
+		{ AUD_PLL_INT,                     0x0000001e },            
+		{ AUD_OUT1_SHIFT,                  0x00000000 },          
 
 		{ /* end of list */ },
 	};
@@ -297,14 +458,14 @@ static void set_audio_standard_NICAM_L(s
 static void set_audio_standard_A2(struct cx8800_dev *dev)
 {
 	/* from dscaler cvs */
-	static const struct rlist a2[] = {
+	static const struct rlist a2_common[] = {
 		{ AUD_PDF_DDS_CNST_BYTE2,     0x06 },
 		{ AUD_PDF_DDS_CNST_BYTE1,     0x82 },
 		{ AUD_PDF_DDS_CNST_BYTE0,     0x12 },
 		{ AUD_QAM_MODE,		      0x05 },
 		{ AUD_PHACC_FREQ_8MSB,	      0x34 },
 		{ AUD_PHACC_FREQ_8LSB,	      0x4c },
-
+		
 		{ AUD_RATE_ADJ1,	0x00001000 },
 		{ AUD_RATE_ADJ2,	0x00002000 },
 		{ AUD_RATE_ADJ3,	0x00003000 },
@@ -347,16 +508,20 @@ static void set_audio_standard_A2(struct
 		{ AUD_RDSQ_SHIFT,	0x00000000 },
 		{ AUD_POLYPH80SCALEFAC,	0x00000001 },
 
-		// Table 1
+		{ /* end of list */ },
+	};
+	
+	static const struct rlist a2_table1[] = {
+		// PAL-BG
 		{ AUD_DMD_RA_DDS,	0x002a73bd },
 		{ AUD_C1_UP_THR,	0x00007000 },
 		{ AUD_C1_LO_THR,	0x00005400 },
 		{ AUD_C2_UP_THR,	0x00005400 },
 		{ AUD_C2_LO_THR,	0x00003000 },
-
-#if 0
-		// found this in WDM-driver for A2, must country spec.
-		// Table 2
+		{ /* end of list */ },
+	};
+	static const struct rlist a2_table2[] = {
+		// PAL-DK
 		{ AUD_DMD_RA_DDS,	0x002a73bd },
 		{ AUD_C1_UP_THR,	0x00007000 },
 		{ AUD_C1_LO_THR,	0x00005400 },
@@ -364,8 +529,10 @@ static void set_audio_standard_A2(struct
 		{ AUD_C2_LO_THR,	0x00003000 },
 		{ AUD_DN0_FREQ,		0x00003a1c },
 		{ AUD_DN2_FREQ,		0x0000d2e0 },
-
-		// Table 3
+		{ /* end of list */ },
+	};
+	static const struct rlist a2_table3[] = {
+		// unknown, probably NTSC-M
 		{ AUD_DMD_RA_DDS,	0x002a2873 },
 		{ AUD_C1_UP_THR,	0x00003c00 },
 		{ AUD_C1_LO_THR,	0x00003000 },
@@ -375,140 +542,26 @@ static void set_audio_standard_A2(struct
 		{ AUD_DN1_FREQ,		0x00003418 },
 		{ AUD_DN2_FREQ,		0x000029c7 },
 		{ AUD_POLY0_DDS_CONSTANT, 0x000a7540 },
-#endif
-
 		{ /* end of list */ },
 	};
 
-	static const struct rlist a2_old[] = {
-		{ AUD_DN0_FREQ,            0x0000312b },
-		{ AUD_POLY0_DDS_CONSTANT,  0x000a62b4 },
-		{ AUD_IIR1_0_SEL,          0x00000000 },
-		{ AUD_IIR1_1_SEL,          0x00000001 },
-		{ AUD_IIR1_2_SEL,          0x0000001f },
-		{ AUD_IIR1_3_SEL,          0x00000020 },
-		{ AUD_IIR1_4_SEL,          0x00000023 },
-		{ AUD_IIR1_5_SEL,          0x00000007 },
-		{ AUD_IIR1_0_SHIFT,        0x00000000 },
-		{ AUD_IIR1_1_SHIFT,        0x00000000 },
-		{ AUD_IIR1_2_SHIFT,        0x00000007 },
-		{ AUD_IIR1_3_SHIFT,        0x00000007 },
-		{ AUD_IIR1_4_SHIFT,        0x00000007 },
-		{ AUD_IIR1_5_SHIFT,        0x00000000 },
-		{ AUD_IIR2_0_SEL,          0x00000002 },
-		{ AUD_IIR2_1_SEL,          0x00000003 },
-		{ AUD_IIR2_2_SEL,          0x00000004 },
-		{ AUD_IIR2_3_SEL,          0x00000005 },
-		{ AUD_IIR3_0_SEL,          0x00000021 },
-		{ AUD_IIR3_1_SEL,          0x00000023 },
-		{ AUD_IIR3_2_SEL,          0x00000016 },
-		{ AUD_IIR3_0_SHIFT,        0x00000000 },
-		{ AUD_IIR3_1_SHIFT,        0x00000000 },
-		{ AUD_IIR3_2_SHIFT,        0x00000000 },
-		{ AUD_IIR4_0_SEL,          0x0000001d },
-		{ AUD_IIR4_1_SEL,          0x00000019 },
-		{ AUD_IIR4_2_SEL,          0x00000008 },
-		{ AUD_IIR4_0_SHIFT,        0x00000000 },
-		{ AUD_IIR4_1_SHIFT,        0x00000000 },
-		{ AUD_IIR4_2_SHIFT,        0x00000001 },
-		{ AUD_IIR4_0_CA0,          0x0003e57e },
-		{ AUD_IIR4_0_CA1,          0x00005e11 },
-		{ AUD_IIR4_0_CA2,          0x0003a7cf },
-		{ AUD_IIR4_0_CB0,          0x00002368 },
-		{ AUD_IIR4_0_CB1,          0x0003bf1b },
-		{ AUD_IIR4_1_CA0,          0x00006349 },
-		{ AUD_IIR4_1_CA1,          0x00006f27 },
-		{ AUD_IIR4_1_CA2,          0x0000e7a3 },
-		{ AUD_IIR4_1_CB0,          0x00005653 },
-		{ AUD_IIR4_1_CB1,          0x0000cf97 },
-		{ AUD_IIR4_2_CA0,          0x00006349 },
-		{ AUD_IIR4_2_CA1,          0x00006f27 },
-		{ AUD_IIR4_2_CA2,          0x0000e7a3 },
-		{ AUD_IIR4_2_CB0,          0x00005653 },
-		{ AUD_IIR4_2_CB1,          0x0000cf97 },
-		{ AUD_HP_MD_IIR4_1,        0x00000001 },
-		{ AUD_HP_PROG_IIR4_1,      0x00000017 },
-		{ AUD_DN1_FREQ,            0x00003618 },
-		{ AUD_DN1_SRC_SEL,         0x00000017 },
-		{ AUD_DN1_SHFT,            0x00000007 },
-		{ AUD_DN1_AFC,             0x00000000 },
-		{ AUD_DN1_FREQ_SHIFT,      0x00000000 },
-		{ AUD_DN2_SRC_SEL,         0x00000040 },
-		{ AUD_DN2_SHFT,            0x00000000 },
-		{ AUD_DN2_AFC,             0x00000002 },
-		{ AUD_DN2_FREQ,            0x0000caaf },
-		{ AUD_DN2_FREQ_SHIFT,      0x00000000 },
-		{ AUD_PDET_SRC,            0x00000014 },
-		{ AUD_PDET_SHIFT,          0x00000000 },
-		{ AUD_DEEMPH0_SRC_SEL,     0x00000011 },
-		{ AUD_DEEMPH1_SRC_SEL,     0x00000013 },
-		{ AUD_DEEMPH0_SHIFT,       0x00000000 },
-		{ AUD_DEEMPH1_SHIFT,       0x00000000 },
-		{ AUD_DEEMPH0_G0,          0x000004da },
-		{ AUD_DEEMPH0_A0,          0x0000777a },
-		{ AUD_DEEMPH0_B0,          0x00000000 },
-		{ AUD_DEEMPH0_A1,          0x0003f062 },
-		{ AUD_DEEMPH0_B1,          0x00000000 },
-		{ AUD_DEEMPH1_G0,          0x000004da },
-		{ AUD_DEEMPH1_A0,          0x0000777a },
-		{ AUD_DEEMPH1_B0,          0x00000000 },
-		{ AUD_DEEMPH1_A1,          0x0003f062 },
-		{ AUD_DEEMPH1_B1,          0x00000000 },
-		{ AUD_PLL_EN,              0x00000000 },
-		{ AUD_DMD_RA_DDS,          0x002a4efb },
-		{ AUD_RATE_ADJ1,           0x00001000 },
-		{ AUD_RATE_ADJ2,           0x00002000 },
-		{ AUD_RATE_ADJ3,           0x00003000 },
-		{ AUD_RATE_ADJ4,           0x00004000 },
-		{ AUD_RATE_ADJ5,           0x00005000 },
-		{ AUD_C2_UP_THR,           0x0000ffff },
-		{ AUD_C2_LO_THR,           0x0000e800 },
-		{ AUD_C1_UP_THR,           0x00008c00 },
-		{ AUD_C1_LO_THR,           0x00006c00 },
-
-		//   ; Completely ditch AFC feedback
-		{ AUD_DCOC_0_SRC,          0x00000021 },
-		{ AUD_DCOC_1_SRC,          0x0000001a },
-		{ AUD_DCOC1_SHIFT,         0x00000000 },
-		{ AUD_DCOC_1_SHIFT_IN0,    0x0000000a },
-		{ AUD_DCOC_1_SHIFT_IN1,    0x00000008 },
-		{ AUD_DCOC_PASS_IN,        0x00000000 },
-		{ AUD_IIR4_0_SEL,          0x00000023 },
-
-		//  ; Completely ditc FM-2 AFC feedback
-		{ AUD_DN1_AFC,             0x00000000 },
-		{ AUD_DCOC_2_SRC,          0x0000001b },
-		{ AUD_IIR4_1_SEL,          0x00000025 },
-
-		// ; WARNING!!! THIS CHANGE WAS NOT EXPECTED!!!
-		// ; Swap I & Q inputs into second rotator
-		// ; to reverse frequency and therefor invert
-		// ; phase from the cordic FM demodulator
-		// ; (frequency rotation must also be reversed
-		{ AUD_DN2_SRC_SEL,         0x00000001 },
-		{ AUD_DN2_FREQ,            0x00003551 },
-
-		//  setup Audio PLL
-		{ AUD_PLL_PRESCALE,        0x00000002 },
-		{ AUD_PLL_INT,             0x0000001f },
-
-		{ /* end of list */ },
+	set_audio_start(dev, 0x0004, EN_DMTRX_SUMDIFF | EN_A2_AUTO_STEREO);
+	set_audio_registers(dev, a2_common);
+	switch (dev->tvaudio) {
+	case WW_A2_BG:
+		dprintk("%s PAL-BG A2 (status: known-good)\n",__FUNCTION__);
+		set_audio_registers(dev, a2_table1);
+		break;
+	case WW_A2_DK:
+		dprintk("%s PAL-DK A2 (status: known-good)\n",__FUNCTION__);
+		set_audio_registers(dev, a2_table2);
+		break;
+	case WW_A2_M:
+		dprintk("%s NTSC-M A2 (status: unknown)\n",__FUNCTION__);
+		set_audio_registers(dev, a2_table3);
+		break;
 	};
-
-
-	dprintk("%s (status: WorksForMe[tm])\n",__FUNCTION__);
-
-	if (0) {
-		/* old code */
-		set_audio_start(dev, 0x0004, EN_DMTRX_SUMR | EN_A2_AUTO_STEREO);
-		set_audio_registers(dev, a2_old);
-		set_audio_finish(dev);
-	} else {
-		/* new code */
-		set_audio_start(dev, 0x0004, EN_DMTRX_LR | EN_A2_AUTO_STEREO);
-		set_audio_registers(dev, a2);
-		set_audio_finish(dev);
-	}
+	set_audio_finish(dev);
 }
 
 static void set_audio_standard_EIAJ(struct cx8800_dev *dev)
@@ -617,9 +670,9 @@ void cx88_get_stereo(struct cx8800_dev *
 	reg   = cx_read(AUD_STATUS);
 	mode  = reg & 0x03;
 	pilot = (reg >> 2) & 0x03;
-	dprintk("AUD_STATUS: %s / %s [status=0x%x,ctl=0x%x,vol=0x%x]\n",
-		m[mode], p[pilot], reg,
-		cx_read(AUD_CTL), cx_sread(SHADOW_AUD_VOL_CTL));
+	dprintk("AUD_STATUS: 0x%x [%s/%s] ctl=%s\n",
+		reg, m[mode], p[pilot],
+		aud_ctl_names[cx_read(AUD_CTL) & 63]);
 
 	t->capability = V4L2_TUNER_CAP_STEREO | V4L2_TUNER_CAP_SAP |
 		V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2;
@@ -628,6 +681,8 @@ void cx88_get_stereo(struct cx8800_dev *
 
 	switch (dev->tvaudio) {
 	case WW_A2_BG:
+	case WW_A2_DK:
+	case WW_A2_M:
  		if (1 == pilot) {
 			/* stereo */
 			t->rxsubchans = V4L2_TUNER_SUB_MONO | V4L2_TUNER_SUB_STEREO;
@@ -659,6 +714,8 @@ void cx88_set_stereo(struct cx8800_dev *
 
 	switch (dev->tvaudio) {
 	case WW_A2_BG:
+	case WW_A2_DK:
+	case WW_A2_M:
 		switch (mode) {
 		case V4L2_TUNER_MODE_MONO:   
 		case V4L2_TUNER_MODE_LANG1:
@@ -717,6 +774,32 @@ void cx88_set_stereo(struct cx8800_dev *
 	return;
 }
 
+/* just monitor the audio status for now ... */
+int cx88_audio_thread(void *data)
+{
+	struct cx8800_dev *dev = data;
+	struct v4l2_tuner t;
+	
+	daemonize("msp3400");
+	allow_signal(SIGTERM);
+	dprintk("cx88: tvaudio thread started\n");
+
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ*3);
+		if (signal_pending(current))
+			break;
+		if (dev->shutdown)
+			break;
+
+		memset(&t,0,sizeof(t));
+		cx88_get_stereo(dev,&t);
+	}
+
+	dprintk("cx88: tvaudio thread exiting\n");
+        complete_and_exit(&dev->texit, 0);
+}
+
 /*
  * Local variables:
  * c-basic-offset: 8
diff -up linux-2.6.7/drivers/media/video/cx88/cx88-vbi.c linux/drivers/media/video/cx88/cx88-vbi.c
--- linux-2.6.7/drivers/media/video/cx88/cx88-vbi.c	2004-06-17 10:28:57.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88-vbi.c	2004-06-17 13:47:59.797270159 +0200
@@ -28,17 +28,14 @@ void cx8800_vbi_fmt(struct cx8800_dev *d
 	f->fmt.vbi.count[0] = VBI_LINE_COUNT;
 	f->fmt.vbi.count[1] = VBI_LINE_COUNT;
 
-	switch (dev->tvnorm->id) {
-	case V4L2_STD_NTSC_M:
-	case V4L2_STD_NTSC_M_JP:
+	if (dev->tvnorm->id & V4L2_STD_525_60) {
+		/* ntsc */
 		f->fmt.vbi.sampling_rate = 28636363;
 		f->fmt.vbi.start[0] = 10 -1;
 		f->fmt.vbi.start[1] = 273 -1;
-		break;
-	case V4L2_STD_PAL_BG:
-	case V4L2_STD_PAL_DK:
-	case V4L2_STD_PAL_I:
-	case V4L2_STD_SECAM:
+
+	} else if (V4L2_STD_625_50) {
+		/* pal */
 		f->fmt.vbi.sampling_rate = 35468950;
 		f->fmt.vbi.start[0] = 7 -1;
 		f->fmt.vbi.start[1] = 319 -1;
@@ -64,10 +61,10 @@ int cx8800_start_vbi_dma(struct cx8800_d
 	/* enable irqs */
 	cx_set(MO_PCI_INTMSK, 0x00fc01);
 	cx_set(MO_VID_INTMSK, 0x0f0088);
-
+	
 	/* enable capture */
 	cx_set(VID_CAPTURE_CONTROL,0x18);
-
+	
 	/* start dma */
 	cx_set(MO_DEV_CNTRL2, (1<<5));
 	cx_set(MO_VID_DMACNTRL, 0x88);
@@ -80,7 +77,7 @@ int cx8800_restart_vbi_queue(struct cx88
 {
 	struct cx88_buffer *buf;
 	struct list_head *item;
-
+	
 	if (list_empty(&q->active))
 		return 0;
 
@@ -104,7 +101,7 @@ void cx8800_vbi_timeout(unsigned long da
 	unsigned long flags;
 
 	cx88_sram_channel_dump(dev, &cx88_sram_channels[SRAM_CH24]);
-
+	
 	cx_clear(MO_VID_DMACNTRL, 0x88);
 	cx_clear(VID_CAPTURE_CONTROL, 0x18);
 
@@ -161,7 +158,7 @@ vbi_prepare(struct file *file, struct vi
 		cx88_risc_buffer(dev->pci, &buf->risc,
 				 buf->vb.dma.sglist,
 				 0, buf->vb.width * buf->vb.height,
-				 buf->vb.width, 0,
+				 buf->vb.width, 0, 
 				 buf->vb.height);
 	}
 	buf->vb.state = STATE_PREPARED;
diff -up linux-2.6.7/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.7/drivers/media/video/cx88/cx88-video.c	2004-06-17 10:29:27.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88-video.c	2004-06-17 13:47:59.805268654 +0200
@@ -2,7 +2,7 @@
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
  *
- * (c) 2003 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
+ * (c) 2003-04 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -32,6 +30,8 @@
 
 #include "cx88.h"
 
+#define V4L2_I2C_CLIENTS 1
+
 MODULE_DESCRIPTION("v4l2 driver module for cx2388x based TV cards");
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
 MODULE_LICENSE("GPL");
@@ -194,8 +194,13 @@ static struct cx8800_tvnorm tvnorms[] = 
 		.cxiformat = VideoFormatPAL60,
 		.cxoformat = 0x181f0008,
 	},{
-		.name      = "SECAM",
-		.id        = V4L2_STD_SECAM,
+		.name      = "SECAM-L",
+		.id        = V4L2_STD_SECAM_L,
+		.cxiformat = VideoFormatSECAM,
+		.cxoformat = 0x181f0008,
+	},{
+		.name      = "SECAM-DK",
+		.id        = V4L2_STD_SECAM_DK,
 		.cxiformat = VideoFormatSECAM,
 		.cxoformat = 0x181f0008,
 	}
@@ -331,7 +336,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 		 */
 		.v = {
 			.id            = V4L2_CID_SATURATION,
-			.name          = "Saturation",
+			.name          = "Saturation", 
 			.minimum       = 0,
 			.maximum       = 0xff,
 			.step          = 1,
@@ -483,35 +488,38 @@ static int set_tvaudio(struct cx8800_dev
 	if (CX88_VMUX_TELEVISION != INPUT(dev->input)->type)
 		return 0;
 
-	switch (dev->tvnorm->id) {
-	case V4L2_STD_PAL_BG:
+	if (V4L2_STD_PAL_BG & dev->tvnorm->id) {
 		dev->tvaudio = nicam ? WW_NICAM_BGDKL : WW_A2_BG;
-		break;
-	case V4L2_STD_PAL_DK:
+
+	} else if (V4L2_STD_PAL_DK & dev->tvnorm->id) {
 		dev->tvaudio = nicam ? WW_NICAM_BGDKL : WW_A2_DK;
-		break;
-	case V4L2_STD_PAL_I:
+
+	} else if (V4L2_STD_PAL_I & dev->tvnorm->id) {
 		dev->tvaudio = WW_NICAM_I;
-		break;
-	case V4L2_STD_SECAM:
-		dev->tvaudio = WW_SYSTEM_L_AM;  /* FIXME: fr != ru */
-		break;
-	case V4L2_STD_NTSC_M:
+
+	} else if (V4L2_STD_SECAM_L & dev->tvnorm->id) {
+		dev->tvaudio = WW_SYSTEM_L_AM;
+
+	} else if (V4L2_STD_SECAM_DK & dev->tvnorm->id) {
+		dev->tvaudio = WW_A2_DK;
+
+	} else if ((V4L2_STD_NTSC_M & dev->tvnorm->id) ||
+		   (V4L2_STD_PAL_M  & dev->tvnorm->id)) {
 		dev->tvaudio = WW_BTSC;
-		break;
-	case V4L2_STD_NTSC_M_JP:
+
+	} else if (V4L2_STD_NTSC_M_JP & dev->tvnorm->id) {
 		dev->tvaudio = WW_EIAJ;
-		break;
-	default:
-		dprintk(1,"tvaudio support needs work for this tv norm [%s], sorry\n",
-			dev->tvnorm->name);
+
+	} else {
+		printk("%s: tvaudio support needs work for this tv norm [%s], sorry\n",
+		       dev->name, dev->tvnorm->name);
 		dev->tvaudio = 0;
 		return 0;
 	}
 
 	cx_andor(MO_AFECFG_IO, 0x1f, 0x0);
 	cx88_set_tvaudio(dev);
-	cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO);
+	// cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO);
 
 	cx_write(MO_AUDD_LNGTH, 128/8);  /* fifo size */
 	cx_write(MO_AUDR_LNGTH, 128/8);  /* fifo size */
@@ -526,7 +534,6 @@ static int set_tvnorm(struct cx8800_dev 
 	u32 vdec_clock;
 	u64 tmp64;
 	u32 bdelay,agcdelay,htotal;
-	struct video_channel c;
 	
 	dev->tvnorm = norm;
 	fsc8       = norm_fsc8(norm);
@@ -592,30 +599,43 @@ static int set_tvnorm(struct cx8800_dev 
 	set_tvaudio(dev);
 
 	// tell i2c chips
-	memset(&c,0,sizeof(c));
-	c.channel = dev->input;
-	c.norm = VIDEO_MODE_PAL;
-	if ((norm->id & (V4L2_STD_NTSC_M|V4L2_STD_NTSC_M_JP)))
-		c.norm = VIDEO_MODE_NTSC;
-	if (norm->id & V4L2_STD_SECAM)
-		c.norm = VIDEO_MODE_SECAM;
-	cx8800_call_i2c_clients(dev,VIDIOCSCHAN,&c);
+#ifdef V4L2_I2C_CLIENTS
+	cx8800_call_i2c_clients(dev,VIDIOC_S_STD,&norm->id);
+#else
+	{
+		struct video_channel c;
+		memset(&c,0,sizeof(c));
+		c.channel = dev->input;
+		c.norm = VIDEO_MODE_PAL;
+		if ((norm->id & (V4L2_STD_NTSC_M|V4L2_STD_NTSC_M_JP)))
+			c.norm = VIDEO_MODE_NTSC;
+		if (norm->id & V4L2_STD_SECAM)
+			c.norm = VIDEO_MODE_SECAM;
+		cx8800_call_i2c_clients(dev,VIDIOCSCHAN,&c);
+	}
+#endif
 
 	// done
 	return 0;
 }
 
 static int set_scale(struct cx8800_dev *dev, unsigned int width, unsigned int height,
-		     int interlaced)
+		     enum v4l2_field field)
 {
 	unsigned int swidth  = norm_swidth(dev->tvnorm);
 	unsigned int sheight = norm_maxh(dev->tvnorm);
 	u32 value;
 
-	dprintk(1,"set_scale: %dx%d [%s]\n", width, height, dev->tvnorm->name);
+	dprintk(1,"set_scale: %dx%d [%s%s,%s]\n", width, height,
+		V4L2_FIELD_HAS_TOP(field)    ? "T" : "",
+		V4L2_FIELD_HAS_BOTTOM(field) ? "B" : "",
+		dev->tvnorm->name);
+	if (!V4L2_FIELD_HAS_BOTH(field))
+		height *= 2;
 
 	// recalc H delay and scale registers
 	value = (width * norm_hdelay(dev->tvnorm)) / swidth;
+	value &= 0x3fe;
 	cx_write(MO_HDELAY_EVEN,  value);
 	cx_write(MO_HDELAY_ODD,   value);
 	dprintk(1,"set_scale: hdelay  0x%04x\n", value);
@@ -646,7 +666,7 @@ static int set_scale(struct cx8800_dev *
 	// setup filters
 	value = 0;
 	value |= (1 << 19);        // CFILT (default)
-	if (interlaced)
+	if (V4L2_FIELD_INTERLACED == field)
 		value |= (1 << 3); // VINT (interlaced vertical scaling)
 	if (width < 385)
 		value |= (1 << 0); // 3-tap interpolation
@@ -675,10 +695,12 @@ static int video_mux(struct cx8800_dev *
 
 	switch (INPUT(input)->type) {
 	case CX88_VMUX_SVIDEO:
-		cx_andor(MO_AFECFG_IO, 0x01, 0x01);
+		cx_set(MO_AFECFG_IO,    0x00000001);
+		cx_set(MO_INPUT_FORMAT, 0x00010010);
 		break;
 	default:
-		cx_andor(MO_AFECFG_IO, 0x01, 0x00);
+		cx_clear(MO_AFECFG_IO,    0x00000001);
+		cx_clear(MO_INPUT_FORMAT, 0x00010010);
 		break;
 	}
 	return 0;
@@ -693,7 +715,7 @@ static int start_video_dma(struct cx8800
 	/* setup fifo + format */
 	cx88_sram_channel_setup(dev, &cx88_sram_channels[SRAM_CH21],
 				buf->bpl, buf->risc.dma);
-	set_scale(dev, buf->vb.width, buf->vb.height, 1);
+	set_scale(dev, buf->vb.width, buf->vb.height, buf->vb.field);
 	cx_write(MO_COLOR_CTRL, buf->fmt->cxformat | ColorFormatGamma);
 
 	/* reset counter */
@@ -1350,6 +1372,9 @@ static int get_control(struct cx8800_dev
 	case V4L2_CID_AUDIO_BALANCE:
 		ctl->value = (value & 0x40) ? (value & 0x3f) : (0x40 - (value & 0x3f));
 		break;
+	case V4L2_CID_AUDIO_VOLUME:
+		ctl->value = 0x3f - (value & 0x3f);
+		break;
 	default:
 		ctl->value = ((value + (c->off << c->shift)) & c->mask) >> c->shift;
 		break;
@@ -1378,6 +1403,9 @@ static int set_control(struct cx8800_dev
 	case V4L2_CID_AUDIO_BALANCE:
 		value = (ctl->value < 0x40) ? (0x40 - ctl->value) : ctl->value;
 		break;
+	case V4L2_CID_AUDIO_VOLUME:
+		value = 0x3f - (ctl->value & 0x3f);
+		break;
 	case V4L2_CID_SATURATION:
 		/* special v_sat handling */
 		v_sat_value = ctl->value - (0x7f - 0x5a);
@@ -1409,7 +1437,7 @@ static void init_controls(struct cx8800_
 	};
 	static struct v4l2_control volume = {
 		.id    = V4L2_CID_AUDIO_VOLUME,
-		.value = 0,
+		.value = 0x3f,
 	};
 
 	set_control(dev,&mute);
@@ -1459,15 +1487,12 @@ static int cx8800_try_fmt(struct cx8800_
 		maxw  = norm_maxw(dev->tvnorm);
 		maxh  = norm_maxh(dev->tvnorm);
 
-#if 0
 		if (V4L2_FIELD_ANY == field) {
 			field = (f->fmt.pix.height > maxh/2)
 				? V4L2_FIELD_INTERLACED
 				: V4L2_FIELD_BOTTOM;
 		}
-#else
-		field = V4L2_FIELD_INTERLACED;
-#endif
+
 		switch (field) {
 		case V4L2_FIELD_TOP:
 		case V4L2_FIELD_BOTTOM:
@@ -1480,14 +1505,15 @@ static int cx8800_try_fmt(struct cx8800_
 		}
 
 		f->fmt.pix.field = field;
-		if (f->fmt.pix.width < 48)
-			f->fmt.pix.width = 48;
 		if (f->fmt.pix.height < 32)
 			f->fmt.pix.height = 32;
-		if (f->fmt.pix.width > maxw)
-			f->fmt.pix.width = maxw;
 		if (f->fmt.pix.height > maxh)
 			f->fmt.pix.height = maxh;
+		if (f->fmt.pix.width < 48)
+			f->fmt.pix.width = 48;
+		if (f->fmt.pix.width > maxw)
+			f->fmt.pix.width = maxw;
+		f->fmt.pix.width &= ~0x03;
 		f->fmt.pix.bytesperline =
 			(f->fmt.pix.width * fmt->depth) >> 3;
 		f->fmt.pix.sizeimage =
@@ -1783,7 +1809,11 @@ static int video_do_ioctl(struct inode *
 			return -EINVAL;
 		down(&dev->lock);
 		dev->freq = f->frequency;
+#ifdef V4L2_I2C_CLIENTS
+		cx8800_call_i2c_clients(dev,VIDIOC_S_FREQUENCY,f);
+#else
 		cx8800_call_i2c_clients(dev,VIDIOCSFREQ,&dev->freq);
+#endif
 		up(&dev->lock);
 		return 0;
 	}
@@ -1836,7 +1866,7 @@ static int video_do_ioctl(struct inode *
 	case VIDIOC_STREAMOFF:
 	{
 		int res = get_ressource(fh);
-
+		
 		err = videobuf_streamoff(file, get_queue(fh));
 		if (err < 0)
 			return err;
@@ -1885,7 +1915,6 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_G_TUNER:
 	{
 		struct v4l2_tuner *t = arg;
-		struct video_tuner vt;
 
 		if (t->index > 0)
 			return -EINVAL;
@@ -1895,9 +1924,16 @@ static int radio_do_ioctl(struct inode *
                 t->rangelow  = (int)(65*16);
                 t->rangehigh = (int)(108*16);
 		
-		memset(&vt,0,sizeof(vt));
-		cx8800_call_i2c_clients(dev,VIDIOCGTUNER,&vt);
-		t->signal = vt.signal;
+#ifdef V4L2_I2C_CLIENTS
+		cx8800_call_i2c_clients(dev,VIDIOC_G_TUNER,t);
+#else
+		{
+			struct video_tuner vt;
+			memset(&vt,0,sizeof(vt));
+			cx8800_call_i2c_clients(dev,VIDIOCGTUNER,&vt);
+			t->signal = vt.signal;
+		}
+#endif
 		return 0;
 	}
 	case VIDIOC_ENUMINPUT:
@@ -2281,11 +2317,6 @@ static void cx8800_unregister_video(stru
 	}
 }
 
-/* debug that damn oops ... */
-static unsigned int oops = 0;
-MODULE_PARM(oops,"i");
-#define OOPS(msg) if (oops) printk("%s: %s\n",__FUNCTION__,msg);
-
 static int __devinit cx8800_initdev(struct pci_dev *pci_dev,
 				    const struct pci_device_id *pci_id)
 {
@@ -2299,7 +2330,6 @@ static int __devinit cx8800_initdev(stru
 	memset(dev,0,sizeof(*dev));
 
 	/* pci init */
-	OOPS("pci init");
 	dev->pci = pci_dev;
 	if (pci_enable_device(pci_dev)) {
 		err = -EIO;
@@ -2308,7 +2338,6 @@ static int __devinit cx8800_initdev(stru
 	sprintf(dev->name,"cx%x[%d]",pci_dev->device,cx8800_devcount);
 
 	/* pci quirks */
-	OOPS("pci quirks");
 	cx88_pci_quirks(dev->name, dev->pci, &latency);
 	if (UNSET != latency) {
 		printk(KERN_INFO "%s: setting pci latency timer to %d\n",
@@ -2317,7 +2346,6 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* print pci info */
-	OOPS("pci info");
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
         pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
         printk(KERN_INFO "%s: found at %s, rev: %d, irq: %d, "
@@ -2333,14 +2361,15 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* board config */
-	OOPS("board config");
 	dev->board = card[cx8800_devcount];
 	for (i = 0; UNSET == dev->board  &&  i < cx88_idcount; i++) 
 		if (pci_dev->subsystem_vendor == cx88_subids[i].subvendor &&
 		    pci_dev->subsystem_device == cx88_subids[i].subdevice)
 			dev->board = cx88_subids[i].card;
-	if (UNSET == dev->board)
+	if (UNSET == dev->board) {
 		dev->board = CX88_BOARD_UNKNOWN;
+		cx88_card_list(dev);
+	}
         printk(KERN_INFO "%s: subsystem: %04x:%04x, board: %s [card=%d,%s]\n",
 	       dev->name,pci_dev->subsystem_vendor,
 	       pci_dev->subsystem_device,cx88_boards[dev->board].name,
@@ -2352,7 +2381,6 @@ static int __devinit cx8800_initdev(stru
 		dev->tuner_type = cx88_boards[dev->board].tuner_type;
 
 	/* get mmio */
-	OOPS("get mmio");
 	if (!request_mem_region(pci_resource_start(pci_dev,0),
 				pci_resource_len(pci_dev,0),
 				dev->name)) {
@@ -2366,7 +2394,6 @@ static int __devinit cx8800_initdev(stru
 	dev->bmmio = (u8*)dev->lmmio;
 
 	/* initialize driver struct */
-	OOPS("init structs");
         init_MUTEX(&dev->lock);
 	dev->slock = SPIN_LOCK_UNLOCKED;
 	dev->tvnorm = tvnorms;
@@ -2390,11 +2417,9 @@ static int __devinit cx8800_initdev(stru
 			  MO_VID_DMACNTRL,0x88,0x00);
 
 	/* initialize hardware */
-	OOPS("reset hardware");
 	cx8800_reset(dev);
 
 	/* get irq */
-	OOPS("install irq handler");
 	err = request_irq(pci_dev->irq, cx8800_irq,
 			  SA_SHIRQ | SA_INTERRUPT, dev->name, dev);
 	if (err < 0) {
@@ -2404,13 +2429,10 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* register i2c bus + load i2c helpers */
-	OOPS("i2c setup");
 	cx8800_i2c_init(dev);
-	OOPS("card setup");
 	cx88_card_setup(dev);
 
 	/* load and configure helper modules */
-	OOPS("configure i2c clients");
 	if (TUNER_ABSENT != dev->tuner_type)
 		request_module("tuner");
 	if (cx88_boards[dev->board].needs_tda9887)
@@ -2419,7 +2441,6 @@ static int __devinit cx8800_initdev(stru
 		cx8800_call_i2c_clients(dev,TUNER_SET_TYPE,&dev->tuner_type);
 
 	/* register v4l devices */
-	OOPS("register video");
 	dev->video_dev = vdev_init(dev,&cx8800_video_template,"video");
 	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
 				    video_nr[cx8800_devcount]);
@@ -2431,7 +2452,6 @@ static int __devinit cx8800_initdev(stru
 	printk(KERN_INFO "%s: registered device video%d [v4l2]\n",
 	       dev->name,dev->video_dev->minor & 0x1f);
 
-	OOPS("register vbi");
 	dev->vbi_dev = vdev_init(dev,&cx8800_vbi_template,"vbi");
 	err = video_register_device(dev->vbi_dev,VFL_TYPE_VBI,
 				    vbi_nr[cx8800_devcount]);
@@ -2444,7 +2464,6 @@ static int __devinit cx8800_initdev(stru
 	       dev->name,dev->vbi_dev->minor & 0x1f);
 
 	if (dev->has_radio) {
-		OOPS("register radio");
 		dev->radio_dev = vdev_init(dev,&cx8800_radio_template,"radio");
 		err = video_register_device(dev->radio_dev,VFL_TYPE_RADIO,
 					    radio_nr[cx8800_devcount]);
@@ -2458,32 +2477,31 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* everything worked */
-	OOPS("finalize");
 	list_add_tail(&dev->devlist,&cx8800_devlist);
 	pci_set_drvdata(pci_dev,dev);
 	cx8800_devcount++;
 
 	/* initial device configuration */
-	OOPS("init device");
 	down(&dev->lock);
 	init_controls(dev);
 	set_tvnorm(dev,tvnorms);
 	video_mux(dev,0);
 	up(&dev->lock);
+
+	/* start tvaudio thread */
+	init_completion(&dev->texit);
+	dev->tpid = kernel_thread(cx88_audio_thread, dev, 0);
 	return 0;
 
  fail3:
-	OOPS("fail3");
 	cx8800_unregister_video(dev);
 	if (0 == dev->i2c_rc)
 		i2c_bit_del_bus(&dev->i2c_adap);
 	free_irq(pci_dev->irq, dev);
  fail2:
-	OOPS("fail2");
 	release_mem_region(pci_resource_start(pci_dev,0),
 			   pci_resource_len(pci_dev,0));
  fail1:
-	OOPS("fail1");
 	kfree(dev);
 	return err;
 }
@@ -2492,6 +2510,11 @@ static void __devexit cx8800_finidev(str
 {
         struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
 
+	/* stop thread */
+	dev->shutdown = 1;
+	if (dev->tpid >= 0)
+		wait_for_completion(&dev->texit);
+
 	cx8800_shutdown(dev);
 	pci_disable_device(pci_dev);
 
diff -up linux-2.6.7/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.7/drivers/media/video/cx88/cx88.h	2004-06-17 10:31:18.000000000 +0200
+++ linux/drivers/media/video/cx88/cx88.h	2004-06-17 13:47:59.807268278 +0200
@@ -32,7 +32,7 @@
 #include "cx88-reg.h"
 
 #include <linux/version.h>
-#define CX88_VERSION_CODE KERNEL_VERSION(0,0,3)
+#define CX88_VERSION_CODE KERNEL_VERSION(0,0,4)
 
 #ifndef TRUE
 # define TRUE (1==1)
@@ -114,17 +114,20 @@ extern struct sram_channel cx88_sram_cha
 /* card configuration                                          */
 
 #define CX88_BOARD_NOAUTO        UNSET
-#define CX88_BOARD_UNKNOWN           0
-#define CX88_BOARD_HAUPPAUGE         1
-#define CX88_BOARD_GDI               2
-#define CX88_BOARD_PIXELVIEW         3
-#define CX88_BOARD_ATI_WONDER_PRO    4
-#define CX88_BOARD_WINFAST2000XP     5
-#define CX88_BOARD_AVERTV_303        6
-#define CX88_BOARD_MSI_TVANYWHERE    7
-#define CX88_BOARD_WINFAST_DV2000    8
-#define CX88_BOARD_LEADTEK_PVR2000   9
-
+#define CX88_BOARD_UNKNOWN               0
+#define CX88_BOARD_HAUPPAUGE             1
+#define CX88_BOARD_GDI                   2
+#define CX88_BOARD_PIXELVIEW             3
+#define CX88_BOARD_ATI_WONDER_PRO        4
+#define CX88_BOARD_WINFAST2000XP         5
+#define CX88_BOARD_AVERTV_303            6
+#define CX88_BOARD_MSI_TVANYWHERE_MASTER 7
+#define CX88_BOARD_WINFAST_DV2000        8
+#define CX88_BOARD_LEADTEK_PVR2000       9
+#define CX88_BOARD_IODATA_GVVCP3PCI      10
+#define CX88_BOARD_PROLINK_PLAYTVPVR     11
+#define CX88_BOARD_ASUS_PVR_416          12
+#define CX88_BOARD_MSI_TVANYWHERE        13
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
@@ -263,6 +266,9 @@ struct cx8800_dev {
 
 	/* other global state info */
 	u32                         shadow[SHADOW_MAX];
+	int                         shutdown;
+	pid_t                       tpid;
+	struct completion           texit;
 	struct cx8800_suspend_state state;
 };
 
@@ -351,7 +357,8 @@ extern const unsigned int cx88_bcount;
 extern struct cx88_subid cx88_subids[];
 extern const unsigned int cx88_idcount;
 
-extern void __devinit cx88_card_setup(struct cx8800_dev *dev);
+extern void cx88_card_list(struct cx8800_dev *dev);
+extern void cx88_card_setup(struct cx8800_dev *dev);
 
 /* ----------------------------------------------------------- */
 /* cx88-tvaudio.c                                              */
@@ -372,6 +379,7 @@ extern void __devinit cx88_card_setup(st
 void cx88_set_tvaudio(struct cx8800_dev *dev);
 void cx88_get_stereo(struct cx8800_dev *dev, struct v4l2_tuner *t);
 void cx88_set_stereo(struct cx8800_dev *dev, u32 mode);
+int cx88_audio_thread(void *data);
 
 /*
  * Local variables:

-- 
Smoking Crack Organization
