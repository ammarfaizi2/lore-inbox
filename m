Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTGKSL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTGKSLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:11:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6788
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264551AbTGKRzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:55:50 -0400
Date: Fri, 11 Jul 2003 19:09:35 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111809.h6BI9Zd5017272@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: AC97 updates from 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This deals with several things
- Codecs that think they are modems but are not
- Abstracting modem detection out of drivers
- Abstracting digital switching out of drivers
- Codecs that have no volume control
- Codec plugins for specific setups
- Codec plugins for things like touchscreen/batmon on AC97
- More codec handlers

The plugin API is intentionally modelled on the other driver_register
type interfaces.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/include/linux/ac97_codec.h linux-2.5.75-ac1/include/linux/ac97_codec.h
--- linux-2.5.75/include/linux/ac97_codec.h	2003-07-10 21:04:47.000000000 +0100
+++ linux-2.5.75-ac1/include/linux/ac97_codec.h	2003-07-11 17:17:37.000000000 +0100
@@ -214,6 +214,9 @@
                                     (CODEC)->supported_mixers & (1<<FOO) )
 
 struct ac97_codec {
+	/* Linked list of codecs */
+	struct list_head list;
+
 	/* AC97 controller connected with */
 	void *private_data;
 
@@ -221,22 +224,37 @@
 	int id;
 	int dev_mixer; 
 	int type;
+	u32 model;
+
+	int modem:1;
 
 	struct ac97_ops *codec_ops;
 
-	/* controller specific lower leverl ac97 accessing routines */
+	/* controller specific lower leverl ac97 accessing routines.
+	   must be re-entrant safe */
 	u16  (*codec_read)  (struct ac97_codec *codec, u8 reg);
 	void (*codec_write) (struct ac97_codec *codec, u8 reg, u16 val);
 
 	/* Wait for codec-ready.  Ok to sleep here.  */
 	void  (*codec_wait)  (struct ac97_codec *codec);
 
+	/* callback used by helper drivers for interesting ac97 setups */
+	void  (*codec_unregister) (struct ac97_codec *codec);
+	
+	struct ac97_driver *driver;
+	void *driver_private;	/* Private data for the driver */
+	
+	spinlock_t lock;
+	
 	/* OSS mixer masks */
 	int modcnt;
 	int supported_mixers;
 	int stereo_mixers;
 	int record_sources;
 
+	/* Property flags */
+	int flags;
+
 	int bit_resolution;
 
 	/* OSS mixer interface */
@@ -264,7 +282,14 @@
 	/* Amplifier control */
 	int (*amplifier)(struct ac97_codec *codec, int on);
 	/* Digital mode control */
-	int (*digital)(struct ac97_codec *codec, int format);
+	int (*digital)(struct ac97_codec *codec, int slots, int rate, int mode);
+#define AUDIO_DIGITAL		0x8000
+#define AUDIO_PRO		0x4000
+#define AUDIO_DRS		0x2000
+#define AUDIO_CCMASK		0x003F
+	
+#define AC97_DELUDED_MODEM	1	/* Audio codec reports its a modem */
+#define AC97_NO_PCM_VOLUME	2	/* Volume control is missing 	   */
 };
 
 extern int ac97_read_proc (char *page_out, char **start, off_t off,
@@ -275,4 +300,19 @@
 extern int ac97_save_state(struct ac97_codec *codec);
 extern int ac97_restore_state(struct ac97_codec *codec);
 
+extern struct ac97_codec *ac97_alloc_codec(void);
+extern void ac97_release_codec(struct ac97_codec *codec);
+
+struct ac97_driver {
+	struct list_head list;
+	char *name;
+	u32 codec_id;
+	u32 codec_mask;
+	int (*probe) (struct ac97_codec *codec, struct ac97_driver *driver);
+	void (*remove) (struct ac97_codec *codec, struct ac97_driver *driver);
+};
+
+extern int ac97_register_driver(struct ac97_driver *driver);
+extern void ac97_unregister_driver(struct ac97_driver *driver);
+
 #endif /* _AC97_CODEC_H_ */
Binary files linux-2.5.75/lib/gen_crc32table and linux-2.5.75-ac1/lib/gen_crc32table differ
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/ac97_codec.c linux-2.5.75-ac1/sound/oss/ac97_codec.c
--- linux-2.5.75/sound/oss/ac97_codec.c	2003-07-10 21:05:27.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/ac97_codec.c	2003-07-11 16:28:47.000000000 +0100
@@ -1,4 +1,3 @@
-
 /*
  * ac97_codec.c: Generic AC97 mixer/modem module
  *
@@ -31,6 +30,10 @@
  **************************************************************************
  *
  * History
+ * May 02, 2003 Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *	Removed non existant WM9700
+ *	Added support for WM9705, WM9708, WM9709, WM9710, WM9711
+ *	WM9712 and WM9717
  * Mar 28, 2002 Randolph Bentson <bentson@holmsjoen.com>
  *	corrections to support WM9707 in ViewPad 1000
  * v0.4 Mar 15 2000 Ollie Lho
@@ -43,7 +46,9 @@
  *	Isolated from trident.c to support multiple ac97 codec
  */
 #include <linux/module.h>
+#include <linux/version.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/bitops.h>
@@ -62,9 +67,10 @@
 
 static int ac97_init_mixer(struct ac97_codec *codec);
 
-static int wolfson_init00(struct ac97_codec * codec);
 static int wolfson_init03(struct ac97_codec * codec);
 static int wolfson_init04(struct ac97_codec * codec);
+static int wolfson_init05(struct ac97_codec * codec);
+static int wolfson_init11(struct ac97_codec * codec);
 static int tritech_init(struct ac97_codec * codec);
 static int tritech_maestro_init(struct ac97_codec * codec);
 static int sigmatel_9708_init(struct ac97_codec *codec);
@@ -72,7 +78,10 @@
 static int sigmatel_9744_init(struct ac97_codec *codec);
 static int ad1886_init(struct ac97_codec *codec);
 static int eapd_control(struct ac97_codec *codec, int);
-static int crystal_digital_control(struct ac97_codec *codec, int mode);
+static int crystal_digital_control(struct ac97_codec *codec, int slots, int rate, int mode);
+static int cmedia_init(struct ac97_codec * codec);
+static int cmedia_digital_control(struct ac97_codec *codec, int slots, int rate, int mode);
+static int generic_digital_control(struct ac97_codec *codec, int slots, int rate, int mode);
 
 
 /*
@@ -93,9 +102,11 @@
  
 static struct ac97_ops null_ops = { NULL, NULL, NULL };
 static struct ac97_ops default_ops = { NULL, eapd_control, NULL };
-static struct ac97_ops wolfson_ops00 = { wolfson_init00, NULL, NULL };
+static struct ac97_ops default_digital_ops = { NULL, eapd_control, generic_digital_control};
 static struct ac97_ops wolfson_ops03 = { wolfson_init03, NULL, NULL };
 static struct ac97_ops wolfson_ops04 = { wolfson_init04, NULL, NULL };
+static struct ac97_ops wolfson_ops05 = { wolfson_init05, NULL, NULL };
+static struct ac97_ops wolfson_ops11 = { wolfson_init11, NULL, NULL };
 static struct ac97_ops tritech_ops = { tritech_init, NULL, NULL };
 static struct ac97_ops tritech_m_ops = { tritech_maestro_init, NULL, NULL };
 static struct ac97_ops sigmatel_9708_ops = { sigmatel_9708_init, NULL, NULL };
@@ -103,12 +114,15 @@
 static struct ac97_ops sigmatel_9744_ops = { sigmatel_9744_init, NULL, NULL };
 static struct ac97_ops crystal_digital_ops = { NULL, eapd_control, crystal_digital_control };
 static struct ac97_ops ad1886_ops = { ad1886_init, eapd_control, NULL };
+static struct ac97_ops cmedia_ops = { NULL, eapd_control, NULL};
+static struct ac97_ops cmedia_digital_ops = { cmedia_init, eapd_control, cmedia_digital_control};
 
 /* sorted by vendor/device id */
 static const struct {
 	u32 id;
 	char *name;
 	struct ac97_ops *ops;
+	int flags;
 } ac97_codec_ids[] = {
 	{0x41445303, "Analog Devices AD1819",	&null_ops},
 	{0x41445340, "Analog Devices AD1881",	&null_ops},
@@ -120,8 +134,12 @@
 	{0x414B4D00, "Asahi Kasei AK4540",	&null_ops},
 	{0x414B4D01, "Asahi Kasei AK4542",	&null_ops},
 	{0x414B4D02, "Asahi Kasei AK4543",	&null_ops},
+	{0x414C4326, "ALC100P",			&null_ops},
 	{0x414C4710, "ALC200/200P",		&null_ops},
-	{0x414C4720, "ALC650",			&null_ops},
+	{0x414C4720, "ALC650",			&default_digital_ops},
+	{0x434D4941, "CMedia",			&cmedia_ops,		AC97_NO_PCM_VOLUME },
+	{0x434D4942, "CMedia",			&cmedia_ops,		AC97_NO_PCM_VOLUME },
+	{0x434D4961, "CMedia",			&cmedia_digital_ops,	AC97_NO_PCM_VOLUME },
 	{0x43525900, "Cirrus Logic CS4297",	&default_ops},
 	{0x43525903, "Cirrus Logic CS4297",	&default_ops},
 	{0x43525913, "Cirrus Logic CS4297A rev A", &default_ops},
@@ -132,6 +150,8 @@
 	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
 	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
 	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
+	{0x43585442, "CXT66",			&default_ops,		AC97_DELUDED_MODEM },
+	{0x44543031, "Diamond Technology DT0893", &default_ops},
 	{0x45838308, "ESS Allegro ES1988",	&null_ops},
 	{0x49434511, "ICE1232",			&null_ops}, /* I hope --jk */
 	{0x4e534331, "National Semiconductor LM4549", &null_ops},
@@ -143,9 +163,11 @@
 	{0x54524106, "TriTech TR28026",		&null_ops},
 	{0x54524108, "TriTech TR28028",		&tritech_ops},
 	{0x54524123, "TriTech TR A5",		&null_ops},
-	{0x574D4C00, "Wolfson WM9700A",		&wolfson_ops00},
-	{0x574D4C03, "Wolfson WM9703/WM9707",	&wolfson_ops03},
+	{0x574D4C03, "Wolfson WM9703/07/08/17",	&wolfson_ops03},
 	{0x574D4C04, "Wolfson WM9704M/WM9704Q",	&wolfson_ops04},
+	{0x574D4C05, "Wolfson WM9705/WM9710",   &wolfson_ops05},
+	{0x574D4C09, "Wolfson WM9709",		&null_ops},
+	{0x574D4C12, "Wolfson WM9711/9712",	&wolfson_ops11},
 	{0x83847600, "SigmaTel STAC????",	&null_ops},
 	{0x83847604, "SigmaTel STAC9701/3/4/5", &null_ops},
 	{0x83847605, "SigmaTel STAC9704",	&null_ops},
@@ -271,6 +293,10 @@
 	[SOUND_MIXER_PHONEIN] 	= AC97_REC_PHONE
 };
 
+static LIST_HEAD(codecs);
+static LIST_HEAD(codec_drivers);
+static DECLARE_MUTEX(codec_sem);
+
 /* reads the given OSS mixer from the ac97 the caller must have insured that the ac97 knows
    about that given mixer, and should be holding a spinlock for the card */
 static int ac97_read_mixer(struct ac97_codec *codec, int oss_channel) 
@@ -445,7 +471,7 @@
 }
 
 /* read or write the recmask, the ac97 can really have left and right recording
-   inputs independently set, but OSS doesn't seem to want us to express that to
+   inputs independantly set, but OSS doesn't seem to want us to express that to
    the user. the caller guarantees that we have a supported bit set, and they
    must be holding the card's spinlock */
 static int ac97_recmask_io(struct ac97_codec *codec, int rw, int mask) 
