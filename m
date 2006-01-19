Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWASD74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWASD74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWASD74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:59:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161058AbWASD7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:59:55 -0500
Date: Wed, 18 Jan 2006 19:59:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch] sg: simplify page_count manipulations
Message-Id: <20060118195937.3586c94f.akpm@osdl.org>
In-Reply-To: <20060118155242.GB28418@wotan.suse.de>
References: <20060118155242.GB28418@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> Hi Linus,
> 
> What do you think about the following couple of patches? Hugh's had a
> look and thinks they're OK.
> 

Gad.  You're brave.

> Allocate a compound page for the user mapping instead of tweaking
> the page refcounts.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/drivers/scsi/sg.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/sg.c
> +++ linux-2.6/drivers/scsi/sg.c
> @@ -1140,32 +1140,6 @@ sg_fasync(int fd, struct file *filp, int
>  	return (retval < 0) ? retval : 0;
>  }
>  
> -/* When startFinish==1 increments page counts for pages other than the 
> -   first of scatter gather elements obtained from alloc_pages().
> -   When startFinish==0 decrements ... */
> -static void
> -sg_rb_correct4mmap(Sg_scatter_hold * rsv_schp, int startFinish)
> -{
> -	struct scatterlist *sg = rsv_schp->buffer;
> -	struct page *page;
> -	int k, m;
> -
> -	SCSI_LOG_TIMEOUT(3, printk("sg_rb_correct4mmap: startFinish=%d, scatg=%d\n", 
> -				   startFinish, rsv_schp->k_use_sg));
> -	/* N.B. correction _not_ applied to base page of each allocation */
> -	for (k = 0; k < rsv_schp->k_use_sg; ++k, ++sg) {
> -		for (m = PAGE_SIZE; m < sg->length; m += PAGE_SIZE) {
> -			page = sg->page;
> -			if (startFinish)
> -				get_page(page);
> -			else {
> -				if (page_count(page) > 0)
> -					__put_page(page);
> -			}
> -		}
> -	}
> -}

What on earth is the above trying to do?  The inner loop is a rather
complex way of doing atomic_add(&page->count, sg->length/PAGE_SIZE).  One
suspects there's a missing "[m]" in there.

Yes, using a compound page for the refcounting sounds sane, but I think
this code is fragile and has monsters in it.

