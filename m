Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTJHNbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbTJHNbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:31:40 -0400
Received: from mail.convergence.de ([212.84.236.4]:9441 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261563AbTJHN3B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:29:01 -0400
Subject: [PATCH 12/14] some more av7110 dvb-driver updates
In-Reply-To: <1065619739657@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:59 +0200
Message-Id: <1065619739957@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] some progress on DVB-C analog module: experimentally fix frequency offset, initialize msp3400 for analog TV sound
- [DVB] Reduce the number of dropped TS packets when an error is detected (Jon Burgess)
- [DVB] If somebody calls G_TUNER for a DVB-C card w/ analog module, then check for the selected tuner, not if the currently selected channel has a tuner.
- [DVB] play_iframe may be used to play stillpicture frames, that can either by complete i-frames or partial p-frames. In any case, the av7110 needs about 400kB of video data, before the internal video decoder starts displaying anything. for stillframes, this is bad, so we  *always* loop writing the frame until the magic amount is reached. stupid, but works...
- [DVB] applied 64bit fixes by Pedro Miguel Teixeira <pmsjt@warner.homeip.net
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/dvb-core/dvb_demux.c linux-2.6.0-test6-cvs/drivers/media/dvb/dvb-core/dvb_demux.c
--- linux-2.6.0-test6/drivers/media/dvb/dvb-core/dvb_demux.c	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/dvb-core/dvb_demux.c	2003-09-23 11:59:02.000000000 +0200
@@ -391,7 +393,9 @@
 	spin_lock(&demux->lock);
 
 	while (count--) {
+               	if(buf[0] == 0x47) {
 		dvb_dmx_swfilter_packet(demux, buf);
+		}
 		buf += 188;
 	}
 
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/ttpci/av7110.h linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/av7110.h
--- linux-2.6.0-test6/drivers/media/dvb/ttpci/av7110.h	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/av7110.h	2003-09-29 16:04:08.000000000 +0200
@@ -399,14 +399,14 @@
 
         struct dvb_device       dvb_dev;
         struct dvb_net               dvb_net;
-	struct video_device	vd;
+	struct video_device	v4l_dev;
 
         struct saa7146_dev	*dev;
 
 	struct dvb_i2c_bus	*i2c_bus;	
 	char			*card_name;
 
