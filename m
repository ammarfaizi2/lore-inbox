Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbTGAC7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 22:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbTGAC7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 22:59:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:8958 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265852AbTGAC7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 22:59:03 -0400
Date: Tue, 1 Jul 2003 08:48:15 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, Benjamin LaHaise <bcrl@kvack.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.73-mm2] aio O_DIRECT no readahead
Message-ID: <20030701084814.A1554@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1057022391.22702.18.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1057022391.22702.18.camel@dell_ss5.pdx.osdl.net>; from daniel@osdl.org on Mon, Jun 30, 2003 at 06:19:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 06:19:51PM -0700, Daniel McNeil wrote:
> More testing on AIO with O_DIRECT and /dev/raw/.  Doing AIO reads was
> using a lot more cpu time than using dd on the raw partition even with
> the io_queue_wait patch.  Found out that aio is doing readahead even
> for O_DIRECT.  Here's a patch that fixes it.  Here are some output

That was a good catch. Thanks ! 

> from time on reading a 90mb partition on a raw device with 32k i/o:
> 
> CMD             Kernel                  I/O     real    user    sys
> RUN             version                 size
> ===             ======                  ===     ====    ====    ===
> dd              2.5.73-mm2:             32k     2.514s  0.000s  0.200s
> aio (1 iocb)    2.5.73-mm2:             32k     3.408s  1.120s  2.250s
> aio (32 iocb)   2.5.73-mm2:             32k     2.994s  0.830s  2.160s
> aio (1 iocb)    2.5.73-mm2+patch.aiodio 32k     2.509s  0.850s  1.660s
> aio (1 iocb)    2.5.73-mm2+patch.aiodio
>                    +patch.io_queue_wait 32k     2.566s  0.010s  0.240s
> aio (32 iocb)   2.5.73-mm2+patch.aiodio
>                    +patch.io_queue_wait 32k     2.465s  0.010s  0.080s
> 
> With this patch and my previous io_queue_wait patch the cpu time
> drops down to very little when doing AIO with O_DIRECT.
> 
> Daniel McNeil <daniel@osdl.org>

> --- linux-2.5.73-mm2/fs/aio.c	2003-06-30 16:39:15.874216228 -0700
> +++ linux-2.5.73-mm2.aiodio/fs/aio.c	2003-06-30 15:38:46.000000000 -0700
> @@ -1380,15 +1380,20 @@ ssize_t aio_setup_iocb(struct kiocb *kio
>  			break;
>  		ret = -EINVAL;
>  		if (file->f_op->aio_read) {
> -			struct address_space *mapping =
> -				file->f_dentry->d_inode->i_mapping;
> -			unsigned long index = kiocb->ki_pos >> PAGE_CACHE_SHIFT;
> -			unsigned long end = (kiocb->ki_pos + kiocb->ki_left)
> -				>> PAGE_CACHE_SHIFT;
> -
> -			for (; index < end; index++) {
> -				page_cache_readahead(mapping, &file->f_ra,
> -							file, index);
> +			/*
> +			 * Do not do readahead for DIRECT i/o
> +			 */
> +			if (!(file->f_flags & O_DIRECT)) {
> +				struct address_space *mapping =
> +					file->f_dentry->d_inode->i_mapping;
> +				unsigned long index = kiocb->ki_pos >> PAGE_CACHE_SHIFT;
> +				unsigned long end = (kiocb->ki_pos + kiocb->ki_left)
> +					>> PAGE_CACHE_SHIFT;
> +
> +				for (; index < end; index++) {
> +					page_cache_readahead(mapping, &file->f_ra,
> +								file, index);
> +				}
>  			}
>  			kiocb->ki_retry = aio_pread;
>  		}


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

