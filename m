Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267833AbUH1VCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267833AbUH1VCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUH1VCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:02:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267864AbUH1VCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:02:04 -0400
Date: Sat, 28 Aug 2004 22:58:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040828205823.GB8716@suse.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828151837.GD12772@fs.tum.de> <200408281932.05964.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408281932.05964.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28 2004, Denis Vlasenko wrote:
> On Saturday 28 August 2004 18:18, Adrian Bunk wrote:
> > The patch below does BUG -> BUG_ON conversions in mm/ .
> >
> > diffstat output:
> >  mm/bootmem.c    |    6 ++----
> >  mm/filemap.c    |    6 ++----
> >  mm/highmem.c    |   15 +++++----------
> >  mm/memory.c     |   12 ++++--------
> >  mm/mempool.c    |    5 +++--
> >  mm/mmap.c       |   12 ++++--------
> >  mm/mprotect.c   |    3 +--
> >  mm/msync.c      |    3 +--
> >  mm/page_alloc.c |    3 +--
> >  mm/pdflush.c    |    3 +--
> >  mm/shmem.c      |    3 +--
> >  mm/slab.c       |   30 ++++++++++--------------------
> >  mm/swap.c       |   12 ++++--------
> >  mm/swap_state.c |    6 ++----
> >  mm/swapfile.c   |    6 ++----
> >  mm/vmalloc.c    |    3 +--
> >  mm/vmscan.c     |   18 ++++++------------
> >  17 files changed, 50 insertions(+), 96 deletions(-)
> >
> >
> > Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> >
> > --- linux-2.6.9-rc1-mm1-full-3.4/mm/bootmem.c.old	2004-08-28
> > 16:25:18.000000000 +0200 +++
> > linux-2.6.9-rc1-mm1-full-3.4/mm/bootmem.c	2004-08-28 16:26:48.000000000
> > +0200 @@ -125,8 +125,7 @@
> >  	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
> >
> >  	for (i = sidx; i < eidx; i++) {
> > -		if (unlikely(!test_and_clear_bit(i, bdata->node_bootmem_map)))
> > -			BUG();
> > +		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
> >  	}
> >  }
> >
> > @@ -246,8 +245,7 @@
> >  	 * Reserve the area now:
> >  	 */
> >  	for (i = start; i < start+areasize; i++)
> > -		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
> > -			BUG();
> > +		BUG_ON(test_and_set_bit(i, bdata->node_bootmem_map));
> 
> BUG_ON is like assert(). It may be #defined to nothing.
> Do not place expression with side effects into it.

I've seen several write this, and I don't agree. I was the one that
introduced BUG_ON, actually, with the original bio patches in 2.5.1-pre.
I never intended it to be a nop, no more than making BUG() a nop would
be stupid. It was just short-hand for adding the unlikely() without the
readability problem.

BUG_ON(1); must always BUG(). That said, it's never wise to put
expressions with side-effects into macros.

-- 
Jens Axboe

