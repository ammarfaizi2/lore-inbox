Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVCBSR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVCBSR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCBSR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:17:28 -0500
Received: from smtp.gentoo.org ([134.68.220.30]:1479 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S262403AbVCBSN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:13:29 -0500
Subject: [PATCH] Resend: Determine SCx200 CB address at run-time
From: Henrik Brix Andersen <brix@gentoo.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DXPdCYsmGbmGOdrpsUcd"
Organization: Gentoo Linux
Date: Wed, 02 Mar 2005 19:12:37 +0100
Message-Id: <1109787158.12086.11.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DXPdCYsmGbmGOdrpsUcd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The current SCx200 drivers use a fixed base address of 0x9000 for the
Configuration Block, but some systems (at least the Soekris net4801)
uses a base address of 0x6000. This patch first tries the fixed address
then - if no configuration block could be found - tries the address
written to the Configuration Block Address Scratchpad register by the
BIOS.

This was first sent at Wed, 23 Feb 2005 13:53:33 +0100.

Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>
---

diff -urp linux-2.6.11/arch/i386/kernel/scx200.c linux-2.6.11-scx200/arch/i=
386/kernel/scx200.c
--- linux-2.6.11/arch/i386/kernel/scx200.c	2005-03-02 08:38:25.000000000 +0=
100
+++ linux-2.6.11-scx200/arch/i386/kernel/scx200.c	2005-03-02 18:01:56.00000=
0000 +0100
@@ -13,6 +13,9 @@
=20
 #include <linux/scx200.h>
=20
+/* Verify that the configuration block really is there */
+#define scx200_cb_probe(base) (inw((base) + SCx200_CBA) =3D=3D (base))
+
 #define NAME "scx200"
=20
 MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
@@ -22,9 +25,13 @@ MODULE_LICENSE("GPL");
 unsigned scx200_gpio_base =3D 0;
 long scx200_gpio_shadow[2];
=20
+unsigned scx200_cb_base =3D 0;
+
 static struct pci_device_id scx200_tbl[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_XBUS)   },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_XBUS)   },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci,scx200_tbl);
@@ -45,22 +52,39 @@ static int __devinit scx200_probe(struct
 	int bank;
 	unsigned base;
=20
-	base =3D pci_resource_start(pdev, 0);
-	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
-
-	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") =3D=3D =
0) {
-		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
-		return -EBUSY;
+	if (pdev->device =3D=3D PCI_DEVICE_ID_NS_SCx200_BRIDGE ||
+	    pdev->device =3D=3D PCI_DEVICE_ID_NS_SC1100_BRIDGE) {
+		base =3D pci_resource_start(pdev, 0);
+		printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
+
+		if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") =3D=3D=
 0) {
+			printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
+			return -EBUSY;
+		}
+
+		scx200_gpio_base =3D base;
+
+		/* read the current values driven on the GPIO signals */
+		for (bank =3D 0; bank < 2; ++bank)
+			scx200_gpio_shadow[bank] =3D inl(scx200_gpio_base + 0x10 * bank);
+
+	} else {
+		/* find the base of the Configuration Block */
+		if (scx200_cb_probe(SCx200_CB_BASE_FIXED)) {
+			scx200_cb_base =3D SCx200_CB_BASE_FIXED;
+		} else {
+			pci_read_config_dword(pdev, SCx200_CBA_SCRATCH, &base);
+			if (scx200_cb_probe(base)) {
+				scx200_cb_base =3D base;
+			} else {
+				printk(KERN_WARNING NAME ": Configuration Block not found\n");
+				return -ENODEV;
+			}
+		}
+		printk(KERN_INFO NAME ": Configuration Block base 0x%x\n", scx200_cb_bas=
e);
 	}
=20
-	scx200_gpio_base =3D base;
-
-	/* read the current values driven on the GPIO signals */
-	for (bank =3D 0; bank < 2; ++bank)
-		scx200_gpio_shadow[bank] =3D inl(scx200_gpio_base + 0x10 * bank);
-
 	return 0;
-
 }
=20
 u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
@@ -134,6 +158,7 @@ EXPORT_SYMBOL(scx200_gpio_shadow);
 EXPORT_SYMBOL(scx200_gpio_lock);
 EXPORT_SYMBOL(scx200_gpio_configure);
 EXPORT_SYMBOL(scx200_gpio_dump);