@@ -487,8 +513,8 @@
 
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strlcpy(info.id, codec->name, sizeof(info.id));
-		strlcpy(info.name, codec->name, sizeof(info.name));
+		strncpy(info.id, codec->name, sizeof(info.id));
+		strncpy(info.name, codec->name, sizeof(info.name));
 		info.modify_counter = codec->modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -496,8 +522,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strlcpy(info.id, codec->name, sizeof(info.id));
-		strlcpy(info.name, codec->name, sizeof(info.name));
+		strncpy(info.id, codec->name, sizeof(info.id));
+		strncpy(info.name, codec->name, sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
@@ -678,6 +704,75 @@
 }
  
 /**
+ *	ac97_check_modem - Check if the Codec is a modem
+ *	@codec: codec to check
+ *
+ *	Return true if the device is an AC97 1.0 or AC97 2.0 modem
+ */
+ 
+static int ac97_check_modem(struct ac97_codec *codec)
+{
+	/* Check for an AC97 1.0 soft modem (ID1) */
+	if(codec->codec_read(codec, AC97_RESET) & 2)
+		return 1;
+	/* Check for an AC97 2.x soft modem */
+	codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
+	if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) & 1)
+		return 1;
+	return 0;
+}
+
+
+/**
+ *	ac97_alloc_codec - Allocate an AC97 codec
+ *
+ *	Returns a new AC97 codec structure. AC97 codecs may become
+ *	refcounted soon so this interface is needed. Returns with
+ *	one reference taken.
+ */
+ 
+struct ac97_codec *ac97_alloc_codec(void)
+{
+	struct ac97_codec *codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL);
+	if(!codec)
+		return NULL;
+
+	memset(codec, 0, sizeof(*codec));
+	spin_lock_init(&codec->lock);
+	INIT_LIST_HEAD(&codec->list);
+	return codec;
+}
+
+EXPORT_SYMBOL(ac97_alloc_codec);
+
+/**
+ *	ac97_release_codec -	Release an AC97 codec
+ *	@codec: codec to release
+ *
+ *	Release an allocated AC97 codec. This will be refcounted in
+ *	time but for the moment is trivial. Calls the unregister
+ *	handler if the codec is now defunct.
+ */
+ 
+void ac97_release_codec(struct ac97_codec *codec)
+{
+	/* Remove from the list first, we don't want to be
+	   "rediscovered" */
+	down(&codec_sem);
+	list_del(&codec->list);
+	up(&codec_sem);
+	/*
+	 *	The driver needs to deal with internal
+	 *	locking to avoid accidents here. 
+	 */
+	if(codec->driver)
+		codec->driver->remove(codec, codec->driver);
+	kfree(codec);
+}
+
+EXPORT_SYMBOL(ac97_release_codec);
+
+/**
  *	ac97_probe_codec - Initialize and setup AC97-compatible codec
  *	@codec: (in/out) Kernel info for a single AC97 codec
  *
@@ -703,10 +798,13 @@
 int ac97_probe_codec(struct ac97_codec *codec)
 {
 	u16 id1, id2;
-	u16 audio, modem;
+	u16 audio;
 	int i;
 	char cidbuf[CODEC_ID_BUFSZ];
-
+	u16 f;
+	struct list_head *l;
+	struct ac97_driver *d;
+	
 	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
 	 * be read zero.
 	 *
@@ -729,13 +827,9 @@
 	}
 
 	/* probe for Modem Codec */
