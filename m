Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291163AbSAaRVp>; Thu, 31 Jan 2002 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291164AbSAaRV3>; Thu, 31 Jan 2002 12:21:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15650 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291169AbSAaRVG>; Thu, 31 Jan 2002 12:21:06 -0500
Date: Thu, 31 Jan 2002 18:21:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131182150.F1309@athlon.random>
In-Reply-To: <20020131033345.X1309@athlon.random> <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com> <20020131153607.C1309@athlon.random> <20020131163934.GA834@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020131163934.GA834@holomorphy.com>; from wli@holomorphy.com on Thu, Jan 31, 2002 at 08:39:34AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
> On Thu, 31 Jan 2002, Andrea Arcangeli wrote:
> >>> So I wouldn't merge it, at least until some math is done for the memory
> >>> consumation with 500k inodes with only 1 page in them each, and on the
> >>> number of heights/levels that must be walked during the tree lookup,
> >>> during a access at offset 10G (or worst case in general [biggest
> >>> height]) of an inode with 10G just allocated in pagecache.
> 
> Did someone say math? Looks like I popped in just in time.
> 
> The radix tree forest worst case space usage for fixed-precision search
> keys is where each leaf node of a radix tree is occupied by a unique page,
> and furthermore, each radix tree contains a single page (otherwise the
> shared root conserves a small amount of space).
> 
> key precision = D^B = wordsize (e.g. 2^32 or 2^64)
> D = depth
> B = branch factor
> 
> Each leaf node lies within a chain of D nodes, where all but the root
> nodes are of size B words. This is (D-1)*B + 1 words per file, hence
> per-page. Variable branch factors don't complicate this significantly:
> 1 + \sum_{0 \leq k \leq D} B_k words per page.
> 
> For a branch factor of 128 on i386, this ends up as 1 + 7 + 7 + 6 = 21
> words per file. So for 500K inodes each with one page, 42MB (Douglas
> Adams fan?). Offsets of 10GB don't work here. Sounds like either an
> interesting patch or a 64-bit machine if they work for you. =)

What do you mean with offsets of 10GB not working? In any recent
distribution supporting LFS the file size limit is only a constraint of
the filesystem on disk format. You don't need a 64bit arch for that.
(and anyways any change to the pagecahce must work fine for 64bit archs
too)

> On Thu, Jan 31, 2002 at 11:58:10AM -0200, Rik van Riel wrote:
> >> Ummm, I don't see how this worst case is any more realistic
> >> as the worst case for the hash table (where all pages live
> >> in very few hash buckets and we have really deep chains).
> 
> I don't believe it's particularly realistic either. And sorry about the
> inaccurate estimates from before. =)
> 
> On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> > Mathematically the hashtable complexity is O(N). But probabilistically
> > with the tuning we do on the hashtable size, the collisions will be
> > nearly zero for most buckets for of most workloads. Despite the worst
> > case is with all the pagecache and swapcache queued in a single linked
> > list :).
> 
> To avoid its worst case (or just poor distribution across the buckets),
> a good hash function is necessary. And I don't believe the measurements
> are in favor of the one currently in use. Also, the pointer links for

the randomization provided by the inode is quite powerful (and it makes
not possible to guess the hash bucket in use from userspace without
privilegies), and the current one make sure to optimize the cacheline
usage during consecutive reads. 

