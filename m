Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVAHH6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVAHH6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 02:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVAHH4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 02:56:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:38277 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261850AbVAHFsM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:12 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632601876@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:40 -0800
Message-Id: <11051632602670@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.14, 2004/12/20 16:17:10-08:00, greg@kroah.com

USB: change wTotalLength field in struct usb_config_descriptor to be __le16

Another step in the quest to get all USB data structures to be native
endian.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/mips/au1000/common/usbdev.c |    4 ++--
 drivers/usb/class/audio.c        |    2 +-
 drivers/usb/class/usb-midi.c     |    4 ++--
 drivers/usb/core/config.c        |    2 +-
 drivers/usb/core/devio.c         |    2 +-
 drivers/usb/core/hcd.c           |    4 ++--
 drivers/usb/core/hub.c           |    8 ++++----
 drivers/usb/core/inode.c         |    2 +-
 drivers/usb/host/hc_crisv10.c    |    2 +-
 drivers/usb/misc/usbtest.c       |    5 ++---
 include/linux/usb_ch9.h          |    2 +-
 sound/usb/usbaudio.c             |    7 ++++---
 sound/usb/usbmidi.c              |    2 +-
 13 files changed, 23 insertions(+), 23 deletions(-)


diff -Nru a/arch/mips/au1000/common/usbdev.c b/arch/mips/au1000/common/usbdev.c
--- a/arch/mips/au1000/common/usbdev.c	2005-01-07 15:42:19 -08:00
+++ b/arch/mips/au1000/common/usbdev.c	2005-01-07 15:42:19 -08:00
@@ -766,7 +766,7 @@
 							 dev->conf_desc),
 					    0);
 				} else {
-				int len = dev->conf_desc->wTotalLength;
+				int len = le16_to_cpu(dev->conf_desc->wTotalLength);
 				dbg("sending whole config desc,"
 				    " size=%d, our size=%d", desc_len, len);
 				desc_len = desc_len > len ? len : desc_len;
@@ -1407,7 +1407,7 @@
 	/*
 	 * initialize the full config descriptor
 	 */
-	usbdev.full_conf_desc = fcd = kmalloc(config_desc->wTotalLength,
+	usbdev.full_conf_desc = fcd = kmalloc(le16_to_cpu(config_desc->wTotalLength),
 					      ALLOC_FLAGS);
 	if (!fcd) {
 		err("failed to alloc full config descriptor");
diff -Nru a/drivers/usb/class/audio.c b/drivers/usb/class/audio.c
--- a/drivers/usb/class/audio.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/class/audio.c	2005-01-07 15:42:19 -08:00
@@ -3801,7 +3801,7 @@
 	 * find which configuration number is active
 	 */
 	buffer = dev->rawdescriptors[dev->actconfig - dev->config];
-	buflen = dev->actconfig->desc.wTotalLength;
+	buflen = le16_to_cpu(dev->actconfig->desc.wTotalLength);
 	s = usb_audio_parsecontrol(dev, buffer, buflen, intf->altsetting->desc.bInterfaceNumber);
 	if (s) {
 		usb_set_intfdata (intf, s);
diff -Nru a/drivers/usb/class/usb-midi.c b/drivers/usb/class/usb-midi.c
--- a/drivers/usb/class/usb-midi.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/class/usb-midi.c	2005-01-07 15:42:19 -08:00
@@ -1804,7 +1804,7 @@
 
 	i = d->actconfig - d->config;
 	buffer = d->rawdescriptors[i];
-	bufSize = d->actconfig->desc.wTotalLength;
+	bufSize = le16_to_cpu(d->actconfig->desc.wTotalLength);
 
 	u = parse_descriptor( d, buffer, bufSize, ifnum, alts, 1);
 	if ( u == NULL ) {
@@ -1892,7 +1892,7 @@
 
 	i = d->actconfig - d->config;
 	buffer = d->rawdescriptors[i];
-	bufSize = d->actconfig->desc.wTotalLength;
+	bufSize = le16_to_cpu(d->actconfig->desc.wTotalLength);
 
 	u = parse_descriptor( d, buffer, bufSize, ifnum, alts, 0);
 	if ( u == NULL ) {
diff -Nru a/drivers/usb/core/config.c b/drivers/usb/core/config.c
--- a/drivers/usb/core/config.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/core/config.c	2005-01-07 15:42:19 -08:00
@@ -320,7 +320,7 @@
 
 	}	/* for ((buffer2 = buffer, size2 = size); ...) */
 	size = buffer2 - buffer;
-	config->desc.wTotalLength = buffer2 - buffer0;
+	config->desc.wTotalLength = cpu_to_le16(buffer2 - buffer0);
 
 	if (n != nintf)
 		dev_warn(ddev, "config %d has %d interface%s, different from "
diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/core/devio.c	2005-01-07 15:42:19 -08:00
@@ -148,7 +148,7 @@
 			/* The descriptor may claim to be longer than it
 			 * really is.  Here is the actual allocated length. */
 			unsigned alloclen =
-				dev->config[i].desc.wTotalLength;
+				le16_to_cpu(dev->config[i].desc.wTotalLength);
 
 			len = length - (*ppos - pos);
 			if (len > nbytes)
diff -Nru a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/core/hcd.c	2005-01-07 15:42:19 -08:00
@@ -170,7 +170,7 @@
 	/* one configuration */
 	0x09,       /*  __u8  bLength; */
 	0x02,       /*  __u8  bDescriptorType; Configuration */
-	0x19, 0x00, /*  __u16 wTotalLength; */
+	0x19, 0x00, /*  __le16 wTotalLength; */
 	0x01,       /*  __u8  bNumInterfaces; (1) */
 	0x01,       /*  __u8  bConfigurationValue; */
 	0x00,       /*  __u8  iConfiguration; */
@@ -217,7 +217,7 @@
 	/* one configuration */
 	0x09,       /*  __u8  bLength; */
 	0x02,       /*  __u8  bDescriptorType; Configuration */
-	0x19, 0x00, /*  __u16 wTotalLength; */
+	0x19, 0x00, /*  __le16 wTotalLength; */
 	0x01,       /*  __u8  bNumInterfaces; (1) */
 	0x01,       /*  __u8  bConfigurationValue; */
 	0x00,       /*  __u8  iConfiguration; */
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/core/hub.c	2005-01-07 15:42:19 -08:00
@@ -1189,7 +1189,7 @@
 
 		/* descriptor may appear anywhere in config */
 		if (__usb_get_extra_descriptor (udev->rawdescriptors[0],
-					udev->config[0].desc.wTotalLength,
+					le16_to_cpu(udev->config[0].desc.wTotalLength),
 					USB_DT_OTG, (void **) &desc) == 0) {
 			if (desc->bmAttributes & USB_OTG_HNP) {
 				unsigned		port1;
@@ -2828,8 +2828,8 @@
 	struct usb_config_descriptor	*buf;
 
 	for (index = 0; index < udev->descriptor.bNumConfigurations; index++) {
-		if (len < udev->config[index].desc.wTotalLength)
-			len = udev->config[index].desc.wTotalLength;
+		if (len < le16_to_cpu(udev->config[index].desc.wTotalLength))
+			len = le16_to_cpu(udev->config[index].desc.wTotalLength);
 	}
 	buf = kmalloc (len, SLAB_KERNEL);
 	if (buf == 0) {
@@ -2839,7 +2839,7 @@
 	}
 	for (index = 0; index < udev->descriptor.bNumConfigurations; index++) {
 		int length;
-		int old_length = udev->config[index].desc.wTotalLength;
+		int old_length = le16_to_cpu(udev->config[index].desc.wTotalLength);
 
 		length = usb_get_descriptor(udev, USB_DT_CONFIG, index, buf,
 				old_length);
diff -Nru a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
--- a/drivers/usb/core/inode.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/core/inode.c	2005-01-07 15:42:19 -08:00
@@ -695,7 +695,7 @@
 	for (i = 0; i < dev->descriptor.bNumConfigurations; ++i) {
 		struct usb_config_descriptor *config =
 			(struct usb_config_descriptor *)dev->rawdescriptors[i];
-		i_size += le16_to_cpu ((__force __le16)config->wTotalLength);
+		i_size += le16_to_cpu(config->wTotalLength);
 	}
 	if (dev->usbfs_dentry->d_inode)
 		dev->usbfs_dentry->d_inode->i_size = i_size;
diff -Nru a/drivers/usb/host/hc_crisv10.c b/drivers/usb/host/hc_crisv10.c
--- a/drivers/usb/host/hc_crisv10.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/host/hc_crisv10.c	2005-01-07 15:42:19 -08:00
@@ -136,7 +136,7 @@
 {
 	0x09,  /*  __u8  bLength; */
 	0x02,  /*  __u8  bDescriptorType; Configuration */
-	0x19,  /*  __u16 wTotalLength; */
+	0x19,  /*  __le16 wTotalLength; */
 	0x00,
 	0x01,  /*  __u8  bNumInterfaces; */
 	0x01,  /*  __u8  bConfigurationValue; */
diff -Nru a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c	2005-01-07 15:42:19 -08:00
+++ b/drivers/usb/misc/usbtest.c	2005-01-07 15:42:19 -08:00
@@ -527,10 +527,9 @@
 		return 0;
 	}
 
-	le16_to_cpus (&config->wTotalLength);
-	if (config->wTotalLength == len)		/* read it all */
+	if (le16_to_cpu(config->wTotalLength) == len)		/* read it all */
 		return 1;
-	if (config->wTotalLength >= TBUF_SIZE)		/* max partial read */
+	if (le16_to_cpu(config->wTotalLength) >= TBUF_SIZE)		/* max partial read */
 		return 1;
 	dbg ("bogus config descriptor read size");
 	return 0;
diff -Nru a/include/linux/usb_ch9.h b/include/linux/usb_ch9.h
--- a/include/linux/usb_ch9.h	2005-01-07 15:42:19 -08:00
+++ b/include/linux/usb_ch9.h	2005-01-07 15:42:19 -08:00
@@ -208,7 +208,7 @@
 	__u8  bLength;
 	__u8  bDescriptorType;
 
-	__u16 wTotalLength;
+	__le16 wTotalLength;
 	__u8  bNumInterfaces;
 	__u8  bConfigurationValue;
 	__u8  iConfiguration;
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	2005-01-07 15:42:19 -08:00
+++ b/sound/usb/usbaudio.c	2005-01-07 15:42:19 -08:00
@@ -2933,8 +2933,8 @@
 	struct usb_host_config *config = dev->actconfig;
 	int err;
 
-	if (get_cfg_desc(config)->wTotalLength == EXTIGY_FIRMWARE_SIZE_OLD ||
-	    get_cfg_desc(config)->wTotalLength == EXTIGY_FIRMWARE_SIZE_NEW) {
+	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
+	    le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_NEW) {
 		snd_printdd("sending Extigy boot sequence...\n");
 		/* Send message to force it to reconnect with full interface. */
 		err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev,0),
@@ -2946,7 +2946,8 @@
 		if (err < 0) snd_printdd("error usb_get_descriptor: %d\n", err);
 		err = usb_reset_configuration(dev);
 		if (err < 0) snd_printdd("error usb_reset_configuration: %d\n", err);
-		snd_printdd("extigy_boot: new boot length = %d\n", get_cfg_desc(config)->wTotalLength);
+		snd_printdd("extigy_boot: new boot length = %d\n",
+			    le16_to_cpu(get_cfg_desc(config)->wTotalLength));
 		return -ENODEV; /* quit this anyway */
 	}
 	return 0;
diff -Nru a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
--- a/sound/usb/usbmidi.c	2005-01-07 15:42:19 -08:00
+++ b/sound/usb/usbmidi.c	2005-01-07 15:42:19 -08:00
@@ -59,7 +59,7 @@
 	__u8  bDescriptorType;
 	__u8  bDescriptorSubtype;
 	__u8  bcdMSC[2];
-	__u16 wTotalLength;
+	__le16 wTotalLength;
 } __attribute__ ((packed));
 
 struct usb_ms_endpoint_descriptor {

