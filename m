Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVECGnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVECGnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 02:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVECGnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 02:43:51 -0400
Received: from fmr21.intel.com ([143.183.121.13]:5263 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261403AbVECGnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 02:43:42 -0400
Date: Mon, 2 May 2005 23:41:41 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, zwane@arm.linux.org.uk,
       bunk@stusta.de
Subject: Handling delayed write to /proc/irq fix4_rc3_mm2
Message-ID: <20050502234141.A10952@unix-os.sc.intel.com>
References: <200505022355.j42NtVgr028787@shell0.pdx.osdl.net> <20050503004940.GS3592@stusta.de> <20050502181020.5d4f18ee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050502181020.5d4f18ee.akpm@osdl.org>; from akpm@osdl.org on Mon, May 02, 2005 at 06:10:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

the following fixes are for the errors in the earlier patch pointed out by
Adraian and Zwane.

- Fixed header file when CONFIG_GENERIC_PENDING_IRQ is not defined.
- Extended cleanup to current code by Zwane for set_ioapic_affinit_irq
  done in i386 to x86_64 as well.

This applies on top of current rc3-mm2 patch list.


--

Signed-off-by: Ashok Raj <ashok.raj@intel.com>


- Extend zwane's fixes for set_ioapic_affinity to x86_64 as well.
- Put correct fix requested by Adrian, for include/linux/irq.h when
  CONFIG_GENERIC_PENDING_IRQ is not defined.
---

 linux-2.6.12-rc3-mm2-root/arch/x86_64/kernel/io_apic.c |   15 +++++----
 linux-2.6.12-rc3-mm2-root/include/linux/irq.h          |   27 ++++++++++++++---
 linux-2.6.12-rc3-mm2-root/kernel/irq/manage.c          |    6 ---
 3 files changed, 33 insertions(+), 15 deletions(-)

diff -puN arch/x86_64/kernel/io_apic.c~fix_rc3_mm2_deferred_irq_write arch/x86_64/kernel/io_apic.c
--- linux-2.6.12-rc3-mm2/arch/x86_64/kernel/io_apic.c~fix_rc3_mm2_deferred_irq_write	2005-05-02 21:55:36.000000000 -0700
+++ linux-2.6.12-rc3-mm2-root/arch/x86_64/kernel/io_apic.c	2005-05-02 21:58:53.000000000 -0700
@@ -121,11 +121,6 @@ static void set_ioapic_affinity_irq(unsi
 	set_irq_info(irq, mask);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
-#else
-static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t mask)
-{
-	return;
-}
 #endif
 
 /*
@@ -1425,6 +1420,7 @@ static void unmask_IO_APIC_vector (unsig
 	unmask_IO_APIC_irq(irq);
 }
 
+#ifdef CONFIG_SMP
 static void set_ioapic_affinity_vector (unsigned int vector,
 					cpumask_t cpu_mask)
 {
@@ -1433,7 +1429,8 @@ static void set_ioapic_affinity_vector (
 	set_native_irq_info(vector, cpu_mask);
 	set_ioapic_affinity_irq(irq, cpu_mask);
 }
-#endif
+#endif // CONFIG_SMP
+#endif // CONFIG_PCI_MSI
 
 /*
  * Level and edge triggered IO-APIC interrupts need different handling,
@@ -1452,7 +1449,9 @@ static struct hw_interrupt_type ioapic_e
 	.disable 	= disable_edge_ioapic,
 	.ack 		= ack_edge_ioapic,
 	.end 		= end_edge_ioapic,
+#ifdef CONFIG_SMP
 	.set_affinity = set_ioapic_affinity,
+#endif
 };
 
 static struct hw_interrupt_type ioapic_level_type = {
@@ -1463,7 +1462,9 @@ static struct hw_interrupt_type ioapic_l
 	.disable 	= disable_level_ioapic,
 	.ack 		= mask_and_ack_level_ioapic,
 	.end 		= end_level_ioapic,
+#ifdef CONFIG_SMP
 	.set_affinity = set_ioapic_affinity,
+#endif
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -2015,6 +2016,7 @@ int io_apic_set_pci_routing (int ioapic,
  * we need to reprogram the ioredtbls to cater for the cpus which have come online
  * so mask in all cases should simply be TARGET_CPUS
  */
+#ifdef CONFIG_SMP
 void __init setup_ioapic_dest(void)
 {
 	int pin, ioapic, irq, irq_entry;
@@ -2033,3 +2035,4 @@ void __init setup_ioapic_dest(void)
 
 	}
 }
+#endif
diff -puN include/linux/irq.h~fix_rc3_mm2_deferred_irq_write include/linux/irq.h
--- linux-2.6.12-rc3-mm2/include/linux/irq.h~fix_rc3_mm2_deferred_irq_write	2005-05-02 22:02:18.000000000 -0700
+++ linux-2.6.12-rc3-mm2-root/include/linux/irq.h	2005-05-02 22:12:18.000000000 -0700
@@ -97,9 +97,13 @@ static inline void set_native_irq_info(i
 }
 #endif
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#ifdef CONFIG_SMP
+
+#if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
 extern cpumask_t pending_irq_cpumask[NR_IRQS];
+#endif
 
+#ifdef CONFIG_GENERIC_PENDING_IRQ
 static inline void
 move_native_irq(int irq)
 {
@@ -147,7 +151,9 @@ static inline void move_irq(int irq)
 static inline void set_irq_info(int irq, cpumask_t mask)
 {
 }
-#else
+
+#else // CONFIG_PCI_MSI
+
 static inline void move_irq(int irq)
 {
 	move_native_irq(irq);
@@ -158,12 +164,25 @@ static inline void set_irq_info(int irq,
 	set_native_irq_info(irq, mask);
 }
 #endif // CONFIG_PCI_MSI
-#else
+
+#else	// CONFIG_GENERIC_PENDING_IRQ
+
 #define move_irq(x)
 #define move_native_irq(x)
-extern void set_irq_info(unsigned int irq, cpumask_t mask);
+static inline void set_irq_info(int irq, cpumask_t mask)
+{
+	set_native_irq_info(irq, mask);
+}
+
 #endif // CONFIG_GENERIC_PENDING_IRQ
 
+#else // CONFIG_SMP
+
+#define move_irq(x)
+#define move_native_irq(x)
+
+#endif // CONFIG_SMP
+
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
diff -puN kernel/irq/manage.c~fix_rc3_mm2_deferred_irq_write kernel/irq/manage.c
--- linux-2.6.12-rc3-mm2/kernel/irq/manage.c~fix_rc3_mm2_deferred_irq_write	2005-05-02 22:17:19.000000000 -0700
+++ linux-2.6.12-rc3-mm2-root/kernel/irq/manage.c	2005-05-02 22:18:19.000000000 -0700
@@ -17,7 +17,7 @@
 
 cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
+#if defined (CONFIG_GENERIC_PENDING_IRQ) || defined (CONFIG_IRQBALANCE)
 cpumask_t __cacheline_aligned pending_irq_cpumask[NR_IRQS];
 #endif
 
@@ -40,10 +40,6 @@ void synchronize_irq(unsigned int irq)
 
 EXPORT_SYMBOL(synchronize_irq);
 
-#else
-void set_irq_info(unsigned int irq, cpumask_t mask)
-{
-}
 #endif
 
 /**
_
