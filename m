Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032279AbWLGOvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032279AbWLGOvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032280AbWLGOvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:51:22 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3958 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032279AbWLGOvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:51:21 -0500
Date: Thu, 7 Dec 2006 15:51:19 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [0/5] PCI MMConfig per-chipset support
Message-ID: <20061207145119.GD45089@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061207143603.GA41804@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207143603.GA41804@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the only way to reliably support mmconfig in the
presence of funky biosen is to detect the hostbridge and read where
the window is mapped from its registers.  Do that for the E7520 and
the 945G/GZ/P/PL for a start.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
---
 arch/i386/pci/mmconfig-shared.c |  114 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/arch/i386/pci/mmconfig-shared.c b/arch/i386/pci/mmconfig-shared.c
index 7a8a498..4906741 100644
--- a/arch/i386/pci/mmconfig-shared.c
+++ b/arch/i386/pci/mmconfig-shared.c
@@ -3,6 +3,7 @@
  *                     MMCONFIG - common code between i386 and x86-64.
  * 
  * This code does:
+ * - known chipset handling
  * - ACPI decoding and validation
  *
  * Per-architecture code takes care of the mappings and accesses
@@ -55,14 +56,123 @@ static __init void unreachable_devices(void)
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
 	extern int pci_mmcfg_arch_init(void);
 
+	int known_bridge = 0;
+
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
 
-	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+	if (type == 1 && pci_mmcfg_check_hostbridge())
+		known_bridge = 1;
+
+	if (!known_bridge)
+		acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
 
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
@@ -71,7 +181,7 @@ void __init pci_mmcfg_init(int type)
 
 	/* Only do this check when type 1 works. If it doesn't work
            assume we run on a Mac and always use MCFG */
-	if (type == 1 &&
+	if (type == 1 && !known_bridge &&
 	    !e820_all_mapped(pci_mmcfg_config[0].base_address,
 			     pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			     E820_RESERVED)) {
-- 
1.4.4.1.g278f

