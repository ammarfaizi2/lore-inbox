Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVFBWHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFBWHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVFBWHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:07:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:47547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261407AbVFBWGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:06:01 -0400
Date: Thu, 2 Jun 2005 15:05:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][5/5] RapidIO support: net driver over messaging
Message-ID: <20050602150543.7e4326b6@dxpl.pdx.osdl.net>
In-Reply-To: <20050602143404.F24818@cox.net>
References: <20050602140359.B24818@cox.net>
	<20050602141247.C24818@cox.net>
	<20050602141946.D24818@cox.net>
	<20050602142509.E24818@cox.net>
	<20050602143404.F24818@cox.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How much is this like ethernet? does it still do ARP?
Can it do promiscious receive?

> +LIST_HEAD(rionet_peers);

Does this have to be global?

Not sure about the locking of this stuff, are you
relying on the RTNL?

> +
> +static int rionet_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +	struct rionet_private *rnet = ndev->priv;
> +
> +	if (netif_msg_drv(rnet))
> +		printk(KERN_WARNING
> +		       "%s: rionet_change_mtu(): not implemented\n", DRV_NAME);
> +
> +	return 0;
> +}

If you can allow any mtu then don't need this at all.
Or if you are limited then better return an error for bad values.

> +static void rionet_set_multicast_list(struct net_device *ndev)
> +{
> +	struct rionet_private *rnet = ndev->priv;
> +
> +	if (netif_msg_drv(rnet))
> +		printk(KERN_WARNING
> +		       "%s: rionet_set_multicast_list(): not implemented\n",
> +		       DRV_NAME);
> +}

If you can't handle it then just leave dev->set_multicast_list
as NULL and all attempts to add or delete will get -EINVAL

> +
> +static int rionet_open(struct net_device *ndev)
> +{


> +	/* Initialize inbound message ring */
> +	for (i = 0; i < RIONET_RX_RING_SIZE; i++)
> +		rnet->rx_skb[i] = NULL;
> +	rnet->rx_slot = 0;
> +	rionet_rx_fill(ndev, 0);
> +
> +	rnet->tx_slot = 0;
> +	rnet->tx_cnt = 0;
> +	rnet->ack_slot = 0;
> +
> +	spin_lock_init(&rnet->lock);
> +
> +	rnet->msg_enable = RIONET_DEFAULT_MSGLEVEL;

Better to do all initialization of the per device data
in the place it is allocated (rio_setup_netdev)
> +
> +static int rionet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
> +{
> +	return -EOPNOTSUPP;
> +}

Unneeded, if dev->do_ioctl is NULL, then all private ioctl's will
return -EINVAL that is what you want.

> +
> +static u32 rionet_get_link(struct net_device *ndev)
> +{
> +	return netif_carrier_ok(ndev);
> +}

Use ethtool_op_get_link
> +
> +static int rionet_setup_netdev(struct rio_mport *mport)
> +{
> +	int rc = 0;
> +	struct net_device *ndev = NULL;
> +	struct rionet_private *rnet;
> +	u16 device_id;
> +
> +	/* Allocate our net_device structure */
> +	ndev = alloc_etherdev(sizeof(struct rionet_private));
> +	if (ndev == NULL) {
> +		printk(KERN_INFO "%s: could not allocate ethernet device.\n",
> +		       DRV_NAME);
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * XXX hack, store point a static at ndev so we can get it...
> +	 * Perhaps need an array of these that the handler can
> +	 * index via the mbox number.
> +	 */
> +	sndev = ndev;
> +
> +	/* Set up private area */
> +	rnet = (struct rionet_private *)ndev->priv;
> +	rnet->mport = mport;
> +
> +	/* Set the default MAC address */
> +	device_id = rio_local_get_device_id(mport);
> +	ndev->dev_addr[0] = 0x00;
> +	ndev->dev_addr[1] = 0x01;
> +	ndev->dev_addr[2] = 0x00;
> +	ndev->dev_addr[3] = 0x01;
> +	ndev->dev_addr[4] = device_id >> 8;
> +	ndev->dev_addr[5] = device_id & 0xff;
> +
> +	/* Fill in the driver function table */
> +	ndev->open = &rionet_open;
> +	ndev->hard_start_xmit = &rionet_start_xmit;
> +	ndev->stop = &rionet_close;
> +	ndev->get_stats = &rionet_stats;
> +	ndev->change_mtu = &rionet_change_mtu;
> +	ndev->set_mac_address = &rionet_set_mac_address;
> +	ndev->set_multicast_list = &rionet_set_multicast_list;
> +	ndev->do_ioctl = &rionet_ioctl;
> +	SET_ETHTOOL_OPS(ndev, &rionet_ethtool_ops);
> +
> +	ndev->mtu = RIO_MAX_MSG_SIZE - 14;
> +
> +	SET_MODULE_OWNER(ndev);

Can you set any ndev->features to get better performance. 
	Can you take >32bit data addresses? then set HIGHDMA
	You are doing your on locking, can you use LLTX?
	Does the hardware support scatter gather?
