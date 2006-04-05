Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWDERe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWDERe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWDERe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:34:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:36773 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751309AbWDERe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:34:56 -0400
Date: Wed, 5 Apr 2006 12:32:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host
 controllers as modules
In-Reply-To: <074E7D37-773D-4203-BB09-20040C5D5D5B@kernel.crashing.org>
Message-ID: <Pine.LNX.4.44.0604051231030.17147-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me test this patch out.  I'm ok with the changes for handling  
> both PCI and platform driver.  However, I need to take a look at the  
> renaming of the fsl driver.  The "dr" device supports device and OTG  
> modes.  I'm concerned about how we distinguish that in the future.
> 
> (also, we need to fixup arch/powerpc/sysdev/fsl_soc.c)

Here's a cleaned up version that builds and fixes up some warnings for me.
I need to cleanup the code in arch/powerpc/sysdev/fsl_soc.c a bit, but it 
works for now.

diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci-au1xxx.c
index 63eadee..036a1c0 100644
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -280,18 +280,3 @@ static struct device_driver ehci_hcd_au1
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
index f985f12..30410c2 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -339,28 +339,3 @@ static struct platform_driver ehci_fsl_m
 		   .name = "fsl-usb2-mph",
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
index 79f2d8b..549ce59 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -905,3 +905,57 @@ MODULE_LICENSE ("GPL");
 #ifndef	EHCI_BUS_GLUED
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
+#ifdef CONFIG_PPC_83xx
+	retval = platform_driver_register(&ehci_fsl_dr_driver);
+	if (retval < 0)
+		return retval;
+
+	retval = platform_driver_register(&ehci_fsl_dr_driver);
+	if (retval < 0)
+		return retval;
+#endif
+
+#ifdef CONFIG_SOC_AU1X00
+	pr_debug(DRIVER_INFO " (Au1xxx)\n");
+
+	retval = driver_register(&ehci_hcd_au1xxx_driver);
+	if (retval < 0)
+		return retval;
+#endif
+
+#ifdef CONFIG_PCI
+	retval = pci_register_driver(&ehci_pci_driver);
+	if (retval < 0)
+		return retval;
+#endif
+
+	return retval;
+}
+
+static void __exit ehci_hcd_cleanup(void)
+{
+#ifdef CONFIG_PPC_83xx
+	platform_driver_unregister(&ehci_fsl_mph_driver);
+	platform_driver_unregister(&ehci_fsl_dr_driver);
+#endif
+#ifdef CONFIG_SOC_AU1X00
+	driver_unregister(&ehci_hcd_au1xxx_driver);
+#endif
+#ifdef CONFIG_PCI
+	pci_unregister_driver(&ehci_pci_driver);
+#endif
+}
+
+module_init(ehci_hcd_init);
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

