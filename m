Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbSK2UPV>; Fri, 29 Nov 2002 15:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbSK2UPV>; Fri, 29 Nov 2002 15:15:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40680 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267144AbSK2UPK>; Fri, 29 Nov 2002 15:15:10 -0500
Date: Fri, 29 Nov 2002 12:18:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
       linux-kernel@vger.kernel.org
cc: wli@holomorphy.com, mochel@osdl.org, johnstul@us.ibm.com,
       Erich Focht <efocht@ess.nec.de>, colpatch@us.ibm.com
Subject: Re: [RFC] rethinking the topology functions
Message-ID: <1669249734.1038572290@[10.10.2.3]>
In-Reply-To: <200211291918.gATJIUQ03127@localhost.localdomain>
References: <200211291918.gATJIUQ03127@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1669261060=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1669261060==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> I'd like to rework the current sysfs cpu/node pieces to provide 
> two separate topologies (one for CPU and one for memory).

There are two other sets of patches that are floating around that
will interact with this. The first (from Matt) makes the topo 
functions cache results, instead of recalculating each time. 
I'm thinking that we may want the generic front end to do that and
read from arrays, whilst only the *_init backend gets moved into
the subarch stuff ? (looking back at the patch right now, I can't
quite see what it's doing in 30s, but that's what it was meant to do).

The second is the start of breaking things out into the numaq
subarch - the attatched bits seem to work & are written with the
intent of being mergeable. It's just pieces torn off the big patch
by James Cleverdon and John Stultz (which isn't really mergeable
as is) and tweaked around by me. I'm going to test them a little 
more before submission, but they're pretty much there, I think. 
They're based on top of John's subarch reshuffle (the stuff you had
under generic is really NUMA-Q)

> Ultimately, the scheduler could be tuned to use the topologies to 
> make scheduling decisions.  

We kind of have that already. There are NUMA sceduler patches that
do this kind of thing in 2.5.47-mjb3 ... earlier versions of Erich's
scheduler had a pooling abstraction - this got ripped out for 
simplicity in the hope of getting something merged before the 2.5
freeze, but it'd be nice to put them back if that's not going to 
happen (still vaguely hoping).

> When that happens, we can probably fold 
> the current Pentium Hyperthreading stuff into a simple topology map 
> as well.

Not sure about that ... the HT stuff I believe created one queue
per pair of CPUs, which isn't going to work well for multiple real
CPUs per nodes, though is kind of a nice trick for a shared cache
SMT like HT .... things like the PPC64 chip multi-chip-on-1-die 
may feel differently about that.

> I believe Martin Bligh and Bill Irwin are working (or at least 
> thinking) somewhat along these lines, so I thought I'd gather 
> feedback before jumping into a wholesale rewrite.

cc'ed John, Erich, Matt ... 

M.
--==========1669261060==========
Content-Type: text/plain; charset=us-ascii; name=21-i386_topo-11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=21-i386_topo-11; size=5254

diff -purN -X /home/mbligh/.diff.exclude 11-noearlyirq-01/arch/i386/kernel/smpboot.c 21-i386_topo-11/arch/i386/kernel/smpboot.c
--- 11-noearlyirq-01/arch/i386/kernel/smpboot.c	Tue Nov 19 16:32:31 2002
+++ 21-i386_topo-11/arch/i386/kernel/smpboot.c	Tue Nov 19 16:33:30 2002
@@ -502,6 +502,46 @@ static struct task_struct * __init fork_
 	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
 }
 
