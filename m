Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUHKUlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUHKUlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268196AbUHKUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:41:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57740 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268229AbUHKUkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:40:51 -0400
Date: Wed, 11 Aug 2004 13:40:18 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-Id: <20040811134018.1551e03b.pj@sgi.com>
In-Reply-To: <20040811180558.GA4066@in.ibm.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040811131155.GA4239@in.ibm.com>
	<20040811091732.411edb6d.pj@sgi.com>
	<20040811180558.GA4066@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> Another approach that might work, in order to ensure that the top_cpuset
> has its cpus_allowed set to the proper value of cpu_possible_map, would
> be to add a routine, say cpuset_init_smp(),

Dinakar replied:
> Yes that would be fine too.

Since I've gotten this far without having the definition of 'struct cpuset'
exposed in a header file, I'd like to see if I can continue that.  I'll
give this other approach a try - though it will be a day or so before I
can get to it - prior commitments.  Unless of course, someone sends me such
a patch first ;).

Paul wrote:
> If you take your approach, should we remove the __init qualifier from
> kernel/cpuset.c cpuset_init()?

Dinakar replied:
> The qualifier would still be valid I think, no ?

What led me to ask that question was the following bit of code at the
bottom of start_kernel(), in init/main.c:

=========================================================
        /* rootfs populating might need page-writeback */
        page_writeback_init();
#ifdef CONFIG_PROC_FS
        proc_root_init();
#endif
        cpuset_init();

        check_bugs();

        /* Do the rest non-__init'ed, we're now alive */
        rest_init();
}
=========================================================

Since this is where your patch was moving the cpuset_init() call _away_
from, in order to put the call later, I took the comment about
"non-__init'ed" to mean that your patch was moving the cpuset_init()
call past the place where an __init qualifier was valid.

But I haven't studied the code to know this for sure, and if my other
scheme pans out to address the problem you found (that cpu_possible_map,
upon which cpuset initialization depends, does not get fully initialized
until smp_prepare_cpus gets called by init(),) then this detail won't
matter anyway.

However an equivalent detail would matter.  Can I mark cpuset_init_smp()
as "__init" ?  Hmmm ... likely I can, since two routines called at the
same time, sched_init_smp() and smp_init(), are marked __init.  This
suggests that my interpretation of that comment was wrong, and that
you're entirely right -- calls made in either place can be marked
__init.  Is that comment above misleading?


> A related Q, I was wondering why the nodemask_t needed to be part 
> of the task_struct, since cpuset would anyway have a reference to it.

Good question.

The nodemasks current->mems_allowed and current->cpuset->mems_allowed,
can be out of sync, by design.  Changes made via the cpuset file system
affect the second of these.  But not until the affected task goes
through the numa code in an mbind or set_mempolicy system call does that
task pick up the new value of mems_allowed and put it in its task struct
as current->mems_allowed to control memory placement.

This seems necessary, because there is no way for one task to affect
anothers mm, vma and zonelist structures.  So all of these structures
must be managed directly by a task on itself.  So a tasks mems_allowed,
which must be consistent with its zonelists, must also be managed
directly by itself.

If one task directly manipulated anothers current->mems_allowed, we
could end up in the situation that a task had done say an MPOL_BIND
setting up some zonelists for one set of nodes, then had its
current->mems_allowed changed to some non-overlapping set, leaving the
task completely unable to allocate memory on its own behalf, which would
likely send us into portions of the allocator code we should only arrive
in if very short on memory and desperate, which risks causing further
grief to the rest of the system ... not good (tm).

Hmmm ... as I write this, I am suspecting that there is a bit of code
that is missing in this solution.  Any given task may have multiple
memory policies, a default one (set_mempolicy) and zero or more ones
specific to some range of memory (mbind).  We must deal with the case
that any change in a tasks current->mems_allowed could break any of the
memory policies affecting it (leave the policy non-overlapping with the
mems_allowed).  My crystal ball sees some more nodemasks, perhaps one
per numa struct mempolicy, and a little bit more code, in my future ;).
I'll have to think about this.  Suggestions welcome.

As I said -- good question.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
