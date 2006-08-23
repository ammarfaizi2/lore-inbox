Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWHWGMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWHWGMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 02:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWHWGMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 02:12:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50077 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751343AbWHWGL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 02:11:59 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: Re: [RFC][PATCH] ps command race fix take2 [1/4] list token
References: <20060822173904.5f8f6e0f.kamezawa.hiroyu@jp.fujitsu.com>
	<m164gkr9p3.fsf@ebiederm.dsl.xmission.com>
	<20060823072256.7d931f8b.kamezawa.hiroyu@jp.fujitsu.com>
Date: Wed, 23 Aug 2006 00:11:17 -0600
In-Reply-To: <20060823072256.7d931f8b.kamezawa.hiroyu@jp.fujitsu.com>
	(KAMEZAWA Hiroyuki's message of "Wed, 23 Aug 2006 07:22:56 +0900")
Message-ID: <m1ac5woube.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> On Tue, 22 Aug 2006 10:56:08 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
>> 
>> > This is ps command race fix take2. Unfortunately, against 2.6.18-rc4.
>> > I'll rebase this to appropriate kernel if O.K. (I think this is RFC)
>> >
>> > This patch implements Paul Jackson's idea, 'inserting false link in task
> list'.
>> 
>> Currently the tasklist_lock is one of the more highly contended locks in
>> the kernel.  Adding an extra place it is taken is undesirable.
> yes. taking lock is a probem.
> I know current readdir() uses 8192 bytes buffer for getdents64(). Then,
> maybe write-lock will be acquired all-tgids/400+ times for inserting token
> (in 32bit system).
>  
>> If could see a better algorithm for sending a signal to all processes
>> in a process groups we could remove the tasklist_lock entirely.
>> 
> ??
> Sorry, could you explain more ?

The core problem is not when there is a single user.  The problem is
that no matter how large the system gets we have a single lock.  So it
gets increasingly contended.

I almost removed the tasklist_lock from all read paths.  But as it
happens sending a signal to a process group is an atomic operation
with respect to fork so that path has to take the lock, or else
we get places where "kill -9 -pgrp" fails to kill every process in
the process group.  Which is even worse.


>> In addition you only solves half the readdir problems.  You don't solve
>> the seek problem which is returning to an offset you had been to
>> before.  A relatively rare case but...
>> 
> Ah, I should add lseek handler for proc root. Okay.

Hmm.  Possibly.  Mostly what I was thinking is that a token in the
list simply cannot solve the problem of a guaranteeing lseek to a
previous position works.  I really haven't looked closely on
how you handle that case.

>> > Good point of this approach is cost of searching task is O(N) (N=num of
> tgids).
>> > Bad point is lock and kmalloc/kfree.
>> > I didin't modified thread_list and cpuset's proc list, maybe future work.
>> >
>> > If searching pid bitmap is better, please take Erics.
>> 
>> My patch at least needs a good changelog but I believe it will work
>> better and can be further improved with a better pid data structure
>> if there is actually a problem there.  Given that I don't take
>> any locks it should be much friendlier at scale, and the code
>> was simpler.
> yes. it has several good points and simple.
> My patch's point is just using task_list if we can, because it exists for
> keeping
> all tasks(tgids).

One of the reasons I have an issue with it, is that with the
impending introduction of multiple pid spaces is that the task list
really isn't what we want to traverse.

>> However I will miss a few newly forked processes and I don't think your
>> technique will miss any.  Still neither will miss a process that
>> existed the entire time.
>> 
>> If nothing else I think it was worth posting so we could contrast the two.
>> 
> please post again. I think comparing the two is good.
> I will post take3 with improved comments and lseek handler, and so
> on.

I intend to, I'm unfortunately busy in another direction at the
moment.

Eric
