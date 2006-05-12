Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWELKbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWELKbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWELKbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:31:48 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:53198
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751150AbWELKbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:31:44 -0400
X-Mailbox-Line: From mb@bu3sch.de Fri May 12 12:36:48 2006
Message-Id: <20060512103648.429736000@bu3sch.de>
References: <20060512103522.898597000@bu3sch.de>
User-Agent: quilt/0.45-1
Date: Fri, 12 May 2006 12:35:28 +0200
From: mb@bu3sch.de
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
Subject: [patch 6/9] Add VIA HW RNG driver
Content-Disposition: inline; filename=add-via-hw-random.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Index: hwrng/drivers/char/hw_random/Kconfig
===================================================================
--- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
+++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:20.000000000 +0200
@@ -48,3 +48,16 @@
 	  module will be called geode-rng.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_VIA
+	tristate "VIA HW Random Number Generator support"
+	depends on HW_RANDOM && X86
+	default y
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on VIA based motherboards.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called via-rng.
+
+	  If unsure, say Y.
Index: hwrng/drivers/char/hw_random/Makefile
===================================================================
--- hwrng.orig/drivers/char/hw_random/Makefile	2006-05-08 00:12:03.000000000 +0200
+++ hwrng/drivers/char/hw_random/Makefile	2006-05-08 00:12:12.000000000 +0200
@@ -6,3 +6,4 @@
 obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
 obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o
 obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
+obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
Index: hwrng/drivers/char/hw_random/via-rng.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ hwrng/drivers/char/hw_random/via-rng.c	2006-05-08 00:12:12.000000000 +0200
@@ -0,0 +1,184 @@
+/*
+ * RNG driver for VIA RNGs
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
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+
+
+#define PFX	KBUILD_MODNAME ": "
+
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
+static int via_rng_data_present(struct hwrng *rng)
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
+	bytes_out = xstore(via_rng_datum, VIA_RNG_CHUNK_1);
+	bytes_out &= VIA_XSTORE_CNT_MASK;
+	if (bytes_out == 0)
+		return 0;
+	return 1;
+}
+
+static int via_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	u32 via_rng_datum = (u32)rng->priv;
+
+	*data = via_rng_datum;
+
+	return 1;
+}
+
+static int via_rng_init(struct hwrng *rng)
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
+
+
+static struct hwrng via_rng = {
+	.name		= "via",
+	.init		= via_rng_init,
+	.data_present	= via_rng_data_present,
+	.data_read	= via_rng_data_read,
+};
+
+
+static int __init mod_init(void)
+{
+	int err;
+
+	if (!cpu_has_xstore)
+		return -ENODEV;
+	printk(KERN_INFO "VIA RNG detected\n");
+	err = hwrng_register(&via_rng);
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
+	hwrng_unregister(&via_rng);
+}
+
+subsys_initcall(mod_init);
+module_exit(mod_exit);
+
+MODULE_AUTHOR("The Linux Kernel team");
+MODULE_DESCRIPTION("H/W RNG driver for VIA chipsets");
+MODULE_LICENSE("GPL");

--

