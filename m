Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317944AbSGWESI>; Tue, 23 Jul 2002 00:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317948AbSGWESI>; Tue, 23 Jul 2002 00:18:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45256 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317944AbSGWESF>;
	Tue, 23 Jul 2002 00:18:05 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: linux-kernel@vger.kernel.org
Subject: Summit patch for 2.4.19-rc3-ac2
Date: Mon, 22 Jul 2002 21:21:04 -0700
User-Agent: KMail/1.4.1
Cc: Steven Cole <scole@lanl.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_4FPOCEB5I3RXW5TDAWYJ"
Message-Id: <200207222121.04788.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_4FPOCEB5I3RXW5TDAWYJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here's a patch for those who have been plagued by APIC errors starting ar=
ound=20
-rc1-ac6.  I've submitted it to Alan, but since it has been affecting a=20
number of folks, I'm also posting it here for your consideration and revi=
ew.

This fixes the APIC receive accept errors on the two machines we have tha=
t=20
were subject to it.  Let me know if it doesn't work for you.

--=20
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

--------------Boundary-00=_4FPOCEB5I3RXW5TDAWYJ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.4.19-rc3-ac2_summit.2002-07-22"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4.19-rc3-ac2_summit.2002-07-22"

diff -ruN 2.4.19-rc3-ac2/arch/i386/kernel/apic.c ac2/arch/i386/kernel/apic.c
--- 2.4.19-rc3-ac2/arch/i386/kernel/apic.c	Mon Jul 22 20:03:41 2002
+++ ac2/arch/i386/kernel/apic.c	Mon Jul 22 20:04:38 2002
@@ -261,20 +261,6 @@
 	apic_write_around(APIC_LVT1, value);
 }
 
