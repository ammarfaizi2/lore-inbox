Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUETTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUETTQL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUETTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:16:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34718 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265199AbUETTQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:16:03 -0400
Date: Thu, 20 May 2004 16:16:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] bug in 2.4.26 mm/memory.c:map_user_kiobuf
Message-ID: <20040520191658.GB19922@logos.cnet>
References: <Pine.LNX.4.33.0405111431560.3073-200000@godzilla.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0405111431560.3073-200000@godzilla.se.axis.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 02:57:40PM +0200, Bjorn Wesen wrote:
> Hi,
> 
> get_user_pages can in some circumstances return less than a complete 
> mapping, without giving an error code.

And those circumstances would be only get_user_pages(): 

	if ( !vma || (pages && vma->vm_flags & VM_IO) || !(flags & vma->vm_flags) )
		return i ? : -EFAULT;

Yes? When does it fail?

>  This fools map_user_kiobuf which 
> loops over the assumed number of pages in the mapping, calling 
> flush_dcache_page on all of them, which is not very good if the maplist is 
> not fully populated. It also fools drivers using map_user_kiobuf and which 
> also assume that you get a complete mapping (or an error code). Actually, 
> iobuf->nr_pages is reduced to reflect the incomplete mapping, but 
> iobuf->length is not, so I don't really know what the desired behaviour is
> in the kernel<->driver communication.
> 
> Anyway, the flush loop is incorrect, and it probably doesn't hurt to 
> restrict map_user_kiobuf so it returns -ENOMEM if get_user_pages can't 
> return the full amount of pages, to avoid surprises downstream. 
> 
> get_user_pages seem to behave in this way during severe memory-shortage, but 
> also (and more importantly) when a page-limited tmpfs is used as a substrate 
> for an mmap and map_user_kiobuf and the page/size limit is hit.

My knowledge on this area is limited but this looks OK to me. 

Stephen?

> 
> /Bjorn
> 
> --- linux-2.4.26/mm/memory.c    2003-11-28 19:26:21.000000000 +0100
> +++ linux-2.4.26/mm/memory-2.c  2004-05-11 13:48:10.000000000 +0200
> @@ -563,12 +563,19 @@
>         err = get_user_pages(current, mm, va, pgcount,
>                         (rw==READ), 0, iobuf->maplist, NULL);
>         up_read(&mm->mmap_sem);
> -       if (err < 0) {
> +       /* get_user_pages returns the amount of mapped pages,
> +        * which can be less than the amount of requested pages
> +        * in some cases. To avoid surprises downstream, we
> +        * unmap and return an error in those cases.  -bjornw
> +        */
> +       if(err > 0)
> +               iobuf->nr_pages = err;
> +       if (err < pgcount) {
> +               /* unmap depends on nr_pages being set at this point */
>                 unmap_kiobuf(iobuf);
>                 dprintk ("map_user_kiobuf: end %d\n", err);
> -               return err;
> +               return err < 0 ? err : -ENOMEM;
>         }
> -       iobuf->nr_pages = err;
>         while (pgcount--) {
>                 /* FIXME: flush superflous for rw==READ,
>                  * probably wrong function for rw==WRITE

> --- linux-2.4.26/mm/memory.c	2003-11-28 19:26:21.000000000 +0100
> +++ linux-2.4.26/mm/memory-2.c	2004-05-11 13:48:10.000000000 +0200
> @@ -563,12 +563,19 @@
>  	err = get_user_pages(current, mm, va, pgcount,
>  			(rw==READ), 0, iobuf->maplist, NULL);
>  	up_read(&mm->mmap_sem);
> -	if (err < 0) {
> +	/* get_user_pages returns the amount of mapped pages,
> +	 * which can be less than the amount of requested pages
> +	 * in some cases. To avoid surprises downstream, we
> +	 * unmap and return an error in those cases.  -bjornw
> +	 */
> +	if(err > 0)
> +		iobuf->nr_pages = err;
> +	if (err < pgcount) {
> +		/* unmap depends on nr_pages being set at this point */
>  		unmap_kiobuf(iobuf);
>  		dprintk ("map_user_kiobuf: end %d\n", err);
> -		return err;
> +		return err < 0 ? err : -ENOMEM;
>  	}
> -	iobuf->nr_pages = err;
>  	while (pgcount--) {
>  		/* FIXME: flush superflous for rw==READ,
>  		 * probably wrong function for rw==WRITE

