Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbTGOMQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbTGOMOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:14:39 -0400
Received: from mail.convergence.de ([212.84.236.4]:35232 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267475AbTGOMGJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:09 -0400
Subject: [PATCH 7/17] Update the DVB av7110 driver
In-Reply-To: <10582716551228@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:56 +0200
Message-Id: <10582716563797@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - Fix to 'Sharing SDRAM between TT re-insertion and OSD...' - OSD didn't get the maximum available memory in one piece; needs new firmware version 0x2616
[DVB] - Improved performance when setting palette with full 256 color OSD
[DVB] - read MAC from EEPROM if available, contributed by Michael Glaum <mglaum@kvh.com>
[DVB] - add some MODULE_PARM_DESC for modinfo
[DVB] - add support for the "analog module" available for DVB-C cards: the saa7113 is initialized and some more v4l2 ioctls are available. you can use "xawtv" now to switch between "dvb" and "analog" input. when you are one the "analog" input, you can tune in analog channels.
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/av7110.c linux-2.5.73.work/drivers/media/dvb/ttpci/av7110.c
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/av7110.c	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/av7110.c	2003-06-23 12:40:49.000000000 +0200
@@ -86,6 +86,7 @@
 	#define DEB_EE(x)
 #endif
 
+#include "ttpci-eeprom.h"
 #include "av7110.h"
 #include "av7110_ipack.h"
 
@@ -110,7 +112,8 @@
 
 int av7110_num = 0;
 
-#define FW_CI_LL_SUPPORT(arm_app) (((arm_app) >> 16) & 0x8000)
+#define FW_CI_LL_SUPPORT(arm_app) ((arm_app) & 0x80000000)
+#define FW_VERSION(arm_app)       ((arm_app) & 0x0000FFFF)
 
 /****************************************************************************
  * DEBI functions
@@ -1089,7 +1092,7 @@
         u32 stat;
 #endif
 
-	DEB_EE(("av7110: %p\n",av7110));
+//	DEB_EE(("av7110: %p\n",av7110));
 
 	if (!av7110->arm_ready) {
 		DEB_D(("arm not ready.\n"));
@@ -1166,7 +1169,7 @@
 {
         int ret;
         
- 	DEB_EE(("av7110: %p\n",av7110));
+// 	DEB_EE(("av7110: %p\n",av7110));
 
         if (!av7110->arm_ready) {
 		DEB_D(("arm not ready.\n"));
@@ -1190,7 +1193,7 @@
         u16 buf[num+2];
         int i, ret;
 
- 	DEB_EE(("av7110: %p\n",av7110));
+// 	DEB_EE(("av7110: %p\n",av7110));
 
         buf[0]=(( type << 8 ) | com);
         buf[1]=num;
@@ -1332,7 +1335,7 @@
 
 static inline int SendDAC(struct av7110 *av7110, u8 addr, u8 data)
 {
- 	DEB_EE(("av7110: %p\n",av7110));
+// 	DEB_EE(("av7110: %p\n",av7110));
 
         return outcom(av7110, COMTYPE_AUDIODAC, AudioDAC, 2, addr, data);
 }
@@ -1659,6 +1662,24 @@
                   color, ((blend>>4)&0x0f));
 }
 
+static int OSDSetPalette(struct av7110 *av7110, u32 *colors, u8 first, u8 last)
+{
+       int i;
+       int length = last - first + 1;
+
+       if (length * 4 > DATA_BUFF3_SIZE)
+               return -1;
+
+       for (i=0; i<length; i++) {
+               u32 blend = (colors[i] & 0xF0000000) >> 4;
+               u32 yuv = blend ? RGB2YUV(colors[i] & 0xFF, (colors[i] >> 8) & 0xFF, (colors[i] >> 16) & 0xFF) | blend : 0;
+               yuv = ((yuv & 0xFFFF0000) >> 16) | ((yuv & 0x0000FFFF) << 16); // TODO kls2003-06-15: not sure if this is endian-proof
+               wdebi(av7110, DEBINOSWAP, DATA_BUFF3_BASE + i*4, yuv, 4);
+       }
+       return outcom(av7110, COMTYPE_OSD, Set_Palette, 4,
+               av7110->osdwin, bpp2pal[av7110->osdbpp[av7110->osdwin]], first, last);
+}
+
 static int OSDSetBlock(struct av7110 *av7110, int x0, int y0, int x1, int y1, int inc, u8 *data)
 {
         uint w, h, bpp, bpl, size, lpb, bnum, brest;
@@ -1721,6 +1742,9 @@
                 return 0;
         case OSD_SetPalette:
         {      
+                if (FW_VERSION(av7110->arm_app) >= 0x2618)
+                        OSDSetPalette(av7110, (u32 *)dc->data, dc->color, dc->x0);
+                else {
                 int i, len=dc->x0-dc->color+1;
                 u8 *colors=(u8 *)dc->data;
 
@@ -1728,6 +1752,7 @@
                         OSDSetColor(av7110, dc->color+i,
                                     colors[i*4]  , colors[i*4+1],
                                     colors[i*4+2], colors[i*4+3]);
+                }
                 return 0;
         }
         case OSD_SetTrans: 
@@ -2087,28 +2112,28 @@
 
 static inline void TestMode(struct av7110 *av7110, int mode)
 {
- 	DEB_EE(("av7110: %p\n",av7110));
+//	DEB_EE(("av7110: %p\n",av7110));
         outcom(av7110, COMTYPE_ENCODER, SetTestMode, 1, mode);
 }
 
 static inline void VidMode(struct av7110 *av7110, int mode)
 {
- 	DEB_EE(("av7110: %p\n",av7110));
+// 	DEB_EE(("av7110: %p\n",av7110));
         outcom(av7110, COMTYPE_ENCODER, SetVidMode, 1, mode);
 }
            
 
-static inline int vidcom(struct av7110 *av7110, u32 com, u32 arg)
+static int inline vidcom(struct av7110 *av7110, u32 com, u32 arg)
 {
- 	DEB_EE(("av7110: %p\n",av7110));
+// 	DEB_EE(("av7110: %p\n",av7110));
         return outcom(av7110, 0x80, 0x02, 4, 
                       (com>>16), (com&0xffff), 
                       (arg>>16), (arg&0xffff));
 }
 
-static inline int audcom(struct av7110 *av7110, u32 com)
+static int inline audcom(struct av7110 *av7110, u32 com)
 {
-	DEB_EE(("av7110: %p\n",av7110));
+//	DEB_EE(("av7110: %p\n",av7110));
 	return outcom(av7110, 0x80, 0x03, 4, 
                       (com>>16), (com&0xffff));
 }
@@ -2583,38 +2608,274 @@
  * V4L SECTION
  ****************************************************************************/
 
-int av7110_ioctl(struct saa7146_dev *dev, unsigned int cmd, void *arg) 
+static struct v4l2_input inputs[2] = {
+	{ 0,	"DVB",		V4L2_INPUT_TYPE_CAMERA,	1, 0, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 }, 
+	{ 1,	"ANALOG",	V4L2_INPUT_TYPE_TUNER,	2, 1, V4L2_STD_PAL_BG|V4L2_STD_NTSC_M, 0 },
+};
+
+/* taken from ves1820.c */
+static int ves1820_writereg(struct saa7146_dev *dev, u8 reg, u8 data)
 {
+	u8 addr = 0x09;
+        u8 buf[] = { 0x00, reg, data };
+	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = 3 };
+
+  	DEB_EE(("av7710: dev: %p\n",dev));
+
+	if( 1 != saa7146_i2c_transfer(dev, &msg, 1, 1)) {
+		return -1;
+	}
+	return 0;
+}
+
+static int tuner_write(struct saa7146_dev *dev, u8 addr, u8 data [4])
+{
+        struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = data, .len = 4 };
+
+  	DEB_EE(("av7710: dev: %p\n",dev));
+
+	if( 1 != saa7146_i2c_transfer(dev, &msg, 1, 1)) {
+		return -1;
+	}
+	return 0;
+}
+
+
+/**
+ *   set up the downconverter frequency divisor for a
+ *   reference clock comparision frequency of 62.5 kHz.
+ */
+static int tuner_set_tv_freq (struct saa7146_dev *dev, u32 freq)
+{
+        u32 div;
+	u8 config;
+        u8 buf [4];
+
+ 	DEB_EE(("av7710: freq: 0x%08x\n",freq));
+
+	/* magic number: 56. tuning with the frequency given by v4l2
+	   is always off by 56*62.5 kHz...*/
+	div = freq + 56;
+
+	buf[0] = (div >> 8) & 0x7f;
+	buf[1] = div & 0xff;
+	buf[2] = 0x8e;
+
+	if (freq < 16*168.25 ) 
+		config = 0xa0;
+	else if (freq < 16*447.25) 
+		config = 0x90;
+	else
+		config = 0x30;
+	config &= ~0x02;
+
+	buf[3] = config;
+
+        return tuner_write (dev, 0x61, buf);
+}
+
+static struct saa7146_standard analog_standard[];
+static struct saa7146_standard dvb_standard[];
+static struct saa7146_standard standard[];
+
+int av7110_dvb_c_switch(struct saa7146_fh *fh)
+{
+	struct saa7146_dev *dev = fh->dev;
+	struct saa7146_vv *vv = dev->vv_data;
+	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
+	u16 buf[3] = { ((COMTYPE_AUDIODAC << 8) + ADSwitch), 1, 1 };
+
+	u8 band = 0;
+	int source, sync;
+	struct saa7146_fh *ov_fh = NULL;
+	int restart_overlay = 0;
+
+	DEB_EE(("av7110: %p\n",av7110));
+
+	if( vv->ov_data != NULL ) {
+		ov_fh = vv->ov_data->fh;
+		saa7146_stop_preview(ov_fh);
+		restart_overlay = 1;
+	}
+
+	if( 0 != av7110->current_input ) {
+		buf[2] = 0;
+		band = 0x68; /* analog band */
+		source = SAA7146_HPS_SOURCE_PORT_B;
+		sync = SAA7146_HPS_SYNC_PORT_B;
+		memcpy(standard,analog_standard,sizeof(struct saa7146_standard)*2);
+	} else {
+		buf[2] = 1;
+		band = 0x28; /* digital band */	
+		source = SAA7146_HPS_SOURCE_PORT_A;
+		sync = SAA7146_HPS_SYNC_PORT_A;
+		memcpy(standard,dvb_standard,sizeof(struct saa7146_standard)*2);
+	}
+
+	/* hmm, this does not do anything!? */
+	if (OutCommand(av7110, buf, 3)) {
+		printk("ADSwitch error\n");
+	}
+
+	if( 0 != ves1820_writereg(dev, 0x0f, band )) {
+		printk("setting band in demodulator failed.\n");
+	}
+	saa7146_set_hps_source_and_sync(dev, source, sync);
+
+	/* restart overlay if it was active before */
+	if( 0 != restart_overlay ) {
+		saa7146_start_preview(ov_fh);
+	}
+
+	return 0;
+}
+
+int av7110_ioctl(struct saa7146_fh *fh, unsigned int cmd, void *arg) 
+{
+	struct saa7146_dev *dev = fh->dev;
+	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
  	DEB_EE(("saa7146_dev: %p\n",dev));
 
 	switch(cmd) {
+	case VIDIOC_G_TUNER:
+	{
+		struct v4l2_tuner *t = arg;
+
+		DEB_EE(("VIDIOC_G_TUNER: %d\n", t->index));
+
+		if( 0 == av7110->has_analog_tuner || av7110->current_input != 1 ) {
+			return -EINVAL;
+		}
+
+		memset(t,0,sizeof(*t));
+		strcpy(t->name, "Television");
+
+		t->type = V4L2_TUNER_ANALOG_TV;
+		t->capability = V4L2_TUNER_CAP_NORM | V4L2_TUNER_CAP_STEREO | V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2 | V4L2_TUNER_CAP_SAP;
+		t->rangelow = 772;	/* 48.25 MHZ / 62.5 kHz = 772, see fi1216mk2-specs, page 2 */
+		t->rangehigh = 13684;	/* 855.25 MHz / 62.5 kHz = 13684 */
+		/* FIXME: add the real signal strength here */
+		t->signal = 0xffff;
+		t->afc = 0;		
+		/* fixme: real autodetection here */
+		t->rxsubchans 	= V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
+
+		return 0;
+	}
+	case VIDIOC_S_TUNER:
+	{
+		struct v4l2_tuner *t = arg;
+		
+		DEB_EE(("VIDIOC_S_TUNER: %d\n", t->index));
+
+		if( 0 == av7110->has_analog_tuner || av7110->current_input != 1 ) {
+			return -EINVAL;
+		}
+
+
+		switch(t->audmode) {
+			case V4L2_TUNER_MODE_STEREO: {
+				DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_STEREO\n"));
+				break;
+			}
+			case V4L2_TUNER_MODE_LANG1: {
+				DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG1\n"));
+				break;
+			}
+			case V4L2_TUNER_MODE_LANG2: {
+				DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG2\n"));
+				break;
+			}
+			default: { /* case V4L2_TUNER_MODE_MONO: {*/
+				DEB_D(("VIDIOC_S_TUNER: TDA9840_SET_MONO\n"));
+				break;
+			}
+		}
+
+		return 0;
+	}
+	case VIDIOC_G_FREQUENCY:
+	{
+		struct v4l2_frequency *f = arg;
+
+		DEB_EE(("VIDIOC_G_FREQ: freq:0x%08x.\n", f->frequency));
+
+		if( 0 == av7110->has_analog_tuner || av7110->current_input != 1 ) {
+			return -EINVAL;
+		}
+
+		memset(f,0,sizeof(*f));
+		f->type = V4L2_TUNER_ANALOG_TV;
+		f->frequency =  av7110->current_freq;
+
+		return 0;
+	}
+	case VIDIOC_S_FREQUENCY:
+	{
+		struct v4l2_frequency *f = arg;
+
+		DEB_EE(("VIDIOC_S_FREQUENCY: freq:0x%08x.\n",f->frequency));
+
+		if( 0 == av7110->has_analog_tuner || av7110->current_input != 1 ) {
+			return -EINVAL;
+		}
+
+		if (V4L2_TUNER_ANALOG_TV != f->type)
+			return -EINVAL;
+
+		/* tune in desired frequency */			
+		tuner_set_tv_freq(dev, f->frequency);
+		av7110->current_freq = f->frequency;
+
+		return 0;
+	}
 	case VIDIOC_ENUMINPUT:
 	{
 		struct v4l2_input *i = arg;
 		
+		DEB_EE(("VIDIOC_ENUMINPUT: %d\n", i->index));
+
+		if( 0 != av7110->has_analog_tuner ) {
+			if( i->index < 0 || i->index >= 2) {
+				return -EINVAL;
+			}
+		} else {
 		if( i->index != 0 ) {
 			return -EINVAL;
 		}
+		}		
 
-		memset(i,0,sizeof(*i));
-		i->index = 0;
-		strcpy(i->name, "DVB");
-		i->type = V4L2_INPUT_TYPE_CAMERA;
-		i->audioset = 1;
+		memcpy(i, &inputs[i->index], sizeof(struct v4l2_input));
 		
 		return 0;
 	}
 	case VIDIOC_G_INPUT:
 	{
 		int *input = (int *)arg;
-		*input = 0;
+		*input = av7110->current_input;
+		DEB_EE(("VIDIOC_G_INPUT: %d\n", *input));
 		return 0;		
 	}	
 	case VIDIOC_S_INPUT:
 	{
+		int input = *(int *)arg;
+
+		DEB_EE(("VIDIOC_S_INPUT: %d\n", input));
+
+		if( 0 == av7110->has_analog_tuner ) {
 		return 0;		
 	}	
+		
+		if( input < 0 || input >= 2) {
+			return -EINVAL;
+		}
+		
+		/* fixme: switch inputs here */
+		av7110->current_input = input;
+		return av7110_dvb_c_switch(fh);
+	}	
 	default:
+		printk("no such ioctl\n");
 		return -ENOIOCTLCMD;
 	}
 	return 0;
@@ -4006,7 +4267,6 @@
 #endif
 //        }
         
-        av7110->dvb_net.card_num=av7110->dvb_adapter->num;
         dvb_net_init(av7110->dvb_adapter, &av7110->dvb_net, &dvbdemux->dmx);
 
 	return 0;
@@ -4061,6 +4321,10 @@
 	{ VIDIOC_ENUMINPUT, 	SAA7146_EXCLUSIVE },
 	{ VIDIOC_G_INPUT,	SAA7146_EXCLUSIVE },
 	{ VIDIOC_S_INPUT,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_G_FREQUENCY,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_FREQUENCY, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_G_TUNER, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_TUNER, 	SAA7146_EXCLUSIVE },
 	{ 0, 0 }
 };
 
