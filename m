Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVBOAwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVBOAwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVBOAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:52:43 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:28392 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261462AbVBOAvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:51:46 -0500
Date: Tue, 15 Feb 2005 01:51:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Cc: ncunningham@cyclades.com, bernard@blackham.com.au, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Fix u32 vs. pm_message_t in network device drivers
Message-ID: <20050215005121.GF5415@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix confusion in network device drivers. No code
changes. Please apply,
								Pavel
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/net/3c59x.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/net/3c59x.c	2005-02-15 01:04:10.000000000 +0100
@@ -964,7 +964,7 @@
 
 #ifdef CONFIG_PM
 
-static int vortex_suspend (struct pci_dev *pdev, u32 state)
+static int vortex_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
--- clean-mm/drivers/net/8139too.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/net/8139too.c	2005-02-15 01:04:10.000000000 +0100
@@ -2558,7 +2558,7 @@
 
 #ifdef CONFIG_PM
 
-static int rtl8139_suspend (struct pci_dev *pdev, u32 state)
+static int rtl8139_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = netdev_priv(dev);
--- clean-mm/drivers/net/amd8111e.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/net/amd8111e.c	2005-02-15 01:04:10.000000000 +0100
@@ -1797,7 +1797,7 @@
 	if(!err)
 		netif_wake_queue(dev);
 }
-static int amd8111e_suspend(struct pci_dev *pci_dev, u32 state)
+static int amd8111e_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {	
 	struct net_device *dev = pci_get_drvdata(pci_dev);
 	struct amd8111e_priv *lp = netdev_priv(dev);
--- clean-mm/drivers/net/b44.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/net/b44.c	2005-02-15 01:04:10.000000000 +0100
@@ -1910,7 +1910,7 @@
 	}
 }
 
-static int b44_suspend(struct pci_dev *pdev, u32 state)
+static int b44_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = netdev_priv(dev);
--- clean-mm/drivers/net/e100.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/net/e100.c	2005-02-15 01:04:10.000000000 +0100
@@ -2310,7 +2310,7 @@
 }
 
 #ifdef CONFIG_PM
-static int e100_suspend(struct pci_dev *pdev, u32 state)
+static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
@@ -2321,7 +2321,7 @@
 	netif_device_detach(netdev);
 
 	pci_save_state(pdev);
-	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
--- clean-mm/drivers/net/eepro100.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/net/eepro100.c	2005-02-15 01:04:10.000000000 +0100
@@ -2271,7 +2271,7 @@
 }
 
 #ifdef CONFIG_PM
-static int eepro100_suspend(struct pci_dev *pdev, u32 state)
+static int eepro100_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct speedo_private *sp = netdev_priv(dev);
@@ -2289,7 +2289,7 @@
 	
 	/* XXX call pci_set_power_state ()? */
 	pci_disable_device(pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 	return 0;
 }
 
@@ -2299,7 +2299,7 @@
 	struct speedo_private *sp = netdev_priv(dev);
 	void __iomem *ioaddr = sp->regs;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
--- clean-mm/drivers/net/epic100.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/net/epic100.c	2005-02-15 01:04:10.000000000 +0100
@@ -1624,7 +1624,7 @@
 
 #ifdef CONFIG_PM
 
-static int epic_suspend (struct pci_dev *pdev, u32 state)
+static int epic_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	long ioaddr = dev->base_addr;
--- clean-mm/drivers/net/irda/donauboe.c	2005-02-15 00:34:38.000000000 +0100
+++ linux-mm/drivers/net/irda/donauboe.c	2005-02-15 01:04:10.000000000 +0100
@@ -1712,7 +1712,7 @@
 }
 
 static int
-toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
+toshoboe_gotosleep (struct pci_dev *pci_dev, pm_message_t crap)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
   unsigned long flags;
--- clean-mm/drivers/net/natsemi.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/net/natsemi.c	2005-02-15 01:04:10.000000000 +0100
@@ -3160,7 +3160,7 @@
  * Interrupts must be disabled, otherwise hands_off can cause irq storms.
  */
 
-static int natsemi_suspend (struct pci_dev *pdev, u32 state)
+static int natsemi_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
--- clean-mm/drivers/net/ne2k-pci.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/net/ne2k-pci.c	2005-02-15 01:04:10.000000000 +0100
@@ -654,13 +654,13 @@
 }
 
 #ifdef CONFIG_PM
