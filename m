Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUEIXBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUEIXBi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 19:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUEIXBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 19:01:38 -0400
Received: from mx.ticino.com ([195.190.166.60]:45838 "EHLO mail.ticino.com")
	by vger.kernel.org with ESMTP id S264419AbUEIXBc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 19:01:32 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Papik Meli <papik78@yahoo.it>
Reply-To: papik78@yahoo.it
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USB (invalid interface number error) kernel 2.6.5
Date: Mon, 10 May 2004 01:01:24 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200405100101.24265.papik78@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is the first time I post to this list, so please excuse any 
mistake...

Until kernel 2.6.3 there was a patch that permitted to use some USB
whose first interface number is 1 instead of 0. But with kernel 2.6.5
the patch didn't work anymore. So I "ported" the patch in the new kernel.

Disclaimer:
I never coded anything in the kernel and I've never seen any USB
specification, but now my usb mouse works ;), I hope someone
could say if I did the right things...

I'm not subscribed to the list so please CC me: papik (at) ticino (dot) com

-Papik


Here is the patch:
--- linux-2.6.5/drivers/usb/core/config.c	2004-04-16 15:29:58.000000000 +0200
+++ edited/drivers/usb/core/config.c	2004-05-10 00:37:50.205602696 +0200
@@ -87,11 +87,11 @@
 	kfree(intf);
 }
 
-static int usb_parse_interface(struct usb_host_config *config, unsigned char *buffer, int size)
+static int usb_parse_interface(struct usb_host_config *config, unsigned char *buffer, int size, int inums[])
 {
 	unsigned char *buffer0 = buffer;
 	struct usb_interface_descriptor	*d;
-	int inum, asnum;
+	int inum, intfindx, asnum;
 	struct usb_interface *interface;
 	struct usb_host_interface *ifp;
 	int len, numskipped;
@@ -107,7 +107,14 @@
 	}
 
 	inum = d->bInterfaceNumber;
-	if (inum >= config->desc.bNumInterfaces) {
+
+	/* find in inums the index of inum */
+	for (intfindx=0; intfindx < config->desc.bNumInterfaces; ++intfindx)
+	{
+		if (inums[intfindx] == inum)
+			break;
+	}
+	if (intfindx >= config->desc.bNumInterfaces) {
 
 		/* Skip to the next interface descriptor */
 		buffer += d->bLength;
@@ -123,7 +130,7 @@
 		return buffer - buffer0;
 	}
 
-	interface = config->interface[inum];
+	interface = config->interface[intfindx];
 	asnum = d->bAlternateSetting;
 	if (asnum >= interface->num_altsetting) {
 		warn("invalid alternate setting %d for interface %d",
@@ -199,7 +206,8 @@
 int usb_parse_configuration(struct usb_host_config *config, char *buffer, int size)
 {
 	int nintf, nintf_orig;
-	int i, j;
+	int i, j, n;
+	int inum, inums[USB_MAXINTERFACES];
 	struct usb_interface *interface;
 	char *buffer2;
 	int size2;
@@ -223,6 +231,7 @@
 		config->desc.bNumInterfaces = nintf = USB_MAXINTERFACES;
 	}
 
+	/* Alloc  and clear memory for interfaces */
 	for (i = 0; i < nintf; ++i) {
 		interface = config->interface[i] =
 		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
@@ -238,6 +247,7 @@
 	 * number of altsettings for each interface */
 	buffer2 = buffer;
 	size2 = size;
+	i = 0; /* Interface number counter */
 	j = 0;
 	while (size2 >= sizeof(struct usb_descriptor_header)) {
 		header = (struct usb_descriptor_header *) buffer2;
@@ -254,14 +264,26 @@
 				return -EINVAL;
 			}
 			d = (struct usb_interface_descriptor *) header;
-			i = d->bInterfaceNumber;
-			if (i >= nintf_orig) {
-				warn("invalid interface number (%d/%d)",
-				    i, nintf_orig);
+			inum = d->bInterfaceNumber;
+			/* Interface already encountered ? */
+			for (n = i-1; n >=0; --n)
+				if (inums[n] == inum)
+					break;
+			if (n < 0)
+			{
+				n = i;
+				inums[n]=inum;
+				++i;
+			}
+			if (n >= nintf_orig) {
+				warn("too many interfaces(%d/%d)",
+				    n, nintf_orig);
 				return -EINVAL;
 			}
-			if (i < nintf)
-				++config->interface[i]->num_altsetting;
+			if (n < nintf)
+			{
+				++config->interface[n]->num_altsetting;
+			}
 
 		} else if ((header->bDescriptorType == USB_DT_DEVICE ||
 		    header->bDescriptorType == USB_DT_CONFIG) && j) {
@@ -279,11 +301,11 @@
 		interface = config->interface[i];
 		if (interface->num_altsetting > USB_MAXALTSETTING) {
 			warn("too many alternate settings for interface %d (%d max %d)\n",
-			    i, interface->num_altsetting, USB_MAXALTSETTING);
+			    inums[i], interface->num_altsetting, USB_MAXALTSETTING);
 			return -EINVAL;
 		}
 		if (interface->num_altsetting == 0) {
-			warn("no alternate settings for interface %d", i);
+			warn("no alternate settings for interface %d", inums[i]);
 			return -EINVAL;
 		}
 
@@ -324,7 +346,7 @@
 
 	/* Parse all the interface/altsetting descriptors */
 	while (size >= sizeof(struct usb_descriptor_header)) {
-		retval = usb_parse_interface(config, buffer, size);
+		retval = usb_parse_interface(config, buffer, size, inums);
 		if (retval < 0)
 			return retval;
 
@@ -337,7 +359,7 @@
 		interface = config->interface[i];
 		for (j = 0; j < interface->num_altsetting; ++j) {
 			if (!interface->altsetting[j].desc.bLength) {
-				warn("missing altsetting %d for interface %d", j, i);
+				warn("missing altsetting %d for interface %d", j, inums[i]);
 				return -EINVAL;
 			}
 		}
-------------------- End of patch -----------------
