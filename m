Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbUKHJMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUKHJMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 04:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUKHJMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 04:12:35 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17886 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261794AbUKHJAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 04:00:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 09:53:00 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 5/6] v4l: cx88 update
Message-ID: <20041108085300.GA19277@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cx88 driver update, changes:

 * adapt to video-buf changes.
 * add support for a new card.
 * use the new video-buf-dvb module.

The dvb stuff doesn't build yet as it depends on some cutting-edge
code from the linuxtv cvs and is tagged as 'BROKEN' because of that.

The patch also removes all trailing whitespaces.  I've a script to
remove them from my sources now, that should kill those no-op
whitespace changes in my patches after merging this initial cleanup.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/Kconfig               |   13 
 drivers/media/video/cx88/Makefile         |    4 
 drivers/media/video/cx88/cx88-blackbird.c |   51 +--
 drivers/media/video/cx88/cx88-cards.c     |   32 +-
 drivers/media/video/cx88/cx88-core.c      |   23 -
 drivers/media/video/cx88/cx88-dvb.c       |  343 ++++++++--------------
 drivers/media/video/cx88/cx88-i2c.c       |    6 
 drivers/media/video/cx88/cx88-mpeg.c      |    5 
 drivers/media/video/cx88/cx88-reg.h       |   66 ++--
 drivers/media/video/cx88/cx88-tvaudio.c   |   28 +
 drivers/media/video/cx88/cx88-vbi.c       |   22 -
 drivers/media/video/cx88/cx88-video.c     |  153 +++++----
 drivers/media/video/cx88/cx88.h           |   28 -
 13 files changed, 350 insertions(+), 424 deletions(-)

Index: linux-2004-11-05/drivers/media/video/cx88/cx88.h
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88.h	2004-11-07 12:24:30.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88.h	2004-11-07 16:01:04.547277171 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.37 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88.h,v 1.40 2004/11/03 09:04:51 kraxel Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -26,15 +26,10 @@
 #include <linux/videodev.h>
 #include <linux/kdev_t.h>
 
-#include <dvbdev.h>
-#include <dmxdev.h>
-#include <dvb_demux.h>
-#include <dvb_net.h>
-#include <dvb_frontend.h>
-
-#include <media/video-buf.h>
 #include <media/tuner.h>
 #include <media/audiochip.h>
+#include <media/video-buf.h>
+#include <media/video-buf-dvb.h>
 
 #include "btcx-risc.h"
 #include "cx88-reg.h"
@@ -160,6 +155,7 @@ extern struct sram_channel cx88_sram_cha
 #define CX88_BOARD_HAUPPAUGE_DVB_T1        18
 #define CX88_BOARD_CONEXANT_DVB_T1         19
 #define CX88_BOARD_PROVIDEO_PV259          20
