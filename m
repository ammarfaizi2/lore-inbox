Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289571AbSAJRki>; Thu, 10 Jan 2002 12:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289572AbSAJRka>; Thu, 10 Jan 2002 12:40:30 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:57547 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S289571AbSAJRkR>;
	Thu, 10 Jan 2002 12:40:17 -0500
Message-ID: <3C3DD27B.307E8D94@inti.gov.ar>
Date: Thu, 10 Jan 2002 14:42:19 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-kernel <linux-kernel@vger.kernel.org>,
        Ollie Lho <ollie@sis.com.tw>
Subject: [PATCH][RFC/A][2] Sound: Avance Logic codecs addition and more
Content-Type: multipart/mixed;
 boundary="------------149D081E5DE8391B20ED30C2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------149D081E5DE8391B20ED30C2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Kernel: 2.4.17
Module: ac97_codec.c
Harware tested: ALC100P and STAC9721/23 codecs
Abstract: Add new ALC, Sigmatel and Cirrus codecs. Changes in the codecs
list to support ranges and if the codec is unknown report it with the name
of the vendor if we can determine it.
Revision of the patch: 2

That's the second version of the patch I sent yesterday.
Alan was right about Cirrus chips, I downloaded the data sheets and is
clear that the 3 LSB are the revision and can have any value.
I also downloaded Sigmatel data sheets and after reading the comments about
the IDs by these three vendors (I started with Avance Logic, now Realtek) is

obvious that the 24 MSB are the vendor ID (of course there are irregular
values because a Redmond company assigns these values ;-) and the chip
number is in the 8 LSB.
Is also clear that various manufacturers choose to reserve some of these
bits for revision numbers.
For these reasons I'm sending a more complex patch. It changes the way
codecs ids are stored. A main list contains the name of the vendor, the id
of the vendor, a mask to filter the revision bits, the number of known
devices from this vendor and a pointer to an array containing the list of
devices.
The array of devices contains the id of the codec, the name and a pointer
to the structure of function-options.
The code first looks for the vendor, if found then looks for the particular
codec. If the codec couldn't be found but we know the manufacturer then the
code assigns the name of the vendor to the "name" field. The code also
assigns to the "type" field the id of the codec *after* filtering the
revision.
Of course the patch is larger but I think it reflects better the reality.
If this approach looks coherent I'll ask for these changes:
1) Add a "char *vendor" field to the ac97_codec structure.
2) Store only the name of the codec in the "name" field, we can reconstruct
a descriptive name latter using vendor+name. I checked and it looks like
the name is only used in ac97_codec (also for debug in i810, but just to
log the name and can be updated).
3) Add a "u32 revision" field to hold the revision of the chip. This value
could be needed by the "ops" functions and is much more clear (type says
the type and revision the revision).

The patch also adds identification for:
"Cirrus Logic CS4201", "Cirrus Logic CS4205", "SigmaTel STAC9750/51",
"SigmaTel STAC9766/67", "SigmaTel STAC9700" and "SigmaTel STAC9711".
[Also for the ones in the first patch "ALC 100/P", "ALC 650" and
"ALC 101"]

Note that I'm not sure about the "ops" for these chips (I only have an
ALC100P) so I left null_ops. That's better than nothing because if the
codec isn't identified the code uses null_ops anyways.
If somebody wants to discuss about what ops functions should be used by
looking in the datasheets I'm available for such a thing.

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



--------------149D081E5DE8391B20ED30C2
Content-Type: text/plain; charset=us-ascii;
 name="ac97_cod.pat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_cod.pat"

diff -ru linux-2.4.17.ori/drivers/sound/ac97_codec.c linux-2.4.17/drivers/sound/ac97_codec.c
--- linux-2.4.17.ori/drivers/sound/ac97_codec.c	Mon Nov 12 15:02:54 2001
+++ linux-2.4.17/drivers/sound/ac97_codec.c	Wed Jan  9 23:43:21 2002
@@ -31,6 +31,8 @@
  **************************************************************************
  *
  * History
+ * v0.5 Jan 08 2002 Salvador E. Tropea (SET)
+ *	added Avance Logic ALC codec ids and a mask mechanism for ranges.
  * v0.4 Mar 15 2000 Ollie Lho
  *	dual codecs support verified with 4 channels output
  * v0.3 Feb 22 2000 Ollie Lho
