Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129877AbRBHFvB>; Thu, 8 Feb 2001 00:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBHFuw>; Thu, 8 Feb 2001 00:50:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28432 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129307AbRBHFud>;
	Thu, 8 Feb 2001 00:50:33 -0500
Message-ID: <3A823385.49C69C70@mandrakesoft.com>
Date: Thu, 08 Feb 2001 00:49:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org
Subject: PATCH 2.4.1.ac5: Update ac97 codec ids and codec-specific patches
Content-Type: multipart/mixed;
 boundary="------------95B41EB701C36A2D44E6C1A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------95B41EB701C36A2D44E6C1A0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan,

Attached is a patch against 2.4.1-ac5 which syncs the codec id list and
codec-specific init functions with the ones in my CVS tree.  Most of
this is a merge from ALSA, and I would put the changes in the category
"needs to go to Linus, but only after a bunch of testing"

Important changes:
* Merge codec-specific initialization code from ALSA and maestro.c
* Sort codec id list by value.  Add several new codec ids.  None removed
(thrice checked!), of course.  Note the Tritech device id from maestro
(0x00FF) seems almost certainly wrong... but since maestro.c didn't mask
it at all, I won't either.

Minor changes:
* Add URLs for Intel AC97 docs and homepage
* Use kernel-standard ARRAY_SIZE macro, not arraysize
* Const-ify a couple tables
* Remove excess whitespace after AC97_REC_PHONE mention
* Change existing sigmatel_init return values from one to zero (not that
the return values are -ever- used, at present)

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------95B41EB701C36A2D44E6C1A0
Content-Type: text/plain; charset=us-ascii;
 name="ac97-codec-2.4.1.ac5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97-codec-2.4.1.ac5.patch"

Index: linux_2_4/drivers/sound/ac97_codec.c
diff -u linux_2_4/drivers/sound/ac97_codec.c:1.1.1.11 linux_2_4/drivers/sound/ac97_codec.c:1.1.1.11.4.3
--- linux_2_4/drivers/sound/ac97_codec.c:1.1.1.11	Tue Feb  6 21:46:55 2001
+++ linux_2_4/drivers/sound/ac97_codec.c	Wed Feb  7 21:40:40 2001
@@ -20,6 +20,16 @@
  *	along with this program; if not, write to the Free Software
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
+ **************************************************************************
+ *
+ * The Intel Audio Codec '97 specification is available at the Intel
+ * audio homepage: http://developer.intel.com/ial/scalableplatforms/audio/
+ *
+ * The specification itself is currently available at:
+ * ftp://download.intel.com/ial/scalableplatforms/ac97r22.pdf
+ *
+ **************************************************************************
+ *
  * History
  * v0.4 Mar 15 2000 Ollie Lho
  *	dual codecs support verified with 4 channels output
@@ -49,42 +59,61 @@
 
 static int ac97_init_mixer(struct ac97_codec *codec);
 
-static int sigmatel_init(struct ac97_codec *codec);
+static int wolfson_init(struct ac97_codec * codec);
+static int tritech_init(struct ac97_codec * codec);
+static int tritech_maestro_init(struct ac97_codec * codec);
+static int sigmatel_9708_init(struct ac97_codec *codec);
+static int sigmatel_9721_init(struct ac97_codec *codec);
+static int sigmatel_9744_init(struct ac97_codec *codec);
 static int enable_eapd(struct ac97_codec *codec);
-
-#define arraysize(x)   (sizeof(x)/sizeof((x)[0]))
 
