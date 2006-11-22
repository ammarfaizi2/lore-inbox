Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756689AbWKVT3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689AbWKVT3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756720AbWKVT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:29:17 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:62992 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1756689AbWKVT3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:29:16 -0500
Date: Wed, 22 Nov 2006 20:29:13 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI MMConfig: Detect and support the E7520
Message-ID: <20061122192913.GA57132@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    It seems that the only way to reliably support mmconfig in the
    presence of funky biosen is to detect the hostbridge and read where
    the window is mapped from its registers.  Do that for the E7520 on
    x86-64 for a start.
    
    The detection and support should eventually be shared with i386 since
    you can run a 32bits kernel on a 64bits chip.

Signed-off-by: Olivier Galibert <galibert@pobox.com>

---

This allows an eServer I have here to use mmconfig while its space is
not reserved in the e820 table.  Annoyingly enough, none of the
non-e7520 boxen I have around seem to support mmconfig.


diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index f8b6b28..af549a2 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -163,14 +163,81 @@ static __init void unreachable_devices(v
 	}
 }
 
+static __init const char *pci_mmcfg_e7520(void)
+{
+	/* This device has an always active 256Mb mmconfig window.
+	 * Address selection register is the 4 top bits of 0xce.w
+	 * multiplied by 256Mb.  Register is write-once, so don't
+	 * touch it.
+	 */
+
+	u32 win;
+	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0xcc, 4, &win);
+
+	pci_mmcfg_config_num = 1;
+	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
+	pci_mmcfg_config[0].base_address = win & 0xf0000000;
+	pci_mmcfg_config[0].pci_segment_group_number = 0;
+	pci_mmcfg_config[0].start_bus_number = 0;
+	pci_mmcfg_config[0].end_bus_number = 7;
+
+	return "Intel Corporation E7520 Memory Controller Hub";
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
@@ -178,9 +245,10 @@ void __init pci_mmcfg_init(int type)
 
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
