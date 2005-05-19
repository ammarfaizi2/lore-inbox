Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVESSXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVESSXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVESSXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:23:15 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:34946 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261201AbVESSXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:23:02 -0400
Date: Thu, 19 May 2005 14:23:02 -0400
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
Message-ID: <20050519182302.GE23621@csclub.uwaterloo.ca>
References: <428CD458.6010203@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428CD458.6010203@free.fr>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 08:00:56PM +0200, Olivier Croquette wrote:
> It seems that the thread ids in Linux are unique within the complete 
> operating system, and not only within their corresponding processes. 
> This is explicitely allowed by the POSIX standard (it also states that 
> applications shall no rely on it).
> 
> Apparently some system calls which normally require a process id also 
> work with thread ids.

They work with numbers, this is C, there is no real serious type checking.
Don't rely on it and just pretend it isn't that way.

> - a system call requiring a PID can have  the same effect if a thread id 
> of the same process was given.
> Example: kill(tid,SIGTERM) will kill the entire process the thread
> belongs to. I think that this is not POSIX compliant. It shall trigger
> ESRCH!

How should kill know if you are sending a threadid or processid?  If the
integer matches a running pid then it should kill that one.  If there is
no such process id it should return ESRCH.  Just because every threadid
is a processid too doesn't mean it is broken, and you aren't supposed to
pass threadids to kill anyhow.

> Sometimes, the system call has another effect, potentialy providing
> additional functionality.
> Example: sched_setaffinity(). The man page and the prototype (which 
> requires a pid_t) both show that a process id is required. Nothing 
> indicates that it works with threads, and AFAIK there is no documented 
> way to set affinity for a specific thread.
> But if you give a TID to sched_setaffinity, it will put the *thread* on 
> the given cpu set.
> If you give a PID to sched_setaffinity, it will put the *main thread* on
> the given cpu set. The other threads won't be impacted.
> Even if sched_setaffinity() is no standard, I find it confusing to give
> it a pid_t and that it affects only threads!
> 
> 
> Some open questions:
> 
> - is it a guaranted behaviour within Linux that thread ids and process 
> ids do not overlap? is it documented anywhere?
> 
> - is there a real confusion at API level within Linux between threads
> and processes or are kill() and sched_setaffinity() isolated examples? 
> or bugs?

Just pretend they are different things even if currently they are
implemented so threads are processes and your code should be safe.

> - is Linux kill() POSIX compliant in this regard?

Does posix say that a process can't be allocated multiple PIDs?  What
should kill do when sent to anyone of the PIDs beloging to a process?
It should probably do the same thing as if it was sent to the PID of the
main thread (whatever main thread means in a threaded program).  I would
think it is posix compliant even if it isn't the common way to represent
threads on posix compliant systems.

> - do we want to limit the sched_setaffinity() functionality to
> correspond to its documentation, or do we want to update the
> documentation so that its covers all the functionality?

I believe Linux currently implements threads as seperate processes (at
least top and ps sees them that way).  Of course I would never recomend
assuming things will always work that way, since after all someone is
perfectly allowed to implement threading in user space with a posix
thread compliant interface and link a program against their own thread
library which doesn't use the kernel to manage the threads (using
linuxthreads).  A safe programmer makes no assumptions about anything if
it isn't documented in the specs to work a specific way.  if it is
states as undefined, expect the behaviour to potentially change.

Now given linux runs threads as seperate processes, it makes sense that
thread ids and process ids are the same thing and hence currently
unique, and that kill would work on any thread's pid within a given
process.  I am not sure how the process handles signals to a thread in
terms of signal handling, although I would think the kernel probably
knows it is a thread and passes it to the parent process instead.

Doesn't sched_setaffinity do what it says it will?  Since each thread is
treated as a process then sched_setaffinity should work on it I would
think since it is a process after all as far as the scheduler is
concerned.

Len Sorensen