-	/* support for analog module of dvb-c */
+	/* support for analog module of dvb-c */
 	int			has_analog_tuner;
 	int			current_input;
 	u32			current_freq;
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/ttpci/budget-core.c linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/budget-core.c
--- linux-2.6.0-test6/drivers/media/dvb/ttpci/budget-core.c	2003-10-01 12:25:32.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/budget-core.c	2003-09-23 11:59:37.000000000 +0200
@@ -80,14 +80,11 @@
 		return;
 
         if (newdma > olddma) { /* no wraparound, dump olddma..newdma */
-               	if(mem[olddma] == 0x47)
                         dvb_dmx_swfilter_packets(&budget->demux, 
         	                mem+olddma, (newdma-olddma) / 188);
         } else { /* wraparound, dump olddma..buflen and 0..newdma */
-                if(mem[olddma] == 0x47)
 	                dvb_dmx_swfilter_packets(&budget->demux,
         	                mem+olddma, (TS_BUFLEN-olddma) / 188);
-                if(mem[0] == 0x47)
                         dvb_dmx_swfilter_packets(&budget->demux,
                                 mem, newdma / 188);
         }
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/ttpci/av7110.c linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/av7110.c
--- linux-2.6.0-test6/drivers/media/dvb/ttpci/av7110.c	2003-10-01 12:25:33.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/av7110.c	2003-10-01 12:27:23.000000000 +0200
@@ -609,7 +611,7 @@
                      enum dmx_success success,
                      struct av7110 *av7110)
 {
-	DEB_EE(("av7110: %p\n",av7110));
+	DEB_INT(("av7110: %p\n",av7110));
 
         if (!dvbdmxfilter->feed->demux->dmx.frontend)
                 return 0;
@@ -1324,17 +1326,43 @@
  * Firmware commands 
  ****************************************************************************/
 
+/* msp3400 i2c subaddresses */
+#define MSP_WR_DEM 0x10
+#define MSP_RD_DEM 0x11
+#define MSP_WR_DSP 0x12
+#define MSP_RD_DSP 0x13
+
 static inline int msp_writereg(struct av7110 *av7110, u8 dev, u16 reg, u16 val)
 {
         u8 msg[5]={ dev, reg>>8, reg&0xff, val>>8 , val&0xff }; 
         struct dvb_i2c_bus *i2c = av7110->i2c_bus;
-        struct i2c_msg msgs;
+        struct i2c_msg msgs = { .flags = 0, .addr = 0x40, .len = 5, .buf = msg};
 
-        msgs.flags=0;
-        msgs.addr=0x40;
-        msgs.len=5;
-        msgs.buf=msg;
-        return i2c->xfer(i2c, &msgs, 1);
+        if (i2c->xfer(i2c, &msgs, 1) != 1) {
+		printk("av7110(%d): %s(%u = %u) failed\n",
+				av7110->dvb_adapter->num, __FUNCTION__, reg, val);
+		return -EIO;
+	}
+	return 0;
+}
+
+static inline int msp_readreg(struct av7110 *av7110, u8 dev, u16 reg, u16 *val)
+{
+        u8 msg1[3]={ dev, reg>>8, reg&0xff };
+        u8 msg2[2];
+        struct dvb_i2c_bus *i2c = av7110->i2c_bus;
+        struct i2c_msg msgs[2] = {
+		{ .flags = 0,        .addr = 0x40, .len = 3, .buf = msg1},
+		{ .flags = I2C_M_RD, .addr = 0x40, .len = 2, .buf = msg2}
+	};
+
+        if (i2c->xfer(i2c, msgs, 2) != 2) {
+		printk("av7110(%d): %s(%u) failed\n",
+				av7110->dvb_adapter->num, __FUNCTION__, reg);
+		return -EIO;
+	}
+	*val = (msg2[0] << 8) | msg2[1];
+	return 0;
 }
 
 static inline int SendDAC(struct av7110 *av7110, u8 addr, u8 data)
@@ -1375,9 +1403,9 @@
 		if (vol > 0) {
 		       balance = ((volright-volleft) * 127) / vol;
 		}
-		msp_writereg(av7110, 0x12, 0x0001, balance << 8);
-		msp_writereg(av7110, 0x12, 0x0000, val); /* loudspeaker */
-		msp_writereg(av7110, 0x12, 0x0006, val); /* headphonesr */
+		msp_writereg(av7110, MSP_WR_DSP, 0x0001, balance << 8);
+		msp_writereg(av7110, MSP_WR_DSP, 0x0000, val); /* loudspeaker */
+		msp_writereg(av7110, MSP_WR_DSP, 0x0006, val); /* headphonesr */
 		return 0;
         }
         return 0;
