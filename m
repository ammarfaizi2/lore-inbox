Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268533AbTCAI3Z>; Sat, 1 Mar 2003 03:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268534AbTCAI3Y>; Sat, 1 Mar 2003 03:29:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2395
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268533AbTCAI3K>; Sat, 1 Mar 2003 03:29:10 -0500
Date: Sat, 1 Mar 2003 03:37:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][RFC][2/2] per node vector spaces
Message-ID: <Pine.LNX.4.50.0303010336440.2365-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.62-numaq/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/arch/i386/kernel/io_apic.c,v
retrieving revision 1.2
diff -u -r1.2 io_apic.c
--- linux-2.5.62-numaq/arch/i386/kernel/io_apic.c	24 Feb 2003 06:55:02 -0000	1.2
+++ linux-2.5.62-numaq/arch/i386/kernel/io_apic.c	26 Feb 2003 23:19:36 -0000
@@ -35,6 +35,7 @@
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/desc.h>
+#include <asm/topology.h>
 
 #include <mach_apic.h>
 
@@ -1002,28 +1003,44 @@
 	return 0;
 }
 
-int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+/* XXX This might have to be per BUS -Zwane */
+unsigned int inline ioapic_to_node(unsigned int ioapic)
+{
+	return ioapic / NR_IO_APICS_PER_NODE;
+}
+
+int irq_vector[MAX_NUMNODES][NR_IRQS] = {[0 ... MAX_NUMNODES-1] = { FIRST_DEVICE_VECTOR , 0 }};
 
-static int __init assign_irq_vector(int irq)
+static int __init assign_irq_vector(int irq, int node)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	if (IO_APIC_VECTOR(irq) > 0)
-		return IO_APIC_VECTOR(irq);
+	int i;
+	static int current_vector[MAX_NUMNODES] = {[0 ... MAX_NUMNODES-1] = FIRST_DEVICE_VECTOR},
+		offset[MAX_NUMNODES];
+
+	printk("requesting vector for node%d/irq%d\n", node, irq);
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (IO_APIC_VECTOR(irq, i) > 0) {
+			printk("returning previous allocation (node%d) vector0x%x\n",
+				i, IO_APIC_VECTOR(irq,i));
+			return IO_APIC_VECTOR(irq, i);
+		}
+	}
 next:
-	current_vector += 8;
-	if (current_vector == SYSCALL_VECTOR)
+	current_vector[node] += 8;
+	if (current_vector[node] == SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
-		offset++;
-		current_vector = FIRST_DEVICE_VECTOR + offset;
+	if (current_vector[node] > FIRST_SYSTEM_VECTOR) {
+		offset[node]++;
+		current_vector[node] = FIRST_DEVICE_VECTOR + offset[node];
 	}
 
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt vectors");
+	if (current_vector[node] == FIRST_SYSTEM_VECTOR)
+		panic("ran out of interrupt vectors!");
 
-	IO_APIC_VECTOR(irq) = current_vector;
-	return current_vector;
+	IO_APIC_VECTOR(irq, node) = current_vector[node];
+	printk("returning new allocation node%d/irq%d -> vector0x%x\n", node, irq, current_vector[node]);
+	return current_vector[node];
 }
 
 static struct hw_interrupt_type ioapic_level_irq_type;
