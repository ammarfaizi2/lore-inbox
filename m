Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUDEMpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUDEMpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:45:46 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:57507 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262325AbUDEMlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:41:45 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 14:33:39 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] cx88 update.
Message-ID: <20040405123339.GA30083@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the cx88 driver.  There are *lots* of changes:

  * vbi support was added.
  * plenty of fixes for audio support (there are still problems
    through).
  * new cards added.
  * serveral minor tweaks.

please apply,

  Gerd

diff -up linux-2.6.5/drivers/media/video/cx88/Makefile linux/drivers/media/video/cx88/Makefile
--- linux-2.6.5/drivers/media/video/cx88/Makefile	2004-04-05 10:39:31.257474664 +0200
+++ linux/drivers/media/video/cx88/Makefile	2004-04-05 10:49:59.012074060 +0200
@@ -1,5 +1,5 @@
 cx88xx-objs	:= cx88-cards.o cx88-core.o
-cx8800-objs	:= cx88-video.o cx88-tvaudio.o cx88-i2c.o
+cx8800-objs	:= cx88-video.o cx88-tvaudio.o cx88-i2c.o cx88-vbi.o
 
 obj-$(CONFIG_VIDEO_CX88) += cx88xx.o cx8800.o
 
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.5/drivers/media/video/cx88/cx88-cards.c	2004-04-05 10:42:28.982940319 +0200
+++ linux/drivers/media/video/cx88/cx88-cards.c	2004-04-05 10:49:59.017073118 +0200
@@ -52,16 +52,19 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-			//.gpio0  = 0xff03,
-			.gpio0  = 0xff01,
+			.gpio0  = 0xff00,  // internal decoder
 		},{
 			.type   = CX88_VMUX_DEBUG,
 			.vmux   = 0,
-			.gpio0  = 0xff00,
+			.gpio0  = 0xff01,  // mono from tuner chip
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
 			.gpio0  = 0xff02,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0xff02,
 		}},
 		.radio = {
 			.type   = CX88_RADIO,
@@ -92,21 +95,50 @@ struct cx88_board cx88_boards[] = {
 	},
 	[CX88_BOARD_ATI_WONDER_PRO] = {
 		.name           = "ATI TV Wonder Pro",
-		.tuner_type     = UNSET,
+		.tuner_type     = 44,
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+
 		}},
 	},
         [CX88_BOARD_WINFAST2000XP] = {
                 .name           = "Leadtek Winfast 2000XP Expert",
-                .tuner_type     = 38,
+                .tuner_type     = 44,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
+			.gpio0	= 0x00F5e700,
+			.gpio1  = 0x00003004,
+			.gpio2  = 0x00F5e700,
+			.gpio3  = 0x02000000,
+		},{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0	= 0x00F5c700,
+			.gpio1  = 0x00003004,
+			.gpio2  = 0x00F5c700,
+			.gpio3  = 0x02000000,
+		},{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0	= 0x00F5c700,
+			.gpio1  = 0x00003004,
+			.gpio2  = 0x00F5c700,
+			.gpio3  = 0x02000000,
                 }},
                 .radio = {
                         .type   = CX88_RADIO,
+			.gpio0	= 0x00F5d700,
+			.gpio1  = 0x00003004,
+			.gpio2  = 0x00F5d700,
+			.gpio3  = 0x02000000,
                 },
         },
 	[CX88_BOARD_AVERTV_303] = {
@@ -127,6 +159,10 @@ struct cx88_board cx88_boards[] = {
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
 		},{
+			 // temporarly for testing ...
+                        .type   = CX88_VMUX_COMPOSITE2,
+                        .vmux   = 2,
+		},{
                         .type   = CX88_VMUX_SVIDEO,
                         .vmux   = 2,
                 }},
