Return-Path: <linux-kernel-owner+w=401wt.eu-S932185AbXAPBrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXAPBrR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 20:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbXAPBrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 20:47:17 -0500
Received: from mx1.sierrawireless.com ([204.50.29.40]:31564 "EHLO
	mx1.sierrawireless.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXAPBrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 20:47:16 -0500
X-Greylist: delayed 846 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 20:47:16 EST
Message-ID: <45AC2B68.9060904@sierrawireless.com>
Date: Mon, 15 Jan 2007 17:33:28 -0800
From: Kevin Lloyd <klloyd@sierrawireless.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: gregkh@suse.de
CC: linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, klloyd@sierrawireless.com
Subject: [PATCH 2.6.20-rc3 01/01] usb: Sierra Wireless auto set D0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2007 01:28:19.0363 (UTC) FILETIME=[9A8CDF30:01C7390D]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14938.000
X-TM-AS-Result: No--8.399900-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Kevin Lloyd <linux@sierrawireless.com>

This patch ensures that the device is turned on when inserted into the 
system (which mostly affects the EM5725 and MC5720. It also adds more 
VID/PIDs and matches the N_OUT_URB with the airprime driver.

Signed-off-by: Kevin Lloyd <linux@sierrawireless.com>

---

--- linux-2.6.20-rc5/drivers/usb/serial/sierra.c.orig	2007-01-15 15:17:15.000000000 -0800
+++ linux-2.6.20-rc5/drivers/usb/serial/sierra.c	2007-01-15 15:41:56.000000000 -0800
@@ -14,9 +14,31 @@
   Whom based his on the Keyspan driver by Hugh Blemings <hugh@blemings.org>
 
   History:
+v.1.0.6:
+ klloyd
+ Added more devices and added Vendor Specific USB message to make sure
+ that devices are in D0 state when they start. This is very important for
+ MC5720 and EM5625 modules that go between Windows and Non-Windows 
+ machines.
+v.1.0.5:
+ Greg KH
+ This saves over 30 lines and fixes a warning from sparse and allows
+ debugging to work dynamically like all other usb-serial drivers.
+ klloyd
+ Changed versioning to v.x.y.z
+v.1.04:
+ klloyd
+ Adds significant throughput increase to the Sierra driver (uses multiple
+ urgs for download link). This patch also updates the current sierra.c 
+ driver so that it supports both 3-port Sierra devices and 1-port legacy
+ devices and removes Sierra's references in other related files (Kconfig
+ and airprime.c).
+v.1.03
+ klloyd
+ Adds DTR line control support and impliments urb control.
 */
 
-#define DRIVER_VERSION "v.1.0.5"
+#define DRIVER_VERSION "v.1.0.6"
 #define DRIVER_AUTHOR "Kevin Lloyd <linux@sierrawireless.com>"
 #define DRIVER_DESC "USB Driver for Sierra Wireless USB modems"
 
@@ -31,14 +53,14 @@
 
 
 static struct usb_device_id id_table [] = {
+	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0018) },	/* Sierra Wireless MC5720 */
 	{ USB_DEVICE(0x1199, 0x0020) },	/* Sierra Wireless MC5725 */
-	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0019) },	/* Sierra Wireless AirCard 595 */
-	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0021) },	/* Sierra Wireless AirCard 597E */
 	{ USB_DEVICE(0x1199, 0x6802) },	/* Sierra Wireless MC8755 */
+	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 */
 	{ USB_DEVICE(0x1199, 0x6803) },	/* Sierra Wireless MC8765 */
-	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 for Europe */
 	{ USB_DEVICE(0x1199, 0x6812) },	/* Sierra Wireless MC8775 */
 	{ USB_DEVICE(0x1199, 0x6820) },	/* Sierra Wireless AirCard 875 */
 
@@ -55,14 +77,14 @@ static struct usb_device_id id_table_1po
 };
 
 static struct usb_device_id id_table_3port [] = {
+	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0018) },	/* Sierra Wireless MC5720 */
 	{ USB_DEVICE(0x1199, 0x0020) },	/* Sierra Wireless MC5725 */
-	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0019) },	/* Sierra Wireless AirCard 595 */
-	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0021) },	/* Sierra Wireless AirCard 597E */
 	{ USB_DEVICE(0x1199, 0x6802) },	/* Sierra Wireless MC8755 */
+	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 */
 	{ USB_DEVICE(0x1199, 0x6803) },	/* Sierra Wireless MC8765 */
-	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 for Europe */
 	{ USB_DEVICE(0x1199, 0x6812) },	/* Sierra Wireless MC8775 */
 	{ USB_DEVICE(0x1199, 0x6820) },	/* Sierra Wireless AirCard 875 */
 	{ }
@@ -81,7 +103,7 @@ static int debug;
 
 /* per port private data */
 #define N_IN_URB	4
-#define N_OUT_URB	1
+#define N_OUT_URB	4
 #define IN_BUFLEN	4096
 #define OUT_BUFLEN	128
 
@@ -123,6 +145,7 @@ static int sierra_send_setup(struct usb_
 		return usb_control_msg(serial->dev,
 				usb_rcvctrlpipe(serial->dev, 0),
 				0x22,0x21,val,0,NULL,0,USB_CTRL_SET_TIMEOUT);
+
 	}
 
 	return 0;
@@ -396,6 +419,8 @@ static int sierra_open(struct usb_serial
 	struct usb_serial *serial = port->serial;
 	int i, err;
 	struct urb *urb;
+	int result;
+	__u16 set_mode_dzero = 0x0000; //Set mode to D0
 
 	portdata = usb_get_serial_port_data(port);
 
@@ -442,6 +467,11 @@ static int sierra_open(struct usb_serial
 
 	port->tty->low_latency = 1;
 
+	//set mode to D0
+	result = usb_control_msg(serial->dev,
+			usb_rcvctrlpipe(serial->dev, 0),
+			0x00,0x40,set_mode_dzero,0,NULL,0,USB_CTRL_SET_TIMEOUT);
+
 	sierra_send_setup(port);
 
 	return (0);



