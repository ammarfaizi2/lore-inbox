Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292079AbSCDHWf>; Mon, 4 Mar 2002 02:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292082AbSCDHW1>; Mon, 4 Mar 2002 02:22:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292079AbSCDHWN>;
	Mon, 4 Mar 2002 02:22:13 -0500
Message-ID: <3C83202D.A9FFB902@zip.com.au>
Date: Sun, 03 Mar 2002 23:20:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au>,
		<3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> Why did you write [patch] instead of [PATCH]? ;-)

It's a start ;)

>...
> > Global accounting of locked and dirty pages has been introduced.
> 
> Alan seems to be working on this as well.  Besides locked and dirty we also
> have 'pinned', i.e., pages that somebody has taken a use count on, beyond the
> number of pte+pcache references.

Well one little problem with tree owners writing code is that it's
rather hard for mortals to see what they've done.  Because the diffs
come with so much other stuff.  Which is my lame excuse for not having
reviewed Alan's work.  But if he has global (as opposed to per-mm, per-vma,
etc) data then yes, it can go into the page_states[] array.

> I'm just going to poke at a couple of inconsequential things for now, to show
> I've read the post.  In general this is really important work because it
> starts to move away from the vfs's current dumb filesystem orientation.
> 
> I doubt all the subproblems you've addressed are tackled in the simplest
> possible way, and because of that it's a cinch Linus isn't just going to
> apply this.  But hopefully the benchmarking team descend upon this and find
> out if it does/does't suck, and hopefully you plan to maintain it through 2.5.

The problem with little, incremental patches is that they require
a high degree of planning, trust and design.  A belief that the
end outcome will be right.   That's hard, and it generates a lot of
talk, and the end outcome may *not* be right.

So in the best of worlds, we have the end outcome in-hand, and testable.
If it works, then we go back to the incremental patches.
 
> > Testing is showing considerable improvements in system tractability
> > under heavy load, while approximately doubling heavy dbench throughput.
> > Other benchmarks are pretty much unchanged, apart from those which are
> > affected by file fragmentation, which show improvement.
> 
> What is system tractability?

Sorry.  General usability when the system is under load.  With these
patches it's better, but still bad.

Look.  A process calls the page allocator to, duh, allocate some pages.
Processes do *not* call the page allocator because they suddenly feel
like spending fifteen seconds asleep on the damned request queue.

We need to throttle the writers and only the writers.  We need other tasks
to be able to obtain full benefit of the rate at which the disks can
clean memory.

You know where this is headed, don't you:

- writeout is performed by the writers, and by the gang-of-flush-threads.
- kswapd is 100% non-blocking.  It never does I/O.
- kswapd is the only process which runs page_launder/shrink_caches.
- Memory requesters do not perform I/O.  They sleep until memory
  is available. kswapd gives them pages as they become available, and
  wakes them up.

So that's the grand plan.  It may be fatally flawed - I remember Linus
had a serious-sounding objection to it some time back, but I forget
what that was.  We come badly unstuck if it's a disk-writer who
goes to sleep on the i-want-some-memory queue, but I don't think
it was that.

Still, this is just a VM rant.  It's not the objective of this work.

 
> > With this patch, writepage() is still using the buffer layer, so lock
> > contention will still be high.
> 
> Right, and buffers are going away one way or another.

This is a problem.  I'm adding new stuff which does old things in
a new way, with no believable plan in place for getting rid of the
old stuff.

I don't think it's humanly possible to do away with struct buffer_head.
It is *the* way of representing a disk block.   And unless we plan
to live with 4k pages and 4k blocks for ever, the problem is about
to get worse.  Think 64k pages with 4k blocks.

Possibly we could handle sub-page segments of memory via a per-page up-to-date
bitmask.  And then a `dirty' bitmask.  And then a `locked' bitmask, etc.  I
suspect eventually we'll end up with, say, a vector of structures attached to
each page which represents the state of each of the page's sub-segments.  whoops.

So as a tool for representing disk blocks - for subdividing individual
pages of the block device's pagecache entries, buffer_heads make sense,
and I doubt if they're going away.

But as a tool for getting bulk file data on and off disk, buffer_heads
really must die.   Note how submit_bh() now adds an extra memory allocation
into each buffer as it goes past.  Look at some 2.5 kernel profiles....

> ...
> > Within the VM, the concept of ->writepage() has been replaced with the
> > concept of "write back a mapping".  This means that rather than writing
> > back a single page, we write back *all* dirty pages against the mapping
> > to which the LRU page belongs.
> 
> This is a good and natural step, but don't we want to go even more global
> than that and look at all the dirty data on a superblock, so the decision on
> what to write out is optimized across files for better locality.

Possibly, yes.

The way I'm performing writeback now is quite different from the
2.4 way.  Instead of:

	for (buffer = oldest; buffer != newest; buffer++)
		write(buffer);

it's

	for (superblock = first; superblock != last; superblock++)
		for (dirty_inode = first; dirty_inode != last; dirty_inode++)
			filemap_fdatasync(inode);

