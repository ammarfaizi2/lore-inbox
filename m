Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262724AbRE3LB3>; Wed, 30 May 2001 07:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbRE3LBU>; Wed, 30 May 2001 07:01:20 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:39623 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S262724AbRE3LBC>; Wed, 30 May 2001 07:01:02 -0400
Date: Wed, 30 May 2001 11:59:50 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Jens Axboe <axboe@kernel.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>, andrea@e-mind.com
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010530115538.B15089@suse.de>
Message-ID: <Pine.LNX.4.21.0105301113550.7153-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Jens Axboe wrote:
> On Wed, May 30 2001, Mark Hemment wrote:
> > Hi Jens,
> > 
> >   I ran this (well, cut-two) on a 4-way box with 4GB of memory and a
> > modified qlogic fibre channel driver with 32disks hanging off it, without
> > any problems.  The test used was SpecFS 2.0
> 
> Cool, could you send me the qlogic diff? It's the one-liner can_dma32
> chance I'm interested in, I'm just not sure what driver you used :-)

  The qlogic driver is the one from;
	http://www.feral.com/isp.html
I find this much more stable than the one already in the kernel.
  It did just need the one-liner change, but as the driver isn't in the
kernel there isn't much point adding it change to your patch. :)


> >   I did change the patch so that bounce-pages always come from the NORMAL
> > zone, hence the ZONE_DMA32 zone isn't needed.  I avoided the new zone, as
> > I'm not 100% sure the VM is capable of keeping the zones it already has
> > balanced - and adding another one might break the camels back.  But as the
> > test box has 4GB, it wasn't bouncing anyway.
> 
> You are right, this is definitely something that needs checking. I
> really want this to work though. Rik, Andrea? Will the balancing handle
> the extra zone?

  In theory it should do - ie. there isn't anything to stop it.

  With NFS loads, over a ported VxFS filesystem, I do see some problems
between the NORMAL and HIGH zones.  Thinking about it, ZONE_DMA32
shouldn't make this any worse.

  Rik, Andrea, quick description of a balancing problem;
	Consider a VM which is under load (but not stressed), such that
	all zone free-page pools are between their MIN and LOW marks, with
	pages in the inactive_clean lists.

	The NORMAL zone has non-zero page order allocations thrown at
	it.  This causes __alloc_pages() to reap pages from the NORMAL
	inactive_clean list until the required buddy is built.  The blind
	reaping causes the NORMAL zone to have a large number of free pages
	(greater than ->pages_low).

	Now, when HIGHMEM allocations come in (for page cache pages), they
	skip the HIGH zone and use the NORMAL zone (as it now has plenty
	of free pages) - the code at the top of __alloc_pages(), which
	checks against ->pages_low.

	But the NORMAL zone is usually under more pressure than the HIGH
	zone - as many more allocations needed ready-mapped memory.  This
	causes the page-cache pages from the NORMAL zone to come under
	more pressure, and are "re-cycled" quicker than page-cache pages
	in the HIGHMEM zone.

  OK, we shouldn't be throwing too many non-zero page allocations at
__alloc_pages(), but it does happen.
  Also, the problem isn't as bad as it first looks - HIGHMEM page-cache
pages do get "recycled" (reclaimed), but there is a slight imbalance.

Mark

