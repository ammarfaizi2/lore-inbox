Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946148AbWKAFgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946148AbWKAFgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946123AbWKAFgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:03 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22215 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946148AbWKAFfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:35:38 -0500
Message-Id: <20061101053552.314319000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/61] sky2: turn off PHY IRQ on shutdown
Content-Disposition: inline; filename=sky2-turn-off-phy-irq-on-shutdown.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

When PHY is turned off on shutdown, it can causes the IRQ to get stuck on.
Make sure and disable the IRQ first, and if IRQ occurs when device
is not running, don't access PHY because that can hang.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/net/sky2.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.18.1.orig/drivers/net/sky2.c
+++ linux-2.6.18.1/drivers/net/sky2.c
@@ -1429,6 +1429,11 @@ static int sky2_down(struct net_device *
 	/* Stop more packets from being queued */
 	netif_stop_queue(dev);
 
+	/* Disable port IRQ */
+	imask = sky2_read32(hw, B0_IMSK);
+	imask &= ~portirq_msk[port];
+	sky2_write32(hw, B0_IMSK, imask);
+
 	sky2_phy_reset(hw, port);
 
 	/* Stop transmitter */
@@ -1472,11 +1477,6 @@ static int sky2_down(struct net_device *
 	sky2_write8(hw, SK_REG(port, RX_GMF_CTRL_T), GMF_RST_SET);
 	sky2_write8(hw, SK_REG(port, TX_GMF_CTRL_T), GMF_RST_SET);
 
-	/* Disable port IRQ */
-	imask = sky2_read32(hw, B0_IMSK);
-	imask &= ~portirq_msk[port];
-	sky2_write32(hw, B0_IMSK, imask);
-
 	/* turn off LED's */
 	sky2_write16(hw, B0_Y2LED, LED_STAT_OFF);
 
@@ -1687,13 +1687,13 @@ static void sky2_phy_intr(struct sky2_hw
 	struct sky2_port *sky2 = netdev_priv(dev);
 	u16 istatus, phystat;
 
+	if (!netif_running(dev))
+		return;
+
 	spin_lock(&sky2->phy_lock);
 	istatus = gm_phy_read(hw, port, PHY_MARV_INT_STAT);
 	phystat = gm_phy_read(hw, port, PHY_MARV_PHY_STAT);
 
-	if (!netif_running(dev))
-		goto out;
-
 	if (netif_msg_intr(sky2))
 		printk(KERN_INFO PFX "%s: phy interrupt status 0x%x 0x%x\n",
 		       sky2->netdev->name, istatus, phystat);

--
