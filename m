Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbULJPta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbULJPta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULJPta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:49:30 -0500
Received: from mail.convergence.de ([212.227.36.84]:42142 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261736AbULJPic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:38:32 -0500
Message-ID: <41B9C2C7.4070508@linuxtv.org>
Date: Fri, 10 Dec 2004 16:37:43 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][3/6] update dib-usb driver
Content-Type: multipart/mixed;
 boundary="------------010609050008070908000501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609050008070908000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010609050008070908000501
Content-Type: text/plain;
 name="03-dvb-dibusb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-dvb-dibusb.diff"

- [DVB] added new usb ids for some more clones
- [DVB] added option to deliver the complete TS with USB2.0 devices
- [DVB] added support for the dib3000mc/p frontend driver

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/dibusb/Kconfig linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dibusb/Kconfig
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/dibusb/Kconfig	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dibusb/Kconfig	2004-12-08 14:45:05.000000000 +0100
@@ -3,6 +3,7 @@
 	depends on DVB_CORE && USB
 	select FW_LOADER
 	select DVB_DIB3000MB
+	select DVB_DIB3000MC
 	help
 	  Support for USB 1.1 and 2.0 DVB-T devices based on reference designs made by
 	  DiBcom (http://www.dibcom.fr).
@@ -32,19 +33,25 @@
 	  Say Y if you own such a device and want to use it. You should build it as
 	  a module.
 
-config DVB_DIBUSB_MISDESIGNED_AN2235
-	bool "Enable support for some Artec T1 device, which identifies as AN2235"
+config DVB_DIBUSB_MISDESIGNED_DEVICES
+	bool "Enable support for some misdesigned (see help) devices, which identify with wrong IDs"
 	depends on DVB_DIBUSB
 	help
-	  Somehow Artec forgot to program the eeprom for some of their T1 devices. So
-	  comes that they identify with the default Vendor and Product ID of the Cypress
-	  CY7C64613 (AN2235).
+	  Somehow Artec/Ultima Electronic forgot to program the eeprom of some of their 
+	  USB1.1/USB2.0 devices.
+	  So comes that they identify with the default Vendor and Product ID of the Cypress
+	  CY7C64613 (AN2235) or Cypress FX2.
+
+	  Affected device IDs:
+	    0x0574:0x2235 (Artec T1 USB1.1, cold)
+	    0x04b4:0x8613 (Artec T1 USB2.0, cold)
+	    0x0574:0x1002 (Artec T1 USB2.0, warm)
 
-	  Say Y if your Artec device has 0x0574 as Vendor ID and 0x2235 as Product ID.
+	  Say Y if your device one of the mentioned IDs.
 
 config DVB_DIBCOM_DEBUG
 	bool "Enable extended debug support for DiBcom USB device"
 	depends on DVB_DIBUSB
 	help
 	  Say Y if you want to enable debuging. See modinfo dvb-dibusb for
-	  debug level.
+	  debug levels.
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/dibusb/dvb-dibusb.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dibusb/dvb-dibusb.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-11-30 15:26:46.000000000 +0100
@@ -7,10 +7,8 @@
  * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  * based on GPL code from DiBcom, which has
- *
  * Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
  *
- *
  * Remote control code added by David Matthews (dm@prolingua.co.uk)
  *
  *	This program is free software; you can redistribute it and/or
@@ -70,6 +68,9 @@
 #define deb_err(args...)   dprintk(0x10,args)
 #define deb_rc(args...)   dprintk(0x20,args)
 
+static int pid_parse;
+module_param(pid_parse, int, 0x644);
+MODULE_PARM_DESC(pid_parse, "enable pid parsing (filtering) when running at USB2.0");
 
 /* Version information */
 #define DRIVER_VERSION "0.1"
@@ -91,7 +92,7 @@
 		wbuf[0] == DIBUSB_REQ_I2C_WRITE &&
 		dib->dibdev->parm->type == DIBUSB1_1)
 		deb_err("BUG: writing to i2c, while TS-streaming destroys the stream."
-				"(%x reg: %x %x)", wbuf[0],wbuf[2],wbuf[3]);
+				"(%x reg: %x %x)\n", wbuf[0],wbuf[2],wbuf[3]);
 			
 	debug_dump(wbuf,wlen);
 
@@ -190,6 +191,7 @@
 
 	dib->feedcount += onoff ? 1 : -1;
 
