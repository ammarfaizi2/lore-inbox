Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264345AbUEMR4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264345AbUEMR4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264349AbUEMR4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:56:39 -0400
Received: from ida.rowland.org ([192.131.102.52]:1284 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264345AbUEMR4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:56:32 -0400
Date: Thu, 13 May 2004 13:56:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>, Duncan Sands <baldrick@free.fr>
cc: Nuno Ferreira <nuno.ferreira@graycell.biz>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sf.net>
Subject: PATCH: (as279) Don't delete interfaces until all are unbound
In-Reply-To: <200405131845.29812.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Duncan Sands wrote:

> No, but the pointer for another (previous) interface may just have been
> set to NULL, causing an Oops when usb_ifnum_to_if loops over all
> interfaces.

Of course!  I trust you won't mind me changing your suggested fix
slightly.  This should do an equally good job of repairing things, and it
will prevent other possible invalid references as well.

Greg, please apply.

Alan Stern


===== drivers/usb/core/message.c 1.83 vs edited =====
--- 1.83/drivers/usb/core/message.c	Mon May  3 06:26:40 2004
+++ edited/drivers/usb/core/message.c	Thu May 13 13:37:48 2004
@@ -830,7 +830,14 @@
 			interface = dev->actconfig->interface[i];
 			dev_dbg (&dev->dev, "unregistering interface %s\n",
 				interface->dev.bus_id);
-			device_unregister (&interface->dev);
+			device_del (&interface->dev);
+		}
+
+		/* Now that the interfaces are unbound, nobody should
+		 * try to access them.
+		 */
+		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
+			put_device (&dev->actconfig->interface[i]->dev);
 			dev->actconfig->interface[i] = NULL;
 		}
 		dev->actconfig = 0;
===== drivers/usb/core/usb.c 1.264 vs edited =====
--- 1.264/drivers/usb/core/usb.c	Thu Apr 15 08:19:20 2004
+++ edited/drivers/usb/core/usb.c	Thu May 13 13:40:06 2004
@@ -198,6 +198,9 @@
  * This routine helps device drivers avoid such mistakes.
  * However, you should make sure that you do the right thing with any
  * alternate settings available for this interfaces.
+ *
+ * Don't call this function unless you are bound to one of the interfaces
+ * on this device or you own the dev->serialize semaphore!
  */
 struct usb_interface *usb_ifnum_to_if(struct usb_device *dev, unsigned ifnum)
 {
@@ -228,6 +231,9 @@
  * it would be incorrect to assume that the first altsetting entry in
  * the array corresponds to altsetting zero.  This routine helps device
  * drivers avoid such mistakes.
+ *
+ * Don't call this function unless you are bound to the intf interface
+ * or you own the device's ->serialize semaphore!
  */
 struct usb_host_interface *usb_altnum_to_altsetting(struct usb_interface *intf,
 		unsigned int altnum)


