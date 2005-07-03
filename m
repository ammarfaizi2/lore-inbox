Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVGDBtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVGDBtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 21:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVGDBtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 21:49:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12243 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261447AbVGDBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 21:49:38 -0400
Date: Sun, 3 Jul 2005 17:53:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: Anthony DiSante <theant@nodivisions.com>, andrea@suse.de, akpm@osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killings, but I'm not out of memory!
Message-ID: <20050703205357.GA21166@logos.cnet>
References: <42C179D5.3040603@nodivisions.com> <1119977073.1723.2.camel@localhost.localdomain> <42C18031.50206@nodivisions.com> <1120049835.1176.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120049835.1176.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 29, 2005 at 02:57:15PM +0200, Alexander Nyberg wrote:
> > >>I'm running a 2.6.11 kernel.  I have 1 gig of RAM and 1 gig of swap.  Lately 
> > >>when my RAM gets full, the oom-killer takes out either Mozilla or 
> > >>Thunderbird (my two biggest memory hogs), even though my swap space is only 
> > >>20% full.  I still have ~800 MB of free swap space, so shouldn't the kernel 
> > >>push Moz or T-bird into swap instead of oom-killing it?  At their maximum 
> > >>memory-hogging capacity, neither Moz nor T-bird is ever using more than 200 MB.
> > >>
> > > You cut out the important part where it printed out memory usage
> > > information at the time of the OOM, please post it
> > > 
> > 
> > Oops.  I left that out because it line-wrapped so bad, and I didn't realize 
> > it was important.  Here it is:
> > 
> > ... oom-killer: gfp_mask=0x80d2
> > ... DMA per-cpu:
> > ... cpu 0 hot: low 2, high 6, batch 1
> > ... cpu 0 cold: low 0, high 2, batch 1
> > ... Normal per-cpu:
> > ... cpu 0 hot: low 32, high 96, batch 16
> > ... cpu 0 cold: low 0, high 32, batch 16
> > ... HighMem per-cpu:
> > ... cpu 0 hot: low 14, high 42, batch 7
> > ... cpu 0 cold: low 0, high 14, batch 7
> > ...
> > ... Free pages:       12536kB (112kB HighMem)
> > ... Active:240797 inactive:2399 dirty:0 writeback:0 unstable:0 free:3134 
> > slab:7144 mapped:240597 pagetables:1073
> > ... DMA free:4096kB min:68kB low:84kB high:100kB active:8260kB inactive:0kB 
> > present:16384kB pages_scanned:9052 all_unreclaimable? yes
> > ... lowmem_reserve[]: 0 880 1007
> > ... Normal free:8328kB min:3756kB low:4692kB high:5632kB active:827084kB 
> > inactive:9468kB present:901120kB pages_scanned:23361 all_unreclaimable? no
> > ... lowmem_reserve[]: 0 0 1023
> > ... HighMem free:112kB min:128kB low:160kB high:192kB active:127844kB 
> > inactive:128kB present:131008kB pages_scanned:135459 all_unreclaimable? yes
> > ... lowmem_reserve[]: 0 0 0
> > ... DMA: 0*4kB 28*8kB 16*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 
> > 1*2048kB 0*4096kB = 4096kB
> > ... Normal: 98*4kB 16*8kB 216*16kB 18*32kB 1*64kB 1*128kB 0*256kB 1*512kB 
> > 1*1024kB 1*2048kB 0*4096kB = 8328kB
> > ... HighMem: 0*4kB 2*8kB 2*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 
> > 0*1024kB 0*2048kB 0*4096kB = 112kB
> > ... Swap cache: add 166973, delete 149202, find 1714386/1723885, race 0+0
> > ... Free swap  = 781012kB
> > ... Total swap = 987988kB
> > ... Out of Memory: Killed process 30787 (thunderbird-bin).
> > ... Out of Memory: Killed process 18112 (thunderbird-bin).
> > ... Out of Memory: Killed process 18116 (thunderbird-bin).
> > ... Out of Memory: Killed process 18117 (thunderbird-bin).
> > ... Out of Memory: Killed process 18119 (thunderbird-bin).
> > ... Out of Memory: Killed process 8857 (thunderbird-bin).
> 
> Yeah this indeed looks strange. gfp_mask == GFP_HIGHUSER | __GFP_ZERO
> 
> iirc Andrea fixing up some all_unreclaimable bug in 2.6.11 but this
> looks like that for some reason it didn't go into the Normal zone which
> has plenty of free pages...

Anthony, are you certain that this was the only VM dump available? 

AFAICS the only possible explanation for a OOM kill manifestation under 
this conditions (free pages count in the normal zone is higher than 
its high watermark + lowmem reservation), is a higher order allocation.

Why the heck doesnt the OOM killer print the order of current allocation? 

Anyway, the current try_to_free_pages/alloc_pages interaction seem to 
continue susceptible to deliberate decisions, even after Nick changed
the algorithm to return success if the total count of reclaimed pages
is greater than SWAP_CLUSTER_MAX, instead of a single priority pass 
being greater than SWAP_CLUSTER_MAX.

It sounds to me that a more reliable indication of OOM is failure to 
free _any_ pages after a full priority decay.

Nick, Andrew? 

--- linux-2.6.11/mm/vmscan.c.orig       2005-07-03 11:02:15.000000000 -0300
+++ linux-2.6.11/mm/vmscan.c    2005-07-03 11:02:44.000000000 -0300
@@ -938,6 +938,8 @@
                if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
                        blk_congestion_wait(WRITE, HZ/10);
        }
+       /* return failure only if zero pages have been reclaimed */
+       ret = !!total_reclaimed;
 out:
        for (i = 0; zones[i] != 0; i++)
                zones[i]->prev_priority = zones[i]->temp_priority;
