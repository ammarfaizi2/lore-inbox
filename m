Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWC3BIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWC3BIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWC3BIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:08:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751217AbWC3BIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:08:14 -0500
Date: Wed, 29 Mar 2006 17:10:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: clem@clem.clem-digital.net, klassert@mathematik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
Message-Id: <20060329171030.3d475bcb.akpm@osdl.org>
In-Reply-To: <200603300053.k2U0rYwc001690@clem.clem-digital.net>
References: <20060329112931.766aecbd.akpm@osdl.org>
	<200603300053.k2U0rYwc001690@clem.clem-digital.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements <clem@clem.clem-digital.net> wrote:
>
> Quoting Andrew Morton
>   > 
>   > Pete Clements <clem@clem.clem-digital.net> wrote:
>   > >
>   > > Quoting Andrew Morton
>   > >   > > Quoting Steffen Klassert
>   > >   > >   > >   Had several of these with git11
>   > >   > >   > >   NETDEV WATCHDOG: eth0: transmit timed out
>   > >   > >   > 
>   > >   > >   > Is this for sure that these messages occured first time with git11?
>   > >   > >   > There were no changes in the 3c59x driver between git10 and git11.
>   > >   > >   > 
>   > >   > > Tried 2.6.15 and could not get a timed out condition.  Looks like
>   > >   > > that defect is between 15 and 16 in my case.  
>   > >   > > 
>   > >   > > Be glad to do any testing that I can.
>   > >   > > 
>   > >   > 
>   > >   > Please try adding the 3c59x module parameter `global_enable_wol=0', see if
>   > >   > that helps.
>   > >   > 
>   > > Driver is compiled in, not module.
>   > > 
>   > 
>   > Boot with 3c59x.global_enable_wol=0 on the kernel command line.
>   > 
> Backed out your second patch and booted with the parameter.  Not
> seeing the time outs.
> 

Oh damn.  So you're sure that 3c59x.global_enable_wol=0 actually makes the
driver behave better?

For years the driver required a special module parameter to enable WOL,
because there was some problem with some hardware.  It's all lost in the
mists of time.

So the situation as I understand it now is:

- We need to apply the "vortex_error() to not run iowrite16" fix

- The "do mdio_read() twice if we're reading MII_BMSR" patch does indeed
  fix something (what did it fix, again?) but we don't recall why the
  driver was reading it twice in the first place.

Both patches are appended below.

If we do both of those things, does the driver still require
3c59x.global_enable_wol=0 to function properly?

(This driver supports a huge number of cards spread across 15 or more years
and it has large amounts of tricky trial-and-error knowledge in it.  It's
generally best not to touch it).


From: Andrew Morton <akpm@osdl.org>

The pre-2.6.16 patch "3c59x collision statistics fix" accidentally caused
vortex_error() to not run iowrite16(TxEnable, ioaddr + EL3_CMD) if we got a
maxCollisions interrupt but MAX_COLLISION_RESET is not set.

Cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
Cc: Pete Clements <clem@clem.clem-digital.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/3c59x.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff -puN drivers/net/3c59x.c~3c59x-collision-statistics-fix-fix drivers/net/3c59x.c
--- devel/drivers/net/3c59x.c~3c59x-collision-statistics-fix-fix	2006-03-28 22:36:48.000000000 -0800
+++ devel-akpm/drivers/net/3c59x.c	2006-03-28 22:40:01.000000000 -0800
@@ -2085,16 +2085,14 @@ vortex_error(struct net_device *dev, int
 		}
 		if (tx_status & 0x14)  vp->stats.tx_fifo_errors++;
 		if (tx_status & 0x38)  vp->stats.tx_aborted_errors++;
+		if (tx_status & 0x08)  vp->xstats.tx_max_collisions++;
 		iowrite8(0, ioaddr + TxStatus);
 		if (tx_status & 0x30) {			/* txJabber or txUnderrun */
 			do_tx_reset = 1;
-		} else if (tx_status & 0x08) {	/* maxCollisions */
-			vp->xstats.tx_max_collisions++;
-			if (vp->drv_flags & MAX_COLLISION_RESET) {
-				do_tx_reset = 1;
-				reset_mask = 0x0108;		/* Reset interface logic, but not download logic */
-			}
-		} else {						/* Merely re-enable the transmitter. */
+		} else if ((tx_status & 0x08) && (vp->drv_flags & MAX_COLLISION_RESET))  {	/* maxCollisions */
+			do_tx_reset = 1;
+			reset_mask = 0x0108;		/* Reset interface logic, but not download logic */
+		} else {				/* Merely re-enable the transmitter. */
 			iowrite16(TxEnable, ioaddr + EL3_CMD);
 		}
 	}
_





From: Andrew Morton <akpm@osdl.org>

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/3c59x.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

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

