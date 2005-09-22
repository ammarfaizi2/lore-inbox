Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVIVHsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVIVHsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVIVHsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:48:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:36018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751433AbVIVHsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:15 -0400
Date: Thu, 22 Sep 2005 00:47:11 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: [patch 01/18] Driver Core: fis bus rescan devices race
Message-ID: <20050922074711.GB15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-fix-bus_rescan_devices.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Ritz <daniel.ritz@gmx.ch>

bus_rescan_devices_helper() does not hold the dev->sem when it checks for
!dev->driver().  device_attach() holds the sem, but calls again
device_bind_driver() even when dev->driver is set.

What happens is that a first device_attach() call (module insertion time)
is on the way binding the device to a driver.  Another thread calls
bus_rescan_devices().  Now when bus_rescan_devices_helper() checks for
dev->driver it is still NULL 'cos the the prior device_attach() is not yet
finished.  But as soon as the first one releases the dev->sem the second
device_attach() tries to rebind the already bound device again. 
device_bind_driver() does this blindly which leads to a corrupt
driver->klist_devices list (the device links itself, the head points to the
device).  Later a call to device_release_driver() sets dev->driver to NULL
and breaks the link it has to itself on knode_driver.  Rmmoding the driver
later calls driver_detach() which leads to an endless loop 'cos the list
head in klist_devices still points to the device.  And since dev->driver is
NULL it's stuck with the same device forever.  Boom.  And rmmod hangs.

Very easy to reproduce with new-style pcmcia and a 16bit card.  Just loop
modprobe <pcmcia-modules> ;cardctl eject; rmmod <card driver, pcmcia
modules>.

Easiest fix is to check if the device is already bound to a driver in
device_bind_driver().  This avoids the double binding.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
drivers/base/dd.c |    3 +++
 1 file changed, 3 insertions(+)

--- scsi-2.6.orig/drivers/base/dd.c	2005-09-20 05:59:41.000000000 -0700
+++ scsi-2.6/drivers/base/dd.c	2005-09-21 17:29:03.000000000 -0700
@@ -40,6 +40,9 @@
  */
 void device_bind_driver(struct device * dev)
 {
+	if (klist_node_attached(&dev->knode_driver))
+		return;
+
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id, dev->driver->name);
 	klist_add_tail(&dev->knode_driver, &dev->driver->klist_devices);

--
