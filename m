Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUKHQOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUKHQOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKHQOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:14:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261865AbUKHOfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:35:05 -0500
Date: Mon, 8 Nov 2004 14:34:19 GMT
Message-Id: <200411081434.iA8EYJ3Y023602@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 16/20] FRV: Make calibrate_delay() optional
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes calibrate_delay() optional. In this architecture, it's
a waste of time since we can predict exactly what it's going to come up with
just by looking at the CPU's hardware clock registers. Thus far, we haven't
seen a board with any clock not dependent on the CPU's clock.

Signed-Off-By: dhowells@redhat.com
---
diffstat calibrate-2610rc1mm3.diff
 arch/alpha/Kconfig         |    4 ++
 arch/arm/Kconfig           |    4 ++
 arch/arm26/Kconfig         |    4 ++
 arch/cris/Kconfig          |    4 ++
 arch/h8300/Kconfig         |    4 ++
 arch/i386/Kconfig          |    4 ++
 arch/ia64/Kconfig          |    4 ++
 arch/m32r/Kconfig          |    4 ++
 arch/m68k/Kconfig          |    4 ++
 arch/m68knommu/Kconfig     |    4 ++
 arch/mips/Kconfig          |    4 ++
 arch/parisc/Kconfig        |    4 ++
 arch/ppc/Kconfig           |    4 ++
 arch/ppc64/Kconfig         |    4 ++
 arch/s390/Kconfig          |    4 ++
 arch/sh/Kconfig            |    4 ++
 arch/sh64/Kconfig          |    4 ++
 arch/sparc/Kconfig         |    4 ++
 arch/sparc64/Kconfig       |    4 ++
 arch/um/Kconfig            |    4 ++
 arch/v850/Kconfig          |    3 +
 arch/x86_64/Kconfig        |    4 ++
 include/asm-m32r/smp.h     |    1 
 include/asm-x86_64/proto.h |    1 
 include/linux/delay.h      |    1 
 init/Makefile              |    2 +
 init/calibrate.c           |   79 +++++++++++++++++++++++++++++++++++++++++++++
 init/main.c                |   70 ---------------------------------------
 28 files changed, 169 insertions(+), 72 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/alpha/Kconfig linux-2.6.10-rc1-mm3-frv/arch/alpha/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/alpha/Kconfig	2004-10-19 10:41:41.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/alpha/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -28,6 +28,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config GENERIC_ISA_DMA
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/arm/Kconfig linux-2.6.10-rc1-mm3-frv/arch/arm/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/arm/Kconfig	2004-11-05 13:15:15.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/arm/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -57,6 +57,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config GENERIC_BUST_SPINLOCK
 	bool
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/arm26/Kconfig linux-2.6.10-rc1-mm3-frv/arch/arm26/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/arm26/Kconfig	2004-10-19 10:41:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/arm26/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -45,6 +45,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config GENERIC_BUST_SPINLOCK
 	bool
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/cris/Kconfig linux-2.6.10-rc1-mm3-frv/arch/cris/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/cris/Kconfig	2004-10-19 10:41:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/cris/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -20,6 +20,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config CRIS
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/h8300/Kconfig linux-2.6.10-rc1-mm3-frv/arch/h8300/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/h8300/Kconfig	2004-10-19 10:41:43.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/h8300/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -33,6 +33,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config ISA
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/i386/Kconfig linux-2.6.10-rc1-mm3-frv/arch/i386/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/i386/Kconfig	2004-11-05 13:15:17.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/i386/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -373,6 +373,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	depends on !M386
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config X86_PPRO_FENCE
 	bool
 	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/ia64/Kconfig linux-2.6.10-rc1-mm3-frv/arch/ia64/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/ia64/Kconfig	2004-11-05 13:15:18.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/ia64/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -30,6 +30,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config TIME_INTERPOLATION
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/m32r/Kconfig linux-2.6.10-rc1-mm3-frv/arch/m32r/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/m32r/Kconfig	2004-10-19 10:41:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/m32r/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -189,6 +189,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/m68k/Kconfig linux-2.6.10-rc1-mm3-frv/arch/m68k/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/m68k/Kconfig	2004-11-05 13:15:18.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/m68k/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -21,6 +21,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 mainmenu "Linux/68k Kernel Configuration"
 
 source "init/Kconfig"
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/m68knommu/Kconfig linux-2.6.10-rc1-mm3-frv/arch/m68knommu/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/m68knommu/Kconfig	2004-11-05 13:15:18.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/m68knommu/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -29,6 +29,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "Processor type and features"
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/mips/Kconfig linux-2.6.10-rc1-mm3-frv/arch/mips/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/mips/Kconfig	2004-10-19 10:41:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/mips/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -826,6 +826,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config HAVE_DEC_LOCK
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/parisc/Kconfig linux-2.6.10-rc1-mm3-frv/arch/parisc/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/parisc/Kconfig	2004-10-19 10:41:45.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/parisc/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -32,6 +32,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config GENERIC_ISA_DMA
 	bool
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/ppc/Kconfig linux-2.6.10-rc1-mm3-frv/arch/ppc/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/ppc/Kconfig	2004-11-05 13:15:20.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/ppc/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -22,6 +22,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config HAVE_DEC_LOCK
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/ppc64/Kconfig linux-2.6.10-rc1-mm3-frv/arch/ppc64/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/ppc64/Kconfig	2004-11-05 13:15:19.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/ppc64/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -20,6 +20,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config GENERIC_ISA_DMA
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/s390/Kconfig linux-2.6.10-rc1-mm3-frv/arch/s390/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/s390/Kconfig	2004-10-19 10:41:47.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/s390/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -14,6 +14,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config GENERIC_BUST_SPINLOCK
 	bool
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sh/Kconfig linux-2.6.10-rc1-mm3-frv/arch/sh/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sh/Kconfig	2004-11-05 13:15:21.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/sh/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -25,6 +25,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "System type"
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sh64/Kconfig linux-2.6.10-rc1-mm3-frv/arch/sh64/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sh64/Kconfig	2004-10-19 10:41:47.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/sh64/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -25,6 +25,10 @@ config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config LOG_BUF_SHIFT
 	int
 	default 14
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sparc/Kconfig linux-2.6.10-rc1-mm3-frv/arch/sparc/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sparc/Kconfig	2004-11-05 13:15:21.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/sparc/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -207,6 +207,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config SUN_PM
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sparc64/Kconfig linux-2.6.10-rc1-mm3-frv/arch/sparc64/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/sparc64/Kconfig	2004-11-05 13:15:21.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/sparc64/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -186,6 +186,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 choice
 	prompt "SPARC64 Huge TLB Page Size"
 	depends on HUGETLB_PAGE
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/um/Kconfig linux-2.6.10-rc1-mm3-frv/arch/um/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/um/Kconfig	2004-11-05 13:15:22.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/um/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -31,6 +31,10 @@ config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 menu "UML-specific options"
 
 config MODE_TT
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/v850/Kconfig linux-2.6.10-rc1-mm3-frv/arch/v850/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/v850/Kconfig	2004-10-19 10:41:49.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/arch/v850/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -19,6 +19,9 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
 
 # Turn off some random 386 crap that can affect device config
 config ISA
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/arch/x86_64/Kconfig linux-2.6.10-rc1-mm3-frv/arch/x86_64/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/arch/x86_64/Kconfig	2004-11-05 13:15:23.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/arch/x86_64/Kconfig	2004-11-05 14:13:03.000000000 +0000
@@ -41,6 +41,10 @@ config RWSEM_GENERIC_SPINLOCK
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config X86_CMPXCHG
 	bool
 	default y
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-m32r/smp.h linux-2.6.10-rc1-mm3-frv/include/asm-m32r/smp.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-m32r/smp.h	2004-10-19 10:42:13.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-m32r/smp.h	2004-11-05 14:13:04.000000000 +0000
@@ -92,7 +92,6 @@ static __inline__ unsigned int num_booti
 }
 
 extern void smp_send_timer(void);
