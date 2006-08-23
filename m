Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWHWLgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWHWLgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWHWLgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:36:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36490 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932389AbWHWLf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:35:59 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	<m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
	<20060823072256.7d931f8b.kamezawa.hiroyu@jp.fujitsu.com>
	<m1ac5woube.fsf@ebiederm.dsl.xmission.com>
	<20060823173323.b9cf1509.kamezawa.hiroyu@jp.fujitsu.com>
Date: Wed, 23 Aug 2006 05:35:08 -0600
In-Reply-To: <20060823173323.b9cf1509.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Wed, 23 Aug 2006 17:33:23 +0900")
Message-ID: <m1r6z7ofbn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> On Wed, 23 Aug 2006 00:11:17 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
>> 
>> > On Tue, 22 Aug 2006 10:56:08 -0600
>> > ebiederm@xmission.com (Eric W. Biederman) wrote:
>> The core problem is not when there is a single user.  The problem is
>> that no matter how large the system gets we have a single lock.  So it
>> gets increasingly contended.
>
>> I almost removed the tasklist_lock from all read paths.  But as it
>> happens sending a signal to a process group is an atomic operation
>> with respect to fork so that path has to take the lock, or else
>> we get places where "kill -9 -pgrp" fails to kill every process in
>> the process group.  Which is even worse.
>> 
> Hmm, maybe tasklist_lock covers too wide area.
> we can add some other (RCU) lock just for linked list from init_task.tasks.
> And pid_alive() will help people who want to access not stale task.
>
> Now, job in fork() is
> - set cpu allowed 
> - set parent
> - attach pgid, sid
> - add to linked list from init_task
> - attach pid
>
> Then, adding for_each_alive_process() and new (RCU) lock for
> linked_list_from_init_task_lock (divide lock) and change job as
>
> - set cpu allowed
> - set parent
> - attach pgid, sid
> - attach pid
> new_list_writelock()
> - add to linked list
> new_list_writeunlock()
>
> may reduce contention. for_each_alive_process() will do
>
> rcu_readlock()
> for (task =....)
> 	if (!pid_alive(task))
> 		continue;
> rcu_readunlock();
>
> Is this bad ?

What you are proposing is to reduce contention by having several different
locks for each of the global data structures.  The process tree, the task list,
the process groups and the sessions.  If this was all a really hot spot
then doing that might be useful.  In practice it doesn't really
address the problem that we have.  We have global locks we need to
take, and we have global data structures we need to modify.  The
result are global cache line bounces every time you write to the data
structure.

With purely reads on such a global data structure you are probably ok,
with respect to scalability as you can get shared cache lines.
Writing to a global data structure that is heavily read will generally
scale badly, simply because of cache line bounces.

So until some clever person figures out how to refactor the data
structures so we they are not global it is probably best not modify
them if we can avoid it.

>> >> In addition you only solves half the readdir problems.  You don't solve
>> >> the seek problem which is returning to an offset you had been to
>> >> before.  A relatively rare case but...
>> >> 
>> > Ah, I should add lseek handler for proc root. Okay.
>> 
>> Hmm.  Possibly.  Mostly what I was thinking is that a token in the
>> list simply cannot solve the problem of a guaranteeing lseek to a
>> previous position works.  I really haven't looked closely on
>> how you handle that case.
>> 
> I'll try some. But lseek on directory, which is modified at any moment, cannot
> work stable anyway.

It can work as well as anything else in readdir.  It can ensure that you don't
miss things that haven't been added or deleted during the while you are in
the middle of readdir.    I'm just after the usual Single Unix Spec/POSIX guarantees.
The same thing that are missing in the current readdir implementation.

I think the ideal case for a readdir would be a sequence number that
always increases, that is assigned each time a new directory entry (in
our case a task) is created.  This will ensure we see everything new
but not everything old.  The problem with that approach is that
all such counters eventually wrap.  The core problem is that we have
to give out an indefinite number of tokens that last for an indefinite
amount of time.

If we relax the rules and allow ourselves to miss new directory
entries then anything that provides a total ordering of the
entries, allows us to export the key by which the total ordering
is defined to user space, and provides the concept of finding the
entry at or after this key provides us with what we need to implement
a solid readdir implementation complete with supporting seeks.

>> > My patch's point is just using task_list if we can, because it exists for
>> > keeping
>> > all tasks(tgids).
>> 
>> One of the reasons I have an issue with it, is that with the
>> impending introduction of multiple pid spaces is that the task list
>> really isn't what we want to traverse.
>> 
> Yes, scanning the whole space is not good.
> I think this can be handlerd by task_lists per pid-space.
> Is pidmap is maintained per pid-space ?

It will be.  It pretty much has to be, and the actual accessor function
did not actually assume you were using the pid bitmap.  Merely that you
could traverse through pids in order.

Eric
