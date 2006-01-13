Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWAMIsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWAMIsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWAMIsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:48:36 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:17892 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030304AbWAMIsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:48:35 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 05/13] USBATM: xusbatm rewrite
Date: Fri, 13 Jan 2006 09:48:36 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kl2xDM8HpBRqMKZ"
Message-Id: <200601130948.36673.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_kl2xDM8HpBRqMKZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The xusbatm driver is for otherwise unsupported modems.
All it does is grab hold of a user-specified set of
interfaces - the generic usbatm core methods (hopefully)
do the rest.  As Aurelio Arroyo discovered when he tried
to use xusbatm (big mistake!), the interface grabbing logic
was completely borked.  Here is a rewrite that works.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_kl2xDM8HpBRqMKZ
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="05-xusbatm"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="05-xusbatm"

Index: Linux/drivers/usb/atm/xusbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/xusbatm.c	2006-01-13 08:48:09.000000000 +0100
+++ Linux/drivers/usb/atm/xusbatm.c	2006-01-13 08:57:07.000000000 +0100
@@ -41,6 +41,8 @@
 XUSBATM_PARM(tx_endpoint, unsigned char, byte, "tx endpoint number");
 XUSBATM_PARM(rx_padding, unsigned char, byte, "rx padding (default 0)");
 XUSBATM_PARM(tx_padding, unsigned char, byte, "tx padding (default 0)");
+XUSBATM_PARM(rx_altsetting, unsigned char, byte, "rx altsetting (default 0)");
+XUSBATM_PARM(tx_altsetting, unsigned char, byte, "rx altsetting (default 0)");
 
 static const char xusbatm_driver_name[] = "xusbatm";
 
@@ -48,61 +50,94 @@
 static struct usb_device_id xusbatm_usb_ids[XUSBATM_DRIVERS_MAX + 1];
 static struct usb_driver xusbatm_usb_driver;
 
