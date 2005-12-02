Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVLBDFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVLBDFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVLBDFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:05:24 -0500
Received: from hera.kernel.org ([140.211.167.34]:17591 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964809AbVLBDFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:05:23 -0500
Date: Thu, 1 Dec 2005 23:26:45 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, christoph@lameter.com,
       riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
       andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202012645.GA3834@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201150349.3538638e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 01, 2005 at 03:03:49PM -0800, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > Hi Andrew,
> > 
> > On Thu, Dec 01, 2005 at 02:37:14AM -0800, Andrew Morton wrote:
> > > Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > > >
> > > >  The zone aging rates are currently imbalanced,
> > > 
> > > ZONE_DMA is out of whack.  It shouldn't be, and I'm not aware of anyone
> > > getting in and working out why.  I certainly wouldn't want to go and add
> > > all this stuff without having a good understanding of _why_ it's out of
> > > whack.  Perhaps it's just some silly bug, like the thing I pointed at in
> > > the previous email.
> > 
> > I think that the problem is caused by the interaction between 
> > the way reclaiming is quantified and parallel allocators.
> 
> Could be.  But what about the bug which I think is there?  That'll cause
> overscanning of the DMA zone. 

There were about 12Mb of inactive pages on the DMA zone. You're hypothesis 
was that there were no LRU pages to be scanned on DMA zone?

> > The zones have different sizes, and each zone reclaim iteration
> > scans the same number of pages. It is unfair.
> 
> Nope.  See how shrink_zone() bases nr_active and nr_inactive on
> zone->nr_active and zone_nr_inactive.  These calculations are intended to
> cause the number of scanned pages in each zone to be
> 
> 	(zone->nr-active + zone->nr_inactive) >> sc->priority.  

True... Well, I don't know, then.

> > On top of that, kswapd is likely to block while doing its job, 
> > which means that allocators have a chance to run.
> 
> kswapd should only block under rare circumstances - huge amounts of dirty
> pages coming off the tail of the LRU. 

Alright. I don't know - what could be the problem, then? 

> > --- mm/vmscan.c.orig	2006-01-01 12:44:39.000000000 -0200
> > +++ mm/vmscan.c	2006-01-01 16:43:54.000000000 -0200
> > @@ -616,8 +616,12 @@
> >  {
> 
> Please use `diff -p'.
