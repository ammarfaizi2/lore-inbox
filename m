Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbRGTWFW>; Fri, 20 Jul 2001 18:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbRGTWFP>; Fri, 20 Jul 2001 18:05:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44688 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267452AbRGTWFH>; Fri, 20 Jul 2001 18:05:07 -0400
Date: Fri, 20 Jul 2001 15:04:14 -0700
From: "Martin J. Bligh" <mbligh@sequent.com>
Reply-To: "Martin J. Bligh" <mbligh@sequent.com>
To: linux-kernel@vger.kernel.org
Subject: Patches to enable Linux on a multiquad NUMA system (32 proc i386)
Message-ID: <3504009338.995641454@W-MBLIG.beaverton.ibm.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Appended are patches which make Linux function on a multiquad
ia32 NUMA system (specifically an IBM / Sequent NUMA-Q, but
much of the code will be common to other similar systems). They
should work from 2.4.2 - 2.4.6 cleanly.

I'd welcome any comments / input / questions on the code below.
Intent is to submit (sometime real soon) for hopeful inclusion into the
main kernel tree.

The code should enable a system up to 32 procs, but has only
been tested on a 16 proc system at this time (16Gb of memory).
Note that this code does NOT make Linux aware from a performance
perspective that it is running on a NUMA system (no node-local
memory allocation, text replication, multi-path IO etc), but it does
enable it to function. It seems stable and reasonably fast. Performance
enhancements will follow later ;-)

The code has quite a few small tweaks, but only a two major changes:

1. Change the APIC addressing mode from "logical flat" to
"logical clustered". See chapter 7 of vol 3 of the Intel Pentium 3
developers manual for a description.

2. Bootstrap the secondary processors via an NMI rather than the
usual INIT ASSERT, INIT DEASSERT, STARTUP sequence of
IPIs.

I've tried to keep nearly all of the changes under #ifdef
CONFIG_MULTIQUAD, so that impact to non multiquad systems
should be very minimal to non-existant. I think that a few of the
changes might be good generic improvements, but for the moment,
low impact was the intent.

This might perturb people:
-extern volatile int x86_apicid_to_cpu[NR_CPUS];
-extern volatile int x86_cpu_to_apicid[NR_CPUS];
+extern volatile int p_apicid_to_cpu[MAX_P_APICID];   /* phys apicid -> cpu 
*/
+extern volatile int cpu_to_p_apicid[NR_CPUS];        /* cpu -> phys apicid 
*/
+extern volatile int l_apicid_to_cpu[MAX_L_APICID];   /* log apicid -> cpu 
*/
+extern volatile int cpu_to_l_apicid[NR_CPUS];        /* cpu -> log apicid 
*/

The change in naming here is for two reasons:

1. I'm trying to make people really think about, and be clear
about, whether they're using physical or logical adresses. It's
not a 1-1 map anymore (at least for multiquad).

2. Multiquad actually needs to use BOTH the physical and
logical addressing, so I can't just overload the meaning of
the existing x86 arrays.

There are a couple of bits of "voodoo" code where we need
to poke the hardware in a particular way to make it work (from
empirical experience). I've tried to label anything like this with
my name in the comment so that people can come back and
slap me for it later. There are a few disgusting quick hacks still
there, but I decided to publish and be damned at this point ...
they should be clearly commented.

Martin J. Bligh (IBM Linux Technology Center)

PS. Though I wrote the patches below, several others have
had a hand in helping me to design / debug it ;-) Thanks to
those at IBM and the OSDL who've helped do this ...

--------------------------------------------------------------

diff -urN virgin-2.4.6/Documentation/Configure.help 
linux-2.4.6/Documentation/Configure.help
--- virgin-2.4.6/Documentation/Configure.help	Mon Jul  2 14:07:55 2001
+++ linux-2.4.6/Documentation/Configure.help	Thu Jul 19 11:49:04 2001
@@ -119,6 +119,16 @@
   SMP-FAQ on the WWW at http://www.irisa.fr/prive/mentre/smp-faq/ .

   If you don't know what to do here, say N.
+
+Multiquad support for NUMA systems
+CONFIG_MULTIQUAD
+  This option is used for getting Linux to run on a (IBM/Sequent)
+  NUMA multiquad box (and quite possibly others using clustered
+  APIC addressing mode). This changes the way that processors are
+  bootstrapped, and uses Clustered Logical APIC addressing mode
+  instead of Flat Logical. For a Sequent / IBM NUMA-Q system, you
+  will need a new lynxer.elf file to flash your firmware with -
+  send email to mbligh@us.ibm.com

 APIC and IO-APIC Support on Uniprocessors
 CONFIG_X86_UP_IOAPIC
