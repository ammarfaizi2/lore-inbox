Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVCVCME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVCVCME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVCVCLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:11:24 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:3979 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262320AbVCVBfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:04 -0500
Message-Id: <20050322013456.199428000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:47 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibcom-debug.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 14/48] dibusb: debug changes
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o use own err,info,warn defines, driver description
o remove warning about firmware bug
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-dvb.c |   13 +++++--------
 dvb-dibusb-pid.c |    4 ++--
 dvb-dibusb-usb.c |    6 ------
 dvb-dibusb.h     |   11 +++++++----
 4 files changed, 14 insertions(+), 20 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb.h	2005-03-22 00:15:37.000000000 +0100
@@ -44,7 +44,7 @@ extern int dvb_dibusb_debug;
 
 /* Version information */
 #define DRIVER_VERSION "0.3"
-#define DRIVER_DESC "Driver for DiBcom based USB Budget DVB-T device"
+#define DRIVER_DESC "DiBcom based USB Budget DVB-T device"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
 #define deb_info(args...) dprintk(0x01,args)
@@ -55,9 +55,12 @@ extern int dvb_dibusb_debug;
 #define deb_rc(args...)   dprintk(0x20,args)
 
 /* generic log methods - taken from usb.h */
-#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
-#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
-#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
+#undef err
+#define err(format, arg...)  printk(KERN_ERR     "dvb-dibusb: " format "\n" , ## arg)
+#undef info
+#define info(format, arg...) printk(KERN_INFO    "dvb-dibusb: " format "\n" , ## arg)
+#undef warn
+#define warn(format, arg...) printk(KERN_WARNING "dvb-dibusb: " format "\n" , ## arg)
 
 struct dibusb_usb_controller {
 	const char *name;       /* name of the usb controller */
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-pid.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-pid.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-pid.c	2005-03-22 00:15:37.000000000 +0100
@@ -67,13 +67,13 @@ int dibusb_ctrl_pid(struct usb_dibusb *d
 		if (dib->xfer_ops.pid_ctrl != NULL) 
 			dib->xfer_ops.pid_ctrl(dib->fe,dpid->index,0,0);
 		
+		ret = dpid->index;
 		dpid->pid = 0;
 		dpid->active = 0;
-		ret = dpid->index;
 	}
 	
 	/* a free pid from the list */
-	deb_info("setting pid: %5d %04x at index %d '%s'\n",pid,pid,ret,onoff ? "on" : "off");
+	deb_xfer("setting pid: %5d %04x at index %d '%s'\n",pid,pid,ret,onoff ? "on" : "off");
 
 	return ret;
 }
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:14:35.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:15:37.000000000 +0100
@@ -25,12 +25,6 @@ int dibusb_readwrite_usb(struct usb_dibu
 	if ((ret = down_interruptible(&dib->usb_sem)))
 		return ret;
 
-	if (dib->feedcount &&
-		wbuf[0] == DIBUSB_REQ_I2C_WRITE &&
-		dib->dibdev->dev_cl->id == DIBUSB1_1)
-		deb_err("BUG: writing to i2c, while TS-streaming destroys the stream."
-				"(%x reg: %x %x)\n", wbuf[0],wbuf[2],wbuf[3]);
-
 	debug_dump(wbuf,wlen);
 
 	ret = usb_bulk_msg(dib->udev,usb_sndbulkpipe(dib->udev,
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-dvb.c	2005-03-22 00:15:37.000000000 +0100
@@ -28,7 +28,7 @@ void dibusb_urb_complete(struct urb *urb
 			urb->actual_length);
 
 	urb_compl_count++;
-	if (urb_compl_count % 500 == 0)
+	if (urb_compl_count % 1000 == 0)
 		deb_info("%d urbs completed so far.\n",urb_compl_count);
 
 	switch (urb->status) {
@@ -40,7 +40,8 @@ void dibusb_urb_complete(struct urb *urb
 		case -ESHUTDOWN:
 			return;
 		default:        /* error */
-			warn("urb completition error %d.", urb->status);
+			deb_ts("urb completition error %d.", urb->status);
+			break;
 	}
 
 	if (dib->feedcount > 0) {
@@ -77,7 +78,6 @@ static int dibusb_ctrl_feed(struct dvb_d
 	/* 
 	 * stop feed before setting a new pid if there will be no pid anymore 
 	 */
-//	if ((dib->dibdev->parm->firmware_bug && dib->feedcount) || 
 	if (newfeedcount == 0) {
 		deb_ts("stop feeding\n");
 		if (dib->xfer_ops.fifo_ctrl != NULL) {
@@ -97,12 +97,9 @@ static int dibusb_ctrl_feed(struct dvb_d
 		dibusb_ctrl_pid(dib,dvbdmxfeed,onoff);
 
 	/* 
-	 * start the feed, either if there is the firmware bug or 
-	 * if this was the first pid to set and there is still a pid for 
-	 * reception.
+	 * start the feed if this was the first pid to set and there is still a pid
+	 * for reception.
 	 */
-	
-//	if ((dib->dibdev->parm->firmware_bug)
 	if (dib->feedcount == onoff && dib->feedcount > 0) {
 
 		deb_ts("controlling pid parser\n");

--

