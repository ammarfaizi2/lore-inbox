Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUFNRqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUFNRqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUFNRqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:46:42 -0400
Received: from imap.gmx.net ([213.165.64.20]:60375 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262730AbUFNRqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:46:33 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: William Lee Irwin III <wli@holomorphy.com>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.7-rc3-mm2
Date: Mon, 14 Jun 2004 19:58:25 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20040614021018.789265c4.akpm@osdl.org> <200406141620.01731.dominik.karall@gmx.net> <20040614141942.GF1444@holomorphy.com>
In-Reply-To: <20040614141942.GF1444@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406141958.29040.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 June 2004 16:19, William Lee Irwin III wrote:
> On Monday 14 June 2004 11:10, Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/
> >>2.6 .7-rc3-mm2/
>
> On Mon, Jun 14, 2004 at 04:19:52PM +0200, Dominik Karall wrote:
> > I got following messages on startup of hotplug:
> > usb 3-1: control timeout on ep0in
> > usb 3-1: string descriptor 0 read error: -110
> > usb 3-1: string descriptor 0 read error: -110
>
> By any chance could you do bisection search on the patches in -mm?
>
>
> -- wli

OK, I greped through the usb sources and searched for the message string, so I 
get a match in drivers/usb/core/message.c.
I removed the message.c patch from -mm2 patch and it works now without those 
error messages.

@William
thx for your explanation! :)

This is the patch I removed(!):
-----------------------------------------------------
diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
--- a/drivers/usb/core/message.c	2004-06-14 00:07:35 -07:00
+++ b/drivers/usb/core/message.c	2004-06-14 00:07:35 -07:00
@@ -566,22 +566,19 @@
  */
 int usb_get_descriptor(struct usb_device *dev, unsigned char type, unsigned 
char index, void *buf, int size)
 {
-	int i = 5;
+	int i;
 	int result;
 	
 	memset(buf,0,size);	// Make sure we parse really received data
 
-	while (i--) {
+	for (i = 0; i < 3; ++i) {
 		/* retry on length 0 or stall; some devices are flakey */
-		if ((result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-				    USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-				    (type << 8) + index, 0, buf, size,
-				    HZ * USB_CTRL_GET_TIMEOUT)) > 0
-				|| result != -EPIPE)
+		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+				(type << 8) + index, 0, buf, size,
+				HZ * USB_CTRL_GET_TIMEOUT);
+		if (!(result == 0 || result == -EPIPE))
 			break;
-
-		dev_dbg (&dev->dev, "RETRY descriptor, result %d\n", result);
-		result = -ENOMSG;
 	}
 	return result;
 }
@@ -830,6 +827,7 @@
 			interface = dev->actconfig->interface[i];
 			dev_dbg (&dev->dev, "unregistering interface %s\n",
 				interface->dev.bus_id);
+			usb_remove_sysfs_intf_files(interface);
 			device_del (&interface->dev);
 		}
 
@@ -842,7 +840,7 @@
 		}
 		dev->actconfig = 0;
 		if (dev->state == USB_STATE_CONFIGURED)
-			dev->state = USB_STATE_ADDRESS;
+			usb_set_device_state(dev, USB_STATE_ADDRESS);
 	}
 }
 
@@ -1047,7 +1045,7 @@
 			config->desc.bConfigurationValue, 0,
 			NULL, 0, HZ * USB_CTRL_SET_TIMEOUT);
 	if (retval < 0) {
-		dev->state = USB_STATE_ADDRESS;
+		usb_set_device_state(dev, USB_STATE_ADDRESS);
 		return retval;
 	}
 
@@ -1185,9 +1183,9 @@
 
 	dev->actconfig = cp;
 	if (!cp)
-		dev->state = USB_STATE_ADDRESS;
+		usb_set_device_state(dev, USB_STATE_ADDRESS);
 	else {
-		dev->state = USB_STATE_CONFIGURED;
+		usb_set_device_state(dev, USB_STATE_CONFIGURED);
 
 		/* Initialize the new interface structures and the
 		 * hc/hcd/usbcore interface/endpoint state.
@@ -1322,7 +1320,7 @@
 	 */
 
 	err = usb_get_string(dev, dev->string_langid, index, tbuf, 2);
-	if (err == -EPIPE) {
+	if (err == -EPIPE || err == 0) {
 		dev_dbg(&dev->dev, "RETRY string %d read/%d\n", index, 2);
 		err = usb_get_string(dev, dev->string_langid, index, tbuf, 2);
 	}
@@ -1331,7 +1329,7 @@
 	len=tbuf[0];	
 	
 	err = usb_get_string(dev, dev->string_langid, index, tbuf, len);
-	if (err == -EPIPE) {
+	if (err == -EPIPE || err == 0) {
 		dev_dbg(&dev->dev, "RETRY string %d read/%d\n", index, len);
 		err = usb_get_string(dev, dev->string_langid, index, tbuf, len);
 	}
-----------------------------------------------------

I'm not sure if removing _only_ this patch breaks anything, but it compiled 
for me without problems. Let me now if you need more debugging!

greets dominik