Again, by luck and by design, it turns out that this almost always
works.  Care is taken to ensure that the ordering of the various
lists is preserved, and that we end up writing data in program-creation
order.  Which works OK, because filesystems allocate inodes and blocks
in the way we expect (and desire).

What you're proposing is that, within the VM, we opportunistically
flush out more inodes - those which neighbour the one which owns
the page which the VM wants to free.

That would work.  It doesn't particularly help us in the case where the VM
is trying to get free pages against a specific zone, but it would perhaps
provide some overall bandwidth benefits.

However, I'm kind of already doing this.  Note how the VM's wakeup_bdflush()
call also wakes pdflush. pdflush will wake up, walk through all the
superblocks, find one which doesn't currently have a pdflush instance
working it and will start writing back that superblock's dirty pages.

(And the next wakeup_bdflush call will wake another pdflush thread,
which will go off and find a different superblock to sync, which is
in theory tons better than using a single bdflush thread for all dirty
data in the machine.   But I haven't demonstrated practical benefit
from this yet).

> ...
> 
> >   But it may come unstuck when applied to swapcache.
> 
> You're not even trying to apply this to swap cache right now are you?

No.
 
> > Things which must still be done include:
> >
> > [...]
> >
> > - Remove bdflush and kupdate - use the pdflush pool to provide these
> >   functions.
> 
> The main disconnect there is sub-page sized writes, you will bundle together
> young and old 1K buffers.  Since it's getting harder to find a 1K blocksize
> filesystem, we might not care.  There is also my nefarious plan to make
> struct pages refer to variable-binary-sized objects, including smaller than
> 4K PAGE_SIZE.

I was merely suggesting a tidy-up here.  pdflush provides a dynamically-sized
pool of threads for writing data back to disk.  So we can remove the
dedicated kupdate and bdflush kernel threads and replace them with:

wakeup_bdflush()
{
	pdflush_operation(sync_old_buffers, NULL);
}

Additionally, we do need to provide ways of turning the kupdate,
bdflush and pdflush functions off and on.  For laptops, swsusp, etc.
But these are really strange interfaces which have sort of crept
up on us over time.  In this case we need to go back, work out
what we're really trying to do here and provide a proper set of
interfaces.  Rather than `kill -STOP $(pidof kupdate)' or whatever
the heck people are using.

> ...
> > - Use pdflush for try_to_sync_unused_inodes(), to stop the keventd
> >   abuse.
> 
> Could you explain please?

keventd is a "process context bottom half handler".  It should provide
the caller with reasonably-good response times.  Recently, schedule_task()
has been used for writing ginormous gobs of discontiguous data out to
disk because the VM happened to get itself into a sticky corner.

So it's another little tidy-up.  Use the pdflush pool for this operation,
and restore keventd's righteousness.

> ...
> I guess the thing to do is start thinking about parts that can be broken out
> because of obvious correctness.  The dirty/locked accounting would be one
> candidate, the multiple flush threads another, and I'm sure there are more
> because you don't seem to have treated much as sacred ;-)

Yes, that's a reasonable ordering.  pdflush is simple and powerful enough
to be useful even if the rest founders - rationalise kupdate, bdflush,
keventd non-abuse, etc.  ratcache is ready, IMO.  The global page-accounting
is not provably needed yet.

Here's another patch for you:

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre2/dallocbase-10-readahead.patch

It's against 2.5.6-pre2 base.  It's a partial redesign and a big
tidy-up of the readahead code.  It's largely described in the
comments (naturally).  

- Unifies the current three readahead functions (mmap reads, read(2)
  and sys_readhead) into a single implementation.

- More aggressive in building up the readahead windows.

- More conservative in tearing them down.

- Special start-of-file heuristics.

- Preallocates the readahead pages, to avoid the (never demonstrated,
  but potentially catastrophic) scenario where allocation of readahead
  pages causes the allocator to perform VM writeout.

- {hidden agenda): Gets all the readahead pages gathered together in
  one spot, so they can be marshalled into big BIOs.

- reinstates the readahead tunables which Mr Dalecki cheerfully chainsawed.
  So hdparm(8) and blockdev(8) are working again.  The readahead settings
  are now per-request-queue, and the drivers never have to know about it.

- Identifies readahead thrashing.

  Note "identifies".  This is 100% reliable - it detects readahead
  thrashing beautifully.  It just doesn't do anything useful about
  it :(

  Currently, I just perform a massive shrink on the readahead window
  when thrashing occurs.  This greatly reduces the amount of pointless
  I/O which we perform, and will reduce the CPU load.  But big deal.  It
  doesn't do anything to reduce the seek load, and it's the seek load
  which is the killer here.   I have a little test case which goes from
  40 seconds with 40 files to eight minutes with 50 files, because the
  50 file case invokes thrashing.   Still thinking about this one.

- Provides almost unmeasurable throughput speedups!

-
