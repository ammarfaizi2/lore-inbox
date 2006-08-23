Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWHWIbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWHWIbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWHWIbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:31:04 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:2017 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964773AbWHWIbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:31:01 -0400
Date: Wed, 23 Aug 2006 17:33:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
Message-Id: <20060823173323.b9cf1509.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m1ac5woube.fsf@ebiederm.dsl.xmission.com>
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	<m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
	<20060823072256.7d931f8b.kamezawa.hiroyu@jp.fujitsu.com>
	<m1ac5woube.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 00:11:17 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> > On Tue, 22 Aug 2006 10:56:08 -0600
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> The core problem is not when there is a single user.  The problem is
> that no matter how large the system gets we have a single lock.  So it
> gets increasingly contended.

> I almost removed the tasklist_lock from all read paths.  But as it
> happens sending a signal to a process group is an atomic operation
> with respect to fork so that path has to take the lock, or else
> we get places where "kill -9 -pgrp" fails to kill every process in
> the process group.  Which is even worse.
> 
Hmm, maybe tasklist_lock covers too wide area.
we can add some other (RCU) lock just for linked list from init_task.tasks.
And pid_alive() will help people who want to access not stale task.

Now, job in fork() is
- set cpu allowed 
- set parent
- attach pgid, sid
- add to linked list from init_task
- attach pid

Then, adding for_each_alive_process() and new (RCU) lock for
linked_list_from_init_task_lock (divide lock) and change job as

- set cpu allowed
- set parent
- attach pgid, sid
- attach pid
new_list_writelock()
- add to linked list
new_list_writeunlock()

may reduce contention. for_each_alive_process() will do

rcu_readlock()
for (task =....)
	if (!pid_alive(task))
		continue;
rcu_readunlock();

Is this bad ?

> >> In addition you only solves half the readdir problems.  You don't solve
> >> the seek problem which is returning to an offset you had been to
> >> before.  A relatively rare case but...
> >> 
> > Ah, I should add lseek handler for proc root. Okay.
> 
> Hmm.  Possibly.  Mostly what I was thinking is that a token in the
> list simply cannot solve the problem of a guaranteeing lseek to a
> previous position works.  I really haven't looked closely on
> how you handle that case.
> 
I'll try some. But lseek on directory, which is modified at any moment, cannot
work stable anyway.

> > My patch's point is just using task_list if we can, because it exists for
> > keeping
> > all tasks(tgids).
> 
> One of the reasons I have an issue with it, is that with the
> impending introduction of multiple pid spaces is that the task list
> really isn't what we want to traverse.
> 
Yes, scanning the whole space is not good.
I think this can be handlerd by task_lists per pid-space.
Is pidmap is maintained per pid-space ?

-Kame

