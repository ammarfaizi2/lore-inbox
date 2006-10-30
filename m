Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWJ3Kvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWJ3Kvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbWJ3Kvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:51:42 -0500
Received: from smtp-out.google.com ([216.239.33.17]:19955 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161238AbWJ3Kvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:51:41 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=a+bhx5LjU9rQn2NhfIaxk27sY9MCRVQzKDaJgDn8EcQjjc1RPizcL8/YB5LGwVTPj
	kwfnxMog4d2QP0++yEfrQ==
Message-ID: <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
Date: Mon, 30 Oct 2006 02:51:24 -0800
From: "Paul Menage" <menage@google.com>
To: vatsa@in.ibm.com
Subject: Re: [RFC] Resource Management - Infrastructure choices
Cc: dev@openvz.org, sekharan@us.ibm.com, pj@sgi.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, rohitseth@google.com,
       balbir@in.ibm.com, dipankar@in.ibm.com, matthltc@us.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061030103356.GA16833@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/06, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
>         - Paul Menage's patches present a rework of existing code, which makes
>           it simpler to get it in. Does it meet container (Openvz/Linux
>           VServer) and resource management requirements?
>
>                 Paul has ported over the CKRM code on top of his patches. So I
>                 am optimistic that it meets resource management requirements in
>                 general.
>
>                 One shortcoming I have seen in it is that it lacks an
>                 efficient method to retrieve tasks associated with a group.
>                 This may be needed by few controllers implementations if they
>                 have to support, say, change of resource limits. This however
>                 I think could be addressed quite easily (by a linked list
>                 hanging off each container structure).

The cpusets code which this was based on simply locked the task list,
and traversed it to find threads in the cpuset of interest; you could
do the same thing in any other resource controller.

Not keeping a list of tasks in the container makes fork/exit more
efficient, and I assume is the reason that cpusets made that design
decision. If we really wanted to keep a list of tasks in a container
it wouldn't be hard, but should probably be conditional on at least
one of the registered resource controllers to avoid unnecessary
overhead when none of the controllers actually care (in a similar
manner to the fork/exit callbacks, which only take the container
callback mutex if some container subsystem is interested in fork/exit
events).

>
>                 - register/deregister themselves
>                 - be intimated about changes in resource allocation for a group
>                 - be intimated about task movements between groups
>                 - be intimated about creation/deletion of groups
>                 - know which group a task belongs to

Apart from the deregister, my generic containers patch provides all of
these as well.

How important is it for controllers/subsystems to be able to
deregister themselves, do you think? I could add it relatively easily,
but it seemed unnecessary in general.

>
> B. UBC
>
>         Framework to account and limit usage of various resources by a
>         container (group of tasks).
>
>         Provides a system call based interface to:
>
>                 - set a task's beancounter id. If the id does not exist, a new
>                   beancounter object is created
>                 - change a task's association from one beancounter to other
>                 - return beancounter id to which the calling task belongs
>                 - set limits of consumption of a particular resource by a
>                   beancounter
>                 - return statistics information for a given beancounter and
>                   resource.

I've not really played with it yet, but I don't see any reason why the
beancounter resource control concept couldn't also be built over
generic containers. The user interface would be different, of course
(filesysmem vs syscall), but maybe even that could be emulated if
there was a need for backwards compatibility.

>
> Consensus:
>
>         - Provide resource control over a group of tasks
>         - Support movement of task from one resource group to another
>         - Dont support heirarchy for now

Both CKRM/RG and generic containers support a hierarchy.

>         - Support limit (soft and/or hard depending on the resource
>           type) in controllers. Guarantee feature could be indirectly
>           met thr limits.

That's an issue for resource controllers, rather than the underlying
infrastructure, I think.

>
> Debated:
>         - syscall vs configfs interface
>         - Interaction of resource controllers, containers and cpusets
>                 - Should we support, for instance, creation of resource
>                   groups/containers under a cpuset?
>         - Should we have different groupings for different resources?

I've played around with the idea where the hierarchies of resource
controller entities was distinct from the hierarchy of process
containers.

The simplest form of this would be that at each level in the hierarchy
the user could indicate, for each resource controller, whether child
containers would inherit the same resource entity for that controller,
or would have a new one created. E.g. you could determine if, when you
create a child container, whether tasks in that container would be in
the same cpuset as the parent, or in a fresh cpuset; this would be
independent of whether they were in the same disk I/O scheduling
domain, or in a fresh child domain, etc. This would be an extension of
the "X_enabled" files that appear in the top-level container directory
for each container subsystem in my current patch.

At a more complex level, the resource controller entity tree for each
resource controller could be independent, and the mapping from
containers to resource controller nodes could be arbitrary and
different for each controller - so every process would belong to
exactly one container, but the user could pick e.g. any cpuset and any
disk I/O scheduling domain for each container.

Both of these seem a little complex for a first cut of the code, though.

Paul
