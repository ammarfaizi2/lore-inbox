Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUEKO5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUEKO5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbUEKO5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:57:53 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:30966 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264777AbUEKO5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:57:36 -0400
Message-ID: <40A0E906.2090302@pacbell.net>
Date: Tue, 11 May 2004 07:53:58 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [linux-2.6.5] oops when plugging CDC USB network
 device...
References: <Pine.LNX.4.44L0.0405071022221.1035-100000@ida.rowland.org> <27198.1084272848@www53.gmx.net>
In-Reply-To: <27198.1084272848@www53.gmx.net>
Content-Type: multipart/mixed;
 boundary="------------080707030707080605050608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080707030707080605050608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Blueman wrote:
> Alan, David,
> 
> Thanks for your response - the problem observed in linux-2.6.5 is fixed in
> 2.6.6. Now I get a status code of -75 [1] and see no additional networking
> devices.

In drivers/usb/core/message.c::usb_string(), try making the retry
cases consider not just -EPIPE faults but also -EOVERFLOW.  Likewise
in the get_descriptor() logic.  (Some devices seem to have firmware
bugs that cause those failures, and are often amenable to retries.)

Also, this patch should help correct the "missing diagnostics with
CONFIG_USB_DEBUG during CDC Ethernet probe()" issue ... and help
show more precisely where the problem is.

- Dave



--------------080707030707080605050608
Content-Type: text/plain;
 name="usbnet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbnet.patch"

--- linux-2.5/drivers/usb/net/usbnet.c	2004-04-23 19:19:49.000000000 -0700
+++ gadget-2.6/drivers/usb/net/usbnet.c	2004-05-09 13:10:23.000000000 -0700
@@ -107,7 +107,13 @@
  *
  *-------------------------------------------------------------------------*/
 
+// #define	DEBUG			// error path messages, extra info
+// #define	VERBOSE			// more; success messages
+
 #include <linux/config.h>
+#ifdef	CONFIG_USB_DEBUG
+#   define DEBUG
+#endif
 #include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/sched.h>
@@ -120,25 +126,15 @@
 #include <linux/mii.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
-
-
-// #define	DEBUG			// error path messages, extra info
-// #define	VERBOSE			// more; success messages
-#define	REALLY_QUEUE
-
-#if !defined (DEBUG) && defined (CONFIG_USB_DEBUG)
-#   define DEBUG
-#endif
 #include <linux/usb.h>
-
 #include <asm/io.h>
 #include <asm/scatterlist.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 
-
 #define DRIVER_VERSION		"25-Aug-2003"
 
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -148,13 +144,8 @@
  * For high speed, each frame comfortably fits almost 36 max size
  * Ethernet packets (so queues should be bigger).
  */
-#ifdef REALLY_QUEUE
 #define	RX_QLEN(dev) (((dev)->udev->speed == USB_SPEED_HIGH) ? 60 : 4)
 #define	TX_QLEN(dev) (((dev)->udev->speed == USB_SPEED_HIGH) ? 60 : 4)
-#else
-#define	RX_QLEN(dev)		1
-#define	TX_QLEN(dev)		1
-#endif
 
 // packets are always ethernet inside
 // ... except they can be bigger (limit of 64K with NetChip framing)
@@ -1006,7 +997,7 @@
 			if (!info->control || !info->data) {
 				dev_dbg (&intf->dev,
 					"master #%u/%p slave #%u/%p\n",
-					info->u->bMasterInterface0
+					info->u->bMasterInterface0,
 					info->control,
 					info->u->bSlaveInterface0,
 					info->data);
@@ -1142,10 +1133,13 @@
 	unsigned char	buf [13];
 
 	tmp = usb_string (dev->udev, e->iMACAddress, buf, sizeof buf);
-	if (tmp < 0)
+	if (tmp != 12) {
+		dev_dbg (&dev->udev->dev,
+			"bad MAC string %d fetch, %d\n", e->iMACAddress, tmp);
+		if (tmp >= 0)
+			tmp = -EINVAL;
 		return tmp;
-	else if (tmp != 12)
-		return -EINVAL;
+	}
 	for (i = tmp = 0; i < 6; i++, tmp += 2)
 		dev->net->dev_addr [i] =
 			 (nibble (buf [tmp]) << 4) + nibble (buf [tmp + 1]);

--------------080707030707080605050608--

