Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbSLPRrU>; Mon, 16 Dec 2002 12:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSLPRrU>; Mon, 16 Dec 2002 12:47:20 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:47256 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266840AbSLPRrQ>; Mon, 16 Dec 2002 12:47:16 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: [PATCH] (Was: i4l dtmf errors)
Date: Mon, 16 Dec 2002 18:44:58 +0100
Organization: None
Message-ID: <atl3eq$s43$1@fritz38552.news.dfncis.de>
References: <atg5jv$d73$1@fritz38552.news.dfncis.de> <Pine.LNX.4.44.0212141712410.7099-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1113440.8i0y9mmqF5"
Content-Transfer-Encoding: 7Bit
User-Agent: KNode/0.7.1
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.5; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.5; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1113440.8i0y9mmqF5
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit

<veröffentlicht & per Mail versendet>

Kai Germaschewski wrote:

> On Sat, 14 Dec 2002, Wolfgang Fritz wrote:
> 
>> > it seems isdn4linux detects DTMF tones from normal speach. This is
>> > rather annoying when using i4l for voice with Asterisk.org. This is
>> > tested on all recent kernels
>> 
>> The DTMF detection is broken since kernel 2.0.x. I have a patch for a
>> 2.2 kernel which may manually be applied 2.4 kernels with some manual
>> work. It fixes an overflow problem in the goertzel algorithm (which
>> does the basic tone detection) and changes the algorithm to detect
>> the DTMF pairs. If interested, I can try to recover that patch.
> 
> If you dig out that patch and submit it (to me), I'm pretty sure
> there's a good chance of it going into the official kernel. ISTR there
> was talk about that earlier, but nothing ever happened.
> 
> --Kai
> 

Here is the patch against 2.4.20.

Wolfgang
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart1113440.8i0y9mmqF5
Content-Type: text/x-diff; name="dtmf.patch"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="dtmf.patch"

diff -urN -X dontdiff linux-2.4.20/drivers/isdn/isdn_audio.c linux-2.4.20.mod/drivers/isdn/isdn_audio.c
--- linux-2.4.20/drivers/isdn/isdn_audio.c	Mon Feb 25 20:37:58 2002
+++ linux-2.4.20.mod/drivers/isdn/isdn_audio.c	Mon Dec 16 17:45:39 2002
@@ -169,39 +169,19 @@
 	0x8a, 0x8a, 0x6a, 0x6a, 0xea, 0xea, 0x2a, 0x2a
 };
 
-#define NCOEFF           16     /* number of frequencies to be analyzed       */
-#define DTMF_TRESH    25000     /* above this is dtmf                         */
+#define NCOEFF            8     /* number of frequencies to be analyzed       */
+#define DTMF_TRESH     4000     /* above this is dtmf                         */
 #define SILENCE_TRESH   200     /* below this is silence                      */
-#define H2_TRESH      20000     /* 2nd harmonic                               */
 #define AMP_BITS          9     /* bits per sample, reduced to avoid overflow */
 #define LOGRP             0
 #define HIGRP             1
 
-typedef struct {
-	int grp;                /* low/high group     */
-	int k;                  /* k                  */
-	int k2;                 /* k fuer 2. harmonic */
-} dtmf_t;
-
 /* For DTMF recognition:
  * 2 * cos(2 * PI * k / N) precalculated for all k
  */
 static int cos2pik[NCOEFF] =
 {
-	55812, 29528, 53603, 24032, 51193, 14443, 48590, 6517,
-	38113, -21204, 33057, -32186, 25889, -45081, 18332, -55279
-};
-
-static dtmf_t dtmf_tones[8] =
-{
-	{LOGRP, 0, 1},          /*  697 Hz */
-	{LOGRP, 2, 3},          /*  770 Hz */
-	{LOGRP, 4, 5},          /*  852 Hz */
-	{LOGRP, 6, 7},          /*  941 Hz */
-	{HIGRP, 8, 9},          /* 1209 Hz */
-	{HIGRP, 10, 11},        /* 1336 Hz */
-	{HIGRP, 12, 13},        /* 1477 Hz */
-	{HIGRP, 14, 15}         /* 1633 Hz */
+	55813, 53604, 51193, 48591, 38114, 33057, 25889, 18332
 };
 
 static char dtmf_matrix[4][4] =
@@ -499,6 +479,18 @@
 			sk2 = sk1;
 			sk1 = sk;
 		}
