Return-Path: <linux-kernel-owner+w=401wt.eu-S964990AbXAGTmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbXAGTmT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbXAGTmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:42:19 -0500
Received: from outbound-mail-42.bluehost.com ([69.89.18.11]:38192 "HELO
	outbound-mail-42.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964990AbXAGTmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:42:18 -0500
X-Length: 958
X-Flags: 1
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Reply-To: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>
Cc: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] update MMConfig patches w/915 support
Date: Sun, 7 Jan 2007 11:42:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701071142.09428.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates Oliver's MMConfig bridge detection patches with support
for 915G bridges.  It seems to work ok on my 915GM laptop.

I also tried adding 965 support, but it doesn't work (at least not on my
G965 box).  When I enable MMConfig support when the register value is
0xf00000003 (should be a 256M enabled window at 0xf0000000) the box hangs
at boot, so I'm not sure what I'm doing wrong...

The routines could probably be consolidated into a single probe_intel_9xx
routine or something, but I really looked at that yet (though there are
many similarities between the 91[05], 945 and 965 families, they may not
be enough that the code would actually be simpler if shared.

Thanks,
Jesse

Signed-off-by:  Jesse Barnes <jbarnes@virtuousgeek.org>

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.19-mmconfig.orig/arch/i386/pci/mmconfig-shared.c linux-2.6.19-mmconfig/arch/i386/pci/mmconfig-shared.c
--- linux-2.6.19-mmconfig.orig/arch/i386/pci/mmconfig-shared.c	2007-01-07 10:10:29.000000000 -0800
+++ linux-2.6.19-mmconfig/arch/i386/pci/mmconfig-shared.c	2007-01-07 11:36:24.000000000 -0800
@@ -71,6 +71,25 @@ static __init const char *pci_mmcfg_e752
 	return "Intel Corporation E7520 Memory Controller Hub";
 }
 
+static __init const char *pci_mmcfg_intel_915(void)
+{
+	u32 pciexbar, len = 0;
+
+	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x48, 4, &pciexbar);
+
+	/* No enable bit or size field, so assume 256M range is enabled. */
+	len = 0x10000000U;
+	pci_mmcfg_config_num = 1;
+
+	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
+	pci_mmcfg_config[0].base_address = pciexbar;
+	pci_mmcfg_config[0].pci_segment_group_number = 0;
+	pci_mmcfg_config[0].start_bus_number = 0;
+	pci_mmcfg_config[0].end_bus_number = (len >> 20) - 1;
+
+	return "Intel Corporation 915PM/GM/GMS Express Memory Controller Hub";
+}
+
 static __init const char *pci_mmcfg_intel_945(void)
 {
 	u32 pciexbar, mask = 0, len = 0;
@@ -126,6 +145,7 @@ struct pci_mmcfg_hostbridge_probe {
 
 static __initdata struct pci_mmcfg_hostbridge_probe pci_mmcfg_probes[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E7520_MCH, pci_mmcfg_e7520 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82915GM_HB, pci_mmcfg_intel_915 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82945G_HB, pci_mmcfg_intel_945 },
 };
 