diff -urN virgin-2.4.6/arch/i386/config.in linux-2.4.6/arch/i386/config.in
--- virgin-2.4.6/arch/i386/config.in	Wed Jun 20 17:47:39 2001
+++ linux-2.4.6/arch/i386/config.in	Thu Jul 19 11:20:11 2001
@@ -175,6 +175,8 @@
       define_bool CONFIG_X86_IO_APIC y
       define_bool CONFIG_X86_LOCAL_APIC y
    fi
+else
+   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi

 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
diff -urN virgin-2.4.6/arch/i386/kernel/apic.c 
linux-2.4.6/arch/i386/kernel/apic.c
--- virgin-2.4.6/arch/i386/kernel/apic.c	Wed Jun 20 11:06:38 2001
+++ linux-2.4.6/arch/i386/kernel/apic.c	Thu Jul 19 11:51:11 2001
@@ -44,7 +44,7 @@
 	return maxlvt;
 }

-static void clear_local_APIC(void)
+void clear_local_APIC(void)
 {
 	int maxlvt;
 	unsigned long v;
@@ -208,6 +208,14 @@
 {
 	unsigned long value, ver, maxlvt;

+#ifdef CONFIG_MULTIQUAD
+	/* Pound the ESR really hard over the head with a big hammer - mbligh */
+	apic_write(APIC_ESR, 0);
+	apic_write(APIC_ESR, 0);
+	apic_write(APIC_ESR, 0);
+	apic_write(APIC_ESR, 0);
+#endif /* CONFIG_MULTIQUAD */
+
 	value = apic_read(APIC_LVR);
 	ver = GET_APIC_VERSION(value);

@@ -216,6 +224,7 @@

 	/*
 	 * Double-check wether this APIC is really registered.
+	 * This is meaningless in multiquad mode, so we skip it.
 	 */
 	if (!test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
 		BUG();
@@ -226,6 +235,7 @@
 	 * document number 292116).  So here it goes...
 	 */

+#ifndef CONFIG_MULTIQUAD   /* Multiquad rely on the lynxer to do this for 
us */
 	/*
 	 * Put the APIC into flat delivery mode.
 	 * Must be "all ones" explicitly for 82489DX.
@@ -239,6 +249,7 @@
 	value &= ~APIC_LDR_MASK;
 	value |= (1<<(smp_processor_id()+24));
 	apic_write_around(APIC_LDR, value);
+#endif /* !CONFIG_MULTIQUAD */

 	/*
 	 * Set Task Priority to 'accept all'. We never change this
@@ -321,6 +332,14 @@
 		value |= APIC_LVT_LEVEL_TRIGGER;
 	apic_write_around(APIC_LVT1, value);

+#ifdef CONFIG_MULTIQUAD
+	/*
+	 * Something untraceble is sending us bogus interrupts on secondary
+	 * quads ... for the moment, just disable the ESR - we can't do
+	 * anything useful with the errors anyway - mbligh
+	 */
+	printk("Leaving ESR disabled.\n");
+#else
 	if (APIC_INTEGRATED(ver)) {		/* !82489DX */
 		maxlvt = get_maxlvt();
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
@@ -339,6 +358,7 @@
 		printk("ESR value after enabling vector: %08lx\n", value);
 	} else
 		printk("No ESR for 82489DX.\n");
+#endif /* !CONFIG_MULTIQUAD */
 }

 void __init init_apic_mappings(void)
diff -urN virgin-2.4.6/arch/i386/kernel/io_apic.c 
linux-2.4.6/arch/i386/kernel/io_apic.c
--- virgin-2.4.6/arch/i386/kernel/io_apic.c	Wed Jun 20 11:06:38 2001
+++ linux-2.4.6/arch/i386/kernel/io_apic.c	Thu Jul 19 14:11:34 2001
@@ -53,7 +53,13 @@
 int mp_irq_entries;

 #if CONFIG_SMP
-# define TARGET_CPUS cpu_online_map
+# ifdef CONFIG_MULTIQUAD
+#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
+#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
+# else
+#  define TARGET_CPUS cpu_online_map
+#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all 
procs */
+# endif
 #else
 # define TARGET_CPUS 0x01
 #endif
@@ -607,7 +613,7 @@
 		memset(&entry,0,sizeof(entry));

 		entry.delivery_mode = dest_LowestPrio;
-		entry.dest_mode = 1;			/* logical delivery */
+		entry.dest_mode = INT_DELIVERY_MODE;
 		entry.mask = 0;				/* enable IRQ */
 		entry.dest.logical.logical_dest = TARGET_CPUS;

@@ -678,7 +684,8 @@
 	 * We use logical delivery to get the timer IRQ
 	 * to the first CPU.
 	 */
-	entry.dest_mode = 1;				/* logical delivery */
+	entry.mask = 0;					/* unmask IRQ now */
+	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
 	entry.dest.logical.logical_dest = TARGET_CPUS;
 	entry.delivery_mode = dest_LowestPrio;
@@ -1042,7 +1049,11 @@
 				i);
 			phys_id_present_map |= 1 << i;
 			mp_ioapics[apic].mpc_apicid = i;
