Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWC1Syf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWC1Syf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWC1Syf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:54:35 -0500
Received: from mail19.bluewin.ch ([195.186.18.65]:13041 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S1751193AbWC1Sye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:54:34 -0500
Date: Tue, 28 Mar 2006 20:53:56 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, vda@ilport.com.ua, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] via-rhine: link state fix
Message-ID: <20060328185356.GA22278@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.16 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problems with link state detection have been reported several times in the
past months.

Denis Vlasenko did all the work tracking it down. Jeff Garzik suggested the
proper place for the fix.

When using the mii library, the driver needs to check mii->force_media
and set dev->state accordingly.

Roger

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.15.6/drivers/net/via-rhine.c.orig	2006-03-12 13:32:16.000000000 +0100
+++ linux-2.6.15.6/drivers/net/via-rhine.c	2006-03-12 22:01:36.000000000 +0100
@@ -1085,6 +1085,25 @@
 	else
 	    iowrite8(ioread8(ioaddr + ChipCmd1) & ~Cmd1FDuplex,
 		   ioaddr + ChipCmd1);
+	if (debug > 1)
+		printk(KERN_INFO "%s: force_media %d, carrier %d\n", dev->name,
+			rp->mii_if.force_media, netif_carrier_ok(dev));
+}
+
+/* Called after status of force_media possibly changed */
+void rhine_set_carrier(struct mii_if_info *mii)
+{
+	if (mii->force_media) {
+		/* autoneg is off: Link is always assumed to be up */
+		if (!netif_carrier_ok(mii->dev))
+			netif_carrier_on(mii->dev);
+	}
+	else	/* Let MMI library update carrier status */
+		rhine_check_media(mii->dev, 0);
+	if (debug > 1)
+		printk(KERN_INFO "%s: force_media %d, carrier %d\n",
+		       mii->dev->name, mii->force_media,
+		       netif_carrier_ok(mii->dev));
 }
 
 static void rhine_check_media_task(struct net_device *dev)
@@ -1782,6 +1801,7 @@
 	spin_lock_irq(&rp->lock);
 	rc = mii_ethtool_sset(&rp->mii_if, cmd);
 	spin_unlock_irq(&rp->lock);
+	rhine_set_carrier(&rp->mii_if);
 
 	return rc;
 }
@@ -1869,6 +1889,7 @@
 	spin_lock_irq(&rp->lock);
 	rc = generic_mii_ioctl(&rp->mii_if, if_mii(rq), cmd, NULL);
 	spin_unlock_irq(&rp->lock);
+	rhine_set_carrier(&rp->mii_if);
 
 	return rc;
 }
