Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWJMEVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWJMEVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 00:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWJMEVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 00:21:25 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:39906 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751602AbWJMEVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 00:21:24 -0400
Date: Fri, 13 Oct 2006 14:20:59 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Santiago Leon <santil@us.ibm.com>, Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: veth crash (commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773)
Message-ID: <20061013042059.GA6500@localhost.localdomain>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Santiago Leon <santil@us.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061012082214.GA9154@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012082214.GA9154@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 06:22:14PM +1000, David Gibson wrote:
> Your recent ibmveth commit, 751ae21c6cd1493e3d0a4935b08fb298b9d89773
> ("fix int rollover panic"), causes a rapid oops on my test machine
> (POWER5 LPAR).
> 
> I've bisected it down to that commit, but am still investigating the
> cause of the crash itself.

Found the problem, I believe: an object lesson in the need for great
caution using ++.

[...]
@@ -213,6 +213,7 @@ static void ibmveth_replenish_buffer_poo
 		}
 
 		free_index = pool->consumer_index++ % pool->size;
+		pool->consumer_index = free_index;
 		index = pool->free_map[free_index];
 
 		ibmveth_assert(index != IBM_VETH_INVALID_MAP);

Since the ++ is used as post-increment, the increment is not included
in free_index, and so the added line effectively reverts the
increment.  The produced_index side has an analagous bug.

Jeff, Santiago, please apply the patch below to correct this:

ibmveth: Fix index increment calculation

The recent commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773 introduced
a bug in the producer/consumer index calculation in the ibmveth driver
- incautious use of the post-increment ++ operator resulted in an
increment being immediately reverted.  This patch corrects the logic.

Without this patch, the driver oopses almost immediately after
activation on at least some machines.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/drivers/net/ibmveth.c
===================================================================
--- working-2.6.orig/drivers/net/ibmveth.c	2006-10-13 14:12:49.000000000 +1000
+++ working-2.6/drivers/net/ibmveth.c	2006-10-13 14:14:24.000000000 +1000
@@ -212,8 +212,8 @@ static void ibmveth_replenish_buffer_poo
 			break;
 		}
 
-		free_index = pool->consumer_index++ % pool->size;
-		pool->consumer_index = free_index;
+		free_index = pool->consumer_index;
+		pool->consumer_index = (pool->consumer_index + 1) % pool->size;
 		index = pool->free_map[free_index];
 
 		ibmveth_assert(index != IBM_VETH_INVALID_MAP);
@@ -329,8 +329,10 @@ static void ibmveth_remove_buffer_from_p
 			 adapter->rx_buff_pool[pool].buff_size,
 			 DMA_FROM_DEVICE);
 
-	free_index = adapter->rx_buff_pool[pool].producer_index++ % adapter->rx_buff_pool[pool].size;
-	adapter->rx_buff_pool[pool].producer_index = free_index;
+	free_index = adapter->rx_buff_pool[pool].producer_index;
+	adapter->rx_buff_pool[pool].producer_index
+		= (adapter->rx_buff_pool[pool].producer_index + 1)
+		% adapter->rx_buff_pool[pool].size;
 	adapter->rx_buff_pool[pool].free_map[free_index] = index;
 
 	mb();


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
