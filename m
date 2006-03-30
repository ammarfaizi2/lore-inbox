Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWC3QDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWC3QDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWC3QDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:03:00 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:62982 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S1750798AbWC3QC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:02:59 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200603301602.k2UG2jAB002016@clem.clem-digital.net>
Subject: Re: Correction: 2.6.16-git12 killed networking -- 3c900 card
To: klassert@mathematik.tu-chemnitz.de (Steffen Klassert)
Date: Thu, 30 Mar 2006 11:02:45 -0500 (EST)
Cc: clem@clem.clem-digital.net (Pete Clements), akpm@osdl.org (Andrew Morton),
       klassert@mathematik.tu-chemnitz.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060330142950.GB8629@bayes.mathematik.tu-chemnitz.de>
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steffen Klassert
  > 
  > On Thu, Mar 30, 2006 at 08:46:54AM -0500, Pete Clements wrote:
  > > 
  > > Looks like that is the case until -git12, which Steffen has identified.
  > > Tested on git18 (with git12 fix) and looks good.
  > 
  > This Patch is a candidate for the final fix to make 10base2 work again. 
  > Could you please try this together with Andrews 
  > 3c59x-collision-statistics-fix-fix.patch?
  > 
  > Steffen
  > 
  > --- linux-2.6.16-git12/drivers/net/3c59x.c	2006-03-30 14:16:23.000000000 +0200
  > +++ linux-2.6.16-git12-sk/drivers/net/3c59x.c	2006-03-30 15:27:13.000000000 +0200
  > @@ -788,7 +788,7 @@
  >  	int options;						/* User-settable misc. driver options. */
  >  	unsigned int media_override:4, 		/* Passed-in media type. */
  >  		default_media:4,				/* Read from the EEPROM/Wn3_Config. */
  > -		full_duplex:1, force_fd:1, autoselect:1,
  > +		full_duplex:1, autoselect:1,
  >  		bus_master:1,					/* Vortex can only do a fragment bus-m. */
  >  		full_bus_master_tx:1, full_bus_master_rx:2, /* Boomerang  */
  >  		flow_ctrl:1,					/* Use 802.3x flow control (PAUSE only) */
  > @@ -1633,12 +1633,6 @@
  >  			((vp->full_duplex && vp->flow_ctrl && vp->partner_flow_ctrl) ?
  >  					0x100 : 0),
  >  			ioaddr + Wn3_MAC_Ctrl);
  > -
  > -	issue_and_wait(dev, TxReset);
  > -	/*
  > -	 * Don't reset the PHY - that upsets autonegotiation during DHCP operations.
  > -	 */
  > -	issue_and_wait(dev, RxReset|0x04);
  >  }
  >  
  >  static void vortex_check_media(struct net_device *dev, unsigned int init)
  > @@ -1663,7 +1657,7 @@
  >  	struct vortex_private *vp = netdev_priv(dev);
  >  	void __iomem *ioaddr = vp->ioaddr;
  >  	unsigned int config;
  > -	int i;
  > +	int i, mii_reg1, mii_reg5;
  >  
  >  	if (VORTEX_PCI(vp)) {
  >  		pci_set_power_state(VORTEX_PCI(vp), PCI_D0);	/* Go active */
  > @@ -1723,14 +1717,23 @@
  >  		printk(KERN_DEBUG "vortex_up(): writing 0x%x to InternalConfig\n", config);
  >  	iowrite32(config, ioaddr + Wn3_Config);
  >  
  > -	netif_carrier_off(dev);
  >  	if (dev->if_port == XCVR_MII || dev->if_port == XCVR_NWAY) {
  >  		EL3WINDOW(4);
  > +		mii_reg1 = mdio_read(dev, vp->phys[0], MII_BMSR);
  > +		mii_reg5 = mdio_read(dev, vp->phys[0], MII_LPA);
  > +		vp->partner_flow_ctrl = ((mii_reg5 & 0x0400) != 0);
  > +
  >  		vortex_check_media(dev, 1);
  >  	}
  >  	else
  >  		vortex_set_duplex(dev);
  >  
  > +	issue_and_wait(dev, TxReset);
  > +	/*
  > +	 * Don't reset the PHY - that upsets autonegotiation during DHCP operations.
  > +	 */
  > +	issue_and_wait(dev, RxReset|0x04);
  > +
  >  
  >  	iowrite16(SetStatusEnb | 0x00, ioaddr + EL3_CMD);
  >  
  > 

Applied to a fresh git18, all looks good.

-- 
Pete Clements 
