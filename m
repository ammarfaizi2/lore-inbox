Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWFGP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWFGP4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWFGP4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:56:48 -0400
Received: from es335.com ([67.65.19.105]:51822 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S932265AbWFGP4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:56:47 -0400
Subject: Re: [PATCH 2/7] AMSO1100 Low Level Driver.
From: Steve Wise <swise@opengridcomputing.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060531115906.30f4bbda@localhost.localdomain>
References: <20060531182733.3652.54755.stgit@stevo-desktop>
	 <20060531182737.3652.24752.stgit@stevo-desktop>
	 <20060531115906.30f4bbda@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 10:56:44 -0500
Message-Id: <1149695804.27684.42.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2006-05-31 at 11:59 -0700, Stephen Hemminger wrote:
> The following should be replaced with BUG_ON() or WARN_ON().
> and pr_debug()
> 
> +#ifdef C2_DEBUG
> +#define assert(expr)                                                  \
> +    if(!(expr)) {                                                     \
> +        printk(KERN_ERR PFX "Assertion failed! %s, %s, %s, line %d\n",\
> +               #expr, __FILE__, __FUNCTION__, __LINE__);              \
> +    }
> +#define dprintk(fmt, args...) do {printk(KERN_INFO PFX fmt, ##args);} while (0)
> +#else
> +#define assert(expr)          do {} while (0)
> +#define dprintk(fmt, args...) do {} while (0)
> +#endif				/* C2_DEBUG */
> 
> --------------------
> Also, you tend to use assert() as a bogus NULL pointer check.
> If you get passed a NULL, it is a bug, and the deref will fail
> and cause a pretty stack dump...
> 

done.

> 
> +static void c2_set_rxbufsize(struct c2_port *c2_port)
> +{
> +	struct net_device *netdev = c2_port->netdev;
> +
> +	assert(netdev != NULL);
> 
> Bogus, you will just fail on the deref below
> 

done.

> +
> +	if (netdev->mtu > RX_BUF_SIZE)
> +		c2_port->rx_buf_size =
> +		    netdev->mtu + ETH_HLEN + sizeof(struct c2_rxp_hdr) +
> +		    NET_IP_ALIGN;
> +	else
> +		c2_port->rx_buf_size = sizeof(struct c2_rxp_hdr) + RX_BUF_SIZE;
> +}
> 
> 
> +static void c2_rx_interrupt(struct net_device *netdev)
> +{
> +	struct c2_port *c2_port = netdev_priv(netdev);
> +	struct c2_dev *c2dev = c2_port->c2dev;
> +	struct c2_ring *rx_ring = &c2_port->rx_ring;
> +	struct c2_element *elem;
> +	struct c2_rx_desc *rx_desc;
> +	struct c2_rxp_hdr *rxp_hdr;
> +	struct sk_buff *skb;
> +	dma_addr_t mapaddr;
> +	u32 maplen, buflen;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c2dev->lock, flags);
> +
> +	/* Begin where we left off */
> +	rx_ring->to_clean = rx_ring->start + c2dev->cur_rx;
> +
> +	for (elem = rx_ring->to_clean; elem->next != rx_ring->to_clean;
> +	     elem = elem->next) {
> +		rx_desc = elem->ht_desc;
> +		mapaddr = elem->mapaddr;
> +		maplen = elem->maplen;
> +		skb = elem->skb;
> +		rxp_hdr = (struct c2_rxp_hdr *) skb->data;
> +
> +		if (rxp_hdr->flags != RXP_HRXD_DONE)
> +			break;
> +		buflen = rxp_hdr->len;
> +
> +		/* Sanity check the RXP header */
> +		if (rxp_hdr->status != RXP_HRXD_OK ||
> +		    buflen > (rx_desc->len - sizeof(*rxp_hdr))) {
> +			c2_rx_error(c2_port, elem);
> +			continue;
> +		}
> +
> +		/* 
> +		 * Allocate and map a new skb for replenishing the host 
> +		 * RX desc 
> +		 */
> +		if (c2_rx_alloc(c2_port, elem)) {
> +			c2_rx_error(c2_port, elem);
> +			continue;
> +		}
> +
> +		/* Unmap the old skb */
> +		pci_unmap_single(c2dev->pcidev, mapaddr, maplen,
> +				 PCI_DMA_FROMDEVICE);
> +
> 
> prefetch(skb->data) here will help performance.
> 
> 

good. ok.

> +		/*
> +		 * Skip past the leading 8 bytes comprising of the 
> +		 * "struct c2_rxp_hdr", prepended by the adapter 
> +		 * to the usual Ethernet header ("struct ethhdr"), 
> +		 * to the start of the raw Ethernet packet.
> +		 * 
> +		 * Fix up the various fields in the sk_buff before 
> +		 * passing it up to netif_rx(). The transfer size 
> +		 * (in bytes) specified by the adapter len field of 
> +		 * the "struct rxp_hdr_t" does NOT include the 
> +		 * "sizeof(struct c2_rxp_hdr)".
> +		 */
> +		skb->data += sizeof(*rxp_hdr);
> +		skb->tail = skb->data + buflen;
> +		skb->len = buflen;
> +		skb->dev = netdev;
> +		skb->protocol = eth_type_trans(skb, netdev);
> +
> +		/* Drop arp requests to the pseudo nic ip addr */
> +		if (unlikely(ntohs(skb->protocol) == ETH_P_ARP)) {
> +			u8 *tpa;
> +
> +			/* pull out the tgt ip addr */
> +			tpa = skb->data /* beginning of the arp packet */
> +				+ 8	/* arp addr fmts, lens, and opcode */
> +				+ 6  	/* arp src hw addr */
> +				+ 4 	/* arp src proto addr */
> +				+ 6;	/* arp tgt hw addr */
> +			if (is_rnic_addr(c2dev->pseudo_netdev, *((u32 *)tpa))) {
> +				dprintk("Dropping arp req for"
> +					" %03d.%03d.%03d.%03d\n",
> +					tpa[0], tpa[1], tpa[2], tpa[3]); 
> +				kfree_skb(skb);
> +				continue;
> +			}
> +		} 
> 
> This is looks like a mess, please do it at a higher level or
> code it with proper structure headers
> 

This code can be removed entirely.  It can be avoided having the c2
driver set in_dev->cnf.arp_ignore to 1 when loaded.


> +
> +		netif_rx(skb);
> +
> +		netdev->last_rx = jiffies;
> +		c2_port->netstats.rx_packets++;
> +		c2_port->netstats.rx_bytes += buflen;
> +	}
> +
> +	/* Save where we left off */
> +	rx_ring->to_clean = elem;
> +	c2dev->cur_rx = elem - rx_ring->start;
> +	C2_SET_CUR_RX(c2dev, c2dev->cur_rx);
> +
> +	spin_unlock_irqrestore(&c2dev->lock, flags);
> +}
> +
> +/*
> + * Handle netisr0 TX & RX interrupts.
> + */
> +static irqreturn_t c2_interrupt(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	unsigned int netisr0, dmaisr;
> +	int handled = 0;
> +	struct c2_dev *c2dev = (struct c2_dev *) dev_id;
> +
> +	assert(c2dev != NULL);
> +
> +	/* Process CCILNET interrupts */
> +	netisr0 = readl(c2dev->regs + C2_NISR0);
> +	if (netisr0) {
> +
> +		/*
> +		 * There is an issue with the firmware that always
> +		 * provides the status of RX for both TX & RX 
> +		 * interrupts.  So process both queues here.
> +		 */
> +		c2_rx_interrupt(c2dev->netdev);
> +		c2_tx_interrupt(c2dev->netdev);
> +
> +		/* Clear the interrupt */
> +		writel(netisr0, c2dev->regs + C2_NISR0);
> +		handled++;
> +	}
> +
> +	/* Process RNIC interrupts */
> +	dmaisr = readl(c2dev->regs + C2_DISR);
> +	if (dmaisr) {
> +		writel(dmaisr, c2dev->regs + C2_DISR);
> +		c2_rnic_interrupt(c2dev);
> +		handled++;
> +	}
> +
> +	if (handled) {
> +		return IRQ_HANDLED;
> +	} else {
> +		return IRQ_NONE;
> +	}
> 
> 	return IRQ_RETVAL(handled);
> +}
> +
> +static int c2_up(struct net_device *netdev)
> +{
> +	struct c2_port *c2_port = netdev_priv(netdev);
> +	struct c2_dev *c2dev = c2_port->c2dev;
> +	struct c2_element *elem;
> +	struct c2_rxp_hdr *rxp_hdr;
> +	size_t rx_size, tx_size;
> +	int ret, i;
> +	unsigned int netimr0;
> +
> +	assert(c2dev != NULL);
> 
> More bogus asserts
> 

removed.

<snip>

> +static struct net_device_stats *c2_get_stats(struct net_device *netdev)
> +{
> +	struct c2_port *c2_port = netdev_priv(netdev);
> +
> +	return &c2_port->netstats;
> +}
> +
> +static int c2_set_mac_address(struct net_device *netdev, void *p)
> +{
> +	return -1;
> +}
> 
> If you don't handle changing mac_address, just leaveing
> dev->set_mac_address will do the right thing.
> Also, if you need to return an error, use -ESOMEERROR, not -1.
> 

I'll remove c2_set_mac_address() entirely.

<snip>


> This seems like log spam, or developer debug thing.
> You need to learn to watch netlink event's from user space.
> 

Yes, the entire block below will be removed.  It's not needed.

> 
> +
> +#ifdef NETEVENT_NOTIFIER
> +static int netevent_notifier(struct notifier_block *self, unsigned long event,
> +			     void *data)
> +{
> +	int i;
> +	u8 *ha;
> +	struct neighbour *neigh = data;
> +	struct netevent_redirect *redir = data;
> +	struct netevent_route_change *rev = data;
> +
> +	switch (event) {
> +	case NETEVENT_ROUTE_UPDATE:
> +		printk(KERN_ERR "NETEVENT_ROUTE_UPDATE:\n");
> +		printk(KERN_ERR "fib_flags           : %d\n",
> +		       rev->fib_info->fib_flags);
> +		printk(KERN_ERR "fib_protocol        : %d\n",
> +		       rev->fib_info->fib_protocol);
> +		printk(KERN_ERR "fib_prefsrc         : %08x\n",
> +		       rev->fib_info->fib_prefsrc);
> +		printk(KERN_ERR "fib_priority        : %d\n",
> +		       rev->fib_info->fib_priority);
> +		break;
> +
> +	case NETEVENT_NEIGH_UPDATE:
> +		printk(KERN_ERR "NETEVENT_NEIGH_UPDATE:\n");
> +		printk(KERN_ERR "nud_state : %d\n", neigh->nud_state);
> +		printk(KERN_ERR "refcnt    : %d\n", neigh->refcnt);
> +		printk(KERN_ERR "used      : %d\n", neigh->used);
> +		printk(KERN_ERR "confirmed : %d\n", neigh->confirmed);
> +		printk(KERN_ERR "      ha: ");
> +		for (i = 0; i < neigh->dev->addr_len; i += 4) {
> +			ha = &neigh->ha[i];
> +			printk("%02x:%02x:%02x:%02x:", ha[0], ha[1], ha[2],
> +			       ha[3]);
> +		}
> +		printk("\n");
> +
> +		printk(KERN_ERR "%8s: ", neigh->dev->name);
> +		for (i = 0; i < neigh->dev->addr_len; i += 4) {
> +			ha = &neigh->ha[i];
> +			printk("%02x:%02x:%02x:%02x:", ha[0], ha[1], ha[2],
> +			       ha[3]);
> +		}
> +		printk("\n");
> +		break;
> +
> +	case NETEVENT_REDIRECT:
> +		printk(KERN_ERR "NETEVENT_REDIRECT:\n");
> +		printk(KERN_ERR "old: ");
> +		for (i = 0; i < redir->old->neighbour->dev->addr_len; i += 4) {
> +			ha = &redir->old->neighbour->ha[i];
> +			printk("%02x:%02x:%02x:%02x:", ha[0], ha[1], ha[2],
> +			       ha[3]);
> +		}
> +		printk("\n");
> +
> +		printk(KERN_ERR "new: ");
> +		for (i = 0; i < redir->new->neighbour->dev->addr_len; i += 4) {
> +			ha = &redir->new->neighbour->ha[i];
> +			printk("%02x:%02x:%02x:%02x:", ha[0], ha[1], ha[2],
> +			       ha[3]);
> +		}
> +		printk("\n");
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "NETEVENT_WTFO:\n");
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block nb = {
> +	.notifier_call = netevent_notifier,
> +};
> +#endif
> +/*



Thanks,

Steve.