+#ifdef CONFIG_X86_NUMAQ
+/* which logical CPUs are on which nodes */
+volatile unsigned long node_2_cpu_mask[MAX_NR_NODES];
+/* which node each logical CPU is on */
+volatile int cpu_2_node[NR_CPUS];
+
+/* Initialize all maps between cpu number and node */
+static inline void init_cpu_to_node_mapping(void)
+{
+	int node, cpu;
+
+	for (node = 0; node <
MAX_NR_NODES; node++) {
+		node_2_cpu_mask[node] = 0;
+	}
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		cpu_2_node[cpu] = -1;
+	}
+}
+
+/* set up a mapping between cpu and node. */
+static inline void map_cpu_to_node(int cpu, int node)
+{
+	node_2_cpu_mask[node] |= (1 << cpu);
+	cpu_2_node[cpu] = node;
+}
+
+/* undo a mapping between cpu and node. */
+static inline void unmap_cpu_to_node(int cpu, int node)
+{
+	node_2_cpu_mask[node] &= ~(1 << cpu);
+	cpu_2_node[cpu] = -1;
+}
+#else /* !CONFIG_X86_NUMAQ */
+
+#define init_cpu_to_node_mapping()	({})
+#define map_cpu_to_node(cpu, node)	({})
+#define unmap_cpu_to_node(cpu, node)	({})
+
+#endif /* CONFIG_X86_NUMAQ */
+
 /* which physical APIC ID maps to which logical CPU number */
 volatile int
physical_apicid_2_cpu[MAX_APICID];
 /* which logical CPU number maps to which physical APIC ID */
@@ -525,6 +565,7 @@ static inline void init_cpu_to_apicid(vo
 		cpu_2_physical_apicid[cpu] = -1;
 		cpu_2_logical_apicid[cpu] = -1;
 	}
+	init_cpu_to_node_mapping();
 }
 
 static inline void map_cpu_to_boot_apicid(int cpu, int apicid)
