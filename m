Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280670AbRK1UdB>; Wed, 28 Nov 2001 15:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280669AbRK1Ucv>; Wed, 28 Nov 2001 15:32:51 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19471 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280647AbRK1Ucq>; Wed, 28 Nov 2001 15:32:46 -0500
Message-ID: <3C054992.48F5C9E7@zip.com.au>
Date: Wed, 28 Nov 2001 12:31:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Mike Fedyk <mfedyk@matchmail.com>, Ahmed Masud <masud@googgun.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C03FE2F.63D7ACFD@zip.com.au> <Pine.LNX.4.21.0111281604390.15571-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Tue, 27 Nov 2001, Andrew Morton wrote:
> 
> > Mike Fedyk wrote:
> > >
> > > >   I'll send you a patch which makes the VM less inclined to page things
> > > >   out in the presence of heavy writes, and which decreases read
> > > >   latencies.
> > > >
> > > Is this patch posted anywhere?
> >
> > I sent it yesterday, in this thread.  Here it is again.
> >
> > Description:
> >
> > - Account for locked as well as dirty buffers when deciding
> >   to throttle writers.
> 
> Just one thing: If we have lots of locked buffers due to reads we are
> going to may unecessarily block writes, and thats not any good.

True.  I believe this change makes balance_dirty() work as it was
originally intended to work.   But in so doing, lots of things change.
Various places which have been tuned for the broken balance_dirty()
behaviour may need to be retuned.  It needs testing, thought, and
a comment from Linus would be helpful.

> But well, I prefer to fix interactivity than to care about that one kind
> of workload, so I'm ok with it.
> 
> > - Tweak VM to make it work the inactive list harder, before starting
> >   to evict pages or swap.
> 
> I would like to see he interactivity problems get fixed on block layer
> side first: Its not a VM issue initially. Actually, the thing is that if
> you tweak VM this way you're going to break some workloads.

Possibly.  I have a feeling that the VM is a bit too swaphappy,
especially in the presence of heavy write() loads.  I'd rather
see more aggressive dropbehind on the write() data, than see
useful cache data dropped.  But I'm not sure yet.
 
> > - Change the elevator so that once a request's latency has
> >   expired, we can still perform merges in front of that
> >   request.  But we no longer will insert new requests in
> >   front of that request.
> 
> Sounds fine... I've received quite many success reports already, right ?

A few people have reported success.  Nathan Grennan didn't. 

The elevator change also needs more testing and review.
There's a possibility that it could cause a seek-storm collapse
when interacting with readahead.   Currently, readhead does this:

	for (some pages) {
		alloc_page()
		page_cache_read()
	}

See the potential here for the alloc_page() to get abducted
by shrink_cache(), to perform IO, and to not return until after
the previous page_cache_read() has been submitted to the device?
Ouch.  Putting reads nearer the elevator head exposes this possibility.

It seems to not happen, due to the vagaries of the VM-of-the-minute,
and the workload.  But it could.

So the obvious change is to allocate all the readhead pages up-front
before issuing the reads.  I rewrote the readhead code to do this
(and dropped about 300 lines from filemap.c in the process), but given
that the condition doesn't trigger, it doesn't make much difference.

I've spent a week so far looking closely at various performance
and usability problems with 2.4. It's still a work-in-progress.
I don't feel ready to start offering anything for merging yet,
really.  Some of these things interact, and I'd prefer to get
more off-stream testing done, as well as code review.

Current patchset is at http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/

The list so far is:

vm-fixes.patch
	The balance_dirty() and less swap-happy changes
write-cluster.patch
	ext2 metadata prereading and various other hacks which
	prevent writes from stumbling over reads, and thus ruining
	write clustering.  This patch is in the early prototype stage
readhead.patch
	VM readhead rewrite.  Designed to avoid the above
	problem, and to make readhead growth more aggressive,
	and to make readhead shrinkth less aggressive.  I
	don't see why we should drop the readhead window on the
	floor if someone has read a few megs from a file and then
	seeks elsewhere within it.  Also uses common code for
	mmap readhead.  The madvise explicit dropbehind code
	accidentally died.  Oh well.
	Testing with paging-intensive workloads (start X11, staroffice6)
	indicates that we indeed do more IO, in less requests.  But
	walltime doesn't change.   I may not proceed with this.
mini-ll.patch
	A kinder, gentler low-latency patch, based on the one which
	Andrea is maintaining.  Doesn't drop any locks.  As far as
	I'm concerned, this can be merged today (six months ago, in
	fact).  It gives practically all the perceived benefit of
	the preemptive kernel patch and is clearly safe.
	A number of vendors are shipping kernels which are patched
	to add rescheduling points to copy_*_user(), which is
	much less effective than this patch.  They shouldn't
	be doing this.
elevator.patch
	The previously-described elevator changes
inline.patch
	Drops a large number of ill-chosen `inline' qualifiers
	from the kernel.  Removes a total of about 12,000 bytes
	of instructions, almost all from the very hottest parts of
	the kernel.  Should prove useful for computers which
	have an L1 cache which is faster than main memory.
block-alloc.patch
	My nemesis.  Fixing the long- and short-term fragmentation
	of ext2/ext3 blocks would be a more significant performance
	boost than anything else in the 2.4 series.  But it's just
	proving intractable.  I'll probably have to drop most of
	this, and look at online defrag.   There's potential for
	a 3x to 5x speedup here.

Also need to do something about the stalls which Nathan Grennan
has reported.  On ext3 it seems to be due to atime updates.
Not sure about ext2 yet.
