Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUJDTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUJDTsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUJDToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:44:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:7300 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268410AbUJDTkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:40:43 -0400
Message-Id: <200410041146.i94Bi54h012775@owlet.beaverton.ibm.com>
To: Paul Jackson <pj@sgi.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement 
In-reply-to: Your message of "Sun, 03 Oct 2004 17:45:39 PDT."
             <20041003174539.1652ea2b.pj@sgi.com> 
Date: Mon, 04 Oct 2004 04:44:05 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I move 'em.  I have user code that identifies the kernel threads
    whose cpus_allowed is a superset of cpus_online_map, and I put them
    in a nice little padded cell with init and the classic Unix daemons,
    called the 'bootcpuset'.

So the examples you gave before were rather oversimplified, then?
You talked about dividing up a 256 cpu machine but didn't mention that
some portion of that must be reserved for the "bootcpuset".  Would this
be enforced by the kernel, or the administrator?

I might suggest a simpler approach.  As a matter of policy, at least one
cpu must remain outside of cpusets so that system processes like init,
getty, lpd, etc. have a place to run.

    The tasks whose cpus_allowed is a strict _subset_ of cpus_online_map
    need to be where they are.  These are things like the migration
    helper threads, one for each cpu.  They get a license to violate
    cpuset boundaries.

Literally, or figuratively?  (How do we recognize these tasks?)

    I will probably end up submitting a patch at some point, that changes
    two lines, one in ____call_usermodehelper() and one in kthread(), from
    setting the cpus_allowed on certain kernel threads to CPU_MASK_ALL,
    so that instead these lines set that cpus_allowed to a new mask,
    a kernel global variable that can be read and written via the cpuset
    api.  But other than that, I don't need anymore kernel hooks than I
    already have, and even now, I can get everything that's causing me
    any grief pinned into the bootcpuset.

Will cpus in exclusive cpusets be asked to service interrupts?

Martin pointed out the problem with looking at overloaded cpus repeatedly,
only to find (repeatedly) we can't steal any of their processes.
This is a real problem, but exists today outside of any cpuset changes.
A decaying failure rate might provide a hint to the scheduler to alleviate
this problem, or maybe the direct route of just checking more thoroughly
from the beginning is the answer.

    So with my bootcpuset, the problem is reduced, to a few tasks
    per CPU, such as the migration threads, which must remain pinned
    on their one CPU (or perhaps on just the CPUs local to one Memory
    Node).  These tasks remain in the root cpuset, which by the scheme
    we're contemplating, doesn't get a sched_domain in the fancier
    configurations.

You just confused me on many different levels:

    * what is the root cpuset? Is this the same as the "bootcpuset" you
      made mention of?

    * so where *do* these tasks go in the "fancier configurations"?

    * what does it mean "not to get a sched_domain"?  That the tasks in
      the root cpuset can't move?  Can't run?  One solution to the
      problem Martin described is to completely split the hierarchy that
      sched_domain represents, with a different, disjoint tree for each
      group of cpus in a cpuset.  But wouldn't changing cpus_allowed
      in every process do the same thing? (Isn't that how this would be
      implemented at the lowest layer?)

I really haven't heard of anything that couldn't be handled adequately
through cpus_allowed so far other than "kicking everybody off a cpu"
which would need some new code.  (Although, probably not, now that I
think of it, with the new hotplug cpu code wanting to do that too.)

    If we just wrote the code, and quit trying to find a grand unifying
    theory to explain it consistently with the rest of our design,
    it would probably work just fine.

I'll assume we're missing a smiley here.

So we want to pin a process to a cpu or set of cpus: set cpus_allowed to
    that cpu or that set of cpus.
So we want its children to be subject to the same restriction: children
    already inherit the cpus_allowed mask of their parent.
We want to keep out everyone who shouldn't be here: then clear the
    bits for the restrictive cpus in their cpus_allowed mask when the
    restriction is created.

When you "remove a cpuset" you just or in the right bits in everybody's
cpus_allowed fields and they start migrating over.

To me, this all works for the cpu-intensive, gotta have it with 1% runtime
variation example you gave.  Doesn't it?  And it seems to work for the
department-needs-8-cpus-to-do-as-they-please example too, doesn't it?
The scheduler won't try to move a process to someplace it's not allowed.

Rick
