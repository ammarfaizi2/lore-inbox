Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284020AbRL2Ple>; Sat, 29 Dec 2001 10:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284088AbRL2PlZ>; Sat, 29 Dec 2001 10:41:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13136 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284020AbRL2PlQ>; Sat, 29 Dec 2001 10:41:16 -0500
Date: Sat, 29 Dec 2001 16:40:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Message-ID: <20011229164056.H1356@athlon.random>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com> <200112201946.fBKJkNw01262@penguin.transmeta.com> <20011221004251.K1477@athlon.random>, <20011221004251.K1477@athlon.random>; <20011221024910.L1477@athlon.random> <3C22CF16.C78B1F19@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C22CF16.C78B1F19@zip.com.au>; from akpm@zip.com.au on Thu, Dec 20, 2001 at 09:56:40PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 09:56:40PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > actually while testing it I unfortunately found also an fs corruption
> > bug in the ->prepare_write/commit_write/writepage/direct_IO callbacks.
> > It's a longstanding one, since get_block born.  In short, if get_block
> > fails while mapping on a certain page during
> > prepare_write/writepage/direct_IO (like it can happen with a full
> > filesystem, incidentally ext2 on /dev/ram0 during my testing that is
> > only 4M and so it overflows fast), the blocks before the ENOSPC failure
> > will be allocated, but the i_size won't be update accordingly (no commit
> > write, because prepare_write failed in the middle). for the
> > generic_file_write users it's easily fixable with an hack (truncating
> > backwards because we don't know how far we got allocating blocks when we
> > return from prepare_write), similar hack for the direct_IO one (that
> > commits only once at the end in function of the direct_IO generated).
> > But for writepage is quite a pain, infact I believe the writepage blocks
> > should be reserved in-core, to guarantee we will never fail a truncate
> > with ENOSPC.  With the shared mappings we're effectively doing allocate
> > on flush...  but with the lack of space reservation that makes it
> > unreliable :)
> 
> The -ac kernels handled this by zeroing out the accidentally-allocated
> blocks at __block_prepare_write.

actually my fix seems cleaner because it puts the "clearing" in one single
place.

> > So for now I did an hack to cure the other two (writepage can still
> > corrupt the fs as said). I think the right fix (ala 2.5) is to change
> > the API so we can use the last blocks too, but the below will cure 2.4
> > and for writepage the right fix IMHO is to do the reservation of the
> > space.
> 
> This is better in a way because it reclaims the eztra few blocks.  But
> the -ac approach also works for writepage().

yes, it can solve the metadata corruption (assuming the locking is
right, I can as well call ->truncate within writepage but it's not
obvious at all that it won't race because we don't hold the i_sem within
writepage), but the data corruption still holds. I mean, there's no
failure path to notify userspace that a certain page fault is writing
into a page over an hole, that we don't have space to later allocate on
disk. so to me it sounds like MAP_SHARED should preallocate the space of
the holes so you will know that the writes into the MAP_SHARED segments
won't be lost (current state of things will lead to silent corruption
and pinned dirty pages in ram, aka broken allocate on flush like
previously said).

> Why was that code not brought across?

Who developed that code? Can the author of the code forward port it to
2.4.18pre and post a patch to the list so we can review? thanks,
Avoiding the matadata corruption would be a good start at least for 2.4,
then we should just focus on the writepage locking that could race with the
other "create=1" get_blocks. If it doesn't race I will certainly agree
on that approch for 2.4.

Andrea
