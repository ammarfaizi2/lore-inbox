Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310426AbSCLGDB>; Tue, 12 Mar 2002 01:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCLGCw>; Tue, 12 Mar 2002 01:02:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44305 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310426AbSCLGCp>;
	Tue, 12 Mar 2002 01:02:45 -0500
Message-ID: <3C8D9999.83F991DB@zip.com.au>
Date: Mon, 11 Mar 2002 22:00:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[  Does anyone know what "CFT" means?  It means "call for testers".  It
   doesn't mean "woo-hoo, it'll be neat when that's merged <delete>".  It means
   "help, help - there's no point in just one guy testing this" (thanks Randy). ]


This is an update of the delayed-allocation and multipage pagecache I/O
patches.  I'm calling this a beta, because it all works, and I have
other stuff to do for a while.

Of the thirteen patches, seven (dallocbase-* and tuning-*) are
applicable to the base 2.5.6 kernel.

You need to mount an ext2 filesystem with the `-o delalloc' mount
option to turn on most of the functionality.

The rolled up patch is at

	http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/everything.patch.gz


These patches do a ton of stuff.  Generally, the CPU overhead for filesystem
operations is decreased by about 40%.  Note "overhead": this is after factoring
out the constant copy_*_user overhead.  This translates to a 15-25% reduction
in CPU use for most workloads.

All the benchmarks are increased, to varying degrees.  Best case is two
instances of `dbench 64' against different disks which went from 7
megabytes/sec to 25.  This is due to better write layout patterns, avoidance of
synchronous reads in the writeback path, better memory management and better
management of writeback threads.


The patch breakdown is:

dallocbase-10-readahead

  Unifies the current three readahead functions (mmap reads, read(2) and
  sys_readhead) into a single implementation.

  More aggressive in building up the readahead windows.

  More conservative in tearing them down.

  Special start-of-file heuristics.

  Preallocates the readahead pages, to avoid the (never demonstrated, but
  potentially catastrophic) scenario where allocation of readahead pages causes
  the allocator to perform VM writeout.

  {hidden agenda): Gets all the readahead pages gathered together in one
  spot, so they can be marshalled into big BIOs.

  Reinstates the readahead tuning ioctls, so hdparm(8) and blockdev(8) are
  working again.  The readahead settings are now per-request-queue, and the
  drivers never have to know about it.

  Big code cleanup.

  Identifies readahead thrashing.

    Currently, it just performs a shrink on the readahead window when thrashing
    occurs.  This greatly reduces the amount of pointless I/O which we perform,
    and will reduce the CPU load.  The idea is that the readahead window
    dynamically adjusts to a sustainable size.  It improves things, but not
    hugely, experimentally.

    We really need drop-behind for read and write streams.  Or O_STREAMING,
    indeed.

dallocbase-15-pageprivate

  page->buffers is a bit of a layering violation.  Not all address_spaces
  have pages which are backed by buffers.

  The exclusive use of page->buffers for buffers means that a piece of prime
  real estate in struct page is unavailable to other forms of address_space.

  This patch turns page->buffers into `unsigned long page->private' and sets
  in place all the infrastructure which is needed to allow other address_spaces
  to use this storage.

  With this change in place, the multipage-bio no-buffer_head code can use
  page->private to cache the results of an earlier get_block(), so repeated
  calls into the filesystem are not needed in the case of file overwriting.

dallocbase-20-page_accounting

  This patch provides global accounting of locked and dirty pages.  It does
  this via lightweight per-CPU data structures.  The page_cache_size accounting
  has been changed to use this facility as well.

  Locked and dirty page accounting is needed for making writeback and
  throttling decisions in the delayed-allocation code.

dallocbase-30-pdflush

  This patch creates an adaptively-sized pool of writeback threads, called
  `pdflush'.  A simple algorithm is used to determine when new threads are
  needed, and when excess threads should be reaped.

  The kupdate and bdflush kernel threads are removed - the pdflush pool is
  used instead.

  The (ab)use of keventd for writing back unused inodes has been removed -
  the pdflush pool is now used for that operation.

dalloc-10-core

  The core delayed allocation code.  There's a description in the
  dalloc-10-core.patch file (all the patches have descriptions).

dalloc-20-ext2

  Implements delayed allocation for ext2.

dalloc-30-ratcache

  The radix-tree pagecache patch.

mpage-10-biobits

  Little API extensions in the BIO layer which were needed for building the
  pagecache BIOs.

mpage-20-core

  The core multipage I/O layer.

  This now implements multipage BIO reads into the pagecache.  Also caching
  of get_block() results at page->private.

  The get_block() result caching currently only applies if all of a page's
  blocks are laid out contiguously on disk.  Caching of a discontiguous list of
  blocks at page->private is easy enough to do, but would require a memory
  allocation, and the requirement is so rare that I didn't bother.

mpage-30-ext2

  Implements multipage I/O for ext2.

tuning-10-request

  get_request() fairness for 2.5.x.  Avoids the situation where a thread
  sleeps for ages on the request queue while other threads whizz in and steal
  requests which they didn't wait for.

tuning-20-ext2-preread-inode

  When we create a new inode, preread its backing block.

  Without this patch, many-inode writeout gets seriously stalled by having to
  read many individual inode table blocks.

tuning-30-read_latency

  read-latency2, ported from 2.4.  Intelligently promotes reads ahead of
  writes on the request queue, to prevent reads from being stalled for very
  long periods of time.

  Also reinstates the BLKELVGET and BLKELVSET ioctls, so `elvtune' may be
  used in 2.5.

  Also increases the size of the request queues, which allows better request
  merging.  This is acceptable now that reads are not heavily penalised by a
  large queue.


-
