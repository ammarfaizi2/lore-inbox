Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937968AbWLGOt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937968AbWLGOt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937967AbWLGOt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:49:57 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3443 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937968AbWLGOt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:49:56 -0500
Date: Thu, 7 Dec 2006 15:49:53 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/5] PCI MMConfig: Share what's shareable.
Message-ID: <20061207144952.GA45089@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 and x86-64 pci mmconfig code have a lot in common.  So share
what's shareable between the two.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
---
 arch/i386/pci/Makefile          |    2 +-
 arch/i386/pci/mmconfig-shared.c |   88 +++++++++++++++++++++++++++++++++++++++
 arch/i386/pci/mmconfig.c        |   70 ++-----------------------------
 arch/x86_64/pci/Makefile        |    3 +-
 arch/x86_64/pci/mmconfig.c      |   64 +++-------------------------
 5 files changed, 102 insertions(+), 125 deletions(-)

diff --git a/arch/i386/pci/Makefile b/arch/i386/pci/Makefile
index 1594d2f..44650e0 100644
--- a/arch/i386/pci/Makefile
+++ b/arch/i386/pci/Makefile
@@ -1,7 +1,7 @@
 obj-y				:= i386.o init.o
 
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
-obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig.o direct.o
+obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig.o direct.o mmconfig-shared.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
 pci-y				:= fixup.o
diff --git a/arch/i386/pci/mmconfig-shared.c b/arch/i386/pci/mmconfig-shared.c
new file mode 100644
index 0000000..4ca3f5a
--- /dev/null
+++ b/arch/i386/pci/mmconfig-shared.c
@@ -0,0 +1,88 @@
+/*
+ * mmconfig-shared.c - Low-level direct PCI config space access via
+ *                     MMCONFIG - common code between i386 and x86-64.
+ * 
+ * This code does:
+ * - ACPI decoding and validation
+ *
+ * Per-architecture code takes care of the mappings and accesses
+ * themselves.
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <asm/e820.h>
+
+#include "pci.h"
+
+/* aperture is up to 256MB but BIOS may reserve less */
+#define MMCONFIG_APER_MIN	(2 * 1024*1024)
+#define MMCONFIG_APER_MAX	(256 * 1024*1024)
+
+/* Verify the first 16 busses. We assume that systems with more busses
+   get MCFG right. */
+#define MAX_CHECK_BUS 16
+
+DECLARE_BITMAP(pci_mmcfg_fallback_slots, 32*MAX_CHECK_BUS);
+
+/* K8 systems have some devices (typically in the builtin northbridge)
+   that are only accessible using type1
+   Normally this can be expressed in the MCFG by not listing them
+   and assigning suitable _SEGs, but this isn't implemented in some BIOS.
+   Instead try to discover all devices on bus 0 that are unreachable using MM
+   and fallback for them. */
+static __init void unreachable_devices(void)
+{
+	int i, k;
+	/* Use the max bus number from ACPI here? */
+	for (k = 0; k < MAX_CHECK_BUS; k++) {
+		for (i = 0; i < 32; i++) {
+			u32 val1, val2;
+
+			pci_conf1_read(0, k, PCI_DEVFN(i,0), 0, 4, &val1);
+			if (val1 == 0xffffffff)
+				continue;
+			
+			raw_pci_ops->read(0, k, PCI_DEVFN(i, 0), 0, 4, &val2);
+			if (val1 != val2) {
+				set_bit(i + 32*k, pci_mmcfg_fallback_slots);
+				printk(KERN_NOTICE "PCI: No mmconfig possible"
+				       " on device %02x:%02x\n", k, i);
+			}
+		}
+	}
+}
+
+void __init pci_mmcfg_init(int type)
+{
+	extern int pci_mmcfg_arch_init(void);
+
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		return;
+
+	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+
+	if ((pci_mmcfg_config_num == 0) ||
+	    (pci_mmcfg_config == NULL) ||
+	    (pci_mmcfg_config[0].base_address == 0))
+		return;
+
+	/* Only do this check when type 1 works. If it doesn't work
+           assume we run on a Mac and always use MCFG */
+	if (type == 1 &&
+	    !e820_all_mapped(pci_mmcfg_config[0].base_address,
+			     pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
+			     E820_RESERVED)) {
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+				pci_mmcfg_config[0].base_address);
+		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
+		return;
+	}
+
+	if (pci_mmcfg_arch_init()) {
+		unreachable_devices();
+		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
+	}
+}
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index c6b6d9b..36e1ba0 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -15,10 +15,6 @@
 #include <asm/e820.h>
 #include "pci.h"
 
