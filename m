Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSFXUoq>; Mon, 24 Jun 2002 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSFXUop>; Mon, 24 Jun 2002 16:44:45 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:9659 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315265AbSFXUon>; Mon, 24 Jun 2002 16:44:43 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 24 Jun 2002 13:44:25 -0700
Message-Id: <200206242044.NAA04851@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org,
       martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   	Sorry if I was not clear enough about the purpose of of
>   the new scatterlist->driver_priv field.  It is a "streaming" data
>   structure to use the terminology of DMA-maping.txt (i.e., one that
>   would typically only be allocated for a few microseconds as an IO is
>   built up and sent).  Its purpose is to hold the hardware-specific
>   gather-scatter segment descriptor, which typically look something like this:
>   
>   		struct foo_corporation_scsi_controller_sg_element {
>   			u64	data_addr;
>   			u64	next_addr;
>   			u16	data_len;
>   			u16	reserved;
>   			u32	various_flags;
>   		}
>   		
>This is small, about one cacheline, and thus is not to be used
>with non-consistent memory.  Also, if you use streaming memory, where
>is the structure written to and where is the pci_dma_sync_single
>(which is a costly cache flush on many systems btw, another reason to
>use consistent memory) between the CPU writes and giving the
>descriptor to the device?

>Again, reread DMA-mapping.txt a few more times before composing
>your response to me.  I really meant that you don't understand
>the purpose of consistent vs. streaming memory.

	In my previous email, I suggested using consistent memory in
the paragraph that followed.  I have underlined the sentence below.

	Anyhow, I have reread DMA-mapping.txt end to end, updated my
sample code to suggest to making available some scatterlist merging
code that is currently only available to block devices.  Just to
demonstrate that to you, I have a few comments:

    1. It would help to document if pci_pool_alloc(pool,SLAB_KERNEL,&dma)
       can ever return failure (as opposed to blocking forever).  That would
       effect whether certain error legs have to be written in a device
       driver.

    2. It sure would be nice if there were a couple of ifdef symbols
       that controlled the expansion DECLARE_PCI_UNMAP_{ADDR,LEN}, so
       that default usual implementations could be put in <linux/pci.h>,
       and so that it would be possible to portbly write sg_dma_address()
       that want to return sg.dma_addr if that field exists, and
       sg.vaddr otherwise.  This is of practical use because I would like
       to do the same thing for my proposed sglist.driver_priv{,_dma} fields.

    3. Isn't the stuff about scatterlist->address obselete.  I thought that
       field was deleted in 2.5.


>   	Come to think of it, my use of pci_map_single is incorrect
>   after all, because the driver has not yet filled in that data structure
>   at that point.  Since the data structures are being allocated from a
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   single contiguous block that spans a couple of pages that is being used
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   only for this purpose, perhaps I would be fastest to pci_alloc_consistent
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   the whole memory pool for those little descriptors at initialization time
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   and then change that loop to do the following.
>   
>Please use PCI pools, this is what they were designed for.  Pools of
>like-sized objects allocated out of consistent DMA memory.

	Thanks for reminding me of them.  Although I had explored using
them in another situation, I forgot about them for this situation, where
they make sense, especially if pci_pool_alloc(...,SLAB_KERNEL,...) can
never fail for lack of memory (although they could block indefinitely).
I have updated my sample code accordingly.

>So as it stands I still think your proposal is buggy.

	Do you understand that scatterlist.driver_priv{,_dma} is just
a follow-on optimization of my proposal to turn struct scatterlist
into a linked list, so that pci_map_sg &co. can be consolidated into
the "mid-level" drivers (scsi.o, usb.o)?

	I hope the updated code below and the clarification of my
previous email address the scatterlist.driver_priv{,_dma} issues that
you raised.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

/* Parameters from ll_rw_blk.c.  Used for expressing limits and keeping
   running totals on sglist sizes. */
struct scatter_sizes {
	unsigned int	hw_segments;
	unsigned int	phys_segments;
	unsigned int	segment_size;
	unsigned int	total_size;
};

struct scatter_limit {
	struct scatter_sizes	sizes;
	u32			boundary_mask;	/* u64? */
}

struct dma_stream {
	struct scatter_limit	*limit;
	struct pci_pool		*sgpriv_pool;
	struct pci_dev		*pci_dev;
	unsigned long		flags;
};

/* dma_stream.flags: */
#define DMA_MAP_MUST_SUCCEED		1

struct scatterlist {
	...include all existing fields.  Add these:

	struct scatterlist 	*next;
	void *driver_priv;
	dma_addr_t driver_priv_dma;
};

