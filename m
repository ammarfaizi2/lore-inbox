Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263163AbTCMXzP>; Thu, 13 Mar 2003 18:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbTCMXzG>; Thu, 13 Mar 2003 18:55:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262922AbTCMXx4>;
	Thu, 13 Mar 2003 18:53:56 -0500
Message-ID: <3E711CA8.6080706@pobox.com>
Date: Thu, 13 Mar 2003 19:04:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 4/5] rng driver update
References: <3E711C0A.40705@pobox.com>
In-Reply-To: <3E711C0A.40705@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------010200030509020802010102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200030509020802010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010200030509020802010102
Content-Type: text/plain;
 name="patch.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.4"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1107  -> 1.1108 
#	drivers/char/Kconfig	1.9     -> 1.10   
#	drivers/char/hw_random.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/13	jgarzik@redhat.com	1.1108
# [hw_random] add support for VIA Nehemiah RNG ("xstore" instruction)
# --------------------------------------------
#
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Thu Mar 13 18:53:05 2003
+++ b/drivers/char/Kconfig	Thu Mar 13 18:53:05 2003
@@ -710,7 +710,7 @@
 	  If you're not sure, say N.
 
 config HW_RANDOM
-	tristate "Intel/AMD H/W Random Number Generator support"
+	tristate "Intel/AMD/Via H/W Random Number Generator support"
 	depends on (X86 || IA64) && PCI
 	---help---
 	  This driver provides kernel-side support for the Random Number
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- a/drivers/char/hw_random.c	Thu Mar 13 18:53:05 2003
+++ b/drivers/char/hw_random.c	Thu Mar 13 18:53:05 2003
@@ -1,5 +1,5 @@
 /*
- 	Hardware driver for the Intel/AMD Random Number Generators (RNG)
+ 	Hardware driver for the Intel/AMD/Via Random Number Generators (RNG)
 	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
  
  	derived from
@@ -35,6 +35,11 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 
+#ifdef __i386__
+#include <asm/msr.h>
+#include <asm/cpufeature.h>
+#endif
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -88,6 +93,11 @@
 static unsigned int amd_data_present (void);
 static u32 amd_data_read (void);
 
+static int __init via_init(struct pci_dev *dev);
+static void __exit via_cleanup(void);
+static unsigned int via_data_present (void);
+static u32 via_data_read (void);
+
 struct rng_operations {
 	int (*init) (struct pci_dev *dev);
 	void (*cleanup) (void);
@@ -117,6 +127,7 @@
 	rng_hw_none,
 	rng_hw_intel,
 	rng_hw_amd,
+	rng_hw_via,
 };
 
 static struct rng_operations rng_vendor_ops[] __initdata = {
@@ -129,6 +140,9 @@
 
 	/* rng_hw_amd */
 	{ amd_init, amd_cleanup, amd_data_present, amd_data_read, 4 },
+
+	/* rng_hw_via */
+	{ via_init, via_cleanup, via_data_present, via_data_read, 1 },
 };
 
 /*
@@ -332,6 +346,127 @@
 
 /***********************************************************************
  *
+ * Via RNG operations
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
+u32 via_rng_datum;
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
+static unsigned int via_data_present(void)
+{
+	u32 bytes_out;
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
+	via_rng_datum = 0; /* paranoia, not really necessary */
+	bytes_out = xstore(&via_rng_datum, VIA_RNG_CHUNK_1) & VIA_XSTORE_CNT_MASK;
+	if (bytes_out == 0)
+		return 0;
+
+	return 1;
+}
+
+static u32 via_data_read(void)
+{
+	return via_rng_datum;
+}
+
+static int __init via_init(struct pci_dev *dev)
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
+		printk(KERN_ERR PFX "cannot enable Via C3 RNG, aborting\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit via_cleanup(void)
+{
+	u32 lo, hi;
+
+	rdmsr(MSR_VIA_RNG, lo, hi);
+	lo &= ~VIA_RNG_ENABLE;
+	wrmsr(MSR_VIA_RNG, lo, hi);
+}
+
+
+/***********************************************************************
+ *
  * /dev/hwrandom character device handling (major 10, minor 183)
  *
  */
@@ -470,6 +605,15 @@
 			goto match;
 		}
 	}
+
+#ifdef __i386__
+	/* Probe for Via RNG */
+	if (cpu_has_xstore) {
+		rng_ops = &rng_vendor_ops[rng_hw_via];
+		pdev = NULL;
+		goto match;
+	}
+#endif
 
 	DPRINTK ("EXIT, returning -ENODEV\n");
 	return -ENODEV;

--------------010200030509020802010102--

