Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314575AbSD0DkD>; Fri, 26 Apr 2002 23:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314578AbSD0DkC>; Fri, 26 Apr 2002 23:40:02 -0400
Received: from moog.mee.tcd.ie ([134.226.86.57]:42250 "EHLO moog.mee.tcd.ie")
	by vger.kernel.org with ESMTP id <S314575AbSD0DkA>;
	Fri, 26 Apr 2002 23:40:00 -0400
From: "Ed  Clark" <eclark@ee.tcd.ie>
Reply-To: "Ed  Clark" <eclark@ee.tcd.ie>
Date: Sat, 27 Apr 102 04:40:36 +0100
To: ollie@sis.com.tw
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18 - CMI9738 codec support in ac97_codec.c 
Message-Id: <20020427044051.SM00304@moog.mee.tcd.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

this patch was originally written to fix a problem with the on-board audio subsystem of a pcchips m810lmr, which involves the SiS7018 controller and C-Media CMI9738 AC97 codec. As such, the scope of this patch is any audio subsystem using the CMI9738, and requiring the trident.o module.

The CMI9738 is budget codec which appears to only provide limited support of the usual AC97 features. For example, the CD volume control resolution is 4 bits instead of the usual 5, and there is no support for PCM volume adjustment (presumably because an equivalent function would typically be available in the AC97 controller). This patch provides a work around for these problems. Instead of simply writing the codec registers, a mechanism is provided for making callbacks to either codec or controller specific routines which make amends for codec deficiencies.  


later




--- include/linux/ac97_codec.h.orig	Thu Feb 28 11:34:34 2002
+++ include/linux/ac97_codec.h	Fri Apr 26 13:14:20 2002
@@ -180,6 +180,9 @@
                                     (FOO < SOUND_MIXER_NRDEVICES) && \
                                     (CODEC)->supported_mixers & (1<<FOO) )
 
+struct ac97_codec; /* prevent compiler warnings */
+typedef void (*write_mixer_func_t)(struct ac97_codec*, int, unsigned int, unsigned int) ;
+
 struct ac97_codec {
 	/* AC97 controller connected with */
 	void *private_data;
@@ -218,6 +221,12 @@
 
 	/* Software Modem interface */
 	int  (*modem_ioctl)(struct ac97_codec *codec, unsigned int cmd, unsigned long arg);
+
+        /* callback hooks to complement functionally limited codecs */
+        struct {
+                write_mixer_func_t *controller_write_mixer_func;
+                write_mixer_func_t *codec_alt_write_mixer_func;
+        } misc_ops;
 };
 
 /*
--- drivers/sound/ac97_codec.c.orig	Tue Mar  5 23:21:57 2002
+++ drivers/sound/ac97_codec.c	Fri Apr 26 14:29:13 2002
@@ -31,6 +31,10 @@
  **************************************************************************
  *
  * History
+ * v0.4a
+ *	Apr 24 2002 Ed Clark <eclark@ee.tcd.ie>
+ *	Added callback mechanism to complement functionally limited
+ *	AC97 codecs (ie. CMI9738)
  * v0.4 Mar 15 2000 Ollie Lho
  *	dual codecs support verified with 4 channels output
  * v0.3 Feb 22 2000 Ollie Lho
@@ -53,6 +57,8 @@
 static int ac97_read_mixer(struct ac97_codec *codec, int oss_channel);
 static void ac97_write_mixer(struct ac97_codec *codec, int oss_channel, 
 			     unsigned int left, unsigned int right);
+static void __ac97_write_mixer(struct ac97_codec *codec, int oss_channel, 
+                               unsigned int left, unsigned int right);
 static void ac97_set_mixer(struct ac97_codec *codec, unsigned int oss_mixer, unsigned int val );
 static int ac97_recmask_io(struct ac97_codec *codec, int rw, int mask);
 static int ac97_mixer_ioctl(struct ac97_codec *codec, unsigned int cmd, unsigned long arg);
@@ -65,8 +71,13 @@
 static int sigmatel_9708_init(struct ac97_codec *codec);
 static int sigmatel_9721_init(struct ac97_codec *codec);
 static int sigmatel_9744_init(struct ac97_codec *codec);
+static int cmi9738_init(struct ac97_codec * codec);
 static int eapd_control(struct ac97_codec *codec, int);
 static int crystal_digital_control(struct ac97_codec *codec, int mode);
+static void cmi9738_alt_write_mixer_pcm(struct ac97_codec *codec, int oss_channel, 
+                                        unsigned int left, unsigned int right);
+static void cmi9738_alt_write_mixer_cd(struct ac97_codec *codec, int oss_channel, 
+                                       unsigned int left, unsigned int right);
 
 
 /*
@@ -94,6 +105,7 @@
 static struct ac97_ops sigmatel_9721_ops = { sigmatel_9721_init, NULL, NULL };
 static struct ac97_ops sigmatel_9744_ops = { sigmatel_9744_init, NULL, NULL };
 static struct ac97_ops crystal_digital_ops = { NULL, eapd_control, crystal_digital_control };
+static struct ac97_ops cmi9738_ops = {cmi9738_init, NULL, NULL };
 
 /* sorted by vendor/device id */
 static const struct {
@@ -143,6 +155,7 @@
 	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
 	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},
 	{0x57454301, "Winbond 83971D",		&null_ops},
+	{0x434d4941, "CMI9738",			&cmi9738_ops},
 };
 
 static const char *ac97_stereo_enhancements[] =
