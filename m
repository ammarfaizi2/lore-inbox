Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVIOBEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVIOBEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVIOBEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030306AbVIOBEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:37 -0400
Message-Id: <20050915010405.997069000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Willy Tarreau <willy@w.ods.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 06/11] [stable] [ROM 3/3] Sun HME: enable and map PCI ROM properly
Content-Disposition: inline; filename=sunhme-enable-and-map-pci-rom-properly.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This ports the Sun GEM ROM mapping/enable fixes it sunhme (which used
the same PCI ROM mapping code).

Without this, I get NULL MAC addresses for all 4 ports (it's a SUN QFE).
With it, I get the correct addresses (the ones printed on the label on
the card).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/net/sunhme.c |   45 ++++++++++++++++++---------------------------
 1 files changed, 18 insertions(+), 27 deletions(-)

Index: linux-2.6.13.y/drivers/net/sunhme.c
===================================================================
--- linux-2.6.13.y.orig/drivers/net/sunhme.c
+++ linux-2.6.13.y/drivers/net/sunhme.c
@@ -2954,7 +2954,7 @@ static int is_quattro_p(struct pci_dev *
 }
 
 /* Fetch MAC address from vital product data of PCI ROM. */
-static void find_eth_addr_in_vpd(void __iomem *rom_base, int len, int index, unsigned char *dev_addr)
+static int find_eth_addr_in_vpd(void __iomem *rom_base, int len, int index, unsigned char *dev_addr)
 {
 	int this_offset;
 
@@ -2977,42 +2977,33 @@ static void find_eth_addr_in_vpd(void __
 
 			for (i = 0; i < 6; i++)
 				dev_addr[i] = readb(p + i);
-			break;
+			return 1;
 		}
 		index--;
 	}
+	return 0;
 }
 
 static void get_hme_mac_nonsparc(struct pci_dev *pdev, unsigned char *dev_addr)
 {
-	u32 rom_reg_orig;
-	void __iomem *p;
-	int index;
+	size_t size;
+	void __iomem *p = pci_map_rom(pdev, &size);
 
-	index = 0;
-	if (is_quattro_p(pdev))
-		index = PCI_SLOT(pdev->devfn);
-
-	if (pdev->resource[PCI_ROM_RESOURCE].parent == NULL) {
-		if (pci_assign_resource(pdev, PCI_ROM_RESOURCE) < 0)
-			goto use_random;
+	if (p) {
+		int index = 0;
+		int found;
+
+		if (is_quattro_p(pdev))
+			index = PCI_SLOT(pdev->devfn);
+
+		found = readb(p) == 0x55 &&
+			readb(p + 1) == 0xaa &&
+			find_eth_addr_in_vpd(p, (64 * 1024), index, dev_addr);
+		pci_unmap_rom(pdev, p);
+		if (found)
+			return;
 	}
 
-	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_reg_orig);
-	pci_write_config_dword(pdev, pdev->rom_base_reg,
-			       rom_reg_orig | PCI_ROM_ADDRESS_ENABLE);
-
-	p = ioremap(pci_resource_start(pdev, PCI_ROM_RESOURCE), (64 * 1024));
-	if (p != NULL && readb(p) == 0x55 && readb(p + 1) == 0xaa)
-		find_eth_addr_in_vpd(p, (64 * 1024), index, dev_addr);
-
-	if (p != NULL)
-		iounmap(p);
-
-	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_reg_orig);
-	return;
-
-use_random:
 	/* Sun MAC prefix then 3 random bytes. */
 	dev_addr[0] = 0x08;
 	dev_addr[1] = 0x00;

--