> separate chaining within the objects costs extremely-precious boot-time
> allocated memory and that memory is taken away from the system for all
> time, where the dynamic allocation at least allows for the possibility
> of recovering memory when needed.
> 
> On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> > So in short math is wrong about O(N) being bad, hashtable is infact the
> > only way we can get an effective O(1) by just paying RAM. We pay with
> > RAM and we get performance back to us.
> > but with the radix tree (please correct me if I'm wrong) the height will
> > increase eventually, no matter what (so it won't be an effective O(1)
> > like the hashtable provides in real life, not the worst case, the common
> > case). With the hashtable the height won't increase instead.
> 
> The key is of a fixed precision, hence the tree is of a fixed depth.
> The radix tree is O(1).

what does it mean the tree is of a fixed depth? If the depth is fixed
and you claim the lookup complexity O(1) how can you support terabytes
of pagecache queued into the tree without wasting quite a lot of ram per
inode in the worst case (the worst case is with only a few pages into
each radix tree, just to make sure all the depth gets allocated)? Forget
totally about x86, some box runs linux with 256G of ram (I guess
terabyte is next).

Also the complexity arguments are all about the worst case, O(1) as said
in the earlier email may very well be much slower than O(N) when you get
to numbers. hashtable will provide a common case where there is no
collision in the bucket, and then the lookup only consiste of a pointer
check.

If your radix tree O(1) fixed depth is 10000, you will always have to
walk 10000 pointers before you can finish the lookup and it will be
definitely much slower than O(N).

So keep in mind the math complexity arguments can be very misleading in
real life.

> On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> > In short to get the same performance with the radix tree, you'd need to
> > waste an huge amount of ram per inode, the hashtable is instead global
> > so we pay only once for all the pages in the system. At least this is my
> > understanding, I'm not a radix tree guru though, so I may be missing
> > something.
> 
> Lock and cache contention introduced by intermixing data from unrelated
> objects. We've all seen radix trees before: most page tables are radix

of course with a per-inode data structure the locking issue while
accessing different inodes goes away but I think nominal performance of
the data structure is more important than scalability issue (also
contention would remain in workloads where all tasks access the same
inode like database). The cacheline part has to be taken into account but
the hashfn is just optimized for that one.

> trees.
> 
> On Thu, Jan 31, 2002 at 11:58:10AM -0200, Rik van Riel wrote:
> >> People just don't go around caching a single page each for
> >> all of their 10 GB files and even if they _wanted to_ they
> >> couldn't because of the readahead code.
> >> I suspect that for large files we'll always have around
> >> min_readahead logically contiguous pages cached, if not more.
> 
> I suspect the worst case could only arise after evictions of the
> readahead from the pagecache.
> 
> On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> > readahead really doesn't matter at all. consider all the data just in
> > cache, assume you wrote it and you will never ever need to read it once
> > again because you've 64G of ram and only 20G of disk.
> 
> Good luck booting on a 64GB x86 with excess pointer links in struct page.

x86 doesn't matter. this is common code.

> Boot-time allocations filling the direct-mapped portion of the kernel
> virtual address space -appear- to be a severe problem there, but I've
> not got the RAM to empirically verify this quite yet.
> 
> On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> > I/O on large files can and must run as fast as I/O on small files, at
> > the pagecache level. If the fs doesn't support extents or it's
> > inefficient with large files that's an enterly different problem, and
> > the underlying fs doesn't matter any longer once the data is in cache.
> > pagecache must not slowdown on big files.
> 
> O(1) is O(1). This isn't even average-case or worst case: it's all cases.
> In a radix tree using fixed-precision search keys, such as machine words,
> exactly the same number of internal nodes are traversed to reach a leaf
> for every search key, every time, regardless of how populated or unpopulated
> the radix tree is.

and this mean it will be slower than the hashtable that will reach the
page without walking any "depth" in the common case.

> 
> On Thu, Jan 31, 2002 at 03:36:07PM +0100, Andrea Arcangeli wrote:
> > Otherwise for an unix fs developer usage (the small files ala dbench)
> > the rbtree was much nicer data structure than the hash in first place
> > (and it eats less ram than the radix tree if only one page is queued
> > etc...).
> 
> And the pointer links in struct page? Sounds like more RAM to me...

yes, that would be a few more bytes per page.... unless you allocate the
node structure dynamically like you seems to be doing in the radix tree
patch for the very same reason of not increasing the struct page I guess.

> 4000 open files (much more realistic than 500K) each with one page

open files doesn't matter. what matters are the number of inodes with
cache in them. 500k is definitely realistic, try to run updatedb with
plenty of ram free and then check /proc/sys/fs/inode-nr.

> leads to 48000 words of radix tree overhead. 3 words per page of
> pointer links and > 16000 pages of RAM and the rbtree eats more, not
> less. And 16000 pages is just 64MB on i386.
> 
> 
> Cheers,
> Bill


Andrea
