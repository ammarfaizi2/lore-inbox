Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVAHGTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVAHGTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVAHGTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:19:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:30342 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261942AbVAHFsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:53 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632692510@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <1105163269810@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.46, 2004/12/20 15:00:14-08:00, stern@rowland.harvard.edu

[PATCH] USB: Hub driver: improve error checking and retries [10/13]

Here's another "cleanup" type patch, most of which was written by David
Brownell.  It causes the hub driver to retry a couple of different types
of transfers if they timeout (which seems to help with some flakey
devices), and it adds some error checking for the ep0 maxpacket value sent
by the device.

From: David Brownell <david-b@pacbell.net>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/core/hub.c |   58 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 41 insertions(+), 17 deletions(-)


diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:43:06 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:43:06 -08:00
@@ -240,15 +240,24 @@
 		schedule_delayed_work(&hub->leds, LED_CYCLE_PERIOD);
 }
 
+/* use a short timeout for hub/port status fetches */
+#define	USB_STS_TIMEOUT		1
+#define	USB_STS_RETRIES		5
+
 /*
  * USB 2.0 spec Section 11.24.2.6
  */
 static int get_hub_status(struct usb_device *hdev,
 		struct usb_hub_status *data)
 {
-	return usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
-		USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_HUB, 0, 0,
-		data, sizeof(*data), HZ * USB_CTRL_GET_TIMEOUT);
+	int i, status = -ETIMEDOUT;
+
+	for (i = 0; i < USB_STS_RETRIES && status == -ETIMEDOUT; i++) {
+		status = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
+			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_HUB, 0, 0,
+			data, sizeof(*data), HZ * USB_STS_TIMEOUT);
+	}
+	return status;
 }
 
 /*
@@ -257,9 +266,14 @@
 static int get_port_status(struct usb_device *hdev, int port,
 		struct usb_port_status *data)
 {
-	return usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
-		USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, port,
-		data, sizeof(*data), HZ * USB_CTRL_GET_TIMEOUT);
+	int i, status = -ETIMEDOUT;
+
+	for (i = 0; i < USB_STS_RETRIES && status == -ETIMEDOUT; i++) {
+		status = usb_control_msg(hdev, usb_rcvctrlpipe(hdev, 0),
+			USB_REQ_GET_STATUS, USB_DIR_IN | USB_RT_PORT, 0, port,
+			data, sizeof(*data), HZ * USB_STS_TIMEOUT);
+	}
+	return status;
 }
 
 static void kick_khubd(struct usb_hub *hub)
@@ -2163,6 +2177,7 @@
 	for (i = 0; i < GET_DESCRIPTOR_TRIES; (++i, msleep(100))) {
 		if (USE_NEW_SCHEME(retry_counter)) {
 			struct usb_device_descriptor *buf;
+			int r = 0;
 
 #define GET_DESCRIPTOR_BUFSIZE	64
 			buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
@@ -2176,13 +2191,20 @@
 			 * so that recalcitrant full-speed devices with
 			 * 8- or 16-byte ep0-maxpackets won't slow things
 			 * down tremendously by NAKing the unexpectedly
-			 * early status stage.
+			 * early status stage.  Also, retry on length 0
+			 * or stall; some devices are flakey.
 			 */
-			j = usb_control_msg(udev, usb_rcvaddr0pipe(),
+			for (j = 0; j < 3; ++j) {
+				r = usb_control_msg(udev, usb_rcvaddr0pipe(),
 					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
 					USB_DT_DEVICE << 8, 0,
 					buf, GET_DESCRIPTOR_BUFSIZE,
 					(i ? HZ * USB_CTRL_GET_TIMEOUT : HZ));
+				if (r == 0 || r == -EPIPE)
+					continue;
+				if (r < 0)
+					break;
+			}
 			udev->descriptor.bMaxPacketSize0 =
 					buf->bMaxPacketSize0;
 			kfree(buf);
@@ -2202,7 +2224,7 @@
 			default:
 				dev_err(&udev->dev, "device descriptor "
 						"read/%s, error %d\n",
-						"64", j);
+						"64", r);
 				retval = -EMSGSIZE;
 				continue;
 			}
@@ -2245,14 +2267,16 @@
 	if (retval)
 		goto fail;
 
-	/* Should we verify that the value is valid? */
-	/* (YES!) */
-	if (udev->ep0.desc.wMaxPacketSize
-			!= udev->descriptor.bMaxPacketSize0) {
-		udev->ep0.desc.wMaxPacketSize
-				= udev->descriptor.bMaxPacketSize0;
-		dev_dbg(&udev->dev, "ep0 maxpacket = %d\n",
-				udev->ep0.desc.wMaxPacketSize);
+	i = udev->descriptor.bMaxPacketSize0;
+	if (udev->ep0.desc.wMaxPacketSize != i) {
+		if (udev->speed != USB_SPEED_FULL ||
+				!(i == 8 || i == 16 || i == 32 || i == 64)) {
+			dev_err(&udev->dev, "ep0 maxpacket = %d\n", i);
+			retval = -EMSGSIZE;
+			goto fail;
+		}
+		dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
+		udev->ep0.desc.wMaxPacketSize = i;
 		ep0_reinit(udev);
 	}
   

