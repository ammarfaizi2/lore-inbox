Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSFCW0K>; Mon, 3 Jun 2002 18:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSFCW0J>; Mon, 3 Jun 2002 18:26:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1715 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315628AbSFCW0B>;
	Mon, 3 Jun 2002 18:26:01 -0400
Date: Mon, 3 Jun 2002 15:21:26 -0700
From: Russ Weight <rweight@us.ibm.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.20] Scalable phys_cpu_present_map
Message-ID: <20020603152126.A5463@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
--- a/arch/i386/kernel/apic.c	Mon Jun  3 12:59:32 2002
+++ b/arch/i386/kernel/apic.c	Mon Jun  3 12:59:32 2002
@@ -295,7 +295,7 @@
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
 	if (!clustered_apic_mode && 
-	    !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
+	    !cpumap_test_bit(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map))
 		BUG();
 
 	/*
@@ -1164,7 +1164,8 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
+	cpumap_clear_mask(phys_cpu_present_map);
+	cpumap_set_bit(0, phys_cpu_present_map);
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
 	apic_pm_init2();
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Mon Jun  3 12:59:32 2002
+++ b/arch/i386/kernel/io_apic.c	Mon Jun  3 12:59:32 2002
@@ -1107,7 +1107,8 @@
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
--- a/arch/i386/kernel/mpparse.c	Mon Jun  3 12:59:32 2002
+++ b/arch/i386/kernel/mpparse.c	Mon Jun  3 12:59:32 2002
@@ -67,7 +67,7 @@
 static unsigned int num_processors;
 
 /* Bitmask of physically existing CPUs */
-unsigned long phys_cpu_present_map;
+cpumap_t phys_cpu_present_map;
 
 /*
  * Intel MP BIOS table parsing routines:
@@ -227,9 +227,10 @@
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
@@ -826,7 +827,7 @@
 {
 	smp_found_config = 1;
 
-	phys_cpu_present_map |= 2; /* or in id 1 */
+	cpumap_set_bit(1, phys_cpu_present_map);
 	apic_version[1] |= 0x10; /* integrated APIC */
 	apic_version[0] |= 0x10;
 
diff -Nru a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Jun  3 12:59:32 2002
+++ b/arch/i386/kernel/process.c	Mon Jun  3 12:59:32 2002
@@ -386,7 +386,7 @@
 		   if its not, default to the BSP */
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
+		      !(cpumap_test_bit(cpuid, phys_cpu_present_map))) 
 			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Jun  3 12:59:32 2002
+++ b/arch/i386/kernel/smpboot.c	Mon Jun  3 12:59:32 2002
@@ -1014,6 +1014,9 @@
 void __init smp_boot_cpus(void)
 {
 	int apicid, cpu, bit;
+#ifdef SMP_DEBUG
+	char buf[CPUMAP_BUFSIZE];
+#endif
 
         if (clustered_apic_mode && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
@@ -1069,7 +1072,9 @@
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
@@ -1083,10 +1088,10 @@
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
@@ -1099,7 +1104,9 @@
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
@@ -1115,7 +1122,9 @@
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
@@ -1133,7 +1142,8 @@
 	 * bits 0-3 are quad0, 4-7 are quad1, etc. A perverse twist on the 
 	 * clustered apic ID.
 	 */
-	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
+	Dprintk("CPU present map: %s\n",
+		cpumap_format(phys_cpu_present_map, buf, CPUMAP_BUFSIZE));
 
 	for (bit = 0; bit < NR_CPUS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
@@ -1143,7 +1153,7 @@
 		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << bit)))
+		if (!(cpumap_test_bit(bit, phys_cpu_present_map)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
@@ -1154,7 +1164,7 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
+				(cpumap_test_bit(bit, phys_cpu_present_map)))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 	}
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Jun  3 12:59:32 2002
+++ b/include/asm-i386/mpspec.h	Mon Jun  3 12:59:32 2002
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
--- a/include/asm-i386/smp.h	Mon Jun  3 12:59:32 2002
+++ b/include/asm-i386/smp.h	Mon Jun  3 12:59:32 2002
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
Russ Weight
