Return-Path: <linux-kernel-owner+w=401wt.eu-S932464AbXAITBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbXAITBT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbXAITBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:01:18 -0500
Received: from mail.parknet.jp ([210.171.160.80]:4225 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932464AbXAITBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:01:17 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 4/4] MMCONFIG: Fix x86_64 ioremap base_address
References: <878xgc58nc.fsf@duaron.myhome.or.jp>
	<871wm458lj.fsf@duaron.myhome.or.jp>
	<87wt3w3u04.fsf_-_@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Jan 2007 04:01:13 +0900
In-Reply-To: <87wt3w3u04.fsf_-_@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Wed\, 10 Jan 2007 04\:00\:43 +0900")
Message-ID: <87slek3tza.fsf_-_@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current mmconfig has some problems of remapped range.  The base
address always corresponds to bus number 0, but currently we are
assuming it corresponds to start bus number.

This patch fixes the above problems.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/x86_64/pci/mmconfig.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff -puN arch/x86_64/pci/mmconfig.c~pci-mmconfig-ioremap-range-fix-mm arch/x86_64/pci/mmconfig.c
--- linux-2.6/arch/x86_64/pci/mmconfig.c~pci-mmconfig-ioremap-range-fix-mm	2007-01-06 01:04:47.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/pci/mmconfig.c	2007-01-06 01:05:35.000000000 +0900
@@ -118,6 +118,20 @@ int __init pci_mmcfg_arch_reachable(unsi
 	return pci_dev_base(seg, bus, devfn) != NULL;
 }
 
+static void __iomem * __init mcfg_ioremap(struct acpi_table_mcfg_config *cfg)
+{
+	void __iomem *addr;
+	u32 size;
+
+	size = (cfg->end_bus_number + 1) << 20;
+	addr = ioremap_nocache(cfg->base_address, size);
+	if (addr) {
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x - %x\n",
+		       cfg->base_address, cfg->base_address + size - 1);
+	}
+	return addr;
+}
+
 int __init pci_mmcfg_arch_init(void)
 {
 	int i;
@@ -128,19 +142,14 @@ int __init pci_mmcfg_arch_init(void)
 	}
 
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
-		u32 size = (pci_mmcfg_config[0].end_bus_number - pci_mmcfg_config[0].start_bus_number + 1) << 20;
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
-		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
-							 size);
+		pci_mmcfg_virt[i].virt = mcfg_ioremap(&pci_mmcfg_config[i]);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk(KERN_ERR "PCI: Cannot map mmconfig aperture for "
 					"segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
 			return 0;
 		}
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x-%x\n",
-		       pci_mmcfg_config[i].base_address,
-		       pci_mmcfg_config[i].base_address + size - 1);
 	}
 
 	raw_pci_ops = &pci_mmcfg;
_
