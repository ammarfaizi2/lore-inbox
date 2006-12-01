Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759114AbWLAGQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759114AbWLAGQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759115AbWLAGQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:16:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:29318 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1759112AbWLAGQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:16:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,483,1157353200"; 
   d="scan'208"; a="171486882:sNHT21848281"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Chris Mason" <chris.mason@oracle.com>
Subject: RE: [rfc patch] optimize o_direct on block device
Date: Thu, 30 Nov 2006 22:16:53 -0800
Message-ID: <000001c71510$4bec8400$8f8c030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccUyNIqbvFeehNITC2pCST5RhjTsAAHG8gA
In-Reply-To: <48655D0C-F150-4EF1-B946-94B959580A65@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Thursday, November 30, 2006 1:45 PM
> > At that time, a patch was written for raw device to demonstrate that
> > large performance head room is achievable (at ~20% speedup for micro-
> > benchmark and ~2% for db transaction processing benchmark) with a  
> > tight I/O submission processing loop.
> 
> Where exactly does the benefit come from?  icache misses?  "atomic"  
> ops leading to pipeline flushes?

It benefit from shorter path length. It takes much shorter time to process
one I/O request, both in the submit and completion path.  I always think in
terms of how many instructions, or clock ticks does it take to convert user
request into bio, submit it and in the return path, to process the bio call
back function and do the appropriate io completion (sync or async).  The
stock 2.6.19 kernel takes about 5.17 micro-seconds to process one 4K aligned
DIO (just the submit and completion path, less disk I/O latency).  With the
patch, the time is reduced to 4.26 us.

This time may look small compare to disk latency. But with multi-threaded
app using native AIO interface, the metric is important because we are CPU
bound instead of traditionally I/O bound. So software efficiency is critical.


> I ask to find out just what exactly it would take to get fs/direct- 
> io.c do the job efficiently on behalf of the block devices so that it  
> doesn't have to grow code that duplicates the 48 billion fiddly  
> little behavioural quirks of O_DIRECT.

I've attempted that first, but fall flat with all the 48 billion corner
cases needed to handle in the most inner loop.


> > (2) there are some inconsistency for synchronous I/O: condition to  
> > update
> >     ppos and condition to wait on sync_kiocb is incompatible.  Call  
> > chain
> >     looks like the following:
> >
> >     do_sync_read
> >        generic_file_aio_read
> >          ...
> >            blkdev_direct_IO
> >
> >     do_sync_read will wait for I/O completion only if lower  
> > function returned
> >     -EIOCBQUEUED. Updating ppos is done via generic_file_aio_read,  
> > but only
> >     if the lower function returned positive value. So I either have  
> > to construct
> >     my own wait_on_sync_kiocb, or hack around the ppos update.
> 
> Yeah, this stuff is a mess.
> 
> If memory serves this works out because nothing currently uses the  
> AIO completion paths (EIOCBQEUED, aio_complete()) for sync iocbs.   
> That is, they test is_sync_iocb() and block internally and return the  
> number of bytes transferred.
> 
> Changing this implies moving some work that's done in the generic  
> return code processing path over into the aio completion path.  Like  
> extending i_size.

Right. block device never change i_size on write, so I'm utilizing the
blocking call in the generic path that is currently never exercised.


> > +	atomic_t* bio_count = (atomic_t*) &iocb->private;
> 
> Is atomic_t defined to fit in a long?  Right now it seems to.. (all  
> use 'int' or 's32').  That'll be fun to debug if some joker arch  
> decides to put some debugging help in the atomic_t struct, etc.
> 
> BUILD_BUG_ON() if the sizes don't fit, I guess, if we have to do it  
> this way.  Maybe something somewhere does that already.

Good suggestion, I will add that.


> > +	size = i_size_read(inode);
> > +	if (pos + nbytes > size)
> > +		nbytes = size - pos;
> 
> Has something else made sure that pos won't be > size?  I don't know  
> the block device world all that well.

generic_file_aio_read checks pos < size before calling down direct_IO
method, so the check is there already.  But you are right that in the
write path, the equivalent check is not there.  I need to chew on this
a bit more.


> > +		bio = bio_alloc(GFP_KERNEL, nvec);
> > +		bio->bi_bdev = I_BDEV(inode);
> 
> Not checking for bio allocation failure?

I should've add a big fat comments that bio_alloc never fail with
GFP_KERNEL flag. It allocates from mempool that guarantees availability.


> > +		page = blk_get_page(addr, count, rw, &pvec);
> 
> It looks like count is the iov_len and isn't clamped to the block  
> device size like nbytes.  So we could still have 'count' bytes mapped  
> after nbytes hits the end of the device and stops building IO.  I  
> don't see the function cleaning up these pages that were pinned in  
> the user region that extended beyond the block device.  I guess this  
> wants to be 'nbytes'.

I think I adjusted nbytes to never pass beyond the end of disk.  So the
above scenario won't happen.  I will double check.  Using nbytes won't
be correct though, because each vector isn't contiguous in virtual address
space, I really have to make separate call to get_user_pages further down
from the blk_get_page().


> Indeed, what happens if nbytes runs out when a bio is partially  
> full?  Is it not submitted?  I feel like I'm missing something.

No, it will get submitted.


> > +		if (IS_ERR(page)) {
> > +			bio_release_pages(bio);
> > +			bio_put(bio);
> > +			if (atomic_read(bio_count) == 1)
> > +				return PTR_ERR(page);
> 
> Does this mean that a fault part-way through an IO that exits from  
> here won't update ki_bytes and so the eventual aio_complete() will be  
> for the full requested IO rather than the partial IOs that completed?

If nothing is submitted, then it's an easy case.  But if some bio is
already submitted, yes, the error path lacks backing out bytes
accumulated for current vector because it won't get submitted.


> > +			if (++seg < nr_segs) {
> > +				addr = (unsigned long) iov[seg].iov_base;
> > +				count = iov[seg].iov_len;
> 
> Am I missing where the alignment of the iovec elements beyond the  
> first are being checked?

It is checked immediately below addr and count assignment:

+				if (!(addr & blocksize_mask ||
+				      count & blocksize_mask))
+					goto same_bio;

Looking closely, these checks is not complete ....


> Backing up a bit, I'm not sure it's worth giving ourselves the  
> opportunity to make all these mistakes by copying this code over.   
> 2%, on an extremely aggressive IO subsystem?

IMO, it worth the effort because 2% just from DIO is significant.

- Ken

 
