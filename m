Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273740AbRIQWmx>; Mon, 17 Sep 2001 18:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273747AbRIQWmk>; Mon, 17 Sep 2001 18:42:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5220 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273737AbRIQWky>; Mon, 17 Sep 2001 18:40:54 -0400
Date: Tue, 18 Sep 2001 00:41:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm rewrite ready [Re: broken VM in 2.4.10-pre9]
Message-ID: <20010918004116.A698@athlon.random>
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance> <9o1dev$23l$1@penguin.transmeta.com> <1000722338.14005.0.camel@x153.internalnet> <20010916203414.B1315@athlon.random> <20010917174037.7e3739b9.skraw@ithnet.com> <20010917181040.J713@athlon.random> <20010917191256.6e6a1c87.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010917191256.6e6a1c87.skraw@ithnet.com>; from skraw@ithnet.com on Mon, Sep 17, 2001 at 07:12:56PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC'ed to l-k with Stephan approval ]

On Mon, Sep 17, 2001 at 07:12:56PM +0200, Stephan von Krawczynski wrote:
> On Mon, 17 Sep 2001 18:10:40 +0200 Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > On Mon, Sep 17, 2001 at 05:40:37PM +0200, Stephan von Krawczynski wrote:
> > > On Sun, 16 Sep 2001 20:34:14 +0200 Andrea Arcangeli <andrea@suse.de> wrote:
> > > 
> > > > After a few days of developement I think I'm ready to release the VM
> > > > rewrite I did.
> > > > 
> > > > The alternate vm will be included in 2.4.10pre9aa1 (or anwways the very
> > > > next -aa release) and I'll maintain it in the -aa tree.  It is supposed
> > > > to provide:
> > > 
> > > Where can I get a patch working on 2.4.9 (possibly pre9 or pre10)?
> > > Didn't find it on ftp.kernel.org.
> > 
> > I uploaded it now. You can apply the whole 2.4.10pre10 patch
> > 
> > 
> ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre10aa1.bz2
> > 
> > Any feedback is welcome so I can make it better if it swapouts too much
> > etc...
> 
> Hello Andrea,
> 
> my first impression: very high performance compared to all other versions I
> tested so far.
>
> - cpu average load is low, during whole test sometimes even below 3
>   (never saw
> this before)

Good.

I also had another report with very vfs intensive operation going on and
I suspect this patch will be a good idea (even if it can lead to the
usual excessive grow of the vfs caches on the long run but the current
way is probably too aggressive).

--- 2.4.10pre10aa2/mm/vmscan.c.~1~	Mon Sep 17 19:17:27 2001
+++ 2.4.10pre10aa2/mm/vmscan.c	Tue Sep 18 00:09:33 2001
@@ -518,12 +518,12 @@
 	if (nr_pages <= 0)
 		return 0;
 
-	shrink_dcache_memory(priority, gfp_mask);
-	shrink_icache_memory(priority, gfp_mask);
-
 	nr_pages = shrink_cache(&active_list, &max_scan, nr_pages, classzone, gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
+
+	shrink_dcache_memory(priority, gfp_mask);
+	shrink_icache_memory(priority, gfp_mask);
 
 	return nr_pages;
 }

> - meminfo during test:
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  923574272 920178688  3395584        0 73883648 741076992
> Swap: 271392768        0 271392768
> MemTotal:       901928 kB
> MemFree:          3316 kB
> MemShared:           0 kB
> Buffers:         72152 kB
> Cached:         723708 kB
> SwapCached:          0 kB
> Active:         116172 kB
> Inactive:       679688 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       901928 kB
> LowFree:          3316 kB
> SwapTotal:      265032 kB
> SwapFree:       265032 kB

Fine.

> Doesn't change that much (once all mem is eaten up from free).

that's expected, I didn't claimed to have added the defragmenter yet ;)
The architecture for the defrag it's just there though, I just ignored
solving the order > 1 for now, that will be probably the next step.

> - Has same alloc problems as other versions:
> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 2-order allocation failed
> (gfp=0x20/0) from c012de72
> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 1-order allocation failed
> (gfp=0x20/0) from c012de72
> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 0-order allocation failed
> (gfp=0x20/0) from c012de72

while this is order 0 this is a GFP_ATOMIC allocation so it's sane too that
it failed.  Can you symbol-resolve the address "c012de72" so we know
who's doing this GFP_ATOMIC allocation? thanks. We could theoretically
shrink the cache also from GFP_ATOMIC but we should make a few spinlocks
irq spinlocks.

> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012de72
> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012de72
> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 2-order allocation failed
> (gfp=0x20/0) from c012de72
> Sep 17 19:04:17 admin kernel: cdda2wav __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012de72
> I cut out only a few to give you a hint. I patched the current->comm in myself,
> thats where the cdda2wav comes from.

Ok.

> Is it possible for you to make something like always at least one free page in
> every zone->order? If not try to "refill" the order queue? There must be some
> way to get rid of those alloc-failures.

Of course, as said that's probably the next step, but it won't be a free
page in every zone order, we'll do the work lazily as usual (only when
necessary, order > 0 allocations should be very unlikely, even more
unlikely should be order >0 allocations with GFP_ATOMIC, I believe the
right fix is to fix the caller that is allocating memory that way, but
of course on the long run we'll also try to defrag the ram, but this is
not a good reason for not fixing the drivers! :)

> I do an overnight test right now and have a look tomorrow morning how things
> went.

Ok.

> I'll be back,

thanks for the feedback. As said right now all kind of feedback is
welcome and I've a few other changes pending that looks attractive but
they hurts the wonderful dbench numbers so I didn't made them yet in the
hope dbench has some relation to real life too (and I can pretty much
see why the current algorithm works better than the other changes, it
wasn't developed to run well in dbench of course, it just incidentally
happened to be the best score in dbench).

Another detail: it happened that I was talking with David Mosemberg
about the ptrace races while working on the vm, so due an "editing in
the wrong tree error" there's now a leftover in the 80_vm-aa-1 patch in
signal.c, this patch should be backed out:

diff -urN vm-ref/kernel/signal.c vm/kernel/signal.c
--- vm-ref/kernel/signal.c	Mon Sep 17 01:26:12 2001
+++ vm/kernel/signal.c	Mon Sep 17 01:26:25 2001
@@ -382,7 +382,7 @@
 	switch (sig) {
 	case SIGKILL: case SIGCONT:
 		/* Wake up the process if stopped.  */
-		if (t->state == TASK_STOPPED)
+		if (t->state == TASK_STOPPED && !(t->ptrace & PT_PTRACED))
 			wake_up_process(t);
 		t->exit_code = 0;
 		rm_sig_from_queue(SIGSTOP, t);


but it's non fatal, just ignore it for now, it will be fixed in the next
-aa.  The only downside is that any SIGKILL or SIGCONT won't arrive to
the task while it's being ptraced.

Andrea
