Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRI1XHI>; Fri, 28 Sep 2001 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276371AbRI1XHE>; Fri, 28 Sep 2001 19:07:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53892 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S276369AbRI1XGn>; Fri, 28 Sep 2001 19:06:43 -0400
Date: Fri, 28 Sep 2001 16:14:36 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patches to enable ia32 NUMA system (32 proc)
Message-ID: <966296641.1001693676@[10.10.1.2]>
In-Reply-To: <Pine.LNX.4.33.0109281512280.4166-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only thing I reacted to in these patches is:
> 
>> diff -urN virgin-2.4.10/init/main.c numa-2.4.10/init/main.c
>> --- virgin-2.4.10/init/main.c	Thu Sep 20 21:02:01 2001
>> +++ numa-2.4.10/init/main.c	Thu Sep 27 11:57:21 2001
>> @@ -490,9 +490,19 @@
>> 
>>  #else
>> 
>> +/* Where the IO area was mapped on multiquad, always 0 otherwise */
>> +void *xquad_portio = NULL;
> ...
> 
> This is _definitely_ the wrong place to have magic x86-only code.

True.
 
> Why don't you just move that into the top of smp_boot_cpus()?

Fixed - new patch below.

Martin.

--------------------------------------------------

diff -urN virgin-2.4.10/Documentation/Configure.help numa-2.4.10/Documentation/Configure.help
--- virgin-2.4.10/Documentation/Configure.help	Sun Sep 23 09:52:38 2001
+++ numa-2.4.10/Documentation/Configure.help	Wed Sep 26 16:04:34 2001
@@ -119,6 +119,14 @@
   SMP-FAQ on the WWW at http://www.irisa.fr/prive/mentre/smp-faq/ .
   
   If you don't know what to do here, say N.
+
+Multiquad support for NUMA systems
+CONFIG_MULTIQUAD
+  This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
+  multiquad box. This changes the way that processors are bootstrapped,
+  and uses Clustered Logical APIC addressing mode instead of Flat Logical.
+  You will need a new lynxer.elf file to flash your firmware with - send
+  email to Martin.Bligh@us.ibm.com
   
 APIC and IO-APIC Support on Uniprocessors
 CONFIG_X86_UP_IOAPIC
diff -urN virgin-2.4.10/arch/i386/boot/compressed/misc.c numa-2.4.10/arch/i386/boot/compressed/misc.c
--- virgin-2.4.10/arch/i386/boot/compressed/misc.c	Tue Sep 11 23:02:02 2001
+++ numa-2.4.10/arch/i386/boot/compressed/misc.c	Wed Sep 26 16:04:34 2001
@@ -123,6 +123,10 @@
 static int vidport;
 static int lines, cols;
 
+#ifdef CONFIG_MULTIQUAD
+static void *xquad_portio = NULL;
+#endif
+
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
diff -urN virgin-2.4.10/arch/i386/config.in numa-2.4.10/arch/i386/config.in
--- virgin-2.4.10/arch/i386/config.in	Mon Sep 17 22:52:35 2001
+++ numa-2.4.10/arch/i386/config.in	Wed Sep 26 16:04:34 2001
@@ -175,6 +175,8 @@
       define_bool CONFIG_X86_IO_APIC y
       define_bool CONFIG_X86_LOCAL_APIC y
    fi
+else
+   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
diff -urN virgin-2.4.10/arch/i386/kernel/apic.c numa-2.4.10/arch/i386/kernel/apic.c
--- virgin-2.4.10/arch/i386/kernel/apic.c	Mon Sep 17 23:03:09 2001
+++ numa-2.4.10/arch/i386/kernel/apic.c	Wed Sep 26 16:24:26 2001
@@ -48,7 +48,7 @@
 	return maxlvt;
 }
 
-static void clear_local_APIC(void)
+void clear_local_APIC(void)
 {
 	int maxlvt;
 	unsigned long v;
@@ -254,6 +254,14 @@
 {
 	unsigned long value, ver, maxlvt;
 
+	/* Pound the ESR really hard over the head with a big hammer - mbligh */
+	if (esr_disable) {
+		apic_write(APIC_ESR, 0);
+		apic_write(APIC_ESR, 0);
+		apic_write(APIC_ESR, 0);
+		apic_write(APIC_ESR, 0);
+	}
+
 	value = apic_read(APIC_LVR);
 	ver = GET_APIC_VERSION(value);
 
@@ -262,8 +270,10 @@
 
 	/*
 	 * Double-check wether this APIC is really registered.
+	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
-	if (!test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
+	if (!clustered_apic_mode && 
+	    !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
 		BUG();
 
 	/*
@@ -272,19 +282,22 @@
 	 * document number 292116).  So here it goes...
 	 */
 
-	/*
-	 * Put the APIC into flat delivery mode.
-	 * Must be "all ones" explicitly for 82489DX.
-	 */
-	apic_write_around(APIC_DFR, 0xffffffff);
+	if (!clustered_apic_mode) {
+		/*
+		 * In clustered apic mode, the firmware does this for us 
+		 * Put the APIC into flat delivery mode.
+		 * Must be "all ones" explicitly for 82489DX.
+		 */
+		apic_write_around(APIC_DFR, 0xffffffff);
 
-	/*
-	 * Set up the logical destination ID.
-	 */
-	value = apic_read(APIC_LDR);
-	value &= ~APIC_LDR_MASK;
-	value |= (1<<(smp_processor_id()+24));
-	apic_write_around(APIC_LDR, value);
+		/*
+		 * Set up the logical destination ID.
+		 */
+		value = apic_read(APIC_LDR);
+		value &= ~APIC_LDR_MASK;
+		value |= (1<<(smp_processor_id()+24));
+		apic_write_around(APIC_LDR, value);
+	}
 
 	/*
 	 * Set Task Priority to 'accept all'. We never change this
@@ -367,7 +380,7 @@
 		value |= APIC_LVT_LEVEL_TRIGGER;
 	apic_write_around(APIC_LVT1, value);
 
-	if (APIC_INTEGRATED(ver)) {		/* !82489DX */
+	if (APIC_INTEGRATED(ver) && !esr_disable) {		/* !82489DX */
 		maxlvt = get_maxlvt();
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
 			apic_write(APIC_ESR, 0);
@@ -383,8 +396,18 @@
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
 		printk("ESR value after enabling vector: %08lx\n", value);
-	} else
-		printk("No ESR for 82489DX.\n");
+	} else {
+		if (esr_disable)	
+			/* 
+			 * Something untraceble is creating bad interrupts on 
+			 * secondary quads ... for the moment, just leave the
+			 * ESR disabled - we can't do anything useful with the
+			 * errors anyway - mbligh
+			 */
+			printk("Leaving ESR disabled.\n");
+		else 
+			printk("No ESR for 82489DX.\n");
+	}
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		setup_apic_nmi_watchdog();
@@ -598,7 +621,7 @@
 	}
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	boot_cpu_id = 0;
+	boot_cpu_physical_apicid = 0;
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
@@ -636,8 +659,8 @@
 	 * Fetch the APIC ID of the BSP in case we have a
 	 * default configuration (or the MP table is broken).
 	 */
