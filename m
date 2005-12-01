Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVLAXE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVLAXE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVLAXE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:04:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932543AbVLAXE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:04:26 -0500
Date: Thu, 1 Dec 2005 15:03:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, christoph@lameter.com,
       riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
       andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201150349.3538638e.akpm@osdl.org>
In-Reply-To: <20051201222846.GA3646@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> Hi Andrew,
> 
> On Thu, Dec 01, 2005 at 02:37:14AM -0800, Andrew Morton wrote:
> > Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > >
> > >  The zone aging rates are currently imbalanced,
> > 
> > ZONE_DMA is out of whack.  It shouldn't be, and I'm not aware of anyone
> > getting in and working out why.  I certainly wouldn't want to go and add
> > all this stuff without having a good understanding of _why_ it's out of
> > whack.  Perhaps it's just some silly bug, like the thing I pointed at in
> > the previous email.
> 
> I think that the problem is caused by the interaction between 
> the way reclaiming is quantified and parallel allocators.

Could be.  But what about the bug which I think is there?  That'll cause
overscanning of the DMA zone.

> The zones have different sizes, and each zone reclaim iteration
> scans the same number of pages. It is unfair.

Nope.  See how shrink_zone() bases nr_active and nr_inactive on
zone->nr_active and zone_nr_inactive.  These calculations are intended to
cause the number of scanned pages in each zone to be

	(zone->nr-active + zone->nr_inactive) >> sc->priority.

> On top of that, kswapd is likely to block while doing its job, 
> which means that allocators have a chance to run.

kswapd should only block under rare circumstances - huge amounts of dirty
pages coming off the tail of the LRU.

> --- mm/vmscan.c.orig	2006-01-01 12:44:39.000000000 -0200
> +++ mm/vmscan.c	2006-01-01 16:43:54.000000000 -0200
> @@ -616,8 +616,12 @@
>  {

Please use `diff -p'.

