Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUEDQKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUEDQKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUEDQKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:10:06 -0400
Received: from sark.cc.gatech.edu ([130.207.7.23]:13261 "EHLO
	sark.cc.gatech.edu") by vger.kernel.org with ESMTP id S264479AbUEDQJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:09:45 -0400
Date: Tue, 4 May 2004 12:09:43 -0400
From: rm <async@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.x support for prism2 USB wireless adapter?
Message-ID: <20040504160943.GB5811@tokyo.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 
	i modified Alan Stern's original patch that allows usb
interfaces numbered from 1 to work (which was against 2.6.3) to apply
against 2.6.5.
	it seems to work, but i'm suspicious of having to do this:

+		/*interface->dev.release = usb_release_intf;*/
+		/*device_initialize(&interface->dev);*/

	Alan, can you provide an update of the patch for 2.6.5?

	rob

--- drivers/usb/core/config.c.orig	2004-04-03 22:36:14.000000000 -0500
+++ drivers/usb/core/config.c	2004-05-04 10:23:14.000000000 -0400
@@ -87,7 +87,7 @@
 	kfree(intf);
 }
 
-static int usb_parse_interface(struct usb_host_config *config, unsigned char *buffer, int size)
+static int usb_parse_interface(struct usb_host_config *config, unsigned char *buffer, int size, u8 inums[])
 {
 	unsigned char *buffer0 = buffer;
 	struct usb_interface_descriptor	*d;
@@ -106,8 +106,16 @@
 		return -EINVAL;
 	}
 
+	interface = NULL;
 	inum = d->bInterfaceNumber;
-	if (inum >= config->desc.bNumInterfaces) {
+	for (i = 0; i < config->desc.bNumInterfaces; ++i) {
+		if (inums[i] == inum) {
+			interface = config->interface[i];
+			break;
+		}
+	}
+	if (!interface) {
+
 
 		/* Skip to the next interface descriptor */
 		buffer += d->bLength;
@@ -123,7 +131,7 @@
 		return buffer - buffer0;
 	}
 
-	interface = config->interface[inum];
+
 	asnum = d->bAlternateSetting;
 	if (asnum >= interface->num_altsetting) {
 		warn("invalid alternate setting %d for interface %d",
@@ -207,6 +215,8 @@
 	int numskipped, len;
 	char *begin;
 	int retval;
+	int n;
+	u8 inums[USB_MAXINTERFACES], nalts[USB_MAXINTERFACES];
 
 	memcpy(&config->desc, buffer, USB_DT_CONFIG_SIZE);
 	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
@@ -223,22 +233,15 @@
 		config->desc.bNumInterfaces = nintf = USB_MAXINTERFACES;
 	}
 
-	for (i = 0; i < nintf; ++i) {
-		interface = config->interface[i] =
-		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
-		dbg("kmalloc IF %p, numif %i", interface, i);
-		if (!interface) {
-			err("out of memory");
-			return -ENOMEM;
-		}
-		memset(interface, 0, sizeof(struct usb_interface));
-	}
+	if (nintf == 0)
+		warn("no interfaces?");
 
 	/* Go through the descriptors, checking their length and counting the
 	 * number of altsettings for each interface */
+	n = 0; 
 	buffer2 = buffer;
 	size2 = size;
-	j = 0;
+
 	while (size2 >= sizeof(struct usb_descriptor_header)) {
 		header = (struct usb_descriptor_header *) buffer2;
 		if ((header->bLength > size2) || (header->bLength < 2)) {
@@ -248,42 +251,73 @@
 
 		if (header->bDescriptorType == USB_DT_INTERFACE) {
 			struct usb_interface_descriptor *d;
+			int inum; 
 
 			if (header->bLength < USB_DT_INTERFACE_SIZE) {
 				warn("invalid interface descriptor");
 				return -EINVAL;
 			}
 			d = (struct usb_interface_descriptor *) header;
-			i = d->bInterfaceNumber;
-			if (i >= nintf_orig) {
+			inum = d->bInterfaceNumber;
+			if (inum > nintf_orig) {
 				warn("invalid interface number (%d/%d)",
-				    i, nintf_orig);
+				    inum, nintf_orig);
+				return -EINVAL;
+			}
+
+
+			/* Have we already encountered this interface? */
+			for (i = n - 1; i >= 0; --i) {
+				if (inums[i] == inum)
+					break;
+			}
+			if (i >= 0)
+				++nalts[i];
+			else if (n >= nintf_orig) {
+				warn("too many interfaces (> %d)", nintf_orig);
 				return -EINVAL;
+			} else if (n < nintf) {
+				inums[n] = inum;
+				nalts[n] = 1;
+				++n;
 			}
-			if (i < nintf)
-				++config->interface[i]->num_altsetting;
+
+
 
 		} else if ((header->bDescriptorType == USB_DT_DEVICE ||
-		    header->bDescriptorType == USB_DT_CONFIG) && j) {
+			    header->bDescriptorType == USB_DT_CONFIG) && buffer2 > buffer) {
 			warn("unexpected descriptor type 0x%X", header->bDescriptorType);
 			return -EINVAL;
 		}
 
-		j = 1;
+
 		buffer2 += header->bLength;
 		size2 -= header->bLength;
 	}
 
-	/* Allocate the altsetting arrays */
-	for (i = 0; i < config->desc.bNumInterfaces; ++i) {
-		interface = config->interface[i];
-		if (interface->num_altsetting > USB_MAXALTSETTING) {
-			warn("too many alternate settings for interface %d (%d max %d)\n",
-			    i, interface->num_altsetting, USB_MAXALTSETTING);
-			return -EINVAL;
+	if (n < nintf) {
+		warn("not enough interfaces (%d/%d)", n, nintf);
+		return -EINVAL;
+	}
+
+	/* Allocate the interfaces and altsetting arrays */
+	for (i = 0; i < nintf; ++i) {
+		interface = config->interface[i] =
+		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
+		dbg("kmalloc IF %p, numif %i", interface, i);
+		if (!interface) {
+			err("out of memory");
+			return -ENOMEM;
 		}
-		if (interface->num_altsetting == 0) {
-			warn("no alternate settings for interface %d", i);
+		memset(interface, 0, sizeof(struct usb_interface));
+		/*interface->dev.release = usb_release_intf;*/
+		/*device_initialize(&interface->dev);*/
+
+		interface->num_altsetting = nalts[i];
+
+		if (interface->num_altsetting > USB_MAXALTSETTING) {
+		  warn("too many alternate settings for interface %d (%d max %d)\n",
+		       inums[i], interface->num_altsetting, USB_MAXALTSETTING);
 			return -EINVAL;
 		}
 
@@ -324,7 +358,7 @@
 
 	/* Parse all the interface/altsetting descriptors */
 	while (size >= sizeof(struct usb_descriptor_header)) {
-		retval = usb_parse_interface(config, buffer, size);
+		retval = usb_parse_interface(config, buffer, size, inums);
 		if (retval < 0)
 			return retval;
 





----
Robert Melby
Georgia Institute of Technology, Atlanta Georgia, 30332
uucp:     ...!{decvax,hplabs,ncar,purdue,rutgers}!gatech!prism!gt4255a
Internet: async!cc!gatech!edu!...
