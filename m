Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273107AbRIJAQB>; Sun, 9 Sep 2001 20:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRIJAPv>; Sun, 9 Sep 2001 20:15:51 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:45065 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273107AbRIJAPi>; Sun, 9 Sep 2001 20:15:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 02:23:11 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109091615570.22033-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109091615570.22033-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 01:24 am, Linus Torvalds wrote:
> On Sun, 9 Sep 2001, Daniel Phillips wrote:
> >
> > Needed for basic IO functionality:
> >         atomic_t b_count;               /* users using this block */
> >         unsigned long b_state;          /* buffer state bitmap (see above) */
> >         unsigned long b_blocknr;        /* block number */
> >         unsigned long b_flushtime;      /* Time when (dirty) buffer should be written */
> >         struct page *b_page;            /* the page this bh is mapped to */
> >         struct buffer_head *b_reqnext;  /* request queue */
> >         wait_queue_head_t b_wait;
> >
> > Can get from mapping:
> >         unsigned short b_size;          /* block size */
> 
> No.
> 
> Don't fall into the trap of thinking that blocksizes are constant for a
> mapping.
> 
> Yes, they are _right_now_, if only because of limitations of the old
> buffer cache. But it's very very wrong to think you can get the buffer
> size from the mapping.

Well, I'm happy enough to get this far down the list before getting the first
Bzzt.  But why do you think we need different blocks sizes in the same 
mapping?  Maybe NTFS is bizarre enough to need that, but then why not just 
have special mappings for the "misc" sizes?

> Besides - we want to be able to do IO _without_ any mappings at all. The
> "iobuf" thing should be completely mapping-independent, in case somebody
> wants to just do raw IO.
> 
> Which means that these two:
> 
> >         kdev_t b_dev;                   /* device (B_FREE = free) */
> >         void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
> 
> also have to be in the iobuf anyway, quite regardless of any other issues.
> 
> > Could possibly get rid of (with a page cache mapping):
> >         struct buffer_head *b_next;     /* Hash queue list */
> >         struct buffer_head **b_pprev;   /* doubly linked list of hash-queue */
> 
> Absolutely.
> 
> > Used by raid, loop and highmem, could move to request struct:
> >         void *b_private;                /* reserved for b_end_io */
> 
> No. We only have one request struct, and we can have hundreds of buffers
> associated with it. This is very much a iobuf thing.

Yes, duh.

> > Should die:
> >         kdev_t b_rdev;                  /* Real device */
> >         unsigned long b_rsector;        /* Real buffer location on disk */
> 
> No - these are what all the indirect IO code uses.

They're still warts.  It would be nice if the various block remappers could
provide their own pool of remapping structs.  Note that bounce buffers are
never in the page cache, so there are a 

> 
> >         struct buffer_head *b_next_free;/* lru/free list linkage */
> >         struct buffer_head *b_prev_free;/* doubly linked list of buffers */
> 
> Right now we keep the dirty list in these. We should drop it eventually,
> and just every time we mark a buffer dirty we also mark the page dirty,
> and then we use the _real_ dirty lists (which are nicely per-inode etc).
> 
> > > Maybe we could do without bh->b_count, but it is at least
> > > currently required for backwards compatibility with all the code that
> > > thinks buffer heads are autonomous entities. But I actually suspect it
> > > makes a lot of sense even for a stand-alone IO entity (I'm a firm believer
> > > in reference counting as a way to avoid memory management trouble).
> >
> > Maybe.  We might be able to tell from the state flags and the page use count
> > that the buffer head is really freeable.
> 
> I doubt it. Almost all data structures that are reachable many ways need
> to have a _count_.
> 
> People who think that locking is a way of "pinning" data structures are
> invariably wrong, stupid, and need to get spanked. Reference counts rule.

I didn't want to get rid of it, it's in line with how all the other objects
are handled.  It's robust.

> > > Dan, how much of this do you have?
> >
> > Working code?  Just the page cache version of ext2_getblk in the directory
> > indexing patch.
> 
> Which is probably fine - we could replace the existing getblk with it, and
> do only minor fixups. Maybe.

Yep, maybe.  Christoph was looking at trying this idea with vxfs, I should
ping him on that.

> > One observation: the buffer hash link is currently unused for page cache
> > buffers.  We could possibly use that for reverse mapping from logical inode
> > blocks to physical device blocks, to combat aliasing.
> 
> That still assumes that we have to look them up, which I'd rather avoid.
> Also, I'd rather get rid of the buffer hash link completely, instead of
> making it more confusing..

Just to start you thinking...
 
> >						  A spin-off benefit
> > is, the same mechanism could be used to implement a physical readahead
> > cache which can do things that logical readahead can't.
> 
> Considering that 99.9% of all disks do this on a lower hardware layer
> anyway, I very much doubt it has any good properties to make software more
> complex by having that kind of readahead in sw.

Well, I already wrote a longer screed on the subject for your Sunday night
reading pleasure ;-)

--
Daniel
