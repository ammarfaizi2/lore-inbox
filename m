Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUBWOya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUBWOya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:54:30 -0500
Received: from ida.rowland.org ([192.131.102.52]:3332 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261900AbUBWOyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:54:22 -0500
Date: Mon, 23 Feb 2004 09:54:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
cc: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.x support for prism2 USB wireless adapter?
In-Reply-To: <40395346.3040300@gadsdon.giointernet.co.uk>
Message-ID: <Pine.LNX.4.44L0.0402230953141.1175-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Robert Gadsdon wrote:

> I had my Linksys prism2 USB wireless adapter (WUSB11 v2.5) working 
> reasonably well with kernel 2.4.23, but with kernel 2.6.3 (and udev 018) 
> I get:
> 
> usb 1-1: new full speed USB device using address 5
> drivers/usb/core/config.c: invalid interface number (1/1)
> usb 1-1: can't read configurations, error -22
> 
> #modprobe prism2_usb     gives:
> prism2usb_init: prism2_usb.o: 0.2.1-pre20 Loaded
> prism2usb_init: dev_info is: prism2_usb
> drivers/usb/core/usb.c: registered new driver prism2_usb
> 
> #lsusb     does not show the device at all...
> 
> Is this still 'work in progress'?

The problem is that the prism2's single interface is number 1, but
according to the USB standard interfaces are supposed to be
numbered starting at 0.  This is a fairly common error among USB devices.
The patch below will cause the kernel to accept the device; please let us
know how it works out.

Alan Stern


===== drivers/usb/core/config.c 1.28 vs edited =====
--- 1.28/drivers/usb/core/config.c	Fri Sep 26 12:37:44 2003
+++ edited/drivers/usb/core/config.c	Tue Dec 16 16:41:44 2003
@@ -8,9 +8,7 @@
 #define USB_MAXALTSETTING		128	/* Hard limit */
 #define USB_MAXENDPOINTS		30	/* Hard limit */
 
-/* these maximums are arbitrary */
-#define USB_MAXCONFIG			8
-#define USB_MAXINTERFACES		32
+#define USB_MAXCONFIG			8	/* Arbitrary limit */
 
 static int usb_parse_endpoint(struct usb_host_endpoint *endpoint, unsigned char *buffer, int size)
 {
@@ -90,7 +88,8 @@
 	kfree(intf);
 }
 
-static int usb_parse_interface(struct usb_host_config *config, unsigned char *buffer, int size)
+static int usb_parse_interface(struct usb_host_config *config,
+		unsigned char *buffer, int size, u8 inums[])
 {
 	unsigned char *buffer0 = buffer;
 	struct usb_interface_descriptor	*d;
@@ -109,8 +108,15 @@
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
 
 		/* Skip to the next interface descriptor */
 		buffer += d->bLength;
@@ -126,7 +132,6 @@
 		return buffer - buffer0;
 	}
 
-	interface = config->interface[inum];
 	asnum = d->bAlternateSetting;
 	if (asnum >= interface->num_altsetting) {
 		warn("invalid alternate setting %d for interface %d",
@@ -210,6 +215,8 @@
 	int numskipped, len;
 	char *begin;
 	int retval;
+	int n;
+	u8 inums[USB_MAXINTERFACES], nalts[USB_MAXINTERFACES];
 
 	memcpy(&config->desc, buffer, USB_DT_CONFIG_SIZE);
 	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
@@ -225,25 +232,14 @@
 		    nintf, USB_MAXINTERFACES);
 		config->desc.bNumInterfaces = nintf = USB_MAXINTERFACES;
 	}
-
-	for (i = 0; i < nintf; ++i) {
-		interface = config->interface[i] =
-		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
-		dbg("kmalloc IF %p, numif %i", interface, i);
-		if (!interface) {
-			err("out of memory");
-			return -ENOMEM;
-		}
-		memset(interface, 0, sizeof(struct usb_interface));
-		interface->dev.release = usb_release_intf;
-		device_initialize(&interface->dev);
-	}
+	if (nintf == 0)
+		warn("no interfaces?");
 
 	/* Go through the descriptors, checking their length and counting the
 	 * number of altsettings for each interface */
+	n = 0;
 	buffer2 = buffer;
 	size2 = size;
-	j = 0;
 	while (size2 >= sizeof(struct usb_descriptor_header)) {
 		header = (struct usb_descriptor_header *) buffer2;
 		if ((header->bLength > size2) || (header->bLength < 2)) {
@@ -253,42 +249,67 @@
 
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
 
 		} else if ((header->bDescriptorType == USB_DT_DEVICE ||
-		    header->bDescriptorType == USB_DT_CONFIG) && j) {
+		    header->bDescriptorType == USB_DT_CONFIG) && buffer2 > buffer) {
 			warn("unexpected descriptor type 0x%X", header->bDescriptorType);
 			return -EINVAL;
 		}
 
-		j = 1;
 		buffer2 += header->bLength;
 		size2 -= header->bLength;
 	}