@@ -4114,6 +4378,8 @@
 		return -ENOMEM;
 	}
 
+	ttpci_eeprom_parse_mac(av7110->i2c_bus);
+
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 	saa7146_write(dev, BCS_CTRL, 0x80400040);
 
@@ -4186,9 +4452,9 @@
 	bootarm(av7110);
 	firmversion(av7110);
 
-	if ((av7110->arm_app&0xffff)<0x2501)
+	if (FW_VERSION(av7110->arm_app)<0x2501)
 		printk ("av7110: Warning, firmware version 0x%04x is too old. "
-			"System might be unstable!\n", av7110->arm_app&0xffff);
+			"System might be unstable!\n", FW_VERSION(av7110->arm_app));
 
 	kernel_thread(arm_thread, (void *) av7110, 0);
 
@@ -4199,6 +4465,8 @@
 	VidMode(av7110, vidmode);
 
 	/* remaining inits according to card and frontend type */
+	av7110->has_analog_tuner = 0;
+	av7110->current_input = 0;
 	if (i2c_writereg(av7110, 0x20, 0x00, 0x00)==1) {
 		printk ("av7110(%d): Crystal audio DAC detected\n",
 			av7110->dvb_adapter->num);
@@ -4225,6 +4493,31 @@
 			msp_writereg(av7110, 0x12, 0x000a, 0x0220); // SCART 1 source
 			msp_writereg(av7110, 0x12, 0x0007, 0x7f00); // SCART 1 volume
 			msp_writereg(av7110, 0x12, 0x000d, 0x4800); // prescale SCART
+		
+		if (i2c_writereg(av7110, 0x48, 0x01, 0x00)!=1) {
+			INFO(("saa7113 not accessible.\n"));
+		} else {
+			av7110->has_analog_tuner = 1;
+			/* init the saa7113 */
+			i2c_writereg(av7110, 0x48, 0x02, 0xd0); i2c_writereg(av7110, 0x48, 0x03, 0x23); i2c_writereg(av7110, 0x48, 0x04, 0x00);
+			i2c_writereg(av7110, 0x48, 0x05, 0x00); i2c_writereg(av7110, 0x48, 0x06, 0xe9); i2c_writereg(av7110, 0x48, 0x07, 0x0d);
+			i2c_writereg(av7110, 0x48, 0x08, 0x98); i2c_writereg(av7110, 0x48, 0x09, 0x02); i2c_writereg(av7110, 0x48, 0x0a, 0x80);
+			i2c_writereg(av7110, 0x48, 0x0b, 0x40); i2c_writereg(av7110, 0x48, 0x0c, 0x40); i2c_writereg(av7110, 0x48, 0x0d, 0x00);
+			i2c_writereg(av7110, 0x48, 0x0e, 0x01);	i2c_writereg(av7110, 0x48, 0x0f, 0x7c); i2c_writereg(av7110, 0x48, 0x10, 0x48);
+			i2c_writereg(av7110, 0x48, 0x11, 0x0c);	i2c_writereg(av7110, 0x48, 0x12, 0x8b);	i2c_writereg(av7110, 0x48, 0x13, 0x10);
+			i2c_writereg(av7110, 0x48, 0x14, 0x00);	i2c_writereg(av7110, 0x48, 0x15, 0x00);	i2c_writereg(av7110, 0x48, 0x16, 0x00);
+			i2c_writereg(av7110, 0x48, 0x17, 0x00);	i2c_writereg(av7110, 0x48, 0x18, 0x00);	i2c_writereg(av7110, 0x48, 0x19, 0x00);
+			i2c_writereg(av7110, 0x48, 0x1a, 0x00);	i2c_writereg(av7110, 0x48, 0x1b, 0x00);	i2c_writereg(av7110, 0x48, 0x1c, 0x00);
+			i2c_writereg(av7110, 0x48, 0x1d, 0x00);	i2c_writereg(av7110, 0x48, 0x1e, 0x00);
+		}	
+
+		memcpy(standard,dvb_standard,sizeof(struct saa7146_standard)*2);
+		/* set dd1 stream a & b */
+      		saa7146_write(dev, DD1_STREAM_B, 0x00000000);
+		saa7146_write(dev, DD1_INIT, 0x0200700);
+		saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
+
+
 	} else if (dev->pci->subsystem_vendor == 0x110a) {
 		printk("av7110(%d): DVB-C w/o analog module detected\n",
 			av7110->dvb_adapter->num);
@@ -4330,6 +4623,16 @@
 	{ "NTSC", V4L2_STD_NTSC, 0x10, 244, 480, 0x40, 708, 709, 480, 640 },
 };
 
