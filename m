Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSFRUF1>; Tue, 18 Jun 2002 16:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSFRUF0>; Tue, 18 Jun 2002 16:05:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21377 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317590AbSFRUFX>; Tue, 18 Jun 2002 16:05:23 -0400
Date: Tue, 18 Jun 2002 16:08:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Robert Love <rml@tech9.net>
cc: David Schwartz <davids@webmaster.com>, mgix@mgix.com,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Question about sched_yield()
In-Reply-To: <1024428314.3090.223.camel@sinai>
Message-ID: <Pine.LNX.3.95.1020618160537.8716A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2002, Robert Love wrote:

> On Tue, 2002-06-18 at 12:11, David Schwartz wrote:
> 
> > 	I'm sorry, but you are being entirely unreasonable.
> 
> No, sorry, you are.  Listen to everyone else here.
> 
> > 	If you didn't mean to burn the CPU in an endless loop, WHY DID YOU?
> 
> It is not an endless loop.  Here is the problem.  You have n tasks.  One
> type executes:
> 
> 	while(1) ;
> 
> the others execute:
> 
> 	while(1)
> 		sched_yield();
> 
> the second bunch should _not_ receive has much CPU time as the first. 
> This has nothing to do with intelligent work or blocking or picking your
> nose.  It has everything to do with the fact that yielding means
> "relinquish my timeslice" and "put me at the end of the runqueue".
> 
> If we are doing this, then why does the sched_yield'ing task monopolize
> the CPU?  BECAUSE IT IS BROKEN.
> 
> > 	You should never call sched_yield in a loop like this unless your intent is 
> > to burn the CPU until some other thread/process does something. Since you 
> > rarely want to do this, you should seldom if ever call sched_yield in a loop. 
> 
> But there are other tasks that wish to do something in these examples...
> 
> > 	But your expectation that it will reduce CPU usage is just plain wrong. If 
> > you have one thread spinning on sched_yield, on a single CPU machine it will 
> > definitely get 100% of the CPU. If you have two, they will each definitely 
> > get 50% of the CPU. There are blocking functions and scheduler priority 
> > functions for this purpose.
> 
> If they are all by themselves, of course they will get 100% of the CPU. 
> No one is saying sched_yield is equivalent to blocking.  I am not even
> saying it should get no CPU!  It should get a bunch.  But all the
> processes being equal, one that keeps yielding its timeslice should not
> get as much CPU time as one that does not.  Why is that not logical to
> you?
> 
> The original report was that given one task of the second case (above)
> and two of the first, everything was fine - the yielding task received
> little CPU as it continually relinquishes its timeslice.  In the
> alternative case, there are two of each types of tasks.  Now, the CPU is
> split and the yielding tasks are receiving a chunk of it.  Why?  Because
> the yielding behavior is broken and the tasks are continually yielding
> and rescheduling back and forth.  So there is an example of how it
> should work and how it does.  It is broken.
> 
> There isn't even really an argument.  Ingo and I have both identified
> this is a problem in 2.4 and 2.5 and Ingo fixed it in 2.5.  If 2.5 no
> longer has this behavior, then are you saying it is NOW broken?
> 
> 	Robert Love



Lets put in some numbers.

	for(;;)                  Task 0
           ;

        for(;;)                  Task 1
            sched_yield();

I will assume that scheduling takes 0 seconds and system calls
also take 0 seconds. This should be fair if I modify task 0 so
it does:
		for(;;)
                    getuid();

Which means both tasks make continuous system calls, which should
take, roughly, the same time.

Initial conditions has task B spinning for HZ time until preempted
so Task 0 starts up with HZ more time than Task 1. Task 1 now gets
the CPU. When Task 1 gets the CPU, it immediately gives it up, it
does not wait until it's preempted like task 0. Task 0 now gets the
CPU and keeps it for HZ time.

Clearly, task 0 should be getting at least HZ more CPU time than task 1.
And, yawn, it probably does! I just launched 400 of the following
programs:


int main(int c, char *argv[])
{

    for(;;)
        sched_yield();
   return c;
}

This is a dual CPU system. Top shows 184% system CPU usage and 14%
user CPU usage.

  3:54pm  up 23:30,  2 users,  load average: 14.74, 8.08, 3.30
463 processes: 62 sleeping, 401 running, 0 zombie, 0 stopped
CPU states: 13.7% user, 186.3% system,  0.0% nice,  0.0% idle
Mem:  320720K av, 215816K used, 104904K free,      0K shrd,  11752K buff
Swap: 1044208K av, 1044208K used,      0K free               131732K cached
 PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 8627 root      18   0   208  208   172 R       0 15.6  0.0   0:31 xxx[K
 8637 root      18   0   208  208   172 R       0 15.6  0.0   0:30 xxx[K
 8638 root      18   0   208  208   172 R       0 15.6  0.0   0:30 xxx[K
 8624 root      15   0   208  208   172 R       0 13.7  0.0   0:32 xxx[K
 8629 root      15   0   208  208   172 R       0 13.7  0.0   0:31 xxx[K
 8632 root      15   0   208  208   172 R       0 13.7  0.0   0:30 xxx[K
 8626 root      15   0   208  208   172 R       0 12.7  0.0   0:31 xxx[K
 8628 root      15   0   208  208   172 R       0 12.7  0.0   0:31 xxx[K
 8633 root      15   0   208  208   172 R       0 12.7  0.0   0:30 xxx[K
 8639 root      15   0   208  208   172 R       0 12.7  0.0   0:30 xxx[K
 8625 root      14   0   208  208   172 R       0 11.7  0.0   0:32 xxx[K
 8630 root      15   0   208  208   172 R       0 11.7  0.0   0:30 xxx[K
 8634 root      14   0   208  208   172 R       0 11.7  0.0   0:30 xxx[K
 8635 root      15   0   208  208   172 R       0 11.7  0.0   0:30 xxx[K
 8636 root      15   0   208  208   172 R       0 11.7  0.0   0:30 xxx[K
 [SNIPPED]

The system is as responsive as ever even though there are all those
'CPU burners', each showing they take roughly 12 percent of the CPU.
Let's see 400 * 0.12 = 48 == accounting error, nothing more.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