+		} else {
+			printk("Setting %d in the phys_id_present_map\n", 
mp_ioapics[apic].mpc_apicid);
+			phys_id_present_map |= 1 << mp_ioapics[apic].mpc_apicid;
 		}
+

 		/*
 		 * We need to adjust the IRQ routing table
diff -urN virgin-2.4.6/arch/i386/kernel/mpparse.c 
linux-2.4.6/arch/i386/kernel/mpparse.c
--- virgin-2.4.6/arch/i386/kernel/mpparse.c	Mon Jun 11 19:15:27 2001
+++ linux-2.4.6/arch/i386/kernel/mpparse.c	Thu Jul 19 11:20:12 2001
@@ -44,7 +44,7 @@
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_id = -1U;
 /* Internal processor count */
-static unsigned int num_processors;
+unsigned int num_processors;

 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
@@ -358,6 +358,12 @@
 			}
 		}
 	}
+#ifdef CONFIG_MULTIQUAD
+	if (nr_ioapics > 2) {
+		/* don't initialise IO apics on secondary quads */
+		nr_ioapics = 2;
+	}
+#endif /* CONFIG_MULTIQUAD */
 	return num_processors;
 }

diff -urN virgin-2.4.6/arch/i386/kernel/setup.c 
linux-2.4.6/arch/i386/kernel/setup.c
--- virgin-2.4.6/arch/i386/kernel/setup.c	Fri May 25 17:07:09 2001
+++ linux-2.4.6/arch/i386/kernel/setup.c	Fri Jul 20 13:43:42 2001
@@ -2385,7 +2385,15 @@
 	struct cpuinfo_x86 *c = cpu_data;
 	int i, n;

+#ifdef CONFIG_MULTIQUAD
+	/*
+	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
+	 * page buffer and corrupts memory - this needs fixing properly
+	 */
+	for (n = 0; n < 8; n++, c++) {
+#else
 	for (n = 0; n < NR_CPUS; n++, c++) {
+#endif /* CONFIG_MULTIQUAD */
 		int fpu_exception;
 #ifdef CONFIG_SMP
 		if (!(cpu_online_map & (1<<n)))
@@ -2448,7 +2456,7 @@
 	return p - buffer;
 }

-static unsigned long cpu_initialized __initdata = 0;
+unsigned long cpu_initialized __initdata = 0;

 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
diff -urN virgin-2.4.6/arch/i386/kernel/smp.c 
linux-2.4.6/arch/i386/kernel/smp.c
--- virgin-2.4.6/arch/i386/kernel/smp.c	Tue Feb 13 14:13:43 2001
+++ linux-2.4.6/arch/i386/kernel/smp.c	Thu Jul 19 11:20:12 2001
@@ -148,22 +148,6 @@
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
@@ -174,30 +158,105 @@
 	unsigned long cfg;
 	unsigned long flags;

+#ifndef CONFIG_MULTIQUAD
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
+#else  /* CONFIG_MULTIQUAD */
+	/*
+	 * Hack. The clustered APIC addressing mode doesn't allow us to send
+	 * to an arbitrary mask, so I do a unicasts to each CPU instead. This
+	 * should be modified to do 1 message per cluster ID - mbligh
+	 */
+	unsigned int query_cpu, query_mask;
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
+			cfg = __prepare_ICR2(cpu_to_l_apicid[query_cpu]);
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
+#endif /* CONFIG_MULTIQUAD */
 	__restore_flags(flags);
+}
+
+static inline void send_IPI_allbutself(int vector)
+{
+	/*
+	 * if there are no other CPUs in the system then
+	 * we get an APIC send error if we try to broadcast.
+	 * thus we have to avoid sending IPIs in this case.
+	 */
+#ifndef CONFIG_MULTIQUAD
+	if (smp_num_cpus > 1)
+		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+#else  /* CONFIG_MULTIQUAD */
+	int cpu;
+
+	if (smp_num_cpus > 1) {
+		for (cpu = 0; cpu < smp_num_cpus; ++cpu) {
+			if (cpu != smp_processor_id())
+				send_IPI_mask(1 << cpu, vector);
+		}
+	}
+#endif /* CONFIG_MULTIQUAD */
+}
+
+static inline void send_IPI_all(int vector)
+{
+#ifndef CONFIG_MULTIQUAD
+	__send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+#else  /* CONFIG_MULTIQUAD */
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; ++cpu) {
+		send_IPI_mask(1 << cpu, vector);
+	}
+#endif /* CONFIG_MULTIQUAD */
 }

 /*
diff -urN virgin-2.4.6/arch/i386/kernel/smpboot.c 
linux-2.4.6/arch/i386/kernel/smpboot.c
--- virgin-2.4.6/arch/i386/kernel/smpboot.c	Tue Feb 13 14:13:43 2001
+++ linux-2.4.6/arch/i386/kernel/smpboot.c	Thu Jul 19 14:49:41 2001
@@ -29,6 +29,7 @@
  *		Ingo Molnar	:	various cleanups and rewrites
  *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
+ *		Martin J. Bligh	: 	Added support for multi-quad systems
  */

 #include <linux/config.h>
