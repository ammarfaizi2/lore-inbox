Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVF0NW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVF0NW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVF0NRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:17:02 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:14309 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262058AbVF0MQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:33 -0400
Message-Id: <20050627121415.059137000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:28 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wolfgang Rohdewald <wolfgang@rohdewald.de>
Content-Disposition: inline; filename=dvb-ttpci-firmware-error-handling-fixes2.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 28/51] ttpci: more error handling for firmware communication
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfgang Rohdewald <wolfgang@rohdewald.de>

o propagate more errors back to caller or log them, mainly in
  av7110.c and av7110_av.c
o fix error message in StartHWFilter
o do not StopHWFilter for handle 0xffff

Signed-off-by: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/ttpci/av7110.c    |  239 ++++++++++++++++++++++--------------
 drivers/media/dvb/ttpci/av7110.h    |    4 
 drivers/media/dvb/ttpci/av7110_av.c |  210 ++++++++++++++++++-------------
 drivers/media/dvb/ttpci/av7110_av.h |    4 
 drivers/media/dvb/ttpci/av7110_hw.h |   12 -
 5 files changed, 281 insertions(+), 188 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.c	2005-06-27 13:24:21.000000000 +0200
@@ -116,13 +116,18 @@ static int av7110_num = 0;
 
 static void init_av7110_av(struct av7110 *av7110)
 {
+	int ret;
 	struct saa7146_dev *dev = av7110->dev;
 
 	/* set internal volume control to maximum */
 	av7110->adac_type = DVB_ADAC_TI;
-	av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
-
-	av7710_set_video_mode(av7110, vidmode);
+	ret = av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
+	if (ret<0)
+		printk("dvb-ttpci:cannot set internal volume to maximum:%d\n",ret);
+
+	ret = av7710_set_video_mode(av7110, vidmode);
+	if (ret<0)
+		printk("dvb-ttpci:cannot set video mode:%d\n",ret);
 
 	/* handle different card types */
 	/* remaining inits according to card and frontend type */
@@ -156,8 +161,12 @@ static void init_av7110_av(struct av7110
 
 	if (av7110->adac_type == DVB_ADAC_NONE || av7110->adac_type == DVB_ADAC_MSP) {
 		// switch DVB SCART on
-		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
-		av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
+		ret = av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, MainSwitch, 1, 0);
+		if (ret<0)
+			printk("dvb-ttpci:cannot switch on SCART(Main):%d\n",ret);
+		ret = av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, ADSwitch, 1, 1);
+		if (ret<0)
+			printk("dvb-ttpci:cannot switch on SCART(AD):%d\n",ret);
 		if (rgb_on &&
 		    (av7110->dev->pci->subsystem_vendor == 0x110a) && (av7110->dev->pci->subsystem_device == 0x0000)) {
 			saa7146_setgpio(dev, 1, SAA7146_GPIO_OUTHI); // RGB on, SCART pin 16
@@ -165,8 +174,12 @@ static void init_av7110_av(struct av7110
 		}
 	}
 
-	av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
-	av7110_setup_irc_config(av7110, 0);
+	ret = av7110_set_volume(av7110, av7110->mixer.volume_left, av7110->mixer.volume_right);
+	if (ret<0)
+		printk("dvb-ttpci:cannot set volume :%d\n",ret);
+	ret = av7110_setup_irc_config(av7110, 0);
+	if (ret<0)
+		printk("dvb-ttpci:cannot setup irc config :%d\n",ret);
 }
 
 static void recover_arm(struct av7110 *av7110)
@@ -258,8 +271,9 @@ static int arm_thread(void *data)
  *
  *  If we want to support multiple controls we would have to do much more...
  */
-void av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
+int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
 {
+	int ret = 0;
 	static struct av7110 *last;
 
 	dprintk(4, "%p\n", av7110);
@@ -270,9 +284,10 @@ void av7110_setup_irc_config(struct av71
 		last = av7110;
 
 	if (av7110) {
-		av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
+		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
 		av7110->ir_config = ir_config;
 	}
+	return ret;
 }
 
 static void (*irc_handler)(u32);
@@ -765,13 +780,14 @@ static inline int SetPIDs(struct av7110 
 			     pcrpid, vpid, apid, ttpid, subpid);
 }
 
