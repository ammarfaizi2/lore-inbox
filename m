Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTEEXvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 19:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTEEXvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 19:51:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:58599 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262109AbTEEXvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 19:51:09 -0400
Subject: [RFC][PATCH] fix for clusterd io_apics
From: Keith Mannthey <kmannth@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       James Cleverdon <cleverdj@us.ibm.com>
In-Reply-To: <20030430192205.13491d61.akpm@digeo.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
	<20030430163637.04f06ba6.akpm@digeo.com>
	<1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com> 
	<20030430192205.13491d61.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 May 2003 17:04:08 -0700
Message-Id: <1052179450.16886.224.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following is a patch to fix inconsistent use of the function
set_ioapic_affinity. In the current kernel it is unclear as to weather
the value being passed to the function is a cpu mask or valid apic id. 
In irq_affinity_write_proc the kernel passes on a cpu mask but the kirqd
thread passes on logical apic ids.  In flat apic mode this is not an
issue because a cpu mask represents the apic value.  However in
clustered apic mode the cpu mask is very different from the logical apic
id.  
  This is an attempt to do the right thing for clustered apics.  I
clarify that the value being passed to set_ioapic_affinity is a cpu mask
not a apicid.  Set_ioapic_affinity will do the conversion to logical
apic ids.  Since many cpu masks don't map to valid apicids in clustered
apic mode TARGET_CPUS is used as a default value when such a situation
occurs.  I think this is a good step in making irq_affinity clustered
apic safe.
  
Keith 

