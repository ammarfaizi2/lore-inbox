Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317869AbSFNB4k>; Thu, 13 Jun 2002 21:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317871AbSFNB4j>; Thu, 13 Jun 2002 21:56:39 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:54912 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317869AbSFNB4i>; Thu, 13 Jun 2002 21:56:38 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 13 Jun 2002 18:56:32 -0700
Message-Id: <200206140156.SAA02512@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, axboe@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	In the course of working on potential kernel crashes in
ll_rw_kio and fs/mpage.c, I have been thinking that there has got
to be a better way to more efficiently construct large I/O requests,
and I now have an idea of how to do it, although it may at first
seem to be regressing back to struct buffer_head.  Currently, most
block IO operations will at best generate IO errors if bio_alloc
starts to fail, and code that attempts to build big block IO's has
to be a bit complex to build bio's that are as big as possible but
still not too big or having too many IO vectors for whatever the
underlying device driver says it is willing to handle.


PROSOSAL:	struct bio *bio_chain(struct bio* old);

	newbio = bio_chain(oldbio);

	would be similar to:
		newbio = bio_alloc(GFP_KERNEL, 1);
		newbio->bi_bdev = oldbio->bi_bdev;
		newbio->bi_rw = oldbio->bi_rw;
		submit_bio(oldio);

	...except for two important differences:

	1. bio_chain NEVER gets a memory allocation failure.  If it is
not able to allocate any memory, it fiddles with old->bi_destructor
and waits for the "old" bio to complete, and returns the old bio.
This is important because most current block device drivers will, at
best, generate errors if they fail to allocate a bio.

	2. bio_chain will set some kind of hint that newbio is
probably contiguous with oldbio.  So, if oldbio is still on the
device queue when newbio is eventually submitted, the merge code
will first check the request that oldbio is in for merging.  So,
the merging in that case will be O(1).  Also, if bio_chain is also
used to submit newbio and it is able to do the merge, bio_chain can
simply return the bio that was going to be discarded by the merge,
since bio_chain is only defined to return a bio capable of holding
one IO vector and all bio's in a request meet that criterion, and
the bio being discarded by the merge will already have bi_bdev and
bi_rw set to the correct values if it was mergeable in the first
place.

	I realize there may be locking issues in implementing this.

	Under this scheme, code that wants to build up big bio's
can be much simpler, because it does not have to think about
q->max_phys_segments or q->max_hw_segments (it just has to make sure
that each request is smaller than q->max_sectors).  Also, part of the
IO could be started earlier if the device is idle, although that
trade-off may not be worthwhile.

	Code that builds up big bio's would look something like this:

	/* Allocate a lot of iovecs in the first bio, so that
	   the merge code is less likely to have to do a memory
	   allocation */
	bio = alloced_bio = bio_alloc(GFP_KERNEL, bio_max_iovecs(q));
	if (!bio) { /* Work even if first bio_alloc in loop fails. */
		up(&devprivate->backup_bio_mutex);
		bio = devprivate->backup_bio;
	}

	bio->bi_bdev = bdev;
	bio->bi_rw = rw;
	bio->bi_vcnt = 1;
	for(;;) {
		bio->bi_sector = sector;
		bio->bi_io_vec[0].bv_page = ...;
		bio->bi_io_vec[0].bv_offset = ...;
		bio->bi_io_vec[0].bv_len = ...;
		if (last_one)
			break;
		bio = bio_chain(bio);
		sector += ....;
	}

	if (alloced_bio)
		submit_bio(bio);
	else {
		devprivate->backup_bio = bio_chain(bio);
		down(&devprivate->backup_bio_mutex);
	}

	The bio_chain calls should be very fast in the normal repeating
case.  They will immediately succeed in merging oldbio with the bio that
was submitted before and just return oldbio.  Since oldbio already has
all of the correct values set, bio_chain does not need to fill anything
in in this case.  So, while the loops is theoretically building up and
destroying bio's, is, really just assembling big bio's, at least in
terms of the CPU costs.

	For performance reasons, the semantics of bio_chain could be
restricted further.  For example, oldbio could be required to have
bi->bi_vcnt == 1 and bi->bi_idx == 0, and the bio_chain optimization
might only be done if the bio is submitted by bio_chain, not by
submit_bio, or perhaps we could even require that the bio returned by
bio_chain can only be submitted by bio_chain or freed.

	By the way, I also want to implement a mechanism like this for
the USB requests to make them also impervious to memory allocation failures
after device initialization.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