+#define CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS 21
 
 enum cx88_itype {
 	CX88_VMUX_COMPOSITE1 = 1,
@@ -351,7 +347,6 @@ struct cx8802_fh {
 };
 
 struct cx8802_suspend_state {
-	u32                        pci_cfg[64 / sizeof(u32)];
 	int                        disabled;
 };
 
@@ -369,11 +364,6 @@ struct cx8802_dev {
 	u32                        ts_packet_size;
 	u32                        ts_packet_count;
 
-	/* error stats */
-	u32                        stopper_count;
-	u32                        error_count;
-	u32                        timeout_count;
-
 	/* other global state info */
 	struct cx8802_suspend_state state;
 
@@ -383,15 +373,7 @@ struct cx8802_dev {
 	u32                        mailbox;
 
 	/* for dvb only */
-	struct dvb_adapter         *dvb_adapter;
-	struct videobuf_queue      dvbq;
-	struct task_struct         *dvb_thread;
-	struct dvb_demux           demux;
-	struct dmxdev              dmxdev;
-	struct dmx_frontend        fe_hw;
-	struct dmx_frontend        fe_mem;
-	struct dvb_net             dvbnet;
-	int                        nfeeds;
+	struct videobuf_dvb        dvb;
 	void*                      fe_handle;
 	int                        (*fe_release)(void *handle);
 };
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-reg.h
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-reg.h	2004-11-07 12:22:32.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-reg.h	2004-11-07 16:01:04.548276982 +0100
@@ -1,5 +1,5 @@
-/* 
-    $Id: cx88-reg.h,v 1.5 2004/09/15 16:15:24 kraxel Exp $
+/*
+    $Id: cx88-reg.h,v 1.6 2004/10/13 10:39:00 kraxel Exp $
 
     cx88x-hw.h - CX2388x register offsets
 
@@ -559,11 +559,11 @@
 /* ---------------------------------------------------------------------- */
 /* various constants                                                      */
 
-#define SEL_BTSC     0x01 
-#define SEL_EIAJ     0x02 
-#define SEL_A2       0x04 
+#define SEL_BTSC     0x01
+#define SEL_EIAJ     0x02
+#define SEL_A2       0x04
 #define SEL_SAP      0x08
-#define SEL_NICAM    0x10 
+#define SEL_NICAM    0x10
 #define SEL_FMRADIO  0x20
 
 // AUD_CTL
@@ -618,7 +618,7 @@
 #define EN_DMTRX_BYPASS         (1 << 11)
 #endif
 
-// Video 
+// Video
 #define VID_CAPTURE_CONTROL		0x310180
 
 #define CX23880_CAP_CTL_CAPTURE_VBI_ODD  (1<<3)
@@ -630,10 +630,10 @@
 #define VideoInputMux1		 0x1
 #define VideoInputMux2		 0x2
 #define VideoInputMux3		 0x3
-#define VideoInputTuner		 0x0 
-#define VideoInputComposite	 0x1 
+#define VideoInputTuner		 0x0
+#define VideoInputComposite	 0x1
 #define VideoInputSVideo	 0x2
-#define VideoInputOther		 0x3 
+#define VideoInputOther		 0x3
 
 #define Xtal0		 0x1
 #define Xtal1		 0x2
@@ -644,12 +644,12 @@
 #define VideoFormatNTSCJapan	 0x2
 #define VideoFormatNTSC443	 0x3
 #define VideoFormatPAL		 0x4
-#define VideoFormatPALB		 0x4 
-#define VideoFormatPALD		 0x4 
-#define VideoFormatPALG		 0x4 
-#define VideoFormatPALH		 0x4 
-#define VideoFormatPALI		 0x4 
-#define VideoFormatPALBDGHI	 0x4 
+#define VideoFormatPALB		 0x4
+#define VideoFormatPALD		 0x4
+#define VideoFormatPALG		 0x4
+#define VideoFormatPALH		 0x4
+#define VideoFormatPALI		 0x4
+#define VideoFormatPALBDGHI	 0x4
 #define VideoFormatPALM		 0x5
 #define VideoFormatPALN		 0x6
 #define VideoFormatPALNC	 0x7
@@ -661,12 +661,12 @@
 #define VideoFormatNTSCJapan27MHz	 0x12
 #define VideoFormatNTSC44327MHz		 0x13
 #define VideoFormatPAL27MHz		 0x14
-#define VideoFormatPALB27MHz		 0x14 
-#define VideoFormatPALD27MHz		 0x14 
-#define VideoFormatPALG27MHz		 0x14 
-#define VideoFormatPALH27MHz		 0x14 
-#define VideoFormatPALI27MHz		 0x14 
-#define VideoFormatPALBDGHI27MHz	 0x14 
+#define VideoFormatPALB27MHz		 0x14
+#define VideoFormatPALD27MHz		 0x14
+#define VideoFormatPALG27MHz		 0x14
+#define VideoFormatPALH27MHz		 0x14
+#define VideoFormatPALI27MHz		 0x14
+#define VideoFormatPALBDGHI27MHz	 0x14
 #define VideoFormatPALM27MHz		 0x15
 #define VideoFormatPALN27MHz		 0x16
 #define VideoFormatPALNC27MHz		 0x17
@@ -745,8 +745,8 @@
 #define CHANNEL_VIP_UP		 0xA
 #define CHANNEL_HOST_DN		 0xB
 #define CHANNEL_HOST_UP		 0xC
-#define CHANNEL_FIRST		 0x1 
-#define CHANNEL_LAST		 0xC 
+#define CHANNEL_FIRST		 0x1
+#define CHANNEL_LAST		 0xC
 
 #define GP_COUNT_CONTROL_NONE		 0x0
 #define GP_COUNT_CONTROL_INC		 0x1
@@ -773,15 +773,15 @@
 #define DEFAULT_SAT_U_NTSC			0x7F
 #define DEFAULT_SAT_V_NTSC			0x5A
 
-typedef enum                                                                          
-{                                                                                     
-	SOURCE_TUNER = 0,                                                             
-	SOURCE_COMPOSITE,                                                             
-	SOURCE_SVIDEO,                                                                
-	SOURCE_OTHER1,                                                                
-	SOURCE_OTHER2,                                                                
-	SOURCE_COMPVIASVIDEO,                                                         
-	SOURCE_CCIR656                                                                    
+typedef enum
+{
+	SOURCE_TUNER = 0,
+	SOURCE_COMPOSITE,
+	SOURCE_SVIDEO,
+	SOURCE_OTHER1,
+	SOURCE_OTHER2,
+	SOURCE_COMPVIASVIDEO,
+	SOURCE_CCIR656
 } VIDEOSOURCETYPE;
 
 #endif /* _CX88_REG_H_ */
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-cards.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-cards.c	2004-11-07 12:23:44.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-cards.c	2004-11-07 16:01:04.548276982 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-cards.c,v 1.44 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88-cards.c,v 1.47 2004/11/03 09:04:50 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -336,11 +336,11 @@ struct cx88_board cx88_boards[] = {
 		.tuner_type     = TUNER_ABSENT, /* No analog tuner */
 		.input          = {{
 			.type   = CX88_VMUX_COMPOSITE1,
-			.vmux   = 0,
+			.vmux   = 1,
 			.gpio0  = 0x000027df,
 		 },{
 			.type   = CX88_VMUX_SVIDEO,
-			.vmux   = 1,
+			.vmux   = 2,
 			.gpio0  = 0x000027df,
 		}},
 		.dvb            = 1,
@@ -438,6 +438,20 @@ struct cx88_board cx88_boards[] = {
 		}},
 		.blackbird = 1,
 	},
+	[CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS] = {
+		.name           = "DVICO FusionHDTV DVB-T Plus",
+		.tuner_type     = TUNER_ABSENT, /* No analog tuner */
+		.input          = {{
+			.type   = CX88_VMUX_COMPOSITE1,
+			.vmux   = 1,
+			.gpio0  = 0x000027df,
+		 },{
+			.type   = CX88_VMUX_SVIDEO,
+			.vmux   = 2,
+			.gpio0  = 0x000027df,
+		}},
+		.dvb            = 1,
+	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
 
@@ -525,6 +539,10 @@ struct cx88_subid cx88_subids[] = {
 		.subvendor = 0x1540,
 		.subdevice = 0x2580,
 		.card      = CX88_BOARD_PROVIDEO_PV259,
+	},{
+		.subvendor = 0x18AC,
+		.subdevice = 0xDB10,
+		.card      = CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS,
 	}
 };
 const unsigned int cx88_idcount = ARRAY_SIZE(cx88_subids);
@@ -612,7 +630,7 @@ static struct {
 	{ TUNER_ABSENT,        "Philips TD1536D_FH_44"},
 	{ TUNER_LG_NTSC_FM,    "LG TPI8NSR01F"},
 	{ TUNER_LG_PAL_FM,     "LG TPI8PSB01D"},
-	{ TUNER_LG_PAL,        "LG TPI8PSB11D"},	
+	{ TUNER_LG_PAL,        "LG TPI8PSB11D"},
 	{ TUNER_LG_PAL_I_FM,   "LG TAPC-I001D"},
 	{ TUNER_LG_PAL_I,      "LG TAPC-I701D"}
 };
@@ -634,12 +652,12 @@ static void hauppauge_eeprom(struct cx88
 	model = eeprom_data[12] << 8 | eeprom_data[11];
 	tuner = eeprom_data[9];
 	radio = eeprom_data[blk2-1] & 0x01;
-	
+
         if (tuner < ARRAY_SIZE(hauppauge_tuner))
                 core->tuner_type = hauppauge_tuner[tuner].id;
 	if (radio)
 		core->has_radio = 1;
-	
+
 	printk(KERN_INFO "%s: hauppauge eeprom: model=%d, "
 	       "tuner=%s (%d), radio=%s\n",
 	       core->name, model, (tuner < ARRAY_SIZE(hauppauge_tuner)
@@ -804,7 +822,7 @@ void cx88_card_list(struct cx88_core *co
 void cx88_card_setup(struct cx88_core *core)
 {
 	static u8 eeprom[128];
-		
+
 	switch (core->board) {
 	case CX88_BOARD_HAUPPAUGE:
 		if (0 == core->i2c_rc)
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-core.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-core.c	2004-11-07 12:22:08.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-core.c	2004-11-07 16:01:04.549276793 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-core.c,v 1.13 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88-core.c,v 1.15 2004/10/25 11:26:36 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * driver core
@@ -50,13 +50,12 @@ module_param(latency,int,0444);
 MODULE_PARM_DESC(latency,"pci latency timer");
 
 static unsigned int tuner[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
-static int tuner_num;
-module_param_array(tuner,int,&tuner_num,0444);
-MODULE_PARM_DESC(tuner,"tuner type");
+static unsigned int card[]  = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
+
+module_param_array(tuner, int, NULL, 0444);
+module_param_array(card,  int, NULL, 0444);
 
-static unsigned int card[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
-static int card_num;
-module_param_array(card,int,&card_num,0444);
+MODULE_PARM_DESC(tuner,"tuner type");
 MODULE_PARM_DESC(card,"card type");
 
 static unsigned int nicam = 0;
@@ -137,7 +136,7 @@ static u32* cx88_risc_field(u32 *rp, str
 	/* sync instruction */
 	if (sync_line != NO_SYNC_LINE)
 		*(rp++) = cpu_to_le32(RISC_RESYNC | sync_line);
-	
+
 	/* scan lines */
 	sg = sglist;
 	for (line = 0; line < lines; line++) {
@@ -291,7 +290,7 @@ cx88_free_buffer(struct pci_dev *pci, st
  *
  * Every channel has 160 bytes control data (64 bytes instruction
  * queue and 6 CDT entries), which is close to 2k total.
- * 
+ *
  * Address layout:
  *    0x0000 - 0x03ff    CMDs / reserved
  *    0x0400 - 0x0bff    instruction queues + CDs
@@ -467,7 +466,7 @@ void cx88_risc_disasm(struct cx88_core *
 		      struct btcx_riscmem *risc)
 {
 	unsigned int i,j,n;
-	
+
 	printk("%s: risc disasm: %p [dma=0x%08lx]\n",
 	       core->name, risc->cpu, (unsigned long)risc->dma);
 	for (i = 0; i < (risc->size >> 2); i += n) {
@@ -537,13 +536,13 @@ void cx88_sram_channel_dump(struct cx88_
 }
 
 char *cx88_pci_irqs[32] = {
-	"vid", "aud", "ts", "vip", "hst", "5", "6", "tm1", 
+	"vid", "aud", "ts", "vip", "hst", "5", "6", "tm1",
 	"src_dma", "dst_dma", "risc_rd_err", "risc_wr_err",
 	"brdg_err", "src_dma_err", "dst_dma_err", "ipb_dma_err",
 	"i2c", "i2c_rack", "ir_smp", "gpio0", "gpio1"
 };
 char *cx88_vid_irqs[32] = {
-	"y_risci1", "u_risci1", "v_risci1", "vbi_risc1", 
+	"y_risci1", "u_risci1", "v_risci1", "vbi_risc1",
 	"y_risci2", "u_risci2", "v_risci2", "vbi_risc2",
 	"y_oflow",  "u_oflow",  "v_oflow",  "vbi_oflow",
 	"y_sync",   "u_sync",   "v_sync",   "vbi_sync",
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-i2c.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-i2c.c	2004-11-07 12:22:20.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-i2c.c	2004-11-07 16:01:04.549276793 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-i2c.c,v 1.17 2004/10/11 13:45:51 kraxel Exp $
+    $Id: cx88-i2c.c,v 1.18 2004/10/13 10:39:00 kraxel Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
@@ -21,7 +21,7 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-    
+
 */
 
 #include <linux/module.h>
@@ -72,7 +72,7 @@ static int cx8800_bit_getscl(void *data)
 {
 	struct cx88_core *core = data;
 	u32 state;
-	
+
 	state = cx_read(MO_I2C);
 	return state & 0x02 ? 1 : 0;
 }
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-tvaudio.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-tvaudio.c	2004-11-07 12:22:29.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-tvaudio.c	2004-11-07 16:01:04.550276604 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-tvaudio.c,v 1.22 2004/10/11 13:45:51 kraxel Exp $
+    $Id: cx88-tvaudio.c,v 1.24 2004/10/25 11:51:00 kraxel Exp $
 
     cx88x-audio.c - Conexant CX23880/23881 audio downstream driver driver
 
@@ -18,9 +18,9 @@
 
     Some comes from the dscaler sources, one of the dscaler driver guy works
     for Conexant ...
-    
+
     -----------------------------------------------------------------------
-    
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -553,6 +553,13 @@ static void set_audio_standard_A2(struct
 	set_audio_start(core, 0x0004, EN_DMTRX_SUMDIFF | EN_A2_AUTO_STEREO);
 	set_audio_registers(core, a2_common);
 	switch (core->tvaudio) {
+	case WW_NICAM_I:
+		/* gives at least mono according to the dscaler guys */
+		/* so use use that while nicam is broken ...         */
+		dprintk("%s PAL-I mono (status: unknown)\n",__FUNCTION__);
+		set_audio_registers(core, a2_table1);
+		cx_write(AUD_CTL, EN_A2_FORCE_MONO1);
+		break;
 	case WW_A2_BG:
 		dprintk("%s PAL-BG A2 (status: known-good)\n",__FUNCTION__);
 		set_audio_registers(core, a2_table1);
@@ -601,7 +608,7 @@ static void set_audio_standard_FM(struct
 			cx_write(AUD_DEEMPH1_B0, 0x1C29);
 			cx_write(AUD_DEEMPH1_A1, 0x3FC66);
 			cx_write(AUD_DEEMPH1_B1, 0x399A);
-			
+
 			break;
 
 		case WW_FM_DEEMPH_75:
@@ -639,10 +646,11 @@ void cx88_set_tvaudio(struct cx88_core *
 	case WW_BTSC:
 		set_audio_standard_BTSC(core,0);
 		break;
-	case WW_NICAM_I:
+	// case WW_NICAM_I:
 	case WW_NICAM_BGDKL:
 		set_audio_standard_NICAM(core);
 		break;
+	case WW_NICAM_I:
 	case WW_A2_BG:
 	case WW_A2_DK:
 	case WW_A2_M:
@@ -750,7 +758,7 @@ void cx88_set_stereo(struct cx88_core *c
 	case WW_A2_DK:
 	case WW_A2_M:
 		switch (mode) {
-		case V4L2_TUNER_MODE_MONO:   
+		case V4L2_TUNER_MODE_MONO:
 		case V4L2_TUNER_MODE_LANG1:
 			ctl  = EN_A2_FORCE_MONO1;
 			mask = 0x3f;
@@ -767,7 +775,7 @@ void cx88_set_stereo(struct cx88_core *c
 		break;
 	case WW_NICAM_BGDKL:
 		switch (mode) {
-		case V4L2_TUNER_MODE_MONO:   
+		case V4L2_TUNER_MODE_MONO:
 			ctl  = EN_NICAM_FORCE_MONO1;
 			mask = 0x3f;
 			break;
@@ -780,10 +788,10 @@ void cx88_set_stereo(struct cx88_core *c
 			mask = 0x93f;
 			break;
 		}
-		break;	
+		break;
 	case WW_FM:
 		switch (mode) {
-		case V4L2_TUNER_MODE_MONO:   
+		case V4L2_TUNER_MODE_MONO:
 			ctl  = EN_FMRADIO_FORCE_MONO;
 			mask = 0x3f;
 			break;
@@ -792,7 +800,7 @@ void cx88_set_stereo(struct cx88_core *c
 			mask = 0x3f;
 			break;
 		}
-		break;	
+		break;
 	}
 
 	if (UNSET != ctl) {
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-video.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-video.c	2004-11-07 12:22:59.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-video.c	2004-11-07 16:01:04.551276416 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.40 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88-video.c,v 1.46 2004/11/07 14:44:59 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -41,18 +41,15 @@ MODULE_LICENSE("GPL");
 /* ------------------------------------------------------------------ */
 
 static unsigned int video_nr[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
-static unsigned int video_nr_num;
-module_param_array(video_nr,int,&video_nr_num,0444);
-MODULE_PARM_DESC(video_nr,"video device numbers");
+static unsigned int vbi_nr[]   = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
+static unsigned int radio_nr[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
 
-static unsigned int vbi_nr[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
-static unsigned int vbi_nr_num;
-module_param_array(vbi_nr,int,&vbi_nr_num,0444);
-MODULE_PARM_DESC(vbi_nr,"vbi device numbers");
+module_param_array(video_nr, int, NULL, 0444);
+module_param_array(vbi_nr,   int, NULL, 0444);
+module_param_array(radio_nr, int, NULL, 0444);
 
-static unsigned int radio_nr[] = {[0 ... (CX88_MAXBOARDS - 1)] = UNSET };
-static unsigned int radio_nr_num;
-module_param_array(radio_nr,int,&radio_nr_num,0444);
+MODULE_PARM_DESC(video_nr,"video device numbers");
+MODULE_PARM_DESC(vbi_nr,"vbi device numbers");
 MODULE_PARM_DESC(radio_nr,"radio device numbers");
 
 static unsigned int video_debug = 0;
@@ -210,7 +207,7 @@ static struct cx8800_fmt formats[] = {
 static struct cx8800_fmt* format_by_fourcc(unsigned int fourcc)
 {
 	unsigned int i;
-	
+
 	for (i = 0; i < ARRAY_SIZE(formats); i++)
 		if (formats[i].fourcc == fourcc)
 			return formats+i;
@@ -433,10 +430,10 @@ static int start_video_dma(struct cx8800
 	/* enable irqs */
 	cx_set(MO_PCI_INTMSK, 0x00fc01);
 	cx_set(MO_VID_INTMSK, 0x0f0011);
-	
+
 	/* enable capture */
 	cx_set(VID_CAPTURE_CONTROL,0x06);
-	
+
 	/* start dma */
 	cx_set(MO_DEV_CNTRL2, (1<<5));
 	cx_set(MO_VID_DMACNTRL, 0x11);
@@ -465,7 +462,7 @@ static int restart_video_queue(struct cx
 {
 	struct cx88_buffer *buf, *prev;
 	struct list_head *item;
-	
+
 	if (!list_empty(&q->active)) {
 	        buf = list_entry(q->active.next, struct cx88_buffer, vb.queue);
 		dprintk(2,"restart_queue [%p/%d]: restart dma\n",
@@ -514,10 +511,10 @@ static int restart_video_queue(struct cx
 /* ------------------------------------------------------------------ */
 
 static int
-buffer_setup(void *priv, unsigned int *count, unsigned int *size)
+buffer_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
-	struct cx8800_fh *fh = priv;
-	
+	struct cx8800_fh *fh = q->priv_data;
+
 	*size = fh->fmt->depth*fh->width*fh->height >> 3;
 	if (0 == *count)
 		*count = 32;
@@ -527,12 +524,12 @@ buffer_setup(void *priv, unsigned int *c
 }
 
 static int
-buffer_prepare(void *priv, struct videobuf_buffer *vb,
+buffer_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 	       enum v4l2_field field)
 {
-	struct cx8800_fh   *fh  = priv;
+	struct cx8800_fh   *fh  = q->priv_data;
 	struct cx8800_dev  *dev = fh->dev;
-	struct cx88_buffer *buf = (struct cx88_buffer*)vb;
+	struct cx88_buffer *buf = container_of(vb,struct cx88_buffer,vb);
 	int rc, init_buffer = 0;
 
 	BUG_ON(NULL == fh->fmt);
@@ -611,11 +608,11 @@ buffer_prepare(void *priv, struct videob
 }
 
 static void
-buffer_queue(void *priv, struct videobuf_buffer *vb)
+buffer_queue(struct videobuf_queue *vq, struct videobuf_buffer *vb)
 {
-	struct cx88_buffer    *buf  = (struct cx88_buffer*)vb;
+	struct cx88_buffer    *buf = container_of(vb,struct cx88_buffer,vb);
 	struct cx88_buffer    *prev;
-	struct cx8800_fh      *fh   = priv;
+	struct cx8800_fh      *fh   = vq->priv_data;
 	struct cx8800_dev     *dev  = fh->dev;
 	struct cx88_dmaqueue  *q    = &dev->vidq;
 
@@ -659,10 +656,10 @@ buffer_queue(void *priv, struct videobuf
 	}
 }
 
-static void buffer_release(void *priv, struct videobuf_buffer *vb)
+static void buffer_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct cx88_buffer *buf = (struct cx88_buffer*)vb;
-	struct cx8800_fh   *fh  = priv;
+	struct cx88_buffer *buf = container_of(vb,struct cx88_buffer,vb);
+	struct cx8800_fh   *fh  = q->priv_data;
 
 	cx88_free_buffer(fh->dev->pci,buf);
 }
@@ -722,7 +719,7 @@ static u32* ov_risc_field(struct cx8800_
 				ra = addr + (fh->fmt->depth>>3)*start;
 			else
 				ra = 0;
-				
+
 			if (0 == start)
 				ri |= RISC_SOL;
 			if (fh->win.w.width == end)
@@ -745,11 +742,11 @@ static int ov_risc_frame(struct cx8800_d
 	u32 instructions,fields;
 	u32 *rp;
 	int rc;
-	
+
 	/* skip list for window clipping */
 	if (NULL == (skips = kmalloc(sizeof(*skips) * fh->nclips,GFP_KERNEL)))
 		return -ENOMEM;
-	
+
 	fields = 0;
 	if (V4L2_FIELD_HAS_TOP(fh->win.field))
 		fields++;
@@ -875,7 +872,7 @@ static int setup_window(struct cx8800_de
 	default:
 		BUG();
 	}
-	
+
 	down(&fh->vidq.lock);
 	if (fh->clips)
 		kfree(fh->clips);
@@ -885,13 +882,13 @@ static int setup_window(struct cx8800_de
 #if 0
 	fh->ov.setup_ok = 1;
 #endif
-	
+
 	/* update overlay if needed */
 	retval = 0;
 #if 0
 	if (check_btres(fh, RESOURCE_OVERLAY)) {
 		struct bttv_buffer *new;
-		
+
 		new = videobuf_alloc(sizeof(*new));
 		bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
 		retval = bttv_switch_overlay(btv,fh,new);
@@ -938,7 +935,7 @@ static int video_open(struct inode *inod
 	struct list_head *list;
 	enum v4l2_buf_type type = 0;
 	int radio = 0;
-	
+
 	list_for_each(list,&cx8800_devlist) {
 		h = list_entry(list, struct cx8800_dev, devlist);
 		if (h->video_dev->minor == minor) {
@@ -978,14 +975,14 @@ static int video_open(struct inode *inod
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_INTERLACED,
-			    sizeof(struct cx88_buffer));
+			    sizeof(struct cx88_buffer),
+			    fh);
 	videobuf_queue_init(&fh->vbiq, &cx8800_vbi_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VBI_CAPTURE,
 			    V4L2_FIELD_SEQ_TB,
-			    sizeof(struct cx88_buffer));
-	init_MUTEX(&fh->vidq.lock);
-	init_MUTEX(&fh->vbiq.lock);
+			    sizeof(struct cx88_buffer),
+			    fh);
 
 	if (fh->radio) {
 		struct cx88_core *core = dev->core;
@@ -1013,14 +1010,12 @@ video_read(struct file *file, char *data
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		if (res_locked(fh->dev,RESOURCE_VIDEO))
 			return -EBUSY;
-		return videobuf_read_one(file->private_data,
-					 &fh->vidq, data, count, ppos,
+		return videobuf_read_one(&fh->vidq, data, count, ppos,
 					 file->f_flags & O_NONBLOCK);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 		if (!res_get(fh->dev,fh,RESOURCE_VBI))
 			return -EBUSY;
-		return videobuf_read_stream(file->private_data,
-					    &fh->vbiq, data, count, ppos, 1,
+		return videobuf_read_stream(&fh->vbiq, data, count, ppos, 1,
 					    file->f_flags & O_NONBLOCK);
 	default:
 		BUG();
@@ -1032,16 +1027,30 @@ static unsigned int
 video_poll(struct file *file, struct poll_table_struct *wait)
 {
 	struct cx8800_fh *fh = file->private_data;
+	struct cx88_buffer *buf;
 
 	if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
 		if (!res_get(fh->dev,fh,RESOURCE_VBI))
 			return POLLERR;
-		return videobuf_poll_stream(file, file->private_data,
-					    &fh->vbiq, wait);
+		return videobuf_poll_stream(file, &fh->vbiq, wait);
 	}
 
-	/* FIXME */
-	return POLLERR;
+	if (res_check(fh,RESOURCE_VIDEO)) {
+		/* streaming capture */
+		if (list_empty(&fh->vidq.stream))
+			return POLLERR;
+		buf = list_entry(fh->vidq.stream.next,struct cx88_buffer,vb.stream);
+	} else {
+		/* read() capture */
+		buf = (struct cx88_buffer*)fh->vidq.read_buf;
+		if (NULL == buf)
+			return POLLERR;
+	}
+	poll_wait(file, &buf->vb.done, wait);
+	if (buf->vb.state == STATE_DONE ||
+	    buf->vb.state == STATE_ERROR)
+		return POLLIN|POLLRDNORM;
+	return 0;
 }
 
 static int video_release(struct inode *inode, struct file *file)
@@ -1057,7 +1066,7 @@ static int video_release(struct inode *i
 
 	/* stop video capture */
 	if (res_check(fh, RESOURCE_VIDEO)) {
-		videobuf_queue_cancel(file->private_data,&fh->vidq);
+		videobuf_queue_cancel(&fh->vidq);
 		res_free(dev,fh,RESOURCE_VIDEO);
 	}
 	if (fh->vidq.read_buf) {
@@ -1068,9 +1077,9 @@ static int video_release(struct inode *i
 	/* stop vbi capture */
 	if (res_check(fh, RESOURCE_VBI)) {
 		if (fh->vbiq.streaming)
-			videobuf_streamoff(file->private_data,&fh->vbiq);
+			videobuf_streamoff(&fh->vbiq);
 		if (fh->vbiq.reading)
-			videobuf_read_stop(file->private_data,&fh->vbiq);
+			videobuf_read_stop(&fh->vbiq);
 		res_free(dev,fh,RESOURCE_VBI);
 	}
 
@@ -1084,7 +1093,7 @@ video_mmap(struct file *file, struct vm_
 {
 	struct cx8800_fh *fh = file->private_data;
 
-	return videobuf_mmap_mapper(vma, get_queue(fh));
+	return videobuf_mmap_mapper(get_queue(fh), vma);
 }
 
 /* ------------------------------------------------------------------ */
@@ -1095,7 +1104,7 @@ static int get_control(struct cx8800_dev
 	struct cx88_ctrl *c = NULL;
 	u32 value;
 	int i;
-	
+
 	for (i = 0; i < CX8800_CTLS; i++)
 		if (cx8800_ctls[i].v.id == ctl->id)
 			c = &cx8800_ctls[i];
@@ -1269,7 +1278,7 @@ static int cx8800_s_fmt(struct cx8800_de
 			struct v4l2_format *f)
 {
 	int err;
-	
+
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 		err = cx8800_try_fmt(dev,fh,f);
@@ -1311,7 +1320,7 @@ static int video_do_ioctl(struct inode *
 	case VIDIOC_QUERYCAP:
 	{
 		struct v4l2_capability *cap = arg;
-		
+
 		memset(cap,0,sizeof(*cap));
                 strcpy(cap->driver, "cx8800");
 		strlcpy(cap->card, cx88_boards[core->board].name,
@@ -1416,7 +1425,7 @@ static int video_do_ioctl(struct inode *
 	case VIDIOC_S_INPUT:
 	{
 		unsigned int *i = arg;
-		
+
 		if (*i >= 4)
 			return -EINVAL;
 		down(&dev->lock);
@@ -1520,13 +1529,13 @@ static int video_do_ioctl(struct inode *
 		return get_control(dev,arg);
 	case VIDIOC_S_CTRL:
 		return set_control(dev,arg);
-		
+
 	/* --- tuner ioctls ------------------------------------------ */
 	case VIDIOC_G_TUNER:
 	{
 		struct v4l2_tuner *t = arg;
 		u32 reg;
-		
+
 		if (UNSET == core->tuner_type)
 			return -EINVAL;
 		if (0 != t->index)
@@ -1603,7 +1612,7 @@ static int video_do_ioctl(struct inode *
 		req.type   = q->type;
 		req.count  = 8;
 		req.memory = V4L2_MEMORY_MMAP;
-		err = videobuf_reqbufs(file->private_data,q,&req);
+		err = videobuf_reqbufs(q,&req);
 		if (err < 0)
 			return err;
 		memset(mbuf,0,sizeof(*mbuf));
@@ -1616,16 +1625,16 @@ static int video_do_ioctl(struct inode *
 		return 0;
 	}
 	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(file->private_data, get_queue(fh), arg);
+		return videobuf_reqbufs(get_queue(fh), arg);
 
 	case VIDIOC_QUERYBUF:
 		return videobuf_querybuf(get_queue(fh), arg);
 
 	case VIDIOC_QBUF:
-		return videobuf_qbuf(file->private_data, get_queue(fh), arg);
+		return videobuf_qbuf(get_queue(fh), arg);
 
 	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(file->private_data, get_queue(fh), arg,
+		return videobuf_dqbuf(get_queue(fh), arg,
 				      file->f_flags & O_NONBLOCK);
 
 	case VIDIOC_STREAMON:
@@ -1634,13 +1643,13 @@ static int video_do_ioctl(struct inode *
 
                 if (!res_get(dev,fh,res))
 			return -EBUSY;
-		return videobuf_streamon(file->private_data, get_queue(fh));
+		return videobuf_streamon(get_queue(fh));
 	}
 	case VIDIOC_STREAMOFF:
 	{
 		int res = get_ressource(fh);
 
-		err = videobuf_streamoff(file->private_data, get_queue(fh));
+		err = videobuf_streamoff(get_queue(fh));
 		if (err < 0)
 			return err;
 		res_free(dev,fh,res);
@@ -1668,7 +1677,7 @@ static int radio_do_ioctl(struct inode *
 	struct cx8800_fh *fh    = file->private_data;
 	struct cx8800_dev *dev  = fh->dev;
 	struct cx88_core  *core = dev->core;
-	
+
 	if (video_debug > 1)
 		cx88_print_ioctl(core->name,cmd);
 
@@ -1676,7 +1685,7 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_QUERYCAP:
 	{
 		struct v4l2_capability *cap = arg;
-		
+
 		memset(cap,0,sizeof(*cap));
                 strcpy(cap->driver, "cx8800");
 		strlcpy(cap->card, cx88_boards[core->board].name,
@@ -1697,7 +1706,7 @@ static int radio_do_ioctl(struct inode *
 		strcpy(t->name, "Radio");
                 t->rangelow  = (int)(65*16);
                 t->rangehigh = (int)(108*16);
-		
+
 #ifdef V4L2_I2C_CLIENTS
 		cx88_call_i2c_clients(dev->core,VIDIOC_G_TUNER,t);
 #else
@@ -1713,7 +1722,7 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
-		
+
 		if (i->index != 0)
 			return -EINVAL;
 		strcpy(i->name,"Radio");
@@ -1770,7 +1779,7 @@ static int radio_do_ioctl(struct inode *
 	case VIDIOC_G_FREQUENCY:
 	case VIDIOC_S_FREQUENCY:
 		return video_do_ioctl(inode,file,cmd,arg);
-		
+
 	default:
 		return v4l_compat_translate_ioctl(inode,file,cmd,arg,
 						  radio_do_ioctl);
@@ -1795,7 +1804,7 @@ static void cx8800_vid_timeout(unsigned 
 	unsigned long flags;
 
 	cx88_sram_channel_dump(dev->core, &cx88_sram_channels[SRAM_CH21]);
-	
+
 	cx_clear(MO_VID_DMACNTRL, 0x11);
 	cx_clear(VID_CAPTURE_CONTROL, 0x06);
 
@@ -1833,7 +1842,7 @@ static void cx8800_vid_irq(struct cx8800
 		cx_clear(VID_CAPTURE_CONTROL, 0x06);
 		cx88_sram_channel_dump(dev->core, &cx88_sram_channels[SRAM_CH21]);
 	}
-	
+
 	/* risc1 y */
 	if (status & 0x01) {
 		spin_lock(&dev->slock);
@@ -1892,7 +1901,7 @@ static irqreturn_t cx8800_irq(int irq, v
 		       core->name);
 		cx_write(MO_PCI_INTMSK,0);
 	}
-	
+
  out:
 	return IRQ_RETVAL(handled);
 }
@@ -2134,7 +2143,7 @@ static void __devexit cx8800_finidev(str
 	cx88_shutdown(dev->core); /* FIXME */
 	pci_disable_device(pci_dev);
 
-	/* unregister stuff */	
+	/* unregister stuff */
 
 	free_irq(pci_dev->irq, dev);
 	cx8800_unregister_video(dev);
@@ -2170,7 +2179,7 @@ static int cx8800_suspend(struct pci_dev
 	/* FIXME -- shutdown device */
 	cx88_shutdown(dev->core);
 #endif
-	
+
 	pci_save_state(pci_dev);
 	if (0 != pci_set_power_state(pci_dev, state)) {
 		pci_disable_device(pci_dev);
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-vbi.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-vbi.c	2004-11-07 12:22:41.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-vbi.c	2004-11-07 16:01:04.551276416 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-vbi.c,v 1.12 2004/10/11 13:45:51 kraxel Exp $
+ * $Id: cx88-vbi.c,v 1.14 2004/11/07 13:17:15 kraxel Exp $
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -143,7 +143,7 @@ void cx8800_vbi_timeout(unsigned long da
 /* ------------------------------------------------------------------ */
 
 static int
-vbi_setup(void *priv, unsigned int *count, unsigned int *size)
+vbi_setup(struct videobuf_queue *q, unsigned int *count, unsigned int *size)
 {
 	*size = VBI_LINE_COUNT * VBI_LINE_LENGTH * 2;
 	if (0 == *count)
@@ -156,12 +156,12 @@ vbi_setup(void *priv, unsigned int *coun
 }
 
 static int
-vbi_prepare(void *priv, struct videobuf_buffer *vb,
+vbi_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 	    enum v4l2_field field)
 {
-	struct cx8800_fh   *fh  = priv;
+	struct cx8800_fh   *fh  = q->priv_data;
 	struct cx8800_dev  *dev = fh->dev;
-	struct cx88_buffer *buf = (struct cx88_buffer*)vb;
+	struct cx88_buffer *buf = container_of(vb,struct cx88_buffer,vb);
 	unsigned int size;
 	int rc;
 
@@ -192,11 +192,11 @@ vbi_prepare(void *priv, struct videobuf_
 }
 
 static void
-vbi_queue(void *priv, struct videobuf_buffer *vb)
+vbi_queue(struct videobuf_queue *vq, struct videobuf_buffer *vb)
 {
-	struct cx88_buffer    *buf  = (struct cx88_buffer*)vb;
+	struct cx88_buffer    *buf = container_of(vb,struct cx88_buffer,vb);
 	struct cx88_buffer    *prev;
-	struct cx8800_fh      *fh   = priv;
+	struct cx8800_fh      *fh   = vq->priv_data;
 	struct cx8800_dev     *dev  = fh->dev;
 	struct cx88_dmaqueue  *q    = &dev->vbiq;
 
@@ -224,10 +224,10 @@ vbi_queue(void *priv, struct videobuf_bu
 	}
 }
 
-static void vbi_release(void *priv, struct videobuf_buffer *vb)
+static void vbi_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct cx88_buffer *buf = (struct cx88_buffer*)vb;
-	struct cx8800_fh   *fh  = priv;
+	struct cx88_buffer *buf = container_of(vb,struct cx88_buffer,vb);
+	struct cx8800_fh   *fh  = q->priv_data;
 
 	cx88_free_buffer(fh->dev->pci,buf);
 }
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-mpeg.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-mpeg.c	2004-11-07 12:24:38.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-mpeg.c	2004-11-07 16:01:04.552276227 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-mpeg.c,v 1.11 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88-mpeg.c,v 1.14 2004/10/25 11:26:36 kraxel Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -239,7 +239,6 @@ static void cx8802_timeout(unsigned long
 	if (debug)
 		cx88_sram_channel_dump(dev->core, &cx88_sram_channels[SRAM_CH28]);
 	cx8802_stop_dma(dev);
-	dev->timeout_count++;
 	do_cancel_buffers(dev,"timeout",1);
 }
 
@@ -276,7 +275,6 @@ static void cx8802_mpeg_irq(struct cx880
 	/* risc2 y */
 	if (status & 0x10) {
 		spin_lock(&dev->slock);
-		dev->stopper_count++;
 		cx8802_restart_queue(dev,&dev->mpegq);
 		spin_unlock(&dev->slock);
 	}
@@ -284,7 +282,6 @@ static void cx8802_mpeg_irq(struct cx880
         /* other general errors */
         if (status & 0x1f0100) {
                 spin_lock(&dev->slock);
-		dev->error_count++;
 		cx8802_stop_dma(dev);
                 cx8802_restart_queue(dev,&dev->mpegq);
                 spin_unlock(&dev->slock);
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-dvb.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-dvb.c	2004-11-07 12:23:11.639793830 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-dvb.c	2004-11-07 16:01:04.552276227 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.12 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88-dvb.c,v 1.19 2004/11/07 14:44:59 kraxel Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -32,6 +32,8 @@
 
 #include "cx88.h"
 #include "cx22702.h"
+#include "mt352.h"
+#include "mt352_priv.h" /* FIXME */
 
 MODULE_DESCRIPTION("driver for cx2388x based DVB cards");
 MODULE_AUTHOR("Chris Pascoe <c.pascoe@itee.uq.edu.au>");
@@ -47,9 +49,10 @@ MODULE_PARM_DESC(debug,"enable debug mes
 
 /* ------------------------------------------------------------------ */
 
-static int dvb_buf_setup(void *priv, unsigned int *count, unsigned int *size)
+static int dvb_buf_setup(struct videobuf_queue *q,
+			 unsigned int *count, unsigned int *size)
 {
-	struct cx8802_dev *dev = priv;
+	struct cx8802_dev *dev = q->priv_data;
 
 	dev->ts_packet_size  = 188 * 4;
 	dev->ts_packet_count = 32;
@@ -59,22 +62,22 @@ static int dvb_buf_setup(void *priv, uns
 	return 0;
 }
 
-static int dvb_buf_prepare(void *priv, struct videobuf_buffer *vb,
+static int dvb_buf_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
 			   enum v4l2_field field)
 {
-	struct cx8802_dev *dev = priv;
+	struct cx8802_dev *dev = q->priv_data;
 	return cx8802_buf_prepare(dev, (struct cx88_buffer*)vb);
 }
 
-static void dvb_buf_queue(void *priv, struct videobuf_buffer *vb)
+static void dvb_buf_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct cx8802_dev *dev = priv;
+	struct cx8802_dev *dev = q->priv_data;
 	cx8802_buf_queue(dev, (struct cx88_buffer*)vb);
 }
 
-static void dvb_buf_release(void *priv, struct videobuf_buffer *vb)
+static void dvb_buf_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct cx8802_dev *dev = priv;
+	struct cx8802_dev *dev = q->priv_data;
 	cx88_free_buffer(dev->pci, (struct cx88_buffer*)vb);
 }
 
@@ -85,233 +88,141 @@ struct videobuf_queue_ops dvb_qops = {
 	.buf_release  = dvb_buf_release,
 };
 
-static int dvb_thread(void *data)
-{
-	struct cx8802_dev *dev = data;
-	struct videobuf_buffer *buf;
-	unsigned long flags;
-	int err;
-
-	dprintk(1,"dvb thread started\n");
-	videobuf_read_start(dev, &dev->dvbq);
-
-	for (;;) {
-		/* fetch next buffer */
-		buf = list_entry(dev->dvbq.stream.next,
-				 struct videobuf_buffer, stream);
-		list_del(&buf->stream);
-		err = videobuf_waiton(buf,0,1);
-		BUG_ON(0 != err);
-
-		/* no more feeds left or stop_feed() asked us to quit */
-		if (0 == dev->nfeeds)
-			break;
-		if (kthread_should_stop())
-			break;
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
-
-		/* feed buffer data to demux */
-		if (buf->state == STATE_DONE)
-			dvb_dmx_swfilter(&dev->demux, buf->dma.vmalloc,
-					 buf->size);
-
-		/* requeue buffer */
-		list_add_tail(&buf->stream,&dev->dvbq.stream);
-		spin_lock_irqsave(dev->dvbq.irqlock,flags);
-		dev->dvbq.ops->buf_queue(dev,buf);
-		spin_unlock_irqrestore(dev->dvbq.irqlock,flags);
-
-		/* log errors if any */
-		if (dev->error_count || dev->stopper_count) {
-			printk("%s: error=%d stopper=%d\n",
-			       dev->core->name, dev->error_count,
-			       dev->stopper_count);
-			dev->error_count   = 0;
-			dev->stopper_count = 0;
-		}
-		if (debug && dev->timeout_count) {
-			printk("%s: timeout=%d (FE not locked?)\n",
-			       dev->core->name, dev->timeout_count);
-			dev->timeout_count = 0;
-		}
-	}
-
-	videobuf_read_stop(dev, &dev->dvbq);
-	dprintk(1,"dvb thread stopped\n");
+/* ------------------------------------------------------------------ */
 
-	/* Hmm, linux becomes *very* unhappy without this ... */
-	while (!kthread_should_stop()) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule();
-	}
+static int dvico_fusionhdtv_demod_init(struct dvb_frontend* fe)
+{
+	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x39 };
+	static u8 reset []         = { RESET,      0x80 };
+	static u8 adc_ctl_1_cfg [] = { ADC_CTL_1,  0x40 };
+	static u8 agc_cfg []       = { AGC_TARGET, 0x24, 0x20 };
+	static u8 gpp_ctl_cfg []   = { GPP_CTL,    0x33 };
+	static u8 capt_range_cfg[] = { CAPT_RANGE, 0x32 };
+
+	mt352_write(fe, clock_config,   sizeof(clock_config));
+	udelay(200);
+	mt352_write(fe, reset,          sizeof(reset));
+	mt352_write(fe, adc_ctl_1_cfg,  sizeof(adc_ctl_1_cfg));
+
+	mt352_write(fe, agc_cfg,        sizeof(agc_cfg));
+	mt352_write(fe, gpp_ctl_cfg,    sizeof(gpp_ctl_cfg));
+	mt352_write(fe, capt_range_cfg, sizeof(capt_range_cfg));
 	return 0;
 }
 
-/* ---------------------------------------------------------------------------- */
+#define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
 
-static int dvb_start_feed(struct dvb_demux_feed *feed)
+static int lg_z201_pll_set(struct dvb_frontend* fe,
+			   struct dvb_frontend_parameters* params, u8* pllbuf)
 {
-	struct dvb_demux *demux = feed->demux;
-	struct cx8802_dev *dev = demux->priv;
-	int rc;
+	u32 div;
+	unsigned char cp = 0;
+	unsigned char bs = 0;
+
+	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
+
+	if (params->frequency < 542000000) cp = 0xbc;
+	else if (params->frequency < 830000000) cp = 0xf4;
+	else cp = 0xfc;
+
+	if (params->frequency == 0) bs = 0x03;
+	else if (params->frequency < 157500000) bs = 0x01;
+	else if (params->frequency < 443250000) bs = 0x02;
+	else bs = 0x04;
+
+	pllbuf[0] = 0xC2; /* Note: non-linux standard PLL I2C address */
+	pllbuf[1] = div >> 8;
+	pllbuf[2] = div & 0xff;
+	pllbuf[3] = cp;
+	pllbuf[4] = bs;
 
-	if (!demux->dmx.frontend)
-		return -EINVAL;
+	return 0;
+}
 
-	down(&dev->lock);
-	dev->nfeeds++;
-	rc = dev->nfeeds;
-
-	if (NULL != dev->dvb_thread)
-		goto out;
-	dev->dvb_thread = kthread_run(dvb_thread, dev, "%s dvb", dev->core->name);
-	if (IS_ERR(dev->dvb_thread)) {
-		rc = PTR_ERR(dev->dvb_thread);
-		dev->dvb_thread = NULL;
-	}
+static int thomson_dtt7579_pll_set(struct dvb_frontend* fe,
+				   struct dvb_frontend_parameters* params,
+				   u8* pllbuf)
+{
+	u32 div;
+	unsigned char cp = 0;
+	unsigned char bs = 0;
+
+	div = (((params->frequency + 83333) * 3) / 500000) + IF_FREQUENCYx6;
+
+	if (params->frequency < 542000000) cp = 0xb4;
+	else if (params->frequency < 771000000) cp = 0xbc;
+	else cp = 0xf4;
+
+        if (params->frequency == 0) bs = 0x03;
+	else if (params->frequency < 443250000) bs = 0x02;
+	else bs = 0x08;
+
+	pllbuf[0] = 0xc0; // Note: non-linux standard PLL i2c address
+	pllbuf[1] = div >> 8;
+   	pllbuf[2] = div & 0xff;
+   	pllbuf[3] = cp;
+   	pllbuf[4] = bs;
 
-out:
-	up(&dev->lock);
-	dprintk(2, "%s rc=%d\n",__FUNCTION__,rc);
-	return rc;
-}
-
-static int dvb_stop_feed(struct dvb_demux_feed *feed)
-{
-	struct dvb_demux *demux = feed->demux;
-	struct cx8802_dev *dev = demux->priv;
-	int err = 0;
-
-	dprintk(2, "%s\n",__FUNCTION__);
-
-	down(&dev->lock);
-	dev->nfeeds--;
-	if (0 == dev->nfeeds  &&  NULL != dev->dvb_thread) {
-		cx8802_cancel_buffers(dev);
-		err = kthread_stop(dev->dvb_thread);
-		dev->dvb_thread = NULL;
-	}
-	up(&dev->lock);
-	return err;
+	return 0;
 }
 
-static void dvb_unregister(struct cx8802_dev *dev)
-{
-#if 1 /* really needed? */
-	down(&dev->lock);
-	if (NULL != dev->dvb_thread) {
-		kthread_stop(dev->dvb_thread);
-		BUG();
-	}
-	up(&dev->lock);
-#endif
+struct mt352_config dvico_fusionhdtv_dvbt1 = {
+	.demod_address = 0x0F,
+	.demod_init    = dvico_fusionhdtv_demod_init,
+	.pll_set       = lg_z201_pll_set,
+};
 
-	dvb_net_release(&dev->dvbnet);
-	dev->demux.dmx.remove_frontend(&dev->demux.dmx, &dev->fe_mem);
-	dev->demux.dmx.remove_frontend(&dev->demux.dmx, &dev->fe_hw);
-	dvb_dmxdev_release(&dev->dmxdev);
-	dvb_dmx_release(&dev->demux);
-	if (dev->fe_handle)
-		dev->fe_release(dev->fe_handle);
-	dvb_unregister_adapter(dev->dvb_adapter);
-	return;
-}
+struct mt352_config dvico_fusionhdtv_dvbt_plus = {
+	.demod_address = 0x0F,
+	.demod_init    = dvico_fusionhdtv_demod_init,
+	.pll_set       = thomson_dtt7579_pll_set,
+};
 
 static int dvb_register(struct cx8802_dev *dev)
 {
-	int result;
+	/* init struct videobuf_dvb */
+	dev->dvb.name = dev->core->name;
 
-	/* adapter */
-	result = dvb_register_adapter(&dev->dvb_adapter, dev->core->name,
-				      THIS_MODULE);
-	if (result < 0) {
-		printk(KERN_WARNING "%s: dvb_register_adapter failed (errno = %d)\n",
-		       dev->core->name, result);
-		goto fail1;
-	}
-
-	/* frontend */
+	/* init frontend */
 	switch (dev->core->board) {
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
 	case CX88_BOARD_CONEXANT_DVB_T1:
-		dev->fe_handle = cx22702_create(&dev->core->i2c_adap,
-						dev->dvb_adapter,
-						dev->core->pll_addr,
-						dev->core->pll_type,
-						dev->core->demod_addr);
-		dev->fe_release = cx22702_destroy;
+		dev->dvb.frontend = cx22702_create(&dev->core->i2c_adap,
+						   dev->core->pll_addr,
+						   dev->core->pll_type,
+						   dev->core->demod_addr);
+		break;
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
+		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv_dvbt1,
+						 &dev->core->i2c_adap);
+		if (dev->dvb.frontend) {
+			dev->dvb.frontend->ops->info.frequency_min = 174000000;
+			dev->dvb.frontend->ops->info.frequency_max = 862000000;
+		}
+		break;
+	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T_PLUS:
+		dev->dvb.frontend = mt352_attach(&dvico_fusionhdtv_dvbt_plus,
+						 &dev->core->i2c_adap);
+		if (dev->dvb.frontend) {
+			dev->dvb.frontend->ops->info.frequency_min = 174000000;
+			dev->dvb.frontend->ops->info.frequency_max = 862000000;
+		}
 		break;
 	default:
-		printk("%s: FIXME: frontend handing not here yet ...\n",
+		printk("%s: FIXME: frontend handling not here yet ...\n",
 		       dev->core->name);
 		break;
 	}
+	if (NULL == dev->dvb.frontend)
+		return -1;
 
-	/* demux */
-	dev->demux.dmx.capabilities =
-		DMX_TS_FILTERING | DMX_SECTION_FILTERING |
-		DMX_MEMORY_BASED_FILTERING;
-	dev->demux.priv       = dev;
-	dev->demux.filternum  = 256;
-	dev->demux.feednum    = 256;
-	dev->demux.start_feed = dvb_start_feed;
-	dev->demux.stop_feed  = dvb_stop_feed;
-	result = dvb_dmx_init(&dev->demux);
-	if (result < 0) {
-		printk(KERN_WARNING "%s: dvb_dmx_init failed (errno = %d)\n",
-		       dev->core->name, result);
-		goto fail2;
-	}
+	/* Copy the board name into the DVB structure */
+	strlcpy(dev->dvb.frontend->ops->info.name,
+		cx88_boards[dev->core->board].name,
+		sizeof(dev->dvb.frontend->ops->info.name));
 
-	dev->dmxdev.filternum    = 256;
-	dev->dmxdev.demux        = &dev->demux.dmx;
-	dev->dmxdev.capabilities = 0;
-	result = dvb_dmxdev_init(&dev->dmxdev, dev->dvb_adapter);
-	if (result < 0) {
-		printk(KERN_WARNING "%s: dvb_dmxdev_init failed (errno = %d)\n",
-		       dev->core->name, result);
-		goto fail3;
-	}
-
-	dev->fe_hw.source = DMX_FRONTEND_0;
-	result = dev->demux.dmx.add_frontend(&dev->demux.dmx, &dev->fe_hw);
-	if (result < 0) {
-		printk(KERN_WARNING "%s: add_frontend failed (DMX_FRONTEND_0, errno = %d)\n",
-		       dev->core->name, result);
-		goto fail4;
-	}
-
-	dev->fe_mem.source = DMX_MEMORY_FE;
-	result = dev->demux.dmx.add_frontend(&dev->demux.dmx, &dev->fe_mem);
-	if (result < 0) {
-		printk(KERN_WARNING "%s: add_frontend failed (DMX_MEMORY_FE, errno = %d)\n",
-		       dev->core->name, result);
-		goto fail5;
-	}
-
-	result = dev->demux.dmx.connect_frontend(&dev->demux.dmx, &dev->fe_hw);
-	if (result < 0) {
-		printk(KERN_WARNING "%s: connect_frontend failed (errno = %d)\n",
-		       dev->core->name, result);
-		goto fail6;
-	}
-
-	dvb_net_init(dev->dvb_adapter, &dev->dvbnet, &dev->demux.dmx);
-	return 0;
-
-fail6:
-	dev->demux.dmx.remove_frontend(&dev->demux.dmx, &dev->fe_mem);
-fail5:
-	dev->demux.dmx.remove_frontend(&dev->demux.dmx, &dev->fe_hw);
-fail4:
-	dvb_dmxdev_release(&dev->dmxdev);
-fail3:
-	dvb_dmx_release(&dev->demux);
-fail2:
-	dvb_unregister_adapter(dev->dvb_adapter);
-fail1:
-	return result;
+	/* register everything */
+	return videobuf_dvb_register(&dev->dvb);
 }
 
 /* ----------------------------------------------------------- */
@@ -346,13 +257,12 @@ static int __devinit dvb_probe(struct pc
 
 	/* dvb stuff */
 	printk("%s/2: cx2388x based dvb card\n", core->name);
-	videobuf_queue_init(&dev->dvbq, &dvb_qops,
+	videobuf_queue_init(&dev->dvb.dvbq, &dvb_qops,
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_TOP,
-			    sizeof(struct cx88_buffer));
-	init_MUTEX(&dev->dvbq.lock);
-
+			    sizeof(struct cx88_buffer),
+			    dev);
 	err = dvb_register(dev);
 	if (0 != err)
 		goto fail_free;
@@ -370,7 +280,7 @@ static void __devexit dvb_remove(struct 
         struct cx8802_dev *dev = pci_get_drvdata(pci_dev);
 
 	/* dvb */
-	dvb_unregister(dev);
+	videobuf_dvb_unregister(&dev->dvb);
 
 	/* common */
 	cx8802_fini_common(dev);
@@ -394,7 +304,7 @@ static struct pci_driver dvb_pci_driver 
         .name     = "cx88-dvb",
         .id_table = cx8802_pci_tbl,
         .probe    = dvb_probe,
-        .remove   = dvb_remove,
+        .remove   = __devexit_p(dvb_remove),
 	.suspend  = cx8802_suspend_common,
 	.resume   = cx8802_resume_common,
 };
@@ -423,5 +333,6 @@ module_exit(dvb_fini);
 /*
  * Local variables:
  * c-basic-offset: 8
+ * compile-command: "make DVB=1"
  * End:
  */
Index: linux-2004-11-05/drivers/media/video/cx88/cx88-blackbird.c
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/cx88-blackbird.c	2004-11-07 12:23:49.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/cx88-blackbird.c	2004-11-07 16:01:04.553276038 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-blackbird.c,v 1.14 2004/10/12 07:33:22 kraxel Exp $
+ * $Id: cx88-blackbird.c,v 1.17 2004/11/07 13:17:15 kraxel Exp $
  *
  *  Support for a cx23416 mpeg encoder via cx2388x host port.
  *  "blackbird" reference design.
@@ -543,9 +543,10 @@ static int blackbird_initialize_codec(st
 
 /* ------------------------------------------------------------------ */
 
-static int bb_buf_setup(void *priv, unsigned int *count, unsigned int *size)
+static int bb_buf_setup(struct videobuf_queue *q,
+			unsigned int *count, unsigned int *size)
 {
-	struct cx8802_fh *fh = priv;
+	struct cx8802_fh *fh = q->priv_data;
 
 	fh->dev->ts_packet_size  = 512;
 	fh->dev->ts_packet_count = 100;
@@ -561,23 +562,24 @@ static int bb_buf_setup(void *priv, unsi
 }
 
 static int
-bb_buf_prepare(void *priv, struct videobuf_buffer *vb,
-		 enum v4l2_field field)
+bb_buf_prepare(struct videobuf_queue *q, struct videobuf_buffer *vb,
+	       enum v4l2_field field)
 {
-	struct cx8802_fh *fh = priv;
+	struct cx8802_fh *fh = q->priv_data;
 	return cx8802_buf_prepare(fh->dev, (struct cx88_buffer*)vb);
 }
 
 static void
-bb_buf_queue(void *priv, struct videobuf_buffer *vb)
+bb_buf_queue(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct cx8802_fh *fh = priv;
+	struct cx8802_fh *fh = q->priv_data;
 	cx8802_buf_queue(fh->dev, (struct cx88_buffer*)vb);
 }
 
-static void bb_buf_release(void *priv, struct videobuf_buffer *vb)
+static void
+bb_buf_release(struct videobuf_queue *q, struct videobuf_buffer *vb)
 {
-	struct cx8802_fh *fh = priv;
+	struct cx8802_fh *fh = q->priv_data;
 	cx88_free_buffer(fh->dev->pci, (struct cx88_buffer*)vb);
 }
 
@@ -635,23 +637,23 @@ static int mpeg_do_ioctl(struct inode *i
 
 	/* --- streaming capture ------------------------------------- */
 	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(file->private_data, &fh->mpegq, arg);
+		return videobuf_reqbufs(&fh->mpegq, arg);
 
 	case VIDIOC_QUERYBUF:
 		return videobuf_querybuf(&fh->mpegq, arg);
 
 	case VIDIOC_QBUF:
-		return videobuf_qbuf(file->private_data, &fh->mpegq, arg);
+		return videobuf_qbuf(&fh->mpegq, arg);
 
 	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(file->private_data, &fh->mpegq, arg,
+		return videobuf_dqbuf(&fh->mpegq, arg,
 				      file->f_flags & O_NONBLOCK);
 
 	case VIDIOC_STREAMON:
-		return videobuf_streamon(file->private_data, &fh->mpegq);
+		return videobuf_streamon(&fh->mpegq);
 
 	case VIDIOC_STREAMOFF:
-		return videobuf_streamoff(file->private_data, &fh->mpegq);
+		return videobuf_streamoff(&fh->mpegq);
 
 	default:
 		return -EINVAL;
@@ -696,9 +698,8 @@ static int mpeg_open(struct inode *inode
 			    dev->pci, &dev->slock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
 			    V4L2_FIELD_TOP,
-			    sizeof(struct cx88_buffer));
-	init_MUTEX(&fh->mpegq.lock);
-
+			    sizeof(struct cx88_buffer),
+			    fh);
 	return 0;
 }
 
@@ -710,9 +711,9 @@ static int mpeg_release(struct inode *in
 
 	/* stop mpeg capture */
 	if (fh->mpegq.streaming)
-		videobuf_streamoff(file->private_data,&fh->mpegq);
+		videobuf_streamoff(&fh->mpegq);
 	if (fh->mpegq.reading)
-		videobuf_read_stop(file->private_data,&fh->mpegq);
+		videobuf_read_stop(&fh->mpegq);
 
 	file->private_data = NULL;
 	kfree(fh);
@@ -724,8 +725,7 @@ mpeg_read(struct file *file, char *data,
 {
 	struct cx8802_fh *fh = file->private_data;
 
-	return videobuf_read_stream(file->private_data,
-				    &fh->mpegq, data, count, ppos, 0,
+	return videobuf_read_stream(&fh->mpegq, data, count, ppos, 0,
 				    file->f_flags & O_NONBLOCK);
 }
 
@@ -734,8 +734,7 @@ mpeg_poll(struct file *file, struct poll
 {
 	struct cx8802_fh *fh = file->private_data;
 
-	return videobuf_poll_stream(file, file->private_data,
-				    &fh->mpegq, wait);
+	return videobuf_poll_stream(file, &fh->mpegq, wait);
 }
 
 static int
@@ -743,7 +742,7 @@ mpeg_mmap(struct file *file, struct vm_a
 {
 	struct cx8802_fh *fh = file->private_data;
 
-	return videobuf_mmap_mapper(vma, &fh->mpegq);
+	return videobuf_mmap_mapper(&fh->mpegq, vma);
 }
 
 static struct file_operations mpeg_fops =
@@ -871,7 +870,7 @@ static struct pci_driver blackbird_pci_d
         .name     = "cx88-blackbird",
         .id_table = cx8802_pci_tbl,
         .probe    = blackbird_probe,
-        .remove   = blackbird_remove,
+        .remove   = __devexit_p(blackbird_remove),
 	.suspend  = cx8802_suspend_common,
 	.resume   = cx8802_resume_common,
 };
Index: linux-2004-11-05/drivers/media/video/Kconfig
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/Kconfig	2004-11-07 16:00:38.239242292 +0100
+++ linux-2004-11-05/drivers/media/video/Kconfig	2004-11-07 16:01:28.435768837 +0100
@@ -315,12 +315,13 @@ config VIDEO_CX88
 	  To compile this driver as a module, choose M here: the
 	  module will be called cx8800
 
-#config VIDEO_CX88_DVB
-#	tristate "DVB Support for cx2388x based TV cards"
-#	depends on VIDEO_CX88 && DVB_CORE
-#	---help---
-#	  This adds support for DVB cards based on the
-#	  Connexant 2388x chip.
+config VIDEO_CX88_DVB
+	tristate "DVB Support for cx2388x based TV cards"
+	depends on VIDEO_CX88 && DVB_CORE && BROKEN
+	select VIDEO_BUF_DVB
+	---help---
+	  This adds support for DVB cards based on the
+	  Connexant 2388x chip.
 
 config VIDEO_OVCAMCHIP
 	tristate "OmniVision Camera Chip support"
Index: linux-2004-11-05/drivers/media/video/cx88/Makefile
===================================================================
--- linux-2004-11-05.orig/drivers/media/video/cx88/Makefile	2004-11-07 12:21:50.000000000 +0100
+++ linux-2004-11-05/drivers/media/video/cx88/Makefile	2004-11-07 16:01:04.554275850 +0100
@@ -5,4 +5,6 @@ cx8802-objs	:= cx88-mpeg.o
 obj-$(CONFIG_VIDEO_CX88) += cx88xx.o cx8800.o cx8802.o cx88-blackbird.o
 obj-$(CONFIG_VIDEO_CX88_DVB) += cx88-dvb.o
 
-EXTRA_CFLAGS = -I$(src)/.. -I$(srctree)/drivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -I$(src)/..
+EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/dvb-core
+EXTRA_CFLAGS += -I$(srctree)/drivers/media/dvb/frontends

-- 
#define printk(args...) fprintf(stderr, ## args)
