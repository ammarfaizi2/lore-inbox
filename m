Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUEITuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUEITuR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 15:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUEITuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 15:50:17 -0400
Received: from uucp.gnuu.de ([151.189.20.84]:10248 "EHLO uucp.gnuu.de")
	by vger.kernel.org with ESMTP id S264377AbUEITuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 15:50:11 -0400
Date: Sun, 9 May 2004 21:47:15 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hci-usb bugfix
Message-ID: <20040509194715.GA2163@eniac.lan.yath.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Sebastian Schmidt <yath@yath.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a little patch against 2.6.6-rc3 which fixes the Oops when
unplugging an USB Bluetooth device.

hci_usb_disconnect() got called recursively which caused
sysfs_hash_and_remove() finally to dereference a NULL pointer.

--- SNIP ---
diff -uNr linux-2.6.6-rc3.old/drivers/bluetooth/hci_usb.c linux-2.6.6-rc3/drivers/bluetooth/hci_usb.c
--- linux-2.6.6-rc3.old/drivers/bluetooth/hci_usb.c     2004-05-09 20:25:00.000000000 +0200
+++ linux-2.6.6-rc3/drivers/bluetooth/hci_usb.c 2004-05-09 20:28:30.000000000 +0200
@@ -986,8 +986,21 @@

        hci_usb_close(hdev);

-       if (husb->isoc_iface)
+       if (husb->isoc_iface) {
+#if 0
                usb_driver_release_interface(&hci_usb_driver, husb->isoc_iface);
+#else
+               /* do the same as usb_driver_release_interface would do,
+                * except calling diconnect().
+                * usb_driver_release_interface() _does_ check if
+                *  are in disconnect() or add, but I really dunno 
+                *  where dev->driver_list or dev->bus_list gets set.
+                *      -- yath
+                */
+               husb->isoc_iface->dev.driver = NULL;
+               usb_set_intfdata(husb->isoc_iface, NULL);
+#endif
+       }

        if (hci_unregister_dev(hdev) < 0)
                BT_ERR("Can't unregister HCI device %s", hdev->name);
--- SNAP ---

Please apply it,

Sebastian

