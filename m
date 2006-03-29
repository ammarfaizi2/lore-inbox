Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWC2LmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWC2LmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 06:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWC2LmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 06:42:08 -0500
Received: from wproxy.gmail.com ([64.233.184.237]:62663 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbWC2LmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 06:42:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pyPSFkOBe4gx5jyUlx18tT815Mh345FbN0hjhBe+lpg8e3gMWCfB3QPWahHvoK/ge2W/MNm3BPxse/0LZIedDOFyYF7+xjpf7zlvw2y/CzJ78kQnu2gObfVDPt919wPOUGJ/hgM310dITOQ52h08Gc4ztUF7DPQspkxccpELcGU=
Message-ID: <c5e68b660603290342k2d46605bv5eeb4b341585e805@mail.gmail.com>
Date: Wed, 29 Mar 2006 13:42:06 +0200
From: "=?ISO-8859-1?Q?Ole_Andr=E9_Vadla_Ravn=E5s?=" <oleavr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16] rndis_host/cdc_ether: add support for Windows Mobile 5 based devices
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Windows Mobile 5 based devices speak RNDIS but lack the CDC and union
descriptors, and instead provide a couple of ACM descriptors. They
also expect the queries (RNDIS_MSG_QUERY) to have an appended buffer
of the same size as the response is expected to generate passed along
with the request. My understanding is that this is used to pass input
values, or left uninitialized when there is none, and also used for
the device to know what length the host expects. This patch fixes
these two issues and has been reported to work with several WM5 based
devices.

Signed-off-by: Ole Andre Vadla Ravnaas <oleavr@gmail.com>


diff -Nur linux-2.6.16-orig/drivers/usb/net/cdc_ether.c
linux-2.6.16/drivers/usb/net/cdc_ether.c
--- linux-2.6.16-orig/drivers/usb/net/cdc_ether.c	2006-03-20
06:53:29.000000000 +0100
+++ linux-2.6.16/drivers/usb/net/cdc_ether.c	2006-03-29 11:36:31.000000000 +0200
@@ -72,7 +72,8 @@
 	/* this assumes that if there's a non-RNDIS vendor variant
 	 * of cdc-acm, it'll fail RNDIS requests cleanly.
 	 */
-	rndis = (intf->cur_altsetting->desc.bInterfaceProtocol == 0xff);
+	rndis = (intf->cur_altsetting->desc.bInterfaceProtocol == 0xff ||
+		 intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_MISC);

 	memset(info, 0, sizeof *info);
 	info->control = intf;
@@ -172,6 +173,55 @@
 		buf += buf [0];
 	}