-static int usb_intf_has_ep(const struct usb_interface *intf, u8 ep)
+static struct usb_interface *xusbatm_find_intf (struct usb_device *usb_dev, int altsetting, u8 ep)
 {
+	struct usb_host_interface *alt;
+	struct usb_interface *intf;
 	int i, j;
 
-	for (i = 0; i < intf->num_altsetting; i++) {
-		struct usb_host_interface *alt = intf->altsetting;
-		for (j = 0; j < alt->desc.bNumEndpoints; j++)
-			if ((alt->endpoint[i].desc.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK) == ep)
-				return 1;
+	for(i = 0; i < usb_dev->actconfig->desc.bNumInterfaces; i++)
+		if ((intf = usb_dev->actconfig->interface[i]) && (alt = usb_altnum_to_altsetting(intf, altsetting)))
+			for (j = 0; j < alt->desc.bNumEndpoints; j++)
+				if (alt->endpoint[j].desc.bEndpointAddress == ep)
+					return intf;
+	return NULL;
+}
+
+static int xusbatm_capture_intf (struct usbatm_data *usbatm, struct usb_device *usb_dev,
+		struct usb_interface *intf, int altsetting, int claim)
+{
+	int ifnum = intf->altsetting->desc.bInterfaceNumber;
+	int ret;
+
+	if (claim && (ret = usb_driver_claim_interface(&xusbatm_usb_driver, intf, usbatm))) {
+		usb_err(usbatm, "%s: failed to claim interface %2d (%d)!\n", __func__, ifnum, ret);
+		return ret;
+	}
+	if ((ret = usb_set_interface(usb_dev, ifnum, altsetting))) {
+		usb_err(usbatm, "%s: altsetting %2d for interface %2d failed (%d)!\n", __func__, altsetting, ifnum, ret);
+		return ret;
 	}
 	return 0;
 }
 
+static void xusbatm_release_intf (struct usb_device *usb_dev, struct usb_interface *intf, int claimed)
+{
+	if (claimed) {
+		usb_set_intfdata(intf, NULL);
+		usb_driver_release_interface(&xusbatm_usb_driver, intf);
+	}
+}
+
 static int xusbatm_bind(struct usbatm_data *usbatm,
 			struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	int drv_ix = id - xusbatm_usb_ids;
-	int rx_ep_present = usb_intf_has_ep(intf, rx_endpoint[drv_ix]);
-	int tx_ep_present = usb_intf_has_ep(intf, tx_endpoint[drv_ix]);
-	u8 searched_ep = rx_ep_present ? tx_endpoint[drv_ix] : rx_endpoint[drv_ix];
-	int i, ret;
+	int rx_alt = rx_altsetting[drv_ix];
+	int tx_alt = tx_altsetting[drv_ix];
+	struct usb_interface *rx_intf = xusbatm_find_intf(usb_dev, rx_alt, rx_endpoint[drv_ix]);
+	struct usb_interface *tx_intf = xusbatm_find_intf(usb_dev, tx_alt, tx_endpoint[drv_ix]);
+	int ret;
 
 	usb_dbg(usbatm, "%s: binding driver %d: vendor %04x product %04x"
-		" rx: ep %02x padd %d tx: ep %02x padd %d\n",
+		" rx: ep %02x padd %d alt %2d tx: ep %02x padd %d alt %2d\n",
 		__func__, drv_ix, vendor[drv_ix], product[drv_ix],
-		rx_endpoint[drv_ix], rx_padding[drv_ix],
-		tx_endpoint[drv_ix], tx_padding[drv_ix]);
+		rx_endpoint[drv_ix], rx_padding[drv_ix], rx_alt,
+		tx_endpoint[drv_ix], tx_padding[drv_ix], tx_alt);
 
-	if (!rx_ep_present && !tx_ep_present) {
-		usb_dbg(usbatm, "%s: intf #%d has neither rx (%#x) nor tx (%#x) endpoint\n",
-			__func__, intf->altsetting->desc.bInterfaceNumber,
-			rx_endpoint[drv_ix], tx_endpoint[drv_ix]);
+	if (!rx_intf || !tx_intf) {
+		if (!rx_intf)
+			usb_dbg(usbatm, "%s: no interface contains endpoint %02x in altsetting %2d\n",
+				__func__, rx_endpoint[drv_ix], rx_alt);
+		if (!tx_intf)
+			usb_dbg(usbatm, "%s: no interface contains endpoint %02x in altsetting %2d\n",
+				__func__, tx_endpoint[drv_ix], tx_alt);
 		return -ENODEV;
 	}
 
-	if (rx_ep_present && tx_ep_present)
-		return 0;
+	if ((rx_intf != intf) && (tx_intf != intf))
+		return -ENODEV;
 
-	for(i = 0; i < usb_dev->actconfig->desc.bNumInterfaces; i++) {
-		struct usb_interface *cur_if = usb_dev->actconfig->interface[i];
+	if ((rx_intf == tx_intf) && (rx_alt != tx_alt)) {
+		usb_err(usbatm, "%s: altsettings clash on interface %2d (%2d vs %2d)!\n", __func__,
+				rx_intf->altsetting->desc.bInterfaceNumber, rx_alt, tx_alt);
+		return -EINVAL;
+	}
 
-		if (cur_if != intf && usb_intf_has_ep(cur_if, searched_ep)) {
-			ret = usb_driver_claim_interface(&xusbatm_usb_driver,
-							 cur_if, usbatm);
-			if (!ret)
-				usb_err(usbatm, "%s: failed to claim interface #%d (%d)\n",
-					__func__, cur_if->altsetting->desc.bInterfaceNumber, ret);
-			return ret;
-		}
+	usb_dbg(usbatm, "%s: rx If#=%2d; tx If#=%2d\n", __func__,
+			rx_intf->altsetting->desc.bInterfaceNumber,
+			tx_intf->altsetting->desc.bInterfaceNumber);
+
+	if ((ret = xusbatm_capture_intf(usbatm, usb_dev, rx_intf, rx_alt, rx_intf != intf)))
+		return ret;
+
+	if ((tx_intf != rx_intf) && (ret = xusbatm_capture_intf(usbatm, usb_dev, tx_intf, tx_alt, tx_intf != intf))) {
+		xusbatm_release_intf(usb_dev, rx_intf, rx_intf != intf);
+		return ret;
 	}
 
-	usb_err(usbatm, "%s: no interface has endpoint %#x\n",
-		__func__, searched_ep);
-	return -ENODEV;
+	return 0;
 }
 
 static void xusbatm_unbind(struct usbatm_data *usbatm,
@@ -114,9 +149,12 @@
 	usb_dbg(usbatm, "%s entered\n", __func__);
 
 	for(i = 0; i < usb_dev->actconfig->desc.bNumInterfaces; i++) {
-		struct usb_interface *cur_if = usb_dev->actconfig->interface[i];
-		usb_set_intfdata(cur_if, NULL);
-		usb_driver_release_interface(&xusbatm_usb_driver, cur_if);
+		struct usb_interface *cur_intf = usb_dev->actconfig->interface[i];
+
+		if (cur_intf && (usb_get_intfdata(cur_intf) == usbatm)) {
+			usb_set_intfdata(cur_intf, NULL);
+			usb_driver_release_interface(&xusbatm_usb_driver, cur_intf);
+		}
 	}
 }
 
@@ -161,11 +199,13 @@
 	}
 
 	for (i = 0; i < num_vendor; i++) {
+		rx_endpoint[i] |= USB_DIR_IN;
+		tx_endpoint[i] &= USB_ENDPOINT_NUMBER_MASK;
+
 		xusbatm_usb_ids[i].match_flags	= USB_DEVICE_ID_MATCH_DEVICE;
 		xusbatm_usb_ids[i].idVendor	= vendor[i];
 		xusbatm_usb_ids[i].idProduct	= product[i];
 
-
 		xusbatm_drivers[i].driver_name	= xusbatm_driver_name;
 		xusbatm_drivers[i].bind		= xusbatm_bind;
 		xusbatm_drivers[i].unbind	= xusbatm_unbind;

--Boundary-00=_kl2xDM8HpBRqMKZ--
