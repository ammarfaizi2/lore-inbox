Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSJaP0g>; Thu, 31 Oct 2002 10:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSJaPZr>; Thu, 31 Oct 2002 10:25:47 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:38820 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262580AbSJaPYT>; Thu, 31 Oct 2002 10:24:19 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 31 Oct 2002 17:31:32 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] tv tuner driver update
Message-ID: <20021031163132.GA17504@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the tv tuner module.  It makes the descriptions
more verbose and also has some minor bugfixes + cleanups.

  Gerd

--- linux-2.5.45/drivers/media/video/tuner.c	2002-10-31 14:04:49.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2002-10-31 14:20:28.000000000 +0100
@@ -101,10 +101,16 @@
 
 /* system switching for Philips FI1216MF MK2
    from datasheet "1996 Jul 09",
+    standard         BG     L      L'
+    picture carrier  38.90  38.90  33.95
+    colour	     34.47  34.37  38.38
+    sound 1          33.40  32.40  40.45
+    sound 2          33.16  -      -
+    NICAM            33.05  33.05  39.80
  */
 #define PHILIPS_MF_SET_BG	0x01 /* Bit 2 must be zero, Bit 3 is system output */
-#define PHILIPS_MF_SET_PAL_L	0x03
-#define PHILIPS_MF_SET_PAL_L2	0x02
+#define PHILIPS_MF_SET_PAL_L	0x03 // France
+#define PHILIPS_MF_SET_PAL_L2	0x02 // L'
 
 
 /* ---------------------------------------------------------------------- */
@@ -121,7 +127,9 @@
 	unsigned char VHF_H;
 	unsigned char UHF;
 	unsigned char config; 
-	unsigned short IFPCoff; /* 622.4=16*38.90 MHz PAL, 732=16*45.75 NTSC */
+	unsigned short IFPCoff; /* 622.4=16*38.90 MHz PAL, 
+				   732  =16*45.75 NTSCi, 
+				   940  =58.75 NTSC-Japan */
 };
 
 /*
@@ -132,16 +140,16 @@
 static struct tunertype tuners[] = {
         { "Temic PAL (4002 FH5)", TEMIC, PAL,
 	  16*140.25,16*463.25,0x02,0x04,0x01,0x8e,623},
-	{ "Philips PAL_I", Philips, PAL_I,
+	{ "Philips PAL_I (FI1246 and compatibles)", Philips, PAL_I,
 	  16*140.25,16*463.25,0xa0,0x90,0x30,0x8e,623},
-	{ "Philips NTSC", Philips, NTSC,
+	{ "Philips NTSC (FI1236 and compatibles)", Philips, NTSC,
 	  16*157.25,16*451.25,0xA0,0x90,0x30,0x8e,732},
-	{ "Philips SECAM", Philips, SECAM,
+	{ "Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF)", Philips, SECAM,
 	  16*168.25,16*447.25,0xA7,0x97,0x37,0x8e,623},
 
 	{ "NoTuner", NoTuner, NOTUNER,
 	  0,0,0x00,0x00,0x00,0x00,0x00},
-	{ "Philips PAL", Philips, PAL,
+	{ "Philips PAL_BG (FI1216 and compatibles)", Philips, PAL,
 	  16*168.25,16*447.25,0xA0,0x90,0x30,0x8e,623},
 	{ "Temic NTSC (4032 FY5)", TEMIC, NTSC,
 	  16*157.25,16*463.25,0x02,0x04,0x01,0x8e,732},
@@ -181,7 +189,7 @@
           16*158.00, 16*453.00, 0xa0,0x90,0x30,0x8e,732},
         { "Temic PAL/SECAM multi (4046 FM5)", TEMIC, PAL,
           16*169.00, 16*454.00, 0xa0,0x90,0x30,0x8e,623},
-        { "Philips PAL_DK", Philips, PAL,
+        { "Philips PAL_DK (FI1256 and compatibles)", Philips, PAL,
 	  16*170.00,16*450.00,0xa0,0x90,0x30,0x8e,623},
 
 	{ "Philips PAL/SECAM multi (FQ1216ME)", Philips, PAL,
@@ -200,7 +208,7 @@
 	{ "Temic PAL* auto + FM (4009 FN5)", TEMIC, PAL,
 	  16*141.00, 16*464.00, 0xa0,0x90,0x30,0x8e,623},
 	{ "SHARP NTSC_JP (2U5JF5540)", SHARP, NTSC, /* 940=16*58.75 NTSC@Japan */
