Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282495AbRKZUnC>; Mon, 26 Nov 2001 15:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282500AbRKZUmD>; Mon, 26 Nov 2001 15:42:03 -0500
Received: from dsl-213-023-039-076.arcor-ip.net ([213.23.39.76]:14606 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282495AbRKZUk5>;
	Mon, 26 Nov 2001 15:40:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Benjamin LaHaise <bcrl@redhat.com>, Momchil Velikov <velco@fadata.bg>
Subject: Re: [PATCH] Scalable page cache
Date: Mon, 26 Nov 2001 21:43:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain> <87vgfxqwd3.fsf@fadata.bg> <20011126131641.A13955@redhat.com>
In-Reply-To: <20011126131641.A13955@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E168Sb8-0000Ao-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 26, 2001 07:16 pm, Benjamin LaHaise wrote:

> First off, if we take a look at why the page cache lock is being contended 
> a few obvious problems pop out immediately:
> 
> 	1. potentially long hash chains are walked with the page cache
> 	   lock held for the entire duration of the operation

Yes, having a not-very-random hash function makes this worse.  What we see 
is: the attempt to improve locality by having the hash function preserve 
certain input bits can easily produce a net loss by causing a big variance in 
hash chain length, increasing the average length of the list walk.  At some 
point I'll go check this theory for the pache cache (in fact I think it's 
already been checked, and a paper written about it).

> 	2. multiple cache lines are touched while holding the page cache 
> 	   lock
> 	3. sequential lookups involve reaquiring the page cache lock
> 	4. the page cache hash is too large, virtually assuring that 
> 	   lookups will cause a cache miss

A more random hash improves (4) too, by allowing a smaller table.

Though somebody may well come up with a better structure than a hash table 
for the page cache, I'm pretty sure we can make the existing approach work a 
little better.

We could divide up the locking using pcache_locks [page_hash >> some_shift].

--
Daniel
