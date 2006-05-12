Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWELKc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWELKc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWELKbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:31:53 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:45262
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751146AbWELKbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:31:34 -0400
X-Mailbox-Line: From mb@bu3sch.de Fri May 12 12:36:47 2006
Message-Id: <20060512103647.777856000@bu3sch.de>
References: <20060512103522.898597000@bu3sch.de>
User-Agent: quilt/0.45-1
Date: Fri, 12 May 2006 12:35:25 +0200
From: mb@bu3sch.de
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 3/9] Add Intel HW RNG driver
Content-Disposition: inline; filename=add-intel-hw-random.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:30.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:11:47.000000000 +0200
@@ -9,3 +9,16 @@
 	  Hardware Random Number Generator Core infrastructure.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_INTEL
+	tristate "Intel HW Random Number Generator support"
+	depends on HW_RANDOM && (X86 || IA64) && PCI
+	default y
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Intel i8xx-based motherboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called intel-rng.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-08 00:11:30.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-08 00:11:35.000000000 +0200
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_HW_RANDOM) += core.o
+obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
Index: hwrng/drivers/char/hw_random/intel-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/intel-rng.c	2006-05-08 00:11:35.000000000 +0200
@@ -0,0 +1,198 @@
+/*
+ * RNG driver for Intel RNGs
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
+/*
+ * RNG registers
+ */
+#define INTEL_RNG_HW_STATUS			0
+#define         INTEL_RNG_PRESENT		0x40
+#define         INTEL_RNG_ENABLED		0x01
+#define INTEL_RNG_STATUS			1
+#define         INTEL_RNG_DATA_PRESENT		0x01
+#define INTEL_RNG_DATA				2
+
+/*
+ * Magic address at which Intel PCI bridges locate the RNG
+ */
+#define INTEL_RNG_ADDR				0xFFBC015F
+#define INTEL_RNG_ADDR_LEN			3
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
+	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE(pci, pci_tbl);
+
+
+static inline u8 hwstatus_get(void __iomem *mem)
+{
+	return readb(mem + INTEL_RNG_HW_STATUS);
+}
+
+static inline u8 hwstatus_set(void __iomem *mem,
+			      u8 hw_status)
+{
+	writeb(hw_status, mem + INTEL_RNG_HW_STATUS);
+	return hwstatus_get(mem);
+}
+
+static int intel_rng_data_present(struct hwrng *rng)
+{
+	void __iomem *mem = (void __iomem *)rng->priv;
+
+	return !!(readb(mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT);
+}
+
+static int intel_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *mem = (void __iomem *)rng->priv;
+
+	*data = readb(mem + INTEL_RNG_DATA);
+
+	return 1;
+}
+
+static int intel_rng_init(struct hwrng *rng)
+{
+	void __iomem *mem = (void __iomem *)rng->priv;
+	u8 hw_status;
+	int err = -EIO;
+
+	hw_status = hwstatus_get(mem);
+	/* turn RNG h/w on, if it's off */
+	if ((hw_status & INTEL_RNG_ENABLED) == 0)
+		hw_status = hwstatus_set(mem, hw_status | INTEL_RNG_ENABLED);
+	if ((hw_status & INTEL_RNG_ENABLED) == 0) {
+		printk(KERN_ERR PFX "cannot enable RNG, aborting\n");
+		goto out;
+	}
+	err = 0;
+out:
+	return err;
+}
+
+static void intel_rng_cleanup(struct hwrng *rng)
+{
+	void __iomem *mem = (void __iomem *)rng->priv;
+	u8 hw_status;
+
+	hw_status = hwstatus_get(mem);
+	if (hw_status & INTEL_RNG_ENABLED)
+		hwstatus_set(mem, hw_status & ~INTEL_RNG_ENABLED);
+	else
+		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
+}
+
+
+static struct hwrng intel_rng = {
+	.name		= "intel",
+	.init		= intel_rng_init,
+	.cleanup	= intel_rng_cleanup,
+	.data_present	= intel_rng_data_present,
+	.data_read	= intel_rng_data_read,
+};
+
+
+static int __init mod_init(void)
+{
+	int err = -ENODEV;
+	struct pci_dev *pdev = NULL;
+	const struct pci_device_id *ent;
+	void __iomem *mem;
+	u8 hw_status;
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
+	err = -ENOMEM;
+	mem = ioremap(INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
+	if (!mem)
+		goto out;
+	intel_rng.priv = (unsigned long)mem;
+
+	/* Check for Intel 82802 */
+	err = -ENODEV;
+	hw_status = hwstatus_get(mem);
+	if ((hw_status & INTEL_RNG_PRESENT) == 0)
+		goto err_unmap;
+
+	printk(KERN_INFO "Intel 82802 RNG detected\n");
+	err = hwrng_register(&intel_rng);
+	if (err) {
+		printk(KERN_ERR PFX "RNG registering failed (%d)\n",
+		       err);
+		goto out;
+	}
+out:
+	return err;
+
+err_unmap:
+	iounmap(mem);
+	goto out;
+}
+
+static void __exit mod_exit(void)
+{
+	void __iomem *mem = (void __iomem *)intel_rng.priv;
+
+	hwrng_unregister(&intel_rng);
+	iounmap(mem);
+}
+
+subsys_initcall(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W RNG driver for Intel chipsets");
+MODULE_LICENSE("GPL");

--