@@ -57,10 +58,17 @@
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;

-/* which CPU (physical APIC ID) maps to which logical CPU number */
-volatile int x86_apicid_to_cpu[NR_CPUS];
-/* which logical CPU number maps to which CPU (physical APIC ID) */
-volatile int x86_cpu_to_apicid[NR_CPUS];
+#ifndef CONFIG_MUTLIQUAD    /* meaningless in a multi-quad system */
+/* which physical APIC ID maps to which logical CPU number */
+volatile int p_apicid_to_cpu[MAX_P_APICID];
+#endif /* !CONFIG_MULTIQUAD */
+/* which logical CPU number maps to which physical APIC ID */
+volatile int cpu_to_p_apicid[NR_CPUS];
+
+/* which logical APIC ID maps to which logical CPU number */
+volatile int l_apicid_to_cpu[MAX_L_APICID];
+/* which logical CPU number maps to which logical APIC ID */
+volatile int cpu_to_l_apicid[NR_CPUS];

 static volatile unsigned long cpu_callin_map;
 static volatile unsigned long cpu_callout_map;
@@ -357,7 +365,9 @@
 	 * our local APIC.  We have to wait for the IPI or we'll
 	 * lock up on an APIC access.
 	 */
+#ifndef CONFIG_MULTIQUAD             /* multi quad doesn't use INIT */
 	while (!atomic_read(&init_deasserted));
+#endif /* CONFIG_MULTIQUAD */

 	/*
 	 * (This works even if the APIC is not enabled.)
@@ -406,9 +416,16 @@
 	 */

 	Dprintk("CALLIN, before setup_local_APIC().\n");
+#ifdef CONFIG_MULTIQUAD
+	/*
+	 * Because we use NMIs rather than the INIT-STARTUP sequence to
+	 * bootstrap the CPUs, the APIC may be in a wierd state. Kick it.
+	 */
+	clear_local_APIC();
+#endif /* CONFIG_MULTIQUAD */
 	setup_local_APIC();

-	sti();
+	__sti();

 #ifdef CONFIG_MTRR
 	/*
@@ -461,8 +478,18 @@
 	 * low-memory mappings have been cleared, flush them from
 	 * the local TLBs too.
 	 */
+#ifdef CONFIG_MULTIQUAD
+	/*
+	 * Taking these printk's out causes an undiagnosable BINT error
+	 * I suspect the console lock serialises the procs.
+	 * Truly disgusting - mbligh.
+	 */
+	printk("Before tlbflush - processor: %d\n", current->processor);
+#endif /* CONFIG_MULTIQUAD */
 	local_flush_tlb();
-
+#ifdef CONFIG_MULTIQUAD
+	printk("After tlbflush - processor: %d\n", current->processor);
+#endif /* CONFIG_MULTIQUAD */
 	return cpu_idle();
 }