+	if (dib->pid_parse) {
 	if (dib->xfer_ops.pid_ctrl != NULL) {
 		if (dib->xfer_ops.pid_ctrl(dib->fe,pid,onoff) < 0) {
 		err("no free pid in list.");
@@ -199,11 +201,20 @@
 		err("no pid ctrl callback.");
 		return -ENODEV;
 	}
+	}
 	/*
 	 * start the feed, either if there is the firmware bug or
 	 * if this was the first pid to set.
 	 */
 	if (dib->dibdev->parm->firmware_bug || dib->feedcount == onoff) {
+
+		deb_ts("controlling pid parser\n");
+		if (dib->xfer_ops.pid_parse != NULL) {
+			if (dib->xfer_ops.pid_parse(dib->fe,dib->pid_parse) < 0) {
+				err("could not handle pid_parser");
+			}
+		}
+		
 		deb_ts("start feeding\n");
 		if (dib->xfer_ops.fifo_ctrl != NULL) {
 			if (dib->xfer_ops.fifo_ctrl(dib->fe,1)) {
@@ -269,6 +282,13 @@
 	{ 0x00, 0xff, 0x4c, KEY_PAUSE },
 	{ 0x00, 0xff, 0x4d, KEY_SCREEN }, /* Full screen mode. */
 	{ 0x00, 0xff, 0x54, KEY_AUDIO }, /* MTS - Switch to secondary audio. */
+	/* additional keys TwinHan VisionPlus, the Artec seemingly not have */
+	{ 0x00, 0xff, 0x0c, KEY_CANCEL }, /* Cancel */
+	{ 0x00, 0xff, 0x1c, KEY_EPG }, /* EPG */
+	{ 0x00, 0xff, 0x00, KEY_TAB }, /* Tab */
+	{ 0x00, 0xff, 0x48, KEY_INFO }, /* Preview */
+	{ 0x00, 0xff, 0x04, KEY_LIST }, /* RecordList */
+	{ 0x00, 0xff, 0x0f, KEY_TEXT }, /* Teletext */
 	/* Key codes for the KWorld/ADSTech/JetWay remote. */
 	{ 0x86, 0x6b, 0x12, KEY_POWER },
 	{ 0x86, 0x6b, 0x0f, KEY_SELECT }, /* source */
@@ -374,17 +393,11 @@
  */
 
 #if 0
-
 /*
- * #if 0'ing the following 5 functions as they are not in use _now_,
+ * #if 0'ing the following functions as they are not in use _now_, 
  * but probably will be sometime.
  */
 
-static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
-{
-	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
-}
-
 /*
  * do not use this, just a workaround for a bug,
  * which will hopefully never occur :).
@@ -396,6 +409,21 @@
 }
 
 /*
+ * ioctl for power control
+ */
+static int dibusb_hw_sleep(struct usb_dibusb *dib)
+{
+	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
+	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+}
+
+#endif 
+static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
+{
+	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
+}
+
+/*
  * ioctl for the firmware
  */
 static int dibusb_ioctl_cmd(struct usb_dibusb *dib, u8 cmd, u8 *param, int plen)
@@ -409,23 +437,12 @@
 	return dibusb_write_usb(dib,b,2+size);
 }
 
-/*
- * ioctl for power control
- */
-static int dibusb_hw_sleep(struct usb_dibusb *dib)
-{
-	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
-	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
-}
-
 static int dibusb_hw_wakeup(struct usb_dibusb *dib)
 {
 	u8 b[1] = { DIBUSB_IOCTL_POWER_WAKEUP };
 	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
 }
 
-#endif
-
 /*
  * I2C
  */
@@ -458,7 +475,8 @@
 	return I2C_FUNC_I2C;
 }
 
-static int thomson_cable_eu_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
+static int thomson_cable_eu_pll_set(struct dvb_frontend* fe, struct
+		dvb_frontend_parameters* params);
 
 static struct dib3000_config thomson_cable_eu_config = {
 	.demod_address = 0x10,
@@ -466,7 +484,8 @@
 	.pll_set = thomson_cable_eu_pll_set,
 };
 
-static int thomson_cable_eu_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+static int thomson_cable_eu_pll_set(struct dvb_frontend* fe, struct
+		dvb_frontend_parameters* params)
 {
 	struct usb_dibusb* dib = (struct usb_dibusb*) fe->dvb->priv;
 	u8 buf[4];
@@ -493,7 +512,71 @@
    	buf[2] = 0x8e;
    	buf[3] = (vu << 7) | (p2 << 2) | (p1 << 1) | p0;
 
-	if (i2c_transfer (&dib->i2c_adap, &msg, 1) != 1) return -EIO;
+	if (i2c_transfer (&dib->i2c_adap, &msg, 1) != 1)
+		return -EIO;
+
+	msleep(1);
+	return 0;
+}
+
+static int panasonic_cofdm_env57h1xd5_pll_set(struct dvb_frontend *fe, struct
+		dvb_frontend_parameters *params);
+
+static struct dib3000_config panasonic_cofdm_env57h1xd5 = {
+	.demod_address = 0x18,
+	.pll_addr = 192,
+	.pll_set = panasonic_cofdm_env57h1xd5_pll_set,
+};
+
+static int panasonic_cofdm_env57h1xd5_pll_set(struct dvb_frontend *fe, struct
+		dvb_frontend_parameters *params)
+{
+	struct usb_dibusb* dib = (struct usb_dibusb*) fe->dvb->priv;
+	u8 buf[4];
+	u32 freq = params->frequency;
+	u32 tfreq = (freq + 36125000) / 1000000 * 6 + 1;
+	u8 TA, T210, R210, ctrl1, cp210, p4321;
+	struct i2c_msg msg = { 
+		.addr = panasonic_cofdm_env57h1xd5.pll_addr, 
+		.flags = 0, 
+		.buf = buf, 
+		.len = sizeof(buf) 
+	};
+
+	if (freq > 858000000) {
+		err("frequency cannot be larger than 858 MHz.");
+		return -EINVAL;
+	}
+	
+	// contol data 1 : 1 | T/A=1 | T2,T1,T0 = 0,0,0 | R2,R1,R0 = 0,1,0
+	TA = 1;
+	T210 = 0;
+	R210 = 0x2;
+	ctrl1 = (1 << 7) | (TA << 6) | (T210 << 3) | R210;
+
+// ********    CHARGE PUMP CONFIG vs RF FREQUENCIES     *****************
+	if (freq < 470000000) 
+		cp210 = 2;  // VHF Low and High band ch E12 to E4 to E12
+	else if (freq < 526000000) 
+		cp210 = 4;  // UHF band Ch E21 to E27
+	else // if (freq < 862000000) 
+		cp210 = 5;  // UHF band ch E28 to E69
+
+//*********************    BW select  *******************************
+	if (freq < 153000000) 
+		p4321  = 1; // BW selected for VHF low
+	else if (freq < 470000000) 
+		p4321  = 2; // BW selected for VHF high E5 to E12
+	else // if (freq < 862000000) 
+		p4321  = 4; // BW selection for UHF E21 to E69
+
+	buf[0] = (tfreq >> 8) & 0xff;
+	buf[1] = (tfreq >> 0) & 0xff;
+	buf[2] = 0xff & ctrl1;
+	buf[3] =  (cp210 << 5) | (p4321);
+
+	if (i2c_transfer (&dib->i2c_adap, &msg, 1) != 1)
+		return -EIO;
 
 	msleep(1);
 	return 0;
@@ -508,7 +591,15 @@
 
 static void frontend_init(struct usb_dibusb* dib)
 {
+	switch (dib->dibdev->parm->type) {
+		case DIBUSB1_1:
+		case DIBUSB1_1_AN2235:
 	dib->fe = dib3000mb_attach(&thomson_cable_eu_config, &dib->i2c_adap,&dib->xfer_ops);
+			break;
+		case DIBUSB2_0:
+			dib->fe = dib3000mc_attach(&panasonic_cofdm_env57h1xd5,&dib->i2c_adap, &dib->xfer_ops);
+			break;
+	}
 
 	if (dib->fe == NULL) {
 		printk("dvb-dibusb: A frontend driver was not found for device %04x/%04x\n",
@@ -671,9 +762,11 @@
 	deb_info("allocate %d bytes as buffersize for all URBs\n",bufsize);
 	/* allocate the actual buffer for the URBs */
 	if ((dib->buffer = pci_alloc_consistent(NULL,bufsize,&dib->dma_handle)) == NULL) {
+		deb_info("not enough memory.\n");
 		dibusb_exit(dib);
 		return -ENOMEM;
 	}
+	deb_info("allocation complete\n");
 	memset(dib->buffer,0,bufsize);
 
 	/* allocate and submit the URBs */
@@ -721,6 +814,8 @@
 
 	INIT_WORK(&dib->rc_query_work, dibusb_query_rc, dib);
 
+	dibusb_hw_wakeup(dib);
+	
 	if ((ret = dibusb_dvb_init(dib))) {
 		dibusb_exit(dib);
 		return ret;
@@ -844,27 +939,33 @@
 	if (cold)
 		ret = dibusb_loadfirmware(udev,dibdev);
 	else {
+		dib = kmalloc(sizeof(struct usb_dibusb),GFP_KERNEL);
+		if (dib == NULL) {
+			err("no memory");
+			return ret;
+		}
+		memset(dib,0,sizeof(struct usb_dibusb));
+		
+		dib->pid_parse = 1;
 		switch (udev->speed) {
 			case USB_SPEED_LOW:
 				err("cannot handle USB speed because it is to sLOW.");
 				break;
 			case USB_SPEED_FULL:
-				info("running at FULL speed, will use pid filter.");
+				info("running at FULL speed, will use pid parsing.");
 				break;
 			case USB_SPEED_HIGH:
+				if (!pid_parse) {
+					dib->pid_parse = 0;
 				info("running at HIGH speed, will deliver the complete TS.");
+				} else
+					info("running at HIGH speed, will use pid_parsing anyway.");
 				break;
 			case USB_SPEED_UNKNOWN: /* fall through */
 			default:
 				err("cannot handle USB speed because it is unkown.");
 				break;
 		}
-		dib = kmalloc(sizeof(struct usb_dibusb),GFP_KERNEL);
-		if (dib == NULL) {
-			err("no memory");
-			return ret;
-		}
-		memset(dib,0,sizeof(struct usb_dibusb));
 
 		dib->udev = udev;
 		dib->dibdev = dibdev;
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/dibusb/dvb-dibusb.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dibusb/dvb-dibusb.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/dibusb/dvb-dibusb.h	2004-12-08 14:31:32.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/dibusb/dvb-dibusb.h	2004-12-08 14:45:05.000000000 +0100
@@ -67,7 +67,7 @@
 		.data_pipe = 0x82,
 	},
 	{	.type = DIBUSB2_0,
-		.demod_addr = 0x10,
+		.demod_addr = 0x18,
 		.fw_filenames = dibusb_fw_filenames2_0,
 		.usb_controller = "Cypress FX2",
 		.usb_cpu_csreg = 0xe600,
@@ -109,6 +109,8 @@
 #define USB_VID_ANCHOR						0x0547
 #define USB_VID_AVERMEDIA					0x14aa
 #define USB_VID_COMPRO						0x185b
+#define USB_VID_COMPRO_UNK					0x145f
+#define USB_VID_CYPRESS						0x04b4
 #define USB_VID_DIBCOM						0x10b8
 #define USB_VID_EMPIA						0xeb1a
 #define USB_VID_GRANDTEC					0x5032
@@ -122,6 +124,8 @@
 #define USB_PID_AVERMEDIA_DVBT_USB_WARM		0x0002
 #define USB_PID_COMPRO_DVBU2000_COLD		0xd000
 #define USB_PID_COMPRO_DVBU2000_WARM		0xd001
+#define USB_PID_COMPRO_DVBU2000_UNK_COLD	0x010c
+#define USB_PID_COMPRO_DVBU2000_UNK_WARM	0x010d
 #define USB_PID_DIBCOM_MOD3000_COLD			0x0bb8
 #define USB_PID_DIBCOM_MOD3000_WARM			0x0bb9
 #define USB_PID_DIBCOM_MOD3001_COLD			0x0bc6
@@ -137,12 +141,15 @@
 #define USB_PID_ULTIMA_TVBOX_AN2235_COLD	0x8107
 #define USB_PID_ULTIMA_TVBOX_AN2235_WARM	0x8108
 #define USB_PID_ULTIMA_TVBOX_ANCHOR_COLD	0x2235
+#define USB_PID_ULTIMA_TVBOX_USB2_COLD		0x8109
+#define USB_PID_ULTIMA_TVBOX_USB2_FX_COLD	0x8613
+#define USB_PID_ULTIMA_TVBOX_USB2_FX_WARM	0x1002
 #define USB_PID_UNK_HYPER_PALTEK_COLD		0x005e
 #define USB_PID_UNK_HYPER_PALTEK_WARM		0x005f
 #define USB_PID_YAKUMO_DTT200U_COLD			0x0201
 #define USB_PID_YAKUMO_DTT200U_WARM			0x0301
 
-#define DIBUSB_SUPPORTED_DEVICES	12
+#define DIBUSB_SUPPORTED_DEVICES	15
 
 /* USB Driver stuff */
 static struct dibusb_device dibusb_devices[DIBUSB_SUPPORTED_DEVICES] = {
@@ -176,11 +183,26 @@
 		.warm_product_id = 0, /* undefined, this design becomes USB_PID_DIBCOM_MOD3000_WARM in warm state */
 		.parm = &dibusb_dev_parm[2],
 	},
+	{	.name = "Artec T1 USB2.0 TVBOX (please report the warm ID)",
+		.cold_product_id = USB_PID_ULTIMA_TVBOX_USB2_COLD,
+		.warm_product_id = 0, /* don't know, it is most likely that the device will get another USB ID in warm state */
+		.parm = &dibusb_dev_parm[1],
+	},
+	{	.name = "Artec T1 USB2.0 TVBOX with FX2 IDs (misdesigned, please report the warm ID)",
+		.cold_product_id = USB_PID_ULTIMA_TVBOX_USB2_FX_COLD,
+		.warm_product_id = USB_PID_ULTIMA_TVBOX_USB2_FX_WARM, /* undefined, it could be that the device will get another USB ID in warm state */
+		.parm = &dibusb_dev_parm[1],
+	},
 	{	.name = "Compro Videomate DVB-U2000 - DVB-T USB1.1",
 		.cold_product_id = USB_PID_COMPRO_DVBU2000_COLD,
 		.warm_product_id = USB_PID_COMPRO_DVBU2000_WARM,
 		.parm = &dibusb_dev_parm[0],
 	},
+	{	.name = "Compro Videomate DVB-U2000 - DVB-T USB1.1 (really ?? please report the name!)",
+		.cold_product_id = USB_PID_COMPRO_DVBU2000_UNK_COLD,
+		.warm_product_id = USB_PID_COMPRO_DVBU2000_UNK_WARM,
+		.parm = &dibusb_dev_parm[0],
+	},
 	{	.name = "Unkown USB1.1 DVB-T device ???? please report the name to the author",
 		.cold_product_id = USB_PID_UNK_HYPER_PALTEK_COLD,
 		.warm_product_id = USB_PID_UNK_HYPER_PALTEK_WARM,
@@ -237,14 +259,18 @@
 	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
 	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_COLD) },
 	{ USB_DEVICE(USB_VID_AVERMEDIA,		USB_PID_YAKUMO_DTT200U_WARM) },
+	{ USB_DEVICE(USB_PID_COMPRO_DVBU2000_UNK_COLD, USB_VID_COMPRO_UNK) },
+	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_COLD) },
 
 /*
- * activate the following define when you have the device and want to compile
- * build from build-2.6 in dvb-kernel
+ * activate the following define when you have one of the devices and want to 
+ * build it from build-2.6 in dvb-kernel
  */
-// #define CONFIG_DVB_DIBUSB_MISDESIGNED_AN2235
-#ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_AN2235
+// #define CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES 
+#ifdef CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES
 	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+	{ USB_DEVICE(USB_VID_CYPRESS,		USB_PID_ULTIMA_TVBOX_USB2_FX_COLD) },
+	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_USB2_FX_WARM) },
 #endif
 	{ }                 /* Terminating entry */
 };
@@ -260,6 +286,7 @@
 	struct dibusb_device * dibdev;
 
 	int feedcount;
+	int pid_parse;
 	struct dib3000_xfer_ops xfer_ops;
 
 	struct urb **urb_list;
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/Kconfig linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/Kconfig
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/Kconfig	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/Kconfig	2004-11-30 15:26:47.000000000 +0100
@@ -111,6 +111,13 @@
 	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
 	  to support this frontend.
 
+config DVB_DIB3000MC
+	tristate "DiBcom 3000-MC/P" 
+	depends on DVB_CORE
+	help
+	  A DVB-T tuner module. Designed for mobile usage. Say Y when you want
+	  to support this frontend.
+
 comment "DVB-C (cable) frontends"
 	depends on DVB_CORE
 
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/Makefile linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/Makefile
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/Makefile	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/Makefile	2004-11-30 15:26:47.000000000 +0100
@@ -11,7 +11,8 @@
 obj-$(CONFIG_DVB_CX24110) += cx24110.o
 obj-$(CONFIG_DVB_TDA8083) += tda8083.o
 obj-$(CONFIG_DVB_L64781) += l64781.o
-obj-$(CONFIG_DVB_DIB3000MB) += dib3000mb.o
+obj-$(CONFIG_DVB_DIB3000MB) += dib3000mb.o dib3000-common.o
+obj-$(CONFIG_DVB_DIB3000MC) += dib3000mc.o dib3000-common.o
 obj-$(CONFIG_DVB_MT312) += mt312.o
 obj-$(CONFIG_DVB_VES1820) += ves1820.o
 obj-$(CONFIG_DVB_VES1X93) += ves1x93.o
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000-common.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000-common.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000-common.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000-common.c	2004-12-08 14:45:05.000000000 +0100
@@ -0,0 +1,145 @@
+#include "dib3000-common.h"
+
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+static int debug;
+module_param(debug, int, 0x644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=i2c,4=srch (|-able)).");
+#endif
+#define deb_info(args...) dprintk(0x01,args)
+#define deb_i2c(args...) dprintk(0x02,args)
+#define deb_srch(args...) dprintk(0x04,args)
+
+
+int dib3000_read_reg(struct dib3000_state *state, u16 reg)
+{
+	u8 wb[] = { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };
+	u8 rb[2];
+	struct i2c_msg msg[] = {
+		{ .addr = state->config.demod_address, .flags = 0,        .buf = wb, .len = 2 },
+		{ .addr = state->config.demod_address, .flags = I2C_M_RD, .buf = rb, .len = 2 },
+	};
+	
+	if (i2c_transfer(state->i2c, msg, 2) != 2)
+		deb_i2c("i2c read error\n");
+	
+	deb_i2c("reading i2c bus (reg: %5d 0x%04x, val: %5d 0x%04x)\n",reg,reg,
+			(rb[0] << 8) | rb[1],(rb[0] << 8) | rb[1]);
+
+	return (rb[0] << 8) | rb[1];
+}
+
+int dib3000_write_reg(struct dib3000_state *state, u16 reg, u16 val)
+{
+	u8 b[] = {
+		(reg >> 8) & 0xff, reg & 0xff,
+		(val >> 8) & 0xff, val & 0xff,
+	};
+	struct i2c_msg msg[] = { 
+		{ .addr = state->config.demod_address, .flags = 0, .buf = b, .len = 4 } 
+	};
+	deb_i2c("writing i2c bus (reg: %5d 0x%04x, val: %5d 0x%04x)\n",reg,reg,val,val);
+
+	return i2c_transfer(state->i2c,msg, 1) != 1 ? -EREMOTEIO : 0;
+}
+
+int dib3000_init_pid_list(struct dib3000_state *state, int num)
+{
+	int i;
+	if (state != NULL) {
+		state->pid_list = kmalloc(sizeof(struct dib3000_pid) * num,GFP_KERNEL);
+		if (state->pid_list == NULL)
+			return -ENOMEM;
+
+		deb_info("initializing %d pids for the pid_list.\n",num);
+		state->pid_list_lock = SPIN_LOCK_UNLOCKED;
+		memset(state->pid_list,0,num*(sizeof(struct dib3000_pid)));
+		for (i=0; i < num; i++) {
+			state->pid_list[i].pid = 0;
+			state->pid_list[i].active = 0;
+		}
+		state->feedcount = 0;
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+void dib3000_dealloc_pid_list(struct dib3000_state *state)
+{
+	if (state != NULL && state->pid_list != NULL)
+		kfree(state->pid_list);
+}
+
+/* fetch a pid from pid_list */
+int dib3000_get_pid_index(struct dib3000_pid pid_list[], int num_pids, int pid,
+		spinlock_t *pid_list_lock,int onoff)
+{
+	int i,ret = -1;
+	unsigned long flags;
+
+	spin_lock_irqsave(pid_list_lock,flags);
+	for (i=0; i < num_pids; i++)
+		if (onoff) {
+			if (!pid_list[i].active) {
+				pid_list[i].pid = pid;
+				pid_list[i].active = 1;
+				ret = i;
+				break;
+			}
+		} else {
+			if (pid_list[i].active && pid_list[i].pid == pid) {
+				pid_list[i].pid = 0;
+				pid_list[i].active = 0;
+				ret = i;
+				break;
+			}
+		}
+	
+	deb_info("setting pid: %5d %04x at index %d '%s'\n",pid,pid,ret,onoff ? "on" : "off");
+				
+	spin_unlock_irqrestore(pid_list_lock,flags);
+	return ret;
+}
+
+int dib3000_search_status(u16 irq,u16 lock)
+{
+	if (irq & 0x02) {
+		if (lock & 0x01) {
+			deb_srch("auto search succeeded\n");
+			return 1; // auto search succeeded
+		} else {
+			deb_srch("auto search not successful\n");
+			return 0; // auto search failed
+		}
+	} else if (irq & 0x01)  {
+		deb_srch("auto search failed\n");
+		return 0; // auto search failed
+	}
+	return -1; // try again 
+}
+
+/* for auto search */
+u16 dib3000_seq[2][2][2] =     /* fft,gua,   inv   */
+	{ /* fft */
+		{ /* gua */
+			{ 0, 1 },                   /*  0   0   { 0,1 } */
+			{ 3, 9 },                   /*  0   1   { 0,1 } */
+		},
+		{
+			{ 2, 5 },                   /*  1   0   { 0,1 } */
+			{ 6, 11 },                  /*  1   1   { 0,1 } */
+		}
+	};
+
+MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@desy.de");
+MODULE_DESCRIPTION("Common functions for the dib3000mb/dib3000mc dvb frontend drivers");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(dib3000_seq);
+
+EXPORT_SYMBOL(dib3000_read_reg);
+EXPORT_SYMBOL(dib3000_write_reg);
+EXPORT_SYMBOL(dib3000_init_pid_list);
+EXPORT_SYMBOL(dib3000_dealloc_pid_list);
+EXPORT_SYMBOL(dib3000_get_pid_index);
+EXPORT_SYMBOL(dib3000_search_status);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000-common.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000-common.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000-common.h	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000-common.h	2004-12-08 14:45:06.000000000 +0100
@@ -26,6 +25,8 @@
 #ifndef DIB3000_COMMON_H
 #define DIB3000_COMMON_H
 
+#include "dvb_frontend.h"
+#include "dib3000.h"
 
 /* info and err, taken from usb.h, if there is anything available like by default,
  * please change !
@@ -41,6 +42,63 @@
 	int active;
 };
 
+/* frontend state */
+struct dib3000_state {
+	struct i2c_adapter* i2c;
+
+	struct dvb_frontend_ops ops;
+
+/* configuration settings */
+	struct dib3000_config config;
+
+	spinlock_t pid_list_lock;
+	struct dib3000_pid *pid_list;
+
+	int feedcount;
+
+	struct dvb_frontend frontend;
+	int timing_offset;
+	int timing_offset_comp_done;
+};
+
+/* commonly used methods by the dib3000mb/mc/p frontend */
+extern int dib3000_read_reg(struct dib3000_state *state, u16 reg);
+extern int dib3000_write_reg(struct dib3000_state *state, u16 reg, u16 val);
+
+extern int dib3000_init_pid_list(struct dib3000_state *state, int num);
+extern void dib3000_dealloc_pid_list(struct dib3000_state *state);
+extern int dib3000_get_pid_index(struct dib3000_pid pid_list[], int num_pids,
+	int pid, spinlock_t *pid_list_lock,int onoff);
+
+extern int dib3000_search_status(u16 irq,u16 lock);
+
+/* handy shortcuts */
+#define rd(reg) dib3000_read_reg(state,reg)
+
+#define wr(reg,val) if (dib3000_write_reg(state,reg,val)) \
+	{ err("while sending 0x%04x to 0x%04x.",val,reg); return -EREMOTEIO; }
+
+#define wr_foreach(a,v) { int i; \
+	if (sizeof(a) != sizeof(v)) \
+		err("sizeof: %d %d is different",sizeof(a),sizeof(v));\
+	for (i=0; i < sizeof(a)/sizeof(u16); i++) \
+		wr(a[i],v[i]); \
+	}
+
+#define set_or(reg,val) wr(reg,rd(reg) | val)
+
+#define set_and(reg,val) wr(reg,rd(reg) & val)
+
+
+/* debug */
+
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+#define dprintk(level,args...) \
+    do { if ((debug & level)) { printk(args); } } while (0)
+#else
+#define dprintk(args...) do { } while (0)
+#endif
+
 /* mask for enabling a specific pid for the pid_filter */
 #define DIB3000_ACTIVATE_PID_FILTERING	(0x2000)
 
@@ -81,17 +139,7 @@
 #define DIB3000_TUNER_WRITE_DISABLE(a)	(0xffff & ((a << 7) | (1 << 7)))
 
 /* for auto search */
-static u16 dib3000_seq[2][2][2] =     /* fft,gua,   inv   */
-	{ /* fft */
-		{ /* gua */
-			{ 0, 1 },                   /*  0   0   { 0,1 } */
-			{ 3, 9 },                   /*  0   1   { 0,1 } */
-		},
-		{
-			{ 2, 5 },                   /*  1   0   { 0,1 } */
-			{ 6, 11 },                  /*  1   1   { 0,1 } */
-		}
-	};
+extern u16 dib3000_seq[2][2][2];
 
 #define DIB3000_REG_MANUFACTOR_ID		(  1025)
 #define DIB3000_I2C_ID_DIBCOM			(0x01b3)
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000.h	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000.h	2004-11-23 21:16:39.000000000 +0100
@@ -42,7 +42,7 @@
 struct dib3000_xfer_ops
 {
 	/* pid and transfer handling is done in the demodulator */
-	int (*pid_filter)(struct dvb_frontend *fe, int onoff);
+	int (*pid_parse)(struct dvb_frontend *fe, int onoff);
 	int (*fifo_ctrl)(struct dvb_frontend *fe, int onoff);
 	int (*pid_ctrl)(struct dvb_frontend *fe, int pid, int onoff);
 };
@@ -50,4 +50,6 @@
 extern struct dvb_frontend* dib3000mb_attach(const struct dib3000_config* config,
 					     struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops);
 
+extern struct dvb_frontend* dib3000mc_attach(const struct dib3000_config* config,
+					     struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops);
 #endif // DIB3000_H
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000mb.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000mb.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000mb.c	2004-12-08 14:31:33.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000mb.c	2004-12-08 14:45:06.000000000 +0100
@@ -34,135 +33,38 @@
 #include "dib3000mb_priv.h"
 #include "dib3000.h"
 
-struct dib3000mb_state {
-
-	struct i2c_adapter* i2c;
-
-	struct dvb_frontend_ops ops;
-
-	/* configuration settings */
-	const struct dib3000_config* config;
-
-	spinlock_t pid_list_lock;
-	struct dib3000_pid pid_list[DIB3000MB_NUM_PIDS];
-	int feedcount;
-
-	struct dvb_frontend frontend;
-};
-
-
-/* debug */
+/* Version information */
+#define DRIVER_VERSION "0.1"
+#define DRIVER_DESC "DiBcom 3000-MB DVB-T demodulator driver"
+#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
-#define dprintk(level,args...) \
-	do { if ((debug & level)) { printk(args); } } while (0)
-
 static int debug;
 module_param(debug, int, 0x644);
-MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore,8=setfe,16=getfe (|-able)).");
-#else
-#define dprintk(args...) do { } while (0);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-able)).");
 #endif
-
 #define deb_info(args...) dprintk(0x01,args)
 #define deb_xfer(args...) dprintk(0x02,args)
-#define deb_alot(args...) dprintk(0x04,args)
-#define deb_setf(args...) dprintk(0x08,args)
-#define deb_getf(args...) dprintk(0x10,args)
-
-/* Version information */
-#define DRIVER_VERSION "0.1"
-#define DRIVER_DESC "DiBcom 3000-MB DVB-T demodulator driver"
-#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
-
-
-/* handy shortcuts */
-#define rd(reg) dib3000mb_read_reg(state,reg)
-#define wr(reg,val) if (dib3000mb_write_reg(state,reg,val)) \
-	{ err("while sending 0x%04x to 0x%04x.",val,reg); return -EREMOTEIO; }
-#define wr_foreach(a,v) { int i; \
-	deb_alot("sizeof: %d %d\n",sizeof(a),sizeof(v));\
-	for (i=0; i < sizeof(a)/sizeof(u16); i++) \
-		wr(a[i],v[i]); \
-}
-
-static int dib3000mb_read_reg(struct dib3000mb_state *state, u16 reg)
-{
-	u8 wb[] = { ((reg >> 8) | 0x80) & 0xff, reg & 0xff };
-	u8 rb[2];
-	struct i2c_msg msg[] = {
-		{ .addr = state->config->demod_address, .flags = 0,        .buf = wb, .len = 2 },
-		{ .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = rb, .len = 2 },
-	};
-	deb_alot("reading from i2c bus (reg: %d)\n",reg);
-
-	if (i2c_transfer(state->i2c, msg, 2) != 2)
-		deb_alot("i2c read error\n");
-
-	return (rb[0] << 8) | rb[1];
-}
-
-static int dib3000mb_write_reg(struct dib3000mb_state *state, u16 reg, u16 val)
-{
-	u8 b[] = {
-		(reg >> 8) & 0xff, reg & 0xff,
-		(val >> 8) & 0xff, val & 0xff,
-	};
-	struct i2c_msg msg[] = { { .addr = state->config->demod_address, .flags = 0, .buf = b, .len = 4 } };
-	deb_alot("writing to i2c bus (reg: %d, val: %d)\n",reg,val);
-
-	return i2c_transfer(state->i2c,msg, 1) != 1 ? -EREMOTEIO : 0;
-}
-
-static int dib3000mb_set_frontend(struct dvb_frontend* fe,
-		struct dvb_frontend_parameters *fep, int tuner);
+#define deb_setf(args...) dprintk(0x04,args)
+#define deb_getf(args...) dprintk(0x08,args)
 
 static int dib3000mb_get_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep);
 
