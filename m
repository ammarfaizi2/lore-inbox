Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbUKIThA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUKIThA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbUKIThA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:37:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:8077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261640AbUKITg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:36:56 -0500
Date: Tue, 9 Nov 2004 11:36:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: balance_pgdat(): where is total_scanned ever updated?
Message-Id: <20041109113620.16b47e28.akpm@osdl.org>
In-Reply-To: <20041109104220.GB6326@logos.cnet>
References: <200411061418_MC3-1-8E17-8B6C@compuserve.com>
	<20041106161114.1cbb512b.akpm@osdl.org>
	<20041109104220.GB6326@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Sat, Nov 06, 2004 at 04:11:14PM -0800, Andrew Morton wrote:
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > > Kernel version is 2.6.9, but I see no updates to this function in BK-current.
> > > How is total_scanned ever updated?  AFAICT it is always zero.
> > 
> > It's a bug which was introduced months ago when we added struct
> > reclaim_state.
> > 
> > > In mm/vmscan.c:balance_pgdat(), there are these references to total_scanned
> > > (missing whitepace indicated by "^"):
> > > 
> > > 
> > >  977:        int total_scanned, total_reclaimed;
> > > 
> > >  983:        total_scanned = 0;
> > > 
> > > 1076:                        if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
> > > 1077:                            total_scanned > total_reclaimed+total_reclaimed/2)
> > >                                                                ^ ^             ^ ^
> > > 
> > > 1088:                if (total_scanned && priority < DEF_PRIORITY - 2)
> > > 
> > > 
> > > Could this be part of the problems with reclaim?  Or have I missed something?
> > 
> > I had a patch which fixes it in -mm for a while.  It does increase the
> > number of pages which are reclaimed via direct reclaim and decreases the
> > number of pages which are reclaimed by kswapd.  As one would expect from
> > throttling kswapd.  This seems undesirable.
> 
> Hi Andrew,
> 
> Do you have any numbers to backup the claim "It does increase the
> number of pages which are reclaimed via direct reclaim and decreases the
> number of pages which are reclaimed by kswapd", please?

Run a workload and watch /proc/vmstat.  iirc, the one-line total_scanned
fix takes the kswapd-vs-direct reclaim rate from 1:1 to 1:3 or thereabouts.


> Because linux-2.6.10-rc1-mm2 (and 2.6.9) completly ignores sc->may_writepage 
> under normal operation, its only used when laptop_mode is on:
> 
> 		if (laptop_mode && !sc->may_writepage)
> 			goto keep_locked;
> 
> Is this intentional ???

yup.  In laptop mode we try to scan further to find a clean page rather
than spinning up the disk for a writepage.

> > I'm leaving this alone until it can be demonstrated that fixing it improves
> > kernel behaviour in some manner.
> 
> I dont see it working at all?
> 

There's lots of useful info in /proc/vmstat.
