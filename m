Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282131AbRK1MV0>; Wed, 28 Nov 2001 07:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283017AbRK1MVG>; Wed, 28 Nov 2001 07:21:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15115 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282131AbRK1MUZ>;
	Wed, 28 Nov 2001 07:20:25 -0500
Date: Wed, 28 Nov 2001 13:20:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: bio write-up (was: Re: 2.5.1-pre2 does not compile)
Message-ID: <20011128132000.T23858@suse.de>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27 2001, Linus Torvalds wrote:
> 
> On Wed, 28 Nov 2001, Paul Mackerras wrote:
> >
> > Is there a description of the new block layer and its interface to
> > block device drivers somewhere?  That would be helpful, since Ben
> > Herrenschmidt and I are going to have to convert several
> > powermac-specific drivers.
> 
> Jens has something written up, which he sent to me as an introduction to
> the patch. I'll send that out unless he does a cleaned-up version, but I'd
> actually prefer for him to do the sending. Jens?

Ok, here's the stuff I sent Linus + some extra comments on how exactly
it differs for stuff like drivers.

--->
o io_request_lock removal. it's completely gone, although lots of SCSI
drivers still need to be fixed (with it gone they break during compile
though, which is what we want). locking is per-queue (q->queue_lock),
the locking semantics are the same though (locking is still imposed by
the block layer, grabbing the lock before request_fn execution -- I want
to keep it this way, because it means we can leave lots of older drivers
alone and they will automagically be SMP safe still. clever drivers are
free to drop the queue lock whenever they want, of course).

SCSI mid layer is in an ok state, low level drivers that currently work
are sym, sym2, aic7xxx_old, and aic7xxx. IDE should be completely ok,
basically it relies on a new ide_lock to keep the same serialization
that it currently has. Keeping a couple of disks busy in IDE didn't show
this as being a big bottleneck at all, I guess we can later optimize
this if we really want... The "other" block drivers like DAC960,
cpqarray, and cciss are fixed too although at least DAC960 may have
multi-page bio quirks. Not a big deal at this point since only raw I/O
is the user that.


o main unit of I/O is the bio, not the buffer_head. this is the really
major change that requires updates to basically all block drivers. the
exception are drivers that only reference CURRENT and CURRENT->buffer
for transfers (hence forth called "old-style drivers", they will still
work as usual. Any driver that currently traverse segments in a request
must be updated.

A bio has no virtual mapping of the data at all. This basically forces
highmem support on drivers, at least it is no different than doing low
memory I/O which is what I think matters. Of course bounce limits can be
set by the driver. A bio looks like this:

struct bio {
	sector_t		bi_sector;
	struct bio		*bi_next;	/* request queue link */
	atomic_t		bi_cnt;		/* pin count */
	kdev_t			bi_dev;		/* will be block device */
	struct bio_vec_list	*bi_io_vec;
	unsigned long		bi_flags;	/* status, command, etc */
	unsigned long		bi_rw;		/* bottom bits READ/WRITE,
						 * top bits priority
						 */
	int (*bi_end_io)(struct bio *bio, int nr_sectors);
	void			*bi_private;

	void (*bi_destructor)(struct bio *);	/* destructor */
};

Most of the above is self-explanatory, so I'll just brief you on some of
the differences from buffer_head. bi_io_vec is the actual io vector,
it's composed of these:

struct bio_vec {
	struct page	*bv_page;
	unsigned int	bv_len;
	unsigned int	bv_offset;
};

struct bio_vec_list {
	unsigned int	bvl_cnt;	/* how may bio_vec's */
	unsigned int	bvl_idx;	/* current index into bvl_vec */
	unsigned int	bvl_size;	/* total size in bytes */
	unsigned int	bvl_max;	/* max bvl_vecs we can hold, used
					   as index into pool */
	struct bio_vec	bvl_vec[0];	/* the iovec array */
};

The main reason for doing an array like this is that it enables easy
pre-clustering of pages for I/O submission. Stuff like read_cluster, raw
I/O, O_DIRECT etc can queue nice big portions of pages at once. And XFS
will really like it too. Also, the vm can pre-alloc a bio + veclist and
do it's own merging if it wants to (again XFS, I know they do this on
Irix (well sort of, pass it down differently, the merging at the vm
layer is what I'm comparing it to)). The I/O scheduler still uses
bi_next to singly link merges at that level.

The end_io callback now has a number of sectors argument, basically so
we don't have to loop around ending requests. No uptodate flag is passed
down, all that can be fitted in the bi_flags now. One bit of completion
info was never enough anyways.

bi_desctructor is only there because a bio can originate from different
sources. Normally it will be gotten with bio_alloc(int gfp_mask, int
nr_iovecs) and the default destructor frees the necessary things on I/O
completion. A bio may come from other sources though, or it may be a
cloned or even a copied bio (ie loop can clone or copy a bio (similar to
network skb stuff) with bio_clone/bio_copy), or maybe someone using just
kmalloc for allocating the bio.

Traversal of data segments in a request becomes even more hairy at this
point though, since a request still holds a list of bios which in turn
can hold a map of segments. I've always thought that drivers had to
initimate knowledge of how that works though, so I've moved this to
something like:

	rq_for_each_bio(bio, rq)
		bio_for_each_segment(bio_vec, bio, i)
			/* bio_vec is now current segment */

which I think we should have had a long time ago. Then we are also free
to change the implementation details later without having to change
drivers again :-). I should mention that ll_rw_blk provides a
blk_rq_map_sg helper to map a struct request to a scatterlist, so we can
rip the scatterlist build out of a lot of drivers. They can simply do

	nr_segments = blk_rq_map_sg(q, rq, scatterlist);

I can say a lot more about the bio stuff, but it's probably better if
you just start with commenting/flaming the above and we can go from
there :-). I'll move on to a few more things...

