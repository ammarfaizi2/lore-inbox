Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUIKRJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUIKRJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUIKRJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:09:18 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:59810 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268215AbUIKRIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:08:55 -0400
Date: Sat, 11 Sep 2004 10:07:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-Id: <20040911100731.2f400271.pj@sgi.com>
In-Reply-To: <20040911141001.GD32755@krispykreme>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	<20040911082834.10372.51697.75658@sam.engr.sgi.com>
	<20040911141001.GD32755@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm adding Andi Kleen, Iwamoto-san and Dave Hansen to the cc list, since
the numa code and other hotplug work might have similar considerations.

Anton asks:
> How does this change interact with CPU hotplug?

You beat my estimate ;).  I figured it would be a day before someone
asked this question.  It only took you six hours.  Good.

Cpusets and hotplug (CPU or Memory) aren't friends, yet.

Cpusets builds up additional data structures, used to manage a tasks CPU
and Memory placement.  If more CPUs or Memory are added later on,
cpusets won't know of them nor let you use them.  If CPUs or Memory are
removed later on, cpusets will still think it is ok to use them, and
potentially starve a task if that tasks cpuset had been configured to
_only_ allow using the now departed CPU or Memory.

When the move_task_off_dead_cpu() code in kernel/sched.c catches this,
the following code can break cpuset exclusive semantics if it decides
that a task has to be allowed to run anywhere because none of the places
it had been allowed are online anymore:

  kernel/sched.c: move_task_off_dead_cpu()

        /* No more Mr. Nice Guy. */
        if (dest_cpu == NR_CPUS) {
                        tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
                        if (!cpus_intersects(tsk->cpus_allowed, cpu_online_map))
                                cpus_setall(tsk->cpus_allowed);
                dest_cpu = any_online_cpu(tsk->cpus_allowed);

It wouldn't surprise me if Andi Kleen's numa code, especially the
MPOL_BIND which builds up special restricted zonelists holding only the
bound Memory Nodes, has the same sorts of interactions with Memory
hotplug.  However, I have not given this suspicion any careful thought,
so could easily be wrong.

The CPU placement code, prior to cpusets, had just been horsing the
task->cpus_allowed field around, which the CPU hotplug guys have been
able to deal with, adding or modifying code such as the above.  But the
numa Memory placement code (I suspect), and with cpusets now the CPU
placement code, build up additional structures that think they know
what's available and who can use it.  This assumption is violated when
stuff is plugged in and out.

Here's my current best shot at how to deal with this:

 1) For now, CONFIG_CPUSETS (and CONFIG_NUMA?) marked incompatible
    with CONFIG_HOTPLUG.

 2) Someday soon, the cpuset (and numa?) placement code needs to add an
    internal kernel call that the hotplug code can call to inform the
    placement code that a CPU or Memory resource has gone on or offline,
    so that the placement code can "deal with it", somehow.

 3) The way that I anticipate the cpuset code will "deal with it"
    will be:

      a] When a CPU or Memory is added, just add it to the top cpuset.
         User code can take it from there, adding the new resource
         to whatever lower level cpusets it wants to.

      b] When a CPU or Memory is about to be removed, walk the cpuset
	 tree from the bottom up, removing the resource, and if
	 that causes a particular cpuset to become empty (no more
	 online CPU or no more online Memory), then automatically
	 reassign any task attached to that cpuset to its parent
	 cpuset, and remove the soon to be empty cpuset.  If the
	 fine user doesn't like this default forced re-placement
	 to parent cpuset, they should have emptied that soon to be
	 useless cpuset of tasks before unplugging the hardware, and
	 attached those tasks to whatever cpuset met their fancy.
	 Or, if the removal could not have been anticipated, the
	 user code will just have to move tasks around after the
	 fact.

      c] The hotplug code should never add a CPU or Memory to what
         a task can use, without co-ordinating with the cpuset code.
         So fallback code such as the above call to cpus_setall()
         should involve cpusets somehow - whether asking it for the
         fallback CPUs to use, or telling it that this task just got
         force migrated to CPU_MASK_ALL - not sure which.

 4) Andi and the memory hotplug folks will have to speak to the question
    of whether this matters to the numa placement code, and what that
    might mean.

Suggestions?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
