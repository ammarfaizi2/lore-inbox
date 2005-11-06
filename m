Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVKFESz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVKFESz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVKFESz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:18:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20405 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932278AbVKFESz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:18:55 -0500
Date: Sat, 5 Nov 2005 20:18:41 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051105201841.2591bacc.pj@sgi.com>
In-Reply-To: <p73oe4z2f9h.fsf@verdi.suse.de>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051029171630.04a69660.pj@sgi.com>
	<p73oe4z2f9h.fsf@verdi.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Regarding cpumemset and alloc_pages. I recently rechecked
> the cpumemset hooks in there and I must say they turned out
> to be quite worse
> 
> In hindsight it would have been better to use the "generate
> zonelists for all possible nodes" approach you originally had
> and which I rejected (sorry) 
> 
> That would make the code much cleaner and faster.
> Maybe it's not too late to switch for that?
> 
> If not then the fast path definitely needs to be tuned a bit


(What Andi calls cpumemsets are what others call cpusets;
 I faked him out with a threatened name change that never
 happened. -pj)


Sure, this could be changed to the other scheme if we wanted.  Only
internals of the cpuset, mempolicy, and page_alloc code are affected.

I see only small differences in performance, between the two choices,
in most cases.

The current code in the kernel does the following:
  1) The cpuset_update_current_mems_allowed() calls in the
     various alloc_page*() paths in mm/mempolicy.c:
	* take the task_lock spinlock on the current task
	* compare the tasks mems_generation to that in its cpuset
  2) The first cpuset_zone_allowed() call or two, near the top
     of mm/page_alloc.c:__alloc_pages():
	* check in_interrupt()
	* check if the zone's node is set in task->mems_allowed

This task_lock spinlock, or some performance equivalent, is, I think,
unavoidable.

An essential difference between mempolicy and cpusets is that cpusets
supports outside manipulation of a tasks memory placement.  Sooner or
later, the task has to synchronize with these outside changes, and a
task_lock(current) in the path to __alloc_pages() is the lowest cost
way I could find to do this.

The one functional difference I know of affects mempolicy MPOL_BIND,
not cpusets.  This subset zonelist proposal provided higher quality
zonelists to MPOL_BIND, properly sorted to start the search on the
faulting node and working outward.

===

The alternative approach that Andi refers to, along with some analysis
of its tradeoffs, is visible at:

  http://lkml.org/lkml/2004/8/2/256
  Date: Mon, 2 Aug 2004 16:35:06 -0700 (PDT)
  Subject: [PATCH] subset zonelists and big numa friendly mempolicy MPOL_MBIND

Instead of passing a zonelist to __alloc_pages() with all the
systems nodes, and skipping over those zones on nodes not allowed,
this alternative would build custom zonelists for each cpuset and
each MPOL_BIND mempolicy, containing just the allowed nodes.  A set
of zonelists is needed, one for each node in the cpuset, each one
sorted differently so that we search for memory on the nodes closest
to the faulting node first.  This set of zonelists has to be packed
in, or otherwise they could eat alot of memory on large systems,
since they are N-squared in size, for the number of nodes in the set.

This should make Christoph Lameter happer too.  He has been complaining
that the zonelists used by MPOL_BIND are not properly sorted to
look on the nodes nearest the current one first.  The fancy subset
zonelists of my proposal provide properly sorted zonelists for
MPOL_BIND policies.

Work that would need to be done for this alternative:

 * recode __GFP_HARDWALL to replace the initial short zonelist
   with a longer zonelist if need be, and restart __alloc_pages.
 * convert some code in this old patch from bitmaps to nodemasks
 * add the cpuset hooks to these subset zonelists (the above patch
   just has the infrastructure and MPOL_BIND hooks)

Comparative benefits between the current implementation and this
alternative:

  Neutral:
    Systems with just one or a few memory nodes on the system won't
    notice much.

  Neutral:
    When there's enough free memory on the current node to meet the
    request, it won't make much difference.  A free page on the
    current node is found quickly enough, either way.

  Alternative wins:
    The limit case of searching across many nodes on a large system
    that is short of memory should save a few CPU cycles with this
    alternative.

  Alternative wins:
    The instruction cache footprint of __alloc_pages, when one is
    short of memory, should be a little smaller with this alternative.

  Current way wins:
    The kernel text size would likely grow a bit, as the code to pack
    zonelists is a couple pages.

  Alternative wins:
    It provides properly sorted zonelists for MPOL_BIND.

  Current way wins:
    It's less work - we've already got it.

  Alternative wins:
    Code esthetics - I haven't coded it, but I suspect that the
    alternative has a smaller, prettier impact on __alloc_pages().
    From the above Aug 2004 patch, one can see that the alternative
    definitely reduces the code size of mm/mempolicy.c, by removing
    some specialized MPOL_BIND code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
