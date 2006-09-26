Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWIZUdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWIZUdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWIZUdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:33:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:58921 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S964790AbWIZUda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:33:30 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,221,1157353200"; 
   d="scan'208"; a="136413902:sNHT520594207"
Message-ID: <45198E27.2070709@intel.com>
Date: Tue, 26 Sep 2006 13:31:35 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mm-commits@vger.kernel.org, auke-jan.h.kok@intel.com, jeff@garzik.org,
       stable@kernel.org
Subject: Re: + e1000-account-for-net_ip_align-when-calculating-bufsiz.patch
 added to -mm tree
References: <200609230447.k8N4llZe005123@shell0.pdx.osdl.net>
In-Reply-To: <200609230447.k8N4llZe005123@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2006 20:33:26.0462 (UTC) FILETIME=[04E82DE0:01C6E1AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> The patch titled
> 
>      e1000: account for NET_IP_ALIGN when calculating bufsiz
> 
> has been added to the -mm tree.  Its filename is
> 
>      e1000-account-for-net_ip_align-when-calculating-bufsiz.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this


Andrew,

can you drop this patch? Discussion and testing showed that it does the reverse 
of what it needs to be for the cornercases and doesn't fix anything.

old case 255 max_frame -> 256 buffer -> 512 slab
this patch 255 max_frame -> 512 buffer -> 1024 slab (!)

Thanks,

Auke


> 
> ------------------------------------------------------
> Subject: e1000: account for NET_IP_ALIGN when calculating bufsiz
> From: Auke Kok <auke-jan.h.kok@intel.com>
> 
> Account for NET_IP_ALIGN when requesting buffer sizes from netdev_alloc_skb
> to reduce slab allocation by half.
> 
> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/net/e1000/e1000_main.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
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
> Patches currently in -mm which might be from auke-jan.h.kok@intel.com are
> 
> git-netdev-all.patch
> e1000-memory-leak-in-e1000_set_ringparam.patch
> e1000-account-for-net_ip_align-when-calculating-bufsiz.patch
> e1000_7033_dump_ring.patch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe mm-commits" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
