Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRDNQMF>; Sat, 14 Apr 2001 12:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRDNQLy>; Sat, 14 Apr 2001 12:11:54 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:36514 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S132473AbRDNQLj>; Sat, 14 Apr 2001 12:11:39 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 14 Apr 2001 09:11:23 -0700
Message-Id: <200104141611.JAA06613@adam.yggdrasil.com>
To: public@dgmo.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> = Rik van Riel <riel@conectiva.com.br>
>>  = Adam J. Richter <adam@yggdrasil.com>
>   = Michael O'Reilly <public@dgmo.org>

>> Rik van Riel <riel@conectiva.com.br> writes, regarding the idea
>> of having do_fork() give all of the parent's remaining time slice to
>> the newly created child:
>> 
>>>It could upset programs which use threads to handle
>>>relatively IO poor things (like, waiting on disk IO in a
>>>thread, like glibc does to fake async file IO).
>> 
>> 	Good point.

>Is it really? If a program is using thread to handle IO things,
>then:

>a) It's not going to create a thread for every IO! So I think
>the argument is suprious anyway.

	Maybe not that often, but, from my incomplete understanding of
linux/kernel/sched.c, it looks like it can be a really long time
before the recalculate loop in schedule() gets called.  Currently,
the time slice of a regular "nice 0" process in Linux is 50ms
(NICE_TO_TICKS(20) = 5, and each tick is 10ms).  So, if you're
on a multiuser system or you're running some parallel algorithm
that uses a bunch of threads so that nobody has to rendezvous to
block on IO, then this could on the order of one second.

	Tangential note: I think the 50ms process time slice makes
Linux boxes that have a lot of runnable threads or processes
unresponsive in ways that will not show up in most benchmarks, making
things like multi-user VNC servers much less scalable than they should
be.  I wish the Linux "recalculate" loop would scale the time slices to
#cpu's/#runnable processes, such as by replacing changing the
"p->counter = ..." line in the "recalculate" loop in schedule() to
something like this:

	  int runnables;
	  ...
	  runnables = 0;
	  list_for_each(tmp, &runqueue_head)
		runnables++;
	  runnables /= smp_num_cpus;
	  runnables = runnables ? runnables : 1; /* prevent division by 0 */
          for_each_task(p)
                  p->counter = (p->counter >> 1) + 
			       (NICE_TO_TICKS(p->nice) / runnables) + 1;

	(the "+ 1" at the end would ensure that the increment is never
zero, even if runnables is very high.)


	Anyhow, getting back to the topic at hand...

>b) You _still_ want the child to run first. The child
>will start the I/O and block, then switching back
>to the parent. This maximises the I/O thruput without
>costing you any CPU. (Reasoning: The child running
>2nd will increase the latency which automatically
>reduces the number of ops/second you can get).

	 Absolutely.  I never said that it would be a good idea run
the parent first in that case and Rik didn't either.  Under Rik's
idea, the child would still run first, but the parent could retain
some CPU priority, so that it could get around to running again
before the next call to the "recalculate" loop in schedule(), which
might be 1 second if the system has 20 runnable runnable threads.
	

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