@@ -2623,7 +2651,7 @@
 		.status		= 0,
 	}, { 
 		.index 		= 1,
-		.name 		= "ANALOG",
+		.name 		= "Television",
 		.type		= V4L2_INPUT_TYPE_TUNER,
 		.audioset 	= 2,
 		.tuner		= 0,
@@ -2672,9 +2700,9 @@
 
  	DEB_EE(("av7710: freq: 0x%08x\n",freq));
 
-	/* magic number: 56. tuning with the frequency given by v4l2
-	   is always off by 56*62.5 kHz...*/
-	div = freq + 56;
+	/* magic number: 614. tuning with the frequency given by v4l2
+	   is always off by 614*62.5 = 38375 kHz...*/
+	div = freq + 614;
 
 	buf[0] = (div >> 8) & 0x7f;
 	buf[1] = div & 0xff;
@@ -2697,13 +2725,18 @@
 static struct saa7146_standard dvb_standard[];
 static struct saa7146_standard standard[];
 
+static struct v4l2_audio msp3400_v4l2_audio = {
+	.index = 0,
+	.name = "Television",
+	.capability = V4L2_AUDCAP_STEREO
+};
+
 int av7110_dvb_c_switch(struct saa7146_fh *fh)
 {
 	struct saa7146_dev *dev = fh->dev;
 	struct saa7146_vv *vv = dev->vv_data;
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
-	u16 buf[3] = { ((COMTYPE_AUDIODAC << 8) + ADSwitch), 1, 1 };
-
+	u16 adswitch;
 	u8 band = 0;
 	int source, sync;
 	struct saa7146_fh *ov_fh = NULL;
@@ -2718,23 +2751,36 @@
 	}
 
 	if( 0 != av7110->current_input ) {
-		buf[2] = 0;
+		adswitch = 1;
 		band = 0x68; /* analog band */
 		source = SAA7146_HPS_SOURCE_PORT_B;
 		sync = SAA7146_HPS_SYNC_PORT_B;
 		memcpy(standard,analog_standard,sizeof(struct saa7146_standard)*2);
+		printk("av7110: switching to analog TV\n");
+		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0000); // loudspeaker source
+		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0000); // headphone source
+		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0000); // SCART 1 source
+		msp_writereg(av7110, MSP_WR_DSP, 0x000e, 0x3000); // FM matrix, mono
+		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x4f00); // loudspeaker + headphone
+		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x4f00); // SCART 1 volume
 	} else {
-		buf[2] = 1;
+		adswitch = 0;
 		band = 0x28; /* digital band */	
 		source = SAA7146_HPS_SOURCE_PORT_A;
 		sync = SAA7146_HPS_SYNC_PORT_A;
 		memcpy(standard,dvb_standard,sizeof(struct saa7146_standard)*2);
+		printk("av7110: switching DVB mode\n");
+		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
+		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0220); // headphone source
+		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0220); // SCART 1 source
+		msp_writereg(av7110, MSP_WR_DSP, 0x000e, 0x3000); // FM matrix, mono
+		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x7f00); // loudspeaker + headphone
+		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x7f00); // SCART 1 volume
 	}
 
 	/* hmm, this does not do anything!? */
