Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSEFJEu>; Mon, 6 May 2002 05:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSEFJEt>; Mon, 6 May 2002 05:04:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62359 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314290AbSEFJEr>;
	Mon, 6 May 2002 05:04:47 -0400
Date: Mon, 6 May 2002 05:04:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.13 floppy driver is broken
In-Reply-To: <200205052328.BAA12076@harpo.it.uu.se>
Message-ID: <Pine.GSO.4.21.0205052345560.29064-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 May 2002, Mikael Pettersson wrote:

> There are at least two major problems with drivers/block/floppy.c
> in 2.5.13:
> 
> 1. Writing to /dev/fd0 fails with EROFS from open().
>    The driver's open() method relies on revalidate() having read the
>    first block and sensed whether the floppy is writable or not.
>    But this code was #if:ed out (lines 3883-3903) in 2.5.13, causing
>    open() to think the floppy is write-protected and return -EROFS.
>    Simply removing the #if 0 doesn't work since some of the code
>    in there no longer compiles in 2.5.13.
>    A workaround is to read from /dev/fd0 before writing.

Okaaay...

That answers some of the questions about said code.  
 
> 2. The data written is seriously corrupted. I compared a bzImage
>    written to /dev/fd0 with 2.4.19-pre8 and 2.5.13. The first 9K was Ok,
>    but then 2.5.13 wrote data starting from offset 8K in the input.
>    I checked if the remaining data was simply shifted 1K, but that
>    was not the case: there are other differences (the next one at
>    offset 18K) but I haven't fully analysed the pattern.
>    I suspect there's some kind of block size confusion error.

More likely, misdetected geometry (almost definitely a result of the
same code being commented out).

All right, let's see what can be done.  First of all, the use of getblk()
(actually, emulated bread()) is indeed bogus.  We want to trigger reading
from device; that means either short-circuiting it to call of the actual
code in floppy.c (and I'm _not_ up to that task - after attempt to track
the sequence of events I gave up; too much stuff happening after we
get from ll_rw_blk.c to floppy.c) or allocating a local buffer, bio,
filling it, submitting and waiting for result.

So far, so good, but...  We want floppy to be open and to stay open while
we are doing that.  And floppy_revalidate() does indeed want to be called
only for opened devices.

Unfortunately, further look through the source shows that it's not
guaranteed.  Worse yet, device can get closed under us.

Look: set_geometry() iterates through the drives and if some of them
are currently set to type we are redefining and are opened (have
positive ->fd_ref) - we mark them as changed and call check_disk_change()
for all of them after geometry is redefined.  That certainly makes sense.

check_disk_change() calls bdops->relavidate(), aka. floppy_revalidate().
Again, so far so good.  There we check ->fd_ref again and find to our
satisfaction that it's still opened.  Now we do lock_fdc().  Notice that
at this point we are not holding any locks and lock_fdc() can easily
block.  Woops - whoever had kept that device opened might've closed
it while we slept.

That race, BTW, is common with 2.4 (and I suspect 2.2 as well - I don't
have 2.2 tree around right now).  As far as I can see we need (for 2.4)
to keep pointer to opening block_device along with ->fd_ref (when it's
positive, that is) and bump ->bd_openers (along with ->fd_ref) around
the call of check_disk_change() in set_geometry().  That should take care
of call in check_disk_change() (other callers of check_disk_change() either
do it for device that will stay opened or are for non-floppies).  There
is no direct callers of floppy_revalidate(), so that leaves us with
only one caller - devfs check_disc_changed().

That guy is called from two places - devfs_readdir()->scan_dir_for_removable()
(which, surprisingly, doesn't screw us up, but only because floppy devfs
entries are not marked as removable) and get_removable_partition() (called
only for removable, so we are safe again).  So it looks like set_geometry()
change will be enough...

However, I have a really bad feeling about check_disc_changed() - we are
calling it only with ->i_sem on parent directory (e.g. devfs_lookup() ->
get_removable_partition() -> check_disc_changed()) and I don't see anything
that would stop devfs_unregister() to free devfs_entry from under us;  for
that matter, get_removable_partition() traverses the list of children
without any relevant locks (which would be ->u.dir.lock, from looking at
the code).  Two minutes of grep in devfs/base.c and we are in race country.

Same goes for scan_dir_for_removable(), BTW...

OK, it looks like floppy.c fix is more or less straightforward - I'll do
it when I'll get some sleep.

Devfs is a problem, though.  I _really_ don't like the idea of calling
device methods when we not only didn't complete ->open() but quite possibly
had never called it.  Richard, could you describe the logics in there?
E.g. get_removable_partition() looks rather... arbitrary.

