Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVI0DL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVI0DL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 23:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVI0DL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 23:11:59 -0400
Received: from xenotime.net ([66.160.160.81]:8899 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750824AbVI0DL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 23:11:59 -0400
Date: Mon, 26 Sep 2005 20:11:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Cc: gregkh <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@suse.de
Subject: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
Message-Id: <20050926201156.7b9ef031.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

MSI requires local APIC + IO APIC support (according to
drivers/pci/Kconfig), but if a kernel is built with all of
those (APICs + CONFIG_PCI_MSI) and then booted with "nosmp" or
"max_cpus=0|1" or "noapic" or "nolapic", MSI also should be
disabled, otherwise the interrupt routing is bad (so that only
using "irqpoll" helps).

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 arch/i386/kernel/io_apic.c   |    2 ++
 arch/i386/kernel/smpboot.c   |    6 +++++-
 arch/x86_64/kernel/apic.c    |    6 +++++-
 arch/x86_64/kernel/io_apic.c |    2 ++
 arch/x86_64/kernel/setup.c   |    4 +++-
 arch/x86_64/kernel/smpboot.c |   11 +++++++++--
 drivers/pci/msi.c            |    5 +++++
 include/linux/pci.h          |    2 ++
 8 files changed, 33 insertions(+), 5 deletions(-)

diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/arch/i386/kernel/io_apic.c linux-2614-rc2-git4/arch/i386/kernel/io_apic.c
--- linux-2614-rc2-git4-pv/arch/i386/kernel/io_apic.c	2005-09-25 13:18:08.000000000 -0700
+++ linux-2614-rc2-git4/arch/i386/kernel/io_apic.c	2005-09-25 14:54:45.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
 
@@ -684,6 +685,7 @@ int skip_ioapic_setup;
 static int __init ioapic_setup(char *str)
 {
 	skip_ioapic_setup = 1;
+	msi_off();
 	return 1;
 }
 
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/arch/i386/kernel/smpboot.c linux-2614-rc2-git4/arch/i386/kernel/smpboot.c
--- linux-2614-rc2-git4-pv/arch/i386/kernel/smpboot.c	2005-09-25 13:18:08.000000000 -0700
+++ linux-2614-rc2-git4/arch/i386/kernel/smpboot.c	2005-09-25 14:54:51.000000000 -0700
@@ -46,6 +46,7 @@
 #include <linux/bootmem.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/pci.h>
 #include <linux/percpu.h>
 
 #include <linux/delay.h>
@@ -1107,9 +1108,11 @@ static void __init smp_boot_cpus(unsigne
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = physid_mask_of_physid(0);
-		if (APIC_init_uniprocessor())
+		if (APIC_init_uniprocessor()) {
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
+			msi_off();
+		}
 		map_cpu_to_logical_apicid();
 		cpu_set(0, cpu_sibling_map[0]);
 		cpu_set(0, cpu_core_map[0]);
@@ -1150,6 +1153,7 @@ static void __init smp_boot_cpus(unsigne
 		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
+		msi_off();
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		cpu_set(0, cpu_sibling_map[0]);
 		cpu_set(0, cpu_core_map[0]);
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/arch/x86_64/kernel/apic.c linux-2614-rc2-git4/arch/x86_64/kernel/apic.c
--- linux-2614-rc2-git4-pv/arch/x86_64/kernel/apic.c	2005-09-25 13:18:11.000000000 -0700
+++ linux-2614-rc2-git4/arch/x86_64/kernel/apic.c	2005-09-25 14:55:20.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/pci.h>
 #include <linux/sysdev.h>
 
 #include <asm/atomic.h>
@@ -1057,8 +1058,10 @@ int __init APIC_init_uniprocessor (void)
 #ifdef CONFIG_X86_IO_APIC
 	if (smp_found_config && !skip_ioapic_setup && nr_ioapics)
 			setup_IO_APIC();
-	else
+	else {
 		nr_ioapics = 0;
+		msi_off();
+	}
 #endif
 	setup_boot_APIC_clock();
 	check_nmi_watchdog();
@@ -1074,6 +1077,7 @@ static __init int setup_disableapic(char
 static __init int setup_nolapic(char *str) 
 { 
 	disable_apic = 1;
+	msi_off();
 	return 0;
 } 
 
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/arch/x86_64/kernel/io_apic.c linux-2614-rc2-git4/arch/x86_64/kernel/io_apic.c
--- linux-2614-rc2-git4-pv/arch/x86_64/kernel/io_apic.c	2005-09-25 13:18:11.000000000 -0700
+++ linux-2614-rc2-git4/arch/x86_64/kernel/io_apic.c	2005-09-25 14:55:22.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/smp_lock.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include <linux/sysdev.h>
 
 #include <asm/io.h>
@@ -227,6 +228,7 @@ int ioapic_force;
 static int __init disable_ioapic_setup(char *str)
 {
 	skip_ioapic_setup = 1;
+	msi_off();
 	return 1;
 }
 
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/arch/x86_64/kernel/setup.c linux-2614-rc2-git4/arch/x86_64/kernel/setup.c
--- linux-2614-rc2-git4-pv/arch/x86_64/kernel/setup.c	2005-09-25 13:18:11.000000000 -0700
+++ linux-2614-rc2-git4/arch/x86_64/kernel/setup.c	2005-09-25 14:55:27.000000000 -0700
@@ -345,8 +345,10 @@ static __init void parse_cmdline_early (
 		    !memcmp(from, "disableapic", 11))
 			disable_apic = 1;
 
-		if (!memcmp(from, "noapic", 6)) 
+		if (!memcmp(from, "noapic", 6)) {
 			skip_ioapic_setup = 1;
+			msi_off();
+		}
 
 		if (!memcmp(from, "apic", 4)) { 
 			skip_ioapic_setup = 0;
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/arch/x86_64/kernel/smpboot.c linux-2614-rc2-git4/arch/x86_64/kernel/smpboot.c
--- linux-2614-rc2-git4-pv/arch/x86_64/kernel/smpboot.c	2005-09-25 13:18:11.000000000 -0700
+++ linux-2614-rc2-git4/arch/x86_64/kernel/smpboot.c	2005-09-25 14:55:33.000000000 -0700
@@ -47,6 +47,7 @@
 #include <linux/bootmem.h>
 #include <linux/thread_info.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -918,9 +919,11 @@ static int __init smp_sanity_check(unsig
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		disable_smp();
-		if (APIC_init_uniprocessor())
+		if (APIC_init_uniprocessor()) {
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
+			msi_off();
+		}
 		return -1;
 	}
 
@@ -942,6 +945,7 @@ static int __init smp_sanity_check(unsig
 			boot_cpu_id);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		nr_ioapics = 0;
+		msi_off();
 		return -1;
 	}
 
@@ -951,6 +955,7 @@ static int __init smp_sanity_check(unsig
 	if (!max_cpus) {
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		nr_ioapics = 0;
+		msi_off();
 		return -1;
 	}
 
@@ -995,8 +1000,10 @@ void __init smp_prepare_cpus(unsigned in
 	 */
 	if (!skip_ioapic_setup && nr_ioapics)
 		setup_IO_APIC();
-	else
+	else {
 		nr_ioapics = 0;
+		msi_off();
+	}
 
 	/*
 	 * Set up local APIC timer on boot CPU.
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/drivers/pci/msi.c linux-2614-rc2-git4/drivers/pci/msi.c
--- linux-2614-rc2-git4-pv/drivers/pci/msi.c	2005-09-25 13:18:14.000000000 -0700
+++ linux-2614-rc2-git4/drivers/pci/msi.c	2005-09-25 14:53:53.000000000 -0700
@@ -1113,6 +1113,11 @@ void msi_remove_pci_irq_vectors(struct p
 	}
 }
 
+void msi_off(void)
+{
+	pci_msi_enable = 0;
+}
+
 EXPORT_SYMBOL(pci_enable_msi);
 EXPORT_SYMBOL(pci_disable_msi);
 EXPORT_SYMBOL(pci_enable_msix);
diff -Naurp -X linux-2614-rc2/Documentation/dontdiff linux-2614-rc2-git4-pv/include/linux/pci.h linux-2614-rc2-git4/include/linux/pci.h
--- linux-2614-rc2-git4-pv/include/linux/pci.h	2005-09-25 13:18:20.000000000 -0700
+++ linux-2614-rc2-git4/include/linux/pci.h	2005-09-25 14:53:27.000000000 -0700
@@ -480,6 +480,7 @@ static inline int pci_enable_msix(struct
 	struct msix_entry *entries, int nvec) {return -1;}
 static inline void pci_disable_msix(struct pci_dev *dev) {}
 static inline void msi_remove_pci_irq_vectors(struct pci_dev *dev) {}
+static inline void msi_off(void) {}
 #else
 extern void pci_scan_msi_device(struct pci_dev *dev);
 extern int pci_enable_msi(struct pci_dev *dev);
@@ -488,6 +489,7 @@ extern int pci_enable_msix(struct pci_de
 	struct msix_entry *entries, int nvec);
 extern void pci_disable_msix(struct pci_dev *dev);
 extern void msi_remove_pci_irq_vectors(struct pci_dev *dev);
+extern void msi_off(void);
 #endif
 
 /*


---
