Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVIKRHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVIKRHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIKRHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:07:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751104AbVIKRHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:07:35 -0400
Date: Sun, 11 Sep 2005 10:07:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sungem driver patch testing..
In-Reply-To: <20050911120332.GA7627@infradead.org>
Message-ID: <Pine.LNX.4.58.0509110940220.4912@g5.osdl.org>
References: <Pine.LNX.4.58.0509102008540.4912@g5.osdl.org>
 <20050911120332.GA7627@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Christoph Hellwig wrote:
> 
> While we're at it the cpp conditioal looks bogus.  We definitly needs this
> when plugging a SUN card into a mac.  I'd suggest compiling this
> unconditionally and fall back to it when whatever firmware method to get
> the mac address fails.

Here's a patch (on top of the previous PCI ROM mapping fix) that does
that. It seems to work for me, but I can't really test it, and it's mostly
just cleanup, so I'm not going to apply it.

David can decide to apply it or not as he sees fit (I applied the ROM
mapping fix, since the same fix was already reported to fix a real problem
on the happy-meal ethernet).

David: my G5 doesn't trigger the code, since it finds the MAC address in 
the OF tables. However, if I force that to fail (and add a few printk's), 
I get:

	OF prom reports MAC 00:0d:93:5a:8c:2c
	sungem: no MAC info in OF - falling back to PCI ROM code
	PCI ROM reports MAC 08:00:20:b6:cf:93

so the code seems to work (but because it's an Apple ROM, it doesn't
actually find the magic sequence, so it will have selected a random
address - the three last bytes will change every boot - but the thing does
work..).

Maybe the PCI rom mapping code should report when it just makes up a
random address?

		Linus
----
sungem: fall back on PCI ROM code on PMAC

This falls back to finding the MAC address from the PCI expansion ROM if 
the card information cannot be found in the Mac OF tables.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -2815,7 +2815,33 @@ static int gem_ioctl(struct net_device *
 	return rc;
 }
 
-#if (!defined(__sparc__) && !defined(CONFIG_PPC_PMAC))
+/*
+ * On Sparc, we get the MAC address from the Sun prom property tables
+ */
+#ifdef __sparc__
+
+static int __devinit gem_get_device_address(struct gem *gp)
+{
+	struct net_device *dev = gp->dev;
+	struct pci_dev *pdev = gp->pdev;
+	struct pcidev_cookie *pcp = pdev->sysdata;
+	int node = -1;
+
+	if (pcp != NULL) {
+		node = pcp->prom_node;
+		if (prom_getproplen(node, "local-mac-address") == 6)
+			prom_getproperty(node, "local-mac-address",
+					 dev->dev_addr, 6);
+		else
+			node = -1;
+	}
+	if (node == -1)
+		memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
+	return 0;
+}
+
+#else /* Not __sparc__ */
+
 /* Fetch MAC address from vital product data of PCI ROM. */
 static int find_eth_addr_in_vpd(void __iomem *rom_base, int len, unsigned char *dev_addr)
 {
@@ -2866,45 +2892,30 @@ static void get_gem_mac_nonobp(struct pc
 	get_random_bytes(dev_addr + 3, 3);
 	return;
 }
-#endif /* not Sparc and not PPC */
 
+/*
+ * On PPC PMAC, we try the OF first, then fall back to searching
+ * the PCI ROM.
+ */
 static int __devinit gem_get_device_address(struct gem *gp)
 {
-#if defined(__sparc__) || defined(CONFIG_PPC_PMAC)
+#if defined(CONFIG_PPC_PMAC)
 	struct net_device *dev = gp->dev;
-#endif
-
-#if defined(__sparc__)
-	struct pci_dev *pdev = gp->pdev;
-	struct pcidev_cookie *pcp = pdev->sysdata;
-	int node = -1;
-
-	if (pcp != NULL) {
-		node = pcp->prom_node;
-		if (prom_getproplen(node, "local-mac-address") == 6)
-			prom_getproperty(node, "local-mac-address",
-					 dev->dev_addr, 6);
-		else
-			node = -1;
-	}
-	if (node == -1)
-		memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
-#elif defined(CONFIG_PPC_PMAC)
 	unsigned char *addr;
 
 	addr = get_property(gp->of_node, "local-mac-address", NULL);
-	if (addr == NULL) {
-		printk("\n");
-		printk(KERN_ERR "%s: can't get mac-address\n", dev->name);
-		return -1;
+	if (addr) {
+		memcpy(dev->dev_addr, addr, 6);
+		return 0;
 	}
-	memcpy(dev->dev_addr, addr, 6);
-#else
-	get_gem_mac_nonobp(gp->pdev, gp->dev->dev_addr);
+	printk("sungem: no MAC info in OF - falling back to PCI ROM code\n");
 #endif
+	get_gem_mac_nonobp(gp->pdev, gp->dev->dev_addr);
 	return 0;
 }
 
+#endif /* Not sparc */
+
 static void __devexit gem_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
