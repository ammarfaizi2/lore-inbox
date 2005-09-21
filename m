Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVIUPgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVIUPgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVIUPgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:36:20 -0400
Received: from gold.veritas.com ([143.127.12.110]:49158 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751084AbVIUPgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:36:20 -0400
Date: Wed, 21 Sep 2005 16:35:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <20050921145833.GA15682@janus>
Message-ID: <Pine.LNX.4.61.0509211621410.7001@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <20050921145833.GA15682@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 15:36:19.0493 (UTC) FILETIME=[365D1550:01C5BEC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> On Wed, Sep 21, 2005 at 03:38:57PM +0100, Hugh Dickins wrote:
> > On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> > > This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.
> > 
> > It would be a good idea to CC Christoph Lameter, who I believe was the
> > one who very intentionally moved most of these updates out to timer tick.
> > Is that significantly missing updates?
> 
> Apparently: I use a private patch (see below) to expose mm->hiwater_vm
> to userland via /proc to detect misbehaving processes and for measuring
> worst case memory use by programs. from 2.6.12 on I'm constantly seeing
> a lot of processes with hiwater_vm < total_vm.

Then just add an update_mem_hiwater() in your patch?  On one level,
of course, that's just a hack which will hide the deficiency from you.
But on another level, I suspect it'd be good enough.

Let's hear what Christoph has to say.

> > 5. Please add appropriate CONFIG, dummy macros etc., so that no time
> >    is wasted on these updates in all the vanilla systems which have no
> >    interest in them - but maybe Christoph already has that well in hand.
> 
> I'm not sure where it's being used for, other than how I use it in which
> case it probably should depend on CONFIG_PROC_FS:

CONFIG_FRANK_VM would be better.

> --- ./fs/proc/task_mmu.c.orig	2005-07-07 14:22:12.000000000 +0200
> +++ ./fs/proc/task_mmu.c	2005-09-16 13:51:56.000000000 +0200
> @@ -14,6 +14,7 @@
>  	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
>  	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
>  	buffer += sprintf(buffer,
> +		"VmPeak:\t%8lu kB\n"

Good naming.

>  		"VmSize:\t%8lu kB\n"
>  		"VmLck:\t%8lu kB\n"
>  		"VmRSS:\t%8lu kB\n"
> @@ -22,6 +23,7 @@
>  		"VmExe:\t%8lu kB\n"
>  		"VmLib:\t%8lu kB\n"
>  		"VmPTE:\t%8lu kB\n",
> +		mm->hiwater_vm << (PAGE_SHIFT-10),
>  		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
>  		mm->locked_vm << (PAGE_SHIFT-10),
>  		get_mm_counter(mm, rss) << (PAGE_SHIFT-10),

hiwater_vm would be much less contentious to update whenever total_vm
changes (perhaps in __vm_stat_account) than hiwater_rss.  But tomorrow
I fear we'll be seeing a /proc patch from Frank Rss...

I do keep wondering what's so interesting about this hiwater_vm
(but would regret proposing other statistics to gather instead):
perhaps you're showing it just because it's there?

Hugh
