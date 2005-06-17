Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVFQTZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVFQTZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVFQTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:25:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:26804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262067AbVFQTZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:25:36 -0400
Date: Fri, 17 Jun 2005 12:25:25 -0700
From: Greg KH <gregkh@suse.de>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       hch@lst.de
Subject: [PATCH] PCI: don't override drv->shutdown unconditionally
Message-ID: <20050617192525.GA22457@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are many drivers that have been setting the generic driver
model level shutdown callback, and pci thus must not override it.

Without this patch we can have really bad data loss on various
raid controllers.


From: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/pci/pci-driver.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/pci/pci-driver.c	2005-06-16 15:19:44.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci-driver.c	2005-06-17 12:17:34.000000000 -0700
@@ -395,7 +395,10 @@
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
-	drv->driver.shutdown = pci_device_shutdown,
+	/* FIXME, once all of the existing PCI drivers have been fixed to set
+	 * the pci shutdown function, this test can go away. */
+	if (!drv->driver.shutdown)
+		drv->driver.shutdown = pci_device_shutdown,
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
