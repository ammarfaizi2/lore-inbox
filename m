Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFOFfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFOFfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVFOFe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:34:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:7592 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261500AbVFOFda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:33:30 -0400
Date: Tue, 14 Jun 2005 22:30:31 -0700
From: Greg KH <gregkh@suse.de>
To: len.brown@intel.com, ak@suse.de
Cc: acpi-devel@lists.sourceforge.net, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/04] PCI: add proper MCFG table parsing to ACPI core.
Message-ID: <20050615053031.GB23394@kroah.com>
References: <20050615052916.GA23394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615052916.GA23394@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the first step in properly handling the MCFG PCI table.
It defines the structures properly, and saves off the table so that the
pci mmconfig code can access it.  It moves the parsing of the table a
little later in the boot process, but still before the information is
needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/acpi/boot.c |   41 +++++++++++++++++++++++++++++++++--------
 arch/i386/pci/mmconfig.c     |   12 +++++++-----
 arch/x86_64/pci/mmconfig.c   |   16 +++++++++-------
 include/linux/acpi.h         |   16 +++++++++++++---
 4 files changed, 62 insertions(+), 23 deletions(-)

--- gregkh-2.6.orig/arch/i386/kernel/acpi/boot.c	2005-06-14 21:14:31.000000000 -0700
+++ gregkh-2.6/arch/i386/kernel/acpi/boot.c	2005-06-14 21:16:46.000000000 -0700
@@ -158,9 +158,15 @@
 #endif
 
 #ifdef CONFIG_PCI_MMCONFIG
-static int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)
+/* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
+struct acpi_table_mcfg_config *pci_mmcfg_config;
+int pci_mmcfg_config_num;
+
+int __init acpi_parse_mcfg(unsigned long phys_addr, unsigned long size)
 {
 	struct acpi_table_mcfg *mcfg;
+	unsigned long i;
+	int config_size;
 
 	if (!phys_addr || !size)
 		return -EINVAL;
@@ -171,18 +177,38 @@
 		return -ENODEV;
 	}
 
-	if (mcfg->base_reserved) {
-		printk(KERN_ERR PREFIX "MMCONFIG not in low 4GB of memory\n");
+	/* how many config structures do we have */
+	pci_mmcfg_config_num = 0;
+	i = size - sizeof(struct acpi_table_mcfg);
+	while (i >= sizeof(struct acpi_table_mcfg_config)) {
+		++pci_mmcfg_config_num;
+		i -= sizeof(struct acpi_table_mcfg_config);
+	};
+	if (pci_mmcfg_config_num == 0) {
+		printk(KERN_ERR PREFIX "MMCONFIG has no entries\n");
 		return -ENODEV;
 	}
 
-	pci_mmcfg_base_addr = mcfg->base_address;
+	config_size = pci_mmcfg_config_num * sizeof(*pci_mmcfg_config);
+	pci_mmcfg_config = kmalloc(config_size, GFP_KERNEL);
+	if (!pci_mmcfg_config) {
+		printk(KERN_WARNING PREFIX
+		       "No memory for MCFG config tables\n");
+		return -ENOMEM;
+	}
+
+	memcpy(pci_mmcfg_config, &mcfg->config, config_size);
+	for (i = 0; i < pci_mmcfg_config_num; ++i) {
+		if (mcfg->config[i].base_reserved) {
+			printk(KERN_ERR PREFIX
+			       "MMCONFIG not in low 4GB of memory\n");
+			return -ENODEV;
+		}
+	}
 
 	return 0;
 }
-#else
-#define	acpi_parse_mcfg NULL
-#endif /* !CONFIG_PCI_MMCONFIG */
+#endif /* CONFIG_PCI_MMCONFIG */
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static int __init
@@ -923,7 +949,6 @@
 	acpi_process_madt();
 
 	acpi_table_parse(ACPI_HPET, acpi_parse_hpet);
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
 
 	return 0;
 }
--- gregkh-2.6.orig/include/linux/acpi.h	2005-06-14 21:14:31.000000000 -0700
+++ gregkh-2.6/include/linux/acpi.h	2005-06-14 21:16:46.000000000 -0700
@@ -342,11 +342,19 @@
 
 /* PCI MMCONFIG */
 
+/* Defined in PCI Firmware Specification 3.0 */
+struct acpi_table_mcfg_config {
+	u32				base_address;
+	u32				base_reserved;
+	u16				pci_segment_group_number;
+	u8				start_bus_number;
+	u8				end_bus_number;
+	u8				reserved[4];
+} __attribute__ ((packed));
 struct acpi_table_mcfg {
 	struct acpi_table_header	header;
 	u8				reserved[8];
-	u32				base_address;
-	u32				base_reserved;
+	struct acpi_table_mcfg_config	config[0];
 } __attribute__ ((packed));
 
 /* Table Handlers */