-void ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
+int ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		u16 subpid, u16 pcrpid)
 {
+	int ret = 0;
 	dprintk(4, "%p\n", av7110);
 
 	if (down_interruptible(&av7110->pid_mutex))
-		return;
+		return -ERESTARTSYS;
 
 	if (!(vpid & 0x8000))
 		av7110->pids[DMX_PES_VIDEO] = vpid;
@@ -786,10 +802,11 @@ void ChangePIDs(struct av7110 *av7110, u
 
 	if (av7110->fe_synced) {
 		pcrpid = av7110->pids[DMX_PES_PCR];
-		SetPIDs(av7110, vpid, apid, ttpid, subpid, pcrpid);
+		ret = SetPIDs(av7110, vpid, apid, ttpid, subpid, pcrpid);
 	}
 
 	up(&av7110->pid_mutex);
+	return ret;
 }
 
 
@@ -832,11 +849,13 @@ static int StartHWFilter(struct dvb_demu
 	ret = av7110_fw_request(av7110, buf, 20, &handle, 1);
 	if (ret != 0 || handle >= 32) {
 		printk("dvb-ttpci: %s error  buf %04x %04x %04x %04x  "
-				"ret %x  handle %04x\n",
+				"ret %d  handle %04x\n",
 				__FUNCTION__, buf[0], buf[1], buf[2], buf[3],
 				ret, handle);
 		dvbdmxfilter->hw_handle = 0xffff;
-		return -1;
+		if (!ret)
+			ret = -1;
+		return ret;
 	}
 
 	av7110->handle2filter[handle] = dvbdmxfilter;
@@ -859,7 +878,7 @@ static int StopHWFilter(struct dvb_demux
 	if (handle >= 32) {
 		printk("%s tried to stop invalid filter %04x, filter type = %x\n",
 				__FUNCTION__, handle, dvbdmxfilter->type);
-		return 0;
+		return -EINVAL;
 	}
 
 	av7110->handle2filter[handle] = NULL;
@@ -873,18 +892,20 @@ static int StopHWFilter(struct dvb_demux
 				"resp %04x %04x  pid %d\n",
 				__FUNCTION__, buf[0], buf[1], buf[2], ret,
 				answ[0], answ[1], dvbdmxfilter->feed->pid);
-		ret = -1;
+		if (!ret)
+			ret = -1;
 	}
 	return ret;
 }
 
 
-static void dvb_feed_start_pid(struct dvb_demux_feed *dvbdmxfeed)
+static int dvb_feed_start_pid(struct dvb_demux_feed *dvbdmxfeed)
 {
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	struct av7110 *av7110 = (struct av7110 *) dvbdmx->priv;
 	u16 *pid = dvbdmx->pids, npids[5];
 	int i;
+	int ret = 0;
 
 	dprintk(4, "%p\n", av7110);
 
@@ -893,36 +914,49 @@ static void dvb_feed_start_pid(struct dv
 	npids[i] = (pid[i]&0x8000) ? 0 : pid[i];
 	if ((i == 2) && npids[i] && (dvbdmxfeed->ts_type & TS_PACKET)) {
 		npids[i] = 0;
-		ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
-		StartHWFilter(dvbdmxfeed->filter);
-		return;
+		ret = ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
+		if (!ret)
+			ret = StartHWFilter(dvbdmxfeed->filter);
+		return ret;
+	}
+	if (dvbdmxfeed->pes_type <= 2 || dvbdmxfeed->pes_type == 4) {
+		ret = ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
+		if (ret)
+			return ret;
 	}
-	if (dvbdmxfeed->pes_type <= 2 || dvbdmxfeed->pes_type == 4)
-		ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
 
 	if (dvbdmxfeed->pes_type < 2 && npids[0])
 		if (av7110->fe_synced)
-			av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
+		{
+			ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
+			if (ret)
+				return ret;
+		}
 
 	if ((dvbdmxfeed->ts_type & TS_PACKET)) {
 		if (dvbdmxfeed->pes_type == 0 && !(dvbdmx->pids[0] & 0x8000))
-			av7110_av_start_record(av7110, RP_AUDIO, dvbdmxfeed);
+			ret = av7110_av_start_record(av7110, RP_AUDIO, dvbdmxfeed);
 		if (dvbdmxfeed->pes_type == 1 && !(dvbdmx->pids[1] & 0x8000))
-			av7110_av_start_record(av7110, RP_VIDEO, dvbdmxfeed);
+			ret = av7110_av_start_record(av7110, RP_VIDEO, dvbdmxfeed);
 	}
+	return ret;
 }
 
-static void dvb_feed_stop_pid(struct dvb_demux_feed *dvbdmxfeed)
+static int dvb_feed_stop_pid(struct dvb_demux_feed *dvbdmxfeed)
 {
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	struct av7110 *av7110 = (struct av7110 *) dvbdmx->priv;
 	u16 *pid = dvbdmx->pids, npids[5];
 	int i;
 
+	int ret = 0;
+
 	dprintk(4, "%p\n", av7110);
 
 	if (dvbdmxfeed->pes_type <= 1) {
-		av7110_av_stop(av7110, dvbdmxfeed->pes_type ?  RP_VIDEO : RP_AUDIO);
+		ret = av7110_av_stop(av7110, dvbdmxfeed->pes_type ?  RP_VIDEO : RP_AUDIO);
+		if (ret)
+			return ret;
 		if (!av7110->rec_mode)
 			dvbdmx->recording = 0;
 		if (!av7110->playing)
@@ -933,24 +967,27 @@ static void dvb_feed_stop_pid(struct dvb
 	switch (i) {
 	case 2: //teletext
 		if (dvbdmxfeed->ts_type & TS_PACKET)
-			StopHWFilter(dvbdmxfeed->filter);
+			ret = StopHWFilter(dvbdmxfeed->filter);
 		npids[2] = 0;
 		break;
 	case 0:
 	case 1:
 	case 4:
 		if (!pids_off)
-			return;
+			return 0;
 		npids[i] = (pid[i]&0x8000) ? 0 : pid[i];
 		break;
 	}
-	ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
+	if (!ret)
+		ret = ChangePIDs(av7110, npids[1], npids[0], npids[2], npids[3], npids[4]);
+	return ret;
 }
 
 static int av7110_start_feed(struct dvb_demux_feed *feed)
 {
 	struct dvb_demux *demux = feed->demux;
 	struct av7110 *av7110 = demux->priv;
+	int ret = 0;
 
 	dprintk(4, "%p\n", av7110);
 
@@ -971,21 +1008,22 @@ static int av7110_start_feed(struct dvb_
 					   !(demux->pids[1] & 0x8000)) {
 					       dvb_ringbuffer_flush_spinlock_wakeup(&av7110->avout);
 					       dvb_ringbuffer_flush_spinlock_wakeup(&av7110->aout);
-					       av7110_av_start_play(av7110,RP_AV);
-					       demux->playing = 1;
+					       ret = av7110_av_start_play(av7110,RP_AV);
+					       if (!ret)
+						       demux->playing = 1;
 					}
 				break;
 			default:
-				dvb_feed_start_pid(feed);
+				ret = dvb_feed_start_pid(feed);
 				break;
 			}
 		} else if ((feed->ts_type & TS_PACKET) &&
 			   (demux->dmx.frontend->source != DMX_MEMORY_FE)) {
-			StartHWFilter(feed->filter);
+			ret = StartHWFilter(feed->filter);
 		}
 	}
 
-	if (feed->type == DMX_TYPE_SEC) {
+	else if (feed->type == DMX_TYPE_SEC) {
 		int i;
 
 		for (i = 0; i < demux->filternum; i++) {
@@ -996,12 +1034,15 @@ static int av7110_start_feed(struct dvb_
 			if (demux->filter[i].filter.parent != &feed->feed.sec)
 				continue;
 			demux->filter[i].state = DMX_STATE_GO;
-			if (demux->dmx.frontend->source != DMX_MEMORY_FE)
-				StartHWFilter(&demux->filter[i]);
+			if (demux->dmx.frontend->source != DMX_MEMORY_FE) {
+				ret = StartHWFilter(&demux->filter[i]);
+				if (ret)
+					break;
+			}
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 
@@ -1010,6 +1051,7 @@ static int av7110_stop_feed(struct dvb_d
 	struct dvb_demux *demux = feed->demux;
 	struct av7110 *av7110 = demux->priv;
 
+	int ret = 0;
 	dprintk(4, "%p\n", av7110);
 
 	if (feed->type == DMX_TYPE_TS) {
@@ -1022,26 +1064,29 @@ static int av7110_stop_feed(struct dvb_d
 		}
 		if (feed->ts_type & TS_DECODER &&
 		    feed->pes_type < DMX_TS_PES_OTHER) {
-			dvb_feed_stop_pid(feed);
+			ret = dvb_feed_stop_pid(feed);
 		} else
 			if ((feed->ts_type & TS_PACKET) &&
 			    (demux->dmx.frontend->source != DMX_MEMORY_FE))
-				StopHWFilter(feed->filter);
+				ret = StopHWFilter(feed->filter);
 	}
 
-	if (feed->type == DMX_TYPE_SEC) {
+	if (!ret && feed->type == DMX_TYPE_SEC) {
 		int i;
 
 		for (i = 0; i<demux->filternum; i++)
 			if (demux->filter[i].state == DMX_STATE_GO &&
 			    demux->filter[i].filter.parent == &feed->feed.sec) {
 				demux->filter[i].state = DMX_STATE_READY;
-				if (demux->dmx.frontend->source != DMX_MEMORY_FE)
-					StopHWFilter(&demux->filter[i]);
+				if (demux->dmx.frontend->source != DMX_MEMORY_FE) {
+					ret = StopHWFilter(&demux->filter[i]);
+					if (ret)
+						break;
+				}
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 
@@ -1093,7 +1138,7 @@ static int dvb_get_stc(struct dmx_demux 
 	ret = av7110_fw_request(av7110, &tag, 0, fwstc, 4);
 	if (ret) {
 		printk(KERN_ERR "%s: av7110_fw_request error\n", __FUNCTION__);
-		return -EIO;
+		return ret;
 	}
 	dprintk(2, "fwstc = %04hx %04hx %04hx %04hx\n",
 		fwstc[0], fwstc[1], fwstc[2], fwstc[3]);
@@ -1119,18 +1164,14 @@ static int av7110_set_tone(struct dvb_fr
 
 	switch (tone) {
 	case SEC_TONE_ON:
-		Set22K(av7110, 1);
-		break;
+		return Set22K(av7110, 1);
 
 	case SEC_TONE_OFF:
-		Set22K(av7110, 0);
-		break;
+		return Set22K(av7110, 0);
 
 	default:
 		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static int av7110_diseqc_send_master_cmd(struct dvb_frontend* fe,
@@ -1138,9 +1179,7 @@ static int av7110_diseqc_send_master_cmd
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_diseqc_send(av7110, cmd->msg_len, cmd->msg, -1);
-
-	return 0;
+	return av7110_diseqc_send(av7110, cmd->msg_len, cmd->msg, -1);
 }
 
 static int av7110_diseqc_send_burst(struct dvb_frontend* fe,
@@ -1148,9 +1187,7 @@ static int av7110_diseqc_send_burst(stru
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_diseqc_send(av7110, 0, NULL, minicmd);
-
-	return 0;
+	return av7110_diseqc_send(av7110, 0, NULL, minicmd);
 }
 
 /* simplified code from budget-core.c */
@@ -1992,76 +2029,84 @@ static struct l64781_config grundig_2950
 
 
 
-static void av7110_fe_lock_fix(struct av7110* av7110, fe_status_t status)
+static int av7110_fe_lock_fix(struct av7110* av7110, fe_status_t status)
 {
+	int ret = 0;
 	int synced = (status & FE_HAS_LOCK) ? 1 : 0;
 
 	av7110->fe_status = status;
 
 	if (av7110->fe_synced == synced)
-		return;
+		return 0;
 
 	av7110->fe_synced = synced;
 
 	if (av7110->playing)
-		return;
+		return 0;
 
 	if (down_interruptible(&av7110->pid_mutex))
-		return;
+		return -ERESTARTSYS;
 
 	if (av7110->fe_synced) {
-		SetPIDs(av7110, av7110->pids[DMX_PES_VIDEO],
+		ret = SetPIDs(av7110, av7110->pids[DMX_PES_VIDEO],
 			av7110->pids[DMX_PES_AUDIO],
 			av7110->pids[DMX_PES_TELETEXT], 0,
 			av7110->pids[DMX_PES_PCR]);
-		av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
+		if (!ret)
+			ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
 	} else {
-		SetPIDs(av7110, 0, 0, 0, 0, 0);
-		av7110_fw_cmd(av7110, COMTYPE_PID_FILTER, FlushTSQueue, 0);
-		av7110_wait_msgstate(av7110, GPMQBusy);
+		ret = SetPIDs(av7110, 0, 0, 0, 0, 0);
+		if (!ret) {
+			ret = av7110_fw_cmd(av7110, COMTYPE_PID_FILTER, FlushTSQueue, 0);
+			if (!ret)
+				ret = av7110_wait_msgstate(av7110, GPMQBusy);
+		}
 	}
 
 	up(&av7110->pid_mutex);
+	return ret;
 }
 
 static int av7110_fe_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
 {
 	struct av7110* av7110 = fe->dvb->priv;
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_set_frontend(fe, params);
+
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_set_frontend(fe, params);
+	return ret;
 }
 
 static int av7110_fe_init(struct dvb_frontend* fe)
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_init(fe);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_init(fe);
+	return ret;
 }
 
 static int av7110_fe_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
 	struct av7110* av7110 = fe->dvb->priv;
-	int ret;
 
 	/* call the real implementation */
-	ret = av7110->fe_read_status(fe, status);
-	if (ret)
-		return ret;
-
-	if (((*status ^ av7110->fe_status) & FE_HAS_LOCK) && (*status & FE_HAS_LOCK)) {
-		av7110_fe_lock_fix(av7110, *status);
-	}
-
-	return 0;
+	int ret = av7110->fe_read_status(fe, status);
+	if (!ret)
+		if (((*status ^ av7110->fe_status) & FE_HAS_LOCK) && (*status & FE_HAS_LOCK))
+			ret = av7110_fe_lock_fix(av7110, *status);
+	return ret;
 }
 
 static int av7110_fe_diseqc_reset_overload(struct dvb_frontend* fe)
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_diseqc_reset_overload(fe);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_diseqc_reset_overload(fe);
+	return ret;
 }
 
 static int av7110_fe_diseqc_send_master_cmd(struct dvb_frontend* fe,
@@ -2069,40 +2114,50 @@ static int av7110_fe_diseqc_send_master_
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_diseqc_send_master_cmd(fe, cmd);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_diseqc_send_master_cmd(fe, cmd);
+	return ret;
 }
 
 static int av7110_fe_diseqc_send_burst(struct dvb_frontend* fe, fe_sec_mini_cmd_t minicmd)
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_diseqc_send_burst(fe, minicmd);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_diseqc_send_burst(fe, minicmd);
+	return ret;
 }
 
 static int av7110_fe_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_set_tone(fe, tone);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_set_tone(fe, tone);
+	return ret;
 }
 
 static int av7110_fe_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_set_voltage(fe, voltage);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_set_voltage(fe, voltage);
+	return ret;
 }
 
 static int av7110_fe_dishnetwork_send_legacy_command(struct dvb_frontend* fe, unsigned int cmd)
 {
 	struct av7110* av7110 = fe->dvb->priv;
 
-	av7110_fe_lock_fix(av7110, 0);
-	return av7110->fe_dishnetwork_send_legacy_command(fe, cmd);
+	int ret = av7110_fe_lock_fix(av7110, 0);
+	if (!ret)
+		ret = av7110->fe_dishnetwork_send_legacy_command(fe, cmd);
+	return ret;
 }
 
 static u8 read_pwm(struct av7110* av7110)
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110.h	2005-06-27 13:24:17.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110.h	2005-06-27 13:24:21.000000000 +0200
@@ -254,12 +254,12 @@ struct av7110 {
 };
 
 
-extern void ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
+extern int ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		       u16 subpid, u16 pcrpid);
 
 extern void av7110_register_irc_handler(void (*func)(u32));
 extern void av7110_unregister_irc_handler(void (*func)(u32));
-extern void av7110_setup_irc_config (struct av7110 *av7110, u32 ir_config);
+extern int av7110_setup_irc_config (struct av7110 *av7110, u32 ir_config);
 
 extern int av7110_ir_init (void);
 extern void av7110_ir_exit (void);
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_av.c	2005-06-27 13:24:19.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.c	2005-06-27 13:24:21.000000000 +0200
@@ -121,6 +121,7 @@ static int dvb_filter_pes2ts_cb(void *pr
 int av7110_av_start_record(struct av7110 *av7110, int av,
 			   struct dvb_demux_feed *dvbdmxfeed)
 {
+	int ret = 0;
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 
 	dprintk(2, "av7110:%p, , dvb_demux_feed:%p\n", av7110, dvbdmxfeed);
@@ -137,7 +138,7 @@ int av7110_av_start_record(struct av7110
 				       dvbdmx->pesfilter[0]->pid,
 				       dvb_filter_pes2ts_cb,
 				       (void *) dvbdmx->pesfilter[0]);
-		av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, AudioPES, 0);
+		ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, AudioPES, 0);
 		break;
 
 	case RP_VIDEO:
@@ -145,7 +146,7 @@ int av7110_av_start_record(struct av7110
 				       dvbdmx->pesfilter[1]->pid,
 				       dvb_filter_pes2ts_cb,
 				       (void *) dvbdmx->pesfilter[1]);
-		av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, VideoPES, 0);
+		ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, VideoPES, 0);
 		break;
 
 	case RP_AV:
@@ -157,14 +158,15 @@ int av7110_av_start_record(struct av7110
 				       dvbdmx->pesfilter[1]->pid,
 				       dvb_filter_pes2ts_cb,
 				       (void *) dvbdmx->pesfilter[1]);
-		av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, AV_PES, 0);
+		ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, AV_PES, 0);
 		break;
 	}
-	return 0;
+	return ret;
 }
 
 int av7110_av_start_play(struct av7110 *av7110, int av)
 {
+	int ret = 0;
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (av7110->rec_mode)
@@ -182,54 +184,57 @@ int av7110_av_start_play(struct av7110 *
 	av7110->playing |= av;
 	switch (av7110->playing) {
 	case RP_AUDIO:
-		av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, AudioPES, 0);
+		ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, AudioPES, 0);
 		break;
 	case RP_VIDEO:
-		av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, VideoPES, 0);
+		ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, VideoPES, 0);
 		av7110->sinfo = 0;
 		break;
 	case RP_AV:
 		av7110->sinfo = 0;
-		av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, AV_PES, 0);
+		ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, AV_PES, 0);
 		break;
 	}