-	if (OutCommand(av7110, buf, 3)) {
+	if (outcom(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, adswitch))
 		printk("ADSwitch error\n");
-	}
 
 	if( 0 != ves1820_writereg(dev, 0x0f, band )) {
 		printk("setting band in demodulator failed.\n");
@@ -2759,6 +2805,8 @@
 	case VIDIOC_G_TUNER:
 	{
 		struct v4l2_tuner *t = arg;
+		u16 stereo_det;
+		s8 stereo;
 
 		DEB_EE(("VIDIOC_G_TUNER: %d\n", t->index));
 
@@ -2770,21 +2818,39 @@
 		strcpy(t->name, "Television");
 
 		t->type = V4L2_TUNER_ANALOG_TV;
-		t->capability = V4L2_TUNER_CAP_NORM | V4L2_TUNER_CAP_STEREO | V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2 | V4L2_TUNER_CAP_SAP;
+		t->capability = V4L2_TUNER_CAP_NORM | V4L2_TUNER_CAP_STEREO |
+			V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2 | V4L2_TUNER_CAP_SAP;
 		t->rangelow = 772;	/* 48.25 MHZ / 62.5 kHz = 772, see fi1216mk2-specs, page 2 */
 		t->rangehigh = 13684;	/* 855.25 MHz / 62.5 kHz = 13684 */
 		/* FIXME: add the real signal strength here */
 		t->signal = 0xffff;
 		t->afc = 0;		
-		/* fixme: real autodetection here */
+
+msp_readreg(av7110, MSP_RD_DEM, 0x007e, &stereo_det);
+printk("VIDIOC_G_TUNER: msp3400 TV standard detection: 0x%04x\n", stereo_det);
+
+		msp_readreg(av7110, MSP_RD_DSP, 0x0018, &stereo_det);
+		printk("VIDIOC_G_TUNER: msp3400 stereo detection: 0x%04x\n", stereo_det);
+		stereo = (s8)(stereo_det >> 8);
+		if (stereo > 0x10) {
+			/* stereo */
 		t->rxsubchans 	= V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
+			t->audmode = V4L2_TUNER_MODE_STEREO;
+		}
+		else if (stereo < -0x10) {
+			/* bilingual*/
+			t->rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
+			 t->audmode = V4L2_TUNER_MODE_LANG1;
+		}
+		else /* mono */
+			t->rxsubchans = V4L2_TUNER_SUB_MONO;
 
 		return 0;
 	}
 	case VIDIOC_S_TUNER:
 	{
 		struct v4l2_tuner *t = arg;
-		
+		u16 fm_matrix, src;
 		DEB_EE(("VIDIOC_S_TUNER: %d\n", t->index));
 
 		if( 0 == av7110->has_analog_tuner || av7110->current_input != 1 ) {
@@ -2793,23 +2859,31 @@
 
 
 		switch(t->audmode) {
-			case V4L2_TUNER_MODE_STEREO: {
+		case V4L2_TUNER_MODE_STEREO:
 				DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_STEREO\n"));
+			fm_matrix = 0x3001; // stereo
+			src = 0x0020;
 				break;
-			}
-			case V4L2_TUNER_MODE_LANG1: {
+		case V4L2_TUNER_MODE_LANG1:
 				DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG1\n"));
+			fm_matrix = 0x3000; // mono
+			src = 0x0000;
 				break;
-			}
-			case V4L2_TUNER_MODE_LANG2: {
+		case V4L2_TUNER_MODE_LANG2:
 				DEB_D(("VIDIOC_S_TUNER: V4L2_TUNER_MODE_LANG2\n"));
+			fm_matrix = 0x3000; // mono
+			src = 0x0010;
 				break;
-			}
-			default: { /* case V4L2_TUNER_MODE_MONO: {*/
+		default: /* case V4L2_TUNER_MODE_MONO: {*/
 				DEB_D(("VIDIOC_S_TUNER: TDA9840_SET_MONO\n"));
+			fm_matrix = 0x3000; // mono
+			src = 0x0030;
 				break;
 			}
-		}
+		msp_writereg(av7110, MSP_WR_DSP, 0x000e, fm_matrix);
+		msp_writereg(av7110, MSP_WR_DSP, 0x0008, src);
+		msp_writereg(av7110, MSP_WR_DSP, 0x0009, src);
+		msp_writereg(av7110, MSP_WR_DSP, 0x000a, src);
 
 		return 0;
 	}
@@ -2842,10 +2916,18 @@
 		if (V4L2_TUNER_ANALOG_TV != f->type)
 			return -EINVAL;
 
+		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0xffe0); // fast mute
+		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0xffe0);
+
 		/* tune in desired frequency */			
 		tuner_set_tv_freq(dev, f->frequency);
 		av7110->current_freq = f->frequency;
 
+		msp_writereg(av7110, MSP_WR_DSP, 0x0015, 0x003f); // start stereo detection
+		msp_writereg(av7110, MSP_WR_DSP, 0x0015, 0x0000);
+		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x4f00); // loudspeaker + headphone
+		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x4f00); // SCART 1 volume
+
 		return 0;
 	}
 	case VIDIOC_ENUMINPUT:
@@ -2893,6 +2975,22 @@
 		av7110->current_input = input;
 		return av7110_dvb_c_switch(fh);
 	}	
+	case VIDIOC_G_AUDIO:
+	{
+		struct v4l2_audio *a = arg;
+
+		DEB_EE(("VIDIOC_G_AUDIO: %d\n", a->index));
+		if (a->index != 0)
+			return -EINVAL;
+		memcpy(a, &msp3400_v4l2_audio, sizeof(struct v4l2_audio));
+		break;
+	}
+	case VIDIOC_S_AUDIO:
+	{
+		struct v4l2_audio *a = arg;
+		DEB_EE(("VIDIOC_S_AUDIO: %d\n", a->index));
+		break;
+	}
 	default:
 		printk("no such ioctl\n");
 		return -ENOIOCTLCMD;
