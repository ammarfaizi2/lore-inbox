Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVIKDLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVIKDLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 23:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVIKDLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 23:11:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932342AbVIKDLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 23:11:25 -0400
Date: Sat, 10 Sep 2005 20:11:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sungem driver patch testing..
Message-ID: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been grepping around for things that do their own PCI ROM mapping and 
do it badly, and one thing that matches that description is the sungem 
ethernet driver on PC's.

If anybody has such a beast, can you please try this patch and report 
whether it works for you? 

		Linus

---
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -2817,7 +2817,7 @@ static int gem_ioctl(struct net_device *
 
 #if (!defined(__sparc__) && !defined(CONFIG_PPC_PMAC))
 /* Fetch MAC address from vital product data of PCI ROM. */
-static void find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)
+static int find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)
 {
 	int this_offset;
 
@@ -2838,35 +2838,27 @@ static void find_eth_addr_in_vpd(void __
 
 		for (i = 0; i < 6; i++)
 			dev_addr[i] = readb(p + i);
-		break;
+		return 1;
 	}
+	return 0;
 }
 
 static void get_gem_mac_nonobp(struct pci_dev *pdev, unsigned char *dev_addr)
 {
-	u32 rom_reg_orig;
-	void __iomem *p;
-
-	if (pdev->resource[PCI_ROM_RESOURCE].parent == NULL) {
-		if (pci_assign_resource(pdev, PCI_ROM_RESOURCE) < 0)
-			goto use_random;
-	}
-
-	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_reg_orig);
-	pci_write_config_dword(pdev, pdev->rom_base_reg,
-			       rom_reg_orig | PCI_ROM_ADDRESS_ENABLE);
+	size_t size;
+	void __iomem *p = pci_map_rom(pdev, &size);
 
-	p = ioremap(pci_resource_start(pdev, PCI_ROM_RESOURCE), (64 * 1024));
-	if (p != NULL && readb(p) == 0x55 && readb(p + 1) == 0xaa)
-		find_eth_addr_in_vpd(p, (64 * 1024), dev_addr);
+	if (p) {
+			int found;
 
-	if (p != NULL)
-		iounmap(p);
-
-	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_reg_orig);
-	return;
+		found = readb(p) == 0x55 &&
+			readb(p + 1) == 0xaa &&
+			find_eth_addr_in_vpd(p, (64 * 1024), dev_addr);
+		pci_unmap_rom(pdev, p);
+		if (found)
+			return;
+	}
 
-use_random:
 	/* Sun MAC prefix then 3 random bytes. */
 	dev_addr[0] = 0x08;
 	dev_addr[1] = 0x00;
