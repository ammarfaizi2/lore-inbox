Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWEGLaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWEGLaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 07:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWEGL3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 07:29:55 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:53160
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932127AbWEGL3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 07:29:49 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 13:36:05 2006
Message-Id: <20060507113605.144341000@pc1>
References: <20060507113513.418451000@pc1>
Date: Sun, 07 May 2006 13:35:16 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, mbuesch@freenet.de,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: [patch 3/6] New Generic HW RNG
Content-Disposition: inline; filename=add-x86-hw-random.patch
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the x86 RNG.
This driver is ported from the old hw_random.c

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-07 01:40:45.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-07 01:51:25.000000000 +0200
@@ -9,3 +9,16 @@
 	  Hardware Random Number Generator Core infrastructure.
 
 	  If unsure, say Y.
+
+config X86_RNG
+	tristate "Intel/AMD/VIA HW Random Number Generator support"
+	depends on HW_RANDOM && (X86 || IA64) && PCI
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Intel i8xx-based motherboards,
+	  AMD 76x-based motherboards, and Via Nehemiah CPUs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called x86-rng.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-07 01:41:11.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-07 01:51:25.000000000 +0200
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_HW_RANDOM) += core.o
+obj-$(CONFIG_X86_RNG) += x86-rng.o
Index: hwrng/drivers/char/hw_random/x86-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/x86-rng.c	2006-05-07 00:26:57.000000000 +0200
@@ -0,0 +1,586 @@
+/*
+ * drivers/char/rng/x86.c
+ *
+ * RNG driver for Intel/AMD/VIA RNGs
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
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/random.h>
+#include <linux/miscdevice.h>
+#include <linux/smp_lock.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/hw_random.h>
+
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+
+#include <asm/io.h>
+
+
+/*
+ * debugging macros
+ */
+
+/* pr_debug() collapses to a no-op if DEBUG is not defined */
+#define DPRINTK(fmt, args...) pr_debug(PFX "%s: " fmt, __FUNCTION__ , ## args)
+
+#define RNG_VERSION "1.1.0"
+#define RNG_MODULE_NAME "x86-rng"
+#define RNG_DRIVER_NAME RNG_MODULE_NAME " hardware driver " RNG_VERSION
+#define PFX RNG_MODULE_NAME ": "
+
+#undef RNG_NDEBUG        /* define to enable lightweight runtime checks */
+#ifdef RNG_NDEBUG
+#define assert(expr)							\
+		if(!(expr)) {						\
+		printk(KERN_DEBUG PFX "Assertion failed! %s,%s,%s,"	\
+		"line=%d\n", #expr, __FILE__, __FUNCTION__, __LINE__);	\
+		}
+#else
+#define assert(expr)
+#endif
+
+static struct hwrng *x86_rng_ops;
+
+static int __init intel_init (struct hwrng *rng);
+static void intel_cleanup(struct hwrng *rng);
+static int intel_data_present (struct hwrng *rng);
+static int intel_data_read (struct hwrng *rng, u32 *data);
+
+static int __init amd_init (struct hwrng *rng);
+static void amd_cleanup(struct hwrng *rng);
+static int amd_data_present (struct hwrng *rng);
+static int amd_data_read (struct hwrng *rng, u32 *data);
+
+#ifdef __i386__
+static int __init via_init(struct hwrng *rng);
+static int via_data_present (struct hwrng *rng);
+static int via_data_read (struct hwrng *rng, u32 *data);
+#endif
+
+static int __init geode_init(struct hwrng *rng);
+static void geode_cleanup(struct hwrng *rng);
+static int geode_data_present (struct hwrng *rng);
+static int geode_data_read (struct hwrng *rng, u32 *data);
+
+enum {
+	rng_hw_none,
+	rng_hw_intel,
+	rng_hw_amd,
+#ifdef __i386__
+	rng_hw_via,
+#endif
+	rng_hw_geode,
+};
+
+static struct hwrng rng_vendor_ops[] = {
+	{ /* rng_hw_none */
+	}, { /* rng_hw_intel */
+		.name		= "intel",
+		.init		= intel_init,
+		.cleanup	= intel_cleanup,
+		.data_present	= intel_data_present,
+		.data_read	= intel_data_read,
+	}, { /* rng_hw_amd */
+		.name		= "amd",
+		.init		= amd_init,
+		.cleanup	= amd_cleanup,
+		.data_present	= amd_data_present,
+		.data_read	= amd_data_read,
+	},
+#ifdef __i386__
+	{ /* rng_hw_via */
+		.name		= "via",
+		.init		= via_init,
+		.data_present	= via_data_present,
+		.data_read	= via_data_read,
+	},
+#endif
+	{ /* rng_hw_geode */
+		.name		= "geode",
+		.init		= geode_init,
+		.cleanup	= geode_cleanup,
+		.data_present	= geode_data_present,
+		.data_read	= geode_data_read,
+	},
+};
+
+/*
+ * Data for PCI driver interface
+ *
+ * This data only exists for exporting the supported
+ * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
+ * register a pci_driver, because someone else might one day
+ * want to register another driver on the same PCI id.
+ */
+static struct pci_device_id rng_pci_tbl[] = {
+	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
+	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
+
+	{ 0x8086, 0x2418, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2430, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
+
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_geode },
+
+	{ 0, },	/* terminate list */
+};
+MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
+
+
+/***********************************************************************
+ *
+ * Intel RNG operations
+ *
+ */
+
+/*
+ * RNG registers (offsets from rng_mem)
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
+static inline u8 intel_hwstatus (void __iomem *rng_mem)
+{
+	assert (rng_mem != NULL);
+	return readb (rng_mem + INTEL_RNG_HW_STATUS);
+}
+
+static inline u8 intel_hwstatus_set (void __iomem *rng_mem, u8 hw_status)
+{
+	assert (rng_mem != NULL);
+	writeb (hw_status, rng_mem + INTEL_RNG_HW_STATUS);
+	return intel_hwstatus (rng_mem);
+}
+
+static int intel_data_present(struct hwrng *rng)
+{
+	void __iomem *rng_mem = (void __iomem *)rng->priv;
+
+	assert (rng_mem != NULL);
+	return (readb (rng_mem + INTEL_RNG_STATUS) & INTEL_RNG_DATA_PRESENT) ?
+		1 : 0;
+}
+
+static int intel_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *rng_mem = (void __iomem *)rng->priv;
+
+	assert (rng_mem != NULL);
+	*data = readb (rng_mem + INTEL_RNG_DATA);
+
+	return 1;
+}
+
+static int __init intel_init(struct hwrng *rng)
+{
+	void __iomem *rng_mem;
+	int rc;
+	u8 hw_status;
+
+	DPRINTK ("ENTER\n");
+
+	rng_mem = ioremap (INTEL_RNG_ADDR, INTEL_RNG_ADDR_LEN);
+	if (rng_mem == NULL) {
+		printk (KERN_ERR PFX "cannot ioremap RNG Memory\n");
+		rc = -EBUSY;
+		goto err_out;
+	}
+	rng->priv = (unsigned long)rng_mem;
+
+	/* Check for Intel 82802 */
+	hw_status = intel_hwstatus (rng_mem);
+	if ((hw_status & INTEL_RNG_PRESENT) == 0) {
+		printk (KERN_ERR PFX "RNG not detected\n");
+		rc = -ENODEV;
+		goto err_out_free_map;
+	}
+
+	/* turn RNG h/w on, if it's off */
+	if ((hw_status & INTEL_RNG_ENABLED) == 0)
+		hw_status = intel_hwstatus_set (rng_mem, hw_status | INTEL_RNG_ENABLED);
+	if ((hw_status & INTEL_RNG_ENABLED) == 0) {
+		printk (KERN_ERR PFX "cannot enable RNG, aborting\n");
+		rc = -EIO;
+		goto err_out_free_map;
+	}
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out_free_map:
+	iounmap (rng_mem);
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+static void intel_cleanup(struct hwrng *rng)
+{
+	void __iomem *rng_mem = (void __iomem *)rng->priv;
+	u8 hw_status;
+
+	hw_status = intel_hwstatus (rng_mem);
+	if (hw_status & INTEL_RNG_ENABLED)
+		intel_hwstatus_set (rng_mem, hw_status & ~INTEL_RNG_ENABLED);
+	else
+		printk(KERN_WARNING PFX "unusual: RNG already disabled\n");
+	iounmap(rng_mem);
+}
+
+/***********************************************************************
+ *
+ * AMD RNG operations
+ *
+ */
+
+static struct pci_dev *amd_pdev;
+
+static int amd_data_present (struct hwrng *rng)
+{
+	u32 pmbase = (u32)rng->priv;
+
+      	return !!(inl(pmbase + 0xF4) & 1);
+}
+
+
+static int amd_data_read (struct hwrng *rng, u32 *data)
+{
+	u32 pmbase = (u32)rng->priv;
+
+	*data = inl(pmbase + 0xF0);
+
+	return 4;
+}
+
+static int __init amd_init(struct hwrng *rng)
+{
+	u32 pmbase;
+	int rc;
+	u8 rnen;
+
+	DPRINTK ("ENTER\n");
+
+	amd_pdev = (struct pci_dev *)rng->priv;
+	pci_read_config_dword(amd_pdev, 0x58, &pmbase);
+
+	pmbase &= 0x0000FF00;
+
+	if (pmbase == 0)
+	{
+		printk (KERN_ERR PFX "power management base not set\n");
+		rc = -EIO;
+		goto err_out;
+	}
+	rng->priv = (unsigned long)pmbase;
+
+	pci_read_config_byte(amd_pdev, 0x40, &rnen);
+	rnen |= (1 << 7);	/* RNG on */
+	pci_write_config_byte(amd_pdev, 0x40, rnen);
+
+	pci_read_config_byte(amd_pdev, 0x41, &rnen);
+	rnen |= (1 << 7);	/* PMIO enable */
+	pci_write_config_byte(amd_pdev, 0x41, rnen);
+
+	pr_info( PFX "AMD768 system management I/O registers at 0x%X.\n",
+			pmbase);
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+
+err_out:
+	DPRINTK ("EXIT, returning %d\n", rc);
+	return rc;
+}
+
+static void amd_cleanup(struct hwrng *rng)
+{
+	u8 rnen;
+
+	pci_read_config_byte(amd_pdev, 0x40, &rnen);
+	rnen &= ~(1 << 7);	/* RNG off */
+	pci_write_config_byte(amd_pdev, 0x40, rnen);
+	amd_pdev = NULL;
+
+	/* FIXME: twiddle pmio, also? */
+}
+
+#ifdef __i386__
+/***********************************************************************
+ *
+ * VIA RNG operations
+ *
+ */
+
+enum {
+	VIA_STRFILT_CNT_SHIFT	= 16,
+	VIA_STRFILT_FAIL	= (1 << 15),
+	VIA_STRFILT_ENABLE	= (1 << 14),
+	VIA_RAWBITS_ENABLE	= (1 << 13),
+	VIA_RNG_ENABLE		= (1 << 6),
+	VIA_XSTORE_CNT_MASK	= 0x0F,
+
+	VIA_RNG_CHUNK_8		= 0x00,	/* 64 rand bits, 64 stored bits */
+	VIA_RNG_CHUNK_4		= 0x01,	/* 32 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_4_MASK	= 0xFFFFFFFF,
+	VIA_RNG_CHUNK_2		= 0x02,	/* 16 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_2_MASK	= 0xFFFF,
+	VIA_RNG_CHUNK_1		= 0x03,	/* 8 rand bits, 32 stored bits */
+	VIA_RNG_CHUNK_1_MASK	= 0xFF,
+};
+
+/*
+ * Investigate using the 'rep' prefix to obtain 32 bits of random data
+ * in one insn.  The upside is potentially better performance.  The
+ * downside is that the instruction becomes no longer atomic.  Due to
+ * this, just like familiar issues with /dev/random itself, the worst
+ * case of a 'rep xstore' could potentially pause a cpu for an
+ * unreasonably long time.  In practice, this condition would likely
+ * only occur when the hardware is failing.  (or so we hope :))
+ *
+ * Another possible performance boost may come from simply buffering
+ * until we have 4 bytes, thus returning a u32 at a time,
+ * instead of the current u8-at-a-time.
+ */
+
+static inline u32 xstore(u32 *addr, u32 edx_in)
+{
+	u32 eax_out;
+
+	asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=%0) */"
+		:"=m"(*addr), "=a"(eax_out)
+		:"D"(addr), "d"(edx_in));
+
+	return eax_out;
+}
+
+static int via_data_present(struct hwrng *rng)
+{
+	u32 bytes_out;
+	u32 *via_rng_datum = (u32 *)(&rng->priv);
+
+	/* We choose the recommended 1-byte-per-instruction RNG rate,
+	 * for greater randomness at the expense of speed.  Larger
+	 * values 2, 4, or 8 bytes-per-instruction yield greater
+	 * speed at lesser randomness.
+	 *
+	 * If you change this to another VIA_CHUNK_n, you must also
+	 * change the ->n_bytes values in rng_vendor_ops[] tables.
+	 * VIA_CHUNK_8 requires further code changes.
+	 *
+	 * A copy of MSR_VIA_RNG is placed in eax_out when xstore
+	 * completes.
+	 */
+
+	*via_rng_datum = 0; /* paranoia, not really necessary */
+	bytes_out = xstore(via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MASK;
+	if (bytes_out == 0)
+		return 0;
+
+	return 1;
+}
+
+static int via_data_read(struct hwrng *rng, u32 *data)
+{
+	u32 via_rng_datum = (u32)rng->priv;
+
+	*data = via_rng_datum;
+
+	return 1;
+}
+
+static int __init via_init(struct hwrng *rng)
+{
+	u32 lo, hi, old_lo;
+
+	/* Control the RNG via MSR.  Tread lightly and pay very close
+	 * close attention to values written, as the reserved fields
+	 * are documented to be "undefined and unpredictable"; but it
+	 * does not say to write them as zero, so I make a guess that
+	 * we restore the values we find in the register.
+	 */
+	rdmsr(MSR_VIA_RNG, lo, hi);
+
+	old_lo = lo;
+	lo &= ~(0x7f << VIA_STRFILT_CNT_SHIFT);
+	lo &= ~VIA_XSTORE_CNT_MASK;
+	lo &= ~(VIA_STRFILT_ENABLE | VIA_STRFILT_FAIL | VIA_RAWBITS_ENABLE);
+	lo |= VIA_RNG_ENABLE;
+
+	if (lo != old_lo)
+		wrmsr(MSR_VIA_RNG, lo, hi);
+
+	/* perhaps-unnecessary sanity check; remove after testing if
+	   unneeded */
+	rdmsr(MSR_VIA_RNG, lo, hi);
+	if ((lo & VIA_RNG_ENABLE) == 0) {
+		printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+#endif
+
+/***********************************************************************
+ *
+ * AMD Geode RNG operations
+ *
+ */
+
+#define GEODE_RNG_DATA_REG   0x50
+#define GEODE_RNG_STATUS_REG 0x54
+
+static int geode_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *geode_rng_base = (void __iomem *)rng->priv;
+
+	assert(geode_rng_base != NULL);
+	*data = readl(geode_rng_base + GEODE_RNG_DATA_REG);
+
+	return 4;
+}
+
+static int geode_data_present(struct hwrng *rng)
+{
+	void __iomem *geode_rng_base = (void __iomem *)rng->priv;
+	u32 val;
+
+	assert(geode_rng_base != NULL);
+	val = readl(geode_rng_base + GEODE_RNG_STATUS_REG);
+
+	return !!val;
+}
+
+static void geode_cleanup(struct hwrng *rng)
+{
+	void __iomem *geode_rng_base = (void __iomem *)rng->priv;
+
+	iounmap(geode_rng_base);
+  	geode_rng_base = NULL;
+}
+
+static int geode_init(struct hwrng *rng)
+{
+	void __iomem *geode_rng_base;
+	struct pci_dev *dev = (struct pci_dev *)rng->priv;
+	unsigned long rng_base = pci_resource_start(dev, 0);
+
+	if (rng_base == 0)
+		return 1;
+
+	geode_rng_base = ioremap(rng_base, 0x58);
+
+	if (geode_rng_base == NULL) {
+		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
+		return -EBUSY;
+	}
+	rng->priv = (unsigned long)geode_rng_base;
+
+	return 0;
+}
+
+
+/*
+ * rng_init - initialize RNG module
+ */
+static int __init x86_rng_init(void)
+{
+	int rc;
+	struct pci_dev *pdev = NULL;
+	const struct pci_device_id *ent;
+
+	DPRINTK ("ENTER\n");
+
+	/* Probe for Intel, AMD RNGs */
+	for_each_pci_dev(pdev) {
+		ent = pci_match_id(rng_pci_tbl, pdev);
+		if (ent) {
+			x86_rng_ops = &rng_vendor_ops[ent->driver_data];
+			goto match;
+		}
+	}
+
+	/* Probe for VIA RNG */
+	if (cpu_has_xstore) {
+		x86_rng_ops = &rng_vendor_ops[rng_hw_via];
+		pdev = NULL;
+		goto match;
+	}
+
+	DPRINTK ("EXIT, returning -ENODEV\n");
+	return -ENODEV;
+
+match:
+	x86_rng_ops->priv = (unsigned long)pdev;
+	rc = hwrng_register(x86_rng_ops);
+	if (rc)
+		return rc;
+
+	pr_info( RNG_DRIVER_NAME " loaded\n");
+
+	DPRINTK ("EXIT, returning 0\n");
+	return 0;
+}
+
+/*
+ * rng_init - shutdown RNG module
+ */
+static void __exit x86_rng_exit (void)
+{
+	DPRINTK ("ENTER\n");
+
+	hwrng_unregister(x86_rng_ops);
+
+	DPRINTK ("EXIT\n");
+}
+
+subsys_initcall(x86_rng_init);
+module_exit(x86_rng_exit);
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W RNG driver for Intel/AMD/VIA chipsets");
+MODULE_LICENSE("GPL");

--

