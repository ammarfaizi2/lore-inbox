Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSHCAaa>; Fri, 2 Aug 2002 20:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSHCAaa>; Fri, 2 Aug 2002 20:30:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317349AbSHCAa3>;
	Fri, 2 Aug 2002 20:30:29 -0400
Message-ID: <3D4B2471.29EE6462@zip.com.au>
Date: Fri, 02 Aug 2002 17:31:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <3D4AE995.DFD862EF@zip.com.au> <Pine.LNX.4.44L.0208022113440.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 2 Aug 2002, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > This patch eliminates about 35% of the raw rmap setup/teardown overhead by
> > > adopting a new locking interface that allows the add_rmaps to be batched in
> > > copy_page_range.
> >
> > Well that's fairly straightforward, thanks.  Butt-ugly though ;)
> 
> It'd be nice if the code would be a bit more beautiful and the
> reverse mapping scheme more modular.

I changed it to, essentially:

foo()
{
	spinlock_t *rmap_lock = NULL;
	unsigned rmap_lockno = -1;
	...
	for (stuff) {
		cached_rmap_lock(page, &rmap_lock, &rmap_lockno);
		__page_add_rmap(page, ptep);
		..
	}
	drop_rmap_lock(&rmap_lock, &rmap_lockno);
}

See http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.30/daniel-rmap-speedup.patch

Fixing zap_pte_range pretty much requires the pagemap_lru_lock
rework; otherwise we couldn't hold the rmap lock across
tlb_remove_page().

> Remember that we're planning to go to an object-based scheme
> later on, turning the code into a big monolithic mesh really
> makes long-term maintenance a pain...

We have short-term rmap problems:

1) Unexplained pte chain state with ntpd
2) 10-20% increased CPU load in fork/exec/exit loads
3) system lock under heavy mmap load
4) ZONE_NORMAL pte_chain consumption

Daniel and I are on 2), Bill is on 4) (I think).
