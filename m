Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbRL3X5b>; Sun, 30 Dec 2001 18:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285748AbRL3X5W>; Sun, 30 Dec 2001 18:57:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24388 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285745AbRL3X5L>; Sun, 30 Dec 2001 18:57:11 -0500
Date: Mon, 31 Dec 2001 00:56:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Message-ID: <20011231005629.J1356@athlon.random>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>, <20011221004251.K1477@athlon.random>; <20011221024910.L1477@athlon.random> <3C22CF16.C78B1F19@zip.com.au>, <3C22CF16.C78B1F19@zip.com.au>; <20011229164056.H1356@athlon.random> <3C2EB208.B2BA7CBF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au>; from akpm@zip.com.au on Sat, Dec 29, 2001 at 10:19:52PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 10:19:52PM -0800, Andrew Morton wrote:
> [ this thread started at http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-51/1001.html ]
> 
> 
> Andrea Arcangeli wrote:
> > 
> > On Thu, Dec 20, 2001 at 09:56:40PM -0800, Andrew Morton wrote:
> > > Andrea Arcangeli wrote:
> > > >
> > > > ...
> > > > actually while testing it I unfortunately found also an fs corruption
> > > > bug in the ->prepare_write/commit_write/writepage/direct_IO callbacks.
> > > > It's a longstanding one, since get_block born.  In short, if get_block
> > > > fails while mapping on a certain page during
> > > > prepare_write/writepage/direct_IO (like it can happen with a full
> > > > filesystem, incidentally ext2 on /dev/ram0 during my testing that is
> > > > only 4M and so it overflows fast), the blocks before the ENOSPC failure
> > > > will be allocated, but the i_size won't be update accordingly (no commit
> > > > write, because prepare_write failed in the middle). for the
> > > > generic_file_write users it's easily fixable with an hack (truncating
> > > > backwards because we don't know how far we got allocating blocks when we
> > > > return from prepare_write), similar hack for the direct_IO one (that
> > > > commits only once at the end in function of the direct_IO generated).
> > > > But for writepage is quite a pain, infact I believe the writepage blocks
> > > > should be reserved in-core, to guarantee we will never fail a truncate
> > > > with ENOSPC.  With the shared mappings we're effectively doing allocate
> > > > on flush...  but with the lack of space reservation that makes it
> > > > unreliable :)
> > >
> > > The -ac kernels handled this by zeroing out the accidentally-allocated
> > > blocks at __block_prepare_write.
> > 
> > actually my fix seems cleaner because it puts the "clearing" in one single
> > place.
> 
> I think so too.  Even for ext3, which has a very complex truncate,
> it appears to be OK.
> 
> > > > So for now I did an hack to cure the other two (writepage can still
> > > > corrupt the fs as said). I think the right fix (ala 2.5) is to change
> > > > the API so we can use the last blocks too, but the below will cure 2.4
> > > > and for writepage the right fix IMHO is to do the reservation of the
> > > > space.
> > >
> > > This is better in a way because it reclaims the eztra few blocks.  But
> > > the -ac approach also works for writepage().
> > 
> > yes, it can solve the metadata corruption (assuming the locking is
> 
> Where can metadata corruption occur?  A few extra blocks outside
> i_size for ext2 directories isn't going to cause corruption, is it?
> 
> Or are you referring to i_blocks accounting being incorrect?

yes, I'm referring to the further blocks wrongly left allocated into the
inode.  that's plain metadata corruption (of course, it's not completly
random corruption at least) but just to mention one of the side effects
it can exploited in order to sniff contents of old data on disk (ok,
with ext2 that can happen anytime after an unclean unmount anyways, but
you know ext3 ordered or data journaling would prevent that).

> > right, I can as well call ->truncate within writepage but it's not
> > obvious at all that it won't race because we don't hold the i_sem within
> > writepage), but the data corruption still holds.
> 
> For sure - holding i_sem on truncate is abolutely required.

yes, this is also why it's not obvious the "undo" get_block on -ENOSPC
failure within writepage (what I understood from you to be in -ac).

> > I mean, there's no
> > failure path to notify userspace that a certain page fault is writing
> > into a page over an hole, that we don't have space to later allocate on
> > disk. so to me it sounds like MAP_SHARED should preallocate the space of
> > the holes so you will know that the writes into the MAP_SHARED segments
> > won't be lost (current state of things will lead to silent corruption
> > and pinned dirty pages in ram, aka broken allocate on flush like
> > previously said).
> 
> Um.  How does this differ from an I/O error on flush?

It differs because I/O error is an hardware error and we have no hope if
the platter is corrupted. I mean, if the DB gets corrupted after a
reboot because last night the harddisk created some badblocks is not our
business. We cannot fix it, currently we cannot notify about it, but
after all it wasn't our mistake :). we'll just left some dirty pages
around if those write fails because the hardware couldn't relocate the
badblock transparently during the writes.

