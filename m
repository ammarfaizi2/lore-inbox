Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310272AbSCAIcU>; Fri, 1 Mar 2002 03:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310403AbSCAIak>; Fri, 1 Mar 2002 03:30:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310388AbSCAI2R>;
	Fri, 1 Mar 2002 03:28:17 -0500
Message-ID: <3C7F3B4A.41DB7754@zip.com.au>
Date: Fri, 01 Mar 2002 00:26:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] delayed disk block allocation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A bunch of patches which implement allocate-on-flush for 2.5.6-pre1 are
available at

  http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-10-core.patch
  - Core functions
and
  http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-20-ext2.patch
  - delalloc implementation for ext2.

Also,
  http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6-pre1/dalloc-30-ratcache.patch
  - Momchil Velikov/Christoph Hellwig radix-tree pagecache ported onto delalloc.


With "allocate on flush", (aka delayed allocation), file data is
assigned a disk mapping when the data is being written out, rather than
at write(2) time.  This has the following advantages:

- Less disk fragmentation

  - By deferring writeout, we can send larger amounts of data into
    the filesytem, which gives the fs a better chance of laying the
    blocks out contiguously.

    This defeats the current (really bad) performance bug in ext2
    and ext3 wherein the blocks for two streaming files are
    intermingled in AAAAAAAABBBBBBBBAAAAAAAABBBBBBBB manner (ext2) and
    ABABABABAB manner (ext3).

  - Short-lived files *never* get a disk mapping, which prevents
    them from fragmenting disk free space.

- Faster

  - Enables complete bypass of the buffer_head layer (that's the
    next patch series).

  - Less work to do for short-lived files

- Unifies the handling of shared mappings and write(2) data.


The patches as they stand work fine, but they enable much more.  I'd be
interested in hearing some test results of this plus the mpio patch on
big boxes.

Delayed allocate for ext2 is turned on with the `-o delalloc' mount
option.  Without this, nothing much has changed (well, things will be a
bit faster, but not much).

The `MPIO_DEBUG' define in mm.h should be set to zero prior to running
any benchmarking.


There is a reservation API by which the kernel tells the filesystem to
reserve space for the delalloc page.  It is completely impractical to
perform exact reservations for ext2, at least.  So what the code does
is to take worst-case reservations based on the page's file offset, and
to force a writeback when ENOSPC is encountered.  The writeback
collapses all existing reservations into real disk mappings.  If we're
still out of space, we're really out of space.  This happens within
delalloc_prepare_write() at present.  I'll be moving it elsewhere soon.

There are new writeback mechanisms - an adaptively-sized pool of
threads called "pdflush" is available for writeback.  These perform the
kupdate and bdflush function for dirty pages.  They are designed to
avoid the situation where bdflush gets stuck on a particular device,
starving writeout for other devices.  pdflush should provide increased
writeout bandwidth on many-disk machines.

There are a minimum of two instances of pdflush.  Additional threads
are created and destroyed on-demand according to a
simple-but-seems-to-work algorithm, which is described in the code.

The pdflush threads are used to perform writeback within shrink_cache,
thus making kswapd almost non-blocking.

Global accounting of locked and dirty pages has been introduced.  This
permits accurate writeback/throttle decisions in balance_dirty_pages().
Testing is showing considerable improvements in system tractability
under heavy load, while approximately doubling heavy dbench throughput.
Other benchmarks are pretty much unchanged, apart from those which are
affected by file fragmentation, which show improvement.

With this patch, writepage() is still using the buffer layer, so lock
contention will still be high.

A few performance glitches in the dirty-data writeout path have been
fixed.

The PG_locked and PG_dirty flags have been renamed to prevent people
from using them, which would bypass locked- and dirty-page accounting.

A number of functions in fs/inode.c have been renamed.  We have a huge
and confusing array of sync_foo() functions in there.  I've attempted
to differentiate between `writeback_foo()', which starts I/O, and
`sync_foo()', which starts I/O and waits on it.  It's still a bit of a
mess, and needs revisiting.

The ratcache patch removes generic_buffer_fdatasync() from the kernel. 
Nothing in the tree is using it.

Within the VM, the concept of ->writepage() has been replaced with the
concept of "write back a mapping".  This means that rather than writing
back a single page, we write back *all* dirty pages against the mapping
to which the LRU page belongs.

  Despite its crudeness, this actually works rather well.  And it's
  important, because disk blocks are allocated at ->writepage time, and
  we *need* to write out good chunks of data, in ascending file offset
  order so that the files are laid out well.  Random page-at-a-time
  sprinkliness won't cut it.

  A simple future refinement is to change the API to be "write back N
  pages around this one, including this one".  At present, I'll have to
  pull a number out of the air (128 pages?).  Some additional
  intelligence from the VM may help here.

  Or not.  It could be that writing out all the mapping's pages is
  always the right thing to do - it's what bdflush is doing at present,
  and it *has* to have the best bandwidth.  But it may come unstuck
  when applied to swapcache.


Things which must still be done include:

- Closely review the ratcache patch.  I fixed several fairly fatal
  bugs in it, and it works just fine now.  But it seems I was working
  from an old version.  Still, it would benefit from a careful
  walkthrough.  This version might be flakey in the tmpfs/shmfs area.

- Remove bdflush and kupdate - use the pdflush pool to provide these
  functions.

- Expose the three writeback tunables to userspace (/proc/sys/vm/pdflush?)

- Use pdflush for try_to_sync_unused_inodes(), to stop the keventd
  abuse.

- Move the page_cache_size accounting into the per-cpu accumulators.

- Use delalloc for ext2 directories and symlinks.

- Throttle tasks which are dirtying pages via shared mappings.

- Make preallocation and quotas play together.

- Implement non-blocking try_to_free_buffers in the VM for buffers
  against delalloc filesystems.

  Overall system behaviour is noticeably improved by these patches,
  but memory-requesters can still occasionally get blocked for a long
  time in sync_page_buffers().  Which is fairly pointless, because the
  amount of non-dirty-page memory which is backed by buffers is tiny. 
  Just hand this work off to pdflush if the backing filesystem is
  delayed-allocate.

- Verify that the new APIs and implementation are suitable for XFS.

- Prove the API by implementing delalloc on other filesystems.

  Looks to be fairly simple for reiserfs and ext3.  But implementing
  multi-page no-buffer_head pagecache writeout will be harder for these
  filesystems.


Nice-to-do things include:

- Maybe balance_dirty_state() calculations for buffer_head based
  filesystems can take into account locked and dirty page counts to
  make better flush/throttling decisions.

- Turn swap space into a delayed allocate address_space.  Allocation
  of swapspace at ->writepage() time should provide improved swap
  bandwidth.

- Unjumble the writeout order.

  In the current code (as in the current 2.4 and 2.5 kernels), disk
  blocks are laid out in the order in which the application wrote(2)
  them.  So files which are created by lseeky applications are all
  jumbled up.

  I can't really see a practical solution for this in the general
  case, even with radix-tree pagecache.  And it may be that we don't
  *need* a solution, because it'll often be the case that the read
  pattern for the file is also lseeky.

  But when the "write some pages around this one" function is
  implemented, it will perform this unjumbling.  It'll be OK to
  implement this by probing the pagecache, or by walking the radix
  tree.

- Don't perform synchronous I/O (reads) inside lock_super() on ext2. 
  Massive numbers of threads get piled up on the superblock lock when
  using silly workloads.
