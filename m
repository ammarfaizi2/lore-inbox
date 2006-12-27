Return-Path: <linux-kernel-owner+w=401wt.eu-S933011AbWL0RMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbWL0RMG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933005AbWL0RMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:12:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41458 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993AbWL0RL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:11:27 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 14/28] V4L/DVB (4982): Fix broken audio mode handling for
	line-in in msp3400.
Date: Wed, 27 Dec 2006 14:57:30 -0200
Message-id: <20061227165729.PS88541200014@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hans Verkuil <hverkuil@xs4all.nl>

The wrong matrix was used when an external input was selected instead of
the tuner input. The rxsubchans field was also not initialized to STEREO
for an external input. And finally the msp34xxg_detect_stereo() should
not try to detect stereo for an external input, that code is for the
tuner input only.
Together these bugs made it hit 'n miss whether you ever got stereo out
of the msp3400 for an external input.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/msp3400-driver.c   |    6 ++----
 drivers/media/video/msp3400-kthreads.c |   11 ++++++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index e1b56dc..295cb99 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -633,10 +633,8 @@ #endif
 			if (((rt->input >> (4 + i * 4)) & 0xf) == 0)
 				extern_input = 0;
 		}
-		if (extern_input)
-			state->mode = MSP_MODE_EXTERN;
-		else
-			state->mode = MSP_MODE_AM_DETECT;
+		state->mode = extern_input ? MSP_MODE_EXTERN : MSP_MODE_AM_DETECT;
+		state->rxsubchans = V4L2_TUNER_SUB_STEREO;
 		msp_set_scart(client, sc_in, 0);
 		msp_set_scart(client, sc1_out, 1);
 		msp_set_scart(client, sc2_out, 2);
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index 4c7f85b..e1821eb 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -483,7 +483,6 @@ int msp3400c_thread(void *data)
 			/* no carrier scan, just unmute */
 			v4l_dbg(1, msp_debug, client, "thread: no carrier scan\n");
 			state->scan_in_progress = 0;
-			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
 			msp_set_audio(client);
 			continue;
 		}
@@ -851,12 +850,15 @@ static void msp34xxg_set_source(struct i
 		source = 1; /* stereo or A|B */
 		matrix = 0x20;
 		break;
-	case V4L2_TUNER_MODE_STEREO:
 	case V4L2_TUNER_MODE_LANG1:
-	default:
 		source = 3; /* stereo or A */
 		matrix = 0x00;
 		break;
+	case V4L2_TUNER_MODE_STEREO:
+	default:
+		source = 3; /* stereo or A */
+		matrix = 0x20;
+		break;
 	}
 
 	if (in == MSP_DSP_IN_TUNER)
@@ -1030,6 +1032,9 @@ static int msp34xxg_detect_stereo(struct
 	int is_stereo = status & 0x40;
 	int oldrx = state->rxsubchans;
 
+	if (state->mode == MSP_MODE_EXTERN)
+		return 0;
+
 	state->rxsubchans = 0;
 	if (is_stereo)
 		state->rxsubchans = V4L2_TUNER_SUB_STEREO;

