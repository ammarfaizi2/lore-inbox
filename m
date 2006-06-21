Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWFUQcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWFUQcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWFUQcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:32:55 -0400
Received: from es335.com ([67.65.19.105]:47621 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S1750806AbWFUQcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:32:54 -0400
Subject: Re: [PATCH v3 1/7] AMSO1100 Low Level Driver.
From: Steve Wise <swise@opengridcomputing.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1150836226.2891.231.camel@laptopd505.fenrus.org>
References: <20060620203050.31536.5341.stgit@stevo-desktop>
	 <20060620203055.31536.15131.stgit@stevo-desktop>
	 <1150836226.2891.231.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:32:51 -0500
Message-Id: <1150907571.31600.31.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 22:43 +0200, Arjan van de Ven wrote:
> On Tue, 2006-06-20 at 15:30 -0500, Steve Wise wrote:
> 
> > +/*
> > + * Allocate TX ring elements and chain them together.
> > + * One-to-one association of adapter descriptors with ring elements.
> > + */
> > +static int c2_tx_ring_alloc(struct c2_ring *tx_ring, void *vaddr,
> > +			    dma_addr_t base, void __iomem * mmio_txp_ring)
> > +{
> > +	struct c2_tx_desc *tx_desc;
> > +	struct c2_txp_desc __iomem *txp_desc;
> > +	struct c2_element *elem;
> > +	int i;
> > +
> > +	tx_ring->start = kmalloc(sizeof(*elem) * tx_ring->count, GFP_KERNEL);
> 
> I would think this needs a dma_alloc_coherent() rather than a kmalloc...
> 

No, this memory is used to describe the tx ring from the host's
perspective.  The HW never touches this memory.  The HW's TX descriptor
ring is in adapter memory and is mapped into host memory (see
c2dev->mmio_txp_ring).

> 
> > +
> > +/* Free all buffers in RX ring, assumes receiver stopped */
> > +static void c2_rx_clean(struct c2_port *c2_port)
> > +{
> > +	struct c2_dev *c2dev = c2_port->c2dev;
> > +	struct c2_ring *rx_ring = &c2_port->rx_ring;
> > +	struct c2_element *elem;
> > +	struct c2_rx_desc *rx_desc;
> > +
> > +	elem = rx_ring->start;
> > +	do {
> > +		rx_desc = elem->ht_desc;
> > +		rx_desc->len = 0;
> > +
> > +		__raw_writew(0, elem->hw_desc + C2_RXP_STATUS);
> > +		__raw_writew(0, elem->hw_desc + C2_RXP_COUNT);
> > +		__raw_writew(0, elem->hw_desc + C2_RXP_LEN);
> 
> you seem to be a fan of the __raw_write() functions... any reason why?
> __raw_ is not a magic "go faster" prefix....
> 

In this particular case, I believe this is done to avoid a swap of '0'
since its not necessary.  In other places, __raw is used because the
adapter needs the data in BE and we want to explicitly swap it using
cpu_to_be* then raw_write it to the adapter memory...


> Also on a related note, have you checked the driver for the needed PCI
> posting flushes?
> 

Um, what's a 'PCI posting flush'?  Can you point me where its
described/used so I can see if we need it?  Thanx.


> > +
> > +	/* Disable IRQs by clearing the interrupt mask */
> > +	writel(1, c2dev->regs + C2_IDIS);
> > +	writel(0, c2dev->regs + C2_NIMR0);
> 
> like here...
> > +
> > +	elem = tx_ring->to_use;
> > +	elem->skb = skb;
> > +	elem->mapaddr = mapaddr;
> > +	elem->maplen = maplen;
> > +
> > +	/* Tell HW to xmit */
> > +	__raw_writeq(cpu_to_be64(mapaddr), elem->hw_desc + C2_TXP_ADDR);
> > +	__raw_writew(cpu_to_be16(maplen), elem->hw_desc + C2_TXP_LEN);
> > +	__raw_writew(cpu_to_be16(TXP_HTXD_READY), elem->hw_desc + C2_TXP_FLAGS);
> 
> or here
> 
> > +static int c2_change_mtu(struct net_device *netdev, int new_mtu)
> > +{
> > +	int ret = 0;
> > +
> > +	if (new_mtu < ETH_ZLEN || new_mtu > ETH_JUMBO_MTU)
> > +		return -EINVAL;
> > +
> > +	netdev->mtu = new_mtu;
> > +
> > +	if (netif_running(netdev)) {
> > +		c2_down(netdev);
> > +
> > +		c2_up(netdev);
> > +	}
> 
> this looks odd...
> 

The 1100 hardware caches the dma address of the next skb that will be
used to place data.  When the MTU changes, we want to free the SKBs in
the RX descriptor ring and get new ones that sufficient for the new MTU.
To effectively flush that cached address of the old skb, we must quiesce
the HW and firmware (via c2_down()), then reinitialize everything with
skb's big enough for the new mtu. 

Steve.


