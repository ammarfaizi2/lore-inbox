Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUJATVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUJATVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUJATVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:21:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:2765 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266236AbUJATUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:20:37 -0400
Date: Fri, 1 Oct 2004 12:17:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: jamesclv@us.ibm.com
Cc: ak@muc.de, suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for
 E7520/E7320/E7525 - change TARGET_CPUS on x86_64
Message-Id: <20041001121754.5a9ecde8.akpm@osdl.org>
In-Reply-To: <200410011202.41048.jamesclv@us.ibm.com>
References: <2HSdY-7dr-3@gated-at.bofh.it>
	<20040930230133.0d4bcc0d.akpm@osdl.org>
	<20041001071922.GA32950@muc.de>
	<200410011202.41048.jamesclv@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cleverdon <jamesclv@us.ibm.com> wrote:
>
>  Zeus boxes are going out the door 1Q2005.  The question is, will v2.6 
>  work on them or not?

We'll get it into 2.6.10.  Please rework your patch against the below, or
against next -mm.


From: Suresh Siddha <suresh.b.siddha@intel.com>

Set TARGET_CPUS on x86_64 to cpu_online_map.  This brings the code inline
with x86 mach-default.  Fix MSI_TARGET_CPU code which will break with this
target_cpus change.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/io_apic.c |   33 +++++++++++++++++++++++++++++----
 25-akpm/arch/x86_64/kernel/smpboot.c |    3 +++
 25-akpm/include/asm-x86_64/hw_irq.h  |    1 +
 25-akpm/include/asm-x86_64/msi.h     |    6 +++++-
 25-akpm/include/asm-x86_64/smp.h     |   12 +++++++++++-
 5 files changed, 49 insertions(+), 6 deletions(-)

diff -puN arch/x86_64/kernel/io_apic.c~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64 arch/x86_64/kernel/io_apic.c
--- 25/arch/x86_64/kernel/io_apic.c~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64	2004-09-30 22:58:55.213807328 -0700
+++ 25-akpm/arch/x86_64/kernel/io_apic.c	2004-09-30 22:58:55.224805656 -0700
@@ -731,7 +731,7 @@ void __init setup_IO_APIC_irqs(void)
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = INT_DELIVERY_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -749,7 +749,7 @@ void __init setup_IO_APIC_irqs(void)
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
+			entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -799,7 +799,7 @@ void __init setup_ExtINT_IRQ0_pin(unsign
 	 */
 	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.delivery_mode = dest_LowestPrio;
 	entry.polarity = 0;
 	entry.trigger = 0;
@@ -2039,7 +2039,7 @@ int io_apic_set_pci_routing (int ioapic,
 
 	entry.delivery_mode = dest_LowestPrio;
 	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.trigger = edge_level;
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
@@ -2089,3 +2089,28 @@ void send_IPI_self(int vector)
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
diff -puN arch/x86_64/kernel/smpboot.c~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64 arch/x86_64/kernel/smpboot.c
--- 25/arch/x86_64/kernel/smpboot.c~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64	2004-09-30 22:58:55.214807176 -0700
+++ 25-akpm/arch/x86_64/kernel/smpboot.c	2004-09-30 22:58:55.225805504 -0700
@@ -950,6 +950,9 @@ int __devinit __cpu_up(unsigned int cpu)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+#ifdef CONFIG_X86_IO_APIC
+	setup_ioapic_dest();
+#endif
 	zap_low_mappings();
 }
 
diff -puN include/asm-x86_64/hw_irq.h~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64 include/asm-x86_64/hw_irq.h
--- 25/include/asm-x86_64/hw_irq.h~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64	2004-09-30 22:58:55.216806872 -0700
+++ 25-akpm/include/asm-x86_64/hw_irq.h	2004-09-30 22:58:55.225805504 -0700
@@ -102,6 +102,7 @@ extern void disable_IO_APIC(void);
 extern void print_IO_APIC(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
 extern void send_IPI(int dest, int vector);
+extern void setup_ioapic_dest(void);
 
 extern unsigned long io_apic_irqs;
 
diff -puN include/asm-x86_64/msi.h~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64 include/asm-x86_64/msi.h
--- 25/include/asm-x86_64/msi.h~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64	2004-09-30 22:58:55.217806720 -0700
+++ 25-akpm/include/asm-x86_64/msi.h	2004-09-30 22:58:55.226805352 -0700
@@ -11,6 +11,10 @@
 #define LAST_DEVICE_VECTOR		232
 #define MSI_DEST_MODE			MSI_LOGICAL_MODE
 #define MSI_TARGET_CPU_SHIFT		12
-#define MSI_TARGET_CPU			TARGET_CPUS
+#ifdef CONFIG_SMP
+#define MSI_TARGET_CPU			logical_smp_processor_id()
+#else
+#define MSI_TARGET_CPU			1
+#endif
 
 #endif /* ASM_MSI_H */
diff -puN include/asm-x86_64/smp.h~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64 include/asm-x86_64/smp.h
--- 25/include/asm-x86_64/smp.h~disable-sw-irqbalance-irqaffinity-for-e7520-e7320-e7525-change-target_cpus-on-x86_64	2004-09-30 22:58:55.219806416 -0700
+++ 25-akpm/include/asm-x86_64/smp.h	2004-09-30 22:58:55.226805352 -0700
@@ -74,6 +74,12 @@ extern __inline int hard_smp_processor_i
 	return GET_APIC_ID(*(unsigned int *)(APIC_BASE+APIC_ID));
 }
 
+static __inline int logical_smp_processor_id(void)
+{
+	/* we don't want to mark this access volatile - bad code generation */
+	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
+}
+
 /*
  * Some lowlevel functions might want to know about
  * the real APIC ID <-> CPU # mapping.
@@ -110,9 +116,13 @@ static inline int cpu_present_to_apicid(
 
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
_

