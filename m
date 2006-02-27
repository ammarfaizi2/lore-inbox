Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWB0W2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWB0W2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWB0W2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:28:04 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20716 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750941AbWB0W2C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:28:02 -0500
Date: Mon, 27 Feb 2006 23:24:38 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       John Zielinski <john_ml@undead.cc>
Subject: Pull request for 'for-jeff' branch
Message-ID: <20060227222438.GA24788@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <4402934B.7040506@pobox.com> <20060227180433.GA20275@electric-eye.fr.zoreil.com> <4403472F.2090808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4403472F.2090808@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from branch 'for-jeff' to get the changes below:

git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git

Shortlog
--------
$ git rev-list --pretty master..HEAD | git shortlog

Francois Romieu:
      via-velocity: fix memory corruption when changing the mtu
      8139cp: fix broken suspend/resume


Patch
-----
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