@@ -539,12 +566,22 @@
 }
 #endif

-static void __init do_boot_cpu (int apicid)
+extern unsigned long cpu_initialized;
+
+static void __init do_boot_cpu (int apicid)
+/*
+ * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
+ * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
+ */
 {
 	struct task_struct *idle;
 	unsigned long send_status, accept_status, boot_status, maxlvt;
 	int timeout, num_starts, j, cpu;
 	unsigned long start_eip;
+#ifdef CONFIG_MULTIQUAD
+	int p_apicid;
+	unsigned short store1, store2;
+#endif

 	cpu = ++cpucount;
 	/*
@@ -563,8 +600,17 @@
 		panic("No idle process for CPU %d", cpu);

 	idle->processor = cpu;
-	x86_cpu_to_apicid[cpu] = apicid;
-	x86_apicid_to_cpu[apicid] = cpu;
+
+#ifdef CONFIG_MULTIQUAD
+	/* set up LOGICAL mappings */
+	cpu_to_l_apicid[cpu] = apicid;
+	l_apicid_to_cpu[apicid] = cpu;
+#else
+	/* set up PHYSICAL mappings */
+	cpu_to_p_apicid[cpu] = apicid;
+	p_apicid_to_cpu[apicid] = cpu;
+#endif
+
 	idle->has_cpu = 1; /* we schedule the first task manually */
 	idle->thread.eip = (unsigned long) start_secondary;

@@ -595,15 +641,28 @@
 	Dprintk("2.\n");
 	*((volatile unsigned short *) phys_to_virt(0x467)) = start_eip & 0xf;
 	Dprintk("3.\n");
+#ifdef CONFIG_MULTIQUAD
+	store1 = *((volatile unsigned short *) phys_to_virt(0xa));
+	*((volatile unsigned short *) phys_to_virt(0xa)) = start_eip >> 4;
+	Dprintk("4.\n");
+	store2 = *((volatile unsigned short *) phys_to_virt(0x8));
+	*((volatile unsigned short *) phys_to_virt(0x8)) = start_eip & 0xf;
+	Dprintk("5.\n");
+#endif /* CONFIG_MULTIQUAD */

 	/*
 	 * Be paranoid about clearing APIC errors.
 	 */
+#ifndef CONFIG_MULTIQUAD
+	/* Fixme. apic_version is keyed by physical apic ID - can't use it */
 	if (APIC_INTEGRATED(apic_version[apicid])) {
+#endif /* CONFIG_MULTIQUAD */
 		apic_read_around(APIC_SPIV);
 		apic_write(APIC_ESR, 0);
 		apic_read(APIC_ESR);
+#ifndef CONFIG_MULTIQUAD
 	}
+#endif /* CONFIG_MULTIQUAD */

 	/*
 	 * Status is now clean
@@ -616,6 +675,37 @@
 	 * Starting actual IPI sequence...
 	 */

+#ifdef CONFIG_MULTIQUAD
+	/* Target chip */
+	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(apicid));
+
+	/* Boot on the stack */
+	/* Kick the second */
+	apic_write_around(APIC_ICR, APIC_DM_NMI | APIC_DEST_LOGICAL);
+
+	Dprintk("Waiting for send to finish...\n");
+	timeout = 0;
+	do {
+		Dprintk("+");
+		udelay(100);
+		send_status = apic_read(APIC_ICR) & APIC_ICR_BUSY;
+	} while (send_status && (timeout++ < 1000));
+
+	/*
+	 * Give the other CPU some time to accept the IPI.
+	 */
+	udelay(200);
+	/*
+	 * Due to the Pentium erratum 3AP.
+	 */
+	if (maxlvt > 3) {
+		apic_read_around(APIC_SPIV);
+		apic_write(APIC_ESR, 0);
+	}
+	accept_status = (apic_read(APIC_ESR) & 0xEF);
+	Dprintk("NMI sent.\n");
+
+#else /* !CONFIG_MULTIQUAD */
 	Dprintk("Asserting INIT.\n");

 	/*
@@ -726,6 +816,7 @@
 			break;
 	}
 	Dprintk("After Startup.\n");
+#endif /* CONFIG_MULTIQUAD */

 	if (send_status)
 		printk("APIC never delivered???\n");
@@ -765,18 +856,34 @@
 				/* trampoline code not run */
 				printk("Not responding.\n");
 #if APIC_DEBUG
