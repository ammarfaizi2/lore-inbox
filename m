Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262489AbTCMSdH>; Thu, 13 Mar 2003 13:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTCMSdH>; Thu, 13 Mar 2003 13:33:07 -0500
Received: from havoc.daloft.com ([64.213.145.173]:49856 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262489AbTCMSdC>;
	Thu, 13 Mar 2003 13:33:02 -0500
Date: Thu, 13 Mar 2003 13:43:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, davej@suse.de, alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] cpu/hw_random cleanups
Message-ID: <20030313184343.GA7246@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the requested cleanups to cpu capabilities and hw_random.c.

For x86 experts, the new cpu cap words are what needs looking over.
For example, I wonder if storing Intel's cpuid(0x00000001) ecx
register output is wise on older Intel cpus.  I worry about garbage
appearing there.  Is that a false worry?

This has only been tested on Via Nehemiah CPUs...  I have a laptop with
an Intel RNG on it at home, and will be testing with that later on
tonight to make sure nothing is broken.  I'm hoping Alan or somebody can
test AMD RNG... if not I'll poke around work and see if there are any
boxes I can test on.

WRT hw_random, the main change there is to allow multiple independent
openers to read(2) simultaneously, by removing the semaphore that
limited userspace to a single open(2)er.

Comments welcome.  This patch is to be considered as a fourth patch in
the previously-posted hw_random series.

	Jeff






===== arch/i386/kernel/cpu/centaur.c 1.7 vs edited =====
--- 1.7/arch/i386/kernel/cpu/centaur.c	Tue Mar 11 21:35:40 2003
+++ edited/arch/i386/kernel/cpu/centaur.c	Thu Mar 13 13:31:08 2003
@@ -256,9 +256,10 @@
 	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
 		set_bit(X86_FEATURE_CENTAUR_EFF, c->x86_capability);
 
-		/* test for on-chip RNG */
-		if (cpuid_edx(0xC0000001) & (1 << 2))
-			set_bit(X86_FEATURE_XSTORE, c->x86_capability);
+		/* store Centaur Extended Feature Flags as
+		 * word 5 of the CPU capability bit array
+		 */
+		c->x86_capability[5] = cpuid_edx(0xC0000001);
 	}
 
 	switch (c->x86_model) {
===== arch/i386/kernel/cpu/common.c 1.19 vs edited =====
--- 1.19/arch/i386/kernel/cpu/common.c	Mon Mar 10 13:20:30 2003
+++ edited/arch/i386/kernel/cpu/common.c	Thu Mar 13 13:30:54 2003
@@ -211,9 +211,10 @@
 	
 		/* Intel-defined flags: level 0x00000001 */
 		if ( c->cpuid_level >= 0x00000001 ) {
-			u32 capability;
-			cpuid(0x00000001, &tfms, &junk, &junk, &capability);
+			u32 capability, excap;
+			cpuid(0x00000001, &tfms, &junk, &excap, &capability);
 			c->x86_capability[0] = capability;
+			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
 			c->x86_mask = tfms & 15;
===== arch/i386/kernel/cpu/proc.c 1.9 vs edited =====
--- 1.9/arch/i386/kernel/cpu/proc.c	Tue Mar 11 21:35:40 2003
+++ edited/arch/i386/kernel/cpu/proc.c	Thu Mar 13 13:31:29 2003
@@ -38,7 +38,19 @@
 
 		/* Other (Linux-defined) */
 		"cxmmx", "k6_mtrr", "cyrix_arr", "centaur_mcr",
-		"centaur_eff", "xstore", NULL, NULL,
+		"centaur_eff", NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+		/* Intel-defined (#2) */
+		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, NULL,
+		"tm2", NULL, "cnxt_id", NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+
+		/* VIA/Cyrix/Centaur-defined */
+		NULL, NULL, "xstore", NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
===== drivers/char/Kconfig 1.10 vs edited =====
--- 1.10/drivers/char/Kconfig	Tue Mar 11 21:35:40 2003
+++ edited/drivers/char/Kconfig	Thu Mar 13 12:26:48 2003
@@ -710,12 +710,12 @@
 	  If you're not sure, say N.
 
 config HW_RANDOM
-	tristate "Intel/AMD/Via H/W Random Number Generator support"
+	tristate "Intel/AMD/VIA HW Random Number Generator support"
 	depends on (X86 || IA64) && PCI
 	---help---
 	  This driver provides kernel-side support for the Random Number
 	  Generator hardware found on Intel i8xx-based motherboards,
-	  and AMD 76x-based motherboards.
+	  AMD 76x-based motherboards, and Via Nehemiah CPUs.
 
 	  Provides a character driver, used to read() entropy data.
 
===== drivers/char/hw_random.c 1.6 vs edited =====
--- 1.6/drivers/char/hw_random.c	Tue Mar 11 21:35:40 2003
+++ edited/drivers/char/hw_random.c	Thu Mar 13 12:27:14 2003
@@ -1,5 +1,5 @@
 /*
- 	Hardware driver for the Intel/AMD/Via Random Number Generators (RNG)
+ 	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
 	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
  
  	derived from
@@ -79,22 +79,21 @@
 #define RNG_MISCDEV_MINOR		183 /* official */
 
 static int rng_dev_open (struct inode *inode, struct file *filp);
-static int rng_dev_release (struct inode *inode, struct file *filp);
 static ssize_t rng_dev_read (struct file *filp, char *buf, size_t size,
 			     loff_t * offp);
 
 static int __init intel_init (struct pci_dev *dev);
-static void __exit intel_cleanup(void);
+static void intel_cleanup(void);
 static unsigned int intel_data_present (void);
 static u32 intel_data_read (void);
 
 static int __init amd_init (struct pci_dev *dev);
-static void __exit amd_cleanup(void);
+static void amd_cleanup(void);
 static unsigned int amd_data_present (void);
 static u32 amd_data_read (void);
 
 static int __init via_init(struct pci_dev *dev);
-static void __exit via_cleanup(void);
+static void via_cleanup(void);
 static unsigned int via_data_present (void);
 static u32 via_data_read (void);
 
@@ -107,12 +106,9 @@
 };
 static struct rng_operations *rng_ops;
 
-static struct semaphore rng_open_sem;	/* Semaphore for serializing rng_open/release */
-
 static struct file_operations rng_chrdev_ops = {
 	.owner		= THIS_MODULE,
 	.open		= rng_dev_open,
-	.release	= rng_dev_release,
 	.read		= rng_dev_read,
 };
 
@@ -262,7 +258,7 @@
 	return rc;
 }
 
