Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFGDAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFGDAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVFGDAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:00:46 -0400
Received: from cpe-24-93-172-51.neo.res.rr.com ([24.93.172.51]:12418 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261490AbVFGDAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:00:38 -0400
Date: Mon, 6 Jun 2005 22:57:10 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Karsten Keil <kkeil@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050607025710.GD3289@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Karsten Keil <kkeil@suse.de>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050606224645.GA23989@pingi3.kke.suse.de> <1118110545.6850.31.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118110545.6850.31.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 12:15:44PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2005-06-07 at 00:46 +0200, Karsten Keil wrote:
> > Hi,
> > 
> > following patch fix the suspend/resume for tulip based
> > cards, so suspend on disk work now for me and tulip based
> > cardbus cards.
> > 
> > 
> > Signed-off-by: Karsten Keil <kkeil@suse.de>
> > 
> > --- linux/drivers/net/tulip/tulip_core.c.orig	2005-03-23 23:54:43.000000000 +0100
> > +++ linux/drivers/net/tulip/tulip_core.c	2005-05-26 17:29:14.000000000 +0200
> > @@ -1755,12 +1755,16 @@
> >  static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
> >  {
> >  	struct net_device *dev = pci_get_drvdata(pdev);
> > +	int err;
> >  
> > +	pci_save_state(pdev);
> >  	if (dev && netif_running (dev) && netif_device_present (dev)) {
> >  		netif_device_detach (dev);
> >  		tulip_down (dev);
> >  		/* pci_power_off(pdev, -1); */
> >  	}
> > +	if ((err = pci_set_power_state(pdev, PCI_D3hot)))
> > +		printk(KERN_ERR "%s: pci_set_power_state D3hot return %d\n", dev->name, err);
> >  	return 0;
> >  }
> 
> It should probably test for message state, it's not worth doing
> pci_set_power_state(D3) if PMSG_FREEZE is passed... (just slows down
> suspend to disk)

Yeah, I added pci_choose_state in my last email.  This will at least help
avoid powering off.  Still, I agree this needs to be handled specifically.
Currently, I don't think many drivers support PMSG_FREEZE.

Thanks,
Adam
