Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVCBQo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVCBQo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVCBQo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:44:57 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:37270 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262349AbVCBQoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:44:24 -0500
Date: Wed, 2 Mar 2005 17:44:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/9] s390: soft-float, 4GB swap bug, smp clean & cpu hotplug.
Message-ID: <20050302164423.GA27829@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/9] s390: soft-float, 4GB swap bug, smp clean & cpu hotplug.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Add -msoft-float to CFLAGS.
 - Remove experimantal tag from cpu hotplug.
 - Allow more than 4GB swap on a single device for 64 bit.
 - Fix race in machine_restart to make sure all cpus entered
   stopped state before reipl.
 - Cleanup: use for_each_online_cpu macro where possible.
 - Add argument brackets to __FD_SET/__FD_CLEAR/__FD_ZERO.
 - Reset cpu_present in smp startup to avoid long delays if only
   one cpu is defined.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/Kconfig                |    6 +--
 arch/s390/Makefile               |    2 -
 arch/s390/defconfig              |   11 ++++-
 arch/s390/kernel/irq.c           |   10 ++---
 arch/s390/kernel/smp.c           |   74 ++++++++++++++++++++-------------------
 drivers/s390/char/sclp_quiesce.c |   25 ++-----------
 include/asm-s390/pgtable.h       |    8 +++-
 include/asm-s390/posix_types.h   |    8 ++--
 include/asm-s390/smp.h           |   25 +++++++++++++
 9 files changed, 96 insertions(+), 73 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-03-02 17:00:07.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc2
-# Mon Jan 31 16:27:12 2005
+# Linux kernel version: 2.6.11
+# Wed Mar  2 16:57:55 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -54,6 +54,7 @@
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
+CONFIG_STOP_MACHINE=y
 
 #
 # Base setup
@@ -67,7 +68,7 @@
 CONFIG_ARCH_S390_31=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
-# CONFIG_HOTPLUG_CPU is not set
+CONFIG_HOTPLUG_CPU=y
 CONFIG_MATHEMU=y
 
 #
@@ -419,6 +420,10 @@
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+
+#
+# XFS support
+#
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
diff -urN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2005-03-02 17:00:07.000000000 +0100
@@ -84,12 +84,12 @@
 	  approximately sixteen kilobytes to the kernel image.
 
 config HOTPLUG_CPU
-	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
-	depends on SMP && EXPERIMENTAL
+	bool "Support for hot-pluggable CPUs"
+	depends on SMP
 	select HOTPLUG
 	default n
 	help
