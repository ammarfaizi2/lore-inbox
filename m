Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTDHB50 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 21:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTDHB5Z (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 21:57:25 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:37699
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263847AbTDHB5U (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 21:57:20 -0400
Date: Mon, 7 Apr 2003 22:04:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] avoid scribbling in IDT with high interrupt count.
In-Reply-To: <Pine.LNX.4.44.0304070818340.26364-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0304071958360.21025-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0304070818340.26364-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Linus Torvalds wrote:

> Zwane - is there any reason we couldn't just start re-using irq vector
> offsets when this happens? We already re-use the vectors themselves, so 
> restarting the offset pointer shouldn't really _change_ anything.

My patch skips irq numbers > NR_IRQS and simply return error when we run 
out of vectors, although mainline doesn't assign duplicates and cause 
collisions, it does waste vector space. e.g. for a system with 
NR_IRQS = 224 we have 23 vectors free, 0 collisions and 167 useable irqs 
and assign_irq_vectors states that we're out of vectors.

> In other words, I'm wondering if this simpler patch wouldn't be sufficient 
> instead?
> 
> Can you please test this, and re-submit (and if you can explain why your 
> patch is better, please do so - I have nothing fundamentally against it, I 
> just want to understand _why_ the complexity is needed).

Your patch booted the system but there are vector collisions resulting in 
lost irq routing when we program the IOAPIC with the duplicated vector. So 
with your patch and NR_IRQS = 224 we have 1 vectors free (0x80), 34 collisions 
and 225 irqs. However that isn't a fault of your patch but a fault with 
the NR_IRQS definition. This is what the vector space looks like on i386 
at present.

0________0x31__________________________0xef____________0xff
  system	   io interrupts            resvd vectors

0xef - 0x31 = 190 useable io interrupt vectors

So perhaps we should, apply your patch, add a NR_IRQ_VECTORS define 
and also add commentary in irq_vectors.h how does the following look? I 
had to readd the NR_IRQS checks to protect against overrunning NR_IRQS sized 
arrays and i added nr_assigned to track how many vectors were allocated so 
taht we can bail out when we're out.

Patch has been tested on a 320 interrupt system and had a maximum useable 
irq line of 211 (ethernet).

Thanks,
	Zwane

Index: linux-2.5.67/include/asm-i386/mach-default/irq_vectors.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.67/include/asm-i386/mach-default/irq_vectors.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq_vectors.h
--- linux-2.5.67/include/asm-i386/mach-default/irq_vectors.h	8 Apr 2003 01:15:29 -0000	1.1.1.1
+++ linux-2.5.67/include/asm-i386/mach-default/irq_vectors.h	8 Apr 2003 01:34:54 -0000
@@ -68,15 +68,22 @@
 #define TIMER_IRQ 0
 
 /*
- * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * 16 8259A IRQ's, MAX_IRQ_SOURCES-16 potential APIC interrupt sources.
  * Right now the APIC is mostly only used for SMP.
  * 256 vectors is an architectural limit. (we can have
  * more than 256 devices theoretically, but they will
  * have to use shared interrupts)
  * Since vectors 0x00-0x1f are used/reserved for the CPU,
- * the usable vector space is 0x20-0xff (224 vectors)
+ * the usable vector space is 0x20-0xff (224 vectors).
+ * Linux currently makes 190 vectors available for io interrupts
+ * starting at FIRST_DEVICE_VECTOR till FIRST_SYSTEM_VECTOR
+ * 
+ * 0________0x31__________________________0xef______0xff
+ *   system           io interrupts           resvd
+ *
  */
 #ifdef CONFIG_X86_IO_APIC
+#define NR_IRQ_VECTORS	190
 #define NR_IRQS 224
 #else
 #define NR_IRQS 16
Index: linux-2.5.67/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.67/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.5.67/arch/i386/kernel/io_apic.c	8 Apr 2003 01:15:35 -0000	1.1.1.1
+++ linux-2.5.67/arch/i386/kernel/io_apic.c	8 Apr 2003 01:36:06 -0000
@@ -1107,9 +1107,15 @@ int irq_vector[NR_IRQS] = { FIRST_DEVICE
 
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
@@ -1167,6 +1173,8 @@ void __init setup_IO_APIC_irqs(void)
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
+		if (irq >= NR_IRQS)
+			continue;
 		/*
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
@@ -1181,6 +1189,9 @@ void __init setup_IO_APIC_irqs(void)
 
 		if (IO_APIC_IRQ(irq)) {
 			vector = assign_irq_vector(irq);
+			if (vector < 0)
+				continue;
+
 			entry.vector = vector;
 
 			if (IO_APIC_irq_trigger(irq))
@@ -2277,6 +2288,10 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int vector;
+
+	if (irq >= NR_IRQS)
+		return -ENOSPC;
 
 	if (!IO_APIC_IRQ(irq)) {
 		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
@@ -2301,8 +2316,11 @@ int io_apic_set_pci_routing (int ioapic,
 
 	add_pin_to_irq(irq, ioapic, pin);
 
-	entry.vector = assign_irq_vector(irq);
+	vector = assign_irq_vector(irq);
+	if (vector < 0)
+		return -ENOSPC;
 
+	entry.vector = vector;
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
 		"IRQ %d)\n", ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);

-- 
function.linuxpower.ca