-	codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
-	modem = codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) & 1;
-	modem |= (audio&2);
-	audio &= ~2;
-
+	codec->modem = ac97_check_modem(codec);
 	codec->name = NULL;
-	codec->codec_ops = &null_ops;
+	codec->codec_ops = &default_ops;
 
 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
@@ -744,16 +838,51 @@
 			codec->type = ac97_codec_ids[i].id;
 			codec->name = ac97_codec_ids[i].name;
 			codec->codec_ops = ac97_codec_ids[i].ops;
+			codec->flags = ac97_codec_ids[i].flags;
 			break;
 		}
 	}
+
+	codec->model = (id1 << 16) | id2;
+	
+	f = codec->codec_read(codec, AC97_EXTENDED_STATUS);
+	if(f & 4)
+		codec->codec_ops = &default_digital_ops;
+	
+	/* A device which thinks its a modem but isnt */
+	if(codec->flags & AC97_DELUDED_MODEM)
+		codec->modem = 0;
+		
 	if (codec->name == NULL)
 		codec->name = "Unknown";
 	printk(KERN_INFO "ac97_codec: AC97 %s codec, id: %s (%s)\n", 
-		modem ? "Modem" : (audio ? "Audio" : ""),
+		codec->modem ? "Modem" : (audio ? "Audio" : ""),
 	       codec_id(id1, id2, cidbuf), codec->name);
 
