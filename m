Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTJSPHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJSPHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:07:54 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:169 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261151AbTJSPHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:07:48 -0400
Message-ID: <3F92AA02.3040200@pacbell.net>
Date: Sun, 19 Oct 2003 08:13:06 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Peter Matthias <espi@epost.de>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ACM USB modem on Kernel 2.6.0-test
References: <3F8851A7.3000105@pacbell.net> <3F904B61.3020400@pacbell.net>
In-Reply-To: <3F904B61.3020400@pacbell.net>
Content-Type: multipart/mixed;
 boundary="------------060103000705040604030708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103000705040604030708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>> In fact, here's a patch with that very change.  Does
>>> it make current 2.6.0-test kernels work "out of the box"
>>> again with your USB modems?
>> 
>> Yes, it works with ELSA Microlink USB. Thanks.
> 
> Hmm. Too early. I get either a "acm: probe of 3-3:2.1 failed with error -5"
> but it works or a 
> Unable to handle kernel NULL pointer dereference at virtual address 00000008
>  ...
>  EIP:    0060:[usb_driver_claim_interface+67/112]    Tainted: P
>  ...

Well, the "it works at all (without the sysfs write)" is
what that patch was about -- so it's still a clear win!

But cdc-acm probe() is pretty broken, and I'm told it's
had strange behavior in various other cases for a while,
including some oopsing.  Like this; not a new bug.

Try this cdc-acm patch.  One user reported that it made
oopsing go away, the bogus probe() errors stopped, and
even the /proc/bus/usb/devices listings were finally
right (both interfaces now claimed by cdc_acm).  Plus
it should stop the pointless hotplugging of "cdc_acm"
for Ethernet devices (including MSFT's RNDIS).

- Dave




--------------060103000705040604030708
Content-Type: text/plain;
 name="Diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Diff"

--- 1.50/drivers/usb/class/cdc-acm.c	Sat Aug 23 12:40:13 2003
+++ edited/drivers/usb/class/cdc-acm.c	Sun Oct 19 07:37:15 2003
@@ -1,5 +1,5 @@
 /*
- * acm.c  Version 0.21
+ * acm.c  Version 0.22
  *
  * Copyright (c) 1999 Armin Fuerst	<fuerst@in.tum.de>
  * Copyright (c) 1999 Pavel Machek	<pavel@suse.cz>
@@ -24,6 +24,8 @@
  *	v0.19 - fixed CLOCAL handling (thanks to Richard Shih-Ping Chan)
  *	v0.20 - switched to probing on interface (rather than device) class
  *	v0.21 - revert to probing on device for devices with multiple configs
+ *	v0.22 - probe only the control interface. if usbcore doesn't choose the
+ *		config we want, sysadmin changes bConfigurationValue in sysfs.
  */
 
 /*
@@ -139,7 +141,8 @@
 
 struct acm {
 	struct usb_device *dev;				/* the corresponding usb device */
-	struct usb_interface *iface;			/* the interfaces - +0 control +1 data */
+	struct usb_interface *control;			/* control interface */
+	struct usb_interface *data;			/* data interface */
 	struct tty_struct *tty;				/* the corresponding tty */
 	struct urb *ctrlurb, *readurb, *writeurb;	/* urbs */
 	struct acm_line line;				/* line coding (bits, stop, parity) */
@@ -167,12 +170,15 @@
 {
 	int retval = usb_control_msg(acm->dev, usb_sndctrlpipe(acm->dev, 0),
 		request, USB_RT_ACM, value,
-		acm->iface[0].altsetting[0].desc.bInterfaceNumber,
+		acm->control->altsetting[0].desc.bInterfaceNumber,
 		buf, len, HZ * 5);
 	dbg("acm_control_msg: rq: 0x%02x val: %#x len: %#x result: %d", request, value, len, retval);
 	return retval < 0 ? retval : 0;
 }
 
+/* devices aren't required to support these requests.
+ * the cdc acm descriptor tells whether they do...
+ */
 #define acm_set_control(acm, control)	acm_ctrl_msg(acm, ACM_REQ_SET_CONTROL, control, NULL, 0)
 #define acm_set_line(acm, line)		acm_ctrl_msg(acm, ACM_REQ_SET_LINE, 0, line, sizeof(struct acm_line))
 #define acm_send_break(acm, ms)		acm_ctrl_msg(acm, ACM_REQ_SEND_BREAK, ms, NULL, 0)
@@ -211,7 +217,7 @@
 
 		case ACM_IRQ_NETWORK:
 
-			dbg("%s network", data[0] ? "connected to" : "disconnected from");
+			dbg("%s network", dr->wValue ? "connected to" : "disconnected from");
 			break;
 
 		case ACM_IRQ_LINE_STATE:
@@ -546,17 +552,15 @@
 	struct usb_device *dev;
 	struct acm *acm;
 	struct usb_host_config *cfacm;
+	struct usb_interface *data;
 	struct usb_host_interface *ifcom, *ifdata;
 	struct usb_endpoint_descriptor *epctrl, *epread, *epwrite;
-	int readsize, ctrlsize, minor, i, j;
+	int readsize, ctrlsize, minor, j;
 	unsigned char *buf;
 
 	dev = interface_to_usbdev (intf);
-	for (i = 0; i < dev->descriptor.bNumConfigurations; i++) {
-
-		cfacm = dev->config + i;
 
-		dbg("probing config %d", cfacm->desc.bConfigurationValue);
+		cfacm = dev->actconfig;
 
 		for (j = 0; j < cfacm->desc.bNumInterfaces - 1; j++) {
 		    
@@ -564,19 +568,23 @@
 			    usb_interface_claimed(cfacm->interface[j + 1]))
 			continue;
 
-			ifcom = cfacm->interface[j]->altsetting + 0;
-			ifdata = cfacm->interface[j + 1]->altsetting + 0;
-
-			if (ifdata->desc.bInterfaceClass != 10 || ifdata->desc.bNumEndpoints < 2) {
-				ifcom = cfacm->interface[j + 1]->altsetting + 0;
+			/* We know we're probe()d with the control interface.
+			 * FIXME ACM doesn't guarantee the data interface is
+			 * adjacent to the control interface, or that if one
+			 * is there it's not for call management ... so use
+			 * the cdc union descriptor whenever there is one.
+			 */
+			ifcom = intf->altsetting + 0;
+			if (intf == cfacm->interface[j]) {
+				ifdata = cfacm->interface[j + 1]->altsetting + 0;
+				data = cfacm->interface[j + 1];
+			} else if (intf == cfacm->interface[j + 1]) {
 				ifdata = cfacm->interface[j]->altsetting + 0;
-				if (ifdata->desc.bInterfaceClass != 10 || ifdata->desc.bNumEndpoints < 2)
-					continue;
-			}
+				data = cfacm->interface[j];
+			} else
+				continue;
 
-			if (ifcom->desc.bInterfaceClass != 2 || ifcom->desc.bInterfaceSubClass != 2 ||
-			    ifcom->desc.bInterfaceProtocol < 1 || ifcom->desc.bInterfaceProtocol > 6 ||
-			    ifcom->desc.bNumEndpoints < 1)
+			if (ifdata->desc.bInterfaceClass != 10 || ifdata->desc.bNumEndpoints < 2)
 				continue;
 
 			epctrl = &ifcom->endpoint[0].desc;
@@ -593,15 +601,6 @@
 				epwrite = &ifdata->endpoint[0].desc;
 			}
 
-			/* FIXME don't scan every config. it's either correct
-			 * when we probe(), or some other task must fix this.
-			 */
-			if (dev->actconfig != cfacm) {
-				err("need inactive config #%d",
-					cfacm->desc.bConfigurationValue);
-				return -ENODEV;
-			}
-
 			for (minor = 0; minor < ACM_TTY_MINORS && acm_table[minor]; minor++);
 			if (acm_table[minor]) {
 				err("no more free acm devices");
@@ -617,7 +616,8 @@
 			ctrlsize = epctrl->wMaxPacketSize;
 			readsize = epread->wMaxPacketSize;
 			acm->writesize = epwrite->wMaxPacketSize;
-			acm->iface = cfacm->interface[j];
+			acm->control = intf;
+			acm->data = data;
 			acm->minor = minor;
 			acm->dev = dev;
 
@@ -665,7 +665,7 @@
 				buf += readsize, acm->writesize, acm_write_bulk, acm);
 			acm->writeurb->transfer_flags |= URB_NO_FSBR;
 
-			info("ttyACM%d: USB ACM device", minor);
+			dev_info(&intf->dev, "ttyACM%d: USB ACM device", minor);
 
 			acm_set_control(acm, acm->ctrlout);
 
@@ -673,8 +673,7 @@
 			acm->line.databits = 8;
 			acm_set_line(acm, &acm->line);
 
-			usb_driver_claim_interface(&acm_driver, acm->iface + 0, acm);
-			usb_driver_claim_interface(&acm_driver, acm->iface + 1, acm);
+			usb_driver_claim_interface(&acm_driver, data, acm);
 
 			tty_register_device(acm_tty_driver, minor, &intf->dev);
 
@@ -682,7 +681,6 @@
 			usb_set_intfdata (intf, acm);
 			return 0;
 		}
