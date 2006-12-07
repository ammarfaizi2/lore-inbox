Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032266AbWLGOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032266AbWLGOvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032269AbWLGOvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:51:55 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2940 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032266AbWLGOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:51:54 -0500
Date: Thu, 7 Dec 2006 15:51:53 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 5/5] PCI MMConfig: Reserve resources but only when we're sure about them.
Message-ID: <20061207145153.GE45089@dspnet.fr.eu.org>
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

Put back the resource reservation as per
4c6e052adfe285ede5884e4e8c4d33af33932c13 but use it *only* when the
range(s) come from a chipset probe instead of the bios.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
---
 arch/i386/pci/mmconfig-shared.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/i386/pci/mmconfig-shared.c b/arch/i386/pci/mmconfig-shared.c
index 4906741..7599b89 100644
--- a/arch/i386/pci/mmconfig-shared.c
+++ b/arch/i386/pci/mmconfig-shared.c
@@ -159,6 +159,37 @@ static int __init pci_mmcfg_check_hostbridge(void)
 	return name != NULL;
 }
 
+static __init void pci_mmcfg_insert_resources(void)
+{
+#define PCI_MMCFG_RESOURCE_NAME_LEN 19
+	int i;
+	struct resource *res;
+	char *names;
+	unsigned num_buses;
+
+	res = kcalloc(PCI_MMCFG_RESOURCE_NAME_LEN + sizeof(*res),
+			pci_mmcfg_config_num, GFP_KERNEL);
+
+	if (!res) {
+		printk(KERN_ERR "PCI: Unable to allocate MMCONFIG resources\n");
+		return;
+	}
+
+	names = (void *)&res[pci_mmcfg_config_num];
+	for (i = 0; i < pci_mmcfg_config_num; i++, res++) {
+		num_buses = pci_mmcfg_config[i].end_bus_number -
+		    pci_mmcfg_config[i].start_bus_number + 1;
+		res->name = names;
+		snprintf(names, PCI_MMCFG_RESOURCE_NAME_LEN, "PCI MMCONFIG %u",
+			pci_mmcfg_config[i].pci_segment_group_number);
+		res->start = pci_mmcfg_config[i].base_address;
+		res->end = res->start + (num_buses << 20) - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		insert_resource(&iomem_resource, res);
+		names += PCI_MMCFG_RESOURCE_NAME_LEN;
+	}
+}
+
 void __init pci_mmcfg_init(int type)
 {
 	extern int pci_mmcfg_arch_init(void);
@@ -194,6 +225,8 @@ void __init pci_mmcfg_init(int type)
 	if (pci_mmcfg_arch_init()) {
 		if (type == 1)
 			unreachable_devices();
+		if (known_bridge)
+			pci_mmcfg_insert_resources();
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 	}
 }
-- 
1.4.4.1.g278f

