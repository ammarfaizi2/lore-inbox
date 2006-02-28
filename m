Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932715AbWB1XKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWB1XKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWB1XKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:10:17 -0500
Received: from havoc.gtf.org ([69.61.125.42]:50073 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932706AbWB1XKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:10:15 -0500
Date: Tue, 28 Feb 2006 18:10:13 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060228231013.GA24466@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/8139cp.c         |   37 +++++++++++---------
 drivers/net/sky2.c           |   77 -------------------------------------------
 drivers/net/sky2.h           |    1 
 drivers/net/via-velocity.c   |    3 +
 net/ieee80211/ieee80211_rx.c |   16 ++------
 5 files changed, 29 insertions(+), 105 deletions(-)

Francois Romieu:
      via-velocity: fix memory corruption when changing the mtu
      8139cp: fix broken suspend/resume

Pete Zaitcev:
      ieee80211_rx.c: is_beacon

Stephen Hemminger:
      sky2: remove MSI support

diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index f822cd3..dd41049 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1118,13 +1118,18 @@ err_out:
 	return -ENOMEM;
 }
 
+static void cp_init_rings_index (struct cp_private *cp)
+{
+	cp->rx_tail = 0;
+	cp->tx_head = cp->tx_tail = 0;
+}
+
 static int cp_init_rings (struct cp_private *cp)
 {
 	memset(cp->tx_ring, 0, sizeof(struct cp_desc) * CP_TX_RING_SIZE);
 	cp->tx_ring[CP_TX_RING_SIZE - 1].opts1 = cpu_to_le32(RingEnd);
 
-	cp->rx_tail = 0;
-	cp->tx_head = cp->tx_tail = 0;
+	cp_init_rings_index(cp);
 
 	return cp_refill_rx (cp);
 }
@@ -1886,30 +1891,30 @@ static int cp_suspend (struct pci_dev *p
 
 	spin_unlock_irqrestore (&cp->lock, flags);
 
-	if (cp->pdev && cp->wol_enabled) {
-		pci_save_state (cp->pdev);
-		cp_set_d3_state (cp);
-	}
+	pci_save_state(pdev);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), cp->wol_enabled);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
 
 static int cp_resume (struct pci_dev *pdev)
 {
-	struct net_device *dev;
-	struct cp_private *cp;
+	struct net_device *dev = pci_get_drvdata (pdev);
+	struct cp_private *cp = netdev_priv(dev);
 	unsigned long flags;
 
-	dev = pci_get_drvdata (pdev);
-	cp  = netdev_priv(dev);
+	if (!netif_running(dev))
+		return 0;
 
 	netif_device_attach (dev);
-	
-	if (cp->pdev && cp->wol_enabled) {
-		pci_set_power_state (cp->pdev, PCI_D0);
-		pci_restore_state (cp->pdev);
-	}
-	
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	/* FIXME: sh*t may happen if the Rx ring buffer is depleted */
+	cp_init_rings_index (cp);
 	cp_init_hw (cp);
 	netif_start_queue (dev);
 
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index ca8160d..72c1630 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -96,10 +96,6 @@ static int copybreak __read_mostly = 256
 module_param(copybreak, int, 0);
 MODULE_PARM_DESC(copybreak, "Receive copy threshold");
 
-static int disable_msi = 0;
-module_param(disable_msi, int, 0);
-MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
-
 static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9000) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9E00) },
@@ -3126,61 +3122,6 @@ static void __devinit sky2_show_addr(str
 		       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 }
 
-/* Handle software interrupt used during MSI test */
-static irqreturn_t __devinit sky2_test_intr(int irq, void *dev_id,
-					    struct pt_regs *regs)
-{
-	struct sky2_hw *hw = dev_id;
-	u32 status = sky2_read32(hw, B0_Y2_SP_ISRC2);
-
-	if (status == 0)
-		return IRQ_NONE;
-
-	if (status & Y2_IS_IRQ_SW) {
-		sky2_write8(hw, B0_CTST, CS_CL_SW_IRQ);
-		hw->msi = 1;
-	}
-	sky2_write32(hw, B0_Y2_SP_ICR, 2);
-
-	sky2_read32(hw, B0_IMSK);
-	return IRQ_HANDLED;
-}
-
-/* Test interrupt path by forcing a a software IRQ */
-static int __devinit sky2_test_msi(struct sky2_hw *hw)
-{
-	struct pci_dev *pdev = hw->pdev;
-	int i, err;
-
-	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
-
-	err = request_irq(pdev->irq, sky2_test_intr, SA_SHIRQ, DRV_NAME, hw);
-	if (err) {
-		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
-		       pci_name(pdev), pdev->irq);
-		return err;
-	}
-
-	sky2_write8(hw, B0_CTST, CS_ST_SW_IRQ);
-	wmb();
-
-	for (i = 0; i < 10; i++) {
-		barrier();
-		if (hw->msi)
-			goto found;
-		mdelay(1);
-	}
-
-	err = -EOPNOTSUPP;
-	sky2_write8(hw, B0_CTST, CS_CL_SW_IRQ);
- found:
-	sky2_write32(hw, B0_IMSK, 0);
-
-	free_irq(pdev->irq, hw);
-
-	return err;
-}
-
 static int __devinit sky2_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -3302,20 +3243,6 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