@@ -536,6 +577,7 @@ static inline void map_cpu_to_boot_apici
 	if (clustered_apic_mode) {
 		logical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_logical_apicid[cpu] = apicid;
+		map_cpu_to_node(cpu, apicid >> 4);
 	} else {
 		physical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_physical_apicid[cpu] = apicid;
@@ -551,6 +593,7 @@ static inline void unmap_cpu_to_boot_api
 	if (clustered_apic_mode) {
 		logical_apicid_2_cpu[apicid] =
-1;	
 		cpu_2_logical_apicid[cpu] = -1;
+		unmap_cpu_to_node(cpu, apicid >> 4);
 	} else {
 		physical_apicid_2_cpu[apicid] = -1;	
 		cpu_2_physical_apicid[cpu] = -1;
diff -purN -X /home/mbligh/.diff.exclude 11-noearlyirq-01/include/asm-i386/smpboot.h 21-i386_topo-11/include/asm-i386/smpboot.h
--- 11-noearlyirq-01/include/asm-i386/smpboot.h	Sun Nov 10 19:28:31 2002
+++ 21-i386_topo-11/include/asm-i386/smpboot.h	Tue Nov 19 16:33:30 2002
@@ -23,6 +23,14 @@
  #define boot_cpu_apicid boot_cpu_physical_apicid
 #endif /* CONFIG_CLUSTERED_APIC */
 
+#ifdef CONFIG_X86_NUMAQ
+/*
+ * Mappings between logical cpu number and node number
+ */
+extern volatile unsigned long node_2_cpu_mask[];
+extern volatile int cpu_2_node[];
+#endif /* CONFIG_X86_NUMAQ */
+
 /*

 * Mappings between logical cpu number and logical / physical apicid
  * The first four macros are trivial, but it keeps the abstraction consistent
diff -purN -X /home/mbligh/.diff.exclude 11-noearlyirq-01/include/asm-i386/topology.h 21-i386_topo-11/include/asm-i386/topology.h
--- 11-noearlyirq-01/include/asm-i386/topology.h	Sun Nov 10 19:28:05 2002
+++ 21-i386_topo-11/include/asm-i386/topology.h	Tue Nov 19 16:33:30 2002
@@ -32,7 +32,7 @@
 #include <asm/smpboot.h>
 
 /* Returns the number of the node containing CPU 'cpu' */
-#define __cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+#define __cpu_to_node(cpu) (cpu_2_node[cpu])
 
 /* Returns the number of the node containing MemBlk 'memblk' */
 #define __memblk_to_node(memblk) (memblk)
@@ -41,44
+41,11 @@
    so it is a pretty simple function! */
 #define __parent_node(node) (node)
 
-/* Returns the number of the first CPU on Node 'node'.
- * This should be changed to a set of cached values
- * but this will do for now.
- */
-static inline int __node_to_first_cpu(int node)
-{
-	int i, cpu, logical_apicid = node << 4;
+/* Returns a bitmask of CPUs on Node 'node'. */
+#define __node_to_cpu_mask(node) (node_2_cpu_mask[node])
 
-	for(i = 1; i < 16; i <<= 1)
-		/* check to see if the cpu is in the system */
-		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
-			/* if yes, return it to caller */
-			return cpu;
-
-	BUG(); /* couldn't find a cpu on given node */
-	return -1;
-}
-
-/* Returns a bitmask of CPUs on Node 'node'.
- * This
should be changed to a set of cached bitmasks
- * but this will do for now.
- */
-static inline unsigned long __node_to_cpu_mask(int node)
-{
-	int i, cpu, logical_apicid = node << 4;
-	unsigned long mask = 0UL;
-
-	if (sizeof(unsigned long) * 8 < NR_CPUS)
-		BUG();
-
-	for(i = 1; i < 16; i <<= 1)
-		/* check to see if the cpu is in the system */
-		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
-			/* if yes, add to bitmask */
-			mask |= 1 << cpu;
-
-	return mask;
-}
+/* Returns the number of the first CPU on Node 'node'. */
+#define __node_to_first_cpu(node) (__ffs(__node_to_cpu_mask(node)))
 
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)

--==========1669261060==========
Content-Type: text/plain; charset=us-ascii; name=numaq_makefile
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=numaq_makefile; size=2969

diff -urpN -X /home/fletch/.diff.exclude 01-subarch_reorg/arch/i386/Makefile 11-numaq_makefile-01/arch/i386/Makefile
--- 01-subarch_reorg/arch/i386/Makefile	Tue Nov 26 08:07:12 2002
+++ 11-numaq_makefile-01/arch/i386/Makefile	Tue Nov 26 08:27:58 2002
@@ -49,6 +49,9 @@ CFLAGS += $(cflags-y)
 #VISWS subarch support
 mflags-$(CONFIG_VISWS) := -Iinclude/asm-i386/mach-visws
 mcore-$(CONFIG_VISWS)  := mach-visws
+#NUMAQ subarch support
+mflags-$(CONFIG_X86_NUMAQ) := -Iinclude/asm-i386/mach-numaq
+mcore-$(CONFIG_X86_NUMAQ)  := mach-default
 #default subarch support
 mflags-y += -Iinclude/asm-i386/mach-default
 ifndef mcore-y
diff -urpN -X /home/fletch/.diff.exclude 01-subarch_reorg/include/asm-i386/mach-default/mach_apic.h
11-numaq_makefile-01/include/asm-i386/mach-default/mach_apic.h
--- 01-subarch_reorg/include/asm-i386/mach-default/mach_apic.h	Tue Nov 26 08:07:22 2002
+++ 11-numaq_makefile-01/include/asm-i386/mach-default/mach_apic.h	Tue Nov 26 08:53:37 2002
@@ -12,7 +12,7 @@ static inline unsigned long calculate_ld
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 #ifdef CONFIG_SMP
- #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
+ #define TARGET_CPUS (cpu_online_map)
 #else
  #define TARGET_CPUS 0x01
 #endif
@@ -27,15 +27,12 @@ static inline void summit_check(char *oe
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
-		(clustered_apic_mode ? "NUMA-Q" : "Flat"), nr_ioapics);
+					"Flat",
nr_ioapics);
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	if (clustered_apic_mode)
-		return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
-	else
-		return mps_cpu;
+	return mps_cpu;
 }
 
 static inline unsigned long apicid_to_cpu_present(int apicid)
