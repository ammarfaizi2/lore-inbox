Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbWCTP4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWCTP4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965608AbWCTP4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:56:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21218 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965234AbWCTPTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:19:00 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hans Verkuil <hverkuil@xs4all.nl>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 025/141] V4L/DVB (3427): audmode and rxsubchans fixes
	(VIDIOC_G/S_TUNER)
Date: Mon, 20 Mar 2006 12:08:41 -0300
Message-id: <20060320150841.PS192117000025@infradead.org>
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
Date: 1138043469 -0200

- Audmode and rxsubchans fixes in msp3400, tuner, tvaudio and cx25840.
- msp3400 cleanups

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
diff --git a/drivers/media/video/cx25840/cx25840-core.c b/drivers/media/video/cx25840/cx25840-core.c
index c66c2c1..3acd587 100644
--- a/drivers/media/video/cx25840/cx25840-core.c
+++ b/drivers/media/video/cx25840/cx25840-core.c
@@ -753,6 +753,7 @@ static int cx25840_command(struct i2c_cl
 
 		memset(input, 0, sizeof(*input));
 		input->index = state->aud_input;
+		input->capability = V4L2_AUDCAP_STEREO;
 		break;
 	}
 
@@ -763,7 +764,6 @@ static int cx25840_command(struct i2c_cl
 	case VIDIOC_G_TUNER:
 	{
 		u8 mode = cx25840_read(client, 0x804);
-		u8 pref = cx25840_read(client, 0x809) & 0xf;
 		u8 vpres = cx25840_read(client, 0x80a) & 0x10;
 		int val = 0;
 
@@ -783,44 +783,49 @@ static int cx25840_command(struct i2c_cl
 			val |= V4L2_TUNER_SUB_MONO;
 
 		if (mode == 2 || mode == 4)
-			val |= V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
+			val = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 
 		if (mode & 0x10)
 			val |= V4L2_TUNER_SUB_SAP;
 
 		vt->rxsubchans = val;
-
-		switch (pref) {
-		case 0:
-			vt->audmode = V4L2_TUNER_MODE_MONO;
-			break;
-		case 1:
-		case 2:
-			vt->audmode = V4L2_TUNER_MODE_LANG2;
-			break;
-		case 4:
-		default:
-			vt->audmode = V4L2_TUNER_MODE_STEREO;
-		}
+		vt->audmode = state->audmode;
 		break;
 	}
 
 	case VIDIOC_S_TUNER:
+		if (state->radio)
+			break;
+
 		switch (vt->audmode) {
 		case V4L2_TUNER_MODE_MONO:
-		case V4L2_TUNER_MODE_LANG1:
-			/* Force PREF_MODE to MONO */
+			/* mono      -> mono
+			   stereo    -> mono
+			   bilingual -> lang1 */
 			cx25840_and_or(client, 0x809, ~0xf, 0x00);
 			break;
-		case V4L2_TUNER_MODE_STEREO:
-			/* Force PREF_MODE to STEREO */
+		case V4L2_TUNER_MODE_LANG1:
+			/* mono      -> mono
+			   stereo    -> stereo
+			   bilingual -> lang1 */
 			cx25840_and_or(client, 0x809, ~0xf, 0x04);
 			break;
+		case V4L2_TUNER_MODE_STEREO:
+			/* mono      -> mono
+			   stereo    -> stereo
+			   bilingual -> lang1/lang2 */
+			cx25840_and_or(client, 0x809, ~0xf, 0x07);
+			break;
 		case V4L2_TUNER_MODE_LANG2:
-			/* Force PREF_MODE to LANG2 */
+			/* mono      -> mono
+			   stereo    ->stereo
+			   bilingual -> lang2 */
 			cx25840_and_or(client, 0x809, ~0xf, 0x01);
 			break;
+		default:
+			return -EINVAL;
 		}
+		state->audmode = vt->audmode;
 		break;
 
 	case VIDIOC_G_FMT:
@@ -901,6 +906,7 @@ static int cx25840_detect_client(struct 
 	state->aud_input = CX25840_AUDIO8;
 	state->audclk_freq = 48000;
 	state->pvr150_workaround = 0;
+	state->audmode = V4L2_TUNER_MODE_LANG1;
 
 	cx25840_initialize(client, 1);
 
diff --git a/drivers/media/video/cx25840/cx25840.h b/drivers/media/video/cx25840/cx25840.h
diff --git a/drivers/media/video/cx25840/cx25840.h b/drivers/media/video/cx25840/cx25840.h
index fd22f30..dd70664 100644
--- a/drivers/media/video/cx25840/cx25840.h
+++ b/drivers/media/video/cx25840/cx25840.h
@@ -78,6 +78,7 @@ struct cx25840_state {
 	enum cx25840_video_input vid_input;
 	enum cx25840_audio_input aud_input;
 	u32 audclk_freq;
+	int audmode;
 };
 
 /* ----------------------------------------------------------------------- */
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
diff --git a/drivers/media/video/msp3400-driver.c b/drivers/media/video/msp3400-driver.c
index 994c340..11ea976 100644
--- a/drivers/media/video/msp3400-driver.c
+++ b/drivers/media/video/msp3400-driver.c
@@ -411,9 +411,9 @@ static int msp_mode_v4l2_to_v4l1(int rxs
 	if (rxsubchans & V4L2_TUNER_SUB_STEREO)
 		mode |= VIDEO_SOUND_STEREO;
 	if (rxsubchans & V4L2_TUNER_SUB_LANG2)
-		mode |= VIDEO_SOUND_LANG2;
+		mode |= VIDEO_SOUND_LANG2 | VIDEO_SOUND_STEREO;
 	if (rxsubchans & V4L2_TUNER_SUB_LANG1)
-		mode |= VIDEO_SOUND_LANG1;
+		mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_STEREO;
 	if (mode == 0)
 		mode |= VIDEO_SOUND_MONO;
 	return mode;
@@ -430,21 +430,6 @@ static int msp_mode_v4l1_to_v4l2(int mod
 	return V4L2_TUNER_MODE_MONO;
 }
 
-static void msp_any_detect_stereo(struct i2c_client *client)
-{
-	struct msp_state *state  = i2c_get_clientdata(client);
-
-	switch (state->opmode) {
-	case OPMODE_MANUAL:
-	case OPMODE_AUTODETECT:
-		autodetect_stereo(client);
-		break;
-	case OPMODE_AUTOSELECT:
-		msp34xxg_detect_stereo(client);
-		break;
-	}
-}
-
 static struct v4l2_queryctrl msp_qctrl_std[] = {
 	{
 		.id            = V4L2_CID_AUDIO_VOLUME,
@@ -506,22 +491,6 @@ static struct v4l2_queryctrl msp_qctrl_s
 };
 
 
-static void msp_any_set_audmode(struct i2c_client *client, int audmode)
-{
-	struct msp_state *state = i2c_get_clientdata(client);
-
-	switch (state->opmode) {
-	case OPMODE_MANUAL:
-	case OPMODE_AUTODETECT:
-		state->watch_stereo = 0;
-		msp3400c_setstereo(client, audmode);
-		break;
-	case OPMODE_AUTOSELECT:
-		msp34xxg_set_audmode(client, audmode);
-		break;
-	}
-}
-
 static int msp_get_ctrl(struct i2c_client *client, struct v4l2_control *ctrl)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
@@ -656,7 +625,7 @@ static int msp_command(struct i2c_client
 			msp_set_scart(client, scart, 0);
 			msp_write_dsp(client, 0x000d, 0x1900);
 			if (state->opmode != OPMODE_AUTOSELECT)
-				msp3400c_setstereo(client, state->audmode);
+				msp_set_audmode(client);
 		}
 		msp_wake_thread(client);
 		break;
@@ -670,8 +639,8 @@ static int msp_command(struct i2c_client
 		switch (state->opmode) {
 		case OPMODE_MANUAL:
 			/* set msp3400 to FM radio mode */
-			msp3400c_setmode(client, MSP_MODE_FM_RADIO);
-			msp3400c_setcarrier(client, MSP_CARRIER(10.7),
+			msp3400c_set_mode(client, MSP_MODE_FM_RADIO);
+			msp3400c_set_carrier(client, MSP_CARRIER(10.7),
 					    MSP_CARRIER(10.7));
 			msp_set_audio(client);
 			break;
@@ -705,7 +674,7 @@ static int msp_command(struct i2c_client
 		if (state->radio)
 			break;
 		if (state->opmode == OPMODE_AUTOSELECT)
-			msp_any_detect_stereo(client);
+			msp_detect_stereo(client);
 		va->mode = msp_mode_v4l2_to_v4l1(state->rxsubchans);
 		break;
 	}
@@ -721,8 +690,9 @@ static int msp_command(struct i2c_client
 		state->treble = va->treble;
 		msp_set_audio(client);
 
-		if (va->mode != 0 && state->radio == 0)
-			msp_any_set_audmode(client, msp_mode_v4l1_to_v4l2(va->mode));
+		if (va->mode != 0 && state->radio == 0) {
+			state->audmode = msp_mode_v4l1_to_v4l2(va->mode);
+		}
 		break;
 	}
 
@@ -864,7 +834,7 @@ static int msp_command(struct i2c_client
 			msp_set_scart(client, scart, 0);
 			msp_write_dsp(client, 0x000d, 0x1900);
 		}
-		msp_any_set_audmode(client, state->audmode);
+		msp_set_audmode(client);
 		msp_wake_thread(client);
 		break;
 	}
@@ -876,7 +846,7 @@ static int msp_command(struct i2c_client
 		if (state->radio)
 			break;
 		if (state->opmode == OPMODE_AUTOSELECT)
-			msp_any_detect_stereo(client);
+			msp_detect_stereo(client);
 		vt->audmode    = state->audmode;
 		vt->rxsubchans = state->rxsubchans;
 		vt->capability = V4L2_TUNER_CAP_STEREO |
@@ -890,8 +860,9 @@ static int msp_command(struct i2c_client
 
 		if (state->radio)  /* TODO: add mono/stereo support for radio */
 			break;
+		state->audmode = vt->audmode;
 		/* only set audmode */
-		msp_any_set_audmode(client, vt->audmode);
+		msp_set_audmode(client);
 		break;
 	}
 
@@ -981,7 +952,7 @@ static int msp_command(struct i2c_client
 		const char *p;
 
 		if (state->opmode == OPMODE_AUTOSELECT)
-			msp_any_detect_stereo(client);
+			msp_detect_stereo(client);
 		v4l_info(client, "%s rev1 = 0x%04x rev2 = 0x%04x\n",
 				client->name, state->rev1, state->rev2);
 		v4l_info(client, "Audio:    volume %d%s\n",
@@ -1082,7 +1053,7 @@ static int msp_attach(struct i2c_adapter
 
 	memset(state, 0, sizeof(*state));
 	state->v4l2_std = V4L2_STD_NTSC;
-	state->audmode = V4L2_TUNER_MODE_STEREO;
+	state->audmode = V4L2_TUNER_MODE_LANG1;
 	state->volume = 58880;	/* 0db gain */
 	state->balance = 32768;	/* 0db gain */
 	state->bass = 32768;
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
diff --git a/drivers/media/video/msp3400-kthreads.c b/drivers/media/video/msp3400-kthreads.c
index 3235a15..c4668f4 100644
--- a/drivers/media/video/msp3400-kthreads.c
+++ b/drivers/media/video/msp3400-kthreads.c
@@ -109,7 +109,7 @@ static struct msp3400c_init_data_dem {
 		{-2, -8, -10, 10, 50, 86},
 		{-4, -12, -9, 23, 79, 126},
 		MSP_CARRIER(6.5), MSP_CARRIER(6.5),
-		0x00c6, 0x0140, 0x0120, 0x7c03
+		0x00c6, 0x0140, 0x0120, 0x7c00
 	},
 };
 
@@ -154,53 +154,60 @@ const char *msp_standard_std_name(int st
 	return "unknown";
 }
 
-void msp3400c_setcarrier(struct i2c_client *client, int cdo1, int cdo2)
+void msp_set_source(struct i2c_client *client, u16 src)
+{
+	struct msp_state *state = i2c_get_clientdata(client);
+
+	if (msp_dolby) {
+		msp_write_dsp(client, 0x0008, 0x0520); /* I2S1 */
+		msp_write_dsp(client, 0x0009, 0x0620); /* I2S2 */
+	} else {
+		msp_write_dsp(client, 0x0008, src);
+		msp_write_dsp(client, 0x0009, src);
+	}
+	msp_write_dsp(client, 0x000a, src);
+	msp_write_dsp(client, 0x000b, src);
+	msp_write_dsp(client, 0x000c, src);
+	if (state->has_scart23_in_scart2_out)
+		msp_write_dsp(client, 0x0041, src);
+}
+
+void msp3400c_set_carrier(struct i2c_client *client, int cdo1, int cdo2)
 {
 	msp_write_dem(client, 0x0093, cdo1 & 0xfff);
 	msp_write_dem(client, 0x009b, cdo1 >> 12);
 	msp_write_dem(client, 0x00a3, cdo2 & 0xfff);
 	msp_write_dem(client, 0x00ab, cdo2 >> 12);
-	msp_write_dem(client, 0x0056, 0); /*LOAD_REG_1/2*/
+	msp_write_dem(client, 0x0056, 0); /* LOAD_REG_1/2 */
 }
 
-void msp3400c_setmode(struct i2c_client *client, int type)
+void msp3400c_set_mode(struct i2c_client *client, int mode)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
+	struct msp3400c_init_data_dem *data = &msp3400c_init_data[mode];
 	int i;
 
-	v4l_dbg(1, msp_debug, client, "setmode: %d\n", type);
-	state->mode       = type;
+	v4l_dbg(1, msp_debug, client, "set_mode: %d\n", mode);
+	state->mode = mode;
 	state->rxsubchans = V4L2_TUNER_SUB_MONO;
 
-	msp_write_dem(client, 0x00bb, msp3400c_init_data[type].ad_cv);
+	msp_write_dem(client, 0x00bb, data->ad_cv);
 
 	for (i = 5; i >= 0; i--)               /* fir 1 */
-		msp_write_dem(client, 0x0001, msp3400c_init_data[type].fir1[i]);
+		msp_write_dem(client, 0x0001, data->fir1[i]);
 
 	msp_write_dem(client, 0x0005, 0x0004); /* fir 2 */
 	msp_write_dem(client, 0x0005, 0x0040);
 	msp_write_dem(client, 0x0005, 0x0000);
 	for (i = 5; i >= 0; i--)
-		msp_write_dem(client, 0x0005, msp3400c_init_data[type].fir2[i]);
+		msp_write_dem(client, 0x0005, data->fir2[i]);
 
-	msp_write_dem(client, 0x0083, msp3400c_init_data[type].mode_reg);
+	msp_write_dem(client, 0x0083, data->mode_reg);
 
-	msp3400c_setcarrier(client, msp3400c_init_data[type].cdo1,
-			    msp3400c_init_data[type].cdo2);
+	msp3400c_set_carrier(client, data->cdo1, data->cdo2);
 
-	msp_write_dem(client, 0x0056, 0); /*LOAD_REG_1/2*/
-
-	if (msp_dolby) {
-		msp_write_dsp(client, 0x0008, 0x0520); /* I2S1 */
-		msp_write_dsp(client, 0x0009, 0x0620); /* I2S2 */
-		msp_write_dsp(client, 0x000b, msp3400c_init_data[type].dsp_src);
-	} else {
-		msp_write_dsp(client, 0x0008, msp3400c_init_data[type].dsp_src);
-		msp_write_dsp(client, 0x0009, msp3400c_init_data[type].dsp_src);
-		msp_write_dsp(client, 0x000b, msp3400c_init_data[type].dsp_src);
-	}
-	msp_write_dsp(client, 0x000a, msp3400c_init_data[type].dsp_src);
-	msp_write_dsp(client, 0x000e, msp3400c_init_data[type].dsp_matrix);
+	msp_set_source(client, data->dsp_src);
+	msp_write_dsp(client, 0x000e, data->dsp_matrix);
 
 	if (state->has_nicam) {
 		/* nicam prescale */
@@ -208,29 +215,31 @@ void msp3400c_setmode(struct i2c_client 
 	}
 }
 
-/* turn on/off nicam + stereo */
-void msp3400c_setstereo(struct i2c_client *client, int audmode)
+/* Set audio mode. Note that the pre-'G' models do not support BTSC+SAP,
+   nor do they support stereo BTSC. */
+void msp3400c_set_audmode(struct i2c_client *client)
 {
 	static char *strmode[] = { "mono", "stereo", "lang2", "lang1" };
 	struct msp_state *state = i2c_get_clientdata(client);
-	int nicam = 0;		/* channel source: FM/AM or nicam */
-	int src = 0;
+	char *modestr = (state->audmode >= 0 && state->audmode < 4) ?
+		strmode[state->audmode] : "unknown";
+	int src = 0;	/* channel source: FM/AM, nicam or SCART */
 
 	if (state->opmode == OPMODE_AUTOSELECT) {
 		/* this method would break everything, let's make sure
 		 * it's never called
 		 */
-		v4l_dbg(1, msp_debug, client, "setstereo called with mode=%d instead of set_source (ignored)\n",
-		     audmode);
+		v4l_dbg(1, msp_debug, client,
+			"set_audmode called with mode=%d instead of set_source (ignored)\n",
+			state->audmode);
 		return;
 	}
 
 	/* switch demodulator */
 	switch (state->mode) {
 	case MSP_MODE_FM_TERRA:
-		v4l_dbg(1, msp_debug, client, "FM setstereo: %s\n", strmode[audmode]);
-		msp3400c_setcarrier(client, state->second, state->main);
-		switch (audmode) {
+		v4l_dbg(1, msp_debug, client, "FM set_audmode: %s\n", modestr);
+		switch (state->audmode) {
 		case V4L2_TUNER_MODE_STEREO:
 			msp_write_dsp(client, 0x000e, 0x3001);
 			break;
@@ -242,50 +251,49 @@ void msp3400c_setstereo(struct i2c_clien
 		}
 		break;
 	case MSP_MODE_FM_SAT:
-		v4l_dbg(1, msp_debug, client, "SAT setstereo: %s\n", strmode[audmode]);
-		switch (audmode) {
+		v4l_dbg(1, msp_debug, client, "SAT set_audmode: %s\n", modestr);
+		switch (state->audmode) {
 		case V4L2_TUNER_MODE_MONO:
-			msp3400c_setcarrier(client, MSP_CARRIER(6.5), MSP_CARRIER(6.5));
+			msp3400c_set_carrier(client, MSP_CARRIER(6.5), MSP_CARRIER(6.5));
 			break;
 		case V4L2_TUNER_MODE_STEREO:
-			msp3400c_setcarrier(client, MSP_CARRIER(7.2), MSP_CARRIER(7.02));
+			msp3400c_set_carrier(client, MSP_CARRIER(7.2), MSP_CARRIER(7.02));
 			break;
 		case V4L2_TUNER_MODE_LANG1:
-			msp3400c_setcarrier(client, MSP_CARRIER(7.38), MSP_CARRIER(7.02));
+			msp3400c_set_carrier(client, MSP_CARRIER(7.38), MSP_CARRIER(7.02));
 			break;
 		case V4L2_TUNER_MODE_LANG2:
-			msp3400c_setcarrier(client, MSP_CARRIER(7.38), MSP_CARRIER(7.02));
+			msp3400c_set_carrier(client, MSP_CARRIER(7.38), MSP_CARRIER(7.02));
 			break;
 		}
 		break;
 	case MSP_MODE_FM_NICAM1:
 	case MSP_MODE_FM_NICAM2:
 	case MSP_MODE_AM_NICAM:
-		v4l_dbg(1, msp_debug, client, "NICAM setstereo: %s\n",strmode[audmode]);
-		msp3400c_setcarrier(client,state->second,state->main);
+		v4l_dbg(1, msp_debug, client, "NICAM set_audmode: %s\n",modestr);
+		msp3400c_set_carrier(client, state->second, state->main);
 		if (state->nicam_on)
-			nicam=0x0100;
+			src = 0x0100;  /* NICAM */
 		break;
 	case MSP_MODE_BTSC:
-		v4l_dbg(1, msp_debug, client, "BTSC setstereo: %s\n",strmode[audmode]);
-		nicam=0x0300;
+		v4l_dbg(1, msp_debug, client, "BTSC set_audmode: %s\n",modestr);
 		break;
 	case MSP_MODE_EXTERN:
-		v4l_dbg(1, msp_debug, client, "extern setstereo: %s\n",strmode[audmode]);
-		nicam = 0x0200;
+		v4l_dbg(1, msp_debug, client, "extern set_audmode: %s\n",modestr);
+		src = 0x0200;  /* SCART */
 		break;
 	case MSP_MODE_FM_RADIO:
-		v4l_dbg(1, msp_debug, client, "FM-Radio setstereo: %s\n",strmode[audmode]);
+		v4l_dbg(1, msp_debug, client, "FM-Radio set_audmode: %s\n",modestr);
 		break;
 	default:
-		v4l_dbg(1, msp_debug, client, "mono setstereo\n");
+		v4l_dbg(1, msp_debug, client, "mono set_audmode\n");
 		return;
 	}
 
 	/* switch audio */
-	switch (audmode) {
+	switch (state->audmode) {
 	case V4L2_TUNER_MODE_STEREO:
-		src = 0x0020 | nicam;
+		src |= 0x0020;
 		break;
 	case V4L2_TUNER_MODE_MONO:
 		if (state->mode == MSP_MODE_AM_NICAM) {
@@ -296,29 +304,22 @@ void msp3400c_setstereo(struct i2c_clien
 			src = 0x0200;
 			break;
 		}
+		if (state->rxsubchans & V4L2_TUNER_SUB_STEREO)
+			src = 0x0030;
+		break;
 	case V4L2_TUNER_MODE_LANG1:
-		src = 0x0000 | nicam;
+		/* switch to stereo for stereo transmission, otherwise
+		   keep first language */
+		if (state->rxsubchans & V4L2_TUNER_SUB_STEREO)
+			src |= 0x0020;
 		break;
 	case V4L2_TUNER_MODE_LANG2:
-		src = 0x0010 | nicam;
+		src |= 0x0010;
 		break;
 	}
-	v4l_dbg(1, msp_debug, client, "setstereo final source/matrix = 0x%x\n", src);
+	v4l_dbg(1, msp_debug, client, "set_audmode final source/matrix = 0x%x\n", src);
 
-	if (msp_dolby) {
-		msp_write_dsp(client, 0x0008, 0x0520);
-		msp_write_dsp(client, 0x0009, 0x0620);
-		msp_write_dsp(client, 0x000a, src);
-		msp_write_dsp(client, 0x000b, src);
-	} else {
-		msp_write_dsp(client, 0x0008, src);
-		msp_write_dsp(client, 0x0009, src);
-		msp_write_dsp(client, 0x000a, src);
-		msp_write_dsp(client, 0x000b, src);
-		msp_write_dsp(client, 0x000c, src);
-		if (state->has_scart23_in_scart2_out)
-			msp_write_dsp(client, 0x0041, src);
-	}
+	msp_set_source(client, src);
 }
 
 static void msp3400c_print_mode(struct i2c_client *client)
@@ -346,12 +347,12 @@ static void msp3400c_print_mode(struct i
 
 /* ----------------------------------------------------------------------- */
 
-int autodetect_stereo(struct i2c_client *client)
+static int msp3400c_detect_stereo(struct i2c_client *client)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 	int val;
 	int rxsubchans = state->rxsubchans;
-	int newnicam   = state->nicam_on;
+	int newnicam = state->nicam_on;
 	int update = 0;
 
 	switch (state->mode) {
@@ -361,7 +362,7 @@ int autodetect_stereo(struct i2c_client 
 			val -= 65536;
 		v4l_dbg(2, msp_debug, client, "stereo detect register: %d\n", val);
 		if (val > 4096) {
-			rxsubchans = V4L2_TUNER_SUB_STEREO | V4L2_TUNER_SUB_MONO;
+			rxsubchans = V4L2_TUNER_SUB_STEREO;
 		} else if (val < -4096) {
 			rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 		} else {
@@ -385,14 +386,11 @@ int autodetect_stereo(struct i2c_client 
 				break;
 			case 1:
 			case 9:
-				rxsubchans = V4L2_TUNER_SUB_MONO
-					| V4L2_TUNER_SUB_LANG1;
+				rxsubchans = V4L2_TUNER_SUB_MONO;
 				break;
 			case 2:
 			case 10:
-				rxsubchans = V4L2_TUNER_SUB_MONO
-					| V4L2_TUNER_SUB_LANG1
-					| V4L2_TUNER_SUB_LANG2;
+				rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 				break;
 			default:
 				rxsubchans = V4L2_TUNER_SUB_MONO;
@@ -404,30 +402,17 @@ int autodetect_stereo(struct i2c_client 
 			rxsubchans = V4L2_TUNER_SUB_MONO;
 		}
 		break;
-	case MSP_MODE_BTSC:
-		val = msp_read_dem(client, 0x200);
-		v4l_dbg(2, msp_debug, client, "status=0x%x (pri=%s, sec=%s, %s%s%s)\n",
-			val,
-			(val & 0x0002) ? "no"     : "yes",
-			(val & 0x0004) ? "no"     : "yes",
-			(val & 0x0040) ? "stereo" : "mono",
-			(val & 0x0080) ? ", nicam 2nd mono" : "",
-			(val & 0x0100) ? ", bilingual/SAP"  : "");
-		rxsubchans = V4L2_TUNER_SUB_MONO;
-		if (val & 0x0040) rxsubchans |= V4L2_TUNER_SUB_STEREO;
-		if (val & 0x0100) rxsubchans |= V4L2_TUNER_SUB_LANG1;
-		break;
 	}
 	if (rxsubchans != state->rxsubchans) {
 		update = 1;
-		v4l_dbg(1, msp_debug, client, "watch: rxsubchans %d => %d\n",
-			state->rxsubchans,rxsubchans);
+		v4l_dbg(1, msp_debug, client, "watch: rxsubchans %02x => %02x\n",
+			state->rxsubchans, rxsubchans);
 		state->rxsubchans = rxsubchans;
 	}
 	if (newnicam != state->nicam_on) {
 		update = 1;
 		v4l_dbg(1, msp_debug, client, "watch: nicam %d => %d\n",
-			state->nicam_on,newnicam);
+			state->nicam_on, newnicam);
 		state->nicam_on = newnicam;
 	}
 	return update;
@@ -442,13 +427,8 @@ static void watch_stereo(struct i2c_clie
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 
-	if (autodetect_stereo(client)) {
-		if (state->rxsubchans & V4L2_TUNER_SUB_STEREO)
-			msp3400c_setstereo(client, V4L2_TUNER_MODE_STEREO);
-		else if (state->rxsubchans & V4L2_TUNER_SUB_LANG1)
-			msp3400c_setstereo(client, V4L2_TUNER_MODE_LANG1);
-		else
-			msp3400c_setstereo(client, V4L2_TUNER_MODE_MONO);
+	if (msp3400c_detect_stereo(client)) {
+		msp3400c_set_audmode(client);
 	}
 
 	if (msp_once)
@@ -460,7 +440,7 @@ int msp3400c_thread(void *data)
 	struct i2c_client *client = data;
 	struct msp_state *state = i2c_get_clientdata(client);
 	struct msp3400c_carrier_detect *cd;
-	int count, max1,max2,val1,val2, val,this;
+	int count, max1, max2, val1, val2, val, this;
 
 
 	v4l_dbg(1, msp_debug, client, "msp3400 daemon started\n");
@@ -470,7 +450,7 @@ int msp3400c_thread(void *data)
 		v4l_dbg(2, msp_debug, client, "msp3400 thread: wakeup\n");
 
 	restart:
-		v4l_dbg(1, msp_debug, client, "thread: restart scan\n");
+		v4l_dbg(2, msp_debug, client, "thread: restart scan\n");
 		state->restart = 0;
 		if (kthread_should_stop())
 			break;
@@ -484,13 +464,14 @@ int msp3400c_thread(void *data)
 
 		/* mute */
 		msp_set_mute(client);
-		msp3400c_setmode(client, MSP_MODE_AM_DETECT /* +1 */ );
+		msp3400c_set_mode(client, MSP_MODE_AM_DETECT /* +1 */ );
 		val1 = val2 = 0;
 		max1 = max2 = -1;
 		state->watch_stereo = 0;
+		state->nicam_on = 0;
 
 		/* some time for the tuner to sync */
-		if (msp_sleep(state,200))
+		if (msp_sleep(state, 200))
 			goto restart;
 
 		/* carrier detect pass #1 -- main carrier */
@@ -505,7 +486,7 @@ int msp3400c_thread(void *data)
 		}
 
 		for (this = 0; this < count; this++) {
-			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
+			msp3400c_set_carrier(client, cd[this].cdo, cd[this].cdo);
 			if (msp_sleep(state,100))
 				goto restart;
 			val = msp_read_dsp(client, 0x1b);
@@ -541,7 +522,7 @@ int msp3400c_thread(void *data)
 			max2 = 0;
 		}
 		for (this = 0; this < count; this++) {
-			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
+			msp3400c_set_carrier(client, cd[this].cdo, cd[this].cdo);
 			if (msp_sleep(state,100))
 				goto restart;
 			val = msp_read_dsp(client, 0x1b);
@@ -553,22 +534,20 @@ int msp3400c_thread(void *data)
 		}
 
 		/* program the msp3400 according to the results */
-		state->main   = msp3400c_carrier_detect_main[max1].cdo;
+		state->main = msp3400c_carrier_detect_main[max1].cdo;
 		switch (max1) {
 		case 1: /* 5.5 */
 			if (max2 == 0) {
 				/* B/G FM-stereo */
 				state->second = msp3400c_carrier_detect_55[max2].cdo;
-				msp3400c_setmode(client, MSP_MODE_FM_TERRA);
-				state->nicam_on = 0;
-				msp3400c_setstereo(client, V4L2_TUNER_MODE_MONO);
+				msp3400c_set_mode(client, MSP_MODE_FM_TERRA);
 				state->watch_stereo = 1;
 			} else if (max2 == 1 && state->has_nicam) {
 				/* B/G NICAM */
 				state->second = msp3400c_carrier_detect_55[max2].cdo;
-				msp3400c_setmode(client, MSP_MODE_FM_NICAM1);
+				msp3400c_set_mode(client, MSP_MODE_FM_NICAM1);
+				msp3400c_set_carrier(client, state->second, state->main);
 				state->nicam_on = 1;
-				msp3400c_setcarrier(client, state->second, state->main);
 				state->watch_stereo = 1;
 			} else {
 				goto no_second;
@@ -577,35 +556,31 @@ int msp3400c_thread(void *data)
 		case 2: /* 6.0 */
 			/* PAL I NICAM */
 			state->second = MSP_CARRIER(6.552);
-			msp3400c_setmode(client, MSP_MODE_FM_NICAM2);
+			msp3400c_set_mode(client, MSP_MODE_FM_NICAM2);
+			msp3400c_set_carrier(client, state->second, state->main);
 			state->nicam_on = 1;
-			msp3400c_setcarrier(client, state->second, state->main);
 			state->watch_stereo = 1;
 			break;
 		case 3: /* 6.5 */
 			if (max2 == 1 || max2 == 2) {
 				/* D/K FM-stereo */
 				state->second = msp3400c_carrier_detect_65[max2].cdo;
-				msp3400c_setmode(client, MSP_MODE_FM_TERRA);
-				state->nicam_on = 0;
-				msp3400c_setstereo(client, V4L2_TUNER_MODE_MONO);
+				msp3400c_set_mode(client, MSP_MODE_FM_TERRA);
 				state->watch_stereo = 1;
 			} else if (max2 == 0 && (state->v4l2_std & V4L2_STD_SECAM)) {
 				/* L NICAM or AM-mono */
 				state->second = msp3400c_carrier_detect_65[max2].cdo;
-				msp3400c_setmode(client, MSP_MODE_AM_NICAM);
-				state->nicam_on = 0;
-				msp3400c_setstereo(client, V4L2_TUNER_MODE_MONO);
-				msp3400c_setcarrier(client, state->second, state->main);
+				msp3400c_set_mode(client, MSP_MODE_AM_NICAM);
+				msp3400c_set_carrier(client, state->second, state->main);
 				/* volume prescale for SCART (AM mono input) */
 				msp_write_dsp(client, 0x000d, 0x1900);
 				state->watch_stereo = 1;
 			} else if (max2 == 0 && state->has_nicam) {
 				/* D/K NICAM */
 				state->second = msp3400c_carrier_detect_65[max2].cdo;
-				msp3400c_setmode(client, MSP_MODE_FM_NICAM1);
+				msp3400c_set_mode(client, MSP_MODE_FM_NICAM1);
+				msp3400c_set_carrier(client, state->second, state->main);
 				state->nicam_on = 1;
-				msp3400c_setcarrier(client, state->second, state->main);
 				state->watch_stereo = 1;
 			} else {
 				goto no_second;
@@ -615,23 +590,25 @@ int msp3400c_thread(void *data)
 		default:
 		no_second:
 			state->second = msp3400c_carrier_detect_main[max1].cdo;
-			msp3400c_setmode(client, MSP_MODE_FM_TERRA);
-			state->nicam_on = 0;
-			msp3400c_setcarrier(client, state->second, state->main);
+			msp3400c_set_mode(client, MSP_MODE_FM_TERRA);
+			msp3400c_set_carrier(client, state->second, state->main);
 			state->rxsubchans = V4L2_TUNER_SUB_MONO;
-			msp3400c_setstereo(client, V4L2_TUNER_MODE_MONO);
 			break;
 		}
 
 		/* unmute */
 		msp_set_audio(client);
+		msp3400c_set_audmode(client);
 
 		if (msp_debug)
 			msp3400c_print_mode(client);
 
-		/* monitor tv audio mode */
+		/* monitor tv audio mode, the first time don't wait
+		   so long to get a quick stereo/bilingual result */
+		if (msp_sleep(state, 1000))
+			goto restart;
 		while (state->watch_stereo) {
-			if (msp_sleep(state,5000))
+			if (msp_sleep(state, 5000))
 				goto restart;
 			watch_stereo(client);
 		}
@@ -655,7 +632,7 @@ int msp3410d_thread(void *data)
 		v4l_dbg(2, msp_debug, client, "msp3410 thread: wakeup\n");
 
 	restart:
-		v4l_dbg(1, msp_debug, client, "thread: restart scan\n");
+		v4l_dbg(2, msp_debug, client, "thread: restart scan\n");
 		state->restart = 0;
 		if (kthread_should_stop())
 			break;
@@ -680,9 +657,10 @@ int msp3410d_thread(void *data)
 		else
 			std = (state->v4l2_std & V4L2_STD_NTSC) ? 0x20 : 1;
 		state->watch_stereo = 0;
+		state->nicam_on = 0;
 
 		if (msp_debug)
-			v4l_dbg(1, msp_debug, client, "setting standard: %s (0x%04x)\n",
+			v4l_dbg(2, msp_debug, client, "setting standard: %s (0x%04x)\n",
 			       msp_standard_std_name(std), std);
 
 		if (std != 1) {
@@ -699,7 +677,7 @@ int msp3410d_thread(void *data)
 				val = msp_read_dem(client, 0x7e);
 				if (val < 0x07ff)
 					break;
-				v4l_dbg(1, msp_debug, client, "detection still in progress\n");
+				v4l_dbg(2, msp_debug, client, "detection still in progress\n");
 			}
 		}
 		for (i = 0; msp_stdlist[i].name != NULL; i++)
@@ -738,46 +716,34 @@ int msp3410d_thread(void *data)
 			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
 			state->nicam_on = 1;
 			state->watch_stereo = 1;
-			msp3400c_setstereo(client,V4L2_TUNER_MODE_STEREO);
 			break;
 		case 0x0009:
 			state->mode = MSP_MODE_AM_NICAM;
 			state->rxsubchans = V4L2_TUNER_SUB_MONO;
 			state->nicam_on = 1;
-			msp3400c_setstereo(client,V4L2_TUNER_MODE_MONO);
 			state->watch_stereo = 1;
 			break;
 		case 0x0020: /* BTSC */
-			/* just turn on stereo */
+			/* The pre-'G' models only have BTSC-mono */
 			state->mode = MSP_MODE_BTSC;
-			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
-			state->nicam_on = 0;
-			state->watch_stereo = 1;
-			msp3400c_setstereo(client,V4L2_TUNER_MODE_STEREO);
+			state->rxsubchans = V4L2_TUNER_SUB_MONO;
 			break;
 		case 0x0040: /* FM radio */
 			state->mode = MSP_MODE_FM_RADIO;
 			state->rxsubchans = V4L2_TUNER_SUB_STEREO;
-			state->nicam_on = 0;
-			state->watch_stereo = 0;
 			/* not needed in theory if we have radio, but
 			   short programming enables carrier mute */
-			msp3400c_setmode(client, MSP_MODE_FM_RADIO);
-			msp3400c_setcarrier(client, MSP_CARRIER(10.7),
+			msp3400c_set_mode(client, MSP_MODE_FM_RADIO);
+			msp3400c_set_carrier(client, MSP_CARRIER(10.7),
 					    MSP_CARRIER(10.7));
-			/* scart routing */
+			/* scart routing (this doesn't belong here I think) */
 			msp_set_scart(client,SCART_IN2,0);
-			/* msp34xx does radio decoding */
-			msp_write_dsp(client, 0x08, 0x0020);
-			msp_write_dsp(client, 0x09, 0x0020);
-			msp_write_dsp(client, 0x0b, 0x0020);
 			break;
 		case 0x0003:
 		case 0x0004:
 		case 0x0005:
 			state->mode = MSP_MODE_FM_TERRA;
 			state->rxsubchans = V4L2_TUNER_SUB_MONO;
-			state->nicam_on = 0;
 			state->watch_stereo = 1;
 			break;
 		}
@@ -788,11 +754,16 @@ int msp3410d_thread(void *data)
 		if (state->has_i2s_conf)
 			msp_write_dem(client, 0x40, state->i2s_mode);
 
-		/* monitor tv audio mode */
+		msp3400c_set_audmode(client);
+
+		/* monitor tv audio mode, the first time don't wait
+		   so long to get a quick stereo/bilingual result */
+		if (msp_sleep(state, 1000))
+			goto restart;
 		while (state->watch_stereo) {
-			if (msp_sleep(state,5000))
-				goto restart;
 			watch_stereo(client);
+			if (msp_sleep(state, 5000))
+				goto restart;
 		}
 	}
 	v4l_dbg(1, msp_debug, client, "thread: exit\n");
@@ -810,7 +781,7 @@ int msp3410d_thread(void *data)
  * the value for source is the same as bit 15:8 of DSP registers 0x08,
  * 0x0a and 0x0c: 0=mono, 1=stereo or A|B, 2=SCART, 3=stereo or A, 4=stereo or B
  *
- * this function replaces msp3400c_setstereo
+ * this function replaces msp3400c_set_audmode
  */
 static void msp34xxg_set_source(struct i2c_client *client, int source)
 {
@@ -823,12 +794,7 @@ static void msp34xxg_set_source(struct i
 	int value = (source & 0x07) << 8 | (source == 0 ? 0x30 : 0x20);
 
 	v4l_dbg(1, msp_debug, client, "set source to %d (0x%x)\n", source, value);
-	/* Loudspeaker Output */
-	msp_write_dsp(client, 0x08, value);
-	/* SCART1 DA Output */
-	msp_write_dsp(client, 0x0a, value);
-	/* Quasi-peak detector */
-	msp_write_dsp(client, 0x0c, value);
+	msp_set_source(client, value);
 	/*
 	 * set identification threshold. Personally, I
 	 * I set it to a higher value that the default
@@ -945,13 +911,14 @@ int msp34xxg_thread(void *data)
 		if (msp_write_dsp(client, 0x13, state->acb))
 			return -1;
 
-		msp_write_dem(client, 0x40, state->i2s_mode);
+		if (state->has_i2s_conf)
+			msp_write_dem(client, 0x40, state->i2s_mode);
 	}
 	v4l_dbg(1, msp_debug, client, "thread: exit\n");
 	return 0;
 }
 
-void msp34xxg_detect_stereo(struct i2c_client *client)
+static void msp34xxg_detect_stereo(struct i2c_client *client)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 
@@ -961,11 +928,11 @@ void msp34xxg_detect_stereo(struct i2c_c
 
 	state->rxsubchans = 0;
 	if (is_stereo)
-		state->rxsubchans |= V4L2_TUNER_SUB_STEREO;
+		state->rxsubchans = V4L2_TUNER_SUB_STEREO;
 	else
-		state->rxsubchans |= V4L2_TUNER_SUB_MONO;
+		state->rxsubchans = V4L2_TUNER_SUB_MONO;
 	if (is_bilingual) {
-		state->rxsubchans |= V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
+		state->rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 		/* I'm supposed to check whether it's SAP or not
 		 * and set only LANG2/SAP in this case. Yet, the MSP
 		 * does a lot of work to hide this and handle everything
@@ -977,12 +944,12 @@ void msp34xxg_detect_stereo(struct i2c_c
 		status, is_stereo, is_bilingual, state->rxsubchans);
 }
 
-void msp34xxg_set_audmode(struct i2c_client *client, int audmode)
+void msp34xxg_set_audmode(struct i2c_client *client)
 {
 	struct msp_state *state = i2c_get_clientdata(client);
 	int source;
 
-	switch (audmode) {
+	switch (state->audmode) {
 	case V4L2_TUNER_MODE_MONO:
 		source = 0; /* mono only */
 		break;
@@ -997,11 +964,40 @@ void msp34xxg_set_audmode(struct i2c_cli
 		source = 4; /* stereo or B */
 		break;
 	default:
-		audmode = 0;
 		source  = 1;
 		break;
 	}
-	state->audmode = audmode;
 	msp34xxg_set_source(client, source);
 }
 
+void msp_set_audmode(struct i2c_client *client)
+{
+	struct msp_state *state = i2c_get_clientdata(client);
+
+	switch (state->opmode) {
+	case OPMODE_MANUAL:
+	case OPMODE_AUTODETECT:
+		state->watch_stereo = 0;
+		msp3400c_set_audmode(client);
+		break;
+	case OPMODE_AUTOSELECT:
+		msp34xxg_set_audmode(client);
+		break;
+	}
+}
+
+void msp_detect_stereo(struct i2c_client *client)
+{
+	struct msp_state *state  = i2c_get_clientdata(client);
+
+	switch (state->opmode) {
+	case OPMODE_MANUAL:
+	case OPMODE_AUTODETECT:
+		msp3400c_detect_stereo(client);
+		break;
+	case OPMODE_AUTOSELECT:
+		msp34xxg_detect_stereo(client);
+		break;
+	}
+}
+
diff --git a/drivers/media/video/msp3400.h b/drivers/media/video/msp3400.h
diff --git a/drivers/media/video/msp3400.h b/drivers/media/video/msp3400.h
index a9ac57d..4182830 100644
--- a/drivers/media/video/msp3400.h
+++ b/drivers/media/video/msp3400.h
@@ -104,14 +104,13 @@ int msp_sleep(struct msp_state *state, i
 
 /* msp3400-kthreads.c */
 const char *msp_standard_std_name(int std);
-void msp3400c_setcarrier(struct i2c_client *client, int cdo1, int cdo2);
-void msp3400c_setmode(struct i2c_client *client, int type);
-void msp3400c_setstereo(struct i2c_client *client, int mode);
-int autodetect_stereo(struct i2c_client *client);
+void msp_set_source(struct i2c_client *client, u16 src);
+void msp_set_audmode(struct i2c_client *client);
+void msp_detect_stereo(struct i2c_client *client);
 int msp3400c_thread(void *data);
 int msp3410d_thread(void *data);
 int msp34xxg_thread(void *data);
-void msp34xxg_detect_stereo(struct i2c_client *client);
-void msp34xxg_set_audmode(struct i2c_client *client, int audmode);
+void msp3400c_set_mode(struct i2c_client *client, int mode);
+void msp3400c_set_carrier(struct i2c_client *client, int cdo1, int cdo2);
 
 #endif /* MSP3400_H */
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 2995b22..af3e7bb 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -398,15 +398,16 @@ static void tuner_status(struct i2c_clie
 	tuner_info("Tuner mode:      %s\n", p);
 	tuner_info("Frequency:       %lu.%02lu MHz\n", freq, freq_fraction);
 	tuner_info("Standard:        0x%08llx\n", t->std);
-	if (t->mode == V4L2_TUNER_RADIO) {
-		if (t->has_signal) {
-			tuner_info("Signal strength: %d\n", t->has_signal(client));
-		}
-		if (t->is_stereo) {
-			tuner_info("Stereo:          %s\n", t->is_stereo(client) ? "yes" : "no");
-		}
+	if (t->mode != V4L2_TUNER_RADIO)
+	       return;
+	if (t->has_signal) {
+		tuner_info("Signal strength: %d\n", t->has_signal(client));
+	}
+	if (t->is_stereo) {
+		tuner_info("Stereo:          %s\n", t->is_stereo(client) ? "yes" : "no");
 	}
 }
+
 /* ---------------------------------------------------------------------- */
 
 /* static var Used only in tuner_attach and tuner_probe */
@@ -737,33 +738,29 @@ static int tuner_command(struct i2c_clie
 				return 0;
 			switch_v4l2();
 
-			if (V4L2_TUNER_RADIO == t->mode) {
-
-				if (t->has_signal)
-					tuner->signal = t->has_signal(client);
-
-				if (t->is_stereo) {
-					if (t->is_stereo(client)) {
-						tuner->rxsubchans =
-						    V4L2_TUNER_SUB_STEREO |
-						    V4L2_TUNER_SUB_MONO;
-					} else {
-						tuner->rxsubchans =
-						    V4L2_TUNER_SUB_MONO;
-					}
-				}
-
-				tuner->capability |=
-				    V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
-
-				tuner->audmode = t->audmode;
-
-				tuner->rangelow = radio_range[0] * 16000;
-				tuner->rangehigh = radio_range[1] * 16000;
-			} else {
+			tuner->type = t->mode;
+			if (t->mode != V4L2_TUNER_RADIO) {
 				tuner->rangelow = tv_range[0] * 16;
 				tuner->rangehigh = tv_range[1] * 16;
+				break;
 			}
+
+			/* radio mode */
+			if (t->has_signal)
+				tuner->signal = t->has_signal(client);
+
+			tuner->rxsubchans =
+				V4L2_TUNER_SUB_MONO | V4L2_TUNER_SUB_STEREO;
+			if (t->is_stereo) {
+				tuner->rxsubchans = t->is_stereo(client) ?
+					V4L2_TUNER_SUB_STEREO : V4L2_TUNER_SUB_MONO;
+			}
+
+			tuner->capability |=
+			    V4L2_TUNER_CAP_LOW | V4L2_TUNER_CAP_STEREO;
+			tuner->audmode = t->audmode;
+			tuner->rangelow = radio_range[0] * 16000;
+			tuner->rangehigh = radio_range[1] * 16000;
 			break;
 		}
 	case VIDIOC_S_TUNER:
@@ -775,10 +772,11 @@ static int tuner_command(struct i2c_clie
 
 			switch_v4l2();
 
-			if (V4L2_TUNER_RADIO == t->mode) {
-				t->audmode = tuner->audmode;
-				set_radio_freq(client, t->radio_freq);
-			}
+			/* do nothing unless we're a radio tuner */
+			if (t->mode != V4L2_TUNER_RADIO)
+				break;
+			t->audmode = tuner->audmode;
+			set_radio_freq(client, t->radio_freq);
 			break;
 		}
 	case VIDIOC_LOG_STATUS:
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
diff --git a/drivers/media/video/tvaudio.c b/drivers/media/video/tvaudio.c
index c8e5ad0..4efb01b 100644
--- a/drivers/media/video/tvaudio.c
+++ b/drivers/media/video/tvaudio.c
@@ -130,6 +130,7 @@ struct CHIPSTATE {
 	struct timer_list    wt;
 	int                  done;
 	int                  watch_stereo;
+	int 		     audmode;
 };
 
 /* ---------------------------------------------------------------------- */
@@ -1514,6 +1515,7 @@ static int chip_attach(struct i2c_adapte
 	chip->type = desc-chiplist;
 	chip->shadow.count = desc->registers+1;
 	chip->prevmode = -1;
+	chip->audmode = V4L2_TUNER_MODE_LANG1;
 	/* register */
 	i2c_attach_client(&chip->c);
 
@@ -1671,6 +1673,8 @@ static int chip_command(struct i2c_clien
 		struct v4l2_tuner *vt = arg;
 		int mode = 0;
 
+		if (chip->radio)
+			break;
 		switch (vt->audmode) {
 		case V4L2_TUNER_MODE_MONO:
 			mode = VIDEO_SOUND_MONO;
@@ -1685,8 +1689,9 @@ static int chip_command(struct i2c_clien
 			mode = VIDEO_SOUND_LANG2;
 			break;
 		default:
-			break;
+			return -EINVAL;
 		}
+		chip->audmode = vt->audmode;
 
 		if (desc->setmode && mode) {
 			chip->watch_stereo = 0;
@@ -1704,7 +1709,7 @@ static int chip_command(struct i2c_clien
 
 		if (chip->radio)
 			break;
-		vt->audmode = 0;
+		vt->audmode = chip->audmode;
 		vt->rxsubchans = 0;
 		vt->capability = V4L2_TUNER_CAP_STEREO |
 			V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2;
@@ -1716,19 +1721,12 @@ static int chip_command(struct i2c_clien
 			vt->rxsubchans |= V4L2_TUNER_SUB_MONO;
 		if (mode & VIDEO_SOUND_STEREO)
 			vt->rxsubchans |= V4L2_TUNER_SUB_STEREO;
+		/* Note: for SAP it should be mono/lang2 or stereo/lang2.
+		   When this module is converted fully to v4l2, then this
+		   should change for those chips that can detect SAP. */
 		if (mode & VIDEO_SOUND_LANG1)
-			vt->rxsubchans |= V4L2_TUNER_SUB_LANG1 |
-					  V4L2_TUNER_SUB_LANG2;
-
-		mode = chip->mode;
-		if (mode & VIDEO_SOUND_MONO)
-			vt->audmode = V4L2_TUNER_MODE_MONO;
-		if (mode & VIDEO_SOUND_STEREO)
-			vt->audmode = V4L2_TUNER_MODE_STEREO;
-		if (mode & VIDEO_SOUND_LANG1)
-			vt->audmode = V4L2_TUNER_MODE_LANG1;
-		if (mode & VIDEO_SOUND_LANG2)
-			vt->audmode = V4L2_TUNER_MODE_LANG2;
+			vt->rxsubchans = V4L2_TUNER_SUB_LANG1 |
+					 V4L2_TUNER_SUB_LANG2;
 		break;
 	}
 

