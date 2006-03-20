Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWCTP3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWCTP3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbWCTP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:28:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55736 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965321AbWCTP2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:28:25 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 005/141] V4L/DVB (3402): Fix handling of VIDIOC_G_TUNER
	audmode in msp3400
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150837.PS920363000005@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>
Date: 1138016762 -0200

- Fix handling of VIDIOC_G_TUNER audmode in msp3400: audmode
is only changed by the user with S_TUNER, never by the driver.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index 69ed369..994c340 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -653,7 +653,6 @@ static int msp_command(struct i2c_client
 		}
 		if (scart) {
 			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
-			state->audmode = V4L2_TUNER_MODE_STEREO;
 			msp_set_scart(client, scart, 0);
 			msp_write_dsp(client, 0x000d, 0x1900);
 			if (state->opmode != OPMODE_AUTOSELECT)
@@ -831,11 +830,8 @@ static int msp_command(struct i2c_client
 			return -EINVAL;
 		}
 
-		msp_any_detect_stereo(client);
-		if (state->audmode == V4L2_TUNER_MODE_STEREO) {
-			a->capability = V4L2_AUDCAP_STEREO;
-		}
-
+		a->capability = V4L2_AUDCAP_STEREO;
+		a->mode = 0;  /* TODO: add support for AVL */
 		break;
 	}
 
@@ -865,15 +861,9 @@ static int msp_command(struct i2c_client
 		}
 		if (scart) {
 			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
-			state->audmode = V4L2_TUNER_MODE_STEREO;
 			msp_set_scart(client, scart, 0);
 			msp_write_dsp(client, 0x000d, 0x1900);
 		}
-		if (sarg->capability == V4L2_AUDCAP_STEREO) {
-			state->audmode = V4L2_TUNER_MODE_STEREO;
-		} else {
-			state->audmode &= ~V4L2_TUNER_MODE_STEREO;
-		}
 		msp_any_set_audmode(client, state->audmode);
 		msp_wake_thread(client);
 		break;
@@ -898,11 +888,10 @@ static int msp_command(struct i2c_client
 	{
 		struct v4l2_tuner *vt = (struct v4l2_tuner *)arg;
 
-		if (state->radio)
+		if (state->radio)  /* TODO: add mono/stereo support for radio */
 			break;
 		/* only set audmode */
-		if (vt->audmode != -1 && vt->audmode != 0)
-			msp_any_set_audmode(client, vt->audmode);
+		msp_any_set_audmode(client, vt->audmode);
 		break;
 	}
 
@@ -927,7 +916,6 @@ static int msp_command(struct i2c_client
 			return -EINVAL;
 		}
 		break;
-
 	}
 
 	case VIDIOC_S_AUDOUT:
@@ -1094,6 +1082,7 @@ static int msp_attach(struct i2c_adapter
 
 	memset(state, 0, sizeof(*state));
 	state->v4l2_std = V4L2_STD_NTSC;
+	state->audmode = V4L2_TUNER_MODE_STEREO;
 	state->volume = 58880;	/* 0db gain */
 	state->balance = 32768;	/* 0db gain */
 	state->bass = 32768;
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index 2072c3e..3235a15 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -170,7 +170,6 @@ void msp3400c_setmode(struct i2c_client 
 
 	v4l_dbg(1, msp_debug, client, "setmode: %d\n", type);
 	state->mode       = type;
-	state->audmode    = V4L2_TUNER_MODE_MONO;
 	state->rxsubchans = V4L2_TUNER_SUB_MONO;
 
 	msp_write_dem(client, 0x00bb, msp3400c_init_data[type].ad_cv);
@@ -210,7 +209,7 @@ void msp3400c_setmode(struct i2c_client 
 }
 
 /* turn on/off nicam + stereo */
-void msp3400c_setstereo(struct i2c_client *client, int mode)
+void msp3400c_setstereo(struct i2c_client *client, int audmode)
 {
 	static char *strmode[] = { "mono", "stereo", "lang2", "lang1" };
 	struct msp_state *state = i2c_get_clientdata(client);
@@ -222,16 +221,16 @@ void msp3400c_setstereo(struct i2c_clien
 		 * it's never called
 		 */
 		v4l_dbg(1, msp_debug, client, "setstereo called with mode=%d instead of set_source (ignored)\n",
-		     mode);
+		     audmode);
 		return;
 	}
 
 	/* switch demodulator */
 	switch (state->mode) {
 	case MSP_MODE_FM_TERRA:
-		v4l_dbg(1, msp_debug, client, "FM setstereo: %s\n", strmode[mode]);
+		v4l_dbg(1, msp_debug, client, "FM setstereo: %s\n", strmode[audmode]);
 		msp3400c_setcarrier(client, state->second, state->main);
-		switch (mode) {
+		switch (audmode) {
 		case V4L2_TUNER_MODE_STEREO:
 			msp_write_dsp(client, 0x000e, 0x3001);
 			break;
@@ -243,8 +242,8 @@ void msp3400c_setstereo(struct i2c_clien
 		}
 		break;
 	case MSP_MODE_FM_SAT:
-		v4l_dbg(1, msp_debug, client, "SAT setstereo: %s\n", strmode[mode]);
-		switch (mode) {
+		v4l_dbg(1, msp_debug, client, "SAT setstereo: %s\n", strmode[audmode]);
+		switch (audmode) {
 		case V4L2_TUNER_MODE_MONO:
 			msp3400c_setcarrier(client, MSP_CARRIER(6.5), MSP_CARRIER(6.5));
 			break;
@@ -262,21 +261,21 @@ void msp3400c_setstereo(struct i2c_clien
 	case MSP_MODE_FM_NICAM1:
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
-		v4l_dbg(1, msp_debug, client, "NICAM setstereo: %s\n",strmode[mode]);
+		v4l_dbg(1, msp_debug, client, "NICAM setstereo: %s\n",strmode[audmode]);
 		msp3400c_setcarrier(client,state->second,state->main);
 		if (state->nicam_on)
 			nicam=0x0100;
 		break;
 	case MSP_MODE_BTSC:
-		v4l_dbg(1, msp_debug, client, "BTSC setstereo: %s\n",strmode[mode]);
+		v4l_dbg(1, msp_debug, client, "BTSC setstereo: %s\n",strmode[audmode]);
 		nicam=0x0300;
 		break;
 	case MSP_MODE_EXTERN:
-		v4l_dbg(1, msp_debug, client, "extern setstereo: %s\n",strmode[mode]);
+		v4l_dbg(1, msp_debug, client, "extern setstereo: %s\n",strmode[audmode]);
 		nicam = 0x0200;
 		break;
 	case MSP_MODE_FM_RADIO:
-		v4l_dbg(1, msp_debug, client, "FM-Radio setstereo: %s\n",strmode[mode]);
+		v4l_dbg(1, msp_debug, client, "FM-Radio setstereo: %s\n",strmode[audmode]);
 		break;
 	default:
 		v4l_dbg(1, msp_debug, client, "mono setstereo\n");
@@ -284,7 +283,7 @@ void msp3400c_setstereo(struct i2c_clien
 	}
 
 	/* switch audio */
-	switch (mode) {
+	switch (audmode) {
 	case V4L2_TUNER_MODE_STEREO:
 		src = 0x0020 | nicam;
 		break;
@@ -759,7 +758,6 @@ int msp3410d_thread(void *data)
 		case 0x0040: /* FM radio */
 			state->mode = MSP_MODE_FM_RADIO;
 			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
-			state->audmode = V4L2_TUNER_MODE_STEREO;
 			state->nicam_on = 0;
 			state->watch_stereo = 0;
 			/* not needed in theory if we have radio, but
@@ -779,7 +777,6 @@ int msp3410d_thread(void *data)
 		case 0x0005:
 			state->mode = MSP_MODE_FM_TERRA;
 			state->rxsubchans = V4L2_TUNER_SUB_MONO;
-			state->audmode = V4L2_TUNER_MODE_MONO;
 			state->nicam_on = 0;
 			state->watch_stereo = 1;
 			break;