+	#ifndef CONFIG_MULTIQUAD
 			inquire_remote_apic(apicid);
+	#endif
 #endif
 		}
 	}
 	if (send_status || accept_status || boot_status) {
-		x86_cpu_to_apicid[cpu] = -1;
-		x86_apicid_to_cpu[apicid] = -1;
+		#ifdef CONFIG_MULTIQUAD
+			cpu_to_l_apicid[cpu] = -1;
+			l_apicid_to_cpu[apicid] = -1;
+		#else
+			cpu_to_p_apicid[cpu] = -1;
+			p_apicid_to_cpu[apicid] = -1;
+		#endif /* CONFIG_MULTIQUAD */
+		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
+		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
 		cpucount--;
 	}

 	/* mark "stuck" area as not stuck */
 	*((volatile unsigned long *)phys_to_virt(8192)) = 0;
+
+#ifdef CONFIG_MULTIQUAD
+	printk("Restoring NMI vector\n");
+	*((volatile unsigned short *) phys_to_virt(0xa)) = store1;
+	*((volatile unsigned short *) phys_to_virt(0x8)) = store2;
+#endif
 }

 cycles_t cacheflush_time;
@@ -827,9 +934,25 @@
 extern int prof_old_multiplier[NR_CPUS];
 extern int prof_counter[NR_CPUS];

+extern unsigned int num_processors;
+
 void __init smp_boot_cpus(void)
 {
 	int apicid, cpu;
+#ifdef CONFIG_MULTIQUAD
+	int num_mps_cpus, mps_cpu, boot_cpu_l_apicid;
+	int mps_cpu_to_l_apicid[NR_CPUS];
+	/* mps_cpu is NOT necessarily the cpu number - this is assigned later */
+
+	printk("The MPS table says we have %d processors\n", num_processors);
+	num_mps_cpus = num_processors;
+
+	/* contsruct the logical apic id's - we ought to get this from MPS? */
+	for (mps_cpu = num_mps_cpus-1; mps_cpu >= 0; --mps_cpu) {
+		mps_cpu_to_l_apicid[mps_cpu] = \
+			((mps_cpu/4)*16) + (1 << (mps_cpu%4));
+	}
+#endif /* CONFIG_MULTIQUAD */

 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */
@@ -840,13 +963,25 @@
 	 * and the per-CPU profiling counter/multiplier
 	 */

-	for (apicid = 0; apicid < NR_CPUS; apicid++) {
-		x86_apicid_to_cpu[apicid] = -1;
-		prof_counter[apicid] = 1;
-		prof_old_multiplier[apicid] = 1;
-		prof_multiplier[apicid] = 1;
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+#ifdef CONFIG_MULTIQUAD
+		cpu_to_l_apicid[cpu] = -1;
+#endif /* CONFIG_MULTIQUAD */
+		prof_counter[cpu] = 1;
+		prof_old_multiplier[cpu] = 1;
+		prof_multiplier[cpu] = 1;
 	}

+#ifdef CONFIG_MULTIQUAD
+	for (apicid = 0; apicid < MAX_L_APICID; apicid++) {
+		l_apicid_to_cpu[apicid] = -1;
+	}
+#else /* !CONFIG_MULTIQUAD */
+	for (apicid = 0; apicid < MAX_P_APICID; apicid++) {
+		p_apicid_to_cpu[apicid] = -1;
+	}
+#endif /* CONFIG_MULTIQUAD */
+
 	/*
 	 * Setup boot CPU information
 	 */
@@ -858,8 +993,14 @@
 	 * We have the boot CPU online for sure.
 	 */
 	set_bit(0, &cpu_online_map);
-	x86_apicid_to_cpu[boot_cpu_id] = 0;
-	x86_cpu_to_apicid[0] = boot_cpu_id;
+#ifdef CONFIG_MULTIQUAD
+	boot_cpu_l_apicid = logical_smp_processor_id();
+	l_apicid_to_cpu[boot_cpu_l_apicid] = 0;
+	cpu_to_l_apicid[0] = boot_cpu_l_apicid;
+#else
+	p_apicid_to_cpu[boot_cpu_id] = 0;
+	cpu_to_p_apicid[0] = boot_cpu_id;
+#endif /* CONFIG_MULTIQUAD */
 	global_irq_holder = 0;
 	current->processor = 0;
 	init_idle();
@@ -927,6 +1068,32 @@
 	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_id)
 		BUG();