o head active queues are a thing of the past. We never should have
exposted the list implementation of requests to the drivers -- I've
changed this so drivers merely do

	rq = elv_next_request(q);

which is the next request that the I/O scheduler thinks should be
handled. That enables us to easily mark requests as active or not, so
the elevator knows not to touch it. Then this head-active crap is
handled transparently instead. Also, it enables us to mark more than the
first request as untouchable, something we've needed for a while.

...

I'll finish off for now with a status... Basically the tree is stable
for IDE and the SCSI stuff listed, same with cpqarray etc. loop probably
needs a bit of fixing, but not much. O_DIRECT is currently a kludge, the
kio blocks/bh stuff is a MESS that needs resolving real soon! Raw I/O is
almost there too, we can pull lots of megs/sec with very little sys time
now.

...

<---

Now, I guess what others are mainly interested in is either a) design of
this stuff or b) what to look out for when converting drivers. Wrt a),
read the source :-). For b, read on.

If you are maintaing and old-style driver that just uses CURRENT and
ignores clustered requests, you should be alright and not need any
changes. Maybe you are dropping the io_request_lock from your request_fn
strategy, if so then just replace that with &q->queue_lock instead. The
generic layer will automatically handle clustered requests, multi-page
bios, etc for you. For a low performance driver or hardware that is PIO
driven or just doesn't support scatter-gather, you can stop reading now.

Lets start by looking at how we transferred data in the 2.4 kernels.
There are two structures you need to know about. The first is the
buffer_head, this is the I/O "atom". For a block driver, the relevant
parts of this struct is:

	unsigned long b_rsector;	/* where */
	kdev_t b_rdev;			/* who */

	char *b_data;			/* what */

	struct buffer_head *b_reqnext;	/* next buffer */

and that is basically it. b_rsector is offset from b_rdev which includes
minor stuff for partitions. b_data is the virtual mapping of the buffer
that wants to be read or written. actually, b_data is the virtual
mapping og b_page and a possible offset, but now we are already getting
into 2.4 + block-highmem or 2.5 land. b_reqnext is the next pointer to a
chain of buffer_heads.

Most real-hardware (ie not loop, raid, rd, etc) don't receive the
buffer_heads directly though. Instead they receive a list of struct
requests to handle. struct request contains lots of house keeping info,
the interesting part again for block drivers are:

	unsigned long sector;		/* like b_rsector */
	unsigned long nr_sectors;	/* total number of sectors */
	unsigned long current_nr_sectors; /* "current" ditto of above */
	unsigned int nr_segments;

	char *buffer;			/* like b_data */
	struct buffer_head *bh;		/* first bh in request */
	struct buffer_head *bhtail;	/* last bh in request */

So struct request ties a list of buffer_heads together for handing to
the driver. Performance hardware usually builds a scatter-gather list of
these chunks and sends it off to the driver. nr_sectors contains the
total size of all the buffer_heads linked to the request,
current_nr_sectors only the size of the currently first bh in the list
(ie rq->bh). When I/O is ended on a request, the buffer_heads are pealed
off the list as I/O on them completes.

