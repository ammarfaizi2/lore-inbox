Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWEDA2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWEDA2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 20:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWEDA2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 20:28:43 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:2495 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750778AbWEDA2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 20:28:42 -0400
Message-ID: <44594AA9.8020906@tlinx.org>
Date: Wed, 03 May 2006 17:28:25 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > Now, regardless of the other issues people have brought up, I'd like to
 > say that I think this is broken.
 >
 > Doing prefetching on a physical block basis is simply not a valid
 > approach, for several reasons:
 >
 >  - it misses several important cases (you can surely prefetch over NFS
 >    too)
---

    I don't think fetching over a network is a case that needs
to be "optimized".  I don't think any there would be sufficient gain
in "pre-fetching" over a network (even if it was one long network read)
to outweigh network latencies.  I would strongly suggest this be
ignored.

 >  - it gives you only a very limited view into what is actually going on.
---

    ???  In what way?  I don't think we need a *complex* view of what
is going on.  If anything, complexity can be a performance drag (though
in some cases, an excellent algorithm can outweigh the extra computational
complexitiy.

 >  - it doesn't much allow you to _fix_ any problems, it just allows 
you to
 >    try to paper them over.
----

    It isn't designed to be the one "true" fix for every problem known.
It's meant to provide speedups for a common subset of io-requests.

    If one comes up with the one-uber algorithm in three years, then
replace this one, meanwhile...

 >  - it's useless anyway, since pretty all kernel caching is based on
 >    virtual caches, so if you "pre-read" the physical buffers, it won't
 >    help: you'll just waste time reading the data into a buffer that will
 >    never be used, and when the real request comes in, the read will
 >    be done _again_.
----

    This is the big drawback/problem.  But this leads me to an obvious
question.  If I read a file into memory, it is cached, _seemingly_,
relative to the filename.  If I read the the same physical block into
memory using _block_-i/o, relative to the device, the claim is that
two separate reads are done into the block cache?  Can't this result
in inconsistent results between the two copies?  If I change the
file relative block, how is this coordinated with the device-relative
block?  Surely there is some block coelescing done at some point to
ensure the two different views of the block are consistent?

    If not, I'd tend to view this as a "bug". 

    But presuming this is "dealt with" at some layer, can't the
same information used to merge the two blocks be used to identify that
the same block is already in memory?

    If file-blockno, addresses can't be converted to device-blockno's,
how can the blocks be written to disk?

    If the file-blockno's are convertable, can't this be used to
compare which physical blocks are already in the cache?  Certainly this
would be faster than the milliseconds it could take to do another
physial read, no?

   
 >     (a) it makes it a hell of a lot more readable, and the user gets a
 >     lot more information that may make him see the higher-level issues
 >     involved.
---

    I'm not sure this is a benefit that outweight the elimination of
having to go through the file system (following directory chains,
indirect blocks, extents, etc).

 >     (b) it's in the form that we cache things, so if you read-ahead in
 >     that form, you'll actually get real information.
----

    This may not be a great reason.  Using the fact that "this is the
way things are already done", may not allow optimal implementation of
faster algorithms.
   
 >     (c) it's in a form where you can actually _do_ something about 
things
 >     like fragmentation etc ("Oh, I could move these files all to a
 >     separate area")
----

    This could theoretically be done solely on a block basis.  While
file pointers would have to be updated to point to "out-of-sequence"
blocks, it might be more optimal to store _some_ files discontiguously
in order to pack the desired blocks into a (relatively) "small" area
that can be read into memory in some minimal number of physical i/o
requests.

   
 >  - it will miss any situation where a filesystem does a read some other
 >    way. Notably, in many loads, the _directory_ accesses are the 
important
 >    ones, and if you want statistics for those you'd often have to do 
that
 >    separately (not always - some of the filesystems just use the same
 >    page reading stuff).
---

    Recording physical block reads could automatically include this
situation.   

 >
 > The downsides basically boil down to the fact that it's not as clearly
 > just one single point. You can't just look at the request queue and see
 > what physical requests go out.
---

    You also have the downside of having to go through the file-system
and following each path and file-chain in order to read a potentially
discontiguous section of a file.  It also, _seemingly_, has the downside
of reading in "entire files" when only subsections of files may be
needed on startup.


   
 >
 > NOTE! You can obviously do both, and try to correlate one against the
 > other, and you'd get the best possible information ("is this seek 
because
 > we started reading another file, or is it because the file itself is
 > fragmented" kind of stuff). So physical statistics aren't meaningless.
 > They're just _less_ important than the virtual ones, and you should do
 > them only if you already do virtual stats.
---
    Sounds like you might need to have 2 sets of "addresses" / block:
file relative block addresses, and device relative block addresses.


-l


