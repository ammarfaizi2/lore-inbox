Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWELKdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWELKdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWELKbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:31:51 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:51406
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751149AbWELKbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:31:41 -0400
X-Mailbox-Line: From mb@bu3sch.de Fri May 12 12:36:48 2006
Message-Id: <20060512103648.229129000@bu3sch.de>
References: <20060512103522.898597000@bu3sch.de>
User-Agent: quilt/0.45-1
Date: Fri, 12 May 2006 12:35:27 +0200
From: mb@bu3sch.de
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 5/9] Add Geode HW RNG driver
Content-Disposition: inline; filename=add-geode-hw-random.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:59.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
@@ -35,3 +35,16 @@
 	  module will be called amd-rng.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_GEODE
+	tristate "AMD Geode HW Random Number Generator support"
+	depends on HW_RANDOM && (X86 || IA64) && PCI
+	default y
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on AMD Geode based motherboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called geode-rng.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-08 00:11:52.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-08 00:12:03.000000000 +0200
@@ -5,3 +5,4 @@
 obj-$(CONFIG_HW_RANDOM) += core.o
 obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
 obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o
+obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
Index: hwrng/drivers/char/hw_random/geode-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/geode-rng.c	2006-05-08 00:12:03.000000000 +0200
@@ -0,0 +1,129 @@
+/*
+ * RNG driver for AMD Geode RNGs
+ *
+ * Copyright 2005 (c) MontaVista Software, Inc.
+ *
+ * with the majority of the code coming from:
+ *
+ * Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
+ * (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
+ *
+ * derived from
+ *
+ * Hardware driver for the AMD 768 Random Number Generator (RNG)
+ * (c) Copyright 2001 Red Hat Inc <alan@redhat.com>
+ *
+ * derived from
+ *
+ * Hardware driver for Intel i810 Random Number Generator (RNG)
+ * Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
+ * Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/hw_random.h>
+#include <asm/io.h>
+
+
+#define PFX	KBUILD_MODNAME ": "
+
+#define GEODE_RNG_DATA_REG   0x50
+#define GEODE_RNG_STATUS_REG 0x54
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id pci_tbl[] = {
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
+
+static int geode_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *mem = (void __iomem *)rng->priv;
+
+	*data = readl(mem + GEODE_RNG_DATA_REG);
+
+	return 4;
+}
+
+static int geode_rng_data_present(struct hwrng *rng)
+{
+	void __iomem *mem = (void __iomem *)rng->priv;
+
+	return !!(readl(mem + GEODE_RNG_STATUS_REG));
+}
+
+
+static struct hwrng geode_rng = {
+	.name		= "geode",
+	.data_present	= geode_rng_data_present,
+	.data_read	= geode_rng_data_read,
+};
+
+
+static int __init mod_init(void)
+{
+	int err = -ENODEV;
+	struct pci_dev *pdev = NULL;
+	const struct pci_device_id *ent;
+	void __iomem *mem;
+	unsigned long rng_base;
+
+	for_each_pci_dev(pdev) {
+		ent = pci_match_id(pci_tbl, pdev);
+		if (ent)
+			goto found;
+	}
+	/* Device not found. */
+	goto out;
+
+found:
+	rng_base = pci_resource_start(pdev, 0);
+	if (rng_base == 0)
+		goto out;
+	err = -ENOMEM;
+	mem = ioremap(rng_base, 0x58);
+	if (!mem)
+		goto out;
+	geode_rng.priv = (unsigned long)mem;
+
+	printk(KERN_INFO "AMD Geode RNG detected\n");
+	err = hwrng_register(&geode_rng);
+	if (err) {
+		printk(KERN_ERR PFX "RNG registering failed (%d)\n",
+		       err);
+		goto out;
+	}
+out:
+	return err;
+}
+
+static void __exit mod_exit(void)
+{
+	void __iomem *mem = (void __iomem *)geode_rng.priv;
+
+	hwrng_unregister(&geode_rng);
+	iounmap(mem);
+}
+
+subsys_initcall(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W RNG driver for AMD Geode chipsets");
+MODULE_LICENSE("GPL");

--

