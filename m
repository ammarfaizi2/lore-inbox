Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSFWX6e>; Sun, 23 Jun 2002 19:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317195AbSFWX6d>; Sun, 23 Jun 2002 19:58:33 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:45512 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317194AbSFWX6a>; Sun, 23 Jun 2002 19:58:30 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 23 Jun 2002 16:58:20 -0700
Message-Id: <200206232358.QAA03027@adam.yggdrasil.com>
To: akpm@zip.com.au, axboe@suse.de
Subject: RFC: turn scatterlist into a linked list, eliminate bio_vec
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have an idea of how to simplify all of the device drivers
that do DMA, the block device layer, networking, scsi, USB, and
others.  I came up with this partly in an effort to explore if I could
go furhter with the bio_append changes, and partly in response to
Martin Dalecki suggesting that think about "a generalized packet
driver command layer, which is independant from SCSI" (although this
idea does not go that far).

	The idea is to turn struct scatterlist from an array into a
linked list.  Here are some advantages:

	1. We can more easily consolidate all of the calls to
pci_{,un}map_sg, blk_rq_map_sg, etc. in the higher level dispatch
routines for each device type (ll_rw_blk.c, scsi.c, etc.), because
the higher level code would already have the struct scatterlist, so
it would not have to do memory allocation per request.  It also
means we have one less place to worry about memory allocation
failures (or add a lot of complexity to prevent them).  Hardware
device drivers would just receive a struct scatterlist and stuff
DMA values.

	2. The gather/scatter merge optimizations now done for block
devices can be restated as operating on any scatterlist, so the same
code could optimize merging and breaking up streams to USB endpoints,
for example.

	3. The gather/scatter merge optimizations will be faster
because it will not be necessary to copy or reallocate arrays.
Instead, we can do O(1) manipulations of head and tail pointers.
Given prior knowledge about exactly what kind of gather/scatter lists
the underlying driver can handle, the merging code could do the
merges one time as it does the math about what can be merged.

	4. The potential memory costs for the raid code to split
linked lists is smaller than that for copying arrays.  At most,
it will cost num_disks * sizeof(struct scatterlist).

	5. We can more easily prepend or append additional data to a
request (assuming a tail pointer, which is needed by the block driver
code for merging anyhow).  This may be useful, say, when one needs
basically to encapsulate one protocol in another.

	Right now, just about every type of device that can
potentially do a large amount of IO has its own way of chaining
these blocks of arbitrary data together (request/bio/bio_vec for
block devices, struct urb, struct sk_buff_head for network packets,
etc.).  At the lowest level of division, I believe that these data
structures already require their blocks of data not to cross
page boundaries.  Most of these data structures contain other important
data and could not be entirely eliminated, but they could be changed to
each contain one struct scatterlist.

	The result would be that the request handler for most block
device drivers, network drivers, usb drivers, etc. would be
simplified.  Also the common denominator of struct scatterlist between
different types of drivers could also simplify the various
encapsulation system (for example, right now the sddr09 scsi over usb
interface actually a scatterlist and copies all of the data into a
single linear buffer, even though USB controllers are good at
gather/scatter).

	When implementing this in practice, there are things
that could be done to preserve backward compatibility for a
while, like leaving the old array-based routines in place for
a time.

	Anyhow, to illustrate better what I have in mind, I have
attached a description of the approximate changes in data structures
and a pair of helper routines that could centralize most of the
scatterlist mapping and unmapping.

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

struct scatterlist {
	...include all existing fields.  Add this one:

	struct scatterlist 	*next;
	void *driver_priv;
	dma_addr_t driver_priv_dma;

	...also alloc_sg() will allocation additional space at the end of
	struct scatterlist as requested by the hardware driver, which the
	hardware driver will use for things like the hardware device's
	gather/scatter structures.
};


typedef void (bio_end_io_t) (struct bio *,
			     unsigned long bi_flags /* combined with bi_rw */);


struct bio {
	/* merge bi_rw and bi_flags into a parameter to submit_bio */
        struct bio              *bi_next;       /* request queue link */
	unsigned int		bi_size;
        bio_end_io_t            *bi_end_io;
        void                    *bi_private;
        bio_destructor_t        *bi_destructor; /* destructor */
};

typedef void (unprep_rq_fn)(request_queue_t *q, struct request *req);

struct request {
	Delete current_nr_sectors, nr_phys_segments, nr_hw_segments.
	Replace them with:

	int			rw;		/* formerly bio.bi_rw */
	unprep_rq_fn 		*unprep_rq_fn; /* Called by
						  blkdev_release_request*/
	struct scatterlist	*head, *tail;
	struct scatter_sizes	sizes;	/* sizes.segment_size refers to the
					   size of the last segment */
};

struct request_queue {
	...new fields:
	int		sgpriv_size;
	mempool_t 	*sgpriv_pool;
	struct pci_dev	*dma_map_dev;
};

/* Allocate one scatterlist element, with any extra space requested in
   q->sglist_extra_bytes. */
struct scatterlist *sglist_alloc(requeust_queue_t *q); 

#define QUEUE_FLAG_DMA_MAP_MUST_SUCCEED	4

/* Generic routines usable as queue->{,un}prep_fn: */

int rq_dma_prep(reqeust_queue_t *q, struct request *req) {
	int failed = 0;
	struct scatterlist *sg;
	int fail_value = q->flags & QUEUE_FLAGS_DMA_MAP_MUST_SUCCEED;

	sg = req->head;
	if (pci_map_sg(req->dma_map_dev, sg, bio_dir_to_dma_dir(req->rw)) < 0)
		failed = fail_value;
	if (failed || !q->sgpriv_pool)
		return failed;

	/* Let's assume the new pci_map_sg will free unused scatterlists. */
	while (sg != NULL && count--) {
		sg->driver_priv = mempool_alloc(q->sgpriv_pool, GFP_KERNEL);

		sg->driver_priv_dma =
			pci_map_single(req->dma_map_dev, sg->driver_priv, len,
				       PCI_DMA_TODEVICE);
			if (sg_dma->dma_add_priv == 0);
				failed = fail_value;
		}
	}
	if (failed)
		rq_dma_unprep(q, req);

	return failed;
}


void rq_dma_unprep(reqeust_queue_t *q, struct request *req) {
	struct scatterlist *sg;

	sg = req->head;
	pci_unmap_sg(req->dma_map_dev, sg, bio_dir_to_dma_dir(req->rw));
	if ((q->flags & QUEUE_FLAG_DMA_MAP_SGLIST) != 0) {
		while (sg != NULL && count--) {
			struct scatterlist_with_dma *sg_dma =
				(struct scatterlist_with_dma*) sg;
			void *vaddr = &sg_dma[1];
			int len = req->sglist_extra_bytes - sizeof(dma_addr_t);

			pci_unmap_single(req->dma_map_dev,
				 	 sg_dma->dma_addr_priv, vaddr, len,
					 PCI_DMA_TODEVICE);
		}
	}
}
