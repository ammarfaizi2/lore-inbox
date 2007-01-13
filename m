Return-Path: <linux-kernel-owner+w=401wt.eu-S1422799AbXAMV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbXAMV13 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbXAMV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 16:27:29 -0500
Received: from mail.parknet.jp ([210.171.160.80]:1514 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422799AbXAMV12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 16:27:28 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm] MMCONFIG: Reject a broken MCFG tables on Asus etc
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 14 Jan 2007 06:27:18 +0900
Message-ID: <87hcuusjm1.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This rejects a broken MCFG tables on Asus etc.
Arjan and Andi suggest this.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/pci/mmconfig-shared.c |   24 ++++++++++++++++++-
 arch/i386/pci/mmconfig.c        |    9 -------
 arch/x86_64/pci/mmconfig.c      |   50 +++++++++++-----------------------------
 3 files changed, 37 insertions(+), 46 deletions(-)

diff -puN arch/i386/pci/mmconfig-shared.c~pci-mmconfig-reject-mcfg_broken arch/i386/pci/mmconfig-shared.c
--- linux-2.6/arch/i386/pci/mmconfig-shared.c~pci-mmconfig-reject-mcfg_broken	2007-01-12 23:15:58.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig-shared.c	2007-01-12 23:15:58.000000000 +0900
@@ -207,6 +207,26 @@ static void __init pci_mmcfg_insert_reso
 	}
 }
 
+static void __init pci_mmcfg_reject_broken(void)
+{
+	struct acpi_table_mcfg_config *cfg = &pci_mmcfg_config[0];
+
+	/*
+	 * Handle more broken MCFG tables on Asus etc.
+	 * They only contain a single entry for bus 0-0.
+	 */
+	if (pci_mmcfg_config_num == 1 &&
+	    cfg->pci_segment_group_number == 0 &&
+	    (cfg->start_bus_number | cfg->end_bus_number) == 0) {
+		kfree(pci_mmcfg_config);
+		pci_mmcfg_config = NULL;
+		pci_mmcfg_config_num = 0;
+
+		printk(KERN_ERR "PCI: start and end of bus number is 0. "
+		       "Rejected as broken MCFG.");
+	}
+}
+
 void __init pci_mmcfg_init(int type)
 {
 	int known_bridge = 0;
@@ -217,8 +237,10 @@ void __init pci_mmcfg_init(int type)
 	if (type == 1 && pci_mmcfg_check_hostbridge())
 		known_bridge = 1;
 
-	if (!known_bridge)
+	if (!known_bridge) {
 		acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
+		pci_mmcfg_reject_broken();
+	}
 
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
diff -puN arch/i386/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken arch/i386/pci/mmconfig.c
--- linux-2.6/arch/i386/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken	2007-01-12 23:15:58.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig.c	2007-01-12 23:15:58.000000000 +0900
@@ -42,15 +42,6 @@ static u32 get_base_addr(unsigned int se
 			return cfg->base_address;
 	}
 
-	/* Handle more broken MCFG tables on Asus etc.
-	   They only contain a single entry for bus 0-0. Assume
- 	   this applies to all busses. */
-	cfg = &pci_mmcfg_config[0];
-	if (pci_mmcfg_config_num == 1 &&
-		cfg->pci_segment_group_number == 0 &&
-		(cfg->start_bus_number | cfg->end_bus_number) == 0)
-		return cfg->base_address;
-
 	/* Fall back to type 0 */
 	return 0;
 }
diff -puN arch/x86_64/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken arch/x86_64/pci/mmconfig.c
--- linux-2.6/arch/x86_64/pci/mmconfig.c~pci-mmconfig-reject-mcfg_broken	2007-01-12 23:15:58.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/pci/mmconfig.c	2007-01-12 23:20:25.000000000 +0900
@@ -20,39 +20,6 @@ struct mmcfg_virt {
 };
 static struct mmcfg_virt *pci_mmcfg_virt;
 
-static inline int mcfg_broken(void)
-{
-	struct acpi_table_mcfg_config *cfg = &pci_mmcfg_config[0];
-
-	/* Handle more broken MCFG tables on Asus etc.
-	   They only contain a single entry for bus 0-0. Assume
- 	   this applies to all busses. */
-	if (pci_mmcfg_config_num == 1 &&
-	    cfg->pci_segment_group_number == 0 &&
-	    (cfg->start_bus_number | cfg->end_bus_number) == 0)
-		return 1;
-	return 0;
-}
-
-static void __iomem *mcfg_ioremap(struct acpi_table_mcfg_config *cfg)
-{
-	void __iomem *addr;
-	u32 size;
-
-	if (mcfg_broken())
-		size = 256 << 20;
-	else
-		size = (cfg->end_bus_number + 1) << 20;
-
-	addr = ioremap_nocache(cfg->base_address, size);
-	if (addr) {
-		printk(KERN_INFO "PCI: Using MMCONFIG at %x - %x\n",
-		       cfg->base_address,
-		       cfg->base_address + size - 1);
-	}
-	return addr;
-}
-
 static char __iomem *get_virt(unsigned int seg, unsigned bus)
 {
 	struct acpi_table_mcfg_config *cfg;
@@ -66,9 +33,6 @@ static char __iomem *get_virt(unsigned i
 			return pci_mmcfg_virt[cfg_num].virt;
 	}
 
-	if (mcfg_broken())
-		return pci_mmcfg_virt[0].virt;
-
 	/* Fall back to type 0 */
 	return NULL;
 }
@@ -154,6 +118,20 @@ int __init pci_mmcfg_arch_reachable(unsi
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
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
