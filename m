Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312799AbSDKTG1>; Thu, 11 Apr 2002 15:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312828AbSDKTG0>; Thu, 11 Apr 2002 15:06:26 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:57872 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312799AbSDKTGZ>; Thu, 11 Apr 2002 15:06:25 -0400
Message-ID: <3CB5D030.D98A4626@zip.com.au>
Date: Thu, 11 Apr 2002 11:04:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Suparna Bhattacharya <suparna@in.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [brokenpatch] page accounting
In-Reply-To: <3CB41BA7.DAC3A785@zip.com.au> <3CB5A82B.80C942A0@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> 
> > +#define PG_slab                         8      /* kill me if needed: slab debug */
> 
> A little plea for mercy for this tiny bit :)

Sure, I'll update the comment.

Things are getting a *little* squeezy in the page->flags
department.  The zone takes eight, and of the remaining
24, I'm showing 18 used up.  A couple of these can be
recycled easily.  I added two to support delayed allocate:

PG_disk_reserved: page has a disk-reservation
PG_space_reclaim: icky hack to avoid deadlocking when
                  writeback is forced to collapse outstanding
                  reservations.


A number of the reasons for delalloc are going away now;
we'll be able to do multipage bio-based writeback and
readahead for the map-at-prepare_write buffer-based
filesystems.   We'll see.

Updated patchset is at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8-pre3/
It hasn't quite recovered from the changed buffer/page
relationship yet - a heavy dbench run on 1k blocksize ext2
dies after half an hour over a page which didn't come unlocked.

- Went back to open-coded per-CPU page accumulators.  I
  stared at the assembly for some time and it looked OK,
  so I'm not sure what went wrong with the `percpu' version.
  I'll have another shot later.

- Split fs/fs-writeback.c out from fs/inode.c.  These are
  all the functions related to sending bulk file data to
  storage.  fs/inode.c contains the inode writeback code,
  the hashing, all the other stuff involved with manipulating
  the state of in-core inodes.

  I think this is a reasonable splitup - it makes the diff
  more readable too...

- include/linux/writeback.h is for communication between
  fs/fs-writeback.c, mm/page-writeback.c and fs/inode.c

- Lots more changes to fs/buffer.c; many of them pointless
  cleanups and shuffling functions around and documenting
  stuff.

- Documenting the VM/fs locking ordering rules, slowly.

- The locking between __set_page_dirty_buffers(),
  try_to_free_buffers() and the functions which attach
  buffers to pages is coming together.  This exclusion
  is needed to preserve the buffer-page relationship
  which has been proposed.

  It would be a ton easier and cleaner if set_page_dirty
  was called under the page lock, but that's rather hard
  to arrange.  Maybe that would be a better approach.

- We need to talk wli into doing a hashed wakeup for the
  buffer layer.  Then buffer_head will be:

struct buffer_head {
        sector_t b_blocknr;             /* block number */
        unsigned short b_size;          /* block size */
        kdev_t b_dev;                   /* device (B_FREE = free) */
        struct block_device *b_bdev;
        atomic_t b_count;               /* users using this block */
        unsigned long b_state;          /* buffer state bitmap (see above) */
        struct buffer_head *b_this_page;/* circular list of buffers in one page */
        char * b_data;                  /* pointer to data block */
        struct page *b_page;            /* the page this bh is mapped to */
        void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
        void *b_private;                /* reserved for b_end_io */
        struct list_head     b_inode_buffers;   /* doubly linked list of inode dirty buffers */
};

I suspect we can also remove b_dev, maybe b_size, conceivably
b_data.

-
