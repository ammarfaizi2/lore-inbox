Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVIDXpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVIDXpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVIDXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:44:54 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:46721 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932134AbVIDXaq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:30:46 -0400
Message-Id: <20050904232324.846856000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:22 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-twinhan-dtv-starbox.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 23/54] usb: add TwinhanDTV StarBox support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add driver for the TwinhanDTV StarBox and clones.

Thanks to Ralph Metzler for his initial work on this box and thanks to Twinhan
for their support.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/Kconfig       |   23 +-
 drivers/media/dvb/dvb-usb/Makefile      |    3 
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h |    6 
 drivers/media/dvb/dvb-usb/vp702x-fe.c   |  339 ++++++++++++++++++++++++++++++++
 drivers/media/dvb/dvb-usb/vp702x.c      |  290 +++++++++++++++++++++++++++
 drivers/media/dvb/dvb-usb/vp702x.h      |  109 ++++++++++
 6 files changed, 765 insertions(+), 5 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/Kconfig	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/Kconfig	2005-09-04 22:28:15.000000000 +0200
@@ -93,13 +93,30 @@ config DVB_USB_DIGITV
 	  Say Y here to support the Nebula Electronics uDigitV USB2.0 DVB-T receiver.
 
 config DVB_USB_VP7045
-	tristate "TwinhanDTV Alpha/MagicBoxII and DNTV tinyUSB2 DVB-T USB2.0 support"
+	tristate "TwinhanDTV Alpha/MagicBoxII, DNTV tinyUSB2, Beetle USB2.0 support"
 	depends on DVB_USB
 	help
 	  Say Y here to support the
+
 	    TwinhanDTV Alpha (stick) (VP-7045),
-		TwinhanDTV MagicBox II (VP-7046) and
-		DigitalNow TinyUSB 2 DVB-t DVB-T USB2.0 receivers.
+		TwinhanDTV MagicBox II (VP-7046),
+		DigitalNow TinyUSB 2 DVB-t,
+		DigitalRise USB 2.0 Ter (Beetle) and
+		TYPHOON DVB-T USB DRIVE
+
+	  DVB-T USB2.0 receivers.
+
+config DVB_USB_VP702X
+	tristate "TwinhanDTV StarBox and clones DVB-S USB2.0 support"
+	depends on DVB_USB
+	help
+	  Say Y here to support the
+
+	    TwinhanDTV StarBox,
+		DigitalRise USB Starbox and
+		TYPHOON DVB-S USB 2.0 BOX
+
+	  DVB-S USB2.0 receivers.
 
 config DVB_USB_NOVA_T_USB2
 	tristate "Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 support"
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/Makefile	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/Makefile	2005-09-04 22:28:15.000000000 +0200
@@ -4,6 +4,9 @@ obj-$(CONFIG_DVB_USB) += dvb-usb.o
 dvb-usb-vp7045-objs = vp7045.o vp7045-fe.o
 obj-$(CONFIG_DVB_USB_VP7045) += dvb-usb-vp7045.o
 
