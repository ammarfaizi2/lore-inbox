Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbUKHEIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUKHEIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUKHEIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:08:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12760 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261748AbUKHEIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:08:00 -0500
Date: Mon, 8 Nov 2004 09:47:30 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-aio@kvack.org,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Oops in aio_free_ring on 2.6.9
Message-ID: <20041108041730.GB3681@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1099683260.12365.348.camel@bluebox> <Pine.LNX.4.58.0411061938150.2223@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411061938150.2223@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 07:43:33PM -0800, Linus Torvalds wrote:
> 
> On Fri, 5 Nov 2004, Darrick J. Wong wrote:
> > 
> > Next, the aio_setup_ring function tries to mmap a bunch of pages and
> > fails, because in step 1 we used up all the address space. 
> > aio_setup_ring then calls aio_free_ring to tear all of this down.
> > (fs/aio.c:143)
> > 
> > aio_free_ring sees the block of struct page pointers and calls free_page
> > (fs/aio.c:88) on the pointers without checking that they're not NULL. 
> > Unfortunately, they _are_ NULL and *oops*!  My patch amends the function
> > to include a null pointer check.
> 
> I don't disagree with the bug, but I disagree with the fix. 
> 
> In my opinion, the problem is that "info->nr_pages" is _wrong_. It's wrong 
> because it has been initialized to a bogus value. 
> 
> I'd much prefer this alternate appended patch. Can you verify that it also 
> fixes the problem (we can drop the bogus info->nr_pages initialization, 
> because the context - including the info part - has been cleared when it 
> was allocated, so nr_pages should already have the _correct_ value of zero 
> at this point).

Since aio_free_ring uses comparison with info->internal_pages rather than
nr_pages to decide whether to kfree(info->ring_pages), I see your point.

Regards
Suparna

> 
> 		Linus
> 
> -----
> ===== fs/aio.c 1.60 vs edited =====
> --- 1.60/fs/aio.c	2004-10-20 01:12:10 -07:00
> +++ edited/fs/aio.c	2004-11-06 19:41:45 -08:00
> @@ -118,8 +118,6 @@
>  	if (nr_pages < 0)
>  		return -EINVAL;
>  
> -	info->nr_pages = nr_pages;
> -
>  	nr_events = (PAGE_SIZE * nr_pages - sizeof(struct aio_ring)) / sizeof(struct io_event);
>  
>  	info->nr = 0;
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