-static struct {
-	unsigned int id;
+/* sorted by vendor/device id */
+static const struct {
+	u32 id;
 	char *name;
 	int  (*init)  (struct ac97_codec *codec);
 } ac97_codec_ids[] = {
-	{0x414B4D00, "Asahi Kasei AK4540 rev 0", NULL},
-	{0x414B4D01, "Asahi Kasei AK4540 rev 1", NULL},
-	{0x41445340, "Analog Devices AD1881"  , NULL},
-	{0x41445360, "Analog Devices AD1885"  , enable_eapd},
-	{0x43525900, "Cirrus Logic CS4297"    , enable_eapd},
-	{0x43525903, "Cirrus Logic CS4297"  ,	enable_eapd},
-	{0x43525913, "Cirrus Logic CS4297A"   , enable_eapd},
-	{0x43525923, "Cirrus Logic CS4298"    , NULL},
-	{0x4352592B, "Cirrus Logic CS4294"    , NULL},
-	{0x4352592D, "Cirrus Logic CS4294"    , NULL},
-	{0x43525931, "Cirrus Logic CS4299"    , NULL},
-	{0x43525934, "Cirrus Logic CS4299"    , NULL},
-	{0x4e534331, "National Semiconductor LM4549" ,	NULL},
-	{0x53494c22, "Silicon Laboratory Si3036"     ,	NULL},
-	{0x53494c23, "Silicon Laboratory Si3038"     ,  NULL},
-	{0x83847600, "SigmaTel STAC????"      , NULL},
+	{0x41445303, "Analog Devices AD1819",	NULL},
+	{0x41445340, "Analog Devices AD1881",	NULL},
+	{0x41445348, "Analog Devices AD1881A",	NULL},
+	{0x41445460, "Analog Devices AD1885",	enable_eapd},
+	{0x414B4D00, "Asahi Kasei AK4540",	NULL},
+	{0x414B4D01, "Asahi Kasei AK4542",	NULL},
+	{0x414B4D02, "Asahi Kasei AK4543",	NULL},
+	{0x414C4710, "ALC200/200P",		NULL},
+	{0x43525900, "Cirrus Logic CS4297",	enable_eapd},
+	{0x43525903, "Cirrus Logic CS4297",	enable_eapd},
+	{0x43525913, "Cirrus Logic CS4297A rev A", enable_eapd},
+	{0x43525914, "Cirrus Logic CS4297A rev B", NULL},
+	{0x43525923, "Cirrus Logic CS4298",	NULL},
+	{0x4352592B, "Cirrus Logic CS4294",	NULL},
+	{0x4352592D, "Cirrus Logic CS4294",	NULL},
+	{0x43525931, "Cirrus Logic CS4299 rev A", NULL},
+	{0x43525933, "Cirrus Logic CS4299 rev C", NULL},
+	{0x43525934, "Cirrus Logic CS4299 rev D", NULL},
+	{0x45838308, "ESS Allegro ES1988",	NULL},
+	{0x49434511, "ICE1232",			NULL}, /* I hope --jk */
+	{0x4e534331, "National Semiconductor LM4549", NULL},
+	{0x53494c22, "Silicon Laboratory Si3036", NULL},
+	{0x53494c23, "Silicon Laboratory Si3038", NULL},
+	{0x545200FF, "TriTech TR?????",		tritech_maestro_init},
+	{0x54524102, "TriTech TR28022",		NULL},
+	{0x54524103, "TriTech TR28023",		NULL},
+	{0x54524106, "TriTech TR28026",		NULL},
+	{0x54524108, "TriTech TR28028",		tritech_init},
+	{0x54524123, "TriTech TR?????",		NULL},
+	{0x574D4C00, "Wolfson WM9704",		wolfson_init},
+	{0x574D4C03, "Wolfson WM9703/9704",	wolfson_init},
+	{0x574D4C04, "Wolfson WM9704 (quad)",	wolfson_init},
+	{0x83847600, "SigmaTel STAC????",	NULL},
 	{0x83847604, "SigmaTel STAC9701/3/4/5", NULL},
-	{0x83847605, "SigmaTel STAC9704"      , NULL},
-	{0x83847608, "SigmaTel STAC9708"      , NULL},
-	{0x83847609, "SigmaTel STAC9721/23"   , sigmatel_init},
-	{0x54524103, "TriTech TR?????"	      , NULL},
-	{0x54524106, "TriTech TR28026"        , NULL},
-	{0x54524108, "TriTech TR28028"        , NULL},
-	{0x54524123, "TriTech TR?????"	      , NULL},	
-	{0x574D4C00, "Wolfson WM9704"         , NULL},
-	{0x00000000, NULL, NULL}
+	{0x83847605, "SigmaTel STAC9704",	NULL},
+	{0x83847608, "SigmaTel STAC9708",	sigmatel_9708_init},
+	{0x83847609, "SigmaTel STAC9721/23",	sigmatel_9721_init},
+	{0x83847644, "SigmaTel STAC9744/45",	sigmatel_9744_init},
+	{0x83847656, "SigmaTel STAC9756/57",	sigmatel_9744_init},
+	{0x83847684, "SigmaTel STAC9783/84?",	NULL},
+	{0,}
 };
 
 static const char *ac97_stereo_enhancements[] =
@@ -176,10 +205,10 @@
 	AC97_REC_LINE,
 	AC97_REC_STEREO, /* combination of all enabled outputs..  */
 	AC97_REC_MONO,	      /*.. or the mono equivalent */
-	AC97_REC_PHONE	      
+	AC97_REC_PHONE
 };
 
