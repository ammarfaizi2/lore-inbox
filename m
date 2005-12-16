Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVLPD3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVLPD3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVLPD3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:29:13 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17842 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932088AbVLPD3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:29:12 -0500
To: Matt Helsley <matthltc@us.ibm.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net,
       vserver@list.linux-vserver.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, pagg@oss.sgi.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization: Overview and Patches 
In-reply-to: Your message of Thu, 15 Dec 2005 18:20:52 PST.
             <1134699652.10396.161.camel@stark> 
Date: Thu, 15 Dec 2005 19:28:48 -0800
Message-Id: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Dec 2005 18:20:52 PST, Matt Helsley wrote:
> On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> > On Thu, 15 Dec 2005 09:35:57 EST, Hubertus Franke wrote:
> > > PID Virtualization is based on the concept of a container.
> > > The ultimate goal is to checkpoint/restart containers. 
> > > 
> > > The mechanism to start a container 
> > > is to 'echo "container_name" > /proc/container'  which creates a new
> > > container and associates the calling process with it. All subsequently
> > > forked tasks then belong to that container.
> > > There is a separate pid space associated with each container.
> > > Only processes/task belonging to the same container "see" each other.
> > > The exception is an implied default system container that has 
> > > a global view.
> 
> <snip>
> 
> > I think perhaps this could also be the basis for a CKRM "class"
> > grouping as well.  Rather than maintaining an independent class
> > affiliation for tasks, why not have a class devolve (evolve?) into
> > a "container" as described here.  The container provides much of
> > the same grouping capabilities as a class as far as I can see.  The
> > right information would be availble for scheduling and IO resource
> > management.  The memory component of CKRM is perhaps a bit tricky
> > still, but an overall strategy (can I use that word here? ;-) might
> > be to use these "containers" as the single intrinsic grouping mechanism
> > for vserver, openvz, application checkpoint/restart, resource
> > management, and possibly others?
> > 
> > Opinions, especially from the CKRM folks?  This might even be useful
> > to the PAGG folks as a grouping mechanism, similar to their jobs or
> > containers.
> > 
> > "This patchset solves multiple problems".
> > 
> > gerrit
> 
> CKRM classes seem too different from containers to merge the two
> concepts:

I agree that the implementation of pid virtualization and classes have
different characteristics.  However, you bring up interesting points
about the differences...  But I question whether or not they are
relevent to an implementation of resource management.  I'm going out
on a limb here looking at a possibly radical change which might
simplify things so there is only one grouping mechanism in kernel.
I could be wrong but...
 
> - Classes don't assign class-unique pids to tasks.

What part of this is important to resource management?  A container
ID is like a class ID.  Yes, I think container ID's are assigned to
processes rather than tasks, but is that really all that important?

> - Tasks can move between classes.
 
In the pid virtualization, I would think that tasks can move between
containers as well, although it isn't all that useful for most things.
For instance, checkpoint/restart needs to checkpoint a process and all
of its threads if it wants to restart it.  So there may be restrictions
on what you can checkpoint/restart.  Vserver probably wants isolation
at a process boundary, rather than a task boundary.  Most resource
management, e.g. Java, probably doesn't care about task vs. process.

> - Tasks move between classes without any need for checkpoint/restart.
 
That *should* be possible with a generalized container solution.
For instance, just like with classes, you have to move things into
containers in the first place.  And, you could in theory have a classification
engine that helped choose which container to put a task/process in
at creation/instantiation/significant event...

> - Classes show up in a filesystem interface rather that using a file
> in /proc to create them. (trivial interface difference)
 
Yep - there will probably be a /proc or /configfs interface to containers
at some point, I would expect.  No significant difference there.

> - There are no "visibility boundaries" to enforce between tasks in
> different classes.
 
Are there in virtualized pids?  There *can* be - e.g. ps can distinguish,
but it is possible for tasks to interact across container boundaries.
Not ideal for vserver, checkpoint/restart, for instance (makes c/r a
little harder or more limited - signals heading outside the container
may "disappear" when you checkpoint/restart but for apps that c/r, that
probably isn't all that likely).

> - Classes are hierarchial.
 
Conceptually they are.  But are they in the CKRM f series?  I thought
that was one area for simplification.  And, how important is that *really*
for most applications?

> - Unless I am mistaken, a container groups processes (Can one thread run
> in container A and another in container B?) while a class groups tasks.
> Since a task represents a thread or a process one thread could be in
> class A and another in class B.

Definitely useful, and one question is whether pid virtualization is
container isolation, or simply virtualization to enable container
isolation.  If it is an enabling technology, perhaps it doesn't have
that restriction and could be used either way based on resource management
needs or based on vserver or c/r needs...

Debate away... ;-)

gerrit
