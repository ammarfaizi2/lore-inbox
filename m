Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129795AbRBYCie>; Sat, 24 Feb 2001 21:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129794AbRBYCiY>; Sat, 24 Feb 2001 21:38:24 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:44551 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S129782AbRBYCiQ>;
	Sat, 24 Feb 2001 21:38:16 -0500
Date: Sat, 24 Feb 2001 18:38:12 -0800 (PST)
From: Noah Romer <klevin@eskimo.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
Message-ID: <Pine.SUN.3.96.1010224182145.11813A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2001, Jeff Garzik wrote:

> Disclaimer:  This is 2.5, repeat, 2.5 material.
[snip] 
> 1) Rx Skb recycling.  It would be nice to have skbs returned to the
> driver after the net core is done with them, rather than have netif_rx
> free the skb.  Many drivers pre-allocate a number of maximum-sized skbs
> into which the net card DMA's data.  If netif_rx returned the SKB
> instead of freeing it, the driver could simply flip the DescriptorOwned
> bit for that buffer, giving it immediately back to the net card.
> 
> Advantages:  A de-allocation immediately followed by a reallocation is
> eliminated, less L1 cache pollution during interrupt handling. 
> Potentially less DMA traffic between card and host.

This could be quite useful for the network driver I maintain (it's made
it to the -ac patch set for 2.4, but not yet into the main kernel
tarball). At the momement, it allocates 127 "buckets" (skb's under linux)
at start of day and posts them to the card. After that, it maintains a
minimum of 80 data buffers available to the card at any one time. There's
a noticable performance hit when the driver has to reallocate new skbs
to keep above the threshold. I try to recycle as much as possible w/in the
driver (i.e. really small incoming packets get a new skb allocated for
them and the original buffer is put back on the queue), but it would be
nice to be able to recycle even more of the skbs.

> Disadvantages?

As has been pointed out, there's a certain loss of control over allocation
of memory (could check for low memory conditions before sending the skb
back to the driver, but . . .). I do see a failure to allocate all 127
skbs, occasionally, when the driver is first loaded (only way to get
around this is to reboot the system).

> 2) Tx packet grouping.  If the net core has knowledge that more packets
> will be following the current one being sent to dev->hard_start_xmit(),
> it should pass that knowledge on to dev->hard_start_xmit(), either as an
> estimated number yet-to-be-sent, or just as a flag that "more is
> coming."
> 
> Advantages: This lets the net driver make smarter decisions about Tx
> interrupt mitigation, Tx buffer queueing, etc.
>
> Disadvantages?  Can this sort of knowledge be obtained by a netdevice
> right now, without any kernel modifications?

In my experience, Tx interrupt mitigation is of little benefit. I actually
saw a performance increase of ~20% when I turned off Tx interrupt
mitigation in my driver (could have been poor implementation on my part).

--
Noah Romer              |"Calm down, it's only ones and zeros." - this message
klevin@eskimo.com       |brought to you by The Network
PGP key available       |"Time will have its say, it always does." - Celltrex
by finger or email      |from Flying to Valhalla by Charles Pellegrino