-	if (!disable_msi && pci_enable_msi(pdev) == 0) {
-		err = sky2_test_msi(hw);
-		if (err == -EOPNOTSUPP) {
-			/* MSI test failed, go back to INTx mode */
-			printk(KERN_WARNING PFX "%s: No interrupt was generated using MSI, "
-			       "switching to INTx mode. Please report this failure to "
-			       "the PCI maintainer and include system chipset information.\n",
-			       pci_name(pdev));
-			pci_disable_msi(pdev);
-		}
-		else if (err)
-			goto err_out_unregister;
-	}
-
 	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ | SA_SAMPLE_RANDOM,
 			  DRV_NAME, hw);
 	if (err) {
@@ -3332,8 +3259,6 @@ static int __devinit sky2_probe(struct p
 	return 0;
 
 err_out_unregister:
-	if (hw->msi)
-		pci_disable_msi(pdev);
 	if (dev1) {
 		unregister_netdev(dev1);
 		free_netdev(dev1);
@@ -3376,8 +3301,6 @@ static void __devexit sky2_remove(struct
 	sky2_read8(hw, B0_CTST);
 
 	free_irq(pdev->irq, hw);
-	if (hw->msi)
-		pci_disable_msi(pdev);
 	pci_free_consistent(pdev, STATUS_LE_BYTES, hw->st_le, hw->st_dma);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 3edb980..dce955c 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1881,7 +1881,6 @@ struct sky2_hw {
 	u32		     intr_mask;
 
 	int		     pm_cap;
-	int		     msi;
 	u8	     	     chip_id;
 	u8		     chip_rev;
 	u8		     copper;
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index c2d5907..ed1f837 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -1106,6 +1106,9 @@ static void velocity_free_rd_ring(struct
 
 	for (i = 0; i < vptr->options.numrx; i++) {
 		struct velocity_rd_info *rd_info = &(vptr->rd_info[i]);
+		struct rx_desc *rd = vptr->rd_ring + i;
+
+		memset(rd, 0, sizeof(*rd));
 
 		if (!rd_info->skb)
 			continue;
diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index 960aa78..b410ab8 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -1301,7 +1301,7 @@ static void update_network(struct ieee80
 	/* dst->last_associate is not overwritten */
 }
 
-static inline int is_beacon(int fc)
+static inline int is_beacon(__le16 fc)
 {
 	return (WLAN_FC_GET_STYPE(le16_to_cpu(fc)) == IEEE80211_STYPE_BEACON);
 }
@@ -1348,9 +1348,7 @@ static void ieee80211_process_probe_resp
 				     escape_essid(info_element->data,
 						  info_element->len),
 				     MAC_ARG(beacon->header.addr3),
-				     is_beacon(le16_to_cpu
-					       (beacon->header.
-						frame_ctl)) ?
+				     is_beacon(beacon->header.frame_ctl) ?
 				     "BEACON" : "PROBE RESPONSE");
 		return;
 	}
@@ -1400,9 +1398,7 @@ static void ieee80211_process_probe_resp
 				     escape_essid(network.ssid,
 						  network.ssid_len),
 				     MAC_ARG(network.bssid),
-				     is_beacon(le16_to_cpu
-					       (beacon->header.
-						frame_ctl)) ?
+				     is_beacon(beacon->header.frame_ctl) ?
 				     "BEACON" : "PROBE RESPONSE");
 #endif
 		memcpy(target, &network, sizeof(*target));
@@ -1412,16 +1408,14 @@ static void ieee80211_process_probe_resp
 				     escape_essid(target->ssid,
 						  target->ssid_len),
 				     MAC_ARG(target->bssid),
-				     is_beacon(le16_to_cpu
-					       (beacon->header.
-						frame_ctl)) ?
+				     is_beacon(beacon->header.frame_ctl) ?
 				     "BEACON" : "PROBE RESPONSE");
 		update_network(target, &network);
 	}
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
 
-	if (is_beacon(le16_to_cpu(beacon->header.frame_ctl))) {
+	if (is_beacon(beacon->header.frame_ctl)) {
 		if (ieee->handle_beacon != NULL)
 			ieee->handle_beacon(dev, beacon, &network);
 	} else {
