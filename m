Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWJDVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWJDVlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWJDVla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:41:30 -0400
Received: from smtp-out.google.com ([216.239.33.17]:6969 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751163AbWJDVlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:41:14 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=pUJ2d2e4+9NwNZ8R9JIyOsaaXuxiCU93OlLXDFQqOWmgJDkxaunp0GUBIIOTOPhfD
	YCV+Ph5IjKuTph/bRhV/w==
Message-ID: <6599ad830610041440n74056262v63528c0d22ca5cb8@mail.gmail.com>
Date: Wed, 4 Oct 2006 14:40:58 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [RFC][PATCH 0/4] Generic container system
Cc: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, winget@google.com, mbligh@google.com,
       rohitseth@google.com, jlan@sgi.com, Joel.Becker@oracle.com,
       Simon.Derr@bull.net
In-Reply-To: <1159988217.24266.60.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002095319.865614000@menage.corp.google.com>
	 <1159925752.24266.22.camel@linuxchandra>
	 <6599ad830610031934s41994158o59f1a2e58b1cb45e@mail.gmail.com>
	 <1159988217.24266.60.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > The filesystem was lifted straight from cpuset.c, and hence isn't a
> > reimplementation, it's a migration of code already in the tree. Wasn't
>
> Ok. I can't call it re-implementing :). But, I guess you get the point.
> This is an oppurtunity to remove the filesystem implementation and use
> existing infrastructure, configfs. configfs didn't exist when cpuset
> went in, otherwise they might have chosen to use it instead of writing
> their own.

I guess I'm mostly agnostic about this issue. But looking at the
configfs interfacing code in rgcs.c versus the filesystem detail code
in container.c, it's about 200 lines vs 300 lines, so not exactly a
huge complexity saving.

> Yes, Joel is aware of it and is open to make that change.
> http://marc.theaimsgroup.com/?l=ckrm-tech&m=115619222129067&w=2. Having
> a in-tree user (this infrastructure + cpuset) for that feature will
> increase the need for it.

Great - when that happens I'd be much happier to move over configfs.

>
> My concern is that the container _will_ be considered empty if there is
> no task attached with the container _and_ there is no sub-container.

Right, that's the definition of an empty container.

>
> CKRM/RG would want a empty container to exist.

Even if the user wants to be told when it's OK to clean up their RG containers?

I don't see why this is a problem - all this does is allows the user
(*if* they want to) to get a callback when there's no longer anything
alive in the container. It doesn't cause the container to be removed,
without additional explicit action from userspace.

I don't see it as a feature that I'd make much use of myself, but it
preserves the existing cpusets API.

>
> cpuset may be happy today. But, It will not be happy when there are tens
> of other container subsystems use the same locks to protect their own
> data structures. Using such coarse locking will certainly affect the
> scalability.

The locks exported by the container system simply guarantee:

- if you hold container_manage_lock(), then no-one else will make any
changes to the core container groupings, and you won't block readers

- if you hold container_lock(), then no changes will be made to the
container groupings.

While there's nothing to stop a container subsystem from also using
them to protect its own data, there's equally nothing to stop a
container subsystem from using its own finer-grained locking, if it
feels that it needs to. E.g. the simple cpu_acct subsystem that I
posted as an example has a per-container spinlock that it uses to
protect the cpu stats for that container. So the callback doesn't need
to take either container_lock() or container_manage_lock(), it just
has to ensure it's in an rcu_read_lock() section and takes its own
spinlock.

> No questions about that. But, do recall BKL and how much effort has gone
> in to break it to add scalability ( I am not saying that these locks are
> same as that). When we are starting afresh, why not start with
> scalability in mind.

Looking at the group_lock in RG (including memrc and cpurc), the only
places that it appears to get taken are when creating and destroying
groups, or when changing shares. These are things that are going to be
done by the middleware - how many concurrent middleware systems are
you expecting to need to scale to? :-)

Incidentally, I have a few questions about the locking in the example
numtasks controller:

- recalc_and_propagate() does:

  lock rgroup->group_lock
  for each child:
    lock child->group_lock
    recalc_and_propagate(child)

So the first thing that the recursive call does is to take the lock
that the previous level of recursion has already taken. How's that
supposed to work?

E.g.

cd /mnt/configfs/res_groups
mkdir foo
echo -n res=numtasks,min_shares=10,max_shares=10 > shares

causes a lockup.

- in dec_usage_count() when a task exits, am I right that the only
locking done is on the group from which the task exited? The calls can
cascade up to the parent if cnt_borrowed is non-zero. In that case, in
the situation where the parent and two child groups each have a
cnt_borrowed of 1, what's to stop the dec_usage_count() calls racing
with one another in the parent, hence leaving parent->cnt_borrowed at
-1, and both calling dec_usage_count() on the grandparent?

I realise that these issues can be fixed, but they do serve to
illustrate the pitfalls (or at least, reduced clarity) associated with
fine-grained locking ...

>
> My thinking was like this: cpuset was the first user of this interface,
> any future container subsystem writers will certainly use cpuset as an
> example to write their subsystems. In effect, use the container-global
> locks to protect their data structures, which is not good in the long
> run.

Fair point. I'll see about reducing some of the coarse-grained locking
in cpuset.c. But a lot of the time, the cpuset code needs to be able
to prevent both changes to current->cpuset, and changes to its
reference - so it has to take container_lock() anyway, and might as
well use that as the only lock, rather than having to take two locks.

One optimization would be to have callback_mutex be an rwsem, so we
could export container_lock()/container_unlock() as well as
container_read_lock() and container_read_unlock(). (PaulJ, any
thoughts on that?)

> > > - Tight coupling of subsystems: I like your idea (you mentioned in a
> > >   reply to the previous thread) of having an array of containers in task
> > >   structure than the current implementation.
> >
> > Can you suggest some scenarios that require this?
>
> Consider a scenario where you have only the system level cpuset and have
> multiple RGs. With this model you would be forced to create multiple
> cpusets (with the same set of cpus) so as to allow multiple RG's.

No - see the intro to this patch set. I added a "<subsys>_enabled"
file for each subsystem, managed by the container.c code; if this is
set to 0, then child containers inherit the same per-subsystem state
for that subsystem as the root container.

So if you do echo 0 > /mnt/container/cpuset_enabled, and create child
containers, you still only have one cpuset.

> Now,
> consider you want to create a cpuset that is a subset of the high level
> cpuset, where in the hierarchy you would create this cpuset (at top
> level or one level below) ?

For a distinct set of tasks, or for the same set of tasks? If the
former, then it can be a new hierarchy under the top-level, no
problem. If it's for the same set of tasks then you'd need to give
more details about how/why you're trying to split up resources. I
would imagine that almost all situations like this, there would be a
natural way to split things up hierarchically. E.g. you want to pin
each customer's tasks on to a particular set of nodes (so use cpuset
parameters at the top level) and within those you want to let the
customer have different groups of tasks with e.g. different memory
limits (so use RG mem controller parameters at the next level)

Paul
