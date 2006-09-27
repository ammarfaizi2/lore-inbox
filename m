Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030775AbWI0Ucs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030775AbWI0Ucs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030779AbWI0Ucs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:32:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36588 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030775AbWI0Ucr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:32:47 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/5] htirq: Tidy up the htirq code
Date: Wed, 27 Sep 2006 14:31:26 -0600
Message-Id: <11593890882551-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <<m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
References: <<m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the declarations for the architecture helpers into
include/linux/htirq.h from the generic include/linux/pci.h.
Hopefully this will make this distinction clearer.

htirq.h is included where it is needed.

The dependency on the msi code is fixed and removed.

The Makefile is tidied up.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/io_apic.c   |    5 ++---
 arch/x86_64/kernel/io_apic.c |    1 +
 drivers/pci/Kconfig          |    1 -
 drivers/pci/Makefile         |    4 +++-
 drivers/pci/htirq.c          |    1 +
 include/linux/htirq.h        |   15 +++++++++++++++
 include/linux/pci.h          |   11 -----------
 7 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index 5a12527..b7287fb 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -33,6 +33,7 @@ #include <linux/module.h>
 #include <linux/sysdev.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/htirq.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -2409,9 +2410,8 @@ static int __init ioapic_init_sysfs(void
 
 device_initcall(ioapic_init_sysfs);
 
-#ifdef CONFIG_PCI_MSI
 /*
- * Dynamic irq allocate and deallocation for MSI
+ * Dynamic irq allocate and deallocation
  */
 int create_irq(void)
 {
@@ -2450,7 +2450,6 @@ void destroy_irq(unsigned int irq)
 	irq_vector[irq] = 0;
 	spin_unlock_irqrestore(&vector_lock, flags);
 }
-#endif /* CONFIG_PCI_MSI */
 
 /*
  * MSI mesage composition
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index e55028f..91728d9 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -31,6 +31,7 @@ #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
 #include <linux/sysdev.h>
 #include <linux/msi.h>
+#include <linux/htirq.h>
 #ifdef CONFIG_ACPI
 #include <acpi/acpi_bus.h>
 #endif
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0af6d72..3029412 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -55,7 +55,6 @@ config PCI_DEBUG
 config HT_IRQ
 	bool "Interrupts on hypertransport devices"
 	default y
-	depends on PCI_MSI
 	depends on X86_LOCAL_APIC && X86_IO_APIC
 	help
 	   This allows native hypertransport devices to use interrupts.
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 04694ec..e3beb78 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -17,6 +17,9 @@ obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 # Build the PCI MSI interrupt support
 obj-$(CONFIG_PCI_MSI) += msi.o
 
+# Build the Hypertransport interrupt support
+obj-$(CONFIG_HT_IRQ) += htirq.o
+
 #
 # Some architectures use the generic PCI setup functions
 #
@@ -29,7 +32,6 @@ obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-obj-$(CONFIG_HT_IRQ) += htirq.o
 
 #
 # ACPI Related PCI FW Functions
diff --git a/drivers/pci/htirq.c b/drivers/pci/htirq.c
index 4ba4635..0e27f24 100644
--- a/drivers/pci/htirq.c
+++ b/drivers/pci/htirq.c
@@ -11,6 +11,7 @@ #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/gfp.h>
+#include <linux/htirq.h>
 
 /* Global ht irq lock.
  *
diff --git a/include/linux/htirq.h b/include/linux/htirq.h
new file mode 100644
index 0000000..1f15ce2
--- /dev/null
+++ b/include/linux/htirq.h
@@ -0,0 +1,15 @@
+#ifndef LINUX_HTIRQ_H
+#define LINUX_HTIRQ_H
+
+/* Helper functions.. */
+void write_ht_irq_low(unsigned int irq, u32 data);
+void write_ht_irq_high(unsigned int irq, u32 data);
+u32  read_ht_irq_low(unsigned int irq);
+u32  read_ht_irq_high(unsigned int irq);
+void mask_ht_irq(unsigned int irq);
+void unmask_ht_irq(unsigned int irq);
+
+/* The arch hook for getting things started */
+int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev);
+
+#endif /* LINUX_HTIRQ_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9fa0740..5bc4659 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -619,20 +619,9 @@ extern void msi_remove_pci_irq_vectors(s
 #endif
 
 #ifdef CONFIG_HT_IRQ
-/* Helper functions.. */
-void write_ht_irq_low(unsigned int irq, u32 data);
-void write_ht_irq_high(unsigned int irq, u32 data);
-u32  read_ht_irq_low(unsigned int irq);
-u32  read_ht_irq_high(unsigned int irq);
-void mask_ht_irq(unsigned int irq);
-void unmask_ht_irq(unsigned int irq);
-
 /* The functions a driver should call */
 int  ht_create_irq(struct pci_dev *dev, int idx);
 void ht_destroy_irq(unsigned int irq);
-
-/* The arch hook for getting things started */
-int arch_setup_ht_irq(unsigned int irq, struct pci_dev *dev);
 #endif /* CONFIG_HT_IRQ */
 
 extern void pci_block_user_cfg_access(struct pci_dev *dev);
-- 
1.4.2.rc3.g7e18e-dirty

