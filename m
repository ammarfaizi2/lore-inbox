Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVCJRlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVCJRlZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCJRh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:37:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60343 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262826AbVCJRXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:23:47 -0500
Date: Thu, 10 Mar 2005 09:22:01 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: haveblue@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9) +
 prezeroing (Version 4)
Message-Id: <20050310092201.37bae9ba.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0503101421260.2105@skynet>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>
	<1110239966.6446.66.camel@localhost>
	<Pine.LNX.4.58.0503101421260.2105@skynet>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman, responding to Dave Hansen 
> > The other thing is that we'll probably have to be a lot more strict
> > about how the allocations fall back.  Some users will probably prefer to
> > kill an application rather than let a kernel allocation fall back into a
> > user memory area.
> >
> 
> That will be a tad trickier because we'll need a way of specifying a
> "fallback policy" at configure time. However, the fallback policy is
> currently isolated within one while loop, having different fallback
> policies is doable. The kicker is that that there might be nasty
> interaction with the page reclaim code where the allocator is not falling
> back due to policy but the reclaim code things everything is just fine.

There is at least one, perhaps a few, policies that I'd like to see in
the current allocator as well.

In particular, I am working on preparing a patch proposal for a policy
that would kill a task rather than invoke the swapper.  In
mm/page_alloc.c __alloc_pages(), if one gets down to the point of being
about to kick the swapper, if this policy is enabled (and you're not
in_interrupt() and don't have flag PF_MEMALLOC set), then ask
oom_kill_task() to shoot us instead.  For some big HPC jobs that are
carefully sized to fit on the allowed memory nodes, swapping is a fate
worse than death.

The natural place (for me, anyway) to hang such policies is off the
cpuset.

I am hopeful that cpusets will soon hit Linus's tree.

Would it make sense to specify these buddy allocator fallback policies
per cpuset as well?

I'd be glad to investigate providing the cpuset part of the code,
exposing the appropriate boolean, enum, scalar or bitmap type(s) to user
land query and setting, as another file in each cpuset directory, if
that would facilitate this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