-/*
- * To build the logical APIC ID for each CPU we have three cases:
- *  1) Normal flat mode:  use a bitmap of the CPU numbers
- *  2) Logical multi-quad (NUMA-Q):  do nothing, the BIOS has set it up
- *  3) Physical multi-quad (xAPIC clusters):  convert the Intel standard
- *	physical APIC ID to a cluster nibble/cpu bitmap nibble
- *
- ***	mps_cpu (index number):   0,  1,  2,  3,  4,  5,  6,  7,  8,  9, ... 
- ***  CPUs have xAPIC phys IDs:  00, 01, 02, 03, 10, 11, 12, 13, 20, 21, ... 
- ***		its logical ID:  01, 02, 04, 08, 11, 12, 14, 18, 21, 22, ... 
- */
- 
-#define physical_to_logical_apicid(phys_apic) ( (1UL << (phys_apic & 0x3)) | (phys_apic & 0xF0U) )
-
 static unsigned long apic_ldr_value(unsigned long value)
 {
 	if (clustered_apic_logical)
diff -ruN 2.4.19-rc3-ac2/arch/i386/kernel/io_apic.c ac2/arch/i386/kernel/io_apic.c
--- 2.4.19-rc3-ac2/arch/i386/kernel/io_apic.c	Mon Jul 22 20:03:41 2002
+++ ac2/arch/i386/kernel/io_apic.c	Mon Jul 22 20:06:07 2002
@@ -760,7 +760,7 @@
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
 		 */
-		if (clustered_apic_mode && (apic != 0) && (irq == 0))
+		if (clustered_apic_logical && (apic != 0) && (irq == 0))
 			continue;
 		else
 			add_pin_to_irq(irq, apic, pin);
diff -ruN 2.4.19-rc3-ac2/arch/i386/kernel/mpparse.c ac2/arch/i386/kernel/mpparse.c
--- 2.4.19-rc3-ac2/arch/i386/kernel/mpparse.c	Mon Jul 22 20:03:41 2002
+++ ac2/arch/i386/kernel/mpparse.c	Mon Jul 22 20:04:38 2002
@@ -162,7 +162,7 @@
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
 
-	logical_apicid = m->mpc_apicid;
+	logical_apicid = 0x01;
 	if (clustered_apic_logical) {
 		quad = translation_table[mpc_record]->trans_quad;
 		logical_apicid = (quad << 4) + 
diff -ruN 2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c ac2/arch/i386/kernel/smpboot.c
--- 2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c	Mon Jul 22 20:03:41 2002
+++ ac2/arch/i386/kernel/smpboot.c	Mon Jul 22 20:08:02 2002
@@ -511,59 +511,28 @@
 	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
 }
 
-/* which physical APIC ID maps to which logical CPU number */
-volatile unsigned char physical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
-volatile unsigned char cpu_2_physical_apicid[NR_CPUS];
+volatile u8 cpu_2_physical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
-/* which logical APIC ID maps to which logical CPU number */
-volatile unsigned char logical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which logical APIC ID */
-volatile unsigned char cpu_2_logical_apicid[NR_CPUS];
+volatile u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
-static inline void init_cpu_to_apicid(void)
-/* Initialize all maps between cpu number and apicids */
-{
-	int apicid, cpu;
-
-	for (apicid = 0; apicid < MAX_APICID; apicid++) {
-		physical_apicid_2_cpu[apicid] = BAD_APICID;
-		logical_apicid_2_cpu[apicid] = BAD_APICID;
-	}
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpu_2_physical_apicid[cpu] = BAD_APICID;
-		cpu_2_logical_apicid[cpu] = BAD_APICID;
-	}
-}
-
-static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
+static inline void map_cpu_to_boot_apicid(int cpu, int phys_apicid, int log_apicid)
 /* 
- * set up a mapping between cpu and apicid. Uses logical apicids for multiquad,
- * else physical apic ids
+ * set up a mapping between cpu and apicids.
  */
 {
-	if (clustered_apic_logical) {
-		logical_apicid_2_cpu[apicid] = (unsigned char) cpu;
-		cpu_2_logical_apicid[cpu] = (unsigned char) apicid;
-	} else {
-		physical_apicid_2_cpu[apicid] = (unsigned char) cpu;
-		cpu_2_physical_apicid[cpu] = (unsigned char) apicid;
-	}
+	cpu_2_logical_apicid[cpu] = (u8) log_apicid;
+	cpu_2_physical_apicid[cpu] = (u8) phys_apicid;
 }
 
-static inline void unmap_cpu_to_boot_apicid(int cpu, int apicid)
+static inline void unmap_cpu_to_boot_apicid(int cpu)
 /* 
- * undo a mapping between cpu and apicid. Uses logical apicids for multiquad,
- * else physical apic ids
+ * undo a mapping between cpu and apicids.
  */
 {
-	if (clustered_apic_logical) {
-		logical_apicid_2_cpu[apicid] = BAD_APICID;
-		cpu_2_logical_apicid[cpu] = BAD_APICID;
-	} else {
-		physical_apicid_2_cpu[apicid] = BAD_APICID;
-		cpu_2_physical_apicid[cpu] = BAD_APICID;
-	}
+	cpu_2_logical_apicid[cpu] = BAD_APICID;
+	cpu_2_physical_apicid[cpu] = BAD_APICID;
 }
 
 #if APIC_DEBUG
@@ -777,17 +746,13 @@
 
 extern unsigned long cpu_initialized;
 