-static void __exit intel_cleanup(void)
+static void intel_cleanup(void)
 {
 	u8 hw_status;
 
@@ -333,7 +329,7 @@
 	return rc;
 }
 
-static void __exit amd_cleanup(void)
+static void amd_cleanup(void)
 {
 	u8 rnen;
 
@@ -346,7 +342,7 @@
 
 /***********************************************************************
  *
- * Via RNG operations
+ * VIA RNG operations
  *
  */
 
@@ -448,14 +444,14 @@
 	   unneeded */
 	rdmsr(MSR_VIA_RNG, lo, hi);
 	if ((lo & VIA_RNG_ENABLE) == 0) {
-		printk(KERN_ERR PFX "cannot enable Via C3 RNG, aborting\n");
+		printk(KERN_ERR PFX "cannot enable VIA C3 RNG, aborting\n");
 		return -ENODEV;
 	}
 
 	return 0;
 }
 
-static void __exit via_cleanup(void)
+static void via_cleanup(void)
 {
 	u32 lo, hi;
 
@@ -473,26 +469,12 @@
 
 static int rng_dev_open (struct inode *inode, struct file *filp)
 {
+	/* enforce read-only access to this chrdev */
 	if ((filp->f_mode & FMODE_READ) == 0)
 		return -EINVAL;
 	if (filp->f_mode & FMODE_WRITE)
 		return -EINVAL;
 
-	/* wait for device to become free */
-	if (filp->f_flags & O_NONBLOCK) {
-		if (down_trylock (&rng_open_sem))
-			return -EAGAIN;
-	} else {
-		if (down_interruptible (&rng_open_sem))
-			return -ERESTARTSYS;
-	}
-	return 0;
-}
-
-
-static int rng_dev_release (struct inode *inode, struct file *filp)
-{
-	up(&rng_open_sem);
 	return 0;
 }
 
@@ -595,8 +577,6 @@
 
 	DPRINTK ("ENTER\n");
 
-	init_MUTEX (&rng_open_sem);
-
 	/* Probe for Intel, AMD RNGs */
 	pci_for_each_dev(pdev) {
 		ent = pci_match_device (rng_pci_tbl, pdev);
@@ -607,7 +587,7 @@
 	}
 
 #ifdef __i386__
-	/* Probe for Via RNG */
+	/* Probe for VIA RNG */
 	if (cpu_has_xstore) {
 		rng_ops = &rng_vendor_ops[rng_hw_via];
 		pdev = NULL;
===== include/asm-i386/cpufeature.h 1.7 vs edited =====
--- 1.7/include/asm-i386/cpufeature.h	Tue Mar 11 21:35:40 2003
+++ edited/include/asm-i386/cpufeature.h	Thu Mar 13 13:31:40 2003
@@ -9,9 +9,9 @@
 
 #include <linux/bitops.h>
 
-#define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
+#define NCAPINTS	6	/* Currently we have 6 32-bit words worth of info */
 
-/* Intel-defined CPU features, CPUID level 0x00000001, word 0 */
+/* Intel-defined CPU features, CPUID level 0x00000001 (edx), word 0 */
 #define X86_FEATURE_FPU		(0*32+ 0) /* Onboard FPU */
 #define X86_FEATURE_VME		(0*32+ 1) /* Virtual Mode Extensions */
 #define X86_FEATURE_DE		(0*32+ 2) /* Debugging Extensions */
@@ -64,7 +64,11 @@
 #define X86_FEATURE_CYRIX_ARR	(3*32+ 2) /* Cyrix ARRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_MCR	(3*32+ 3) /* Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_CENTAUR_EFF	(3*32+ 4) /* Centaur Extended Feature Flags */
-#define X86_FEATURE_XSTORE	(3*32+ 5) /* on-CPU RNG present (xstore insn) */
+
+/* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
+
+/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
 
 
 #define cpu_has(c, bit)		test_bit(bit, (c)->x86_capability)
