Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVHVX6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVHVX6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVHVX6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:58:03 -0400
Received: from pop.gmx.de ([213.165.64.20]:58822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751274AbVHVX6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:58:01 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] driver core: fix bus_rescan_devices() race.
Date: Tue, 23 Aug 2005 02:02:56 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508230202.57377.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: fix bus_rescan_devices() race.

bus_rescan_devices_helper() does not hold the dev->sem when it checks for
!dev->driver. device_attach() holds the sem, but calls again device_bind_driver()
even when dev->driver is set (which means device is already bound to a driver).
what happens is that a first device_attach() call (module insertion time) is on
the way binding the device to a driver. another thread calls bus_rescan_devices().
now when bus_rescan_devices_helper() checks for dev->driver it is still NULL 'cos
the the prior device_attach() is not yet finished. but as soon as the first one
releases the dev->sem the second device_attach() tries to rebind the already
bound device again. device_bind_driver() does this blindly which leads to a
corrupt driver->klist_devices list (the device links itself, the head points
to the device). later a call to device_release_driver() sets dev->driver to NULL
and breaks the link it has to itself on knode_driver. rmmoding the driver
later calls driver_detach() which leads to an endless loop 'cos the list head
in klist_devices still points to the device. and since dev->driver is NULL
it's stuck with the same device forever. boom. and rmmod hangs.

very easy to reproduce with new-style pcmcia and a 16bit card. just loop
modprobe <pcmcia-modules> ;cardctl eject; rmmod <card driver, pcmcia modules>.

fix is not to call device_bind_driver() in device_attach() if dev->driver is
non-NULL. this is wrong anyway since if dev->driver is set the device is bound.
also remove the dev->drv check in bus_rescan_devices_helper().

and while at it replace spin_(un|)lock_irq in driver_detach with the non-irq
variants. just doesn't make sense to me. the whole klist locking never uses the
irq variants.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -127,10 +127,9 @@ int device_attach(struct device * dev)
 	int ret = 0;
 
 	down(&dev->sem);
-	if (dev->driver) {
-		device_bind_driver(dev);
+	if (dev->driver)
 		ret = 1;
-	} else
+	else
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
 	up(&dev->sem);
 	return ret;
@@ -222,15 +221,15 @@ void driver_detach(struct device_driver 
 	struct device * dev;
 
 	for (;;) {
-		spin_lock_irq(&drv->klist_devices.k_lock);
+		spin_lock(&drv->klist_devices.k_lock);
 		if (list_empty(&drv->klist_devices.k_list)) {
-			spin_unlock_irq(&drv->klist_devices.k_lock);
+			spin_unlock(&drv->klist_devices.k_lock);
 			break;
 		}
 		dev = list_entry(drv->klist_devices.k_list.prev,
 				struct device, knode_driver.n_node);
 		get_device(dev);
-		spin_unlock_irq(&drv->klist_devices.k_lock);
+		spin_unlock(&drv->klist_devices.k_lock);
 
 		down(&dev->sem);
 		if (dev->driver == drv)
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -485,8 +485,7 @@ void bus_remove_driver(struct device_dri
 /* Helper for bus_rescan_devices's iter */
 static int bus_rescan_devices_helper(struct device *dev, void *data)
 {
-	if (!dev->driver)
-		device_attach(dev);
+	device_attach(dev);
 	return 0;
 }
 
