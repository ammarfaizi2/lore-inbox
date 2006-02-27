Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWB0WmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWB0WmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWB0Wlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:41:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:61570 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932355AbWB0Wb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:28 -0500
Message-Id: <20060227223402.328777000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [patch 30/39] [PATCH] skge: fix NAPI/irq race
Content-Disposition: inline; filename=skge-fix-napi-irq-race.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix a race in the receive NAPI, irq handling. The interrupt clear and the
start need to be separated.  Otherwise there is a window between the last
frame received and the NAPI done level handling.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/skge.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

--- linux-2.6.15.4.orig/drivers/net/skge.c
+++ linux-2.6.15.4/drivers/net/skge.c
@@ -2675,8 +2675,7 @@ static int skge_poll(struct net_device *
 
 	/* restart receiver */
 	wmb();
-	skge_write8(hw, Q_ADDR(rxqaddr[skge->port], Q_CSR),
-		    CSR_START | CSR_IRQ_CL_F);
+	skge_write8(hw, Q_ADDR(rxqaddr[skge->port], Q_CSR), CSR_START);
 
 	*budget -= work_done;
 	dev->quota -= work_done;
@@ -2853,14 +2852,6 @@ static void skge_extirq(unsigned long da
 	local_irq_enable();
 }
 
-static inline void skge_wakeup(struct net_device *dev)
-{
-	struct skge_port *skge = netdev_priv(dev);
-
-	prefetch(skge->rx_ring.to_clean);
-	netif_rx_schedule(dev);
-}
-
 static irqreturn_t skge_intr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct skge_hw *hw = dev_id;
@@ -2871,13 +2862,15 @@ static irqreturn_t skge_intr(int irq, vo
 
 	status &= hw->intr_mask;
 	if (status & IS_R1_F) {
+		skge_write8(hw, Q_ADDR(Q_R1, Q_CSR), CSR_IRQ_CL_F);
 		hw->intr_mask &= ~IS_R1_F;
-		skge_wakeup(hw->dev[0]);
+		netif_rx_schedule(hw->dev[0]);
 	}
 
 	if (status & IS_R2_F) {
+		skge_write8(hw, Q_ADDR(Q_R2, Q_CSR), CSR_IRQ_CL_F);
 		hw->intr_mask &= ~IS_R2_F;
-		skge_wakeup(hw->dev[1]);
+		netif_rx_schedule(hw->dev[1]);
 	}
 
 	if (status & IS_XA1_F)

--