+#ifdef CONFIG_MULTIQUAD
+	/*
+	 * Now scan the through the CPUs from the MPS table, and fire them up.
+	 */
+	Dprintk("Number of cpus (multiquad): %d\n", num_mps_cpus);
+
+	for (mps_cpu = 0; mps_cpu < num_mps_cpus; mps_cpu++) {
+		/*
+		 * Don't even attempt to start the boot CPU!
+		*/
+		if (cpu_to_l_apicid[mps_cpu] == boot_cpu_l_apicid)
+			continue;
+		
+		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
+			continue;
+
+		do_boot_cpu(mps_cpu_to_l_apicid[mps_cpu]);
+
+		/*
+		 * Make sure we unmap all failed CPUs
+		 */
+		if (l_apicid_to_cpu[mps_cpu_to_l_apicid[mps_cpu]] == -1)
+			printk("CPU mps#%d not responding - cannot use it.\n", mps_cpu);
+	}
+
+#else /* !CONFIG_MULTIQUAD */
 	/*
 	 * Now scan the CPU present map and fire up the other CPUs.
 	 */
@@ -949,10 +1116,11 @@
 		/*
 		 * Make sure we unmap all failed CPUs
 		 */
-		if ((x86_apicid_to_cpu[apicid] == -1) &&
+		if ((p_apicid_to_cpu[apicid] == -1) &&
 				(phys_cpu_present_map & (1 << apicid)))
 			printk("phys CPU #%d not responding - cannot use it.\n",apicid);
 	}
+#endif /* CONFIG_MULTIQUAD */

 	/*
 	 * Cleanup possible dangling ends...
diff -urN virgin-2.4.6/arch/i386/kernel/trampoline.S 
linux-2.4.6/arch/i386/kernel/trampoline.S
--- virgin-2.4.6/arch/i386/kernel/trampoline.S	Mon Feb  7 19:59:39 2000
+++ linux-2.4.6/arch/i386/kernel/trampoline.S	Thu Jul 19 11:20:12 2001
@@ -36,7 +36,9 @@

 ENTRY(trampoline_data)
 r_base = .
-
+#ifdef CONFIG_MULTIQUAD
+	wbinvd
+#endif /* CONFIG_MULTIQUAD */
 	mov	%cs, %ax	# Code and data in the same place
 	mov	%ax, %ds

diff -urN virgin-2.4.6/drivers/char/serial.c 
linux-2.4.6/drivers/char/serial.c
--- virgin-2.4.6/drivers/char/serial.c	Sun May 20 12:11:38 2001
+++ linux-2.4.6/drivers/char/serial.c	Thu Jul 19 11:20:12 2001
@@ -398,6 +398,10 @@
 	return 0;
 }

+#ifdef CONFIG_MULTIQUAD
+void *xquad_portio;    /* Where the IO area was mapped */
+#endif /* CONFIG_MULTIQUAD */
+
 static _INLINE_ unsigned int serial_in(struct async_struct *info, int 
offset)
 {
 	switch (info->io_type) {
@@ -414,6 +418,11 @@
 		return gsc_readb(info->iomem_base + offset);
 #endif
 	default:
+#ifdef CONFIG_MULTIQUAD
+		if (xquad_portio)
+			return readb((unsigned long) xquad_portio + offset);
+		else
+#endif /* CONFIG_MULTIQUAD */
 		return inb(info->port + offset);
 	}
 }
@@ -438,6 +447,11 @@
 		break;
 #endif
 	default:
+#ifdef CONFIG_MULTIQUAD
+		if (xquad_portio)
+			writeb(value, (unsigned long) xquad_portio + offset);
+		else
+#endif /* CONFIG_MULTIQUAD */
 		outb(value, info->port+offset);
 	}
 }
diff -urN virgin-2.4.6/include/asm-i386/io.h 
linux-2.4.6/include/asm-i386/io.h
--- virgin-2.4.6/include/asm-i386/io.h	Tue Jul  3 15:43:07 2001
+++ linux-2.4.6/include/asm-i386/io.h	Thu Jul 19 11:20:12 2001
@@ -103,6 +103,11 @@

 #define IO_SPACE_LIMIT 0xffff

+#ifdef CONFIG_MULTIQUAD
+#define XQUAD_PORTIO_BASE 0xfe400000
+#define XQUAD_PORTIO_LEN  0x40000   /* 256k per quad. Only remapping 1st */
+#endif
+
 #ifdef __KERNEL__

 #include <linux/vmalloc.h>
