Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUHHQRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUHHQRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 12:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUHHQRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 12:17:24 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:2006 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S265772AbUHHQRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 12:17:22 -0400
Date: Sun, 8 Aug 2004 16:02:59 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2/3] via-rhine: de-isolate PHY
Message-ID: <20040808140259.GA8575@k3.hellgate.ch>
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

PHYs may come up isolated. Make sure we can send data to them. This code
section needs a clean-up, but I prefer to merge this fix in isolation.

Report and suggested fix by Tam, Ming Dat (Tommy).

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- linux-2.6.8-rc3-mm1/drivers/net/via-rhine.c.01	2004-08-08 12:36:03.440855262 +0200
+++ linux-2.6.8-rc3-mm1/drivers/net/via-rhine.c	2004-08-08 13:15:24.527527919 +0200
@@ -896,7 +896,10 @@ static int __devinit rhine_init_one(stru
 	pci_set_drvdata(pdev, dev);
 
 	{
+		u16 mii_cmd;
 		int mii_status = mdio_read(dev, phy_id, 1);
+		mii_cmd = mdio_read(dev, phy_id, MII_BMCR) & ~BMCR_ISOLATE;
+		mdio_write(dev, phy_id, MII_BMCR, mii_cmd);
 		if (mii_status != 0xffff && mii_status != 0x0000) {
 			rp->mii_if.advertising = mdio_read(dev, phy_id, 4);
 			printk(KERN_INFO "%s: MII PHY found at address "
