Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVLQBpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVLQBpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 20:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVLQBpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 20:45:45 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:29420 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751354AbVLQBpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 20:45:45 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Matt Helsley <matthltc@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net,
       vserver@list.linux-vserver.org, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, pagg@oss.sgi.com
In-Reply-To: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
References: <E1En6H2-0005ok-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 17:38:08 -0800
Message-Id: <1134783488.10396.349.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 19:28 -0800, Gerrit Huizenga wrote:
> On Thu, 15 Dec 2005 18:20:52 PST, Matt Helsley wrote:
> > On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> > > On Thu, 15 Dec 2005 09:35:57 EST, Hubertus Franke wrote:
> > > > PID Virtualization is based on the concept of a container.
> > > > The ultimate goal is to checkpoint/restart containers. 
> > > > 
> > > > The mechanism to start a container 
> > > > is to 'echo "container_name" > /proc/container'  which creates a new
> > > > container and associates the calling process with it. All subsequently
> > > > forked tasks then belong to that container.
> > > > There is a separate pid space associated with each container.
> > > > Only processes/task belonging to the same container "see" each other.
> > > > The exception is an implied default system container that has 
> > > > a global view.
> > 
> > <snip>
> > 
> > > I think perhaps this could also be the basis for a CKRM "class"
> > > grouping as well.  Rather than maintaining an independent class
> > > affiliation for tasks, why not have a class devolve (evolve?) into
> > > a "container" as described here.  The container provides much of
> > > the same grouping capabilities as a class as far as I can see.  The
> > > right information would be availble for scheduling and IO resource
> > > management.  The memory component of CKRM is perhaps a bit tricky
> > > still, but an overall strategy (can I use that word here? ;-) might
> > > be to use these "containers" as the single intrinsic grouping mechanism
> > > for vserver, openvz, application checkpoint/restart, resource
> > > management, and possibly others?
> > > 
> > > Opinions, especially from the CKRM folks?  This might even be useful
> > > to the PAGG folks as a grouping mechanism, similar to their jobs or
> > > containers.
> > > 
> > > "This patchset solves multiple problems".
> > > 
> > > gerrit
> > 
> > CKRM classes seem too different from containers to merge the two
> > concepts:
> 
> I agree that the implementation of pid virtualization and classes have
> different characteristics.  However, you bring up interesting points
> about the differences...  But I question whether or not they are
> relevent to an implementation of resource management.  I'm going out
> on a limb here looking at a possibly radical change which might
> simplify things so there is only one grouping mechanism in kernel.
> I could be wrong but...

<snip>

> > - Classes don't assign class-unique pids to tasks.
> 
> What part of this is important to resource management?  A container
> ID is like a class ID.  Yes, I think container ID's are assigned to
> processes rather than tasks, but is that really all that important?

	Perhaps you misunderstood my point. Upon inserting a task into a
container you must assign it a pid unique within the container.
Inserting a task into a class requires no analogous operation. While
there is no conflict here neither is there commonality.

<snip>

> For instance, checkpoint/restart needs to checkpoint a process and all
> of its threads if it wants to restart it.  So there may be restrictions
> on what you can checkpoint/restart.  Vserver probably wants isolation
> at a process boundary, rather than a task boundary.  Most resource
> management, e.g. Java, probably doesn't care about task vs. process.

	I really don't see how Java itself is a good example of most resource
management. As I see it Java tries to present a runtime environment for
applications and it is the applications administrators are concerned
with.

	A process could allocate different roles to each thread or dole out
uniform pieces of work to each thread. Being able to manage the resource
usage of these threads could be useful -- so while Java may not "care"
about task vs. process an administrator might.

> > - Tasks move between classes without any need for checkpoint/restart.
>  
> That *should* be possible with a generalized container solution.
> For instance, just like with classes, you have to move things into
> containers in the first place.  And, you could in theory have a classification
> engine that helped choose which container to put a task/process in
> at creation/instantiation/significant event...

	Since arbitrary movement (time, source, and destination) is not
possible the classification analogy does not fit. This is one very big
difference between classes and containers that suggests merging the two
might not be best.

<snip>

> > - There are no "visibility boundaries" to enforce between tasks in
> > different classes.
>  
> Are there in virtualized pids?  There *can* be - e.g. ps can distinguish,
> but it is possible for tasks to interact across container boundaries.

	Right. I didn't say they were entirely invisible to each other. If they
were entirely visible to each other then these boundaries I'm talking
about wouldn't exist and a container would be more similar to a class. 

	These boundaries are probably delineated in miscellaneous areas of the
kernel like getpid(), kill(), any /proc file that shows a set of pids,
etc. Each of these would have to correctly limit the set of pids
displayed and/or accepted as input.

	A CKRM class on the other hand has no such boundaries to present to
userspace and hence does not alter code in such diverse places. I think
this is a consequence of the fact it doesn't virtualize resources for
the purposes of checkpoint/restart (esp. well-known and user-visible
resources like pids, filehandles, etc).

<snip>

> > - Classes are hierarchial.
>  
> Conceptually they are.  But are they in the CKRM f series?  I thought
> that was one area for simplification.  And, how important is that *really*
> for most applications?

	Hiearchy still exists in f-series. It's something Chandra has been
considering removing in order to simplify the code. I think hierarchy
offers a chance for administrators to better organize their classes. I
think the goal should be to enable administrators to let users manage a
class and/or subclasses of their own -- though implementing rcfs via
configfs limits config items to root currently. Perhaps this could be
useful for CKRM inside containers if each container had a virtual root
user id of its own with a corresponding non-zero id in container 0...

> > - Unless I am mistaken, a container groups processes (Can one thread run
> > in container A and another in container B?) while a class groups tasks.
> > Since a task represents a thread or a process one thread could be in
> > class A and another in class B.
> 
> Definitely useful, and one question is whether pid virtualization is

	Above you suggested that most resource management ("e.g. Java") doesn't
care about process vs. threads. Here you say it could be useful.

> container isolation, or simply virtualization to enable container
> isolation.  If it is an enabling technology, perhaps it doesn't have
> that restriction and could be used either way based on resource management
> needs or based on vserver or c/r needs...

	I thought that the point of pid virtualization was to enable
checkpoint/restart and that, as a consequence, moving processes to other
containers is impossible.

> Debate away... ;-)
> 
> gerrit

	The strongest disimilarity between the two I can see is the lack of
task movement between containers. The core similarity is the ability to
group. However, they don't group quite the same things -- from what I
can see containers group _trees of tasks_ with process (thread group)
granularity while classes group _tasks_ with thread granularity.

	At the very least I think we need to know the full extent of isolation
and interaction that are planned/necessary for containers before further
considering any merge proposals.

Cheers,
	-Matt Helsley