+dvb-usb-vp702x-objs = vp702x.o vp702x-fe.o
+obj-$(CONFIG_DVB_USB_VP702X) += dvb-usb-vp702x.o
+
 dvb-usb-dtt200u-objs = dtt200u.o dtt200u-fe.o
 obj-$(CONFIG_DVB_USB_DTT200U) += dvb-usb-dtt200u.o
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp702x-fe.c	2005-09-04 22:28:15.000000000 +0200
@@ -0,0 +1,339 @@
+/* DVB frontend part of the Linux driver for the TwinhanDTV StarBox USB2.0
+ * DVB-S receiver.
+ *
+ * Copyright (C) 2005 Ralph Metzler <rjkm@metzlerbros.de>
+ *                    Metzler Brothers Systementwicklung GbR
+ *
+ * Copyright (C) 2005 Patrick Boettcher <patrick.boettcher@desy.de>
+ *
+ * Thanks to Twinhan who kindly provided hardware and information.
+ *
+ * This file can be removed soon, after the DST-driver is rewritten to provice
+ * the frontend-controlling separately.
+ *
+ *	This program is free software; you can redistribute it and/or modify it
+ *	under the terms of the GNU General Public License as published by the Free
+ *	Software Foundation, version 2.
+ *
+ * see Documentation/dvb/README.dvb-usb for more information
+ *
+ */
+#include "vp702x.h"
+
+struct vp702x_fe_state {
+	struct dvb_frontend fe;
+	struct dvb_usb_device *d;
+
+	fe_sec_voltage_t voltage;
+	fe_sec_tone_mode_t tone_mode;
+
+	u8 lnb_buf[8];
+
+	u8 lock;
+	u8 sig;
+	u8 snr;
+
+	unsigned long next_status_check;
+	unsigned long status_check_interval;
+};
+
+static int vp702x_fe_refresh_state(struct vp702x_fe_state *st)
+{
+	u8 buf[10];
+	if (time_after(jiffies,st->next_status_check)) {
+		vp702x_usb_in_op(st->d,READ_STATUS,0,0,buf,10);
+
+		st->lock = buf[4];
+		vp702x_usb_in_op(st->d,READ_TUNER_REG_REQ,0x11,0,&st->snr,1);
+		vp702x_usb_in_op(st->d,READ_TUNER_REG_REQ,0x15,0,&st->sig,1);
+
+		st->next_status_check = jiffies + (st->status_check_interval*HZ)/1000;
+	}
+	return 0;
+}
+
+static u8 vp702x_chksum(u8 *buf,int f, int count)
+{
+	u8 s = 0;
+	int i;
+	for (i = f; i < f+count; i++)
+		s += buf[i];
+	return ~s+1;
+}
+
+static int vp702x_fe_read_status(struct dvb_frontend* fe, fe_status_t *status)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	vp702x_fe_refresh_state(st);
+	deb_fe("%s\n",__FUNCTION__);
+
+	if (st->lock == 0)
+		*status = FE_HAS_LOCK | FE_HAS_SYNC | FE_HAS_VITERBI | FE_HAS_SIGNAL | FE_HAS_CARRIER;
+	else
+		*status = 0;
+
+	deb_fe("real state: %x\n",*status);
+	*status = 0x1f;
+
+	if (*status & FE_HAS_LOCK)
+		st->status_check_interval = 1000;
+	else
+		st->status_check_interval = 250;
+	return 0;
+}
+
+/* not supported by this Frontend */
+static int vp702x_fe_read_ber(struct dvb_frontend* fe, u32 *ber)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	vp702x_fe_refresh_state(st);
+	*ber = 0;
+	return 0;
+}
+
+/* not supported by this Frontend */
+static int vp702x_fe_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	vp702x_fe_refresh_state(st);
+	*unc = 0;
+	return 0;
+}
+
+static int vp702x_fe_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	vp702x_fe_refresh_state(st);
+
+	*strength = (st->sig << 8) | st->sig;
+	return 0;
+}
+
+static int vp702x_fe_read_snr(struct dvb_frontend* fe, u16 *snr)
+{
+	u8 _snr;
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	vp702x_fe_refresh_state(st);
+
+	_snr = (st->snr & 0x1f) * 0xff / 0x1f;
+	*snr = (_snr << 8) | _snr;
+	return 0;
+}
+
+static int vp702x_fe_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
+{
+	deb_fe("%s\n",__FUNCTION__);
+	tune->min_delay_ms = 2000;
+	return 0;
+}
+
+static int vp702x_fe_set_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	u32 freq = fep->frequency/1000;
+	/*CalFrequency*/
+/*	u16 frequencyRef[16] = { 2, 4, 8, 16, 32, 64, 128, 256, 24, 5, 10, 20, 40, 80, 160, 320 }; */
+	u64 sr;
+	u8 cmd[8] = { 0 },ibuf[10];
+
+	cmd[0] = (freq >> 8) & 0x7f;
+	cmd[1] =  freq       & 0xff;
+	cmd[2] = 1; /* divrate == 4 -> frequencyRef[1] -> 1 here */
+
+	sr = (u64) (fep->u.qpsk.symbol_rate/1000) << 20;
+	do_div(sr,88000);
+	cmd[3] = (sr >> 12) & 0xff;
+	cmd[4] = (sr >> 4)  & 0xff;
+	cmd[5] = (sr << 4)  & 0xf0;
+
+	deb_fe("setting frontend to: %u -> %u (%x) LNB-based GHz, symbolrate: %d -> %Lu (%Lx)\n",
+			fep->frequency,freq,freq, fep->u.qpsk.symbol_rate, sr, sr);
+
+/*	if (fep->inversion == INVERSION_ON)
+		cmd[6] |= 0x80; */
+
+	if (st->voltage == SEC_VOLTAGE_18)
+		cmd[6] |= 0x40;
+
+/*	if (fep->u.qpsk.symbol_rate > 8000000)
+		cmd[6] |= 0x20;
+
+	if (fep->frequency < 1531000)
+		cmd[6] |= 0x04;
+
+	if (st->tone_mode == SEC_TONE_ON)
+		cmd[6] |= 0x01;*/
+
+	cmd[7] = vp702x_chksum(cmd,0,7);
+
+	st->status_check_interval = 250;
+	st->next_status_check = jiffies;
+
+	vp702x_usb_in_op(st->d, RESET_TUNER, 0, 0, NULL, 0);
+	msleep(30);
+	vp702x_usb_inout_op(st->d,cmd,8,ibuf,10,100);
+
+	if (ibuf[2] == 0 && ibuf[3] == 0)
+		deb_fe("tuning failed.\n");
+	else
+		deb_fe("tuning succeeded.\n");
+
+	return 0;
+}
+
+static int vp702x_fe_get_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep)
+{
+	deb_fe("%s\n",__FUNCTION__);
+	return 0;
+}
+
+static int vp702x_fe_send_diseqc_msg (struct dvb_frontend* fe,
+		                    struct dvb_diseqc_master_cmd *m)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	u8 cmd[8],ibuf[10];
+	memset(cmd,0,8);
+
+	deb_fe("%s\n",__FUNCTION__);
+
+	if (m->msg_len > 4)
+		return -EINVAL;
+
+	cmd[1] = SET_DISEQC_CMD;
+	cmd[2] = m->msg_len;
+	memcpy(&cmd[3], m->msg, m->msg_len);
+	cmd[7] = vp702x_chksum(cmd,0,7);
+
+	vp702x_usb_inout_op(st->d,cmd,8,ibuf,10,100);
+
+	if (ibuf[2] == 0 && ibuf[3] == 0)
+		deb_fe("diseqc cmd failed.\n");
+	else
+		deb_fe("diseqc cmd succeeded.\n");
+
+	return 0;
+}
+
+static int vp702x_fe_send_diseqc_burst (struct dvb_frontend* fe, fe_sec_mini_cmd_t burst)
+{
+	deb_fe("%s\n",__FUNCTION__);
+	return 0;
+}
+
+static int vp702x_fe_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	u8 ibuf[10];
+	deb_fe("%s\n",__FUNCTION__);
+
+	st->tone_mode = tone;
+
+	if (tone == SEC_TONE_ON)
+		st->lnb_buf[2] = 0x02;
+	else
+		st->lnb_buf[2] = 0x00;
+
+	st->lnb_buf[7] = vp702x_chksum(st->lnb_buf,0,7);
+
+	vp702x_usb_inout_op(st->d,st->lnb_buf,8,ibuf,10,100);
+	if (ibuf[2] == 0 && ibuf[3] == 0)
+		deb_fe("set_tone cmd failed.\n");
+	else
+		deb_fe("set_tone cmd succeeded.\n");
+
+	return 0;
+}
+
+static int vp702x_fe_set_voltage (struct dvb_frontend* fe, fe_sec_voltage_t
+		voltage)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	u8 ibuf[10];
+	deb_fe("%s\n",__FUNCTION__);
+
+	st->voltage = voltage;
+
+	if (voltage != SEC_VOLTAGE_OFF)
+		st->lnb_buf[4] = 0x01;
+	else
+		st->lnb_buf[4] = 0x00;
+
+	st->lnb_buf[7] = vp702x_chksum(st->lnb_buf,0,7);
+
+	vp702x_usb_inout_op(st->d,st->lnb_buf,8,ibuf,10,100);
+	if (ibuf[2] == 0 && ibuf[3] == 0)
+		deb_fe("set_voltage cmd failed.\n");
+	else
+		deb_fe("set_voltage cmd succeeded.\n");
+
+	return 0;
+}
+
+static void vp702x_fe_release(struct dvb_frontend* fe)
+{
+	struct vp702x_fe_state *st = fe->demodulator_priv;
+	kfree(st);
+}
+
+static struct dvb_frontend_ops vp702x_fe_ops;
+
+struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d)
+{
+	struct vp702x_fe_state *s = kmalloc(sizeof(struct vp702x_fe_state), GFP_KERNEL);
+	if (s == NULL)
+		goto error;
+	memset(s,0,sizeof(struct vp702x_fe_state));
+
+	s->d = d;
+	s->fe.ops = &vp702x_fe_ops;
+	s->fe.demodulator_priv = s;
+
+	s->lnb_buf[1] = SET_LNB_POWER;
+	s->lnb_buf[3] = 0xff; /* 0=tone burst, 2=data burst, ff=off */
+
+	goto success;
+error:
+	return NULL;
+success:
+	return &s->fe;
+}
+
+
+static struct dvb_frontend_ops vp702x_fe_ops = {
+	.info = {
+		.name           = "Twinhan DST-like frontend (VP7021/VP7020) DVB-S",
+		.type           = FE_QPSK,
+		.frequency_min       = 950000,
+		.frequency_max       = 2150000,
+		.frequency_stepsize  = 1000,   /* kHz for QPSK frontends */
+		.frequency_tolerance = 0,
+		.symbol_rate_min     = 1000000,
+		.symbol_rate_max     = 45000000,
+		.symbol_rate_tolerance = 500,  /* ppm */
+		.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
+		FE_CAN_QPSK |
+		FE_CAN_FEC_AUTO
+	},
+	.release = vp702x_fe_release,
+
+	.init = NULL,
+	.sleep = NULL,
+
+	.set_frontend = vp702x_fe_set_frontend,
+	.get_frontend = vp702x_fe_get_frontend,
+	.get_tune_settings = vp702x_fe_get_tune_settings,
+
+	.read_status = vp702x_fe_read_status,
+	.read_ber = vp702x_fe_read_ber,
+	.read_signal_strength = vp702x_fe_read_signal_strength,
+	.read_snr = vp702x_fe_read_snr,
+	.read_ucblocks = vp702x_fe_read_unc_blocks,
+
+	.diseqc_send_master_cmd = vp702x_fe_send_diseqc_msg,
+	.diseqc_send_burst = vp702x_fe_send_diseqc_burst,
+	.set_tone = vp702x_fe_set_tone,
+	.set_voltage = vp702x_fe_set_voltage,
+};
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp702x.c	2005-09-04 22:28:15.000000000 +0200
@@ -0,0 +1,290 @@
+/* DVB USB compliant Linux driver for the TwinhanDTV StarBox USB2.0 DVB-S
+ * receiver.
+ *
+ * Copyright (C) 2005 Ralph Metzler <rjkm@metzlerbros.de>
+ *                    Metzler Brothers Systementwicklung GbR
+ *
+ * Copyright (C) 2005 Patrick Boettcher <patrick.boettcher@desy.de>
+ *
+ * Thanks to Twinhan who kindly provided hardware and information.
+ *
+ *	This program is free software; you can redistribute it and/or modify it
+ *	under the terms of the GNU General Public License as published by the Free
+ *	Software Foundation, version 2.
+ *
+ * see Documentation/dvb/README.dvb-usb for more information
+ */
+#include "vp702x.h"
+
+/* debug */
+int dvb_usb_vp702x_debug;
+module_param_named(debug,dvb_usb_vp702x_debug, int, 0644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,xfer=2,rc=4 (or-able))." DVB_USB_DEBUG_STATUS);
+
+struct vp702x_state {
+	u8 pid_table[17]; /* [16] controls the pid_table state */
+};
+
+/* check for mutex FIXME */
+int vp702x_usb_in_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen)
+{
+	int ret = 0,try = 0;
+
+	while (ret >= 0 && ret != blen && try < 3) {
+		ret = usb_control_msg(d->udev,
+			usb_rcvctrlpipe(d->udev,0),
+			req,
+			USB_TYPE_VENDOR | USB_DIR_IN,
+			value,index,b,blen,
+			2000);
+		deb_info("reading number %d (ret: %d)\n",try,ret);
+		try++;
+	}
+
+	if (ret < 0 || ret != blen) {
+		warn("usb in operation failed.");
+		ret = -EIO;
+	} else
+		ret = 0;
+
+	deb_xfer("in: req. %x, val: %x, ind: %x, buffer: ",req,value,index);
+	debug_dump(b,blen,deb_xfer);
+
+	return ret;
+}
+
+int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen)
+{
+	deb_xfer("out: req. %x, val: %x, ind: %x, buffer: ",req,value,index);
+	debug_dump(b,blen,deb_xfer);
+
+	if (usb_control_msg(d->udev,
+			usb_sndctrlpipe(d->udev,0),
+			req,
+			USB_TYPE_VENDOR | USB_DIR_OUT,
+			value,index,b,blen,
+			2000) != blen) {
+		warn("usb out operation failed.");
+		return -EIO;
+	} else
+		return 0;
+}
+
+int vp702x_usb_inout_op(struct dvb_usb_device *d, u8 *o, int olen, u8 *i, int ilen, int msec)
+{
+	int ret;
+
+	if ((ret = down_interruptible(&d->usb_sem)))
+		return ret;
+
+	if ((ret = vp702x_usb_out_op(d,REQUEST_OUT,0,0,o,olen)) < 0)
+		goto unlock;
+	msleep(msec);
+	ret = vp702x_usb_in_op(d,REQUEST_IN,0,0,i,ilen);
+
+unlock:
+	up(&d->usb_sem);
+
+	return ret;
+}
+
+int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec)
+{
+	u8 bout[olen+2];
+	u8 bin[ilen+1];
+	int ret = 0;
+
+	bout[0] = 0x00;
+	bout[1] = cmd;
+	memcpy(&bout[2],o,olen);
+
+	ret = vp702x_usb_inout_op(d, bout, olen+2, bin, ilen+1,msec);
+
+	if (ret == 0)
+		memcpy(i,&bin[1],ilen);
+
+	return ret;
+}
+
+static int vp702x_pid_filter(struct dvb_usb_device *d, int index, u16 pid, int onoff)
+{
+	struct vp702x_state *st = d->priv;
+	u8 buf[9];
+
+	if (onoff) {
+		st->pid_table[16]   |=   1 << index;
+		st->pid_table[index*2]   = (pid >> 8) & 0xff;
+		st->pid_table[index*2+1] =  pid       & 0xff;
+	} else {
+		st->pid_table[16]   &= ~(1 << index);
+		st->pid_table[index*2] = st->pid_table[index*2+1] = 0;
+	}
+
+	return vp702x_usb_inout_cmd(d,SET_PID_FILTER,st->pid_table,17,buf,9,10);
+}
+
+static int vp702x_power_ctrl(struct dvb_usb_device *d, int onoff)
+{
+	vp702x_usb_in_op(d,RESET_TUNER,0,0,NULL,0);
+
+	vp702x_usb_in_op(d,SET_TUNER_POWER_REQ,0,onoff,NULL,0);
+	return vp702x_usb_in_op(d,SET_TUNER_POWER_REQ,0,onoff,NULL,0);
+}
+
+/* keys for the enclosed remote control */
+static struct dvb_usb_rc_key vp702x_rc_keys[] = {
+	{ 0x00, 0x01, KEY_1 },
+	{ 0x00, 0x02, KEY_2 },
+};
+
+/* remote control stuff (does not work with my box) */
+static int vp702x_rc_query(struct dvb_usb_device *d, u32 *event, int *state)
+{
+	u8 key[10];
+	int i;
+
+/* remove the following return to enabled remote querying */
+	return 0;
+
+	vp702x_usb_in_op(d,READ_REMOTE_REQ,0,0,key,10);
+
+	deb_rc("remote query key: %x %d\n",key[1],key[1]);
+
+	if (key[1] == 0x44) {
+		*state = REMOTE_NO_KEY_PRESSED;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vp702x_rc_keys); i++)
+		if (vp702x_rc_keys[i].custom == key[1]) {
+			*state = REMOTE_KEY_PRESSED;
+			*event = vp702x_rc_keys[i].event;
+			break;
+		}
+	return 0;
+}
+
+static int vp702x_read_mac_addr(struct dvb_usb_device *d,u8 mac[6])
+{
+	u8 macb[9];
+	if (vp702x_usb_inout_cmd(d, GET_MAC_ADDRESS, NULL, 0, macb, 9, 10))
+		return -EIO;
+	memcpy(mac,&macb[3],6);
+	return 0;
+}
+
+static int vp702x_frontend_attach(struct dvb_usb_device *d)
+{
+	u8 buf[9] = { 0 };
+
+	if (vp702x_usb_inout_cmd(d, GET_SYSTEM_STRING, NULL, 0, buf, 9, 10))
+		return -EIO;
+
+	buf[8] = '\0';
+	info("system string: %s",&buf[1]);
+
+	d->fe = vp702x_fe_attach(d);
+	return 0;
+}
+
+static struct dvb_usb_properties vp702x_properties;
+
+static int vp702x_usb_probe(struct usb_interface *intf,
+		const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	usb_clear_halt(udev,usb_sndctrlpipe(udev,0));
+	usb_clear_halt(udev,usb_rcvctrlpipe(udev,0));
+
+	return dvb_usb_device_init(intf,&vp702x_properties,THIS_MODULE);
+}
+
+static struct usb_device_id vp702x_usb_table [] = {
+	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7021_COLD) },
+	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7021_WARM) },
+	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7020_COLD) },
+	    { USB_DEVICE(USB_VID_VISIONPLUS, USB_PID_TWINHAN_VP7020_WARM) },
+	    { 0 },
+};
+MODULE_DEVICE_TABLE(usb, vp702x_usb_table);
+
+static struct dvb_usb_properties vp702x_properties = {
+	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_NEED_PID_FILTERING,
+	.pid_filter_count = 8, /* !!! */
+
+	.usb_ctrl = CYPRESS_FX2,
+	.firmware = "dvb-usb-vp702x-01.fw",
+
+	.pid_filter       = vp702x_pid_filter,
+	.power_ctrl       = vp702x_power_ctrl,
+	.frontend_attach  = vp702x_frontend_attach,
+	.read_mac_address = vp702x_read_mac_addr,
+
+	.rc_key_map       = vp702x_rc_keys,
+	.rc_key_map_size  = ARRAY_SIZE(vp702x_rc_keys),
+	.rc_interval      = 400,
+	.rc_query         = vp702x_rc_query,
+
+	.size_of_priv     = sizeof(struct vp702x_state),
+
+	/* parameter for the MPEG2-data transfer */
+	.urb = {
+		.type = DVB_USB_BULK,
+		.count = 7,
+		.endpoint = 0x02,
+		.u = {
+			.bulk = {
+				.buffersize = 4096,
+			}
+		}
+	},
+
+	.num_device_descs = 2,
+	.devices = {
+		{ .name = "TwinhanDTV StarBox DVB-S USB2.0 (VP7021)",
+		  .cold_ids = { &vp702x_usb_table[0], NULL },
+		  .warm_ids = { &vp702x_usb_table[1], NULL },
+		},
+		{ .name = "TwinhanDTV StarBox DVB-S USB2.0 (VP7020)",
+		  .cold_ids = { &vp702x_usb_table[2], NULL },
+		  .warm_ids = { &vp702x_usb_table[3], NULL },
+		},
+		{ 0 },
+	}
+};
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver vp702x_usb_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "dvb-usb-vp702x",
+	.probe 		= vp702x_usb_probe,
+	.disconnect = dvb_usb_device_exit,
+	.id_table 	= vp702x_usb_table,
+};
+
+/* module stuff */
+static int __init vp702x_usb_module_init(void)
+{
+	int result;
+	if ((result = usb_register(&vp702x_usb_driver))) {
+		err("usb_register failed. (%d)",result);
+		return result;
+	}
+
+	return 0;
+}
+
+static void __exit vp702x_usb_module_exit(void)
+{
+	/* deregister this driver from the USB subsystem */
+	usb_deregister(&vp702x_usb_driver);
+}
+
+module_init(vp702x_usb_module_init);
+module_exit(vp702x_usb_module_exit);
+
+MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de>");
+MODULE_DESCRIPTION("Driver for Twinhan StarBox DVB-S USB2.0 and clones");
+MODULE_VERSION("1.0-alpha");
+MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp702x.h	2005-09-04 22:28:15.000000000 +0200
@@ -0,0 +1,109 @@
+#ifndef _DVB_USB_VP7021_H_
+#define _DVB_USB_VP7021_H_
+
+#define DVB_USB_LOG_PREFIX "vp702x"
+#include "dvb-usb.h"
+
+extern int dvb_usb_vp702x_debug;
+#define deb_info(args...) dprintk(dvb_usb_vp702x_debug,0x01,args)
+#define deb_xfer(args...) dprintk(dvb_usb_vp702x_debug,0x02,args)
+#define deb_rc(args...)   dprintk(dvb_usb_vp702x_debug,0x04,args)
+#define deb_fe(args...)   dprintk(dvb_usb_vp702x_debug,0x08,args)
+
+/* commands are read and written with USB control messages */
+
+/* consecutive read/write operation */
+#define REQUEST_OUT       0xB2
+#define REQUEST_IN		  0xB3
+
+/* the out-buffer of these consecutive operations contain sub-commands when b[0] = 0
+ * request: 0xB2; i: 0; v: 0; b[0] = 0, b[1] = subcmd, additional buffer
+ * the returning buffer looks as follows
+ * request: 0xB3; i: 0; v: 0; b[0] = 0xB3, additional buffer */
+
+#define GET_TUNER_STATUS  0x05
+/* additional in buffer:
+ * 0   1   2    3              4   5   6               7       8
+ * N/A N/A 0x05 signal-quality N/A N/A signal-strength lock==0 N/A */
+
+#define GET_SYSTEM_STRING 0x06
+/* additional in buffer:
+ * 0   1   2   3   4   5   6   7   8
+ * N/A 'U' 'S' 'B' '7' '0' '2' 'X' N/A */
+
+#define SET_DISEQC_CMD    0x08
+/* additional out buffer:
+ * 0    1  2  3  4
+ * len  X1 X2 X3 X4
+ * additional in buffer:
+ * 0   1 2
+ * N/A 0 0   b[1] == b[2] == 0 -> success otherwise not */
+
+#define SET_LNB_POWER     0x09
+/* additional out buffer:
+ * 0    1    2
+ * 0x00 0xff 1 = on, 0 = off
+ * additional in buffer:
+ * 0   1 2
+ * N/A 0 0   b[1] == b[2] == 0 -> success otherwise not */
+
+#define GET_MAC_ADDRESS   0x0A
+/* #define GET_MAC_ADDRESS   0x0B */
+/* additional in buffer:
+ * 0   1   2            3    4    5    6    7    8
+ * N/A N/A 0x0A or 0x0B MAC0 MAC1 MAC2 MAC3 MAC4 MAC5 */
+
+#define SET_PID_FILTER    0x11
+/* additional in buffer:
+ * 0        1        ... 14       15       16
+ * PID0_MSB PID0_LSB ... PID7_MSB PID7_LSB PID_active (bits) */
+
+/* request: 0xB2; i: 0; v: 0;
+ * b[0] != 0 -> tune and lock a channel
+ * 0     1     2       3      4      5      6    7
+ * freq0 freq1 divstep srate0 srate1 srate2 flag chksum
+ */
+
+
+/* one direction requests */
+#define READ_REMOTE_REQ       0xB4
+/* IN  i: 0; v: 0; b[0] == request, b[1] == key */
+
+#define READ_PID_NUMBER_REQ   0xB5
+/* IN  i: 0; v: 0; b[0] == request, b[1] == 0, b[2] = pid number */
+
+#define WRITE_EEPROM_REQ      0xB6
+/* OUT i: offset; v: value to write; no extra buffer */
+
+#define READ_EEPROM_REQ       0xB7
+/* IN  i: bufferlen; v: offset; buffer with bufferlen bytes */
+
+#define READ_STATUS           0xB8
+/* IN  i: 0; v: 0; bufferlen 10 */
+
+#define READ_TUNER_REG_REQ    0xB9
+/* IN  i: 0; v: register; b[0] = value */
+
+#define READ_FX2_REG_REQ      0xBA
+/* IN  i: offset; v: 0; b[0] = value */
+
+#define WRITE_FX2_REG_REQ     0xBB
+/* OUT i: offset; v: value to write; 1 byte extra buffer */
+
+#define SET_TUNER_POWER_REQ   0xBC
+/* IN  i: 0 = power off, 1 = power on */
+
+#define WRITE_TUNER_REG_REQ   0xBD
+/* IN  i: register, v: value to write, no extra buffer */
+
+#define RESET_TUNER           0xBE
+/* IN  i: 0, v: 0, no extra buffer */
+
+extern struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d);
+
+extern int vp702x_usb_inout_op(struct dvb_usb_device *d, u8 *o, int olen, u8 *i, int ilen, int msec);
+extern int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec);
+extern int vp702x_usb_in_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
+extern int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
+
+#endif
--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/dvb-usb-ids.h	2005-09-04 22:28:15.000000000 +0200
@@ -52,12 +52,14 @@
 #define USB_PID_KWORLD_VSTREAM_WARM			0x17df
 #define USB_PID_TWINHAN_VP7041_COLD			0x3201
 #define USB_PID_TWINHAN_VP7041_WARM			0x3202
+#define USB_PID_TWINHAN_VP7020_COLD			0x3203
+#define USB_PID_TWINHAN_VP7020_WARM			0x3204
 #define USB_PID_TWINHAN_VP7045_COLD			0x3205
 #define USB_PID_TWINHAN_VP7045_WARM			0x3206
-#define USB_PID_DNTV_TINYUSB2_COLD			0x3223
-#define USB_PID_DNTV_TINYUSB2_WARM			0x3224
 #define USB_PID_TWINHAN_VP7021_COLD			0x3207
 #define USB_PID_TWINHAN_VP7021_WARM			0x3208
+#define USB_PID_DNTV_TINYUSB2_COLD			0x3223
+#define USB_PID_DNTV_TINYUSB2_WARM			0x3224
 #define USB_PID_ULTIMA_TVBOX_COLD			0x8105
 #define USB_PID_ULTIMA_TVBOX_WARM			0x8106
 #define USB_PID_ULTIMA_TVBOX_AN2235_COLD	0x8107

--

