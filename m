Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263220AbTCNTxF>; Fri, 14 Mar 2003 14:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbTCNTxF>; Fri, 14 Mar 2003 14:53:05 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:2729 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S263220AbTCNTxD>;
	Fri, 14 Mar 2003 14:53:03 -0500
Date: Fri, 14 Mar 2003 23:02:04 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: Greg KH <greg@kroah.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, david-b@pacbell.net
Subject: Re: [2.4] Memleak in drivers/usb/hub.c::usb_reset_device
Message-ID: <20030314200204.GC22018@linuxhacker.ru>
References: <20030312194133.GA27968@linuxhacker.ru> <20030314193718.GC7560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314193718.GC7560@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 14, 2003 at 11:37:19AM -0800, Greg KH wrote:
> >    There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
> >    on error exit path. See the patch.
> >    Found with help of smatch + enhanced unfree script.
> And yes, as David said, there is another kind of error in this area for
> 2.5.  Patches to clean that up would be appreciated.

Ok, I guess something like that should work:

Bye,
    Oleg
===== drivers/usb/core/hub.c 1.57 vs edited =====
--- 1.57/drivers/usb/core/hub.c	Wed Mar  5 18:24:34 2003
+++ edited/drivers/usb/core/hub.c	Fri Mar 14 22:59:45 2003
@@ -1175,7 +1175,7 @@
 int usb_reset_device(struct usb_device *dev)
 {
 	struct usb_device *parent = dev->parent;
-	struct usb_device_descriptor descriptor;
+	struct usb_device_descriptor *descriptor;
 	int i, ret, port = -1;
 
 	if (!parent) {
@@ -1224,17 +1224,24 @@
 	 * If nothing changed, we reprogram the configuration and then
 	 * the alternate settings.
 	 */
-	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, &descriptor,
-			sizeof(descriptor));
-	if (ret < 0)
+	descriptor = kmalloc(sizeof *descriptor, GFP_NOIO);
+	if (!descriptor) {
+		return -ENOMEM;
+	}
+	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, descriptor,
+			sizeof(*descriptor));
+	if (ret < 0) {
+		kfree(descriptor);
 		return ret;
+	}
 
-	le16_to_cpus(&descriptor.bcdUSB);
-	le16_to_cpus(&descriptor.idVendor);
-	le16_to_cpus(&descriptor.idProduct);
-	le16_to_cpus(&descriptor.bcdDevice);
+	le16_to_cpus(&descriptor->bcdUSB);
+	le16_to_cpus(&descriptor->idVendor);
+	le16_to_cpus(&descriptor->idProduct);
+	le16_to_cpus(&descriptor->bcdDevice);
 
-	if (memcmp(&dev->descriptor, &descriptor, sizeof(descriptor))) {
+	if (memcmp(&dev->descriptor, descriptor, sizeof(*descriptor))) {
+		kfree(descriptor);
 		usb_destroy_configuration(dev);
 
 		ret = usb_get_device_descriptor(dev);
@@ -1267,6 +1274,8 @@
 
 		return 1;
 	}
+
+	kfree(descriptor);
 
 	ret = usb_set_configuration(dev, dev->actconfig->desc.bConfigurationValue);
 	if (ret < 0) {
