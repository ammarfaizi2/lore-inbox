Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbRL3GXl>; Sun, 30 Dec 2001 01:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287345AbRL3GXc>; Sun, 30 Dec 2001 01:23:32 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51470 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287344AbRL3GXV>; Sun, 30 Dec 2001 01:23:21 -0500
Message-ID: <3C2EB208.B2BA7CBF@zip.com.au>
Date: Sat, 29 Dec 2001 22:19:52 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern 
 el panic woes
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>, <20011221004251.K1477@athlon.random>; <20011221024910.L1477@athlon.random> <3C22CF16.C78B1F19@zip.com.au>,
		<3C22CF16.C78B1F19@zip.com.au>; from akpm@zip.com.au on Thu, Dec 20, 2001 at 09:56:40PM -0800 <20011229164056.H1356@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this thread started at http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-51/1001.html ]


Andrea Arcangeli wrote:
> 
> On Thu, Dec 20, 2001 at 09:56:40PM -0800, Andrew Morton wrote:
> > Andrea Arcangeli wrote:
> > >
> > > ...
> > > actually while testing it I unfortunately found also an fs corruption
> > > bug in the ->prepare_write/commit_write/writepage/direct_IO callbacks.
> > > It's a longstanding one, since get_block born.  In short, if get_block
> > > fails while mapping on a certain page during
> > > prepare_write/writepage/direct_IO (like it can happen with a full
> > > filesystem, incidentally ext2 on /dev/ram0 during my testing that is
> > > only 4M and so it overflows fast), the blocks before the ENOSPC failure
> > > will be allocated, but the i_size won't be update accordingly (no commit
> > > write, because prepare_write failed in the middle). for the
> > > generic_file_write users it's easily fixable with an hack (truncating
> > > backwards because we don't know how far we got allocating blocks when we
> > > return from prepare_write), similar hack for the direct_IO one (that
> > > commits only once at the end in function of the direct_IO generated).
> > > But for writepage is quite a pain, infact I believe the writepage blocks
> > > should be reserved in-core, to guarantee we will never fail a truncate
> > > with ENOSPC.  With the shared mappings we're effectively doing allocate
> > > on flush...  but with the lack of space reservation that makes it
> > > unreliable :)
> >
> > The -ac kernels handled this by zeroing out the accidentally-allocated
> > blocks at __block_prepare_write.
> 
> actually my fix seems cleaner because it puts the "clearing" in one single
> place.

I think so too.  Even for ext3, which has a very complex truncate,
it appears to be OK.

> > > So for now I did an hack to cure the other two (writepage can still
> > > corrupt the fs as said). I think the right fix (ala 2.5) is to change
> > > the API so we can use the last blocks too, but the below will cure 2.4
> > > and for writepage the right fix IMHO is to do the reservation of the
> > > space.
> >
> > This is better in a way because it reclaims the eztra few blocks.  But
> > the -ac approach also works for writepage().
> 
> yes, it can solve the metadata corruption (assuming the locking is

Where can metadata corruption occur?  A few extra blocks outside
i_size for ext2 directories isn't going to cause corruption, is it?

Or are you referring to i_blocks accounting being incorrect?

> right, I can as well call ->truncate within writepage but it's not
> obvious at all that it won't race because we don't hold the i_sem within
> writepage), but the data corruption still holds.

For sure - holding i_sem on truncate is abolutely required.

> I mean, there's no
> failure path to notify userspace that a certain page fault is writing
> into a page over an hole, that we don't have space to later allocate on
> disk. so to me it sounds like MAP_SHARED should preallocate the space of
> the holes so you will know that the writes into the MAP_SHARED segments
> won't be lost (current state of things will lead to silent corruption
> and pinned dirty pages in ram, aka broken allocate on flush like
> previously said).

Um.  How does this differ from an I/O error on flush?

Would it be necessary to preallocate the holes at mmap() time?  Mad
hand-waving: Could we not perform the instantiation at pagefault time,
and give the caller SIGBUS if we cannot allocate the blocks?  Or if
there's an IO error, or quota exceeded.

> > Why was that code not brought across?
> 
> Who developed that code? Can the author of the code forward port it to
> 2.4.18pre and post a patch to the list so we can review? thanks,
> Avoiding the matadata corruption would be a good start at least for 2.4,
> then we should just focus on the writepage locking that could race with the
> other "create=1" get_blocks. If it doesn't race I will certainly agree
> on that approch for 2.4.
> 

It appeared in 2.4.2-ac25, and it looks like sct was the author:

o       Fix higmem block_prepare_write crash            (Stephen Tweedie)

Which is interesting - from the changelog it looks like he was
fixing a different problem!  I always though that code was there
to prevent leakage of stale blocks.  Stephen?

A 2.4.18-pre1 version is below.  It compiles, but I haven't actually
exercised that code path.

It's not a pretty fix, IMO.  It leaves dangling blocks outside i_size
which will make fsck unhappy.  It also breaks ext3 a little bit - 
those blocks should be journalled and in theory we'd need to
clone off private copies of __block_prepare_write() and
unmap_underlying_metadata() to do this.  Which would be irritating,
but not the end of the world.   (Should have done this in the -ac
version of ext3, but I never noticed it). 


--- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sat Dec 29 21:53:46 2001
@@ -1639,6 +1639,17 @@ static int __block_prepare_write(struct 
 	}
 	return 0;
 out:
+	bh = head;
+	block_start = 0;
+	do {
+		if (buffer_new(bh) && !buffer_uptodate(bh)) {
+			memset(kaddr+block_start, 0, bh->b_size);
+			set_bit(BH_Uptodate, &bh->b_state);
+			mark_buffer_dirty(bh);
+		}
+		block_start += bh->b_size;
+		bh = bh->b_this_page;
+	} while (bh != head);
 	return err;
 }
 
Question: can someone please define BH_New?  Its lifecycle seems
very vague.  We never actually seem to *clear* it anywhere for 
ext2, and it appears that the kernel will keep on treating a
clearly non-new buffer as "new" all the time.  ext3 explicitly
clears BH_New in get_block(), if it finds the block was already
present in the file.  I did this because we need the newness
info for internal purposes.

-
