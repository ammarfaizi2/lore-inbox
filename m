Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVCHK5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVCHK5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVCHKxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:53:24 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19947 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261976AbVCHKuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:50:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:45:30 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tveeprom update
Message-ID: <20050308104530.GA30786@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some new tuners to the list.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tveeprom.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

Index: linux-2.6.11/drivers/media/video/tveeprom.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/tveeprom.c	2005-03-07 18:13:01.000000000 +0100
+++ linux-2.6.11/drivers/media/video/tveeprom.c	2005-03-08 10:33:08.000000000 +0100
@@ -30,6 +30,7 @@
 
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -191,11 +192,13 @@ hauppauge_tuner[] =
 	{ TUNER_ABSENT,        "TCL MFPE05 2"},
 	/* 90-99 */
 	{ TUNER_ABSENT,        "LG TALN H202T"},
-	{ TUNER_ABSENT,        "Philips FQ1216AME MK4"},
-	{ TUNER_ABSENT,        "Philips FQ1236A MK4"},
+	{ TUNER_PHILIPS_FQ1216AME_MK4, "Philips FQ1216AME MK4"},
+	{ TUNER_PHILIPS_FQ1236A_MK4, "Philips FQ1236A MK4"},
 	{ TUNER_ABSENT,        "Philips FQ1286A MK4"},
 	{ TUNER_ABSENT,        "Philips FQ1216ME MK5"},
 	{ TUNER_ABSENT,        "Philips FQ1236 MK5"},
+	{ TUNER_ABSENT,        "Unspecified"},
+	{ TUNER_LG_PAL_TAPE,   "LG PAL (TAPE Series)"},
 };
 
 static char *sndtype[] = {
@@ -241,6 +244,7 @@ static int hasRadioTuner(int tunerType)
                 case 61: //PNPEnv_TUNER_TAPE_M001D_MK3:
                 case 78: //PNPEnv_TUNER_TDA8275C1_8290_FM:
                 case 89: //PNPEnv_TUNER_TCL_MFPE05_2:
+                case 92: //PNPEnv_TUNER_PHILIPS_FQ1236A_MK4:
                     return 1;
         }
         return 0;
@@ -256,8 +260,8 @@ void tveeprom_hauppauge_analog(struct tv
 	** if packet[0] & f8 == f8, then EOD and packet[1] == checksum
 	**
 	** In our (ivtv) case we're interested in the following:
-	** tuner type: tag [00].05 or [0a].01 (index into hauppauge_tuners)
-	** tuner fmts: tag [00].04 or [0a].00 (bitmask index into hauppauge_fmts)
+	** tuner type: tag [00].05 or [0a].01 (index into hauppauge_tuner)
+	** tuner fmts: tag [00].04 or [0a].00 (bitmask index into hauppauge_tuner_fmt)
 	** radio:      tag [00].{last} or [0e].00  (bitmask.  bit2=FM)
 	** audio proc: tag [02].01 or [05].00 (lower nibble indexes lut?)
 
@@ -269,11 +273,11 @@ void tveeprom_hauppauge_analog(struct tv
 	** # of inputs/outputs ???
 	*/
 
-	int i, j, len, done, tag, tuner = 0, t_format = 0;
+	int i, j, len, done, beenhere, tag, tuner = 0, t_format = 0;
 	char *t_name = NULL, *t_fmt_name = NULL;
 
 	dprintk(1, "%s\n",__FUNCTION__);
-	tvee->revision = done = len = 0;
+	tvee->revision = done = len = beenhere = 0;
 	for (i = 0; !done && i < 256; i += len) {
 		dprintk(2, "processing pos = %02x (%02x, %02x)\n",
 			i, eeprom_data[i], eeprom_data[i + 1]);
@@ -342,9 +346,14 @@ void tveeprom_hauppauge_analog(struct tv
 				(eeprom_data[i+7] << 16);
 			break;
 		case 0x0a:
-			tuner = eeprom_data[i+2];
-			t_format = eeprom_data[i+1];
-			break;
+			if(beenhere == 0) {
+				tuner = eeprom_data[i+2];
+				t_format = eeprom_data[i+1];
+				beenhere = 1;
+				break;
+			} else {
+				break;
+			}
 		case 0x0e:
 			tvee->has_radio = eeprom_data[i+1];
 			break;

-- 
#define printk(args...) fprintf(stderr, ## args)
