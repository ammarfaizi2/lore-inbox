Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVCaBMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVCaBMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVCaBMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:12:37 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:17132 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262581AbVCaBLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:11:43 -0500
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] USB: pegasus uses netif_msg_*() filters
Date: Wed, 30 Mar 2005 17:11:37 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gregkh@suse.de
References: <200503302318.j2UNImZh019630@hera.kernel.org> <424B46AF.6080205@pobox.com>
In-Reply-To: <424B46AF.6080205@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301711.37535.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 March 2005 4:39 pm, Jeff Garzik wrote:

> > @@ -85,6 +85,11 @@
> >  MODULE_PARM_DESC(loopback, "Enable MAC loopback mode (bit 0)");
> >  MODULE_PARM_DESC(mii_mode, "Enable HomePNA mode (bit 0),default=MII mode = 0");
> >  
> > +/* use ethtool to change the level for any given device */
> > +static int msg_level = -1;
> 
> incorrect -- this should be an integer which indicates verbosity level; 
> netif_msg_init() then converts that into a bitmap.

But look at netif_msg_init(), and notice how the default bitmap never
applies unless the "level" is negative.   If that were zero, no
messages would ever be enabled.  If it were positive, there'd be no
need for the default bitmap.  Imaginary numbers won't work there,
leaving just negative ones ...


> > -		get_registers(pegasus, PhyData, 2, &regdi);
> > +		ret = get_registers(pegasus, PhyData, 2, &regdi);
> >  		*regd = le16_to_cpu(regdi);
> >  		return 1;
> 
> these changes are completely pointless.  please revert.

They actually aren't pointless.  They make it obvious where the
stupid code is discarding potential error status, not recovering
from errors.  Maybe they also deserve a FIXME ... but every one
of those calls is potential trouble.  (And in fact, I've observed
several of them to be trouble in certain disconnect sequences...)

I'd much rather see someone (anyone!) submit a patch to fix this
stuff correctly than just revert the changes.  As you've noticed,
these are pretty much screaming out for a fix.  Maybe one of the
kernel janitors could help out here, and make all of us happier!


Remember, these register reads go over USB, and the USB requests
can fail.  It's not like a more classic PCI-ish access, where
the only failure is normally at the level of an unexpected
CardBus unplug.

And yes, this driver seems to have a LOT of places where it
should be recovering from such errors, but it isn't.


> > @@ -311,7 +333,7 @@
> >  static int mdio_read(struct net_device *dev, int phy_id, int loc)
> >  {
> >  	pegasus_t *pegasus = (pegasus_t *) netdev_priv(dev);
> > -	__le16 res;
> > +	u16 res;
> >  
> >  	read_mii_word(pegasus, phy_id, loc, &res);
> >  	return (int)res;
> 
> pointless cast in last line (though I realize this wasn't actually 
> changed by your patch)

True.  I didn't try to fix _all_ issues with this driver... just the
ones that fill my "dmesg" with ugly noise.  :)

 

> > @@ -731,7 +782,9 @@
> >  		/* some Pegasus-I products report LOTS of data
> >  		 * toggle errors... avoid log spamming
> >  		 */
> > -		pr_debug("%s: intr status %d\n", net->name, urb->status);
> > +		if (netif_msg_timer(pegasus))
> > +			pr_debug("%s: intr status %d\n", net->name,
> > +					urb->status);
> >  	}
> >  
> >  	if (urb->actual_length >= 6) {
> 
> avoid log spamming by net_ratelimit() or similar.

That's why it's pr_debug.  Again, I didn't try to change that.
It's a pre-existing bug.

 
> also, this seems unrelated to timer (inappropriate)

Interrupt transfers _are_ timer drivern -- period of 2^N msecs in
this case.


> > @@ -771,7 +824,8 @@
> >  static void pegasus_tx_timeout(struct net_device *net)
> >  {
> >  	pegasus_t *pegasus = netdev_priv(net);
> > -	printk(KERN_WARNING "%s: tx timeout\n", net->name);
> > +	if (netif_msg_timer(pegasus))
> > +		printk(KERN_WARNING "%s: tx timeout\n", net->name);
> >  	pegasus->tx_urb->transfer_flags |= URB_ASYNC_UNLINK;
> >  	usb_unlink_urb(pegasus->tx_urb);
> >  	pegasus->stats.tx_errors++;
> 
> inappropriate

Erm, the what exactly _is_ a "timer" message for, if even
a TX timer callback error isn't allowed to trigger one???


> > @@ -946,7 +1016,6 @@
> >  {
> >  	pegasus_t *pegasus = netdev_priv(net);
> >  
> > -	pegasus->flags &= ~PEGASUS_RUNNING;
> >  	netif_stop_queue(net);
> >  	if (!(pegasus->flags & PEGASUS_UNPLUG))
> >  		disable_net_traffic(pegasus);
> 
> where is the netif_msg_ifdown()?

I didn't try to fix all pre-existing bugs ... but I did try
to put the existing messages into more appropriate packages,
and make use of that otherwise-pointless ethtool hook.


> > @@ -1094,12 +1164,14 @@
> >  
> >  	if (net->flags & IFF_PROMISC) {
> >  		pegasus->eth_regs[EthCtrl2] |= RX_PROMISCUOUS;
> > -		pr_info("%s: Promiscuous mode enabled.\n", net->name);
> > +		if (netif_msg_link(pegasus))
> > +			pr_info("%s: Promiscuous mode enabled.\n", net->name);
> >  	} else if ((net->mc_count > multicast_filter_limit) ||
> >  		   (net->flags & IFF_ALLMULTI)) {
> >  		pegasus->eth_regs[EthCtrl0] |= RX_MULTICAST;
> >  		pegasus->eth_regs[EthCtrl2] &= ~RX_PROMISCUOUS;
> > -		pr_info("%s: set allmulti\n", net->name);
> > +		if (netif_msg_link(pegasus))
> > +			pr_info("%s: set allmulti\n", net->name);
> >  	} else {
> >  		pegasus->eth_regs[EthCtrl0] &= ~RX_MULTICAST;
> >  		pegasus->eth_regs[EthCtrl2] &= ~RX_PROMISCUOUS;
> 
> inappropriate

Well then what _should_ a "link" message be for?  I guess you're
thinking it doesn't apply to that particular aspect of link status.
What filter should be used for those messages?  They should NOT
appear in all cases.


