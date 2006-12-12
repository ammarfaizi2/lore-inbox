Return-Path: <linux-kernel-owner+w=401wt.eu-S932386AbWLLTXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWLLTXS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWLLTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:23:18 -0500
Received: from mga02.intel.com ([134.134.136.20]:11755 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386AbWLLTXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:23:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,525,1157353200"; 
   d="scan'208"; a="173595784:sNHT68575129"
Message-ID: <457F01A0.1000202@intel.com>
Date: Tue, 12 Dec 2006 11:23:12 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Yan Burman <burman.yan@gmail.com>
CC: linux-kernel@vger.kernel.org, auke-jan.h.kok@intel.com
Subject: Re: [PATCH 2.6.19] e1000: Replace kmalloc+memset with kcalloc + remove
 now unused size variable
References: <1165950539.10231.3.camel@localhost>
In-Reply-To: <1165950539.10231.3.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Burman wrote:
> Replace kmalloc+memset with kcalloc and remove unused size variable
> 
> Signed-off-by: Yan Burman <burman.yan@gmail.com>

nitpick, e1000 indenting indents successive lines to the first brace unsing spaces

thus:
foo_bar_baz_(aaaaaaaaaaa, bbbbbbbbbbb,
              cccccccc);

and not using tabs, or just a single tab.



Auke


> 
> diff -rubp linux-2.6.19_orig/drivers/net/e1000/e1000_ethtool.c linux-2.6.19/drivers/net/e1000/e1000_ethtool.c
> --- linux-2.6.19_orig/drivers/net/e1000/e1000_ethtool.c	2006-11-30 21:28:21.000000000 +0200
> +++ linux-2.6.19/drivers/net/e1000/e1000_ethtool.c	2006-12-12 20:54:31.000000000 +0200
> @@ -1045,19 +1045,18 @@ e1000_setup_desc_rings(struct e1000_adap
>  	struct e1000_rx_ring *rxdr = &adapter->test_rx_ring;
>  	struct pci_dev *pdev = adapter->pdev;
>  	uint32_t rctl;
> -	int size, i, ret_val;
> +	int i, ret_val;
>  
>  	/* Setup Tx descriptor ring and Tx buffers */
>  
>  	if (!txdr->count)
>  		txdr->count = E1000_DEFAULT_TXD;
>  
> -	size = txdr->count * sizeof(struct e1000_buffer);
> -	if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
> +	if (!(txdr->buffer_info = kcalloc(size, sizeof(struct e1000_buffer),
> +					GFP_KERNEL))) {

doesn't line up, no tabs please

>  		ret_val = 1;
>  		goto err_nomem;
>  	}
> -	memset(txdr->buffer_info, 0, size);
>  
>  	txdr->size = txdr->count * sizeof(struct e1000_tx_desc);
>  	E1000_ROUNDUP(txdr->size, 4096);
> @@ -1108,12 +1107,11 @@ e1000_setup_desc_rings(struct e1000_adap
>  	if (!rxdr->count)
>  		rxdr->count = E1000_DEFAULT_RXD;
>  
> -	size = rxdr->count * sizeof(struct e1000_buffer);
> -	if (!(rxdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
> +	if (!(rxdr->buffer_info = kcalloc(rxdr->count, sizeof(struct e1000_buffer),
> +					GFP_KERNEL))) {

same here

>  		ret_val = 4;
>  		goto err_nomem;
>  	}
> -	memset(rxdr->buffer_info, 0, size);
>  
>  	rxdr->size = rxdr->count * sizeof(struct e1000_rx_desc);
>  	if (!(rxdr->desc = pci_alloc_consistent(pdev, rxdr->size, &rxdr->dma))) {
> diff -rubp linux-2.6.19_orig/drivers/net/e1000/e1000_main.c linux-2.6.19/drivers/net/e1000/e1000_main.c
> --- linux-2.6.19_orig/drivers/net/e1000/e1000_main.c	2006-11-30 21:28:21.000000000 +0200
> +++ linux-2.6.19/drivers/net/e1000/e1000_main.c	2006-12-12 20:52:31.000000000 +0200
> @@ -1225,31 +1225,26 @@ e1000_sw_init(struct e1000_adapter *adap
>  static int __devinit
>  e1000_alloc_queues(struct e1000_adapter *adapter)
>  {
> -	int size;
> -
> -	size = sizeof(struct e1000_tx_ring) * adapter->num_tx_queues;
> -	adapter->tx_ring = kmalloc(size, GFP_KERNEL);
> +	adapter->tx_ring = kcalloc(adapter->num_tx_queues, 
> +		sizeof(struct e1000_tx_ring), GFP_KERNEL);

no tab, spaces until "sizeof" lines up with "adapter"

>  	if (!adapter->tx_ring)
>  		return -ENOMEM;
> -	memset(adapter->tx_ring, 0, size);
>  
> -	size = sizeof(struct e1000_rx_ring) * adapter->num_rx_queues;
> -	adapter->rx_ring = kmalloc(size, GFP_KERNEL);
> +	adapter->rx_ring = kcalloc(adapter->num_rx_queues,
> +		sizeof(struct e1000_rx_ring), GFP_KERNEL);

same here

>  	if (!adapter->rx_ring) {
>  		kfree(adapter->tx_ring);
>  		return -ENOMEM;
>  	}
> -	memset(adapter->rx_ring, 0, size);
>  
>  #ifdef CONFIG_E1000_NAPI
> -	size = sizeof(struct net_device) * adapter->num_rx_queues;
> -	adapter->polling_netdev = kmalloc(size, GFP_KERNEL);
> +	adapter->polling_netdev = kcalloc(adapter->num_rx_queues,
> +		sizeof(struct net_device), GFP_KERNEL);
>  	if (!adapter->polling_netdev) {
>  		kfree(adapter->tx_ring);
>  		kfree(adapter->rx_ring);
>  		return -ENOMEM;
>  	}
> -	memset(adapter->polling_netdev, 0, size);
>  #endif
>  
>  	return E1000_SUCCESS;
> @@ -1614,10 +1609,9 @@ e1000_setup_rx_resources(struct e1000_ad
>                           struct e1000_rx_ring *rxdr)
>  {
>  	struct pci_dev *pdev = adapter->pdev;
> -	int size, desc_len;
> +	int desc_len;
>  
> -	size = sizeof(struct e1000_buffer) * rxdr->count;
> -	rxdr->buffer_info = vmalloc(size);
> +	rxdr->buffer_info = vmalloc(sizeof(struct e1000_buffer) * rxdr->count);
>  	if (!rxdr->buffer_info) {
>  		DPRINTK(PROBE, ERR,
>  		"Unable to allocate memory for the receive descriptor ring\n");
> @@ -1625,18 +1619,17 @@ e1000_setup_rx_resources(struct e1000_ad
>  	}
>  	memset(rxdr->buffer_info, 0, size);
>  
> -	size = sizeof(struct e1000_ps_page) * rxdr->count;
> -	rxdr->ps_page = kmalloc(size, GFP_KERNEL);
> +	rxdr->ps_page = kcalloc(rxdr->count, sizeof(struct e1000_ps_page),
> +		GFP_KERNEL);
>  	if (!rxdr->ps_page) {
>  		vfree(rxdr->buffer_info);
>  		DPRINTK(PROBE, ERR,
>  		"Unable to allocate memory for the receive descriptor ring\n");
>  		return -ENOMEM;
>  	}
> -	memset(rxdr->ps_page, 0, size);
>  
> -	size = sizeof(struct e1000_ps_page_dma) * rxdr->count;
> -	rxdr->ps_page_dma = kmalloc(size, GFP_KERNEL);
> +	rxdr->ps_page_dma = kcalloc(rxdr->count, sizeof(struct e1000_ps_page_dma),
> +		GFP_KERNEL);
>  	if (!rxdr->ps_page_dma) {
>  		vfree(rxdr->buffer_info);
>  		kfree(rxdr->ps_page);
> @@ -1644,7 +1637,6 @@ e1000_setup_rx_resources(struct e1000_ad
>  		"Unable to allocate memory for the receive descriptor ring\n");
>  		return -ENOMEM;
>  	}
> -	memset(rxdr->ps_page_dma, 0, size);
>  
>  	if (adapter->hw.mac_type <= e1000_82547_rev_2)
>  		desc_len = sizeof(struct e1000_rx_desc);
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
