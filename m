Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268141AbTB1VfN>; Fri, 28 Feb 2003 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268192AbTB1Vec>; Fri, 28 Feb 2003 16:34:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44784 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268184AbTB1VdI>; Fri, 28 Feb 2003 16:33:08 -0500
Date: Fri, 28 Feb 2003 13:34:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5/7 Fix kirq_balance up so I can disable it.
Message-ID: <361390000.1046468047@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, there are two different switches used, irqbalance_disabled
and no_balance_irq ... each of which switches half the code off. This
patch harmonises them into one (irqbalance_disable), and uses the old
subarch stuff as a default value so that this is auto-disabled on boxes
like NUMA-Q that can't cope with it. 

Also renamed no_balance_irq to NO_BALANCE_IRQ as it's really a static 
defined number now, not pretending to be a switch variable any more.
Now off by default for NUMA-Q, on by default for others, but can be
disabled with the boot time flag if people desire.

diff -urpN -X /home/fletch/.diff.exclude 013-pcibus_to_cpumask/arch/i386/kernel/io_apic.c 014-no_kirq/arch/i386/kernel/io_apic.c
--- 013-pcibus_to_cpumask/arch/i386/kernel/io_apic.c	Tue Feb 25 23:03:43 2003
+++ 014-no_kirq/arch/i386/kernel/io_apic.c	Fri Feb 28 08:05:35 2003
@@ -223,7 +223,7 @@ static void set_ioapic_affinity (unsigne
 
 extern unsigned long irq_affinity [NR_IRQS];
 int __cacheline_aligned pending_irq_balance_apicid [NR_IRQS];
-static int irqbalance_disabled __initdata = 0;
+static int irqbalance_disabled = NO_BALANCE_IRQ;
 static int physical_balance = 0;
 
 struct irq_cpu_info {
@@ -492,7 +492,7 @@ static inline void balance_irq (int cpu,
 	unsigned long allowed_mask;
 	unsigned int new_cpu;
 		
-	if (no_balance_irq)
+	if (irqbalance_disabled)
 		return;
 
 	allowed_mask = cpu_online_map & irq_affinity[irq];
diff -urpN -X /home/fletch/.diff.exclude 013-pcibus_to_cpumask/include/asm-i386/mach-bigsmp/mach_apic.h 014-no_kirq/include/asm-i386/mach-bigsmp/mach_apic.h
--- 013-pcibus_to_cpumask/include/asm-i386/mach-bigsmp/mach_apic.h	Fri Feb 28 08:05:34 2003
+++ 014-no_kirq/include/asm-i386/mach-bigsmp/mach_apic.h	Fri Feb 28 08:05:35 2003
@@ -10,7 +10,7 @@
 		((phys_apic) & (~0xf)) )
 #endif
 
-#define no_balance_irq (1)
+#define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
 static inline int apic_id_registered(void)
diff -urpN -X /home/fletch/.diff.exclude 013-pcibus_to_cpumask/include/asm-i386/mach-default/mach_apic.h 014-no_kirq/include/asm-i386/mach-default/mach_apic.h
--- 013-pcibus_to_cpumask/include/asm-i386/mach-default/mach_apic.h	Fri Feb 28 08:05:34 2003
+++ 014-no_kirq/include/asm-i386/mach-default/mach_apic.h	Fri Feb 28 08:05:35 2003
@@ -9,7 +9,7 @@
  #define TARGET_CPUS 0x01
 #endif
 
-#define no_balance_irq (0)
+#define NO_BALANCE_IRQ (0)
 #define esr_disable (0)
 
 #define INT_DELIVERY_MODE dest_LowestPrio
diff -urpN -X /home/fletch/.diff.exclude 013-pcibus_to_cpumask/include/asm-i386/mach-numaq/mach_apic.h 014-no_kirq/include/asm-i386/mach-numaq/mach_apic.h
--- 013-pcibus_to_cpumask/include/asm-i386/mach-numaq/mach_apic.h	Fri Feb 28 08:05:34 2003
+++ 014-no_kirq/include/asm-i386/mach-numaq/mach_apic.h	Fri Feb 28 08:05:35 2003
@@ -5,7 +5,7 @@
 
 #define TARGET_CPUS (0xf)
 
-#define no_balance_irq (1)
+#define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
 #define INT_DELIVERY_MODE dest_LowestPrio
diff -urpN -X /home/fletch/.diff.exclude 013-pcibus_to_cpumask/include/asm-i386/mach-summit/mach_apic.h 014-no_kirq/include/asm-i386/mach-summit/mach_apic.h
--- 013-pcibus_to_cpumask/include/asm-i386/mach-summit/mach_apic.h	Fri Feb 28 08:05:34 2003
+++ 014-no_kirq/include/asm-i386/mach-summit/mach_apic.h	Fri Feb 28 08:05:35 2003
@@ -4,7 +4,7 @@
 extern int x86_summit;
 
 #define esr_disable (x86_summit ? 1 : 0)
-#define no_balance_irq (0)
+#define NO_BALANCE_IRQ (0)
 
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u


