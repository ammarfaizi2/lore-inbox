Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRHKFQc>; Sat, 11 Aug 2001 01:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270725AbRHKFQX>; Sat, 11 Aug 2001 01:16:23 -0400
Received: from po4.glue.umd.edu ([128.8.10.124]:38060 "EHLO po4.glue.umd.edu")
	by vger.kernel.org with ESMTP id <S270724AbRHKFQI>;
	Sat, 11 Aug 2001 01:16:08 -0400
Date: Sat, 11 Aug 2001 01:15:49 -0400 (EDT)
From: Roy Katz <katz@Glue.umd.edu>
To: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        rsousa@grad.physics.sunysb.edu, emu10k1-devel@opensource.creative.com,
        oryn@fsck.tv
Subject: [PATCH]  Enable Bass, Treble and Digital controls for sblive
Message-ID: <Pine.GSO.4.21.0108110056080.28900-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm sending this patch because I'm tired of patching the kernel source
every time I upgrade my kernel.  'Oryn' (John Westgate?) at oryn@fsck.tv
wrote it and sent it to me.  It's a very simple patch; it (re-)enables the
Bass, Treble, digital, and surround sound controls on the Creative Labs
Soundblaster Live!.  I'd like to see this included in the next kernel.  
My apologies if this has already been taken care of (I am on 2.4.7 and
haven't yet tried 2.4.8).


Thanks,
Roey Katz
katz@wam.umd.edu

-----------------------------------------

diff -u -r linux/drivers/sound/emu10k1/main.c linux/drivers/sound/emu10k1/main.c
--- linux/drivers/sound/emu10k1/main.c	Thu Sep 21 21:25:09 2000
+++ linux/drivers/sound/emu10k1/main.c	Tue Feb 13 17:20:21 2001
@@ -9,7 +9,7 @@
  *     ----                 ------          ------------------
  *     October 20, 1999     Bertrand Lee    base code release
  *     November 2, 1999     Alan Cox        cleaned up stuff
- *
+ *     February 4, 2001    Jon Westgate    fixed sp/dif recording
  **********************************************************************
  *
  *     This program is free software; you can redistribute it and/or
@@ -162,14 +162,14 @@
 		SOUND_MIXER_LINE3, 0x3232}, {
 		SOUND_MIXER_DIGITAL1, 0x6464}, {
 		SOUND_MIXER_DIGITAL2, 0x6464}, {
+		SOUND_MIXER_DIGITAL3, 0x6464}, {
 		SOUND_MIXER_PCM, 0x6464}, {
 		SOUND_MIXER_RECLEV, 0x0404}, {
 		SOUND_MIXER_TREBLE, 0x3232}, {
 		SOUND_MIXER_BASS, 0x3232}, {
 		SOUND_MIXER_LINE2, 0x4b4b}};
 
