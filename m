Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUETUvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUETUvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 16:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUETUvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 16:51:01 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:55789 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S262009AbUETUuz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 16:50:55 -0400
Date: Thu, 20 May 2004 22:50:39 +0200 (CEST)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: [PATCH] bug in 2.4.26 mm/memory.c:map_user_kiobuf
In-Reply-To: <20040520191658.GB19922@logos.cnet>
Message-ID: <Pine.LNX.3.96.1040520223925.12180B-100000@aldur3.se.axis.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004, Marcelo Tosatti wrote:
> On Tue, May 11, 2004 at 02:57:40PM +0200, Bjorn Wesen wrote:
> > get_user_pages can in some circumstances return less than a complete 
> > mapping, without giving an error code.
> 
> And those circumstances would be only get_user_pages(): 
> 
> 	if ( !vma || (pages && vma->vm_flags & VM_IO) || !(flags & vma->vm_flags) )
> 		return i ? : -EFAULT;
> 
> Yes? When does it fail?

There are several "return i"'s in the inner loop in get_user_pages.
Essentially, if something goes wrong in handle_mm_fault when pages have
already been allocated, it returns with the pages allocated so far. I
didn't look closer into exactly why handle_mm_fault fails, but I did
confirm the result (that get_user_pages returns less than the requested
amount of pages, and that map_user_kiobuf then crashes, under tmpfs mmap 
mappings). 

Probably, the tmpfs page limit makes handle_mm_fault return an error when
you try to kiobuf-map an mmap'ed area and tmpfs runs out of pages, so you
get a similar situation as when you get a real OOM.

> > Anyway, the flush loop is incorrect, and it probably doesn't hurt to 
> > restrict map_user_kiobuf so it returns -ENOMEM if get_user_pages can't 
> > return the full amount of pages, to avoid surprises downstream. 

The alternative patch is to fix the flush loop, and let map_user_kiobuf
actually return an incomplete mapping and hope that all drivers handle it
correctly (I doubt it).

I think the situation arises so seldomly that it is better to reject the
mapping than to try to squeeze out the few cases where the drivers can
actually make anything useful from an incomplete mapping ?

/Bjorn

> > --- linux-2.4.26/mm/memory.c	2003-11-28 19:26:21.000000000 +0100
> > +++ linux-2.4.26/mm/memory-2.c	2004-05-11 13:48:10.000000000 +0200
> > @@ -563,12 +563,19 @@
> >  	err = get_user_pages(current, mm, va, pgcount,
> >  			(rw==READ), 0, iobuf->maplist, NULL);
> >  	up_read(&mm->mmap_sem);
> > -	if (err < 0) {
> > +	/* get_user_pages returns the amount of mapped pages,
> > +	 * which can be less than the amount of requested pages
> > +	 * in some cases. To avoid surprises downstream, we
> > +	 * unmap and return an error in those cases.  -bjornw
> > +	 */
> > +	if(err > 0)
> > +		iobuf->nr_pages = err;
> > +	if (err < pgcount) {
> > +		/* unmap depends on nr_pages being set at this point */
> >  		unmap_kiobuf(iobuf);
> >  		dprintk ("map_user_kiobuf: end %d\n", err);
> > -		return err;
> > +		return err < 0 ? err : -ENOMEM;
> >  	}
> > -	iobuf->nr_pages = err;
> >  	while (pgcount--) {
> >  		/* FIXME: flush superflous for rw==READ,
> >  		 * probably wrong function for rw==WRITE
> 

