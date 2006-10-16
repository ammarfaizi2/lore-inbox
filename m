Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWJPBr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWJPBr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWJPBrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:47:55 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:17123 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751191AbWJPBrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:47:55 -0400
Date: Mon, 16 Oct 2006 11:43:34 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Yao Fei Zhu <walkinair@cn.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Failed to boot kernel 2.6.19-rc2 due to IBM veth problem.
Message-ID: <20061016014334.GA30921@localhost.localdomain>
Mail-Followup-To: Yao Fei Zhu <walkinair@cn.ibm.com>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <4532613D.1090107@cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4532613D.1090107@cn.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 12:26:37AM +0800, Yao Fei Zhu wrote:
> Hi, all,
> 
> Boot kernel 2.6.19-rc2 on IBM System P5 partitions will fall into xmon.
> Here is the boot log,

This is probably the same bug I recently posted about.  The patch
below should fix it.

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
--- working-2.6.orig/drivers/net/ibmveth.c	2006-10-13 14:19:54.000000000 +1000
+++ working-2.6/drivers/net/ibmveth.c	2006-10-13 14:19:59.000000000 +1000
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
