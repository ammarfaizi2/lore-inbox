Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbTGDBcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbTGDBcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:32:31 -0400
Received: from holomorphy.com ([66.224.33.161]:40389 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265631AbTGDBcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:32:19 -0400
Date: Thu, 3 Jul 2003 18:46:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704014624.GN20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030703125839.GZ23578@dualathlon.random> <Pine.LNX.4.44.0307030904260.16582-100000@chimarrao.boston.redhat.com> <20030703185341.GJ20413@holomorphy.com> <20030703192750.GM23578@dualathlon.random> <20030703201607.GK20413@holomorphy.com> <20030704004000.GQ23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704004000.GQ23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> If it's such a strong feature, go ahead and show me a patch to a real
> life applications (there are plenty of things using hashes or btrees,
> feel free to choose the one that according to you will behave closest to
> the "exploit" [1]) using remap_file_pages to avoid the pte overhead and
> show the huge improvement in the numbers compared to changing the design
> of the code to have some sort of locality in the I/O access patterns
> (NOTE: I don't care about ram, I care about speed). Given how hard you
> advocate for this I assume you at least expect a 1% improvement, right?
> Once you make the patch I can volounteer to benchmark it if you don't
> have time or hardware for that. After you made the patch and you showed
> a >=1% improvement by not keeping the file mapped linearly, but by
> mapping it nonlinearly using remap_file_pages, I reserve myself to fix
> the app to have some sort of locality of information so that the I/O
> side will be able to get a boost too.

You're obviously determined to write the issue the thing addresses
out of the cost/benefit analysis. This is tremendously obvious;
conserve RAM and you don't go into page (or pagetable) replacement.

I'm sick of hearing how it's supposedly legitimate to explode when
presented with random access patterns (this is not the only instance
of such an argument).

And I'd love to write an app that uses it for this; unfortunately for
both of us, I'm generally fully booked with kernelspace tasks.


On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> the fact is, no matter the VM side, your app has no way to nearly
> perform in terms of I/O seeks if you're filling a page per pmd due the
> huge seek it will generate with the major faults. And even the minor
> faults if has no locality at all and it seeks all over the place in a
> non predictable manner, the tlb flushes will kill performance compared
> to keeping the file mapped statically, and it'll make it even slower
> than accessing a new pte every time.

What minor faults? remap_file_pages() does pagecache lookups and
instantiates the ptes directly in the system call.

Also, the assumption of being seek-bound assumes a large enough cache
turnover rate to resort to io often. If such were the case it would be
unoptimizable apart from doubling the amount of pagecache it's feasible
to cache (which would provide only a slight advantage in such a case).

The obvious, but unstated assumption I made is that the virtual arena
(and hence physical pagecache backing it) is large enough to provide a
high cache hit rate to the mapped on-disk data structures. And the
virtualspace compaction is in order to prevent pagetables from
competing with pagecache.


On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> Until you produce pratical results IMHO the usage you advocated to use
> remap_file_pages to avoid doing big linear mappings that may allocate
> more ptes, sounds completely vapourware overkill overdesign that won't
> last past emails.  All in my humble opinion of course. I've no problem
> to be wrong, I just don't buy what you say since it is not obvious at
> all given the huge cost of entering exiting kernel, reaching the
> pagetable in software, mangling them, flushing the tlb (on all common
> archs that I'm assuming this doesn't only mean to flush a range but to
> flush it all but it'd be slower even with a range-flush operation),
> compared to doing nothing with a static linear mapping (regardless the
> fact there are more ptes with a big linear mapping, I don't care to save
> ram).

Space _does_ matter. Everywhere. All the time. And it's not just
virtualspace this time. Throw away space, and you go into page or
pagetable replacement.

I'd love to write an app that uses it properly to conserve space. And
saving space is saving time. Time otherwise spent in page replacement
and waiting on io.


On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> If you really go to change the app to use remap_file_pages, rather than
> just compact the vm side with remap_file_pages (which will waste lots of
> cpu power and it'll run slower IMHO), you'd better introduce locality
> knowledge so the I/O side will have a slight chance to perform too and
> the VM side will be improved as well, potentially also sharing the same
> page, not only the same pmd (and after you do that if you really need to
> save ram [not cpu] you can munmap/mmap at the same cost but this is just
> a said note, I said I don't care to save ram, I care to perform the
> fastest). reiserfs and other huge btree users have to do this locality
> stuff all the time with their trees, for example to avoid a directory to
> be completely scattered everywhere in the tree and in turn triggering
> an huge amount of I/O seeks that may not even fit in buffercache. w/o
> the locality information there would be no way for reiserfs to perform
> with big filesystems and many directories, this is just the simples
> example I can think of huge btrees that we use everyday.

Filesystems don't use mmap() to simulate access to the B-trees, they
deal with virtual discontiguity with lookup structures. They essentially
are scattered on-disk, though not so greatly as general lookup
structures would be. The VM space cost of using mmap() on such on-disk
structures is what's addressed by this API.

Also, mmap()/munmap() do not have equivalent costs to remap_file_pages();
they do not instantiate ptes like remap_file_pages() and hence accesses
incur minor faults. So it also addresses minor fault costs. There is no
API not requiring privileges that speculatively populates ptes of a
mapping and would prevent minor faults like remap_file_pages().

Another advantage of the remap_file_pages() approach is that the
virtual arena can be made somewhat smaller than the actual pagecache,
which allows the VM to freely reclaim the cold bits of the cache and by
so doing not overcompete with other applications. i.e. I take the exact
opposite tack: apps should not hog every resource of the machine they
can for raw speed but rather be "good citizens".

In principle, there are other ways to do these things in some cases,
e.g. O_DIRECT. It's not truly an adequate substitute, of course, since
not only is the app then forced to deal with on-disk coherency, the
mappings aren't shared with pagecache (i.e. evictable via mere writeback)
and the cost of io is incurred for each miss of the process' cache of
the on-disk data.


On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> Again, I don't care about saving ram, we're talking 64bit, I care about
> speed, I hope I already made this clear enough in the previous email.

This is a very fundamentally mistaken set of priorities.


On Fri, Jul 04, 2003 at 02:40:00AM +0200, Andrea Arcangeli wrote:
> My arguments sounds all pretty strightforward to me.

Sorry, this line of argument is specious.

As for the security issue, I'm not terribly interested, as rlimits on
numbers of processes and VSZ suffice (to get an idea of how much you've
entitled a user to, check RLIMIT_NPROC*RLIMIT_AS*sizeof(pte_t)/PAGE_SIZE).
This is primarily resource scalability and functionality, not
bencnmark-mania or security.


-- wli
