Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbUK0CCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbUK0CCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUK0Bqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:46:30 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263038AbUKZTie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:34 -0500
Subject: Avoid deadlock in smc91x driver
From: Ian Campbell <icampbell@arcom.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Thu, 25 Nov 2004 16:49:24 +0000
Message-Id: <1101401364.31459.85.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2004 16:51:02.0921 (UTC) FILETIME=[F2C4E790:01C4D30E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

This patch avoids a deadlock on rtnl_sem in smc_close() when bringing
down an smc91x interface. The semaphore is already held by
devinet_ioctl() and the pending work queue contains linkwatch_event()
(scheduled by netif_carrier_off()) which also wants rtnl_sem hence it is
unsafe to call flush_scheduled_work().

The solution is to track whether we have any pending work of our own and
wait for that instead of flushing the entire queue.

I also fixed a typo 'ence' -> 'Hence' and renamed smc_detect_phy to
smc_phy_detect in order to follow the same pattern as the other
smc_phy_* functions.

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: 2.6/drivers/net/smc91x.c
===================================================================
--- 2.6.orig/drivers/net/smc91x.c	2004-11-16 09:26:52.000000000 +0000
+++ 2.6/drivers/net/smc91x.c	2004-11-25 09:49:38.830953019 +0000
@@ -203,7 +203,10 @@
 	u32	msg_enable;
 	u32	phy_type;
 	struct mii_if_info mii;
+
+	/* work queue */
 	struct work_struct phy_configure;
+	int	work_pending;
 
 	spinlock_t lock;
 
@@ -903,7 +906,7 @@
 /*
  * Finds and reports the PHY address
  */
-static void smc_detect_phy(struct net_device *dev)
+static void smc_phy_detect(struct net_device *dev)
 {
 	struct smc_local *lp = netdev_priv(dev);
 	int phyaddr;
@@ -1155,6 +1158,7 @@
 
 smc_phy_configure_exit:
 	spin_unlock_irq(&lp->lock);
+	lp->work_pending = 0;
 }
 
 /*
@@ -1350,10 +1354,13 @@
 	/*
 	 * Reconfiguring the PHY doesn't seem like a bad idea here, but
 	 * smc_phy_configure() calls msleep() which calls schedule_timeout()
-	 * which calls schedule().  Ence we use a work queue.
+	 * which calls schedule().  Hence we use a work queue.
 	 */
-	if (lp->phy_type != 0)
-		schedule_work(&lp->phy_configure);
+	if (lp->phy_type != 0) {
+		if (schedule_work(&lp->phy_configure)) {
+			lp->work_pending = 1;
+		}
+	}
 
 	/* We can accept TX packets again */
 	dev->trans_start = jiffies;
@@ -1537,7 +1544,18 @@
 	smc_shutdown(dev);
 
 	if (lp->phy_type != 0) {
-		flush_scheduled_work();
+		/* We need to ensure that no calls to
+		   smc_phy_configure are pending. 
+
+		   flush_scheduled_work() cannot be called because we
+		   are running with the netlink semaphore held (from
+		   devinet_ioctl()) and the pending work queue
+		   contains linkwatch_event() (scheduled by
+		   netif_carrier_off() above). linkwatch_event() also
+		   wants the netlink semaphore.
+		*/
+		while(lp->work_pending)
+			schedule();
 		smc_phy_powerdown(dev, lp->mii.phy_id);
 	}
 
@@ -1904,7 +1922,7 @@
 	 * Locate the phy, if any.
 	 */
 	if (lp->version >= (CHIP_91100 << 4))
-		smc_detect_phy(dev);
+		smc_phy_detect(dev);
 
 	/* Set default parameters */
 	lp->msg_enable = NETIF_MSG_LINK;

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

