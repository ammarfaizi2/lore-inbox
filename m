Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269663AbUJABdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269663AbUJABdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269664AbUJABdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:33:22 -0400
Received: from fmr04.intel.com ([143.183.121.6]:36234 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S269663AbUJABdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:33:14 -0400
Date: Thu, 30 Sep 2004 18:32:35 -0700
From: Suresh Siddha <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>, akpm@osdl.org
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [Patch 1/2] Disable SW irqbalance/irqaffinity for E7520/E7320/E7525 - change TARGET_CPUS on x86_64
Message-ID: <20040930183235.F29549@unix-os.sc.intel.com>
References: <2HSdY-7dr-3@gated-at.bofh.it> <m3mzzf99vz.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3mzzf99vz.fsf@averell.firstfloor.org>; from ak@muc.de on Fri, Sep 24, 2004 at 01:36:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:36:16PM +0200, Andi Kleen wrote:
> Suresh Siddha <suresh.b.siddha@intel.com> writes:
> 
> > Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
> > with x86 mach-default
> 
> And breaks compilation with MSI on.

Here is a new patch. Andrew Please apply.

thanks,
suresh
--

Set TARGET_CPUS on x86_64 to cpu_online_map. This brings the code inline
with x86 mach-default. Fix MSI_TARGET_CPU code which will break with this 
target_cpus change.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


diff -Nru linux-2.6.9-rc3/arch/x86_64/kernel/io_apic.c linux/arch/x86_64/kernel/io_apic.c
--- linux-2.6.9-rc3/arch/x86_64/kernel/io_apic.c	2004-09-29 20:04:46.000000000 -0700
+++ linux/arch/x86_64/kernel/io_apic.c	2004-09-10 15:34:54.000000000 -0700
@@ -735,7 +735,7 @@
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = INT_DELIVERY_MODE;
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = TARGET_CPUS;
+		entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -753,7 +753,7 @@
 		if (irq_trigger(idx)) {
 			entry.trigger = 1;
 			entry.mask = 1;
-			entry.dest.logical.logical_dest = TARGET_CPUS;
+			entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 		}
 
 		irq = pin_2_irq(idx, apic, pin);
@@ -803,7 +803,7 @@
 	 */
 	entry.dest_mode = INT_DELIVERY_MODE;
 	entry.mask = 0;					/* unmask IRQ now */
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.delivery_mode = dest_LowestPrio;
 	entry.polarity = 0;
 	entry.trigger = 0;
@@ -2011,7 +2011,7 @@
 
 	entry.delivery_mode = dest_LowestPrio;
 	entry.dest_mode = INT_DELIVERY_MODE;
-	entry.dest.logical.logical_dest = TARGET_CPUS;
+	entry.dest.logical.logical_dest = cpu_mask_to_apicid(TARGET_CPUS);
 	entry.trigger = edge_level;
 	entry.polarity = active_high_low;
 	entry.mask = 1;					 /* Disabled (masked) */
@@ -2069,3 +2069,28 @@
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
diff -Nru linux-2.6.9-rc3/arch/x86_64/kernel/smpboot.c linux/arch/x86_64/kernel/smpboot.c
--- linux-2.6.9-rc3/arch/x86_64/kernel/smpboot.c	2004-09-29 20:06:04.000000000 -0700
+++ linux/arch/x86_64/kernel/smpboot.c	2004-09-10 15:34:54.000000000 -0700
@@ -950,6 +950,9 @@
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+#ifdef CONFIG_X86_IO_APIC
+	setup_ioapic_dest();
+#endif
 	zap_low_mappings();
 }
 
diff -Nru linux-2.6.9-rc3/include/asm-x86_64/hw_irq.h linux/include/asm-x86_64/hw_irq.h
--- linux-2.6.9-rc3/include/asm-x86_64/hw_irq.h	2004-09-29 20:05:52.000000000 -0700
+++ linux/include/asm-x86_64/hw_irq.h	2004-09-10 15:34:54.000000000 -0700
@@ -101,6 +101,7 @@
 extern void print_IO_APIC(void);
 extern int IO_APIC_get_PCI_irq_vector(int bus, int slot, int fn);
 extern void send_IPI(int dest, int vector);
+extern void setup_ioapic_dest(void);
 
 extern unsigned long io_apic_irqs;
 
diff -Nru linux-2.6.9-rc3/include/asm-x86_64/msi.h linux/include/asm-x86_64/msi.h
--- linux-2.6.9-rc3/include/asm-x86_64/msi.h	2004-09-29 20:05:26.000000000 -0700
+++ linux/include/asm-x86_64/msi.h	2004-09-10 21:32:14.049837568 -0700
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
diff -Nru linux-2.6.9-rc3/include/asm-x86_64/smp.h linux/include/asm-x86_64/smp.h
--- linux-2.6.9-rc3/include/asm-x86_64/smp.h	2004-09-29 20:03:44.000000000 -0700
+++ linux/include/asm-x86_64/smp.h	2004-09-10 19:39:01.383479816 -0700
@@ -74,6 +74,12 @@
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
@@ -110,9 +116,13 @@
 
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


