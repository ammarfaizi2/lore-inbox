Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVFCWnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVFCWnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVFCWnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:43:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31622 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261157AbVFCWna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:43:30 -0400
Date: Fri, 3 Jun 2005 15:43:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][5/5] RapidIO support: net driver over messaging
Message-ID: <20050603154324.I32392@cox.net>
References: <20050602140359.B24818@cox.net> <20050602141247.C24818@cox.net> <20050602141946.D24818@cox.net> <20050602142509.E24818@cox.net> <20050602143404.F24818@cox.net> <20050602150543.7e4326b6@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050602150543.7e4326b6@dxpl.pdx.osdl.net>; from shemminger@osdl.org on Thu, Jun 02, 2005 at 03:05:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:05:43PM -0700, Stephen Hemminger wrote:
> How much is this like ethernet? does it still do ARP?

It's nothing like Ethernet, the only relation is that an Ethernet network
driver is easy to implement over top of raw message ports on a switched
fabric network. It gives easy access to RIO messaging from userspace
without inventing a new interface.

ARP works by the driver emulating a broadcast over RIO by sending the
same ARP packet to each node that is participating in the rionet. Nodes
join/leave the rionet by sending RIO-specific doorbell messages to
potential participants on the switched fabric. A table is kept to
flag active participants such that a fast lookup can be made to translate
the dst MAC address to a RIO device struct that is used to actually
send the Ethernet packet encapsulated into a standard RIO message
to the appropriate node(s).

> Can it do promiscious receive?

No.

> > +LIST_HEAD(rionet_peers);
> 
> Does this have to be global?

Nope, should be static. Fixing.

> Not sure about the locking of this stuff, are you
> relying on the RTNL?

Yes, last I looked that was sufficient for all the entry points.
I protect the driver-specific data (tx skb rings, etc.) with
a private lock.
 
> > +
> > +static int rionet_change_mtu(struct net_device *ndev, int new_mtu)
> > +{
> > +	struct rionet_private *rnet = ndev->priv;
> > +
> > +	if (netif_msg_drv(rnet))
> > +		printk(KERN_WARNING
> > +		       "%s: rionet_change_mtu(): not implemented\n", DRV_NAME);
> > +
> > +	return 0;
> > +}
> 
> If you can allow any mtu then don't need this at all.
> Or if you are limited then better return an error for bad values.

Ok, I do have a upper limit of 4082 as the RIO messages have a
max 4096 byte payload. That's the default on open as well. I'll
fix this up.

> > +static void rionet_set_multicast_list(struct net_device *ndev)
> > +{
> > +	struct rionet_private *rnet = ndev->priv;
> > +
> > +	if (netif_msg_drv(rnet))
> > +		printk(KERN_WARNING
> > +		       "%s: rionet_set_multicast_list(): not implemented\n",
> > +		       DRV_NAME);
> > +}
> 
> If you can't handle it then just leave dev->set_multicast_list
> as NULL and all attempts to add or delete will get -EINVAL

Will do. It was a placeholder at one point when I thought I might
emulate multicast in the driver...it's fallen down my priority
list.

> > +
> > +static int rionet_open(struct net_device *ndev)
> > +{
> 
> 
> > +	/* Initialize inbound message ring */
> > +	for (i = 0; i < RIONET_RX_RING_SIZE; i++)
> > +		rnet->rx_skb[i] = NULL;
> > +	rnet->rx_slot = 0;
> > +	rionet_rx_fill(ndev, 0);
> > +
> > +	rnet->tx_slot = 0;
> > +	rnet->tx_cnt = 0;
> > +	rnet->ack_slot = 0;
> > +
> > +	spin_lock_init(&rnet->lock);
> > +
> > +	rnet->msg_enable = RIONET_DEFAULT_MSGLEVEL;
> 
> Better to do all initialization of the per device data
> in the place it is allocated (rio_setup_netdev)

Right, will do.

> > +static int rionet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> Unneeded, if dev->do_ioctl is NULL, then all private ioctl's will
> return -EINVAL that is what you want.

Ah, ok. Good, none of the MII stuff applies in this case.
 
> > +static u32 rionet_get_link(struct net_device *ndev)
> > +{
> > +	return netif_carrier_ok(ndev);
> > +}
> 
> Use ethtool_op_get_link

Ok

<snip>

> > +	/* Fill in the driver function table */
> > +	ndev->open = &rionet_open;
> > +	ndev->hard_start_xmit = &rionet_start_xmit;
> > +	ndev->stop = &rionet_close;
> > +	ndev->get_stats = &rionet_stats;
> > +	ndev->change_mtu = &rionet_change_mtu;
> > +	ndev->set_mac_address = &rionet_set_mac_address;
> > +	ndev->set_multicast_list = &rionet_set_multicast_list;
> > +	ndev->do_ioctl = &rionet_ioctl;
> > +	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
> > +
> > +	ndev->mtu = RIO_MAX_MSG_SIZE - 14;
> > +
> > +	SET_MODULE_OWNER(ndev);
> 
> Can you set any ndev->features to get better performance. 
> 	Can you take >32bit data addresses? then set HIGHDMA
> 	You are doing your on locking, can you use LLTX?
> 	Does the hardware support scatter gather?

Some of these get tricky.  In general, rionet could support
SG and with driver help we can flag IP_CSUM. In practice, the
current generation MPC85xx HW on my development system have
some problems with their message port dma queues. In short,
their implementation is such that the arch-specific code is
forced to do a copy of the skb on both tx and rx. Because of
this, adding SG/IP_CSUM doesn't have any value yet...it'll make
sense to add the addtional features once we get a platform with
better messaging hardware. HIGHDMA may not be suitable on all
platforms. Since rionet sits on top of a hardware abstraction,
it doesn't have full knowledge of the DMA capabilities of the
hardware. We can eventually have some interfaces to the arch
code to learn that info, but it's not there yet.  I have to
look into LLTX, I know what it stands for, but I'm not sure
of the details.  Do you have a good LLTX example reference?

That said, my goal is to enable as many features as possible
when we have hw to take advantage of them.

-Matt
