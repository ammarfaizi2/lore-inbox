Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272356AbTHIMwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 08:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272357AbTHIMwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 08:52:38 -0400
Received: from [203.145.184.221] ([203.145.184.221]:63750 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272356AbTHIMwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 08:52:37 -0400
Subject: [PATCH 2.6.0-test3][BLUETOOTH] BUG fix for
	drivers/bluetooth/hci_usb.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Maxim Krasnyansky <maxk@qualcomm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, trivial@rustcorp.com.au
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 09 Aug 2003 18:41:59 +0530
Message-Id: <1060434720.2511.45.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes two pointer reference bugs (shows up as compile
time warnings given below) which wrongly take the address of "struct
usb_interface*".

============compiler warning============================
drivers/bluetooth/hci_usb.c: In function `hci_usb_probe':
drivers/bluetooth/hci_usb.c:786: warning: assignment from incompatible
pointer type
drivers/bluetooth/hci_usb.c:810: warning: assignment from incompatible
pointer type
=========================================================================
diff -urN linux-2.6.0-test3/drivers/bluetooth/hci_usb.c linux-2.6.0-test3-nvk/drivers/bluetooth/hci_usb.c
--- linux-2.6.0-test3/drivers/bluetooth/hci_usb.c	2003-07-15 17:22:49.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/bluetooth/hci_usb.c	2003-08-09 18:17:21.000000000 +0530
@@ -783,7 +783,7 @@
 
 	BT_DBG("udev %p ifnum %d", udev, ifnum);
 
-	iface = &udev->actconfig->interface[0];
+	iface = udev->actconfig->interface[0];
 
 	/* Check our black list */
 	if (usb_match_id(intf, ignore_ids))
@@ -807,7 +807,7 @@
 
 	ifn = min_t(unsigned int, udev->actconfig->desc.bNumInterfaces, HCI_MAX_IFACE_NUM);
 	for (i = 0; i < ifn; i++) {
-		iface = &udev->actconfig->interface[i];
+		iface = udev->actconfig->interface[i];
 		for (a = 0; a < iface->num_altsetting; a++) {
 			uif = &iface->altsetting[a];
 			for (e = 0; e < uif->desc.bNumEndpoints; e++) {



