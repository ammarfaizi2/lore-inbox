Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVIOBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVIOBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVIOBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030305AbVIOBEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:33 -0400
Message-Id: <20050915010405.460144000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 05/11] Sun GEM ethernet: enable and map PCI ROM properly
Content-Disposition: inline; filename=sungem-enable-and-map-pci-rom-properly.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This same patch was reported to fix the MAC address detection on sunhme
(next patch).  Most people seem to be running this on Sparcs or PPC
machines, where we get the MAC address from their respective firmware
rather than from the (previously broken) ROM mapping routines.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/net/sungem.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

Index: linux-2.6.13.y/drivers/net/sungem.c
===================================================================
--- linux-2.6.13.y.orig/drivers/net/sungem.c
+++ linux-2.6.13.y/drivers/net/sungem.c
@@ -2816,7 +2816,7 @@ static int gem_ioctl(struct net_device *
 
 #if (!defined(__sparc__) && !defined(CONFIG_PPC_PMAC))
 /* Fetch MAC address from vital product data of PCI ROM. */
-static void find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)
+static int find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)
 {
 	int this_offset;
 
@@ -2837,35 +2837,27 @@ static void find_eth_addr_in_vpd(void __
 
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

--
