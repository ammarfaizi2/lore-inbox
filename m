Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWBPHTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWBPHTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWBPHTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:19:35 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:19644 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932492AbWBPHTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:19:34 -0500
Date: Thu, 16 Feb 2006 08:19:22 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: [patch 3/4] s390: additional_cpus parameter
Message-ID: <20060216071922.GF9241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce additional_cpus command line option. By default no additional
cpu can be attached to the system anymore. Only the cpus present at IPL
time can be switched on/off. If it is desired that additional cpus can be
attached to the system the maximum number of additional cpus needs to be
specified with this option.
This change is necessary in order to limit the waste of per_cpu data
structures.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 Documentation/cpu-hotplug.txt |    4 ++
 arch/s390/kernel/setup.c      |    2 +
 arch/s390/kernel/smp.c        |   58 ++++++++++++++++++++++++++++--------------
 include/asm-s390/smp.h        |    2 +
 4 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
index 08c5d04..7462063 100644
--- a/Documentation/cpu-hotplug.txt
+++ b/Documentation/cpu-hotplug.txt
@@ -11,6 +11,8 @@
 			Joel Schopp <jschopp@austin.ibm.com>
 		ia64/x86_64:
 			Ashok Raj <ashok.raj@intel.com>
+		s390:
+			Heiko Carstens <heiko.carstens@de.ibm.com>
 
 Authors: Ashok Raj <ashok.raj@intel.com>
 Lots of feedback: Nathan Lynch <nathanl@austin.ibm.com>,
@@ -44,7 +46,7 @@ maxcpus=n    Restrict boot time cpus to 
              maxcpus=2 will only boot 2. You can choose to bring the
              other cpus later online, read FAQ's for more info.
 
-additional_cpus=n	[x86_64 only] use this to limit hotpluggable cpus.
+additional_cpus=n	[x86_64, s390 only] use this to limit hotpluggable cpus.
                         This option sets
 			cpu_possible_map = cpu_present_map + additional_cpus
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index de87842..24f62f1 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -600,6 +600,7 @@ setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) &_end;
 
 	parse_cmdline_early(cmdline_p);
+	parse_early_param();
 
 	setup_memory();
 	setup_resources();
@@ -607,6 +608,7 @@ setup_arch(char **cmdline_p)
 
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
+	smp_setup_cpu_possible_map();
 
 	/*
 	 * Create kernel page tables and switch to virtual addressing.
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 0d1ad5d..53291e9 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1,8 +1,7 @@
 /*
  *  arch/s390/kernel/smp.c
  *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) IBM Corp. 1999,2006
  *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com),
  *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  *               Heiko Carstens (heiko.carstens@de.ibm.com)
@@ -41,8 +40,6 @@
 #include <asm/cpcmd.h>
 #include <asm/tlbflush.h>
 
-/* prototypes */
-
 extern volatile int __cpu_logical_map[];
 
 /*
@@ -51,13 +48,11 @@ extern volatile int __cpu_logical_map[];
 
 struct _lowcore *lowcore_ptr[NR_CPUS];
 
-cpumask_t cpu_online_map;
-cpumask_t cpu_possible_map = CPU_MASK_ALL;
+cpumask_t cpu_online_map = CPU_MASK_NONE;
+cpumask_t cpu_possible_map = CPU_MASK_NONE;
 
 static struct task_struct *current_set[NR_CPUS];
 
-EXPORT_SYMBOL(cpu_online_map);
-
 /*
  * Reboot, halt and power_off routines for SMP.
  */
@@ -490,10 +485,10 @@ void smp_ctl_clear_bit(int cr, int bit) 
  * Lets check how many CPUs we have.
  */
 
