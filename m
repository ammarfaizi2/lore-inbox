Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVCNTLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVCNTLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVCNTLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:11:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:48376 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261725AbVCNTKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:10:50 -0500
Date: Mon, 14 Mar 2005 11:10:10 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: haveblue@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 0/2 Buddy allocator with placement policy (Version 9) +
 prezeroing (Version 4)
Message-Id: <20050314111010.2137dcae.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0503141157330.12793@skynet>
References: <20050307193938.0935EE594@skynet.csn.ul.ie>
	<1110239966.6446.66.camel@localhost>
	<Pine.LNX.4.58.0503101421260.2105@skynet>
	<20050310092201.37bae9ba.pj@engr.sgi.com>
	<1110478613.16432.36.camel@localhost>
	<Pine.LNX.4.58.0503141157330.12793@skynet>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel wrote:
> I have not read up on cpuset before so I am assuming you are talking about
> http://www.bullopensource.org/cpuset/ so correct me if I am wrong.

Yes - that.  See also the kernel doc file:

	Documentation/cpusets.txt

> I agree that if cpuset is not
> widely used, it should not be the only way of setting policy.

Well ... cpusets just hit Linus tree four days ago, so I wouldn't expect
them to have achieved world domination quite yet ;).

Cpusets implement hardwall outer limits on cpu and memory usage.  The
tasks assigned to a cpuset are only allowed to work within that cpuset.

Within a cpuset, a job may use sched_setaffinity, set_mempolicy, mbind
and madvise to make fine grained placement and related policy choices
however it chooses, subject to the broad, hard constraints of the cpuset.

The imposition of a policy that says a task can't swap is usually, at
least where I see it used, a hard constraint, imposed externally on an
entire job, for the well being of the rest of the system:

    Waking up swappers imposes a burden on the rest of the
    system, which some jobs must not be allowed to do.

    And wasting further cpu cycles on a job that has exceeded
    its allowed memory when it wasn't supposed to (and hence
    no longer has any chance of substaining the in-memory
    performance required of it) is a waste of possibly expensive
    compute resources.

The natural place for such an externally imposed policy limiting overall
processor or memory usage by a group of tasks is, in my admittedly
biased view, the cpuset.

I envision a per-cpuset file, "policy_kill_no_swap", containing a
boolean "0" or "1" (actually, "0\n" or "1\n").  It defaults to "0".  If
set to "1" (by writing "1" to that file) then if any task in that cpuset
gets far enough in the mm/page_alloc.c:__alloc_pages() code to initiate
swapping, that task is killed instead.

I don't see any need to have any other way of specifying this policy
preference by a per task call such as set_mempolicy(2).  However if
others saw such a need, I'm open to considering it.

I don't view this fallback stuff like I see Mel describing it. I don't
see it as a passing a list of fallback alternatives to a single API.
Rather, each API need only specify one policy.  The only place
'fallback' comes into play is if there are multiple API's (such as both
set_mempolicy and cpusets) that affect the same decision in the kernel
(such as whether to let a task invoke swapping, or to kill it instead).
The 'fallback' is the chose of what API takes precedence here.  For
system wide imposed hardwall limitations, the cpuset should have its
policy enforced.  Within those limits, finer grained calls such as
set_mempolicy should prevail.

So, if others did make the case for a second, per-task, way of
specifying this 'kill_no_swap' policy, then:
 1) If a tasks cpuset policy_kill_no_swap is true, that prevails.
 2) Otherwise the per-task setting of kill_no_swap prevails.

The choices of where migration is allowed is separate, in my view,
and deserves its own policy flags.  I don't know what those flags
should be.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
