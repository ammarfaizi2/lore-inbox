Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRJETt0>; Fri, 5 Oct 2001 15:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273115AbRJETtR>; Fri, 5 Oct 2001 15:49:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54280 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273108AbRJETtI>; Fri, 5 Oct 2001 15:49:08 -0400
Date: Fri, 5 Oct 2001 15:27:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: pre4 oom too soon
In-Reply-To: <Pine.LNX.4.21.0110051945080.1199-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0110051518110.2744-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Oct 2001, Hugh Dickins wrote:

> 2.4.11-pre4 gives me oom_kill I never got before.
> All numbers decimal in 4kB pages:
> 
> num_physpages         65520
> free or freeable      56000	(from MemFree after swapoff afterwards)
> total_swap_pages     132526
> prog tries to hog    153600
> 
> At oom_kill time:
> 
> all_zones_low           yes    (DMA & Normal well above min, no Highmem)
> nr_swap_pages             0
> page_cache_size       59013
> swapper_space.nrpages 58202
> 
> I'm not sure exactly what to blame in out_of_memory(), but it does
> look wrong to depend so much on whether nr_swap_pages happens to be
> 0 at that instant or not, and a lot of that full swap is duplicated
> in the swap cache.  Probably that should be taken into consideration?

The issue is that right now we're going to _check_ for OOM each time
kswapd_balance_pgdat is not able to make all zones have enough free
pages: That is way too fragile (I submitted the patch to Linus saying that
it was just a previa, and he included it anyway.. :))



        do {
                need_more_balance = 0;
                pgdat = pgdat_list;
                do
                        need_more_balance |= kswapd_balance_pgdat(pgdat);
                while ((pgdat = pgdat->node_next));
                if (need_more_balance && out_of_memory()) {
                        oom_kill();
                }
        } while (need_more_balance);

Note that a full kswapd_balance_pgdat() is going to scan only a small
portion of the lists. I'm pretty sure we have to guarantee kswapd scanned
at least all lists (maybe scanned all lists twice), before checking for
OOM.

I guess I'll not be able to write a patch to give us that behaviour
_today_, but I'll do so Monday if nobody else does.

