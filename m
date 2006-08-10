Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWHJUeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWHJUeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWHJUOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:42731 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932520AbWHJTgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:16 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [60/145] x86_64: Move early chipset quirks out to new file
Message-Id: <20060810193615.80DCC13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:15 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

They did not really belong into io_apic.c. Move them into a new file
and clean it up a bit.

Also remove outdated ATI quirk that was obsolete,

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/Makefile       |    2 
 arch/x86_64/kernel/early-quirks.c |  118 ++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/io_apic.c      |  101 --------------------------------
 arch/x86_64/kernel/setup.c        |    2 
 include/asm-x86_64/proto.h        |    2 
 5 files changed, 121 insertions(+), 104 deletions(-)

Index: linux/arch/x86_64/kernel/Makefile
===================================================================
--- linux.orig/arch/x86_64/kernel/Makefile
+++ linux/arch/x86_64/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y	:= process.o signal.o entry.o trap
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
-		pci-dma.o pci-nommu.o alternative.o
+		pci-dma.o pci-nommu.o alternative.o early-quirks.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_X86_MCE)         += mce.o
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -280,107 +280,6 @@ static int __init setup_enable_8254_time
 __setup("disable_8254_timer", setup_disable_8254_timer);
 __setup("enable_8254_timer", setup_enable_8254_timer);
 
