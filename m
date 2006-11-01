Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946873AbWKARUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946873AbWKARUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946942AbWKARUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:20:54 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5089 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946873AbWKARUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:20:53 -0500
Date: Wed, 1 Nov 2006 22:55:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101172540.GA8904@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <20061031115342.GB9588@in.ibm.com> <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:46:00AM -0800, Paul Menage wrote:
> The idea is that in general, people aren't going to want to have
> separate hierarchies for different resources - they're going to have
> the hierarchies be the same for all resources. So in general when they
> move a process from one container to another, they're going to want to
> move that task to use all the new resources limits/guarantees
> simultaneously.

Sure, a reasonable enough requirement.

> Having completely independent hierarchies makes this more difficult -
> you have to manually maintain multiple different hierarchies from
> userspace.

I suspect we can avoid maintaining separate hierarchies if not required.

        mkdir /dev/res_groups
        mount -t container -o cpu,mem,io none /dev/res_groups
        mkdir /dev/res_groups/A
        mkdir /dev/res_groups/B

Directories A and B would now contain res ctl files associated with all
resources (viz cpu, mem, io) and also a 'members' file listing the tasks
belonging to those groups.

Do you think the above mechanism is implementable? Even if it is, I dont know 
how the implementation will get complicated because of this requirement.

> Suppose a task forks while you're moving it from one
> container to another? With the approach that each process is in one
> container, and each container is in a set of resource nodes, at least

This requirement that each process should be exactly in one process container
is perhaps not good, since it will not give the fleixibility to define groups
unique to each resource (see my reply earlier to David Rientjes).

> the child task is either entirely in the new resource limits or
> entirely in the old limits - if userspace has to update several
> hierarchies at once non-atomically then a freshly forked child could
> end up with a mixture of resource nodes.

If the user intended to have a common grouping hierarchy for all
resources, then this movement of tasks can be "atomic" as far as user is
concerned, as per the above example:

        echo task_pid > /dev/res_groups/B/members

should cause the task transition to the new group in one shot?

> >I am thinking we can avoid maintaining these two hierarchies, by
> >something on these lines:
> >
> >        mkdir /dev/cpu
> >        mount -t container -ocpu container /dev/cpu
> >
> >                -> Represents a hierarchy for cpu control purpose.
> >
> >                   tsk->cpurc   = represent the node in the cpu
> >                                  controller hierarchy. Also maintains
> >                                  resource allocation information for
> >                                  this node.
> >
> 
> If we were going to do something like this, hopefully it would look
> more like an array of generic container subsystems, rather than a
> separate named pointer for each subsystem.

Sounds good.

> I think we have an overloading of terminology here. By "container" I
> just mean "group of processes tracked for resource control and other
> purposes". Can we use a term like "virtual server" if you're doing
> virtualization? I.e. a virtual server would be a specialization of a
> container (effectively analagous to a resource controller)

Ok, sure.

> >I suspect this may simplify the "container" filesystem, since it doesnt
> >have to track multiple hierarchies at the same time, and improve lock
> >contention too (modifying the cpu controller hierarchy can take a different
> >lock than the mem controller hierarchy).
> 
> Do you think that lock contention when modifying hierarchies is
> generally going to be an issue - how often do tasks get moved around
> in the hierarchy, compared to the other operations going on on the
> system?

I suspect the manipulation to resource group hierarchy (and the
resulting lock contention) will be more frequent than to the cpuset 
hierarchy, if we have to support scenarios like here:

	http://lkml.org/lkml/2006/9/5/178

I will try and get a better picture of how frequent would such task
migration be in practice from few people I know who are interested in this
feature within IBM.

-- 
Regards,
vatsa
