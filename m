Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSAIQAR>; Wed, 9 Jan 2002 11:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSAIQAB>; Wed, 9 Jan 2002 11:00:01 -0500
Received: from [200.10.161.32] ([200.10.161.32]:40112 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S287684AbSAIP7s>;
	Wed, 9 Jan 2002 10:59:48 -0500
Message-ID: <3C3C6966.4679872E@inti.gov.ar>
Date: Wed, 09 Jan 2002 13:01:42 -0300
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
Subject: [PATCH][RFCA] Sound: Avance Logic codecs addition
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.17
Hardware: ALi5451+ALC100P
Module: sound/ac97_codec.c

The following patch adds the ALC100, ALC100P, ALC101, ALC201, ALC201A and
ALC650 codecs to the list. It was tested with a mother using ALC100P. The
rest are from information found in Realtek's datasheets (ALC=Avance Logic,
now absorved by Realtek).
The patch not only adds the entries but also changes the structure a little
bit. That's needed because according to the datasheets the lower 4 bits are
reserved for the revision number (0000==rev A). In fact the chip I have
returns 6 as revision number. For this reason I added a field to indicate a
mask to filter some bits.


diff -ru linux-2.4.17.ori/drivers/sound/ac97_codec.c
linux-2.4.17/drivers/sound/ac97_codec.c
--- linux-2.4.17.ori/drivers/sound/ac97_codec.c Mon Nov 12 15:02:54 2001
+++ linux-2.4.17/drivers/sound/ac97_codec.c     Tue Jan  8 21:54:34 2002
@@ -31,6 +31,8 @@
  **************************************************************************

  *
  * History
+ * v0.5 Jan 08 2002 Salvador E. Tropea (SET)
+ *     added Avance Logic ALC codec ids and a mask mechanism for ranges.
  * v0.4 Mar 15 2000 Ollie Lho
  *     dual codecs support verified with 4 channels output
  * v0.3 Feb 22 2000 Ollie Lho
