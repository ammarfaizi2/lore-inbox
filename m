Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317585AbSFRTxs>; Tue, 18 Jun 2002 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317584AbSFRTxr>; Tue, 18 Jun 2002 15:53:47 -0400
Received: from mail.webmaster.com ([216.152.64.131]:27536 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S317583AbSFRTxq> convert rfc822-to-8bit; Tue, 18 Jun 2002 15:53:46 -0400
From: David Schwartz <davids@webmaster.com>
To: <rml@tech9.net>
CC: <mgix@mgix.com>, <root@chaos.analogic.com>,
       Chris Friesen <Chris.Friesen@vax.home.local>,
       <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Tue, 18 Jun 2002 12:53:43 -0700
In-Reply-To: <1024428314.3090.223.camel@sinai>
Subject: RE: Question about sched_yield()
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020618195344.AAA831@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jun 2002 12:25:13 -0700, Robert Love wrote:

>>    If you didn't mean to burn the CPU in an endless loop, WHY DID YOU?

>It is not an endless loop.  Here is the problem.  You have n tasks.  One
>type executes:
>
>    while(1) ;
>
>the others execute:
>
>    while(1)
>        sched_yield();

>the second bunch should _not_ receive has much CPU time as the first.

	Why not? They're both at the same priority. They're both always 
ready-to-run. Neither blocks. Why should the kernel assume that one will do 
useful work while the other won't?

>This has nothing to do with intelligent work or blocking or picking your
>nose.  It has everything to do with the fact that yielding means
>"relinquish my timeslice" and "put me at the end of the runqueue".

	And consider me immediately ready to run again.

>>    You should never call sched_yield in a loop like this unless your 
>>intent
>>is
>>to burn the CPU until some other thread/process does something. Since you
>>rarely want to do this, you should seldom if ever call sched_yield in a
>>loop.

>But there are other tasks that wish to do something in these examples...

	All the tasks are equally situated. Same priority, all ready-to-run.

>>    But your expectation that it will reduce CPU usage is just plain wrong. 
>>If
>>
>>you have one thread spinning on sched_yield, on a single CPU machine it
>>will
>>definitely get 100% of the CPU. If you have two, they will each definitely
>>get 50% of the CPU. There are blocking functions and scheduler priority
>>functions for this purpose.

>If they are all by themselves, of course they will get 100% of the CPU.
>No one is saying sched_yield is equivalent to blocking.  I am not even
>saying it should get no CPU!  It should get a bunch.  But all the
>processes being equal, one that keeps yielding its timeslice should not
>get as much CPU time as one that does not.  Why is that not logical to
>you?

	Because a thread/process that voluntarily yields its timeslice should be 
rewarded over one that burns it up, not penalized.

>The original report was that given one task of the second case (above)
>and two of the first, everything was fine - the yielding task received
>little CPU as it continually relinquishes its timeslice.  In the
>alternative case, there are two of each types of tasks.  Now, the CPU is
>split and the yielding tasks are receiving a chunk of it.  Why?  Because
>the yielding behavior is broken and the tasks are continually yielding
>and rescheduling back and forth.  So there is an example of how it
>should work and how it does.  It is broken.

	So you're saying that the yielding tasks should be penalized for yielding 
rather than just being descheduled?

>There isn't even really an argument.  Ingo and I have both identified
>this is a problem in 2.4 and 2.5 and Ingo fixed it in 2.5.  If 2.5 no
>longer has this behavior, then are you saying it is NOW broken?

	I'm saying that the fixed behavior is better than the previous behavior and 
that the previous behavior wasn't particularly good. But I'm also saying that 
people are misusing sched_yield and have incorrect expectations about it.

	If you spin on sched_yield, expect CPU wastage. It's really that simple. 
Threads/processes that use sched_yield intelligently should be rewarded for 
doing so, not penalized. Otherwise sched_yield becomes much less useful.

	DS


