Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273822AbRIRDta>; Mon, 17 Sep 2001 23:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273823AbRIRDtL>; Mon, 17 Sep 2001 23:49:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:63750 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273822AbRIRDtI> convert rfc822-to-8bit; Mon, 17 Sep 2001 23:49:08 -0400
Date: Mon, 17 Sep 2001 23:25:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918053711.P698@athlon.random>
Message-ID: <Pine.LNX.4.21.0109172314130.7032-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> On Mon, Sep 17, 2001 at 10:08:22PM -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Mon, 17 Sep 2001, Marcelo Tosatti wrote:
> > 
> > > 
> > > 
> > > On Mon, 17 Sep 2001, Linus Torvalds wrote:
> > > 
> > > > 
> > > > Ok, the big thing here is continued merging, this time with Andrea.
> > > > 
> > > > I still don't like some of the VM changes, but integrating Andrea's VM
> > > > changes results in (a) better performance and (b) much cleaner inactive
> > > > page handling in particular. Besides, for the 2.4.x tree, the big priority
> > > > is stability, we can re-address my other concerns during 2.5.x.
> > > 
> > > Andrea, 
> > > 
> > > Could you please make a resume of your VM changes ? 
> > > 
> > > Its hard to keep up with VM changes this way. 
> > 
> > Andrea, 
> > 
> > I've just read a bit of your new VM code and I have a few comments.
> > 
> > You completly removed the "inactive freeable pages" logic: There is no
> 
> yes, it wasn't relly useful to keep this list lazily, you either keep it
> enforced with locking overhead or such information isn't valuable.
> 
> > more distiction between "freeable inactive" and "free" pages. All VM work
> > is based on "freepages.high" watermark. I don't like that: it seems to
> 
> hardly on freepages.high:
> 
> diff -urN vm-ref/mm/swap.c vm/mm/swap.c
> --- vm-ref/mm/swap.c	Tue Sep 18 00:18:17 2001
> +++ vm/mm/swap.c	Tue Sep 18 00:18:35 2001
> @@ -24,50 +24,13 @@
>  #include <asm/uaccess.h> /* for copy_to/from_user */
>  #include <asm/pgtable.h>
>  
> -/*
> - * We identify three levels of free memory.  We never let free mem
> - * fall below the freepages.min except for atomic allocations.  We
> - * start background swapping if we fall below freepages.high free
> - * pages, and we begin intensive swapping below freepages.low.
> - *
> - * Actual initialization is done in mm/page_alloc.c
> - */
> -freepages_t freepages = {
> -	0,	/* freepages.min */
> -	0,	/* freepages.low */
> -	0	/* freepages.high */
> -};
> -
> 
> > make page freeing more aggressive over time.
> 
> I don't see your point with "page freeing more aggressive over time".

I meant "zone->freepages.high" (or something like that... you get the
idea). 

My point is: we're not going to start aging pte's until we have a
zone shortage, right ?

With the old scheme, we would differentiate "inactive shortage" from "free
shortage".

> 
> > Also, if we have several try_to_free_pages() callers, for different
> > classzones, I'm right saying that a caller with a "smaller" classzone can
> > "hide" pages in its "active_local_lru" and/or "inactive_local_lru" (during
> > shrink_cache) from other processes trying to free pages from those higher
> > zones ?
> 
> I'm deeply impressed, you seem to have understood the rewrite greatly
> well, congrats, this "hiding" was infact my main concern I had on the
> memclass check during shrink_cache, but I don't think this will ever
> give us troubles.  In such there are suprious swapouts with HIGHMEM
> we'll just need to waste some cpu by lefting those pages visible with a
> few changes in shrink_cache, but again I'm almost sure there won't be
> problems, we do multiple scans before failing so those pages will return
> visible before the other task has a chance to fail the allocation.

I really think this will cause problems in practice, Andrea.

Moreover, the whole active_local_lru has a _bad_ effect on writeout
clustering:

shrink_cache() callers on low classzone can "hide" pages from higher
classzone callers and avoid clustering. Look:

We have a nice big sequentially ordered list of pages to writeout. 

lowzone shrink_cache() moves higher zones pages (from this ordered list)
to its inactive/active_local_lru until it calls schedule() (due to
need_resched()). (for example)

Now we have a higher classzone caller which finds "half of the block" and
writes it out.

>From this point on, we breaked in half an ordered list of pages which
could be nicely merged together at ll_rw_block().

The example I gave which splits one sequentially ordered list of pages in
two blocks is a simple and "stupid" one. But think how badly can we have
pages ordered during a long time of VM activity.



