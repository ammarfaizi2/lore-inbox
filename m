Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUHHQTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUHHQTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUHHQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:19:23 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:16880 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S265795AbUHHQSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:18:09 -0400
Date: Sun, 8 Aug 2004 16:02:47 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [1/3] via-rhine: suspend/resume support
Message-ID: <20040808140247.GA8542@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808140216.GA8181@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arkadiusz Miskiewicz

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.8-rc2-mm1/drivers/net/via-rhine.c	2004-07-30 19:19:19.000000000 +0200
+++ linux-2.6.8-rc2/drivers/net/via-rhine.c	2004-08-06 19:19:07.931310552 +0200
@@ -485,6 +485,9 @@
 	dma_addr_t tx_bufs_dma;
 
 	struct pci_dev *pdev;
+#ifdef CONFIG_PM
+	long pioaddr;
+#endif
 	struct net_device_stats stats;
 	spinlock_t lock;
 
@@ -825,6 +828,9 @@
 	dev->base_addr = ioaddr;
 	rp = netdev_priv(dev);
 	rp->quirks = quirks;
+#ifdef CONFIG_PM
+	rp->pioaddr = pioaddr;
+#endif
 
 	/* Get chip registers into a sane state */
 	rhine_power_init(dev);
@@ -1951,11 +1957,70 @@
 
 }
 
+#ifdef CONFIG_PM
+static int rhine_suspend(struct pci_dev *pdev, u32 state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rhine_private *rp = netdev_priv(dev);
+	unsigned long flags;
+
+	if (!netif_running(dev))
+		return 0;
+
+	netif_device_detach(dev);
+	pci_save_state(pdev, pdev->saved_config_space);
+
+	spin_lock_irqsave(&rp->lock, flags);
+	rhine_shutdown(&pdev->dev);
+	spin_unlock_irqrestore(&rp->lock, flags);
+
+	return 0;
+}
+
+static int rhine_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rhine_private *rp = netdev_priv(dev);
+	unsigned long flags;
+	int ret;
+
+	if (!netif_running(dev))
+		return 0;
+
+	ret = pci_set_power_state(pdev, 0);
+	if (debug > 1)
+		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",
+			dev->name, ret ? "failed" : "succeeded", ret);
+
+	pci_restore_state(pdev, pdev->saved_config_space);
+
+	spin_lock_irqsave(&rp->lock, flags);
+#ifdef USE_MMIO
+	enable_mmio(rp->pioaddr, rp->quirks);
+#endif
+	rhine_power_init(dev);
+	free_tbufs(dev);
+	free_rbufs(dev);
+	alloc_tbufs(dev);
+	alloc_rbufs(dev);
+	init_registers(dev);
+	spin_unlock_irqrestore(&rp->lock, flags);
+	
+	netif_device_attach(dev);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_driver rhine_driver = {
 	.name		= DRV_NAME,
 	.id_table	= rhine_pci_tbl,
 	.probe		= rhine_init_one,
 	.remove		= __devexit_p(rhine_remove_one),
+#ifdef CONFIG_PM
+	.suspend	= rhine_suspend,
+	.resume		= rhine_resume,
+#endif /* CONFIG_PM */
 	.driver = {
 		.shutdown = rhine_shutdown,
 	}
