Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281935AbRKZR1V>; Mon, 26 Nov 2001 12:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281934AbRKZR1L>; Mon, 26 Nov 2001 12:27:11 -0500
Received: from [217.9.226.246] ([217.9.226.246]:5760 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S281935AbRKZR04>; Mon, 26 Nov 2001 12:26:56 -0500
To: <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
Date: 26 Nov 2001 19:23:52 +0200
Message-ID: <87vgfxqwd3.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> On 26 Nov 2001, Momchil Velikov wrote:

>> Hi,
>> 
>> This patch:
>> 
>> - replaces the global page cache hash table with a per mapping
>> splay tree;
>> 
>> - eliminates the ``pagecache_lock'', instead ``i_shared_lock''
>> is used so serialize access during insertion/deletion
>> into/from the tree;
>> 
>> The goals of the patch are to:
>> 
>> - to improve scalability (via the elimination of the global
>> lock);
>> 
>> - reduce the memory/cache footprint (via to the
>> ``page_hash_table'' elimination);
>> 
>> The patch is against 2.4.16-pre1. Comments are welcome.

Ingo> are you aware of the following patch? (written by David Miller and me.)

Ingo>   http://people.redhat.com/mingo/smp-pagecache-patches/pagecache-2.4.10-A3

Yep.  Folks on #kernelnewbies told me about it, when there were only
changes to ``shrink_cache'' left.  So, I decided to funish mine ;)

Ingo> it gets rid of the pagecache lock without introducing a tree.

Ingo> while reducing memory footprint is a goal we want to achieve, the
Ingo> pagecache hash is such a critical piece of data structure that we want
Ingo> O(1)-type search properties, not a tree. The pagetable hash takes up 0.2%
Ingo> of RAM currently. (but we could cut the size of the hash in half i think,
Ingo> it's a bit over-sized currently - it has as many entries.)

That's why I use splay tree and not red-black or AVL-balanced one - to
exploit the locality of reference, expecting to have O(1) on average.
Of course, I decided on tree because it is hard to choose the right
hash size.

Ingo> The problem with the tree is that if we have a big, eg. 16 GB pagecache,
Ingo> then even assuming a perfectly balanced tree, it takes more than 20
Ingo> iterations to find the page in the tree.  (which also means 20 cachelines
Ingo> touched per tree node we pass.) Such an overhead (both algorithmic and
Ingo> cache-footprint overhead) is absolutely out of question - and it will only
Ingo> get worse with more RAM, which isnt a good property.

The tree is per mapping, not a single one.  Now, with 16GB cached in a
single mapping, it'd perform poorly, indeed (though probably not 20).

Ingo> hashes on the other hand are simple and fast, and we can always balance
Ingo> performance against cache footprint and hash-table memory usage. This is
Ingo> one reason why we keept the pagetable hash in our patch.

Ingo> 	Ingo
