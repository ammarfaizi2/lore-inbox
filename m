Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWBKT6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWBKT6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 14:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWBKT6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 14:58:51 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26567 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S964789AbWBKT6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 14:58:51 -0500
Date: Sat, 11 Feb 2006 20:57:18 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Vincent ETIENNE <ve@vetienne.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: BUG at drivers/net/dl2k.c
Message-ID: <20060211195718.GA24012@electric-eye.fr.zoreil.com>
References: <200602092101.41970.ve@vetienne.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602092101.41970.ve@vetienne.net>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent ETIENNE <ve@vetienne.net> :
> 
> I'm using 2.6.14-mm2 kernel (x86_64) on a Bi-Opteron 246 board with a   PCI-64 
> card ( DLINK 550 GT ) plug  on PCI-X interface. This card use the DL2000 
> driver which seems to cause this problem logged during boot time  : 
> 
> BUG: warning at drivers/net/dl2k.c:1481/mii_wait_link()
[...]

Try the bandaid below. If it is not enough, please open a PR at
http://bugzilla.kernel.org and add me to the Cc: list.

1ms delay in irq context always hurt. This stuff should be done in
an user-context.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff --git a/drivers/net/dl2k.c b/drivers/net/dl2k.c
index 430c628..2d47804 100644
--- a/drivers/net/dl2k.c
+++ b/drivers/net/dl2k.c
@@ -972,7 +972,7 @@ rio_error (struct net_device *dev, int i
 
 	/* Link change event */
 	if (int_status & LinkEvent) {
-		if (mii_wait_link (dev, 10) == 0) {
+		if (mii_wait_link (dev, 1000) == 0) {
 			printk (KERN_INFO "%s: Link up\n", dev->name);
 			if (np->phy_media)
 				mii_get_media_pcs (dev);
@@ -1478,7 +1478,7 @@ mii_wait_link (struct net_device *dev, i
 		bmsr.image = mii_read (dev, phy_addr, MII_BMSR);
 		if (bmsr.bits.link_status)
 			return 0;
-		mdelay (1);
+		udelay(10);
 	} while (--wait > 0);
 	return -1;
 }

