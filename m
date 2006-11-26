Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935382AbWKZNPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935382AbWKZNPi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 08:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935385AbWKZNPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 08:15:38 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:27396 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S935382AbWKZNPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 08:15:36 -0500
Date: Sun, 26 Nov 2006 14:15:32 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061126131532.GA41703@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252034.34378.ak@suse.de> <20061125205152.GA18964@dspnet.fr.eu.org> <200611252159.59414.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611252159.59414.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here you go, what about that?  I'll be able to test it on i386 on
monday, not before.  It's hard to doa full 32bits install remotely :-)

  OG.

>From 9703313602daaac65e41210444b2ce20b6e340b6 Mon Sep 17 00:00:00 2001
From: Olivier Galibert <galibert@pobox.com>
Date: Sun, 26 Nov 2006 14:10:09 +0100
Subject: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL

It seems that the only way to reliably support mmconfig in the
presence of funky biosen is to detect the hostbridge and read where
the window is mapped from its registers.  Do that for the E7520 and
the 945G/GZ/P/PL for a start.
---
 arch/i386/pci/Makefile          |    2 
 arch/i386/pci/mmconfig-shared.c |  199 +++++++++++++++++++++++++++++++++++++++
 arch/i386/pci/mmconfig.c        |   71 +-------------
 arch/x86_64/pci/Makefile        |    3 -
 arch/x86_64/pci/mmconfig.c      |   73 ++------------
 5 files changed, 216 insertions(+), 132 deletions(-)

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
index 0000000..4906741
--- /dev/null
+++ b/arch/i386/pci/mmconfig-shared.c
@@ -0,0 +1,199 @@
+/*
+ * mmconfig-shared.c - Low-level direct PCI config space access via
+ *                     MMCONFIG - common code between i386 and x86-64.
+ * 
+ * This code does:
+ * - known chipset handling
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
+static __init const char *pci_mmcfg_e7520(void)
+{
+	u32 win;
+	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0xce, 2, &win);
+
+	pci_mmcfg_config_num = 1;
+	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
+	pci_mmcfg_config[0].base_address = (win & 0xf000) << 16;
+	pci_mmcfg_config[0].pci_segment_group_number = 0;
+	pci_mmcfg_config[0].start_bus_number = 0;
+	pci_mmcfg_config[0].end_bus_number = 255;
+
+	return "Intel Corporation E7520 Memory Controller Hub";
+}
+
+static __init const char *pci_mmcfg_intel_945(void)
+{
+	u32 pciexbar, mask = 0, len = 0;
+
+	pci_mmcfg_config_num = 1;
+
+	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x48, 4, &pciexbar);
+
+	// Enable bit
+	if (!(pciexbar & 1))
+		pci_mmcfg_config_num = 0;
+
+	// Size bits
+	switch ((pciexbar >> 1) & 3) {
+	case 0:
+		mask = 0xf0000000U;
+		len  = 0x10000000U;
+		break;
+	case 1:
+		mask = 0xf8000000U;
+		len  = 0x08000000U;
+		break;
+	case 2:
+		mask = 0xfc000000U;
+		len  = 0x04000000U;
+		break;
+	default:
+		pci_mmcfg_config_num = 0;
+	}
+
+	// Errata #2, things break when not aligned on a 256Mb boundary
+	// Can only happen in 64M/128M mode
+
+	if ((pciexbar & mask) & 0x0fffffffU)
+		pci_mmcfg_config_num = 0;
+
+	if (pci_mmcfg_config_num) {
+		pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
+		pci_mmcfg_config[0].base_address = pciexbar & mask;
+		pci_mmcfg_config[0].pci_segment_group_number = 0;
+		pci_mmcfg_config[0].start_bus_number = 0;
+		pci_mmcfg_config[0].end_bus_number = (len >> 20) - 1;
+	}
+
+	return "Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub";
+}
+
+struct pci_mmcfg_hostbridge_probe {
+	u32 vendor;
+	u32 device;
+	const char *(*probe)(void);
+};
+
+static __initdata struct pci_mmcfg_hostbridge_probe pci_mmcfg_probes[] = {
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E7520_MCH, pci_mmcfg_e7520 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82945G_HB, pci_mmcfg_intel_945 },
+};
+
+static int __init pci_mmcfg_check_hostbridge(void)
+{
+	u32 l;
+	u16 vendor, device;
+	int i;
+	const char *name;
+
+	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0, 4, &l);
+	vendor = l & 0xffff;
+	device = (l >> 16) & 0xffff;
+
+	pci_mmcfg_config_num = 0;
+	pci_mmcfg_config = NULL;
+	name = NULL;
+
+	for (i = 0; !name && i < sizeof(pci_mmcfg_probes) / sizeof(pci_mmcfg_probes[0]); i++)
+		if ((pci_mmcfg_probes[i].vendor == PCI_ANY_ID || pci_mmcfg_probes[i].vendor == vendor) &&
+		    (pci_mmcfg_probes[i].device == PCI_ANY_ID || pci_mmcfg_probes[i].device == device))
+			name = pci_mmcfg_probes[i].probe();
+
+	if (name) {
+		if (pci_mmcfg_config_num)
+			printk(KERN_INFO "PCI: Found %s with MMCONFIG support.\n", name);
+		else
+			printk(KERN_INFO "PCI: Found %s without MMCONFIG support.\n", name);
+	}
+
+	return name != NULL;
+}
+
+void __init pci_mmcfg_init(int type)
+{
+	extern int pci_mmcfg_arch_init(void);
+
+	int known_bridge = 0;
+
+	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
+		return;
+
+	if (type == 1 && pci_mmcfg_check_hostbridge())
+		known_bridge = 1;
+
+	if (!known_bridge)
+		acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+
+	if ((pci_mmcfg_config_num == 0) ||
+	    (pci_mmcfg_config == NULL) ||
+	    (pci_mmcfg_config[0].base_address == 0))
+		return;
+
+	/* Only do this check when type 1 works. If it doesn't work
+           assume we run on a Mac and always use MCFG */
+	if (type == 1 && !known_bridge &&
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
+		if (type == 1)
+			unreachable_devices();
+		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
+	}
+}
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index c6b6d9b..9fac232 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -15,10 +15,6 @@ #include <linux/acpi.h>
 #include <asm/e820.h>
 #include "pci.h"
 
