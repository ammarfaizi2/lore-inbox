Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291143AbSAaQkr>; Thu, 31 Jan 2002 11:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291145AbSAaQkj>; Thu, 31 Jan 2002 11:40:39 -0500
Received: from holomorphy.com ([216.36.33.161]:898 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291143AbSAaQk3>;
	Thu, 31 Jan 2002 11:40:29 -0500
Date: Thu, 31 Jan 2002 08:39:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131163934.GA834@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020131033345.X1309@athlon.random> <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com> <20020131153607.C1309@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020131153607.C1309@athlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
>>> So I wouldn't merge it, at least until some math is done for the memory
>>> consumation with 500k inodes with only 1 page in them each, and on the
>>> number of heights/levels that must be walked during the tree lookup,
>>> during a access at offset 10G (or worst case in general [biggest
>>> height]) of an inode with 10G just allocated in pagecache.

Did someone say math? Looks like I popped in just in time.

The radix tree forest worst case space usage for fixed-precision search
keys is where each leaf node of a radix tree is occupied by a unique page,
and furthermore, each radix tree contains a single page (otherwise the
shared root conserves a small amount of space).

key precision = D^B = wordsize (e.g. 2^32 or 2^64)
D = depth
B = branch factor

Each leaf node lies within a chain of D nodes, where all but the root
nodes are of size B words. This is (D-1)*B + 1 words per file, hence
per-page. Variable branch factors don't complicate this significantly:
1 + \sum_{0 \leq k \leq D} B_k words per page.

For a branch factor of 128 on i386, this ends up as 1 + 7 + 7 + 6 = 21
words per file. So for 500K inodes each with one page, 42MB (Douglas
Adams fan?). Offsets of 10GB don't work here. Sounds like either an
interesting patch or a 64-bit machine if they work for you. =)

On Thu, Jan 31, 2002 at 11:58:10AM -0200, Rik van Riel wrote:
>> Ummm, I don't see how this worst case is any more realistic
>> as the worst case for the hash table (where all pages live
>> in very few hash buckets and we have really deep chains).

I don't believe it's particularly realistic either. And sorry about the
inaccurate estimates from before. =)

On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> Mathematically the hashtable complexity is O(N). But probabilistically
> with the tuning we do on the hashtable size, the collisions will be
> nearly zero for most buckets for of most workloads. Despite the worst
> case is with all the pagecache and swapcache queued in a single linked
> list :).

To avoid its worst case (or just poor distribution across the buckets),
a good hash function is necessary. And I don't believe the measurements
are in favor of the one currently in use. Also, the pointer links for
separate chaining within the objects costs extremely-precious boot-time
allocated memory and that memory is taken away from the system for all
time, where the dynamic allocation at least allows for the possibility
of recovering memory when needed.

On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> So in short math is wrong about O(N) being bad, hashtable is infact the
> only way we can get an effective O(1) by just paying RAM. We pay with
> RAM and we get performance back to us.
> but with the radix tree (please correct me if I'm wrong) the height will
> increase eventually, no matter what (so it won't be an effective O(1)
> like the hashtable provides in real life, not the worst case, the common
> case). With the hashtable the height won't increase instead.

The key is of a fixed precision, hence the tree is of a fixed depth.
The radix tree is O(1).

On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> In short to get the same performance with the radix tree, you'd need to
> waste an huge amount of ram per inode, the hashtable is instead global
> so we pay only once for all the pages in the system. At least this is my
> understanding, I'm not a radix tree guru though, so I may be missing
> something.

Lock and cache contention introduced by intermixing data from unrelated
objects. We've all seen radix trees before: most page tables are radix
trees.

On Thu, Jan 31, 2002 at 11:58:10AM -0200, Rik van Riel wrote:
>> People just don't go around caching a single page each for
>> all of their 10 GB files and even if they _wanted to_ they
>> couldn't because of the readahead code.
>> I suspect that for large files we'll always have around
>> min_readahead logically contiguous pages cached, if not more.

I suspect the worst case could only arise after evictions of the
readahead from the pagecache.

On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> readahead really doesn't matter at all. consider all the data just in
> cache, assume you wrote it and you will never ever need to read it once
> again because you've 64G of ram and only 20G of disk.

Good luck booting on a 64GB x86 with excess pointer links in struct page.
Boot-time allocations filling the direct-mapped portion of the kernel
virtual address space -appear- to be a severe problem there, but I've
not got the RAM to empirically verify this quite yet.

On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> I/O on large files can and must run as fast as I/O on small files, at
> the pagecache level. If the fs doesn't support extents or it's
> inefficient with large files that's an enterly different problem, and
> the underlying fs doesn't matter any longer once the data is in cache.
> pagecache must not slowdown on big files.

O(1) is O(1). This isn't even average-case or worst case: it's all cases.
In a radix tree using fixed-precision search keys, such as machine words,
exactly the same number of internal nodes are traversed to reach a leaf
for every search key, every time, regardless of how populated or unpopulated
the radix tree is.

On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> Otherwise for an unix fs developer usage (the small files ala dbench)
> the rbtree was much nicer data structure than the hash in first place
> (and it eats less ram than the radix tree if only one page is queued
> etc...).

And the pointer links in struct page? Sounds like more RAM to me...
4000 open files (much more realistic than 500K) each with one page
leads to 48000 words of radix tree overhead. 3 words per page of
pointer links and > 16000 pages of RAM and the rbtree eats more, not
less. And 16000 pages is just 64MB on i386.


Cheers,
Bill
