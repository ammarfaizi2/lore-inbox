Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWCMAuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWCMAuQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 19:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWCMAuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 19:50:16 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:28874 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932300AbWCMAuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 19:50:14 -0500
Subject: Re: [Alsa-devel] Re: 2.6.15-rt20, "bad page state", jackd (alsa
	1.0.10 vs. recent kernels)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: cc@ccrma.Stanford.EDU, nando@ccrma.Stanford.EDU,
       Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net,
       Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44121351.2050703@yahoo.com.au>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <20060309084746.GB9408@osiris.boeblingen.de.ibm.com>
	 <1141938488.22708.28.camel@cmn3.stanford.edu>
	 <4410B2D7.4090806@yahoo.com.au>
	 <1141958866.22708.69.camel@cmn3.stanford.edu>
	 <441109BC.9070705@yahoo.com.au>
	 <1142016627.6124.33.camel@cmn3.stanford.edu>
	 <44121351.2050703@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 16:49:37 -0800
Message-Id: <1142210977.7471.27.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 11:01 +1100, Nick Piggin wrote:
> Fernando Lopez-Lezcano wrote:
> 
> > Takashi and other gurus in alsa-devel, any comments on this? The
> > original problem - not quoted in this email - is that when I stop jackd
> > in the affected configurations I get errors similar to this one:
> > 
> > 
> >>Bad page state at __free_pages_ok (in process 'jackd', page c1013ce0)
> >>flags:0x00000414 mapping:00000000 mapcount:0 count:0
> >>Backtrace:
> >> [<c015947d>] bad_page+0x7d/0xc0 (8)
> >> [<c01598fd>] __free_pages_ok+0x9d/0x180 (36)
> >> [<c015a5ac>] __pagevec_free+0x3c/0x50 (40)
> >> [<c015db47>] release_pages+0x127/0x1a0 (16)
> >> [<c016c93d>] free_pages_and_swap_cache+0x7d/0xc0 (80)
> >> [<c01681ae>] unmap_region+0x13e/0x160 (28)
> >> [<c0168461>] do_munmap+0xe1/0x120 (48)
> >> [<c01684df>] sys_munmap+0x3f/0x60 (32)
> >> [<c01034a1>] syscall_call+0x7/0xb (16)
> >>Trying to fix it up, but a reboot is needed
> > 
> 
> FWIW, this is a PageReserved page being freed. PageReserved does
> anything, and you instead need to ensure the page count is incremented
> in your ->nopage handler (ie. via get_page()).
> 
> > 
> > One other thing occurred to me (not tested yet)
> > 
> > - userspace regression in the module load code (so that in the end
> > modules from the in kernel tree get mixed with modules coming from the
> > externally compiled alsa tree). Very unlikely, I think, I could test for
> > this by removing the in kernel modules temporarily. 
> > 
> > I have problems in both:
> >   snd-ice1712 (midiman delta 66)
> >   snd-hdsp (rme hdsp)
> > but this seems to work fine:
> >   snd-echo3g (gina3g)
> > 
> > The interesting thing is that the one that works (snd-echo3g) has no
> > counterpat in the in kernel alsa tree - that is, only exists in the
> > add-on modules compiled externally. Coincidence?

Well, I found it. Finally. I diffed memalloc.c in the alsa kernel tree
with alsa stable 1.0.10 and googled for the obvious two chunks that
stood out :-)

It's apparently an old issue, see here and follow the thread:
  http://lkml.org/lkml/2005/11/21/9
So, 1.0.10 obviously did not include these two patches:

========
--- linux-2.6.15-old/acore/memalloc.c   2006-03-10 15:13:36.636282832
-0800
+++ linux-2.6.15/sound/core/memalloc.c  2006-01-02 19:21:10.000000000
-0800
@@ -267,6 +197,7 @@

        snd_assert(size > 0, return NULL);
        snd_assert(gfp_flags != 0, return NULL);
+       gfp_flags |= __GFP_COMP;        /* compound page lets parts be
mapped */
        pg = get_order(size);
        if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL) {
                mark_pages(virt_to_page(res), pg);
@@ -311,6 +242,7 @@
        snd_assert(dma != NULL, return NULL);
        pg = get_order(size);
        gfp_flags = GFP_KERNEL
+               | __GFP_COMP    /* compound page lets parts be mapped */
                | __GFP_NORETRY /* don't trigger OOM-killer */
                | __GFP_NOWARN; /* no stack trace print - this call is
non-critical */
        res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
========

With this in a short remote test 1.0.10 on top of 2.6.15-rt21 does not
generate the bad page messages I originally reported. Woohoo!

And 1.0.11rc3 apparently only includes one of the two patches. 

]# find . -type f -exec grep GFP_COMP {} \; -print
#ifndef __GFP_COMP
#define __GFP_COMP      0
./include/adriver.h
        gfp_flags |= __GFP_COMP;        /* compound page lets parts be
mapped */
                | __GFP_COMP    /* compound page lets parts be mapped */
./alsa-kernel/core/memalloc.c

I'll test 1.0.11rc3 asap to confirm whether adding the missing bit makes
a difference or not. I think I was getting the exact same error on
1.0.11rc3 but I have to make sure. 

Thanks for all the help!
-- Fernando