-static void __init do_boot_cpu (int apicid) 
-/*
- * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
- * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
- */
+static void __init do_boot_cpu (int phys_apicid, int log_apicid)
 {
 	struct task_struct *idle;
 	unsigned long boot_error = 0;
 	int timeout, cpu;
 	unsigned long start_eip;
-	unsigned short nmi_high, nmi_low;
+	unsigned short nmi_high = 0, nmi_low = 0;
 
 	cpu = ++cpucount;
 	/*
@@ -807,7 +772,7 @@
 
 	init_idle(idle, cpu);
 
-	map_cpu_to_boot_apicid(cpu, apicid);
+	map_cpu_to_boot_apicid(cpu, phys_apicid, log_apicid);
 
 	idle->thread.eip = (unsigned long) start_secondary;
 
@@ -817,7 +782,7 @@
 	start_eip = setup_trampoline();
 
 	/* So we see what's up   */
-	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
+	printk("Booting processor %d/%d eip %lx\n", cpu, log_apicid, start_eip);
 	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
 
 	/*
@@ -846,7 +811,7 @@
 	/*
 	 * Be paranoid about clearing APIC errors.
 	 */
-	if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[apicid])) {
+	if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[phys_apicid])) {
 		apic_read_around(APIC_SPIV);
 		apic_write(APIC_ESR, 0);
 		apic_read(APIC_ESR);
@@ -862,9 +827,9 @@
 	 */
 
 	if (clustered_apic_logical)
-		boot_error = wakeup_secondary_via_NMI(apicid);
+		boot_error = wakeup_secondary_via_NMI(log_apicid);
 	else 
-		boot_error = wakeup_secondary_via_INIT(apicid, start_eip);
+		boot_error = wakeup_secondary_via_INIT(phys_apicid, start_eip);
 
 	if (!boot_error) {
 		/*
@@ -900,13 +865,13 @@
 				printk("Not responding.\n");
 #if APIC_DEBUG
 			if (!clustered_apic_mode)
-				inquire_remote_apic(apicid);
+				inquire_remote_apic(phys_apicid);
 #endif
 		}
 	}
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
-		unmap_cpu_to_boot_apicid(cpu, apicid);
+		unmap_cpu_to_boot_apicid(cpu);
 		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
 		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
@@ -975,7 +940,6 @@
 extern int prof_old_multiplier[NR_CPUS];
 extern int prof_counter[NR_CPUS];
 
-static int boot_cpu_logical_apicid;
 #ifdef CONFIG_MULTIQUAD
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
@@ -985,7 +949,7 @@
 
 void __init smp_boot_cpus(void)
 {
-	int apicid, cpu, bit;
+	int phys_apicid, log_apicid, cpu, bit;
 
 #ifdef CONFIG_MULTIQUAD
         if (clustered_apic_logical && (numnodes > 1)) {
@@ -1014,8 +978,6 @@
 		prof_multiplier[cpu] = 1;
 	}
 
-	init_cpu_to_apicid();
-
 	/*
 	 * Setup boot CPU information
 	 */
@@ -1027,8 +989,13 @@
 	 * We have the boot CPU online for sure.
 	 */
 	set_bit(0, &cpu_online_map);
-	boot_cpu_logical_apicid = logical_smp_processor_id();
-	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
+	if (clustered_apic_physical)
+		boot_cpu_logical_apicid = physical_to_logical_apicid(boot_cpu_physical_apicid);
+	else if (clustered_apic_logical)
+		boot_cpu_logical_apicid = logical_smp_processor_id();
+	else
+		boot_cpu_logical_apicid = 0x01;
+	map_cpu_to_boot_apicid(0, boot_cpu_physical_apicid, boot_cpu_logical_apicid);
 
 	global_irq_holder = 0;
 	current->cpu = 0;
@@ -1111,27 +1078,32 @@
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
 	for (bit = 0; bit < NR_CPUS; bit++) {
-		apicid = cpu_present_to_apicid(bit);
-		/*
-		 * Don't even attempt to start the boot CPU!
-		 */
-		if (apicid == boot_cpu_apicid)
-			continue;
-
 		if (!(phys_cpu_present_map & (1UL << bit)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
+		phys_apicid = raw_phys_apicid[bit];
+		/*
+		 * Don't even attempt to start the boot CPU!
+		 */
+		if (phys_apicid == boot_cpu_physical_apicid)
+			continue;
+		if (clustered_apic_physical)
+			log_apicid = physical_to_logical_apicid(phys_apicid);
+		else if (clustered_apic_logical)
+			log_apicid = ((bit >> 2) << 4) | (1 << (bit & 0x3));
+		else
+			log_apicid = 1u << bit;
 
-		do_boot_cpu(apicid);
+		do_boot_cpu(phys_apicid, log_apicid);
 
 		/*
 		 * Make sure we unmap all failed CPUs
 		 */
-		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
+		if ((cpu_to_physical_apicid(bit) == BAD_APICID) &&
+				(phys_cpu_present_map & (1ul << bit)))
 			printk("CPU #%d not responding - cannot use it.\n",
-								apicid);
+								bit);
 	}
 
 	/*
diff -ruN 2.4.19-rc3-ac2/include/asm-i386/mpspec.h ac2/include/asm-i386/mpspec.h
--- 2.4.19-rc3-ac2/include/asm-i386/mpspec.h	Mon Jul 22 20:03:42 2002
+++ ac2/include/asm-i386/mpspec.h	Mon Jul 22 20:04:38 2002
@@ -201,6 +201,7 @@
 extern int quad_local_to_mp_bus_id [NR_CPUS/4][4];
 
 extern unsigned int boot_cpu_physical_apicid;
+extern unsigned int boot_cpu_logical_apicid;
 extern unsigned long phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
diff -ruN 2.4.19-rc3-ac2/include/asm-i386/smpboot.h ac2/include/asm-i386/smpboot.h
--- 2.4.19-rc3-ac2/include/asm-i386/smpboot.h	Mon Jul 22 20:03:42 2002
+++ ac2/include/asm-i386/smpboot.h	Mon Jul 22 20:04:38 2002
@@ -12,13 +12,27 @@
 
 extern unsigned char raw_phys_apicid[NR_CPUS];
 
+/*
+ * To build the logical APIC ID for each CPU we have three cases:
+ *  1) Normal flat mode:  use a bitmap of the CPU numbers
+ *  2) Logical multi-quad (NUMA-Q):  do nothing, the BIOS has set it up
+ *  3) Physical multi-quad (xAPIC clusters):  convert the Intel standard
+ *	physical APIC ID to a cluster nibble/cpu bitmap nibble
+ *
+ ***	mps_cpu (index number):   0,  1,  2,  3,  4,  5,  6,  7,  8,  9, ... 
+ ***  CPUs have xAPIC phys IDs:  00, 01, 02, 03, 10, 11, 12, 13, 20, 21, ... 
+ ***		its logical ID:  01, 02, 04, 08, 11, 12, 14, 18, 21, 22, ... 
+ */
+ 
+#define physical_to_logical_apicid(phys_apic) ( (1ul << (phys_apic & 0x3)) | (phys_apic & 0xF0u) )
+
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
 	if(clustered_apic_logical)
 		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
 	if(clustered_apic_physical)
 		return raw_phys_apicid[mps_cpu];
-	return mps_cpu;
+	return 1 << mps_cpu;
 }
 
 static inline unsigned long apicid_to_phys_cpu_present(int apicid)
@@ -33,10 +47,8 @@
  * The first four macros are trivial, but it keeps the abstraction consistent
  */
 
-extern volatile unsigned char logical_apicid_2_cpu[];
-extern volatile unsigned char cpu_2_logical_apicid[];
-extern volatile unsigned char physical_apicid_2_cpu[];
-extern volatile unsigned char cpu_2_physical_apicid[];
+extern volatile u8 cpu_2_logical_apicid[];
+extern volatile u8 cpu_2_physical_apicid[];
 
 #define logical_apicid_to_cpu(apicid) (int)logical_apicid_2_cpu[apicid]
 #define cpu_to_logical_apicid(cpu) (int)cpu_2_logical_apicid[cpu]

--------------Boundary-00=_4FPOCEB5I3RXW5TDAWYJ--