@@ -98,51 +100,58 @@
 /* sorted by vendor/device id */
 static const struct {
        u32 id;
+       /* Some manufacturers use a range of values */
+       u32 mask;
        char *name;
        struct ac97_ops *ops;
 } ac97_codec_ids[] = {
-       {0x41445303, "Analog Devices AD1819",   &null_ops},
-       {0x41445340, "Analog Devices AD1881",   &null_ops},
-       {0x41445348, "Analog Devices AD1881A",  &null_ops},
-       {0x41445360, "Analog Devices AD1885",   &default_ops},
-       {0x41445460, "Analog Devices AD1885",   &default_ops},
-       {0x414B4D00, "Asahi Kasei AK4540",      &null_ops},
-       {0x414B4D01, "Asahi Kasei AK4542",      &null_ops},
-       {0x414B4D02, "Asahi Kasei AK4543",      &null_ops},
-       {0x414C4710, "ALC200/200P",             &null_ops},
-       {0x43525900, "Cirrus Logic CS4297",     &default_ops},
-       {0x43525903, "Cirrus Logic CS4297",     &default_ops},
-       {0x43525913, "Cirrus Logic CS4297A rev A", &default_ops},
-       {0x43525914, "Cirrus Logic CS4297A rev B", &default_ops},
-       {0x43525923, "Cirrus Logic CS4298",     &null_ops},
-       {0x4352592B, "Cirrus Logic CS4294",     &null_ops},
-       {0x4352592D, "Cirrus Logic CS4294",     &null_ops},
-       {0x43525931, "Cirrus Logic CS4299 rev A", &crystal_digital_ops},
-       {0x43525933, "Cirrus Logic CS4299 rev C", &crystal_digital_ops},
-       {0x43525934, "Cirrus Logic CS4299 rev D", &crystal_digital_ops},
-       {0x45838308, "ESS Allegro ES1988",      &null_ops},
-       {0x49434511, "ICE1232",                 &null_ops}, /* I hope --jk
*/
-       {0x4e534331, "National Semiconductor LM4549", &null_ops},
-       {0x53494c22, "Silicon Laboratory Si3036", &null_ops},
-       {0x53494c23, "Silicon Laboratory Si3038", &null_ops},
-       {0x545200FF, "TriTech TR?????",         &tritech_m_ops},
-       {0x54524102, "TriTech TR28022",         &null_ops},
-       {0x54524103, "TriTech TR28023",         &null_ops},
-       {0x54524106, "TriTech TR28026",         &null_ops},
-       {0x54524108, "TriTech TR28028",         &tritech_ops},
-       {0x54524123, "TriTech TR A5",           &null_ops},
-       {0x574D4C00, "Wolfson WM9704",          &wolfson_ops},
-       {0x574D4C03, "Wolfson WM9703/9704",     &wolfson_ops},
-       {0x574D4C04, "Wolfson WM9704 (quad)",   &wolfson_ops},
-       {0x83847600, "SigmaTel STAC????",       &null_ops},
-       {0x83847604, "SigmaTel STAC9701/3/4/5", &null_ops},
-       {0x83847605, "SigmaTel STAC9704",       &null_ops},
-       {0x83847608, "SigmaTel STAC9708",       &sigmatel_9708_ops},
-       {0x83847609, "SigmaTel STAC9721/23",    &sigmatel_9721_ops},
-       {0x83847644, "SigmaTel STAC9744/45",    &sigmatel_9744_ops},
-       {0x83847656, "SigmaTel STAC9756/57",    &sigmatel_9744_ops},
-       {0x83847684, "SigmaTel STAC9783/84?",   &null_ops},
-       {0x57454301, "Winbond 83971D",          &null_ops},
+       {0x41445303,   ~0, "Analog Devices AD1819",     &null_ops},
+       {0x41445340,   ~0, "Analog Devices AD1881",     &null_ops},
+       {0x41445348,   ~0, "Analog Devices AD1881A",    &null_ops},
+       {0x41445360,   ~0, "Analog Devices AD1885",     &default_ops},
+       {0x41445460,   ~0, "Analog Devices AD1885",     &default_ops},
+       {0x414B4D00,   ~0, "Asahi Kasei AK4540",        &null_ops},
+       {0x414B4D01,   ~0, "Asahi Kasei AK4542",        &null_ops},
+       {0x414B4D02,   ~0, "Asahi Kasei AK4543",        &null_ops},
+       /* ALC = Avance Logic, now Realtek, 0x414C43 is ALC and 0x414C47 ALG
*/
+       /* Note: 4 LSB are the revision 0 = rev A */
+       {0x414C4320, ~0xF, "ALC 100/P",         &null_ops},
+       {0x414C4710, ~0xF, "ALC 200/201/201A/P",        &null_ops},
+       {0x414C4720, ~0xF, "ALC 650",                   &null_ops},
+       {0x414C4730, ~0xF, "ALC 101",                   &null_ops},
+       {0x43525900,   ~0, "Cirrus Logic CS4297",       &default_ops},
+       {0x43525903,   ~0, "Cirrus Logic CS4297",       &default_ops},
+       {0x43525913,   ~0, "Cirrus Logic CS4297A rev A", &default_ops},
+       {0x43525914,   ~0, "Cirrus Logic CS4297A rev B", &default_ops},
+       {0x43525923,   ~0, "Cirrus Logic CS4298",       &null_ops},
+       {0x4352592B,   ~0, "Cirrus Logic CS4294",       &null_ops},
+       {0x4352592D,   ~0, "Cirrus Logic CS4294",       &null_ops},
+       {0x43525931,   ~0, "Cirrus Logic CS4299 rev A",
&crystal_digital_ops},
+       {0x43525933,   ~0, "Cirrus Logic CS4299 rev C",
&crystal_digital_ops},
+       {0x43525934,   ~0, "Cirrus Logic CS4299 rev D",
&crystal_digital_ops},
+       {0x45838308,   ~0, "ESS Allegro ES1988",        &null_ops},
+       {0x49434511,   ~0, "ICE1232",                   &null_ops}, /* I
hope --jk */
+       {0x4e534331,   ~0, "National Semiconductor LM4549", &null_ops},
+       {0x53494c22,   ~0, "Silicon Laboratory Si3036", &null_ops},
+       {0x53494c23,   ~0, "Silicon Laboratory Si3038", &null_ops},
+       {0x545200FF,   ~0, "TriTech TR?????",           &tritech_m_ops},
+       {0x54524102,   ~0, "TriTech TR28022",           &null_ops},
+       {0x54524103,   ~0, "TriTech TR28023",           &null_ops},
+       {0x54524106,   ~0, "TriTech TR28026",           &null_ops},
+       {0x54524108,   ~0, "TriTech TR28028",           &tritech_ops},
+       {0x54524123,   ~0, "TriTech TR A5",             &null_ops},
+       {0x574D4C00,   ~0, "Wolfson WM9704",            &wolfson_ops},
+       {0x574D4C03,   ~0, "Wolfson WM9703/9704",       &wolfson_ops},
+       {0x574D4C04,   ~0, "Wolfson WM9704 (quad)",     &wolfson_ops},
+       {0x83847600,   ~0, "SigmaTel STAC????", &null_ops},
+       {0x83847604,   ~0, "SigmaTel STAC9701/3/4/5", &null_ops},
+       {0x83847605,   ~0, "SigmaTel STAC9704", &null_ops},
+       {0x83847608,   ~0, "SigmaTel STAC9708", &sigmatel_9708_ops},
+       {0x83847609,   ~0, "SigmaTel STAC9721/23",      &sigmatel_9721_ops},

+       {0x83847644,   ~0, "SigmaTel STAC9744/45",      &sigmatel_9744_ops},

+       {0x83847656,   ~0, "SigmaTel STAC9756/57",      &sigmatel_9744_ops},

+       {0x83847684,   ~0, "SigmaTel STAC9783/84?",     &null_ops},
+       {0x57454301,   ~0, "Winbond 83971D",            &null_ops},
 };

 static const char *ac97_stereo_enhancements[] =