-extern void calibrate_delay(void);
 extern unsigned long send_IPI_mask_phys(cpumask_t, int, int);
 
 #endif	/* not __ASSEMBLY__ */
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-x86_64/proto.h linux-2.6.10-rc1-mm3-frv/include/asm-x86_64/proto.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-x86_64/proto.h	2004-11-05 13:15:49.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/include/asm-x86_64/proto.h	2004-11-05 14:13:04.000000000 +0000
@@ -25,7 +25,6 @@ extern void ia32_syscall(void);
 extern void ia32_cstar_target(void); 
 extern void ia32_sysenter_target(void); 
 
-extern void calibrate_delay(void);
 extern void cpu_idle(void);
 extern void config_acpi_tables(void);
 extern void ia32_syscall(void);
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/delay.h linux-2.6.10-rc1-mm3-frv/include/linux/delay.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/linux/delay.h	2004-10-19 10:42:16.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/linux/delay.h	2004-11-05 14:13:04.380455487 +0000
@@ -38,6 +38,7 @@ extern unsigned long loops_per_jiffy;
 #define ndelay(x)	udelay(((x)+999)/1000)
 #endif
 
+void calibrate_delay(void);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
 
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/calibrate.c linux-2.6.10-rc1-mm3-frv/init/calibrate.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/calibrate.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/init/calibrate.c	2004-11-05 14:13:04.000000000 +0000
@@ -0,0 +1,79 @@
+/* calibrate.c: default delay calibration
+ *
+ * Excised from init/main.c
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+static unsigned long preset_lpj;
+static int __init lpj_setup(char *str)
+{
+	preset_lpj = simple_strtoul(str,NULL,0);
+	return 1;
+}
+
+__setup("lpj=", lpj_setup);
+
+/*
+ * This is the number of bits of precision for the loops_per_jiffy.  Each
+ * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
+ * better than 1%
+ */
+#define LPS_PREC 8
+
+void __devinit calibrate_delay(void)
+{
+	unsigned long ticks, loopbit;
+	int lps_precision = LPS_PREC;
+
+	if (preset_lpj) {
+		loops_per_jiffy = preset_lpj;
+		printk("Calibrating delay loop (skipped)... "
+			"%lu.%02lu BogoMIPS preset\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100);
+	} else {
+		loops_per_jiffy = (1<<12);
+
+		printk(KERN_DEBUG "Calibrating delay loop... ");
+		while ((loops_per_jiffy <<= 1) != 0) {
+			/* wait for "start of" clock tick */
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			/* Go .. */
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			ticks = jiffies - ticks;
+			if (ticks)
+				break;
+		}
+
+		/*
+		 * Do a binary approximation to get loops_per_jiffy set to
+		 * equal one clock (up to lps_precision bits)
+		 */
+		loops_per_jiffy >>= 1;
+		loopbit = loops_per_jiffy;
+		while (lps_precision-- && (loopbit >>= 1)) {
+			loops_per_jiffy |= loopbit;
+			ticks = jiffies;
+			while (ticks == jiffies)
+				/* nothing */;
+			ticks = jiffies;
+			__delay(loops_per_jiffy);
+			if (jiffies != ticks)	/* longer than 1 tick */
+				loops_per_jiffy &= ~loopbit;
+		}
+
+		/* Round the value and print it */
+		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
+			loops_per_jiffy/(500000/HZ),
+			(loops_per_jiffy/(5000/HZ)) % 100,
+			loops_per_jiffy);
+	}
+
+}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/main.c linux-2.6.10-rc1-mm3-frv/init/main.c
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/main.c	2004-11-05 13:15:51.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/init/main.c	2004-11-05 14:13:04.499445437 +0000
@@ -184,15 +179,6 @@ static int __init obsolete_checksetup(ch
 	return 0;
 }
 