+	if (n < nintf) {
+		warn("not enough interfaces (%d/%d)", n, nintf);
+		return -EINVAL;
+	}
 
-	/* Allocate the altsetting arrays */
-	for (i = 0; i < config->desc.bNumInterfaces; ++i) {
-		interface = config->interface[i];
+	/* Allocate the interfaces and altsetting arrays */
+	for (i = 0; i < nintf; ++i) {
+		interface = config->interface[i] =
+		    kmalloc(sizeof(struct usb_interface), GFP_KERNEL);
+		dbg("kmalloc IF %p, numif %i", interface, i);
+		if (!interface) {
+			err("out of memory");
+			return -ENOMEM;
+		}
+		memset(interface, 0, sizeof(struct usb_interface));
+		interface->dev.release = usb_release_intf;
+		device_initialize(&interface->dev);
+
+		interface->num_altsetting = nalts[i];
 		if (interface->num_altsetting > USB_MAXALTSETTING) {
 			warn("too many alternate settings for interface %d (%d max %d)\n",
-			    i, interface->num_altsetting, USB_MAXALTSETTING);
-			return -EINVAL;
-		}
-		if (interface->num_altsetting == 0) {
-			warn("no alternate settings for interface %d", i);
+			    inums[i], interface->num_altsetting, USB_MAXALTSETTING);
 			return -EINVAL;
 		}
 
@@ -329,7 +350,7 @@
 
 	/* Parse all the interface/altsetting descriptors */
 	while (size >= sizeof(struct usb_descriptor_header)) {
-		retval = usb_parse_interface(config, buffer, size);
+		retval = usb_parse_interface(config, buffer, size, inums);
 		if (retval < 0)
 			return retval;
 
===== include/linux/usb.h 1.165 vs edited =====
--- 1.165/include/linux/usb.h	Mon Dec  8 12:39:26 2003
+++ edited/include/linux/usb.h	Tue Dec 16 16:49:47 2003
@@ -74,8 +74,8 @@
  * struct usb_interface - what usb device drivers talk to
  * @altsetting: array of interface descriptors, one for each alternate
  * 	setting that may be selected.  Each one includes a set of
- * 	endpoint configurations and will be in numberic order,
- * 	0..num_altsetting.
+ * 	endpoint configurations, and they will be in numeric order:
+ * 	0..num_altsetting-1.
  * @num_altsetting: number of altsettings defined.
  * @act_altsetting: index of current altsetting.  this number is always
  *	less than num_altsetting.  after the device is configured, each
@@ -110,10 +110,8 @@
  * will use them in non-default settings.
  */
 struct usb_interface {
-	/* array of alternate settings for this interface.
-	 * these will be in numeric order, 0..num_altsettting
-	 */
-	struct usb_host_interface *altsetting;
+	struct usb_host_interface *altsetting;	/* array of alternate */
+			/* setting structures for this interface */
 
 	unsigned act_altsetting;	/* active alternate setting */
 	unsigned num_altsetting;	/* number of alternate settings */
@@ -150,8 +148,12 @@
 struct usb_host_config {
 	struct usb_config_descriptor	desc;
 
-	/* the interfaces associated with this configuration
-	 * these will be in numeric order, 0..desc.bNumInterfaces
+	/* The interfaces associated with this configuration.
+	 * There are desc.bNumInterfaces of them, and they are
+	 * *not* guaranteed to be in numeric order.  Even worse,
+	 * some non-compliant devices number the interfaces
+	 * starting with 1, not 0.  To be safe don't index this
+	 * array directly; instead use usb_ifnum_to_if().
 	 */
 	struct usb_interface *interface[USB_MAXINTERFACES];
 

