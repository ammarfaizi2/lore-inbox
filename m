Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSJMUmi>; Sun, 13 Oct 2002 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJMUlq>; Sun, 13 Oct 2002 16:41:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6020 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261733AbSJMUki>;
	Sun, 13 Oct 2002 16:40:38 -0400
Date: Sun, 13 Oct 2002 13:42:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 [3/4]
Message-ID: <39930000.1034541727@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch originally by James Cleverdon

This patch turns TARGET_CPUS into a simple function target_cpus()
that returns the approprate value for the appropriate apic addressing 
mode being used. Will optimise away on non-summit boxes.

----------------

diff -urpN -X /home/fletch/.diff.exclude summit-2/arch/i386/kernel/io_apic.c summit-3/arch/i386/kernel/io_apic.c
--- summit-2/arch/i386/kernel/io_apic.c	Fri Oct 11 22:06:05 2002
+++ summit-3/arch/i386/kernel/io_apic.c	Sat Oct 12 10:04:08 2002
@@ -692,6 +692,20 @@ next:
 	return current_vector;
 }
 
+static inline int target_cpus(void)
+{
+	switch (clustered_apic_mode) {
+		case CLUSTERED_APIC_NUMAQ:
+			/* broadcast to local quad */ 
+			return APIC_BROADCAST_ID;
+		case CLUSTERED_APIC_XAPIC:
+			/* any CPU on cluster 0 */
+			return XAPIC_DEST_CPUS_MASK;
+		default:
+			return cpu_online_map;
+	}
+}
+
 static struct hw_interrupt_type ioapic_level_irq_type;
 static struct hw_interrupt_type ioapic_edge_irq_type;
 
@@ -714,7 +728,7 @@ void __init setup_IO_APIC_irqs(void)
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = INT_DELIVERY_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest = target_cpus();
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -732,7 +746,6 @@ void __init setup_IO_APIC_irqs(void)
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -794,7 +807,7 @@ void __init setup_ExtINT_IRQ0_pin(unsign
 	 */
 	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = target_cpus();
 	entry.delivery_mode = dest_LowestPrio;
 	entry.polarity = 0;
 	entry.trigger = 0;
@@ -1868,7 +1881,7 @@ int io_apic_set_pci_routing (int ioapic,
 
 	entry.delivery_mode = dest_LowestPrio;
 	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = target_cpus();
 	entry.mask = 1;					 /* Disabled (masked) */
 	entry.trigger = 1;				   /* Level sensitive */
 	entry.polarity = 1;					/* Low active */
diff -urpN -X /home/fletch/.diff.exclude summit-2/include/asm-i386/smp.h summit-3/include/asm-i386/smp.h
--- summit-2/include/asm-i386/smp.h	Sat Oct 12 08:54:08 2002
+++ summit-3/include/asm-i386/smp.h	Sat Oct 12 10:01:36 2002
@@ -21,17 +21,10 @@
 #endif
 #endif
 
-#ifdef CONFIG_SMP
-# ifdef CONFIG_CLUSTERED_APIC
-#  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
-#  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
-# else
-#  define TARGET_CPUS cpu_online_map
-#  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
-# endif
+#ifdef CONFIG_X86_NUMAQ
+ #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 #else
-# define INT_DELIVERY_MODE 1     /* logical delivery */
-# define TARGET_CPUS 0x01
+ #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 #endif
 
 #define CLUSTERED_APIC_NONE	0x00