-	return ac97_init_mixer(codec);
+	if(!ac97_init_mixer(codec))
+		return 0;
+		
+	/* 
+	 *	Attach last so the caller can override the mixer
+	 *	callbacks.
+	 */
+	 
+	down(&codec_sem);
+	list_add(&codec->list, &codecs);
+
+	list_for_each(l, &codec_drivers) {
+		d = list_entry(l, struct ac97_driver, list);
+		if ((codec->model ^ d->codec_id) & d->codec_mask)
+			continue;
+		if(d->probe(codec, d) == 0)
+		{
+			codec->driver = d;
+			break;
+		}
+	}
+
+	up(&codec_sem);
+	return 1;
 }
 
 static int ac97_init_mixer(struct ac97_codec *codec)
@@ -772,6 +901,7 @@
 	if (!(cap & 0x10))
 		codec->supported_mixers &= ~SOUND_MASK_ALTPCM;
 
+
 	/* detect bit resolution */
 	codec->codec_write(codec, AC97_MASTER_VOL_STEREO, 0x2020);
 	if(codec->codec_read(codec, AC97_MASTER_VOL_STEREO) == 0x2020)
@@ -800,6 +930,15 @@
 		ac97_set_mixer(codec, md->mixer, md->value);
 	}
 
+	/*
+	 *	Volume is MUTE only on this device. We have to initialise
+	 *	it but its useless beyond that.
+	 */
+	if(codec->flags & AC97_NO_PCM_VOLUME)
+	{
+		codec->supported_mixers &= ~SOUND_MASK_PCM;
+		printk(KERN_WARNING "AC97 codec does not have proper volume support.\n");
+	}
 	return 1;
 }
 
