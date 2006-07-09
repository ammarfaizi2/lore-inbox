Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWGIFzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWGIFzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 01:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIFzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 01:55:40 -0400
Received: from xenotime.net ([66.160.160.81]:38798 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964996AbWGIFzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 01:55:40 -0400
Date: Sat, 8 Jul 2006 22:58:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, davej@codemonkey.org.uk
Subject: [PATCH] PCIE: check and return bus_register errors
Message-Id: <20060708225825.0c1fac16.rdunlap@xenotime.net>
In-Reply-To: <20060707171015.688e4011.akpm@osdl.org>
References: <20060707165238.337c7a4a.rdunlap@xenotime.net>
	<20060707171015.688e4011.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:10:15 -0700 Andrew Morton wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > +			if (!pcie_dev_registered)
> > +				pcie_port_bus_register();
> > +
> 
> Wonderful.  You're forced to drop all error checking on the floor because
> pcie_port_bus_register() assumes that nobody could possibly ever be
> interested in actually checking for errors.
> 
> What happens if the bus_register() fails and the driver cheerily blunders
> along assuming that pcie_port_bus_type is registered?  Incomprehensible lkml
> oops reports, I'm suspecting..
> 
> Let's start stamping this out.  Could I please ask that you first prepare a
> patch which fixes pcie_port_bus_register() (and mark it __must_check) and
> then let's actually, like, check for errors?



From: Randy Dunlap <rdunlap@xenotime.net>

Have pcie_port_bus_register() notice and return errors.
Mark it __must_check so that its caller(s) must check its return value.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pci/pcie/portdrv.h      |    2 +-
 drivers/pci/pcie/portdrv_core.c |    5 +++--
 drivers/pci/pcie/portdrv_pci.c  |    9 +++++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

--- linux-2618-rc1.orig/drivers/pci/pcie/portdrv_core.c
+++ linux-2618-rc1/drivers/pci/pcie/portdrv_core.c
@@ -6,6 +6,7 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -402,9 +403,9 @@ void pcie_port_device_remove(struct pci_
 		pci_disable_msi(dev);
 }
 
-void pcie_port_bus_register(void)
+int __must_check pcie_port_bus_register(void)
 {
-	bus_register(&pcie_port_bus_type);
+	return bus_register(&pcie_port_bus_type);
 }
 
 void pcie_port_bus_unregister(void)
--- linux-2618-rc1.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2618-rc1/drivers/pci/pcie/portdrv_pci.c
@@ -127,12 +127,17 @@ static struct pci_driver pcie_portdrv = 
 
 static int __init pcie_portdrv_init(void)
 {
-	int retval = 0;
+	int retval;
 
-	pcie_port_bus_register();
+	retval = pcie_port_bus_register();
+	if (retval) {
+		printk(KERN_WARNING "PCIE: bus_register error: %d\n", retval);
+		goto out;
+	}
 	retval = pci_register_driver(&pcie_portdrv);
 	if (retval)
 		pcie_port_bus_unregister();
+ out:
 	return retval;
 }
 
--- linux-2618-rc1.orig/drivers/pci/pcie/portdrv.h
+++ linux-2618-rc1/drivers/pci/pcie/portdrv.h
@@ -39,7 +39,7 @@ extern int pcie_port_device_suspend(stru
 extern int pcie_port_device_resume(struct pci_dev *dev);
 #endif
 extern void pcie_port_device_remove(struct pci_dev *dev);
-extern void pcie_port_bus_register(void);
+extern int pcie_port_bus_register(void);
 extern void pcie_port_bus_unregister(void);
 
 #endif /* _PORTDRV_H_ */



---