@@ -322,6 +335,16 @@
 /* write the OSS encoded volume to the given OSS encoded mixer, again caller's job to
    make sure all is well in arg land, call with spinlock held */
 static void ac97_write_mixer(struct ac97_codec *codec, int oss_channel,
+                             unsigned int left, unsigned int right)
+{   
+        if ( (codec->misc_ops.codec_alt_write_mixer_func) &&
+             (codec->misc_ops.codec_alt_write_mixer_func[oss_channel]) )
+                codec->misc_ops.codec_alt_write_mixer_func[oss_channel](codec, oss_channel, left, right);
+        else 
+                __ac97_write_mixer(codec, oss_channel, left, right);
+}
+
+static void __ac97_write_mixer(struct ac97_codec *codec, int oss_channel,
 		      unsigned int left, unsigned int right)
 {
 	u16 val = 0;
@@ -744,6 +767,7 @@
 	codec->write_mixer = ac97_write_mixer;
 	codec->recmask_io = ac97_recmask_io;
 	codec->mixer_ioctl = ac97_mixer_ioctl;
+        codec->misc_ops.codec_alt_write_mixer_func = NULL;
 
 	/* codec specific initialization for 4-6 channel output or secondary codec stuff */
 	if (codec->codec_ops->init != NULL) {
@@ -909,6 +933,46 @@
 	return 0;
 }
 
+/*
+ *	C-Media CMI9738
+ */
+
+static void cmi9738_alt_write_mixer_pcm(struct ac97_codec *codec, int oss_channel,
+                                       unsigned int left, unsigned int right)
+{
+        /* when able, let AC97 controller handle PCM volume adjustment */
+        if ( (codec->misc_ops.controller_write_mixer_func) &&
+             (codec->misc_ops.controller_write_mixer_func[oss_channel]) )
+                codec->misc_ops.controller_write_mixer_func[oss_channel](codec, oss_channel, left, right);
+        /* still use codec mute control */
+        __ac97_write_mixer(codec, oss_channel, left, right);
+}
+
+static void cmi9738_alt_write_mixer_cd(struct ac97_codec *codec, int oss_channel,
+                                       unsigned int left, unsigned int right)
+{
+        /* adjust for 4 bit resolution of CD mixer */
+        left >>= 1;
+        right >>= 1;
+        __ac97_write_mixer(codec, oss_channel, left, right);
+}
+
+static write_mixer_func_t cmi9738_alt_write_mixer_func[SOUND_MIXER_NRDEVICES] = {
+        [SOUND_MIXER_PCM]	=	cmi9738_alt_write_mixer_pcm,
+        [SOUND_MIXER_CD]	=	cmi9738_alt_write_mixer_cd,
+};
+
+static int cmi9738_init(struct ac97_codec *codec)
+{
+        /* unmute cmi9738 PCM channel */ 
+        codec->codec_write(codec, AC97_PCMOUT_VOL, 0x1f1f);
+    
+        /* switch in alternative mixer controls */
+        codec->misc_ops.codec_alt_write_mixer_func = cmi9738_alt_write_mixer_func;
+
+        return 1;
+}
+
 /* copied from drivers/sound/maestro.c */
 #if 0  /* there has been 1 person on the planet with a pt101 that we
         know of.  If they care, they can put this back in :) */
--- drivers/sound/trident.c.orig	Sat Apr 20 06:27:53 2002
+++ drivers/sound/trident.c	Fri Apr 26 14:19:05 2002
@@ -36,6 +36,10 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.9e
+ *	April 24 2002 Ed Clark <eclark@ee.tcd.ie>
+ *	Added controller callback mechanism to complement functionally
+ *	limited AC97 codecs. Included callback for PCM volume adjustment.
  *  v0.14.9d
  *  	October 8 2001 Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  *	use set_current_state, properly release resources on failure in
@@ -413,6 +417,8 @@
 static int trident_open_mixdev(struct inode *inode, struct file *file);
 static int trident_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
 				unsigned long arg);
+static void trident_write_mixer_pcm(struct ac97_codec *codec, int oss_channel,
+                                    unsigned int left, unsigned int right);
 
 static void ali_ac97_set(struct trident_card *card, int secondary, u8 reg, u16 val);
 static u16 ali_ac97_get(struct trident_card *card, int secondary, u8 reg);
@@ -3785,6 +3791,34 @@
 	open:		trident_open_mixdev,
 };
 
+/* PCM volume adjustment (for AC97 codecs lacking this ability) */
+static void trident_write_mixer_pcm(struct ac97_codec *codec, int oss_channel,
+                                    unsigned int left, unsigned int right)
+{
+        struct trident_card *card = (struct trident_card *)codec->private_data;
+        unsigned int val;
+    
+        right = ((100 - right) * 32) / 100;
+        left = ((100 - left) * 32) / 100;
+        if (right >= 32)
+                right = 31;
+        if (left >= 32)
+                left = 31;
+        /* attenuation scaling,
+           AC97 codec : 1.5dB/step
+           controller : 0.5dB/step
+        */
+        right *= 3;
+        left *= 3;        
+        val = (right << 8) | left;
+        val = (val << 16) | val;
+        outl(val,TRID_REG(card, T4D_MUSICVOL_WAVEVOL));
+}
+
+static write_mixer_func_t controller_write_mixer_func[SOUND_MIXER_NRDEVICES] = {
+        [SOUND_MIXER_PCM] = trident_write_mixer_pcm,
+};
+
 static int ali_reset_5451(struct trident_card *card)
 {
 	struct pci_dev *pci_dev = NULL;
@@ -3910,6 +3944,9 @@
 			codec->codec_write = trident_ac97_set;
 		}
 	
+                /* set AC97 controller callbacks */
+                codec->misc_ops.controller_write_mixer_func = controller_write_mixer_func;
+                
 		if (ac97_probe_codec(codec) == 0)
 			break;
 


