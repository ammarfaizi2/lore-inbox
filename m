Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSLWGhM>; Mon, 23 Dec 2002 01:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSLWGhM>; Mon, 23 Dec 2002 01:37:12 -0500
Received: from franka.aracnet.com ([216.99.193.44]:61591 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266640AbSLWGhJ>; Mon, 23 Dec 2002 01:37:09 -0500
Date: Sun, 22 Dec 2002 22:45:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 3/8 Move NUMA-Q support into subarch
Message-ID: <48240000.1040625911@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code originally by James Cleverdon. Abstracts out some sections
that were switched by clustered_apic_mode into the following functions:

apic_id_registered()
init_apic_ldr()
multi_timer_check()

Changes the return check in balance_irq from testing clustered_apic_mode
to testing "no_balance_irq" to be more general.

The removal of:
	entry.dest.logical.logical_dest = TARGET_CPUS;
is because it's a duplicate (we do it twice in the same function for
no reason).

diff -urpN -X /home/fletch/.diff.exclude 11-numaq1/arch/i386/kernel/apic.c 12-numaq2/arch/i386/kernel/apic.c
--- 11-numaq1/arch/i386/kernel/apic.c	Sun Dec 22 12:08:42 2002
+++ 12-numaq2/arch/i386/kernel/apic.c	Sun Dec 22 12:09:41 2002
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
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
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
diff -urpN -X /home/fletch/.diff.exclude 11-numaq1/arch/i386/kernel/io_apic.c 12-numaq2/arch/i386/kernel/io_apic.c
--- 11-numaq1/arch/i386/kernel/io_apic.c	Sun Dec 22 12:08:42 2002
+++ 12-numaq2/arch/i386/kernel/io_apic.c	Sun Dec 22 12:09:41 2002
@@ -262,7 +262,7 @@ static inline void balance_irq(int irq)
 	irq_balance_t *entry = irq_balance + irq;
 	unsigned long now = jiffies;
 
-	if (clustered_apic_mode)
+	if (no_balance_irq)
 		return;
 
 	if (unlikely(time_after(now, entry->timestamp + IRQ_BALANCE_INTERVAL))) {
@@ -740,7 +740,6 @@ void __init setup_IO_APIC_irqs(void)
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -748,7 +747,7 @@ void __init setup_IO_APIC_irqs(void)
 		 * skip adding the timer int on secondary nodes, which causes
 		 * a small but painful rift in the time-space continuum
 		 */
-		if (clustered_apic_mode && (apic != 0) && (irq == 0))
+		if (multi_timer_check(apic, irq))
 			continue;
 		else
 			add_pin_to_irq(irq, apic, pin);
diff -urpN -X /home/fletch/.diff.exclude 11-numaq1/include/asm-i386/mach-default/mach_apic.h 12-numaq2/include/asm-i386/mach-default/mach_apic.h
--- 11-numaq1/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:09:22 2002
+++ 12-numaq2/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:09:41 2002
@@ -1,14 +1,6 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
-static inline unsigned long calculate_ldr(unsigned long old)
-{
-	unsigned long id;
-
-	id = 1UL << smp_processor_id();
-	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
-}
-
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 #ifdef CONFIG_SMP
@@ -17,6 +9,8 @@ static inline unsigned long calculate_ld
  #define TARGET_CPUS 0x01
 #endif
 
+#define no_balance_irq (0)
+
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
@@ -24,10 +18,38 @@ static inline void summit_check(char *oe
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
+ * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
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
diff -urpN -X /home/fletch/.diff.exclude 11-numaq1/include/asm-i386/mach-numaq/mach_apic.h 12-numaq2/include/asm-i386/mach-numaq/mach_apic.h
--- 11-numaq1/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:09:22 2002
+++ 12-numaq2/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:09:41 2002
@@ -1,18 +1,12 @@
 #ifndef __ASM_MACH_APIC_H
 #define __ASM_MACH_APIC_H
 
-static inline unsigned long calculate_ldr(unsigned long old)
-{
-	unsigned long id;
-
-	id = 1UL << smp_processor_id();
-	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
-}
-
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
 #define TARGET_CPUS (0xf)
 
+#define no_balance_irq (1)
+
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
@@ -20,10 +14,25 @@ static inline void summit_check(char *oe
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
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
 		"NUMA-Q", nr_ioapics);
+}
+
+static inline int multi_timer_check(int apic, int irq)
+{
+	return (apic != 0 && irq == 0);
 }
 
 static inline int cpu_present_to_apicid(int mps_cpu)