-#include <asm/pci-direct.h>
-#include <linux/pci_ids.h>
-#include <linux/pci.h>
-
-
-#ifdef CONFIG_ACPI
-
-static int nvidia_hpet_detected __initdata;
-
-static int __init nvidia_hpet_check(unsigned long phys, unsigned long size)
-{
-	nvidia_hpet_detected = 1;
-	return 0;
-}
-#endif
-
-/* Temporary Hack. Nvidia and VIA boards currently only work with IO-APIC
-   off. Check for an Nvidia or VIA PCI bridge and turn it off.
-   Use pci direct infrastructure because this runs before the PCI subsystem. 
-
-   Can be overwritten with "apic"
-
-   And another hack to disable the IOMMU on VIA chipsets.
-
-   ... and others. Really should move this somewhere else.
-
-   Kludge-O-Rama. */
-void __init check_ioapic(void) 
-{ 
-	int num,slot,func; 
-	/* Poor man's PCI discovery */
-	for (num = 0; num < 32; num++) { 
-		for (slot = 0; slot < 32; slot++) { 
-			for (func = 0; func < 8; func++) { 
-				u32 class;
-				u32 vendor;
-				u8 type;
-				class = read_pci_config(num,slot,func,
-							PCI_CLASS_REVISION);
-				if (class == 0xffffffff)
-					break; 
-
-		       		if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
-					continue; 
-
-				vendor = read_pci_config(num, slot, func, 
-							 PCI_VENDOR_ID);
-				vendor &= 0xffff;
-				switch (vendor) { 
-				case PCI_VENDOR_ID_VIA:
-#ifdef CONFIG_IOMMU
-					if ((end_pfn > MAX_DMA32_PFN ||
-					     force_iommu) &&
-					    !iommu_aperture_allowed) {
-						printk(KERN_INFO
-    "Looks like a VIA chipset. Disabling IOMMU. Override with \"iommu=allowed\"\n");
-						iommu_aperture_disabled = 1;
-					}
-#endif
-					return;
-				case PCI_VENDOR_ID_NVIDIA:
-#ifdef CONFIG_ACPI
-					/*
-					 * All timer overrides on Nvidia are
-					 * wrong unless HPET is enabled.
-					 */
-					nvidia_hpet_detected = 0;
-					acpi_table_parse(ACPI_HPET,
-							nvidia_hpet_check);
-					if (nvidia_hpet_detected == 0) {
-						acpi_skip_timer_override = 1;
-						printk(KERN_INFO "Nvidia board "
-						    "detected. Ignoring ACPI "
-						    "timer override.\n");
-					}
-#endif
-					/* RED-PEN skip them on mptables too? */
-					return;
-
-				/* This should be actually default, but
-				   for 2.6.16 let's do it for ATI only where
-				   it's really needed. */
-				case PCI_VENDOR_ID_ATI:
-					if (timer_over_8254 == 1) {	
-						timer_over_8254 = 0;	
-					printk(KERN_INFO
-		"ATI board detected. Disabling timer routing over 8254.\n");
-					}	
-					return;
-				} 
-
-
-				/* No multi-function device? */
-				type = read_pci_config_byte(num,slot,func,
-							    PCI_HEADER_TYPE);
-				if (!(type & 0x80))
-					break;
-			} 
-		}
-	}
-} 
 
 /*
  * Find the IRQ entry number of a certain pin.
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -655,7 +655,7 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
-	check_ioapic();
+	early_quirks();
 
 	/*
 	 * set this early, so we dont allocate cpu0
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -92,7 +92,7 @@ extern void syscall32_cpu_init(void);
 
 extern void setup_node_bootmem(int nodeid, unsigned long start, unsigned long end);
 
-extern void check_ioapic(void);
+extern void early_quirks(void);
 extern void check_efer(void);
 
 extern int unhandled_signal(struct task_struct *tsk, int sig);
Index: linux/arch/x86_64/kernel/early-quirks.c
===================================================================
--- /dev/null
+++ linux/arch/x86_64/kernel/early-quirks.c
@@ -0,0 +1,118 @@
+/* Various workarounds for chipset bugs.
+   This code runs very early and can't use the regular PCI subsystem
+   The entries are keyed to PCI bridges which usually identify chipsets
+   uniquely.
+   This is only for whole classes of chipsets with specific problems which
+   need early invasive action (e.g. before the timers are initialized).
+   Most PCI device specific workarounds can be done later and should be
+   in standard PCI quirks
+   Mainboard specific bugs should be handled by DMI entries.
+   CPU specific bugs in setup.c */
+
+#include <linux/pci.h>
+#include <linux/acpi.h>
+#include <linux/pci_ids.h>
+#include <asm/pci-direct.h>
+#include <asm/proto.h>
+#include <asm/dma.h>
+
+static void via_bugs(void)
+{
+#ifdef CONFIG_IOMMU
+	if ((end_pfn > MAX_DMA32_PFN ||  force_iommu) &&
+	    !iommu_aperture_allowed) {
+		printk(KERN_INFO
+  "Looks like a VIA chipset. Disabling IOMMU. Override with iommu=allowed\n");
+		iommu_aperture_disabled = 1;
+	}
+#endif
+}
+
+#ifdef CONFIG_ACPI
+
+static int nvidia_hpet_detected __initdata;
+
+static int __init nvidia_hpet_check(unsigned long phys, unsigned long size)
+{
+	nvidia_hpet_detected = 1;
+	return 0;
+}
+#endif
+
+static void nvidia_bugs(void)
+{
+#ifdef CONFIG_ACPI
+	/*
+	 * All timer overrides on Nvidia are
+	 * wrong unless HPET is enabled.
+	 */
+	nvidia_hpet_detected = 0;
+	acpi_table_parse(ACPI_HPET, nvidia_hpet_check);
+	if (nvidia_hpet_detected == 0) {
+		acpi_skip_timer_override = 1;
+		printk(KERN_INFO "Nvidia board "
+		       "detected. Ignoring ACPI "
+		       "timer override.\n");
+	}
+#endif
+	/* RED-PEN skip them on mptables too? */
+
+}
+
+static void ati_bugs(void)
+{
+#if 1 /* for testing */
+	printk("ATI board detected\n");
+#endif
+	/* No bugs right now */
+}
+
+struct chipset {
+	u16 vendor;
+	void (*f)(void);
+};
+
+static struct chipset early_qrk[] = {
+	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
+	{ PCI_VENDOR_ID_VIA, via_bugs },
+	{ PCI_VENDOR_ID_ATI, ati_bugs },
+	{}
+};
+
+void __init early_quirks(void)
+{
+	int num, slot, func;
+	/* Poor man's PCI discovery */
+	for (num = 0; num < 32; num++) {
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				u32 class;
+				u32 vendor;
+				u8 type;
+				int i;
+				class = read_pci_config(num,slot,func,
+							PCI_CLASS_REVISION);
+				if (class == 0xffffffff)
+					break;
+
+		       		if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
+					continue;
+
+				vendor = read_pci_config(num, slot, func,
+							 PCI_VENDOR_ID);
+				vendor &= 0xffff;
+
+				for (i = 0; early_qrk[i].f; i++)
+					if (early_qrk[i].vendor == vendor) {
+						early_qrk[i].f();
+						return;
+					}
+
+				type = read_pci_config_byte(num, slot, func,
+							    PCI_HEADER_TYPE);
+				if (!(type & 0x80))
+					break;
+			}
+		}
+	}
+}