-	if (boot_cpu_id == -1U)
-		boot_cpu_id = GET_APIC_ID(apic_read(APIC_ID));
+	if (boot_cpu_physical_apicid == -1U)
+		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
 
 #ifdef CONFIG_X86_IO_APIC
 	{
@@ -1077,9 +1100,9 @@
 	/*
 	 * Complain if the BIOS pretends there is one.
 	 */
-	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_id])) {
+	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
-			boot_cpu_id);
+			boot_cpu_physical_apicid);
 		return -1;
 	}
 
@@ -1088,7 +1111,7 @@
 	connect_bsp_APIC();
 
 	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_id);
+	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
 	apic_pm_init2();
 
diff -urN virgin-2.4.10/arch/i386/kernel/io_apic.c numa-2.4.10/arch/i386/kernel/io_apic.c
--- virgin-2.4.10/arch/i386/kernel/io_apic.c	Mon Sep 17 23:03:09 2001
+++ numa-2.4.10/arch/i386/kernel/io_apic.c	Wed Sep 26 16:04:34 2001
@@ -44,11 +44,6 @@
  */
 int nr_ioapic_registers[MAX_IO_APICS];
 
-#if CONFIG_SMP
-# define TARGET_CPUS cpu_online_map
-#else
-# define TARGET_CPUS 0x01
-#endif
 /*
  * Rough estimation of how many shared IRQs there are, can
  * be changed anytime.
@@ -603,7 +598,7 @@
 		memset(&entry,0,sizeof(entry));
 
 		entry.delivery_mode = dest_LowestPrio;
-		entry.dest_mode = 1;			/* logical delivery */
+		entry.dest_mode = INT_DELIVERY_MODE;
 		entry.mask = 0;				/* enable IRQ */
 		entry.dest.logical.logical_dest = TARGET_CPUS;
 
@@ -677,7 +672,7 @@
 	 * We use logical delivery to get the timer IRQ
 	 * to the first CPU.
 	 */
-	entry.dest_mode = 1;				/* logical delivery */
+	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
 	entry.dest.logical.logical_dest = TARGET_CPUS;
 	entry.delivery_mode = dest_LowestPrio;
@@ -1016,6 +1011,9 @@
 	unsigned char old_id;
 	unsigned long flags;
 
+	if (clustered_apic_mode)
+		/* We don't have a good way to do this yet - hack */
+		phys_id_present_map = (u_long) 0xf;
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
@@ -1053,7 +1051,11 @@
 				i);
 			phys_id_present_map |= 1 << i;
 			mp_ioapics[apic].mpc_apicid = i;
+		} else {
+			printk("Setting %d in the phys_id_present_map\n", mp_ioapics[apic].mpc_apicid);
+			phys_id_present_map |= 1 << mp_ioapics[apic].mpc_apicid;
 		}
+
 
 		/*
 		 * We need to adjust the IRQ routing table
diff -urN virgin-2.4.10/arch/i386/kernel/mpparse.c numa-2.4.10/arch/i386/kernel/mpparse.c
--- virgin-2.4.10/arch/i386/kernel/mpparse.c	Mon Sep 17 23:03:09 2001
+++ numa-2.4.10/arch/i386/kernel/mpparse.c	Wed Sep 26 16:04:34 2001
@@ -54,7 +54,7 @@
 unsigned long mp_lapic_addr;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_id = -1U;
+unsigned int boot_cpu_physical_apicid = -1U;
 /* Internal processor count */
 static unsigned int num_processors;
 
@@ -180,8 +180,9 @@
 
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
-		boot_cpu_id = m->mpc_apicid;
+		boot_cpu_physical_apicid = m->mpc_apicid;
 	}
+
 	num_processors++;
 
 	if (m->mpc_apicid > MAX_APICS) {
@@ -191,7 +192,12 @@
 	}
 	ver = m->mpc_apicver;
 
-	phys_cpu_present_map |= 1 << m->mpc_apicid;
+	if (clustered_apic_mode)
+		/* Crude temporary hack. Assumes processors are sequential */
+		phys_cpu_present_map |= 1 << (num_processors-1);
+	else
+		phys_cpu_present_map |= 1 << m->mpc_apicid;
+
 	/*
 	 * Validate version
 	 */
@@ -376,6 +382,10 @@
 				break;
 			}
 		}
+	}
+	if (clustered_apic_mode && nr_ioapics > 2) {
+		/* don't initialise IO apics on secondary quads */
+		nr_ioapics = 2;
 	}
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
diff -urN virgin-2.4.10/arch/i386/kernel/process.c numa-2.4.10/arch/i386/kernel/process.c
--- virgin-2.4.10/arch/i386/kernel/process.c	Mon Sep 17 22:52:35 2001
+++ numa-2.4.10/arch/i386/kernel/process.c	Wed Sep 26 16:38:53 2001
@@ -376,7 +376,7 @@
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
 		      !(phys_cpu_present_map & (1<<cpuid))) 
-			reboot_cpu = boot_cpu_id;
+			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
 		/* re-run this function on the other CPUs
diff -urN virgin-2.4.10/arch/i386/kernel/setup.c numa-2.4.10/arch/i386/kernel/setup.c
--- virgin-2.4.10/arch/i386/kernel/setup.c	Mon Sep 17 23:03:09 2001
+++ numa-2.4.10/arch/i386/kernel/setup.c	Wed Sep 26 16:04:34 2001
@@ -2416,7 +2416,12 @@
 	struct cpuinfo_x86 *c = cpu_data;
 	int i, n;
 
-	for (n = 0; n < NR_CPUS; n++, c++) {
+	/* 
+	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
+	 * page buffer and corrupts memory - this needs fixing properly
+	 */
+	for (n = 0; n < 8; n++, c++) {
+	/* for (n = 0; n < NR_CPUS; n++, c++) { */
 		int fpu_exception;
 #ifdef CONFIG_SMP
 		if (!(cpu_online_map & (1<<n)))
@@ -2479,7 +2484,7 @@
 	return p - buffer;
 }
 