-static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
+static int ne2k_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 
 	netif_device_detach(dev);
 	pci_save_state(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
--- clean-mm/drivers/net/sis900.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/net/sis900.c	2005-02-15 01:04:10.000000000 +0100
@@ -2261,7 +2261,7 @@
 
 #ifdef CONFIG_PM
 
-static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
+static int sis900_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
 	long ioaddr = net_dev->base_addr;
--- clean-mm/drivers/net/sungem.c	2005-02-03 22:27:15.000000000 +0100
+++ linux-mm/drivers/net/sungem.c	2005-02-15 01:04:10.000000000 +0100
@@ -2356,7 +2356,7 @@
 }
 
 #ifdef CONFIG_PM
-static int gem_suspend(struct pci_dev *pdev, u32 state)
+static int gem_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct gem *gp = dev->priv;
--- clean-mm/drivers/net/tg3.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/net/tg3.c	2005-02-15 01:04:10.000000000 +0100
@@ -8918,7 +8918,7 @@
 	}
 }
 
-static int tg3_suspend(struct pci_dev *pdev, u32 state)
+static int tg3_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(dev);
@@ -8945,7 +8945,7 @@
 	spin_unlock(&tp->tx_lock);
 	spin_unlock_irq(&tp->lock);
 
-	err = tg3_set_power_state(tp, state);
+	err = tg3_set_power_state(tp, pci_choose_state(pdev, state));
 	if (err) {
 		spin_lock_irq(&tp->lock);
 		spin_lock(&tp->tx_lock);
--- clean-mm/drivers/net/tulip/tulip_core.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/net/tulip/tulip_core.c	2005-02-15 01:04:10.000000000 +0100
@@ -1749,7 +1749,7 @@
 
 #ifdef CONFIG_PM
 
-static int tulip_suspend (struct pci_dev *pdev, u32 state)
+static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
--- clean-mm/drivers/net/typhoon.c	2005-02-15 00:46:41.000000000 +0100
+++ linux-mm/drivers/net/typhoon.c	2005-02-15 01:04:10.000000000 +0100
@@ -1874,7 +1874,7 @@
 }
 
 static int
-typhoon_sleep(struct typhoon *tp, int state, u16 events)
+typhoon_sleep(struct typhoon *tp, pci_power_t state, u16 events)
 {
 	struct pci_dev *pdev = tp->pdev;
 	void __iomem *ioaddr = tp->ioaddr;
@@ -2155,7 +2155,7 @@
 		goto out;
 	}
 
-	if(typhoon_sleep(tp, 3, 0) < 0) 
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) 
 		printk(KERN_ERR "%s: unable to go back to sleep\n", dev->name);
 
 out:
@@ -2182,7 +2182,7 @@
 	if(typhoon_boot_3XP(tp, TYPHOON_STATUS_WAITING_FOR_HOST) < 0)
 		printk(KERN_ERR "%s: unable to boot sleep image\n", dev->name);
 
-	if(typhoon_sleep(tp, 3, 0) < 0)
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0)
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 
 	return 0;
@@ -2222,7 +2222,7 @@
 }
 
 static int
-typhoon_suspend(struct pci_dev *pdev, u32 state)
+typhoon_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct typhoon *tp = netdev_priv(dev);
@@ -2532,7 +2532,7 @@
 	if(xp_resp[0].numDesc != 0)
 		tp->capabilities |= TYPHOON_WAKEUP_NEEDS_RESET;
 
-	if(typhoon_sleep(tp, 3, 0) < 0) {
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) {
 		printk(ERR_PFX "%s: cannot put adapter to sleep\n",
 		       pci_name(pdev));
 		err = -EIO;
--- clean-mm/drivers/net/via-rhine.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/net/via-rhine.c	2005-02-15 01:04:10.000000000 +0100
@@ -1937,7 +1937,7 @@
 }
 
 #ifdef CONFIG_PM
-static int rhine_suspend(struct pci_dev *pdev, u32 state)
+static int rhine_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rhine_private *rp = netdev_priv(dev);
--- clean-mm/drivers/net/via-velocity.c	2005-02-15 00:34:39.000000000 +0100
+++ linux-mm/drivers/net/via-velocity.c	2005-02-15 01:04:10.000000000 +0100
@@ -263,7 +263,7 @@
 
 #ifdef CONFIG_PM
 
-static int velocity_suspend(struct pci_dev *pdev, u32 state);
+static int velocity_suspend(struct pci_dev *pdev, pm_message_t state);
 static int velocity_resume(struct pci_dev *pdev);
 
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
@@ -3210,7 +3210,7 @@
 	return 0;
 }
 
-static int velocity_suspend(struct pci_dev *pdev, u32 state)
+static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct velocity_info *vptr = pci_get_drvdata(pdev);
 	unsigned long flags;
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
