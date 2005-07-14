Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVGNXUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVGNXUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNXSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:18:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1756 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261684AbVGNXQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:16:36 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 16:16:23 -0700
Message-Id: <1121382983.6755.87.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does your patch ensures that we meet the driver alignment
restrictions ? Like you said, you need atleast "even" byte alignment
for IDE etc..

And also, are there any restrictions on how much the "minimum" IO
size has to be ? I mean, can I read "1" byte ? I guess you are
not relaxing it (yet)..

Thanks,
Badari

On Wed, 2005-07-13 at 16:43 -0700, Daniel McNeil wrote:
> This patch relaxes the direct i/o alignment check so that user addresses
> do not have to be a multiple of the device block size.
> 
> I've done some preliminary testing and it mostly works on an ext3
> file system on a ide disk.  I have seen trouble when the user address
> is on an odd byte boundary.  Sometimes the data is read back incorrectly
> on read and sometimes I get these kernel error messages:
> 	hda: dma_timer_expiry: dma status == 0x60
> 	hda: DMA timeout retry
> 	hda: timeout waiting for DMA
> 	hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> 	ide: failed opcode was: unknown
> 	hda: drive not ready for command
> 
> Doing direct-io with user addresses on even, non-512 boundaries appears
> to be working correctly.
> 
> Any additional testing and/or comments welcome.
> 
> Signed-off-by: Daniel McNeil <daniel@osdl.org>
> 
> --- linux-2.6.12.orig/fs/direct-io.c	2005-06-28 16:39:39.000000000 -0700
> +++ linux-2.6.12/fs/direct-io.c	2005-06-28 16:39:59.000000000 -0700
> @@ -1147,7 +1147,9 @@ __blockdev_direct_IO(int rw, struct kioc
>  			goto out;
>  	}
>  
> -	/* Check the memory alignment.  Blocks cannot straddle pages */
> +	/*
> +	 * Check the i/o.  It must be a multiple of device block size.
> +	 */
>  	for (seg = 0; seg < nr_segs; seg++) {
>  		addr = (unsigned long)iov[seg].iov_base;
>  		size = iov[seg].iov_len;
> @@ -1156,7 +1158,7 @@ __blockdev_direct_IO(int rw, struct kioc
>  			if (bdev)
>  				 blkbits = bdev_blkbits;
>  			blocksize_mask = (1 << blkbits) - 1;
> -			if ((addr & blocksize_mask) || (size & blocksize_mask))
> +			if (size & blocksize_mask)
>  				goto out;
>  		}
>  	}
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
> 