@@ -137,6 +173,7 @@ struct cx88_board cx88_boards[] = {
 	[CX88_BOARD_WINFAST_DV2000] = {
                 .name           = "Leadtek Winfast DV2000",
                 .tuner_type     = 38,
+		.needs_tda9887  = 1,
                 .input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
@@ -145,6 +182,24 @@ struct cx88_board cx88_boards[] = {
                         .type   = CX88_RADIO,
                 },
         },
+        [CX88_BOARD_LEADTEK_PVR2000] = {
+                .name           = "Leadtek PVR 2000",
+                .tuner_type     = 38,
+                .input          = {{
+                        .type   = CX88_VMUX_TELEVISION,
+                        .vmux   = 0,
+                },{
+                        .type   = CX88_VMUX_COMPOSITE1,
+                        .vmux   = 1,
+                },{
+                        .type   = CX88_VMUX_SVIDEO,
+                        .vmux   = 2,
+                }},
+                .radio = {
+                        .type   = CX88_RADIO,
+                },
+        },
+
 
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
@@ -178,10 +233,18 @@ struct cx88_subid cx88_subids[] = {
                 .subdevice = 0x6611,
                 .card      = CX88_BOARD_WINFAST2000XP,
 	},{
+                .subvendor = 0x107d,
+                .subdevice = 0x6613,	/* NTSC */
+                .card      = CX88_BOARD_WINFAST2000XP,
+	},{
 		.subvendor = 0x107d,
                 .subdevice = 0x6620,
                 .card      = CX88_BOARD_WINFAST_DV2000,
         },{
+                .subvendor = 0x107d,
+                .subdevice = 0x663C,
+                .card      = CX88_BOARD_LEADTEK_PVR2000,
+        },{
 		.subvendor = 0x1461,
 		.subdevice = 0x000b,
 		.card      = CX88_BOARD_AVERTV_303,
@@ -193,6 +256,34 @@ struct cx88_subid cx88_subids[] = {
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
 
+
+/* ----------------------------------------------------------------------- */
+/* some leadtek specific stuff                                             */
+
+static void __devinit leadtek_eeprom(struct cx8800_dev *dev, u8 *eeprom_data)
+{
+	/* This is just for the Winfast 2000 XP board ATM; I don't have data on
+	 * any others.
+	 *
+	 * Byte 0 is 1 on the NTSC board.
+	 */
+
+	if (eeprom_data[4] != 0x7d ||
+	    eeprom_data[5] != 0x10 || 
+	    eeprom_data[7] != 0x66) {
+		printk(KERN_WARNING "%s Leadtek eeprom invalid.\n", dev->name);
+		return;
+	}
+
+	dev->has_radio  = 1;
+	dev->tuner_type = (eeprom_data[6] == 0x13) ? 43 : 38;
+	
+	printk(KERN_INFO "%s: Leadtek Winfast 2000 XP config: "
+	       "tuner=%d, eeprom[0]=0x%02x\n",
+	       dev->name, dev->tuner_type, eeprom_data[0]);
+}
+
+
 /* ----------------------------------------------------------------------- */
 /* some hauppauge specific stuff                                           */
 
@@ -378,6 +469,11 @@ void __devinit cx88_card_setup(struct cx
 			i2c_eeprom(&dev->i2c_client,eeprom,sizeof(eeprom));
 		gdi_eeprom(dev,eeprom);
 		break;
+	case CX88_BOARD_WINFAST2000XP:
+		if (0 == dev->i2c_rc)
+			i2c_eeprom(&dev->i2c_client,eeprom,sizeof(eeprom));
+		leadtek_eeprom(dev,eeprom);
+		break;
 	}
 }
 
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-core.c linux/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.5/drivers/media/video/cx88/cx88-core.c	2004-04-05 10:39:53.528272081 +0200
+++ linux/drivers/media/video/cx88/cx88-core.c	2004-04-05 10:49:59.022072176 +0200
@@ -100,15 +100,6 @@ static const char *v4l2_ioctls[] = {
 };
 #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
 
-static const char *osspcm_ioctls[] = {
-	"RESET", "SYNC", "SPEED", "STEREO", "GETBLKSIZE", "SETFMT",
-	"CHANNELS", "?", "POST", "SUBDIVIDE", "SETFRAGMENT", "GETFMTS",
-	"GETOSPACE", "GETISPACE", "NONBLOCK", "GETCAPS", "GET/SETTRIGGER",
-	"GETIPTR", "GETOPTR", "MAPINBUF", "MAPOUTBUF", "SETSYNCRO",
-	"SETDUPLEX", "GETODELAY"
-};
-#define OSSPCM_IOCTLS ARRAY_SIZE(v4l2_ioctls)
-
 void cx88_print_ioctl(char *name, unsigned int cmd)
 {
 	char *dir;
@@ -131,15 +122,6 @@ void cx88_print_ioctl(char *name, unsign
 		       name, cmd, dir, (_IOC_NR(cmd) < V4L2_IOCTLS) ?
 		       v4l2_ioctls[_IOC_NR(cmd)] : "???");
 		break;
-	case 'P':
-		printk(KERN_DEBUG "%s: ioctl 0x%08x (oss dsp, %s, SNDCTL_DSP_%s)\n",
-		       name, cmd, dir, (_IOC_NR(cmd) < OSSPCM_IOCTLS) ?
-		       osspcm_ioctls[_IOC_NR(cmd)] : "???");
-		break;
-	case 'M':
-		printk(KERN_DEBUG "%s: ioctl 0x%08x (oss mixer, %s, #%d)\n",
-		       name, cmd, dir, _IOC_NR(cmd));
-		break;
 	default:
 		printk(KERN_DEBUG "%s: ioctl 0x%08x (???, %s, #%d)\n",
 		       name, cmd, dir, _IOC_NR(cmd));
@@ -296,6 +278,7 @@ struct sram_channel cx88_sram_channels[]
 		.name       = "video y / packed",
 		.cmds_start = 0x180040,
 		.ctrl_start = 0x180400,
+	        .cdt        = 0x180400 + 64,
 		.fifo_start = 0x180c00,
 		.fifo_size  = 0x002800,
 		.ptr1_reg   = MO_DMA21_PTR1,
@@ -307,6 +290,7 @@ struct sram_channel cx88_sram_channels[]
 		.name       = "video u",
 		.cmds_start = 0x180080,
 		.ctrl_start = 0x1804a0,
+	        .cdt        = 0x1804a0 + 64,
 		.fifo_start = 0x183400,
 		.fifo_size  = 0x000800,
 		.ptr1_reg   = MO_DMA22_PTR1,
@@ -318,6 +302,7 @@ struct sram_channel cx88_sram_channels[]
 		.name       = "video v",
 		.cmds_start = 0x1800c0,
 		.ctrl_start = 0x180540,
+	        .cdt        = 0x180540 + 64,
 		.fifo_start = 0x183c00,
 		.fifo_size  = 0x000800,
 		.ptr1_reg   = MO_DMA23_PTR1,
@@ -329,6 +314,7 @@ struct sram_channel cx88_sram_channels[]
 		.name       = "vbi",
 		.cmds_start = 0x180100,
 		.ctrl_start = 0x1805e0,
+	        .cdt        = 0x1805e0 + 64,
 		.fifo_start = 0x184400,
 		.fifo_size  = 0x001000,
 		.ptr1_reg   = MO_DMA24_PTR1,
@@ -340,6 +326,7 @@ struct sram_channel cx88_sram_channels[]
 		.name       = "audio from",
 		.cmds_start = 0x180140,
 		.ctrl_start = 0x180680,
+	        .cdt        = 0x180680 + 64,
 		.fifo_start = 0x185400,
 		.fifo_size  = 0x000200,
 		.ptr1_reg   = MO_DMA25_PTR1,
@@ -351,8 +338,9 @@ struct sram_channel cx88_sram_channels[]
 		.name       = "audio to",
 		.cmds_start = 0x180180,
 		.ctrl_start = 0x180720,
-		.fifo_start = 0x185600,
-		.fifo_size  = 0x000200,
+	        .cdt        = 0x180680 + 64,  /* same as audio IN */
+		.fifo_start = 0x185400,       /* same as audio IN */
+		.fifo_size  = 0x000200,       /* same as audio IN */
 		.ptr1_reg   = MO_DMA26_PTR1,
 		.ptr2_reg   = MO_DMA26_PTR2,
 		.cnt1_reg   = MO_DMA26_CNT1,
@@ -368,7 +356,7 @@ int cx88_sram_channel_setup(struct cx880
 	u32 cdt;
 
 	bpl   = (bpl + 7) & ~7; /* alignment */
-	cdt   = ch->ctrl_start + 64;
+	cdt   = ch->cdt;
 	lines = ch->fifo_size / bpl;
 	if (lines > 6)
 		lines = 6;
@@ -429,13 +417,13 @@ int cx88_risc_decode(u32 risc)
 	};
 	int i;
 
-	printk("0x%08x [ %s", risc, instr[risc >> 28] ?
-				instr[risc >> 28] : "INVALID");
+	printk("0x%08x [ %s", risc,
+	       instr[risc >> 28] ? instr[risc >> 28] : "INVALID");
 	for (i = ARRAY_SIZE(bits)-1; i >= 0; i--)
 		if (risc & (1 << (i + 12)))
 			printk(" %s",bits[i]);
 	printk(" count=%d ]\n", risc & 0xfff);
-	return incr[risc >> 28] ? 1 : incr[risc >> 28];
+	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
 void cx88_risc_disasm(struct cx8800_dev *dev,
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-i2c.c linux/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.5/drivers/media/video/cx88/cx88-i2c.c	2004-04-05 10:40:12.331723896 +0200
+++ linux/drivers/media/video/cx88/cx88-i2c.c	2004-04-05 10:49:59.025071610 +0200
@@ -152,7 +152,7 @@ int __devinit cx8800_i2c_init(struct cx8
 	       sizeof(dev->i2c_client));
 
 	dev->i2c_adap.dev.parent = &dev->pci->dev;
-	strcpy(dev->i2c_adap.name,dev->name);
+	strlcpy(dev->i2c_adap.name,dev->name,sizeof(dev->i2c_adap.name));
         dev->i2c_algo.data = dev;
         i2c_set_adapdata(&dev->i2c_adap,dev);
         dev->i2c_adap.algo_data = &dev->i2c_algo;
@@ -162,6 +162,8 @@ int __devinit cx8800_i2c_init(struct cx8
 	cx8800_bit_setsda(dev,1);
 
 	dev->i2c_rc = i2c_bit_add_bus(&dev->i2c_adap);
+	printk("%s: i2c register %s\n", dev->name,
+	       (0 == dev->i2c_rc) ? "ok" : "FAILED");
 	return dev->i2c_rc;
 }
 
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-reg.h linux/drivers/media/video/cx88/cx88-reg.h
--- linux-2.6.5/drivers/media/video/cx88/cx88-reg.h	2004-04-05 10:40:32.037005625 +0200
+++ linux/drivers/media/video/cx88/cx88-reg.h	2004-04-05 10:49:59.029070857 +0200
@@ -146,6 +146,8 @@
 #define MO_INPUT_FORMAT     0x310104
 #define MO_AGC_BURST        0x31010c
 #define MO_CONTR_BRIGHT     0x310110
+#define MO_UV_SATURATION    0x310114
+#define MO_HUE              0x310118
 #define MO_HTOTAL           0x310120
 #define MO_HDELAY_EVEN      0x310124
 #define MO_HDELAY_ODD       0x310128
@@ -175,6 +177,7 @@
 #define MO_VBI_PACKET       0x310188 // vbi packet size / delay
 #define MO_FIELD_COUNT      0x310190 // field counter
 #define MO_VIP_CONFIG       0x310194
+#define MO_VBOS_CONTROL	    0x3101a8
 
 #define MO_AGC_BACK_VBI     0x310200
 #define MO_AGC_SYNC_TIP1    0x310208
@@ -406,7 +409,7 @@
 #define AUD_PDF_DDS_CNST_BYTE1   0x320d02
 #define AUD_PDF_DDS_CNST_BYTE0   0x320d03
 #define AUD_PHACC_FREQ_8MSB      0x320d2a
-#define AUD_PHACC_FREQ_8LSB      0x320d23
+#define AUD_PHACC_FREQ_8LSB      0x320d2b
 #define AUD_QAM_MODE             0x320d04
 
 
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-tvaudio.c linux/drivers/media/video/cx88/cx88-tvaudio.c
--- linux-2.6.5/drivers/media/video/cx88/cx88-tvaudio.c	2004-04-05 10:40:27.843796851 +0200
+++ linux/drivers/media/video/cx88/cx88-tvaudio.c	2004-04-05 10:49:59.034069915 +0200
@@ -14,7 +14,7 @@
     Some of this comes from party done linux driver sources I got from
     [undocumented].
 
-    Some comes from the dscaler sources, the dscaler driver guy works
+    Some comes from the dscaler sources, one of the dscaler driver guy works
     for Conexant ...
     
     -----------------------------------------------------------------------
@@ -51,7 +51,7 @@
 
 #include "cx88.h"
 
-static unsigned int audio_debug = UNSET;
+static unsigned int audio_debug = 1;
 MODULE_PARM(audio_debug,"i");
 MODULE_PARM_DESC(audio_debug,"enable debug messages [audio]");
 
@@ -70,30 +70,81 @@ static void set_audio_registers(struct c
 {
 	int i;
 
-	for (i = 0; l[i].reg; i++)
-		cx_write(l[i].reg, l[i].val);
+	for (i = 0; l[i].reg; i++) {
+		switch (l[i].reg) {
+		case AUD_PDF_DDS_CNST_BYTE2:
+		case AUD_PDF_DDS_CNST_BYTE1:
+		case AUD_PDF_DDS_CNST_BYTE0:
+		case AUD_QAM_MODE:
+		case AUD_PHACC_FREQ_8MSB:
+		case AUD_PHACC_FREQ_8LSB:
+			cx_writeb(l[i].reg, l[i].val);
+			break;
+		default:
+			cx_write(l[i].reg, l[i].val);
+			break;
+		}
+	}
+}
+
+static void set_audio_start(struct cx8800_dev *dev,
+			    u32 mode, u32 ctl)
+{
+	// mute
+	cx_write(AUD_VOL_CTL,       (1 << 6));
+
+	//  increase level of input by 12dB
+	cx_write(AUD_AFE_12DB_EN,   0x0001);
+
+	// start programming
+	cx_write(AUD_CTL,           0x0000);
+	cx_write(AUD_INIT,          mode);
+	cx_write(AUD_INIT_LD,       0x0001);
+	cx_write(AUD_SOFT_RESET,    0x0001);
+
+	cx_write(AUD_CTL,           ctl);
+}
+
+static void set_audio_finish(struct cx8800_dev *dev)
+{
+	u32 volume;
+
+	// finish programming
+	cx_write(AUD_SOFT_RESET, 0x0000);
+
+	// start audio processing
+	cx_set(AUD_CTL, EN_DAC_ENABLE);
+
+	// unmute
+	volume = cx_sread(SHADOW_AUD_VOL_CTL);
+	cx_swrite(SHADOW_AUD_VOL_CTL, AUD_VOL_CTL, volume);
 }
 
+/* ----------------------------------------------------------- */
+
 static void set_audio_standard_BTSC(struct cx8800_dev *dev, unsigned int sap)
 {
-	dprintk("set_audio_standard_BTSC() [TODO]\n");
+	static const struct rlist btsc[] = {
+		/* Magic stuff from leadtek driver + datasheet.*/
+		{ AUD_DBX_IN_GAIN,   0x4734 },
+		{ AUD_DBX_WBE_GAIN,  0x4640 },
+		{ AUD_DBX_SE_GAIN,   0x8D31 },
+		{ AUD_DEEMPH0_G0,    0x1604 },
+		{ AUD_PHASE_FIX_CTL, 0x0020 },
+
+                { /* end of list */ },
+	};
+
+	dprintk("%s (status: unknown)\n",__FUNCTION__);
+	set_audio_start(dev, 0x0001,
+			EN_BTSC_AUTO_STEREO);
+        set_audio_registers(dev, btsc);
+	set_audio_finish(dev);
 }
 
 static void set_audio_standard_NICAM(struct cx8800_dev *dev)
 {
 	static const struct rlist nicam[] = {
-		//  increase level of input by 12dB
-		{ AUD_AFE_12DB_EN,         0x00000001 },
-
-    		// initialize NICAM                 
-    		{ AUD_INIT,                0x00000010 },
-    		{ AUD_INIT_LD,             0x00000001 },
-    		{ AUD_SOFT_RESET,          0x00000001 },
-    
-   		// WARNING!!!! Stereo mode is FORCED!!!!
-    		{ AUD_CTL,                 EN_DAC_ENABLE | EN_DMTRX_LR | EN_NICAM_FORCE_STEREO },
-    
-    		{ AUD_SOFT_RESET,          0x00000001 },
     		{ AUD_RATE_ADJ1,           0x00000010 },
     		{ AUD_RATE_ADJ2,           0x00000040 },
     		{ AUD_RATE_ADJ3,           0x00000100 },
@@ -101,43 +152,235 @@ static void set_audio_standard_NICAM(str
     		{ AUD_RATE_ADJ5,           0x00001000 },
     //		{ AUD_DMD_RA_DDS,          0x00c0d5ce },
 
+		// setup QAM registers
+		{ AUD_PDF_DDS_CNST_BYTE2,  0x06 },
+		{ AUD_PDF_DDS_CNST_BYTE1,  0x82 },
+		{ AUD_PDF_DDS_CNST_BYTE0,  0x16 },
+		{ AUD_QAM_MODE,            0x05 },
+		{ AUD_PHACC_FREQ_8MSB,     0x34 },
+		{ AUD_PHACC_FREQ_8LSB,     0x4c },
+
                 { /* end of list */ },
         };
 
-        printk("set_audio_standard_NICAM()\n");
+	dprintk("%s (status: unknown)\n",__FUNCTION__);
+        set_audio_start(dev, 0x0010,
+			EN_DMTRX_LR | EN_NICAM_FORCE_STEREO);
         set_audio_registers(dev, nicam);
+        set_audio_finish(dev);
+}
 
-    	// setup QAM registers
-    	cx_write(0x320d01,                0x06);
-    	cx_write(0x320d02,                0x82);
-    	cx_write(0x320d03,                0x16);
-    	cx_write(0x320d04,                0x05);
-    	cx_write(0x320d2a,                0x34);
-    	cx_write(0x320d2b,                0x4c);
-
-    	// setup Audio PLL
-    	//cx_write(AUD_PLL_PRESCALE,        0x0002);
-    	//cx_write(AUD_PLL_INT,             0x001f);
+static void set_audio_standard_NICAM_L(struct cx8800_dev *dev)
+{
+	/* This is officially wierd.. register dumps indicate windows
+	 * uses audio mode 4.. A2. Let's operate and find out. */
 
-    	// de-assert Audio soft reset
-    	cx_write(AUD_SOFT_RESET,          0x00000000);  // Causes a pop every time
+	static const struct rlist nicam_l[] = {
+		// setup QAM registers
+		{ AUD_PDF_DDS_CNST_BYTE2,	   0x48 },
+		{ AUD_PDF_DDS_CNST_BYTE1,          0x3d },
+		{ AUD_PDF_DDS_CNST_BYTE0,          0xf5 },
+		{ AUD_QAM_MODE,                    0x00 },
+		{ AUD_PHACC_FREQ_8MSB,             0x3a },
+		{ AUD_PHACC_FREQ_8LSB,             0x4a },
+
+		{ AUD_POLY0_DDS_CONSTANT,          0x000e4db2 },
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
+		{ AUD_IIR2_1_SEL,                  0x00000003 },
+		{ AUD_IIR2_2_SEL,                  0x00000004 },
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
+		{ AUD_IIR4_1_CB0,                  0x00005653 },
+		{ AUD_IIR4_1_CB1,                  0x0000cf97 },         
+		{ AUD_IIR4_2_CA0,                  0x00006349 },         
+		{ AUD_IIR4_2_CA1,                  0x00006f27 },         
+		{ AUD_IIR4_2_CA2,                  0x0000e7a3 },         
+		{ AUD_IIR4_2_CB0,                  0x00005653 },         
+		{ AUD_IIR4_2_CB1,                  0x0000cf97 },         
+		{ AUD_HP_MD_IIR4_1,                0x00000001 },           
+		{ AUD_HP_PROG_IIR4_1,              0x0000001a },         
+		{ AUD_DN0_FREQ,                    0x00000000 },
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
+		{ AUD_CORDIC_SHIFT_1,              0x00000007 },
+		{ AUD_PLL_EN,                      0x00000000 },        
+		{ AUD_PLL_PRESCALE,                0x00000002 },
+		{ AUD_PLL_INT,                     0x0000001e },            
+		{ AUD_OUT1_SHIFT,                  0x00000000 },          
+
+		{ /* end of list */ },
+	};
+
+	dprintk("%s (status: unknown)\n",__FUNCTION__);
+        set_audio_start(dev, 0x0004,
+			0 /* FIXME */);
+	set_audio_registers(dev, nicam_l);
+        set_audio_finish(dev);
 }
 
 static void set_audio_standard_A2(struct cx8800_dev *dev)
 {
+	/* from dscaler cvs */
 	static const struct rlist a2[] = {
-		//  increase level of input by 12dB
-		{ AUD_AFE_12DB_EN,         0x00000001 },
+		{ AUD_PDF_DDS_CNST_BYTE2,     0x06 },
+		{ AUD_PDF_DDS_CNST_BYTE1,     0x82 },
+		{ AUD_PDF_DDS_CNST_BYTE0,     0x12 },
+		{ AUD_QAM_MODE,		      0x05 },
+		{ AUD_PHACC_FREQ_8MSB,	      0x34 },
+		{ AUD_PHACC_FREQ_8LSB,	      0x4c },
+		
+		{ AUD_RATE_ADJ1,	0x00001000 },
+		{ AUD_RATE_ADJ2,	0x00002000 },
+		{ AUD_RATE_ADJ3,	0x00003000 },
+		{ AUD_RATE_ADJ4,	0x00004000 },
+		{ AUD_RATE_ADJ5,	0x00005000 },
+		{ AUD_THR_FR,		0x00000000 },
+		{ AAGC_HYST,		0x0000001a },
+		{ AUD_PILOT_BQD_1_K0,	0x0000755b },
+		{ AUD_PILOT_BQD_1_K1,	0x00551340 },
+		{ AUD_PILOT_BQD_1_K2,	0x006d30be },
+		{ AUD_PILOT_BQD_1_K3,	0xffd394af },
+		{ AUD_PILOT_BQD_1_K4,	0x00400000 },
+		{ AUD_PILOT_BQD_2_K0,	0x00040000 },
+		{ AUD_PILOT_BQD_2_K1,	0x002a4841 },
+		{ AUD_PILOT_BQD_2_K2,	0x00400000 },
+		{ AUD_PILOT_BQD_2_K3,	0x00000000 },
+		{ AUD_PILOT_BQD_2_K4,	0x00000000 },
+		{ AUD_MODE_CHG_TIMER,	0x00000040 },
+		{ AUD_START_TIMER,	0x00000200 },
+		{ AUD_AFE_12DB_EN,	0x00000000 },
+		{ AUD_CORDIC_SHIFT_0,	0x00000007 },
+		{ AUD_CORDIC_SHIFT_1,	0x00000007 },
+		{ AUD_DEEMPH0_G0,	0x00000380 },
+		{ AUD_DEEMPH1_G0,	0x00000380 },
+		{ AUD_DCOC_0_SRC,	0x0000001a },
+		{ AUD_DCOC0_SHIFT,	0x00000000 },
+		{ AUD_DCOC_0_SHIFT_IN0,	0x0000000a },
+		{ AUD_DCOC_0_SHIFT_IN1,	0x00000008 },
+		{ AUD_DCOC_PASS_IN,	0x00000003 },
+		{ AUD_IIR3_0_SEL,	0x00000021 },
+		{ AUD_DN2_AFC,		0x00000002 },
+		{ AUD_DCOC_1_SRC,	0x0000001b },
+		{ AUD_DCOC1_SHIFT,	0x00000000 },
+		{ AUD_DCOC_1_SHIFT_IN0,	0x0000000a },
+		{ AUD_DCOC_1_SHIFT_IN1,	0x00000008 },
+		{ AUD_IIR3_1_SEL,	0x00000023 },
+		{ AUD_RDSI_SEL,		0x00000017 },
+		{ AUD_RDSI_SHIFT,	0x00000000 },
+		{ AUD_RDSQ_SEL,		0x00000017 },
+		{ AUD_RDSQ_SHIFT,	0x00000000 },
+		{ AUD_POLYPH80SCALEFAC,	0x00000001 },
+		
+		// Table 1
+		{ AUD_DMD_RA_DDS,	0x002a73bd },
+		{ AUD_C1_UP_THR,	0x00007000 },
+		{ AUD_C1_LO_THR,	0x00005400 },
+		{ AUD_C2_UP_THR,	0x00005400 },
+		{ AUD_C2_LO_THR,	0x00003000 },
+
+#if 0
+		// found this in WDM-driver for A2, must country spec.
+		// Table 2
+		{ AUD_DMD_RA_DDS,	0x002a73bd },
+		{ AUD_C1_UP_THR,	0x00007000 },
+		{ AUD_C1_LO_THR,	0x00005400 },
+		{ AUD_C2_UP_THR,	0x00005400 },
+		{ AUD_C2_LO_THR,	0x00003000 },
+		{ AUD_DN0_FREQ,		0x00003a1c },
+		{ AUD_DN2_FREQ,		0x0000d2e0 },
+
+		// Table 3
+		{ AUD_DMD_RA_DDS,	0x002a2873 },
+		{ AUD_C1_UP_THR,	0x00003c00 },
+		{ AUD_C1_LO_THR,	0x00003000 },
+		{ AUD_C2_UP_THR,	0x00006000 },
+		{ AUD_C2_LO_THR,	0x00003c00 },
+		{ AUD_DN0_FREQ,		0x00002836 },
+		{ AUD_DN1_FREQ,		0x00003418 },
+		{ AUD_DN2_FREQ,		0x000029c7 },
+		{ AUD_POLY0_DDS_CONSTANT, 0x000a7540 },
+#endif
 
-		//  initialize A2
-		{ AUD_INIT,                0x00000004 },
-		{ AUD_INIT_LD,             0x00000001 },
-		{ AUD_SOFT_RESET,          0x00000001 },
-    
-		// ; WARNING!!! A2 STEREO DEMATRIX HAS TO BE
-		// ; SET MANUALLY!!!  Value sould be 0x100c
-		{ AUD_CTL, EN_DAC_ENABLE | EN_DMTRX_SUMR | EN_A2_AUTO_STEREO },
+		{ /* end of list */ },
+	};
 
+	static const struct rlist a2_old[] = {
 		{ AUD_DN0_FREQ,            0x0000312b },
 		{ AUD_POLY0_DDS_CONSTANT,  0x000a62b4 },
 		{ AUD_IIR1_0_SEL,          0x00000000 },
@@ -245,35 +488,45 @@ static void set_audio_standard_A2(struct
 		{ AUD_DN2_SRC_SEL,         0x00000001 },
 		{ AUD_DN2_FREQ,            0x00003551 },
 
-
 		//  setup Audio PLL
 		{ AUD_PLL_PRESCALE,        0x00000002 },
 		{ AUD_PLL_INT,             0x0000001f },
 
-		//  de-assert Audio soft reset
-		{ AUD_SOFT_RESET,          0x00000000 },
-
 		{ /* end of list */ },
 	};
 
-	dprintk("set_audio_standard_A2()\n");
-	set_audio_registers(dev, a2);
+
+	dprintk("%s (status: WorksForMe[tm])\n",__FUNCTION__);
+
+	if (0) {
+		/* old code */
+		set_audio_start(dev, 0x0004, EN_DMTRX_SUMR | EN_A2_AUTO_STEREO);
+		set_audio_registers(dev, a2_old);
+		set_audio_finish(dev);
+	} else {
+		/* new code */
+		set_audio_start(dev, 0x0004, EN_DMTRX_LR | EN_A2_AUTO_STEREO);
+		set_audio_registers(dev, a2);
+		set_audio_finish(dev);
+	}
 }
 
 static void set_audio_standard_EIAJ(struct cx8800_dev *dev)
 {
-	dprintk("set_audio_standard_EIAJ() [TODO]\n");
+	static const struct rlist eiaj[] = {
+		/* TODO: eiaj register settings are not there yet ... */
+
+		{ /* end of list */ },
+	};
+	dprintk("%s (status: unknown)\n",__FUNCTION__);
+
+	set_audio_start(dev, 0x0002, EN_EIAJ_AUTO_STEREO);
+	set_audio_registers(dev, eiaj);
+	set_audio_finish(dev);
 }
 
 static void set_audio_standard_FM(struct cx8800_dev *dev)
 {
-	dprintk("set_audio_standard_FM\n");
-
-	// initialize FM Radio
-	cx_write(AUD_INIT,0x0020);
-	cx_write(AUD_INIT_LD,0x0001);
-	cx_write(AUD_SOFT_RESET,0x0001);
-
 #if 0 /* FIXME */
 	switch (dev->audio_properties.FM_deemphasis)
 	{
@@ -311,19 +564,19 @@ static void set_audio_standard_FM(struct
 	}
 #endif
 
-	// de-assert Audio soft reset
-	cx_write(AUD_SOFT_RESET,0x0000);
+	dprintk("%s (status: unknown)\n",__FUNCTION__);
+	set_audio_start(dev, 0x0020, EN_FMRADIO_AUTO_STEREO);
 
 	// AB: 10/2/01: this register is not being reset appropriately on occasion.
 	cx_write(AUD_POLYPH80SCALEFAC,3);
+
+	set_audio_finish(dev);
 }
 
 /* ----------------------------------------------------------- */
 
 void cx88_set_tvaudio(struct cx8800_dev *dev)
 {
-	cx_write(AUD_CTL, 0x00);
-
 	switch (dev->tvaudio) {
 	case WW_BTSC:
 		set_audio_standard_BTSC(dev,0);
@@ -343,22 +596,21 @@ void cx88_set_tvaudio(struct cx8800_dev 
 	case WW_FM:
 		set_audio_standard_FM(dev);
 		break;
+	case WW_SYSTEM_L_AM:
+		set_audio_standard_NICAM_L(dev);
+		break;
 	case WW_NONE:
 	default:
 		printk("%s: unknown tv audio mode [%d]\n",
 		       dev->name, dev->tvaudio);
 		break;
 	}
-
-	// unmute
-	cx_set(AUD_CTL, EN_DAC_ENABLE);
-	cx_write(AUD_VOL_CTL, 0x00);
 	return;
 }
 
 void cx88_get_stereo(struct cx8800_dev *dev, struct v4l2_tuner *t)
 {
-	static char *m[] = {"mono", "dual mono", "stereo", "sap"};
+	static char *m[] = {"stereo", "dual mono", "mono", "sap"};
 	static char *p[] = {"no pilot", "pilot c1", "pilot c2", "?"};
 	u32 reg,mode,pilot;
 
@@ -367,7 +619,7 @@ void cx88_get_stereo(struct cx8800_dev *
 	pilot = (reg >> 2) & 0x03;
 	dprintk("AUD_STATUS: %s / %s [status=0x%x,ctl=0x%x,vol=0x%x]\n",
 		m[mode], p[pilot], reg,
-		cx_read(AUD_CTL), cx_read(AUD_VOL_CTL));
+		cx_read(AUD_CTL), cx_sread(SHADOW_AUD_VOL_CTL));
 
 	t->capability = V4L2_TUNER_CAP_STEREO | V4L2_TUNER_CAP_SAP |
 		V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2;
@@ -376,20 +628,20 @@ void cx88_get_stereo(struct cx8800_dev *
 
 	switch (dev->tvaudio) {
 	case WW_A2_BG:
- 		if (2 == pilot) {
+ 		if (1 == pilot) {
 			/* stereo */
 			t->rxsubchans = V4L2_TUNER_SUB_MONO | V4L2_TUNER_SUB_STEREO;
-			if (2 == mode)
+			if (0 == mode)
 				t->audmode = V4L2_TUNER_MODE_STEREO;
 		}
- 		if (1 == pilot) {
+ 		if (2 == pilot) {
 			/* dual language -- FIXME */
 			t->rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 			t->audmode = V4L2_TUNER_MODE_LANG1;
 		}
 		break;
 	case WW_NICAM_BGDKL:
-		if (2 == mode)
+		if (0 == mode)
 			t->audmode = V4L2_TUNER_MODE_STEREO;
 		break;
 	default:
@@ -455,12 +707,12 @@ void cx88_set_stereo(struct cx8800_dev *
 
 	if (UNSET != ctl) {
 		cx_write(AUD_SOFT_RESET, 0x0001);
-		cx_andor(AUD_CTL, mask, ctl);
+		cx_andor(AUD_CTL, mask,  ctl);
 		cx_write(AUD_SOFT_RESET, 0x0000);
 		dprintk("cx88_set_stereo: mask 0x%x, ctl 0x%x "
 			"[status=0x%x,ctl=0x%x,vol=0x%x]\n",
 			mask, ctl, cx_read(AUD_STATUS),
-			cx_read(AUD_CTL), cx_read(AUD_VOL_CTL));
+			cx_read(AUD_CTL), cx_sread(SHADOW_AUD_VOL_CTL));
 	}
 	return;
 }
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-vbi.c linux/drivers/media/video/cx88/cx88-vbi.c
--- linux-2.6.5/drivers/media/video/cx88/cx88-vbi.c	2004-04-05 10:49:59.038069161 +0200
+++ linux/drivers/media/video/cx88/cx88-vbi.c	2004-04-05 10:49:59.038069161 +0200
@@ -0,0 +1,228 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+#include "cx88.h"
+
+static unsigned int vbibufs = 4;
+MODULE_PARM(vbibufs,"i");
+MODULE_PARM_DESC(vbibufs,"number of vbi buffers, range 2-32");
+
+static unsigned int vbi_debug = 0;
+MODULE_PARM(vbi_debug,"i");
+MODULE_PARM_DESC(vbi_debug,"enable debug messages [video]");
+
+#define dprintk(level,fmt, arg...)	if (vbi_debug >= level) \
+	printk(KERN_DEBUG "%s: " fmt, dev->name , ## arg)
+
+/* ------------------------------------------------------------------ */
+
+void cx8800_vbi_fmt(struct cx8800_dev *dev, struct v4l2_format *f)
+{
+	memset(&f->fmt.vbi,0,sizeof(f->fmt.vbi));
+
+	f->fmt.vbi.samples_per_line = VBI_LINE_LENGTH;
+	f->fmt.vbi.sample_format = V4L2_PIX_FMT_GREY;
+	f->fmt.vbi.offset = 244;
+	f->fmt.vbi.count[0] = VBI_LINE_COUNT;
+	f->fmt.vbi.count[1] = VBI_LINE_COUNT;
+
+	switch (dev->tvnorm->id) {
+	case V4L2_STD_NTSC_M:
+	case V4L2_STD_NTSC_M_JP:
+		f->fmt.vbi.sampling_rate = 28636363;
+		f->fmt.vbi.start[0] = 10 -1;
+		f->fmt.vbi.start[1] = 273 -1;
+		break;
+	case V4L2_STD_PAL_BG:
+	case V4L2_STD_PAL_DK:
+	case V4L2_STD_PAL_I:
+	case V4L2_STD_SECAM:
+		f->fmt.vbi.sampling_rate = 35468950;
+		f->fmt.vbi.start[0] = 7 -1;
+		f->fmt.vbi.start[1] = 319 -1;
+	}
+}
+
+int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
+			 struct cx88_dmaqueue *q,
+			 struct cx88_buffer   *buf)
+{
+	/* setup fifo + format */
+	cx88_sram_channel_setup(dev, &cx88_sram_channels[SRAM_CH24],
+				buf->vb.width, buf->risc.dma);
+
+	cx_write(MO_VBOS_CONTROL, ( (1 << 18) |  // comb filter delay fixup
+				    (1 << 15) |  // enable vbi capture
+				    (1 << 11) ));
+
+	/* reset counter */
+	cx_write(MO_VBI_GPCNTRL,0x3);
+	q->count = 1;
+
+	/* enable irqs */
+	cx_set(MO_PCI_INTMSK, 0x00fc01);
+	cx_set(MO_VID_INTMSK, 0x0f0088);
+	
+	/* enable capture */
+	cx_set(VID_CAPTURE_CONTROL,0x18);
+	
+	/* start dma */
+	cx_set(MO_DEV_CNTRL2, (1<<5));
+	cx_set(MO_VID_DMACNTRL, 0x88);
+
+	return 0;
+}
+
+int cx8800_restart_vbi_queue(struct cx8800_dev    *dev,
+			     struct cx88_dmaqueue *q)
+{
+	struct cx88_buffer *buf;
+	struct list_head *item;
+	
+	if (list_empty(&q->active))
+		return 0;
+
+	buf = list_entry(q->active.next, struct cx88_buffer, vb.queue);
+	dprintk(2,"restart_queue [%p/%d]: restart dma\n",
+		buf, buf->vb.i);
+	cx8800_start_vbi_dma(dev, q, buf);
+	list_for_each(item,&q->active) {
+		buf = list_entry(item, struct cx88_buffer, vb.queue);
+		buf->count = q->count++;
+	}
+	mod_timer(&q->timeout, jiffies+BUFFER_TIMEOUT);
+	return 0;
+}
+
+void cx8800_vbi_timeout(unsigned long data)
+{
+	struct cx8800_dev *dev = (struct cx8800_dev*)data;
+	struct cx88_dmaqueue *q = &dev->vbiq;
+	struct cx88_buffer *buf;
+	unsigned long flags;
+
+	cx88_sram_channel_dump(dev, &cx88_sram_channels[SRAM_CH24]);
+	
+	cx_clear(MO_VID_DMACNTRL, 0x88);
+	cx_clear(VID_CAPTURE_CONTROL, 0x18);
+
+	spin_lock_irqsave(&dev->slock,flags);
+	while (!list_empty(&q->active)) {
+		buf = list_entry(q->active.next, struct cx88_buffer, vb.queue);
+		list_del(&buf->vb.queue);
+		buf->vb.state = STATE_ERROR;
+		wake_up(&buf->vb.done);
+		printk("%s: [%p/%d] timeout - dma=0x%08lx\n", dev->name,
+		       buf, buf->vb.i, (unsigned long)buf->risc.dma);
+	}
+	cx8800_restart_vbi_queue(dev,q);
+	spin_unlock_irqrestore(&dev->slock,flags);
+}
+
+/* ------------------------------------------------------------------ */
+
+static int
+vbi_setup(struct file *file, unsigned int *count, unsigned int *size)
+{
+	*size = VBI_LINE_COUNT * VBI_LINE_LENGTH * 2;
+	if (0 == *count)
+		*count = vbibufs;
+	if (*count < 2)
+		*count = 2;
+	if (*count > 32)
+		*count = 32;
+	return 0;
+}
+
+static int
+vbi_prepare(struct file *file, struct videobuf_buffer *vb,
+	    enum v4l2_field field)
+{
+	struct cx8800_fh   *fh  = file->private_data;
+	struct cx8800_dev  *dev = fh->dev;
+	struct cx88_buffer *buf = (struct cx88_buffer*)vb;
+	unsigned int size;
+	int rc;
+
+	size = VBI_LINE_COUNT * VBI_LINE_LENGTH * 2;
+	if (0 != buf->vb.baddr  &&  buf->vb.bsize < size)
+		return -EINVAL;
+
+	if (STATE_NEEDS_INIT == buf->vb.state) {
+		buf->vb.width  = VBI_LINE_LENGTH;
+		buf->vb.height = VBI_LINE_COUNT;
+		buf->vb.size   = size;
+		buf->vb.field  = V4L2_FIELD_SEQ_TB;
+
+		if (0 != (rc = videobuf_iolock(dev->pci,&buf->vb,NULL)))
+			goto fail;
+		cx88_risc_buffer(dev->pci, &buf->risc,
+				 buf->vb.dma.sglist,
+				 0, buf->vb.width * buf->vb.height,
+				 buf->vb.width, 0, 
+				 buf->vb.height);
+	}
+	buf->vb.state = STATE_PREPARED;
+	return 0;
+
+ fail:
+	cx88_free_buffer(dev->pci,buf);
+	return rc;
+}
+
+static void
+vbi_queue(struct file *file, struct videobuf_buffer *vb)
+{
+	struct cx88_buffer    *buf  = (struct cx88_buffer*)vb;
+	struct cx88_buffer    *prev;
+	struct cx8800_fh      *fh   = file->private_data;
+	struct cx8800_dev     *dev  = fh->dev;
+	struct cx88_dmaqueue  *q    = &dev->vbiq;
+
+	/* add jump to stopper */
+	buf->risc.jmp[0] = cpu_to_le32(RISC_JUMP | RISC_IRQ1 | 0x10000);
+	buf->risc.jmp[1] = cpu_to_le32(q->stopper.dma);
+
+	if (list_empty(&q->active)) {
+		list_add_tail(&buf->vb.queue,&q->active);
+		cx8800_start_vbi_dma(dev, q, buf);
+		buf->vb.state = STATE_ACTIVE;
+		buf->count    = q->count++;
+		mod_timer(&q->timeout, jiffies+BUFFER_TIMEOUT);
+		dprintk(2,"[%p/%d] vbi_queue - first active\n",
+			buf, buf->vb.i);
+
+	} else {
+		prev = list_entry(q->active.prev, struct cx88_buffer, vb.queue);
+		list_add_tail(&buf->vb.queue,&q->active);
+		buf->vb.state = STATE_ACTIVE;
+		buf->count    = q->count++;
+		prev->risc.jmp[1] = cpu_to_le32(buf->risc.dma);
+		dprintk(2,"[%p/%d] buffer_queue - append to active\n",
+			buf, buf->vb.i);
+	}
+}
+
+static void vbi_release(struct file *file, struct videobuf_buffer *vb)
+{
+	struct cx88_buffer *buf = (struct cx88_buffer*)vb;
+	struct cx8800_fh   *fh  = file->private_data;
+
+	cx88_free_buffer(fh->dev->pci,buf);
+}
+
+struct videobuf_queue_ops cx8800_vbi_qops = {
+	.buf_setup    = vbi_setup,
+	.buf_prepare  = vbi_prepare,
+	.buf_queue    = vbi_queue,
+	.buf_release  = vbi_release,
+};
+
+/* ------------------------------------------------------------------ */
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -up linux-2.6.5/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.5/drivers/media/video/cx88/cx88-video.c	2004-04-05 10:41:11.667527842 +0200
+++ linux/drivers/media/video/cx88/cx88-video.c	2004-04-05 10:49:59.048067277 +0200
@@ -42,6 +42,10 @@ static unsigned int video_nr[] = {[0 ...
 MODULE_PARM(video_nr,"1-" __stringify(CX88_MAXBOARDS) "i");
 MODULE_PARM_DESC(video_nr,"video device numbers");
 
+static unsigned int vbi_nr[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
+MODULE_PARM(vbi_nr,"1-" __stringify(CX88_MAXBOARDS) "i");
+MODULE_PARM_DESC(vbi_nr,"vbi device numbers");
+
 static unsigned int radio_nr[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
 MODULE_PARM(radio_nr,"1-" __stringify(CX88_MAXBOARDS) "i");
 MODULE_PARM_DESC(radio_nr,"radio device numbers");
@@ -131,45 +135,69 @@ static unsigned int inline norm_htotal(s
 	return (norm->id & V4L2_STD_625_50) ? 1135 : 910;
 }
 
+static unsigned int inline norm_vbipack(struct cx8800_tvnorm *norm)
+{
+	return (norm->id & V4L2_STD_625_50) ? 511 : 288;
+}
+
 static struct cx8800_tvnorm tvnorms[] = {
 	{
 		.name      = "NTSC-M",
 		.id        = V4L2_STD_NTSC_M,
 		.cxiformat = VideoFormatNTSC,
+		.cxoformat = 0x181f0008,
 	},{
 		.name      = "NTSC-JP",
 		.id        = V4L2_STD_NTSC_M_JP,
 		.cxiformat = VideoFormatNTSCJapan,
+		.cxoformat = 0x181f0008,
 #if 0
 	},{
 		.name      = "NTSC-4.43",
 		.id        = FIXME,
 		.cxiformat = VideoFormatNTSC443,
+		.cxoformat = 0x181f0008,
 #endif
 	},{
-		.name      = "PAL",
-		.id        = V4L2_STD_PAL,
+		.name      = "PAL-BG",
+		.id        = V4L2_STD_PAL_BG,
+		.cxiformat = VideoFormatPAL,
+		.cxoformat = 0x181f0008,
+	},{
+		.name      = "PAL-DK",
+		.id        = V4L2_STD_PAL_DK,
 		.cxiformat = VideoFormatPAL,
+		.cxoformat = 0x181f0008,
+	},{
+		.name      = "PAL-I",
+		.id        = V4L2_STD_PAL_I,
+		.cxiformat = VideoFormatPAL,
+		.cxoformat = 0x181f0008,
         },{
 		.name      = "PAL-M",
 		.id        = V4L2_STD_PAL_M,
 		.cxiformat = VideoFormatPALM,
+		.cxoformat = 0x1c1f0008,
 	},{
 		.name      = "PAL-N",
 		.id        = V4L2_STD_PAL_N,
 		.cxiformat = VideoFormatPALN,
+		.cxoformat = 0x1c1f0008,
 	},{
 		.name      = "PAL-Nc",
 		.id        = V4L2_STD_PAL_Nc,
 		.cxiformat = VideoFormatPALNC,
+		.cxoformat = 0x1c1f0008,
 	},{
 		.name      = "PAL-60",
 		.id        = V4L2_STD_PAL_60,
 		.cxiformat = VideoFormatPAL60,
+		.cxoformat = 0x181f0008,
 	},{
 		.name      = "SECAM",
 		.id        = V4L2_STD_SECAM,
 		.cxiformat = VideoFormatSECAM,
+		.cxoformat = 0x181f0008,
 	}
 };
 
@@ -266,10 +294,10 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.off             = 128,
-		.reg             = MO_CONTR_BRIGHT,
-		.mask            = 0x00ff,
-		.shift           = 0,
+		.off                   = 128,
+		.reg                   = MO_CONTR_BRIGHT,
+		.mask                  = 0x00ff,
+		.shift                 = 0,
 	},{
 		.v = {
 			.id            = V4L2_CID_CONTRAST,
@@ -280,12 +308,42 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.reg             = MO_CONTR_BRIGHT,
-		.mask            = 0xff00,
-		.shift           = 8,
+		.reg                   = MO_CONTR_BRIGHT,
+		.mask                  = 0xff00,
+		.shift                 = 8,
+	},{
+		.v = {
+			.id            = V4L2_CID_HUE,
+			.name          = "Hue",
+			.minimum       = 0,
+			.maximum       = 0xff,
+			.step          = 1,
+			.default_value = 0,
+			.type          = V4L2_CTRL_TYPE_INTEGER,
+		},
+		.off                   = 0,
+		.reg                   = MO_HUE,
+		.mask                  = 0x00ff,
+		.shift                 = 0,
+	},{
+		/* strictly, this only describes only U saturation.
+		 * V saturation is handled specially through code.
+		 */
+		.v = {
+			.id            = V4L2_CID_SATURATION,
+			.name          = "Saturation", 
+			.minimum       = 0,
+			.maximum       = 0xff,
+			.step          = 1,
+			.default_value = 0,
+			.type          = V4L2_CTRL_TYPE_INTEGER,
+		},
+		.off                   = 0,
+		.reg                   = MO_UV_SATURATION,
+		.mask                  = 0x00ff,
+		.shift                 = 0,
 	},{
 	/* --- audio --- */
-#if 0
 		.v = {
 			.id            = V4L2_CID_AUDIO_MUTE,
 			.name          = "Mute",
@@ -293,11 +351,11 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.maximum       = 1,
 			.type          = V4L2_CTRL_TYPE_BOOLEAN,
 		},
-		.reg             = AUD_VOL_CTL,
-		.mask            = (1 << 6),
-		.shift           = 6,
+		.reg                   = AUD_VOL_CTL,
+		.sreg                  = SHADOW_AUD_VOL_CTL,
+		.mask                  = (1 << 6),
+		.shift                 = 6,
 	},{
-#endif
 		.v = {
 			.id            = V4L2_CID_AUDIO_VOLUME,
 			.name          = "Volume",
@@ -307,9 +365,24 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
-		.reg             = AUD_VOL_CTL,
-		.mask            = 0x3f,
-		.shift           = 0,
+		.reg                   = AUD_VOL_CTL,
+		.sreg                  = SHADOW_AUD_VOL_CTL,
+		.mask                  = 0x3f,
+		.shift                 = 0,
+	},{
+		.v = {
+			.id            = V4L2_CID_AUDIO_BALANCE,
+			.name          = "Balance",
+			.minimum       = 0,
+			.maximum       = 0x7f,
+			.step          = 1,
+			.default_value = 0x40,
+			.type          = V4L2_CTRL_TYPE_INTEGER,
+		},
+		.reg                   = AUD_BAL_CTL,
+		.sreg                  = SHADOW_AUD_BAL_CTL,
+		.mask                  = 0x7f,
+		.shift                 = 0,
 	}
 };
 const int CX8800_CTLS = ARRAY_SIZE(cx8800_ctls);
@@ -344,13 +417,11 @@ int res_check(struct cx8800_fh *fh, unsi
 	return (fh->resources & bit);
 }
 
-#if 0
 static
 int res_locked(struct cx8800_dev *dev, unsigned int bit)
 {
 	return (dev->resources & bit);
 }
-#endif
 
 static
 void res_free(struct cx8800_dev *dev, struct cx8800_fh *fh, unsigned int bits)
@@ -412,21 +483,39 @@ static int set_tvaudio(struct cx8800_dev
 	if (CX88_VMUX_TELEVISION != INPUT(dev->input)->type)
 		return 0;
 
-
-	dev->tvaudio = 0;
-	if (dev->tvnorm->id & V4L2_STD_PAL) {
-		if (nicam)
-			dev->tvaudio = WW_NICAM_BGDKL;
-		else
-			dev->tvaudio = WW_A2_BG;
-	}
-	if (0 == dev->tvaudio)
+	switch (dev->tvnorm->id) {
+	case V4L2_STD_PAL_BG:
+		dev->tvaudio = nicam ? WW_NICAM_BGDKL : WW_A2_BG;
+		break;
+	case V4L2_STD_PAL_DK:
+		dev->tvaudio = nicam ? WW_NICAM_BGDKL : WW_A2_DK;
+		break;
+	case V4L2_STD_PAL_I:
+		dev->tvaudio = WW_NICAM_I;
+		break;
+	case V4L2_STD_SECAM:
+		dev->tvaudio = WW_SYSTEM_L_AM;  /* FIXME: fr != ru */
+		break;
+	case V4L2_STD_NTSC_M:
+		dev->tvaudio = WW_BTSC;
+		break;
+	case V4L2_STD_NTSC_M_JP:
+		dev->tvaudio = WW_EIAJ;
+		break;
+	default:
+		dprintk(1,"tvaudio support needs work for this tv norm [%s], sorry\n",
+			dev->tvnorm->name);
+		dev->tvaudio = 0;
 		return 0;
+	}
 
-	cx_andor(MO_AFECFG_IO,    0x1f, 0x0);
+	cx_andor(MO_AFECFG_IO, 0x1f, 0x0);
 	cx88_set_tvaudio(dev);
-	//cx88_set_stereo(dev,norm->tvaudio, V4L2_TUNER_MODE_MONO);
-	//cx_write(MO_AUD_DMACNTRL, 0x03); /* need audio fifo */
+	cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO);
+
+	cx_write(MO_AUDD_LNGTH, 128/8);  /* fifo size */
+	cx_write(MO_AUDR_LNGTH, 128/8);  /* fifo size */
+	cx_write(MO_AUD_DMACNTRL, 0x03); /* need audio fifo */
 	return 0;
 }
 
@@ -455,8 +544,8 @@ static int set_tvnorm(struct cx8800_dev 
 #if 1
 	// FIXME: as-is from DScaler
 	dprintk(1,"set_tvnorm: MO_OUTPUT_FORMAT 0x%08x [old=0x%08x]\n",
-		0x1c1f0008, cx_read(MO_OUTPUT_FORMAT));
-	cx_write(MO_OUTPUT_FORMAT, 0x1c1f0008);
+		norm->cxoformat, cx_read(MO_OUTPUT_FORMAT));
+	cx_write(MO_OUTPUT_FORMAT, norm->cxoformat);
 #endif
 
 	// MO_SCONV_REG = adc clock / video dec clock * 2^17
@@ -494,6 +583,10 @@ static int set_tvnorm(struct cx8800_dev 
 	dprintk(1,"set_tvnorm: MO_HTOTAL        0x%08x [old=0x%08x,htotal=%d]\n",
 		htotal, cx_read(MO_HTOTAL), (u32)tmp64);
 	cx_write(MO_HTOTAL, htotal);
+
+	// vbi stuff
+	cx_write(MO_VBI_PACKET, ((1 << 11) | /* (norm_vdelay(norm)   << 11) | */
+				 norm_vbipack(norm)));
 	
 	// audio
 	set_tvaudio(dev);
@@ -552,9 +645,14 @@ static int set_scale(struct cx8800_dev *
 
 	// setup filters
 	value = 0;
-	value |= (1 << 19);  // CFILT (default)
+	value |= (1 << 19);        // CFILT (default)
 	if (interlaced)
 		value |= (1 << 3); // VINT (interlaced vertical scaling)
+	if (width < 385)
+		value |= (1 << 0); // 3-tap interpolation
+	if (width < 193)
+		value |= (1 << 1); // 5-tap interpolation
+
 	cx_write(MO_FILTER_EVEN,  value);
 	cx_write(MO_FILTER_ODD,   value);
 	dprintk(1,"set_scale: filter  0x%04x\n", value);
@@ -564,11 +662,25 @@ static int set_scale(struct cx8800_dev *
 
 static int video_mux(struct cx8800_dev *dev, unsigned int input)
 {
-	dprintk(1,"video_mux: %d [vmux=%d,gpio=0x%x]\n",
-		input, INPUT(input)->vmux, INPUT(input)->gpio0);
+	dprintk(1,"video_mux: %d [vmux=%d,gpio=0x%x,0x%x,0x%x,0x%x]\n",
+		input, INPUT(input)->vmux,
+		INPUT(input)->gpio0,INPUT(input)->gpio1,
+		INPUT(input)->gpio2,INPUT(input)->gpio3);
 	dev->input = input;
 	cx_andor(MO_INPUT_FORMAT, 0x03 << 14, INPUT(input)->vmux << 14);
 	cx_write(MO_GP0_IO, INPUT(input)->gpio0);
+	cx_write(MO_GP1_IO, INPUT(input)->gpio1);
+	cx_write(MO_GP2_IO, INPUT(input)->gpio2);
+	cx_write(MO_GP3_IO, INPUT(input)->gpio3);
+
+	switch (INPUT(input)->type) {
+	case CX88_VMUX_SVIDEO:
+		cx_andor(MO_AFECFG_IO, 0x01, 0x01);
+		break;
+	default:
+		cx_andor(MO_AFECFG_IO, 0x01, 0x00);
+		break;
+	}
 	return 0;
 }
 
@@ -721,6 +833,20 @@ buffer_prepare(struct file *file, struct
 					 buf->bpl, buf->bpl,
 					 buf->vb.height >> 1);
 			break;
+		case V4L2_FIELD_SEQ_TB:
+			cx88_risc_buffer(dev->pci, &buf->risc,
+					 buf->vb.dma.sglist,
+					 0, buf->bpl * (buf->vb.height >> 1),
+					 buf->bpl, 0,
+					 buf->vb.height >> 1);
+			break;
+		case V4L2_FIELD_SEQ_BT:
+			cx88_risc_buffer(dev->pci, &buf->risc,
+					 buf->vb.dma.sglist,
+					 buf->bpl * (buf->vb.height >> 1), 0,
+					 buf->bpl, 0,
+					 buf->vb.height >> 1);
+			break;
 		default:
 			BUG();
 		}
@@ -795,7 +921,7 @@ static void buffer_release(struct file *
 	cx88_free_buffer(fh->dev->pci,buf);
 }
 
-static struct videobuf_queue_ops cx8800_video_qops = {
+struct videobuf_queue_ops cx8800_video_qops = {
 	.buf_setup    = buffer_setup,
 	.buf_prepare  = buffer_prepare,
 	.buf_queue    = buffer_queue,
@@ -1032,19 +1158,51 @@ static int setup_window(struct cx8800_de
 
 /* ------------------------------------------------------------------ */
 
+static struct videobuf_queue* get_queue(struct cx8800_fh *fh)
+{
+	switch (fh->type) {
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+		return &fh->vidq;
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		return &fh->vbiq;
+	default:
+		BUG();
+		return NULL;
+	}
+}
+
+static int get_ressource(struct cx8800_fh *fh)
+{
+	switch (fh->type) {
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+		return RESOURCE_VIDEO;
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		return RESOURCE_VBI;
+	default:
+		BUG();
+		return 0;
+	}
+}
+
 static int video_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(inode);
 	struct cx8800_dev *h,*dev = NULL;
 	struct cx8800_fh *fh;
 	struct list_head *list;
-	enum v4l2_buf_type type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	enum v4l2_buf_type type = 0;
 	int radio = 0;
 	
 	list_for_each(list,&cx8800_devlist) {
 		h = list_entry(list, struct cx8800_dev, devlist);
-		if (h->video_dev->minor == minor)
-			dev = h;
+		if (h->video_dev->minor == minor) {
+			dev  = h;
+			type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		}
+		if (h->vbi_dev->minor == minor) {
+			dev  = h;
+			type = V4L2_BUF_TYPE_VBI_CAPTURE;
+		}
 		if (h->radio_dev &&
 		    h->radio_dev->minor == minor) {
 			radio = 1;
@@ -1075,11 +1233,20 @@ static int video_open(struct inode *inod
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_INTERLACED,
 			    sizeof(struct cx88_buffer));
+	videobuf_queue_init(&fh->vbiq, &cx8800_vbi_qops,
+			    dev->pci, &dev->slock,
+			    V4L2_BUF_TYPE_VBI_CAPTURE,
+			    V4L2_FIELD_SEQ_TB,
+			    sizeof(struct cx88_buffer));
 	init_MUTEX(&fh->vidq.lock);
+	init_MUTEX(&fh->vbiq.lock);
 
 	if (fh->radio) {
 		dprintk(1,"video_open: setting radio device\n");
 		cx_write(MO_GP0_IO, cx88_boards[dev->board].radio.gpio0);
+		cx_write(MO_GP1_IO, cx88_boards[dev->board].radio.gpio1);
+		cx_write(MO_GP2_IO, cx88_boards[dev->board].radio.gpio2);
+		cx_write(MO_GP3_IO, cx88_boards[dev->board].radio.gpio3);
 		dev->tvaudio = WW_FM;
 		cx88_set_tvaudio(dev);
 		cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO);
@@ -1094,12 +1261,30 @@ video_read(struct file *file, char *data
 {
 	struct cx8800_fh *fh = file->private_data;
 
-	return videobuf_read_one(file, &fh->vidq, data, count, ppos);
+	switch (fh->type) {
+	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+		if (res_locked(fh->dev,RESOURCE_VIDEO))
+			return -EBUSY;
+		return videobuf_read_one(file, &fh->vidq, data, count, ppos);
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		if (!res_get(fh->dev,fh,RESOURCE_VBI))
+			return -EBUSY;
+		return videobuf_read_stream(file, &fh->vbiq, data, count, ppos, 1);
+	default:
+		BUG();
+		return 0;
+	}
 }
 
 static unsigned int
 video_poll(struct file *file, struct poll_table_struct *wait)
 {
+	struct cx8800_fh *fh = file->private_data;
+
+	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type)
+		return videobuf_poll_stream(file, &fh->vbiq, wait);
+
+	/* FIXME */
 	return POLLERR;
 }
 
@@ -1124,6 +1309,15 @@ static int video_release(struct inode *i
 		kfree(fh->vidq.read_buf);
 	}
 
+	/* stop vbi capture */
+	if (res_check(fh, RESOURCE_VBI)) {
+		if (fh->vbiq.streaming)
+			videobuf_streamoff(file,&fh->vbiq);
+		if (fh->vbiq.reading)
+			videobuf_read_stop(file,&fh->vbiq);
+		res_free(dev,fh,RESOURCE_VBI);
+	}
+
 	file->private_data = NULL;
 	kfree(fh);
 	return 0;
@@ -1134,7 +1328,7 @@ video_mmap(struct file *file, struct vm_
 {
 	struct cx8800_fh *fh = file->private_data;
 
-	return videobuf_mmap_mapper(vma,&fh->vidq);
+	return videobuf_mmap_mapper(vma, get_queue(fh));
 }
 
 /* ------------------------------------------------------------------ */
@@ -1151,14 +1345,22 @@ static int get_control(struct cx8800_dev
 	if (NULL == c)
 		return -EINVAL;
 
-	value = cx_read(c->reg);
-	ctl->value = ((value + (c->off << c->shift)) & c->mask) >> c->shift;
+	value = c->sreg ? cx_sread(c->sreg) : cx_read(c->reg);
+	switch (ctl->id) {
+	case V4L2_CID_AUDIO_BALANCE:
+		ctl->value = (value & 0x40) ? (value & 0x3f) : (0x40 - (value & 0x3f));
+		break;
+	default:
+		ctl->value = ((value + (c->off << c->shift)) & c->mask) >> c->shift;
+		break;
+	}
 	return 0;
 }
 
 static int set_control(struct cx8800_dev *dev, struct v4l2_control *ctl)
 {
 	struct cx88_ctrl *c = NULL;
+        u32 v_sat_value;
 	u32 value;
 	int i;
 
@@ -1172,11 +1374,48 @@ static int set_control(struct cx8800_dev
 		return -ERANGE;
 	if (ctl->value > c->v.maximum)
 		return -ERANGE;
-	value = ((ctl->value - c->off) << c->shift) & c->mask;
-	cx_andor(c->reg, c->mask, value);
+	switch (ctl->id) {
+	case V4L2_CID_AUDIO_BALANCE:
+		value = (ctl->value < 0x40) ? (0x40 - ctl->value) : ctl->value;
+		break;
+	case V4L2_CID_SATURATION:
+		/* special v_sat handling */
+		v_sat_value = ctl->value - (0x7f - 0x5a);
+		if (v_sat_value > 0xff)
+			v_sat_value = 0xff;
+		if (v_sat_value < 0x00)
+			v_sat_value = 0x00;
+		cx_andor(MO_UV_SATURATION, 0xff00, v_sat_value << 8);
+		/* fall through to default route for u_sat */
+	default:
+		value = ((ctl->value - c->off) << c->shift) & c->mask;
+		break;
+	}
+	dprintk(1,"set_control id=0x%X reg=0x%x val=0x%x%s\n",
+		ctl->id, c->reg, value, c->sreg ? " [shadowed]" : "");
+	if (c->sreg) {
+		cx_sandor(c->sreg, c->reg, c->mask, value);
+	} else {
+		cx_andor(c->reg, c->mask, value);
+	}
 	return 0;
 }
 
+static void init_controls(struct cx8800_dev *dev)
+{
+	static struct v4l2_control mute = {
+		.id    = V4L2_CID_AUDIO_MUTE,
+		.value = 1,
+	};
+	static struct v4l2_control volume = {
+		.id    = V4L2_CID_AUDIO_VOLUME,
+		.value = 0,
+	};
+
+	set_control(dev,&mute);
+	set_control(dev,&volume);
+}
+
 /* ------------------------------------------------------------------ */
 
 static int cx8800_g_fmt(struct cx8800_dev *dev, struct cx8800_fh *fh,
@@ -1194,6 +1433,9 @@ static int cx8800_g_fmt(struct cx8800_de
 		f->fmt.pix.sizeimage =
 			f->fmt.pix.height * f->fmt.pix.bytesperline;
 		return 0;
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		cx8800_vbi_fmt(dev, f);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1253,6 +1495,9 @@ static int cx8800_try_fmt(struct cx8800_
 
 		return 0;
 	}
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		cx8800_vbi_fmt(dev, f);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1274,6 +1519,9 @@ static int cx8800_s_fmt(struct cx8800_de
 		fh->height     = f->fmt.pix.height;
 		fh->vidq.field = f->fmt.pix.field;
 		return 0;
+	case V4L2_BUF_TYPE_VBI_CAPTURE:
+		cx8800_vbi_fmt(dev, f);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1311,9 +1559,9 @@ static int video_do_ioctl(struct inode *
 			V4L2_CAP_VIDEO_CAPTURE |
 			V4L2_CAP_READWRITE     |
 			V4L2_CAP_STREAMING     |
+			V4L2_CAP_VBI_CAPTURE   |
 #if 0
 			V4L2_CAP_VIDEO_OVERLAY |
-			V4L2_CAP_VBI_CAPTURE   |
 #endif
 			0;
 		if (UNSET != dev->tuner_type)
@@ -1541,30 +1789,58 @@ static int video_do_ioctl(struct inode *
 	}
 
 	/* --- streaming capture ------------------------------------- */
+	case VIDIOCGMBUF:
+	{
+		struct video_mbuf *mbuf = arg;
+		struct videobuf_queue *q;
+		struct v4l2_requestbuffers req;
+		unsigned int i;
+
+		q = get_queue(fh);
+		memset(&req,0,sizeof(req));
+		req.type   = q->type;
+		req.count  = 8;
+		req.memory = V4L2_MEMORY_MMAP;
+		err = videobuf_reqbufs(file,q,&req);
+		if (err < 0)
+			return err;
+		memset(mbuf,0,sizeof(*mbuf));
+		mbuf->frames = req.count;
+		mbuf->size   = 0;
+		for (i = 0; i < mbuf->frames; i++) {
+			mbuf->offsets[i]  = q->bufs[i]->boff;
+			mbuf->size       += q->bufs[i]->bsize;
+		}
+		return 0;
+	}
 	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(file,&fh->vidq,arg);
+		return videobuf_reqbufs(file, get_queue(fh), arg);
 
 	case VIDIOC_QUERYBUF:
-		return videobuf_querybuf(&fh->vidq,arg);
+		return videobuf_querybuf(get_queue(fh), arg);
 
 	case VIDIOC_QBUF:
-		return videobuf_qbuf(file,&fh->vidq,arg);
+		return videobuf_qbuf(file, get_queue(fh), arg);
 
 	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(file,&fh->vidq,arg);
+		return videobuf_dqbuf(file, get_queue(fh), arg);
 
 	case VIDIOC_STREAMON:
 	{
-                if (!res_get(dev,fh,RESOURCE_VIDEO))
+		int res = get_ressource(fh);
+
+                if (!res_get(dev,fh,res))
 			return -EBUSY;
-		return videobuf_streamon(file,&fh->vidq);
+		return videobuf_streamon(file, get_queue(fh));
 	}
 	case VIDIOC_STREAMOFF:
 	{
-		err = videobuf_streamoff(file,&fh->vidq);
+		int res = get_ressource(fh);
+		
+		err = videobuf_streamoff(file, get_queue(fh));
 		if (err < 0)
 			return err;
-		res_free(dev,fh,RESOURCE_VIDEO);
+		res_free(dev,fh,res);
 		return 0;
 	}
 
@@ -1726,9 +2002,34 @@ static void cx8800_vid_timeout(unsigned 
 	spin_unlock_irqrestore(&dev->slock,flags);
 }
 
-static void cx8800_vid_irq(struct cx8800_dev *dev)
+static void cx8800_wakeup(struct cx8800_dev *dev,
+			  struct cx88_dmaqueue *q, u32 count)
 {
 	struct cx88_buffer *buf;
+
+	for (;;) {
+		if (list_empty(&q->active))
+			break;
+		buf = list_entry(q->active.next,
+				 struct cx88_buffer, vb.queue);
+		if (buf->count > count)
+			break;
+		do_gettimeofday(&buf->vb.ts);
+		dprintk(2,"[%p/%d] wakeup reg=%d buf=%d\n",buf,buf->vb.i,
+			count, buf->count);
+		buf->vb.state = STATE_DONE;
+		list_del(&buf->vb.queue);
+		wake_up(&buf->vb.done);
+	}
+	if (list_empty(&q->active)) {
+		del_timer(&q->timeout);
+	} else {
+		mod_timer(&q->timeout, jiffies+BUFFER_TIMEOUT);
+	}
+}
+
+static void cx8800_vid_irq(struct cx8800_dev *dev)
+{
 	u32 status, mask, count;
 
 	status = cx_read(MO_VID_INTSTAT);
@@ -1752,35 +2053,33 @@ static void cx8800_vid_irq(struct cx8800
 	if (status & 0x01) {
 		spin_lock(&dev->slock);
 		count = cx_read(MO_VIDY_GPCNT);
-		for (;;) {
-			if (list_empty(&dev->vidq.active))
-				break;
-			buf = list_entry(dev->vidq.active.next,
-					 struct cx88_buffer, vb.queue);
-			if (buf->count > count)
-				break;
-			do_gettimeofday(&buf->vb.ts);
-			dprintk(2,"[%p/%d] wakeup reg=%d buf=%d\n",buf,buf->vb.i,
-				count, buf->count);
-			buf->vb.state = STATE_DONE;
-			list_del(&buf->vb.queue);
-			wake_up(&buf->vb.done);
-		}
-		if (list_empty(&dev->vidq.active)) {
-			del_timer(&dev->vidq.timeout);
-		} else {
-			mod_timer(&dev->vidq.timeout, jiffies+BUFFER_TIMEOUT);
-		}
+		cx8800_wakeup(dev, &dev->vidq, count);
+		spin_unlock(&dev->slock);
+	}
+
+	/* risc1 vbi */
+	if (status & 0x08) {
+		spin_lock(&dev->slock);
+		count = cx_read(MO_VBI_GPCNT);
+		cx8800_wakeup(dev, &dev->vbiq, count);
 		spin_unlock(&dev->slock);
 	}
 
 	/* risc2 y */
 	if (status & 0x10) {
-		dprintk(2,"stopper\n");
+		dprintk(2,"stopper video\n");
 		spin_lock(&dev->slock);
 		restart_video_queue(dev,&dev->vidq);
 		spin_unlock(&dev->slock);
 	}
+
+	/* risc2 vbi */
+	if (status & 0x80) {
+		dprintk(2,"stopper vbi\n");
+		spin_lock(&dev->slock);
+		cx8800_restart_vbi_queue(dev,&dev->vbiq);
+		spin_unlock(&dev->slock);
+	}
 }
 
 static irqreturn_t cx8800_irq(int irq, void *dev_id, struct pt_regs *regs)
@@ -1831,8 +2130,16 @@ static struct file_operations video_fops
 struct video_device cx8800_video_template =
 {
 	.name          = "cx8800-video",
-	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_OVERLAY|
-	                 VID_TYPE_CLIPPING|VID_TYPE_SCALES,
+	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_SCALES,
+	.hardware      = 0,
+	.fops          = &video_fops,
+	.minor         = -1,
+};
+
+struct video_device cx8800_vbi_template =
+{
+	.name          = "cx8800-vbi",
+	.type          = VID_TYPE_TELETEXT|VID_TYPE_TUNER,
 	.hardware      = 0,
 	.fops          = &video_fops,
 	.minor         = -1,
@@ -1958,6 +2265,13 @@ static void cx8800_unregister_video(stru
 			video_device_release(dev->radio_dev);
 		dev->radio_dev = NULL;
 	}
+	if (dev->vbi_dev) {
+		if (-1 != dev->vbi_dev->minor)
+			video_unregister_device(dev->vbi_dev);
+		else
+			video_device_release(dev->vbi_dev);
+		dev->vbi_dev = NULL;
+	}
 	if (dev->video_dev) {
 		if (-1 != dev->video_dev->minor)
 			video_unregister_device(dev->video_dev);
@@ -1967,6 +2281,11 @@ static void cx8800_unregister_video(stru
 	}
 }
 
+/* debug that damn oops ... */
+static unsigned int oops = 0;
+MODULE_PARM(oops,"i");
+#define OOPS(msg) if (oops) printk("%s: %s\n",__FUNCTION__,msg);
+
 static int __devinit cx8800_initdev(struct pci_dev *pci_dev,
 				    const struct pci_device_id *pci_id)
 {
@@ -1980,6 +2299,7 @@ static int __devinit cx8800_initdev(stru
 	memset(dev,0,sizeof(*dev));
 
 	/* pci init */
+	OOPS("pci init");
 	dev->pci = pci_dev;
 	if (pci_enable_device(pci_dev)) {
 		err = -EIO;
@@ -1988,6 +2308,7 @@ static int __devinit cx8800_initdev(stru
 	sprintf(dev->name,"cx%x[%d]",pci_dev->device,cx8800_devcount);
 
 	/* pci quirks */
+	OOPS("pci quirks");
 	cx88_pci_quirks(dev->name, dev->pci, &latency);
 	if (UNSET != latency) {
 		printk(KERN_INFO "%s: setting pci latency timer to %d\n",
@@ -1996,6 +2317,7 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* print pci info */
+	OOPS("pci info");
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
         pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
         printk(KERN_INFO "%s: found at %s, rev: %d, irq: %d, "
@@ -2011,6 +2333,7 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* board config */
+	OOPS("board config");
 	dev->board = card[cx8800_devcount];
 	for (i = 0; UNSET == dev->board  &&  i < cx88_idcount; i++) 
 		if (pci_dev->subsystem_vendor == cx88_subids[i].subvendor &&
@@ -2029,6 +2352,7 @@ static int __devinit cx8800_initdev(stru
 		dev->tuner_type = cx88_boards[dev->board].tuner_type;
 
 	/* get mmio */
+	OOPS("get mmio");
 	if (!request_mem_region(pci_resource_start(pci_dev,0),
 				pci_resource_len(pci_dev,0),
 				dev->name)) {
@@ -2039,13 +2363,15 @@ static int __devinit cx8800_initdev(stru
 	}
 	dev->lmmio = ioremap(pci_resource_start(pci_dev,0),
 			     pci_resource_len(pci_dev,0));
+	dev->bmmio = (u8*)dev->lmmio;
 
 	/* initialize driver struct */
+	OOPS("init structs");
         init_MUTEX(&dev->lock);
 	dev->slock = SPIN_LOCK_UNLOCKED;
 	dev->tvnorm = tvnorms;
 
-	/* init dma queues */
+	/* init video dma queues */
 	INIT_LIST_HEAD(&dev->vidq.active);
 	INIT_LIST_HEAD(&dev->vidq.queued);
 	dev->vidq.timeout.function = cx8800_vid_timeout;
@@ -2053,11 +2379,22 @@ static int __devinit cx8800_initdev(stru
 	init_timer(&dev->vidq.timeout);
 	cx88_risc_stopper(dev->pci,&dev->vidq.stopper,
 			  MO_VID_DMACNTRL,0x11,0x00);
-	
+
+	/* init vbi dma queues */
+	INIT_LIST_HEAD(&dev->vbiq.active);
+	INIT_LIST_HEAD(&dev->vbiq.queued);
+	dev->vbiq.timeout.function = cx8800_vbi_timeout;
+	dev->vbiq.timeout.data     = (unsigned long)dev;
+	init_timer(&dev->vbiq.timeout);
+	cx88_risc_stopper(dev->pci,&dev->vbiq.stopper,
+			  MO_VID_DMACNTRL,0x88,0x00);
+
 	/* initialize hardware */
+	OOPS("reset hardware");
 	cx8800_reset(dev);
 
 	/* get irq */
+	OOPS("install irq handler");
 	err = request_irq(pci_dev->irq, cx8800_irq,
 			  SA_SHIRQ | SA_INTERRUPT, dev->name, dev);
 	if (err < 0) {
@@ -2067,16 +2404,22 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* register i2c bus + load i2c helpers */
+	OOPS("i2c setup");
 	cx8800_i2c_init(dev);
+	OOPS("card setup");
 	cx88_card_setup(dev);
 
 	/* load and configure helper modules */
+	OOPS("configure i2c clients");
 	if (TUNER_ABSENT != dev->tuner_type)
 		request_module("tuner");
+	if (cx88_boards[dev->board].needs_tda9887)
+		request_module("tda9887");
 	if (dev->tuner_type != UNSET)
 		cx8800_call_i2c_clients(dev,TUNER_SET_TYPE,&dev->tuner_type);
 
 	/* register v4l devices */
+	OOPS("register video");
 	dev->video_dev = vdev_init(dev,&cx8800_video_template,"video");
 	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
 				    video_nr[cx8800_devcount]);
@@ -2088,7 +2431,20 @@ static int __devinit cx8800_initdev(stru
 	printk(KERN_INFO "%s: registered device video%d [v4l2]\n",
 	       dev->name,dev->video_dev->minor & 0x1f);
 
+	OOPS("register vbi");
+	dev->vbi_dev = vdev_init(dev,&cx8800_vbi_template,"vbi");
+	err = video_register_device(dev->vbi_dev,VFL_TYPE_VBI,
+				    vbi_nr[cx8800_devcount]);
+	if (err < 0) {
+		printk(KERN_INFO "%s: can't register vbi device\n",
+		       dev->name);
+		goto fail3;
+	}
+	printk(KERN_INFO "%s: registered device vbi%d\n",
+	       dev->name,dev->vbi_dev->minor & 0x1f);
+
 	if (dev->has_radio) {
+		OOPS("register radio");
 		dev->radio_dev = vdev_init(dev,&cx8800_radio_template,"radio");
 		err = video_register_device(dev->radio_dev,VFL_TYPE_RADIO,
 					    radio_nr[cx8800_devcount]);
@@ -2102,26 +2458,32 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* everything worked */
+	OOPS("finalize");
 	list_add_tail(&dev->devlist,&cx8800_devlist);
 	pci_set_drvdata(pci_dev,dev);
 	cx8800_devcount++;
 
 	/* initial device configuration */
+	OOPS("init device");
 	down(&dev->lock);
+	init_controls(dev);
 	set_tvnorm(dev,tvnorms);
 	video_mux(dev,0);
 	up(&dev->lock);
 	return 0;
 
  fail3:
+	OOPS("fail3");
 	cx8800_unregister_video(dev);
 	if (0 == dev->i2c_rc)
 		i2c_bit_del_bus(&dev->i2c_adap);
 	free_irq(pci_dev->irq, dev);
  fail2:
+	OOPS("fail2");
 	release_mem_region(pci_resource_start(pci_dev,0),
 			   pci_resource_len(pci_dev,0));
  fail1:
+	OOPS("fail1");
 	kfree(dev);
 	return err;
 }
diff -up linux-2.6.5/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.5/drivers/media/video/cx88/cx88.h	2004-04-05 10:43:37.336044658 +0200
+++ linux/drivers/media/video/cx88/cx88.h	2004-04-05 10:50:14.833092462 +0200
@@ -1,7 +1,7 @@
 /*
- * v4l2 device driver for philips saa7134 based TV cards
+ * v4l2 device driver for cx2388x based TV cards
  *
- * (c) 2001,02 Gerd Knorr <kraxel@bytesex.org>
+ * (c) 2003,04 Gerd Knorr <kraxel@bytesex.org> [SUSE Labs]
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -32,7 +32,7 @@
 #include "cx88-reg.h"
 
 #include <linux/version.h>
-#define CX88_VERSION_CODE KERNEL_VERSION(0,0,1)
+#define CX88_VERSION_CODE KERNEL_VERSION(0,0,3)
 
 #ifndef TRUE
 # define TRUE (1==1)
@@ -50,6 +50,14 @@
 #define FORMAT_FLAGS_PACKED       0x01
 #define FORMAT_FLAGS_PLANAR       0x02
 
+#define VBI_LINE_COUNT              17
+#define VBI_LINE_LENGTH           2048
+
+/* need "shadow" registers for some write-only ones ... */
+#define SHADOW_AUD_VOL_CTL           1
+#define SHADOW_AUD_BAL_CTL           2
+#define SHADOW_MAX                   2
+
 /* ----------------------------------------------------------- */
 /* static data                                                 */
 
@@ -72,6 +80,7 @@ struct cx88_ctrl {
 	struct v4l2_queryctrl  v;
 	u32                    off;
 	u32                    reg;
+	u32                    sreg;
 	u32                    mask;
 	u32                    shift;
 };
@@ -91,6 +100,7 @@ struct sram_channel {
 	char *name;
 	u32  cmds_start;
 	u32  ctrl_start;
+	u32  cdt;
 	u32  fifo_start;
 	u32  fifo_size;
 	u32  ptr1_reg;
@@ -113,6 +123,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_AVERTV_303        6
 #define CX88_BOARD_MSI_TVANYWHERE    7
 #define CX88_BOARD_WINFAST_DV2000    8
+#define CX88_BOARD_LEADTEK_PVR2000   9
 
 
 enum cx88_itype {
@@ -129,12 +140,13 @@ enum cx88_itype {
 struct cx88_input {
 	enum cx88_itype type;
 	unsigned int    vmux;
-	u32             gpio0;
+	u32             gpio0, gpio1, gpio2, gpio3;
 };
 
 struct cx88_board {
 	char                    *name;
 	unsigned int            tuner_type;
+	int                     needs_tda9887:1;
 	struct cx88_input       input[8];
 	struct cx88_input       radio;
 };
@@ -195,6 +207,9 @@ struct cx8800_fh {
 	struct cx8800_fmt          *fmt;
 	unsigned int               width,height;
 	struct videobuf_queue      vidq;
+
+	/* vbi capture */
+	struct videobuf_queue      vbiq;
 };
 
 struct cx8800_suspend_state {
@@ -211,6 +226,7 @@ struct cx8800_dev {
 	/* various device info */
 	unsigned int               resources;
 	struct video_device        *video_dev;
+	struct video_device        *vbi_dev;
 	struct video_device        *radio_dev;
 
 	/* pci i/o */
@@ -218,6 +234,7 @@ struct cx8800_dev {
 	struct pci_dev             *pci;
 	unsigned char              pci_rev,pci_lat;
         u32                        *lmmio;
+        u8                         *bmmio;
 
 	/* config info */
 	unsigned int               board;
@@ -236,6 +253,7 @@ struct cx8800_dev {
 
 	/* capture queues */
 	struct cx88_dmaqueue       vidq;
+	struct cx88_dmaqueue       vbiq;
 
 	/* various v4l controls */
 	struct cx8800_tvnorm       *tvnorm;
@@ -244,6 +262,7 @@ struct cx8800_dev {
 	u32                        freq;
 
 	/* other global state info */
+	u32                         shadow[SHADOW_MAX];
 	struct cx8800_suspend_state state;
 };
 
@@ -251,6 +270,7 @@ struct cx8800_dev {
 
 #define cx_read(reg)             readl(dev->lmmio + ((reg)>>2))
 #define cx_write(reg,value)      writel((value), dev->lmmio + ((reg)>>2));
+#define cx_writeb(reg,value)     writeb((value), dev->bmmio + (reg));
 
 #define cx_andor(reg,mask,value) \
   writel((readl(dev->lmmio+((reg)>>2)) & ~(mask)) |\
@@ -258,8 +278,16 @@ struct cx8800_dev {
 #define cx_set(reg,bit)          cx_andor((reg),(bit),(bit))
 #define cx_clear(reg,bit)        cx_andor((reg),(bit),0)
 
-#define cx_wait(d) { if (need_resched()) schedule(); else udelay(d);}
+#define cx_wait(d) { if (need_resched()) schedule(); else udelay(d); }
 
+/* shadow registers */
+#define cx_sread(sreg)		    (dev->shadow[sreg])
+#define cx_swrite(sreg,reg,value) \
+  (dev->shadow[sreg] = value, \
+   writel(dev->shadow[sreg], dev->lmmio + ((reg)>>2)))
+#define cx_sandor(sreg,reg,mask,value) \
+  (dev->shadow[sreg] = (dev->shadow[sreg] & ~(mask)) | ((value) & (mask)), \
+   writel(dev->shadow[sreg], dev->lmmio + ((reg)>>2)))
 
 /* ----------------------------------------------------------- */
 /* cx88-core.c                                                 */
@@ -294,6 +322,19 @@ extern int cx88_pci_quirks(char *name, s
 			   unsigned int *latency);
 
 /* ----------------------------------------------------------- */
+/* cx88-vbi.c                                                  */
+
+void cx8800_vbi_fmt(struct cx8800_dev *dev, struct v4l2_format *f);
+int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
+			 struct cx88_dmaqueue *q,
+			 struct cx88_buffer   *buf);
+int cx8800_restart_vbi_queue(struct cx8800_dev    *dev,
+			     struct cx88_dmaqueue *q);
+void cx8800_vbi_timeout(unsigned long data);
+
+extern struct videobuf_queue_ops cx8800_vbi_qops;
+
+/* ----------------------------------------------------------- */
 /* cx88-i2c.c                                                  */
 
 extern int cx8800_i2c_init(struct cx8800_dev *dev);
@@ -310,7 +351,7 @@ extern const unsigned int cx88_bcount;
 extern struct cx88_subid cx88_subids[];
 extern const unsigned int cx88_idcount;
 
-extern void cx88_card_setup(struct cx8800_dev *dev);
+extern void __devinit cx88_card_setup(struct cx8800_dev *dev);
 
 /* ----------------------------------------------------------- */
 /* cx88-tvaudio.c                                              */

-- 
http://bigendian.bytesex.org
