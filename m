Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSDVG2X>; Mon, 22 Apr 2002 02:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSDVG2W>; Mon, 22 Apr 2002 02:28:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9477 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314067AbSDVG2V>;
	Mon, 22 Apr 2002 02:28:21 -0400
Message-ID: <3CC3AD8C.630D4B74@zip.com.au>
Date: Sun, 21 Apr 2002 23:28:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: updated writeback patches for 2.5.8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This code is working satisfactorily now.

ext2, the three modes of ext3 and reiserfs are solid.  JFS has also
been tested - had a bit of a problem with JFS under heavy load, but
that appears to be unrelated to these changes.  The loop driver
is much, much happier.  The ramdisk driver is very sick, but that
is not due to these changes:

# mke2fs /dev/ram0
# mount /dev/ram0 /mnt/ram0
# cp -a /usr/src/dbench /mnt/ram0
# umount /mnt/ram0
# e2fsck -fy /dev/ram0		--->>  many, many errors

Minix and sysvfs are broken - fixing those will happen shortly (there
doesn't seem to be a mkfs.sysv.  Help.)

It's a very big patch.  That is pretty unavoidable - a large chunk of
kernel functionality has been removed and new mechanisms (which are
largely just a revamp of the existing ones) were put in its place.

There's a *ton* of stuff still to be done.  Smaller patches,
fortunately.  It would help if anyone who reviews these changes could
check my todo list before larting me - it's probably already in the
plans.

I haven't done much benchmarking at all - a number of design changes
still need to be made before tuning and smoothing is appropriate.
And, really, some VM decisions need to be made.  Generally, throughput
seems to be improved.

At http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/ the following
files may be found:

ttd

  The 86-entry todo list.

pagecache-screwup.patch

  Fix ratcache locking bug.

per-cpu-pages.patch

  Fun hack to amortise zone_t.lock costs for Anton's testing. 
  Not really being proposed for inclusion, but it works well.

dallocbase-10-page_alloc_fail.patch

  Debug stuff.

dallocbase-35-pageprivate_fixes.patch

  Fix JFS compilation

dallocbase-55-ext2_dir.patch

  Teach ext2 to not use directory data outside i_size

dallocbase-60-page_accounting.patch

  Global locked and dirty page accounting

ratcache-pf_memalloc.patch

  Make the rat not consume all memory on the swapout path.

mempool-node.patch

  Make mempool not alter the objects which it is managing

readahead-fixes.patch

  Allow zero-length readahead, make readahead initialisation sane.

unplug-fix.patch

  Might fix a lockup which I observed a single time in a week's heavy
  thrashing.  Everything died; a process was stuck in
  get_request_wait() while holding fs locks.  There were many
  outstanding requests.  Why had I/O not been started?  I assume it was
  a missing unplug.  Very, very, very hard to reproduce.

dallocbase-70-writeback.patch

  The core writeback stuff.  Removes the buffer LRU and hash table,
  implements address_space-based writeback.

  Splits half of fs/inode.c into fs/fs-writeback.c.
  Moves most of the page flag handling out of mm.h into page-flags.h
  address_space writeback functions in mm/page-writeback.c

dallocbase-80-unused_list.patch

  Remove the buffer unused_list, replace with a mempool.


The rest hasn't been tested in two weeks and is probably busted:

dalloc-10-syncalloc_ext3.patch
dalloc-20-syncalloc_ext2.patch

  Turn on multipage VM writeback for ext2, ext3.

dalloc-30-dellalloc_core.patch

  Delayed allocate core

dalloc-40-ext2.patch

  Implement delayed allocation in ext2

mpage-10-biobits.patch

  BIO support for multipage writeback and readahead

mpage-20-core.patch

  Multipage I/O core

mpage-30-ext2.patch

  Multipage for ext2

mpage-40-ext3.patch

  Teach ext3 about generic_writeback_mapping() interface change.

tuning-10-request.patch

  get_request() starvation fix.

tuning-20-ext2-preread-inode.patch

  ext2 tuning.

tuning-30-read_latency.patch

  Disk read latency hacks.
