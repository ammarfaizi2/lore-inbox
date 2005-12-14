Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVLNDQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVLNDQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVLNDQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:16:12 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:26016 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030321AbVLNDQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:16:08 -0500
Message-Id: <20051214031459.544945000@localhost>
References: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:46 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org,
       Peter Beutner <p.beutner@gmx.net>, Alex Woods <linux-dvb@giblets.org>
Subject: [patch-mm 2/6] V4L/DVB (3154): TTUSB DEC driver patch roundup
Content-Disposition: inline; filename=v4l_dvb_3154_ttusb_dec_driver_patch_roundup.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Woods <linux-dvb@giblets.org>

- Collection of patches from Peter Beutner addressing:
- add symbolrates to the DVB-S frontend description
- fix capability flags in DVB-S frontend describtion
- remove some void casts
- disable zig-zag scanning as it makes no sense for DVB-T
- set sensible min_delay value
- return an error for requested filter types the driver can't handle

Signed-off-by: Peter Beutner <p.beutner@gmx.net>
Signed-off-by: Alex Woods <linux-dvb@giblets.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/dvb/ttusb-dec/ttusb_dec.c  |   15 ++++----
 drivers/media/dvb/ttusb-dec/ttusbdecfe.c |   53 ++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 12 deletions(-)

--- git.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c
+++ git/drivers/media/dvb/ttusb-dec/ttusb_dec.c
@@ -369,7 +369,7 @@ static int ttusb_dec_get_stb_state (stru
 
 static int ttusb_dec_audio_pes2ts_cb(void *priv, unsigned char *data)
 {
-	struct ttusb_dec *dec = (struct ttusb_dec *)priv;
+	struct ttusb_dec *dec = priv;
 
 	dec->audio_filter->feed->cb.ts(data, 188, NULL, 0,
 				       &dec->audio_filter->feed->feed.ts,
@@ -380,7 +380,7 @@ static int ttusb_dec_audio_pes2ts_cb(voi
 
 static int ttusb_dec_video_pes2ts_cb(void *priv, unsigned char *data)
 {
-	struct ttusb_dec *dec = (struct ttusb_dec *)priv;
+	struct ttusb_dec *dec = priv;
 
 	dec->video_filter->feed->cb.ts(data, 188, NULL, 0,
 				       &dec->video_filter->feed->feed.ts,
@@ -965,8 +965,8 @@ static int ttusb_dec_start_ts_feed(struc
 
 	case DMX_TS_PES_TELETEXT:
 		dec->pid[DMX_PES_TELETEXT] = dvbdmxfeed->pid;
-		dprintk("  pes_type: DMX_TS_PES_TELETEXT\n");
-		break;
+		dprintk("  pes_type: DMX_TS_PES_TELETEXT(not supported)\n");
+		return -ENOSYS;
 
 	case DMX_TS_PES_PCR:
 		dprintk("  pes_type: DMX_TS_PES_PCR\n");
@@ -975,8 +975,8 @@ static int ttusb_dec_start_ts_feed(struc
 		break;
 
 	case DMX_TS_PES_OTHER:
-		dprintk("  pes_type: DMX_TS_PES_OTHER\n");
-		break;
+		dprintk("  pes_type: DMX_TS_PES_OTHER(not supported)\n");
+		return -ENOSYS;
 
 	default:
 		dprintk("  pes_type: unknown (%d)\n", dvbdmxfeed->pes_type);
@@ -1395,6 +1395,7 @@ static int ttusb_dec_init_stb(struct ttu
 			/* We can't trust the USB IDs that some firmwares
 			   give the box */
 			switch (model) {
+			case 0x00070001:
 			case 0x00070008:
 			case 0x0007000c:
 				ttusb_dec_set_model(dec, TTUSB_DEC3000S);
@@ -1588,7 +1589,7 @@ static int fe_send_command(struct dvb_fr
 			   int param_length, const u8 params[],
 			   int *result_length, u8 cmd_result[])
 {
-	struct ttusb_dec* dec = (struct ttusb_dec*) fe->dvb->priv;
+	struct ttusb_dec* dec = fe->dvb->priv;
 	return ttusb_dec_send_command(dec, command, param_length, params, result_length, cmd_result);
 }
 
--- git.orig/drivers/media/dvb/ttusb-dec/ttusbdecfe.c
+++ git/drivers/media/dvb/ttusb-dec/ttusbdecfe.c
@@ -42,8 +42,39 @@ struct ttusbdecfe_state {
 
 static int ttusbdecfe_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
-	*status = FE_HAS_SIGNAL | FE_HAS_VITERBI |
-		  FE_HAS_SYNC | FE_HAS_CARRIER | FE_HAS_LOCK;
+	struct ttusbdecfe_state* state = fe->demodulator_priv;
+	u8 b[] = { 0x00, 0x00, 0x00, 0x00,
+		   0x00, 0x00, 0x00, 0x00 };
+	u8 result[4];
+	int len, ret;
+
+	*status=0;
+
+	ret=state->config->send_command(fe, 0x73, sizeof(b), b, &len, result);
+	if(ret)
+		return ret;
+
+	if(len != 4) {
+		printk(KERN_ERR "%s: unexpected reply\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	switch(result[3]) {
+		case 1:  /* not tuned yet */
+		case 2:  /* no signal/no lock*/
+			break;
+		case 3:	 /* signal found and locked*/
+			*status = FE_HAS_SIGNAL | FE_HAS_VITERBI |
+			FE_HAS_SYNC | FE_HAS_CARRIER | FE_HAS_LOCK;
+			break;
+		case 4:
+			*status = FE_TIMEDOUT;
+			break;
+		default:
+			pr_info("%s: returned unknown value: %d\n",
+				__FUNCTION__, result[3]);
+			return -EIO;
+	}
 
 	return 0;
 }
@@ -64,6 +95,16 @@ static int ttusbdecfe_dvbt_set_frontend(
 	return 0;
 }
 
+static int ttusbdecfe_dvbt_get_tune_settings(struct dvb_frontend* fe,
+					struct dvb_frontend_tune_settings* fesettings)
+{
+		fesettings->min_delay_ms = 1500;
+		/* Drift compensation makes no sense for DVB-T */
+		fesettings->step_size = 0;
+		fesettings->max_drift = 0;
+		return 0;
+}
+
 static int ttusbdecfe_dvbs_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
 {
 	struct ttusbdecfe_state* state = (struct ttusbdecfe_state*) fe->demodulator_priv;
@@ -212,6 +253,8 @@ static struct dvb_frontend_ops ttusbdecf
 
 	.set_frontend = ttusbdecfe_dvbt_set_frontend,
 
+	.get_tune_settings = ttusbdecfe_dvbt_get_tune_settings,
+
 	.read_status = ttusbdecfe_read_status,
 };
 
@@ -223,11 +266,11 @@ static struct dvb_frontend_ops ttusbdecf
 		.frequency_min		= 950000,
 		.frequency_max		= 2150000,
 		.frequency_stepsize	= 125,
+		.symbol_rate_min        = 1000000,  /* guessed */
+		.symbol_rate_max        = 45000000, /* guessed */
 		.caps =	FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 			FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-			FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
-			FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
-			FE_CAN_HIERARCHY_AUTO,
+			FE_CAN_QPSK
 	},
 
 	.release = ttusbdecfe_release,

--

