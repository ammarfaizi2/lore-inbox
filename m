Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUKIVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUKIVgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUKIVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:36:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:17537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261703AbUKIVgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:36:33 -0500
Date: Tue, 9 Nov 2004 13:40:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: balance_pgdat(): where is total_scanned ever updated?
Message-Id: <20041109134032.124b55fa.akpm@osdl.org>
In-Reply-To: <20041109180223.GG7632@logos.cnet>
References: <200411061418_MC3-1-8E17-8B6C@compuserve.com>
	<20041106161114.1cbb512b.akpm@osdl.org>
	<20041109104220.GB6326@logos.cnet>
	<20041109113620.16b47e28.akpm@osdl.org>
	<20041109180223.GG7632@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I had a patch which fixes it in -mm for a while.  It does increase the
> > > > number of pages which are reclaimed via direct reclaim and decreases the
> > > > number of pages which are reclaimed by kswapd.  As one would expect from
> > > > throttling kswapd.  This seems undesirable.
> > > 
> > > Hi Andrew,
> > > 
> > > Do you have any numbers to backup the claim "It does increase the
> > > number of pages which are reclaimed via direct reclaim and decreases the
> > > number of pages which are reclaimed by kswapd", please?
> > 
> > Run a workload and watch /proc/vmstat.  iirc, the one-line total_scanned
> > fix takes the kswapd-vs-direct reclaim rate from 1:1 to 1:3 or thereabouts.
> 
> You're talking about laptop_mode ONLY, then?

No, not at all.

If we restore the total_scanned logic then kswapd will throttle itself, as
designed.  Regardless of laptop_mode.  I did that, and monitored the page
scanning and reclaim rates under various workloads.  I observed that with
the fix in place, kswapd performed less page reclaim and direct-reclaim
performed more reclaim.  And I wasn't able to demonstrate any benchmark
improvements with the fix in place, so things are left as they are.

> How can that have any effect if may_writepage is ignored if !laptop_mode? 

This is to do with kswapd throttling.  If we put kswapd to sleep more
often, it does less scanning and reclaiming.

> About /proc/vmstat - each output is huge - do you actually read those?

yup.

	cat /proc/vmstat > /tmp/1
	run workload
	cat /proc/vmstat > /tmp/2
	analyse /tmp/1 and /tmp/2

> We need a vmstat like tool for that information to be readable.

Would be nice.

> > > Because linux-2.6.10-rc1-mm2 (and 2.6.9) completly ignores sc->may_writepage 
> > > under normal operation, its only used when laptop_mode is on:
> > > 
> > > 		if (laptop_mode && !sc->may_writepage)
> > > 			goto keep_locked;
> > > 
> > > Is this intentional ???
> > 
> > yup.  In laptop mode we try to scan further to find a clean page rather
> > than spinning up the disk for a writepage.
> 
> It might be interesting to use sc->may_writepage independantly of
> laptop mode (ie make kswapd only writeout pages if the reclaim ratio 
> is low).

sure.

