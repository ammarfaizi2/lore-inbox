Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbVKWWa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbVKWWa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVKWWaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:30:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:39587 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030425AbVKWWaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:30:20 -0500
Date: Wed, 23 Nov 2005 23:30:08 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
Message-ID: <20051123223007.GA5921@wotan.suse.de>
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384E7F2.2030508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384E7F2.2030508@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 05:06:42PM -0500, Jeff Garzik wrote:
> IOAT is super-neat stuff.

The main problem I see is that it'll likely only pay off when you can keep 
the queue of copies long (to amortize the cost of 
talking to an external chip). At least for the standard recvmsg 
skb->user space, user space-> skb cases these queues are 
likely short in most cases. That's because most applications
do relatively small recvmsg or sendmsgs. 

It definitely will need a threshold under which it is disabled.
With bad luck the threshold will be high enough that it doesn't
help very often :/

Longer term the right way to handle this would be likely to use
POSIX AIO on sockets. With that interface it would be easier
to keep long queues of data in flight, which would be best for
the DMA engine.

> In addition to helping speed up network RX, I would like to see how 
> possible it is to experiment with IOAT uses outside of networking. 
> Sample ideas:  VM page pre-zeroing.  ATA PIO data xfers (async copy to 
> static buffer, to dramatically shorten length of kmap+irqsave time). 
> Extremely large memcpy() calls.

Another proposal was swiotlb.

But it's not clear it's a good idea: a lot of these applications prefer to 
have the target in cache. And IOAT will force it out of cache.

> Additionally, current IOAT is memory->memory.  I would love to be able 
> to convince Intel to add transforms and checksums, to enable offload of 
> memory->transform->memory and memory->checksum->result operations like 
> sha-{1,256} hashing[1], crc32*, aes crypto, and other highly common 
> operations.  All of that could be made async.

I remember the registers in the Amiga Blitter for this and I'm
still scared... Maybe it's better to keep it simple.

-Andi

