Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUENHU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUENHU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 03:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUENHU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 03:20:57 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38635 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263980AbUENHUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 03:20:55 -0400
From: Duncan Sands <baldrick@free.fr>
To: Andy Lutomirski <luto@myrealbox.com>, Andrew Morton <akpm@osdl.org>,
       vojtech@suse.cz
Subject: Re: 2.6.6-mm2 (oops on keyboard/mouse USB hub unplug)
Date: Fri, 14 May 2004 09:20:51 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <fa.h3bu70j.nm6rj1@ifi.uio.no> <40A4207D.9000003@myrealbox.com>
In-Reply-To: <40A4207D.9000003@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200405140920.51717.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unplugging my hub still oopses.  This one was introduced in -mm1
> (2.6.6-rc2-mm1 was fine), and reverting mm1's bk-usb.patch fixed it.
> This happens every time.

The following patch from Alan Stern should fix it:

===== drivers/usb/core/message.c 1.83 vs edited =====
--- 1.83/drivers/usb/core/message.c     Mon May  3 06:26:40 2004
+++ edited/drivers/usb/core/message.c   Thu May 13 13:37:48 2004
@@ -830,7 +830,14 @@
                        interface = dev->actconfig->interface[i];
                        dev_dbg (&dev->dev, "unregistering interface %s\n",
                                interface->dev.bus_id);
-                       device_unregister (&interface->dev);
+                       device_del (&interface->dev);
+               }
+
+               /* Now that the interfaces are unbound, nobody should
+                * try to access them.
+                */
+               for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
+                       put_device (&dev->actconfig->interface[i]->dev);
                        dev->actconfig->interface[i] = NULL;
                }
                dev->actconfig = 0;
===== drivers/usb/core/usb.c 1.264 vs edited =====
--- 1.264/drivers/usb/core/usb.c        Thu Apr 15 08:19:20 2004
+++ edited/drivers/usb/core/usb.c       Thu May 13 13:40:06 2004
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
  * the array corresponds to altsetting zero.  This routine helps device
  * drivers avoid such mistakes.
+ *
+ * Don't call this function unless you are bound to the intf interface
+ * or you own the device's ->serialize semaphore!
  */
 struct usb_host_interface *usb_altnum_to_altsetting(struct usb_interface *intf,
                unsigned int altnum)
