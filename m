Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCRWjA>; Mon, 18 Mar 2002 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293186AbSCRWiq>; Mon, 18 Mar 2002 17:38:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20639 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293175AbSCRWiZ>;
	Mon, 18 Mar 2002 17:38:25 -0500
Date: Mon, 18 Mar 2002 14:35:06 -0800
From: Russ Weight <rweight@us.ibm.com>
To: ming0@elte.hu
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Scalable phys_cpu_present_map 2.5.7-pre2
Message-ID: <20020318143506.A4636@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch applies to the 2.5.7-pre2 kernel. It is dependent
on my previously submitted patch entitled "[PATCH] Scalable CPU
bitmasks".

          This patch modifies the phys_cpu_present_map bitmask to
  be a "scalable CPU bitmask".  The datatype is changed to cpumap_t,
  and all accesses to the bitmask are done through the appropriate
  supporting functions. Note that this patch depends on the "Scalable
  CPU bitmasks" patch.
  
          This patch affects i386 architecture specific code, but does
  not affect other architectures. Note that the x86_64 architecture uses
  a phys_cpu_present_map, but there is no shared use of the bitmask
  between architectures, and therefore no conflict.

diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Mon Mar 18 13:25:24 2002
+++ b/arch/i386/kernel/apic.c	Mon Mar 18 13:25:24 2002
@@ -283,7 +283,7 @@
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
 	if (!clustered_apic_mode && 
-	    !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
+	    !cpumap_test_bit(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map))
 		BUG();
 
 	/*
@@ -1148,7 +1148,8 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
+	cpumap_clear_mask(phys_cpu_present_map);
+	cpumap_set_bit(0, phys_cpu_present_map);
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
 	apic_pm_init2();
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Mar 18 13:25:24 2002
+++ b/arch/i386/kernel/io_apic.c	Mon Mar 18 13:25:24 2002
@@ -1026,7 +1026,8 @@
 static void __init setup_ioapic_ids_from_mpc (void)
 {
 	struct IO_APIC_reg_00 reg_00;
-	unsigned long phys_id_present_map = phys_cpu_present_map;
+	unsigned long phys_id_present_map =
+			cpumap_to_ulong(phys_cpu_present_map);
 	int apic;
 	int i;
 	unsigned char old_id;
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Mon Mar 18 13:25:24 2002
+++ b/arch/i386/kernel/mpparse.c	Mon Mar 18 13:25:24 2002
@@ -67,7 +67,7 @@
 static unsigned int num_processors;
 
 /* Bitmask of physically existing CPUs */
-unsigned long phys_cpu_present_map;
+cpumap_t phys_cpu_present_map;
 
 /* ACPI MADT entry parsing functions */
 #ifdef CONFIG_ACPI_BOOT
@@ -237,9 +237,10 @@
 	ver = m->mpc_apicver;
 
 	if (clustered_apic_mode) {
-		phys_cpu_present_map |= (logical_apicid&0xf) << (4*quad);
+		int cpuid = ffs(logical_apicid&0xf) - 1 + (4*quad);
+		cpumap_set_bit(cpuid, phys_cpu_present_map);
 	} else {
-		phys_cpu_present_map |= 1 << m->mpc_apicid;
+		cpumap_set_bit(m->mpc_apicid, phys_cpu_present_map);
 	}
 	/*
 	 * Validate version
@@ -836,7 +837,7 @@
 {
 	smp_found_config = 1;
 
-	phys_cpu_present_map |= 2; /* or in id 1 */
+	cpumap_set_bit(1, phys_cpu_present_map);
 	apic_version[1] |= 0x10; /* integrated APIC */
 	apic_version[0] |= 0x10;
 
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Mar 18 13:25:24 2002
+++ b/arch/i386/kernel/process.c	Mon Mar 18 13:25:24 2002
@@ -385,7 +385,7 @@
 		   if its not, default to the BSP */
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
+		      !(cpumap_test_bit(cpuid, phys_cpu_present_map))) 
 			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Mar 18 13:25:24 2002
+++ b/arch/i386/kernel/smpboot.c	Mon Mar 18 13:25:24 2002
@@ -1011,6 +1011,9 @@
 void __init smp_boot_cpus(void)
 {
 	int apicid, cpu, bit;
+#ifdef SMP_DEBUG
+	char buf[CPUMAP_BUFSIZE];
+#endif
 
         if (clustered_apic_mode && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
@@ -1066,7 +1069,9 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
+		cpu_online_map = 1;
+		cpumap_clear_mask(phys_cpu_present_map);
+		cpumap_set_bit(0, phys_cpu_present_map);
 		smp_num_cpus = 1;
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
@@ -1080,10 +1085,10 @@
 	 * Makes no sense to do this check in clustered apic mode, so skip it
 	 */
 	if (!clustered_apic_mode && 
-	    !test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map)) {
+	    !cpumap_test_bit(boot_cpu_physical_apicid, phys_cpu_present_map)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 							boot_cpu_physical_apicid);
-		phys_cpu_present_map |= (1 << hard_smp_processor_id());
+		cpumap_set_bit(hard_smp_processor_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -1097,7 +1102,9 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
+		cpu_online_map = 1;
+		cpumap_clear_mask(phys_cpu_present_map);
+		cpumap_set_bit(0, phys_cpu_present_map);
 		smp_num_cpus = 1;
 		goto smp_done;
 	}
@@ -1113,7 +1120,9 @@
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
 #endif
-		cpu_online_map = phys_cpu_present_map = 1;
+		cpu_online_map = 1;
+		cpumap_clear_mask(phys_cpu_present_map);
+		cpumap_set_bit(0, phys_cpu_present_map);
 		smp_num_cpus = 1;
 		goto smp_done;
 	}
@@ -1131,7 +1140,8 @@
 	 * bits 0-3 are quad0, 4-7 are quad1, etc. A perverse twist on the 
 	 * clustered apic ID.
 	 */
-	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
+	Dprintk("CPU present map: %s\n",
+		cpumap_format(phys_cpu_present_map, buf, CPUMAP_BUFSIZE));
 
 	for (bit = 0; bit < NR_CPUS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
@@ -1141,7 +1151,7 @@
 		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << bit)))
+		if (!(cpumap_test_bit(bit, phys_cpu_present_map)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
@@ -1152,7 +1162,7 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
+				(cpumap_test_bit(bit, phys_cpu_present_map)))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 	}
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Mar 18 13:25:24 2002
+++ b/include/asm-i386/mpspec.h	Mon Mar 18 13:25:24 2002
@@ -1,6 +1,8 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
 
+#include <linux/cpumap.h>
+
 /*
  * Structure definitions for SMP machines following the
  * Intel Multiprocessing Specification 1.1 and 1.4.
@@ -204,7 +206,7 @@
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
-extern unsigned long phys_cpu_present_map;
+extern cpumap_t phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
 extern void get_smp_config (void);
diff -Nru a/include/asm-i386/smp.h b/include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Mon Mar 18 13:25:24 2002
+++ b/include/asm-i386/smp.h	Mon Mar 18 13:25:24 2002
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/ptrace.h>
+#include <linux/cpumap.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -53,7 +54,7 @@
  */
  
 extern void smp_alloc_memory(void);
-extern unsigned long phys_cpu_present_map;
+extern cpumap_t phys_cpu_present_map;
 extern unsigned long cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center
