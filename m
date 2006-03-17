Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWCQU4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWCQU4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWCQU4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:56:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59562 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030193AbWCQU4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:24 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Marcin Rudowski <mar_rud@poczta.onet.pl>,
       Ian Pickworth <ian@pickworth.me.uk>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 08/21] Cx88 default picture controls values
Date: Fri, 17 Mar 2006 17:54:35 -0300
Message-id: <20060317205434.PS87790000008@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Marcin Rudowski <mar_rud@poczta.onet.pl>
Date: 1142132627 \-0300

This patch fixes default values for some picture controls:
 - brightness set to 50% by default (now is 0%)
 - hue set to 50% by default (now is 0%)
 - sets saturation to datasheet value
 - volume set to 0dB (now is -32dB)
and some left small fixes:
 - twice offset adding
 - balance didn't follow datasheet (bits[0:5] = attenuation;
   bit[6] = channel to provide attenuation)

Signed-off-by: Marcin Rudowski <mar_rud@poczta.onet.pl>
Signed-off-by: Ian Pickworth <ian@pickworth.me.uk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-video.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-video.c b/drivers/media/video/cx88/cx88-video.c
index 073494c..39328bb 100644
--- a/drivers/media/video/cx88/cx88-video.c
+++ b/drivers/media/video/cx88/cx88-video.c
@@ -227,7 +227,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.minimum       = 0x00,
 			.maximum       = 0xff,
 			.step          = 1,
-			.default_value = 0,
+			.default_value = 0x7f,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
 		.off                   = 128,
@@ -255,7 +255,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.minimum       = 0,
 			.maximum       = 0xff,
 			.step          = 1,
-			.default_value = 0,
+			.default_value = 0x7f,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
 		.off                   = 128,
@@ -300,7 +300,7 @@ static struct cx88_ctrl cx8800_ctls[] = 
 			.minimum       = 0,
 			.maximum       = 0x3f,
 			.step          = 1,
-			.default_value = 0x1f,
+			.default_value = 0x3f,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
 		.reg                   = AUD_VOL_CTL,
@@ -909,7 +909,8 @@ static int get_control(struct cx88_core 
 	value = c->sreg ? cx_sread(c->sreg) : cx_read(c->reg);
 	switch (ctl->id) {
 	case V4L2_CID_AUDIO_BALANCE:
-		ctl->value = (value & 0x40) ? (value & 0x3f) : (0x40 - (value & 0x3f));
+		ctl->value = ((value & 0x7f) < 0x40) ? ((value & 0x7f) + 0x40)
+					: (0x7f - (value & 0x7f));
 		break;
 	case V4L2_CID_AUDIO_VOLUME:
 		ctl->value = 0x3f - (value & 0x3f);
@@ -946,7 +947,7 @@ static int set_control(struct cx88_core 
 	mask=c->mask;
 	switch (ctl->id) {
 	case V4L2_CID_AUDIO_BALANCE:
-		value = (ctl->value < 0x40) ? (0x40 - ctl->value) : ctl->value;
+		value = (ctl->value < 0x40) ? (0x7f - ctl->value) : (ctl->value - 0x40);
 		break;
 	case V4L2_CID_AUDIO_VOLUME:
 		value = 0x3f - (ctl->value & 0x3f);
@@ -987,8 +988,7 @@ static void init_controls(struct cx88_co
 
 	for (i = 0; i < CX8800_CTLS; i++) {
 		ctrl.id=cx8800_ctls[i].v.id;
-		ctrl.value=cx8800_ctls[i].v.default_value
-				+cx8800_ctls[i].off;
+		ctrl.value=cx8800_ctls[i].v.default_value;
 		set_control(core, &ctrl);
 	}
 }