-static int dib3000mb_fe_read_search_status(struct dvb_frontend* fe)
-{
-	u16 irq;
-	struct dvb_frontend_parameters fep;
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
-
-	irq = rd(DIB3000MB_REG_AS_IRQ_PENDING);
-
-	if (irq & 0x02) {
-		if (rd(DIB3000MB_REG_LOCK2_VALUE) & 0x01) {
-			if (dib3000mb_get_frontend(fe, &fep) == 0) {
-				deb_setf("reading tuning data from frontend succeeded.\n");
-				return dib3000mb_set_frontend(fe, &fep, 0) == 0;
-			} else {
-				deb_setf("reading tuning data failed -> tuning failed.\n");
-				return 0;
-			}
-		} else {
-			deb_setf("AS IRQ was pending, but LOCK2 was not & 0x01.\n");
-			return 0;
-		}
-	} else if (irq & 0x01) {
-		deb_setf("Autosearch failed.\n");
-		return 0;
-	}
-
-	return -1;
-}
-
 static int dib3000mb_set_frontend(struct dvb_frontend* fe,
 		struct dvb_frontend_parameters *fep, int tuner)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	fe_code_rate_t fe_cr = FEC_NONE;
 	int search_state,seq;
 
 	if (tuner) {
 		wr(DIB3000MB_REG_TUNER,
-				DIB3000_TUNER_WRITE_ENABLE(state->config->pll_addr));
-		state->config->pll_set(fe, fep);
+				DIB3000_TUNER_WRITE_ENABLE(state->config.pll_addr));
+		state->config.pll_set(fe, fep);
 		wr(DIB3000MB_REG_TUNER,
-				DIB3000_TUNER_WRITE_DISABLE(state->config->pll_addr));
+				DIB3000_TUNER_WRITE_DISABLE(state->config.pll_addr));
 
 		deb_setf("bandwidth: ");
 		switch (ofdm->bandwidth) {
@@ -389,10 +291,22 @@
 		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_AUTO_SEARCH);
 		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_OFF);
 
-		while ((search_state = dib3000mb_fe_read_search_status(fe)) < 0 && as_count++ < 100)
+		while ((search_state = 
+				dib3000_search_status(
+					rd(DIB3000MB_REG_AS_IRQ_PENDING),
+					rd(DIB3000MB_REG_LOCK2_VALUE))) < 0 && as_count++ < 100) 
 			msleep(1);
 
 		deb_info("search_state after autosearch %d after %d checks\n",search_state,as_count);
+
+		if (search_state == 1) {
+			struct dvb_frontend_parameters feps;
+			if (dib3000mb_get_frontend(fe, &feps) == 0) {
+				deb_setf("reading tuning data from frontend succeeded.\n");
+				return dib3000mb_set_frontend(fe, &feps, 0);
+			}
+		}
+
 	} else {
 		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_CTRL);
 		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_OFF);
@@ -403,7 +317,7 @@
 
 static int dib3000mb_fe_init(struct dvb_frontend* fe, int mobile_mode)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
 	wr(DIB3000MB_REG_POWER_CONTROL,DIB3000MB_POWER_UP);
 
@@ -474,12 +388,12 @@
 
 	wr(DIB3000MB_REG_DATA_IN_DIVERSITY,DIB3000MB_DATA_DIVERSITY_IN_OFF);
 
-	if (state->config->pll_init) {
+	if (state->config.pll_init) {
 		wr(DIB3000MB_REG_TUNER,
-			DIB3000_TUNER_WRITE_ENABLE(state->config->pll_addr));
-		state->config->pll_init(fe);
+			DIB3000_TUNER_WRITE_ENABLE(state->config.pll_addr));
+		state->config.pll_init(fe);
 		wr(DIB3000MB_REG_TUNER,
-			DIB3000_TUNER_WRITE_DISABLE(state->config->pll_addr));
+			DIB3000_TUNER_WRITE_DISABLE(state->config.pll_addr));
 	}
 
 	return 0;
@@ -488,7 +402,7 @@
 static int dib3000mb_get_frontend(struct dvb_frontend* fe,
 				  struct dvb_frontend_parameters *fep)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
 	fe_code_rate_t *cr;
 	u16 tps_val;
