Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVARBpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVARBpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVARBpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:45:19 -0500
Received: from ozlabs.org ([203.10.76.45]:26307 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261154AbVARBar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:30:47 -0500
Subject: Re: [patch 2/2] mm: Reimplementation of alloc_percpu
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <20050117183617.GC2322@impedimenta.in.ibm.com>
References: <20050117183014.GB2322@impedimenta.in.ibm.com>
	 <20050117183617.GC2322@impedimenta.in.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 12:30:32 +1100
Message-Id: <1106011832.30801.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 00:06 +0530, Ravikiran G Thirumalai wrote:
> Here's the alloc_percpu reimplementation changed to
> - Use qsort 
> - Use GFP_KERNEL|__GFP_HIGHMEM|__GFP_ZERO for BLOCK_MANAGEMENT_PAGES
>   (GFP_HIGHZERO would have been ideal)
> - Changed currency size to sizeof (int) from sizeof (void *) for better
>   utilization for small objects
> 
> The allocator can be easily modified to use __per_cpu_offset[] table at a later
> stage by: 
> 1. Allocating ALIGN(__per_cpu_end - __per_cpu_start, PAGE_SIZE) for the
>    static percpu areas and populating __per_cpu_offset[] offset table
> 2. Making PCPU_BLKSIZE same as the static per cpu area size above
> 3. Serving dynamic percpu requests from modules etc from blocks by
>    returning ret -= __per_cpu_offset[0] from a percpu block.  This way
>    modules need not have a limit on static percpu areas.

Unfortunately ia64 breaks (3).  They have pinned TLB entries covering
64k, which they put the static per-cpu data into.  This is used for
local_inc, etc, and David Mosberger loved that trick (this is why my
version allocated from that first reserved block for modules' static
per-cpu vars).

Hope that clarifies,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