-	  16*137.25,16*317.25,0x01,0x02,0x08,0x8e,940},
+	  16*137.25,16*317.25,0x01,0x02,0x08,0x8e,732 }, // Corrected to NTSC=732 (was:940)
 
 	{ "Samsung PAL TCPM9091PD27", Samsung, PAL,  /* from sourceforge v3tv */
           16*169,16*464,0xA0,0x90,0x30,0x8e,623},
@@ -215,8 +223,10 @@
           16*158.00, 16*453.00, 0xa0,0x90,0x30,0x8e,732},
         { "LG PAL (newer TAPC series)", LGINNOTEK, PAL,
           16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,623},
-	{ "Philips PAL/SECAM multi (FM1216ME)", Philips, PAL,
+	{ "Philips PAL/SECAM multi (FM1216ME MK3)", Philips, PAL,
 	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,623 },
+	{ "LG NTSC (newer TAPC series)", LGINNOTEK, NTSC,
+          16*170.00, 16*450.00, 0x01,0x02,0x08,0x8e,732},
 };
 #define TUNERS (sizeof(tuners)/sizeof(struct tunertype))
 
@@ -295,6 +305,13 @@
                 }
                 printk("\n ");
         }
+	// Look for MT2032 id:
+	// part= 0x04(MT2032), 0x06(MT2030), 0x07(MT2040)
+        if((buf[0x11] != 0x4d) || (buf[0x12] != 0x54) || (buf[0x13] != 0x04)) {
+                printk("not a MT2032.\n");
+                return 0;
+        }
+
 
         // Initialize Registers per spec.
         buf[1]=2; // Index to register 2
@@ -621,7 +638,7 @@
 
 	/* tv norm specific stuff for multi-norm tuners */
 	switch (t->type) {
-	case TUNER_PHILIPS_SECAM:
+	case TUNER_PHILIPS_SECAM: // FI1216MF
 		/* 0x01 -> ??? no change ??? */
 		/* 0x02 -> PAL BDGHI / SECAM L */
 		/* 0x04 -> ??? PAL others / SECAM others ??? */
@@ -751,7 +768,7 @@
         buffer[1] = div      & 0xff;
 	buffer[2] = tun->config;
 	switch (t->type) {
-	case TUNER_PHILIPS_FM1216ME:
+	case TUNER_PHILIPS_FM1216ME_MK3:
 		buffer[3] = 0x19;
 		break;
 	default:
@@ -857,12 +874,14 @@
 
 	/* --- configuration --- */
 	case TUNER_SET_TYPE:
-		if (t->type != -1)
+		if (t->type != -1) {
+			printk("tuner: type already set\n");
 			return 0;
+		}
 		if (*iarg < 0 || *iarg >= TUNERS)
 			return 0;
 		t->type = *iarg;
-		dprintk("tuner: type set to %d (%s)\n",
+		printk("tuner: type set to %d (%s)\n",
                         t->type,tuners[t->type].name);
 		strncpy(client->name, tuners[t->type].name, sizeof(client->name));
 		if (t->type == TUNER_MT2032)
@@ -965,7 +984,7 @@
 };
 static struct i2c_client client_template =
 {
-        name:   "(unset)",
+        name:   "(tuner unset)",
 	flags:  I2C_CLIENT_ALLOW_USE,
         driver: &driver,
 };
--- linux-2.5.45/drivers/media/video/tuner.h	2002-10-31 14:04:38.000000000 +0100
+++ linux/drivers/media/video/tuner.h	2002-10-31 14:20:28.000000000 +0100
@@ -62,7 +62,9 @@
 #define TUNER_TEMIC_4012FY5	35	/* 4012 FY5 (3X 0971, 1099)*/
 #define TUNER_TEMIC_4136FY5	36	/* 4136 FY5 (3X 7708, 7746)*/
 #define TUNER_LG_PAL_NEW_TAPC   37
-#define TUNER_PHILIPS_FM1216ME  38
+#define TUNER_PHILIPS_FM1216ME_MK3  38
+#define TUNER_LG_NTSC_NEW_TAPC   39
+
 
 
 
@@ -84,7 +86,9 @@
 
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
-#define TUNER_SET_RADIOFREQ          _IOW('t',3,int)    /* set radio freq */
-#define TUNER_SET_MODE               _IOW('t',4,int)    /* set tuner mode */
+#if 0 /* obsolete */
+# define TUNER_SET_RADIOFREQ         _IOW('t',3,int)    /* set radio freq */
+# define TUNER_SET_MODE              _IOW('t',4,int)    /* set tuner mode */
+#endif
 
 #endif

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