-	int initdig[] = { 0, 1, 2, 3, 6, 7, 18, 19, 20, 21, 24, 25, 72, 73, 74, 75, 78, 79,
-		94, 95
+	int initdig[] = { 0, 1, 2, 3, 6, 7, 10, 11, 18, 19, 20, 21, 24, 25, 28, 29, 36, 37, 38, 39, 42, 43, 46, 47, 54, 55, 56, 57, 60, 61, 64, 65,  72, 73, 74, 75, 78, 79, 82, 83, 94, 95, 96, 97, 100, 101
 	};
 
 	for (count = 0; count < sizeof(card->digmix) / sizeof(card->digmix[0]); count++) {
@@ -296,9 +296,7 @@
 static void __devinit fx_init(struct emu10k1_card *card)
 {
 	int i, j, k;
-#ifdef TONE_CONTROL
 	int l;
-#endif	
 	u32 pc = 0;
 
 	for (i = 0; i < 512; i++)
@@ -327,7 +325,6 @@
 			OP(0, 0x102, 0x102, 0x11a + k, 0x16 + j);
 			OP(0, 0x102, 0x102, 0x11c + k, 0x18 + j);
 			OP(0, 0x102, 0x102, 0x11e + k, 0x1a + j);
-#ifdef TONE_CONTROL
 			OP(0, 0x102, 0x102, 0x120 + k, 0x1c + j);
 
 			k = 0x1a0 + i * 8 + j * 4;
@@ -350,9 +347,6 @@
 				OP(4, 0x20 + (i * 2) + j, 0x40, l + 2, 0x50);	/* FIXME: Is this really needed? */
 			else
 				OP(6, 0x20 + (i * 2) + j, l + 2, 0x40, 0x40);
-#else
-			OP(0, 0x20 + (i * 2) + j, 0x102, 0x120 + k, 0x1c + j);
-#endif
 		}
 	}
 	sblive_writeptr(card, DBG, 0, 0);
diff -u -r linux/drivers/sound/emu10k1/mixer.c linux/drivers/sound/emu10k1/mixer.c
--- linux/drivers/sound/emu10k1/mixer.c	Thu Sep 21 21:25:09 2000
+++ linux/drivers/sound/emu10k1/mixer.c	Tue Feb 13 17:20:56 2001
@@ -12,7 +12,7 @@
  *     ----                 ------          ------------------
  *     October 20, 1999     Bertrand Lee    base code release
  *     November 2, 1999     Alan Cox        cleaned up stuff
- *
+ *     February 13, 2001     Jon Westgate    Fixed SP/DIF input
  **********************************************************************
  *
  *     This program is free software; you can redistribute it and/or
@@ -69,10 +69,8 @@
 	SOUND_MASK_VOLUME,
 	SOUND_MASK_OGAIN,	/* Used to be PHONEOUT */
 	SOUND_MASK_PHONEIN,
-#ifdef TONE_CONTROL
 	SOUND_MASK_TREBLE,
 	SOUND_MASK_BASS,
-#endif
 };
 
 static const unsigned char volreg[SOUND_MIXER_NRDEVICES] = {
@@ -121,10 +119,8 @@
 	switch (ch) {
 	case SOUND_MIXER_PCM:
 	case SOUND_MIXER_VOLUME:
-#ifdef TONE_CONTROL
 	case SOUND_MIXER_TREBLE:
         case SOUND_MIXER_BASS:
-#endif
                 return put_user(0x0000, (int *) arg);
 	default:
 		break;
@@ -196,10 +192,10 @@
 	[SOUND_MIXER_LINE2] = 16,
 	[SOUND_MIXER_LINE3] = 17,
 	[SOUND_MIXER_DIGITAL1] = 18,
-	[SOUND_MIXER_DIGITAL2] = 19
+	[SOUND_MIXER_DIGITAL2] = 19,
+	[SOUND_MIXER_DIGITAL3] = 20
 };
 
-#ifdef TONE_CONTROL
 
 static const u32 bass_table[41][5] = {
 	{ 0x3e4f844f, 0x84ed4cc3, 0x3cc69927, 0x7b03553a, 0xc4da8486 },
@@ -313,7 +309,6 @@
 	}
 }
 