@@ -4366,9 +4464,46 @@
 	{ VIDIOC_S_FREQUENCY, 	SAA7146_EXCLUSIVE },
 	{ VIDIOC_G_TUNER, 	SAA7146_EXCLUSIVE },
 	{ VIDIOC_S_TUNER, 	SAA7146_EXCLUSIVE },
+	{ VIDIOC_G_AUDIO,	SAA7146_EXCLUSIVE },
+	{ VIDIOC_S_AUDIO,	SAA7146_EXCLUSIVE },
 	{ 0, 0 }
 };
 
+static u8 saa7113_init_regs[] = {
+	0x02, 0xd0,
+	0x03, 0x23,
+	0x04, 0x00,
+	0x05, 0x00,
+	0x06, 0xe9,
+	0x07, 0x0d,
+	0x08, 0x98,
+	0x09, 0x02,
+	0x0a, 0x80,
+	0x0b, 0x40,
+	0x0c, 0x40,
+	0x0d, 0x00,
+	0x0e, 0x01,
+	0x0f, 0x7c,
+	0x10, 0x48,
+	0x11, 0x0c,
+	0x12, 0x8b,
+	0x13, 0x1a,
+	0x14, 0x00,
+	0x15, 0x00,
+	0x16, 0x00,
+	0x17, 0x00,
+	0x18, 0x00,
+	0x19, 0x00,
+	0x1a, 0x00,
+	0x1b, 0x00,
+	0x1c, 0x00,
+	0x1d, 0x00,
+	0x1e, 0x00,
+
+	0xff
+};
+
+
 static struct saa7146_ext_vv av7110_vv_data_st;
 static struct saa7146_ext_vv av7110_vv_data_c;
 
@@ -4404,7 +4539,7 @@
 		return -1;
 	}
 