-	}
 
 	return -EIO;
 }
@@ -705,8 +703,7 @@
 
 	kfree(acm->ctrlurb->transfer_buffer);
 
-	usb_driver_release_interface(&acm_driver, acm->iface + 0);
-	usb_driver_release_interface(&acm_driver, acm->iface + 1);
+	usb_driver_release_interface(&acm_driver, acm->data);
 
 	if (!acm->used) {
 		tty_unregister_device(acm_tty_driver, acm->minor);
@@ -727,8 +724,15 @@
  */
 
 static struct usb_device_id acm_ids[] = {
-	{ USB_DEVICE_INFO(USB_CLASS_COMM, 0, 0) },
-	{ USB_DEVICE_INFO(USB_CLASS_COMM, 2, 0) },
+	/* control interfaces with various AT-command sets */
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 1) },
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 2) },
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 3) },
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 4) },
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 5) },
+	{ USB_INTERFACE_INFO(USB_CLASS_COMM, 2, 6) },
+
+	/* NOTE:  COMM/2/0xff is likely MSFT RNDIS ... NOT a modem!! */
 	{ }
 };
 
@@ -736,7 +740,7 @@
 
 static struct usb_driver acm_driver = {
 	.owner =	THIS_MODULE,
-	.name =		"acm",
+	.name =		"cdc_acm",
 	.probe =	acm_probe,
 	.disconnect =	acm_disconnect,
 	.id_table =	acm_ids,

--------------060103000705040604030708--

