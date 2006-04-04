Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWDDCta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWDDCta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWDDCta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:49:30 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:43891 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964977AbWDDCt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:49:29 -0400
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [linux-usb-devel] compile error when building multiple EHCI host controllers as modules
Date: Mon, 3 Apr 2006 19:48:37 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       LKML mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0603241429220.19557-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0603241429220.19557-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_G6dMEKuYMqvAe3Y"
Message-Id: <200604031948.38101.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_G6dMEKuYMqvAe3Y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 24 March 2006 12:32 pm, Kumar Gala wrote:
> > The issue I have this is that it makes two (or more) things that were  
> > independent now dependent.  What about just moving the module_init/ 
> > exit() functions into files that are built separately.  For the ehci- 
> > fsl case it was trivial, need to look at ehci-pci case.
> 
> Ok, my idea required exporting things I didn't really want to export, so 
> what about something like this or where you thinking of some more 
> sophisticated?
> 
> If this is good, I'll do the same for ohci.

How about this one instead?  It requires fewer per-SOC hacks in generic
code when adding a new SOC.  And it also removes a platform device naming
goof for your mpc83xx support ... that's a case where you should just let
the platform device IDs distinguish things.

- Dave


--Boundary-00=_G6dMEKuYMqvAe3Y
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ehci-kumar.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ehci-kumar.patch"

Let EHCI build and link supporing both PCI and platform bus glue.

 - there's now a single pair of module init/exit routines, which
   do little beyond registering/unregistering one or two drivers:
     * a single platform driver
     * a single pci driver

 - for coldplug, the non-PCI drivers also define a MODULE_ALIAS;
   boot scripts can just "modprobe $(cat .../modalias)"

 - renamed mpc83xx platform devices to follow normal Linux rules

au1xxx will have a compile problem, it still needs to convert to
using platform_driver.

Index: g26/drivers/usb/host/ehci-au1xxx.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-au1xxx.c	2006-03-31 22:36:07.000000000 -0800
+++ g26/drivers/usb/host/ehci-au1xxx.c	2006-04-03 19:40:44.000000000 -0700
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
Index: g26/drivers/usb/host/ehci-fsl.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-fsl.c	2006-03-31 22:36:07.000000000 -0800
+++ g26/drivers/usb/host/ehci-fsl.c	2006-04-03 19:38:26.000000000 -0700
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
Index: g26/drivers/usb/host/ehci-hcd.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-hcd.c	2006-03-31 22:36:07.000000000 -0800
+++ g26/drivers/usb/host/ehci-hcd.c	2006-04-03 19:46:07.000000000 -0700
@@ -889,19 +889,59 @@ MODULE_LICENSE ("GPL");
 
 #ifdef CONFIG_PCI
 #include "ehci-pci.c"
-#define	EHCI_BUS_GLUED
+#define	PCI_DRIVER		ehci_pci_driver
 #endif
 
 #ifdef CONFIG_PPC_83xx
 #include "ehci-fsl.c"
-#define	EHCI_BUS_GLUED
+#define	PLATFORM_DRIVER		ehci_fsl_dr_driver
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
+	driver_unregister(&PLATFORM_DRIVER);
+#endif
+#ifdef PCI_DRIVER
+	pci_unregister_driver(&PCI_DRIVER);
+#endif
+}
+module_exit(ehci_hcd_cleanup);
+
Index: g26/drivers/usb/host/ehci-pci.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-pci.c	2006-03-31 22:36:07.000000000 -0800
+++ g26/drivers/usb/host/ehci-pci.c	2006-04-03 19:15:33.000000000 -0700
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
Index: g26/arch/ppc/syslib/mpc83xx_devices.c
===================================================================
--- g26.orig/arch/ppc/syslib/mpc83xx_devices.c	2006-03-31 22:35:39.000000000 -0800
+++ g26/arch/ppc/syslib/mpc83xx_devices.c	2006-04-03 19:39:10.000000000 -0700
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

--Boundary-00=_G6dMEKuYMqvAe3Y--