/* Formerly blk_map_sg.  Now all devices can get the DMA merge optimizations
   currently available to block devices. */
extern int dma_coalesce_sg(struct scatter_limit *limit,
			   struct scatterlist *sg);

typedef void (bio_end_io_t) (struct bio *,
			     unsigned long bi_flags /* combined with bi_rw */);


struct bio {
	/* merge bi_rw and bi_flags into a parameter to submit_bio */
        struct bio              *bi_next;       /* request queue link */
	unsigned int		bi_size;
        bio_end_io_t            *bi_end_io;
        void                    *bi_private;
        bio_destructor_t        *bi_destructor;
};

typedef void (unprep_rq_fn)(request_queue_t *q, struct request *req);

struct request {
	Include all existing fields except current_nr_sectors,
	nr_phys_segments, nr_hw_segments.  Add these:

	int			map_sg_count;
	unprep_rq_fn 		*unprep_rq_fn; /* Called by
						  blkdev_release_request*/
	struct scatterlist	*head, *tail;
	struct scatter_sizes	sizes;	/* sizes.segment_size refers to the
					   size of the last segment */
	atomic_t		num_bios; /* Cannot free scatterlist until
					     last request completes. */
};

struct request_queue {
	...delete max_{sectors,phys_segments,hw_segments,segment_size} and
	seg_boundary_mask.  Replace them with this field:

	struct dma_stream *stream; /* Shareable between different queues,
				      for example, disks on the same
				      controller, or between /dev/loop/nnn,
				      and its underlying device. */
};


static inline int req_dma_dir(struct request *req) {
	return (req->flags & REQ_RW) ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE;
}

/* Generic routines usable as queue->{,un}prep_fn: */
int rq_dma_prep(dma_stream *stream, struct request *req) {
	int count;
	struct scatterlist *sg = req->head;
	int alloc_flags;
	int err_on_mem_fail =
		(stream->flags & DMA_MAP_MUST_SUCCEED) ? -ENOMEM : 0;
	int mem_fail;

	count = dma_coalesce_sg(&stream->limit, sg);
	count = pci_map_sg(stream->pci_dev, sg, count, req_dma_dir(req));
	if (count < 0 && err_on_mem_fail)
		return count;

	/* Perhaps we could change new pci_map_sg, so that if it shortens
	   shortens the scatterlist, that it still leaves the unused
	   scatterlist entries linked at the end of the list, but that
	   the first unused entry (if any) is makred with
	   sg->sg_length = 0, just so we don't have to remember the
	   count returned by pci_map_sg result (since there is no easy
	   place to store it).  Otherwise, we need to remember the count,
	   like so:
	*/
	req->map_sg_count = count;

	/* "Read ahead" requests should abort rather than block. */
	alloc_flags = (req->flags & REQ_RW_AHEAD) ? SLAB_ATOMIC : SLAB_KERNEL;

	/*
	 * SLAB_KERNEL will never fail, so no need to check.  It will
	 * just block until memory is available.
	 */
	mem_fail = 0;
	if (q->sgpriv_pool) {
		while(count--) {
			sg->driver_priv = pci_pool_alloc(q->sgpriv_pool,
				alloc_flags, &sg->driver_priv_dma);
			if (sg->driver_prv == NULL)
				mem_fail = err_on_mem_fail;
			sg = sg->next;
		}
	}

	return mem_fail;
}


void rq_dma_unprep(reqeust_queue_t *q, struct request *req) {
	struct scatterlist *sg;

	sg = req->head;
	pci_unmap_sg(req->dma_map_dev, sg, req_dma_dir(req));
	if (q->sgpriv_pool) {
		int count = req->map_sg_count;
		while (count--) {
			pci_pool_free(q->sgpriv_pool, sg->driver_priv,
				      sg->driver_priv_dma);
			sg = sg->next;
		}
	}
}

/* By the way, we cannot move q->sgpriv_pool into struct pci_device and
   have pci_{,un}map_sg take care of sg->driver_priv{,_dma} because

	1. Non-PCI drivers use pci_device == NULL.  Perhaps, in the future,
	   this will cease to be an issue of the DMA mapping stuff can
	   be abstracted to "struct dma_device".

	2. Conceivably, a driver might want more than one pool for
	   different IO functions on the same device.  This is similar
	   to the example of a sound card requiring different DMA masks
	   in DMA-mapping.txt.  Both problems could be solved by
	   creating a "struct dma_channel", which could contain the
	   gather/scatter parameters currently in struct requeust_queue,
	   the dma_mask parameter from pci_device, and allocation pool
	   for sglist->sg_driver_priv.
*/


   


