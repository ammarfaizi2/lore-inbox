Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVCVBxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVCVBxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVCVBte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:49:34 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:39051 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262343AbVCVBgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:05 -0500
Message-Id: <20050322013500.196244000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:16 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb-dtt200u.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 43/48] dibusb: support dtt200u (Yakumo/Typhoon/Hama) USB2.0 device
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o added native support for the dtt200u (Yakumo/Typhoon/Hama) USB2.0 device
o URBs are now submitted, when the actual transfer began, not right from the
  device plugin (solves a lot of problems)
o minor fixes in the dib3000-frontends
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dibusb/Makefile            |    3 
 dibusb/dvb-dibusb-core.c   |   26 ++--
 dibusb/dvb-dibusb-dvb.c    |    5 
 dibusb/dvb-dibusb-fe-i2c.c |   27 ----
 dibusb/dvb-dibusb-usb.c    |   70 +++++++++---
 dibusb/dvb-dibusb.h        |    9 +
 dibusb/dvb-fe-dtt200u.c    |  258 +++++++++++++++++++++++++++++++++++++++++++++
 frontends/dib3000mb.c      |    1 
 frontends/dib3000mc.c      |    1 
 9 files changed, 350 insertions(+), 50 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Makefile
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/Makefile	2005-03-22 00:17:09.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/Makefile	2005-03-22 00:28:15.000000000 +0100
@@ -3,7 +3,8 @@ dvb-dibusb-objs = dvb-dibusb-core.o \
 	dvb-dibusb-fe-i2c.o \
 	dvb-dibusb-firmware.o \
 	dvb-dibusb-remote.o \
-	dvb-dibusb-usb.o
+	dvb-dibusb-usb.o \
+	dvb-fe-dtt200u.o
 
 obj-$(CONFIG_DVB_DIBUSB) += dvb-dibusb.o
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-core.c	2005-03-22 00:28:15.000000000 +0100
@@ -119,10 +119,6 @@ static struct usb_device_id dib_table []
 /* 00 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_AVERMEDIA_DVBT_USB_COLD)},
 /* 01 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_AVERMEDIA_DVBT_USB_WARM)},
 /* 02 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_COLD) },
-
-/* the following device is actually not supported, but when loading the 
- * correct firmware (ie. its usb ids will change) everything works fine then 
- */
 /* 03 */	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_WARM) },
 
 /* 04 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
@@ -161,7 +157,7 @@ static struct usb_device_id dib_table []
  * activate the following define when you have one of the devices and want to 
  * build it from build-2.6 in dvb-kernel
  */
-// #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES 
+// #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
 #ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
 /* 34 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
 /* 35 */	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
@@ -207,6 +203,10 @@ static struct dibusb_demod dibusb_demod[
 	  254,
 	  { 0xf, 0 }, 
 	},
+	{ DTT200U_FE,
+	  8,
+	  { 0xff,0 }, /* there is no i2c bus in this device */
+	}
 };
 
 static struct dibusb_device_class dibusb_device_classes[] = {
@@ -258,6 +258,14 @@ static struct dibusb_device_class dibusb
 	  &dibusb_demod[DIBUSB_DIB3000MC],
 	  &dibusb_tuner[DIBUSB_TUNER_COFDM_PANASONIC_ENV57H1XD5],
 	},
+	{ DTT200U,&dibusb_usb_ctrl[2],
+	  "dvb-dtt200u-1.fw",
+	  0x01, 0x02,
+	  7, 4096,
+	  DIBUSB_RC_NO,
+	  &dibusb_demod[DTT200U_FE],
+	  NULL, /* no explicit tuner/pll-programming necessary (it has the ENV57H1XD5) */
+	},
 };
 
 static struct dibusb_usb_device dibusb_devices[] = {
@@ -321,10 +329,10 @@ static struct dibusb_usb_device dibusb_d
 		{ &dib_table[30], NULL },
 		{ &dib_table[31], NULL },
 	},
