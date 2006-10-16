Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWJPRob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWJPRob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWJPRob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:44:31 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:62204 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161030AbWJPRoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:44:30 -0400
Message-ID: <4533C4E9.1040504@cn.ibm.com>
Date: Tue, 17 Oct 2006 01:44:09 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Failed to boot kernel 2.6.19-rc2 due to IBM veth problem.
References: <4532613D.1090107@cn.ibm.com> <20061016014334.GA30921@localhost.localdomain>
In-Reply-To: <20061016014334.GA30921@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson 写道:
> On Mon, Oct 16, 2006 at 12:26:37AM +0800, Yao Fei Zhu wrote:
> 
>>Hi, all,
>>
>>Boot kernel 2.6.19-rc2 on IBM System P5 partitions will fall into xmon.
>>Here is the boot log,
> 
> 
> This is probably the same bug I recently posted about.  The patch
> below should fix it.
> 
> ibmveth: Fix index increment calculation
> 
> The recent commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773 introduced
> a bug in the producer/consumer index calculation in the ibmveth driver
> - incautious use of the post-increment ++ operator resulted in an
> increment being immediately reverted.  This patch corrects the logic.
> 
> Without this patch, the driver oopses almost immediately after
> activation on at least some machines.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> 
> Index: working-2.6/drivers/net/ibmveth.c
> ===================================================================
> --- working-2.6.orig/drivers/net/ibmveth.c	2006-10-13 14:19:54.000000000 +1000
> +++ working-2.6/drivers/net/ibmveth.c	2006-10-13 14:19:59.000000000 +1000
> @@ -212,8 +212,8 @@ static void ibmveth_replenish_buffer_poo
>  			break;
>  		}
>  
> -		free_index = pool->consumer_index++ % pool->size;
> -		pool->consumer_index = free_index;
> +		free_index = pool->consumer_index;
> +		pool->consumer_index = (pool->consumer_index + 1) % pool->size;
>  		index = pool->free_map[free_index];
>  
>  		ibmveth_assert(index != IBM_VETH_INVALID_MAP);
> @@ -329,8 +329,10 @@ static void ibmveth_remove_buffer_from_p
>  			 adapter->rx_buff_pool[pool].buff_size,
>  			 DMA_FROM_DEVICE);
>  
> -	free_index = adapter->rx_buff_pool[pool].producer_index++ % adapter->rx_buff_pool[pool].size;
> -	adapter->rx_buff_pool[pool].producer_index = free_index;
> +	free_index = adapter->rx_buff_pool[pool].producer_index;
> +	adapter->rx_buff_pool[pool].producer_index
> +		= (adapter->rx_buff_pool[pool].producer_index + 1)
> +		% adapter->rx_buff_pool[pool].size;
>  	adapter->rx_buff_pool[pool].free_map[free_index] = index;
>  
>  	mb();
> 
> 
David, I have verified this fix, it works fine for me, Thanks. What's the status of it? Submitted?

