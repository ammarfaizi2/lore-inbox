Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbVKQBxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbVKQBxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 20:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbVKQBxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 20:53:48 -0500
Received: from pop-gadwall.atl.sa.earthlink.net ([207.69.195.61]:37615 "EHLO
	pop-gadwall.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1161076AbVKQBxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 20:53:47 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: advansys & zd1201
Message-Id: <E1EcYy3-0005kG-HK@penngrove.fdns.net>
Date: Wed, 16 Nov 2005 17:53:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, i've narrowed down where the changes occured.  RThe 'advansys' driver
started working with 2.6.14-rc1, which is also when the MESH slab errors 
came back.

'zd1201' started hanging for me with 2.6.12-rc4.  This happens both on a
PowerMac 8500/G3 and a VAIO R505 laptop.  Alas, the relevant incremental
patch doesn't show anything interesting.  When it hangs, the symptoms are
that 'ifconfig wlan0' shows 'RX packets' as slowly increasing but running
'ping' to that subnet doesn't change 'TX packets'.  I've tried recent
system in hopes that someone had fixed it, but 2.6.15-rc1, 2.6.14-mm1 and
2.6.14-git12 don't seem to help.  I haven't tried instrumenting the driver
yet and any clues on how to debug this would be appreciated.  It typically
takes at least an hour for the failure to occur, alas.

So i'm still looking for a system which will reliably run both 'advansys' 
and 'zd1201' drivers.
			      -- JM

-------------------------------------------------------------------------------
diff -urN linux-2.6.12-rc3/drivers/usb/net/zd1201.c linux-2.6.12-rc4/drivers/usb/net/zd1201.c
--- linux-2.6.12-rc3/drivers/usb/net/zd1201.c	2005-05-06 22:59:19.697465677 -0700
+++ linux-2.6.12-rc4/drivers/usb/net/zd1201.c	2005-05-06 22:59:26.580765388 -0700
@@ -45,7 +45,7 @@
 MODULE_DEVICE_TABLE(usb, zd1201_table);
 
 
-int zd1201_fw_upload(struct usb_device *dev, int apfw)
+static int zd1201_fw_upload(struct usb_device *dev, int apfw)
 {
 	const struct firmware *fw_entry;
 	char* data;
@@ -111,7 +111,7 @@
 	return err;
 }
 
-void zd1201_usbfree(struct urb *urb, struct pt_regs *regs)
+static void zd1201_usbfree(struct urb *urb, struct pt_regs *regs)
 {
 	struct zd1201 *zd = urb->context;
 
@@ -142,7 +142,8 @@
 
 	total: 4 + 2 + 2 + 2 + 2 + 4 = 16
 */
-int zd1201_docmd(struct zd1201 *zd, int cmd, int parm0, int parm1, int parm2)
+static int zd1201_docmd(struct zd1201 *zd, int cmd, int parm0,
+			int parm1, int parm2)
 {
 	unsigned char *command;
 	int ret;
@@ -175,15 +176,15 @@
 }
 
 /* Callback after sending out a packet */
-void zd1201_usbtx(struct urb *urb, struct pt_regs *regs)
+static void zd1201_usbtx(struct urb *urb, struct pt_regs *regs)
 {
 	struct zd1201 *zd = urb->context;
 	netif_wake_queue(zd->dev);
 	return;
 }
 
-/* Incomming data */
-void zd1201_usbrx(struct urb *urb, struct pt_regs *regs)
+/* Incoming data */
+static void zd1201_usbrx(struct urb *urb, struct pt_regs *regs)
 {
 	struct zd1201 *zd = urb->context;
 	int free = 0;
@@ -613,7 +614,7 @@
 	return (zd1201_setconfig(zd, rid, &zdval, sizeof(__le16), 1));
 }
 
-int zd1201_drvr_start(struct zd1201 *zd)
+static int zd1201_drvr_start(struct zd1201 *zd)
 {
 	int err, i;
 	short max;
@@ -771,7 +772,7 @@
 /*
 	RFC 1042 encapsulates Ethernet frames in 802.11 frames
 	by prefixing them with 0xaa, 0xaa, 0x03) followed by a SNAP OID of 0
-	(0x00, 0x00, 0x00). Zd requires an additionnal padding, copy
+	(0x00, 0x00, 0x00). Zd requires an additional padding, copy
 	of ethernet addresses, length of the standard RFC 1042 packet
 	and a command byte (which is nul for tx).
 	
@@ -1097,7 +1098,7 @@
 
 /*	Little bit of magic here: we only get the quality if we poll
  *	for it, and we never get an actual request to trigger such
- *	a poll. Therefore we 'asume' that the user will soon ask for
+ *	a poll. Therefore we 'assume' that the user will soon ask for
  *	the stats after asking the bssid.
  */
 static int zd1201_get_wap(struct net_device *dev,
@@ -1107,7 +1108,7 @@
 	unsigned char buffer[6];
 
 	if (!zd1201_getconfig(zd, ZD1201_RID_COMMSQUALITY, buffer, 6)) {
-		/* Unfortunatly the quality and noise reported is useless.
+		/* Unfortunately the quality and noise reported is useless.
 		   they seem to be accumulators that increase until you
 		   read them, unless we poll on a fixed interval we can't
 		   use them
@@ -1739,7 +1740,8 @@
 	.private_args 		= (struct iw_priv_args *) zd1201_private_args,
 };
 
-int zd1201_probe(struct usb_interface *interface, const struct usb_device_id *id)
+static int zd1201_probe(struct usb_interface *interface,
+			const struct usb_device_id *id)
 {
 	struct zd1201 *zd;
 	struct usb_device *usb;
@@ -1851,7 +1853,7 @@
 	return err;
 }
 
-void zd1201_disconnect(struct usb_interface *interface)
+static void zd1201_disconnect(struct usb_interface *interface)
 {
 	struct zd1201 *zd=(struct zd1201 *)usb_get_intfdata(interface);
 	struct hlist_node *node, *node2;
@@ -1882,7 +1884,7 @@
 	kfree(zd);
 }
 
-struct usb_driver zd1201_usb = {
+static struct usb_driver zd1201_usb = {
 	.owner = THIS_MODULE,
 	.name = "zd1201",
 	.probe = zd1201_probe,
===============================================================================
