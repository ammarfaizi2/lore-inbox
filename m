Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWIXV3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWIXV3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWIXV3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:29:21 -0400
Received: from mga03.intel.com ([143.182.124.21]:14963 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751528AbWIXV3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:29:20 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,210,1157353200"; 
   d="scan'208"; a="121857723:sNHT670826079"
Message-ID: <4516F57E.7090603@intel.com>
Date: Sun, 24 Sep 2006 14:15:42 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Holger.Kiehl@dwd.de, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@vger.kernel.org,
       john.ronciak@intel.com
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
References: <20060922004253.2e2e2612.akpm@osdl.org> <4514190C.8010901@intel.com> <20060922215000.c1fde093.akpm@osdl.org> <20060922.222507.74751476.davem@davemloft.net> <20060922223348.1b24fda5.akpm@osdl.org> <20060924152651.GA2077@2ka.mipt.ru>
In-Reply-To: <20060924152651.GA2077@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Fri, Sep 22, 2006 at 10:33:48PM -0700, Andrew Morton (akpm@osdl.org) wrote:
>>> The NET_IP_ALIGN existed not just for fun :)  There are ramifications
>>> for removing it.
>> It's still there, isn't it?
>>
>> For the 9k MTU case, for example, we end up allocating 16384 byte skbs
>> instead of 32786 kbytes ones.
> 
> This patch will not help - netdev_alloc_skb() adds additional
> NET_SKB_PAD and then alloc_skb() adds sizeof(struct skb_shared_info).
> And even if you acconut for them in adapter->rx_buf_len, chip still can
> overwrite that area (in the thread mentioned in this e-mail thread
> before I posted such patch and received a dump of sizes chip receives -
> there were a lot of _different_ ones which were too close to the limit).

I just did the math on it and it does not compute as I wanted too, we're 
basically flowing to the next larger buffersize 2 mtu bytes earlier, undoing 
any benefit completely.

There is not much that can fix this issue since the hardware will always 
receive in 2-order buffers and dma that back in its entirity, so we must always 
claim size for NET_IP_ALIGN and NET_SKB_PAD after the 2-order bufsz. For the 
9kb mtu case (16kb hw bufsz), we're stuck with 32kb slab allocations. bummer.

Andrew, please drop this patch.

Auke

> 
>> diff -puN drivers/net/e1000/e1000_main.c~e1000-account-for-net_ip_align-when-calculating-bufsiz drivers/net/e1000/e1000_main.c
>> --- a/drivers/net/e1000/e1000_main.c~e1000-account-for-net_ip_align-when-calculating-bufsiz
>> +++ a/drivers/net/e1000/e1000_main.c
>> @@ -1101,7 +1101,7 @@ e1000_sw_init(struct e1000_adapter *adap
>>  
>>  	pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);
>>  
>> -	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
>> +	adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE + NET_IP_ALIGN;
>>  	adapter->rx_ps_bsize0 = E1000_RXBUFFER_128;
>>  	hw->max_frame_size = netdev->mtu +
>>  			     ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
>> @@ -3163,26 +3163,27 @@ e1000_change_mtu(struct net_device *netd
>>  	 * larger slab size
>>  	 * i.e. RXBUFFER_2048 --> size-4096 slab */
>>  
>> -	if (max_frame <= E1000_RXBUFFER_256)
>> +	if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_256)
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_256;
>> -	else if (max_frame <= E1000_RXBUFFER_512)
>> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_512)
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_512;
>> -	else if (max_frame <= E1000_RXBUFFER_1024)
>> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_1024)
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_1024;
>> -	else if (max_frame <= E1000_RXBUFFER_2048)
>> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_2048)
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
>> -	else if (max_frame <= E1000_RXBUFFER_4096)
>> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_4096)
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_4096;
>> -	else if (max_frame <= E1000_RXBUFFER_8192)
>> +	else if (max_frame + NET_IP_ALIGN <= E1000_RXBUFFER_8192)
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_8192;
>> -	else if (max_frame <= E1000_RXBUFFER_16384)
>> +	else
>>  		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
>>  
>>  	/* adjust allocation if LPE protects us, and we aren't using SBP */
>>  	if (!adapter->hw.tbi_compatibility_on &&
>>  	    ((max_frame == MAXIMUM_ETHERNET_FRAME_SIZE) ||
>>  	     (max_frame == MAXIMUM_ETHERNET_VLAN_SIZE)))
>> -		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE;
>> +		adapter->rx_buffer_len = MAXIMUM_ETHERNET_VLAN_SIZE +
>> +					NET_IP_ALIGN;
>>  
>>  	netdev->mtu = new_mtu;
>>  
>> @@ -4002,7 +4003,8 @@ e1000_alloc_rx_buffers(struct e1000_adap
>>  	struct e1000_buffer *buffer_info;
>>  	struct sk_buff *skb;
>>  	unsigned int i;
>> -	unsigned int bufsz = adapter->rx_buffer_len + NET_IP_ALIGN;
>> +	/* we have already accounted for NET_IP_ALIGN */
>> +	unsigned int bufsz = adapter->rx_buffer_len;
>>  
>>  	i = rx_ring->next_to_use;
>>  	buffer_info = &rx_ring->buffer_info[i];
>> _
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
