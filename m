Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUIXGjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUIXGjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUIXGiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:38:02 -0400
Received: from fmr04.intel.com ([143.183.121.6]:36833 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S268505AbUIXGgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:36:07 -0400
Date: Thu, 23 Sep 2004 23:36:02 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: linux-kernel@vger.kernel.org
Cc: asit.k.mallick@intel.com
Subject: [Patch 1/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525
Message-ID: <20040923233602.B19555@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
with x86 mach-default

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.6.9-rc2/arch/x86_64/kernel/io_apic.c linux-target/arch/x86_64/kernel/io_apic.c
--- linux-2.6.9-rc2/arch/x86_64/kernel/io_apic.c	2004-09-12 22:32:47.000000000 -0700
+++ linux-target/arch/x86_64/kernel/io_apic.c	2004-09-03 13:27:26.500032792 -0700
@@ -732,7 +732,7 @@
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = INT_DELIVERY_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -750,7 +750,7 @@
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
+			entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -800,7 +800,7 @@
 	 */
 	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.delivery_mode = dest_LowestPrio;
 	entry.polarity = 0;
 	entry.trigger = 0;
@@ -1908,7 +1908,7 @@
 
 	entry.delivery_mode = dest_LowestPrio;
 	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.trigger = edge_level;
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
@@ -1966,3 +1966,28 @@
 	apic_write_around(APIC_ICR, cfg);
 }
 #endif
+
+
+/*
+ * This function currently is only a helper for the i386 smp boot process where 
+ * we need to reprogram the ioredtbls to cater for the cpus which have come online
+ * so mask in all cases should simply be TARGET_CPUS
+ */
+void __init setup_ioapic_dest(void)
+{
+	int pin, ioapic, irq, irq_entry;
+
+	if (skip_ioapic_setup == 1)
+		return;
+
+	for (ioapic = 0; ioapic < nr_ioapics; ioapic++) {
+		for (pin = 0; pin < nr_ioapic_registers[ioapic]; pin++) {
+			irq_entry = find_irq_entry(ioapic, pin, mp_INT);
+			if (irq_entry == -1)
+				continue;
+			irq = pin_2_irq(irq_entry, ioapic, pin);
+			set_ioapic_affinity_irq(irq, TARGET_CPUS);
+		}
+
+	}
+}
diff -Nru linux-2.6.9-rc2/arch/x86_64/kernel/smpboot.c linux-target/arch/x86_64/kernel/smpboot.c
--- linux-2.6.9-rc2/arch/x86_64/kernel/smpboot.c	2004-09-12 22:33:39.000000000 -0700
+++ linux-target/arch/x86_64/kernel/smpboot.c	2004-09-03 13:27:26.501032640 -0700
@@ -950,6 +950,9 @@
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+#ifdef CONFIG_X86_IO_APIC
+	setup_ioapic_dest();
+#endif
 	zap_low_mappings();
 }
 
diff -Nru linux-2.6.9-rc2/include/asm-x86_64/hw_irq.h linux-target/include/asm-x86_64/hw_irq.h
--- linux-2.6.9-rc2/include/asm-x86_64/hw_irq.h	2004-09-12 22:33:37.000000000 -0700
+++ linux-target/include/asm-x86_64/hw_irq.h	2004-09-03 13:27:26.501032640 -0700
@@ -101,6 +101,7 @@
 extern void print_IO_APIC(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
 extern void send_IPI(int dest, int vector);
+extern void setup_ioapic_dest(void);
 
 extern unsigned long io_apic_irqs;
 
diff -Nru linux-2.6.9-rc2/include/asm-x86_64/smp.h linux-target/include/asm-x86_64/smp.h
--- linux-2.6.9-rc2/include/asm-x86_64/smp.h	2004-09-12 22:31:26.000000000 -0700
+++ linux-target/include/asm-x86_64/smp.h	2004-09-03 13:27:55.155676472 -0700
@@ -110,9 +110,13 @@
 
 #endif
 #define INT_DELIVERY_MODE 1     /* logical delivery */
-#define TARGET_CPUS 1
 
 #ifndef ASSEMBLY
+#ifdef CONFIG_SMP
+#define TARGET_CPUS cpu_online_map
+#else
+#define TARGET_CPUS cpumask_of_cpu(0)
+#endif
 static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
 	return cpus_addr(cpumask)[0];