+	/* Windows Mobile 5 based RNDIS devices lack the CDC descriptors,
+	 * so to work around this without changing too much of the overall
+	 * logic we fake those headers here. */
+	if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_MISC) {
+		struct usb_cdc_header_desc *h;
+		struct usb_cdc_union_desc *u;
+
+		dev_dbg(&intf->dev, "taking WM5 workaround path\n");
+
+		/* allocate and fill in the missing structures */
+		h = kmalloc(sizeof(struct usb_cdc_header_desc), GFP_KERNEL);
+		if (!h)
+			return -ENOMEM;
+		info->header = h;
+
+		h->bLength = sizeof(struct usb_cdc_header_desc);
+		h->bDescriptorType = USB_DT_CS_INTERFACE;
+		h->bDescriptorSubType = USB_CDC_HEADER_TYPE;
+
+		h->bcdCDC = 0; /* FIXME */
+		
+		u = kmalloc(sizeof(struct usb_cdc_union_desc), GFP_KERNEL);
+		if (!u)
+			return -ENOMEM;
+		info->u = u;
+
+		u->bLength = sizeof(struct usb_cdc_union_desc);
+		u->bDescriptorType = USB_DT_CS_INTERFACE;
+		u->bDescriptorSubType = USB_CDC_UNION_TYPE;
+		
+		u->bMasterInterface0 = 0;
+		u->bSlaveInterface0 = 1;
+
+		/* initialize */
+		info->control = usb_ifnum_to_if(dev->udev,
+					info->u->bMasterInterface0);
+		info->data = usb_ifnum_to_if(dev->udev,
+					info->u->bSlaveInterface0);
+		if (!info->control || !info->data) {
+			dev_dbg(&intf->dev,
+				"master #%u/%p slave #%u/%p\n",
+				info->u->bMasterInterface0,
+				info->control,
+				info->u->bSlaveInterface0,
+				info->data);
+			goto bad_desc;
+		}
+	}
+	
 	if (!info->header || !info->u || (!rndis && !info->ether)) {
 		dev_dbg(&intf->dev, "missing cdc %s%s%sdescriptor\n",
 			info->header ? "" : "header ",
@@ -229,6 +279,15 @@
 	struct cdc_state		*info = (void *) &dev->data;
 	struct usb_driver		*driver = driver_of(intf);

+	/* clean up resources allocated by the Windows Mobile 5 RNDIS workaround */
+	if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_MISC) {
+		if (info->header)
+			kfree(info->header);
+
+		if (info->u)
+			kfree(info->u);
+	}
+
 	/* disconnect master --> disconnect slave */
 	if (intf == info->control && info->data) {
 		/* ensure immediate exit from usbnet_disconnect */
diff -Nur linux-2.6.16-orig/drivers/usb/net/rndis_host.c
linux-2.6.16/drivers/usb/net/rndis_host.c
--- linux-2.6.16-orig/drivers/usb/net/rndis_host.c	2006-03-20
06:53:29.000000000 +0100
+++ linux-2.6.16/drivers/usb/net/rndis_host.c	2006-03-29
11:38:49.000000000 +0200
@@ -410,10 +410,12 @@
 		1 << le32_to_cpu(u.init_c->packet_alignment));

 	/* get designated host ethernet address */
-	memset(u.get, 0, sizeof *u.get);
+	memset(u.get, 0, sizeof *u.get + 48);
 	u.get->msg_type = RNDIS_MSG_QUERY;
-	u.get->msg_len = ccpu2(sizeof *u.get);
+	u.get->msg_len = ccpu2(sizeof *u.get + 48);
 	u.get->oid = OID_802_3_PERMANENT_ADDRESS;
+	u.get->len = ccpu2(48);
+	u.get->offset = ccpu2(20);

 	retval = rndis_command(dev, u.header);
 	if (unlikely(retval < 0)) {
@@ -575,10 +577,14 @@

 /*-------------------------------------------------------------------------*/

+#define WM5_SUB_CLASS 0x01
+#define WM5_PROTOCOL  0x01
+
 static const struct usb_device_id	products [] = {
 {
 	/* RNDIS is MSFT's un-official variant of CDC ACM */
 	USB_INTERFACE_INFO(USB_CLASS_COMM, 2 /* ACM */, 0x0ff),
+	USB_INTERFACE_INFO(USB_CLASS_MISC, WM5_SUB_CLASS, WM5_PROTOCOL),
 	.driver_info = (unsigned long) &rndis_info,
 },
 	{ },		// END
diff -Nur linux-2.6.16-orig/include/linux/usb_ch9.h
linux-2.6.16/include/linux/usb_ch9.h
--- linux-2.6.16-orig/include/linux/usb_ch9.h	2006-03-20
06:53:29.000000000 +0100
+++ linux-2.6.16/include/linux/usb_ch9.h	2006-03-29 11:36:31.000000000 +0200
@@ -217,6 +217,7 @@
 #define USB_CLASS_CONTENT_SEC		0x0d	/* content security */
 #define USB_CLASS_VIDEO			0x0e
 #define USB_CLASS_WIRELESS_CONTROLLER	0xe0
+#define USB_CLASS_MISC			0xef
 #define USB_CLASS_APP_SPEC		0xfe
 #define USB_CLASS_VENDOR_SPEC		0xff