-static unsigned long preset_lpj;
-static int __init lpj_setup(char *str)
-{
-	preset_lpj = simple_strtoul(str,NULL,0);
-	return 1;
-}
-
-__setup("lpj=", lpj_setup);
-
 /*
  * This should be approx 2 Bo*oMips to start (note initial shift), and will
  * still work even if initially too large, it will just take slightly longer
@@ -201,67 +191,6 @@ unsigned long loops_per_jiffy = (1<<12);
 
 EXPORT_SYMBOL(loops_per_jiffy);
 
-/*
- * This is the number of bits of precision for the loops_per_jiffy.  Each
- * bit takes on average 1.5/HZ seconds.  This (like the original) is a little
- * better than 1%
- */
-#define LPS_PREC 8
-
-void __devinit calibrate_delay(void)
-{
-	unsigned long ticks, loopbit;
-	int lps_precision = LPS_PREC;
-
-	if (preset_lpj) {
-		loops_per_jiffy = preset_lpj;
-		printk("Calibrating delay loop (skipped)... "
-			"%lu.%02lu BogoMIPS preset\n",
-			loops_per_jiffy/(500000/HZ),
-			(loops_per_jiffy/(5000/HZ)) % 100);
-	} else {
-		loops_per_jiffy = (1<<12);
-
-		printk(KERN_DEBUG "Calibrating delay loop... ");
-		while ((loops_per_jiffy <<= 1) != 0) {
-			/* wait for "start of" clock tick */
-			ticks = jiffies;
-			while (ticks == jiffies)
-				/* nothing */;
-			/* Go .. */
-			ticks = jiffies;
-			__delay(loops_per_jiffy);
-			ticks = jiffies - ticks;
-			if (ticks)
-				break;
-		}
-
-		/*
-		 * Do a binary approximation to get loops_per_jiffy set to
-		 * equal one clock (up to lps_precision bits)
-		 */
-		loops_per_jiffy >>= 1;
-		loopbit = loops_per_jiffy;
-		while (lps_precision-- && (loopbit >>= 1)) {
-			loops_per_jiffy |= loopbit;
-			ticks = jiffies;
-			while (ticks == jiffies)
-				/* nothing */;
-			ticks = jiffies;
-			__delay(loops_per_jiffy);
-			if (jiffies != ticks)	/* longer than 1 tick */
-				loops_per_jiffy &= ~loopbit;
-		}
-
-		/* Round the value and print it */
-		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
-			loops_per_jiffy/(500000/HZ),
-			(loops_per_jiffy/(5000/HZ)) % 100,
-			loops_per_jiffy);
-	}
-
-}
-
 static int __init debug_kernel(char *str)
 {
 	if (*str)
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/init/Makefile linux-2.6.10-rc1-mm3-frv/init/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-mm3/init/Makefile	2004-06-18 13:42:40.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/init/Makefile	2004-11-05 14:13:04.504445015 +0000
@@ -3,6 +3,8 @@
 #
 
 obj-y				:= main.o version.o mounts.o initramfs.o
+obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
+
 mounts-y			:= do_mounts.o
 mounts-$(CONFIG_DEVFS_FS)	+= do_mounts_devfs.o
 mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