diff -urpN -X /home/fletch/.diff.exclude 01-subarch_reorg/include/asm-i386/mach-numaq/mach_apic.h 11-numaq_makefile-01/include/asm-i386/mach-numaq/mach_apic.h
--- 01-subarch_reorg/include/asm-i386/mach-numaq/mach_apic.h	Wed Dec 31 16:00:00 1969
+++ 11-numaq_makefile-01/include/asm-i386/mach-numaq/mach_apic.h	Tue Nov 26 08:52:30 2002
@@ -0,0 +1,39 @@
+#ifndef __ASM_MACH_APIC_H
+#define __ASM_MACH_APIC_H
+
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long
id;
+
+	id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
+#define APIC_DFR_VALUE	(APIC_DFR_FLAT)
+
+#define TARGET_CPUS (0xf)
+
+#define APIC_BROADCAST_ID      0x0F
+#define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
+
+static inline void summit_check(char *oem, char *productid) 
+{
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		"NUMA-Q", nr_ioapics);
+}
+
+static inline int cpu_present_to_apicid(int mps_cpu)
+{
+	return ( ((mps_cpu/4)*16) + (1<<(mps_cpu%4)) );
+}
+
+static inline unsigned long apicid_to_cpu_present(int apicid)
+{
+	return (1ul << apicid);
+}
+
+#endif /* __ASM_MACH_APIC_H */

--==========1669261060==========
Content-Type: text/plain; charset=us-ascii; name=numaq_apic
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=numaq_apic; size=6557

diff -urpN -X /home/fletch/.diff.exclude 11-numaq_makefile-01/arch/i386/kernel/apic.c 12-numaq_apic-11/arch/i386/kernel/apic.c
--- 11-numaq_makefile-01/arch/i386/kernel/apic.c	Tue Nov 26 08:07:12 2002
+++ 12-numaq_apic-11/arch/i386/kernel/apic.c	Tue Nov 26 09:09:42 2002
@@ -311,11 +311,9 @@ void __init setup_local_APIC (void)
 		__error_in_apic_c();
 
 	/*
-	 * Double-check wether this APIC is really registered.
-	 * This is meaningless in clustered apic mode, so we skip it.
+	 * Double-check whether this APIC is really registered.
 	 */
-	if (!clustered_apic_mode && 
-	    !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
+	if (!apic_id_registered())
 		BUG();
 
 	/*
@@ -323,21 +321,7 @@ void __init setup_local_APIC (void)
 	 * an
APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
 	 * document number 292116).  So here it goes...
 	 */
-
-	if (!clustered_apic_mode) {
-		/*
-		 * In clustered apic mode, the firmware does this for us 
-		 * Put the APIC into flat delivery mode.
-		 * Must be "all ones" explicitly for 82489DX.
-		 */
-		apic_write_around(APIC_DFR, APIC_DFR_VALUE);
-
-		/*
-		 * Set up the logical destination ID.
-		 */
-		value = apic_read(APIC_LDR);
-		apic_write_around(APIC_LDR, calculate_ldr(value));
-	}
+	init_apic_ldr();
 
 	/*
 	 * Set Task Priority to 'accept all'. We never change this
diff -urpN -X /home/fletch/.diff.exclude 11-numaq_makefile-01/arch/i386/kernel/io_apic.c 12-numaq_apic-11/arch/i386/kernel/io_apic.c
---
11-numaq_makefile-01/arch/i386/kernel/io_apic.c	Tue Nov 26 08:07:12 2002
+++ 12-numaq_apic-11/arch/i386/kernel/io_apic.c	Tue Nov 26 09:06:30 2002
@@ -256,7 +256,7 @@ static inline void balance_irq(int irq)
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 
-	if (clustered_apic_mode)
+	if (no_balance_irq)
 		return;
 
 	if (unlikely(time_after(now, entry->timestamp + IRQ_BALANCE_INTERVAL))) {
@@ -272,7 +272,7 @@ static inline void balance_irq(int irq)
 		new_cpu = move(entry->cpu, allowed_mask, now, random_number);
 		if (entry->cpu != new_cpu) {
 			entry->cpu = new_cpu;
-			set_ioapic_affinity(irq, 1 << new_cpu);
+			set_ioapic_affinity(irq, cpu_present_to_apicid(new_cpu));
 		}
 	}
 }
@@ -734,7 +734,6 @@ void __init
setup_IO_APIC_irqs(void)
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -742,7 +741,7 @@ void __init setup_IO_APIC_irqs(void)
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
 		 */
-		if (clustered_apic_mode && (apic != 0) && (irq == 0))
+		if (multi_timer_check(apic, irq))
 			continue;
 		else
 			add_pin_to_irq(irq, apic, pin);
diff -urpN -X /home/fletch/.diff.exclude 11-numaq_makefile-01/include/asm-i386/mach-default/mach_apic.h 12-numaq_apic-11/include/asm-i386/mach-default/mach_apic.h
---
11-numaq_makefile-01/include/asm-i386/mach-default/mach_apic.h	Tue Nov 26 08:53:37 2002
+++ 12-numaq_apic-11/include/asm-i386/mach-default/mach_apic.h	Tue Nov 26 09:31:11 2002
@@ -17,6 +17,8 @@ static inline unsigned long calculate_ld
  #define TARGET_CPUS 0x01
 #endif
 
+#define no_balance_irq (0)
+
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
@@ -24,10 +26,38 @@ static inline void summit_check(char *oe
 {
 }
 
+static inline int apic_id_registered(void)
+{
+	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
+						&phys_cpu_present_map));
+}
+
+/*
+ * Set up the logical destination ID.
+ *
+ * Intel recommends to set DFR, LDR and TPR before enabling
+ * an APIC.  See e.g. "AP-388
82489DX User's Manual" (Intel
+ * document number 292116).  So here it goes...
+ */
+static inline void init_apic_ldr(void)
+{
+	unsigned long val;
+
+	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
+	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
+	val |= SET_APIC_LOGICAL_ID(1UL << smp_processor_id());
+	apic_write_around(APIC_LDR, val);
+}
+
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
 					"Flat", nr_ioapics);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
