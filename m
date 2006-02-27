Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWB0Wbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWB0Wbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWB0Wbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33666 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932362AbWB0Wbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:48 -0500
Message-Id: <20060227223403.585057000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:32 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [patch 32/39] [PATCH] skge: fix SMP race
Content-Disposition: inline; filename=skge-fix-smp-race.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

If skge is attached to a bad cable, that goes up/down.
It exposes an SMP race with the management of IRQ mask

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/skge.c |   21 ++++++++++++++-------
 drivers/net/skge.h |    1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

--- linux-2.6.15.4.orig/drivers/net/skge.c
+++ linux-2.6.15.4/drivers/net/skge.c
@@ -2182,8 +2182,10 @@ static int skge_up(struct net_device *de
 	skge->tx_avail = skge->tx_ring.count - 1;
 
 	/* Enable IRQ from port */
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= portirqmask[port];
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock_irq(&hw->hw_lock);
 
 	/* Initialize MAC */
 	spin_lock_bh(&hw->phy_lock);
@@ -2241,8 +2243,10 @@ static int skge_down(struct net_device *
 	else
 		yukon_stop(skge);
 
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask &= ~portirqmask[skge->port];
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock_irq(&hw->hw_lock);
 
 	/* Stop transmitter */
 	skge_write8(hw, Q_ADDR(txqaddr[port], Q_CSR), CSR_STOP);
@@ -2698,10 +2702,11 @@ static int skge_poll(struct net_device *
 	if (work_done >=  to_do)
 		return 1; /* not done */
 
-	netif_rx_complete(dev);
-	hw->intr_mask |= portirqmask[skge->port];
-	skge_write32(hw, B0_IMSK, hw->intr_mask);
-	skge_read32(hw, B0_IMSK);
+	spin_lock_irq(&hw->hw_lock);
+	__netif_rx_complete(dev);
+  	hw->intr_mask |= portirqmask[skge->port];
+  	skge_write32(hw, B0_IMSK, hw->intr_mask);
+ 	spin_unlock_irq(&hw->hw_lock);
 
 	return 0;
 }
@@ -2861,10 +2866,10 @@ static void skge_extirq(unsigned long da
 	}
 	spin_unlock(&hw->phy_lock);
 
-	local_irq_disable();
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= IS_EXT_REG;
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
-	local_irq_enable();
+	spin_unlock_irq(&hw->hw_lock);
 }
 
 static irqreturn_t skge_intr(int irq, void *dev_id, struct pt_regs *regs)
@@ -2875,7 +2880,7 @@ static irqreturn_t skge_intr(int irq, vo
 	if (status == 0 || status == ~0) /* hotplug or shared irq */
 		return IRQ_NONE;
 
-	status &= hw->intr_mask;
+	spin_lock(&hw->hw_lock);
 	if (status & IS_R1_F) {
 		skge_write8(hw, Q_ADDR(Q_R1, Q_CSR), CSR_IRQ_CL_F);
 		hw->intr_mask &= ~IS_R1_F;
@@ -2927,6 +2932,7 @@ static irqreturn_t skge_intr(int irq, vo
 	}
 
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock(&hw->hw_lock);
 
 	return IRQ_HANDLED;
 }
@@ -3285,6 +3291,7 @@ static int __devinit skge_probe(struct p
 
 	hw->pdev = pdev;
 	spin_lock_init(&hw->phy_lock);
+	spin_lock_init(&hw->hw_lock);
 	tasklet_init(&hw->ext_tasklet, skge_extirq, (unsigned long) hw);
 
 	hw->regs = ioremap_nocache(pci_resource_start(pdev, 0), 0x4000);
--- linux-2.6.15.4.orig/drivers/net/skge.h
+++ linux-2.6.15.4/drivers/net/skge.h
@@ -2473,6 +2473,7 @@ struct skge_hw {
 
 	struct tasklet_struct ext_tasklet;
 	spinlock_t	     phy_lock;
+	spinlock_t	     hw_lock;
 };
 
 enum {

--
