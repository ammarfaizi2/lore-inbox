Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbTIMJ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTIMJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:56:16 -0400
Received: from [144.139.35.54] ([144.139.35.54]:18817 "EHLO portal.frood.au")
	by vger.kernel.org with ESMTP id S262113AbTIMJ4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:56:10 -0400
Message-ID: <3F62E9B5.10408@bigpond.com>
Date: Sat, 13 Sep 2003 19:56:05 +1000
From: James Harper <james.harper@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix oops from cdc_acm in 2.6.0-test5
Content-Type: multipart/mixed;
 boundary="------------030601030607040002070604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030601030607040002070604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch to 2.6.0-test5 fixes some pointer arithmetic errors in the 
cdc_acm driver which were causing an oops in usb_driver_claim_interface.

works for me!

James


--------------030601030607040002070604
Content-Type: text/plain;
 name="cdc-acm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdc-acm.patch"

--- cdc-acm.c.bak	2003-09-12 22:54:42.000000000 +1000
+++ cdc-acm.c	2003-09-13 00:03:06.000000000 +1000
@@ -139,7 +139,8 @@
 
 struct acm {
 	struct usb_device *dev;				/* the corresponding usb device */
-	struct usb_interface *iface;			/* the interfaces - +0 control +1 data */
+	struct usb_interface *iface_control;		/* the control interface */
+	struct usb_interface *iface_data;		/* the data interface */
 	struct tty_struct *tty;				/* the corresponding tty */
 	struct urb *ctrlurb, *readurb, *writeurb;	/* urbs */
 	struct acm_line line;				/* line coding (bits, stop, parity) */
@@ -167,7 +168,7 @@
 {
 	int retval = usb_control_msg(acm->dev, usb_sndctrlpipe(acm->dev, 0),
 		request, USB_RT_ACM, value,
-		acm->iface[0].altsetting[0].desc.bInterfaceNumber,
+		acm->iface_control->altsetting[0].desc.bInterfaceNumber,
 		buf, len, HZ * 5);
 	dbg("acm_control_msg: rq: 0x%02x val: %#x len: %#x result: %d", request, value, len, retval);
 	return retval < 0 ? retval : 0;
@@ -559,7 +560,6 @@
 		dbg("probing config %d", cfacm->desc.bConfigurationValue);
 
 		for (j = 0; j < cfacm->desc.bNumInterfaces - 1; j++) {
-		    
 			if (usb_interface_claimed(cfacm->interface[j]) ||
 			    usb_interface_claimed(cfacm->interface[j + 1]))
 			continue;
@@ -617,7 +617,8 @@
 			ctrlsize = epctrl->wMaxPacketSize;
 			readsize = epread->wMaxPacketSize;
 			acm->writesize = epwrite->wMaxPacketSize;
-			acm->iface = cfacm->interface[j];
+			acm->iface_control = cfacm->interface[j];
+			acm->iface_data = cfacm->interface[j+1];
 			acm->minor = minor;
 			acm->dev = dev;
 
@@ -673,8 +674,8 @@
 			acm->line.databits = 8;
 			acm_set_line(acm, &acm->line);
 
-			usb_driver_claim_interface(&acm_driver, acm->iface + 0, acm);
-			usb_driver_claim_interface(&acm_driver, acm->iface + 1, acm);
+			usb_driver_claim_interface(&acm_driver, acm->iface_control, acm);
+			usb_driver_claim_interface(&acm_driver, acm->iface_data, acm);
 
 			tty_register_device(acm_tty_driver, minor, &intf->dev);
 
@@ -705,8 +706,8 @@
 
 	kfree(acm->ctrlurb->transfer_buffer);
 
-	usb_driver_release_interface(&acm_driver, acm->iface + 0);
-	usb_driver_release_interface(&acm_driver, acm->iface + 1);
+	usb_driver_release_interface(&acm_driver, acm->iface_control);
+	usb_driver_release_interface(&acm_driver, acm->iface_data);
 
 	if (!acm->used) {
 		tty_unregister_device(acm_tty_driver, acm->minor);

--------------030601030607040002070604--