diff -urN virgin-2.4.6/include/asm-i386/mpspec.h 
linux-2.4.6/include/asm-i386/mpspec.h
--- virgin-2.4.6/include/asm-i386/mpspec.h	Fri Sep  8 07:37:08 2000
+++ linux-2.4.6/include/asm-i386/mpspec.h	Thu Jul 19 14:36:52 2001
@@ -13,10 +13,14 @@

 #define SMP_MAGIC_IDENT	(('_'<<24)|('P'<<16)|('M'<<8)|'_')

+#ifdef CONFIG_MULTIQUAD
+#define MAX_APICS 256
+#else /* !CONFIG_MULTIQUAD */
 /*
  * a maximum of 16 APICs with the current APIC ID architecture.
  */
 #define MAX_APICS 16
+#endif /* CONFIG_MULTIQUAD */

 struct intel_mp_floating
 {
@@ -156,7 +160,7 @@
  *	7	2 CPU MCA+PCI
  */

-#define MAX_IRQ_SOURCES 128
+#define MAX_IRQ_SOURCES 256
 #define MAX_MP_BUSSES 32
 enum mp_bustype {
 	MP_BUS_ISA = 1,
diff -urN virgin-2.4.6/include/asm-i386/smp.h 
linux-2.4.6/include/asm-i386/smp.h
--- virgin-2.4.6/include/asm-i386/smp.h	Tue Jul  3 15:42:55 2001
+++ linux-2.4.6/include/asm-i386/smp.h	Thu Jul 19 14:43:38 2001
@@ -59,8 +59,14 @@
  * Some lowlevel functions might want to know about
  * the real APIC ID <-> CPU # mapping.
  */
-extern volatile int x86_apicid_to_cpu[NR_CPUS];
-extern volatile int x86_cpu_to_apicid[NR_CPUS];
+#define MAX_L_APICID 256
+#define MAX_P_APICID 16
+#ifndef CONFIG_MULTIQUAD        /* This makes no sense on multiquad */
+extern volatile int p_apicid_to_cpu[MAX_P_APICID];   /* phys apicid -> cpu 
*/
+#endif /* !CONFIG_MULTIQUAD */
+extern volatile int cpu_to_p_apicid[NR_CPUS];        /* cpu -> phys apicid 
*/
+extern volatile int l_apicid_to_cpu[MAX_L_APICID];   /* log apicid -> cpu 
*/
+extern volatile int cpu_to_l_apicid[NR_CPUS];        /* cpu -> log apicid 
*/

 /*
  * General functions that each host system must provide.
@@ -81,6 +87,12 @@
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
diff -urN virgin-2.4.6/init/main.c linux-2.4.6/init/main.c
--- virgin-2.4.6/init/main.c	Wed Jun 20 11:10:27 2001
+++ linux-2.4.6/init/main.c	Thu Jul 19 11:20:12 2001
@@ -505,6 +505,10 @@
 /*
  *	Activate the first processor.
  */
+
+#ifdef CONFIG_MULTIQUAD
+void *xquad_portio;    /* Where the IO area was mapped */
+#endif /* CONFIG_MULTIQUAD */

 asmlinkage void __init start_kernel(void)
 {
@@ -577,6 +581,13 @@
 #endif
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
+
+#ifdef CONFIG_MULTIQUAD
+        /* remap the 256k range for cross-quad I/O */
+        xquad_portio = ioremap (XQUAD_PORTIO_BASE, XQUAD_PORTIO_LEN);
+        printk("Cross quad portio set up at vaddr 0x%08lx\n", \
+		(u_long) xquad_portio);
+#endif /* CONFIG_MULTIQUAD */

 	/*
 	 *	We count on the initial thread going ok
diff -urN virgin-2.4.6/kernel/printk.c linux-2.4.6/kernel/printk.c
--- virgin-2.4.6/kernel/printk.c	Fri Jun 29 19:30:36 2001
+++ linux-2.4.6/kernel/printk.c	Thu Jul 19 11:57:07 2001
@@ -23,7 +23,12 @@

 #include <asm/uaccess.h>

-#define LOG_BUF_LEN	(16384)
+#ifdef CONFIG_MULTIQUAD
+#define LOG_BUF_LEN	(65536)   /* All the CPUs make the buffer overflow */
+#else
+#define LOG_BUF_LEN	(16384)   /* buy some memory - it's so cheap ... */
+#endif /* CONFIG_MULTIQUAD */
+
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)

 static char buf[1024];

