Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289293AbSA1Rkg>; Mon, 28 Jan 2002 12:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289294AbSA1RkY>; Mon, 28 Jan 2002 12:40:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289293AbSA1RkM>; Mon, 28 Jan 2002 12:40:12 -0500
Date: Mon, 28 Jan 2002 09:39:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>,
        <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <20020128091338.D6578@helen.CS.Berkeley.EDU>
Message-ID: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Josh MacDonald wrote:
>
> So, it would seem that the dcache and kmem_slab_cache memory allocator
> could benefit from a way to shrink the dcache in a less random way.
> Any thoughts?

The way I want to solve this problem generically is to basically get rid
of the special-purpose memory shrinkers, and have everything done with one
unified interface, namely the physical-page-based "writeout()" routine. We
do that for the page cache, and there's nothing that says that we couldn't
do the same for all other caches, including very much the slab allocator.

Thus any slab user that wants to, could just register their own per-page
memory pressure logic. The dcache "reference" bit would go away, to be
replaced by a per-page reference bit (that part could be done already, of
course, and might help a bit on its own).

Basically, the more different "pools" of memory we have, the harder it
gets to balance them. Clearly, the optimal number of pools from a
balancing standpoint is just a single, direct physical pool.

Right now we have several pools - we have the pure physical LRU, we have
the virtual mapping (where scanning is directly tied to the physical LRU,
but where the separate pool still _does_ pose some problems), and we have
separate balancing for inodes, dentries and quota. And there's no question
that it hurts us under memory pressure.

(There's a related question, which is whether other caches might also
benefit from being able to grow more - right now there are some caches
that are of a limited size partly because they have no good way of
shrinking back on demand).

I am, for example, very interested to see if Rik can get the overhead of
the rmap stuff down low enough that it's not a noticeable hit under
non-VM-pressure. I'm looking at the issue of doing COW on the page tables
(which really is a separate issue), because it might make it more
palatable to go with the rmap approach.

			Linus

