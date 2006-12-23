Return-Path: <linux-kernel-owner+w=401wt.eu-S1753344AbWLWBUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbWLWBUT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 20:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbWLWBUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 20:20:19 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:44172 "EHLO
	mail01.miraclelinux.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753344AbWLWBUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 20:20:17 -0500
X-Greylist: delayed 1171 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 20:20:17 EST
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH -mm] MMCONFIG: Fix x86_64 ioremap base_address
From: OGAWA Hirofumi <hogawa@miraclelinux.com>
Date: Sat, 23 Dec 2006 10:02:07 +0900
Message-ID: <lrfyb7ctm8.fsf@dhcp-0242.miraclelinux.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current -mm's mmconfig has some problems of remapped range.

a) In the case of broken MCFG tables on Asus etc., we need to remap
256M range, but currently only remap 1M.

b) The base address always corresponds to bus number 0, but currently
we are assuming it corresponds to start bus number.

This patch fixes the above problems.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/x86_64/pci/mmconfig.c |   48 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff -puN arch/x86_64/pci/mmconfig.c~pci-mmconfig-ioremap-range-fix arch/x86_64/pci/mmconfig.c
--- linux-2.6/arch/x86_64/pci/mmconfig.c~pci-mmconfig-ioremap-range-fix	2006-12-23 08:52:15.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/pci/mmconfig.c	2006-12-23 09:35:37.000000000 +0900
@@ -24,6 +24,39 @@ struct mmcfg_virt {
 };
 static struct mmcfg_virt *pci_mmcfg_virt;
 
+static inline int mcfg_broken(void)
+{
+	struct acpi_table_mcfg_config *cfg = &pci_mmcfg_config[0];
+
+	/* Handle more broken MCFG tables on Asus etc.
+	   They only contain a single entry for bus 0-0. Assume
+ 	   this applies to all busses. */
+	if (pci_mmcfg_config_num == 1 &&
+	    cfg->pci_segment_group_number == 0 &&
+	    (cfg->start_bus_number | cfg->end_bus_number) == 0)
+		return 1;
+	return 0;
+}
+
+static void __iomem *mcfg_ioremap(struct acpi_table_mcfg_config *cfg)
+{
+	void __iomem *addr;
+	u32 size;
+
+	if (mcfg_broken())
+		size = 256 << 20;
+	else
+		size = (cfg->end_bus_number + 1) << 20;
+
+	addr = ioremap_nocache(cfg->base_address, size);
+	if (addr) {
+		printk(KERN_INFO "PCI: Using MMCONFIG at %x - %x\n",
+		       cfg->base_address,
+		       cfg->base_address + size - 1);
+	}
+	return addr;
+}
+
 static char __iomem *get_virt(unsigned int seg, unsigned bus)
 {
 	int cfg_num = -1;
@@ -41,13 +74,7 @@ static char __iomem *get_virt(unsigned i
 			return pci_mmcfg_virt[cfg_num].virt;
 	}
 
-	/* Handle more broken MCFG tables on Asus etc.
-	   They only contain a single entry for bus 0-0. Assume
- 	   this applies to all busses. */
-	cfg = &pci_mmcfg_config[0];
-	if (pci_mmcfg_config_num == 1 &&
-		cfg->pci_segment_group_number == 0 &&
-		(cfg->start_bus_number | cfg->end_bus_number) == 0)
+	if (mcfg_broken())
 		return pci_mmcfg_virt[0].virt;
 
 	/* Fall back to type 0 */
@@ -139,19 +166,14 @@ int __init pci_mmcfg_arch_init(void)
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

-- 
OGAWA Hirofumi <hogawa@miraclelinux.com>