-/* aperture is up to 256MB but BIOS may reserve less */
-#define MMCONFIG_APER_MIN	(2 * 1024*1024)
-#define MMCONFIG_APER_MAX	(256 * 1024*1024)
-
 /* Assume systems with more busses have correct MCFG */
 #define MAX_CHECK_BUS 16
 
@@ -27,7 +23,7 @@
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
 
-static DECLARE_BITMAP(fallback_slots, MAX_CHECK_BUS*32);
+extern DECLARE_BITMAP(pci_mmcfg_fallback_slots, MAX_CHECK_BUS*32);
 
 /*
  * Functions for accessing PCI configuration space with MMCONFIG accesses
@@ -38,7 +34,7 @@ static u32 get_base_addr(unsigned int seg, int bus, unsigned devfn)
 	struct acpi_table_mcfg_config *cfg;
 
 	if (seg == 0 && bus < MAX_CHECK_BUS &&
-	    test_bit(PCI_SLOT(devfn) + 32*bus, fallback_slots))
+	    test_bit(PCI_SLOT(devfn) + 32*bus, pci_mmcfg_fallback_slots))
 		return 0;
 
 	while (1) {
@@ -154,67 +150,9 @@ static struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
-/* K8 systems have some devices (typically in the builtin northbridge)
-   that are only accessible using type1
-   Normally this can be expressed in the MCFG by not listing them
-   and assigning suitable _SEGs, but this isn't implemented in some BIOS.
-   Instead try to discover all devices on bus 0 that are unreachable using MM
-   and fallback for them. */
-static __init void unreachable_devices(void)
+int __init pci_mmcfg_arch_init(void)
 {
-	int i, k;
-	unsigned long flags;
-
-	for (k = 0; k < MAX_CHECK_BUS; k++) {
-		for (i = 0; i < 32; i++) {
-			u32 val1;
-			u32 addr;
-
-			pci_conf1_read(0, k, PCI_DEVFN(i, 0), 0, 4, &val1);
-			if (val1 == 0xffffffff)
-				continue;
-
-			/* Locking probably not needed, but safer */
-			spin_lock_irqsave(&pci_config_lock, flags);
-			addr = get_base_addr(0, k, PCI_DEVFN(i, 0));
-			if (addr != 0)
-				pci_exp_set_dev_base(addr, k, PCI_DEVFN(i, 0));
-			if (addr == 0 ||
-			    readl((u32 __iomem *)mmcfg_virt_addr) != val1) {
-				set_bit(i + 32*k, fallback_slots);
-				printk(KERN_NOTICE
-			"PCI: No mmconfig possible on %x:%x\n", k, i);
-			}
-			spin_unlock_irqrestore(&pci_config_lock, flags);
-		}
-	}
-}
-
-void __init pci_mmcfg_init(int type)
-{
-	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-		return;
-
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
-	if ((pci_mmcfg_config_num == 0) ||
-	    (pci_mmcfg_config == NULL) ||
-	    (pci_mmcfg_config[0].base_address == 0))
-		return;
-
-	/* Only do this check when type 1 works. If it doesn't work
-	   assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
-			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
-				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-		return;
-	}
-
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
-	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
-
-	unreachable_devices();
+	return 1;
 }
diff --git a/arch/x86_64/pci/Makefile b/arch/x86_64/pci/Makefile
index 149aba0..c9eddc8 100644
--- a/arch/x86_64/pci/Makefile
+++ b/arch/x86_64/pci/Makefile
@@ -11,7 +11,7 @@ obj-y		+= fixup.o init.o
 obj-$(CONFIG_ACPI)	+= acpi.o
 obj-y			+= legacy.o irq.o common.o early.o
 # mmconfig has a 64bit special
-obj-$(CONFIG_PCI_MMCONFIG) += mmconfig.o direct.o
+obj-$(CONFIG_PCI_MMCONFIG) += mmconfig.o direct.o mmconfig-shared.o
 
 obj-$(CONFIG_NUMA)	+= k8-bus.o
 
@@ -24,3 +24,4 @@ fixup-y  += ../../i386/pci/fixup.o
 i386-y  += ../../i386/pci/i386.o
 init-y += ../../i386/pci/init.o
 early-y += ../../i386/pci/early.o
+mmconfig-shared-y += ../../i386/pci/mmconfig-shared.o
diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index f8b6b28..b270f20 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -21,7 +21,7 @@
    get MCFG right. */
 #define MAX_CHECK_BUS 16
 
-static DECLARE_BITMAP(fallback_slots, 32*MAX_CHECK_BUS);
+extern DECLARE_BITMAP(pci_mmcfg_fallback_slots, 32*MAX_CHECK_BUS);
 
 /* Static virtual mapping of the MMCONFIG aperture */
 struct mmcfg_virt {
@@ -64,7 +64,7 @@ static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned i
 {
 	char __iomem *addr;
 	if (seg == 0 && bus < MAX_CHECK_BUS &&
-		test_bit(32*bus + PCI_SLOT(devfn), fallback_slots))
+		test_bit(32*bus + PCI_SLOT(devfn), pci_mmcfg_fallback_slots))
 		return NULL;
 	addr = get_virt(seg, bus);
 	if (!addr)
@@ -135,63 +135,15 @@ static struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
-/* K8 systems have some devices (typically in the builtin northbridge)
-   that are only accessible using type1
-   Normally this can be expressed in the MCFG by not listing them
-   and assigning suitable _SEGs, but this isn't implemented in some BIOS.
-   Instead try to discover all devices on bus 0 that are unreachable using MM
-   and fallback for them. */
-static __init void unreachable_devices(void)
-{
-	int i, k;
-	/* Use the max bus number from ACPI here? */
-	for (k = 0; k < MAX_CHECK_BUS; k++) {
-		for (i = 0; i < 32; i++) {
-			u32 val1;
-			char __iomem *addr;
-
-			pci_conf1_read(0, k, PCI_DEVFN(i,0), 0, 4, &val1);
-			if (val1 == 0xffffffff)
-				continue;
-			addr = pci_dev_base(0, k, PCI_DEVFN(i, 0));
-			if (addr == NULL|| readl(addr) != val1) {
-				set_bit(i + 32*k, fallback_slots);
-				printk(KERN_NOTICE "PCI: No mmconfig possible"
-				       " on device %02x:%02x\n", k, i);
-			}
-		}
-	}
-}
-
-void __init pci_mmcfg_init(int type)
+int __init pci_mmcfg_arch_init(void)
 {
 	int i;
-
-	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-		return;
-
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
-	if ((pci_mmcfg_config_num == 0) ||
-	    (pci_mmcfg_config == NULL) ||
-	    (pci_mmcfg_config[0].base_address == 0))
-		return;
-
-	/* Only do this check when type 1 works. If it doesn't work
-           assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
-			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
-				pci_mmcfg_config[0].base_address);
-		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
-		return;
-	}
-
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {
 		printk(KERN_ERR "PCI: Can not allocate memory for mmconfig structures\n");
-		return;
+		return 0;
 	}
+
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
 		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
@@ -200,13 +152,11 @@ void __init pci_mmcfg_init(int type)
 			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for "
 					"segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
-			return;
+			return 0;
 		}
 		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
 	}
 
-	unreachable_devices();
-
 	raw_pci_ops = &pci_mmcfg;
-	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
+	return 1;
 }
-- 
1.4.4.1.g278f
