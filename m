Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTKRLuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 06:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTKRLuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 06:50:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54226 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261763AbTKRLtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 06:49:52 -0500
Date: Tue, 18 Nov 2003 17:25:20 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: 2.6.0-test9-mm3 - AIO test results
Message-ID: <20031118115520.GA4291@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031112233002.436f5d0c.akpm@osdl.org> <1068761038.1805.35.camel@ibm-c.pdx.osdl.net> <20031117052518.GA11184@in.ibm.com> <1069118109.1842.31.camel@ibm-c.pdx.osdl.net> <1069119433.1842.43.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069119433.1842.43.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't seem to able to recreate this at my end - even with 1k 
block sizes.  Did you notice if this problem occurs without
the latest patch ?

Regards
Suparna

On Mon, Nov 17, 2003 at 05:37:14PM -0800, Daniel McNeil wrote:
> Obviously, the ps output in my previous email showed that the hangs were
> with 1k i/o sizes.  
> 
> More testing using 2k, 4k, 16k, 32k, 64k, 128k, 256k and 512k all
> completed correctly.
> 
> Even 11k and 17k worked.
> 
> $ ls -l
> -rw-------    1 daniel   daniel   88289280 Jun  9 16:54 glibc-2.3.2.tar
> -rw-rw-r--    1 daniel   daniel   88289280 Nov 17 17:32 ff2
> 
> 
> So, only 1k is hanging so far.
> 
> Daniel
> 
> On Mon, 2003-11-17 at 17:15, Daniel McNeil wrote:
> > Suparna,
> > 
> > Good news and bad news.  Your patch does fix the non-power of two i/o
> > size problems where AIO previously did not complete:
> > 
> > $ ./aiodio_sparse  -s 1751k -r 18k -w 11k
> > $ aiodio_sparse -i 9 -dd -s 180k -r 18k -w 18k  
> > io_submit() return 9
> > aiodio_sparse: 9 i/o in flight
> > aiodio_sparse: offset 165888 filesize 184320 inflight 9
> > aiodio_sparse: io_getevent() returned 1
> > aiodio_sparse: io_getevent() res 18432 res2 0
> > io_submit() return 1
> > AIO DIO write done unlinking file
> > dio_sparse done writing, kill children
> > aiodio_sparse 0 children had errors
> > 
> > But when testing using aiocp using O_DIRECT to copy a file to
> > an already allocated file, the aiocp process hangs.  I used i/o
> > size of 4k and that compeleted.  Using i/o size of 1k and 2k,
> > the aiocp process hung during io_sumbit() and are unkillable.
> > Here are the stack traces:
> > 
> > # ps -fu daniel | grep aiocp
> > daniel    1920     1  0 16:45 ?        00:00:07 aiocp -b 1k -n 1 -f DIRECT glibc-2.3.2.tar ff2
> > daniel    2083  2037  0 17:00 pts/2    00:00:03 aiocp -dd -b 1k -n 8 -f DIRECT glibc-2.3.2.tar ff2
> > 
> > 
> > aiocp         D 00000001  1920      1                1902 (NOTLB)
> > e70abd04 00200086 c18dbc80 00000001 00000003 c02897fc 00000060 00200246
> >        f7cdb8b4 c16522f0 c18dbc80 0000309c 640a05eb 0000008b e6d9e660
> > c0289a16
> >        f7cdb8b4 e87e95cc c18dbc80 00000000 00000001 e70abd10 c0123712
> > e70aa000
> > Call Trace:
> >  [<c02897fc>] generic_unplug_device+0x50/0xbd
> >  [<c0289a16>] blk_run_queues+0xa9/0x15c
> >  [<c0123712>] io_schedule+0x26/0x30
> >  [<c0192242>] direct_io_worker+0x376/0x5ab
> >  [<c014840f>] generic_file_direct_IO+0x70/0x89
> >  [<c019264a>] __blockdev_direct_IO+0x1d3/0x2d5
> >  [<c01ac73e>] ext3_direct_io_get_blocks+0x0/0xbf
> >  [<c01ad72d>] ext3_direct_IO+0xc0/0x1e1
> >  [<c01ac73e>] ext3_direct_io_get_blocks+0x0/0xbf
> >  [<c014840f>] generic_file_direct_IO+0x70/0x89
> >  [<c0145e11>] __generic_file_aio_read+0xfb/0x1ff
> >  [<c0121b70>] schedule+0x3ac/0x7ef
> >  [<c0145f48>] generic_file_aio_read+0x33/0x37
> >  [<c0194ad3>] aio_pread+0x34/0x5f
> >  [<c0193bec>] aio_run_iocb+0xa6/0x1ed
> >  [<c019316f>] __aio_get_req+0x27/0x158
> >  [<c0194a9f>] aio_pread+0x0/0x5f
> >  [<c0194f62>] io_submit_one+0x1ea/0x2b7
> >  [<c0195110>] sys_io_submit+0xe1/0x194
> >  [<c03c29a7>] syscall_call+0x7/0xb
> >  [<c03c007b>] rpc_depopulate+0x1aa/0x24b
> > 
> > 
> > aiocp         D 366EDC94  2083   2037                     (NOTLB)
> > e758bd04 00200082 f71ba000 366edc94 00000161 c02897fc 00000060 366edc94
> >        00000161 f71ba000 c18d3c80 000069a9 366f5a0e 00000161 e8d4acc0 c0289a16
> >        f7cdb8b4 e960465c c18d3c80 00000000 00000001 e758bd10 c0123712 e758a000
> > Call Trace:
> >  [<c02897fc>] generic_unplug_device+0x50/0xbd
> >  [<c0289a16>] blk_run_queues+0xa9/0x15c
> >  [<c0123712>] io_schedule+0x26/0x30
> >  [<c0192242>] direct_io_worker+0x376/0x5ab
> >  [<c019264a>] __blockdev_direct_IO+0x1d3/0x2d5
> >  [<c01ac73e>] ext3_direct_io_get_blocks+0x0/0xbf
> >  [<c01ad72d>] ext3_direct_IO+0xc0/0x1e1
> >  [<c01ac73e>] ext3_direct_io_get_blocks+0x0/0xbf
> >  [<c014840f>] generic_file_direct_IO+0x70/0x89
> >  [<c0145e11>] __generic_file_aio_read+0xfb/0x1ff
> >  [<c0259d3e>] write_chan+0x165/0x21e
> >  [<c0145f48>] generic_file_aio_read+0x33/0x37
> >  [<c0194ad3>] aio_pread+0x34/0x5f
> >  [<c0193bec>] aio_run_iocb+0xa6/0x1ed
> >  [<c019316f>] __aio_get_req+0x27/0x158
> >  [<c0194a9f>] aio_pread+0x0/0x5f
> >  [<c02532ab>] tty_write+0x1e8/0x3b2
> >  [<c0194f62>] io_submit_one+0x1ea/0x2b7
> >  [<c0195110>] sys_io_submit+0xe1/0x194
> >  [<c03c29a7>] syscall_call+0x7/0xb
> >  [<c03c007b>] rpc_depopulate+0x1aa/0x24b
> > 
> > 
> > 
> > Daniel
> > 
> > On Sun, 2003-11-16 at 21:25, Suparna Bhattacharya wrote:
> > > On Thu, Nov 13, 2003 at 02:03:58PM -0800, Daniel McNeil wrote:
> > > > Andrew,
> > > > 
> > > > I'm testing test9-mm3 on a 2-proc Xeon with a ext3 file system.
> > > > I tested using the test programs aiocp and aiodio_sparse.
> > > > (see http://developer.osdl.org/daniel/AIO/)
> > > > 
> > > > Using aiocp with i/o sizes from 1k to 512k to copy files worked
> > > > without any errors or kernel debug messages.
> > > > 
> > > > With 64k i/o, the aiodio_sparse program complete without any errors.
> > > > There are no kernel error messages, so that is good.
> > > > 
> > > > There are still problems with non power of 2 i/o sizes using AIO and
> > > > O_DIRECT.  It hangs with aio's that do not seem to complete.  The test
> > > > does exit when hitting ^c and there are no kernel messages.  Test output
> > > > below:
> > > 
> > > Could you check if the following patch fixes the problem for you ?
> > > 
> > > Regards
> > > Suparna
> > > 
> > > --------------------------------------------------------------
> > > 
> > > With this patch, when the DIO code falls back to buffered i/o after
> > > having submitted part of the i/o, then buffered i/o is issued only
> > > for the remaining part of the request (i.e. the part not already 
> > > covered by DIO).
> > > 
> > > diff -ur pure-mm3/fs/direct-io.c linux-2.6.0-test9-mm3/fs/direct-io.c
> > > --- pure-mm3/fs/direct-io.c	2003-11-14 09:09:06.000000000 +0530
> > > +++ linux-2.6.0-test9-mm3/fs/direct-io.c	2003-11-17 09:00:47.000000000 +0530
> > > @@ -74,6 +74,7 @@
> > >  					   been performed at the start of a
> > >  					   write */
> > >  	int pages_in_io;		/* approximate total IO pages */
> > > +	size_t	size;			/* total request size (doesn't change)*/
> > >  	sector_t block_in_file;		/* Current offset into the underlying
> > >  					   file in dio_block units. */
> > >  	unsigned blocks_available;	/* At block_in_file.  changes */
> > > @@ -226,7 +227,7 @@
> > >  			dio_complete(dio, dio->block_in_file << dio->blkbits,
> > >  					dio->result);
> > >  			/* Complete AIO later if falling back to buffered i/o */
> > > -			if (dio->result != -ENOTBLK) {
> > > +			if (dio->result >= dio->size || dio->rw == READ) {
> > >  				aio_complete(dio->iocb, dio->result, 0);
> > >  				kfree(dio);
> > >  			} else {
> > > @@ -889,6 +890,7 @@
> > >  	dio->blkbits = blkbits;
> > >  	dio->blkfactor = inode->i_blkbits - blkbits;
> > >  	dio->start_zero_done = 0;
> > > +	dio->size = 0;
> > >  	dio->block_in_file = offset >> blkbits;
> > >  	dio->blocks_available = 0;
> > >  	dio->cur_page = NULL;
> > > @@ -925,7 +927,7 @@
> > >  
> > >  	for (seg = 0; seg < nr_segs; seg++) {
> > >  		user_addr = (unsigned long)iov[seg].iov_base;
> > > -		bytes = iov[seg].iov_len;
> > > +		dio->size += bytes = iov[seg].iov_len;
> > >  
> > >  		/* Index into the first page of the first block */
> > >  		dio->first_block_in_page = (user_addr & ~PAGE_MASK) >> blkbits;
> > > @@ -956,6 +958,13 @@
> > >  		}
> > >  	} /* end iovec loop */
> > >  
> > > +	if (ret == -ENOTBLK && rw == WRITE) {
> > > +		/*
> > > +		 * The remaining part of the request will be 
> > > +		 * be handled by buffered I/O when we return
> > > +		 */
> > > +		ret = 0;
> > > +	}
> > >  	/*
> > >  	 * There may be some unwritten disk at the end of a part-written
> > >  	 * fs-block-sized block.  Go zero that now.
> > > @@ -986,19 +995,13 @@
> > >  	 */
> > >  	if (dio->is_async) {
> > >  		if (ret == 0)
> > > -			ret = dio->result;	/* Bytes written */
> > > -		if (ret == -ENOTBLK) {
> > > -			/*
> > > -			 * The request will be reissued via buffered I/O
> > > -			 * when we return; Any I/O already issued
> > > -			 * effectively becomes redundant.
> > > -			 */
> > > -			dio->result = ret;
> > > +			ret = dio->result;
> > > +		if (ret > 0 && dio->result < dio->size && rw == WRITE) {
> > >  			dio->waiter = current;
> > >  		}
> > >  		finished_one_bio(dio);		/* This can free the dio */
> > >  		blk_run_queues();
> > > -		if (ret == -ENOTBLK) {
> > > +		if (dio->waiter) {
> > >  			/*
> > >  			 * Wait for already issued I/O to drain out and
> > >  			 * release its references to user-space pages
> > > @@ -1032,7 +1035,8 @@
> > >  		}
> > >  		dio_complete(dio, offset, ret);
> > >  		/* We could have also come here on an AIO file extend */
> > > -		if (!is_sync_kiocb(iocb) && (ret != -ENOTBLK))
> > > +		if (!is_sync_kiocb(iocb) && !(rw == WRITE && ret >= 0 && 
> > > +			dio->result < dio->size))
> > >  			aio_complete(iocb, ret, 0);
> > >  		kfree(dio);
> > >  	}
> > > diff -ur pure-mm3/mm/filemap.c linux-2.6.0-test9-mm3/mm/filemap.c
> > > --- pure-mm3/mm/filemap.c	2003-11-14 09:15:08.000000000 +0530
> > > +++ linux-2.6.0-test9-mm3/mm/filemap.c	2003-11-15 11:11:16.000000000 +0530
> > > @@ -1895,14 +1895,16 @@
> > >  		 */
> > >  		if (written >= 0 && file->f_flags & O_SYNC)
> > >  			status = generic_osync_inode(inode, mapping, OSYNC_METADATA);
> > > -		if (written >= 0 && !is_sync_kiocb(iocb))
> > > +		if (written >= count && !is_sync_kiocb(iocb))
> > >  			written = -EIOCBQUEUED;
> > > -		if (written != -ENOTBLK)
> > > +		if (written < 0 || written >= count)
> > >  			goto out_status;
> > >  		/*
> > >  		 * direct-io write to a hole: fall through to buffered I/O
> > > +		 * for completing the rest of the request.
> > >  		 */
> > > -		written = 0;
> > > +		pos += written;
> > > +		count -= written;
> > >  	}
> > >  
> > >  	buf = iov->iov_base;
> > 
> > --
> > To unsubscribe, send a message with 'unsubscribe linux-aio' in
> > the body to majordomo@kvack.org.  For more info on Linux AIO,
> > see: http://www.kvack.org/aio/
> > Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

