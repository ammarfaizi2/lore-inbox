Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266065AbUHFRcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbUHFRcz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHFRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:30:57 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:18186 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S268220AbUHFR0p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:26:45 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Roger Luethi <rl@hellgate.ch>
Subject: Re: via-rhine suspend/resume patch (works but not always) [PATCH]
Date: Fri, 6 Aug 2004 19:26:31 +0200
User-Agent: KMail/1.6.2
References: <200408030138.15641.arekm@pld-linux.org> <200408060155.11804.arekm@pld-linux.org> <20040806073432.GA11358@k3.hellgate.ch>
In-Reply-To: <20040806073432.GA11358@k3.hellgate.ch>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408061926.31898.arekm@pld-linux.org>
X-Spam-Score: 1.8 (+)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (1.8 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.8 DOMAIN_BODY            BODY: Domain registration spam body
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 of August 2004 09:34, you wrote:

> > +	/* Enable or Disable generation of PME# for D3 state */
> > +	pci_enable_wake(pdev, 3, rp->wolopts);
> > +
>
> If you don't call pci_enable_wake, it still works, I take it. 
Suspend/resume (to/from disk) works well without this. I've dropped this
part until this is clear.

> ISTR that 
> even if you call it pci_enable_wake(pdev, 3, 0); WOL _still_ works.
> Why would that be?
Probably pci_enable_wake(pdev, 3, 0); is not enough for rhine
hardware. I have no idea.

I would like to test WOL related things more but I don't want to
do this now until S3 support works well in kernel :) I can't help
with all those WOL chip registers magic since I can only guess.

Final path attached then. Please send it upstream. Thanks for great help!

Resume/suspend support for via-rhine.

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>

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

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
