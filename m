Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVANSyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVANSyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVANSyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:54:52 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:1735 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261342AbVANSyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:54:23 -0500
Date: Fri, 14 Jan 2005 19:54:21 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/8] s390: Core changes.
Message-ID: <20050114185421.GA6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/8] s390: Core changes.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

s390 core changes:
 - Fix mm_struct leak on cpu hotplug.
 - Improved cpu detection logic to avoid long delay at system start.
 - Call cpu_relax() in cpu hotplug wait loop.
 - Remove #define of account_system_vtime for CONFIG_VIRT_CPU_ACCOUNTING=n.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig       |    8 ++++--
 arch/s390/kernel/setup.c  |    2 +
 arch/s390/kernel/smp.c    |   60 +++++++++++++++++++---------------------------
 include/asm-s390/system.h |    2 -
 4 files changed, 34 insertions(+), 38 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-01-14 19:44:38.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-01-14 19:45:15.000000000 +0100
@@ -1,10 +1,11 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10
-# Mon Dec 27 11:03:23 2004
+# Linux kernel version: 2.6.11-rc1
+# Fri Jan 14 14:56:51 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_ARCH_S390=y
 CONFIG_UID16=y
 
@@ -142,6 +143,7 @@
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
 CONFIG_SCSI_FC_ATTRS=y
+# CONFIG_SCSI_ISCSI_ATTRS is not set
 
 #
 # SCSI low-level drivers
@@ -184,6 +186,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -530,6 +533,7 @@
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
 
 #
 # Security options
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-01-14 19:44:38.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-01-14 19:45:15.000000000 +0100
@@ -98,6 +98,8 @@
         clear_thread_flag(TIF_USEDFPU);
         current->used_math = 0;
 
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
         if (current->mm)
                 BUG();
         enter_lazy_tlb(&init_mm, current);
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2005-01-14 19:44:38.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2005-01-14 19:45:15.000000000 +0100
@@ -486,48 +486,38 @@
  * Lets check how many CPUs we have.
  */
 
-#ifdef CONFIG_HOTPLUG_CPU
-
 void
 __init smp_check_cpus(unsigned int max_cpus)
 {
-	int cpu;
+	int cpu, num_cpus;
+	__u16 boot_cpu_addr;
 
 	/*
 	 * cpu 0 is the boot cpu. See smp_prepare_boot_cpu.
 	 */
-	for (cpu = 1; cpu < max_cpus; cpu++)
-		cpu_set(cpu, cpu_possible_map);
-}
 
-#else /* CONFIG_HOTPLUG_CPU */
+	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
+	__cpu_logical_map[0] = boot_cpu_addr;
+	current_thread_info()->cpu = 0;
+	num_cpus = 1;
+	for (cpu = 0; cpu <= 65535 && num_cpus < max_cpus; cpu++) {
+		if ((__u16) cpu == boot_cpu_addr)
+			continue;
+		__cpu_logical_map[num_cpus] = (__u16) cpu;
+		if (signal_processor(num_cpus, sigp_sense) ==
+		    sigp_not_operational)
+			continue;
+		cpu_set(num_cpus, cpu_present_map);
+		num_cpus++;
+	}
 
-void
-__init smp_check_cpus(unsigned int max_cpus)
-{
-        int curr_cpu, num_cpus;
-	__u16 boot_cpu_addr;
+	for (cpu = 1; cpu < max_cpus; cpu++)
+		cpu_set(cpu, cpu_possible_map);
 
-	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
-        current_thread_info()->cpu = 0;
-        num_cpus = 1;
-        for (curr_cpu = 0;
-             curr_cpu <= 65535 && num_cpus < max_cpus; curr_cpu++) {
-                if ((__u16) curr_cpu == boot_cpu_addr)
-                        continue;
-                __cpu_logical_map[num_cpus] = (__u16) curr_cpu;
-                if (signal_processor(num_cpus, sigp_sense) ==
-                    sigp_not_operational)
-                        continue;
-		cpu_set(num_cpus, cpu_possible_map);
-                num_cpus++;
-        }
-        printk("Detected %d CPU's\n",(int) num_cpus);
-        printk("Boot cpu address %2X\n", boot_cpu_addr);
+	printk("Detected %d CPU's\n",(int) num_cpus);
+	printk("Boot cpu address %2X\n", boot_cpu_addr);
 }
 
-#endif /* CONFIG_HOTPLUG_CPU */
-
 /*
  *      Activate a secondary processor.
  */
@@ -571,8 +561,6 @@
 	p = fork_idle(cpu);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
-	atomic_inc(&init_mm.mm_count);
-	p->active_mm = &init_mm;
 	current_set[cpu] = p;
 }
 
@@ -681,7 +669,8 @@
 	eieio();
 	signal_processor(cpu,sigp_restart);
 
-	while (!cpu_online(cpu));
+	while (!cpu_online(cpu))
+		cpu_relax();
 	return 0;
 }
 
@@ -736,13 +725,15 @@
 __cpu_die(unsigned int cpu)
 {
 	/* Wait until target cpu is down */
-	while (!cpu_stopped(cpu));
+	while (!cpu_stopped(cpu))
+		cpu_relax();
 	printk("Processor %d spun down\n", cpu);
 }
 
 void
 cpu_die(void)
 {
+	idle_task_exit();
 	signal_processor(smp_processor_id(), sigp_stop);
 	BUG();
 	for(;;);
@@ -806,6 +797,7 @@
 
 void smp_cpus_done(unsigned int max_cpus)
 {
+	cpu_present_map = cpu_possible_map;
 }
 
 /*
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-patched/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	2005-01-14 19:45:01.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/system.h	2005-01-14 19:45:15.000000000 +0100
@@ -119,8 +119,6 @@
 
 #else
 
-#define account_system_vtime(prev)
-
 #define finish_arch_switch(rq, prev) do {				     \
 	set_fs(current->thread.mm_segment);				     \
 	spin_unlock_irq(&(rq)->lock);					     \
