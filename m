Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSFRTZd>; Tue, 18 Jun 2002 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSFRTZc>; Tue, 18 Jun 2002 15:25:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61945 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317568AbSFRTZb>; Tue, 18 Jun 2002 15:25:31 -0400
Subject: RE: Question about sched_yield()
From: Robert Love <rml@tech9.net>
To: David Schwartz <davids@webmaster.com>
Cc: mgix@mgix.com, root@chaos.analogic.com,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020618191114.AAA27826@shell.webmaster.com@whenever>
References: <20020618191114.AAA27826@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 12:25:13 -0700
Message-Id: <1024428314.3090.223.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 12:11, David Schwartz wrote:

> 	I'm sorry, but you are being entirely unreasonable.

No, sorry, you are.  Listen to everyone else here.

> 	If you didn't mean to burn the CPU in an endless loop, WHY DID YOU?

It is not an endless loop.  Here is the problem.  You have n tasks.  One
type executes:

	while(1) ;

the others execute:

	while(1)
		sched_yield();

the second bunch should _not_ receive has much CPU time as the first. 
This has nothing to do with intelligent work or blocking or picking your
nose.  It has everything to do with the fact that yielding means
"relinquish my timeslice" and "put me at the end of the runqueue".

If we are doing this, then why does the sched_yield'ing task monopolize
the CPU?  BECAUSE IT IS BROKEN.

> 	You should never call sched_yield in a loop like this unless your intent is 
> to burn the CPU until some other thread/process does something. Since you 
> rarely want to do this, you should seldom if ever call sched_yield in a loop. 

But there are other tasks that wish to do something in these examples...

> 	But your expectation that it will reduce CPU usage is just plain wrong. If 
> you have one thread spinning on sched_yield, on a single CPU machine it will 
> definitely get 100% of the CPU. If you have two, they will each definitely 
> get 50% of the CPU. There are blocking functions and scheduler priority 
> functions for this purpose.

If they are all by themselves, of course they will get 100% of the CPU. 
No one is saying sched_yield is equivalent to blocking.  I am not even
saying it should get no CPU!  It should get a bunch.  But all the
processes being equal, one that keeps yielding its timeslice should not
get as much CPU time as one that does not.  Why is that not logical to
you?

The original report was that given one task of the second case (above)
and two of the first, everything was fine - the yielding task received
little CPU as it continually relinquishes its timeslice.  In the
alternative case, there are two of each types of tasks.  Now, the CPU is
split and the yielding tasks are receiving a chunk of it.  Why?  Because
the yielding behavior is broken and the tasks are continually yielding
and rescheduling back and forth.  So there is an example of how it
should work and how it does.  It is broken.

There isn't even really an argument.  Ingo and I have both identified
this is a problem in 2.4 and 2.5 and Ingo fixed it in 2.5.  If 2.5 no
longer has this behavior, then are you saying it is NOW broken?

	Robert Love

