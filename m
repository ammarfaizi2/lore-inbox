Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263332AbTDCJIM>; Thu, 3 Apr 2003 04:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbTDCJIM>; Thu, 3 Apr 2003 04:08:12 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:37884
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263332AbTDCJIJ>; Thu, 3 Apr 2003 04:08:09 -0500
Date: Thu, 3 Apr 2003 04:15:09 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Martin Bligh <mbligh@aracnet.com>
Subject: [PATCH][2.5] purge panic from assign_irq_vector (boot 8quad w/
 mainline)
Message-ID: <Pine.LNX.4.50.0304030224440.30262-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a NUMAQ system with 320 interrupt sources in the mptables, we panic in 
setup_IO_APIC_irqs whilst assigning vectors to the interrupts due to 
vector space exhaustion. This is rather annoying and unecessary, we can 
simply not assign the vector and it will later on not have a interrupt 
controller handler designated to it. With this patch we can boot 32way, 
16 IOAPICs, get the irqs we can handle working and keep trucking. This is 
probably the cleanest and least invasive solution for mainline right now 
but there are patches which avert this scenario and use more io  
interrupts being worked on.

(Hardware courtesy of OSDL)
Tested and booted on failure case system;
32 processor NUMAQ 16 IOAPICs, 320 interrupt sources

and regression tested on
8 processor 1 IOAPIC, 63 interrupt sources

Someone please apply (if only because panic sucks),

Cheers,
	Zwane Mwaikambo

Index: linux-2.5.66/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.5.66/arch/i386/kernel/io_apic.c	24 Mar 2003 23:40:27 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/kernel/io_apic.c	3 Apr 2003 08:25:48 -0000
@@ -1105,6 +1105,9 @@ static int __init assign_irq_vector(int 
 	if (IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
+	if (current_vector == -ENOSPC)
+		goto out;
+
 	current_vector += 8;
 	if (current_vector == SYSCALL_VECTOR)
 		goto next;
@@ -1114,10 +1117,14 @@ next:
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
 
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
+	if (current_vector == FIRST_SYSTEM_VECTOR) {
+		printk(KERN_WARNING "ran out of interrupt vectors!\n");
+		current_vector = -ENOSPC;
+		goto out;
+	}
 
 	IO_APIC_VECTOR(irq) = current_vector;
+out:
 	return current_vector;
 }
 
@@ -1164,6 +1171,9 @@ void __init setup_IO_APIC_irqs(void)
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
+		if (irq > NR_IRQS)
+			continue;
+
 		/*
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
@@ -1178,8 +1188,10 @@ void __init setup_IO_APIC_irqs(void)
 
 		if (IO_APIC_IRQ(irq)) {
 			vector = assign_irq_vector(irq);
-			entry.vector = vector;
+			if (vector < 0)
+				continue;
 
+			entry.vector = vector;
 			if (IO_APIC_irq_trigger(irq))
 				irq_desc[irq].handler = &ioapic_level_irq_type;
 			else
@@ -2274,6 +2286,10 @@ int io_apic_set_pci_routing (int ioapic,
 {
 	struct IO_APIC_route_entry entry;
 	unsigned long flags;
+	int vector;
+
+	if (irq > NR_IRQS)
+		return -ENOSPC;
 
 	if (!IO_APIC_IRQ(irq)) {
 		printk(KERN_ERR "IOAPIC[%d]: Invalid reference to IRQ 0/n", 
@@ -2298,8 +2314,11 @@ int io_apic_set_pci_routing (int ioapic,
 
 	add_pin_to_irq(irq, ioapic, pin);
 
-	entry.vector = assign_irq_vector(irq);
+	vector = assign_irq_vector(irq);
+	if (vector < 0)
+		return -ENOSPC;
 
+	entry.vector = vector;
 	printk(KERN_DEBUG "IOAPIC[%d]: Set PCI routing entry (%d-%d -> 0x%x -> "
 		"IRQ %d)\n", ioapic, 
 		mp_ioapics[ioapic].mpc_apicid, pin, entry.vector, irq);