+		/* Avoid overflows */
+		sk >>= 1;
+		sk2 >>= 1;
+		/* compute |X(k)|**2 */
+		/* report overflows. This should not happen. */
+		/* Comment this out if desired */
+		if (sk < -32768 || sk > 32767)
+			printk(KERN_DEBUG
+			       "isdn_audio: dtmf goertzel overflow, sk=%d\n", sk);
+		if (sk2 < -32768 || sk2 > 32767)
+			printk(KERN_DEBUG
+			       "isdn_audio: dtmf goertzel overflow, sk2=%d\n", sk2);
 		result[k] =
 		    ((sk * sk) >> AMP_BITS) -
 		    ((((cos2pik[k] * sk) >> 15) * sk2) >> AMP_BITS) +
@@ -522,28 +514,58 @@
 	int grp[2];
 	char what;
 	char *p;
+	int thresh;
 
 	while ((skb = skb_dequeue(&info->dtmf_queue))) {
 		result = (int *) skb->data;
 		s = info->dtmf_state;
-		grp[LOGRP] = grp[HIGRP] = -2;
+		grp[LOGRP] = grp[HIGRP] = -1;
 		silence = 0;
-		for (i = 0; i < 8; i++) {
-			if ((result[dtmf_tones[i].k] > DTMF_TRESH) &&
-			    (result[dtmf_tones[i].k2] < H2_TRESH))
-				grp[dtmf_tones[i].grp] = (grp[dtmf_tones[i].grp] == -2) ? i : -1;
-			else if ((result[dtmf_tones[i].k] < SILENCE_TRESH) &&
-			      (result[dtmf_tones[i].k2] < SILENCE_TRESH))
+		thresh = 0;
+		for (i = 0; i < NCOEFF; i++) {
+			if (result[i] > DTMF_TRESH) {
+				if (result[i] > thresh)
+					thresh = result[i];
+			}
+			else if (result[i] < SILENCE_TRESH)
 				silence++;
 		}
-		if (silence == 8)
+		if (silence == NCOEFF)
 			what = ' ';
 		else {
-			if ((grp[LOGRP] >= 0) && (grp[HIGRP] >= 0)) {
-				what = dtmf_matrix[grp[LOGRP]][grp[HIGRP] - 4];
-				if (s->last != ' ' && s->last != '.')
-					s->last = what;	/* min. 1 non-DTMF between DTMF */
-			} else
+			if (thresh > 0)	{
+				thresh = thresh >> 4;  /* touchtones must match within 12 dB */
+				for (i = 0; i < NCOEFF; i++) {
+					if (result[i] < thresh)
+						continue;  /* ignore */
+					/* good level found. This is allowed only one time per group */
+					if (i < NCOEFF / 2) {
+						/* lowgroup*/
+						if (grp[LOGRP] >= 0) {
+							// Bad. Another tone found. */
+							grp[LOGRP] = -1;
+							break;
+						}
+						else
+							grp[LOGRP] = i;
+					}
+					else { /* higroup */
+						if (grp[HIGRP] >= 0) { // Bad. Another tone found. */
+							grp[HIGRP] = -1;
+							break;
+						}
+						else
+							grp[HIGRP] = i - NCOEFF/2;
+					}
+				}
+				if ((grp[LOGRP] >= 0) && (grp[HIGRP] >= 0)) {
+					what = dtmf_matrix[grp[LOGRP]][grp[HIGRP]];
+					if (s->last != ' ' && s->last != '.')
+						s->last = what;	/* min. 1 non-DTMF between DTMF */
+				} else
+					what = '.';
+			}
+			else
 				what = '.';
 		}
 		if ((what != s->last) && (what != ' ') && (what != '.')) {
diff -urN -X dontdiff linux-2.4.20/drivers/isdn/isdn_audio.h linux-2.4.20.mod/drivers/isdn/isdn_audio.h
--- linux-2.4.20/drivers/isdn/isdn_audio.h	Fri Dec 21 18:41:54 2001
+++ linux-2.4.20.mod/drivers/isdn/isdn_audio.h	Mon Dec 16 17:42:32 2002
@@ -20,6 +20,7 @@
 
 typedef struct dtmf_state {
 	char last;
+	char llast;
 	int idx;
 	int buf[DTMF_NPOINTS];
 } dtmf_state;

--nextPart1113440.8i0y9mmqF5--