-/* aperture is up to 256MB but BIOS may reserve less */
-#define MMCONFIG_APER_MIN	(2 * 1024*1024)
-#define MMCONFIG_APER_MAX	(256 * 1024*1024)
-
 /* Assume systems with more busses have correct MCFG */
 #define MAX_CHECK_BUS 16
 
@@ -27,7 +23,7 @@ #define mmcfg_virt_addr ((void __iomem *
 /* The base address of the last MMCONFIG device accessed */
 static u32 mmcfg_last_accessed_device;
 
-static DECLARE_BITMAP(fallback_slots, MAX_CHECK_BUS*32);
+extern DECLARE_BITMAP(pci_mmcfg_fallback_slots, MAX_CHECK_BUS*32);
 
 /*
  * Functions for accessing PCI configuration space with MMCONFIG accesses
@@ -38,7 +34,7 @@ static u32 get_base_addr(unsigned int se
 	struct acpi_table_mcfg_config *cfg;
 
 	if (seg == 0 && bus < MAX_CHECK_BUS &&
-	    test_bit(PCI_SLOT(devfn) + 32*bus, fallback_slots))
+	    test_bit(PCI_SLOT(devfn) + 32*bus, pci_mmcfg_fallback_slots))
 		return 0;
 
 	while (1) {
@@ -154,67 +150,8 @@ static struct pci_raw_ops pci_mmcfg = {
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
-	printk(KERN_INFO "PCI: Using MMCONFIG\n");
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
index f8b6b28..091f759 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -13,15 +13,11 @@ #include <asm/e820.h>
 
 #include "pci.h"
 
-/* aperture is up to 256MB but BIOS may reserve less */
-#define MMCONFIG_APER_MIN	(2 * 1024*1024)
-#define MMCONFIG_APER_MAX	(256 * 1024*1024)
-
 /* Verify the first 16 busses. We assume that systems with more busses
    get MCFG right. */
 #define MAX_CHECK_BUS 16
 
-static DECLARE_BITMAP(fallback_slots, 32*MAX_CHECK_BUS);
+extern DECLARE_BITMAP(pci_mmcfg_fallback_slots, 32*MAX_CHECK_BUS);
 
 /* Static virtual mapping of the MMCONFIG aperture */
 struct mmcfg_virt {
@@ -64,7 +60,7 @@ static char __iomem *pci_dev_base(unsign
 {
 	char __iomem *addr;
 	if (seg == 0 && bus < MAX_CHECK_BUS &&
-		test_bit(32*bus + PCI_SLOT(devfn), fallback_slots))
+		test_bit(32*bus + PCI_SLOT(devfn), pci_mmcfg_fallback_slots))
 		return NULL;
 	addr = get_virt(seg, bus);
 	if (!addr)
@@ -135,78 +131,29 @@ static struct pci_raw_ops pci_mmcfg = {
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
+		u32 size = (pci_mmcfg_config[0].end_bus_number - pci_mmcfg_config[0].start_bus_number + 1) << 20;
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
 		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
-							 MMCONFIG_APER_MAX);
+							 size);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for "
 					"segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
-			return;
+			return 0;
 		}
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x-%x\n", pci_mmcfg_config[i].base_address, pci_mmcfg_config[i].base_address + size - 1);
 	}
 
-	unreachable_devices();
-
 	raw_pci_ops = &pci_mmcfg;
-	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
+	return 1;
 }
-- 
1.4.2.GIT