-static unsigned long cpu_initialized __initdata = 0;
+unsigned long cpu_initialized __initdata = 0;
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
diff -urN virgin-2.4.10/arch/i386/kernel/smp.c numa-2.4.10/arch/i386/kernel/smp.c
--- virgin-2.4.10/arch/i386/kernel/smp.c	Mon Sep 17 23:03:09 2001
+++ numa-2.4.10/arch/i386/kernel/smp.c	Wed Sep 26 16:04:34 2001
@@ -20,6 +20,7 @@
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
+#include <asm/smpboot.h>
 
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
@@ -148,28 +149,12 @@
 	apic_write_around(APIC_ICR, cfg);
 }
 
-static inline void send_IPI_allbutself(int vector)
-{
-	/*
-	 * if there are no other CPUs in the system then
-	 * we get an APIC send error if we try to broadcast.
-	 * thus we have to avoid sending IPIs in this case.
-	 */
-	if (smp_num_cpus > 1)
-		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-}
-
-static inline void send_IPI_all(int vector)
-{
-	__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-}
-
 void send_IPI_self(int vector)
 {
 	__send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
-static inline void send_IPI_mask(int mask, int vector)
+static inline void send_IPI_mask_bitmask(int mask, int vector)
 {
 	unsigned long cfg;
 	unsigned long flags;
@@ -177,27 +162,120 @@
 	__save_flags(flags);
 	__cli();
 
+		
 	/*
 	 * Wait for idle.
 	 */
 	apic_wait_icr_idle();
-
+		
 	/*
 	 * prepare target chip field
 	 */
 	cfg = __prepare_ICR2(mask);
 	apic_write_around(APIC_ICR2, cfg);
-
+		
 	/*
 	 * program the ICR 
 	 */
 	cfg = __prepare_ICR(0, vector);
-	
+			
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
 	 */
 	apic_write_around(APIC_ICR, cfg);
+
 	__restore_flags(flags);
+}
+
+static inline void send_IPI_mask_sequence(int mask, int vector)
+{
+	unsigned long cfg, flags;
+	unsigned int query_cpu, query_mask;
+
+	/*
+	 * Hack. The clustered APIC addressing mode doesn't allow us to send 
+	 * to an arbitrary mask, so I do a unicasts to each CPU instead. This 
+	 * should be modified to do 1 message per cluster ID - mbligh
+	 */ 
+
+	__save_flags(flags);
+	__cli();
+
+	for (query_cpu = 0; query_cpu < NR_CPUS; ++query_cpu) {
+		query_mask = 1 << query_cpu;
+		if (query_mask & mask) {
+		
+			/*
+			 * Wait for idle.
+			 */
+			apic_wait_icr_idle();
+		
+			/*
+			 * prepare target chip field
+			 */
+			cfg = __prepare_ICR2(cpu_to_logical_apicid(query_cpu));
+			apic_write_around(APIC_ICR2, cfg);
+		
+			/*
+			 * program the ICR 
+			 */
+			cfg = __prepare_ICR(0, vector);
+			
+			/*
+			 * Send the IPI. The write to APIC_ICR fires this off.
+			 */
+			apic_write_around(APIC_ICR, cfg);
+		}
+	}
+	__restore_flags(flags);
+}
+
+static inline void send_IPI_mask(int mask, int vector)
+{
+	if (clustered_apic_mode) 
+		send_IPI_mask_sequence(mask, vector);
+	else
+		send_IPI_mask_bitmask(mask, vector);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	/*
+	 * if there are no other CPUs in the system then
+	 * we get an APIC send error if we try to broadcast.
+	 * thus we have to avoid sending IPIs in this case.
+	 */
+	if (!(smp_num_cpus > 1))
+		return;
+
+	if (clustered_apic_mode) {
+		// Pointless. Use send_IPI_mask to do this instead
+		int cpu;
+
+		if (smp_num_cpus > 1) {
+			for (cpu = 0; cpu < smp_num_cpus; ++cpu) {
+				if (cpu != smp_processor_id())
+					send_IPI_mask(1 << cpu, vector);
+			}
+		}
+	} else {
+		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+		return;
+	}
+}
+
+static inline void send_IPI_all(int vector)
+{
+	if (clustered_apic_mode) {
+		// Pointless. Use send_IPI_mask to do this instead
+		int cpu;
+
+		for (cpu = 0; cpu < smp_num_cpus; ++cpu) {
+			send_IPI_mask(1 << cpu, vector);
+		}
+	} else {
+		__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+	}
 }
 
 /*
diff -urN virgin-2.4.10/arch/i386/kernel/smpboot.c numa-2.4.10/arch/i386/kernel/smpboot.c
--- virgin-2.4.10/arch/i386/kernel/smpboot.c	Mon Sep 17 23:03:09 2001
+++ numa-2.4.10/arch/i386/kernel/smpboot.c	Fri Sep 28 15:23:32 2001
@@ -29,6 +29,7 @@
  *		Ingo Molnar	:	various cleanups and rewrites
  *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
+ *		Martin J. Bligh	: 	Added support for multi-quad systems
  */
 
 #include <linux/config.h>
@@ -44,6 +45,7 @@
 #include <linux/mc146818rtc.h>
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
+#include <asm/smpboot.h>
 
 /* Set if we find a B stepping CPU			*/
 static int smp_b_stepping;
@@ -57,11 +59,6 @@
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
 
-/* which CPU (physical APIC ID) maps to which logical CPU number */
-volatile int x86_apicid_to_cpu[NR_CPUS];
-/* which logical CPU number maps to which CPU (physical APIC ID) */
-volatile int x86_cpu_to_apicid[NR_CPUS];
-
 static volatile unsigned long cpu_callin_map;
 static volatile unsigned long cpu_callout_map;
 
@@ -357,7 +354,8 @@
 	 * our local APIC.  We have to wait for the IPI or we'll
 	 * lock up on an APIC access.
 	 */
-	while (!atomic_read(&init_deasserted));
+	if (!clustered_apic_mode) 
+		while (!atomic_read(&init_deasserted));
 
 	/*
 	 * (This works even if the APIC is not enabled.)
@@ -406,9 +404,15 @@
 	 */
 
 	Dprintk("CALLIN, before setup_local_APIC().\n");
+	/*
+	 * Because we use NMIs rather than the INIT-STARTUP sequence to
+	 * bootstrap the CPUs, the APIC may be in a wierd state. Kick it.
+	 */
+	if (clustered_apic_mode)
+		clear_local_APIC();
 	setup_local_APIC();
 
-	sti();
+	__sti();
 
 #ifdef CONFIG_MTRR
 	/*
@@ -458,11 +462,20 @@
 	while (!atomic_read(&smp_commenced))
 		rep_nop();
 	/*
+	 * Removing the next 2 printk's causes an undiagnosable BINT error
+	 * in multiquad mode. Seems the console lock serialises the procs? 
+	 * As of 2.4.10, these printk's panic the kernel if I have serial
+	 * console enabled. Aarrrgggh. mbligh
+	 */
+	if (clustered_apic_mode)
+		printk("Before tlbflush - processor: %d\n", current->processor);
+	/*
 	 * low-memory mappings have been cleared, flush them from
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-
+	if (clustered_apic_mode)
+		printk("After tlbflush - processor: %d\n", current->processor);
 	return cpu_idle();
 }
 
@@ -501,6 +514,61 @@
 	return do_fork(CLONE_VM|CLONE_PID, 0, &regs, 0);
 }
 
+/* which physical APIC ID maps to which logical CPU number */
+volatile int physical_apicid_2_cpu[MAX_APICID];
+/* which logical CPU number maps to which physical APIC ID */
+volatile int cpu_2_physical_apicid[NR_CPUS];
+
+/* which logical APIC ID maps to which logical CPU number */
+volatile int logical_apicid_2_cpu[MAX_APICID];
+/* which logical CPU number maps to which logical APIC ID */
+volatile int cpu_2_logical_apicid[NR_CPUS];
+
+static inline void init_cpu_to_apicid(void)
+/* Initialize all maps between cpu number and apicids */
+{
+	int apicid, cpu;
+
+	for (apicid = 0; apicid < MAX_APICID; apicid++) {
+		physical_apicid_2_cpu[apicid] = -1;
+		logical_apicid_2_cpu[apicid] = -1;
+	}
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cpu_2_physical_apicid[cpu] = -1;
+		cpu_2_logical_apicid[cpu] = -1;
+	}
+}
+
+static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
+/* 
+ * set up a mapping between cpu and apicid. Uses logical apicids for multiquad,
+ * else physical apic ids
+ */
+{
+	if (clustered_apic_mode) {
+		logical_apicid_2_cpu[apicid] = cpu;	
+		cpu_2_logical_apicid[cpu] = apicid;
+	} else {
+		physical_apicid_2_cpu[apicid] = cpu;	
+		cpu_2_physical_apicid[cpu] = apicid;
+	}
+}
+
+static inline void unmap_cpu_to_boot_apicid(int cpu, int apicid)
+/* 
+ * undo a mapping between cpu and apicid. Uses logical apicids for multiquad,
+ * else physical apic ids
+ */
+{
+	if (clustered_apic_mode) {
+		logical_apicid_2_cpu[apicid] = -1;	
+		cpu_2_logical_apicid[cpu] = -1;
+	} else {
+		physical_apicid_2_cpu[apicid] = -1;	
+		cpu_2_physical_apicid[cpu] = -1;
+	}
+}
+
 #if APIC_DEBUG
 static inline void inquire_remote_apic(int apicid)
 {
@@ -539,89 +607,65 @@
 }
 #endif
 