@@ -95,54 +97,143 @@
 static struct ac97_ops sigmatel_9744_ops = { sigmatel_9744_init, NULL, NULL };
 static struct ac97_ops crystal_digital_ops = { NULL, eapd_control, crystal_digital_control };
 
-/* sorted by vendor/device id */
-static const struct {
+/* structures to hold the tree */
+struct ac97_codec_id {
 	u32 id;
 	char *name;
 	struct ac97_ops *ops;
+};
+
+/* codecs by manufacturer */
+static struct ac97_codec_id ads_codecs[] = {
+	{0x03, "Analog Devices AD1819",	&null_ops},
+	{0x40, "Analog Devices AD1881",	&null_ops},
+	{0x48, "Analog Devices AD1881A",&null_ops},
+	{0x60, "Analog Devices AD1885",	&default_ops},
+};
+
+static struct ac97_codec_id adt_codecs[] = {
+	{0x60, "Analog Devices AD1885",	&default_ops},
+};
+
+static struct ac97_codec_id akm_codecs[] = {
+	{0x00, "Asahi Kasei AK4540",	&null_ops},
+	{0x01, "Asahi Kasei AK4542",	&null_ops},
+	{0x02, "Asahi Kasei AK4543",	&null_ops},
+};
+
+static struct ac97_codec_id alc_codecs[] = {
+	/* Note: 4 LSB are the revision 0 = rev A */
+	{0x20, "ALC 100/P",		&null_ops},
+};
+
+static struct ac97_codec_id alg_codecs[] = {
+	/* Note: 4 LSB are the revision 0 = rev A */
+	{0x10, "ALC 200/201/201A/P",	&null_ops},
+	{0x20, "ALC 650",		&null_ops},
+	{0x30, "ALC 101",		&null_ops},
+};
+
+static struct ac97_codec_id cry_codecs[] = {
+	{0x00, "Cirrus Logic CS4297",	&default_ops},
+	{0x10, "Cirrus Logic CS4297A",	&default_ops},
+	{0x20, "Cirrus Logic CS4298",	&null_ops},
+	{0x28, "Cirrus Logic CS4294",	&null_ops},
+	{0x30, "Cirrus Logic CS4299",	&crystal_digital_ops},
+	{0x40, "Cirrus Logic CS4201",	&null_ops}, /* Not sure about options */
+	{0x50, "Cirrus Logic CS4205",	&null_ops}, /* Not sure about options */
+};
+
+static struct ac97_codec_id ess_codecs[] = {
+	{0x08, "ESS Allegro ES1988",	&null_ops},
+};
+
+static struct ac97_codec_id ice_codecs[] = {
+	{0x11, "ICE1232",		&null_ops}, /* I hope --jk */
+};
+
+static struct ac97_codec_id nac_codecs[] = {
+	{0x31, "National Semiconductor LM4549", &null_ops},
+};
+
+static struct ac97_codec_id sil_codecs[] = {
+	{0x22, "Silicon Laboratory Si3036", &null_ops},
+	{0x23, "Silicon Laboratory Si3038", &null_ops},
+};
+
+static struct ac97_codec_id tr__codecs[] = {
+	{0xFF, "TriTech TR?????",	&tritech_m_ops},
+};
+
+static struct ac97_codec_id tra_codecs[] = {
+	{0x02, "TriTech TR28022",	&null_ops},
+	{0x03, "TriTech TR28023",	&null_ops},
+	{0x06, "TriTech TR28026",	&null_ops},
+	{0x08, "TriTech TR28028",	&tritech_ops},
+	{0x23, "TriTech TR A5",		&null_ops},
+};
+
+static struct ac97_codec_id wml_codecs[] = {
+	{0x00, "Wolfson WM9704",	&wolfson_ops},
+	{0x03, "Wolfson WM9703/9704",	&wolfson_ops},
+	{0x04, "Wolfson WM9704 (quad)",	&wolfson_ops},
+};
+
+static struct ac97_codec_id stf_codecs[] = {
+	{0x00, "SigmaTel STAC9700",	&null_ops},
+	{0x04, "SigmaTel STAC9701/3/4/5", &null_ops},
+	{0x05, "SigmaTel STAC9704",	&null_ops},
+	{0x08, "SigmaTel STAC9708/11",	&sigmatel_9708_ops},
+	{0x09, "SigmaTel STAC9721/23",	&sigmatel_9721_ops},
+	{0x44, "SigmaTel STAC9744/45",	&sigmatel_9744_ops},
+	{0x50, "SigmaTel STAC9750/51",	&null_ops}, /* Not sure about options */
+	{0x56, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
+	{0x66, "SigmaTel STAC9766/67",	&null_ops}, /* Not sure about options */
+	{0x84, "SigmaTel STAC9783/84?",	&null_ops}, /* Data sheet is preliminary and says 00 */
+};
+
+static struct ac97_codec_id wic_codecs[] = {
+	{0x01, "Winbond 83971D",	&null_ops},
+};
+
+/* vendors and their codecs sorted by id */
+static const struct {
+	u32 id;
+	u32 mask;
+	int count;
+	struct ac97_codec_id *list;
+	char *name;
 } ac97_codec_ids[] = {
-	{0x41445303, "Analog Devices AD1819",	&null_ops},
-	{0x41445340, "Analog Devices AD1881",	&null_ops},
-	{0x41445348, "Analog Devices AD1881A",	&null_ops},
-	{0x41445360, "Analog Devices AD1885",	&default_ops},
-	{0x41445460, "Analog Devices AD1885",	&default_ops},
-	{0x414B4D00, "Asahi Kasei AK4540",	&null_ops},
-	{0x414B4D01, "Asahi Kasei AK4542",	&null_ops},
-	{0x414B4D02, "Asahi Kasei AK4543",	&null_ops},
-	{0x414C4710, "ALC200/200P",		&null_ops},
-	{0x43525900, "Cirrus Logic CS4297",	&default_ops},
-	{0x43525903, "Cirrus Logic CS4297",	&default_ops},
-	{0x43525913, "Cirrus Logic CS4297A rev A", &default_ops},
-	{0x43525914, "Cirrus Logic CS4297A rev B", &default_ops},
-	{0x43525923, "Cirrus Logic CS4298",	&null_ops},
-	{0x4352592B, "Cirrus Logic CS4294",	&null_ops},
-	{0x4352592D, "Cirrus Logic CS4294",	&null_ops},
-	{0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
-	{0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
-	{0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
-	{0x45838308, "ESS Allegro ES1988",	&null_ops},
-	{0x49434511, "ICE1232",			&null_ops}, /* I hope --jk */
-	{0x4e534331, "National Semiconductor LM4549", &null_ops},
-	{0x53494c22, "Silicon Laboratory Si3036", &null_ops},
-	{0x53494c23, "Silicon Laboratory Si3038", &null_ops},
-	{0x545200FF, "TriTech TR?????",		&tritech_m_ops},
-	{0x54524102, "TriTech TR28022",		&null_ops},
-	{0x54524103, "TriTech TR28023",		&null_ops},
-	{0x54524106, "TriTech TR28026",		&null_ops},
-	{0x54524108, "TriTech TR28028",		&tritech_ops},
-	{0x54524123, "TriTech TR A5",		&null_ops},
-	{0x574D4C00, "Wolfson WM9704",		&wolfson_ops},
-	{0x574D4C03, "Wolfson WM9703/9704",	&wolfson_ops},
-	{0x574D4C04, "Wolfson WM9704 (quad)",	&wolfson_ops},
-	{0x83847600, "SigmaTel STAC????",	&null_ops},
-	{0x83847604, "SigmaTel STAC9701/3/4/5", &null_ops},
-	{0x83847605, "SigmaTel STAC9704",	&null_ops},
-	{0x83847608, "SigmaTel STAC9708",	&sigmatel_9708_ops},
-	{0x83847609, "SigmaTel STAC9721/23",	&sigmatel_9721_ops},
-	{0x83847644, "SigmaTel STAC9744/45",	&sigmatel_9744_ops},
-	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
-	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},
-	{0x57454301, "Winbond 83971D",		&null_ops},
+	{0x41445300, ~0x0, ARRAY_SIZE(ads_codecs), ads_codecs,
+	 "Analog Devices"},					/* ADS */
+	{0x41445400, ~0x0, ARRAY_SIZE(adt_codecs), adt_codecs,
+	 "Analog Devices"},					/* ADT */
+	{0x414B4D00, ~0x0, ARRAY_SIZE(akm_codecs), akm_codecs,
+	 "Asahi Kasei"},					/* AKM */
+	{0x414C4300, ~0xF, ARRAY_SIZE(alc_codecs), alc_codecs,
+	 "Avance Logic"},					/* ALC */
+	{0x414C4700, ~0xF, ARRAY_SIZE(alg_codecs), alg_codecs,
+	 "Avance Logic"},					/* ALG newer chips */
+	{0x43525900, ~0x7, ARRAY_SIZE(cry_codecs), cry_codecs,
+	 "Cirrus Logic"},					/* CRY */
+	{0x45838300, ~0x0, ARRAY_SIZE(ess_codecs), ess_codecs,
+	 "ESS"},						/* ESS */
+	{0x49434500, ~0x0, ARRAY_SIZE(ice_codecs), ice_codecs,
+	 "ICE"},						/* ICE -- I hope --jk */
+	{0x4E534300, ~0x0, ARRAY_SIZE(nac_codecs), nac_codecs,
+	 "National Semiconductor"},				/* NAC */
+	{0x53494C00, ~0x0, ARRAY_SIZE(sil_codecs), sil_codecs,
+	 "Silicon Laboratory"},					/* SIL */
+	{0x54520000, ~0x0, ARRAY_SIZE(tr__codecs), tr__codecs,
+	 "TriTech"},						/* TR? -- really? --set */
+	{0x54524100, ~0x0, ARRAY_SIZE(tra_codecs), tra_codecs,
+	 "TriTech"},						/* TRA */
+	{0x574D4C00, ~0x0, ARRAY_SIZE(wml_codecs), wml_codecs,
+	 "Wolfson"},						/* WML */
+	{0x83847600, ~0x0, ARRAY_SIZE(stf_codecs), stf_codecs,
+	 "SigmaTel"},						/* STF */
+	{0x57454300, ~0x0, ARRAY_SIZE(wic_codecs), wic_codecs,
+	 "Winbond"},						/* WIC */
 };
 
 static const char *ac97_stereo_enhancements[] =
@@ -642,6 +733,26 @@
 }
 
 /**
+ *	Helper function, here just to keep the sanity.
+ */
+ 
+static void look_codec_in_list(u32 id, u32 id_vendor, int count, struct ac97_codec_id *list, struct ac97_codec *codec)
+{
+	int j;
+
+	for (j=0; j<count; j++)
+		if (list[j].id == id_vendor) {
+			codec->type = id;
+			codec->name = list[j].name;
+			codec->codec_ops = list[j].ops;
+#ifdef DEBUG
+			printk("Found: %s\n", codec->name);
+#endif
+			break;
+		}
+}
+
+/**
  *	ac97_probe_codec - Initialize and setup AC97-compatible codec
  *	@codec: (in/out) Kernel info for a single AC97 codec
  *
@@ -668,7 +779,9 @@
 {
 	u16 id1, id2;
 	u16 audio, modem;
+	u32 id, id_vendor;
 	int i;
+	char *vendor = NULL;
 
 	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
 	 * be read zero.
@@ -699,16 +812,22 @@
 
 	id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
 	id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
-	for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
-		if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
-			codec->type = ac97_codec_ids[i].id;
-			codec->name = ac97_codec_ids[i].name;
-			codec->codec_ops = ac97_codec_ids[i].ops;
-			break;
+	id = ((id1 << 16) | id2);
+#ifdef DEBUG
+	printk("Looking for codec id: 0x%08x\n", id);
+#endif
+	id_vendor = id & 0xFFFFFF00;
+	for (i=0; (vendor == NULL) && (i<ARRAY_SIZE(ac97_codec_ids)); i++) {
+		if (ac97_codec_ids[i].id==id_vendor) {
+			vendor = ac97_codec_ids[i].name;
+			look_codec_in_list(id & ac97_codec_ids[i].mask,
+				id & ac97_codec_ids[i].mask & 0xFF,
+				ac97_codec_ids[i].count,
+				ac97_codec_ids[i].list, codec);
 		}
 	}
 	if (codec->name == NULL)
-		codec->name = "Unknown";
+		codec->name = vendor == NULL ? "Unknown" : vendor;
 	printk(KERN_INFO "ac97_codec: AC97 %s codec, id: 0x%04x:"
 	       "0x%04x (%s)\n", audio ? "Audio" : (modem ? "Modem" : ""),
 	       id1, id2, codec->name);

--------------149D081E5DE8391B20ED30C2--