-#endif
 
 static const u32 db_table[101] = {
 	0x00000000, 0x01571f82, 0x01674b41, 0x01783a1b, 0x0189f540,
@@ -364,7 +359,7 @@
 
 static void update_digital(struct emu10k1_card *card)
 {
-	int i, k, l1, r1, l2, r2, l3, r3, l4, r4;
+	int i, k, l1, r1, l2, r2, l3, r3, l4, r4, l5, r5;
 	u64 j;
 
 	i = card->arrwVol[volidx[SOUND_MIXER_VOLUME]];
@@ -382,6 +377,10 @@
 	l4 = i & 0xff;
 	r4 = (i >> 8) & 0xff;
 
+	i = card->arrwVol[volidx[SOUND_MIXER_DIGITAL3]];
+        l5 = i & 0xff;
+        r5 = (i >> 8) & 0xff;
+	
 	i = (r1 * r2) / 50;
 	if (r2 > 50)
 		r2 = 2 * r1 - i;
@@ -404,6 +403,8 @@
 				j = (i & 1) ? ((u64) db_table[r1] * (u64) db_table[r3]) : ((u64) db_table[l1] * (u64) db_table[l3]);
 			else if ((i == 6) || (i == 7) || (i == 24) || (i == 25))
 				j = (i & 1) ? ((u64) db_table[r1] * (u64) db_table[r4]) : ((u64) db_table[l1] * (u64) db_table[l4]);
+                        else if ((i == 10) || (i == 11))
+                                j = (i & 1) ? ((u64) db_table[r1] * (u64) db_table[r5]) : ((u64) db_table[l1] * (u64) db_table[l5]);
 			else
 				j = ((i & 1) ? db_table[r1] : db_table[l1]) << 31;
 			card->digmix[i] = j >> 31;
@@ -417,6 +418,8 @@
 				j = (i & 1) ? ((u64) db_table[r2] * (u64) db_table[r3]) : ((u64) db_table[l2] * (u64) db_table[l3]);
 			else if ((i == 78) || (i == 79))
 				j = (i & 1) ? ((u64) db_table[r2] * (u64) db_table[r4]) : ((u64) db_table[l2] * (u64) db_table[l4]);
+                        else if ((i == 82) || (i == 83))
+                                j = (i & 1) ? ((u64) db_table[r2] * (u64) db_table[r5]) : ((u64) db_table[l2] * (u64) db_table[l5]);
 			else
 				j = ((i & 1) ? db_table[r2] : db_table[l2]) << 31;
 			card->digmix[i] = j >> 31;
@@ -424,7 +427,7 @@
 		}
 	}
 
