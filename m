Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWCWUFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWCWUFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWCWUFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:05:06 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:53392 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422666AbWCWUFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:05:03 -0500
Date: Thu, 23 Mar 2006 15:04:51 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 5/10] 64 bit resources drivers net changes
Message-ID: <20060323200451.GI7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com> <20060323200227.GG7175@in.ibm.com> <20060323200342.GH7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200342.GH7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required under drivers/net/* for 64bit resources.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Murali M Chakravarthy <muralim@in.ibm.com>
Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/net/3c59x.c            |    6 ++++--
 drivers/net/8139cp.c           |   11 ++++++-----
 drivers/net/8139too.c          |    6 +++---
 drivers/net/e100.c             |    4 ++--
 drivers/net/skge.c             |    4 ++--
 drivers/net/sky2.c             |    6 +++---
 drivers/net/tulip/de2104x.c    |    9 +++++----
 drivers/net/tulip/tulip_core.c |    6 +++---
 drivers/net/typhoon.c          |    5 +++--
 drivers/net/wan/dscc4.c        |   12 ++++++------
 drivers/net/wan/pc300_drv.c    |    4 ++--
 11 files changed, 39 insertions(+), 34 deletions(-)

diff -puN drivers/net/3c59x.c~64bit-resources-drivers-net-changes drivers/net/3c59x.c
--- linux-2.6.16-mm1/drivers/net/3c59x.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/3c59x.c	2006-03-23 11:39:08.000000000 -0500
@@ -1413,8 +1413,10 @@ static int __devinit vortex_probe1(struc
 		}
 
 		if (print_info) {
-			printk(KERN_INFO "%s: CardBus functions mapped %8.8lx->%p\n",
-				print_name, pci_resource_start(pdev, 2),
+			printk(KERN_INFO "%s: CardBus functions mapped "
+				"%16.16llx->%p\n",
+				print_name,
+				(unsigned long long)pci_resource_start(pdev, 2),
 				vp->cb_fn_base);
 		}
 		EL3WINDOW(2);
diff -puN drivers/net/8139cp.c~64bit-resources-drivers-net-changes drivers/net/8139cp.c
--- linux-2.6.16-mm1/drivers/net/8139cp.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/8139cp.c	2006-03-23 11:39:08.000000000 -0500
@@ -1671,7 +1671,7 @@ static int cp_init_one (struct pci_dev *
 	struct cp_private *cp;
 	int rc;
 	void __iomem *regs;
-	long pciaddr;
+	u64 pciaddr;
 	unsigned int addr_len, i, pci_using_dac;
 	u8 pci_rev;
 
@@ -1731,8 +1731,8 @@ static int cp_init_one (struct pci_dev *
 	}
 	if (pci_resource_len(pdev, 1) < CP_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		printk(KERN_ERR PFX "MMIO resource (%llx) too small on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pci_name(pdev));
 		goto err_out_res;
 	}
 
@@ -1764,8 +1764,9 @@ static int cp_init_one (struct pci_dev *
 	regs = ioremap(pciaddr, CP_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		printk(KERN_ERR PFX "Cannot map PCI MMIO (%llx@%llx) on pci dev %s\n",
+			(unsigned long long)pci_resource_len(pdev, 1),
+			(unsigned long long)pciaddr, pci_name(pdev));
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
diff -puN drivers/net/8139too.c~64bit-resources-drivers-net-changes drivers/net/8139too.c
--- linux-2.6.16-mm1/drivers/net/8139too.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/8139too.c	2006-03-23 11:39:08.000000000 -0500
@@ -1341,9 +1341,9 @@ static int rtl8139_open (struct net_devi
 	netif_start_queue (dev);
 
 	if (netif_msg_ifup(tp))
-		printk(KERN_DEBUG "%s: rtl8139_open() ioaddr %#lx IRQ %d"
-			" GP Pins %2.2x %s-duplex.\n",
-			dev->name, pci_resource_start (tp->pci_dev, 1),
+		printk(KERN_DEBUG "%s: rtl8139_open() ioaddr %#llx IRQ %d"
+			" GP Pins %2.2x %s-duplex.\n", dev->name,
+			(unsigned long long)pci_resource_start (tp->pci_dev, 1),
 			dev->irq, RTL_R8 (MediaStatus),
 			tp->mii.full_duplex ? "full" : "half");
 
diff -puN drivers/net/e100.c~64bit-resources-drivers-net-changes drivers/net/e100.c
--- linux-2.6.16-mm1/drivers/net/e100.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/e100.c	2006-03-23 11:39:08.000000000 -0500
@@ -2624,9 +2624,9 @@ static int __devinit e100_probe(struct p
 		goto err_out_free;
 	}
 
-	DPRINTK(PROBE, INFO, "addr 0x%lx, irq %d, "
+	DPRINTK(PROBE, INFO, "addr 0x%llx, irq %d, "
 		"MAC addr %02X:%02X:%02X:%02X:%02X:%02X\n",
-		pci_resource_start(pdev, 0), pdev->irq,
+		(unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
 		netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
 		netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);
 
diff -puN drivers/net/skge.c~64bit-resources-drivers-net-changes drivers/net/skge.c
--- linux-2.6.16-mm1/drivers/net/skge.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/skge.c	2006-03-23 11:39:08.000000000 -0500
@@ -3324,8 +3324,8 @@ static int __devinit skge_probe(struct p
 	if (err)
 		goto err_out_free_irq;
 
-	printk(KERN_INFO PFX DRV_VERSION " addr 0x%lx irq %d chip %s rev %d\n",
-	       pci_resource_start(pdev, 0), pdev->irq,
+	printk(KERN_INFO PFX DRV_VERSION " addr 0x%llx irq %d chip %s rev %d\n",
+	       (unsigned long long)pci_resource_start(pdev, 0), pdev->irq,
 	       skge_board_name(hw), hw->chip_rev);
 
 	if ((dev = skge_devinit(hw, 0, using_dac)) == NULL)
diff -puN drivers/net/sky2.c~64bit-resources-drivers-net-changes drivers/net/sky2.c
--- linux-2.6.16-mm1/drivers/net/sky2.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/sky2.c	2006-03-23 11:39:08.000000000 -0500
@@ -3214,9 +3214,9 @@ static int __devinit sky2_probe(struct p
 	if (err)
 		goto err_out_iounmap;
 
-	printk(KERN_INFO PFX "v%s addr 0x%lx irq %d Yukon-%s (0x%x) rev %d\n",
-	       DRV_VERSION, pci_resource_start(pdev, 0), pdev->irq,
-	       yukon2_name[hw->chip_id - CHIP_ID_YUKON_XL],
+	printk(KERN_INFO PFX "v%s addr 0x%llx irq %d Yukon-%s (0x%x) rev %d\n",
+	       DRV_VERSION, (unsigned long long)pci_resource_start(pdev, 0),
+	       pdev->irq, yukon2_name[hw->chip_id - CHIP_ID_YUKON_XL],
 	       hw->chip_id, hw->chip_rev);
 
 	dev = sky2_init_netdev(hw, 0, using_dac);
diff -puN drivers/net/tulip/de2104x.c~64bit-resources-drivers-net-changes drivers/net/tulip/de2104x.c
--- linux-2.6.16-mm1/drivers/net/tulip/de2104x.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/tulip/de2104x.c	2006-03-23 11:39:08.000000000 -0500
@@ -2007,8 +2007,8 @@ static int __init de_init_one (struct pc
 	}
 	if (pci_resource_len(pdev, 1) < DE_REGS_SIZE) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "MMIO resource (%lx) too small on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pci_name(pdev));
+		printk(KERN_ERR PFX "MMIO resource (%llx) too small on pci dev %s\n",
+		       (unsigned long long)pci_resource_len(pdev, 1), pci_name(pdev));
 		goto err_out_res;
 	}
 
@@ -2016,8 +2016,9 @@ static int __init de_init_one (struct pc
 	regs = ioremap_nocache(pciaddr, DE_REGS_SIZE);
 	if (!regs) {
 		rc = -EIO;
-		printk(KERN_ERR PFX "Cannot map PCI MMIO (%lx@%lx) on pci dev %s\n",
-		       pci_resource_len(pdev, 1), pciaddr, pci_name(pdev));
+		printk(KERN_ERR PFX "Cannot map PCI MMIO (%llx@%lx) on pci dev %s\n",
+			(unsigned long long)pci_resource_len(pdev, 1),
+			pciaddr, pci_name(pdev));
 		goto err_out_res;
 	}
 	dev->base_addr = (unsigned long) regs;
diff -puN drivers/net/tulip/tulip_core.c~64bit-resources-drivers-net-changes drivers/net/tulip/tulip_core.c
--- linux-2.6.16-mm1/drivers/net/tulip/tulip_core.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/tulip/tulip_core.c	2006-03-23 11:39:08.000000000 -0500
@@ -1350,10 +1350,10 @@ static int __devinit tulip_init_one (str
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
-		printk (KERN_ERR PFX "%s: I/O region (0x%lx@0x%lx) too small, "
+		printk (KERN_ERR PFX "%s: I/O region (0x%llx@0x%llx) too small, "
 			"aborting\n", pci_name(pdev),
-			pci_resource_len (pdev, 0),
-			pci_resource_start (pdev, 0));
+			(unsigned long long)pci_resource_len (pdev, 0),
+			(unsigned long long)pci_resource_start (pdev, 0));
 		goto err_out_free_netdev;
 	}
 
diff -puN drivers/net/typhoon.c~64bit-resources-drivers-net-changes drivers/net/typhoon.c
--- linux-2.6.16-mm1/drivers/net/typhoon.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/typhoon.c	2006-03-23 11:39:08.000000000 -0500
@@ -2568,9 +2568,10 @@ typhoon_init_one(struct pci_dev *pdev, c
 
 	pci_set_drvdata(pdev, dev);
 
-	printk(KERN_INFO "%s: %s at %s 0x%lx, ",
+	printk(KERN_INFO "%s: %s at %s 0x%llx, ",
 	       dev->name, typhoon_card_info[card_id].name,
-	       use_mmio ? "MMIO" : "IO", pci_resource_start(pdev, use_mmio));
+	       use_mmio ? "MMIO" : "IO",
+	       (unsigned long long)pci_resource_start(pdev, use_mmio));
 	for(i = 0; i < 5; i++)
 		printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x\n", dev->dev_addr[i]);
diff -puN drivers/net/wan/dscc4.c~64bit-resources-drivers-net-changes drivers/net/wan/dscc4.c
--- linux-2.6.16-mm1/drivers/net/wan/dscc4.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/wan/dscc4.c	2006-03-23 11:39:08.000000000 -0500
@@ -732,15 +732,15 @@ static int __devinit dscc4_init_one(stru
 	ioaddr = ioremap(pci_resource_start(pdev, 0),
 					pci_resource_len(pdev, 0));
 	if (!ioaddr) {
-		printk(KERN_ERR "%s: cannot remap MMIO region %lx @ %lx\n",
-			DRV_NAME, pci_resource_len(pdev, 0),
-			pci_resource_start(pdev, 0));
+		printk(KERN_ERR "%s: cannot remap MMIO region %llx @ %llx\n",
+			DRV_NAME, (unsigned long long)pci_resource_len(pdev, 0),
+			(unsigned long long)pci_resource_start(pdev, 0));
 		rc = -EIO;
 		goto err_free_mmio_regions_2;
 	}
-	printk(KERN_DEBUG "Siemens DSCC4, MMIO at %#lx (regs), %#lx (lbi), IRQ %d\n",
-	        pci_resource_start(pdev, 0),
-	        pci_resource_start(pdev, 1), pdev->irq);
+	printk(KERN_DEBUG "Siemens DSCC4, MMIO at %#llx (regs), %#llx (lbi), IRQ %d\n",
+	        (unsigned long long)pci_resource_start(pdev, 0),
+	        (unsigned long long)pci_resource_start(pdev, 1), pdev->irq);
 
 	/* Cf errata DS5 p.2 */
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0xf8);
diff -puN drivers/net/wan/pc300_drv.c~64bit-resources-drivers-net-changes drivers/net/wan/pc300_drv.c
--- linux-2.6.16-mm1/drivers/net/wan/pc300_drv.c~64bit-resources-drivers-net-changes	2006-03-23 11:39:08.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/net/wan/pc300_drv.c	2006-03-23 11:39:08.000000000 -0500
@@ -3445,9 +3445,9 @@ cpc_init_one(struct pci_dev *pdev, const
 
 	card = (pc300_t *) kmalloc(sizeof(pc300_t), GFP_KERNEL);
 	if (card == NULL) {
-		printk("PC300 found at RAM 0x%08lx, "
+		printk("PC300 found at RAM 0x%016llx, "
 		       "but could not allocate card structure.\n",
-		       pci_resource_start(pdev, 3));
+		       (unsigned long long)pci_resource_start(pdev, 3));
 		err = -ENOMEM;
 		goto err_disable_dev;
 	}
_
