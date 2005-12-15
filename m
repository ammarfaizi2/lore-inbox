Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbVLOJ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbVLOJ07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbVLOJSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:10922 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422639AbVLOJRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:45 -0500
To: torvalds@osdl.org
Subject: [PATCH] i386,amd64: mmconfig __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFA-0007yj-Vw@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/i386/pci/mmconfig.c   |    2 +-
 arch/x86_64/pci/mmconfig.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

2e9fa139a1fc14c8cb26fae0bcb31ecc73811f6f
diff --git a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
index 08a0849..70a9cc1 100644
--- a/arch/i386/pci/mmconfig.c
+++ b/arch/i386/pci/mmconfig.c
@@ -155,7 +155,7 @@ static __init void unreachable_devices(v
 		addr = get_base_addr(0, 0, PCI_DEVFN(i, 0));
 		if (addr != 0)
 			pci_exp_set_dev_base(addr, 0, PCI_DEVFN(i, 0));
-		if (addr == 0 || readl((u32 *)addr) != val1)
+		if (addr == 0 || readl((u32 __iomem *)addr) != val1)
 			set_bit(i, fallback_slots);
 		spin_unlock_irqrestore(&pci_config_lock, flags);
 	}
diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index 9c4f907..f16c0d5 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -18,11 +18,11 @@ static DECLARE_BITMAP(fallback_slots, 32
 /* Static virtual mapping of the MMCONFIG aperture */
 struct mmcfg_virt {
 	struct acpi_table_mcfg_config *cfg;
-	char *virt;
+	char __iomem *virt;
 };
 static struct mmcfg_virt *pci_mmcfg_virt;
 
-static char *get_virt(unsigned int seg, unsigned bus)
+static char __iomem *get_virt(unsigned int seg, unsigned bus)
 {
 	int cfg_num = -1;
 	struct acpi_table_mcfg_config *cfg;
@@ -43,9 +43,9 @@ static char *get_virt(unsigned int seg, 
 	}
 }
 
-static char *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
+static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
 {
-	char *addr;
+	char __iomem *addr;
 	if (seg == 0 && bus == 0 && test_bit(PCI_SLOT(devfn), &fallback_slots))
 		return NULL;
 	addr = get_virt(seg, bus);
@@ -57,7 +57,7 @@ static char *pci_dev_base(unsigned int s
 static int pci_mmcfg_read(unsigned int seg, unsigned int bus,
 			  unsigned int devfn, int reg, int len, u32 *value)
 {
-	char *addr;
+	char __iomem *addr;
 
 	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
 	if (unlikely(!value || (bus > 255) || (devfn > 255) || (reg > 4095)))
@@ -85,7 +85,7 @@ static int pci_mmcfg_read(unsigned int s
 static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
 			   unsigned int devfn, int reg, int len, u32 value)
 {
-	char *addr;
+	char __iomem *addr;
 
 	/* Why do we have this when nobody checks it. How about a BUG()!? -AK */
 	if (unlikely((bus > 255) || (devfn > 255) || (reg > 4095)))
@@ -127,7 +127,7 @@ static __init void unreachable_devices(v
 	int i;
 	for (i = 0; i < 32; i++) {
 		u32 val1;
-		char *addr;
+		char __iomem *addr;
 
 		pci_conf1_read(0, 0, PCI_DEVFN(i,0), 0, 4, &val1);
 		if (val1 == 0xffffffff)
-- 
0.99.9.GIT