-static void __init do_boot_cpu (int apicid)
+static int wakeup_secondary_via_NMI(int logical_apicid)
+/* 
+ * Poke the other CPU in the eye to wake it up. Remember that the normal
+ * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
+ * won't ... remember to clear down the APIC, etc later.
+ */
 {
-	struct task_struct *idle;
-	unsigned long send_status, accept_status, boot_status, maxlvt;
-	int timeout, num_starts, j, cpu;
-	unsigned long start_eip;
-
-	cpu = ++cpucount;
-	/*
-	 * We can't use kernel_thread since we must avoid to
-	 * reschedule the child.
-	 */
-	if (fork_by_hand() < 0)
-		panic("failed fork for CPU %d", cpu);
-
-	/*
-	 * We remove it from the pidhash and the runqueue
-	 * once we got the process:
-	 */
-	idle = init_task.prev_task;
-	if (!idle)
-		panic("No idle process for CPU %d", cpu);
+	unsigned long send_status = 0, accept_status = 0;
+	int timeout, maxlvt;
 
-	idle->processor = cpu;
-	x86_cpu_to_apicid[cpu] = apicid;
-	x86_apicid_to_cpu[apicid] = cpu;
-	idle->has_cpu = 1; /* we schedule the first task manually */
-	idle->thread.eip = (unsigned long) start_secondary;
-
-	del_from_runqueue(idle);
-	unhash_process(idle);
-	init_tasks[cpu] = idle;
+	/* Target chip */
+	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(logical_apicid));
 
-	/* start_eip had better be page-aligned! */
-	start_eip = setup_trampoline();
+	/* Boot on the stack */
+	/* Kick the second */
+	apic_write_around(APIC_ICR, APIC_DM_NMI | APIC_DEST_LOGICAL);
 
-	/* So we see what's up   */
-	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+	Dprintk("Waiting for send to finish...\n");
+	timeout = 0;
+	do {
+		Dprintk("+");
+		udelay(100);
+		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
+	} while (send_status && (timeout++ < 1000));
 
 	/*
-	 * This grunge runs the startup process for
-	 * the targeted processor.
+	 * Give the other CPU some time to accept the IPI.
 	 */
-
-	atomic_set(&init_deasserted, 0);
-
-	Dprintk("Setting warm reset code and vector.\n");
-
-	CMOS_WRITE(0xa, 0xf);
-	local_flush_tlb();
-	Dprintk("1.\n");
-	*((volatile unsigned short *) phys_to_virt(0x469)) = start_eip >> 4;
-	Dprintk("2.\n");
-	*((volatile unsigned short *) phys_to_virt(0x467)) = start_eip & 0xf;
-	Dprintk("3.\n");
-
+	udelay(200);
 	/*
-	 * Be paranoid about clearing APIC errors.
+	 * Due to the Pentium erratum 3AP.
 	 */
