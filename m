Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVJSBeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVJSBeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVJSBeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:34:10 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:3076 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932451AbVJSBdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:45 -0400
Date: Tue, 18 Oct 2005 21:31:02 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, rl@hellgate.ch
Subject: [patch 2.6.14-rc4] via-rhine: change mdelay to msleep and remove from ISR path
Message-ID: <10182005213102.12948@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the mdelay call in rhine_disable_linkmon.  The function
is called from the via-rhine versions of mdio_read and mdio_write.
Those functions are indirectly called from rhine_check_media and
rhine_tx_timeout, both of which can be called in interrupt context.

So, create tx_timeout_task and check_media_task as instances of struct
work_struct inside of rhine_private.  Then, change rhine_tx_timeout to
invoke schedule_work for tx_timeout_task (i.e. rhine_tx_timeout_task),
moving the work to process context.  Also, change rhine_error (invoked
from rhine_interrupt) to invoke schedule_work for check_media_task
(i.e. rhine_check_media_task), which simply calls rhine_check media
in process context.  Finally, add a call to flush_scheduled_work in
rhine_close to avoid any resource conflicts with pending work items.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/via-rhine.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c
+++ b/drivers/net/via-rhine.c
@@ -490,6 +490,8 @@ struct rhine_private {
 	u8 tx_thresh, rx_thresh;
 
 	struct mii_if_info mii_if;
+	struct work_struct tx_timeout_task;
+	struct work_struct check_media_task;
 	void __iomem *base;
 };
 
@@ -497,6 +499,8 @@ static int  mdio_read(struct net_device 
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int  rhine_open(struct net_device *dev);
 static void rhine_tx_timeout(struct net_device *dev);
+static void rhine_tx_timeout_task(struct net_device *dev);
+static void rhine_check_media_task(struct net_device *dev);
 static int  rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t rhine_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
 static void rhine_tx(struct net_device *dev);
@@ -850,6 +854,12 @@ static int __devinit rhine_init_one(stru
 	if (rp->quirks & rqRhineI)
 		dev->features |= NETIF_F_SG|NETIF_F_HW_CSUM;
 
+	INIT_WORK(&rp->tx_timeout_task,
+		  (void (*)(void *))rhine_tx_timeout_task, dev);
+
+	INIT_WORK(&rp->check_media_task,
+		  (void (*)(void *))rhine_check_media_task, dev);
+
 	/* dev->name not defined before register_netdev()! */
 	rc = register_netdev(dev);
 	if (rc)
@@ -1076,6 +1086,11 @@ static void rhine_check_media(struct net
 		   ioaddr + ChipCmd1);
 }
 
+static void rhine_check_media_task(struct net_device *dev)
+{
+	rhine_check_media(dev, 0);
+}
+
 static void init_registers(struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
@@ -1129,8 +1144,8 @@ static void rhine_disable_linkmon(void _
 	if (quirks & rqRhineI) {
 		iowrite8(0x01, ioaddr + MIIRegAddr);	// MII_BMSR
 
-		/* Can be called from ISR. Evil. */
-		mdelay(1);
+		/* Do not call from ISR! */
+		msleep(1);
 
 		/* 0x80 must be set immediately before turning it off */
 		iowrite8(0x80, ioaddr + MIICmd);
@@ -1220,6 +1235,16 @@ static int rhine_open(struct net_device 
 static void rhine_tx_timeout(struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
+
+	/*
+	 * Move bulk of work outside of interrupt context
+	 */
+	schedule_work(&rp->tx_timeout_task);
+}
+
+static void rhine_tx_timeout_task(struct net_device *dev)
+{
+	struct rhine_private *rp = netdev_priv(dev);
 	void __iomem *ioaddr = rp->base;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
@@ -1625,7 +1650,7 @@ static void rhine_error(struct net_devic
 	spin_lock(&rp->lock);
 
 	if (intr_status & IntrLinkChange)
-		rhine_check_media(dev, 0);
+		schedule_work(&rp->check_media_task);
 	if (intr_status & IntrStatsMax) {
 		rp->stats.rx_crc_errors += ioread16(ioaddr + RxCRCErrs);
 		rp->stats.rx_missed_errors += ioread16(ioaddr + RxMissed);
@@ -1872,6 +1897,9 @@ static int rhine_close(struct net_device
 	spin_unlock_irq(&rp->lock);
 
 	free_irq(rp->pdev->irq, dev);
+
+	flush_scheduled_work();
+
 	free_rbufs(dev);
 	free_tbufs(dev);
 	free_ring(dev);
