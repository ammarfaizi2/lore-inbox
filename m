Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291205AbSAaRvF>; Thu, 31 Jan 2002 12:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291203AbSAaRuw>; Thu, 31 Jan 2002 12:50:52 -0500
Received: from holomorphy.com ([216.36.33.161]:22658 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291204AbSAaRua>;
	Thu, 31 Jan 2002 12:50:30 -0500
Date: Thu, 31 Jan 2002 09:50:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Momchil Velikov <velco@fadata.bg>,
        John Stoffel <stoffel@casc.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020131175012.GC834@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Momchil Velikov <velco@fadata.bg>, John Stoffel <stoffel@casc.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020131033345.X1309@athlon.random> <Pine.LNX.4.33L.0201311155010.32634-100000@imladris.surriel.com> <20020131153607.C1309@athlon.random> <20020131163934.GA834@holomorphy.com> <20020131182150.F1309@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020131182150.F1309@athlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
>> For a branch factor of 128 on i386, this ends up as 1 + 7 + 7 + 6 = 21
>> words per file. So for 500K inodes each with one page, 42MB (Douglas
>> Adams fan?). Offsets of 10GB don't work here. Sounds like either an
>> interesting patch or a 64-bit machine if they work for you. =)

These numbers are wrong -- see the other reply.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> What do you mean with offsets of 10GB not working? In any recent
> distribution supporting LFS the file size limit is only a constraint of
> the filesystem on disk format. You don't need a 64bit arch for that.
> (and anyways any change to the pagecahce must work fine for 64bit archs
> too)

I stand corrected on that. It appears the extra bits are used for large
files. The depth of the tree as represented in the calculation may need
to go up and so the worst case space usage is even larger than the
2.2-ish 32-bit - PAGE_SHIFT calculation.

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
>> To avoid its worst case (or just poor distribution across the buckets),
>> a good hash function is necessary. And I don't believe the measurements
>> are in favor of the one currently in use. Also, the pointer links for

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> the randomization provided by the inode is quite powerful (and it makes
> not possible to guess the hash bucket in use from userspace without
> privilegies), and the current one make sure to optimize the cacheline
> usage during consecutive reads. 

chi^2 is nowhere near passing a confidence test for uniformity on the
pagecache and on various machines extremely poor bucket distribution
has been observed (i.e. visibly poor from histograms).

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
>> The key is of a fixed precision, hence the tree is of a fixed depth.
>> The radix tree is O(1).

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> what does it mean the tree is of a fixed depth? If the depth is fixed
> and you claim the lookup complexity O(1) how can you support terabytes
> of pagecache queued into the tree without wasting quite a lot of ram per
> inode in the worst case (the worst case is with only a few pages into
> each radix tree, just to make sure all the depth gets allocated)? Forget
> totally about x86, some box runs linux with 256G of ram (I guess
> terabyte is next).

The number of levels in the tree is proportional to the number of bits in
the machine word, which is a constant. A double-precision machine word
is of constant size as well. Radix trees can be used on strings, which
is where they would not be of fixed depth.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> Also the complexity arguments are all about the worst case, O(1) as said
> in the earlier email may very well be much slower than O(N) when you get
> to numbers. hashtable will provide a common case where there is no
> collision in the bucket, and then the lookup only consiste of a pointer
> check.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> If your radix tree O(1) fixed depth is 10000, you will always have to
> walk 10000 pointers before you can finish the lookup and it will be
> definitely much slower than O(N).
> So keep in mind the math complexity arguments can be very misleading in
> real life.

I know how to use them. Unfortunately, I am not a lightning calculator,
as seen in the preceding post.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> of course with a per-inode data structure the locking issue while
> accessing different inodes goes away but I think nominal performance of
> the data structure is more important than scalability issue (also
> contention would remain in workloads where all tasks access the same
> inode like database). The cacheline part has to be taken into account but
> the hashfn is just optimized for that one.

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
>> Good luck booting on a 64GB x86 with excess pointer links in struct page.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> x86 doesn't matter. this is common code.

I wish.

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
>> O(1) is O(1). This isn't even average-case or worst case: it's all cases.
>> In a radix tree using fixed-precision search keys, such as machine words,
>> exactly the same number of internal nodes are traversed to reach a leaf
>> for every search key, every time, regardless of how populated or unpopulated
>> the radix tree is.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> and this mean it will be slower than the hashtable that will reach the
> page without walking any "depth" in the common case.

Not so; the hash table will walk some number of pointer links which can
be estimated from the load on the table, and this is likely to be
approximately the same as the radix tree from hash table statistics I've
seen.

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> yes, that would be a few more bytes per page.... unless you allocate the
> node structure dynamically like you seems to be doing in the radix tree
> patch for the very same reason of not increasing the struct page I guess.

Well, maybe not given the revised numbers. =)

On Thu, Jan 31, 2002 at 08:39:34AM -0800, William Lee Irwin III wrote:
>> 4000 open files (much more realistic than 500K) each with one page

On Thu, Jan 31, 2002 at 06:21:50PM +0100, Andrea Arcangeli wrote:
> open files doesn't matter. what matters are the number of inodes with
> cache in them. 500k is definitely realistic, try to run updatedb with
> plenty of ram free and then check /proc/sys/fs/inode-nr.

I misspoke -- I used an estimate of the number of address_spaces in use
on busy systems I heard elsewhere and quadrupled it (and then said "open
files"). Since it's inodes, 4K is still a bad estimate.


Cheers,
Bill
