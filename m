Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315253AbSDWQov>; Tue, 23 Apr 2002 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSDWQou>; Tue, 23 Apr 2002 12:44:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59045 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315253AbSDWQot>;
	Tue, 23 Apr 2002 12:44:49 -0400
Date: Tue, 23 Apr 2002 16:41:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] task cpu affinity syscalls for 2.4-O(1)
In-Reply-To: <20020423093634.A1904@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0204231635410.12991-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Apr 2002, Mike Kravetz wrote:

> I don't have a suggestion for the locking yet, but rather a question
> about the current code that you may be able to answer.  At the end of
> set_cpus_allowed(), there is this block of code:
> 
>         init_MUTEX_LOCKED(&req.sem);
>         req.task = p;
>         list_add(&req.list, &rq->migration_queue);
>         task_rq_unlock(rq, &flags);
>         wake_up_process(rq->migration_thread);
> 
>         down(&req.sem);
> 
> After releasing the runqueue lock, what prevents p from moving to (and
> running on) another CPU via the load_balance() mechanism before the
> migration thread is scheduled?  I couldn't find anything in the code to
> prevent this, and it looks like bad things would happen if it did.  Of
> course, this assumes we are not running in the context of p while
> calling set_cpus_allowed() for p.

well, my goal was the following: the migration thread makes sure that the
migrated thread will *not* run on that particular CPU. The only issue the
migration thread is for is to 'push' the migrated thread from its current
CPU.

so we first set the cpus_allowed mask, then we schedule the migration
thread (which is a highest RT priority thread) if the thread is running on
an invalid CPU.

load_balance() moving a process to another CPU is in fact makes this job
easier, and causes no problems. It will pull a process only to allowed
runqueues.

this way it can be guaranteed that after the set_cpus_allowed() call the
thread is not running on an invalid CPU.

the affinity setting syscalls added by Robert's patch utilize this
underlying mechanizm, but kernel threads call it directly as well. Eg. in
the softirqd case it's of importance whether the thread is running on the
right CPU or not, after calling set_cpus_allowed().

is there anything else unclear in this area?

	Ingo