-	return av7110->playing;
+	if (!ret)
+		ret = av7110->playing;
+	return ret;
 }
 
-void av7110_av_stop(struct av7110 *av7110, int av)
+int av7110_av_stop(struct av7110 *av7110, int av)
 {
+	int ret = 0;
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (!(av7110->playing & av) && !(av7110->rec_mode & av))
-		return;
-
+		return 0;
 	av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Stop, 0);
 	if (av7110->playing) {
 		av7110->playing &= ~av;
 		switch (av7110->playing) {
 		case RP_AUDIO:
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, AudioPES, 0);
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, AudioPES, 0);
 			break;
 		case RP_VIDEO:
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, VideoPES, 0);
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Play, 2, VideoPES, 0);
 			break;
 		case RP_NONE:
-			av7110_set_vidmode(av7110, av7110->vidmode);
+			ret = av7110_set_vidmode(av7110, av7110->vidmode);
 			break;
 		}
 	} else {
 		av7110->rec_mode &= ~av;
 		switch (av7110->rec_mode) {
 		case RP_AUDIO:
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, AudioPES, 0);
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, AudioPES, 0);
 			break;
 		case RP_VIDEO:
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, VideoPES, 0);
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Record, 2, VideoPES, 0);
 			break;
 		case RP_NONE:
 			break;
 		}
 	}
