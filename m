Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVA0X0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVA0X0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVA0XZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:25:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:26766 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261289AbVA0XWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:22:12 -0500
X-Authenticated: #1122255
Message-ID: <41F977D4.7030103@gmx.de>
Date: Fri, 28 Jan 2005 00:23:00 +0100
From: Nico Huber <nico.h@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Logitech Cordeless Desktop Keyboard fails to report class descriptor
Content-Type: multipart/mixed;
 boundary="------------070406030400000401080100"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406030400000401080100
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

The receiver of my Logitech Cordeless Desktop fails to report the 
keyboard's class  descriptor most times I insert the usb-hid module 
since I changed to linux 2.6. The modell of the receiver is C-BD9-DUAL 
REV C.
The request seems not to fail but the count of received characters is zero.

As I said it only fails most times, I worked around making the following 
changes in drivers/usb/input/hid-core.c from linux-2.6.11-rc2:

Following the good example of drivers/usb/core/message.c line 575, I 
initialized the buffer in hid_get_class_descriptor() to zero.
In the loop of hid_get_class_descriptor() not waiting for any result but 
waiting for a result wich is lower the requested size of the class 
descriptor (line 1290).
usb_hid_configure() should not try to parse the expected length but the 
received (line 1653).

attached is a patch to linux-2.6.11-rc2 with these changes

Nico Huber
.

--------------070406030400000401080100
Content-Type: text/plain;
 name="linux-2.6.11-rc2-hid-class-descriptor.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.11-rc2-hid-class-descriptor.patch"

--- a/drivers/usb/input/hid-core.c	2005-01-27 23:59:52.000000000 +0100
+++ b/drivers/usb/input/hid-core.c	2005-01-28 00:06:31.000000000 +0100
@@ -1282,12 +1282,15 @@
 		unsigned char type, void *buf, int size)
 {
 	int result, retries = 4;
+
+	memset(buf,0,size);	// Make sure we parse really received data
+
 	do {
 		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
 				USB_REQ_GET_DESCRIPTOR, USB_RECIP_INTERFACE | USB_DIR_IN,
 				(type << 8), ifnum, buf, size, HZ * USB_CTRL_GET_TIMEOUT);
 		retries--;
-	} while (result < 0 && retries);
+	} while (result < size && retries);
 	return result;
 }
 
@@ -1650,7 +1653,7 @@
 	printk("\n");
 #endif
 
-	if (!(hid = hid_parse_report(rdesc, rsize))) {
+	if (!(hid = hid_parse_report(rdesc, n))) {
 		dbg("parsing report descriptor failed");
 		kfree(rdesc);
 		return NULL;

--------------070406030400000401080100--