-	if (saa7146_register_device(&av7110->vd, dev, "av7110", VFL_TYPE_GRABBER)) {
+	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_GRABBER)) {
 		ERR(("cannot register capture device. skipping.\n"));
 		saa7146_vv_release(dev);
 		kfree(av7110);
@@ -4424,7 +4559,7 @@
 						av7110->dvb_adapter, 0);
 
 	if (!av7110->i2c_bus) {
-		saa7146_unregister_device(&av7110->vd, dev);
+		saa7146_unregister_device(&av7110->v4l_dev, dev);
 		saa7146_vv_release(dev);
 		dvb_unregister_adapter (av7110->dvb_adapter);
 		kfree(av7110);
@@ -4532,36 +4667,65 @@
 	/**
 	 * some special handling for the Siemens DVB-C cards...
 	 */
-	} else if (i2c_writereg(av7110, 0x80, 0x0, 0x80)==1) {
-			i2c_writereg(av7110, 0x80, 0x0, 0);
+	} else if (i2c_writereg(av7110, 0x80, 0x0, 0x80) == 1
+			&& i2c_writereg(av7110, 0x80, 0x0, 0) == 1) {
+		u16 version1, version2;
 		printk ("av7110(%d): DVB-C analog module detected, "
 			"initializing MSP3400\n",
 			av7110->dvb_adapter->num);
 		av7110->adac_type = DVB_ADAC_MSP;
-		dvb_delay(100);
-			msp_writereg(av7110, 0x12, 0x0013, 0x0c00);
-			msp_writereg(av7110, 0x12, 0x0000, 0x7f00); // loudspeaker + headphone
-			msp_writereg(av7110, 0x12, 0x0008, 0x0220); // loudspeaker source
-			msp_writereg(av7110, 0x12, 0x0004, 0x7f00); // loudspeaker volume
-			msp_writereg(av7110, 0x12, 0x000a, 0x0220); // SCART 1 source
-			msp_writereg(av7110, 0x12, 0x0007, 0x7f00); // SCART 1 volume
-			msp_writereg(av7110, 0x12, 0x000d, 0x4800); // prescale SCART
+		dvb_delay(100); // the probing above resets the msp...
+		msp_readreg(av7110, MSP_RD_DSP, 0x001e, &version1);
+		msp_readreg(av7110, MSP_RD_DSP, 0x001f, &version2);
+		printk("av7110(%d): MSP3400 version 0x%04x 0x%04x\n",
+			av7110->dvb_adapter->num, version1, version2);
+		msp_writereg(av7110, MSP_WR_DSP, 0x0013, 0x0c00);
+		msp_writereg(av7110, MSP_WR_DSP, 0x0000, 0x7f00); // loudspeaker + headphone
+		msp_writereg(av7110, MSP_WR_DSP, 0x0008, 0x0220); // loudspeaker source
+		msp_writereg(av7110, MSP_WR_DSP, 0x0009, 0x0220); // headphone source
+		msp_writereg(av7110, MSP_WR_DSP, 0x0004, 0x7f00); // loudspeaker volume
+		msp_writereg(av7110, MSP_WR_DSP, 0x000a, 0x0220); // SCART 1 source
+		msp_writereg(av7110, MSP_WR_DSP, 0x0007, 0x7f00); // SCART 1 volume
+		msp_writereg(av7110, MSP_WR_DSP, 0x000d, 0x4800); // prescale SCART
 		
 		if (i2c_writereg(av7110, 0x48, 0x01, 0x00)!=1) {
 			INFO(("saa7113 not accessible.\n"));
-		} else {
+		}
+		else {
+			u8 *i = saa7113_init_regs;
 			av7110->has_analog_tuner = 1;
 			/* init the saa7113 */
-			i2c_writereg(av7110, 0x48, 0x02, 0xd0); i2c_writereg(av7110, 0x48, 0x03, 0x23); i2c_writereg(av7110, 0x48, 0x04, 0x00);
-			i2c_writereg(av7110, 0x48, 0x05, 0x00); i2c_writereg(av7110, 0x48, 0x06, 0xe9); i2c_writereg(av7110, 0x48, 0x07, 0x0d);
-			i2c_writereg(av7110, 0x48, 0x08, 0x98); i2c_writereg(av7110, 0x48, 0x09, 0x02); i2c_writereg(av7110, 0x48, 0x0a, 0x80);
-			i2c_writereg(av7110, 0x48, 0x0b, 0x40); i2c_writereg(av7110, 0x48, 0x0c, 0x40); i2c_writereg(av7110, 0x48, 0x0d, 0x00);
-			i2c_writereg(av7110, 0x48, 0x0e, 0x01);	i2c_writereg(av7110, 0x48, 0x0f, 0x7c); i2c_writereg(av7110, 0x48, 0x10, 0x48);
-			i2c_writereg(av7110, 0x48, 0x11, 0x0c);	i2c_writereg(av7110, 0x48, 0x12, 0x8b);	i2c_writereg(av7110, 0x48, 0x13, 0x10);
-			i2c_writereg(av7110, 0x48, 0x14, 0x00);	i2c_writereg(av7110, 0x48, 0x15, 0x00);	i2c_writereg(av7110, 0x48, 0x16, 0x00);
-			i2c_writereg(av7110, 0x48, 0x17, 0x00);	i2c_writereg(av7110, 0x48, 0x18, 0x00);	i2c_writereg(av7110, 0x48, 0x19, 0x00);
-			i2c_writereg(av7110, 0x48, 0x1a, 0x00);	i2c_writereg(av7110, 0x48, 0x1b, 0x00);	i2c_writereg(av7110, 0x48, 0x1c, 0x00);
-			i2c_writereg(av7110, 0x48, 0x1d, 0x00);	i2c_writereg(av7110, 0x48, 0x1e, 0x00);
+			while (*i != 0xff) {
+				if (i2c_writereg(av7110, 0x48, i[0], i[1]) != 1) {
+					printk("av7110(%d): saa7113 initialization failed",
+							av7110->dvb_adapter->num);
+					break;
+				}
+				i += 2;
+			}
+			/* setup msp for analog sound: B/G Dual-FM */
+			msp_writereg(av7110, MSP_WR_DEM, 0x00bb, 0x02d0); // AD_CV
+			msp_writereg(av7110, MSP_WR_DEM, 0x0001,  3); // FIR1
+			msp_writereg(av7110, MSP_WR_DEM, 0x0001, 18); // FIR1
+			msp_writereg(av7110, MSP_WR_DEM, 0x0001, 27); // FIR1
+			msp_writereg(av7110, MSP_WR_DEM, 0x0001, 48); // FIR1
+			msp_writereg(av7110, MSP_WR_DEM, 0x0001, 66); // FIR1
+			msp_writereg(av7110, MSP_WR_DEM, 0x0001, 72); // FIR1
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005,  4); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005, 64); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005,  0); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005,  3); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005, 18); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005, 27); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005, 48); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005, 66); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0005, 72); // FIR2
+			msp_writereg(av7110, MSP_WR_DEM, 0x0083, 0xa000); // MODE_REG
+			msp_writereg(av7110, MSP_WR_DEM, 0x0093, 0x00aa); // DCO1_LO 5.74MHz
+			msp_writereg(av7110, MSP_WR_DEM, 0x009b, 0x04fc); // DCO1_HI
+			msp_writereg(av7110, MSP_WR_DEM, 0x00a3, 0x038e); // DCO2_LO 5.5MHz
+			msp_writereg(av7110, MSP_WR_DEM, 0x00ab, 0x04c6); // DCO2_HI
+			msp_writereg(av7110, MSP_WR_DEM, 0x0056, 0); // LOAD_REG 1/2
 		}	
 
 		memcpy(standard,dvb_standard,sizeof(struct saa7146_standard)*2);