@@ -391,6 +399,7 @@
 int acpi_get_table_header_early (enum acpi_table_id id, struct acpi_table_header **header);
 int acpi_table_parse_madt (enum acpi_madt_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
 int acpi_table_parse_srat (enum acpi_srat_entry_id id, acpi_madt_entry_handler handler, unsigned int max_entries);
+int acpi_parse_mcfg (unsigned long phys_addr, unsigned long size);
 void acpi_table_print (struct acpi_table_header *header, unsigned long phys_addr);
 void acpi_table_print_madt_entry (acpi_table_entry_header *madt);
 void acpi_table_print_srat_entry (acpi_table_entry_header *srat);
@@ -412,7 +421,8 @@
 
 extern int acpi_mp_config;
 
-extern u32 pci_mmcfg_base_addr;
+extern struct acpi_table_mcfg_config *pci_mmcfg_config;
+extern int pci_mmcfg_config_num;
 
 extern int sbf_port ;
 
--- gregkh-2.6.orig/arch/i386/pci/mmconfig.c	2005-06-14 21:14:31.000000000 -0700
+++ gregkh-2.6/arch/i386/pci/mmconfig.c	2005-06-14 21:53:11.000000000 -0700
@@ -11,11 +11,9 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/acpi.h>
 #include "pci.h"
 
-/* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
-u32 pci_mmcfg_base_addr;
-
 #define mmcfg_virt_addr ((void __iomem *) fix_to_virt(FIX_PCIE_MCFG))
 
 /* The base address of the last MMCONFIG device accessed */
@@ -27,7 +25,7 @@
 
 static inline void pci_exp_set_dev_base(int bus, int devfn)
 {
-	u32 dev_base = pci_mmcfg_base_addr | (bus << 20) | (devfn << 12);
+	u32 dev_base = pci_mmcfg_config[0].base_address | (bus << 20) | (devfn << 12);
 	if (dev_base != mmcfg_last_accessed_device) {
 		mmcfg_last_accessed_device = dev_base;
 		set_fixmap_nocache(FIX_PCIE_MCFG, dev_base);
@@ -101,7 +99,11 @@
 {
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		goto out;
-	if (!pci_mmcfg_base_addr)
+
+	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if ((pci_mmcfg_config_num == 0) ||
+	    (pci_mmcfg_config == NULL) ||
+	    (pci_mmcfg_config[0].base_address == 0))
 		goto out;
 
 	/* Kludge for now. Don't use mmconfig on AMD systems because
--- gregkh-2.6.orig/arch/x86_64/pci/mmconfig.c	2005-06-14 21:14:31.000000000 -0700
+++ gregkh-2.6/arch/x86_64/pci/mmconfig.c	2005-06-14 21:53:30.000000000 -0700
@@ -7,15 +7,13 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/acpi.h>
 #include "pci.h"
 
 #define MMCONFIG_APER_SIZE (256*1024*1024)
 
-/* The physical address of the MMCONFIG aperture.  Set from ACPI tables. */
-u32 pci_mmcfg_base_addr;
-
 /* Static virtual mapping of the MMCONFIG aperture */
-char *pci_mmcfg_virt;
+static char *pci_mmcfg_virt;
 
 static inline char *pci_dev_base(unsigned int bus, unsigned int devfn)
 {
@@ -77,7 +75,11 @@
 {
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 0;
-	if (!pci_mmcfg_base_addr)
+
+	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if ((pci_mmcfg_config_num == 0) ||
+	    (pci_mmcfg_config == NULL) ||
+	    (pci_mmcfg_config[0].base_address == 0))
 		return 0;
 
 	/* Kludge for now. Don't use mmconfig on AMD systems because
@@ -88,13 +90,13 @@
 		return 0; 
 
 	/* RED-PEN i386 doesn't do _nocache right now */
-	pci_mmcfg_virt = ioremap_nocache(pci_mmcfg_base_addr, MMCONFIG_APER_SIZE);
+	pci_mmcfg_virt = ioremap_nocache(pci_mmcfg_config[0].base_address, MMCONFIG_APER_SIZE);
 	if (!pci_mmcfg_virt) { 
 		printk("PCI: Cannot map mmconfig aperture\n");
 		return 0;
 	}	
 
-	printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_base_addr);
+	printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[0].base_address);
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 
