Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289337AbSA1T0D>; Mon, 28 Jan 2002 14:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSA1TZy>; Mon, 28 Jan 2002 14:25:54 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:13063 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289337AbSA1TZp>; Mon, 28 Jan 2002 14:25:45 -0500
Message-ID: <3C55A58F.1070908@namesys.com>
Date: Mon, 28 Jan 2002 22:25:03 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I understand you right, your scheme has the fundamental flaw that one 
dcache entry on a page can keep an entire page full of "slackers" in 
memory, and since there is little correlation in usage between dcache 
entries that happen to get stored on a page, the result is that the 
effectiveness per megabyte of the dcache is decreased by an order of 
magnitude.  It would be worse to have one dcache entry per page, but 
maybe not by as much as you might expect.

When objects smaller than a page are stored on a page but not correlated 
in their usage, they need to be aged individually not as a page, and 
then garbage collected as needed.  Neither the current model nor your 
proposed scheme solve the fundamental problem Josh's measurements prove 
exists.  

We need subcache plugins with a subcache size proportional centralized 
memory pressure distributor, not a unified cache.

Josh went to bed, but I'll encourage him to say more about this in the 
morning Moscow time.

Hans


Linus Torvalds wrote:

>On Mon, 28 Jan 2002, Josh MacDonald wrote:
>
>>So, it would seem that the dcache and kmem_slab_cache memory allocator
>>could benefit from a way to shrink the dcache in a less random way.
>>Any thoughts?
>>
>
>The way I want to solve this problem generically is to basically get rid
>of the special-purpose memory shrinkers, and have everything done with one
>unified interface, namely the physical-page-based "writeout()" routine. We
>do that for the page cache, and there's nothing that says that we couldn't
>do the same for all other caches, including very much the slab allocator.
>
>Thus any slab user that wants to, could just register their own per-page
>memory pressure logic. The dcache "reference" bit would go away, to be
>replaced by a per-page reference bit (that part could be done already, of
>course, and might help a bit on its own).
>
>Basically, the more different "pools" of memory we have, the harder it
>gets to balance them. Clearly, the optimal number of pools from a
>balancing standpoint is just a single, direct physical pool.
>
>Right now we have several pools - we have the pure physical LRU, we have
>the virtual mapping (where scanning is directly tied to the physical LRU,
>but where the separate pool still _does_ pose some problems), and we have
>separate balancing for inodes, dentries and quota. And there's no question
>that it hurts us under memory pressure.
>
>(There's a related question, which is whether other caches might also
>benefit from being able to grow more - right now there are some caches
>that are of a limited size partly because they have no good way of
>shrinking back on demand).
>
>I am, for example, very interested to see if Rik can get the overhead of
>the rmap stuff down low enough that it's not a noticeable hit under
>non-VM-pressure. I'm looking at the issue of doing COW on the page tables
>(which really is a separate issue), because it might make it more
>palatable to go with the rmap approach.
>
>			Linus
>
>
>



