Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263392AbUKZWSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbUKZWSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbUKZWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:11:52 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:1235 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S263392AbUKZWAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:00:07 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-25.tower-9.messagelabs.com!1101376798!14406324!1
X-StarScan-Version: 5.4.2; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: "deadlock" between smc91x driver and link_watch
From: Ian Campbell <icampbell@arcom.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.61.0411241125280.8946@xanadu.home>
References: <1101230194.14370.12.camel@icampbell-debian>
	 <20041123153158.6f20a7d7.akpm@osdl.org>
	 <1101289309.10841.9.camel@icampbell-debian>
	 <20041124014650.47af8ae4.akpm@osdl.org>
	 <1101290297.10841.15.camel@icampbell-debian>
	 <Pine.LNX.4.61.0411241014160.8946@xanadu.home>
	 <1101311558.31459.21.camel@icampbell-debian>
	 <Pine.LNX.4.61.0411241125280.8946@xanadu.home>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Thu, 25 Nov 2004 09:59:55 +0000
Message-Id: <1101376796.31459.45.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (97976604)
X-IMAIL-SPAM-VALREVDNS: (97976604)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've taken Nico's comments on board and used lp->work_pending to detect
whether smc_phy_configure is pending or not instead of dev_hold/put(). I
was able to do away with smc_phy_configure_wq() from the previous
version since setting lp->work_pending=0 can safely be done in
smc_phy_configure() itself, unlike dev_put().

Also fixed a typo 'ence' -> 'Hence' and renamed smc_detect_phy to
smc_phy_detect in order to follow the same pattern as the other
smc_phy_* functions, I was typing smc_phy_detect() every time anyway and
it was getting on my wick. I hope that's OK...

Signed-off-by: Ian Campbell <icampbell@arcom.com>

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


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
