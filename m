Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWARDKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWARDKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWARDKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:10:12 -0500
Received: from ns1.siteground.net ([207.218.208.2]:50597 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964884AbWARDKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:10:10 -0500
Date: Tue, 17 Jan 2006 19:09:59 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: Convert global dirty_exceeded flag to per-node node_dirty_exceeded
Message-ID: <20060118030959.GD5289@localhost.localdomain>
References: <20060117020352.GB5313@localhost.localdomain> <20060116181323.7a5f0ac7.akpm@osdl.org> <20060118012953.GC5289@localhost.localdomain> <20060117180956.7f2627a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117180956.7f2627a6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 06:09:56PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > On Mon, Jan 16, 2006 at 06:13:23PM -0800, Andrew Morton wrote:
> > > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > > >
> > > > Convert global dirty_exceeded flag to per-node node_dirty_exceeded.
> > > > 
> > > > dirty_exceeded ping pongs between nodes in order to force all cpus in
> > > > the system to increase the frequency of calls to balance_dirty_pages.
> > > > 
> > > > Currently dirty_exceeded is used by balance_dirty_pages_ratelimited to
> > > > force all CPUs in the system call balance_dirty_pages often, in order to
> > > > reduce the amount of dirty pages in the entire system (based on
> > > > dirty_thresh and one CPU exceeding thee ratelimits).  As dirty_exceeded
> > > > is a global variable, it will ping-pong between nodes of a NUMA system
> > > > which is not good.
> > > 
> > > Did you not test this obvious little optimisation?
> > 
> > We ran the test we encountered this problem on with your patch.
> > At first it looked like it did not help.  But later we found that there was
> > false sharing on this variable.
> 
> OK.  That's a bit nasty, isn't it?  It can work well or poorly for
> different people depending upon vagaries of .config and the linker.
> 
> We should find out what it was sharing _with_.  Could you please run
> 
> 	nm -n vmlinux| grep -C5 dirty_exceeded

ffffffff805290c0 b irq_dir
ffffffff80529838 b root_irq_dir
ffffffff80529880 B max_pfn
ffffffff80529888 B min_low_pfn
ffffffff80529890 B max_low_pfn
ffffffff80529900 B nr_pagecache
ffffffff80529908 B nr_swap_pages
ffffffff80529980 b boot_pageset
ffffffff8052a980 B laptop_mode
ffffffff8052a984 B block_dump
ffffffff8052a988 b dirty_exceeded
ffffffff8052a990 b total_pages
ffffffff8052a998 B nr_pdflush_threads
ffffffff8052a9a0 b last_empty_jifs
ffffffff8052a9c0 B slab_reclaim_pages
ffffffff8052a9c4 b slab_break_gfp_order
ffffffff8052a9c8 b g_cpucache_up
ffffffff8052a9d0 b cache_chain
ffffffff8052a9e0 b cache_chain_sem
ffffffff8052aa00 b offslab_limit
ffffffff8052aa08 B page_cluster

Maybe slab_reclaim_pages is the culprit? 

Thanks,
Kiran
