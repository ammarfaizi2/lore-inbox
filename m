Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVLRPpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVLRPpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVLRPpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:45:24 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:40631 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965167AbVLRPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:45:23 -0500
Subject: [PATCH 5/5] - Fix a broken logic that didn't cover all standards.
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: linux-kernel@vger.kernel.org
Cc: js@linuxtv.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com
Date: Sun, 18 Dec 2005 13:23:45 -0200
Message-Id: <1134920704.6702.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix a broken logic that didn't cover all standards.
- Fix compilation failure with gcc 2.95.3 and other archtectures.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/video/cx25840/cx25840-core.c |   40 ++++++++++++++++------------
 1 files changed, 23 insertions(+), 17 deletions(-)

da7e1b8401e2ce0834070401a7c7b5c958dfc853
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index aea3f03..5b93723 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -333,24 +333,30 @@ static int set_input(struct i2c_client *
 
 static int set_v4lstd(struct i2c_client *client, v4l2_std_id std)
 {
-	u8 fmt;
+	u8 fmt=0; 	/* zero is autodetect */
 
-	switch (std) {
-	/* zero is autodetect */
-	case 0: fmt = 0x0; break;
-	/* default ntsc to ntsc-m */
-	case V4L2_STD_NTSC:
-	case V4L2_STD_NTSC_M: fmt = 0x1; break;
-	case V4L2_STD_NTSC_M_JP: fmt = 0x2; break;
-	case V4L2_STD_NTSC_443: fmt = 0x3; break;
-	case V4L2_STD_PAL: fmt = 0x4; break;
-	case V4L2_STD_PAL_M: fmt = 0x5; break;
-	case V4L2_STD_PAL_N: fmt = 0x6; break;
-	case V4L2_STD_PAL_Nc: fmt = 0x7; break;
-	case V4L2_STD_PAL_60: fmt = 0x8; break;
-	case V4L2_STD_SECAM: fmt = 0xc; break;
-	default:
-		return -ERANGE;
+	/* First tests should be against specific std */
+	if (std & V4L2_STD_NTSC_M_JP) {
+		fmt=0x2;
+	} else if (std & V4L2_STD_NTSC_443) {
+		fmt=0x3;
+	} else if (std & V4L2_STD_PAL_M) {
+		fmt=0x5;
+	} else if (std & V4L2_STD_PAL_N) {
+		fmt=0x6;
+	} else if (std & V4L2_STD_PAL_Nc) {
+		fmt=0x7;
+	} else if (std & V4L2_STD_PAL_60) {
+		fmt=0x8;
+	} else {
+		/* Then, test against generic ones */
+		if (std & V4L2_STD_NTSC) {
+			fmt=0x1;
+		} else if (std & V4L2_STD_PAL) {
+			fmt=0x4;
+		} else if (std & V4L2_STD_SECAM) {
+			fmt=0xc;
+		}
 	}
 
 	cx25840_and_or(client, 0x400, ~0xf, fmt);
-- 
0.99.9.GIT

