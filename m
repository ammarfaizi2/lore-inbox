Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267825AbUHTIbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267825AbUHTIbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUHTIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:31:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267777AbUHTIbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:31:19 -0400
Date: Fri, 20 Aug 2004 04:28:47 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: remove dentry_open::file_ra_init_state() duplicated memset was Re: kernbench on 512p
Message-ID: <20040820072847.GA8205@logos.cnet>
References: <200408191216.33667.jbarnes@engr.sgi.com> <20040820005654.GC6374@logos.cnet> <20040819232145.2fd5c54a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819232145.2fd5c54a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 11:21:45PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > So this patch creates a __file_ra_state_init() function, which initializes
> >  the file_ra_state fields, without the memset. 
> > 
> >  file_ra_state_init() does the memset + its __ counterpart. 
> 
> Seems unnecessarily fiddly.  How about this?

Thats cleaner yep. :)

> --- 25/mm/readahead.c~file_ra_state_init-speedup	2004-08-19 23:20:11.695876032 -0700
> +++ 25-akpm/mm/readahead.c	2004-08-19 23:20:42.077257360 -0700
> @@ -28,12 +28,12 @@ struct backing_dev_info default_backing_
>  EXPORT_SYMBOL_GPL(default_backing_dev_info);
>  
>  /*
> - * Initialise a struct file's readahead state
> + * Initialise a struct file's readahead state.  Assumes that the caller has
> + * memset *ra to zero.
>   */
>  void
>  file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
>  {
> -	memset(ra, 0, sizeof(*ra));
>  	ra->ra_pages = mapping->backing_dev_info->ra_pages;
>  	ra->average = ra->ra_pages / 2;
>  }
> diff -puN fs/nfsd/vfs.c~file_ra_state_init-speedup fs/nfsd/vfs.c
> --- 25/fs/nfsd/vfs.c~file_ra_state_init-speedup	2004-08-19 23:20:11.713873296 -0700
> +++ 25-akpm/fs/nfsd/vfs.c	2004-08-19 23:21:05.721662864 -0700
> @@ -771,6 +771,7 @@ nfsd_get_raparms(dev_t dev, ino_t ino, s
>  	ra = *frap;
>  	ra->p_dev = dev;
>  	ra->p_ino = ino;
> +	memset(&ra->p_ra, 0, sizeof(ra->p_ra));
>  	file_ra_state_init(&ra->p_ra, mapping);
>  found:
>  	if (rap != &raparm_cache) {
> _
