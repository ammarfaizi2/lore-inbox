Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWELKdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWELKdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWELKbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:31:49 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:49358
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751148AbWELKbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:31:38 -0400
X-Mailbox-Line: From mb@bu3sch.de Fri May 12 12:36:48 2006
Message-Id: <20060512103648.022350000@bu3sch.de>
References: <20060512103522.898597000@bu3sch.de>
User-Agent: quilt/0.45-1
Date: Fri, 12 May 2006 12:35:26 +0200
From: mb@bu3sch.de
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 4/9] Add AMD HW RNG driver
Content-Disposition: inline; filename=add-amd-hw-random.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/amd-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/amd-rng.c	2006-05-08 00:11:52.000000000 +0200
@@ -0,0 +1,152 @@
+/*
+ * RNG driver for AMD RNGs
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
+	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE (pci, pci_tbl);
+
+static struct pci_dev *amd_pdev;
+
+
+static int amd_rng_data_present(struct hwrng *rng)
+{
+	u32 pmbase = (u32)rng->priv;
+
+      	return !!(inl(pmbase + 0xF4) & 1);
+}
+
+static int amd_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	u32 pmbase = (u32)rng->priv;
+
+	*data = inl(pmbase + 0xF0);
+
+	return 4;
+}
+
+static int amd_rng_init(struct hwrng *rng)
+{
+	u8 rnen;
+
+	pci_read_config_byte(amd_pdev, 0x40, &rnen);
+	rnen |= (1 << 7);	/* RNG on */
+	pci_write_config_byte(amd_pdev, 0x40, rnen);
+
+	pci_read_config_byte(amd_pdev, 0x41, &rnen);
+	rnen |= (1 << 7);	/* PMIO enable */
+	pci_write_config_byte(amd_pdev, 0x41, rnen);
+
+	return 0;
+}
+
+static void amd_rng_cleanup(struct hwrng *rng)
+{
+	u8 rnen;
+
+	pci_read_config_byte(amd_pdev, 0x40, &rnen);
+	rnen &= ~(1 << 7);	/* RNG off */
+	pci_write_config_byte(amd_pdev, 0x40, rnen);
+}
+
+
+static struct hwrng amd_rng = {
+	.name		= "amd",
+	.init		= amd_rng_init,
+	.cleanup	= amd_rng_cleanup,
+	.data_present	= amd_rng_data_present,
+	.data_read	= amd_rng_data_read,
+};
+
+
+static int __init mod_init(void)
+{
+	int err = -ENODEV;
+	struct pci_dev *pdev = NULL;
+	const struct pci_device_id *ent;
+	u32 pmbase;
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
+	err = pci_read_config_dword(pdev, 0x58, &pmbase);
+	if (err)
+		goto out;
+	err = -EIO;
+	pmbase &= 0x0000FF00;
+	if (pmbase == 0)
+		goto out;
+	amd_rng.priv = (unsigned long)pmbase;
+	amd_pdev = pdev;
+
+	printk(KERN_INFO "AMD768 RNG detected\n");
+	err = hwrng_register(&amd_rng);
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
+	hwrng_unregister(&amd_rng);
+}
+
+subsys_initcall(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W RNG driver for AMD chipsets");
+MODULE_LICENSE("GPL");
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:47.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:11:59.000000000 +0200
@@ -22,3 +22,16 @@
 	  module will be called intel-rng.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_AMD
+	tristate "AMD HW Random Number Generator support"
+	depends on HW_RANDOM && (X86 || IA64) && PCI
+	default y
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on AMD 76x-based motherboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called amd-rng.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-08 00:11:35.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-08 00:11:52.000000000 +0200
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_HW_RANDOM) += core.o
 obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
+obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o

--