-	if (APIC_INTEGRATED(apic_version[apicid])) {
+	maxlvt = get_maxlvt();
+	if (maxlvt > 3) {
 		apic_read_around(APIC_SPIV);
 		apic_write(APIC_ESR, 0);
-		apic_read(APIC_ESR);
 	}
+	accept_status = (apic_read(APIC_ESR) & 0xEF);
+	Dprintk("NMI sent.\n");
 
-	/*
-	 * Status is now clean
-	 */
-	send_status = 0;
-	accept_status = 0;
-	boot_status = 0;
+	if (send_status)
+		printk("APIC never delivered???\n");
+	if (accept_status)
+		printk("APIC delivery error (%lx).\n", accept_status);
 
-	/*
-	 * Starting actual IPI sequence...
-	 */
+	return (send_status | accept_status);
+}
+
+static int wakeup_secondary_via_INIT(int phys_apicid, unsigned long start_eip)
+{
+	unsigned long send_status = 0, accept_status = 0;
+	int maxlvt, timeout, num_starts, j;
 
 	Dprintk("Asserting INIT.\n");
 
 	/*
 	 * Turn INIT on target chip
 	 */
-	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(apicid));
+	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(phys_apicid));
 
 	/*
 	 * Send IPI
@@ -642,7 +686,7 @@
 	Dprintk("Deasserting INIT.\n");
 
 	/* Target chip */
-	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(apicid));
+	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(phys_apicid));
 
 	/* Send IPI */
 	apic_write_around(APIC_ICR, APIC_INT_LEVELTRIG | APIC_DM_INIT);
@@ -661,10 +705,9 @@
 	 * Should we send STARTUP IPIs ?
 	 *
 	 * Determine this based on the APIC version.
-	 * If we don't have an integrated APIC, don't
-	 * send the STARTUP IPIs.
+	 * If we don't have an integrated APIC, don't send the STARTUP IPIs.
 	 */
-	if (APIC_INTEGRATED(apic_version[apicid]))
+	if (APIC_INTEGRATED(apic_version[phys_apicid]))
 		num_starts = 2;
 	else
 		num_starts = 0;
@@ -688,7 +731,7 @@
 		 */
 
 		/* Target chip */
-		apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(apicid));
+		apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(phys_apicid));
 
 		/* Boot on the stack */
 		/* Kick the second */
@@ -732,7 +775,104 @@
 	if (accept_status)
 		printk("APIC delivery error (%lx).\n", accept_status);
 
-	if (!send_status && !accept_status) {
+	return (send_status | accept_status);
+}
+
+extern unsigned long cpu_initialized;
+
+static void __init do_boot_cpu (int apicid) 
+/*
+ * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
+ * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
+ */
+{
+	struct task_struct *idle;
+	unsigned long boot_error = 0;
+	int timeout, cpu;
+	unsigned long start_eip;
+	unsigned short nmi_high, nmi_low;
+
+	cpu = ++cpucount;
+	/*
+	 * We can't use kernel_thread since we must avoid to
+	 * reschedule the child.
+	 */
+	if (fork_by_hand() < 0)
+		panic("failed fork for CPU %d", cpu);
+
+	/*
+	 * We remove it from the pidhash and the runqueue
+	 * once we got the process:
+	 */
+	idle = init_task.prev_task;
+	if (!idle)
+		panic("No idle process for CPU %d", cpu);
+
+	idle->processor = cpu;
+
+	map_cpu_to_boot_apicid(cpu, apicid);
+
+	idle->has_cpu = 1; /* we schedule the first task manually */
+	idle->thread.eip = (unsigned long) start_secondary;
+
+	del_from_runqueue(idle);
+	unhash_process(idle);
+	init_tasks[cpu] = idle;
+
+	/* start_eip had better be page-aligned! */
+	start_eip = setup_trampoline();
+
+	/* So we see what's up   */
+	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
+	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
+
+	/*
+	 * This grunge runs the startup process for
+	 * the targeted processor.
+	 */
+
+	atomic_set(&init_deasserted, 0);
+
+	Dprintk("Setting warm reset code and vector.\n");
+
+	if (clustered_apic_mode) {
+		/* stash the current NMI vector, so we can put things back */
+		nmi_high = *((volatile unsigned short *) TRAMPOLINE_HIGH);
+		nmi_low = *((volatile unsigned short *) TRAMPOLINE_LOW);
+	} 
+
+	CMOS_WRITE(0xa, 0xf);
+	local_flush_tlb();
+	Dprintk("1.\n");
+	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
+	Dprintk("2.\n");
+	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
+	Dprintk("3.\n");
+
+	/*
+	 * Be paranoid about clearing APIC errors.
+	 */
+	if (!clustered_apic_mode && APIC_INTEGRATED(apic_version[apicid])) {
+		apic_read_around(APIC_SPIV);
+		apic_write(APIC_ESR, 0);
+		apic_read(APIC_ESR);
+	}
+
+	/*
+	 * Status is now clean
+	 */
+	boot_error = 0;
+
+	/*
+	 * Starting actual IPI sequence...
+	 */
+
+	if (clustered_apic_mode)
+		boot_error = wakeup_secondary_via_NMI(apicid);
+	else 
+		boot_error = wakeup_secondary_via_INIT(apicid, start_eip);
+
+	if (!boot_error) {
 		/*
 		 * allow APs to start initializing.
 		 */
@@ -756,7 +896,7 @@
 			print_cpu_info(&cpu_data[cpu]);
 			Dprintk("CPU has booted.\n");
 		} else {
-			boot_status = 1;
+			boot_error= 1;
 			if (*((volatile unsigned char *)phys_to_virt(8192))
 					== 0xA5)
 				/* trampoline started but...? */
@@ -765,18 +905,28 @@
 				/* trampoline code not run */
 				printk("Not responding.\n");
 #if APIC_DEBUG
-			inquire_remote_apic(apicid);
+			if (!clustered_apic_mode)
+				inquire_remote_apic(apicid);
 #endif
 		}
 	}
-	if (send_status || accept_status || boot_status) {
-		x86_cpu_to_apicid[cpu] = -1;
-		x86_apicid_to_cpu[apicid] = -1;
+	if (boot_error) {
+		/* Try to put things back the way they were before ... */
+		unmap_cpu_to_boot_apicid(cpu, apicid);
+		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
+		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
 		cpucount--;
 	}
 
 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)phys_to_virt(8192)) = 0;
