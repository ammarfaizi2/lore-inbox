Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTAXSTV>; Fri, 24 Jan 2003 13:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbTAXSTV>; Fri, 24 Jan 2003 13:19:21 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:27402 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264610AbTAXSTS>; Fri, 24 Jan 2003 13:19:18 -0500
Date: Fri, 24 Jan 2003 21:27:48 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       willy@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124212748.C25285@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes actual bug when the card lose its MSI state after
reset.

The additional tg3 specific fix is still required,
as Jeff.Wiedemeier@hp.com pointed out:
> The TG3 will only do MSI if it's device-specific MSGINT_MODE register is
> set to enable MSI. If it's not set that way, you don't get MSI even if
> the config space says you do.

Ivan.

--- 2.5.59/drivers/net/tg3.c	Fri Jan 17 05:22:16 2003
+++ linux/drivers/net/tg3.c	Fri Jan 24 19:28:44 2003
@@ -3096,7 +3096,12 @@ static void tg3_chip_reset(struct tg3 *t
 		val |= PCISTATE_RETRY_SAME_DMA;
 	pci_write_config_dword(tp->pdev, TG3PCI_PCISTATE, val);
 
-	pci_restore_state(tp->pdev, tp->pci_cfg_state);
+	pci_restore_extended_state(tp->pdev, tp->pci_cfg_state);
+
+	/* Make sure MSGINT_MODE is set if MSI is configured. */
+	pci_read_config_dword(tp->pdev, TG3PCI_MSI_CAP_ID, &val);
+	if ((val >> 16) & PCI_MSI_FLAGS_ENABLE)
+		tw32(MSGINT_MODE, MSGINT_MODE_ENABLE);
 
 	/* Make sure PCI-X relaxed ordering bit is clear. */
 	pci_read_config_dword(tp->pdev, TG3PCI_X_CAPS, &val);
@@ -6684,11 +6689,19 @@ static int __devinit tg3_init_one(struct
 	spin_lock_init(&tp->tx_lock);
 	spin_lock_init(&tp->indirect_lock);
 
+	err = -ENOMEM;
+
+	tp->pci_cfg_state = pci_alloc_extended_state(pdev);
+	if (!tp->pci_cfg_state) {
+		printk(KERN_ERR PFX "Cannot allocate pci_cfg_state, "
+		       "aborting.\n");
+		goto err_out_free_dev;
+	}
+
 	tp->regs = (unsigned long) ioremap(tg3reg_base, tg3reg_len);
 	if (tp->regs == 0UL) {
 		printk(KERN_ERR PFX "Cannot map device registers, "
 		       "aborting.\n");
-		err = -ENOMEM;
 		goto err_out_free_dev;
 	}
 
@@ -6766,7 +6779,7 @@ static int __devinit tg3_init_one(struct
 	 * of the PCI config space.  We need to restore this after
 	 * GRC_MISC_CFG core clock resets and some resume events.
 	 */
-	pci_save_state(tp->pdev, tp->pci_cfg_state);
+	pci_save_extended_state(tp->pdev, tp->pci_cfg_state);
 
 	printk(KERN_INFO "%s: Tigon3 [partno(%s) rev %04x PHY(%s)] (PCI%s:%s:%s) %sBaseT Ethernet ",
 	       dev->name,
@@ -6806,8 +6819,11 @@ static void __devexit tg3_remove_one(str
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev) {
+		struct tg3 *tp = dev->priv;
+
 		unregister_netdev(dev);
-		iounmap((void *) ((struct tg3 *)(dev->priv))->regs);
+		iounmap((void *)tp->regs);
+		kfree(tp->pci_cfg_state);
 		kfree(dev);
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
--- 2.5.59/drivers/net/tg3.h	Fri Jan 17 05:21:42 2003
+++ linux/drivers/net/tg3.h	Fri Jan 24 19:24:02 2003
@@ -1847,7 +1847,7 @@ struct tg3 {
 	u8				pci_lat_timer;
 	u8				pci_hdr_type;
 	u8				pci_bist;
-	u32				pci_cfg_state[64 / sizeof(u32)];
+	u32				*pci_cfg_state;
 
 	int				pm_cap;
 
