Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290834AbSAaCcz>; Wed, 30 Jan 2002 21:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290837AbSAaCcp>; Wed, 30 Jan 2002 21:32:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43114 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290834AbSAaCcf>; Wed, 30 Jan 2002 21:32:35 -0500
Date: Thu, 31 Jan 2002 03:33:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Momchil Velikov <velco@fadata.bg>
Cc: John Stoffel <stoffel@casc.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131033345.X1309@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com> <87d6zrlefa.fsf@fadata.bg> <15448.28224.481925.430169@gargle.gargle.HOWL> <87wuxzjxjm.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <87wuxzjxjm.fsf@fadata.bg>; from velco@fadata.bg on Thu, Jan 31, 2002 at 12:15:09AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:15:09AM +0200, Momchil Velikov wrote:
> >>>>> "John" == John Stoffel <stoffel@casc.com> writes:
> 
> Momchil> Memory overhead due to allocator overhead is of no concern with the
> Momchil> slab allocator. What matters most is probably the overhead of the
> Momchil> radix tree nodes themselves, compared to the two pointers in struct
> Momchil> page with the hash table approach. rat-4 variant ought to have less
> Momchil> overhead compared to rat-7 at the expense of deeper/higher tree. I
> Momchil> have no figures for the actual memory usage though. For small files it
> Momchil> should be negligible, i.e. one radix tree node, 68 or 516 bytes for
> Momchil> rat-4 or rat-7, for a file of size up to 65536 or 524288 bytes.  The
> Momchil> worst case would be very large file with a few cached pages with
> Momchil> offsets uniformly distributed across the whole file, that is having
> Momchil> deep tree with only one page hanging off each leaf node.
> 
> John> Isn't this a good place to use AVL trees then, since they balance
> John> automatically?  Admittedly, it may be more overhead than we want in
> John> the case where the tree is balanced by default anyway.  

rbtree are not too overhead for the rebalance, but the problem of not
using the hashtable is that you can't just pay with ram globally. Of
course you can enlarge the array for each radix node (that will end to
be a waste with an huge number of inodes with only a page in them), but
as the height of the tree increases performance will go down anyways (it
will never be as large as the global hashtable that we can tune
optimally at boot). With the hashtable the ram we pay for is not per inode,
but it's global.

I'm not optimistic it will work (even if it can be better than an rb or
an avl during the lookups because it pays more ram per tree node [and
per-inode], but still nearly not enoguh ram per node with big files to
be fast, and a big waste of ram with lots of inodes with a only 1 page
in them)

So I wouldn't merge it, at least until some math is done for the memory
consumation with 500k inodes with only 1 page in them each, and on the
number of heights/levels that must be walked during the tree lookup,
during a access at offset 10G (or worst case in general [biggest
height]) of an inode with 10G just allocated in pagecache.

> 
> The widespread opinion is that binary trees are generally way too deep
> compared to radix trees, so searches have larger cache footprint.
> 
> John> Again, benchmarks would be the good thing to see either way.
> 
> I've posted some with 2.4.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
