Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWIMQ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWIMQ1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIMQ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:27:11 -0400
Received: from stinky.trash.net ([213.144.137.162]:22765 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750710AbWIMQ1I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:27:08 -0400
Message-ID: <4508315A.9070809@trash.net>
Date: Wed, 13 Sep 2006 18:27:06 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Roedel <joro-lkml@zlug.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH] EtherIP tunnel driver (RFC 3378)
References: <20060911204129.GA28929@zlug.org>
In-Reply-To: <20060911204129.GA28929@zlug.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are lots of whitespace errors (trailing whitespace, whitespace
following opening parens, no whitespace after comma, ...) which I'm
going to ignore below, please fix them anyway.

Joerg Roedel wrote:
> diff -uprN -X linux-2.6.17.13/Documentation/dontdiff linux-2.6.17.13-vanilla/net/ipv4/etherip.c linux-2.6.17.13/net/ipv4/etherip.c
> --- linux-2.6.17.13-vanilla/net/ipv4/etherip.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17.13/net/ipv4/etherip.c	2006-09-11 21:59:40.000000000 +0200
> @@ -0,0 +1,546 @@
> +/*
> + * etherip.c: Ethernet over IPv4 tunnel driver (according to RFC3378)
> + *
> + * This driver could be used to tunnel Ethernet packets through IPv4
> + * networks. This is especially usefull together with the bridging
> + * code in Linux.
> + *
> + * This code was written with an eye on the IPIP driver in linux from
> + * Sam Lantinga. Thanks for the great work.
> + *
> + *      This program is free software; you can redistribute it and/or
> + *      modify it under the terms of the GNU General Public License
> + *      version 2 (no later version) as published by the
> + *      Free Software Foundation.
> + *
> + */
> +
> +#include <linux/capability.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/ip.h>
> +#include <linux/if_tunnel.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
> +#include <linux/netfilter_ipv4.h>
> +#include <net/ip.h>
> +#include <net/protocol.h>
> +#include <net/route.h>
> +#include <net/ipip.h>
> +#include <net/xfrm.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Joerg Roedel <joerg@zlug.org>");
> +MODULE_DESCRIPTION("Ethernet over IPv4 tunnel driver");
> +
> +/* 
> + * These 2 defines are taken from ipip.c - if it's good enough for them
> + * it's good enough for me.
> + */
> +#define HASH_SIZE        16
> +#define HASH(addr)       ((addr^(addr>>4))&0xF)
> +
> +#define ETHERIP_HEADER   ((u16)0x0300)
> +#define ETHERIP_HLEN     2
> +
> +#define BANNER1 "etherip: Ethernet over IPv4 tunneling driver\n"
> +#define BANNER2 "etherip: (C) 2006 by Joerg Roedel <joerg@zlug.org>\n"
> +
> +struct etherip_tunnel {
> +	struct list_head list;
> +	struct net_device *dev;
> +	struct net_device_stats stats;
> +	struct ip_tunnel_parm parms;
> +	unsigned int recursion;
> +};
> +
> +static struct net_device *etherip_tunnel_dev;
> +static struct list_head tunnels[HASH_SIZE];
> +
> +static DEFINE_RWLOCK(etherip_lock);
> +
> +static void etherip_tunnel_setup(struct net_device *dev);
> +
> +/* add a tunnel to the hash */
> +static void etherip_tunnel_add(struct etherip_tunnel *tun)
> +{
> +	unsigned h = HASH(tun->parms.iph.daddr);
> +	list_add_tail(&tun->list, &tunnels[h]);
> +}
> +
> +/* delete a tunnel from the hash*/
> +static void etherip_tunnel_del(struct etherip_tunnel *tun)
> +{
> +	list_del(&tun->list);
> +}
> +
> +/* find a tunnel in the hash by parameters from userspace */
> +static struct etherip_tunnel* etherip_tunnel_find(struct ip_tunnel_parm *p)
> +{
> +	struct list_head *ptr;
> +	struct etherip_tunnel *ret;
> +	unsigned h = HASH(p->iph.daddr);
> +
> +	list_for_each(ptr, &tunnels[h]) {
> +		ret = list_entry(ptr, struct etherip_tunnel, list);

Again, please use list_for_each_entry

> +		if (ret->parms.iph.daddr == p->iph.daddr) {
> +			return ret;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/* find a tunnel by its destination address */
> +static struct etherip_tunnel* etherip_tunnel_locate(u32 remote)
> +{
> +	struct list_head *ptr;
> +	struct etherip_tunnel *ret;
> +	unsigned h = HASH(remote);
> +
> +	list_for_each(ptr, &tunnels[h]) {
> +		ret = list_entry(ptr, struct etherip_tunnel, list);
> +		if (ret->parms.iph.daddr == remote) {
> +			return ret;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/* netdevice start function */
> +static int etherip_tunnel_open(struct net_device *dev)
> +{
> +	netif_start_queue(dev);
> +	return 0;
> +}
> +
> +/* netdevice stop function */
> +static int etherip_tunnel_stop(struct net_device *dev)
> +{
> +	netif_stop_queue(dev);
> +	return 0;
> +}
> +
> +/* netdevice hard_start_xmit function
> + * it gets an Ethernet packet in skb and encapsulates it in another IP
> + * packet */
> +static int etherip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct etherip_tunnel *tunnel = netdev_priv(dev);
> +	struct rtable *rt;
> +	struct iphdr *iph;
> +	struct flowi fl;
> +	struct net_device *tdev;
> +	int max_headroom;
> +	struct net_device_stats *stats = &tunnel->stats;
> +
> +	if (tunnel->recursion++) {
> +		tunnel->stats.collisions++;
> +		goto tx_error;
> +	}
> +
> +	fl.oif = fl.iif      = 0;
> +	fl.proto             = IPPROTO_ETHERIP;
> +	fl.nl_u.ip4_u.daddr  = tunnel->parms.iph.daddr;
> +	fl.nl_u.ip4_u.saddr  = tunnel->parms.iph.saddr;
> +	fl.nl_u.ip4_u.fwmark = 0;
> +	fl.nl_u.ip4_u.tos    = 0;

This still leaves the entire uli_u part as well as flags uninitialized.
Just use memset or initialize the entire structure at once. fl.oif
should be set to parms.link.

> +
> +	if (ip_route_output_key(&rt, &fl)) {
> +		tunnel->stats.tx_carrier_errors++;
> +		goto tx_error_icmp;
> +	}
> +
> +	tdev = rt->u.dst.dev;
> +	if (tdev == dev) {
> +		ip_rt_put(rt);
> +		tunnel->stats.collisions++;
> +		goto tx_error;
> +	}
> +
> +	max_headroom = (LL_RESERVED_SPACE(tdev)+sizeof(struct iphdr)
> +			+ ETHERIP_HLEN);
> +
> +	if (skb_headroom(skb) < max_headroom || skb_cloned(skb)
> +			|| skb_shared(skb)) {
> +		struct sk_buff *n_skb = skb_realloc_headroom(skb,max_headroom);
> +		if (!n_skb) {
> +			ip_rt_put(rt);
> +			dev_kfree_skb(skb);
> +			tunnel->stats.tx_dropped++;
> +			return 0;
> +		}
> +		if (skb->sk)
> +			skb_set_owner_w(n_skb, skb->sk);
> +		dev_kfree_skb(skb);
> +		skb = n_skb;
> +	}
> +
> +	skb->h.raw = skb->nh.raw;
> +	skb->nh.raw = skb_push(skb, sizeof(struct iphdr)+ETHERIP_HLEN);
> +	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
> +	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE | IPSKB_XFRM_TRANSFORMED |
> +			IPSKB_REROUTED); 
> +	dst_release(skb->dst);

Still no propagation of the pmtu to the original dst_entry.

> +	skb->dst = &rt->u.dst;
> +
> +	/* Build the IP header for the outgoing packet
> +	 *
> +	 * Note: This driver never sets the DF flag on outgoing packets
> +	 *       to ensure that the tunnel provides the full Ethernet MTU.
> +	 *       This behavior guarantees that protocols can be
> +	 *       encapsulated within the Ethernet packet which do not
> +	 *       know the concept of a path MTU
> +	 */
> +	iph = skb->nh.iph;
> +	iph->version = 4;
> +	iph->ihl = sizeof(struct iphdr)>>2;
> +	iph->frag_off = 0;
> +	iph->protocol = IPPROTO_ETHERIP;
> +	iph->tos = 0;
> +	iph->daddr = rt->rt_dst;
> +	iph->saddr = rt->rt_src;
> +	iph->ttl = tunnel->parms.iph.ttl;
> +	if (iph->ttl == 0)
> +		iph->ttl = dst_metric(&rt->u.dst, RTAX_HOPLIMIT);
> +
> +	/* add the 16bit etherip header after the ip header */
> +	*((u16*)(skb->nh.raw + sizeof(struct iphdr))) = ntohs(ETHERIP_HEADER);
> +	nf_reset(skb);
> +	IPTUNNEL_XMIT();
> +	tunnel->dev->trans_start = jiffies;
> +	tunnel->recursion--;
> +
> +	return 0;
> +
> +tx_error_icmp:
> +	dst_link_failure(skb);
> +
> +tx_error:
> +	tunnel->stats.tx_errors++;
> +	dev_kfree_skb(skb);
> +	tunnel->recursion--;
> +	return 0;
> +}
> +
> +/* get statistics callback */
> +static struct net_device_stats *etherip_tunnel_stats(struct net_device *dev)
> +{
> +	struct etherip_tunnel *ethip = netdev_priv(dev);
> +	return &ethip->stats;
> +}
> +
> +/* checks parameters the driver gets from userspace */
> +static int etherip_param_check(struct ip_tunnel_parm *p)
> +{
> +	if ((p->iph.version != 4)
> +		|| (p->iph.protocol != IPPROTO_ETHERIP)
> +		|| (p->iph.ihl != 5)
> +		|| (p->iph.daddr == INADDR_ANY)
> +		|| MULTICAST(p->iph.daddr))
> +		return -EINVAL;

Lots of unnecessary parens (here and elsewhere). It also becomes more
readable IMO if you put the || at the end of the line and align the
conditions:

if (p->iph.version != 4 ||
    p->iph.protocol != IPPROTO_ETHERIP ||
    p->iph.ihl != 4 ||
...

Well, thats just my taste, but a single tab is in my opinion the
worst of all choices since it fails to make the distinction between
the condition and the following expression visible.

> +
> +	return 0;
> +}
> +
> +/* central ioctl function for all netdevices this driver manages
> + * it allows to create, delete, modify a tunnel and fetch tunnel
> + * information */
> +static int etherip_tunnel_ioctl(struct net_device *dev, struct ifreq *ifr,
> +		int cmd)
> +{
> +	int err = 0;
> +	struct ip_tunnel_parm p;
> +	struct net_device *new_dev;
> +	char *dev_name;
> +	struct etherip_tunnel *t;
> +
> +
> +	switch (cmd) {
> +	case SIOCGETTUNNEL:
> +		err = -EINVAL;
> +		if (dev == etherip_tunnel_dev)
> +			goto out;
> +		t = netdev_priv(dev);
> +		if (copy_to_user(ifr->ifr_ifru.ifru_data, &t->parms,
> +				sizeof(t->parms)))
> +			err = -EFAULT;

break

> +		err = 0;
> +		break;
> +	case SIOCADDTUNNEL:
> +		err = -EINVAL;
> +		if (dev != etherip_tunnel_dev)
> +			goto out;
> +
> +	case SIOCCHGTUNNEL:
> +		err = -EPERM;
> +		if (!capable(CAP_NET_ADMIN))
> +			goto out;
> +
> +		err = -EFAULT;
> +		if (copy_from_user(&p, ifr->ifr_ifru.ifru_data,
> +					sizeof(p)))
> +			goto out;
> +
> +		if ((err = etherip_param_check(&p)) < 0)
> +			goto out;
> +
> +		t = etherip_tunnel_find(&p);
> +
> +		err = -EEXIST;
> +		if ((t != NULL) && (t->dev != dev))
> +			goto out;
> +
> +		if (cmd == SIOCADDTUNNEL) {
> +
> +			p.name[IFNAMSIZ-1] = 0;
> +			dev_name = p.name;
> +			if (dev_name[0] == 0)
> +				dev_name = "ethip%d";
> +
> +			err = -ENOMEM;
> +			new_dev = alloc_netdev(
> +					sizeof(struct etherip_tunnel),
> +					dev_name,
> +					etherip_tunnel_setup);
> +
> +			if (new_dev == NULL)
> +				goto out;
> +				
> +			if (strchr(new_dev->name, '%')) {
> +				err = dev_alloc_name( new_dev, new_dev->name);
> +				if (err < 0)
> +					goto add_err;
> +			}
> +			
> +			t = netdev_priv(new_dev);
> +			t->dev = new_dev;
> +			strncpy(p.name, new_dev->name, IFNAMSIZ);
> +			memcpy(&(t->parms), &p, sizeof(p));
> +				
> +			err = register_netdevice(new_dev);
> +			if (err < 0)
> +				goto add_err;
> +
> +			err = -EFAULT;
> +			if (copy_to_user(ifr->ifr_ifru.ifru_data, &p,
> +						sizeof(p)))
> +				goto add_err;

You can't just free the device once its registered.

> +			
> +			write_lock(&etherip_lock);

Needs bh protection.

> +			etherip_tunnel_add(t);
> +			write_unlock(&etherip_lock);
> +
> +		} else {
> +			err = -EINVAL;
> +			if ((t = netdev_priv(dev)) == NULL)
> +				goto out;
> +			if (dev == etherip_tunnel_dev)
> +				goto out;
> +			write_lock(&etherip_lock);
> +			memcpy(&(t->parms), &p, sizeof(p));
> +			write_unlock(&etherip_lock);
> +		}
> +
> +		err = 0;
> +		break;
> +add_err:
> +		free_netdev(new_dev);
> +		goto out;
> +
> +	case SIOCDELTUNNEL:
> +		err = -EPERM;
> +		if (!capable(CAP_NET_ADMIN))
> +			goto out;
> +
> +		err = -EINVAL;
> +		if (dev == etherip_tunnel_dev)
> +			goto out;
> +
> +		t = netdev_priv(dev);
> +			
> +		write_lock(&etherip_lock);
> +		etherip_tunnel_del(t);
> +		write_unlock(&etherip_lock);
> +
> +		unregister_netdevice(t->dev);
> +		err = 0;
> +
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +/* device init function - called via register_netdevice
> + * The tunnel is registered as an Ethernet device. This allows
> + * the tunnel to be added to a bridge */
> +static void etherip_tunnel_setup(struct net_device *dev)
> +{
> +	SET_MODULE_OWNER(dev);
> +	dev->open = etherip_tunnel_open;
> +	dev->hard_start_xmit = etherip_tunnel_xmit;
> +	dev->stop = etherip_tunnel_stop;
> +	dev->get_stats = etherip_tunnel_stats;
> +	dev->do_ioctl = etherip_tunnel_ioctl;
> +	dev->destructor = free_netdev;
> +
> +	ether_setup(dev);
> +	dev->tx_queue_len = 0;
> +	random_ether_addr(dev->dev_addr);
> +}
> +
> +/* receive function for EtherIP packets
> + * Does some basic checks on the MAC addresses and
> + * interface modes */
> +static int etherip_rcv(struct sk_buff *skb)
> +{
> +	struct iphdr *iph;
> +	struct ethhdr *ehdr;
> +	struct etherip_tunnel *tunnel;
> +	struct net_device *dev;
> +
> +	iph = skb->nh.iph;
> +
> +	read_lock(&etherip_lock);
> +	tunnel = etherip_tunnel_locate(iph->saddr);
> +	if (tunnel == NULL)
> +		goto drop;
> +
> +	dev = tunnel->dev;
> +	secpath_reset(skb);
> +	memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
> +	skb_pull(skb, (skb->nh.raw - skb->data)
> +			+ sizeof(struct iphdr) + ETHERIP_HLEN);
> +	ehdr = (struct ethhdr*)skb->data;
> +	skb->dev = dev;
> +	skb->pkt_type = PACKET_HOST;
> +	skb->protocol = eth_type_trans(skb, tunnel->dev);
> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> +	dst_release(skb->dst);
> +	skb->dst = NULL;
> +
> +	/* do some checks */
> +	if (skb->pkt_type == PACKET_HOST || skb->pkt_type == PACKET_BROADCAST)
> +		goto accept;
> +
> +	if (skb->pkt_type == PACKET_MULTICAST &&
> +			(dev->mc_count > 0 || dev->flags & IFF_ALLMULTI))
> +		goto accept;
> +	
> +	if (skb->pkt_type == PACKET_OTHERHOST && dev->flags & IFF_PROMISC)
> +		goto accept;
> +
> +	goto drop;
> +
> +accept:
> +	tunnel->dev->last_rx = jiffies;
> +	tunnel->stats.rx_packets++;
> +	tunnel->stats.rx_bytes += skb->len;
> +	nf_reset(skb);
> +	netif_rx(skb);
> +	read_unlock(&etherip_lock);
> +	return 0;
> +
> +drop:
> +	read_unlock(&etherip_lock);
> +	kfree_skb(skb);
> +	return 0;
> +}
> +
> +static struct net_protocol etherip_protocol = {
> +	.handler      = etherip_rcv,
> +	.err_handler  = 0,
> +	.no_policy    = 1,

This is wrong, you don't do any policy checks in your code.

> +};
> +
> +/* module init function
> + * initializes the EtherIP protocol (97) and registers the initial
> + * device */
> +static int __init etherip_init(void)
> +{
> +	int err, i;
> +	struct etherip_tunnel *p;
> +
> +	printk(KERN_INFO BANNER1);
> +	printk(KERN_INFO BANNER2);
> +
> +	for (i=0;i<HASH_SIZE;++i)
> +		INIT_LIST_HEAD(&tunnels[i]);
> +
> +	if (inet_add_protocol(&etherip_protocol, IPPROTO_ETHERIP)) {
> +		printk(KERN_ERR "etherip: can't add protocol\n");
> +		return -EAGAIN;
> +	}
> +
> +	etherip_tunnel_dev = alloc_netdev(sizeof(struct etherip_tunnel),
> +			"ethip0",
> +			etherip_tunnel_setup);
> +	
> +	if (!etherip_tunnel_dev) {
> +		err = -ENOMEM;
> +		goto err2;
> +	}
> +
> +	p = netdev_priv(etherip_tunnel_dev);
> +	p->dev = etherip_tunnel_dev;
> +
> +	if ((err = register_netdev(etherip_tunnel_dev)))
> +		goto err1;
> +
> +out:
> +	return err;
> +err1:
> +	free_netdev(etherip_tunnel_dev);
> +err2:
> +	inet_del_protocol(&etherip_protocol, IPPROTO_ETHERIP);
> +	goto out;
> +}
> +
> +/* destroy all tunnels */
> +static void __exit etherip_destroy_tunnels(void)
> +{
> +	int i;
> +	struct list_head *ptr;
> +	struct etherip_tunnel *tun;
> +	
> +	for (i=0;i<HASH_SIZE;++i) {
> +		/*
> +		ptr = tunnels[i].next;
> +		while (ptr != &(tunnels[i])) {
> +			ret = list_entry(ptr, struct etherip_tunnel, list);
> +			ptr = ptr->next;
> +			unregister_netdevice(ret->dev);
> +		}*/
> +		list_for_each(ptr, &tunnels[i]) {
> +			tun = list_entry(ptr, struct etherip_tunnel, list);
> +			ptr = ptr->prev;
> +			etherip_tunnel_del(tun);
> +			unregister_netdevice(tun->dev);
> +		}
> +	}
> +}
> +
> +/* module cleanup function */
> +static void __exit etherip_exit(void)
> +{
> +	rtnl_lock();
> +	etherip_destroy_tunnels();
> +	unregister_netdevice(etherip_tunnel_dev);
> +	rtnl_unlock();
> +	if (inet_del_protocol(&etherip_protocol, IPPROTO_ETHERIP))
> +		printk(KERN_ERR "etherip: can't remove protocol\n");
> +}
> +
> +module_init(etherip_init);
> +module_exit(etherip_exit);


