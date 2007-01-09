Return-Path: <linux-kernel-owner+w=401wt.eu-S1751288AbXAIKYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXAIKYF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXAIKYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:24:04 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41633 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbXAIKYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:24:01 -0500
Date: Tue, 9 Jan 2007 05:23:51 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches, updated] net driver fixes
Message-ID: <20070109102351.GA25438@filer.fsl.cs.sunysb.edu>
References: <20070109095058.GA12349@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109095058.GA12349@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 04:50:59AM -0500, Jeff Garzik wrote:
...
> diff --git a/drivers/net/chelsio/my3126.c b/drivers/net/chelsio/my3126.c
> index c7731b6..82fed1d 100644
> --- a/drivers/net/chelsio/my3126.c
> +++ b/drivers/net/chelsio/my3126.c
> @@ -170,9 +170,10 @@ static struct cphy *my3126_phy_create(adapter_t *adapter,
>  {
>  	struct cphy *cphy = kzalloc(sizeof (*cphy), GFP_KERNEL);
>  
> -	if (cphy)
> -		cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);
> +	if (!cphy)
> +		return NULL;
>  
> +	cphy_init(cphy, adapter, phy_addr, &my3126_ops, mdio_ops);
>  	INIT_DELAYED_WORK(&cphy->phy_update, my3216_poll);
>  	cphy->bmsr = 0;
>  
> diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
> index 4c1ff75..c6259c7 100644
> --- a/drivers/net/e1000/e1000_main.c
> +++ b/drivers/net/e1000/e1000_main.c
> @@ -995,12 +995,6 @@ e1000_probe(struct pci_dev *pdev,
>  	   (adapter->hw.mac_type != e1000_82547))
>  		netdev->features |= NETIF_F_TSO;
>  
> -#ifdef CONFIG_DEBUG_SLAB
> -	/* 82544's work arounds do not play nicely with DEBUG SLAB */
> -	if (adapter->hw.mac_type == e1000_82544)
> -		netdev->features &= ~NETIF_F_TSO;
> -#endif
> -
>  #ifdef NETIF_F_TSO6
>  	if (adapter->hw.mac_type > e1000_82547_rev_2)
>  		netdev->features |= NETIF_F_TSO6;
> diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
> index 2f48fe9..93f2b7a 100644
> --- a/drivers/net/forcedeth.c
> +++ b/drivers/net/forcedeth.c
> @@ -234,6 +234,7 @@ enum {
>  #define NVREG_XMITCTL_HOST_SEMA_MASK	0x0000f000
>  #define NVREG_XMITCTL_HOST_SEMA_ACQ	0x0000f000
>  #define NVREG_XMITCTL_HOST_LOADED	0x00004000
> +#define NVREG_XMITCTL_TX_PATH_EN	0x01000000
>  	NvRegTransmitterStatus = 0x088,
>  #define NVREG_XMITSTAT_BUSY	0x01
>  
> @@ -249,6 +250,7 @@ enum {
>  #define NVREG_OFFLOAD_NORMAL	RX_NIC_BUFSIZE
>  	NvRegReceiverControl = 0x094,
>  #define NVREG_RCVCTL_START	0x01
> +#define NVREG_RCVCTL_RX_PATH_EN	0x01000000
>  	NvRegReceiverStatus = 0x98,
>  #define NVREG_RCVSTAT_BUSY	0x01
>  
> @@ -1169,16 +1171,21 @@ static void nv_start_rx(struct net_device *dev)
>  {
>  	struct fe_priv *np = netdev_priv(dev);
>  	u8 __iomem *base = get_hwbase(dev);
> +	u32 rx_ctrl = readl(base + NvRegReceiverControl);
>  
>  	dprintk(KERN_DEBUG "%s: nv_start_rx\n", dev->name);
>  	/* Already running? Stop it. */
> -	if (readl(base + NvRegReceiverControl) & NVREG_RCVCTL_START) {
> -		writel(0, base + NvRegReceiverControl);
> +	if ((readl(base + NvRegReceiverControl) & NVREG_RCVCTL_START) && !np->mac_in_use) {
> +		rx_ctrl &= ~NVREG_RCVCTL_START;
> +		writel(rx_ctrl, base + NvRegReceiverControl);
>  		pci_push(base);
>  	}
>  	writel(np->linkspeed, base + NvRegLinkSpeed);
>  	pci_push(base);
> -	writel(NVREG_RCVCTL_START, base + NvRegReceiverControl);
> +        rx_ctrl |= NVREG_RCVCTL_START;
> +        if (np->mac_in_use)
> +		rx_ctrl &= ~NVREG_RCVCTL_RX_PATH_EN;
> +	writel(rx_ctrl, base + NvRegReceiverControl);
>  	dprintk(KERN_DEBUG "%s: nv_start_rx to duplex %d, speed 0x%08x.\n",
>  				dev->name, np->duplex, np->linkspeed);
>  	pci_push(base);

Bad indentation.

> --- a/drivers/net/ixgb/ixgb_main.c
> +++ b/drivers/net/ixgb/ixgb_main.c
...
> @@ -1324,6 +1330,13 @@ ixgb_tx_map(struct ixgb_adapter *adapter, struct sk_buff *skb,
>  		while(len) {
>  			buffer_info = &tx_ring->buffer_info[i];
>  			size = min(len, IXGB_MAX_DATA_PER_TXD);
> +
> +			/* Workaround for premature desc write-backs
> +			 * in TSO mode.  Append 4-byte sentinel desc */
> +			if (unlikely(mss && !nr_frags && size == len
> +			             && size > 8))
> +				size -= 4;
> +

The condition could be on one line.

>  			buffer_info->length = size;
>  			buffer_info->dma =
>  				pci_map_page(adapter->pdev,
> @@ -1398,11 +1411,43 @@ ixgb_tx_queue(struct ixgb_adapter *adapter, int count, int vlan_id,int tx_flags)
>  	IXGB_WRITE_REG(&adapter->hw, TDT, i);
>  }
>  
> +static int __ixgb_maybe_stop_tx(struct net_device *netdev, int size)
> +{
> +	struct ixgb_adapter *adapter = netdev_priv(netdev);
> +	struct ixgb_desc_ring *tx_ring = &adapter->tx_ring;
> +
> +	netif_stop_queue(netdev);
> +	/* Herbert's original patch had:
> +	 *  smp_mb__after_netif_stop_queue();
> +	 * but since that doesn't exist yet, just open code it. */
> +	smp_mb();
> +
> +	/* We need to check again in a case another CPU has just
> +	 * made room available. */
> +	if (likely(IXGB_DESC_UNUSED(tx_ring) < size))
> +		return -EBUSY;
> +
> +	/* A reprieve! */
> +	netif_start_queue(netdev);
> +	++adapter->restart_queue;
> +	return 0;
> +}
> +
> +static int ixgb_maybe_stop_tx(struct net_device *netdev,
> +                              struct ixgb_desc_ring *tx_ring, int size)
> +{
> +	if (likely(IXGB_DESC_UNUSED(tx_ring) >= size))
> +		return 0;
> +	return __ixgb_maybe_stop_tx(netdev, size);
> +}
> +
> +
>  /* Tx Descriptors needed, worst case */
>  #define TXD_USE_COUNT(S) (((S) >> IXGB_MAX_TXD_PWR) + \
>  			 (((S) & (IXGB_MAX_DATA_PER_TXD - 1)) ? 1 : 0))
> -#define DESC_NEEDED TXD_USE_COUNT(IXGB_MAX_DATA_PER_TXD) + \
> -	MAX_SKB_FRAGS * TXD_USE_COUNT(PAGE_SIZE) + 1
> +#define DESC_NEEDED TXD_USE_COUNT(IXGB_MAX_DATA_PER_TXD) /* skb->date */ + \
> +	MAX_SKB_FRAGS * TXD_USE_COUNT(PAGE_SIZE) + 1 /* for context */ \
> +	+ 1 /* one more needed for sentinel TSO workaround */

() around the additions

Josef "Jeff" Sipek.

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw
