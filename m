Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292582AbSBZAsK>; Mon, 25 Feb 2002 19:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSBZArw>; Mon, 25 Feb 2002 19:47:52 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:54260 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292579AbSBZAre>; Mon, 25 Feb 2002 19:47:34 -0500
Date: Mon, 25 Feb 2002 16:44:41 -0800
From: Russ Weight <rweight@us.ibm.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Scalable phys_cpu_present_map 2.5.5
Message-ID: <20020225164441.A27171@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	This patch applies to the 2.5.5 kernel and is dependent
on my previously submitted patch entitled "[PATCH] Scalable CPU
bitmasks 2.5.5".

	I have submitted previous versions of this patch to Linus
directly, but I have not yet received a response. Perhaps it is better
to send it to you as the maintainer of the lowlevel X86 SMP support.

	This patch modifies the phys_cpu_present_map bitmask to
be a "scalable CPU bitmask".  The datatype is changed to cpumap_t,
and all accesses to the bitmask are done through the appropriate
supporting functions. Note that this patch depends on the "Scalable
CPU bitmasks" patch.

	This patch affects i386 architecture specific code, but does
not affect other architectures. Note that the x86_64 architecture uses
a phys_cpu_present_map, but there is no shared use of the bitmask
between architectures, and therefore no conflict.

---------------------------------------------------------------------------

diff -u cpumap/arch/i386/kernel/process.c linux.ref/arch/i386/kernel/process.c
--- cpumap/arch/i386/kernel/process.c	Tue Feb 19 18:10:52 2002
+++ linux.ref/arch/i386/kernel/process.c	Fri Feb 22 14:06:30 2002
@@ -385,7 +385,7 @@
 		   if its not, default to the BSP */
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
+		      !(cpumap_test_bit(cpuid, phys_cpu_present_map))) 
 			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
diff -u cpumap/arch/i386/kernel/mpparse.c linux.ref/arch/i386/kernel/mpparse.c
--- cpumap/arch/i386/kernel/mpparse.c	Tue Feb 19 18:10:59 2002
+++ linux.ref/arch/i386/kernel/mpparse.c	Fri Feb 22 14:06:30 2002
@@ -61,7 +61,7 @@
 static unsigned int num_processors;
 
 /* Bitmask of physically existing CPUs */
-unsigned long phys_cpu_present_map;
+cpumap_t phys_cpu_present_map;
 
 /*
  * Intel MP BIOS table parsing routines:
@@ -224,9 +224,10 @@
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
@@ -819,7 +820,7 @@
 {
 	smp_found_config = 1;
 
-	phys_cpu_present_map |= 2; /* or in id 1 */
+	cpumap_set_bit(1, phys_cpu_present_map);
 	apic_version[1] |= 0x10; /* integrated APIC */
 	apic_version[0] |= 0x10;
 
diff -u cpumap/arch/i386/kernel/io_apic.c linux.ref/arch/i386/kernel/io_apic.c
--- cpumap/arch/i386/kernel/io_apic.c	Tue Feb 19 18:10:59 2002
+++ linux.ref/arch/i386/kernel/io_apic.c	Fri Feb 22 14:06:30 2002
@@ -1006,7 +1006,8 @@
 static void __init setup_ioapic_ids_from_mpc (void)
 {
 	struct IO_APIC_reg_00 reg_00;
-	unsigned long phys_id_present_map = phys_cpu_present_map;
+	unsigned long phys_id_present_map =
+			cpumap_to_ulong(phys_cpu_present_map);
 	int apic;
 	int i;
 	unsigned char old_id;
diff -u cpumap/arch/i386/kernel/smpboot.c linux.ref/arch/i386/kernel/smpboot.c
--- cpumap/arch/i386/kernel/smpboot.c	Tue Feb 19 18:11:02 2002
+++ linux.ref/arch/i386/kernel/smpboot.c	Fri Feb 22 14:06:30 2002
@@ -1011,6 +1011,9 @@
 void __init smp_boot_cpus(void)
 {
 	int apicid, cpu, bit;
+#ifdef SMP_DEBUG
+	char buf[CPUMAP_BUFSIZE];
+#endif
 
         if (clustered_apic_mode) {
                 /* remap the 1st quad's 256k range for cross-quad I/O */
@@ -1063,7 +1066,9 @@
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
@@ -1077,10 +1082,10 @@
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
@@ -1094,7 +1099,9 @@
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
@@ -1110,7 +1117,9 @@
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
@@ -1128,7 +1137,8 @@
 	 * bits 0-3 are quad0, 4-7 are quad1, etc. A perverse twist on the 
 	 * clustered apic ID.
 	 */
-	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
+	Dprintk("CPU present map: %s\n",
+		cpumap_format(phys_cpu_present_map, buf, CPUMAP_BUFSIZE));
 
 	for (bit = 0; bit < NR_CPUS; bit++) {
 		apicid = cpu_present_to_apicid(bit);
@@ -1138,7 +1148,7 @@
 		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << bit)))
+		if (!(cpumap_test_bit(bit, phys_cpu_present_map)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
@@ -1149,7 +1159,7 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
+				(cpumap_test_bit(bit, phys_cpu_present_map)))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 	}
diff -u cpumap/arch/i386/kernel/apic.c linux.ref/arch/i386/kernel/apic.c
--- cpumap/arch/i386/kernel/apic.c	Tue Feb 19 18:11:03 2002
+++ linux.ref/arch/i386/kernel/apic.c	Fri Feb 22 14:06:30 2002
@@ -283,7 +283,7 @@
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
 	if (!clustered_apic_mode && 
-	    !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
+	    !cpumap_test_bit(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map))
 		BUG();
 
 	/*
@@ -1137,7 +1137,8 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
+	cpumap_clear_mask(phys_cpu_present_map);
+	cpumap_set_bit(0, phys_cpu_present_map);
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
 	apic_pm_init2();
diff -u cpumap/include/asm-i386/mpspec.h linux.ref/include/asm-i386/mpspec.h
--- cpumap/include/asm-i386/mpspec.h	Tue Feb 19 18:10:53 2002
+++ linux.ref/include/asm-i386/mpspec.h	Fri Feb 22 14:06:30 2002
@@ -1,6 +1,8 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
 
+#include <linux/cpumap.h>
+
 /*
  * Structure definitions for SMP machines following the
  * Intel Multiprocessing Specification 1.1 and 1.4.
@@ -201,7 +203,7 @@
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
-extern unsigned long phys_cpu_present_map;
+extern cpumap_t phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
 extern void get_smp_config (void);
diff -u cpumap/include/asm-i386/smp.h linux.ref/include/asm-i386/smp.h
--- cpumap/include/asm-i386/smp.h	Tue Feb 19 18:10:54 2002
+++ linux.ref/include/asm-i386/smp.h	Fri Feb 22 14:06:30 2002
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