@@ -499,7 +413,7 @@
 		return 0;
 
 	dds_val = ((rd(DIB3000MB_REG_DDS_VALUE_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_VALUE_LSB);
-	if (dds_val & threshold)
+	if (dds_val < threshold)
 		inv_test1 = 0;
 	else if (dds_val == threshold)
 		inv_test1 = 1;
@@ -507,7 +421,7 @@
 		inv_test1 = 2;
 
 	dds_val = ((rd(DIB3000MB_REG_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_FREQ_LSB);
-	if (dds_val & threshold)
+	if (dds_val < threshold)
 		inv_test2 = 0;
 	else if (dds_val == threshold)
 		inv_test2 = 1;
@@ -516,7 +430,8 @@
 
 	fep->inversion =
 		((inv_test2 == 2) && (inv_test1==1 || inv_test1==0)) ||
-		((inv_test2 == 0) && (inv_test1==1 || inv_test1==2));
+		((inv_test2 == 0) && (inv_test1==1 || inv_test1==2)) ? 
+		INVERSION_ON : INVERSION_OFF;
 
 	deb_getf("inversion %d %d, %d\n", inv_test2, inv_test1, fep->inversion);
 
@@ -541,10 +456,8 @@
 
 	if (rd(DIB3000MB_REG_TPS_HRCH)) {
 		deb_getf("HRCH ON\n");
-		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_LP);
 		cr = &ofdm->code_rate_LP;
 		ofdm->code_rate_HP = FEC_NONE;
-
 		switch ((tps_val = rd(DIB3000MB_REG_TPS_VIT_ALPHA))) {
 			case DIB3000_ALPHA_0:
 				deb_getf("HIERARCHY_NONE ");
@@ -567,12 +480,15 @@
 				break;
 		}
 		deb_getf("TPS: %d\n", tps_val);
+		
+		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_LP);
 	} else {
 		deb_getf("HRCH OFF\n");
-		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_HP);
 		cr = &ofdm->code_rate_HP;
 		ofdm->code_rate_LP = FEC_NONE;
 		ofdm->hierarchy_information = HIERARCHY_NONE;
+
+		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_HP);
 	}
 
 	switch (tps_val) {
@@ -645,7 +561,7 @@
 
 static int dib3000mb_read_status(struct dvb_frontend* fe, fe_status_t *stat)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
 	*stat = 0;
 
@@ -684,7 +600,7 @@
 
 static int dib3000mb_read_ber(struct dvb_frontend* fe, u32 *ber)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
 	*ber = ((rd(DIB3000MB_REG_BER_MSB) << 16) | rd(DIB3000MB_REG_BER_LSB) );
 	return 0;
@@ -701,7 +617,7 @@
 #define DIB3000MB_GAIN_DELTA_dBm	-2
 static int dib3000mb_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
 /* TODO log10 
 	u16 sigpow = rd(DIB3000MB_REG_SIGNAL_POWER), 
@@ -737,7 +653,7 @@
  */
 static int dib3000mb_read_snr(struct dvb_frontend* fe, u16 *snr)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 	short sigpow = rd(DIB3000MB_REG_SIGNAL_POWER);
 	int icipow = ((rd(DIB3000MB_REG_NOISE_POWER_MSB) & 0xff) << 16) |
 		rd(DIB3000MB_REG_NOISE_POWER_LSB);
@@ -757,7 +673,7 @@
 
 static int dib3000mb_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
 	*unc = rd(DIB3000MB_REG_UNC);
 	return 0;
@@ -765,7 +681,7 @@
 
 static int dib3000mb_sleep(struct dvb_frontend* fe)
 {
-	struct dib3000mb_state* state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
 
 	wr(DIB3000MB_REG_POWER_CONTROL,DIB3000MB_POWER_DOWN);
 	return 0;
@@ -792,49 +708,17 @@
 
 static void dib3000mb_release(struct dvb_frontend* fe)
 {
-	struct dib3000mb_state *state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
 	kfree(state);
 }
 
 /* pid filter and transfer stuff */
-
-/* fetch a pid from pid_list */
-static int dib3000_get_pid_index(struct dib3000_pid pid_list[],
-		int num_pids, int pid, spinlock_t *pid_list_lock,int onoff)
-{
-	int i,ret = -1;
-	unsigned long flags;
-
-	spin_lock_irqsave(pid_list_lock,flags);
-	for (i=0; i < num_pids; i++)
-		if (onoff) {
-			if (!pid_list[i].active) {
-				pid_list[i].pid = pid;
-				pid_list[i].active = 1;
-				ret = i;
-			break;
-			}
-		} else {
-			if (pid_list[i].active && pid_list[i].pid == pid) {
-				pid_list[i].pid = 0;
-				pid_list[i].active = 0;
-				ret = i;
-			break;
-	}
-}
-
-	spin_unlock_irqrestore(pid_list_lock,flags);
-	return ret;
-}
-
 static int dib3000mb_pid_control(struct dvb_frontend *fe,int pid,int onoff)
 {
-	struct dib3000mb_state *state = fe->demodulator_priv;
+	struct dib3000_state *state = fe->demodulator_priv;
 	int index = dib3000_get_pid_index(state->pid_list, DIB3000MB_NUM_PIDS, pid, &state->pid_list_lock,onoff);
 	pid = (onoff ? pid | DIB3000_ACTIVATE_PID_FILTERING : 0);
 
-	deb_info("setting pid 0x%x on index %d\n",pid,index);
-
 	if (index >= 0) {
 		wr(index+DIB3000MB_REG_FIRST_PID,pid);
 	} else {
@@ -846,8 +730,9 @@
 
 static int dib3000mb_fifo_control(struct dvb_frontend *fe, int onoff)
 {
-	struct dib3000mb_state *state = (struct dib3000mb_state*) fe->demodulator_priv;
+	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
 
+	deb_xfer("%s fifo\n",onoff ? "enabling" : "disabling");
 	if (onoff) {
 		wr(DIB3000MB_REG_FIFO, DIB3000MB_FIFO_ACTIVATE);
 	} else {
@@ -856,9 +741,9 @@
 	return 0;
 	}
 
-static int dib3000mb_pid_filter(struct dvb_frontend *fe, int onoff)
+static int dib3000mb_pid_parse(struct dvb_frontend *fe, int onoff) 
 {
-	//struct dib3000mb_state *state = fe->demodulator_priv;
+	//struct dib3000_state *state = fe->demodulator_priv;
 	/* switch it off and on */
 	return 0;
 	}
@@ -868,17 +753,16 @@
 struct dvb_frontend* dib3000mb_attach(const struct dib3000_config* config,
 				      struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops)
 {
-	struct dib3000mb_state* state = NULL;
-	int i;
+	struct dib3000_state* state = NULL;
 
 	/* allocate memory for the internal state */
-	state = (struct dib3000mb_state*) kmalloc(sizeof(struct dib3000mb_state), GFP_KERNEL);
+	state = (struct dib3000_state*) kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
 	if (state == NULL)
 		goto error;
 
 	/* setup the state */
-	state->config = config;
 	state->i2c = i2c;
+	memcpy(&state->config,config,sizeof(struct dib3000_config));
 	memcpy(&state->ops, &dib3000mb_ops, sizeof(struct dvb_frontend_ops));
 
 	/* check for the correct demod */
@@ -888,22 +772,15 @@
 	if (rd(DIB3000_REG_DEVICE_ID) != DIB3000MB_DEVICE_ID)
 		goto error;
 
-	/* initialize the id_list */
-	deb_info("initializing %d pids for the pid_list.\n",DIB3000MB_NUM_PIDS);
-	state->pid_list_lock = SPIN_LOCK_UNLOCKED;
-	memset(state->pid_list,0,DIB3000MB_NUM_PIDS*(sizeof(struct dib3000_pid)));
-	for (i=0; i < DIB3000MB_NUM_PIDS; i++) {
-		state->pid_list[i].pid = 0;
-		state->pid_list[i].active = 0;
-}
-	state->feedcount = 0;
+	if (dib3000_init_pid_list(state,DIB3000MB_NUM_PIDS))
+		goto error;
 
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
 
 	/* set the xfer operations */
-	xfer_ops->pid_filter = dib3000mb_pid_filter;
+	xfer_ops->pid_parse = dib3000mb_pid_parse;
 	xfer_ops->fifo_ctrl = dib3000mb_fifo_control;
 	xfer_ops->pid_ctrl = dib3000mb_pid_control;
 
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000mc.c linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000mc.c
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000mc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000mc.c	2004-12-08 14:45:06.000000000 +0100
@@ -0,0 +1,860 @@
+/*
+ * Frontend driver for mobile DVB-T demodulator DiBcom 3000-MC/P
+ * DiBcom (http://www.dibcom.fr/)
+ *
+ * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ *
+ * based on GPL code from DibCom, which has
+ *
+ * Copyright (C) 2004 Amaury Demol for DiBcom (ademol@dibcom.fr)
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ *
+ * Acknowledgements
+ *
+ *  Amaury Demol (ademol@dibcom.fr) from DiBcom for providing specs and driver
+ *  sources, on which this driver (and the dvb-dibusb) are based.
+ *
+ * see Documentation/dvb/README.dibusb for more information
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include "dvb_frontend.h"
+#include "dib3000-common.h"
+#include "dib3000mc_priv.h"
+#include "dib3000.h"
+
+/* Version information */
+#define DRIVER_VERSION "0.1"
+#define DRIVER_DESC "DiBcom 3000-MC DVB-T demodulator driver"
+#define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
+
+#ifdef CONFIG_DVB_DIBCOM_DEBUG
+static int debug;
+module_param(debug, int, 0x644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=setfe,8=getfe (|-able)).");
+#endif
+#define deb_info(args...) dprintk(0x01,args)
+#define deb_xfer(args...) dprintk(0x02,args)
+#define deb_setf(args...) dprintk(0x04,args)
+#define deb_getf(args...) dprintk(0x08,args)
+
+
+static int dib3000mc_set_impulse_noise(struct dib3000_state * state, int mode,
+	fe_transmit_mode_t transmission_mode, fe_bandwidth_t bandwidth)	
+{
+	switch (transmission_mode) {
+		case TRANSMISSION_MODE_2K:
+			wr_foreach(dib3000mc_reg_fft,dib3000mc_fft_modes[0]);
+			break;
+		case TRANSMISSION_MODE_8K:
+			wr_foreach(dib3000mc_reg_fft,dib3000mc_fft_modes[1]);
+			break;
+		default: 
+			break;
+	}
+
+	switch (bandwidth) {
+/*		case BANDWIDTH_5_MHZ:
+			wr_foreach(dib3000mc_reg_impulse_noise,dib3000mc_impluse_noise[0]); 
+			break; */
+		case BANDWIDTH_6_MHZ:
+			wr_foreach(dib3000mc_reg_impulse_noise,dib3000mc_impluse_noise[1]);
+			break;
+		case BANDWIDTH_7_MHZ:
+			wr_foreach(dib3000mc_reg_impulse_noise,dib3000mc_impluse_noise[2]);
+			break;
+		case BANDWIDTH_8_MHZ:
+			wr_foreach(dib3000mc_reg_impulse_noise,dib3000mc_impluse_noise[3]);
+			break;
+		default: 
+			break;
+	}
+
+	switch (mode) {
+		case 0: /* no impulse */ /* fall through */ 
+			wr_foreach(dib3000mc_reg_imp_noise_ctl,dib3000mc_imp_noise_ctl[0]);
+			break;
+		case 1: /* new algo */
+			wr_foreach(dib3000mc_reg_imp_noise_ctl,dib3000mc_imp_noise_ctl[1]);
+			set_or(DIB3000MC_REG_IMP_NOISE_55,DIB3000MC_IMP_NEW_ALGO(0)); /* gives 1<<10 */
+			break;
+		default: /* old algo */
+			wr_foreach(dib3000mc_reg_imp_noise_ctl,dib3000mc_imp_noise_ctl[3]);
+			break;
+	}
+	return 0;
+}
+
+static int dib3000mc_set_timing(struct dib3000_state *state, int upd_offset,
+		fe_transmit_mode_t fft, fe_bandwidth_t bw)
+{
+	u16 timf_msb,timf_lsb;
+	s32 tim_offset,tim_sgn;
+	u64 comp1,comp2,comp=0;
+
+	switch (bw) {
+		case BANDWIDTH_8_MHZ: comp = DIB3000MC_CLOCK_REF*8; break;
+		case BANDWIDTH_7_MHZ: comp = DIB3000MC_CLOCK_REF*7; break;
+		case BANDWIDTH_6_MHZ: comp = DIB3000MC_CLOCK_REF*6; break;
+		default: err("unknown bandwidth (%d)",bw); break;	
+	}
+	timf_msb = (comp >> 16) & 0xff;
+	timf_lsb = (comp & 0xffff);
+
+	// Update the timing offset ;
+	if (upd_offset > 0) {
+		if (!state->timing_offset_comp_done) { 
+			msleep(200);
+			state->timing_offset_comp_done = 1;
+		}
+		tim_offset = rd(DIB3000MC_REG_TIMING_OFFS_MSB);
+		if ((tim_offset & 0x2000) == 0x2000)
+			tim_offset |= 0xC000;
+		if (fft == TRANSMISSION_MODE_2K)
+			tim_offset <<= 2;
+		state->timing_offset += tim_offset;
+	}
+
+	tim_offset = state->timing_offset;
+	if (tim_offset < 0) {
+		tim_sgn = 1; 
+		tim_offset = -tim_offset;
+	} else 
+		tim_sgn = 0;
+	
+	comp1 =  (u32)tim_offset * (u32)timf_lsb ;
+	comp2 =  (u32)tim_offset * (u32)timf_msb ;
+	comp  = ((comp1 >> 16) + comp2) >> 7;
+
+	if (tim_sgn == 0)
+		comp = (u32)(timf_msb << 16) + (u32) timf_lsb + comp;
+	else
+		comp = (u32)(timf_msb << 16) + (u32) timf_lsb - comp ;
+	
+	timf_msb = (comp >> 16) & 0xff;
+	timf_lsb = comp & 0xffff;
+
+	wr(DIB3000MC_REG_TIMING_FREQ_MSB,timf_msb);
+	wr(DIB3000MC_REG_TIMING_FREQ_LSB,timf_lsb);
+	return 0;
+}
+
+static int dib3000mc_init_auto_scan(struct dib3000_state *state, fe_bandwidth_t bw, int boost)
+{
+	if (boost) {
+		wr(DIB3000MC_REG_SCAN_BOOST,DIB3000MC_SCAN_BOOST_ON);
+	} else {
+		wr(DIB3000MC_REG_SCAN_BOOST,DIB3000MC_SCAN_BOOST_OFF);
+	}
+	switch (bw) {
+		case BANDWIDTH_8_MHZ:
+			wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_8mhz);
+			break;
+		case BANDWIDTH_7_MHZ:
+			wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_7mhz);
+			break;
+		case BANDWIDTH_6_MHZ:
+			wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_6mhz);
+			break;
+/*		case BANDWIDTH_5_MHZ:
+			wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_5mhz);
+			break;*/
+		case BANDWIDTH_AUTO:
+			return -EOPNOTSUPP;
+		default:
+			err("unknown bandwidth value (%d).",bw);
+			return -EINVAL;
+	}
+	if (boost) {
+		u32 timeout = (rd(DIB3000MC_REG_BW_TIMOUT_MSB) << 16) + 
+			rd(DIB3000MC_REG_BW_TIMOUT_LSB);
+		timeout *= 85; timeout >>= 7;
+		wr(DIB3000MC_REG_BW_TIMOUT_MSB,(timeout >> 16) & 0xffff);
+		wr(DIB3000MC_REG_BW_TIMOUT_LSB,timeout & 0xffff);
+	}
+	return 0;
+}
+
+static int dib3000mc_get_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep);
+
+static int dib3000mc_set_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep, int tuner)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
+	fe_code_rate_t fe_cr = FEC_NONE;
+	int search_state, seq;
+	u16 val;
+	u8 fft=0, guard=0, qam=0, alpha=0, sel_hp=0, cr=0, hrch=0;
+
+	if (tuner) {
+		wr(DIB3000MC_REG_TUNER,
+				DIB3000_TUNER_WRITE_ENABLE(state->config.pll_addr));
+		state->config.pll_set(fe, fep);
+		wr(DIB3000MC_REG_TUNER,
+				DIB3000_TUNER_WRITE_DISABLE(state->config.pll_addr));
+	}
+
+	dib3000mc_set_timing(state,0,ofdm->transmission_mode,ofdm->bandwidth);
+	dib3000mc_init_auto_scan(state, ofdm->bandwidth, 0);
+
+	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_AGC);
+	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_OFF);
+		
+/* Default cfg isi offset adp */
+	wr_foreach(dib3000mc_reg_offset,dib3000mc_offset[0]);
+
+	wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT | DIB3000MC_ISI_INHIBIT);
+	wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[1]);
+	wr(DIB3000MC_REG_UNK_133,DIB3000MC_UNK_133);
+
+	wr_foreach(dib3000mc_reg_bandwidth_general,dib3000mc_bandwidth_general);
+	if (ofdm->bandwidth == BANDWIDTH_8_MHZ) {
+		wr_foreach(dib3000mc_reg_bw,dib3000mc_bw[3]);
+	} else {
+		wr_foreach(dib3000mc_reg_bw,dib3000mc_bw[0]);
+	}
+	
+	switch (ofdm->transmission_mode) {
+		case TRANSMISSION_MODE_2K: fft = DIB3000_TRANSMISSION_MODE_2K; break;
+		case TRANSMISSION_MODE_8K: fft = DIB3000_TRANSMISSION_MODE_8K; break;
+		case TRANSMISSION_MODE_AUTO: break;
+		default: return -EINVAL;
+	}
+	switch (ofdm->guard_interval) {
+		case GUARD_INTERVAL_1_32: guard = DIB3000_GUARD_TIME_1_32; break;
+		case GUARD_INTERVAL_1_16: guard = DIB3000_GUARD_TIME_1_16; break;
+		case GUARD_INTERVAL_1_8: guard = DIB3000_GUARD_TIME_1_8; break;
+		case GUARD_INTERVAL_1_4: guard = DIB3000_GUARD_TIME_1_4; break;
+		case GUARD_INTERVAL_AUTO: break;
+		default: return -EINVAL;
+	}
+	switch (ofdm->constellation) {
+		case QPSK: qam = DIB3000_CONSTELLATION_QPSK; break;
+		case QAM_16: qam = DIB3000_CONSTELLATION_16QAM; break;
+		case QAM_64: qam = DIB3000_CONSTELLATION_64QAM; break;
+		case QAM_AUTO: break;
+		default: return -EINVAL;
+	}
+	switch (ofdm->hierarchy_information) {
+		case HIERARCHY_NONE: /* fall through */
+		case HIERARCHY_1: alpha = DIB3000_ALPHA_1; break; 
+		case HIERARCHY_2: alpha = DIB3000_ALPHA_2; break;
+		case HIERARCHY_4: alpha = DIB3000_ALPHA_4; break;
+		case HIERARCHY_AUTO: break;
+		default: return -EINVAL;
+	}
+	if (ofdm->hierarchy_information == HIERARCHY_NONE) {
+		hrch = DIB3000_HRCH_OFF;
+		sel_hp = DIB3000_SELECT_HP;
+		fe_cr = ofdm->code_rate_HP;
+	} else if (ofdm->hierarchy_information != HIERARCHY_AUTO) {
+		hrch = DIB3000_HRCH_ON;
+		sel_hp = DIB3000_SELECT_LP;
+		fe_cr = ofdm->code_rate_LP;
+	}
+	switch (fe_cr) {
+		case FEC_1_2: cr = DIB3000_FEC_1_2; break;
+		case FEC_2_3: cr = DIB3000_FEC_2_3; break;
+		case FEC_3_4: cr = DIB3000_FEC_3_4; break;
+		case FEC_5_6: cr = DIB3000_FEC_5_6; break;
+		case FEC_7_8: cr = DIB3000_FEC_7_8; break;
+		case FEC_NONE: break;
+		case FEC_AUTO: break;
+		default: return -EINVAL;
+	}
+	
+	wr(DIB3000MC_REG_DEMOD_PARM,DIB3000MC_DEMOD_PARM(alpha,qam,guard,fft));
+	wr(DIB3000MC_REG_HRCH_PARM,DIB3000MC_HRCH_PARM(sel_hp,cr,hrch));
+
+	switch (fep->inversion) {
+		case INVERSION_OFF:
+			wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_OFF);
+			break;
+		case INVERSION_AUTO:
+			break;
+		case INVERSION_ON:
+			wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_ON);
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	seq = dib3000_seq
+		[ofdm->transmission_mode == TRANSMISSION_MODE_AUTO]
+		[ofdm->guard_interval == GUARD_INTERVAL_AUTO]
+		[fep->inversion == INVERSION_AUTO];
+
+	deb_setf("seq? %d\n", seq);
+	wr(DIB3000MC_REG_SEQ_TPS,DIB3000MC_SEQ_TPS(seq,1));
+
+	dib3000mc_set_impulse_noise(state,0,ofdm->constellation,ofdm->bandwidth);
+	
+	val = rd(DIB3000MC_REG_DEMOD_PARM);
+	wr(DIB3000MC_REG_DEMOD_PARM,val|DIB3000MC_DEMOD_RST_DEMOD_ON);
+	wr(DIB3000MC_REG_DEMOD_PARM,val);
+
+	msleep(70);
+
+	wr_foreach(dib3000mc_reg_agc_bandwidth, dib3000mc_agc_bandwidth);
+
+	/* something has to be auto searched */
+	if (ofdm->constellation == QAM_AUTO ||
+		ofdm->hierarchy_information == HIERARCHY_AUTO ||
+		ofdm->guard_interval == GUARD_INTERVAL_AUTO ||
+		ofdm->transmission_mode == TRANSMISSION_MODE_AUTO ||
+		fe_cr == FEC_AUTO ||
+		fep->inversion == INVERSION_AUTO
+		) {
+		int as_count=0;
+
+		deb_setf("autosearch enabled.\n");
+
+		val = rd(DIB3000MC_REG_DEMOD_PARM);
+		wr(DIB3000MC_REG_DEMOD_PARM,val | DIB3000MC_DEMOD_RST_AUTO_SRCH_ON);
+		wr(DIB3000MC_REG_DEMOD_PARM,val);
+
+		while ((search_state = dib3000_search_status(
+					rd(DIB3000MC_REG_AS_IRQ),1)) < 0 && as_count++ < 100) 
+			msleep(10);
+		
+		deb_info("search_state after autosearch %d after %d checks\n",search_state,as_count);
+		
+		if (search_state == 1) {
+			struct dvb_frontend_parameters feps;
+			feps.u.ofdm.bandwidth = ofdm->bandwidth; /* bw is not auto searched */;
+			if (dib3000mc_get_frontend(fe, &feps) == 0) {
+				deb_setf("reading tuning data from frontend succeeded.\n");
+				return dib3000mc_set_frontend(fe, &feps, 0);
+			}
+		}
+	} else {
+		wr(DIB3000MC_REG_ISI,DIB3000MC_ISI_DEFAULT|DIB3000MC_ISI_ACTIVATE);
+		wr_foreach(dib3000mc_reg_adp_cfg,dib3000mc_adp_cfg[qam]);
+		/* set_offset_cfg */
+		wr_foreach(dib3000mc_reg_offset,
+				dib3000mc_offset[(ofdm->transmission_mode == TRANSMISSION_MODE_8K)+1]);
+
+//		dib3000mc_set_timing(1,ofdm->transmission_mode,ofdm->bandwidth);
+		
+//		wr(DIB3000MC_REG_LOCK_MASK,DIB3000MC_ACTIVATE_LOCK_MASK); /* activates some locks if needed */
+	
+/*		set_or(DIB3000MC_REG_DEMOD_PARM,DIB3000MC_DEMOD_RST_AUTO_SRCH_ON);
+		set_or(DIB3000MC_REG_DEMOD_PARM,DIB3000MC_DEMOD_RST_AUTO_SRCH_OFF);
+		wr(DIB3000MC_REG_RESTART_VIT,DIB3000MC_RESTART_VIT_ON);
+		wr(DIB3000MC_REG_RESTART_VIT,DIB3000MC_RESTART_VIT_OFF);*/
+	}
+
+	return 0;
+}
+
+
+static int dib3000mc_fe_init(struct dvb_frontend* fe, int mobile_mode)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+
+	state->timing_offset = 0;
+	state->timing_offset_comp_done = 0;
+	
+	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_DIV_OUT_ON);
+	wr(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_PAR_CONT_CLK);
+	wr(DIB3000MC_REG_RST_I2C_ADDR,
+		DIB3000MC_DEMOD_ADDR(state->config.demod_address) |
+		DIB3000MC_DEMOD_ADDR_ON);
+	
+	wr(DIB3000MC_REG_RST_I2C_ADDR,
+		DIB3000MC_DEMOD_ADDR(state->config.demod_address));
+	
+	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_CONFIG);
+	wr(DIB3000MC_REG_RESTART,DIB3000MC_RESTART_OFF);
+
+	wr(DIB3000MC_REG_CLK_CFG_1,DIB3000MC_CLK_CFG_1_POWER_UP);
+	wr(DIB3000MC_REG_CLK_CFG_2,DIB3000MC_CLK_CFG_2_PUP_MOBILE);
+	wr(DIB3000MC_REG_CLK_CFG_3,DIB3000MC_CLK_CFG_3_POWER_UP);
+	wr(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_INIT);
+	
+	wr(DIB3000MC_REG_RST_UNC,DIB3000MC_RST_UNC_OFF);
+	wr(DIB3000MC_REG_UNK_19,DIB3000MC_UNK_19);
+
+	wr(33,5);
+	wr(36,81);
+	wr(DIB3000MC_REG_UNK_88,DIB3000MC_UNK_88);				  
+	
+	wr(DIB3000MC_REG_UNK_99,DIB3000MC_UNK_99);
+	wr(DIB3000MC_REG_UNK_111,DIB3000MC_UNK_111_PH_N_MODE_0); /* phase noise algo off */
+
+	/* mobile mode - portable reception */
+	wr_foreach(dib3000mc_reg_mobile_mode,dib3000mc_mobile_mode[1]); 
+
+/* TUNER_PANASONIC_ENV57H12D5: */
+	wr_foreach(dib3000mc_reg_agc_bandwidth,dib3000mc_agc_bandwidth);
+	wr_foreach(dib3000mc_reg_agc_bandwidth_general,dib3000mc_agc_bandwidth_general);
+	wr_foreach(dib3000mc_reg_agc,dib3000mc_agc_tuner[1]);
+
+	wr(DIB3000MC_REG_UNK_110,DIB3000MC_UNK_110);
+	wr(26,0x6680);
+	wr(DIB3000MC_REG_UNK_1,DIB3000MC_UNK_1);
+	wr(DIB3000MC_REG_UNK_2,DIB3000MC_UNK_2);
+	wr(DIB3000MC_REG_UNK_3,DIB3000MC_UNK_3);
+	wr(DIB3000MC_REG_SEQ_TPS,DIB3000MC_SEQ_TPS_DEFAULT);
+	
+	wr_foreach(dib3000mc_reg_bandwidth_general,dib3000mc_bandwidth_general);
+	wr_foreach(dib3000mc_reg_bandwidth,dib3000mc_bandwidth_8mhz);
+	
+	wr(DIB3000MC_REG_UNK_4,DIB3000MC_UNK_4);
+
+	wr(DIB3000MC_REG_SET_DDS_FREQ_MSB,DIB3000MC_DDS_FREQ_MSB_INV_OFF);
+	wr(DIB3000MC_REG_SET_DDS_FREQ_LSB,DIB3000MC_DDS_FREQ_LSB);
+
+	dib3000mc_set_timing(state,0,TRANSMISSION_MODE_2K,BANDWIDTH_8_MHZ); 
+//	wr_foreach(dib3000mc_reg_timing_freq,dib3000mc_timing_freq[3]);
+
+	wr(DIB3000MC_REG_UNK_120,DIB3000MC_UNK_120);
+	wr(DIB3000MC_REG_UNK_134,DIB3000MC_UNK_134);
+	wr(DIB3000MC_REG_FEC_CFG,DIB3000MC_FEC_CFG);
+	
+	dib3000mc_set_impulse_noise(state,0,TRANSMISSION_MODE_8K,BANDWIDTH_8_MHZ);
+
+/* output mode control, just the MPEG2_SLAVE */
+	set_or(DIB3000MC_REG_OUTMODE,DIB3000MC_OM_SLAVE);
+	wr(DIB3000MC_REG_SMO_MODE,DIB3000MC_SMO_MODE_SLAVE);
+	wr(DIB3000MC_REG_FIFO_THRESHOLD,DIB3000MC_FIFO_THRESHOLD_SLAVE);
+	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_SLAVE);
+
+/* MPEG2_PARALLEL_CONTINUOUS_CLOCK
+	wr(DIB3000MC_REG_OUTMODE,
+		DIB3000MC_SET_OUTMODE(DIB3000MC_OM_PAR_CONT_CLK,
+			rd(DIB3000MC_REG_OUTMODE)));
+
+	wr(DIB3000MC_REG_SMO_MODE,
+			DIB3000MC_SMO_MODE_DEFAULT | 
+			DIB3000MC_SMO_MODE_188);
+
+	wr(DIB3000MC_REG_FIFO_THRESHOLD,DIB3000MC_FIFO_THRESHOLD_DEFAULT);
+	wr(DIB3000MC_REG_ELEC_OUT,DIB3000MC_ELEC_OUT_DIV_OUT_ON);
+*/
+/* diversity */
+	wr(DIB3000MC_REG_DIVERSITY1,DIB3000MC_DIVERSITY1_DEFAULT);
+	wr(DIB3000MC_REG_DIVERSITY2,DIB3000MC_DIVERSITY2_DEFAULT);
+
+	wr(DIB3000MC_REG_DIVERSITY3,DIB3000MC_DIVERSITY3_IN_OFF);
+
+	set_or(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_DIV_IN_OFF);
+
+	
+/*	if (state->config->pll_init) {
+		wr(DIB3000MC_REG_TUNER,
+			DIB3000_TUNER_WRITE_ENABLE(state->config->pll_addr));
+		state->config->pll_init(fe);
+		wr(DIB3000MC_REG_TUNER,
+			DIB3000_TUNER_WRITE_DISABLE(state->config->pll_addr));
+	}*/
+	return 0;
+}
+
+static int dib3000mc_get_frontend(struct dvb_frontend* fe,
+				  struct dvb_frontend_parameters *fep)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
+	fe_code_rate_t *cr;
+	u16 tps_val,cr_val;
+	int inv_test1,inv_test2;
+	u32 dds_val, threshold = 0x1000000;
+
+	if (!(rd(DIB3000MC_REG_LOCK_507) & DIB3000MC_LOCK_507))
+		return 0;
+
+	dds_val = ((rd(DIB3000MC_REG_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MC_REG_DDS_FREQ_LSB);
+	if (dds_val < threshold)
+		inv_test1 = 0;
+	else if (dds_val == threshold)
+		inv_test1 = 1;
+	else
+		inv_test1 = 2;
+
+	dds_val = ((rd(DIB3000MC_REG_SET_DDS_FREQ_MSB) & 0xff) << 16) + rd(DIB3000MC_REG_SET_DDS_FREQ_LSB);
+	if (dds_val < threshold)
+		inv_test2 = 0;
+	else if (dds_val == threshold)
+		inv_test2 = 1;
+	else
+		inv_test2 = 2;
+
+	fep->inversion =
+		((inv_test2 == 2) && (inv_test1==1 || inv_test1==0)) ||
+		((inv_test2 == 0) && (inv_test1==1 || inv_test1==2)) ? 
+		INVERSION_ON : INVERSION_OFF;
+
+	deb_getf("inversion %d %d, %d\n", inv_test2, inv_test1, fep->inversion);
+
+	tps_val = rd(DIB3000MC_REG_TUNING_PARM);
+
+	switch (DIB3000MC_TP_QAM(tps_val)) {
+		case DIB3000_CONSTELLATION_QPSK:
+			deb_getf("QPSK ");
+			ofdm->constellation = QPSK;
+			break;
+		case DIB3000_CONSTELLATION_16QAM:
+			deb_getf("QAM16 ");
+			ofdm->constellation = QAM_16;
+			break;
+		case DIB3000_CONSTELLATION_64QAM:
+			deb_getf("QAM64 ");
+			ofdm->constellation = QAM_64;
+			break;
+		default:
+			err("Unexpected constellation returned by TPS (%d)", tps_val);
+			break;
+ 	}
+
+	if (DIB3000MC_TP_HRCH(tps_val)) {
+		deb_getf("HRCH ON ");
+		cr = &ofdm->code_rate_LP;
+		ofdm->code_rate_HP = FEC_NONE;
+		switch (DIB3000MC_TP_ALPHA(tps_val)) {
+			case DIB3000_ALPHA_0:
+				deb_getf("HIERARCHY_NONE ");
+				ofdm->hierarchy_information = HIERARCHY_NONE;
+				break;
+			case DIB3000_ALPHA_1:
+				deb_getf("HIERARCHY_1 ");
+				ofdm->hierarchy_information = HIERARCHY_1;
+				break;
+			case DIB3000_ALPHA_2:
+				deb_getf("HIERARCHY_2 ");
+				ofdm->hierarchy_information = HIERARCHY_2;
+				break;
+			case DIB3000_ALPHA_4:
+				deb_getf("HIERARCHY_4 ");
+				ofdm->hierarchy_information = HIERARCHY_4;
+				break;
+			default:
+				err("Unexpected ALPHA value returned by TPS (%d)", tps_val);
+				break;
+		}
+		cr_val = DIB3000MC_TP_FEC_CR_LP(tps_val);
+	} else {
+		deb_getf("HRCH OFF ");
+		cr = &ofdm->code_rate_HP;
+		ofdm->code_rate_LP = FEC_NONE;
+		ofdm->hierarchy_information = HIERARCHY_NONE;
+		cr_val = DIB3000MC_TP_FEC_CR_HP(tps_val);
+	}
+
+	switch (cr_val) {
+		case DIB3000_FEC_1_2:
+			deb_getf("FEC_1_2 ");
+			*cr = FEC_1_2;
+			break;
+		case DIB3000_FEC_2_3:
+			deb_getf("FEC_2_3 ");
+			*cr = FEC_2_3;
+			break;
+		case DIB3000_FEC_3_4:
+			deb_getf("FEC_3_4 ");
+			*cr = FEC_3_4;
+			break;
+		case DIB3000_FEC_5_6:
+			deb_getf("FEC_5_6 ");
+			*cr = FEC_4_5;
+			break;
+		case DIB3000_FEC_7_8:
+			deb_getf("FEC_7_8 ");
+			*cr = FEC_7_8;
+			break;
+		default:
+			err("Unexpected FEC returned by TPS (%d)", tps_val);
+			break;
+	}
+
+	switch (DIB3000MC_TP_GUARD(tps_val)) {
+		case DIB3000_GUARD_TIME_1_32:
+			deb_getf("GUARD_INTERVAL_1_32 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_32;
+			break;
+		case DIB3000_GUARD_TIME_1_16:
+			deb_getf("GUARD_INTERVAL_1_16 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_16;
+			break;
+		case DIB3000_GUARD_TIME_1_8:
+			deb_getf("GUARD_INTERVAL_1_8 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_8;
+			break;
+		case DIB3000_GUARD_TIME_1_4:
+			deb_getf("GUARD_INTERVAL_1_4 ");
+			ofdm->guard_interval = GUARD_INTERVAL_1_4;
+			break;
+		default:
+			err("Unexpected Guard Time returned by TPS (%d)", tps_val);
+			break;
+	}
+
+	switch (DIB3000MC_TP_FFT(tps_val)) {
+		case DIB3000_TRANSMISSION_MODE_2K:
+			deb_getf("TRANSMISSION_MODE_2K ");
+			ofdm->transmission_mode = TRANSMISSION_MODE_2K;
+			break;
+		case DIB3000_TRANSMISSION_MODE_8K:
+			deb_getf("TRANSMISSION_MODE_8K ");
+			ofdm->transmission_mode = TRANSMISSION_MODE_8K;
+			break;
+		default:
+			err("unexpected transmission mode return by TPS (%d)", tps_val);
+			break;
+	}
+	return 0;
+}
+
+static int dib3000mc_read_status(struct dvb_frontend* fe, fe_status_t *stat)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	u16 lock = rd(DIB3000MC_REG_LOCKING);
+
+	*stat = 0;
+	if (DIB3000MC_AGC_LOCK(lock))
+		*stat |= FE_HAS_SIGNAL;
+	if (DIB3000MC_CARRIER_LOCK(lock))
+		*stat |= FE_HAS_CARRIER;
+	if (DIB3000MC_TPS_LOCK(lock)) /* VIT_LOCK ? */
+		*stat |= FE_HAS_VITERBI;
+	if (DIB3000MC_MPEG_SYNC_LOCK(lock))
+		*stat |= (FE_HAS_SYNC | FE_HAS_LOCK);
+
+	deb_info("actual status is %2x\n",*stat);
+
+	return 0;
+}
+
+static int dib3000mc_read_ber(struct dvb_frontend* fe, u32 *ber)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	*ber = ((rd(DIB3000MC_REG_BER_MSB) << 16) | rd(DIB3000MC_REG_BER_LSB));
+	return 0;
+}
+
+static int dib3000mc_read_unc_blocks(struct dvb_frontend* fe, u32 *unc)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+
+	*unc = rd(DIB3000MC_REG_PACKET_ERROR_COUNT);
+	return 0;
+}
+
+/* see dib3000mb.c for calculation comments */
+static int dib3000mc_read_signal_strength(struct dvb_frontend* fe, u16 *strength)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB);
+	*strength = (((val >> 6) & 0xff) << 8) + (val & 0x3f);
+
+	deb_info("signal: mantisse = %d, exponent = %d\n",(*strength >> 8) & 0xff, *strength & 0xff);
+	return 0;
+}
+
+/* see dib3000mb.c for calculation comments */
+static int dib3000mc_read_snr(struct dvb_frontend* fe, u16 *snr)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+	
+	u16 val = rd(DIB3000MC_REG_SIGNAL_NOISE_MSB),
+		val2 = rd(DIB3000MC_REG_SIGNAL_NOISE_LSB);
+	u16 sig,noise;
+	
+	sig =   (((val >> 6) & 0xff) << 8) + (val & 0x3f);
+	noise = (((val >> 4) & 0xff) << 8) + ((val & 0xf) << 2) + ((val2 >> 14) & 0x3);
+	if (noise == 0)
+		*snr = 0xffff;
+	else
+		*snr = (u16) sig/noise;
+	
+	deb_info("signal: mantisse = %d, exponent = %d\n",(sig >> 8) & 0xff, sig & 0xff);
+	deb_info("noise:  mantisse = %d, exponent = %d\n",(noise >> 8) & 0xff, noise & 0xff);
+	deb_info("snr: %d\n",*snr);
+	return 0;
+}
+
+static int dib3000mc_sleep(struct dvb_frontend* fe)
+{
+	struct dib3000_state* state = (struct dib3000_state*) fe->demodulator_priv;
+
+	set_or(DIB3000MC_REG_CLK_CFG_7,DIB3000MC_CLK_CFG_7_PWR_DOWN);
+	wr(DIB3000MC_REG_CLK_CFG_1,DIB3000MC_CLK_CFG_1_POWER_DOWN);
+	wr(DIB3000MC_REG_CLK_CFG_2,DIB3000MC_CLK_CFG_2_POWER_DOWN);
+	wr(DIB3000MC_REG_CLK_CFG_3,DIB3000MC_CLK_CFG_3_POWER_DOWN);
+	return 0;
+}
+
+static int dib3000mc_fe_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
+{
+	tune->min_delay_ms = 800;
+	tune->step_size = 166667;
+	tune->max_drift = 166667 * 2;
+
+	return 0;
+}
+
+static int dib3000mc_fe_init_nonmobile(struct dvb_frontend* fe)
+{
+	return dib3000mc_fe_init(fe, 0);
+}
+
+static int dib3000mc_set_frontend_and_tuner(struct dvb_frontend* fe, struct dvb_frontend_parameters *fep)
+{
+	return dib3000mc_set_frontend(fe, fep, 1);
+}
+
+static void dib3000mc_release(struct dvb_frontend* fe)
+{
+	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	dib3000_dealloc_pid_list(state);
+	kfree(state);
+}
+
+/* pid filter and transfer stuff */
+static int dib3000mc_pid_control(struct dvb_frontend *fe,int pid,int onoff)
+{
+	struct dib3000_state *state = fe->demodulator_priv;
+	int index = dib3000_get_pid_index(state->pid_list, DIB3000MC_NUM_PIDS, pid, &state->pid_list_lock,onoff);
+	pid = (onoff ? pid | DIB3000_ACTIVATE_PID_FILTERING : 0);
+
+	if (index >= 0) {
+		wr(index+DIB3000MC_REG_FIRST_PID,pid);
+	} else {
+		err("no more pids for filtering.");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int dib3000mc_fifo_control(struct dvb_frontend *fe, int onoff) 
+{
+	struct dib3000_state *state = (struct dib3000_state*) fe->demodulator_priv;
+	u16 tmp = rd(DIB3000MC_REG_SMO_MODE);
+	deb_xfer("%s fifo",onoff ? "enabling" : "disabling");
+	if (onoff) {
+		wr(DIB3000MC_REG_SMO_MODE,tmp & DIB3000MC_SMO_MODE_FIFO_UNFLUSH);
+	} else {
+		wr(DIB3000MC_REG_SMO_MODE,tmp | DIB3000MC_SMO_MODE_FIFO_FLUSH);
+	}
+	return 0;
+}
+
+static int dib3000mc_pid_parse(struct dvb_frontend *fe, int onoff) 
+{
+	struct dib3000_state *state = fe->demodulator_priv;
+	u16 tmp = rd(DIB3000MC_REG_SMO_MODE);
+	deb_xfer("%s pid parsing",onoff ? "enabling" : "disabling");
+	if (onoff) {
+		wr(DIB3000MC_REG_SMO_MODE,tmp | DIB3000MC_SMO_MODE_PID_PARSE);
+	} else {
+		wr(DIB3000MC_REG_SMO_MODE,tmp & DIB3000MC_SMO_MODE_NO_PID_PARSE);
+	}
+	return 0;
+}
+
+static struct dvb_frontend_ops dib3000mc_ops;
+
+struct dvb_frontend* dib3000mc_attach(const struct dib3000_config* config,
+				      struct i2c_adapter* i2c, struct dib3000_xfer_ops *xfer_ops)
+{
+	struct dib3000_state* state = NULL;
+	u16 devid;
+
+	/* allocate memory for the internal state */
+	state = (struct dib3000_state*) kmalloc(sizeof(struct dib3000_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+
+	/* setup the state */
+	state->i2c = i2c;
+	memcpy(&state->config,config,sizeof(struct dib3000_config));
+	memcpy(&state->ops, &dib3000mc_ops, sizeof(struct dvb_frontend_ops));
+
+	/* check for the correct demod */
+	if (rd(DIB3000_REG_MANUFACTOR_ID) != DIB3000_I2C_ID_DIBCOM) 
+		goto error;
+
+	devid = rd(DIB3000_REG_DEVICE_ID);
+	if (devid != DIB3000MC_DEVICE_ID && devid != DIB3000P_DEVICE_ID)
+		goto error;
+	
+	
+	switch (devid) {
+		case DIB3000MC_DEVICE_ID:
+			info("Found a DiBcom 3000-MC.");
+			break;
+		case DIB3000P_DEVICE_ID:
+			info("Found a DiBcom 3000-P.");
+			break;
+	}
+
+	if (dib3000_init_pid_list(state,DIB3000MC_NUM_PIDS)) 
+		goto error;
+	
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+
+	/* set the xfer operations */
+	xfer_ops->pid_parse = dib3000mc_pid_parse;
+	xfer_ops->fifo_ctrl = dib3000mc_fifo_control;
+	xfer_ops->pid_ctrl = dib3000mc_pid_control;
+	
+	return &state->frontend;
+
+error:
+	if (state)
+		kfree(state);
+	return NULL;
+}
+			
+static struct dvb_frontend_ops dib3000mc_ops = {
+
+	.info = {
+		.name			= "DiBcom 3000-MC/P DVB-T",
+		.type 			= FE_OFDM,
+		.frequency_min 		= 44250000,
+		.frequency_max 		= 867250000,
+		.frequency_stepsize	= 62500,
+		.caps = FE_CAN_INVERSION_AUTO |
+				FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+				FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+				FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+				FE_CAN_TRANSMISSION_MODE_AUTO |
+				FE_CAN_GUARD_INTERVAL_AUTO |
+				FE_CAN_HIERARCHY_AUTO,
+	},
+
+	.release = dib3000mc_release,
+
+	.init = dib3000mc_fe_init_nonmobile,
+	.sleep = dib3000mc_sleep,
+
+	.set_frontend = dib3000mc_set_frontend_and_tuner,
+	.get_frontend = dib3000mc_get_frontend,
+	.get_tune_settings = dib3000mc_fe_get_tune_settings,
+
+	.read_status = dib3000mc_read_status,
+	.read_ber = dib3000mc_read_ber,
+	.read_signal_strength = dib3000mc_read_signal_strength,
+	.read_snr = dib3000mc_read_snr,
+	.read_ucblocks = dib3000mc_read_unc_blocks,
+};
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(dib3000mc_attach);
diff -uraNwB linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000mc_priv.h linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000mc_priv.h
--- linux-2.6.10-rc3-bk3/drivers/media/dvb/frontends/dib3000mc_priv.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/drivers/media/dvb/frontends/dib3000mc_priv.h	2004-11-23 21:16:39.000000000 +0100
@@ -0,0 +1,439 @@
+/*
+ * dib3000mc_priv.h
+ * 
+ * Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de)
+ * 
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2.
+ * 
+ * for more information see dib3000mc.c .
+ */
+
+#ifndef __DIB3000MC_PRIV_H__
+#define __DIB3000MC_PRIV_H__
+
+/* info and err, taken from usb.h, if there is anything available like by default,
+ * please change !
+ */
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
+
+// defines the phase noise algorithm to be used (O:Inhib, 1:CPE on)
+#define DEF_PHASE_NOISE_MODE                0 
+  
+// define Mobille algorithms 
+#define DEF_MOBILE_MODE      Auto_Reception 
+  
+// defines the tuner type 
+#define DEF_TUNER_TYPE   TUNER_PANASONIC_ENV57H13D5
+  
+// defines the impule noise algorithm to be used  
+#define DEF_IMPULSE_NOISE_MODE      0 
+  
+// defines the MPEG2 data output format 
+#define DEF_MPEG2_OUTPUT_188       0
+  
+// defines the MPEG2 data output format 
+#define DEF_OUTPUT_MODE       MPEG2_PARALLEL_CONTINUOUS_CLOCK
+
+/*
+ * Demodulator parameters
+ * reg: 0  1 1  1 11 11 111 
+ *         | |  |  |  |  |
+ *         | |  |  |  |  +-- alpha (000=0, 001=1, 010=2, 100=4)
+ *         | |  |  |  +----- constellation (00=QPSK, 01=16QAM, 10=64QAM) 
+ *         | |  |  +-------- guard (00=1/32, 01=1/16, 10=1/8, 11=1/4)
+ *         | |  +----------- transmission mode (0=2k, 1=8k)
+ *         | |
+ *         | +-------------- restart autosearch for parameters
+ *         +---------------- restart the demodulator
+ * reg: 181      1 111 1
+ *               |  |  |
+ *               |  |  +- FEC applies for HP or LP (0=LP, 1=HP)
+ *               |  +---- FEC rate (001=1/2, 010=2/3, 011=3/4, 101=5/6, 111=7/8)
+ *               +------- hierarchy on (0=no, 1=yes)
+ */
+
+/* demodulator tuning parameter and restart options */
+#define DIB3000MC_REG_DEMOD_PARM		(     0)
+#define DIB3000MC_DEMOD_PARM(a,c,g,t)	( \
+		 (0x7 & a) | \
+		((0x3 & c) << 3) | \
+		((0x3 & g) << 5) | \
+		((0x1 & t) << 7) )
+#define DIB3000MC_DEMOD_RST_AUTO_SRCH_ON	(1 << 8)
+#define DIB3000MC_DEMOD_RST_AUTO_SRCH_OFF	(0 << 8)
+#define DIB3000MC_DEMOD_RST_DEMOD_ON		(1 << 9)
+#define DIB3000MC_DEMOD_RST_DEMOD_OFF		(0 << 9)
+
+/* register for hierarchy parameters */
+#define DIB3000MC_REG_HRCH_PARM			(   181)
+#define DIB3000MC_HRCH_PARM(s,f,h)		( \
+		 (0x1 & s) | \
+		((0x7 & f) << 1) | \
+		((0x1 & h) << 4) )
+		 
+/* timeout ??? */
+#define DIB3000MC_REG_UNK_1				(     1)
+#define DIB3000MC_UNK_1					(  0x04)
+
+/* timeout ??? */
+#define DIB3000MC_REG_UNK_2				(     2)
+#define DIB3000MC_UNK_2					(  0x04)
+
+/* timeout ??? */
+#define DIB3000MC_REG_UNK_3				(     3)
+#define DIB3000MC_UNK_3					(0x1000)
+
+#define DIB3000MC_REG_UNK_4				(     4)
+#define DIB3000MC_UNK_4					(0x0814)
+
+/* timeout ??? */
+#define DIB3000MC_REG_SEQ_TPS			(     5)
+#define DIB3000MC_SEQ_TPS_DEFAULT		(     1)
+#define DIB3000MC_SEQ_TPS(s,t)			( \
+		((s & 0x0f) << 4) | \
+		((t & 0x01) << 8) )
+#define DIB3000MC_IS_TPS(v)				((v << 8) & 0x1)
+#define DIB3000MC_IS_AS(v)				((v >> 4) & 0xf)
+
+/* parameters for the bandwidth */ 
+#define DIB3000MC_REG_BW_TIMOUT_MSB		(     6)
+#define DIB3000MC_REG_BW_TIMOUT_LSB		(     7)
+
+static u16 dib3000mc_reg_bandwidth[] = { 6,7,8,9,10,11,16,17 };
+
+/*static u16 dib3000mc_bandwidth_5mhz[] = 
+	{ 0x28, 0x9380, 0x87, 0x4100, 0x2a4, 0x4500, 0x1, 0xb0d0 };*/
+
+static u16 dib3000mc_bandwidth_6mhz[] = 
+	{ 0x21, 0xd040, 0x70, 0xb62b, 0x233, 0x8ed5, 0x1, 0xb0d0 };
+
+static u16 dib3000mc_bandwidth_7mhz[] =
+	{ 0x1c, 0xfba5, 0x60, 0x9c25, 0x1e3, 0x0cb7, 0x1, 0xb0d0 };
+
+static u16 dib3000mc_bandwidth_8mhz[] =
+	{ 0x19, 0x5c30, 0x54, 0x88a0, 0x1a6, 0xab20, 0x1, 0xb0b0 };
+
+static u16 dib3000mc_reg_bandwidth_general[] = { 12,13,14,15 };
+static u16 dib3000mc_bandwidth_general[] = { 0x0000, 0x03e8, 0x0000, 0x03f2 };
+
+/* lock mask */
+#define DIB3000MC_REG_LOCK_MASK			(    15)
+#define DIB3000MC_ACTIVATE_LOCK_MASK	(0x0800)
+
+/* reset the uncorrected packet count (??? do it 5 times) */
+#define DIB3000MC_REG_RST_UNC			(    18)
+#define DIB3000MC_RST_UNC_ON			(     1)
+#define DIB3000MC_RST_UNC_OFF			(     0)
+
+#define DIB3000MC_REG_UNK_19			(    19)
+#define DIB3000MC_UNK_19				(     0)
+
+/* DDS frequency value (IF position) and inversion bit */ 
+#define DIB3000MC_REG_INVERSION			(    21)
+#define DIB3000MC_REG_SET_DDS_FREQ_MSB	(    21)
+#define DIB3000MC_DDS_FREQ_MSB_INV_OFF	(0x0164)
+#define DIB3000MC_DDS_FREQ_MSB_INV_ON	(0x0364)
+
+#define DIB3000MC_REG_SET_DDS_FREQ_LSB	(    22)
+#define DIB3000MC_DDS_FREQ_LSB			(0x463d)
+
+/* timing frequencies setting */
+#define DIB3000MC_REG_TIMING_FREQ_MSB	(    23)
+#define DIB3000MC_REG_TIMING_FREQ_LSB	(    24)
+#define DIB3000MC_CLOCK_REF				(0x151fd1)
+
+//static u16 dib3000mc_reg_timing_freq[] = { 23,24 };
+
+//static u16 dib3000mc_timing_freq[][2] = {
+//	{ 0x69, 0x9f18 }, /* 5 MHz */
+//	{ 0x7e ,0xbee9 }, /* 6 MHz */ 
+//	{ 0x93 ,0xdebb }, /* 7 MHz */
+//	{ 0xa8 ,0xfe8c }, /* 8 MHz */
+//};
+
+/* timeout ??? */
+static u16 dib3000mc_reg_offset[] = { 26,33 };
+
+static u16 dib3000mc_offset[][2] = {
+	{ 26240, 5 }, /* default */
+	{ 30336, 6 }, /* 8K */
+	{ 38528, 8 }, /* 2K */
+};
+
+#define DIB3000MC_REG_ISI				(    29)
+#define DIB3000MC_ISI_DEFAULT			(0x1073)
+#define DIB3000MC_ISI_ACTIVATE			(0x0000)
+#define DIB3000MC_ISI_INHIBIT			(0x0200)
+
+/* impulse noise control */
+static u16 dib3000mc_reg_imp_noise_ctl[] = { 34,35 };
+
+static u16 dib3000mc_imp_noise_ctl[][2] = {
+	{ 0x1294, 0xfff8 }, /* mode 0 */
+	{ 0x1294, 0xfff8 }, /* mode 1 */
+	{ 0x1294, 0xfff8 }, /* mode 2 */
+	{ 0x1294, 0xfff8 }, /* mode 3 */
+	{ 0x1294, 0xfff8 }, /* mode 4 */
+};
+
+/* AGC registers */ 
+static u16 dib3000mc_reg_agc[] = {
+	36,37,38,39,42,43,44,45,46,47,48,49
+};
+
+static u16 dib3000mc_agc_tuner[][12] = {
+	{	0x0051, 0x301d, 0x0000, 0x1cc7, 0xcf5c, 0x6666,
+		0xbae1, 0xa148, 0x3b5e, 0x3c1c, 0x001a, 0x2019
+	}, /* TUNER_PANASONIC_ENV77H04D5, */
+	
+	{	0x0051, 0x301d, 0x0000, 0x1cc7, 0xdc29, 0x570a, 
+		0xbae1, 0x8ccd, 0x3b6d, 0x551d, 0x000a, 0x951e
+	}, /* TUNER_PANASONIC_ENV57H13D5, TUNER_PANASONIC_ENV57H12D5 */
+
+	{	0x0051, 0x301d, 0x0000, 0x1cc7, 0xffff, 0xffff,
+		0xffff, 0x0000, 0xfdfd, 0x4040, 0x00fd, 0x4040
+	}, /* TUNER_SAMSUNG_DTOS333IH102, TUNER_RFAGCIN_UNKNOWN */
+
+	{	0x0196, 0x301d, 0x0000, 0x1cc7, 0xbd71, 0x5c29,
+		0xb5c3, 0x6148, 0x6569, 0x5127, 0x0033, 0x3537
+	}, /* TUNER_PROVIDER_X */
+	/* TODO TUNER_PANASONIC_ENV57H10D8, TUNER_PANASONIC_ENV57H11D8 */
+};
+
+/* AGC loop bandwidth */
+static u16 dib3000mc_reg_agc_bandwidth[] = { 40,41 };
+static u16 dib3000mc_agc_bandwidth[]  = { 0x119,0x330 };
+
+static u16 dib3000mc_reg_agc_bandwidth_general[] = { 50,51,52,53,54 };
+static u16 dib3000mc_agc_bandwidth_general[] = 
+	{ 0x8000, 0x91ca, 0x01ba, 0x0087, 0x0087 };
+
+#define DIB3000MC_REG_IMP_NOISE_55 		(    55)
+#define DIB3000MC_IMP_NEW_ALGO(w)		(w | (1<<10))
+
+/* Impulse noise params */
+static u16 dib3000mc_reg_impulse_noise[] = { 55,56,57 };
+static u16 dib3000mc_impluse_noise[][3] = {
+	{ 0x489, 0x89, 0x72 }, /* 5 MHz */
+	{ 0x4a5, 0xa5, 0x89 }, /* 6 MHz */
+	{ 0x4c0, 0xc0, 0xa0 }, /* 7 MHz */
+	{ 0x4db, 0xdb, 0xb7 }, /* 8 Mhz */
+};
+
+static u16 dib3000mc_reg_fft[] = {
+	58,59,60,61,62,63,64,65,66,67,68,69,
+	70,71,72,73,74,75,76,77,78,79,80,81,
+	82,83,84,85,86 
+};
+
+static u16 dib3000mc_fft_modes[][29] = {
+	{	0x38, 0x6d9, 0x3f28, 0x7a7, 0x3a74, 0x196, 0x32a, 0x48c, 
+		0x3ffe, 0x7f3, 0x2d94, 0x76, 0x53d, 
+		0x3ff8, 0x7e3, 0x3320, 0x76, 0x5b3, 
+	  	0x3feb, 0x7d2, 0x365e, 0x76, 0x48c, 
+	  	0x3ffe, 0x5b3, 0x3feb, 0x76,   0x0, 0xd 
+	}, /* fft mode 0 */
+	{	0x3b, 0x6d9, 0x3f28, 0x7a7, 0x3a74, 0x196, 0x32a, 0x48c,
+		0x3ffe, 0x7f3, 0x2d94, 0x76, 0x53d, 
+		0x3ff8, 0x7e3, 0x3320, 0x76, 0x5b3, 
+	  	0x3feb, 0x7d2, 0x365e, 0x76, 0x48c, 
+	  	0x3ffe, 0x5b3, 0x3feb, 0x0,  0x8200, 0xd 
+	}, /* fft mode 1 */
+};
+
+#define DIB3000MC_REG_UNK_88			(    88)
+#define DIB3000MC_UNK_88				(0x0410)    
+
+static u16 dib3000mc_reg_bw[] = { 93,94,95,96,97,98 };
+static u16 dib3000mc_bw[][6] = {
+	{ 0,0,0,0,0,0 }, /* 5 MHz */
+	{ 0,0,0,0,0,0 }, /* 6 MHz */
+	{ 0,0,0,0,0,0 }, /* 7 MHz */
+	{ 0x20, 0x21, 0x20, 0x23, 0x20, 0x27 }, /* 8 MHz */
+};
+
+
+/* phase noise control */
+#define DIB3000MC_REG_UNK_99			(    99)
+#define DIB3000MC_UNK_99				(0x0220)
+
+#define DIB3000MC_REG_SCAN_BOOST		(   100)
+#define DIB3000MC_SCAN_BOOST_ON			((11 << 6) + 6)
+#define DIB3000MC_SCAN_BOOST_OFF		((16 << 6) + 9)
+
+/* timeout ??? */
+#define DIB3000MC_REG_UNK_110			(   110)
+#define DIB3000MC_UNK_110				(  3277)
+
+#define DIB3000MC_REG_UNK_111			(   111)
+#define DIB3000MC_UNK_111_PH_N_MODE_0	(     0)
+#define DIB3000MC_UNK_111_PH_N_MODE_1	(1 << 1)
+
+/* superious rm config */
+#define DIB3000MC_REG_UNK_120			(   120)
+#define DIB3000MC_UNK_120				(  8207)
+
+#define DIB3000MC_REG_UNK_133			(   133)
+#define DIB3000MC_UNK_133				( 15564)
+
+#define DIB3000MC_REG_UNK_134			(   134)
+#define DIB3000MC_UNK_134				(     0)
+
+/* adapter config for constellation */
+static u16 dib3000mc_reg_adp_cfg[] = { 129, 130, 131, 132 };
+
+static u16 dib3000mc_adp_cfg[][4] = { 
+	{ 0x99a, 0x7fae, 0x333, 0x7ff0 }, /* QPSK  */
+	{ 0x23d, 0x7fdf, 0x0a4, 0x7ff0 }, /* 16-QAM */
+	{ 0x148, 0x7ff0, 0x0a4, 0x7ff8 }, /* 64-QAM */
+};
+
+static u16 dib3000mc_reg_mobile_mode[] = { 139, 140, 141, 175, 1032 };
+
+static u16 dib3000mc_mobile_mode[][5] = {
+	{ 0x01, 0x0, 0x0, 0x00, 0x12c }, /* fixed */
+	{ 0x01, 0x0, 0x0, 0x00, 0x12c }, /* portable */
+	{ 0x00, 0x0, 0x0, 0x02, 0x000 }, /* mobile */
+	{ 0x00, 0x0, 0x0, 0x02, 0x000 }, /* auto */
+};
+
+#define DIB3000MC_REG_DIVERSITY1		(   177)
+#define DIB3000MC_DIVERSITY1_DEFAULT	(     1)
+
+#define DIB3000MC_REG_DIVERSITY2		(   178)
+#define DIB3000MC_DIVERSITY2_DEFAULT	(     1)
+
+#define DIB3000MC_REG_DIVERSITY3		(   180)
+#define DIB3000MC_DIVERSITY3_IN_OFF		(0xfff0)
+#define DIB3000MC_DIVERSITY3_IN_ON		(0xfff6)
+
+#define DIB3000MC_REG_FEC_CFG			(   195)
+#define DIB3000MC_FEC_CFG				(  0x10)
+
+#define DIB3000MC_REG_SMO_MODE			(   206)
+#define DIB3000MC_SMO_MODE_DEFAULT		(1 << 2)
+#define DIB3000MC_SMO_MODE_FIFO_FLUSH	(1 << 3)
+#define DIB3000MC_SMO_MODE_FIFO_UNFLUSH	~DIB3000MC_SMO_MODE_FIFO_FLUSH
+#define DIB3000MC_SMO_MODE_PID_PARSE	(1 << 4)
+#define DIB3000MC_SMO_MODE_NO_PID_PARSE	~DIB3000MC_SMO_MODE_PID_PARSE
+#define DIB3000MC_SMO_MODE_188			(1 << 5)
+#define DIB3000MC_SMO_MODE_SLAVE		(DIB3000MC_SMO_MODE_DEFAULT | \
+			DIB3000MC_SMO_MODE_188 | DIB3000MC_SMO_MODE_PID_PARSE | (1<<1))
+
+#define DIB3000MC_REG_FIFO_THRESHOLD	(   207)
+#define DIB3000MC_FIFO_THRESHOLD_DEFAULT	(  1792)
+#define DIB3000MC_FIFO_THRESHOLD_SLAVE	(   512)
+/*
+ * pidfilter
+ * it is not a hardware pidfilter but a filter which drops all pids
+ * except the ones set. When connected to USB1.1 bandwidth this is important.
+ * DiB3000-MC/P can filter up to 32 PIDs
+ */
+#define DIB3000MC_REG_FIRST_PID			(   212)
+#define DIB3000MC_NUM_PIDS				(    32)
+
+#define DIB3000MC_REG_OUTMODE			(   244)
+#define DIB3000MC_OM_PARALLEL_GATED_CLK	(     0)
+#define DIB3000MC_OM_PAR_CONT_CLK		(1 << 11)
+#define DIB3000MC_OM_SERIAL				(2 << 11)
+#define DIB3000MC_OM_DIVOUT_ON			(4 << 11)
+#define DIB3000MC_OM_SLAVE				(DIB3000MC_OM_DIVOUT_ON | DIB3000MC_OM_PAR_CONT_CLK)
+
+#define DIB3000MC_REG_RF_POWER			(   392)
+
+#define DIB3000MC_REG_FFT_POSITION		(   407)
+
+#define DIB3000MC_REG_DDS_FREQ_MSB		(   414)
+#define DIB3000MC_REG_DDS_FREQ_LSB		(   415)
+
+#define DIB3000MC_REG_TIMING_OFFS_MSB	(   416)
+#define DIB3000MC_REG_TIMING_OFFS_LSB	(   417)
+
+#define DIB3000MC_REG_TUNING_PARM		(   458)
+#define DIB3000MC_TP_QAM(v)				((v >> 13) & 0x03)
+#define DIB3000MC_TP_HRCH(v)			((v >> 12) & 0x01)
+#define DIB3000MC_TP_ALPHA(v)			((v >> 9) & 0x07)
+#define DIB3000MC_TP_FFT(v)				((v >> 8) & 0x01)
+#define DIB3000MC_TP_FEC_CR_HP(v)		((v >> 5) & 0x07)
+#define DIB3000MC_TP_FEC_CR_LP(v)		((v >> 2) & 0x07)
+#define DIB3000MC_TP_GUARD(v)			(v & 0x03)
+
+#define DIB3000MC_REG_SIGNAL_NOISE_MSB	(   483)
+#define DIB3000MC_REG_SIGNAL_NOISE_LSB	(   484)
+
+#define DIB3000MC_REG_MER				(   485)
+
+#define DIB3000MC_REG_BER_MSB			(   500)
+#define DIB3000MC_REG_BER_LSB			(   501)
+
+#define DIB3000MC_REG_PACKET_ERRORS		(   503)
+
+#define DIB3000MC_REG_PACKET_ERROR_COUNT	(   506)
+
+#define DIB3000MC_REG_LOCK_507			(   507)
+#define DIB3000MC_LOCK_507				(0x0002) // ? name correct ?
+
+#define DIB3000MC_REG_LOCKING			(   509)
+#define DIB3000MC_AGC_LOCK(v)			(v & 0x8000)
+#define DIB3000MC_CARRIER_LOCK(v)		(v & 0x2000)
+#define DIB3000MC_MPEG_SYNC_LOCK(v)		(v & 0x0080)
+#define DIB3000MC_MPEG_DATA_LOCK(v)		(v & 0x0040)
+#define DIB3000MC_TPS_LOCK(v)			(v & 0x0004)
+
+#define DIB3000MC_REG_AS_IRQ			(   511)
+#define DIB3000MC_AS_IRQ_SUCCESS		(1 << 1)
+#define DIB3000MC_AS_IRQ_FAIL			(     1)
+
+#define DIB3000MC_REG_TUNER				(   769)
+
+#define DIB3000MC_REG_RST_I2C_ADDR		(  1024)
+#define DIB3000MC_DEMOD_ADDR_ON			(     1)
+#define DIB3000MC_DEMOD_ADDR(a)			((a << 3) & 0x03F0)
+
+#define DIB3000MC_REG_RESTART			(  1027)
+#define DIB3000MC_RESTART_OFF			(0x0000)
+#define DIB3000MC_RESTART_AGC			(0x0800)
+#define DIB3000MC_RESTART_CONFIG		(0x8000)
+
+#define DIB3000MC_REG_RESTART_VIT		(  1028)
+#define DIB3000MC_RESTART_VIT_OFF		(     0)
+#define DIB3000MC_RESTART_VIT_ON		(     1)
+
+#define DIB3000MC_REG_CLK_CFG_1			(  1031)
+#define DIB3000MC_CLK_CFG_1_POWER_UP	(     0)
+#define DIB3000MC_CLK_CFG_1_POWER_DOWN	(0xffff)
+
+#define DIB3000MC_REG_CLK_CFG_2			(  1032)
+#define DIB3000MC_CLK_CFG_2_PUP_FIXED	(0x012c)
+#define DIB3000MC_CLK_CFG_2_PUP_PORT	(0x0104)
+#define DIB3000MC_CLK_CFG_2_PUP_MOBILE  (0x0000)
+#define DIB3000MC_CLK_CFG_2_POWER_DOWN	(0xffff)
+
+#define DIB3000MC_REG_CLK_CFG_3			(  1033)
+#define DIB3000MC_CLK_CFG_3_POWER_UP	(     0)
+#define DIB3000MC_CLK_CFG_3_POWER_DOWN	(0xfff5)
+
+#define DIB3000MC_REG_CLK_CFG_7			(  1037)
+#define DIB3000MC_CLK_CFG_7_INIT		( 12592)
+#define DIB3000MC_CLK_CFG_7_POWER_UP	(~0x0003)
+#define DIB3000MC_CLK_CFG_7_PWR_DOWN	(0x0003)
+#define DIB3000MC_CLK_CFG_7_DIV_IN_OFF	(1 << 8)
+
+/* was commented out ??? */
+#define DIB3000MC_REG_CLK_CFG_8			(  1038)
+#define DIB3000MC_CLK_CFG_8_POWER_UP	(0x160c)
+
+#define DIB3000MC_REG_CLK_CFG_9			(  1039)
+#define DIB3000MC_CLK_CFG_9_POWER_UP	(     0)
+
+/* also clock ??? */
+#define DIB3000MC_REG_ELEC_OUT			(  1040)
+#define DIB3000MC_ELEC_OUT_HIGH_Z		(     0)
+#define DIB3000MC_ELEC_OUT_DIV_OUT_ON	(     1)
+#define DIB3000MC_ELEC_OUT_SLAVE		(     3)
+
+#endif
diff -uraNwB linux-2.6.10-rc3-bk3/Documentation/dvb/README.dibusb linux-2.6.10-rc3-bk3-p/Documentation/dvb/README.dibusb
--- linux-2.6.10-rc3-bk3/Documentation/dvb/README.dibusb	2004-12-08 14:31:04.000000000 +0100
+++ linux-2.6.10-rc3-bk3-p/Documentation/dvb/README.dibusb	2004-12-08 14:45:05.000000000 +0100
@@ -47,7 +47,7 @@
 Others:
 -------
 - Ultima Electronic/Artec T1 USB TVBOX (AN2135 and AN2235)