+	return ret;
 }
 
 
@@ -317,19 +322,22 @@ int av7110_set_volume(struct av7110 *av7
 	return 0;
 }
 
-void av7110_set_vidmode(struct av7110 *av7110, int mode)
+int av7110_set_vidmode(struct av7110 *av7110, int mode)
 {
+	int ret;
 	dprintk(2, "av7110:%p, \n", av7110);
 
-	av7110_fw_cmd(av7110, COMTYPE_ENCODER, LoadVidCode, 1, mode);
+	ret = av7110_fw_cmd(av7110, COMTYPE_ENCODER, LoadVidCode, 1, mode);
 
-	if (!av7110->playing) {
-		ChangePIDs(av7110, av7110->pids[DMX_PES_VIDEO],
+	if (!ret && !av7110->playing) {
+		ret = ChangePIDs(av7110, av7110->pids[DMX_PES_VIDEO],
 			   av7110->pids[DMX_PES_AUDIO],
 			   av7110->pids[DMX_PES_TELETEXT],
 			   0, av7110->pids[DMX_PES_PCR]);
-		av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
+		if (!ret)
+			ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, Scan, 0);
 	}
+	return ret;
 }
 
 
@@ -340,17 +348,18 @@ static int sw2mode[16] = {
 	VIDEO_MODE_PAL, VIDEO_MODE_PAL, VIDEO_MODE_PAL, VIDEO_MODE_PAL,
 };
 
-static void get_video_format(struct av7110 *av7110, u8 *buf, int count)
+static int get_video_format(struct av7110 *av7110, u8 *buf, int count)
 {
 	int i;
 	int hsize, vsize;
 	int sw;
 	u8 *p;
+	int ret = 0;
 
 	dprintk(2, "av7110:%p, \n", av7110);
 
 	if (av7110->sinfo)
-		return;
+		return 0;
 	for (i = 7; i < count - 10; i++) {
 		p = buf + i;
 		if (p[0] || p[1] || p[2] != 0x01 || p[3] != 0xb3)
@@ -359,11 +368,14 @@ static void get_video_format(struct av71
 		hsize = ((p[1] &0xF0) >> 4) | (p[0] << 4);
 		vsize = ((p[1] &0x0F) << 8) | (p[2]);
 		sw = (p[3] & 0x0F);
-		av7110_set_vidmode(av7110, sw2mode[sw]);
-		dprintk(2, "playback %dx%d fr=%d\n", hsize, vsize, sw);
-		av7110->sinfo = 1;
+		ret = av7110_set_vidmode(av7110, sw2mode[sw]);
+		if (!ret) {
+			dprintk(2, "playback %dx%d fr=%d\n", hsize, vsize, sw);
+			av7110->sinfo = 1;
+		}
 		break;
 	}
+	return ret;
 }
 
 
@@ -974,7 +986,7 @@ static int dvb_video_ioctl(struct inode 
 	unsigned long arg = (unsigned long) parg;
 	int ret = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(1, "av7110:%p, cmd=%04x\n", av7110,cmd);
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
 		if ( cmd != VIDEO_GET_STATUS && cmd != VIDEO_GET_EVENT &&
@@ -987,49 +999,57 @@ static int dvb_video_ioctl(struct inode 
 	case VIDEO_STOP:
 		av7110->videostate.play_state = VIDEO_STOPPED;
 		if (av7110->videostate.stream_source == VIDEO_SOURCE_MEMORY)
-			av7110_av_stop(av7110, RP_VIDEO);
+			ret = av7110_av_stop(av7110, RP_VIDEO);
 		else
-			vidcom(av7110, VIDEO_CMD_STOP,
+			ret = vidcom(av7110, VIDEO_CMD_STOP,
 			       av7110->videostate.video_blank ? 0 : 1);
-		av7110->trickmode = TRICK_NONE;
+		if (!ret)
+			av7110->trickmode = TRICK_NONE;
 		break;
 
 	case VIDEO_PLAY:
 		av7110->trickmode = TRICK_NONE;
 		if (av7110->videostate.play_state == VIDEO_FREEZED) {
 			av7110->videostate.play_state = VIDEO_PLAYING;
-			vidcom(av7110, VIDEO_CMD_PLAY, 0);
+			ret = vidcom(av7110, VIDEO_CMD_PLAY, 0);
+			if (ret)
+				break;
 		}
 
 		if (av7110->videostate.stream_source == VIDEO_SOURCE_MEMORY) {
 			if (av7110->playing == RP_AV) {
-				av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Stop, 0);
+				ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Stop, 0);
+				if (ret)
+					break;
 				av7110->playing &= ~RP_VIDEO;
 			}
-			av7110_av_start_play(av7110, RP_VIDEO);
-			vidcom(av7110, VIDEO_CMD_PLAY, 0);
-		} else {
-			//av7110_av_stop(av7110, RP_VIDEO);
-			vidcom(av7110, VIDEO_CMD_PLAY, 0);
+			ret = av7110_av_start_play(av7110, RP_VIDEO);
 		}
-		av7110->videostate.play_state = VIDEO_PLAYING;
+		if (!ret)
+			ret = vidcom(av7110, VIDEO_CMD_PLAY, 0);
+		if (!ret)
+			av7110->videostate.play_state = VIDEO_PLAYING;
 		break;
 
 	case VIDEO_FREEZE:
 		av7110->videostate.play_state = VIDEO_FREEZED;
 		if (av7110->playing & RP_VIDEO)
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Pause, 0);
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Pause, 0);
 		else
-			vidcom(av7110, VIDEO_CMD_FREEZE, 1);
-		av7110->trickmode = TRICK_FREEZE;
+			ret = vidcom(av7110, VIDEO_CMD_FREEZE, 1);
+		if (!ret)
+			av7110->trickmode = TRICK_FREEZE;
 		break;
 
 	case VIDEO_CONTINUE:
 		if (av7110->playing & RP_VIDEO)
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Continue, 0);
-		vidcom(av7110, VIDEO_CMD_PLAY, 0);
-		av7110->videostate.play_state = VIDEO_PLAYING;
-		av7110->trickmode = TRICK_NONE;
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Continue, 0);
+		if (!ret)
+			ret = vidcom(av7110, VIDEO_CMD_PLAY, 0);
+		if (!ret) {
+			av7110->videostate.play_state = VIDEO_PLAYING;
+			av7110->trickmode = TRICK_NONE;
+		}
 		break;
 
 	case VIDEO_SELECT_SOURCE:
@@ -1045,7 +1065,7 @@ static int dvb_video_ioctl(struct inode 
 		break;
 
 	case VIDEO_GET_EVENT:
-		ret=dvb_video_get_event(av7110, parg, file->f_flags);
+		ret = dvb_video_get_event(av7110, parg, file->f_flags);
 		break;
 
 	case VIDEO_GET_SIZE:
@@ -1105,25 +1125,32 @@ static int dvb_video_ioctl(struct inode 
 	case VIDEO_FAST_FORWARD:
 		//note: arg is ignored by firmware
 		if (av7110->playing & RP_VIDEO)
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 				      __Scan_I, 2, AV_PES, 0);
 		else
-			vidcom(av7110, VIDEO_CMD_FFWD, arg);
-		av7110->trickmode = TRICK_FAST;
-		av7110->videostate.play_state = VIDEO_PLAYING;
+			ret = vidcom(av7110, VIDEO_CMD_FFWD, arg);
+		if (!ret) {
+			av7110->trickmode = TRICK_FAST;
+			av7110->videostate.play_state = VIDEO_PLAYING;
+		}
 		break;
 
 	case VIDEO_SLOWMOTION:
 		if (av7110->playing&RP_VIDEO) {
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Slow, 2, 0, 0);
-			vidcom(av7110, VIDEO_CMD_SLOW, arg);
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY, __Slow, 2, 0, 0);
+			if (!ret)
+				ret = vidcom(av7110, VIDEO_CMD_SLOW, arg);
 		} else {
-			vidcom(av7110, VIDEO_CMD_PLAY, 0);
-			vidcom(av7110, VIDEO_CMD_STOP, 0);
-			vidcom(av7110, VIDEO_CMD_SLOW, arg);
+			ret = vidcom(av7110, VIDEO_CMD_PLAY, 0);
+			if (!ret)
+				ret = vidcom(av7110, VIDEO_CMD_STOP, 0);
+			if (!ret)
+				ret = vidcom(av7110, VIDEO_CMD_SLOW, arg);
+		}
+		if (!ret) {
+			av7110->trickmode = TRICK_SLOW;
+			av7110->videostate.play_state = VIDEO_PLAYING;
 		}