-	{	"AVermedia/Yakumo/Hama/Typhoon DVB-T USB2.0",
-		&dibusb_device_classes[UMT2_0],
+	{	"DTT200U (Yakumo/Hama/Typhoon) DVB-T USB2.0",
+		&dibusb_device_classes[DTT200U],
 		{ &dib_table[2], NULL },
-		{ NULL },
+		{ &dib_table[3], NULL },
 	},	
 	{	"Hanftek UMT-010 DVB-T USB2.0",
 		&dibusb_device_classes[UMT2_0],
@@ -343,7 +351,7 @@ static struct dibusb_usb_device dibusb_d
 		{ NULL },
 	},
 	{	"Artec T1 USB2.0 TVBOX with FX2 IDs (misdesigned, please report the warm ID)",
-		&dibusb_device_classes[DIBUSB2_0],
+		&dibusb_device_classes[DTT200U],
 		{ &dib_table[35], NULL },
 		{ &dib_table[36], NULL }, /* undefined, it could be that the device will get another USB ID in warm state */
 	},
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:27:41.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:28:15.000000000 +0100
@@ -34,7 +34,7 @@ void dibusb_urb_complete(struct urb *urb
 		case 0:         /* success */
 		case -ETIMEDOUT:    /* NAK */
 			break;
-		case -ECONNRESET:   /* unlink */
+		case -ECONNRESET:   /* kill */
 		case -ENOENT:
 		case -ESHUTDOWN:
 			return;
@@ -43,7 +43,7 @@ void dibusb_urb_complete(struct urb *urb
 			break;
 	}
 
-	if (dib->feedcount > 0) {
+	if (dib->feedcount > 0 && urb->actual_length > 0) {
 		if (dib->init_state & DIBUSB_STATE_DVB)
 			dvb_dmx_swfilter(&dib->demux, (u8*) urb->transfer_buffer,urb->actual_length);
 	} else 
@@ -73,6 +73,7 @@ static int dibusb_ctrl_feed(struct dvb_d
 				return -ENODEV;
 			}
 		}
+		dibusb_streaming(dib,0);
 	}
 	
 	dib->feedcount = newfeedcount;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:28:15.000000000 +0100
@@ -125,27 +125,6 @@ static int dibusb_tuner_quirk(struct usb
 	return 0;
 }
 
-/* there is a ugly pid_filter in the firmware of the umt devices, it is accessible
- * by i2c address 0x8. Don't know how to deactivate it and how many rows it has.
- */
-static int dibusb_umt_pid_control(struct dvb_frontend *fe, int index, int pid, int onoff)
-{
-	struct usb_dibusb *dib = fe->dvb->priv;
-	u8 b[3];
-	b[0] = index;
-	if (onoff) {
-		b[1] = (pid >> 8) & 0xff;
-		b[2] = pid & 0xff;
-	} else {
-		b[1] = 0;
-		b[2] = 0;
-	}
-	dibusb_i2c_msg(dib, 0x8, b, 3, NULL,0);
-	dibusb_set_streaming_mode(dib,0);
-	dibusb_set_streaming_mode(dib,1);
-	return 0;
-}
-
 int dibusb_fe_init(struct usb_dibusb* dib)
 {
 	struct dib3000_config demod_cfg;
@@ -160,6 +139,8 @@ int dibusb_fe_init(struct usb_dibusb* di
 			demod_cfg.pll_set = dibusb_general_pll_set;
 			demod_cfg.pll_init = dibusb_general_pll_init;
 
+			deb_info("demod id: %d %d\n",dib->dibdev->dev_cl->demod->id,DTT200U_FE);
+
 			switch (dib->dibdev->dev_cl->demod->id) {
 				case DIBUSB_DIB3000MB:
 					dib->fe = dib3000mb_attach(&demod_cfg,&dib->i2c_adap,&dib->xfer_ops);
@@ -170,7 +151,9 @@ int dibusb_fe_init(struct usb_dibusb* di
 				case DIBUSB_MT352:
 					mt352_hanftek_umt_010_config.demod_address = dib->dibdev->dev_cl->demod->i2c_addrs[i];
 					dib->fe = mt352_attach(&mt352_hanftek_umt_010_config, &dib->i2c_adap);
-					dib->xfer_ops.pid_ctrl = dibusb_umt_pid_control;
+				break;
+				case DTT200U_FE:
+					dib->fe = dtt200u_fe_attach(dib,&dib->xfer_ops);
 				break;
 			}
 			if (dib->fe != NULL) {
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:28:15.000000000 +0100
@@ -57,7 +57,7 @@ int dibusb_readwrite_usb(struct usb_dibu
 /*
  * Cypress controls
  */
-static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
+int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
 {
 	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
 }
@@ -103,7 +103,14 @@ int dibusb_hw_wakeup(struct dvb_frontend
 	struct usb_dibusb *dib = (struct usb_dibusb *) fe->dvb->priv;
 	u8 b[1] = { DIBUSB_IOCTL_POWER_WAKEUP };
 	deb_info("dibusb-device is getting up.\n");
-	dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+
+	switch (dib->dibdev->dev_cl->id) {
+		case DTT200U:
+			break;
+		default:
+			dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+			break;
+	}
 
 	if (dib->fe_init)
 		return dib->fe_init(fe);
@@ -120,6 +127,7 @@ int dibusb_hw_sleep(struct dvb_frontend 
 	switch (dib->dibdev->dev_cl->id) {
 		case DIBUSB1_1:
 		case NOVAT_USB2:
+		case DTT200U:
 			break;
 		default:
 			dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
@@ -137,8 +145,47 @@ int dibusb_set_streaming_mode(struct usb
 	return dibusb_readwrite_usb(dib,b,2,NULL,0);
 }
 
+static int dibusb_urb_kill(struct usb_dibusb *dib)
+{
+	int i;
+deb_info("trying to kill urbs\n");
+	if (dib->init_state & DIBUSB_STATE_URB_SUBMIT) {
+		for (i = 0; i < dib->dibdev->dev_cl->urb_count; i++) {
+			deb_info("killing URB no. %d.\n",i);
+
+			/* stop the URB */
+			usb_kill_urb(dib->urb_list[i]);
+		}
+	} else
+	deb_info(" URBs not killed.\n");
+	dib->init_state &= ~DIBUSB_STATE_URB_SUBMIT;
+	return 0;
+}
+
+static int dibusb_urb_submit(struct usb_dibusb *dib)
+{
+	int i,ret;
+	if (dib->init_state & DIBUSB_STATE_URB_INIT) {
+		for (i = 0; i < dib->dibdev->dev_cl->urb_count; i++) {
+			deb_info("submitting URB no. %d\n",i);
+			if ((ret = usb_submit_urb(dib->urb_list[i],GFP_ATOMIC))) {
+				err("could not submit buffer urb no. %d - get them all back\n",i);
+				dibusb_urb_kill(dib);
+				return ret;
+			}
+			dib->init_state |= DIBUSB_STATE_URB_SUBMIT;
+		}
+	}
+	return 0;
+}
+
 int dibusb_streaming(struct usb_dibusb *dib,int onoff)
 {
+	if (onoff)
+		dibusb_urb_submit(dib);
+	else
+		dibusb_urb_kill(dib);
+
 	switch (dib->dibdev->dev_cl->id) {
 		case DIBUSB2_0:
 		case DIBUSB2_0B:
@@ -157,7 +204,7 @@ int dibusb_streaming(struct usb_dibusb *
 
 int dibusb_urb_init(struct usb_dibusb *dib)
 {
-	int ret,i,bufsize,def_pid_parse = 1;
+	int i,bufsize,def_pid_parse = 1;
 
 	/*
 	 * when reloading the driver w/o replugging the device
@@ -192,7 +239,6 @@ int dibusb_urb_init(struct usb_dibusb *d
 		if (!(dib->urb_list[i] = usb_alloc_urb(0,GFP_ATOMIC))) {
 			return -ENOMEM;
 		}
-		deb_info("submitting URB no. %d\n",i);
 
 		usb_fill_bulk_urb( dib->urb_list[i], dib->udev,
 				usb_rcvbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_data),
@@ -202,11 +248,7 @@ int dibusb_urb_init(struct usb_dibusb *d
 
 		dib->urb_list[i]->transfer_flags = 0;
 
-		if ((ret = usb_submit_urb(dib->urb_list[i],GFP_ATOMIC))) {
-			err("could not submit buffer urb no. %d\n",i);
-			return ret;
-		}
-		dib->init_state |= DIBUSB_STATE_URB_SUBMIT;
+		dib->init_state |= DIBUSB_STATE_URB_INIT;
 	}
 
 	/* dib->pid_parse here contains the value of the module parameter */
@@ -234,14 +276,12 @@ int dibusb_urb_init(struct usb_dibusb *d
 int dibusb_urb_exit(struct usb_dibusb *dib)
 {
 	int i;
+
+	dibusb_urb_kill(dib);
+
 	if (dib->init_state & DIBUSB_STATE_URB_LIST) {
 		for (i = 0; i < dib->dibdev->dev_cl->urb_count; i++) {
 			if (dib->urb_list[i] != NULL) {
-				deb_info("killing URB no. %d.\n",i);
-
-				/* stop the URBs */
-				usb_kill_urb(dib->urb_list[i]);
-
 				deb_info("freeing URB no. %d.\n",i);
 				/* free the URBs */
 				usb_free_urb(dib->urb_list[i]);
@@ -249,7 +289,6 @@ int dibusb_urb_exit(struct usb_dibusb *d
 		}
 		/* free the urb array */
 		kfree(dib->urb_list);
-		dib->init_state &= ~DIBUSB_STATE_URB_SUBMIT;
 		dib->init_state &= ~DIBUSB_STATE_URB_LIST;
 	}
 
@@ -259,5 +298,6 @@ int dibusb_urb_exit(struct usb_dibusb *d
 			dib->buffer,dib->dma_handle);
 
 	dib->init_state &= ~DIBUSB_STATE_URB_BUF;
+	dib->init_state &= ~DIBUSB_STATE_URB_INIT;
 	return 0;
 }
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:18:30.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:28:15.000000000 +0100
@@ -74,6 +74,7 @@ typedef enum {
 	UMT2_0,
 	DIBUSB2_0B,
 	NOVAT_USB2,
+	DTT200U,
 } dibusb_class_t;
 
 typedef enum {
@@ -87,6 +88,7 @@ typedef enum {
 	DIBUSB_DIB3000MB = 0,
 	DIBUSB_DIB3000MC,
 	DIBUSB_MT352,
+	DTT200U_FE,
 } dibusb_demodulator_t;
 
 typedef enum {
@@ -155,10 +157,11 @@ struct usb_dibusb {
 #define DIBUSB_STATE_INIT       0x000
 #define DIBUSB_STATE_URB_LIST   0x001
 #define DIBUSB_STATE_URB_BUF    0x002
-#define DIBUSB_STATE_URB_SUBMIT 0x004
+#define DIBUSB_STATE_URB_INIT	0x004
 #define DIBUSB_STATE_DVB        0x008
 #define DIBUSB_STATE_I2C        0x010
 #define DIBUSB_STATE_REMOTE		0x020
+#define DIBUSB_STATE_URB_SUBMIT 0x040
 	int init_state;
 
 	int feedcount;
@@ -223,6 +226,7 @@ int dibusb_dvb_exit(struct usb_dibusb *d
 /* dvb-dibusb-usb.c */
 int dibusb_readwrite_usb(struct usb_dibusb *dib, u8 *wbuf, u16 wlen, u8 *rbuf,
 	u16 rlen);
+int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len);
 
 int dibusb_hw_wakeup(struct dvb_frontend *);
 int dibusb_hw_sleep(struct dvb_frontend *);
@@ -232,6 +236,9 @@ int dibusb_streaming(struct usb_dibusb *
 int dibusb_urb_init(struct usb_dibusb *);
 int dibusb_urb_exit(struct usb_dibusb *);
 
+/* dvb-fe-dtt200u.c */
+struct dvb_frontend* dtt200u_fe_attach(struct usb_dibusb *,struct dib_fe_xfer_ops *);
+
 /* i2c and transfer stuff */
 #define DIBUSB_I2C_TIMEOUT				5000
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-fe-dtt200u.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-fe-dtt200u.c	2005-03-22 00:28:15.000000000 +0100
@@ -0,0 +1,258 @@
+/*
+ * dvb-dtt200u-fe.c is a driver which implements the frontend-part of the
+ * Yakumo/Typhoon/Hama USB2.0 boxes. It is hard-wired to the dibusb-driver as
+ * it uses the usb-transfer functions directly (maybe creating a
+ * generic-dvb-usb-lib for all usb-drivers will be reduce some more code.)
+ *
+ * Copyright (C) 2005 Patrick Boettcher <patrick.boettcher@desy.de>
+ *
+ * see dvb-dibusb-core.c for copyright details.
+ */
+
+/* guessed protocol description (reverse engineered):
+ * read
+ *  00 - USB type 0x02 for usb2.0, 0x01 for usb1.1
+ *  81 - <TS_LOCK> <current frequency divided by 250000>
+ *  82 - crash - do not touch
+ *  83 - crash - do not touch
+ *  84 - remote control
+ *  85 - crash - do not touch (OK, stop testing here)
+ *  88 - locking 2 bytes (0x80 0x40 == no signal, 0x89 0x20 == nice signal)
+ *  89 - noise-to-signal
+ *	8a - unkown 1 byte - signal_strength
+ *  8c - ber ???
+ *  8d - ber
+ *  8e - unc
+ *
+ * write
+ *  02 - bandwidth
+ *  03 - frequency (divided by 250000)
+ *  04 - pid table (index pid(7:0) pid(12:8))
+ *  05 - reset the pid table
+ *  08 - demod transfer enabled or not (FX2 transfer is enabled by default)
+ */
+
+#include "dvb-dibusb.h"
+#include "dvb_frontend.h"
+
+struct dtt200u_fe_state {
+	struct usb_dibusb *dib;
+
+	struct dvb_frontend_parameters fep;
+	struct dvb_frontend frontend;
+};
+
+#define moan(which,what) info("unexpected value in '%s' for cmd '%02x' - please report to linux-dvb@linuxtv.org",which,what)
+
+static int dtt200u_fe_read_status(struct dvb_frontend* fe, fe_status_t *stat)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u8 bw[1] = { 0x81 };
+	u8 br[3] = { 0 };
+//	u8 bdeb[5] = { 0 };
+
+	dibusb_readwrite_usb(state->dib,bw,1,br,3);
+	switch (br[0]) {
+		case 0x01:
+			*stat = FE_HAS_SIGNAL | FE_HAS_CARRIER | FE_HAS_VITERBI | FE_HAS_SYNC | FE_HAS_LOCK;
+			break;
+		case 0x00:
+			*stat = 0;
+			break;
+		default:
+			moan("br[0]",0x81);
+			break;
+	}
+
+//	bw[0] = 0x88;
+//	dibusb_readwrite_usb(state->dib,bw,1,bdeb,5);
+
+//	deb_info("%02x: %02x %02x %02x %02x %02x\n",bw[0],bdeb[0],bdeb[1],bdeb[2],bdeb[3],bdeb[4]);
+
+	return 0;
+}
+static int dtt200u_fe_read_ber(struct dvb_frontend* fe, u32 *ber)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u8 bw[1] = { 0x8d };
+	*ber = 0;
+	dibusb_readwrite_usb(state->dib,bw,1,(u8*) ber, 3);
+	return 0;
+}
+
+static int dtt200u_fe_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u8 bw[1] = { 0x8c };
+	*unc = 0;
+	dibusb_readwrite_usb(state->dib,bw,1,(u8*) unc, 3);
+	return 0;
+}
+
+static int dtt200u_fe_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u8 bw[1] = { 0x8a };
+	u8 b;
+	dibusb_readwrite_usb(state->dib,bw,1,&b, 1);
+	*strength = (b << 8) | b;
+	return 0;
+}
+
+static int dtt200u_fe_read_snr(struct dvb_frontend* fe, u16 *snr)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u8 bw[1] = { 0x89 };
+	u8 br[1] = { 0 };
+	dibusb_readwrite_usb(state->dib,bw,1,br,1);
+	*snr = ((0xff - br[0]) << 8) | (0xff - br[0]);
+	return 0;
+}
+
+static int dtt200u_fe_init(struct dvb_frontend* fe)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u8 b[] = { 0x01 };
+	return dibusb_write_usb(state->dib,b,1);
+}
+
+static int dtt200u_fe_sleep(struct dvb_frontend* fe)
+{
+	return dtt200u_fe_init(fe);
+}
+
+static int dtt200u_fe_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
+{
+	tune->min_delay_ms = 1500;
+	tune->step_size = 166667;
+	tune->max_drift = 166667 * 2;
+	return 0;
+}
+
+static int dtt200u_fe_set_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	u16 freq = fep->frequency / 250000;
+	u8 bw,bwbuf[2] = { 0x03, 0 }, freqbuf[3] = { 0x02, 0, 0 };
+
+	switch (fep->u.ofdm.bandwidth) {
+		case BANDWIDTH_8_MHZ: bw = 8; break;
+		case BANDWIDTH_7_MHZ: bw = 7; break;
+		case BANDWIDTH_6_MHZ: bw = 6; break;
+		case BANDWIDTH_AUTO: return -EOPNOTSUPP;
+		default:
+			return -EINVAL;
+	}
+	deb_info("set_frontend\n");
+
+	bwbuf[1] = bw;
+	dibusb_write_usb(state->dib,bwbuf,2);
+
+	freqbuf[1] = freq & 0xff;
+	freqbuf[2] = (freq >> 8) & 0xff;
+	dibusb_write_usb(state->dib,freqbuf,3);
+
+	memcpy(&state->fep,fep,sizeof(struct dvb_frontend_parameters));
+
+	return 0;
+}
+
+static int dtt200u_fe_get_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep)
+{
+	struct dtt200u_fe_state *state = fe->demodulator_priv;
+	memcpy(fep,&state->fep,sizeof(struct dvb_frontend_parameters));
+	return 0;
+}
+
+static void dtt200u_fe_release(struct dvb_frontend* fe)
+{
+	struct dtt200u_fe_state *state = (struct dtt200u_fe_state*) fe->demodulator_priv;
+	kfree(state);
+}
+
+static int dtt200u_pid_control(struct dvb_frontend *fe,int index, int pid,int onoff)
+{
+	struct dtt200u_fe_state *state = (struct dtt200u_fe_state*) fe->demodulator_priv;
+	pid = onoff ? pid : 0;
+	u8 b_pid[4] = { 0x04, index, pid & 0xff, (pid >> 8) & 0xff };
+
+	dibusb_write_usb(state->dib,b_pid,4);
+	return 0;
+}
+
+static int dtt200u_fifo_control(struct dvb_frontend *fe, int onoff)
+{
+	struct dtt200u_fe_state *state = (struct dtt200u_fe_state*) fe->demodulator_priv;
+	u8 b_streaming[2] = { 0x08, onoff };
+	u8 b_rst_pid[1] = { 0x05 };
+
+	dibusb_write_usb(state->dib,b_streaming,2);
+
+	if (!onoff)
+		dibusb_write_usb(state->dib,b_rst_pid,1);
+	return 0;
+}
+
+static struct dvb_frontend_ops dtt200u_fe_ops;
+
+struct dvb_frontend* dtt200u_fe_attach(struct usb_dibusb *dib, struct dib_fe_xfer_ops *xfer_ops)
+{
+	struct dtt200u_fe_state* state = NULL;
+
+	/* allocate memory for the internal state */
+	state = (struct dtt200u_fe_state*) kmalloc(sizeof(struct dtt200u_fe_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+	memset(state,0,sizeof(struct dtt200u_fe_state));
+
+	deb_info("attaching frontend dtt200u\n");
+
+	state->dib = dib;
+
+	state->frontend.ops = &dtt200u_fe_ops;
+	state->frontend.demodulator_priv = state;
+
+	xfer_ops->fifo_ctrl = dtt200u_fifo_control;
+	xfer_ops->pid_ctrl = dtt200u_pid_control;
+
+	goto success;
+error:
+	return NULL;
+success:
+	return &state->frontend;
+}
+
+static struct dvb_frontend_ops dtt200u_fe_ops = {
+	.info = {
+		.name			= "DTT200U (Yakumo/Typhoon/Hama) DVB-T",
+		.type			= FE_OFDM,
+		.frequency_min		= 44250000,
+		.frequency_max		= 867250000,
+		.frequency_stepsize	= 250000,
+		.caps = FE_CAN_INVERSION_AUTO |
+				FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+				FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+				FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+				FE_CAN_TRANSMISSION_MODE_AUTO |
+				FE_CAN_GUARD_INTERVAL_AUTO |
+				FE_CAN_RECOVER |
+				FE_CAN_HIERARCHY_AUTO,
+	},
+
+	.release = dtt200u_fe_release,
+
+	.init = dtt200u_fe_init,
+	.sleep = dtt200u_fe_sleep,
+
+	.set_frontend = dtt200u_fe_set_frontend,
+	.get_frontend = dtt200u_fe_get_frontend,
+	.get_tune_settings = dtt200u_fe_get_tune_settings,
+
+	.read_status = dtt200u_fe_read_status,
+	.read_ber = dtt200u_fe_read_ber,
+	.read_signal_strength = dtt200u_fe_read_signal_strength,
+	.read_snr = dtt200u_fe_read_snr,
+	.read_ucblocks = dtt200u_fe_read_unc_blocks,
+};
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:27:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mb.c	2005-03-22 00:28:15.000000000 +0100
@@ -712,6 +712,7 @@ struct dvb_frontend* dib3000mb_attach(co
 	state = (struct dib3000_state*) kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
+	memset(state,0,sizeof(struct dib3000_state));
 
 	/* setup the state */
 	state->i2c = i2c;
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:27:13.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/frontends/dib3000mc.c	2005-03-22 00:28:15.000000000 +0100
@@ -847,6 +847,7 @@ struct dvb_frontend* dib3000mc_attach(co
 	state = (struct dib3000_state*) kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
+	memset(state,0,sizeof(struct dib3000_state));
 
 	/* setup the state */
 	state->i2c = i2c;

--

