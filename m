Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWB1Rak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWB1Rak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWB1Rak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:30:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:38329 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932282AbWB1Raj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:30:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH -mm 2/2] mm: make shrink_all_memory try harder
Date: Tue, 28 Feb 2006 18:25:54 +0100
User-Agent: KMail/1.9.1
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200602271926.20294.rjw@sisk.pl> <200602271930.03171.rjw@sisk.pl> <20060227192532.0a71e19b.akpm@osdl.org>
In-Reply-To: <20060227192532.0a71e19b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602281825.55355.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 04:25, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > Make shrink_all_memory() repeat the attempts to free more memory if there
> > seems to be no pages to free.
> > 
> 
> This description doesn't describe what the problem is, not how the patch
> fixes it.  So I'm kinda left guessing.

I have described it in the 0/0 message, but I should have repeated that in the
changelog, sorry.

The probelm is that shrink_all_memory() sometimes returns 0 when there are
some freeable pages left.  In swsusp we stop freeing memory when
shrink_all_memory() returns 0, so this is a problem to us.

> > ===================================================================
> > --- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
> > +++ linux-2.6.16-rc4-mm2/mm/vmscan.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/cpuset.h>
> >  #include <linux/notifier.h>
> >  #include <linux/rwsem.h>
> > +#include <linux/delay.h>
> >  
> >  #include <asm/tlbflush.h>
> >  #include <asm/div64.h>
> > @@ -1793,17 +1794,24 @@ unsigned long shrink_all_memory(unsigned
> >  	struct reclaim_state reclaim_state = {
> >  		.reclaimed_slab = 0,
> >  	};
> > +	int retry = 2;
> >  
> >  	current->reclaim_state = &reclaim_state;
> > -	for_each_pgdat(pgdat) {
> > -		unsigned long freed;
> > +	do {
> > +		for_each_pgdat(pgdat) {
> > +			unsigned long freed;
> >  
> > -		freed = balance_pgdat(pgdat, nr_to_free, 0);
> > -		ret += freed;
> > -		nr_to_free -= freed;
> > -		if (nr_to_free <= 0)
> > +			freed = balance_pgdat(pgdat, nr_to_free, 0);
> > +			ret += freed;
> > +			nr_to_free -= freed;
> > +			if (nr_to_free <= 0)
> > +				break;
> > +		}
> > +		if (ret > 0)
> >  			break;
> > -	}
> > +		if (retry)
> > +			msleep_interruptible(100);
> 
> TASK_INTERRUPTIBLE sleeps won't do anything if someone has sent this
> process a signal.    They should be used with caution.
> 
> 
> Something like the below, I guess.  But it's hard to fix something when you
> don't know what you're fixing.

Sorry again.

> swsusp should call drop_pagecache() and then drop_slab() before trying to
> use shrink_all_memory(), btw.

Well, sometimes we don't need to free a lot of memory.

> diff -puN mm/vmscan.c~mm-make-shrink_all_memory-try-harder mm/vmscan.c
> --- devel/mm/vmscan.c~mm-make-shrink_all_memory-try-harder	2006-02-27 19:17:29.000000000 -0800
> +++ devel-akpm/mm/vmscan.c	2006-02-27 19:21:08.000000000 -0800
> @@ -33,6 +33,7 @@
>  #include <linux/cpuset.h>
>  #include <linux/notifier.h>
>  #include <linux/rwsem.h>
> +#include <linux/delay.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -1783,11 +1784,13 @@ unsigned long shrink_all_memory(unsigned
>  	pg_data_t *pgdat;
>  	unsigned long nr_to_free = nr_pages;
>  	unsigned long ret = 0;
> +	unsigned retry = 2;
>  	struct reclaim_state reclaim_state = {
>  		.reclaimed_slab = 0,
>  	};
>  
>  	current->reclaim_state = &reclaim_state;
> +repeat:
>  	for_each_pgdat(pgdat) {
>  		unsigned long freed;
>  
> @@ -1797,6 +1800,10 @@ unsigned long shrink_all_memory(unsigned
>  		if ((long)nr_to_free <= 0)
>  			break;
>  	}
> +	if (retry-- && ret < nr_pages) {
> +		blk_congestion_wait(WRITE, HZ/5);
> +		goto repeat;
> +	}

I'd like to do this only if ret is 0.

>  	current->reclaim_state = NULL;
>  	return ret;
>  }
> _
> 
> But then, the above could be implemented by the caller, so I don't know
> what's going on..

If 0 is returned, the caller assumes there are no more freeable pages.