@@ -4569,13 +4733,13 @@
       		saa7146_write(dev, DD1_STREAM_B, 0x00000000);
 		saa7146_write(dev, DD1_INIT, 0x0200700);
 		saa7146_write(dev, MC2, (MASK_09 | MASK_25 | MASK_10 | MASK_26));
-
-
-	} else if (dev->pci->subsystem_vendor == 0x110a) {
+	}
+	else if (dev->pci->subsystem_vendor == 0x110a) {
 		printk("av7110(%d): DVB-C w/o analog module detected\n",
 			av7110->dvb_adapter->num);
 		av7110->adac_type = DVB_ADAC_NONE;
-	} else {
+	}
+	else {
 		av7110->adac_type = adac;
 		printk("av7110(%d): adac type set to %d\n",
 			av7110->dvb_adapter->num, av7110->adac_type);
@@ -4603,7 +4767,7 @@
 		kfree(av7110);
 
 	/* FIXME: error handling is pretty bogus: memory does not get freed...*/
-	saa7146_unregister_device(&av7110->vd, dev);
+	saa7146_unregister_device(&av7110->v4l_dev, dev);
 	saa7146_vv_release(dev);
 
 	dvb_unregister_i2c_bus (master_xfer,av7110->i2c_bus->adapter,
@@ -4619,7 +4783,7 @@
 	struct av7110 *av7110 = (struct av7110*)saa->ext_priv;
 	DEB_EE(("av7110: %p\n",av7110));
 
-	saa7146_unregister_device(&av7110->vd, saa);
+	saa7146_unregister_device(&av7110->v4l_dev, saa);
 
 	av7110->arm_rmmod=1;
 	wake_up_interruptible(&av7110->arm_wait);
@@ -4658,7 +4822,7 @@
 {
 	struct av7110 *av7110 = (struct av7110*)dev->ext_priv;
 
-	DEB_EE(("dev: %p, av7110: %p\n",dev,av7110));
+	DEB_INT(("dev: %p, av7110: %p\n",dev,av7110));
 
 	if (*isr & MASK_19)
 		tasklet_schedule (&av7110->debi_tasklet);

