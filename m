Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967932AbWK3VpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967932AbWK3VpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 16:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967931AbWK3VpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 16:45:07 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:45272 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1031519AbWK3VpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 16:45:03 -0500
In-Reply-To: <000301c7142f$21706160$ff0da8c0@amr.corp.intel.com>
References: <000301c7142f$21706160$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <48655D0C-F150-4EF1-B946-94B959580A65@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <chris.mason@oracle.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [rfc patch] optimize o_direct on block device
Date: Thu, 30 Nov 2006 13:45:00 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At that time, a patch was written for raw device to demonstrate that
> large performance head room is achievable (at ~20% speedup for micro-
> benchmark and ~2% for db transaction processing benchmark) with a  
> tight
> I/O submission processing loop.

Where exactly does the benefit come from?  icache misses?  "atomic"  
ops leading to pipeline flushes?

I ask to find out just what exactly it would take to get fs/direct- 
io.c do the job efficiently on behalf of the block devices so that it  
doesn't have to grow code that duplicates the 48 billion fiddly  
little behavioural quirks of O_DIRECT.

I'm cc:ing Chris directly 'cause he's been fighting with fs/direct- 
io.c recently, too.

> (1) I need a vector structure similar to pagevec, however, pagevec  
> doesn't
>     have everything that I need, i.e., an iterator variable.  So I  
> create a
>     new struct pvec.  Maybe something can be worked out with pagevec?

I don't think you need to duplicate the pagevec functionality a new  
struct.  If nothing else you'd embed a pagevec in a wrapper struct  
which includes the other fields you're using.

> (2) there are some inconsistency for synchronous I/O: condition to  
> update
>     ppos and condition to wait on sync_kiocb is incompatible.  Call  
> chain
>     looks like the following:
>
>     do_sync_read
>        generic_file_aio_read
>          ...
>            blkdev_direct_IO
>
>     do_sync_read will wait for I/O completion only if lower  
> function returned
>     -EIOCBQUEUED. Updating ppos is done via generic_file_aio_read,  
> but only
>     if the lower function returned positive value. So I either have  
> to construct
>     my own wait_on_sync_kiocb, or hack around the ppos update.

Yeah, this stuff is a mess.

If memory serves this works out because nothing currently uses the  
AIO completion paths (EIOCBQEUED, aio_complete()) for sync iocbs.   
That is, they test is_sync_iocb() and block internally and return the  
number of bytes transferred.

Changing this implies moving some work that's done in the generic  
return code processing path over into the aio completion path.  Like  
extending i_size.

> +	atomic_t* bio_count = (atomic_t*) &iocb->private;

Is atomic_t defined to fit in a long?  Right now it seems to.. (all  
use 'int' or 's32').  That'll be fun to debug if some joker arch  
decides to put some debugging help in the atomic_t struct, etc.

BUILD_BUG_ON() if the sizes don't fit, I guess, if we have to do it  
this way.  Maybe something somewhere does that already.

> +		nr_pages = (addr + count + PAGE_SIZE - 1) / PAGE_SIZE -
> +			    addr / PAGE_SIZE;

Ugh, we have *got* to use some macros for this stuff.  Every single  
time we add code like this a handful of brains strain to make sure  
corner cases (wrapping, off-by-one, type conversion, order of  
operations, page straddling) are covered.

> +	size = i_size_read(inode);
> +	if (pos + nbytes > size)
> +		nbytes = size - pos;

Has something else made sure that pos won't be > size?  I don't know  
the block device world all that well.

> +		bio = bio_alloc(GFP_KERNEL, nvec);
> +		bio->bi_bdev = I_BDEV(inode);

Not checking for bio allocation failure?

> +		page = blk_get_page(addr, count, rw, &pvec);

It looks like count is the iov_len and isn't clamped to the block  
device size like nbytes.  So we could still have 'count' bytes mapped  
after nbytes hits the end of the device and stops building IO.  I  
don't see the function cleaning up these pages that were pinned in  
the user region that extended beyond the block device.  I guess this  
wants to be 'nbytes'.

Indeed, what happens if nbytes runs out when a bio is partially  
full?  Is it not submitted?  I feel like I'm missing something.

> +		if (IS_ERR(page)) {
> +			bio_release_pages(bio);
> +			bio_put(bio);
> +			if (atomic_read(bio_count) == 1)
> +				return PTR_ERR(page);

Does this mean that a fault part-way through an IO that exits from  
here won't update ki_bytes and so the eventual aio_complete() will be  
for the full requested IO rather than the partial IOs that completed?

> +			if (++seg < nr_segs) {
> +				addr = (unsigned long) iov[seg].iov_base;
> +				count = iov[seg].iov_len;

Am I missing where the alignment of the iovec elements beyond the  
first are being checked?

> +	}
> +
> +	nbytes = iocb->ki_nbytes = iocb->ki_nbytes - nbytes;
> +	iocb->ki_pos += nbytes;
> +
> +	blk_run_address_space(inode->i_mapping);
> +	if (atomic_dec_and_test(bio_count))
> +		aio_complete(iocb, nbytes, 0);

If blk_get_page() returned an error, but didn't return from the  
function 'cause it didn't drop the last ref, then that error isn't  
reflected here.  But the pending IO could have completed by the time  
we got here.  I think that makes the third different return code to  
expect from an IO that faults part-way through.

Backing up a bit, I'm not sure it's worth giving ourselves the  
opportunity to make all these mistakes by copying this code over.   
2%, on an extremely aggressive IO subsystem?

- z