@@ -668,6 +677,7 @@
 {
        u16 id1, id2;
        u16 audio, modem;
+       u32 id;
        int i;

        /* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00
(reset) should
@@ -699,11 +709,19 @@

        id1 = codec->codec_read(codec, AC97_VENDOR_ID1);
        id2 = codec->codec_read(codec, AC97_VENDOR_ID2);
+       id = ((id1 << 16) | id2);
+#ifdef DEBUG
+       printk("Looking for codec id: 0x%08x\n", id);
+#endif
        for (i = 0; i < ARRAY_SIZE(ac97_codec_ids); i++) {
-               if (ac97_codec_ids[i].id == ((id1 << 16) | id2)) {
+               if ((ac97_codec_ids[i].id & ac97_codec_ids[i].mask) ==
+                       (id & ac97_codec_ids[i].mask)) {
                        codec->type = ac97_codec_ids[i].id;
                        codec->name = ac97_codec_ids[i].name;
                        codec->codec_ops = ac97_codec_ids[i].ops;
+#ifdef DEBUG
+                       printk("Found: %s\n",ac97_codec_ids[i].name);
+#endif
                        break;
                }
        }
<----------End of patch

Enabling the printk's I get:

Looking for codec id: 0x414c4326
Found: ALC 100/P

The motherboard is an ECS K7AMA and the lspci shows the ALi5451 stuff:
  Bus  0, device   3, function  0:
    Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI
South Bridge Audio (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0xd400 [0xd4ff].
      Non-prefetchable 32 bit memory at 0xdfffe000 [0xdfffefff].

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



