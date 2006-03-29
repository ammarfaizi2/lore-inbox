Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWC2HBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWC2HBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWC2HBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:01:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751110AbWC2HBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:01:46 -0500
Date: Tue, 28 Mar 2006 23:01:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: klassert@mathematik.tu-chemnitz.de, clem@clem.clem-digital.net,
       linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-Id: <20060328230132.52c79c6c.akpm@osdl.org>
In-Reply-To: <200603290250.k2T2od8d001585@clem.clem-digital.net>
References: <20060328141443.GB8455@gareth.mathematik.tu-chemnitz.de>
	<200603290250.k2T2od8d001585@clem.clem-digital.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements <clem@clem.clem-digital.net> wrote:
>
> Quoting Steffen Klassert
>   > >   Had several of these with git11
>   > >   NETDEV WATCHDOG: eth0: transmit timed out
>   > 
>   > Is this for sure that these messages occured first time with git11?
>   > There were no changes in the 3c59x driver between git10 and git11.
>   > 
> Tried 2.6.15 and could not get a timed out condition.  Looks like
> that defect is between 15 and 16 in my case.  
> 
> Be glad to do any testing that I can.

If it's noether of those then I'd expect the problem relates to the
conversion to use the standard mii layer.  Possibly we need to re-port some
mdo reading oddity into 3c59x.c:mdio_read(), but it would take some effort
to work out which one.

You could try this shot-in-the-dark:


diff -puN drivers/net/3c59x.c~revert-3c59x-avoid-blindly-reading-link-status-twice drivers/net/3c59x.c
--- devel/drivers/net/3c59x.c~revert-3c59x-avoid-blindly-reading-link-status-twice	2006-03-28 22:51:52.000000000 -0800
+++ devel-akpm/drivers/net/3c59x.c	2006-03-28 23:00:47.000000000 -0800
@@ -3196,7 +3196,7 @@ static void mdio_sync(void __iomem *ioad
 	}
 }
 
-static int mdio_read(struct net_device *dev, int phy_id, int location)
+static int __mdio_read(struct net_device *dev, int phy_id, int location)
 {
 	int i;
 	struct vortex_private *vp = netdev_priv(dev);
@@ -3227,6 +3227,13 @@ static int mdio_read(struct net_device *
 	return retval & 0x20000 ? 0xffff : retval>>1 & 0xffff;
 }
 
+static int mdio_read(struct net_device *dev, int phy_id, int location)
+{
+	if (location == MII_BMSR)
+		__mdio_read(dev, phy_id, location);
+	return __mdio_read(dev, phy_id, location);
+}
+
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
 {
 	struct vortex_private *vp = netdev_priv(dev);
_