-	http://www.arteceuro.com/products-tvbox.html
+	http://82.161.246.249/products-tvbox.html
 
 - Compro Videomate DVB-U2000 - DVB-T USB
 	http://www.comprousa.com/products/vmu2000.htm
@@ -63,6 +63,9 @@
 
 Supported devices USB2.0
 ========================
+- Twinhan MagicBox II
+	http://www.twinhan.com/product_terrestrial_7.asp
+
 - Yakumo DVB-T mobile
 	http://www.yakumo.de/produkte/index.php?pid=1&ag=DVB-T
 
@@ -69,8 +72,14 @@
 - DiBcom USB2.0 DVB-T reference device (non-public)
 
 
-
 0. NEWS:
+  2004-12-06 - possibility for demod i2c-address probing
+             - new usb IDs (Compro,Artec)
+  2004-11-23 - merged changes from DiB3000MC_ver2.1
+             - revised the debugging
+             - possibility to deliver the complete TS for USB2.0
+  2004-11-21 - first working version of the dib3000mc/p frontend driver.
+  2004-11-12 - added additional remote control keys. Thanks to Uwe Hanke.
   2004-11-07 - added remote control support. Thanks to David Matthews.
   2004-11-05 - added support for a new devices (Grandtec/Avermedia/Artec)
              - merged my changes (for dib3000mb/dibusb) to the FE_REFACTORING, because it became HEAD
