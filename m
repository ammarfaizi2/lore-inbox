Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVEDHEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVEDHEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVEDHDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:03:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:64740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262045AbVEDHCW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:22 -0400
Cc: gregkh@suse.de
Subject: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <11151901373936@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:18 -0700
Message-Id: <11151901383259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: Add pci shutdown ability

Now pci drivers can know when the system is going down without having to
add a reboot notifier event.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c8958177224622411b9979eabb5610e30b06034b
tree 09ceb4ce69813c9ac2a3e3c7ea6eff9d5361fe9c
parent 4c0619add8c3a8b28e7fae8b15cc7b62de2f8148
author Greg KH <gregkh@suse.de> 1112939611 +0900
committer Greg KH <gregkh@suse.de> 1115189115 -0700

Index: drivers/pci/pci-driver.c
===================================================================
--- 2e27d1c516480dd6f3686c05caac09b196475951/drivers/pci/pci-driver.c  (mode:100644 sha1:37b7961efc44a93fff15ee41c125be1e71c5d9e5)
+++ 09ceb4ce69813c9ac2a3e3c7ea6eff9d5361fe9c/drivers/pci/pci-driver.c  (mode:100644 sha1:b42466ccbb309f4961b7a653aa079c3577d7cbb7)
@@ -318,6 +318,14 @@
 	return 0;
 }
 
+static void pci_device_shutdown(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *drv = pci_dev->driver;
+
+	if (drv && drv->shutdown)
+		drv->shutdown(pci_dev);
+}
 
 #define kobj_to_pci_driver(obj) container_of(obj, struct device_driver, kobj)
 #define attr_to_driver_attribute(obj) container_of(obj, struct driver_attribute, attr)
@@ -385,6 +393,7 @@
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
+	drv->driver.shutdown = pci_device_shutdown,
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
Index: include/linux/pci.h
===================================================================
--- 2e27d1c516480dd6f3686c05caac09b196475951/include/linux/pci.h  (mode:100644 sha1:3c89148ae28a6e28d4ec21e680a6e383fb885e3d)
+++ 09ceb4ce69813c9ac2a3e3c7ea6eff9d5361fe9c/include/linux/pci.h  (mode:100644 sha1:cff5ba3ac8ce816c8261dd588be17f488de89507)
@@ -671,6 +671,7 @@
 	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
+	void (*shutdown) (struct pci_dev *dev);
 
 	struct device_driver	driver;
 	struct pci_dynids dynids;

