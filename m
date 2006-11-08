Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753882AbWKHCJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbWKHCJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbWKHCJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:09:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:46409 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1753882AbWKHCJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:09:07 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,398,1157353200"; 
   d="scan'208"; a="157811206:sNHT26974983"
Date: Tue, 7 Nov 2006 17:46:43 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: ak@suse.de, akpm@osdl.org
Cc: shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com
Subject: [patch 4/4] fix the irqbalance quirk for E7320/E7520/E7525
Message-ID: <20061107174643.D5401@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com> <20061107173624.A5401@unix-os.sc.intel.com> <20061107174024.B5401@unix-os.sc.intel.com> <20061107174315.C5401@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107174315.C5401@unix-os.sc.intel.com>; from suresh.b.siddha@intel.com on Tue, Nov 07, 2006 at 05:43:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the irqbalance quirks for E7320/E7520/E7525(Errata 23 in
http://download.intel.com/design/chipsets/specupdt/30304203.pdf) to early
quirks.

And add a PCI quirk for these platforms to check(which happens very late
during the boot) if the APIC routing is indeed set to default flat mode.

This fixes the breakage(in x86_64) of this quirk due to cpu hotplug which
selects physical mode instead of the logical flat(as needed for this errata
workaround).

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/arch/i386/kernel/acpi/earlyquirk.c b/arch/i386/kernel/acpi/earlyquirk.c
index fe799b1..4cdec39 100644
--- a/arch/i386/kernel/acpi/earlyquirk.c
+++ b/arch/i386/kernel/acpi/earlyquirk.c
@@ -10,6 +10,7 @@ #include <linux/acpi.h>
 #include <asm/pci-direct.h>
 #include <asm/acpi.h>
 #include <asm/apic.h>
+#include <asm/irq.h>
 
 #ifdef CONFIG_ACPI
 
@@ -43,6 +44,24 @@ #endif
 	return 0;
 }
 