+
+	if(clustered_apic_mode) {
+		printk("Restoring NMI vector\n");
+		*((volatile unsigned short *) TRAMPOLINE_HIGH) = nmi_high;
+		*((volatile unsigned short *) TRAMPOLINE_LOW) = nmi_low;
+	}
 }
 
 cycles_t cacheflush_time;
@@ -826,9 +976,20 @@
 extern int prof_old_multiplier[NR_CPUS];
 extern int prof_counter[NR_CPUS];
 
+static int boot_cpu_logical_apicid;
+/* Where the IO area was mapped on multiquad, always 0 otherwise */
+void *xquad_portio = NULL;
+
 void __init smp_boot_cpus(void)
 {
-	int apicid, cpu;
+	int apicid, cpu, bit;
+
+        if (clustered_apic_mode) {
+                /* remap the 1st quad's 256k range for cross-quad I/O */
+                xquad_portio = ioremap (XQUAD_PORTIO_BASE, XQUAD_PORTIO_LEN);
+                printk("Cross quad port I/O vaddr 0x%08lx, len %08lx\n",
+                        (u_long) xquad_portio, (u_long) XQUAD_PORTIO_LEN);
+        }
 
 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */
@@ -839,13 +1000,14 @@
 	 * and the per-CPU profiling counter/multiplier
 	 */
 
-	for (apicid = 0; apicid < NR_CPUS; apicid++) {
-		x86_apicid_to_cpu[apicid] = -1;
-		prof_counter[apicid] = 1;
-		prof_old_multiplier[apicid] = 1;
-		prof_multiplier[apicid] = 1;
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		prof_counter[cpu] = 1;
+		prof_old_multiplier[cpu] = 1;
+		prof_multiplier[cpu] = 1;
 	}
 
+	init_cpu_to_apicid();
+
 	/*
 	 * Setup boot CPU information
 	 */
@@ -857,8 +1019,9 @@
 	 * We have the boot CPU online for sure.
 	 */
 	set_bit(0, &cpu_online_map);
-	x86_apicid_to_cpu[boot_cpu_id] = 0;
-	x86_cpu_to_apicid[0] = boot_cpu_id;
+	boot_cpu_logical_apicid = logical_smp_processor_id();
+	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
+
 	global_irq_holder = 0;
 	current->processor = 0;
 	init_idle();
@@ -884,20 +1047,22 @@
 	/*
 	 * Should not be necessary because the MP table should list the boot
 	 * CPU too, but we do it for the sake of robustness anyway.
+	 * Makes no sense to do this check in clustered apic mode, so skip it
 	 */
-	if (!test_bit(boot_cpu_id, &phys_cpu_present_map)) {
+	if (!clustered_apic_mode && 
+	    !test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
-								 boot_cpu_id);
+							boot_cpu_physical_apicid);
 		phys_cpu_present_map |= (1 << hard_smp_processor_id());
 	}
 
 	/*
 	 * If we couldn't find a local APIC, then get out of here now!
 	 */
-	if (APIC_INTEGRATED(apic_version[boot_cpu_id]) &&
+	if (APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid]) &&
 	    !test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability)) {
 		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
-			boot_cpu_id);
+			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 #ifndef CONFIG_VISWS
 		io_apic_irqs = 0;
@@ -926,22 +1091,27 @@
 	connect_bsp_APIC();
 	setup_local_APIC();
 
-	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_id)
+	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
 		BUG();
 
 	/*
-	 * Now scan the CPU present map and fire up the other CPUs.
+	 * Scan the CPU present map and fire up the other CPUs via do_boot_cpu
+	 *
+	 * In clustered apic mode, phys_cpu_present_map is a constructed thus:
+	 * bits 0-3 are quad0, 4-7 are quad1, etc. A perverse twist on the 
+	 * clustered apic ID.
 	 */
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
-	for (apicid = 0; apicid < NR_CPUS; apicid++) {
+	for (bit = 0; bit < NR_CPUS; bit++) {
+		apicid = cpu_present_to_apicid(bit);
 		/*
 		 * Don't even attempt to start the boot CPU!
 		 */
-		if (apicid == boot_cpu_id)
+		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << apicid)))
+		if (!(phys_cpu_present_map & (1 << bit)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
@@ -951,9 +1121,10 @@
 		/*
 		 * Make sure we unmap all failed CPUs
 		 */
-		if ((x86_apicid_to_cpu[apicid] == -1) &&
-				(phys_cpu_present_map & (1 << apicid)))
-			printk("phys CPU #%d not responding - cannot use it.\n",apicid);
+		if ((boot_apicid_to_cpu(apicid) == -1) &&
+				(phys_cpu_present_map & (1 << bit)))
+			printk("CPU #%d not responding - cannot use it.\n",
+								apicid);
 	}
 
 	/*
diff -urN virgin-2.4.10/arch/i386/kernel/trampoline.S numa-2.4.10/arch/i386/kernel/trampoline.S
--- virgin-2.4.10/arch/i386/kernel/trampoline.S	Mon Feb  7 19:59:39 2000
+++ numa-2.4.10/arch/i386/kernel/trampoline.S	Wed Sep 26 16:04:34 2001
@@ -36,7 +36,9 @@
 
 ENTRY(trampoline_data)
 r_base = .
-
+#ifdef CONFIG_MULTIQUAD
+	wbinvd
+#endif /* CONFIG_MULTIQUAD */
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds
 
diff -urN virgin-2.4.10/include/asm-i386/apic.h numa-2.4.10/include/asm-i386/apic.h
--- virgin-2.4.10/include/asm-i386/apic.h	Sun Sep 23 10:31:02 2001
+++ numa-2.4.10/include/asm-i386/apic.h	Wed Sep 26 16:04:35 2001
@@ -64,6 +64,7 @@
 }
 
 extern int get_maxlvt(void);
+extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
 extern void disconnect_bsp_APIC (void);
 extern void disable_local_APIC (void);
diff -urN virgin-2.4.10/include/asm-i386/io.h numa-2.4.10/include/asm-i386/io.h
--- virgin-2.4.10/include/asm-i386/io.h	Sun Sep 23 10:31:22 2001
+++ numa-2.4.10/include/asm-i386/io.h	Wed Sep 26 16:04:35 2001
@@ -36,75 +36,11 @@
   *  - Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   */
 
