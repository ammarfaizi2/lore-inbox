Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTDGF4n (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTDGF4n (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:56:43 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:1056
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263267AbTDGF4l (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 01:56:41 -0400
Date: Mon, 7 Apr 2003 02:03:39 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] avoid scribbling in IDT with high interrupt count.
Message-ID: <Pine.LNX.4.50.0304070049400.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with high interrupt counts we end up overshooting the 
interrupt[] array and dumping garbage entry points into the idt. This 
patch checks for out of bounds access during ioapic setup as well as 
returning -ENOSPC when we run out of vectors to assign in 
assign_irq_vector, thus allowing us to remove the panic and boot a 320 
interrupt source system with 2.5.66. Patch appended

(Hardware courtesy of OSDL)
Tested and booted on failure case system;
32 processor NUMAQ 16 IOAPICs, 320 interrupt sources

and regression tested on
8 processor 1 IOAPIC, 63 interrupt sources

Total of 32 processors activated (31453.18 BogoMIPS).
ENABLING IO-APIC IRQs
 printing eip:
c010c954
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c010c954>]    Not tainted
EFLAGS: 00010202
EIP is at set_intr_gate+0x14/0x30
eax: 00606f20   ebx: 07070707   ecx: 07070707   edx: c0138e00
esi: c0136f20   edi: 0000000c   ebp: 00000127   esp: c3c9ff40
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c3c9e000 task=c3c9c040)
Stack: c037cd34 07070707 c0136f20 c3c9ff60 07070707 00000000 00000007 0000000c 
       0001a107 0f000000 000072ed 00000286 c03ee396 00000246 00000000 00eff800 
       00000010 00000000 c037d662 c02c6181 000072b4 00000296 c03ee3b9 00000246 
Call Trace:
 [<c0136f20>] sys_setregid16+0x0/0x30
 [<c0122f28>] printk+0x1d8/0x230
 [<c01050ec>] init+0x6c/0x220
 [<c0105080>] init+0x0/0x220
 [<c0108bb5>] kernel_thread_helper+0x5/0x10

Code: 89 04 cd 00 10 35 c0 89 14 cd 04 10 35 c0 c3 8d b6 00 00 00 
 <0>Kernel panic: Attempted to kill init!


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