-static unsigned int ac97_rm2oss[] = {
+static const unsigned int ac97_rm2oss[] = {
 	[AC97_REC_MIC] 	 = SOUND_MIXER_MIC,
 	[AC97_REC_CD] 	 = SOUND_MIXER_CD,
 	[AC97_REC_VIDEO] = SOUND_MIXER_VIDEO,
@@ -190,7 +219,7 @@
 };
 
 /* indexed by bit position */
-static unsigned int ac97_oss_rm[] = {
+static const unsigned int ac97_oss_rm[] = {
 	[SOUND_MIXER_MIC] 	= AC97_REC_MIC,
 	[SOUND_MIXER_CD] 	= AC97_REC_CD,
 	[SOUND_MIXER_VIDEO] 	= AC97_REC_VIDEO,
@@ -641,7 +670,7 @@
 
 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
-	for (i = 0; i < arraysize(ac97_codec_ids); i++) {
+	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
 		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
 			codec->type = ac97_codec_ids[i].id;
 			codec->name = ac97_codec_ids[i].name;
@@ -705,41 +734,151 @@
 	return 1;
 }
 
-static int sigmatel_init(struct ac97_codec * codec)
+#define AC97_SIGMATEL_ANALOG    0x6c	/* Analog Special */
+#define AC97_SIGMATEL_DAC2INVERT 0x6e
+#define AC97_SIGMATEL_BIAS1     0x70
+#define AC97_SIGMATEL_BIAS2     0x72
+#define AC97_SIGMATEL_MULTICHN  0x74	/* Multi-Channel programming */
+#define AC97_SIGMATEL_CIC1      0x76
+#define AC97_SIGMATEL_CIC2      0x78
+
+
+static int sigmatel_9708_init(struct ac97_codec * codec)
+{
+	u16 codec72, codec6c;
+
+	codec72 = codec->codec_read(codec, AC97_SIGMATEL_BIAS2) & 0x8000;
+	codec6c = codec->codec_read(codec, AC97_SIGMATEL_ANALOG);
+
+	if ((codec72==0) && (codec6c==0)) {
+		codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+		codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x1000);
+		codec->codec_write(codec, AC97_SIGMATEL_BIAS1, 0xabba);
+		codec->codec_write(codec, AC97_SIGMATEL_BIAS2, 0x0007);
+	} else if ((codec72==0x8000) && (codec6c==0)) {
+		codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+		codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x1001);
+		codec->codec_write(codec, AC97_SIGMATEL_DAC2INVERT, 0x0008);
+	} else if ((codec72==0x8000) && (codec6c==0x0080)) {
+		/* nothing */
+	}
+	codec->codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x0000);
+	return 0;
+}
+
+
+static int sigmatel_9721_init(struct ac97_codec * codec)
 {
 	/* Only set up secondary codec */
 	if (codec->id == 0)
-		return 1;
+		return 0;
 
 	codec->codec_write(codec, AC97_SURROUND_MASTER, 0L);
 
 	/* initialize SigmaTel STAC9721/23 as secondary codec, decoding AC link
 	   sloc 3,4 = 0x01, slot 7,8 = 0x00, */
-	codec->codec_write(codec, 0x74, 0x00);
+	codec->codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x00);
 
 	/* we don't have the crystal when we are on an AMR card, so use
 	   BIT_CLK as our clock source. Write the magic word ABBA and read
 	   back to enable register 0x78 */
