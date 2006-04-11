Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWDKPJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWDKPJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWDKPJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:09:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:45547 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751349AbWDKPJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:09:43 -0400
Date: Tue, 11 Apr 2006 10:07:16 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: allow multiple types of EHCI controllers to be built
 as modules
In-Reply-To: <EDA713D2-AF06-4926-99D4-8F54221B621E@kernel.crashing.org>
Message-ID: <Pine.LNX.4.44.0604111006450.25404-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some systems we may have both a platform EHCI controller and PCI EHCI
controller.  Previously we couldn't build the EHCI support as a module due
to conflicting module_init() calls in the code.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 7a5e244608d23e60f31e6c63bd69af3534ef38eb
tree 6957efcb7d12e5f56fbc318bf503dd7307a3d075
parent a145410dccdb44f81d3b56763ef9b6f721f4e47c
author Kumar Gala <galak@kernel.crashing.org> Tue, 11 Apr 2006 10:05:36 -0500
committer Kumar Gala <galak@kernel.crashing.org> Tue, 11 Apr 2006 10:05:36 -0500

 arch/powerpc/sysdev/fsl_soc.c     |   66 +++++++++++++++----------------------
 arch/ppc/syslib/mpc83xx_devices.c |    6 ++-
 drivers/usb/host/ehci-au1xxx.c    |   17 +---------
 drivers/usb/host/ehci-fsl.c       |   37 ++-------------------
 drivers/usb/host/ehci-hcd.c       |   48 +++++++++++++++++++++++++--
 drivers/usb/host/ehci-pci.c       |   20 -----------
 6 files changed, 78 insertions(+), 116 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ceb5846..71a3275 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -372,7 +372,7 @@ static int __init fsl_usb_of_init(void)
 {
 	struct device_node *np;
 	unsigned int i;
-	struct platform_device *usb_dev;
+	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr = NULL;
 	int ret;
 
 	for (np = NULL, i = 0;
@@ -393,15 +393,15 @@ static int __init fsl_usb_of_init(void)
 		r[1].end = np->intrs[0].line;
 		r[1].flags = IORESOURCE_IRQ;
 
-		usb_dev =
-		    platform_device_register_simple("fsl-usb2-mph", i, r, 2);
-		if (IS_ERR(usb_dev)) {
-			ret = PTR_ERR(usb_dev);
+		usb_dev_mph =
+		    platform_device_register_simple("fsl-ehci", i, r, 2);
+		if (IS_ERR(usb_dev_mph)) {
+			ret = PTR_ERR(usb_dev_mph);
 			goto err;
 		}
 
-		usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
-		usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
+		usb_dev_mph->dev.coherent_dma_mask = 0xffffffffUL;
+		usb_dev_mph->dev.dma_mask = &usb_dev_mph->dev.coherent_dma_mask;
 
 		usb_data.operating_mode = FSL_USB2_MPH_HOST;
 
@@ -417,31 +417,14 @@ static int __init fsl_usb_of_init(void)
 		usb_data.phy_mode = determine_usb_phy(prop);
 
 		ret =
-		    platform_device_add_data(usb_dev, &usb_data,
+		    platform_device_add_data(usb_dev_mph, &usb_data,
 					     sizeof(struct
 						    fsl_usb2_platform_data));
 		if (ret)
-			goto unreg;
+			goto unreg_mph;
 	}
 
-	return 0;
-
-unreg:
-	platform_device_unregister(usb_dev);
-err:
-	return ret;
-}
-
-arch_initcall(fsl_usb_of_init);
-
-static int __init fsl_usb_dr_of_init(void)
-{
-	struct device_node *np;
-	unsigned int i;
-	struct platform_device *usb_dev;
-	int ret;
-
-	for (np = NULL, i = 0;
+	for (np = NULL;
 	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL;
 	     i++) {
 		struct resource r[2];
@@ -453,21 +436,21 @@ static int __init fsl_usb_dr_of_init(voi
 
 		ret = of_address_to_resource(np, 0, &r[0]);
 		if (ret)
-			goto err;
+			goto unreg_mph;
 
 		r[1].start = np->intrs[0].line;
 		r[1].end = np->intrs[0].line;
 		r[1].flags = IORESOURCE_IRQ;
 
-		usb_dev =
-		    platform_device_register_simple("fsl-usb2-dr", i, r, 2);
-		if (IS_ERR(usb_dev)) {
-			ret = PTR_ERR(usb_dev);
+		usb_dev_dr =
+		    platform_device_register_simple("fsl-ehci", i, r, 2);
+		if (IS_ERR(usb_dev_dr)) {
+			ret = PTR_ERR(usb_dev_dr);
 			goto err;
 		}
 
-		usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
-		usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
+		usb_dev_dr->dev.coherent_dma_mask = 0xffffffffUL;
+		usb_dev_dr->dev.dma_mask = &usb_dev_dr->dev.coherent_dma_mask;
 
 		usb_data.operating_mode = FSL_USB2_DR_HOST;
 
@@ -475,19 +458,22 @@ static int __init fsl_usb_dr_of_init(voi
 		usb_data.phy_mode = determine_usb_phy(prop);
 
 		ret =
-		    platform_device_add_data(usb_dev, &usb_data,
+		    platform_device_add_data(usb_dev_dr, &usb_data,
 					     sizeof(struct
 						    fsl_usb2_platform_data));
 		if (ret)
-			goto unreg;
+			goto unreg_dr;
 	}
-
 	return 0;
 
-unreg:
-	platform_device_unregister(usb_dev);
+unreg_dr:
+	if (usb_dev_dr)
+		platform_device_unregister(usb_dev_dr);
+unreg_mph:
+	if (usb_dev_mph)
+		platform_device_unregister(usb_dev_mph);
 err:
 	return ret;
 }
 
-arch_initcall(fsl_usb_dr_of_init);
+arch_initcall(fsl_usb_of_init);
diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
index 1af2c00..5c4932c 100644
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -186,7 +186,7 @@ struct platform_device ppc_sys_platform_
 		},
 	},
 	[MPC83xx_USB2_DR] = {
-		.name = "fsl-usb2-dr",
+		.name = "fsl-ehci",
 		.id	= 1,
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
@@ -203,8 +203,8 @@ struct platform_device ppc_sys_platform_
 		},
 	},
 	[MPC83xx_USB2_MPH] = {
-		.name = "fsl-usb2-mph",
-		.id	= 1,
+		.name = "fsl-ehci",
+		.id	= 2,
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
 			{
diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci-au1xxx.c
index 63eadee..0e444ab 100644
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -272,6 +272,8 @@ static int ehci_hcd_au1xxx_drv_resume(st
 	return 0;
 }
 */
+MODULE_ALIAS("au1xxx-ehci");
+/* FIXME use "struct platform_driver" */
 static struct device_driver ehci_hcd_au1xxx_driver = {
 	.name = "au1xxx-ehci",
 	.bus = &platform_bus_type,
@@ -280,18 +282,3 @@ static struct device_driver ehci_hcd_au1
 	/*.suspend      = ehci_hcd_au1xxx_drv_suspend, */
 	/*.resume       = ehci_hcd_au1xxx_drv_resume, */
 };
-
-static int __init ehci_hcd_au1xxx_init(void)
-{
-	pr_debug(DRIVER_INFO " (Au1xxx)\n");
-
-	return driver_register(&ehci_hcd_au1xxx_driver);
-}
-
-static void __exit ehci_hcd_au1xxx_cleanup(void)
-{
-	driver_unregister(&ehci_hcd_au1xxx_driver);
-}
-
-module_init(ehci_hcd_au1xxx_init);
-module_exit(ehci_hcd_au1xxx_cleanup);
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index f985f12..a49a689 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -324,43 +324,12 @@ static int ehci_fsl_drv_remove(struct pl
 	return 0;
 }
 
-static struct platform_driver ehci_fsl_dr_driver = {
-	.probe = ehci_fsl_drv_probe,
-	.remove = ehci_fsl_drv_remove,
-	.driver = {
-		   .name = "fsl-usb2-dr",
-		   },
-};
+MODULE_ALIAS("fsl-ehci");
 
-static struct platform_driver ehci_fsl_mph_driver = {
+static struct platform_driver ehci_fsl_driver = {
 	.probe = ehci_fsl_drv_probe,
 	.remove = ehci_fsl_drv_remove,
 	.driver = {
-		   .name = "fsl-usb2-mph",
+		   .name = "fsl-ehci",
 		   },
 };
-
-static int __init ehci_fsl_init(void)
-{
-	int retval;
-
-	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
-		 hcd_name,
-		 sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
-		 sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
-
-	retval = platform_driver_register(&ehci_fsl_dr_driver);
-	if (retval)
-		return retval;
-
-	return platform_driver_register(&ehci_fsl_mph_driver);
-}
-
-static void __exit ehci_fsl_cleanup(void)
-{
-	platform_driver_unregister(&ehci_fsl_mph_driver);
-	platform_driver_unregister(&ehci_fsl_dr_driver);
-}
-
-module_init(ehci_fsl_init);
-module_exit(ehci_fsl_cleanup);
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 79f2d8b..7d7c97c 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -889,19 +889,59 @@ MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_PCI
 #include "ehci-pci.c"
-#define	EHCI_BUS_GLUED
+#define	PCI_DRIVER		ehci_pci_driver
 #endif
 
 #ifdef CONFIG_PPC_83xx
 #include "ehci-fsl.c"
-#define	EHCI_BUS_GLUED
+#define	PLATFORM_DRIVER		ehci_fsl_driver
 #endif
 
 #ifdef CONFIG_SOC_AU1X00
 #include "ehci-au1xxx.c"
-#define	EHCI_BUS_GLUED
+#define	PLATFORM_DRIVER		ehci_hcd_au1xxx_driver
 #endif
 
-#ifndef	EHCI_BUS_GLUED
+#if !defined(PCI_DRIVER) && !defined(PLATFORM_DRIVER)
 #error "missing bus glue for ehci-hcd"
 #endif
+
+static int __init ehci_hcd_init(void)
+{
+	int retval = 0;
+
+	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
+		 hcd_name,
+		 sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
+		 sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
+
+#ifdef PLATFORM_DRIVER
+	retval = platform_driver_register(&PLATFORM_DRIVER);
+	if (retval < 0)
+		return retval;
+#endif
+
+#ifdef PCI_DRIVER
+	retval = pci_register_driver(&PCI_DRIVER);
+	if (retval < 0) {
+#ifdef PLATFORM_DRIVER
+		platform_driver_unregister(&PLATFORM_DRIVER);
+#endif
+	}
+#endif
+
+	return retval;
+}
+module_init(ehci_hcd_init);
+
+static void __exit ehci_hcd_cleanup(void)
+{
+#ifdef PLATFORM_DRIVER
+	platform_driver_unregister(&PLATFORM_DRIVER);
+#endif
+#ifdef PCI_DRIVER
+	pci_unregister_driver(&PCI_DRIVER);
+#endif
+}
+module_exit(ehci_hcd_cleanup);
+
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 1e03f1a..e0641bc 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -370,23 +370,3 @@ static struct pci_driver ehci_pci_driver
 	.resume =	usb_hcd_pci_resume,
 #endif
 };
-
-static int __init ehci_hcd_pci_init(void)
-{
-	if (usb_disabled())
-		return -ENODEV;
-
-	pr_debug("%s: block sizes: qh %Zd qtd %Zd itd %Zd sitd %Zd\n",
-		hcd_name,
-		sizeof(struct ehci_qh), sizeof(struct ehci_qtd),
-		sizeof(struct ehci_itd), sizeof(struct ehci_sitd));
-
-	return pci_register_driver(&ehci_pci_driver);
-}
-module_init(ehci_hcd_pci_init);
-
-static void __exit ehci_hcd_pci_cleanup(void)
-{
-	pci_unregister_driver(&ehci_pci_driver);
-}
-module_exit(ehci_hcd_pci_cleanup);

