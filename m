Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVCaDax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVCaDax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVCaDax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:30:53 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:15515 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261928AbVCaDad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:30:33 -0500
To: Paul Jackson <pj@engr.sgi.com>
cc: Diego Calleja <diegocg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 0/8] CKRM: Core patch set 
In-reply-to: Your message of Wed, 30 Mar 2005 17:32:32 PST.
             <20050330173232.3ae4c791.pj@engr.sgi.com> 
Date: Wed, 30 Mar 2005 19:30:34 -0800
Message-Id: <E1DGqOA-0005CV-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Mar 2005 17:32:32 PST, Paul Jackson wrote:
> A question for the CKRM developers:
> 
>     What middleware packages, outside the kernel, exist or are
>     in the works that will rely on CKRM?
     
 Primarily, CKRM classes can be instantiated today by simple
 echo's into the /rcfs filesystem.  There isn't a big need for
 a complex middleware package to set up and use CKRM.

 However, there are some tools under way to provide a small CLI
 to help with the administration for those who want it.  There
 are also some pretty minimal rc scripts underway to ensure that
 classes are configured at boot time and/or saved and restored
 across reboots and a simple config file used by that rc script.

>     CKRM (like another project near and dear to me, cpusets)
>     strikes me as a "middleware foundation" facility, intended
>     to provide the essential kernel support required for some
>     serious enterprise software.  So perhaps in addition to
>     asking what end-users (of a combined kernel-middleware
>     platform) exist, we should also be asking who will be
>     directly using CKRM - directly layering middleware on top
>     of it.

 I'm sure you could plug this into some existing workload management
 tools - lots of companies have them for managing other OS's.  Getting
 them to manage Linux with CKRM should be pretty simple for any of
 them if you really want that sort of thing.

>     The details don't matter much and may have to remain
>     obscured in the competitive fog.  But the presence of
>     multiple groups lobbying for the same kernel infrastructure,
>     as an apparent basis for competing middleware products,
>     would I think weigh in CKRM's favor.

> My impression, which may not align with how the CKRM developers view
> things, is that CKRM is descendent from what have been called fair-share
> schedulers.  The following comes from the above email thread.
 
 CKRM is about ways of managing kernel resources - CPU would just be
 one of these.  Fairshare scheduling is similar in some respects to
 what a scheduler might need to do for such a capabilitiy.  But that
 isn't part of the code being put forward now or the set that is
 getting finalized on ckrm-tech for mainline right now.  Definitely
 useful, but a bit more challenging for getting a mainline mergeable
 version.

 BTW, one of your comments was that the word "class" was confusing.
 This may stem from the fact that there have been two approaches
 with the word "class" in them in CKRM.
 
 The first was that a class would be a set of resource upper/lower limits
 such as CPU, memory, number of tasks, getrlimit style resource limits,
 IO bandwidth, network connections, etc. that would be applied to some
 set of tasks.

 At last year's kernel summit, Linus suggested that classes should
 be unique to each resource, e.g. a task could be a member of a
 memory class, mem-A; a CPU resource class cpu-B, an IO resource
 class io-C.  So, now a class is specific to a resource and a task
 is effectively a member of a number of distinct and otherwise
 independent resource classes.

 The current code embodies the second definition of class, which
 provides some more useful independence of resources (they don't all
 need to tie into a common class infrastructure, which made the code
 a little more intertangled).

 With the current core code, a task is put into a particular resource
 class simply by echoes in the corresponding rcfs directory structure
 for that resource.

 A soon to be forthcoming updated patch provides a simple and a more
 interesting classification engine which allows you to specific rules
 about what processes are associated with which resource classes.
 E.g. all tasks with a particular uid can be put in the
 "oracle_mem_pig" class or all tasks with a particular gid may be
 put into the "video" scheduler class.  The classification engine allows
 for some more complex rules which are applied at task creation
 time, or at a few other points such as a change of real or effective
 uid/gid.

 In some respects, this provides for a *very* lightweight form of
 virtualization, by restricting a working set of tasks to a limited
 set of resources, without the hard boundaries of a UML or Xen style
 virtual machine.  This also allows protection for some workloads
 in the face of bursty traffic or workloads which are otherwise content
 to consume your entire machine, to the exclusion of all other activities
 on the machine.

gerrit

