Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWGGXtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWGGXtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGGXtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:49:53 -0400
Received: from xenotime.net ([66.160.160.81]:52944 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750940AbWGGXtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:49:52 -0400
Date: Fri, 7 Jul 2006 16:52:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>, akpm <akpm@osdl.org>, davej@codemonkey.org.uk
Subject: [PATCH] PCIE: create sysfs directory on first use
Message-Id: <20060707165238.337c7a4a.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Dave Jones had a question about why /sys/bus/pci_express/devices
shows up even when there are no PCI-Express devices in a system
(if the config option is enabled).
Greg KH said that it could be added on its first use.

This patch creates that directory only when a device is discovered
and added to the directory.  On my ancient P-III test system,
the directory is never added, but on my Dell D610 notebook and
other dual-core system, it is added during boot discovery.

Does the "drivers" directory need some special handling also?

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pci/pcie/portdrv_core.c |   11 ++++++++++-
 drivers/pci/pcie/portdrv_pci.c  |    1 -
 2 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2618-rc1.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2618-rc1/drivers/pci/pcie/portdrv_core.c
@@ -274,6 +274,8 @@ int pcie_port_device_probe(struct pci_de
 	return -ENODEV;
 }
 
+static int pcie_dev_registered;	/* register on first use */
+
 int pcie_port_device_register(struct pci_dev *dev)
 {
 	struct pcie_port_device_ext *p_ext;
@@ -303,6 +305,9 @@ int pcie_port_device_register(struct pci
 		struct pcie_device *child;
 
 		if (capabilities & (1 << i)) {
+			if (!pcie_dev_registered)
+				pcie_port_bus_register();
+
 			child = alloc_pcie_device(
 				dev, 		/* parent */
 				type,		/* port type */
@@ -405,11 +410,15 @@ void pcie_port_device_remove(struct pci_
 void pcie_port_bus_register(void)
 {
 	bus_register(&pcie_port_bus_type);
+	pcie_dev_registered = 1;
 }
 
 void pcie_port_bus_unregister(void)
 {
-	bus_unregister(&pcie_port_bus_type);
+	if (pcie_dev_registered) {
+		bus_unregister(&pcie_port_bus_type);
+		pcie_dev_registered = 0;
+	}
 }
 
 int pcie_port_service_register(struct pcie_port_service_driver *new)
--- linux-2618-rc1.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2618-rc1/drivers/pci/pcie/portdrv_pci.c
@@ -129,7 +129,6 @@ static int __init pcie_portdrv_init(void
 {
 	int retval = 0;
 
-	pcie_port_bus_register();
 	retval = pci_register_driver(&pcie_portdrv);
 	if (retval)
 		pcie_port_bus_unregister();


---
