Return-Path: <linux-kernel-owner+w=401wt.eu-S965281AbXAKCxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbXAKCxn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 21:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbXAKCxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 21:53:43 -0500
Received: from outbound-mail-42.bluehost.com ([69.89.18.11]:39399 "HELO
	outbound-mail-42.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965281AbXAKCxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 21:53:42 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Olivier Galibert <galibert@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PCI mmconfig support for Intel 915 bridges
Date: Wed, 10 Jan 2007 18:53:03 -0800
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701101853.04059.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the patch I sent earlier to Oliver.  It adds support
for Intel 915 bridge chips to the new PCI MMConfig detection code.  Tested
and works on my sole 915 based platform (a Toshiba laptop).  I added
register masking per Oliver's suggestion, and moved the __init qualifier to
after the 'static const char' to match Ogawa-san's recent cleanup patches.

Over time we can probably associate more PCI IDs with this routine, since
i915 family contains a few other chips.  But since I didn't have platforms
to test such additions on, they're left out for now.

Signed-off-by:  Jesse Barnes <jbarnes@virtuousgeek.org>

Thanks,
Jesse

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.19-mmconfig.orig/arch/i386/pci/mmconfig-shared.c linux-2.6.19-mmconfig/arch/i386/pci/mmconfig-shared.c
--- linux-2.6.19-mmconfig.orig/arch/i386/pci/mmconfig-shared.c	2007-01-07 10:10:29.000000000 -0800
+++ linux-2.6.19-mmconfig/arch/i386/pci/mmconfig-shared.c	2007-01-10 18:46:46.000000000 -0800
@@ -71,6 +71,26 @@ static __init const char *pci_mmcfg_e752
 	return "Intel Corporation E7520 Memory Controller Hub";
 }
 
+static const char __init *pci_mmcfg_intel_915(void)
+{
+	u32 pciexbar, len = 0;
+
+	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x48, 4, &pciexbar);
+
+	/* No enable bit or size field, so assume 256M range is enabled. */
+	len = 0x10000000U;
+	pci_mmcfg_config_num = 1;
+	pciexbar &= 0xe0000000; /* mask out potentially bogus bits */
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
@@ -126,6 +146,7 @@ struct pci_mmcfg_hostbridge_probe {
 
 static __initdata struct pci_mmcfg_hostbridge_probe pci_mmcfg_probes[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E7520_MCH, pci_mmcfg_e7520 },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82915GM_HB, pci_mmcfg_intel_915 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82945G_HB, pci_mmcfg_intel_945 },
 };
 