-void
-__init smp_check_cpus(unsigned int max_cpus)
+static unsigned int
+__init smp_count_cpus(void)
 {
-	int cpu, num_cpus;
+	unsigned int cpu, num_cpus;
 	__u16 boot_cpu_addr;
 
 	/*
@@ -503,19 +498,20 @@ __init smp_check_cpus(unsigned int max_c
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
 	current_thread_info()->cpu = 0;
 	num_cpus = 1;
-	for (cpu = 0; cpu <= 65535 && num_cpus < max_cpus; cpu++) {
+	for (cpu = 0; cpu <= 65535; cpu++) {
 		if ((__u16) cpu == boot_cpu_addr)
 			continue;
-		__cpu_logical_map[num_cpus] = (__u16) cpu;
-		if (signal_processor(num_cpus, sigp_sense) ==
+		__cpu_logical_map[1] = (__u16) cpu;
+		if (signal_processor(1, sigp_sense) ==
 		    sigp_not_operational)
 			continue;
-		cpu_set(num_cpus, cpu_present_map);
 		num_cpus++;
 	}
 
 	printk("Detected %d CPU's\n",(int) num_cpus);
 	printk("Boot cpu address %2X\n", boot_cpu_addr);
+
+	return num_cpus;
 }
 
 /*
@@ -676,6 +672,32 @@ __cpu_up(unsigned int cpu)
 	return 0;
 }
 
+static unsigned int __initdata additional_cpus;
+
+void __init smp_setup_cpu_possible_map(void)
+{
+	unsigned int pcpus, cpu;
+
+	pcpus = smp_count_cpus() + additional_cpus;
+
+	if (pcpus > NR_CPUS)
+		pcpus = NR_CPUS;
+
+	for (cpu = 0; cpu < pcpus; cpu++)
+		cpu_set(cpu, cpu_possible_map);
+
+	cpu_present_map = cpu_possible_map;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int __init setup_additional_cpus(char *s)
+{
+	additional_cpus = simple_strtoul(s, NULL, 0);
+	return 0;
+}
+early_param("additional_cpus", setup_additional_cpus);
+
 int
 __cpu_disable(void)
 {
@@ -744,6 +766,8 @@ cpu_die(void)
 	for(;;);
 }
 
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  *	Cycle through the processors and setup structures.
  */
@@ -757,7 +781,6 @@ void __init smp_prepare_cpus(unsigned in
         /* request the 0x1201 emergency signal external interrupt */
         if (register_external_interrupt(0x1201, do_ext_call_interrupt) != 0)
                 panic("Couldn't request external interrupt 0x1201");
-        smp_check_cpus(max_cpus);
         memset(lowcore_ptr,0,sizeof(lowcore_ptr));  
         /*
          *  Initialize prefix pages and stacks for all possible cpus
@@ -806,14 +829,12 @@ void __devinit smp_prepare_boot_cpu(void
 	BUG_ON(smp_processor_id() != 0);
 
 	cpu_set(0, cpu_online_map);
-	cpu_set(0, cpu_present_map);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
 }
 
 void smp_cpus_done(unsigned int max_cpus)
 {
-	cpu_present_map = cpu_possible_map;
 }
 
 /*
@@ -845,6 +866,7 @@ static int __init topology_init(void)
 
 subsys_initcall(topology_init);
 
+EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
diff --git a/include/asm-s390/smp.h b/include/asm-s390/smp.h
index 9c6e9c3..444dae5 100644
--- a/include/asm-s390/smp.h
+++ b/include/asm-s390/smp.h
@@ -31,6 +31,7 @@ typedef struct
 	__u16      cpu;
 } sigp_info;
 
+extern void smp_setup_cpu_possible_map(void);
 extern int smp_call_function_on(void (*func) (void *info), void *info,
 				int nonatomic, int wait, int cpu);
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
@@ -104,6 +105,7 @@ smp_call_function_on(void (*func) (void 
 #define smp_cpu_not_running(cpu)	1
 #define smp_get_cpu(cpu) ({ 0; })
 #define smp_put_cpu(cpu) ({ 0; })
+#define smp_setup_cpu_possible_map()
 #endif
 
 #endif