+static struct saa7146_standard analog_standard[] = {
+	{ "PAL", V4L2_STD_PAL, 0x18, 288, 576, 0x08, 708, 709, 576, 768 },
+	{ "NTSC", V4L2_STD_NTSC, 0x10, 244, 480, 0x40, 708, 709, 480, 640 },
+};
+
+static struct saa7146_standard dvb_standard[] = {
+	{ "PAL", V4L2_STD_PAL, 0x14, 288, 576, 0x4a, 708, 709, 576, 768 },
+	{ "NTSC", V4L2_STD_NTSC, 0x10, 244, 480, 0x40, 708, 709, 480, 640 },
+};
+
 static struct saa7146_extension av7110_extension;
 
 #define MAKE_AV7110_INFO(x_var,x_name) \
@@ -4390,7 +4693,7 @@
 static struct saa7146_ext_vv av7110_vv_data = {
 	.inputs		= 1,
 	.audios 	= 1,
-	.capabilities	= 0,
+	.capabilities	= V4L2_CAP_TUNER,
 	.flags		= SAA7146_EXT_SWAP_ODD_EVEN,
 
 	.stds		= &standard[0],
@@ -4442,7 +4745,11 @@
 
 MODULE_PARM(av7110_debug,"i");
 MODULE_PARM(vidmode,"i");
+MODULE_PARM_DESC(vidmode,"analog video out: 0 off, 1 CVBS+RGB (default), 2 CVBS+YC, 3 YC");
 MODULE_PARM(pids_off,"i");
+MODULE_PARM_DESC(pids_off,"clear video/audio/PCR PID filters when demux is closed");
 MODULE_PARM(adac,"i");
+MODULE_PARM_DESC(adac,"audio DAC type: 0 TI, 1 CRYSTAL, 2 MSP (use if autodetection fails)");
 MODULE_PARM(hw_sections, "i");
+MODULE_PARM_DESC(hw_sections, "0 use software section filter, 1 use hardware");
 
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/ttpci/av7110.h linux-2.5.73.work/drivers/media/dvb/ttpci/av7110.h
--- linux-2.5.73.bk/drivers/media/dvb/ttpci/av7110.h	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/av7110.h	2003-06-17 09:29:10.000000000 +0200
@@ -153,7 +153,8 @@
 	BlitBmp,
 	ReleaseBmp,
 	SetWTrans,
-	SetWNoTrans
+        SetWNoTrans,
+        Set_Palette
 };
 
 enum av7110_pid_command { 
@@ -405,6 +406,11 @@
 	struct dvb_i2c_bus	*i2c_bus;	
 	char			*card_name;
 
+	/* support for analog module of dvb-c */
+	int			has_analog_tuner;
+	int			current_input;
+	u32			current_freq;
+				
 	struct tasklet_struct   debi_tasklet;
 	struct tasklet_struct   gpio_tasklet;
 
@@ -572,6 +578,9 @@
 #define DATA_BUFF2_BASE	(DATA_BUFF1_BASE+DATA_BUFF1_SIZE)
 #define DATA_BUFF2_SIZE	0x0800
 
+#define DATA_BUFF3_BASE (DATA_BUFF2_BASE+DATA_BUFF2_SIZE)
+#define DATA_BUFF3_SIZE 0x0400
+
 #define Reserved	(DPRAM_BASE + 0x1E00)
 #define Reserved_SIZE	0x1C0
 
diff -uNrwB --new-file linux-2.5.73.patch/drivers/media/dvb/ttpci/ttpci-eeprom.c linux-2.5.73.work/drivers/media/dvb/ttpci/ttpci-eeprom.c
--- linux-2.5.73.patch/drivers/media/dvb/ttpci/ttpci-eeprom.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/ttpci-eeprom.c	2003-06-25 10:57:21.000000000 +0200
@@ -0,0 +1,120 @@
+/*
+    Retrieve encoded MAC address from 24C16 serial 2-wire EEPROM,
+    decode it and store it in the associated adapter struct for
+    use by dvb_net.c
+
+    This code was tested on TT-Budget/WinTV-NOVA-CI PCI boards with
+    Atmel and ST Microelectronics EEPROMs.
+
+    This card appear to have the 24C16 write protect held to ground,
+    thus permitting normal read/write operation. Theoretically it
+    would be possible to write routines to burn a different (encoded)
+    MAC address into the EEPROM.
+
+    Robert Schlabbach	GMX
+    Michael Glaum	KVH Industries
+    Holger Waechtler	Convergence
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#include <asm/errno.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+#include "dvb_i2c.h"
+#include "dvb_functions.h"
+
+#if 1
+#define dprintk(x...) printk(x)
+#else
+#define dprintk(x...)
+#endif
+
+
+static int ttpci_eeprom_read_encodedMAC(struct dvb_i2c_bus *i2c, u8 * encodedMAC)
+{
+	int ret;
+	u8 b0[] = { 0xd4 };
+
+	struct i2c_msg msg[] = {
+		{.addr = 0x50,.flags = 0,.buf = b0,.len = 1},
+		{.addr = 0x50,.flags = I2C_M_RD,.buf = encodedMAC,.len = 6}
+	};
+
+	dprintk("%s\n", __FUNCTION__);
+
+	ret = i2c->xfer(i2c, msg, 2);
+
+	if (ret != 2)		/* Assume EEPROM isn't there */
+		return (-ENODEV);
+
+	return 0;
+}
+
+static void decodeMAC(u8 * decodedMAC, const u8 * encodedMAC)
+{
+	u8 ormask0[3] = { 0x54, 0x7B, 0x9E };
+	u8 ormask1[3] = { 0xD3, 0xF1, 0x23 };
+	u8 low;
+	u8 high;
+	u8 shift;
+	int i;
+
+	decodedMAC[0] = 0x00;
+	decodedMAC[1] = 0xD0;
+	decodedMAC[2] = 0x5C;
+
+	for (i = 0; i < 3; i++) {
+		low = encodedMAC[2 * i] ^ ormask0[i];
+		high = encodedMAC[2 * i + 1] ^ ormask1[i];
+		shift = (high >> 6) & 0x3;
+
+		decodedMAC[5 - i] = ((high << 8) | low) >> shift;
+	}
+
+}
+
+
+int ttpci_eeprom_parse_mac(struct dvb_i2c_bus *i2c)
+{
+	int ret;
+	u8 encodedMAC[6];
+	u8 decodedMAC[6];
+
+	ret = ttpci_eeprom_read_encodedMAC(i2c, encodedMAC);
+
+	if (ret != 0) {		/* Will only be -ENODEV */
+		dprintk("Couldn't read from EEPROM: not there?\n");
+		memset(i2c->adapter->proposed_mac, 0, 6);
+		return ret;
+	}
+
+	decodeMAC(decodedMAC, encodedMAC);
+	memcpy(i2c->adapter->proposed_mac, decodedMAC, 6);
+
+	dprintk("%s adapter %i has MAC addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
+		i2c->adapter->name, i2c->adapter->num,
+		decodedMAC[0], decodedMAC[1], decodedMAC[2],
+		decodedMAC[3], decodedMAC[4], decodedMAC[5]);
+	dprintk("encoded MAC was %02x:%02x:%02x:%02x:%02x:%02x\n",
+		encodedMAC[0], encodedMAC[1], encodedMAC[2],
+		encodedMAC[3], encodedMAC[4], encodedMAC[5]);
+	return 0;
+}
+
+EXPORT_SYMBOL(ttpci_eeprom_parse_mac);
diff -uNrwB --new-file linux-2.5.73.patch/drivers/media/dvb/ttpci/ttpci-eeprom.h linux-2.5.73.work/drivers/media/dvb/ttpci/ttpci-eeprom.h
--- linux-2.5.73.patch/drivers/media/dvb/ttpci/ttpci-eeprom.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.73.work/drivers/media/dvb/ttpci/ttpci-eeprom.h	2003-06-25 10:55:33.000000000 +0200
@@ -0,0 +1,32 @@
+/*
+    Retrieve encoded MAC address from ATMEL ttpci_eeprom serial 2-wire EEPROM,
+    decode it and store it in associated adapter net device
+
+    Robert Schlabbach	GMX
+    Michael Glaum	KVH Industries
+    Holger Waechtler	Convergence
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#ifndef __TTPCI_EEPROM_H__
+#define __TTPCI_EEPROM_H__
+
+#include "dvb_i2c.h"
+
+extern int ttpci_eeprom_parse_mac(struct dvb_i2c_bus *i2c);
+
+#endif
diff -uNrwB --new-file linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvbdev.h linux-2.5.73.work/drivers/media/dvb/dvb-core/dvbdev.h
--- linux-2.5.73.bk/drivers/media/dvb/dvb-core/dvbdev.h	2003-06-25 09:46:54.000000000 +0200
+++ linux-2.5.73.work/drivers/media/dvb/dvb-core/dvbdev.h	2003-06-25 12:24:18.000000000 +0200
@@ -48,6 +48,7 @@
 	struct list_head list_head;
 	struct list_head device_list;
 	const char *name;
+	u8 proposed_mac [6];
 };
 
 