-	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  Say Y here to be able to turn CPUs off and on. CPUs
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
diff -urN linux-2.6/arch/s390/kernel/irq.c linux-2.6-patched/arch/s390/kernel/irq.c
--- linux-2.6/arch/s390/kernel/irq.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/irq.c	2005-03-02 17:00:07.000000000 +0100
@@ -25,9 +25,8 @@
 
 	if (i == 0) {
 		seq_puts(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_online_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -36,9 +35,8 @@
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_online_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
                 seq_putc(p, '\n');
 
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-03-02 17:00:07.000000000 +0100
@@ -212,29 +212,29 @@
 
 static inline void do_send_stop(void)
 {
-        int i, rc;
+        int cpu, rc;
 
         /* stop all processors */
-        for (i =  0; i < NR_CPUS; i++) {
-                if (!cpu_online(i) || smp_processor_id() == i)
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
 			continue;
 		do {
-			rc = signal_processor(i, sigp_stop);
+			rc = signal_processor(cpu, sigp_stop);
 		} while (rc == sigp_busy);
 	}
 }
 
 static inline void do_store_status(void)
 {
-        int i, rc;
+        int cpu, rc;
 
         /* store status of all processors in their lowcores (real 0) */
-        for (i =  0; i < NR_CPUS; i++) {
-                if (!cpu_online(i) || smp_processor_id() == i) 
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
 			continue;
 		do {
 			rc = signal_processor_p(
-				(__u32)(unsigned long) lowcore_ptr[i], i,
+				(__u32)(unsigned long) lowcore_ptr[cpu], cpu,
 				sigp_store_status_at_address);
 		} while(rc == sigp_busy);
         }
@@ -259,37 +259,41 @@
 /*
  * Reboot, halt and power_off routines for SMP.
  */
-static cpumask_t cpu_restart_map;
 
 static void do_machine_restart(void * __unused)
 {
+	int cpu;
 	static atomic_t cpuid = ATOMIC_INIT(-1);
 
-	cpu_clear(smp_processor_id(), cpu_restart_map);
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid) == 0) {
-		/* Wait for all other cpus to enter do_machine_restart. */
-		while (!cpus_empty(cpu_restart_map))
+	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+		signal_processor(smp_processor_id(), sigp_stop);
+
+	/* Wait for all other cpus to enter stopped state */
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+		while(!smp_cpu_not_running(cpu))
 			cpu_relax();
-		/* Store status of other cpus. */
-		do_store_status();
-		/*
-		 * Finally call reipl. Because we waited for all other
-		 * cpus to enter this function we know that they do
-		 * not hold any s390irq-locks (the cpus have been
-		 * interrupted by an external interrupt and s390irq
-		 * locks are always held disabled).
-		 */
-		if (MACHINE_IS_VM)
-			cpcmd ("IPL", NULL, 0);
-		else
-			reipl (0x10000 | S390_lowcore.ipl_device);
 	}
-	signal_processor(smp_processor_id(), sigp_stop);
+
+	/* Store status of other cpus. */
+	do_store_status();
+
+	/*
+	 * Finally call reipl. Because we waited for all other
+	 * cpus to enter this function we know that they do
+	 * not hold any s390irq-locks (the cpus have been
+	 * interrupted by an external interrupt and s390irq
+	 * locks are always held disabled).
+	 */
+	if (MACHINE_IS_VM)
+		cpcmd ("IPL", NULL, 0);
+	else
+		reipl (0x10000 | S390_lowcore.ipl_device);
 }
 
 void machine_restart_smp(char * __unused) 
 {
-	cpu_restart_map = cpu_online_map;
         on_each_cpu(do_machine_restart, NULL, 0, 0);
 }
 
@@ -384,16 +388,16 @@
  */
 static void smp_ext_bitcall_others(ec_bit_sig sig)
 {
-        int i;
+        int cpu;
 
-        for (i = 0; i < NR_CPUS; i++) {
-                if (!cpu_online(i) || smp_processor_id() == i)
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
                         continue;
                 /*
                  * Set signaling bit in lowcore of target cpu and kick it
                  */
-		set_bit(sig, (unsigned long *) &lowcore_ptr[i]->ext_call_fast);
-                while (signal_processor(i, sigp_external_call) == sigp_busy)
+		set_bit(sig, (unsigned long *) &lowcore_ptr[cpu]->ext_call_fast);
+		while (signal_processor(cpu, sigp_external_call) == sigp_busy)
 			udelay(10);
         }
 }
@@ -497,7 +501,6 @@
 	 */
 
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
-	__cpu_logical_map[0] = boot_cpu_addr;
 	current_thread_info()->cpu = 0;
 	num_cpus = 1;
 	for (cpu = 0; cpu <= 65535 && num_cpus < max_cpus; cpu++) {
@@ -725,7 +728,7 @@
 __cpu_die(unsigned int cpu)
 {
 	/* Wait until target cpu is down */
-	while (!cpu_stopped(cpu))
+	while (!smp_cpu_not_running(cpu))
 		cpu_relax();
 	printk("Processor %d spun down\n", cpu);
 }
@@ -790,6 +793,7 @@
 	BUG_ON(smp_processor_id() != 0);
 
 	cpu_set(0, cpu_online_map);
+	cpu_set(0, cpu_present_map);
 	cpu_set(0, cpu_possible_map);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
diff -urN linux-2.6/arch/s390/Makefile linux-2.6-patched/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6-patched/arch/s390/Makefile	2005-03-02 17:00:07.000000000 +0100
@@ -66,7 +66,7 @@
 cflags-$(CONFIG_WARN_STACK) += -mwarn-framesize=$(CONFIG_WARN_STACK_SIZE)
 endif
 
-CFLAGS		+= -mbackchain $(cflags-y)
+CFLAGS		+= -mbackchain -msoft-float $(cflags-y)
 CFLAGS		+= $(call cc-option,-finline-limit=10000)
 CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
 AFLAGS		+= $(aflags-y)
diff -urN linux-2.6/drivers/s390/char/sclp_quiesce.c linux-2.6-patched/drivers/s390/char/sclp_quiesce.c
--- linux-2.6/drivers/s390/char/sclp_quiesce.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_quiesce.c	2005-03-02 17:00:07.000000000 +0100
@@ -30,31 +30,16 @@
 {
 	static atomic_t cpuid = ATOMIC_INIT(-1);
 	psw_t quiesce_psw;
-	__u32 status;
-	int i;
+	int cpu;
 
 	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
 		signal_processor(smp_processor_id(), sigp_stop);
 	/* Wait for all other cpus to enter stopped state */
-	i = 1;
-	while (i < NR_CPUS) {
-		if (!cpu_online(i)) {
-			i++;
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
 			continue;
-		}
-		switch (signal_processor_ps(&status, 0, i, sigp_sense)) {
-		case sigp_order_code_accepted:
-		case sigp_status_stored:
-			/* Check for stopped and check stop state */
-			if (status & 0x50)
-				i++;
-			break;
-		case sigp_busy:
-			break;
-		case sigp_not_operational:
-			i++;
-			break;
-		}
+		while(!smp_cpu_not_running(cpu))
+			cpu_relax();
 	}
 	/* Quiesce the last cpu with the special psw */
 	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-patched/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	2005-03-02 08:38:18.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/pgtable.h	2005-03-02 17:00:07.000000000 +0100
@@ -756,11 +756,17 @@
  *  0000000000111111111122222222223333333333444444444455 5555 5 55566 66
  *  0123456789012345678901234567890123456789012345678901 2345 6 78901 23
  */
+#ifndef __s390x__
+#define __SWP_OFFSET_MASK (~0UL >> 12)
+#else
+#define __SWP_OFFSET_MASK (~0UL >> 11)
+#endif
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
+	offset &= __SWP_OFFSET_MASK;
 	pte_val(pte) = _PAGE_INVALID_SWAP | ((type & 0x1f) << 2) |
-		((offset & 1) << 7) | ((offset & 0xffffe) << 11);
+		((offset & 1UL) << 7) | ((offset & ~1UL) << 11);
 	return pte;
 }
 
diff -urN linux-2.6/include/asm-s390/posix_types.h linux-2.6-patched/include/asm-s390/posix_types.h
--- linux-2.6/include/asm-s390/posix_types.h	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/posix_types.h	2005-03-02 17:00:07.000000000 +0100
@@ -83,16 +83,16 @@
 #endif
 
 #undef  __FD_SET
-#define __FD_SET(fd,fdsetp)  set_bit(fd,fdsetp->fds_bits)
+#define __FD_SET(fd,fdsetp)  set_bit((fd),(fdsetp)->fds_bits)
 
 #undef  __FD_CLR
-#define __FD_CLR(fd,fdsetp)  clear_bit(fd,fdsetp->fds_bits)
+#define __FD_CLR(fd,fdsetp)  clear_bit((fd),(fdsetp)->fds_bits)
 
 #undef  __FD_ISSET
-#define __FD_ISSET(fd,fdsetp)  test_bit(fd,fdsetp->fds_bits)
+#define __FD_ISSET(fd,fdsetp)  test_bit((fd),(fdsetp)->fds_bits)
 
 #undef  __FD_ZERO
-#define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
+#define __FD_ZERO(fdsetp) (memset ((fdsetp), 0, sizeof(*(fd_set *)(fdsetp))))
 
 #endif     /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)*/
 
diff -urN linux-2.6/include/asm-s390/smp.h linux-2.6-patched/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/smp.h	2005-03-02 17:00:07.000000000 +0100
@@ -18,6 +18,7 @@
 #if defined(__KERNEL__) && defined(CONFIG_SMP) && !defined(__ASSEMBLY__)
 
 #include <asm/lowcore.h>
+#include <asm/sigp.h>
 
 /*
   s390 specific smp.c headers
@@ -59,6 +60,30 @@
         return cpu_address;
 }
 
+/*
+ * returns 1 if cpu is in stopped/check stopped state or not operational
+ * returns 0 otherwise
+ */
+static inline int
+smp_cpu_not_running(int cpu)
+{
+	__u32 status;
+
+	switch (signal_processor_ps(&status, 0, cpu, sigp_sense)) {
+	case sigp_order_code_accepted:
+	case sigp_status_stored:
+		/* Check for stopped and check stop state */
+		if (status & 0x50)
+			return 1;
+		break;
+	case sigp_not_operational:
+		return 1;
+	default:
+		break;
+	}
+	return 0;
+}
+
 #define cpu_logical_map(cpu) (cpu)
 
 extern int __cpu_disable (void);
