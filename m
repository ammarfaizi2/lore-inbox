Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWJDS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWJDS5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWJDS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:57:04 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:8323 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750745AbWJDS5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:57:00 -0400
Subject: Re: [RFC][PATCH 0/4] Generic container system
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Paul Menage <menage@google.com>
Cc: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, jlan@sgi.com, Joel.Becker@oracle.com,
       Simon.Derr@bull.net
In-Reply-To: <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
References: <20061002095319.865614000@menage.corp.google.com>
	 <1159925752.24266.22.camel@linuxchandra>
	 <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 04 Oct 2006 11:56:57 -0700
Message-Id: <1159988217.24266.60.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 19:34 -0700, Paul Menage wrote:
> On 10/3/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > Hi Paul,
> >
> > Thanks for doing the exercise of removing the container part of cpuset
> > to provide some process aggregation.
> >
> > With this model, I think I agree with you that RG can be split into
> > individual controllers (need to look at it closely).
> >
> > I have few questions/concerns w.r.t this implementation:
> >
> > - Since we are re-implementing anyways, why not use configfs instead of
> >   having our own filesystem ?
> 
> The filesystem was lifted straight from cpuset.c, and hence isn't a
> reimplementation, it's a migration of code already in the tree. Wasn't

Ok. I can't call it re-implementing :). But, I guess you get the point.
This is an oppurtunity to remove the filesystem implementation and use
existing infrastructure, configfs. configfs didn't exist when cpuset
went in, otherwise they might have chosen to use it instead of writing
their own.

> there also a problem with the maximum output size of a configfs file,
> which would cause problems e.g. listing the task members in a
> container?

Yes, Joel is aware of it and is open to make that change.
http://marc.theaimsgroup.com/?l=ckrm-tech&m=115619222129067&w=2. Having
a in-tree user (this infrastructure + cpuset) for that feature will
increase the need for it.

> 
> > - I am little nervous about notify_on_release, as RG would want
> >   classes/RGs to be available even when there are no tasks or sub-
> >   classes. (Documentation says that the user level program can rmdir
> >   the container, which would be a problem). Can the user level program
> >   be _not_ called when there are other subsystems registered ? Also,
> >   shouldn't it be cpuset specific, instead of global ?
> 
> This again is taken straight from cpusets. The idea is that if you
> don't have some kind of middleware polling the
> container/cpuset/res_group directories to see if they're empty, you
> can instead ask the kernel to call you back (via
> "container_release_agent") at a point when a container is empty and

I understand the purpose and usage.

> hence removable. I don't think there's any guarantee that the
> container will still be empty by the time the userspace agent runs.

My concern is that the container _will_ be considered empty if there is
no task attached with the container _and_ there is no sub-container.

CKRM/RG would want a empty container to exist.

We can hack it around by artificially incrementing the counter, but it
will beat the original purpose of this feature. 

> 
> > - Export of the locks: These locks protect container data structures.
> >   But, most of the usages in cpuset.c are to protect the cpuset data
> >   structure itself. Shouldn't the cpuset subsystem have its own locks ?
> >   IMO, these locks should be used by subsystem only when they want data
> >   integrity in the container data structure itself (like walking thru
> >   the sibling list).
> 
> It would certainly be possible to have finer-grained locking. But the
> cpuset code seems pretty happy with coarse-grained locking (only one

cpuset may be happy today. But, It will not be happy when there are tens
of other container subsystems use the same locks to protect their own
data structures. Using such coarse locking will certainly affect the
scalability.

> writer at any one time) and having just the two global locks does make
> the whole synchronization an awful lot simpler. There's nothing to

No questions about that. But, do recall BKL and how much effort has gone
in to break it to add scalability ( I am not saying that these locks are
same as that). When we are starting afresh, why not start with
scalability in mind.

> stop you having additional analogues of the callback_mutex to protect
> specific data in a particular resource controller's private data.
> 
> My inclination would be to find a situation where generic fine-grained
> locking is really required before forcing it on all container

My thinking was like this: cpuset was the first user of this interface,
any future container subsystem writers will certainly use cpuset as an
example to write their subsystems. In effect, use the container-global
locks to protect their data structures, which is not good in the long
run.

> subsystems. The locking model in RG is certainly finer-grained than in
> cpusets, but don't a lot of the operations end up taking the
> root_group->group_lock anyway as their first action?
> 
Only if they are going to depend on the core data structure being intact
(like list traversal).

> > - Tight coupling of subsystems: I like your idea (you mentioned in a
> >   reply to the previous thread) of having an array of containers in task
> >   structure than the current implementation.
> 
> Can you suggest some scenarios that require this?

Consider a scenario where you have only the system level cpuset and have
multiple RGs. With this model you would be forced to create multiple
cpusets (with the same set of cpus) so as to allow multiple RG's. Now,
consider you want to create a cpuset that is a subset of the high level
cpuset, where in the hierarchy you would create this cpuset (at top
level or one level below) ?

Extend this scenario to multiple subsystems and see how complicated the
interface would become to the user.

If we have it this way, then the notify_on_release issue (above) will
disappear too.
> 
> Paul
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


