Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317651AbSFRWjE>; Tue, 18 Jun 2002 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317652AbSFRWjD>; Tue, 18 Jun 2002 18:39:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41693 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317651AbSFRWjD>;
	Tue, 18 Jun 2002 18:39:03 -0400
Date: Wed, 19 Jun 2002 00:36:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: mgix@mgix.com
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: RE: Question about sched_yield() 
In-Reply-To: <AMEKICHCJFIFEDIBLGOBEEELCBAA.mgix@mgix.com>
Message-ID: <Pine.LNX.4.44.0206190031150.23460-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jun 2002 mgix@mgix.com wrote:

> However, I am not aware of any alternative to communicate what I really
> want to the scheduler, and here's why. If anyone has ideas on how to do
> this better, please, I'm all ears.
> 
> It's basically about spinlocks and the cost of task switching.
> 
> I'm trying to implement "smart" spinlocks.

the right solution for you are the new ultra-fast kernel-helped,
user-space semaphores. Those are kernel objects where the semaphore data
structure is accessible to user-space as well. Acquiring the semaphore in
the no-contention case is very cheap, it's basically a single assembly
instruction. In the contention case you'll enter the kernel and schedule
away.

(in the sched_yield() case you schedule away just as much in the
contention case, so there isnt any difference.)

for shortlived but contended locks this mechanism can be improved a bit by
looping 'some more' on the lock before entering the kernel and blocking -
but it could also be a loss if the amount of additional looping is too
long or too short. Since the O(1) scheduler context-switches in under 1
microsecond on a 1 GHz box, and has no SMP interlocking and cache-trashing
problems, you'll still get 1 million context switches per second, per CPU.  
And this is the 'slow' case.

	Ingo

