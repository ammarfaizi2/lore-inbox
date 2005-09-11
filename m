Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVIKHNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVIKHNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVIKHNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:13:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10259 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932332AbVIKHNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:13:14 -0400
Date: Sun, 11 Sep 2005 09:04:07 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davem@davemloft.net
Subject: Re: sungem driver patch testing..
Message-ID: <20050911070407.GF30279@alpha.home.local>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Sep 10, 2005 at 08:11:22PM -0700, Linus Torvalds wrote:
> 
> I've been grepping around for things that do their own PCI ROM mapping and 
> do it badly, and one thing that matches that description is the sungem 
> ethernet driver on PC's.
> 
> If anybody has such a beast, can you please try this patch and report 
> whether it works for you? 

I've ported it to sunhme (which uses the same PCI ROM mapping code).
Without the patch, I get NULL MAC addresses for all 4 ports (it's a SUN
QFE). With the patch, I get the correct addresses (the ones printed on
the label on the card).

I attach the patch for sunhme, and Cc: Davem so that he updates his tree.

Thanks,
Willy


--- linux-2.6.13.1.orig/drivers/net/sunhme.c	Wed Aug 24 22:51:25 2005
+++ linux-2.6.13.1/drivers/net/sunhme.c	Sun Sep 11 09:06:26 2005
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
-
-	index = 0;
-	if (is_quattro_p(pdev))
-		index = PCI_SLOT(pdev->devfn);
-
-	if (pdev->resource[PCI_ROM_RESOURCE].parent == NULL) {
-		if (pci_assign_resource(pdev, PCI_ROM_RESOURCE) < 0)
-			goto use_random;
-	}
-
-	pci_read_config_dword(pdev, pdev->rom_base_reg, &rom_reg_orig);
-	pci_write_config_dword(pdev, pdev->rom_base_reg,
-			       rom_reg_orig | PCI_ROM_ADDRESS_ENABLE);
-
-	p = ioremap(pci_resource_start(pdev, PCI_ROM_RESOURCE), (64 * 1024));
-	if (p != NULL && readb(p) == 0x55 && readb(p + 1) == 0xaa)
-		find_eth_addr_in_vpd(p, (64 * 1024), index, dev_addr);
+	size_t size;
+	void __iomem *p = pci_map_rom(pdev, &size);
 
-	if (p != NULL)
-		iounmap(p);
-
-	pci_write_config_dword(pdev, pdev->rom_base_reg, rom_reg_orig);
-	return;
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
+	}
 
-use_random:
 	/* Sun MAC prefix then 3 random bytes. */
 	dev_addr[0] = 0x08;
 	dev_addr[1] = 0x00;