@@ -872,54 +1011,75 @@
 	return 0;
 }
 
-
-static int wolfson_init00(struct ac97_codec * codec)
+static int cmedia_init(struct ac97_codec *codec)
 {
-	/* This initialization is suspect, but not known to be wrong.
-	   It was copied from the initialization for the WM9704Q, but
-	   that same sequence is known to fail for the WM9707.  Thus
-	   this warning may help someone with hardware to test
-	   this code. */
-	codec->codec_write(codec, 0x72, 0x0808);
-	codec->codec_write(codec, 0x74, 0x0808);
-
-	// patch for DVD noise
-	codec->codec_write(codec, 0x5a, 0x0200);
-
-	// init vol as PCM vol
-	codec->codec_write(codec, 0x70,
-		codec->codec_read(codec, AC97_PCMOUT_VOL));
-
-	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	/* Initialise the CMedia 9739 */
+	/*
+		We could set various options here
+		Register 0x20 bit 0x100 sets mic as center bass
+		Also do multi_channel_ctrl &=~0x3000 |=0x1000
+		
+		For now we set up the GPIO and PC beep 
+	*/
+	
+	u16 v;
+	
+	/* MIC */
+	codec->codec_write(codec, 0x64, 0x3000);
+	v = codec->codec_read(codec, 0x64);
+	v &= ~0x8000;
+	codec->codec_write(codec, 0x64, v);
+	codec->codec_write(codec, 0x70, 0x0100);
+	codec->codec_write(codec, 0x72, 0x0020);
 	return 0;
 }
