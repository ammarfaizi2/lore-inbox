Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130423AbRBWVLy>; Fri, 23 Feb 2001 16:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRBWVLp>; Fri, 23 Feb 2001 16:11:45 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:58116 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S130423AbRBWVL2>;
	Fri, 23 Feb 2001 16:11:28 -0500
Message-ID: <3A96D1F9.7EA6BBB6@sh0n.net>
Date: Fri, 23 Feb 2001 16:11:22 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net - http://www.sh0n.net/spstarr
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed & mount hanging withloop 
 device issues
In-Reply-To: <Pine.LNX.4.33.0102231409010.496-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok apply patch and loop patch... I'll let you know what happens in my next
email.

Mike Galbraith wrote:

> On Fri, 23 Feb 2001, Shawn Starr wrote:
>
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
> > failed.
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
> > failed.
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 2-order allocation
> > failed.
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
> > failed.
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
> > failed.
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 2-order allocation
> > failed.
> > Feb 23 03:31:18 coredump kernel: __alloc_pages: 3-order allocation
> > failed.
> >
> > The use of mkisofs and xcdroster with cdrecord seems to cause this fault
> > in kernel.log
>
> Hi,
>
> Can you try the below for the high order allocation problem?  We don't
> try very hard at all to service high order allocations under load.  If
> it helps, let me know and I'll submit it to Rik for consideration.
>
> (for loop troubles, you should try Jens' latest loop patch located in
> your favorite kernel mirror under pub/linux/kernel/people/axboe)
>
>         -Mike
>
> (patch was done against 2.4.1-ac20, but should go in ok)
> --- mm/page_alloc.c.org Fri Feb 23 13:21:54 2001
> +++ mm/page_alloc.c     Fri Feb 23 13:28:33 2001
> @@ -274,7 +274,7 @@
>  struct page * __alloc_pages(zonelist_t *zonelist, unsigned long order)
>  {
>         zone_t **zone;
> -       int direct_reclaim = 0;
> +       int direct_reclaim = 0, loop = 0;
>         unsigned int gfp_mask = zonelist->gfp_mask;
>         struct page * page;
>
> @@ -366,7 +366,7 @@
>          *   able to free some memory we can't free ourselves
>          */
>         wakeup_kswapd();
> -       if (gfp_mask & __GFP_WAIT) {
> +       if (gfp_mask & __GFP_WAIT && loop) {
>                 __set_current_state(TASK_RUNNING);
>                 current->policy |= SCHED_YIELD;
>                 schedule();
> @@ -393,6 +393,7 @@
>          *      --> try to free pages ourselves with page_launder
>          */
>         if (!(current->flags & PF_MEMALLOC)) {
> +               loop++;
>                 /*
>                  * Are we dealing with a higher order allocation?
>                  *
> @@ -440,7 +441,7 @@
>                         memory_pressure++;
>                         try_to_free_pages(gfp_mask);
>                         wakeup_bdflush(0);
> -                       if (!order)
> +                       if (!order || loop < (1 << order))
>                                 goto try_again;
>                 }
>         }