Now lets take a look at how 2.5 does this differently. Struct
buffer_head now has no relevance for block drivers, it's purely a buffer
cache thing. Instead we deal with struct bio, which I explained the
layout of earlier in this mail. Struct request is basically the same,
except that now we link bio and biotail into it. For a sane block
driver, the request handling loop with bio will look something like:

	do {
		struct request *rq = elv_next_request(q);
		struct scatterlist *sg;
		struct my_driver_cmd *cmd;
		int nr_segments;

		/*
		 * no more to handle
		 */
		if (!rq)
			break;

		blkdev_dequeue_request(rq);

		/*
		 * for queuing, otherwise you will probably just
		 * have a sg structure allocated at init time (see ide)
		 */
		sg = my_driver_alloc_sg(rq->nr_segments);

		/*
		 * block layer helper to map a struct request into
		 * a scatter-gather list
		 */
		nr_segments = blk_rq_map_sg(q, rq, sg);		

		cmd = my_driver_alloc_cmd();

		/*
		 * init hardware command with data direction and sg list
		 */
		my_driver_setup_cmd(cmd, rq->cmd, sg);
		my_driver_queue_cmd(cmd);
	} while (1);

You are free to loop through the request segments yourself using the
technique described higher up of course, however I recommend using the
blk_rq_map_sg helper to handle the grunt of the mapping work. That will
(probably :-) also help you out later if the internals are changed
again.

blk_rq_map_sg will look at several queue properties to handle stuff
like:

- cluster contigious segments into one, if wanted (QUEUE_FLAG_CLUSTER)
- don't allow a clustered segment to cross a 4GB mem boundary
- don't build bigger segments than q->max_segment_size

and probably more.

Other changes that may affect you:

New queue property settings:

	blk_queue_bounce_limit(q, u64 dma_address)
		Enable I/O to highmem pages, dma_address being your
		limit. No highmem default.

	blk_queue_max_sectors(q, max_sectors)
		Maximum size request you can handle in units of 512 byte
		sectors. 255 default.

	blk_queue_max_segments(q, max_segments)
		Maximum segments you can handle in a request. 128
		default.

	blk_queue_max_segment_size(q, max_seg_size)
		Maximum size of a clustered segment, 64kB default.

New queue flags:

	QUEUE_FLAG_NOSPLIT
		can handle a bio with more than one segment. ll_rw_blk
		will split bigger bio's for you if needed (not actually
		implemented yet :-)

	QUEUE_FLAG_CLUSTER
		Explained above.

- struct request ->queue is no more. with the introduction of
  elv_next_request, you are no longer supposed to handle looping
  directly over the request list.

- end_that_request_first takes an additional number_of_sectors argument.
  It used to handle always just the first buffer_head in a request, now
  it will loop and handle as many sectors (on a bio-segment granularity)
  as you want.

- bh->b_end_io is bio->bi_end_io, but you probably want to use
  bio_endio(bio, uptodate, nr_sectors) instead.

- you can set max sector size, max segment size etc per queue now.
  drivers that used to define their own merge functions to handle things
  like this can now just use the blk_queue_* functions at blk_init_queue
  time.

- you no longer have to map a {partition, sector offset} into the
  correct absolute location anymore, this is done by the block layer. so
  when you received a request ala this before:

	rq->rq_dev = MKDEV(3, 5);	/* /dev/hda5 */
	rq->sector = 0;			/* first sector on hda5 */

  you will now see

	rq->rq_dev = MKDEV(3, 0);	/* /dev/hda */
	rq->sector = 123128;		/* offset from start of disk */

- As mentioned, there is no virtual mapping of a bio. For DMA, this is
  not a problem as you probably never will need a virtual mapping.
  Instead you want a bus mapping so you can ship it to the driver. For
  PIO drivers (or drivers that need to revert to PIO transfer once in a
  while (IDE for example)), where the CPU is doing the actual data
  transfer for you, you do need a virtual mapping though. If you are
  supporting highmem I/O, you need to use bio_kmap and bio_kmap_irq to
  temporarily map a bio into the virtual address space. See how IDE
  handles this with ide_map_buffer.

I've lost track of what else there is to explain, so I'll stop now. If
you have problems convering a driver or questions in general, fire away.
Suparana@IBM has written lots of stuff about bio as it was a WIP, see

http://lse.sourceforge.net/io/bionotes.txt

it may not be completely uptodate right now wrt multi-page bios etc, but
I know that is on its way :-)

-- 
Jens Axboe