diff -urN linux-2.5.68/arch/i386/kernel/io_apic.c linux-2.5.68-fix_irq_affinity/arch/i386/kernel/io_apic.c
--- linux-2.5.68/arch/i386/kernel/io_apic.c	Sat Apr 19 19:49:09 2003
+++ linux-2.5.68-fix_irq_affinity/arch/i386/kernel/io_apic.c	Tue May  6 23:10:18 2003
@@ -240,22 +240,22 @@
 			clear_IO_APIC_pin(apic, pin);
 }
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
+static void set_ioapic_affinity (unsigned int irq, unsigned long cpu_mask)
 {
 	unsigned long flags;
 	int pin;
 	struct irq_pin_list *entry = irq_2_pin + irq;
-
-	/*
-	 * Only the first 8 bits are valid.
-	 */
-	mask = mask << 24;
+	unsigned int apicid_value;
+	
+	apicid_value = cpu_mask_to_apicid(cpu_mask);
+	/* Prepare to do the io_apic_write */
+	apicid_value = apicid_value << 24;
 	spin_lock_irqsave(&ioapic_lock, flags);
 	for (;;) {
 		pin = entry->pin;
 		if (pin == -1)
 			break;
-		io_apic_write(entry->apic, 0x10 + 1 + pin*2, mask);
+		io_apic_write(entry->apic, 0x10 + 1 + pin*2, apicid_value);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
@@ -279,7 +279,7 @@
 
 extern unsigned long irq_affinity[NR_IRQS];
 
-static int __cacheline_aligned pending_irq_balance_apicid[NR_IRQS];
+static int __cacheline_aligned pending_irq_balance_cpumask[NR_IRQS];
 static int irqbalance_disabled = NO_BALANCE_IRQ;
 static int physical_balance = 0;
 
@@ -352,7 +352,7 @@
 		unsigned long flags;
 
 		spin_lock_irqsave(&desc->lock, flags);
-		pending_irq_balance_apicid[irq]=cpu_to_logical_apicid(new_cpu);
+		pending_irq_balance_cpumask[irq] = 1 << new_cpu;
 		spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
@@ -549,8 +549,7 @@
 				selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock_irqsave(&desc->lock, flags);
-		pending_irq_balance_apicid[selected_irq] =
-				cpu_to_logical_apicid(min_loaded);
+		pending_irq_balance_cpumask[selected_irq] = 1 << min_loaded;
 		spin_unlock_irqrestore(&desc->lock, flags);
 		/* Since we made a change, come back sooner to 
 		 * check for more variation.
@@ -582,7 +581,7 @@
 	
 	/* push everything to CPU 0 to give us a starting point.  */
 	for (i = 0 ; i < NR_IRQS ; i++)
-		pending_irq_balance_apicid[i] = cpu_to_logical_apicid(0);
+		pending_irq_balance_cpumask[i] = 1;
 
 repeat:
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -659,9 +658,9 @@
 static inline void move_irq(int irq)
 {
 	/* note - we hold the desc->lock */
-	if (unlikely(pending_irq_balance_apicid[irq])) {
-		set_ioapic_affinity(irq, pending_irq_balance_apicid[irq]);
-		pending_irq_balance_apicid[irq] = 0;
+	if (unlikely(pending_irq_balance_cpumask[irq])) {
+		set_ioapic_affinity(irq, pending_irq_balance_cpumask[irq]);
+		pending_irq_balance_cpumask[irq] = 0;
 	}
 }
 
diff -urN linux-2.5.68/include/asm-i386/mach-bigsmp/mach_apic.h linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-bigsmp/mach_apic.h	Sat Apr 19 19:51:08 2003
+++ linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-bigsmp/mach_apic.h	Tue May  6 22:28:37 2003
@@ -27,7 +27,7 @@
 #define APIC_BROADCAST_ID     (0x0f)
 #define check_apicid_used(bitmap, apicid) (0)
 #define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
-
+#define apicid_cluster(apicid) (apicid & 0xF0)
 static inline unsigned long calculate_ldr(unsigned long old)
 {
 	unsigned long id;
@@ -115,4 +115,37 @@
 	return (1);
 }
 
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	int num_bits_set;
+	int cpus_found = 0;
+	int cpu;
+	int apicid;	
+
+	num_bits_set = hweight32(cpumask); 
+	/* Return id to all */
+	if (num_bits_set == 32)
+		return (int) 0xFF;
+	/* 
+	 * The cpus in the mask must all be on the apic cluster.  If are not 
+	 * on the same apicid cluster return default value of TARGET_CPUS. 
+	 */
+	cpu = ffs(cpumask)-1;
+	apicid = cpu_to_logical_apicid(cpu);
+	while (cpus_found < num_bits_set) {
+		if (cpumask & (1 << cpu)) {
+			int new_apicid = cpu_to_logical_apicid(cpu);
+			if (apicid_cluster(apicid) != 
+					apicid_cluster(new_apicid)){
+				printk ("%s: Not a valid mask!\n",__FUNCTION__);
+				return TARGET_CPUS;
+			}
+			apicid = apicid | new_apicid;
+			cpus_found++;
+		}
+		cpu++;
+	}
+	return apicid;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-default/mach_apic.h linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-default/mach_apic.h	Sat Apr 19 19:51:19 2003
+++ linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-default/mach_apic.h	Tue May  6 22:14:57 2003
@@ -99,4 +99,9 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	return cpumask;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-numaq/mach_apic.h linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-numaq/mach_apic.h	Sat Apr 19 19:49:17 2003
+++ linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-numaq/mach_apic.h	Tue May  6 22:51:02 2003
@@ -14,6 +14,7 @@
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) ((bitmap) & (1 << (apicid)))
 #define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
+#define apicid_cluster(apicid) (apicid & 0xF0)
 
 static inline int apic_id_registered(void)
 {
@@ -103,4 +104,37 @@
 	return (1);
 }
 
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	int num_bits_set;
+	int cpus_found = 0;
+	int cpu;
+	int apicid;	
+
+	num_bits_set = hweight32(cpumask); 
+	/* Return id to all */
+	if (num_bits_set == 32)
+		return (int) 0xFF;
+	/* 
+	 * The cpus in the mask must all be on the apic cluster.  If are not 
+	 * on the same apicid cluster return default value of TARGET_CPUS. 
+	 */
+	cpu = ffs(cpumask)-1;
+	apicid = cpu_to_logical_apicid(cpu);
+	while (cpus_found < num_bits_set) {
+		if (cpumask & (1 << cpu)) {
+			int new_apicid = cpu_to_logical_apicid(cpu);
+			if (apicid_cluster(apicid) != 
+					apicid_cluster(new_apicid)){
+				printk ("%s: Not a valid mask!\n",__FUNCTION__);
+				return TARGET_CPUS;
+			}
+			apicid = apicid | new_apicid;
+			cpus_found++;
+		}
+		cpu++;
+	}
+	return apicid;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-summit/mach_apic.h linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-summit/mach_apic.h	Sat Apr 19 19:50:06 2003
+++ linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-summit/mach_apic.h	Tue May  6 22:12:04 2003
@@ -23,7 +23,7 @@
 
 /* we don't use the phys_cpu_present_map to indicate apicid presence */
 #define check_apicid_present(bit) (x86_summit ? 1 : (phys_cpu_present_map & (1 << bit))) 
-
+#define apicid_cluster(apicid) (apicid & 0xF0)
 extern u8 bios_cpu_apicid[];
 
 static inline void init_apic_ldr(void)
@@ -113,4 +113,37 @@
 		return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	int num_bits_set;
+	int cpus_found = 0;
+	int cpu;
+	int apicid;	
+
+	num_bits_set = hweight32(cpumask); 
+	/* Return id to all */
+	if (num_bits_set == 32)
+		return (int) 0xFF;
+	/* 
+	 * The cpus in the mask must all be on the apic cluster.  If are not 
+	 * on the same apicid cluster return default value of TARGET_CPUS. 
+	 */
+	cpu = ffs(cpumask)-1;
+	apicid = cpu_to_logical_apicid(cpu);
+	while (cpus_found < num_bits_set) {
+		if (cpumask & (1 << cpu)) {
+			int new_apicid = cpu_to_logical_apicid(cpu);
+			if (apicid_cluster(apicid) != 
+					apicid_cluster(new_apicid)){
+				printk ("%s: Not a valid mask!\n",__FUNCTION__);
+				return TARGET_CPUS;
+			}
+			apicid = apicid | new_apicid;
+			cpus_found++;
+		}
+		cpu++;
+	}
+	return apicid;
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -urN linux-2.5.68/include/asm-i386/mach-visws/mach_apic.h linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.5.68/include/asm-i386/mach-visws/mach_apic.h	Sat Apr 19 19:48:49 2003
+++ linux-2.5.68-fix_irq_affinity/include/asm-i386/mach-visws/mach_apic.h	Tue May  6 22:16:52 2003
@@ -77,4 +77,8 @@
 	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
 }
 
+static inline unsigned int cpu_mask_to_apicid (unsigned long cpumask)
+{
+	return cpumask;
+}
 #endif /* __ASM_MACH_APIC_H */