+static void check_intel(void)
+{
+	u16 vendor, device;
+
+	vendor = read_pci_config_16(0, 0, 0, PCI_VENDOR_ID);
+
+	if (vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	device = read_pci_config_16(0, 0, 0, PCI_DEVICE_ID);
+#ifdef CONFIG_SMP
+	if (device == PCI_DEVICE_ID_INTEL_E7320_MCH ||
+	    device == PCI_DEVICE_ID_INTEL_E7520_MCH ||
+	    device == PCI_DEVICE_ID_INTEL_E7525_MCH)
+		quirk_intel_irqbalance();
+#endif
+}
+
 void __init check_acpi_pci(void)
 {
 	int num, slot, func;
@@ -54,6 +73,8 @@ void __init check_acpi_pci(void)
 	if (!early_pci_allowed())
 		return;
 
+	check_intel();
+
 	/* Poor man's PCI discovery */
 	for (num = 0; num < 32; num++) {
 		for (slot = 0; slot < 32; slot++) {
diff --git a/arch/i386/kernel/quirks.c b/arch/i386/kernel/quirks.c
index 9f6ab17..fd8c68c 100644
--- a/arch/i386/kernel/quirks.c
+++ b/arch/i386/kernel/quirks.c
@@ -3,10 +3,28 @@
  */
 #include <linux/pci.h>
 #include <linux/irq.h>
+#include <asm/pci-direct.h>
+#include <asm/genapic.h>
+#include <asm/cpu.h>
 
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
+static void __devinit verify_quirk_intel_irqbalance(struct pci_dev *dev)
+{
+#ifdef CONFIG_X86_64
+	if (genapic !=  &apic_flat) {
+		printk(KERN_WARNING "APIC mode must be flat on this system\n");
+		BUG();
+	}
+#else
+	if (genapic != &apic_default) {
+		printk(KERN_WARNING
+		       "APIC mode must be default(flat) on this system. Use apic=default\n");
+		BUG();
+	}
+#endif
+}
 
-static void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
+void __init quirk_intel_irqbalance(void)
 {
 	u8 config, rev;
 	u32 word;
@@ -16,18 +34,18 @@ static void __devinit quirk_intel_irqbal
 	 * based platforms.
 	 * Disable SW irqbalance/affinity on those platforms.
 	 */
-	pci_read_config_byte(dev, PCI_CLASS_REVISION, &rev);
+	rev = read_pci_config_byte(0, 0, 0, PCI_CLASS_REVISION);
 	if (rev > 0x9)
 		return;
 
 	printk(KERN_INFO "Intel E7520/7320/7525 detected.");
 
-	/* enable access to config space*/
-	pci_read_config_byte(dev, 0xf4, &config);
-	pci_write_config_byte(dev, 0xf4, config|0x2);
+	/* enable access to config space */
+	config = read_pci_config_byte(0, 0, 0, 0xf4);
+	write_pci_config_byte(0, 0, 0, 0xf4, config|0x2);
 
 	/* read xTPR register */
-	raw_pci_ops->read(0, 0, 0x40, 0x4c, 2, &word);
+	word = read_pci_config_16(0, 0, 0x40, 0x4c);
 
 	if (!(word & (1 << 13))) {
 		printk(KERN_INFO "Disabling irq balancing and affinity\n");
@@ -38,13 +56,24 @@ #endif
 #ifdef CONFIG_PROC_FS
 		no_irq_affinity = 1;
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+		printk(KERN_INFO "Disabling cpu hotplug control\n");
+		cpu_hotplug_no_control = 1;
+#endif
+#ifdef CONFIG_X86_64
+		/* force the genapic selection to flat mode so that
+		 * interrupts can be redirected to more than one CPU.
+		 */
+		genapic_force = &apic_flat;
+#endif
 	}
 
-	/* put back the original value for config space*/
+	/* put back the original value for config space */
 	if (!(config & 0x2))
-		pci_write_config_byte(dev, 0xf4, config);
+		write_pci_config_byte(0, 0, 0, 0xf4, config);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_intel_irqbalance);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_intel_irqbalance);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_E7320_MCH,  verify_quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_E7525_MCH,  verify_quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_E7520_MCH,  verify_quirk_intel_irqbalance);
+
 #endif
diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index 4bb8b77..79bc607 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -52,6 +52,7 @@ #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
 #include <asm/nmi.h>
+#include <asm/genapic.h>
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
@@ -1461,6 +1462,13 @@ #endif
 	cpu_set(cpu, smp_commenced_mask);
 	while (!cpu_isset(cpu, cpu_online_map))
 		cpu_relax();
+
+	if (num_online_cpus() > 8 && genapic == &apic_default) {
+		printk(KERN_WARNING
+		       "Default flat APIC routing can't be used with > 8 cpus\n");
+		BUG();
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86_64/kernel/early-quirks.c b/arch/x86_64/kernel/early-quirks.c
index 2b1245d..a644663 100644
--- a/arch/x86_64/kernel/early-quirks.c
+++ b/arch/x86_64/kernel/early-quirks.c
@@ -68,6 +68,18 @@ static void ati_bugs(void)
 	}
 }
 
+static void intel_bugs(void)
+{
+	u16 device = read_pci_config_16(0, 0, 0, PCI_DEVICE_ID);
+
+#ifdef CONFIG_SMP
+	if (device == PCI_DEVICE_ID_INTEL_E7320_MCH ||
+	    device == PCI_DEVICE_ID_INTEL_E7520_MCH ||
+	    device == PCI_DEVICE_ID_INTEL_E7525_MCH)
+		quirk_intel_irqbalance();
+#endif
+}
+
 struct chipset {
 	u16 vendor;
 	void (*f)(void);
@@ -77,6 +89,7 @@ static struct chipset early_qrk[] = {
 	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
 	{ PCI_VENDOR_ID_VIA, via_bugs },
 	{ PCI_VENDOR_ID_ATI, ati_bugs },
+	{ PCI_VENDOR_ID_INTEL, intel_bugs},
 	{}
 };
 
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index 62c2e74..4c161c2 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -60,6 +60,7 @@ #include <asm/nmi.h>
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/numa.h>
+#include <asm/genapic.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -1167,6 +1168,13 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	while (!cpu_isset(cpu, cpu_online_map))
 		cpu_relax();
+
+	if (num_online_cpus() > 8 && genapic == &apic_flat) {
+		printk(KERN_WARNING
+		       "flat APIC routing can't be used with > 8 cpus\n");
+		BUG();
+	}
+
 	err = 0;
 
 	return err;
diff --git a/include/asm-i386/genapic.h b/include/asm-i386/genapic.h
index 8ffbb0f..fd2be59 100644
--- a/include/asm-i386/genapic.h
+++ b/include/asm-i386/genapic.h
@@ -122,6 +122,6 @@ #define APIC_INIT(aname, aprobe) { \
 	APICFUNC(phys_pkg_id) \
 	}
 
-extern struct genapic *genapic;
+extern struct genapic *genapic, apic_default;
 
 #endif
diff --git a/include/asm-i386/irq.h b/include/asm-i386/irq.h
index 331726b..c35dc8e 100644
--- a/include/asm-i386/irq.h
+++ b/include/asm-i386/irq.h
@@ -37,6 +37,8 @@ #ifdef CONFIG_IRQBALANCE
 extern int irqbalance_disable(char *str);
 #endif
 
+extern void quirk_intel_irqbalance(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void fixup_irqs(cpumask_t map);
 #endif
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index e72cfcd..3b6a4ec 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -88,6 +88,7 @@ extern void syscall32_cpu_init(void);
 extern void setup_node_bootmem(int nodeid, unsigned long start, unsigned long end);
 
 extern void early_quirks(void);
+extern void quirk_intel_irqbalance(void);
 extern void check_efer(void);
 
 extern int unhandled_signal(struct task_struct *tsk, int sig);
