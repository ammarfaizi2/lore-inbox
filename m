Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129701AbRBXXZi>; Sat, 24 Feb 2001 18:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129702AbRBXXZ2>; Sat, 24 Feb 2001 18:25:28 -0500
Received: from mail3.atl.bellsouth.net ([205.152.0.38]:60391 "EHLO
	mail3.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129701AbRBXXZS>; Sat, 24 Feb 2001 18:25:18 -0500
Message-ID: <3A9842DC.B42ECD7A@mandrakesoft.com>
Date: Sat, 24 Feb 2001 18:25:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New net features for added performance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disclaimer:  This is 2.5, repeat, 2.5 material.



I've talked about the following items with a couple people on this list
in private.  I wanted to bring these up again, to see if anyone has
comments on the following suggested netdevice changes for the upcoming
2.5 development series of kernels.


1) Rx Skb recycling.  It would be nice to have skbs returned to the
driver after the net core is done with them, rather than have netif_rx
free the skb.  Many drivers pre-allocate a number of maximum-sized skbs
into which the net card DMA's data.  If netif_rx returned the SKB
instead of freeing it, the driver could simply flip the DescriptorOwned
bit for that buffer, giving it immediately back to the net card.

Advantages:  A de-allocation immediately followed by a reallocation is
eliminated, less L1 cache pollution during interrupt handling. 
Potentially less DMA traffic between card and host.

Disadvantages?



2) Tx packet grouping.  If the net core has knowledge that more packets
will be following the current one being sent to dev->hard_start_xmit(),
it should pass that knowledge on to dev->hard_start_xmit(), either as an
estimated number yet-to-be-sent, or just as a flag that "more is
coming."

Advantages: This lets the net driver make smarter decisions about Tx
interrupt mitigation, Tx buffer queueing, etc.

Disadvantages?  Can this sort of knowledge be obtained by a netdevice
right now, without any kernel modifications?



3) Slabbier packet allocation.  Even though skb allocation is decently
fast, you are still looking at an skb buffer head grab and a kmalloc,
for each [dev_]alloc_skb call.  I was wondering if it would be possible
to create a helper function for drivers which would improve the hot-path
considerably:

	static struct skbuff *ether_alloc_skb (int size)
	{
		if (size >= preallocated_skb_list->skb->size) {
			dequeue_skb_from_list()
			if (preallocate_size < low_water_limit)
				schedule_tasklet(refill_skb_list);
			return skb;
		}
		return dev_alloc_skb(size);
	}

The skbs from this list would be allocated by a tasklet in the
background to the maximum size requested by the ethernet driver.  If you
wanted to waste even more memory, you could allocate from per-CPU
lists..

Disadvantages?  Doing this might increase cache pollution due to
increased code and data size, but I think the hot path is much improved
(dequeue a properly sized, initialized, skb-reserved'd skb off a list)
and would help mitigate the impact of sudden bursts of traffic.



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
