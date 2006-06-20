Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWFTUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWFTUoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWFTUn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:43:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750870AbWFTUn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:43:58 -0400
Subject: Re: [PATCH v3 1/7] AMSO1100 Low Level Driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060620203055.31536.15131.stgit@stevo-desktop>
References: <20060620203050.31536.5341.stgit@stevo-desktop>
	 <20060620203055.31536.15131.stgit@stevo-desktop>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 22:43:46 +0200
Message-Id: <1150836226.2891.231.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 15:30 -0500, Steve Wise wrote:

> +/*
> + * Allocate TX ring elements and chain them together.
> + * One-to-one association of adapter descriptors with ring elements.
> + */
> +static int c2_tx_ring_alloc(struct c2_ring *tx_ring, void *vaddr,
> +			    dma_addr_t base, void __iomem * mmio_txp_ring)
> +{
> +	struct c2_tx_desc *tx_desc;
> +	struct c2_txp_desc __iomem *txp_desc;
> +	struct c2_element *elem;
> +	int i;
> +
> +	tx_ring->start = kmalloc(sizeof(*elem) * tx_ring->count, GFP_KERNEL);

I would think this needs a dma_alloc_coherent() rather than a kmalloc...


> +
> +/* Free all buffers in RX ring, assumes receiver stopped */
> +static void c2_rx_clean(struct c2_port *c2_port)
> +{
> +	struct c2_dev *c2dev = c2_port->c2dev;
> +	struct c2_ring *rx_ring = &c2_port->rx_ring;
> +	struct c2_element *elem;
> +	struct c2_rx_desc *rx_desc;
> +
> +	elem = rx_ring->start;
> +	do {
> +		rx_desc = elem->ht_desc;
> +		rx_desc->len = 0;
> +
> +		__raw_writew(0, elem->hw_desc + C2_RXP_STATUS);
> +		__raw_writew(0, elem->hw_desc + C2_RXP_COUNT);
> +		__raw_writew(0, elem->hw_desc + C2_RXP_LEN);

you seem to be a fan of the __raw_write() functions... any reason why?
__raw_ is not a magic "go faster" prefix....

Also on a related note, have you checked the driver for the needed PCI
posting flushes?

> +
> +	/* Disable IRQs by clearing the interrupt mask */
> +	writel(1, c2dev->regs + C2_IDIS);
> +	writel(0, c2dev->regs + C2_NIMR0);

like here...
> +
> +	elem = tx_ring->to_use;
> +	elem->skb = skb;
> +	elem->mapaddr = mapaddr;
> +	elem->maplen = maplen;
> +
> +	/* Tell HW to xmit */
> +	__raw_writeq(cpu_to_be64(mapaddr), elem->hw_desc + C2_TXP_ADDR);
> +	__raw_writew(cpu_to_be16(maplen), elem->hw_desc + C2_TXP_LEN);
> +	__raw_writew(cpu_to_be16(TXP_HTXD_READY), elem->hw_desc + C2_TXP_FLAGS);

or here

> +static int c2_change_mtu(struct net_device *netdev, int new_mtu)
> +{
> +	int ret = 0;
> +
> +	if (new_mtu < ETH_ZLEN || new_mtu > ETH_JUMBO_MTU)
> +		return -EINVAL;
> +
> +	netdev->mtu = new_mtu;
> +
> +	if (netif_running(netdev)) {
> +		c2_down(netdev);
> +
> +		c2_up(netdev);
> +	}

this looks odd...



