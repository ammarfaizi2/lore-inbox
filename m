Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVIUO6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVIUO6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVIUO6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:58:35 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:49315 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1751049AbVIUO6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:58:34 -0400
Date: Wed, 21 Sep 2005 16:58:33 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
Message-ID: <20050921145833.GA15682@janus>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 03:38:57PM +0100, Hugh Dickins wrote:
> On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> > This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.
> 
> It would be a good idea to CC Christoph Lameter, who I believe was the
> one who very intentionally moved most of these updates out to timer tick.
> Is that significantly missing updates?

Apparently: I use a private patch (see below) to expose mm->hiwater_vm
to userland via /proc to detect misbehaving processes and for measuring
worst case memory use by programs. from 2.6.12 on I'm constantly seeing
a lot of processes with hiwater_vm < total_vm.

> 2. You've missed the instance Dave Miller recently added in fs/compat.c.

Thanks. I'll add that.

> 
> 3. If these are to be peppered back all over, then the places where
>    total_vm changes and the places where rss changes are almost completely
>    disjoint, so it's lazy to be calling one function to do both all over.

I'll look into this.

> 
> 5. Please add appropriate CONFIG, dummy macros etc., so that no time
>    is wasted on these updates in all the vanilla systems which have no
>    interest in them - but maybe Christoph already has that well in hand.

I'm not sure where it's being used for, other than how I use it in which
case it probably should depend on CONFIG_PROC_FS:

--- ./fs/proc/task_mmu.c.orig	2005-07-07 14:22:12.000000000 +0200
+++ ./fs/proc/task_mmu.c	2005-09-16 13:51:56.000000000 +0200
@@ -14,6 +14,7 @@
 	text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK)) >> 10;
 	lib = (mm->exec_vm << (PAGE_SHIFT-10)) - text;
 	buffer += sprintf(buffer,
+		"VmPeak:\t%8lu kB\n"
 		"VmSize:\t%8lu kB\n"
 		"VmLck:\t%8lu kB\n"
 		"VmRSS:\t%8lu kB\n"
@@ -22,6 +23,7 @@
 		"VmExe:\t%8lu kB\n"
 		"VmLib:\t%8lu kB\n"
 		"VmPTE:\t%8lu kB\n",
+		mm->hiwater_vm << (PAGE_SHIFT-10),
 		(mm->total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
 		mm->locked_vm << (PAGE_SHIFT-10),
 		get_mm_counter(mm, rss) << (PAGE_SHIFT-10),


-- 
Frank
