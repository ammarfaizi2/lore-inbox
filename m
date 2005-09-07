Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVIGLwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVIGLwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 07:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVIGLwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 07:52:00 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:45975 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751164AbVIGLwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 07:52:00 -0400
Subject: [PATCH 2/2] V4L: tveeprom improved to support newer Hauppage cards
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-aU6lnVreTaz8yx/jAjP1"
Date: Wed, 07 Sep 2005 08:51:56 -0300
Message-Id: <1126093916.5784.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-8mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aU6lnVreTaz8yx/jAjP1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit




--=-aU6lnVreTaz8yx/jAjP1
Content-Disposition: attachment; filename=v4l_fixup_tveeprom.diff
Content-Type: text/x-patch; name=v4l_fixup_tveeprom.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

- tveeprom improved and updated to reflect newer Hauppage cards.
- CodingStyle fixes.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/bttv-cards.c      |    3 
 linux/drivers/media/video/bttv-driver.c     |    1 
 linux/drivers/media/video/cx88/cx88-cards.c |    2 
 linux/drivers/media/video/tveeprom.c        |  329 +++++++++++++-------
 linux/include/media/tveeprom.h              |    8 
 5 files changed, 239 insertions(+), 104 deletions(-)

diff -u /tmp/dst.29011 linux/drivers/media/video/bttv-driver.c
--- /tmp/dst.29011	2005-09-07 08:19:32.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-09-07 08:19:32.000000000 -0300
@@ -4079,6 +4079,7 @@ static int bttv_suspend(struct pci_dev *
 	struct bttv_buffer_set idle;
 	unsigned long flags;
 
+	dprintk("bttv%d: suspend %d\n", btv->c.nr, state.event);
 
 	/* stop dma + irqs */
 	spin_lock_irqsave(&btv->s_lock,flags);
diff -u /tmp/dst.29011 linux/drivers/media/video/bttv-cards.c
--- /tmp/dst.29011	2005-09-07 08:19:32.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-09-07 08:19:32.000000000 -0300
@@ -3062,7 +3062,7 @@ static void __devinit hauppauge_eeprom(s
 {
 	struct tveeprom tv;
 
-	tveeprom_hauppauge_analog(&tv, eeprom_data);
+	tveeprom_hauppauge_analog(&btv->i2c_client, &tv, eeprom_data);
 	btv->tuner_type = tv.tuner_type;
 	btv->has_radio  = tv.has_radio;
 }
@@ -4487,6 +4487,7 @@ void __devinit bttv_check_chipset(void)
 	}
 	if (UNSET != latency)
 		printk(KERN_INFO "bttv: pci latency fixup [%d]\n",latency);
+
 	while ((dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 				      PCI_DEVICE_ID_INTEL_82441, dev))) {
                 unsigned char b;
diff -u /tmp/dst.29011 linux/drivers/media/video/cx88/cx88-cards.c
--- /tmp/dst.29011	2005-09-07 08:19:32.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-09-07 08:19:32.000000000 -0300
@@ -945,7 +945,7 @@ static void hauppauge_eeprom(struct cx88
 {
 	struct tveeprom tv;
 
-	tveeprom_hauppauge_analog(&tv, eeprom_data);
+	tveeprom_hauppauge_analog(&core->i2c_client, &tv, eeprom_data);
 	core->tuner_type = tv.tuner_type;
 	core->has_radio  = tv.has_radio;
 }
diff -u /tmp/dst.29011 linux/include/media/tveeprom.h
--- /tmp/dst.29011	2005-09-07 08:19:33.000000000 -0300
+++ linux/include/media/tveeprom.h	2005-09-07 08:19:33.000000000 -0300
@@ -3,15 +3,19 @@
 
 struct tveeprom {
 	u32 has_radio;
+	u32 has_ir;     /* 0: no IR, 1: IR present, 2: unknown */
 
 	u32 tuner_type;
 	u32 tuner_formats;
 
+	u32 tuner2_type;
+	u32 tuner2_formats;
+
 	u32 digitizer;
 	u32 digitizer_formats;
 
 	u32 audio_processor;
-	/* a_p_fmts? */
+	u32 decoder_processor;
 
 	u32 model;
 	u32 revision;
@@ -19,7 +23,7 @@ struct tveeprom {
 	char rev_str[5];
 };
 
-void tveeprom_hauppauge_analog(struct tveeprom *tvee,
+void tveeprom_hauppauge_analog(struct i2c_client *c, struct tveeprom *tvee,
 			       unsigned char *eeprom_data);
 
 int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len);
diff -u /tmp/dst.29011 linux/drivers/media/video/tveeprom.c
--- /tmp/dst.29011	2005-09-07 08:19:33.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-09-07 08:19:33.000000000 -0300
@@ -47,18 +47,21 @@ MODULE_LICENSE("GPL");
 
 static int debug = 0;
 module_param(debug, int, 0644);
-MODULE_PARM_DESC(debug, "Debug level (0-2)");
+MODULE_PARM_DESC(debug, "Debug level (0-1)");
 
 #define STRM(array,i) (i < sizeof(array)/sizeof(char*) ? array[i] : "unknown")
 
-#define dprintk(num, args...) \
-	do { \
-		if (debug >= num) \
-			printk(KERN_INFO "tveeprom: " args); \
-	} while (0)
+#define tveeprom_info(fmt, arg...) do {\
+	printk(KERN_INFO "tveeprom %d-%04x: " fmt, \
+                        c->adapter->nr, c->addr, ## arg); } while (0)
+#define tveeprom_warn(fmt, arg...) do {\
+	printk(KERN_WARNING "tveeprom %d-%04x: " fmt, \
+                        c->adapter->nr, c->addr, ## arg); } while (0)
+#define tveeprom_dbg(fmt, arg...) do {\
+	if (debug) \
+                printk(KERN_INFO "tveeprom %d-%04x: " fmt, \
+                        c->adapter->nr, c->addr, ## arg); } while (0)
 
-#define TVEEPROM_KERN_ERR(args...) printk(KERN_ERR "tveeprom: " args);
-#define TVEEPROM_KERN_INFO(args...) printk(KERN_INFO "tveeprom: " args);
 
 /* ----------------------------------------------------------------------- */
 /* some hauppauge specific stuff                                           */
@@ -70,14 +73,14 @@ static struct HAUPPAUGE_TUNER_FMT
 }
 hauppauge_tuner_fmt[] =
 {
-	{ 0x00000000, "unknown1" },
-	{ 0x00000000, "unknown2" },
-	{ 0x00000007, "PAL(B/G)" },
-	{ 0x00001000, "NTSC(M)" },
-	{ 0x00000010, "PAL(I)" },
-	{ 0x00400000, "SECAM(L/L´)" },
-	{ 0x00000e00, "PAL(D/K)" },
-	{ 0x03000000, "ATSC Digital" },
+	{ 0x00000000, " unknown1" },
+	{ 0x00000000, " unknown2" },
+	{ 0x00000007, " PAL(B/G)" },
+	{ 0x00001000, " NTSC(M)" },
+	{ 0x00000010, " PAL(I)" },
+	{ 0x00400000, " SECAM(L/L')" },
+	{ 0x00000e00, " PAL(D/K)" },
+	{ 0x03000000, " ATSC Digital" },
 };
 
 /* This is the full list of possible tuners. Many thanks to Hauppauge for
@@ -203,20 +206,47 @@ hauppauge_tuner[] =
         { TUNER_TCL_2002N,     "TCL 2002N 5H"},
 	/* 100-103 */
 	{ TUNER_ABSENT,        "Unspecified"},
-        { TUNER_ABSENT,        "Unspecified"},
+        { TUNER_TEA5767,       "Philips TEA5767HN FM Radio"},
         { TUNER_ABSENT,        "Unspecified"},
         { TUNER_PHILIPS_FM1236_MK3, "TCL MFNM05 4"},
 };
 
-static char *sndtype[] = {
-	"None", "TEA6300", "TEA6320", "TDA9850", "MSP3400C", "MSP3410D",
-	"MSP3415", "MSP3430", "MSP3438", "CS5331", "MSP3435", "MSP3440",
-	"MSP3445", "MSP3411", "MSP3416", "MSP3425",
-
-	"Type 0x10","Type 0x11","Type 0x12","Type 0x13",
-	"Type 0x14","Type 0x15","Type 0x16","Type 0x17",
-	"Type 0x18","MSP4418","Type 0x1a","MSP4448",
-	"Type 0x1c","Type 0x1d","Type 0x1e","Type 0x1f",
+/* This list is supplied by Hauppauge. Thanks! */
+static const char *audioIC[] = {
+        /* 0-4 */
+        "None", "TEA6300", "TEA6320", "TDA9850", "MSP3400C",
+        /* 5-9 */
+        "MSP3410D", "MSP3415", "MSP3430", "MSP3438", "CS5331",
+        /* 10-14 */
+        "MSP3435", "MSP3440", "MSP3445", "MSP3411", "MSP3416",
+        /* 15-19 */
+        "MSP3425", "MSP3451", "MSP3418", "Type 0x12", "OKI7716",
+        /* 20-24 */
+        "MSP4410", "MSP4420", "MSP4440", "MSP4450", "MSP4408",
+        /* 25-29 */
+        "MSP4418", "MSP4428", "MSP4448", "MSP4458", "Type 0x1d",
+        /* 30-34 */
+        "CX880", "CX881", "CX883", "CX882", "CX25840",
+        /* 35-38 */
+        "CX25841", "CX25842", "CX25843", "CX23418",
+};
+
+/* This list is supplied by Hauppauge. Thanks! */
+static const char *decoderIC[] = {
+        /* 0-4 */
+        "None", "BT815", "BT817", "BT819", "BT815A",
+        /* 5-9 */
+        "BT817A", "BT819A", "BT827", "BT829", "BT848",
+        /* 10-14 */
+        "BT848A", "BT849A", "BT829A", "BT827A", "BT878",
+        /* 15-19 */
+        "BT879", "BT880", "VPX3226E", "SAA7114", "SAA7115",
+        /* 20-24 */
+        "CX880", "CX881", "CX883", "SAA7111", "SAA7113",
+        /* 25-29 */
+        "CX882", "TVP5150A", "CX25840", "CX25841", "CX25842",
+        /* 30-31 */
+        "CX25843", "CX23418",
 };
 
 static int hasRadioTuner(int tunerType)
@@ -257,7 +287,8 @@ static int hasRadioTuner(int tunerType)
         return 0;
 }
 
-void tveeprom_hauppauge_analog(struct tveeprom *tvee, unsigned char *eeprom_data)
+void tveeprom_hauppauge_analog(struct i2c_client *c, struct tveeprom *tvee,
+                                unsigned char *eeprom_data)
 {
 	/* ----------------------------------------------
 	** The hauppauge eeprom format is tagged
@@ -267,10 +298,11 @@ void tveeprom_hauppauge_analog(struct tv
 	** if packet[0] & f8 == f8, then EOD and packet[1] == checksum
 	**
 	** In our (ivtv) case we're interested in the following:
-	** tuner type: tag [00].05 or [0a].01 (index into hauppauge_tuner)
-	** tuner fmts: tag [00].04 or [0a].00 (bitmask index into hauppauge_tuner_fmt)
-	** radio:      tag [00].{last} or [0e].00  (bitmask.  bit2=FM)
-	** audio proc: tag [02].01 or [05].00 (lower nibble indexes lut?)
+	** tuner type:   tag [00].05 or [0a].01 (index into hauppauge_tuner)
+	** tuner fmts:   tag [00].04 or [0a].00 (bitmask index into hauppauge_tuner_fmt)
+	** radio:        tag [00].{last} or [0e].00  (bitmask.  bit2=FM)
+	** audio proc:   tag [02].01 or [05].00 (mask with 0x7f)
+	** decoder proc: tag [09].01)
 
 	** Fun info:
 	** model:      tag [00].07-08 or [06].00-01
@@ -280,20 +312,24 @@ void tveeprom_hauppauge_analog(struct tv
 	** # of inputs/outputs ???
 	*/
 
-	int i, j, len, done, beenhere, tag, tuner = 0, t_format = 0;
-	char *t_name = NULL, *t_fmt_name = NULL;
+	int i, j, len, done, beenhere, tag;
 
-	dprintk(1, "%s\n",__FUNCTION__);
-	tvee->revision = done = len = beenhere = 0;
-	for (i = 0; !done && i < 256; i += len) {
-		dprintk(2, "processing pos = %02x (%02x, %02x)\n",
-			i, eeprom_data[i], eeprom_data[i + 1]);
+        int tuner1 = 0, t_format1 = 0;
+	char *t_name1 = NULL;
+        const char *t_fmt_name1[8] = { " none", "", "", "", "", "", "", "" };
+
+        int tuner2 = 0, t_format2 = 0;
+	char *t_name2 = NULL;
+        const char *t_fmt_name2[8] = { " none", "", "", "", "", "", "", "" };
 
+        memset(tvee, 0, sizeof(*tvee));
+	done = len = beenhere = 0;
+	for (i = 0; !done && i < 256; i += len) {
 		if (eeprom_data[i] == 0x84) {
 			len = eeprom_data[i + 1] + (eeprom_data[i + 2] << 8);
-			i+=3;
+			i += 3;
 		} else if ((eeprom_data[i] & 0xf0) == 0x70) {
-			if ((eeprom_data[i] & 0x08)) {
+			if (eeprom_data[i] & 0x08) {
 				/* verify checksum! */
 				done = 1;
 				break;
@@ -301,24 +337,30 @@ void tveeprom_hauppauge_analog(struct tv
 			len = eeprom_data[i] & 0x07;
 			++i;
 		} else {
-			TVEEPROM_KERN_ERR("Encountered bad packet header [%02x]. "
+			tveeprom_warn("Encountered bad packet header [%02x]. "
 				   "Corrupt or not a Hauppauge eeprom.\n", eeprom_data[i]);
 			return;
 		}
 
-		dprintk(1, "%3d [%02x] ", len, eeprom_data[i]);
-		for(j = 1; j < len; j++) {
-			dprintk(1, "%02x ", eeprom_data[i + j]);
-		}
-		dprintk(1, "\n");
+                if (debug) {
+                        tveeprom_info("Tag [%02x] + %d bytes:", eeprom_data[i], len - 1);
+                        for(j = 1; j < len; j++) {
+                                printk(" %02x", eeprom_data[i + j]);
+                        }
+                        printk("\n");
+                }
 
 		/* process by tag */
 		tag = eeprom_data[i];
 		switch (tag) {
 		case 0x00:
-			tuner = eeprom_data[i+6];
-			t_format = eeprom_data[i+5];
+                        /* tag: 'Comprehensive' */
+			tuner1 = eeprom_data[i+6];
+			t_format1 = eeprom_data[i+5];
 			tvee->has_radio = eeprom_data[i+len-1];
+                        /* old style tag, don't know how to detect
+                           IR presence, mark as unknown. */
+			tvee->has_ir = 2;
 			tvee->model =
 				eeprom_data[i+8] +
 				(eeprom_data[i+9] << 8);
@@ -326,25 +368,43 @@ void tveeprom_hauppauge_analog(struct tv
 				(eeprom_data[i+11] << 8) +
 				(eeprom_data[i+12] << 16);
 			break;
+
 		case 0x01:
+                        /* tag: 'SerialID' */
 			tvee->serial_number =
 				eeprom_data[i+6] +
 				(eeprom_data[i+7] << 8) +
 				(eeprom_data[i+8] << 16);
 			break;
+
 		case 0x02:
-			tvee->audio_processor = eeprom_data[i+2] & 0x0f;
+                        /* tag 'AudioInfo'
+                           Note mask with 0x7F, high bit used on some older models
+                           to indicate 4052 mux was removed in favor of using MSP
+                           inputs directly. */
+			tvee->audio_processor = eeprom_data[i+2] & 0x7f;
 			break;
+
+                /* case 0x03: tag 'EEInfo' */
+
 		case 0x04:
+                        /* tag 'SerialID2' */
 			tvee->serial_number =
 				eeprom_data[i+5] +
 				(eeprom_data[i+6] << 8) +
 				(eeprom_data[i+7] << 16);
 			break;
+
 		case 0x05:
-			tvee->audio_processor = eeprom_data[i+1] & 0x0f;
+                        /* tag 'Audio2'
+                           Note mask with 0x7F, high bit used on some older models
+                           to indicate 4052 mux was removed in favor of using MSP
+                           inputs directly. */
+			tvee->audio_processor = eeprom_data[i+1] & 0x7f;
 			break;
+
 		case 0x06:
+                        /* tag 'ModelRev' */
 			tvee->model =
 				eeprom_data[i+1] +
 				(eeprom_data[i+2] << 8);
@@ -352,27 +412,66 @@ void tveeprom_hauppauge_analog(struct tv
 				(eeprom_data[i+6] << 8) +
 				(eeprom_data[i+7] << 16);
 			break;
+
+		case 0x07:
+                        /* tag 'Details': according to Hauppauge not interesting
+                           on any PCI-era or later boards. */
+			break;
+
+                /* there is no tag 0x08 defined */
+
+		case 0x09:
+                        /* tag 'Video' */
+			tvee->decoder_processor = eeprom_data[i + 1];
+			break;
+
 		case 0x0a:
-			if(beenhere == 0) {
-				tuner = eeprom_data[i+2];
-				t_format = eeprom_data[i+1];
+                        /* tag 'Tuner' */
+			if (beenhere == 0) {
+				tuner1 = eeprom_data[i+2];
+				t_format1 = eeprom_data[i+1];
 				beenhere = 1;
-				break;
 			} else {
-				break;
-			}
+                                /* a second (radio) tuner may be present */
+				tuner2 = eeprom_data[i+2];
+				t_format2 = eeprom_data[i+1];
+                                if (t_format2 == 0) {  /* not a TV tuner? */
+                                        tvee->has_radio = 1; /* must be radio */
+                                }
+                        }
+			break;
+
+                case 0x0b:
+                        /* tag 'Inputs': according to Hauppauge this is specific
+                           to each driver family, so no good assumptions can be
+                           made. */
+                        break;
+
+                /* case 0x0c: tag 'Balun' */
+                /* case 0x0d: tag 'Teletext' */
+
 		case 0x0e:
+                        /* tag: 'Radio' */
 			tvee->has_radio = eeprom_data[i+1];
 			break;
+
+                case 0x0f:
+                        /* tag 'IRInfo' */
+                        tvee->has_ir = eeprom_data[i+1];
+                        break;
+
+                /* case 0x10: tag 'VBIInfo' */
+                /* case 0x11: tag 'QCInfo' */
+                /* case 0x12: tag 'InfoBits' */
+
 		default:
-			dprintk(1, "Not sure what to do with tag [%02x]\n", tag);
+			tveeprom_dbg("Not sure what to do with tag [%02x]\n", tag);
 			/* dump the rest of the packet? */
 		}
-
 	}
 
 	if (!done) {
-		TVEEPROM_KERN_ERR("Ran out of data!\n");
+		tveeprom_warn("Ran out of data!\n");
 		return;
 	}
 
@@ -384,47 +483,72 @@ void tveeprom_hauppauge_analog(struct tv
 		tvee->rev_str[4] = 0;
 	}
 
-        if (hasRadioTuner(tuner) && !tvee->has_radio) {
-	    TVEEPROM_KERN_INFO("The eeprom says no radio is present, but the tuner type\n");
-	    TVEEPROM_KERN_INFO("indicates otherwise. I will assume that radio is present.\n");
+        if (hasRadioTuner(tuner1) && !tvee->has_radio) {
+	    tveeprom_info("The eeprom says no radio is present, but the tuner type\n");
+	    tveeprom_info("indicates otherwise. I will assume that radio is present.\n");
             tvee->has_radio = 1;
         }
 
-	if (tuner < sizeof(hauppauge_tuner)/sizeof(struct HAUPPAUGE_TUNER)) {
-		tvee->tuner_type = hauppauge_tuner[tuner].id;
-		t_name = hauppauge_tuner[tuner].name;
+	if (tuner1 < sizeof(hauppauge_tuner)/sizeof(struct HAUPPAUGE_TUNER)) {
+		tvee->tuner_type = hauppauge_tuner[tuner1].id;
+		t_name1 = hauppauge_tuner[tuner1].name;
+	} else {
+		t_name1 = "unknown";
+	}
+
+	if (tuner2 < sizeof(hauppauge_tuner)/sizeof(struct HAUPPAUGE_TUNER)) {
+		tvee->tuner2_type = hauppauge_tuner[tuner2].id;
+		t_name2 = hauppauge_tuner[tuner2].name;
 	} else {
-		t_name = "<unknown>";
+		t_name2 = "unknown";
 	}
 
 	tvee->tuner_formats = 0;
-	t_fmt_name = "<none>";
-	for (i = 0; i < 8; i++) {
-		if (t_format & (1<<i)) {
+	tvee->tuner2_formats = 0;
+	for (i = j = 0; i < 8; i++) {
+		if (t_format1 & (1 << i)) {
 			tvee->tuner_formats |= hauppauge_tuner_fmt[i].id;
-			/* yuck */
-			t_fmt_name = hauppauge_tuner_fmt[i].name;
+			t_fmt_name1[j++] = hauppauge_tuner_fmt[i].name;
 		}
+                if (t_format2 & (1 << i)) {
+                        tvee->tuner2_formats |= hauppauge_tuner_fmt[i].id;
+                        t_fmt_name2[j++] = hauppauge_tuner_fmt[i].name;
+                }
 	}
 
-
-	TVEEPROM_KERN_INFO("Hauppauge: model = %d, rev = %s, serial# = %d\n",
-		   tvee->model,
-		   tvee->rev_str,
-		   tvee->serial_number);
-	TVEEPROM_KERN_INFO("tuner = %s (idx = %d, type = %d)\n",
-		   t_name,
-		   tuner,
-		   tvee->tuner_type);
-	TVEEPROM_KERN_INFO("tuner fmt = %s (eeprom = 0x%02x, v4l2 = 0x%08x)\n",
-		   t_fmt_name,
-		   t_format,
-		   tvee->tuner_formats);
-
-	TVEEPROM_KERN_INFO("audio_processor = %s (type = %d)\n",
-		   STRM(sndtype,tvee->audio_processor),
+	tveeprom_info("Hauppauge model %d, rev %s, serial# %d\n",
+		   tvee->model, tvee->rev_str, tvee->serial_number);
+	tveeprom_info("tuner model is %s (idx %d, type %d)\n",
+		   t_name1, tuner1, tvee->tuner_type);
+	tveeprom_info("TV standards%s%s%s%s%s%s%s%s (eeprom 0x%02x)\n",
+		   t_fmt_name1[0], t_fmt_name1[1], t_fmt_name1[2], t_fmt_name1[3],
+		   t_fmt_name1[4], t_fmt_name1[5], t_fmt_name1[6], t_fmt_name1[7],
+                   t_format1);
+        if (tuner2) {
+                tveeprom_info("second tuner model is %s (idx %d, type %d)\n",
+                           t_name2, tuner2, tvee->tuner2_type);
+        }
+        if (t_format2) {
+                tveeprom_info("TV standards%s%s%s%s%s%s%s%s (eeprom 0x%02x)\n",
+                           t_fmt_name2[0], t_fmt_name2[1], t_fmt_name2[2], t_fmt_name2[3],
+                           t_fmt_name2[4], t_fmt_name2[5], t_fmt_name2[6], t_fmt_name2[7],
+                           t_format2);
+        }
+	tveeprom_info("audio processor is %s (idx %d)\n",
+		   STRM(audioIC, tvee->audio_processor),
 		   tvee->audio_processor);
-
+        if (tvee->decoder_processor) {
+                tveeprom_info("decoder processor is %s (idx %d)\n",
+                           STRM(decoderIC, tvee->decoder_processor),
+                           tvee->decoder_processor);
+        }
+        if (tvee->has_ir == 2)
+                tveeprom_info("has %sradio\n",
+                                tvee->has_radio ? "" : "no ");
+        else
+                tveeprom_info("has %sradio, has %sIR remote\n",
+                                tvee->has_radio ? "" : "no ",
+                                tvee->has_ir ? "" : "no ");
 }
 EXPORT_SYMBOL(tveeprom_hauppauge_analog);
 
@@ -436,23 +560,31 @@ int tveeprom_read(struct i2c_client *c, 
 	unsigned char buf;
 	int err;
 
-	dprintk(1, "%s\n",__FUNCTION__);
 	buf = 0;
-	if (1 != (err = i2c_master_send(c,&buf,1))) {
-		printk(KERN_INFO "tveeprom(%s): Huh, no eeprom present (err=%d)?\n",
-		       c->name,err);
+	if (1 != (err = i2c_master_send(c, &buf, 1))) {
+		tveeprom_info("Huh, no eeprom present (err=%d)?\n", err);
 		return -1;
 	}
-	if (len != (err = i2c_master_recv(c,eedata,len))) {
-		printk(KERN_WARNING "tveeprom(%s): i2c eeprom read error (err=%d)\n",
-		       c->name,err);
+	if (len != (err = i2c_master_recv(c, eedata, len))) {
+		tveeprom_warn("i2c eeprom read error (err=%d)\n", err);
 		return -1;
 	}
+        if (debug) {
+                int i;
+
+                tveeprom_info("full 256-byte eeprom dump:\n");
+                for (i = 0; i < len; i++) {
+                        if (0 == (i % 16))
+                                tveeprom_info("%02x:", i);
+                        printk(" %02x", eedata[i]);
+                        if (15 == (i % 16))
+                                printk("\n");
+                }
+        }
 	return 0;
 }
 EXPORT_SYMBOL(tveeprom_read);
 
-
 /* ----------------------------------------------------------------------- */
 /* needed for ivtv.sf.net at the moment.  Should go away in the long       */
 /* run, just call the exported tveeprom_* directly, there is no point in   */
@@ -485,7 +617,7 @@ tveeprom_command(struct i2c_client *clie
 		buf = kmalloc(256,GFP_KERNEL);
 		memset(buf,0,256);
 		tveeprom_read(client,buf,256);
-		tveeprom_hauppauge_analog(&eeprom,buf);
+		tveeprom_hauppauge_analog(client, &eeprom,buf);
 		kfree(buf);
 		eeprom_props[0] = eeprom.tuner_type;
 		eeprom_props[1] = eeprom.tuner_formats;
@@ -506,8 +638,6 @@ tveeprom_detect_client(struct i2c_adapte
 {
 	struct i2c_client *client;
 
-	dprintk(1,"%s: id 0x%x @ 0x%x\n",__FUNCTION__,
-	       adapter->id, address << 1);
 	client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (NULL == client)
 		return -ENOMEM;
@@ -524,7 +654,6 @@ tveeprom_detect_client(struct i2c_adapte
 static int
 tveeprom_attach_adapter (struct i2c_adapter *adapter)
 {
-	dprintk(1,"%s: id 0x%x\n",__FUNCTION__,adapter->id);
 	if (adapter->id != I2C_HW_B_BT848)
 		return 0;
 	return i2c_probe(adapter, &addr_data, tveeprom_detect_client);

--=-aU6lnVreTaz8yx/jAjP1--

