Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269014AbUJENG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269014AbUJENG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUJENG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:06:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269014AbUJENGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:06:51 -0400
Date: Tue, 5 Oct 2004 08:27:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, sct@redhat.com
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
Message-ID: <20041005112752.GA21094@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16733.50382.569265.183099@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 04:57:50PM -0400, Jeff Moyer wrote:
> This patch makes an attempt at supporting the O_NONBLOCK flag for regular
> files.  It's pretty straight-forward.  One limitation is that we still call
> into the readahead code, which I believe can block.  However, if we don't
> do this, then an application which only uses non-blocking reads may never
> get it's data.
> 
> Comments welcome.

Hi Jeff,

Curiosity: Is this defined in any UNIX standard?

Adv. Programming in the UNIX environment says:

12.2 Nonblocking I/O

"Nonblocking I/O lets us issue an I/O operation, such as open, read,
or write and not have it block forever. If the operation cannot be 
completed, return is made immediately with an error noting that 
the operation would have blocked."

He is talking about read's on descriptors (pipe's, devices, etc) which 
block in case of no data present, not about filesystem IO.

But here we create our own semantics of O_NONBLOCK on read() of 
fs IO. As you say page_cache_readahead can block for one
trying to allocate pages, possibly while submitting IO too.

The patch is cool - might be nice to check if SuS or someone else
specificies behaviour and try to match if so?

> 
> -Jeff
> 
> --- linux-2.6.8/mm/filemap.c.orig	2004-09-30 16:33:46.881129560 -0400
> +++ linux-2.6.8/mm/filemap.c	2004-09-30 16:34:12.109294296 -0400
> @@ -720,7 +720,7 @@ void do_generic_mapping_read(struct addr
>  	unsigned long index, end_index, offset;
>  	loff_t isize;
>  	struct page *cached_page;
> -	int error;
> +	int error, nonblock = filp->f_flags & O_NONBLOCK;
>  	struct file_ra_state ra = *_ra;
>  
>  	cached_page = NULL;
> @@ -755,10 +755,20 @@ find_page:
>  		page = find_get_page(mapping, index);
>  		if (unlikely(page == NULL)) {
>  			handle_ra_miss(mapping, &ra, index);
> +			if (nonblock) {
> +				desc->error = -EWOULDBLOCK;
> +				break;
> +			}
>  			goto no_cached_page;
>  		}
> -		if (!PageUptodate(page))
> +		if (!PageUptodate(page)) {
> +			if (nonblock) {
> +				page_cache_release(page);
> +				desc->error = -EWOULDBLOCK;
> +				break;
> +			}
>  			goto page_not_up_to_date;
> +		}
>  page_ok:
>  
>  		/* If users can be writing to this page using arbitrary
> @@ -1004,7 +1014,7 @@ __generic_file_aio_read(struct kiocb *io
>  			desc.error = 0;
>  			do_generic_file_read(filp,ppos,&desc,file_read_actor);
>  			retval += desc.written;
> -			if (!retval) {
> +			if (!retval || desc.error) {
>  				retval = desc.error;
>  				break;
>  			}
