Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTAGUdR>; Tue, 7 Jan 2003 15:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267501AbTAGUcG>; Tue, 7 Jan 2003 15:32:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:22733 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267492AbTAGUbO>; Tue, 7 Jan 2003 15:31:14 -0500
Date: Tue, 07 Jan 2003 12:28:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (5/7) cleanup apicid <-> cpu mapping
Message-ID: <599350000.1041971335@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To be honest, I have no idea what I was smoking when I wrote this
originally, and it's kind of coincidental that it works at all currently.

We never use physical apicids after the cpus are all booted, so we should
just store the logical IDs which all subsequent things use. The only things
that were using the apicid->cpu mapping were hokey anyway, and it's hard to
maintain for machines that have a large apic addressing space (eg P4s
in clustered mode). Rips out everything except the mapping from
logical_apic_id -> cpu.

diff -urpN -X /home/fletch/.diff.exclude 04-more_numaq1/arch/i386/kernel/smpboot.c 05-cleanup_cpu_apicid/arch/i386/kernel/smpboot.c
--- 04-more_numaq1/arch/i386/kernel/smpboot.c	Tue Jan  7 09:26:53 2003
+++ 05-cleanup_cpu_apicid/arch/i386/kernel/smpboot.c	Tue Jan  7 09:27:26 2003
@@ -405,6 +405,7 @@ void __init smp_callin(void)
 	if (clustered_apic_mode)
 		clear_local_APIC();
 	setup_local_APIC();
+	map_cpu_to_logical_apicid();

 	local_irq_enable();

@@ -536,61 +537,21 @@ static inline void unmap_cpu_to_node(int

 #endif /* CONFIG_NUMA */

-/* which physical APIC ID maps to which logical CPU number */
-volatile int physical_apicid_2_cpu[MAX_APICID];
-/* which logical CPU number maps to which physical APIC ID */
-volatile int cpu_2_physical_apicid[NR_CPUS];
-
-/* which logical APIC ID maps to which logical CPU number */
-volatile int logical_apicid_2_cpu[MAX_APICID];
-/* which logical CPU number maps to which logical APIC ID */
-volatile int cpu_2_logical_apicid[NR_CPUS];
-
-static inline void init_cpu_to_apicid(void)
-/* Initialize all maps between cpu number and apicids */
-{
-	int apicid, cpu;
-
-	for (apicid = 0; apicid < MAX_APICID; apicid++) {
-		physical_apicid_2_cpu[apicid] = -1;
-		logical_apicid_2_cpu[apicid] = -1;
-	}
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpu_2_physical_apicid[cpu] = -1;
-		cpu_2_logical_apicid[cpu] = -1;
-	}
-}
+volatile u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };

-static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
-/*
- * set up a mapping between cpu and apicid. Uses logical apicids for multiquad,
- * else physical apic ids
- */
+void map_cpu_to_logical_apicid(void)
 {
-	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = cpu;	
-		cpu_2_logical_apicid[cpu] = apicid;
-		map_cpu_to_node(cpu, apicid_to_node(apicid));
-	} else {
-		physical_apicid_2_cpu[apicid] = cpu;	
-		cpu_2_physical_apicid[cpu] = apicid;
-	}
+	int cpu = smp_processor_id();
+	int apicid = logical_smp_processor_id();
+
+	cpu_2_logical_apicid[cpu] = apicid;
+	map_cpu_to_node(cpu, apicid_to_node(apicid));
 }

-static inline void unmap_cpu_to_boot_apicid(int cpu, int apicid)
-/*
- * undo a mapping between cpu and apicid. Uses logical apicids for multiquad,
- * else physical apic ids
- */
+void unmap_cpu_to_logical_apicid(int cpu)
 {
-	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_logical_apicid[cpu] = -1;
-		unmap_cpu_to_node(cpu);
-	} else {
-		physical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_physical_apicid[cpu] = -1;
-	}
+	cpu_2_logical_apicid[cpu] = BAD_APICID;
+	unmap_cpu_to_node(cpu);
 }

 #if APIC_DEBUG
