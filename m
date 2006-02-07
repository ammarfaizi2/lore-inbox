Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWBGPk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWBGPk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWBGPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:40:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47260 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751125AbWBGPkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:36 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 06/16] Add standard for South Korean NTSC-M using A2 audio.
Date: Tue, 07 Feb 2006 13:33:31 -0200
Message-id: <20060207153331.PS20631200006@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

South Korea uses NTSC-M but with A2 audio instead of BTSC. Several audio
chips need this information in order to set the correct audio processing
registers.

Acked-by: Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bttv-driver.c          |    2 +
 drivers/media/video/cx25840/cx25840-core.c |   50 +++++++++++-----------------
 drivers/media/video/tda9887.c              |    7 +++-
 drivers/media/video/tuner-core.c           |    5 +++
 include/linux/videodev2.h                  |    4 ++
 5 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
index aa4c4c5..578b200 100644
--- a/drivers/media/video/bttv-driver.c
+++ b/drivers/media/video/bttv-driver.c
@@ -214,7 +214,7 @@ const struct bttv_tvnorm bttv_tvnorms[] 
 		   we can capture, of the first and second field. */
 		.vbistart	= { 7,320 },
 	},{
-		.v4l2_id        = V4L2_STD_NTSC_M,
+		.v4l2_id        = V4L2_STD_NTSC_M | V4L2_STD_NTSC_M_KR,
 		.name           = "NTSC",
 		.Fsc            = 28636363,
 		.swidth         = 768,
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index c66c2c1..08ffd1f 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -220,33 +220,23 @@ static void input_change(struct i2c_clie
 		cx25840_write(client, 0x808, 0xff);
 		cx25840_write(client, 0x80b, 0x10);
 	} else if (std & V4L2_STD_NTSC) {
-		/* NTSC */
-		if (state->pvr150_workaround) {
-			/* Certain Hauppauge PVR150 models have a hardware bug
-			   that causes audio to drop out. For these models the
-			   audio standard must be set explicitly.
-			   To be precise: it affects cards with tuner models
-			   85, 99 and 112 (model numbers from tveeprom). */
-			if (std == V4L2_STD_NTSC_M_JP) {
-				/* Japan uses EIAJ audio standard */
-				cx25840_write(client, 0x808, 0x2f);
-			} else {
-				/* Others use the BTSC audio standard */
-				cx25840_write(client, 0x808, 0x1f);
-			}
-			/* South Korea uses the A2-M (aka Zweiton M) audio
-			   standard, and should set 0x808 to 0x3f, but I don't
-			   know how to detect this. */
-		} else if (std == V4L2_STD_NTSC_M_JP) {
+		/* Certain Hauppauge PVR150 models have a hardware bug
+		   that causes audio to drop out. For these models the
+		   audio standard must be set explicitly.
+		   To be precise: it affects cards with tuner models
+		   85, 99 and 112 (model numbers from tveeprom). */
+		int hw_fix = state->pvr150_workaround;
+
+		if (std == V4L2_STD_NTSC_M_JP) {
 			/* Japan uses EIAJ audio standard */
-			cx25840_write(client, 0x808, 0xf7);
+			cx25840_write(client, 0x808, hw_fix ? 0x2f : 0xf7);
+		} else if (std == V4L2_STD_NTSC_M_KR) {
+			/* South Korea uses A2 audio standard */
+			cx25840_write(client, 0x808, hw_fix ? 0x3f : 0xf8);
 		} else {
 			/* Others use the BTSC audio standard */
-			cx25840_write(client, 0x808, 0xf6);
+			cx25840_write(client, 0x808, hw_fix ? 0x1f : 0xf6);
 		}
-		/* South Korea uses the A2-M (aka Zweiton M) audio standard,
-		   and should set 0x808 to 0xf8, but I don't know how to
-		   detect this. */
 		cx25840_write(client, 0x80b, 0x00);
 	}
 
@@ -330,17 +320,17 @@ static int set_v4lstd(struct i2c_client 
 	u8 fmt=0; 	/* zero is autodetect */
 
 	/* First tests should be against specific std */
-	if (std & V4L2_STD_NTSC_M_JP) {
+	if (std == V4L2_STD_NTSC_M_JP) {
 		fmt=0x2;
-	} else if (std & V4L2_STD_NTSC_443) {
+	} else if (std == V4L2_STD_NTSC_443) {
 		fmt=0x3;
-	} else if (std & V4L2_STD_PAL_M) {
+	} else if (std == V4L2_STD_PAL_M) {
 		fmt=0x5;
-	} else if (std & V4L2_STD_PAL_N) {
+	} else if (std == V4L2_STD_PAL_N) {
 		fmt=0x6;
-	} else if (std & V4L2_STD_PAL_Nc) {
+	} else if (std == V4L2_STD_PAL_Nc) {
 		fmt=0x7;
-	} else if (std & V4L2_STD_PAL_60) {
+	} else if (std == V4L2_STD_PAL_60) {
 		fmt=0x8;
 	} else {
 		/* Then, test against generic ones */
@@ -369,7 +359,7 @@ v4l2_std_id cx25840_get_v4lstd(struct i2
 	}
 
 	switch (fmt) {
-	case 0x1: return V4L2_STD_NTSC_M;
+	case 0x1: return V4L2_STD_NTSC_M | V4L2_STD_NTSC_M_KR;
 	case 0x2: return V4L2_STD_NTSC_M_JP;
 	case 0x3: return V4L2_STD_NTSC_443;
 	case 0x4: return V4L2_STD_PAL;
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 7c71422..0d54f6c 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -231,7 +231,7 @@ static struct tvnorm tvnorms[] = {
 			   cAudioIF_6_5   |
 			   cVideoIF_38_90 ),
 	},{
-		.std   = V4L2_STD_NTSC_M,
+		.std   = V4L2_STD_NTSC_M | V4L2_STD_NTSC_M_KR,
 		.name  = "NTSC-M",
 		.b     = ( cNegativeFmTV  |
 			   cQSS           ),
@@ -619,6 +619,11 @@ static int tda9887_fixup_std(struct tda9
 			tda9887_dbg("insmod fixup: NTSC => NTSC_M_JP\n");
 			t->std = V4L2_STD_NTSC_M_JP;
 			break;
+		case 'k':
+		case 'K':
+			tda9887_dbg("insmod fixup: NTSC => NTSC_M_KR\n");
+			t->std = V4L2_STD_NTSC_M_KR;
+			break;
 		case '-':
 			/* default parameter, do nothing */
 			break;
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 873bf3d..e7ee619 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -366,6 +366,11 @@ static int tuner_fixup_std(struct tuner 
 			tuner_dbg("insmod fixup: NTSC => NTSC_M_JP\n");
 			t->std = V4L2_STD_NTSC_M_JP;
 			break;
+		case 'k':
+		case 'K':
+			tuner_dbg("insmod fixup: NTSC => NTSC_M_KR\n");
+			t->std = V4L2_STD_NTSC_M_KR;
+			break;
 		case '-':
 			/* default parameter, do nothing */
 			break;
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index ce40675..839ccc7 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -628,6 +628,7 @@ typedef __u64 v4l2_std_id;
 #define V4L2_STD_NTSC_M         ((v4l2_std_id)0x00001000)
 #define V4L2_STD_NTSC_M_JP      ((v4l2_std_id)0x00002000)
 #define V4L2_STD_NTSC_443       ((v4l2_std_id)0x00004000)
+#define V4L2_STD_NTSC_M_KR      ((v4l2_std_id)0x00008000)
 
 #define V4L2_STD_SECAM_B        ((v4l2_std_id)0x00010000)
 #define V4L2_STD_SECAM_D        ((v4l2_std_id)0x00020000)
@@ -660,7 +661,8 @@ typedef __u64 v4l2_std_id;
 				 V4L2_STD_PAL_H		|\
 				 V4L2_STD_PAL_I)
 #define V4L2_STD_NTSC           (V4L2_STD_NTSC_M	|\
-				 V4L2_STD_NTSC_M_JP)
+				 V4L2_STD_NTSC_M_JP     |\
+				 V4L2_STD_NTSC_M_KR)
 #define V4L2_STD_SECAM_DK      	(V4L2_STD_SECAM_D	|\
 				 V4L2_STD_SECAM_K	|\
 				 V4L2_STD_SECAM_K1)

