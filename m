Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273016AbRIITNW>; Sun, 9 Sep 2001 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273015AbRIITNM>; Sun, 9 Sep 2001 15:13:12 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:11024 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273016AbRIITNA>; Sun, 9 Sep 2001 15:13:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: linux-2.4.10-pre5
Date: Sun, 9 Sep 2001 21:19:28 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109091019460.14365-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109091019460.14365-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010909191317Z16475-26183+635@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 07:31 pm, Linus Torvalds wrote:
> On Sun, 9 Sep 2001, Andreas Dilger wrote:
> >
> > I think this fits in with your overall strategy as well - remove the buffer
> > as a "cache" object, and only use it as an I/O object, right?  With this
> > change, all of the cache functionality is in the page cache, and the buffers
> > are only used as handles for I/O.
> 
> Absolutely. It would be wonderful to get rid of the buffer hashes, and
> just replace them with walking the page hash instead (plus walking the
> per-page bh list if we have non-page-sized buffers at non-zero offset). It
> would also clearly make the page cache be the allocation unit and VM
> entity.
> 
> The interesting thing is that once you remove the buffer hash entries,
> there's not a lot inside "struct buffer_head" that isn't required for IO
> anyway.

Let me take inventory here, grouping the fields:

Needed for basic IO functionality:
        atomic_t b_count;               /* users using this block */
        unsigned long b_state;          /* buffer state bitmap (see above) */
        unsigned long b_blocknr;        /* block number */
        unsigned long b_flushtime;      /* Time when (dirty) buffer should be written */
        struct page *b_page;            /* the page this bh is mapped to */
        struct buffer_head *b_reqnext;  /* request queue */
        wait_queue_head_t b_wait;

Can get from mapping:
        unsigned short b_size;          /* block size */
        kdev_t b_dev;                   /* device (B_FREE = free) */
        void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
        struct inode * b_inode;

Not needed with variable page size:
        unsigned short b_size;          /* block size */
        struct buffer_head *b_this_page;/* circular list of buffers in one page */
        char * b_data;                  /* pointer to data block */
        struct list_head b_inode_buffers;   /* doubly linked list of inode dirty buffers */

Could possibly get rid of (with a page cache mapping):
        struct buffer_head *b_next;     /* Hash queue list */
        struct buffer_head **b_pprev;   /* doubly linked list of hash-queue */

Used by raid, loop and highmem, could move to request struct:
        void *b_private;                /* reserved for b_end_io */

Should die:
        kdev_t b_rdev;                  /* Real device */
        unsigned long b_rsector;        /* Real buffer location on disk */
        struct buffer_head *b_next_free;/* lru/free list linkage */
        struct buffer_head *b_prev_free;/* doubly linked list of buffers */

(Note b_size appears twice in the list above.)  So it's about evenly split
between fields we needed even if the buffer just becomes an IO tag, and
fields that could be gotten rid of.  The b_wait field could go since we're
really waiting on an IO request, which has its own wait field.

> Maybe we could do without bh->b_count, but it is at least
> currently required for backwards compatibility with all the code that
> thinks buffer heads are autonomous entities. But I actually suspect it
> makes a lot of sense even for a stand-alone IO entity (I'm a firm believer
> in reference counting as a way to avoid memory management trouble).

Maybe.  We might be able to tell from the state flags and the page use count
that the buffer head is really freeable.

> The LRU list and page list is needed for VM stuff, and could be cleanly
> separated out (nothing to do with actual IO). Same goes for b_inode and
> b_inode_buffers.

We can easily get rid of b_inode, since it's in the page->mapping.

> And b_data could be removed, as the information is implied in b_page and
> the position there-in, but at the same time it's probably useful enough
> for low-level IO to leave.
>
> So I'd like to see this kind of cleanup, especially as it would apparently
> both clean up a higher-level memory management issue _and_ make it much
> easier to make the transition to a page-cache for the user accesses (which
> is just _required_ for mmap and friends to work on physical devices).
> 
> Dan, how much of this do you have?

Working code?  Just the page cache version of ext2_getblk in the directory
indexing patch.  This seems to have worked out fairly well.  Though Al
finds it distasteful on philosophical grounds it does seem to be a pragmatic
way to cut through the current complexity, and combines well with Al's
straight-up page cache code without apparent breakage.

I have put considerable thought into how to move all the rest of the
remaining Ext2 buffer code into page cache, but this is still at the design
stage.  Most of it is easy: group descriptors, block/inode bitmaps,
superblocks.  The hard part is ext2_get_block and specifically the indirect
blocks, if we want "page cache style" usage and not just transplanted
buffer-style coding.  I've started on this but don't have working code yet.

One observation: the buffer hash link is currently unused for page cache
buffers.  We could possibly use that for reverse mapping from logical inode
blocks to physical device blocks, to combat aliasing.  A spin-off benefit
is, the same mechanism could be used to implement a physical readahead
cache which can do things that logical readahead can't.  For example, it
could do readahead through a group of small files without knowing anything
about the metadata, which we might not have read yet.

--
Daniel
