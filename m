Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVKNRa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVKNRa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 12:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVKNRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 12:30:57 -0500
Received: from mivlgu.ru ([81.18.140.87]:38551 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751193AbVKNRa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 12:30:57 -0500
Date: Mon, 14 Nov 2005 20:30:50 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCIE: make bus_id for PCI Express devices unique
Message-ID: <20051114173050.GB24496@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bus_id string must be unique for all devices of that bus in the
system, not just for devices with the same parent - otherwise multiple
symlinks with identical names appear in /sys/bus/pci_express/devices.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 drivers/pci/pcie/portdrv_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

 Here is the example of brokenness (observed with 2.6.15-rc1, 2.6.14 and
 even some earlier versions):

 /sys/bus/pci_express/devices:
 total 0
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie00 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie00 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie00 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie00 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie03 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie03
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie03 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie03
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie03 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie03
 lrwxrwxrwx  1 root root 0 Nov 14 08:45 pcie03 -> ../../../devices/pci0000:00/0000:00:0e.0/pcie03

 After applying the patch this becomes:

 /sys/bus/pci_express/devices:
 total 0
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0b.0:pcie00 -> ../../../devices/pci0000:00/0000:00:0b.0/0000:00:0b.0:pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0b.0:pcie03 -> ../../../devices/pci0000:00/0000:00:0b.0/0000:00:0b.0:pcie03
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0c.0:pcie00 -> ../../../devices/pci0000:00/0000:00:0c.0/0000:00:0c.0:pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0c.0:pcie03 -> ../../../devices/pci0000:00/0000:00:0c.0/0000:00:0c.0:pcie03
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0d.0:pcie00 -> ../../../devices/pci0000:00/0000:00:0d.0/0000:00:0d.0:pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0d.0:pcie03 -> ../../../devices/pci0000:00/0000:00:0d.0/0000:00:0d.0:pcie03
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0e.0:pcie00 -> ../../../devices/pci0000:00/0000:00:0e.0/0000:00:0e.0:pcie00
 lrwxrwxrwx  1 root root 0 Nov 14 09:45 0000:00:0e.0:pcie03 -> ../../../devices/pci0000:00/0000:00:0e.0/0000:00:0e.0:pcie03

applies-to: c4c2d62da01963dd519b8a16c3959fe9531614b0
2a1f8b84baa4447b7cf091f59f5d921a47ce5f59
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 467a4ce..e4e5f1e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -238,8 +238,8 @@ static void pcie_device_init(struct pci_
 	device->driver = NULL;
 	device->driver_data = NULL;
 	device->release = release_pcie_device;	/* callback to free pcie dev */
-	sprintf(&device->bus_id[0], "pcie%02x",
-		get_descriptor_id(port_type, service_type));
+	snprintf(device->bus_id, sizeof(device->bus_id), "%s:pcie%02x",
+		 pci_name(parent), get_descriptor_id(port_type, service_type));
 	device->parent = &parent->dev;
 }
 
---
0.99.9.GIT