@@ -838,8 +799,6 @@ static int __init do_boot_cpu(int apicid
 	 */
 	init_idle(idle, cpu);

-	map_cpu_to_boot_apicid(cpu, apicid);
-
 	idle->thread.eip = (unsigned long) start_secondary;

 	unhash_process(idle);
@@ -928,7 +887,7 @@ static int __init do_boot_cpu(int apicid
 	}
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
-		unmap_cpu_to_boot_apicid(cpu, apicid);
+		unmap_cpu_to_logical_apicid(cpu);
 		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
@@ -1018,8 +977,6 @@ static void __init smp_boot_cpus(unsigne
 		prof_multiplier[cpu] = 1;
 	}

-	init_cpu_to_apicid();
-
 	/*
 	 * Setup boot CPU information
 	 */
@@ -1028,7 +985,6 @@ static void __init smp_boot_cpus(unsigne
 	print_cpu_info(&cpu_data[0]);

 	boot_cpu_logical_apicid = logical_smp_processor_id();
-	map_cpu_to_boot_apicid(0, boot_cpu_apicid);

 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
@@ -1085,6 +1041,7 @@ static void __init smp_boot_cpus(unsigne

 	connect_bsp_APIC();
 	setup_local_APIC();
+	map_cpu_to_logical_apicid();

 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
diff -urpN -X /home/fletch/.diff.exclude 04-more_numaq1/include/asm-i386/smp.h 05-cleanup_cpu_apicid/include/asm-i386/smp.h
--- 04-more_numaq1/include/asm-i386/smp.h	Tue Jan  7 09:26:53 2003
+++ 05-cleanup_cpu_apicid/include/asm-i386/smp.h	Tue Jan  7 09:27:26 2003
@@ -62,15 +62,7 @@ extern void smp_invalidate_rcv(void);		/
 extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);

-/*
- * Some lowlevel functions might want to know about
- * the real APIC ID <-> CPU # mapping.
- */
 #define MAX_APICID 256
-extern volatile int cpu_to_physical_apicid[NR_CPUS];
-extern volatile int physical_apicid_to_cpu[MAX_APICID];
-extern volatile int cpu_to_logical_apicid[NR_CPUS];
-extern volatile int logical_apicid_to_cpu[MAX_APICID];

 /*
  * This function is needed by all SMP systems. It must _always_ be valid
@@ -99,6 +91,15 @@ static inline int num_booting_cpus(void)
 {
 	return hweight32(cpu_callout_map);
 }
+
+/* Mapping from cpu number to logical apicid */
+extern volatile u8 cpu_2_logical_apicid[];
+static inline int cpu_to_logical_apicid(int cpu)
+{
+	return (int)cpu_2_logical_apicid[cpu];
+}
+extern void map_cpu_to_logical_apicid(void);
+extern void unmap_cpu_to_logical_apicid(int cpu);

 extern inline int any_online_cpu(unsigned int mask)
 {
diff -urpN -X /home/fletch/.diff.exclude 04-more_numaq1/include/asm-i386/smpboot.h 05-cleanup_cpu_apicid/include/asm-i386/smpboot.h
--- 04-more_numaq1/include/asm-i386/smpboot.h	Sun Nov 17 20:29:56 2002
+++ 05-cleanup_cpu_apicid/include/asm-i386/smpboot.h	Tue Jan  7 09:29:11 2003
@@ -23,26 +23,5 @@
  #define boot_cpu_apicid boot_cpu_physical_apicid
 #endif /* CONFIG_CLUSTERED_APIC */

-/*
- * Mappings between logical cpu number and logical / physical apicid
- * The first four macros are trivial, but it keeps the abstraction consistent
- */
-extern volatile int logical_apicid_2_cpu[];
-extern volatile int cpu_2_logical_apicid[];
-extern volatile int physical_apicid_2_cpu[];
-extern volatile int cpu_2_physical_apicid[];
-
-#define logical_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
-#define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
-#ifdef CONFIG_CLUSTERED_APIC			/* use logical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_logical_apicid[cpu]
-#else /* !CONFIG_CLUSTERED_APIC */		/* use physical IDs to bootstrap */
-#define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
-#define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
-#endif /* CONFIG_CLUSTERED_APIC */
-

 #endif