@@ -1032,14 +1049,14 @@
 void __init setup_IO_APIC_irqs(void)
 {
 	struct IO_APIC_route_entry entry;
-	int apic, pin, idx, irq, first_notcon = 1, vector;
-	unsigned long flags;
+	int apic, pin, idx, irq, first_notcon = 1, vector, i, node;
+	unsigned long flags, cpu_mask;
 
 	printk(KERN_DEBUG "init IO_APIC IRQs\n");
 
 	for (apic = 0; apic < nr_ioapics; apic++) {
 	for (pin = 0; pin < nr_ioapic_registers[apic]; pin++) {
-
+		node = ioapic_to_node(apic);
 		/*
 		 * add it to the IO-APIC irq-routing table:
 		 */
@@ -1082,15 +1099,21 @@
 			continue;
 
 		if (IO_APIC_IRQ(irq)) {
-			vector = assign_irq_vector(irq);
+			vector = assign_irq_vector(irq, node);
 			entry.vector = vector;
 
 			if (IO_APIC_irq_trigger(irq))
 				irq_desc[irq].handler = &ioapic_level_irq_type;
 			else
 				irq_desc[irq].handler = &ioapic_edge_irq_type;
-
-			set_intr_gate_all(vector, interrupt[irq]);
+			
+			for_each_cpu_on_node(i, node, cpu_mask) {
+				if (cpu_possible(i)) {
+					printk("setting interrupt gate for cpu%d, irq%d -> vector0x%x %p",
+						i, irq, vector, interrupt[irq]);
+					set_intr_gate(i, vector, interrupt[irq]);
+				}
+			}
 			
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
@@ -1698,7 +1721,7 @@
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
-	i = IO_APIC_VECTOR(irq);
+	i = IO_APIC_VECTOR(irq, cpu_to_node(smp_processor_id()));
 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
 
 	ack_APIC_irq();
@@ -1768,7 +1791,7 @@
 
 static inline void init_IO_APIC_traps(void)
 {
-	int irq;
+	int irq, node;
 
 	/*
 	 * NOTE! The local APIC isn't very good at handling
@@ -1782,17 +1805,21 @@
 	 * 0x80, because int 0x80 is hm, kind of importantish. ;)
 	 */
 	for (irq = 0; irq < NR_IRQS ; irq++) {
-		if (IO_APIC_IRQ(irq) && !IO_APIC_VECTOR(irq)) {
-			/*
-			 * Hmm.. We don't have an entry for this,
-			 * so default to an old-fashioned 8259
-			 * interrupt if we can..
-			 */
-			if (irq < 16)
-				make_8259A_irq(irq);
-			else
-				/* Strange. Oh, well.. */
-				irq_desc[irq].handler = &no_irq_type;
+		if (IO_APIC_IRQ(irq)) {
+			for (node = 0; node < MAX_NUMNODES; node++) {
+				if (IO_APIC_VECTOR(irq, node))
+					break;	/* XXX Double check this -Zwane */
+				/*
+				 * Hmm.. We don't have an entry for this,
+				 * so default to an old-fashioned 8259
+				 * interrupt if we can..
+				 */
+				if (irq < 16)
+					make_8259A_irq(irq);
+				else
+					/* Strange. Oh, well.. */
+					irq_desc[irq].handler = &no_irq_type;
+			}
 		}
 	}
 }
@@ -1939,8 +1966,8 @@
 	 * get/set the timer IRQ vector:
 	 */
 	disable_8259A_irq(0);
-	vector = assign_irq_vector(0);
-	set_intr_gate_all(vector, interrupt[0]);
+	vector = assign_irq_vector(cpu_to_node(smp_processor_id()), 0);
+	set_intr_gate_all(vector, interrupt[0]);	/* XXX Watch out here -Zwane */
 	
 	/*
 	 * Subtle, code in do_timer_interrupt() expects an AEOI
@@ -2066,7 +2093,9 @@
 	/*
 	 * Set up IO-APIC IRQ routing.
 	 */
+	printk("before setup_ioapic_ids_from_mpc\n");
 	setup_ioapic_ids_from_mpc();
+	printk("before sync_Arb_IDs\n");
 	sync_Arb_IDs();
 	setup_IO_APIC_irqs();
 	init_IO_APIC_traps();
@@ -2195,11 +2224,12 @@
 int io_apic_set_pci_routing (int ioapic, int pin, int irq)
 {
 	struct IO_APIC_route_entry entry;
-	unsigned long flags;
+	unsigned long flags, cpu_mask;
+	int node = ioapic_to_node(ioapic), i;
 
-	if (!IO_APIC_IRQ(irq)) {
-		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
-			ioapic);
+	if (!IO_APIC_IRQ(irq, node)) {
+		printk(KERN_ERR "NODE%d IOAPIC[%d]: Invalid reference to IRQ 0/n", 
+			node, ioapic);
 		return -EINVAL;
 	}
 
@@ -2220,15 +2250,22 @@
 
 	add_pin_to_irq(irq, ioapic, pin);
 
-	entry.vector = assign_irq_vector(irq);
+	entry.vector = assign_irq_vector(irq, node);
 
-	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
-		"IRQ %d)\n", ioapic, 
+	printk(KERN_DEBUG "NODE[%d] IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
+		"IRQ %d)\n", node, ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
 
 	irq_desc[irq].handler = &ioapic_level_irq_type;
 
-	set_intr_gate_all(entry.vector, interrupt[irq]);
+	/* do all the cpus on this node */
+	for_each_cpu_on_node(i, node, cpu_mask) {
+		if (cpu_possible(i)) {
+			printk("setting interrupt gate for cpu%d, irq%d -> vector%d %p",
+				i, irq, vector, interrupt[irq]);
+			set_intr_gate(i, entry.vector, interrupt[irq]);
+		}
+	}
 
 	if (!ioapic && (irq < 16))
 		disable_8259A_irq(irq);
Index: linux-2.5.62-numaq/include/asm-generic/topology.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-generic/topology.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 topology.h
--- linux-2.5.62-numaq/include/asm-generic/topology.h	18 Feb 2003 00:15:48 -0000	1.1.1.1
+++ linux-2.5.62-numaq/include/asm-generic/topology.h	26 Feb 2003 21:34:41 -0000
@@ -48,6 +48,11 @@
 #define node_to_memblk(node)	(0)
 #endif
 
+#define for_each_cpu_on_node(cpu, node, mask) \
+        for(mask = node_to_cpumask(node); \
+            cpu = __ffs(mask), mask != 0; \
+            mask &= ~(1UL<<cpu))
+
 /* Cross-node load balancing interval. */
 #ifndef NODE_BALANCE_RATE
 #define NODE_BALANCE_RATE 10
Index: linux-2.5.62-numaq/include/asm-i386/apicdef.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-i386/apicdef.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 apicdef.h
--- linux-2.5.62-numaq/include/asm-i386/apicdef.h	18 Feb 2003 00:15:59 -0000	1.1.1.1
+++ linux-2.5.62-numaq/include/asm-i386/apicdef.h	24 Feb 2003 07:32:49 -0000
@@ -117,8 +117,10 @@
 
 #ifdef CONFIG_NUMA
  #define MAX_IO_APICS 32
+ #define NR_IO_APICS_PER_NODE	2
 #else
  #define MAX_IO_APICS 8
+ #define NR_IO_APICS_PER_NODE MAX_IO_APICS
 #endif
 
 /*
Index: linux-2.5.62-numaq/include/asm-i386/hw_irq.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.62/include/asm-i386/hw_irq.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 hw_irq.h
--- linux-2.5.62-numaq/include/asm-i386/hw_irq.h	18 Feb 2003 00:15:59 -0000	1.1.1.1
+++ linux-2.5.62-numaq/include/asm-i386/hw_irq.h	24 Feb 2003 08:51:50 -0000
@@ -24,8 +24,9 @@
  * Interrupt entry/exit code at both C and assembly level
  */
 
-extern int irq_vector[NR_IRQS];
-#define IO_APIC_VECTOR(irq)	irq_vector[irq]
+extern unsigned int inline ioapic_to_node(unsigned int ioapic);
+extern int irq_vector[MAX_NUMNODES][NR_IRQS];
+#define IO_APIC_VECTOR(irq, node)	irq_vector[node][irq]
 
 extern void (*interrupt[NR_IRQS])(void);
 
@@ -133,8 +134,10 @@
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
 {
+	int node = cpu_to_node(smp_processor_id());
+
 	if (IO_APIC_IRQ(i))
-		send_IPI_self(IO_APIC_VECTOR(i));
+		send_IPI_self(IO_APIC_VECTOR(i, node));
 }
 #else
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i) {}
