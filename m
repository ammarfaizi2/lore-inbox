Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWIXP13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWIXP13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 11:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWIXP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 11:27:29 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:21464 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751177AbWIXP12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 11:27:28 -0400
Date: Sun, 24 Sep 2006 19:26:51 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: David Miller <davem@davemloft.net>, auke-jan.h.kok@intel.com,
       Holger.Kiehl@dwd.de, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org,
       john.ronciak@intel.com
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
Message-ID: <20060924152651.GA2077@2ka.mipt.ru>
References: <20060922004253.2e2e2612.akpm@osdl.org> <4514190C.8010901@intel.com> <20060922215000.c1fde093.akpm@osdl.org> <20060922.222507.74751476.davem@davemloft.net> <20060922223348.1b24fda5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060922223348.1b24fda5.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 24 Sep 2006 19:26:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 10:33:48PM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > The NET_IP_ALIGN existed not just for fun :)  There are ramifications
> > for removing it.
> 
> It's still there, isn't it?
> 
> For the 9k MTU case, for example, we end up allocating 16384 byte skbs
> instead of 32786 kbytes ones.

This patch will not help - netdev_alloc_skb() adds additional
NET_SKB_PAD and then alloc_skb() adds sizeof(struct skb_shared_info).
And even if you acconut for them in adapter->rx_buf_len, chip still can
overwrite that area (in the thread mentioned in this e-mail thread
before I posted such patch and received a dump of sizes chip receives -
there were a lot of _different_ ones which were too close to the limit).

> 
> diff -puN drivers/net/e1000/e1000_main.c~e1000-account-for-net_ip_align-when-calculating-bufsiz drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c~e1000-account-for-net_ip_align-when-calculating-bufsiz
> +++ a/drivers/net/e1000/e1000_main.c
> @@ -1101,7 +1101,7 @@ e1000_sw_init(struct e1000_adapter *adap
>  
>  	pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);
>  
> -	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
> +	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE + NET_IP_ALIGN;
>  	adapter->rx_ps_bsize0 = E1000_RXBUFFER_128;
>  	hw->max_frame_size = netdev->mtu +
>  			     ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
> @@ -3163,26 +3163,27 @@ e1000_change_mtu(struct net_device *netd
>  	 * larger slab size
>  	 * i.e. RXBUFFER_2048 --> size-4096 slab */
>  
> -	if (max_frame <= E1000_RXBUFFER_256)
> +	if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_256)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_256;
> -	else if (max_frame <= E1000_RXBUFFER_512)
> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_512)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_512;
> -	else if (max_frame <= E1000_RXBUFFER_1024)
> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_1024)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_1024;
> -	else if (max_frame <= E1000_RXBUFFER_2048)
> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_2048)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
> -	else if (max_frame <= E1000_RXBUFFER_4096)
> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_4096)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_4096;
> -	else if (max_frame <= E1000_RXBUFFER_8192)
> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_8192)
>  		adapter->rx_buffer_len = E1000_RXBUFFER_8192;
> -	else if (max_frame <= E1000_RXBUFFER_16384)
> +	else
>  		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
>  
>  	/* adjust allocation if LPE protects us, and we aren't using SBP */
>  	if (!adapter->hw.tbi_compatibility_on &&
>  	    ((max_frame == MAXIMUM_ETHERNET_FRAME_SIZE) ||
>  	     (max_frame == MAXIMUM_ETHERNET_VLAN_SIZE)))
> -		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
> +		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE +
> +					NET_IP_ALIGN;
>  
>  	netdev->mtu = new_mtu;
>  
> @@ -4002,7 +4003,8 @@ e1000_alloc_rx_buffers(struct e1000_adap
>  	struct e1000_buffer *buffer_info;
>  	struct sk_buff *skb;
>  	unsigned int i;
> -	unsigned int bufsz = adapter->rx_buffer_len + NET_IP_ALIGN;
> +	/* we have already accounted for NET_IP_ALIGN */
> +	unsigned int bufsz = adapter->rx_buffer_len;
>  
>  	i = rx_ring->next_to_use;
>  	buffer_info = &rx_ring->buffer_info[i];
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
	Evgeniy Polyakov
