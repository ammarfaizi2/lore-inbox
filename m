Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268009AbTBWRko>; Sun, 23 Feb 2003 12:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268495AbTBWRko>; Sun, 23 Feb 2003 12:40:44 -0500
Received: from franka.aracnet.com ([216.99.193.44]:9364 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268009AbTBWRkm>; Sun, 23 Feb 2003 12:40:42 -0500
Date: Sun, 23 Feb 2003 09:30:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix kirq disable
Message-ID: <1530000.1046021434@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a working irq disablement routing before kirq, which is
now broken. The problem seems to be that there are two different 
switches: irqbalance_disable and no_balance_irq, and each is respected 
in different places. The following patch fixes that ... it's now off
by default for subarches that desire that, and can be disabled
by a command line options for others. I renamed no_balance_irq to
NO_BALANCE_IRQ as it's no longer pretending to be a switch, just a
define.

Seems like a perfectly simple fix to me, however, such some more 
testing would probably be prudent ... could you add this to -mm?

Thanks,

M.

diff -urpN -X /home/fletch/.diff.exclude 262-irq_affinity/arch/i386/kernel/io_apic.c 263-no_kirq/arch/i386/kernel/io_apic.c
--- 262-irq_affinity/arch/i386/kernel/io_apic.c	Sat Feb 22 14:59:01 2003
+++ 263-no_kirq/arch/i386/kernel/io_apic.c	Sat Feb 22 15:04:39 2003
@@ -277,7 +277,7 @@ static void set_ioapic_affinity (unsigne
 
 extern unsigned long irq_affinity [NR_IRQS];
 int __cacheline_aligned pending_irq_balance_apicid [NR_IRQS];
-static int irqbalance_disabled __initdata = 0;
+static int irqbalance_disabled = NO_BALANCE_IRQ;
 static int physical_balance = 0;
 
 struct irq_cpu_info {
@@ -546,7 +546,7 @@ static inline void balance_irq (int cpu,
 	unsigned long allowed_mask;
 	unsigned int new_cpu;
 		
-	if (no_balance_irq)
+	if (irqbalance_disabled)
 		return;
 
 	allowed_mask = cpu_online_map & irq_affinity[irq];
diff -urpN -X /home/fletch/.diff.exclude 262-irq_affinity/include/asm-i386/mach-bigsmp/mach_apic.h 263-no_kirq/include/asm-i386/mach-bigsmp/mach_apic.h
--- 262-irq_affinity/include/asm-i386/mach-bigsmp/mach_apic.h	Sat Feb 22 08:33:07 2003
+++ 263-no_kirq/include/asm-i386/mach-bigsmp/mach_apic.h	Sat Feb 22 15:02:02 2003
@@ -10,7 +10,7 @@
 		((phys_apic) & (~0xf)) )
 #endif
 
-#define no_balance_irq (1)
+#define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
 static inline int apic_id_registered(void)
diff -urpN -X /home/fletch/.diff.exclude 262-irq_affinity/include/asm-i386/mach-default/mach_apic.h 263-no_kirq/include/asm-i386/mach-default/mach_apic.h
--- 262-irq_affinity/include/asm-i386/mach-default/mach_apic.h	Sat Feb 22 08:33:07 2003
+++ 263-no_kirq/include/asm-i386/mach-default/mach_apic.h	Sat Feb 22 15:02:11 2003
@@ -9,7 +9,7 @@
  #define TARGET_CPUS 0x01
 #endif
 
-#define no_balance_irq (0)
+#define NO_BALANCE_IRQ (0)
 #define esr_disable (0)
 
 #define INT_DELIVERY_MODE dest_LowestPrio
diff -urpN -X /home/fletch/.diff.exclude 262-irq_affinity/include/asm-i386/mach-numaq/mach_apic.h 263-no_kirq/include/asm-i386/mach-numaq/mach_apic.h
--- 262-irq_affinity/include/asm-i386/mach-numaq/mach_apic.h	Sat Feb 22 08:33:07 2003
+++ 263-no_kirq/include/asm-i386/mach-numaq/mach_apic.h	Sat Feb 22 15:02:19 2003
@@ -5,7 +5,7 @@
 
 #define TARGET_CPUS (0xf)
 
-#define no_balance_irq (1)
+#define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
 #define INT_DELIVERY_MODE dest_LowestPrio
diff -urpN -X /home/fletch/.diff.exclude 262-irq_affinity/include/asm-i386/mach-summit/mach_apic.h 263-no_kirq/include/asm-i386/mach-summit/mach_apic.h
--- 262-irq_affinity/include/asm-i386/mach-summit/mach_apic.h	Sat Feb 22 14:04:06 2003
+++ 263-no_kirq/include/asm-i386/mach-summit/mach_apic.h	Sat Feb 22 15:02:28 2003
@@ -4,7 +4,7 @@
 extern int x86_summit;
 
 #define esr_disable (x86_summit ? 1 : 0)
-#define no_balance_irq (0)
+#define NO_BALANCE_IRQ (0)
 
 #define XAPIC_DEST_CPUS_MASK    0x0Fu
 #define XAPIC_DEST_CLUSTER_MASK 0xF0u


