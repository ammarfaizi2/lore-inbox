Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWBHHKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWBHHKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWBHHKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:10:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17051 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161044AbWBHHK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:10:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] powermac pci iomem annotations
Cc: linuxppc-dev@ozlabs.org
Message-Id: <E1F6jT7-0002Uv-VK@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 07:10:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138789123 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/platforms/powermac/pci.c |   89 ++++++++++++++++-----------------
 1 files changed, 43 insertions(+), 46 deletions(-)

de125bf395df34892862d76580ce3a153e80f151
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index f671ed2..de3f30e 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -136,14 +136,14 @@ static void __init fixup_bus_range(struc
 	|(((unsigned int)(off)) & 0xFCUL) \
 	|1UL)
 
-static unsigned long macrisc_cfg_access(struct pci_controller* hose,
+static volatile void __iomem *macrisc_cfg_access(struct pci_controller* hose,
 					       u8 bus, u8 dev_fn, u8 offset)
 {
 	unsigned int caddr;
 
 	if (bus == hose->first_busno) {
 		if (dev_fn < (11 << 3))
-			return 0;
+			return NULL;
 		caddr = MACRISC_CFA0(dev_fn, offset);
 	} else
 		caddr = MACRISC_CFA1(bus, dev_fn, offset);
@@ -154,14 +154,14 @@ static unsigned long macrisc_cfg_access(
 	} while (in_le32(hose->cfg_addr) != caddr);
 
 	offset &= has_uninorth ? 0x07 : 0x03;
-	return ((unsigned long)hose->cfg_data) + offset;
+	return hose->cfg_data + offset;
 }
 
 static int macrisc_read_config(struct pci_bus *bus, unsigned int devfn,
 				      int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -177,13 +177,13 @@ static int macrisc_read_config(struct pc
 	 */
 	switch (len) {
 	case 1:
-		*val = in_8((u8 *)addr);
+		*val = in_8(addr);
 		break;
 	case 2:
-		*val = in_le16((u16 *)addr);
+		*val = in_le16(addr);
 		break;
 	default:
-		*val = in_le32((u32 *)addr);
+		*val = in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -193,7 +193,7 @@ static int macrisc_write_config(struct p
 				       int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -209,16 +209,16 @@ static int macrisc_write_config(struct p
 	 */
 	switch (len) {
 	case 1:
-		out_8((u8 *)addr, val);
-		(void) in_8((u8 *)addr);
+		out_8(addr, val);
+		(void) in_8(addr);
 		break;
 	case 2:
-		out_le16((u16 *)addr, val);
-		(void) in_le16((u16 *)addr);
+		out_le16(addr, val);
+		(void) in_le16(addr);
 		break;
 	default:
-		out_le32((u32 *)addr, val);
-		(void) in_le32((u32 *)addr);
+		out_le32(addr, val);
+		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -348,25 +348,23 @@ static int u3_ht_skip_device(struct pci_
 		+ (((unsigned int)bus) << 16) \
 		+ 0x01000000UL)
 
-static unsigned long u3_ht_cfg_access(struct pci_controller* hose,
+static volatile void __iomem *u3_ht_cfg_access(struct pci_controller* hose,
 					     u8 bus, u8 devfn, u8 offset)
 {
 	if (bus == hose->first_busno) {
 		/* For now, we don't self probe U3 HT bridge */
 		if (PCI_SLOT(devfn) == 0)
-			return 0;
-		return ((unsigned long)hose->cfg_data) +
-			U3_HT_CFA0(devfn, offset);
+			return NULL;
+		return hose->cfg_data + U3_HT_CFA0(devfn, offset);
 	} else
-		return ((unsigned long)hose->cfg_data) +
-			U3_HT_CFA1(bus, devfn, offset);
+		return hose->cfg_data + U3_HT_CFA1(bus, devfn, offset);
 }
 
 static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
 				    int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -400,13 +398,13 @@ static int u3_ht_read_config(struct pci_
 	 */
 	switch (len) {
 	case 1:
-		*val = in_8((u8 *)addr);
+		*val = in_8(addr);
 		break;
 	case 2:
-		*val = in_le16((u16 *)addr);
+		*val = in_le16(addr);
 		break;
 	default:
-		*val = in_le32((u32 *)addr);
+		*val = in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -416,7 +414,7 @@ static int u3_ht_write_config(struct pci
 				     int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -442,16 +440,16 @@ static int u3_ht_write_config(struct pci
 	 */
 	switch (len) {
 	case 1:
-		out_8((u8 *)addr, val);
-		(void) in_8((u8 *)addr);
+		out_8(addr, val);
+		(void) in_8(addr);
 		break;
 	case 2:
-		out_le16((u16 *)addr, val);
-		(void) in_le16((u16 *)addr);
+		out_le16(addr, val);
+		(void) in_le16(addr);
 		break;
 	default:
-		out_le32((u32 *)addr, val);
-		(void) in_le32((u32 *)addr);
+		out_le32((u32 __iomem *)addr, val);
+		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -476,7 +474,7 @@ static struct pci_ops u3_ht_pci_ops =
 	 |(((unsigned int)(off)) & 0xfcU)	\
 	 |1UL)
 
-static unsigned long u4_pcie_cfg_access(struct pci_controller* hose,
+static volatile void __iomem *u4_pcie_cfg_access(struct pci_controller* hose,
 					u8 bus, u8 dev_fn, int offset)
 {
 	unsigned int caddr;
@@ -492,14 +490,14 @@ static unsigned long u4_pcie_cfg_access(
 	} while (in_le32(hose->cfg_addr) != caddr);
 
 	offset &= 0x03;
-	return ((unsigned long)hose->cfg_data) + offset;
+	return hose->cfg_data + offset;
 }
 
 static int u4_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 			       int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -515,13 +513,13 @@ static int u4_pcie_read_config(struct pc
 	 */
 	switch (len) {
 	case 1:
-		*val = in_8((u8 *)addr);
+		*val = in_8(addr);
 		break;
 	case 2:
-		*val = in_le16((u16 *)addr);
+		*val = in_le16(addr);
 		break;
 	default:
-		*val = in_le32((u32 *)addr);
+		*val = in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -531,7 +529,7 @@ static int u4_pcie_write_config(struct p
 				int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	unsigned long addr;
+	volatile void __iomem *addr;
 
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
@@ -547,16 +545,16 @@ static int u4_pcie_write_config(struct p
 	 */
 	switch (len) {
 	case 1:
-		out_8((u8 *)addr, val);
-		(void) in_8((u8 *)addr);
+		out_8(addr, val);
+		(void) in_8(addr);
 		break;
 	case 2:
-		out_le16((u16 *)addr, val);
-		(void) in_le16((u16 *)addr);
+		out_le16(addr, val);
+		(void) in_le16(addr);
 		break;
 	default:
-		out_le32((u32 *)addr, val);
-		(void) in_le32((u32 *)addr);
+		out_le32(addr, val);
+		(void) in_le32(addr);
 		break;
 	}
 	return PCIBIOS_SUCCESSFUL;
@@ -773,8 +771,7 @@ static void __init setup_u3_ht(struct pc
 	 * the reg address cell, we shall fix that by killing struct
 	 * reg_property and using some accessor functions instead
 	 */
-	hose->cfg_data = (volatile unsigned char *)ioremap(0xf2000000,
-							   0x02000000);
+	hose->cfg_data = ioremap(0xf2000000, 0x02000000);
 
 	/*
 	 * /ht node doesn't expose a "ranges" property, so we "remove"
-- 
0.99.9.GIT

