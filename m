Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273099AbRIIXtG>; Sun, 9 Sep 2001 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273100AbRIIXsq>; Sun, 9 Sep 2001 19:48:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:25864 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273099AbRIIXsn>; Sun, 9 Sep 2001 19:48:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 01:56:13 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
In-Reply-To: <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109082115270.1161-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010909234859Z16150-26183+677@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 06:28 am, Linus Torvalds wrote:
> [ start future rambling ]
> 
> Now, I actually believe that we would eventually be better off by having a
> real filesystem interface for doing kernel-assisted fsck, backup and
> de-fragmentation (all just three different sides of the same thing:
> filesystem administration), but that's a separate issue, and right now we
> have absolutely no clue about what such an interface would look like. So
> that's a long-term thing (other OS's have such interfaces, but they tend
> to be specialized for only a subset of possible filesystems. Think
> Windows defrag).
> 
> That kind of explicit filesystem maintenance interface would make all the
> remaining issues go away completely, and would at least in theory allow
> on-line fixing of already mounted filesystems. Assuming a good interface
> and algorithm for it exists, of course.

A more modest goal, which I'm simply restating from earlier in the thread, 
would be to achieve a coherent view of a volume at the block level.  This is 
just a cache coherency problem.  The trouble is, every solution that's been 
looked at so far has a non-zero cost associated with it for the normal case 
of no sharing.

*However*.  If we could find a method of implementing the cache coherency so 
it actually accelerates the common case then it would become an attractive 
thing to do.

Physically-based readahead might be such a magic bullet.  The structural cost 
of the cache coherency would be a reverse-lookup hash chain on each page 
cache page, which we already almost have with the unused buffer hash links.  
The operational cost would be an extra hash probe for each block read, write, 
create, or delete.  Against this, physical readahead can sometimes do a 
better job than logical readahead because it can optimize across files and 
metadata structures, something that is difficult to do at the logical level.  
Spending a few extra CPU cycles to buy improved filesystem latency in the 
common case would be a good trade.

While I'm in here between the [future] brackets, I'll mention a few points
in favor:

  - Some of the reverse probes can be optimized away, for example, when we
    find a page in the pagecache we can skip the reverse probe because we
    know it's not in the physical (aka buffer) cache.  This should be the
    common case.

  - Scsi disks, and now some IDE disks, already do physical readahead, but 
    they typically have far less cache memory than the processor does.  If
    physical readahead is good, then more must be better ;-)  In any
    event, moving the physical readahead onto the processor side of the
    bus reduces latency.

  - Physical readahead and logical readahead could conceivably work
    together, for example, by using an interface where the vfs provides
    hints to a physical readahead process, rather than taking on the job
    of intiating IO itself.

  - There are opportunities to do zero-copy moves from the physical
    cache to the page cache, by relinking the underlying page instead
    of copying.

  - This isn't a huge change to the way we already do things.  The
    interface to the physical cache is simply the existing buffer
    API.  We repurpose the currently unused hash chain for page cache 
    buffers, and that's transparent.  The vm scanner has to know a
    few more rules about freeing buffers.  The actual cache
    consistency is implemented transparently by the block IO library.

  - If we ever do get to the point of having variable sized page
    objects the implementation gets simpler.   Not that it's
    particularly complex as it is.

> [ end future rambling ]

--
Daniel