-#ifdef SLOW_IO_BY_JUMPING
-#define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
-#else
-#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
-#endif
-
-#ifdef REALLY_SLOW_IO
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
-#else
-#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
-#endif
-
-/*
- * Talk about misusing macros..
- */
-#define __OUT1(s,x) \
-static inline void out##s(unsigned x value, unsigned short port) {
-
-#define __OUT2(s,s1,s2) \
-__asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
-
-#define __OUT(s,s1,x) \
-__OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
-__OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
-
-#define __IN1(s) \
-static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
-
-#define __IN2(s,s1,s2) \
-__asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
-
-#define __IN(s,s1,i...) \
-__IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-__IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
-
-#define __INS(s) \
-static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
-{ __asm__ __volatile__ ("rep ; ins" #s \
-: "=D" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
-
-#define __OUTS(s) \
-static inline void outs##s(unsigned short port, const void * addr, unsigned long count) \
-{ __asm__ __volatile__ ("rep ; outs" #s \
-: "=S" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
-
-#define RETURN_TYPE unsigned char
-__IN(b,"")
-#undef RETURN_TYPE
-#define RETURN_TYPE unsigned short
-__IN(w,"")
-#undef RETURN_TYPE
-#define RETURN_TYPE unsigned int
-__IN(l,"")
-#undef RETURN_TYPE
-
-__OUT(b,"b",char)
-__OUT(w,"w",short)
-__OUT(l,,int)
-
-__INS(b)
-__INS(w)
-__INS(l)
-
-__OUTS(b)
-__OUTS(w)
-__OUTS(l)
-
 #define IO_SPACE_LIMIT 0xffff
 
+#define XQUAD_PORTIO_BASE 0xfe400000
+#define XQUAD_PORTIO_LEN  0x40000   /* 256k per quad. Only remapping 1st */
+
 #ifdef __KERNEL__
 
 #include <linux/vmalloc.h>
@@ -260,5 +196,111 @@
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)
 
 #endif /* __KERNEL__ */
+
+#ifdef SLOW_IO_BY_JUMPING
+#define __SLOW_DOWN_IO "\njmp 1f\n1:\tjmp 1f\n1:"
+#else
+#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
+#endif
+
+#ifdef REALLY_SLOW_IO
+#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
+#else
+#define __FULL_SLOW_DOWN_IO __SLOW_DOWN_IO
+#endif
+
+#ifdef CONFIG_MULTIQUAD
+extern void *xquad_portio;    /* Where the IO area was mapped */
+#endif /* CONFIG_MULTIQUAD */
+
+/*
+ * Talk about misusing macros..
+ */
+#define __OUT1(s,x) \
+static inline void out##s(unsigned x value, unsigned short port) {
+
+#define __OUT2(s,s1,s2) \
+__asm__ __volatile__ ("out" #s " %" s1 "0,%" s2 "1"
+
+#ifdef CONFIG_MULTIQUAD
+/* Make the default portio routines operate on quad 0 for now */
+#define __OUT(s,s1,x) \
+__OUT1(s##_local,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
+__OUT1(s##_p_local,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} \
+__OUTQ0(s,s,x) \
+__OUTQ0(s,s##_p,x) 
+#else
+#define __OUT(s,s1,x) \
+__OUT1(s,x) __OUT2(s,s1,"w") : : "a" (value), "Nd" (port)); } \
+__OUT1(s##_p,x) __OUT2(s,s1,"w") __FULL_SLOW_DOWN_IO : : "a" (value), "Nd" (port));} 
+#endif /* CONFIG_MULTIQUAD */
+
+#ifdef CONFIG_MULTIQUAD
+#define __OUTQ0(s,ss,x)    /* Do the equivalent of the portio op on quad 0 */ \
+static inline void out##ss(unsigned x value, unsigned short port) { \
+	if (xquad_portio) \
+		write##s(value, (unsigned long) xquad_portio + port); \
+	else               /* We're still in early boot, running on quad 0 */ \
+		out##ss##_local(value, port); \
+} 
+
+#define __INQ0(s,ss)       /* Do the equivalent of the portio op on quad 0 */ \
+static inline RETURN_TYPE in##ss(unsigned short port) { \
+	if (xquad_portio) \
+		return read##s((unsigned long) xquad_portio + port); \
+	else               /* We're still in early boot, running on quad 0 */ \
+		return in##ss##_local(port); \
+}
+#endif /* CONFIG_MULTIQUAD */
+
+#define __IN1(s) \
+static inline RETURN_TYPE in##s(unsigned short port) { RETURN_TYPE _v;
+
+#define __IN2(s,s1,s2) \
+__asm__ __volatile__ ("in" #s " %" s2 "1,%" s1 "0"
+
+#ifdef CONFIG_MULTIQUAD
+#define __IN(s,s1,i...) \
+__IN1(s##_local) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
+__IN1(s##_p_local) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
+__INQ0(s,s) \
+__INQ0(s,s##_p) 
+#else
+#define __IN(s,s1,i...) \
+__IN1(s) __IN2(s,s1,"w") : "=a" (_v) : "Nd" (port) ,##i ); return _v; } \
+__IN1(s##_p) __IN2(s,s1,"w") __FULL_SLOW_DOWN_IO : "=a" (_v) : "Nd" (port) ,##i ); return _v; } 
+#endif /* CONFIG_MULTIQUAD */
+
+#define __INS(s) \
+static inline void ins##s(unsigned short port, void * addr, unsigned long count) \
+{ __asm__ __volatile__ ("rep ; ins" #s \
+: "=D" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
+
+#define __OUTS(s) \
+static inline void outs##s(unsigned short port, const void * addr, unsigned long count) \
+{ __asm__ __volatile__ ("rep ; outs" #s \
+: "=S" (addr), "=c" (count) : "d" (port),"0" (addr),"1" (count)); }
+
+#define RETURN_TYPE unsigned char
+__IN(b,"")
+#undef RETURN_TYPE
+#define RETURN_TYPE unsigned short
+__IN(w,"")
+#undef RETURN_TYPE
+#define RETURN_TYPE unsigned int
+__IN(l,"")
+#undef RETURN_TYPE
+
+__OUT(b,"b",char)
+__OUT(w,"w",short)
+__OUT(l,,int)
+
+__INS(b)
+__INS(w)
+__INS(l)
+
+__OUTS(b)
+__OUTS(w)
+__OUTS(l)
 
 #endif
diff -urN virgin-2.4.10/include/asm-i386/mpspec.h numa-2.4.10/include/asm-i386/mpspec.h
--- virgin-2.4.10/include/asm-i386/mpspec.h	Tue Sep 18 11:21:04 2001
+++ numa-2.4.10/include/asm-i386/mpspec.h	Wed Sep 26 16:04:35 2001
@@ -156,7 +156,7 @@
  *	7	2 CPU MCA+PCI
  */
 
-#define MAX_IRQ_SOURCES 128
+#define MAX_IRQ_SOURCES 256
 #define MAX_MP_BUSSES 32
 enum mp_bustype {
 	MP_BUS_ISA = 1,
@@ -167,7 +167,7 @@
 extern int mp_bus_id_to_type [MAX_MP_BUSSES];
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
-extern unsigned int boot_cpu_id;
+extern unsigned int boot_cpu_physical_apicid;
 extern unsigned long phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
diff -urN virgin-2.4.10/include/asm-i386/smp.h numa-2.4.10/include/asm-i386/smp.h
--- virgin-2.4.10/include/asm-i386/smp.h	Sun Sep 23 10:31:02 2001
+++ numa-2.4.10/include/asm-i386/smp.h	Wed Sep 26 16:04:35 2001
@@ -22,6 +22,18 @@
 #endif
 #endif
 
+#if CONFIG_SMP
+# ifdef CONFIG_MULTIQUAD
+#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
+#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
+# else
+#  define TARGET_CPUS cpu_online_map
+#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
+# endif
+#else
+# define TARGET_CPUS 0x01
+#endif
+
 #ifdef CONFIG_SMP
 #ifndef ASSEMBLY
 
@@ -59,8 +71,21 @@
  * Some lowlevel functions might want to know about
  * the real APIC ID <-> CPU # mapping.
  */
-extern volatile int x86_apicid_to_cpu[NR_CPUS];
-extern volatile int x86_cpu_to_apicid[NR_CPUS];
+#define MAX_APICID 256
+extern volatile int cpu_to_physical_apicid[NR_CPUS];
+extern volatile int physical_apicid_to_cpu[MAX_APICID];
+extern volatile int cpu_to_logical_apicid[NR_CPUS];
+extern volatile int logical_apicid_to_cpu[MAX_APICID];
+
+#ifndef clustered_apic_mode
+ #ifdef CONFIG_MULTIQUAD
+  #define clustered_apic_mode (1)
+  #define esr_disable (1)
+ #else /* !CONFIG_MULTIQUAD */
+  #define clustered_apic_mode (0)
+  #define esr_disable (0)
+ #endif /* CONFIG_MULTIQUAD */
+#endif 
 
 /*
  * General functions that each host system must provide.
@@ -81,6 +106,12 @@
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
+}
+
+extern __inline int logical_smp_processor_id(void)
+{
+	/* we don't want to mark this access volatile - bad code generation */
+	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
 
 #endif /* !ASSEMBLY */
diff -urN virgin-2.4.10/include/asm-i386/smpboot.h numa-2.4.10/include/asm-i386/smpboot.h
--- virgin-2.4.10/include/asm-i386/smpboot.h	Wed Dec 31 16:00:00 1969
+++ numa-2.4.10/include/asm-i386/smpboot.h	Wed Sep 26 16:04:35 2001
@@ -0,0 +1,62 @@
+#ifndef __ASM_SMPBOOT_H
+#define __ASM_SMPBOOT_H
+
+#ifndef clustered_apic_mode
+ #ifdef CONFIG_MULTIQUAD
+  #define clustered_apic_mode (1)
+ #else /* !CONFIG_MULTIQUAD */
+  #define clustered_apic_mode (0)
+ #endif /* CONFIG_MULTIQUAD */
+#endif 
+ 
+#ifdef CONFIG_MULTIQUAD
+ #define TRAMPOLINE_LOW phys_to_virt(0x8)
+ #define TRAMPOLINE_HIGH phys_to_virt(0xa)
+#else /* !CONFIG_MULTIQUAD */
+ #define TRAMPOLINE_LOW phys_to_virt(0x467)
+ #define TRAMPOLINE_HIGH phys_to_virt(0x469)
+#endif /* CONFIG_MULTIQUAD */
+
+#ifdef CONFIG_MULTIQUAD
+ #define boot_cpu_apicid boot_cpu_logical_apicid
+#else /* !CONFIG_MULTIQUAD */
+ #define boot_cpu_apicid boot_cpu_physical_apicid
+#endif /* CONFIG_MULTIQUAD */
+
+/*
+ * How to map from the cpu_present_map
+ */
+#ifdef CONFIG_MULTIQUAD
+ #define cpu_present_to_apicid(mps_cpu) ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) )
+#else /* !CONFIG_MULTIQUAD */
+ #define cpu_present_to_apicid(apicid) (apicid)
+#endif /* CONFIG_MULTIQUAD */
+
+/*
+ * Mappings between logical cpu number and logical / physical apicid
+ * The first four macros are trivial, but it keeps the abstraction consistent
+ */
+extern volatile int logical_apicid_2_cpu[];
+extern volatile int cpu_2_logical_apicid[];
+extern volatile int physical_apicid_2_cpu[];
+extern volatile int cpu_2_physical_apicid[];
+
+#define logical_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
+#define cpu_to_logical_apicid(cpu) cpu_2_logical_apicid[cpu]
+#define physical_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
+#define cpu_to_physical_apicid(cpu) cpu_2_physical_apicid[cpu]
+#ifdef CONFIG_MULTIQUAD			/* use logical IDs to bootstrap */
+#define boot_apicid_to_cpu(apicid) logical_apicid_2_cpu[apicid]
+#define cpu_to_boot_apicid(cpu) cpu_2_logical_apicid[cpu]
+#else /* !CONFIG_MULTIQUAD */		/* use physical IDs to bootstrap */
+#define boot_apicid_to_cpu(apicid) physical_apicid_2_cpu[apicid]
+#define cpu_to_boot_apicid(cpu) cpu_2_physical_apicid[cpu]
+#endif /* CONFIG_MULTIQUAD */
+
+
+#ifdef CONFIG_MULTIQUAD
+#else /* !CONFIG_MULTIQUAD */
+#endif /* CONFIG_MULTIQUAD */
+
+
+#endif
diff -urN virgin-2.4.10/init/main.c numa-2.4.10/init/main.c
--- virgin-2.4.10/init/main.c	Thu Sep 20 21:02:01 2001
+++ numa-2.4.10/init/main.c	Fri Sep 28 15:23:19 2001
@@ -519,7 +519,7 @@
 /*
  *	Activate the first processor.
  */
- 
+
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;

