Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWHNM00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWHNM00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWHNM00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:26:26 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:9956 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752020AbWHNM0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:26:25 -0400
Subject: Re: [PATCH 1/1] network memory allocator.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060814110359.GA27704@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 14:25:13 +0200
Message-Id: <1155558313.5696.167.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 15:04 +0400, Evgeniy Polyakov wrote:

> Defragmentation is a part of freeing algorithm and initial fragmentation
> avoidance is being done at allocation time by removing power-of-two
> allocations. Rate of fragmentation can be found in some userspace
> modlling tests being done for both power-of-two SLAB-like and NTA
> allocators. (more details on project's homepage [4]).

Only with a perfect allocation pattern. And then still only internal
fragmentation; your allocator is still vulnerable to external
fragmentation - you cannot move allocated chunks around because there
are pointers into it, hence you will suffer from external fragmentation.

http://en.wikipedia.org/wiki/Fragmentation_%28computer%29

> Benchmarks with trivial epoll based web server showed noticeble (more
> than 40%) imrovements of the request rates (1600-1800 requests per
> second vs. more than 2300 ones). It can be described by more
> cache-friendly freeing algorithm, by tighter objects packing and thus
> reduced cache line ping-pongs, reduced lookups into higher-layer caches
> and so on.

Nice :-)

> Design of allocator allows to map all node's pages into userspace thus
> allows to have true zero-copy support for both sending and receiving
> dataflows.

I'm still not clear on how you want to do this, only the trivial case of
a sniffer was mentioned by you. To be able to do true zero-copy receive
each packet will have to have its own page(s). Simply because you do not
know the destination before you receive it, the packet could end up
going to a whole different socket that the prev/next. As soon as you
start packing multiple packets on 1 page, you've lost the zero-copy
receive game.

> As described in recent threads [3] it is also possible to eliminate any 
> kind of main system OOM influence on network dataflow processing, thus 
> it is possible to prevent deadlock for systems, which use network as 
> memory storage (swap over network, iSCSI, NBD and so on).

How? You have never stated how you will avoid getting all packets stuck
in blocked sockets.


On another note, I think you misunderstand our SLAB allocator; we do not
round up to nearest order page alloc per object; SLAB is build to avoid
that and is designed to pack equal size objects into pages. The kmalloc
allocator is build on top of several SLAB allocators; each with its
specific size objects to serve.

For example, the 64 byte SLAB will serve 64 byte objects, and packs
about PAGE_SIZE/64 per page (about since there is some overhead).

So the actual internal fragmentation of the current kmalloc/SLAB
allocator is not as bad as you paint it. The biggest problem we have
with the SLAB thing is getting pages back from it. (And the horrific
complexity of the current implementation)

