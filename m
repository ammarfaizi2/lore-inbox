Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWESXQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWESXQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 19:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWESXQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 19:16:19 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:61332 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751433AbWESXQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 19:16:18 -0400
Message-ID: <446E51AB.9080703@myri.com>
Date: Sat, 20 May 2006 01:15:55 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
References: <20060517220218.GA13411@myri.com> <20060517220608.GD13411@myri.com> <200605180108.32949.arnd@arndb.de>
In-Reply-To: <200605180108.32949.arnd@arndb.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>> +static int myri10ge_open(struct net_device *dev)
>>     
>
> This function is too long to read easily.
>   

Ok we have split it a little bit.

>> +	/* allocate the host shadow rings */
>> +
>> +	bytes = 8 + (MYRI10GE_MCP_ETHER_MAX_SEND_DESC_TSO + 4)
>> +	    * sizeof(*mgp->tx.req_list);
>> +	mgp->tx.req_bytes = kmalloc(bytes, GFP_KERNEL);
>> +	if (mgp->tx.req_bytes == NULL)
>> +		goto abort_with_nothing;
>> +	memset(mgp->tx.req_bytes, 0, bytes);
>> +
>> +	/* ensure req_list entries are aligned to 8 bytes */
>> +	mgp->tx.req_list = (struct mcp_kreq_ether_send *)
>> +	    ALIGN((unsigned long)mgp->tx.req_bytes, 8);
>> +
>> +	bytes = rx_ring_entries * sizeof(*mgp->rx_small.shadow);
>> +	mgp->rx_small.shadow = kmalloc(bytes, GFP_KERNEL);
>> +	if (mgp->rx_small.shadow == NULL)
>> +		goto abort_with_tx_req_bytes;
>> +	memset(mgp->rx_small.shadow, 0, bytes);
>> +
>> +	bytes = rx_ring_entries * sizeof(*mgp->rx_big.shadow);
>> +	mgp->rx_big.shadow = kmalloc(bytes, GFP_KERNEL);
>> +	if (mgp->rx_big.shadow == NULL)
>> +		goto abort_with_rx_small_shadow;
>> +	memset(mgp->rx_big.shadow, 0, bytes);
>> +
>> +	/* allocate the host info rings */
>> +
>> +	bytes = tx_ring_entries * sizeof(*mgp->tx.info);
>> +	mgp->tx.info = kmalloc(bytes, GFP_KERNEL);
>> +	if (mgp->tx.info == NULL)
>> +		goto abort_with_rx_big_shadow;
>> +	memset(mgp->tx.info, 0, bytes);
>> +
>> +	bytes = rx_ring_entries * sizeof(*mgp->rx_small.info);
>> +	mgp->rx_small.info = kmalloc(bytes, GFP_KERNEL);
>> +	if (mgp->rx_small.info == NULL)
>> +		goto abort_with_tx_info;
>> +	memset(mgp->rx_small.info, 0, bytes);
>> +
>> +	bytes = rx_ring_entries * sizeof(*mgp->rx_big.info);
>> +	mgp->rx_big.info = kmalloc(bytes, GFP_KERNEL);
>> +	if (mgp->rx_big.info == NULL)
>> +		goto abort_with_rx_small_info;
>> +	memset(mgp->rx_big.info, 0, bytes);
>> +
>>     
>
> Can you do all these allocations at once? Maybe you can even
> move them into the size passed to alloc_etherdev.
>   

They are different things conceptually, so we prefer to allocate
them separately.

> If you need separate allocations, using kzalloc simplifies
> your code.
>   

Right, will do.

>> +		/* Break the SKB or Fragment up into pieces which
>> +		 * do not cross mgp->tx.boundary */
>> +		low = MYRI10GE_LOWPART_TO_U32(bus);
>> +		high_swapped = htonl(MYRI10GE_HIGHPART_TO_U32(bus));
>> +		while (len) {
>> +			u8 flags_next;
>> +			int cum_len_next;
>> +
>> +			if (unlikely(count == max_segments))
>> +				goto abort_linearize;
>> +
>> +			boundary = (low + tx->boundary) & ~(tx->boundary - 1);
>> +			seglen = boundary - low;
>> +			if (seglen > len)
>> +				seglen = len;
>> +			flags_next = flags & ~MYRI10GE_MCP_ETHER_FLAGS_FIRST;
>> +			cum_len_next = cum_len + seglen;
>> +#ifdef NETIF_F_TSO
>> +			if (mss) {	/* TSO */
>> +				(req - rdma_count)->rdma_count = rdma_count + 1;
>> +
>> +				if (likely(cum_len >= 0)) {	/* payload */
>> +					int next_is_first, chop;
>> +
>> +					chop = (cum_len_next > mss);
>> +					cum_len_next = cum_len_next % mss;
>> +					next_is_first = (cum_len_next == 0);
>> +					flags |= chop *
>> +					    MYRI10GE_MCP_ETHER_FLAGS_TSO_CHOP;
>> +					flags_next |= next_is_first *
>> +					    MYRI10GE_MCP_ETHER_FLAGS_FIRST;
>> +					rdma_count |= -(chop | next_is_first);
>> +					rdma_count += chop & !next_is_first;
>> +				} else if (likely(cum_len_next >= 0)) {	/* header ends */
>> +					int small;
>> +
>> +					rdma_count = -1;
>> +					cum_len_next = 0;
>> +					seglen = -cum_len;
>> +					small =
>> +					    (mss <=
>> +					     MYRI10GE_MCP_ETHER_SEND_SMALL_SIZE);
>> +					flags_next =
>> +					    MYRI10GE_MCP_ETHER_FLAGS_TSO_PLD |
>> +					    MYRI10GE_MCP_ETHER_FLAGS_FIRST |
>> +					    (small *
>> +					     MYRI10GE_MCP_ETHER_FLAGS_SMALL);
>> +				}
>> +			}
>>     
>
> 100 characters per line are too much, as are six levels of intentation,
> or the number of lines in this function.
> You should try to split into into smaller ones.
>   

We have tried :) But there is no nice way to split this code. So I guess
we will have to keep it like this.

Thanks,
Brice