-	for (i = 36; i <= 90; i += 18) {
+	for (i = 18; i <= 90; i += 18) {
 		if (i != 72) {
 			for (k = 0; k < 4; k++)
 				if (card->digmix[i + k] != DM_MUTE) {
@@ -438,6 +441,15 @@
 			if (card->digmix[i + 7] != DM_MUTE) {
 				card->digmix[i + 7] = db_table[r4];
 				sblive_writeptr(card, FXGPREGBASE + 0x10 + i + 7, 0, card->digmix[i + 7]);
+                        }
+                        if (card->digmix[i + 10] != DM_MUTE) {
+                                card->digmix[i + 10] = db_table[l5];
+                                sblive_writeptr(card, FXGPREGBASE + 0x10 + i + 10, 0, card->digmix[i + 10]);
+                        }
+                        if (card->digmix[i + 11] != DM_MUTE) {
+                                card->digmix[i + 11] = db_table[r5];
+                                sblive_writeptr(card, FXGPREGBASE + 0x10 + i + 11, 0, card->digmix[i + 11]);
+
 			}
 		}
 	}
@@ -544,7 +556,6 @@
 		else
 			update_digital(card);
 		return 0;
-#ifdef TONE_CONTROL
 	case SOUND_MIXER_TREBLE:
                 DPF(4, "SOUND_MIXER_TREBLE:\n");
                 set_treble(card, l1, r1);
@@ -554,7 +565,6 @@
                 DPF(4, "SOUND_MIXER_BASS:\n");
                 set_bass(card, l1, r1);
 		return 0;
-#endif
 	default:
 		break;
 	}
@@ -565,8 +575,9 @@
 
 	switch (ch) {
 	case SOUND_MIXER_DIGITAL1:
+        case SOUND_MIXER_DIGITAL3:
 	case SOUND_MIXER_LINE3:
-		DPD(4, "SOUND_MIXER_%s:\n", (ch == SOUND_MIXER_DIGITAL1) ? "DIGITAL1" : "LINE3");
+		DPD(4, "SOUND_MIXER_%s:\n", (ch == SOUND_MIXER_DIGITAL1) ? "DIGITAL1" : (ch == SOUND_MIXER_DIGITAL3) ? "DIGITAL3" : "LINE3");
 		update_digital(card);
 		return 0;
 	case SOUND_MIXER_DIGITAL2:
@@ -911,16 +922,9 @@
 			case SOUND_MIXER_DEVMASK:       /* Arg contains a bit for each supported device */
                         DPF(4, "SOUND_MIXER_READ_DEVMASK\n");
 			if (card->isaps)
-#ifdef TONE_CONTROL
 				return put_user(SOUND_MASK_PCM | SOUND_MASK_VOLUME |
 						SOUND_MASK_BASS | SOUND_MASK_TREBLE,
 						(int *) arg); 
-#else
-				return put_user(SOUND_MASK_PCM | SOUND_MASK_VOLUME,
-						(int *) arg); 
-#endif
-		
-#ifdef TONE_CONTROL
 			return put_user(SOUND_MASK_LINE | SOUND_MASK_CD |
                                         SOUND_MASK_OGAIN | SOUND_MASK_LINE1 |
                                         SOUND_MASK_PCM | SOUND_MASK_VOLUME |
@@ -928,16 +932,7 @@
                                         SOUND_MASK_BASS | SOUND_MASK_TREBLE |
                                         SOUND_MASK_RECLEV | SOUND_MASK_SPEAKER |
                                         SOUND_MASK_LINE3 | SOUND_MASK_DIGITAL1 | 
-                                        SOUND_MASK_DIGITAL2 | SOUND_MASK_LINE2, (int *) arg);
-#else
-			return put_user(SOUND_MASK_LINE | SOUND_MASK_CD |
-                                        SOUND_MASK_OGAIN | SOUND_MASK_LINE1 |
-                                        SOUND_MASK_PCM | SOUND_MASK_VOLUME |
-                                        SOUND_MASK_PHONEIN | SOUND_MASK_MIC |
-                                        SOUND_MASK_RECLEV | SOUND_MASK_SPEAKER |
-                                        SOUND_MASK_LINE3 | SOUND_MASK_DIGITAL1 | 
-                                        SOUND_MASK_DIGITAL2 | SOUND_MASK_LINE2, (int *) arg);
-#endif
+                                        SOUND_MASK_DIGITAL2 | SOUND_MASK_DIGITAL3 | SOUND_MASK_LINE2, (int *) arg);
 
 			case SOUND_MIXER_RECMASK:       /* Arg contains a bit for each supported recording source */
 				DPF(2, "SOUND_MIXER_READ_RECMASK\n");
@@ -953,31 +948,16 @@
 				DPF(2, "SOUND_MIXER_READ_STEREODEVS\n");
 
 				if (card->isaps)
-#ifdef TONE_CONTROL
 					return put_user(SOUND_MASK_PCM | SOUND_MASK_VOLUME |
                                         		SOUND_MASK_BASS | SOUND_MASK_TREBLE,
                                         		(int *) arg);
-#else
-					return put_user(SOUND_MASK_PCM | SOUND_MASK_VOLUME,
-                                         		(int *) arg);
-#endif
-
-#ifdef TONE_CONTROL
 				return put_user(SOUND_MASK_LINE | SOUND_MASK_CD |
 					SOUND_MASK_OGAIN | SOUND_MASK_LINE1 |
 					SOUND_MASK_PCM | SOUND_MASK_VOLUME |
 					SOUND_MASK_BASS | SOUND_MASK_TREBLE |
 					SOUND_MASK_RECLEV | SOUND_MASK_LINE3 |
 					SOUND_MASK_DIGITAL1 | SOUND_MASK_DIGITAL2 |
-					SOUND_MASK_LINE2, (int *) arg);
-#else
-				return put_user(SOUND_MASK_LINE | SOUND_MASK_CD |
-					SOUND_MASK_OGAIN | SOUND_MASK_LINE1 |
-					SOUND_MASK_PCM | SOUND_MASK_VOLUME |
-					SOUND_MASK_RECLEV | SOUND_MASK_LINE3 |
-					SOUND_MASK_DIGITAL1 | SOUND_MASK_DIGITAL2 |
-					SOUND_MASK_LINE2, (int *) arg);
-#endif
+					SOUND_MASK_DIGITAL3 | SOUND_MASK_LINE2, (int *) arg);
 
 			case SOUND_MIXER_CAPS:
 				DPF(2, "SOUND_MIXER_READ_CAPS\n");