-
+	
+#define AC97_WM97XX_FMIXER_VOL 0x72
+#define AC97_WM97XX_RMIXER_VOL 0x74
+#define AC97_WM97XX_TEST 0x5a
+#define AC97_WM9704_RPCM_VOL 0x70
+#define AC97_WM9711_OUT3VOL 0x16
 
 static int wolfson_init03(struct ac97_codec * codec)
 {
 	/* this is known to work for the ViewSonic ViewPad 1000 */
-	codec->codec_write(codec, 0x72, 0x0808);
-	codec->codec_write(codec, 0x20, 0x8000);
+	codec->codec_write(codec, AC97_WM97XX_FMIXER_VOL, 0x0808);
+	codec->codec_write(codec, AC97_GENERAL_PURPOSE, 0x8000);
 	return 0;
 }
 
-
 static int wolfson_init04(struct ac97_codec * codec)
 {
-	codec->codec_write(codec, 0x72, 0x0808);
-	codec->codec_write(codec, 0x74, 0x0808);
+	codec->codec_write(codec, AC97_WM97XX_FMIXER_VOL, 0x0808);
+	codec->codec_write(codec, AC97_WM97XX_RMIXER_VOL, 0x0808);
 
 	// patch for DVD noise
-	codec->codec_write(codec, 0x5a, 0x0200);
+	codec->codec_write(codec, AC97_WM97XX_TEST, 0x0200);
 
 	// init vol as PCM vol
-	codec->codec_write(codec, 0x70,
+	codec->codec_write(codec, AC97_WM9704_RPCM_VOL,
 		codec->codec_read(codec, AC97_PCMOUT_VOL));
 
+	/* set rear surround volume */
 	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
 	return 0;
 }
 
+/* WM9705, WM9710 */
+static int wolfson_init05(struct ac97_codec * codec)
+{
+	/* set front mixer volume */
+	codec->codec_write(codec, AC97_WM97XX_FMIXER_VOL, 0x0808);
+	return 0;
+}
+
+/* WM9711, WM9712 */
+static int wolfson_init11(struct ac97_codec * codec)
+{
+	/* set out3 volume */
+	codec->codec_write(codec, AC97_WM9711_OUT3VOL, 0x0808);
+	return 0;
+}
 
 static int tritech_init(struct ac97_codec * codec)
 {
@@ -980,26 +1140,115 @@
 	return 0;
 }
 
+static int generic_digital_control(struct ac97_codec *codec, int slots, int rate, int mode)
+{
+	u16 reg;
+	
+	reg = codec->codec_read(codec, AC97_SPDIF_CONTROL);
+	
+	switch(rate)
+	{
+		/* Off by default */
+		default:
+		case 0:
+			reg = codec->codec_read(codec, AC97_EXTENDED_STATUS);
+			codec->codec_write(codec, AC97_EXTENDED_STATUS, (reg & ~AC97_EA_SPDIF));
+			if(rate == 0)
+				return 0;
+			return -EINVAL;
+		case 1:
+			reg = (reg & AC97_SC_SPSR_MASK) | AC97_SC_SPSR_48K;
+			break;
+		case 2:
+			reg = (reg & AC97_SC_SPSR_MASK) | AC97_SC_SPSR_44K;
+			break;
+		case 3:
+			reg = (reg & AC97_SC_SPSR_MASK) | AC97_SC_SPSR_32K;
+			break;
+	}
+	
+	reg &= ~AC97_SC_CC_MASK;
+	reg |= (mode & AUDIO_CCMASK) << 6;
+	
+	if(mode & AUDIO_DIGITAL)
+		reg |= 2;
+	if(mode & AUDIO_PRO)
+		reg |= 1;
+	if(mode & AUDIO_DRS)
+		reg |= 0x4000;
+
+	codec->codec_write(codec, AC97_SPDIF_CONTROL, reg);
+
+	reg = codec->codec_read(codec, AC97_EXTENDED_STATUS);
+	reg &= (AC97_EA_SLOT_MASK);
+	reg |= AC97_EA_VRA | AC97_EA_SPDIF | slots;
+	codec->codec_write(codec, AC97_EXTENDED_STATUS, reg);
+	
+	reg = codec->codec_read(codec, AC97_EXTENDED_STATUS);
+	if(!(reg & 0x0400))
+	{
+		codec->codec_write(codec, AC97_EXTENDED_STATUS, reg & ~ AC97_EA_SPDIF);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
- *	Crystal digital audio control (CS4299
+ *	Crystal digital audio control (CS4299)
  */
  
-static int crystal_digital_control(struct ac97_codec *codec, int mode)
+static int crystal_digital_control(struct ac97_codec *codec, int slots, int rate, int mode)
 {
 	u16 cv;
 
-	switch(mode)
+	if(mode & AUDIO_DIGITAL)
+		return -EINVAL;
+		
+	switch(rate)
 	{
 		case 0: cv = 0x0; break;	/* SPEN off */
-		case 1: cv = 0x8004; break;	/* 48KHz digital */
-		case 2: cv = 0x8104; break;	/* 44.1KHz digital */
+		case 48000: cv = 0x8004; break;	/* 48KHz digital */
+		case 44100: cv = 0x8104; break;	/* 44.1KHz digital */
+		case 32768: 			/* 32Khz */
 		default:
-			return -1;		/* Not supported yet(eg AC3) */
+			return -EINVAL;
 	}
 	codec->codec_write(codec, 0x68, cv);
 	return 0;
 }
 
+/*
+ *	CMedia digital audio control
+ *	Needs more work.
+ */
+ 
+static int cmedia_digital_control(struct ac97_codec *codec, int slots, int rate, int mode)
+{
+	u16 cv;
+
+	if(mode & AUDIO_DIGITAL)
+		return -EINVAL;
+		
+	switch(rate)
+	{
+		case 0:		cv = 0x0001; break;	/* SPEN off */
+		case 48000:	cv = 0x0009; break;	/* 48KHz digital */
+		default:
+			return -EINVAL;
+	}
+	codec->codec_write(codec, 0x2A, 0x05c4);
+	codec->codec_write(codec, 0x6C, cv);
+	
+	/* Switch on mix to surround */
+	cv = codec->codec_read(codec, 0x64);
+	cv &= ~0x0200;
+	if(mode)
+		cv |= 0x0200;
+	codec->codec_write(codec, 0x64, cv);
+	return 0;
+}
+
+
 /* copied from drivers/sound/maestro.c */
 #if 0  /* there has been 1 person on the planet with a pt101 that we
         know of.  If they care, they can put this back in :) */
@@ -1137,4 +1386,67 @@
 
 EXPORT_SYMBOL(ac97_restore_state);
 
+/**
+ *	ac97_register_driver	-	register a codec helper
+ *	@driver: Driver handler
+ *
+ *	Register a handler for codecs matching the codec id. The handler
+ *	attach function is called for all present codecs and will be 
+ *	called when new codecs are discovered.
+ */
+ 
+int ac97_register_driver(struct ac97_driver *driver)
+{
+	struct list_head *l;
+	struct ac97_codec *c;
+	
+	down(&codec_sem);
+	INIT_LIST_HEAD(&driver->list);
+	list_add(&driver->list, &codec_drivers);
+	
+	list_for_each(l, &codecs)
+	{
+		c = list_entry(l, struct ac97_codec, list);
+		if(c->driver != NULL || ((c->model ^ driver->codec_id) & driver->codec_mask))
+			continue;
+		if(driver->probe(c, driver))
+			continue;
+		c->driver = driver;
+	}
+	up(&codec_sem);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ac97_register_driver);
+
+/**
+ *	ac97_unregister_driver	-	unregister a codec helper
+ *	@driver: Driver handler
+ *
+ *	Register a handler for codecs matching the codec id. The handler
+ *	attach function is called for all present codecs and will be 
+ *	called when new codecs are discovered.
+ */
+ 
+void ac97_unregister_driver(struct ac97_driver *driver)
+{
+	struct list_head *l;
+	struct ac97_codec *c;
+	
+	down(&codec_sem);
+	list_del_init(&driver->list);
+	
+	list_for_each(l, &codecs)
+	{
+		c = list_entry(l, struct ac97_codec, list);
+		if(c->driver == driver)
+			driver->remove(c, driver);
+		c->driver = NULL;
+	}
+	
+	up(&codec_sem);
+}
+
+EXPORT_SYMBOL_GPL(ac97_unregister_driver);
+	
 MODULE_LICENSE("GPL");