-		av7110->trickmode = TRICK_SLOW;
-		av7110->videostate.play_state = VIDEO_PLAYING;
 		break;
 
 	case VIDEO_GET_CAPABILITIES:
@@ -1136,18 +1163,21 @@ static int dvb_video_ioctl(struct inode 
 		av7110_ipack_reset(&av7110->ipack[1]);
 
 		if (av7110->playing == RP_AV) {
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 				      __Play, 2, AV_PES, 0);
+			if (ret)
+				break;
 			if (av7110->trickmode == TRICK_FAST)
-				av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
+				ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 					      __Scan_I, 2, AV_PES, 0);
 			if (av7110->trickmode == TRICK_SLOW) {
-				av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
+				ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 					      __Slow, 2, 0, 0);
-				vidcom(av7110, VIDEO_CMD_SLOW, arg);
+				if (!ret)
+					ret = vidcom(av7110, VIDEO_CMD_SLOW, arg);
 			}
 			if (av7110->trickmode == TRICK_FREEZE)
-				vidcom(av7110, VIDEO_CMD_STOP, 1);
+				ret = vidcom(av7110, VIDEO_CMD_STOP, 1);
 		}
 		break;
 
@@ -1170,7 +1200,7 @@ static int dvb_audio_ioctl(struct inode 
 	unsigned long arg = (unsigned long) parg;
 	int ret = 0;
 
-	dprintk(2, "av7110:%p, \n", av7110);
+	dprintk(1, "av7110:%p, cmd=%04x\n", av7110,cmd);
 
 	if (((file->f_flags & O_ACCMODE) == O_RDONLY) &&
 	    (cmd != AUDIO_GET_STATUS))
@@ -1179,28 +1209,32 @@ static int dvb_audio_ioctl(struct inode 
 	switch (cmd) {
 	case AUDIO_STOP:
 		if (av7110->audiostate.stream_source == AUDIO_SOURCE_MEMORY)
-			av7110_av_stop(av7110, RP_AUDIO);
+			ret = av7110_av_stop(av7110, RP_AUDIO);
 		else
-			audcom(av7110, AUDIO_CMD_MUTE);
-		av7110->audiostate.play_state = AUDIO_STOPPED;
+			ret = audcom(av7110, AUDIO_CMD_MUTE);
+		if (!ret)
+			av7110->audiostate.play_state = AUDIO_STOPPED;
 		break;
 
 	case AUDIO_PLAY:
 		if (av7110->audiostate.stream_source == AUDIO_SOURCE_MEMORY)
-			av7110_av_start_play(av7110, RP_AUDIO);
-		audcom(av7110, AUDIO_CMD_UNMUTE);
-		av7110->audiostate.play_state = AUDIO_PLAYING;
+			ret = av7110_av_start_play(av7110, RP_AUDIO);
+		if (!ret)
+			ret = audcom(av7110, AUDIO_CMD_UNMUTE);
+		if (!ret)
+			av7110->audiostate.play_state = AUDIO_PLAYING;
 		break;
 
 	case AUDIO_PAUSE:
-		audcom(av7110, AUDIO_CMD_MUTE);
-		av7110->audiostate.play_state = AUDIO_PAUSED;
+		ret = audcom(av7110, AUDIO_CMD_MUTE);
+		if (!ret)
+			av7110->audiostate.play_state = AUDIO_PAUSED;
 		break;
 
 	case AUDIO_CONTINUE:
 		if (av7110->audiostate.play_state == AUDIO_PAUSED) {
 			av7110->audiostate.play_state = AUDIO_PLAYING;
-			audcom(av7110, AUDIO_CMD_UNMUTE | AUDIO_CMD_PCM16);
+			ret = audcom(av7110, AUDIO_CMD_UNMUTE | AUDIO_CMD_PCM16);
 		}
 		break;
 
@@ -1210,14 +1244,15 @@ static int dvb_audio_ioctl(struct inode 
 
 	case AUDIO_SET_MUTE:
 	{
-		audcom(av7110, arg ? AUDIO_CMD_MUTE : AUDIO_CMD_UNMUTE);
-		av7110->audiostate.mute_state = (int) arg;
+		ret = audcom(av7110, arg ? AUDIO_CMD_MUTE : AUDIO_CMD_UNMUTE);
+		if (!ret)
+			av7110->audiostate.mute_state = (int) arg;
 		break;
 	}
 
 	case AUDIO_SET_AV_SYNC:
 		av7110->audiostate.AV_sync_state = (int) arg;
-		audcom(av7110, arg ? AUDIO_CMD_SYNC_ON : AUDIO_CMD_SYNC_OFF);
+		ret = audcom(av7110, arg ? AUDIO_CMD_SYNC_ON : AUDIO_CMD_SYNC_OFF);
 		break;
 
 	case AUDIO_SET_BYPASS_MODE:
@@ -1229,21 +1264,24 @@ static int dvb_audio_ioctl(struct inode 
 
 		switch(av7110->audiostate.channel_select) {
 		case AUDIO_STEREO:
-			audcom(av7110, AUDIO_CMD_STEREO);
-			if (av7110->adac_type == DVB_ADAC_CRYSTAL)
-				i2c_writereg(av7110, 0x20, 0x02, 0x49);
+			ret = audcom(av7110, AUDIO_CMD_STEREO);
+			if (!ret)
+				if (av7110->adac_type == DVB_ADAC_CRYSTAL)
+					i2c_writereg(av7110, 0x20, 0x02, 0x49);
 			break;
 
 		case AUDIO_MONO_LEFT:
-			audcom(av7110, AUDIO_CMD_MONO_L);
-			if (av7110->adac_type == DVB_ADAC_CRYSTAL)
-				i2c_writereg(av7110, 0x20, 0x02, 0x4a);
+			ret = audcom(av7110, AUDIO_CMD_MONO_L);
+			if (!ret)
+				if (av7110->adac_type == DVB_ADAC_CRYSTAL)
+					i2c_writereg(av7110, 0x20, 0x02, 0x4a);
 			break;
 
 		case AUDIO_MONO_RIGHT:
-			audcom(av7110, AUDIO_CMD_MONO_R);
-			if (av7110->adac_type == DVB_ADAC_CRYSTAL)
-				i2c_writereg(av7110, 0x20, 0x02, 0x45);
+			ret = audcom(av7110, AUDIO_CMD_MONO_R);
+			if (!ret)
+				if (av7110->adac_type == DVB_ADAC_CRYSTAL)
+					i2c_writereg(av7110, 0x20, 0x02, 0x45);
 			break;
 
 		default:
@@ -1264,7 +1302,7 @@ static int dvb_audio_ioctl(struct inode 
 		dvb_ringbuffer_flush_spinlock_wakeup(&av7110->aout);
 		av7110_ipack_reset(&av7110->ipack[0]);
 		if (av7110->playing == RP_AV)
-			av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
+			ret = av7110_fw_cmd(av7110, COMTYPE_REC_PLAY,
 			       __Play, 2, AV_PES, 0);
 		break;
 	case AUDIO_SET_ID:
@@ -1274,7 +1312,7 @@ static int dvb_audio_ioctl(struct inode 
 	{
 		struct audio_mixer *amix = (struct audio_mixer *)parg;
 
-		av7110_set_volume(av7110, amix->volume_left, amix->volume_right);
+		ret = av7110_set_volume(av7110, amix->volume_left, amix->volume_right);
 		break;
 	}
 	case AUDIO_SET_STREAMTYPE:
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_av.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_av.h	2005-06-27 13:24:21.000000000 +0200
@@ -3,14 +3,14 @@
 
 struct av7110;
 
-extern void av7110_set_vidmode(struct av7110 *av7110, int mode);
+extern int av7110_set_vidmode(struct av7110 *av7110, int mode);
 
 extern int av7110_record_cb(struct dvb_filter_pes2ts *p2t, u8 *buf, size_t len);
 extern int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen);
 extern int av7110_write_to_decoder(struct dvb_demux_feed *feed, const u8 *buf, size_t len);
 
 extern int av7110_set_volume(struct av7110 *av7110, int volleft, int volright);
-extern void av7110_av_stop(struct av7110 *av7110, int av);
+extern int av7110_av_stop(struct av7110 *av7110, int av);
 extern int av7110_av_start_record(struct av7110 *av7110, int av,
 			  struct dvb_demux_feed *dvbdmxfeed);
 extern int av7110_av_start_play(struct av7110 *av7110, int av);
Index: linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_hw.h
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttpci/av7110_hw.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttpci/av7110_hw.h	2005-06-27 13:24:21.000000000 +0200
@@ -458,27 +458,27 @@ static inline int SendDAC(struct av7110 
 	return av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, AudioDAC, 2, addr, data);
 }
 
-static inline void av7710_set_video_mode(struct av7110 *av7110, int mode)
+static inline int av7710_set_video_mode(struct av7110 *av7110, int mode)
 {
-	av7110_fw_cmd(av7110, COMTYPE_ENCODER, SetVidMode, 1, mode);
+	return av7110_fw_cmd(av7110, COMTYPE_ENCODER, SetVidMode, 1, mode);
 }
 
-static int inline vidcom(struct av7110 *av7110, u32 com, u32 arg)
+static inline int vidcom(struct av7110 *av7110, u32 com, u32 arg)
 {
 	return av7110_fw_cmd(av7110, COMTYPE_MISC, AV7110_FW_VIDEO_COMMAND, 4,
 			     (com>>16), (com&0xffff),
 			     (arg>>16), (arg&0xffff));
 }
 
-static int inline audcom(struct av7110 *av7110, u32 com)
+static inline int audcom(struct av7110 *av7110, u32 com)
 {
 	return av7110_fw_cmd(av7110, COMTYPE_MISC, AV7110_FW_AUDIO_COMMAND, 2,
 			     (com>>16), (com&0xffff));
 }
 
-static inline void Set22K(struct av7110 *av7110, int state)
+static inline int Set22K(struct av7110 *av7110, int state)
 {
-	av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, (state ? ON22K : OFF22K), 0);
+	return av7110_fw_cmd(av7110, COMTYPE_AUDIODAC, (state ? ON22K : OFF22K), 0);
 }
 
 

--

