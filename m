Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTE2A6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 20:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTE2A6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 20:58:11 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:49794
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261790AbTE2A6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 20:58:05 -0400
Date: Wed, 28 May 2003 21:01:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] high irq count exceeds interrupt[] array (resend)
Message-ID: <Pine.LNX.4.50.0305281943000.4964-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is required to boot 2.4.70 on an 8quad NUMAQ, without it we 
exceed the interrupt stub array and end up programming random memory into 
the IDT.

Last time i posted this Linus asked what was wrong with vector collisions, 
i'll reply again; if we collide we end up overwriting the previous IDT 
entry and losing that irq entry.

(Hardware courtesy of OSDL)
Patch tested on 32way NUMAQ and uniprocessor with IOAPIC for regression.

Index: linux-2.5/include/asm-i386/mach-default/irq_vectors.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/mach-default/irq_vectors.h,v
retrieving revision 1.3
diff -u -p -B -r1.3 irq_vectors.h
--- linux-2.5/include/asm-i386/mach-default/irq_vectors.h	8 Apr 2003 16:42:23 -0000	1.3
+++ linux-2.5/include/asm-i386/mach-default/irq_vectors.h	28 May 2003 23:50:52 -0000
@@ -74,9 +74,18 @@
  * more than 256 devices theoretically, but they will
  * have to use shared interrupts)
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
+ * the usable vector space is 0x20-0xff (224 vectors).
+ * Linux currently makes 189 vectors available for io interrupts
+ * starting at FIRST_DEVICE_VECTOR till FIRST_SYSTEM_VECTOR
+ * with 1 reserved for SYSCALL_VECTOR
+ * 
+ * 0________0x31__________________________0xef______0xff
+ *   system           io interrupts           resvd
+ *
  */
 #ifdef CONFIG_X86_IO_APIC
+/* number of vectors available for external devices */
+#define NR_IRQ_VECTORS	189
 #define NR_IRQS 224
 #else
 #define NR_IRQS 16
Index: linux-2.5/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/kernel/io_apic.c,v
retrieving revision 1.64
diff -u -p -B -r1.64 io_apic.c
--- linux-2.5/arch/i386/kernel/io_apic.c	15 May 2003 16:01:31 -0000	1.64
+++ linux-2.5/arch/i386/kernel/io_apic.c	28 May 2003 23:50:54 -0000
@@ -1120,9 +1120,15 @@ int irq_vector[NR_IRQS] = { FIRST_DEVICE
 
 static int __init assign_irq_vector(int irq)
 {
-	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0,
+		nr_assigned = 1;
+
 	if (IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
+
+	if (++nr_assigned > NR_IRQ_VECTORS)
+		return -ENOSPC;
+
 next:
 	current_vector += 8;
 	if (current_vector == SYSCALL_VECTOR)
@@ -1180,6 +1186,8 @@ void __init setup_IO_APIC_irqs(void)
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
+		if (irq >= NR_IRQS)
+			continue;
 		/*
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
@@ -1194,6 +1202,9 @@ void __init setup_IO_APIC_irqs(void)
 
 		if (IO_APIC_IRQ(irq)) {
 			vector = assign_irq_vector(irq);
+			if (vector < 0)
+				continue;
+
 			entry.vector = vector;
 
 			if (IO_APIC_irq_trigger(irq))
@@ -2291,6 +2302,10 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int vector;
+
+	if (irq >= NR_IRQS)
+		return -ENOSPC;
 
 	if (!IO_APIC_IRQ(irq)) {
 		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
@@ -2315,8 +2330,11 @@ int io_apic_set_pci_routing (int ioapic,
 
 	add_pin_to_irq(irq, ioapic, pin);
 
-	entry.vector = assign_irq_vector(irq);
+	vector = assign_irq_vector(irq);
+	if (vector < 0)
+		return -ENOSPC;
 
+	entry.vector = vector;
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
 		"IRQ %d)\n", ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