-	codec->codec_write(codec, 0x76, 0xabba);
-	codec->codec_read(codec, 0x76);
+	codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+	codec->codec_read(codec, AC97_SIGMATEL_CIC1);
 
 	/* sync all the clocks*/
-	codec->codec_write(codec, 0x78, 0x3802);
+	codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x3802);
 
-	return 1;
+	return 0;
+}
+
+
+static int sigmatel_9744_init(struct ac97_codec * codec)
+{
+	// patch for SigmaTel
+	codec->codec_write(codec, AC97_SIGMATEL_CIC1, 0xabba);
+	codec->codec_write(codec, AC97_SIGMATEL_CIC2, 0x0000); // is this correct? --jk
+	codec->codec_write(codec, AC97_SIGMATEL_BIAS1, 0xabba);
+	codec->codec_write(codec, AC97_SIGMATEL_BIAS2, 0x0002);
+	codec->codec_write(codec, AC97_SIGMATEL_MULTICHN, 0x0000);
+	return 0;
+}
+
+
+static int wolfson_init(struct ac97_codec * codec)
+{
+	codec->codec_write(codec, 0x72, 0x0808);
+	codec->codec_write(codec, 0x74, 0x0808);
+
+	// patch for DVD noise
+	codec->codec_write(codec, 0x5a, 0x0200);
+
+	// init vol as PCM vol
+	codec->codec_write(codec, 0x70,
+		codec->codec_read(codec, AC97_PCMOUT_VOL));
+
+	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	return 0;
+}
+
+
+static int tritech_init(struct ac97_codec * codec)
+{
+	codec->codec_write(codec, 0x26, 0x0300);
+	codec->codec_write(codec, 0x26, 0x0000);
+	codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	codec->codec_write(codec, AC97_RESERVED_3A, 0x0000);
+	return 0;
+}
+
+
+/* copied from drivers/sound/maestro.c */
+static int tritech_maestro_init(struct ac97_codec * codec)
+{
+	/* no idea what this does */
+	codec->codec_write(codec, 0x2A, 0x0001);
+	codec->codec_write(codec, 0x2C, 0x0000);
+	codec->codec_write(codec, 0x2C, 0XFFFF);
+	return 0;
 }
 
+
 /*
  *	External AMP management for EAPD using codecs
  *	(CS4279A, AD1885, ...)
  */
- 
+
 static int enable_eapd(struct ac97_codec * codec)
 {
 	codec->codec_write(codec, AC97_POWER_CONTROL,
 		codec->codec_read(codec, AC97_POWER_CONTROL)|0x8000);
 	return 0;
 }
+
+
+/* copied from drivers/sound/maestro.c */
+#if 0  /* there has been 1 person on the planet with a pt101 that we
+        know of.  If they care, they can put this back in :) */
+static int pt101_init(struct ac97_codec * codec)
+{
+	printk(KERN_INFO "ac97_codec: PT101 Codec detected, initializing but _not_ installing mixer device.\n");
+	/* who knows.. */
+	codec->codec_write(codec, 0x2A, 0x0001);
+	codec->codec_write(codec, 0x2C, 0x0000);
+	codec->codec_write(codec, 0x2C, 0xFFFF);
+	codec->codec_write(codec, 0x10, 0x9F1F);
+	codec->codec_write(codec, 0x12, 0x0808);
+	codec->codec_write(codec, 0x14, 0x9F1F);
+	codec->codec_write(codec, 0x16, 0x9F1F);
+	codec->codec_write(codec, 0x18, 0x0404);
+	codec->codec_write(codec, 0x1A, 0x0000);
+	codec->codec_write(codec, 0x1C, 0x0000);
+	codec->codec_write(codec, 0x02, 0x0404);
+	codec->codec_write(codec, 0x04, 0x0808);
+	codec->codec_write(codec, 0x0C, 0x801F);
+	codec->codec_write(codec, 0x0E, 0x801F);
+	return 0;
+}
+#endif
 	
 
 EXPORT_SYMBOL(ac97_read_proc);

--------------95B41EB701C36A2D44E6C1A0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
