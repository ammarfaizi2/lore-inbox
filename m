Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVCHJBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVCHJBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVCHJBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:01:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54422 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261896AbVCHJAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:00:41 -0500
Date: Tue, 8 Mar 2005 14:39:46 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-ID: <20050308090946.GA4100@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1110189607.11938.14.camel@frecb000686> <20050307223917.1e800784.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050307223917.1e800784.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 10:39:17PM -0800, Andrew Morton wrote:
> 6
> Lines: 76
> 
> Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> >
> > When reading a file in async mode (using kernel AIO), and the file
> >  size is lower than the requested size (short read),  the direct IO
> >  layer reports an incorrect number of bytes read (transferred).
> > 
> >   That case is handled for the sync path in 'direct_io_worker' 
> >  (fs/direct-io.c) where a check is made against the file size.
> > 
> >   This patch does the same thing for the async path.
> 
> It looks sane to me.  It needs a couple of fixes, below.  One of them is
> horrid and isn't really a fix at all, but it improves things.
> 
> Would Suparna and Badari have time to check the logic of these two patches
> please?
> 

Bugs in this area seem never-ending don't they - plug one, open up
another - hard to be confident/verify :( - someday we'll have to
rewrite a part of this code.

Hmm, shouldn't dio->result ideally have been adjusted to be within
i_size at the time of io submission, so we don't have to deal with
this during completion ? We are creating bios with the right size
after all. 

We have this: 
		if (!buffer_mapped(map_bh)) {
				....
				if (dio->block_in_file >=
                                        i_size_read(dio->inode)>>blkbits) {
                                        /* We hit eof */
                                        page_cache_release(page);
                                        goto out;
                                }

and
		dio->result += iov[seg].iov_len -
                        ((dio->final_block_in_request - dio->block_in_file) <<
                                        blkbits);


can you spot what is going wrong here that we have to try and
workaround this later ?

Regards
Suparna

> 
> 
> 
> - i_size is 64 bit, ssize_t is 32-bit
> 
> - whitespace tweaks.
> 
> - i_size_read() in interrupt context is a no-no.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/fs/direct-io.c |   14 +++++++++++---
>  1 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff -puN fs/direct-io.c~direct-io-async-short-read-fix-fix fs/direct-io.c
> --- 25/fs/direct-io.c~direct-io-async-short-read-fix-fix	2005-03-07 22:28:52.000000000 -0800
> +++ 25-akpm/fs/direct-io.c	2005-03-07 22:37:18.000000000 -0800
> @@ -231,7 +231,7 @@ static void finished_one_bio(struct dio 
>  	if (dio->bio_count == 1) {
>  		if (dio->is_async) {
>  			ssize_t transferred;
> -			ssize_t i_size;
> +			loff_t i_size;
>  			loff_t offset;
>  
>  			/*
> @@ -241,11 +241,19 @@ static void finished_one_bio(struct dio 
>  			spin_unlock_irqrestore(&dio->bio_lock, flags);
>  
>  			/* Check for short read case */
> +
> +			/*
> +			 * We should use i_size_read() here.  But we're called
> +			 * in interrupt context.  If this CPU happened to be
> +			 * in the middle of i_size_write() when the interrupt
> +			 * occurred, i_size_read() would lock up.
> +			 * So we just risk getting a wrong result instead :(
> +			 */
> +			i_size = dio->inode->i_size;
>  			transferred = dio->result;
> -			i_size = i_size_read (dio->inode);
>  			offset = dio->iocb->ki_pos;
>  
> -			if ((dio->rw == READ) && ((offset + transferred) > i_size))
> +			if ((dio->rw == READ) && (offset+transferred > i_size))
>  				transferred = i_size - offset;
>  
>  			dio_complete(dio, offset, transferred);
> _
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@k
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