diff -urpN -X /home/fletch/.diff.exclude 11-numaq_makefile-01/include/asm-i386/mach-numaq/mach_apic.h
12-numaq_apic-11/include/asm-i386/mach-numaq/mach_apic.h
--- 11-numaq_makefile-01/include/asm-i386/mach-numaq/mach_apic.h	Tue Nov 26 08:52:30 2002
+++ 12-numaq_apic-11/include/asm-i386/mach-numaq/mach_apic.h	Tue Nov 26 09:32:21 2002
@@ -13,6 +13,8 @@ static inline unsigned long calculate_ld
 
 #define TARGET_CPUS (0xf)
 
+#define no_balance_irq (1)
+
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
@@ -20,10 +22,25 @@ static inline void summit_check(char *oe
 {
 }
 
+static inline int apic_id_registered(void)
+{
+	return (1);
+}
+
+static inline void init_apic_ldr(void)
+{
+	/* Already done in NUMA-Q firmware */
+}
+
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC
mode:  %s.  Using %d I/O APICs\n",
 		"NUMA-Q", nr_ioapics);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return (apic != 0 && irq == 0);
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)
diff -urpN -X /home/fletch/.diff.exclude 11-numaq_makefile-01/include/asm-i386/mach-summit/mach_apic.h 12-numaq_apic-11/include/asm-i386/mach-summit/mach_apic.h
--- 11-numaq_makefile-01/include/asm-i386/mach-summit/mach_apic.h	Tue Nov 26 08:07:22 2002
+++ 12-numaq_apic-11/include/asm-i386/mach-summit/mach_apic.h	Tue Nov 26 09:31:41 2002
@@ -23,6 +23,8 @@ static inline unsigned long calculate_ld
 #define APIC_DFR_VALUE	(x86_summit ? APIC_DFR_CLUSTER : APIC_DFR_FLAT)
 #define TARGET_CPUS	(x86_summit ? XAPIC_DEST_CPUS_MASK :
cpu_online_map)
 
+#define no_balance_irq (1)
+
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
 
@@ -32,10 +34,25 @@ static inline void summit_check(char *oe
 		x86_summit = 1;
 }
 
+static inline int apic_id_registered(void)
+{
+	return (1);
+}
+
+
+static inline void init_apic_ldr(void)
+{
+}
+
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
 		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return 0;
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)

--==========1669261060==========--

