Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbTCLDQ6>; Tue, 11 Mar 2003 22:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263005AbTCLDQ6>; Tue, 11 Mar 2003 22:16:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35739 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263002AbTCLDQJ>;
	Tue, 11 Mar 2003 22:16:09 -0500
Message-ID: <3E6EA909.9020200@pobox.com>
Date: Tue, 11 Mar 2003 22:27:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
CC: Dave Jones <davej@codemonkey.org.uk>
Subject: [patch 3/3] add Via Nehemiah ("xstore") rng support
Content-Type: multipart/mixed;
 boundary="------------090102060507050706090702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090102060507050706090702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Via came up with a nifty feature on their "Nehemiah" generation of the 
C3 CPU: the xstore instruction.  If the 'rep' prefix is not present, the 
instruction stores 0/1/2/4/8 bytes of random data to a memory location.

This xstore instruction forms the basis of this third patch, which adds 
support for the Via RNG to the newly-modular hw_random driver.

Note that since xstore is a new instruction, GNU binutils does not 
support it.  We must use gcc inline asm to hand-code the machine 
language instruction in hexidecimal.  Eventually I will get around to 
patching GNU binutils to support xstore natively, but even then we won't 
want to force users to update their binutils to bleeding-edge-latest, I 
don't think...

Review from x86 experts is especially appreciated here, as I am from an 
x86 expert myself.

--------------090102060507050706090702
Content-Type: text/plain;
 name="patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2"

# --------------------------------------------
# 03/03/11	jgarzik@redhat.com	1.1103
# [hw_random] add support for Via Nehemiah RNG ("xstore" insn)
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/cpu/centaur.c b/arch/i386/kernel/cpu/centaur.c
--- a/arch/i386/kernel/cpu/centaur.c	Tue Mar 11 21:37:50 2003
+++ b/arch/i386/kernel/cpu/centaur.c	Tue Mar 11 21:37:50 2003
@@ -248,6 +248,36 @@
 }
 #endif
 
+static void __init init_c3(struct cpuinfo_x86 *c)
+{
+	u32  lo, hi;
+
+	/* Test for Centaur Extended Feature Flags presence */
+	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
+		set_bit(X86_FEATURE_CENTAUR_EFF, c->x86_capability);
+
+		/* test for on-chip RNG */
+		if (cpuid_edx(0xC0000001) & (1 << 2))
+			set_bit(X86_FEATURE_XSTORE, c->x86_capability);
+	}
+
+	switch (c->x86_model) {
+		case 6 ... 8:		/* Cyrix III family */
+			rdmsr (MSR_VIA_FCR, lo, hi);
+			lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
+			wrmsr (MSR_VIA_FCR, lo, hi);
+
+			set_bit(X86_FEATURE_CX8, c->x86_capability);
+			set_bit(X86_FEATURE_3DNOW, c->x86_capability);
+
+		case 9:	/* Nehemiah */
+		default:
+			get_model_name(c);
+			display_cacheinfo(c);
+			break;
+	}
+}
+
 static void __init init_centaur(struct cpuinfo_x86 *c)
 {
 	enum {
@@ -386,21 +416,7 @@
 			break;
 
 		case 6:
-			switch (c->x86_model) {
-				case 6 ... 8:		/* Cyrix III family */
-					rdmsr (MSR_VIA_FCR, lo, hi);
-					lo |= (1<<1 | 1<<7);	/* Report CX8 & enable PGE */
-					wrmsr (MSR_VIA_FCR, lo, hi);
-
-					set_bit(X86_FEATURE_CX8, c->x86_capability);
-					set_bit(X86_FEATURE_3DNOW, c->x86_capability);
-
-				case 9:	/* Nehemiah */
-				default:
-					get_model_name(c);
-					display_cacheinfo(c);
-					break;
-			}
+			init_c3(c);
 			break;
 	}
 }
diff -Nru a/arch/i386/kernel/cpu/proc.c b/arch/i386/kernel/cpu/proc.c
--- a/arch/i386/kernel/cpu/proc.c	Tue Mar 11 21:37:50 2003
+++ b/arch/i386/kernel/cpu/proc.c	Tue Mar 11 21:37:50 2003
@@ -37,7 +37,8 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Other (Linux-defined) */
-		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr", NULL, NULL, NULL, NULL,
+		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
+		"centaur_eff", "xstore", NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Tue Mar 11 21:37:50 2003
+++ b/drivers/char/Kconfig	Tue Mar 11 21:37:50 2003
@@ -710,7 +710,7 @@
 	  If you're not sure, say N.
 
 config HW_RANDOM
-	tristate "Intel/AMD H/W Random Number Generator support"
+	tristate "Intel/AMD/Via H/W Random Number Generator support"
 	depends on (X86 || IA64) && PCI
 	---help---
 	  This driver provides kernel-side support for the Random Number
diff -Nru a/drivers/char/hw_random.c b/drivers/char/hw_random.c
--- a/drivers/char/hw_random.c	Tue Mar 11 21:37:50 2003
+++ b/drivers/char/hw_random.c	Tue Mar 11 21:37:50 2003
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
diff -Nru a/include/asm-i386/cpufeature.h b/include/asm-i386/cpufeature.h
--- a/include/asm-i386/cpufeature.h	Tue Mar 11 21:37:50 2003
+++ b/include/asm-i386/cpufeature.h	Tue Mar 11 21:37:50 2003
@@ -63,6 +63,8 @@
 #define X86_FEATURE_K6_MTRR	(3*32+ 1) /* AMD K6 nonstandard MTRRs */
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
+#define X86_FEATURE_CENTAUR_EFF	(3*32+ 4) /* Centaur Extended Feature Flags */
+#define X86_FEATURE_XSTORE	(3*32+ 5) /* on-CPU RNG present (xstore insn) */
 
 
 #define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
@@ -87,6 +89,7 @@
 #define cpu_has_k6_mtrr		boot_cpu_has(X86_FEATURE_K6_MTRR)
 #define cpu_has_cyrix_arr	boot_cpu_has(X86_FEATURE_CYRIX_ARR)
 #define cpu_has_centaur_mcr	boot_cpu_has(X86_FEATURE_CENTAUR_MCR)
+#define cpu_has_xstore		boot_cpu_has(X86_FEATURE_XSTORE)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
diff -Nru a/include/asm-i386/msr.h b/include/asm-i386/msr.h
--- a/include/asm-i386/msr.h	Tue Mar 11 21:37:50 2003
+++ b/include/asm-i386/msr.h	Tue Mar 11 21:37:50 2003
@@ -218,6 +218,7 @@
 /* VIA Cyrix defined MSRs*/
 #define MSR_VIA_FCR			0x1107
 #define MSR_VIA_LONGHAUL		0x110a
+#define MSR_VIA_RNG			0x110b
 #define MSR_VIA_BCR2			0x1147
 
 /* Transmeta defined MSRs */

--------------090102060507050706090702--

