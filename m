Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264013AbUCZKoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbUCZKoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:44:07 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:4684 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S264013AbUCZKnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:43:55 -0500
Date: Fri, 26 Mar 2004 04:39:59 -0600
From: Robin Holt <holt@sgi.com>
To: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Migrate pages from a ccNUMA node to another
Message-ID: <20040326103959.GB14360@lnx-holt>
References: <4063F188.66DB690A@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4063F188.66DB690A@nospam.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 10:02:00AM +0100, Zoltan Menyhart wrote:
> 
> Migrate pages from a ccNUMA node to another.
> ============================================
> 
> 1. Hardware assisted migration
> ..............................
> 

We have found that "automatic" migration ends to result in the
system deciding to move the wrong pieces around.  Since applications
can be so varied, I would recommend we let the application decide
when it thinks it is beneficial to move a memory range to a nearby
node.

> 
> 2. Application driven migration
> ...............................
> 
> An application can exploit the forthcoming NUMA APIs to specify its initial
> memory placement policy.
> Yet what if the application wants to change its behavior ?

The placement policy doesn't really fit the bill entirely.  We are
currently tracking a problem with repeatability of a benchmark.  We
found that the newer libc we are using used to result in a newly
forked process touching a page before the parent did and therefore
the page, which had been marked COW, would, on the old libc end up
on the childs node for the child and parents node for the parent.
After the update, both pages ended up on the parents.

If you syscall would simply do the copy to the destination node
for COW pages, this would have worked terrifically in both cases.

> 
> 3. NUMA aware scheduler
> .......................
> 

Back to my earlier comment about magic.  This is a second tier of
magic.  Here we are talking about infering a reason to migrate based
on memory access patterns, but what if that migration results in
some other process being hurt more than this one is helped.

Honestly, we have beaten on the scheduler quite a bit and the "allocate
memory close to my node" has helped considerably.

One thing that would probably help considerably, in addition to the
syscall you seem to be proposing, would be an addition to the
task_struct.  The new field would specify which node to attempt
allocations on.  Before doing a fork, the parent would do a
syscall to set this field to the node the child will target.  It
would then call fork.  The PGDs et al and associated memory, including
the task struct and pages would end up being allocated based upon
that numa node's allocation preference.


What do you think of combining these two items into a single syscall?

> 
> User mode interface
> -------------------
> 
> This prototype of the page migration service is implemented as a system call,
> the different forms of which are wrapped by use of some small,
> static, inline functions.
> 
> NAME
>         migrate_ph_pages        - migrate pages to another NUMA node

At first, I thought "Wow, this could result in some nice admin tools."
The more I scratch my head on this, the less useful I see it, but
would not argue against it.

>         migrate_virt_addr_range - migrate virtual address range to another node

This one sounds good.

Thanks,
Robin Holt
