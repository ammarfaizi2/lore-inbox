Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWC2PPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWC2PPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWC2PPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:15:14 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:64439 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750806AbWC2PPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:15:13 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603291515.k2TFF3GM001689@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: akpm@osdl.org (Andrew Morton)
Date: Wed, 29 Mar 2006 10:15:03 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements),
       klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060328230132.52c79c6c.akpm@osdl.org>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch applied on top of previous patch to 2.6.16, no longer
seeing the timeouts.

  > Pete Clements <clem@clem.clem-digital.net> wrote:
  > >
  > > Quoting Steffen Klassert
  > >   > >   Had several of these with git11
  > >   > >   NETDEV WATCHDOG: eth0: transmit timed out
  > >   > 
  > >   > Is this for sure that these messages occured first time with git11?
  > >   > There were no changes in the 3c59x driver between git10 and git11.
  > >   > 
  > > Tried 2.6.15 and could not get a timed out condition.  Looks like
  > > that defect is between 15 and 16 in my case.  
  > > 
  > > Be glad to do any testing that I can.
  > 
  > If it's noether of those then I'd expect the problem relates to the
  > conversion to use the standard mii layer.  Possibly we need to re-port some
  > mdo reading oddity into 3c59x.c:mdio_read(), but it would take some effort
  > to work out which one.
  > 
  > You could try this shot-in-the-dark:
  > 
  > 
  > diff -puN drivers/net/3c59x.c~revert-3c59x-avoid-blindly-reading-link-status-twice drivers/net/3c59x.c
  > --- devel/drivers/net/3c59x.c~revert-3c59x-avoid-blindly-reading-link-status-twice	2006-03-28 22:51:52.000000000 -0800
  > +++ devel-akpm/drivers/net/3c59x.c	2006-03-28 23:00:47.000000000 -0800
  > @@ -3196,7 +3196,7 @@ static void mdio_sync(void __iomem *ioad
  >  	}
  >  }
  >  
  > -static int mdio_read(struct net_device *dev, int phy_id, int location)
  > +static int __mdio_read(struct net_device *dev, int phy_id, int location)
  >  {
  >  	int i;
  >  	struct vortex_private *vp = netdev_priv(dev);
  > @@ -3227,6 +3227,13 @@ static int mdio_read(struct net_device *
  >  	return retval & 0x20000 ? 0xffff : retval>>1 & 0xffff;
  >  }
  >  
  > +static int mdio_read(struct net_device *dev, int phy_id, int location)
  > +{
  > +	if (location == MII_BMSR)
  > +		__mdio_read(dev, phy_id, location);
  > +	return __mdio_read(dev, phy_id, location);
  > +}
  > +
  >  static void mdio_write(struct net_device *dev, int phy_id, int location, int value)
  >  {
  >  	struct vortex_private *vp = netdev_priv(dev);
  > _
  > 


-- 
Pete Clements 