+EXPORT_SYMBOL(scx200_cb_base);
=20
 /*
     Local variables:
diff -urp linux-2.6.11/drivers/char/watchdog/Kconfig linux-2.6.11-scx200/dr=
ivers/char/watchdog/Kconfig
--- linux-2.6.11/drivers/char/watchdog/Kconfig	2005-03-02 08:38:13.00000000=
0 +0100
+++ linux-2.6.11-scx200/drivers/char/watchdog/Kconfig	2005-03-02 18:01:56.0=
00000000 +0100
@@ -268,12 +268,12 @@ config SC1200_WDT
=20
 config SCx200_WDT
 	tristate "National Semiconductor SCx200 Watchdog"
-	depends on WATCHDOG && X86 && PCI
+	depends on WATCHDOG && SCx200 && PCI
 	help
 	  Enable the built-in watchdog timer support on the National
 	  Semiconductor SCx200 processors.
=20
-	  If compiled as a module, it will be called scx200_watchdog.
+	  If compiled as a module, it will be called scx200_wdt.
=20
 config 60XX_WDT
 	tristate "SBC-60XX Watchdog Timer"
diff -urp linux-2.6.11/drivers/char/watchdog/scx200_wdt.c linux-2.6.11-scx2=
00/drivers/char/watchdog/scx200_wdt.c
--- linux-2.6.11/drivers/char/watchdog/scx200_wdt.c	2005-03-02 08:38:13.000=
000000 +0100
+++ linux-2.6.11-scx200/drivers/char/watchdog/scx200_wdt.c	2005-03-02 18:01=
:56.000000000 +0100
@@ -64,7 +64,7 @@ static char expect_close;
=20
 static void scx200_wdt_ping(void)
 {
-	outw(wdto_restart, SCx200_CB_BASE + SCx200_WDT_WDTO);
+	outw(wdto_restart, scx200_cb_base + SCx200_WDT_WDTO);
 }
=20
 static void scx200_wdt_update_margin(void)
@@ -78,9 +78,9 @@ static void scx200_wdt_enable(void)
 	printk(KERN_DEBUG NAME ": enabling watchdog timer, wdto_restart =3D %d\n"=
,
 	       wdto_restart);
=20
-	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
-	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
-	outw(W_ENABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
+	outw(0, scx200_cb_base + SCx200_WDT_WDTO);
+	outb(SCx200_WDT_WDSTS_WDOVF, scx200_cb_base + SCx200_WDT_WDSTS);
+	outw(W_ENABLE, scx200_cb_base + SCx200_WDT_WDCNFG);
=20
 	scx200_wdt_ping();
 }
@@ -89,9 +89,9 @@ static void scx200_wdt_disable(void)
 {
 	printk(KERN_DEBUG NAME ": disabling watchdog timer\n");
=20
-	outw(0, SCx200_CB_BASE + SCx200_WDT_WDTO);
-	outb(SCx200_WDT_WDSTS_WDOVF, SCx200_CB_BASE + SCx200_WDT_WDSTS);
-	outw(W_DISABLE, SCx200_CB_BASE + SCx200_WDT_WDCNFG);
+	outw(0, scx200_cb_base + SCx200_WDT_WDTO);
+	outb(SCx200_WDT_WDSTS_WDOVF, scx200_cb_base + SCx200_WDT_WDSTS);
+	outw(W_DISABLE, scx200_cb_base + SCx200_WDT_WDCNFG);
 }
=20
 static int scx200_wdt_open(struct inode *inode, struct file *file)
@@ -210,35 +210,21 @@ static struct file_operations scx200_wdt
=20
 static struct miscdevice scx200_wdt_miscdev =3D {
 	.minor =3D WATCHDOG_MINOR,
-	.name  =3D NAME,
+	.name  =3D "watchdog",
 	.fops  =3D &scx200_wdt_fops,
 };
=20
 static int __init scx200_wdt_init(void)
 {
 	int r;
-	static struct pci_device_id ns_sc[] =3D {
-		{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE) },
-		{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE) },
-		{ },
-	};
=20
 	printk(KERN_DEBUG NAME ": NatSemi SCx200 Watchdog Driver\n");
=20
-	/*
-	 * First check that this really is a NatSemi SCx200 CPU or a Geode
-	 * SC1100 processor
-	 */
-	if (!pci_dev_present(ns_sc))
-		return -ENODEV;
-
-	/* More sanity checks, verify that the configuration block is there */
-	if (!scx200_cb_probe(SCx200_CB_BASE)) {
-		printk(KERN_WARNING NAME ": no configuration block found\n");
+	/* check that we have found the configuration block */
+	if (!scx200_cb_present())
 		return -ENODEV;
-	}
=20
-	if (!request_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+	if (!request_region(scx200_cb_base + SCx200_WDT_OFFSET,
 			    SCx200_WDT_SIZE,
 			    "NatSemi SCx200 Watchdog")) {
 		printk(KERN_WARNING NAME ": watchdog I/O region busy\n");
@@ -252,7 +238,7 @@ static int __init scx200_wdt_init(void)
=20
 	r =3D misc_register(&scx200_wdt_miscdev);
 	if (r) {
-		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+		release_region(scx200_cb_base + SCx200_WDT_OFFSET,
 				SCx200_WDT_SIZE);
 		return r;
 	}
@@ -261,7 +247,7 @@ static int __init scx200_wdt_init(void)
 	if (r) {
 		printk(KERN_ERR NAME ": unable to register reboot notifier");
 		misc_deregister(&scx200_wdt_miscdev);
-		release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+		release_region(scx200_cb_base + SCx200_WDT_OFFSET,
 				SCx200_WDT_SIZE);
 		return r;
 	}
@@ -273,7 +259,7 @@ static void __exit scx200_wdt_cleanup(vo
 {
 	unregister_reboot_notifier(&scx200_wdt_notifier);
 	misc_deregister(&scx200_wdt_miscdev);
-	release_region(SCx200_CB_BASE + SCx200_WDT_OFFSET,
+	release_region(scx200_cb_base + SCx200_WDT_OFFSET,
 		       SCx200_WDT_SIZE);
 }
=20
diff -urp linux-2.6.11/drivers/mtd/maps/Kconfig linux-2.6.11-scx200/drivers=
/mtd/maps/Kconfig
--- linux-2.6.11/drivers/mtd/maps/Kconfig	2005-03-02 08:38:32.000000000 +01=
00
+++ linux-2.6.11-scx200/drivers/mtd/maps/Kconfig	2005-03-02 18:01:56.000000=
000 +0100
@@ -159,7 +159,7 @@ config MTD_VMAX
=20
 config MTD_SCx200_DOCFLASH
 	tristate "Flash device mapped with DOCCS on NatSemi SCx200"
-	depends on X86 && MTD_CFI && MTD_PARTITIONS
+	depends on SCx200 && MTD_CFI && MTD_PARTITIONS
 	help
 	  Enable support for a flash chip mapped using the DOCCS signal on a
 	  National Semiconductor SCx200 processor.
diff -urp linux-2.6.11/drivers/mtd/maps/scx200_docflash.c linux-2.6.11-scx2=
00/drivers/mtd/maps/scx200_docflash.c
--- linux-2.6.11/drivers/mtd/maps/scx200_docflash.c	2005-03-02 08:38:13.000=
000000 +0100
+++ linux-2.6.11-scx200/drivers/mtd/maps/scx200_docflash.c	2005-03-02 18:01=
:56.000000000 +0100
@@ -92,17 +92,16 @@ static int __init init_scx200_docflash(v
 				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
 				      NULL)) =3D=3D NULL)
 		return -ENODEV;
-=09
-	if (!scx200_cb_probe(SCx200_CB_BASE)) {
-		printk(KERN_WARNING NAME ": no configuration block found\n");
+
+	/* check that we have found the configuration block */
+	if (!scx200_cb_present())
 		return -ENODEV;
-	}
=20
 	if (probe) {
 		/* Try to use the present flash mapping if any */
 		pci_read_config_dword(bridge, SCx200_DOCCS_BASE, &base);
 		pci_read_config_dword(bridge, SCx200_DOCCS_CTRL, &ctrl);
-		pmr =3D inl(SCx200_CB_BASE + SCx200_PMR);
+		pmr =3D inl(scx200_cb_base + SCx200_PMR);
=20
 		if (base =3D=3D 0
 		    || (ctrl & 0x07000000) !=3D 0x07000000
@@ -155,14 +154,14 @@ static int __init init_scx200_docflash(v
 	=09
 		pci_write_config_dword(bridge, SCx200_DOCCS_BASE, docmem.start);
 		pci_write_config_dword(bridge, SCx200_DOCCS_CTRL, ctrl);
-		pmr =3D inl(SCx200_CB_BASE + SCx200_PMR);
+		pmr =3D inl(scx200_cb_base + SCx200_PMR);
 	=09
 		if (width =3D=3D 8) {
 			pmr &=3D ~(1<<6);
 		} else {
 			pmr |=3D (1<<6);
 		}
-		outl(pmr, SCx200_CB_BASE + SCx200_PMR);
+		outl(pmr, scx200_cb_base + SCx200_PMR);
 	}
 =09
        	printk(KERN_INFO NAME ": DOCCS mapped at 0x%lx-0x%lx, width %d\n",=
=20
diff -urp linux-2.6.11/include/linux/pci_ids.h linux-2.6.11-scx200/include/=
linux/pci_ids.h
--- linux-2.6.11/include/linux/pci_ids.h	2005-03-02 08:38:37.000000000 +010=
0
+++ linux-2.6.11-scx200/include/linux/pci_ids.h	2005-03-02 18:01:56.0000000=
00 +0100
@@ -386,6 +386,8 @@
 #define PCI_DEVICE_ID_NS_SCx200_VIDEO	0x0504
 #define PCI_DEVICE_ID_NS_SCx200_XBUS	0x0505
 #define PCI_DEVICE_ID_NS_SC1100_BRIDGE	0x0510
+#define PCI_DEVICE_ID_NS_SC1100_SMI	0x0511
+#define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
=20
 #define PCI_VENDOR_ID_TSENG		0x100c
diff -urp linux-2.6.11/include/linux/scx200.h linux-2.6.11-scx200/include/l=
inux/scx200.h
--- linux-2.6.11/include/linux/scx200.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11-scx200/include/linux/scx200.h	2005-03-02 18:01:56.00000000=
0 +0100
@@ -7,6 +7,10 @@
=20
 /* Interesting stuff for the National Semiconductor SCx200 CPU */
=20
+extern unsigned scx200_cb_base;
+
+#define scx200_cb_present() (scx200_cb_base!=3D0)
+
 /* F0 PCI Header/Bridge Configuration Registers */
 #define SCx200_DOCCS_BASE 0x78	/* DOCCS Base Address Register */
 #define SCx200_DOCCS_CTRL 0x7c	/* DOCCS Control Register */
@@ -15,7 +19,7 @@
 #define SCx200_GPIO_SIZE 0x2c	/* Size of GPIO register block */
=20
 /* General Configuration Block */
-#define SCx200_CB_BASE 0x9000	/* Base fixed at 0x9000 according to errata =
*/
+#define SCx200_CB_BASE_FIXED 0x9000	/* Base fixed at 0x9000 according to e=
rrata? */
=20
 /* Watchdog Timer */
 #define SCx200_WDT_OFFSET 0x00	/* offset within configuration block */
@@ -44,9 +48,7 @@
 #define SCx200_IID 0x3c		/* IA On a Chip Identification Number Reg */
 #define SCx200_REV 0x3d		/* Revision Register */
 #define SCx200_CBA 0x3e		/* Configuration Base Address Register */
-
-/* Verify that the configuration block really is there */
-#define scx200_cb_probe(base) (inw((base) + SCx200_CBA) =3D=3D (base))
+#define SCx200_CBA_SCRATCH 0x64	/* Configuration Base Address Scratchpad *=
/
=20
 /*
     Local variables:


--=-DXPdCYsmGbmGOdrpsUcd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJgIVv+Q4flTiePgRAkIXAKDAwemZIA0qhOngFip9gocq2qgOqwCdFbgz
T0OLjSOpwTp7AGZNNCW+bUg=
=OqYO
-----END PGP SIGNATURE-----

--=-DXPdCYsmGbmGOdrpsUcd--