@@ -165,9 +174,7 @@
 2. Known problems and bugs
 
 TODO:
-- remote control
 - signal-quality and strength calculations
-- i2c address probing
 
 2.1. Adding support for devices 
 
@@ -189,7 +196,29 @@
 the linux-dvb mailing list, _after_ you have tried compiling and modprobing
 it.
 
-2.2. Comments
+2.2. USB1.1 Bandwidth limitation
+
+Most of the current supported devices are USB1.1 and thus they have a 
+maximum bandwidth of about 5-6 MBit/s when connected to a USB2.0 hub. 
+This is not enough for receiving the complete transport stream of a
+DVB-T channel (which can be about 16 MBit/s). Normally this is not a
+problem, if you only want to watch TV, but watching a channel while
+recording another channel on the same frequency simply does not work.
+This applies to all USB1.1 DVB-T devices.
+
+A special problem of the dibusb for the USB1.1 is, that the USB control
+IC has a problem with write accesses while having MPEG2-streaming 
+enabled. When you set another pid while receiving MPEG2-TS it happens, that
+the stream is disturbed and probably data is lost (results in distortions of 
+the video or strange beeps within the audio stream). DiBcom is preparing a 
+firmware especially for Linux which perhaps solves the problem.
+
+Especially VDR users are victoms of this bug. VDR frequently requests new PIDs
+due the automatic scanning (introduced in 1.3.x, afaik) and epg-scan. Disabling
+these features is maybe a solution. Additionally this behaviour of VDR exceeds 
+the USB1.1 bandwidth.
+
+2.3. Comments
 
 Patches, comments and suggestions are very very welcome
 

--------------010609050008070908000501--
