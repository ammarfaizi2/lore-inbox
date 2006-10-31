Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423568AbWJaQqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423568AbWJaQqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423569AbWJaQqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:46:10 -0500
Received: from smtp-out.google.com ([216.239.33.17]:54974 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423568AbWJaQqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:46:09 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=J3G7ZsdUGzcf66ut4xSLVPO9GlCPCOCQbCIQ3BtzTIaECJeT489BbvXj06Gu+zXIC
	qsX+WOTwrAA/UIm97iKhA==
Message-ID: <6599ad830610310846m5d718d22p5e1b569d4ef4e63@mail.gmail.com>
Date: Tue, 31 Oct 2006 08:46:00 -0800
From: "Paul Menage" <menage@google.com>
To: vatsa@in.ibm.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: "Paul Jackson" <pj@sgi.com>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061031115342.GB9588@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061030031531.8c671815.pj@sgi.com>
	 <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
	 <20061030042714.fa064218.pj@sgi.com>
	 <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com>
	 <20061030123652.d1574176.pj@sgi.com>
	 <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com>
	 <20061031115342.GB9588@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> For the case where resource node hierarchy is different from process
> container hierarchy, I am trying to make sense of "why do we need to
> maintain two hierarchies" - one the actual hierarchy used for resource
> control purpose, another the process container hierarchy. What purpose
> does maintaining the process container hierarchy (in addition to the
> resource controller hierarchy) solve?

The idea is that in general, people aren't going to want to have
separate hierarchies for different resources - they're going to have
the hierarchies be the same for all resources. So in general when they
move a process from one container to another, they're going to want to
move that task to use all the new resources limits/guarantees
simultaneously.

Having completely independent hierarchies makes this more difficult -
you have to manually maintain multiple different hierarchies from
userspace. Suppose a task forks while you're moving it from one
container to another? With the approach that each process is in one
container, and each container is in a set of resource nodes, at least
the child task is either entirely in the new resource limits or
entirely in the old limits - if userspace has to update several
hierarchies at once non-atomically then a freshly forked child could
end up with a mixture of resource nodes.

>
> I am thinking we can avoid maintaining these two hierarchies, by
> something on these lines:
>
>         mkdir /dev/cpu
>         mount -t container -ocpu container /dev/cpu
>
>                 -> Represents a hierarchy for cpu control purpose.
>
>                    tsk->cpurc   = represent the node in the cpu
>                                   controller hierarchy. Also maintains
>                                   resource allocation information for
>                                   this node.
>

If we were going to do something like this, hopefully it would look
more like an array of generic container subsystems, rather than a
separate named pointer for each subsystem.

>
>         mkdir /dev/mem
>         mount -t container -omem container /dev/mem
>
>                 -> Represents a hierarchy for mem control purpose.
>
>                    tsk->memrc   = represent the node in the mem
>                                   controller hierarchy. Also maintains
>                                   resource allocation information for
>                                   this node.
>
>                    tsk->memrc->parent = parent node.
>
>
>         mkdir /dev/containers
>         mount -t container -ocontainer container /dev/container
>
>                 -> Represents a (mostly flat?) hierarchy for the real
>                    container (virtualization) purpose.

I think we have an overloading of terminology here. By "container" I
just mean "group of processes tracked for resource control and other
purposes". Can we use a term like "virtual server" if you're doing
virtualization? I.e. a virtual server would be a specialization of a
container (effectively analagous to a resource controller)

>
> I suspect this may simplify the "container" filesystem, since it doesnt
> have to track multiple hierarchies at the same time, and improve lock
> contention too (modifying the cpu controller hierarchy can take a different
> lock than the mem controller hierarchy).

Do you think that lock contention when modifying hierarchies is
generally going to be an issue - how often do tasks get moved around
in the hierarchy, compared to the other operations going on on the
system?

Paul
