Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933759AbWKWTvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933759AbWKWTvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933857AbWKWTvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:51:48 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:57360 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S933759AbWKWTvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:51:47 -0500
Date: Thu, 23 Nov 2006 20:51:38 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061123195137.GA35120@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the only way to reliably support mmconfig in the
presence of funky biosen is to detect the hostbridge and read where
the window is mapped from its registers.  Do that for the E7520 and
the 945G/GZ/P/PL on x86-64 for a start.

The detection and support should eventually be shared with i386 since
you can run a 32bits kernel on a 64bits chip.

Signed-off-by: Olivier Galibert <galibert@pobox.com>

---
 arch/x86_64/pci/mmconfig.c |  123 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 117 insertions(+), 6 deletions(-)


Supersedes the previous patch on the same subject.  Found a dell
desktop box with a 945G in it so I added the support.

It should probably be a good idea to resurrect the resource
registration code but to use it only in the known_bridge case.

It's easy to generalize to multiple segments if someone can test it.
I suspect the multi-segment architectures don't use a E7520 or a 945G
as a chipset so this patch shouldn't change anything for them.

Eventually that should be shared with i386 for 32bits kernels on
64bits cpus.


diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index f8b6b28..c74c967 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -163,14 +163,123 @@ static __init void unreachable_devices(v
 	}
 }
 
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
 void __init pci_mmcfg_init(int type)
 {
 	int i;
+	int known_bridge = 0;
 
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if (type == 1 && pci_mmcfg_check_hostbridge())
+		known_bridge = 1;
+
+	if (!known_bridge)
+		acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
 	    (pci_mmcfg_config[0].base_address == 0))
@@ -178,9 +287,10 @@ void __init pci_mmcfg_init(int type)
 
 	/* Only do this check when type 1 works. If it doesn't work
            assume we run on a Mac and always use MCFG */
-	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
-			E820_RESERVED)) {
+	if (type == 1 && !known_bridge &&
+	    !e820_all_mapped(pci_mmcfg_config[0].base_address,
+			     pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
+			     E820_RESERVED)) {
 		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
 				pci_mmcfg_config[0].base_address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
@@ -193,16 +303,17 @@ void __init pci_mmcfg_init(int type)
 		return;
 	}
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
 			return;
 		}
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x-%x\n", pci_mmcfg_config[i].base_address, pci_mmcfg_config[i].base_address + size - 1);
 	}
 
 	unreachable_devices();
-- 
1.4.2.GIT