If instead the DB gets corrupted because somebody was writing to disk
and the disk filled up, so the writepage allocate on flush couldn't find
any space where to write the dirty data, that sounds like our mistake.
There's no way the app can know about this unless we sigsomething or we
return -ENOSPC on mmap. Checking SuSv2 there's no -ENOSPC contemplated
as retval from mmap, but I remeber there are always the zillon of
exceptions and "always available" error codes, so it's not obvious it's
not contemplated.

I mean, if the mmap API prevents us to return -ENOSPC there's no way we
can build a reliable MAP_SHARED with filesystems that allows holes on
files. You will never know if this MAP_SHARED updates hit the disk,
unless you previously made sure to generate a file without holes (to get
the -ENOSPC failure path with the write(2) syscall).

> Would it be necessary to preallocate the holes at mmap() time?  Mad

Not preallocate, but just reserve space, just like we should do with
write(2), the reason write(2) is synchronous with the lowlevel block
allocation is just because we don't have an API with the lowlevel fs to
reserve space. As soon as we'll add this API it will be possible to turn
all the fs out there into allocate on flush for writes (not only for
MAP_SHARED). so if we write a few bytes and delete the file, we won't
hit the lowlevel fs ialloc path for example (but only the superblock
space reservation callback that can also be threaded or maybe lockless
with atomic ops).

> hand-waving: Could we not perform the instantiation at pagefault time,
> and give the caller SIGBUS if we cannot allocate the blocks?  Or if
> there's an IO error, or quota exceeded.

sigbus is viable solution indeed, it's a matter of userspace API
specifications actually, not something we can choose liberally.

The fact is, currently we sigbus on MAP_SHARED if the updates are beyond
the end of the i_size, so maybe using sigbus to notify about the other
cases too would be confusing? (app thinks it's writing beyond the end of
i_size, unless it explicitly checks for that)

> 
> > > Why was that code not brought across?
> > 
> > Who developed that code? Can the author of the code forward port it to
> > 2.4.18pre and post a patch to the list so we can review? thanks,
> > Avoiding the matadata corruption would be a good start at least for 2.4,
> > then we should just focus on the writepage locking that could race with the
> > other "create=1" get_blocks. If it doesn't race I will certainly agree
> > on that approch for 2.4.
> > 
> 
> It appeared in 2.4.2-ac25, and it looks like sct was the author:
> 
> o       Fix higmem block_prepare_write crash            (Stephen Tweedie)
> 
> Which is interesting - from the changelog it looks like he was
> fixing a different problem!  I always though that code was there
> to prevent leakage of stale blocks.  Stephen?

Makes sense to me, I also didn't recall any specific fix for the i_block
corruption before my report of last week, maybe it fixed both things at
once?

> A 2.4.18-pre1 version is below.  It compiles, but I haven't actually
> exercised that code path.
> 
> It's not a pretty fix, IMO.  It leaves dangling blocks outside i_size
> which will make fsck unhappy.  It also breaks ext3 a little bit - 
> those blocks should be journalled and in theory we'd need to
> clone off private copies of __block_prepare_write() and
> unmap_underlying_metadata() to do this.  Which would be irritating,
> but not the end of the world.   (Should have done this in the -ac
> version of ext3, but I never noticed it). 
> 
> 
> --- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
> +++ linux-akpm/fs/buffer.c	Sat Dec 29 21:53:46 2001
> @@ -1639,6 +1639,17 @@ static int __block_prepare_write(struct 
>  	}
>  	return 0;
>  out:
> +	bh = head;
> +	block_start = 0;
> +	do {
> +		if (buffer_new(bh) && !buffer_uptodate(bh)) {
> +			memset(kaddr+block_start, 0, bh->b_size);
> +			set_bit(BH_Uptodate, &bh->b_state);
> +			mark_buffer_dirty(bh);
> +		}
> +		block_start += bh->b_size;
> +		bh = bh->b_this_page;
> +	} while (bh != head);
>  	return err;
>  }

yes, I doesn't deallocate the blocks that was the whole point of the
corruption I mentioned, so it looks it's not covering our case.

>  
> Question: can someone please define BH_New?  Its lifecycle seems

BH_New means the bh is just born while being mapped. It matters only if
you called get_block with create=1 in order to map an unmapped bh. If
the bh was mapped it doesn't matter, because if it was mapped you didn't
need to call get_block in first place (so we left it set and that's
fine). Calling get_block on mapped bh is a bug. a bh_new is always
bh_mapped.

> very vague.  We never actually seem to *clear* it anywhere for 
> ext2, and it appears that the kernel will keep on treating a
> clearly non-new buffer as "new" all the time.  ext3 explicitly
> clears BH_New in get_block(), if it finds the block was already
> present in the file.  I did this because we need the newness
> info for internal purposes.
> 
> -

anyways about the sigbus/mmap returning -ENOSPC things, they're low
prio, I think first we should avoid metadata corruption, that's our
internal stuff and we have no constraints about userspace API in order
to fix it.  Convering writepage with the "get_block undo" as said
doesn't look obvious due the lack of i_sem and the other writers
depending on stuff not going away under them unless i_sem was acquired.
(OTOH those floating unwriteable dirty pages could run the machine oom)

Andrea
