Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVETMzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVETMzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 08:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVETMzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 08:55:22 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:60806 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261453AbVETMzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 08:55:11 -0400
Date: Fri, 20 May 2005 08:55:11 -0400
To: Chris Friesen <cfriesen@nortel.com>
Cc: Olivier Croquette <ocroquette@free.fr>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
Message-ID: <20050520125511.GC23488@csclub.uwaterloo.ca>
References: <428CD458.6010203@free.fr> <20050519182302.GE23621@csclub.uwaterloo.ca> <428CED0C.9020607@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428CED0C.9020607@nortel.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 01:46:20PM -0600, Chris Friesen wrote:
> Doesn't matter.  From a userspace point of view there is no process with 
> that PID, so kill() should return ESRCH.  In the kernel, I think this 
> means that kill() should actually be looking up tgids rather than pids.

If you look in the list of processes running, you WILL see that PID in
the list.  ERSCH should only be returned if you ask for a thread that
either never existed or doesn't exist anymore.  Since a thread is a
process to the kernel (at least as far as cheduling and PIDs are
concerned) you can send a kill to the thread, which will probably be
sent to the parent process id instead.

> PID="process ID"
> 
> You have one PID per process.

No, you have at least one PID per process.  I have never heard anyone
claim before that implementing threads as extra processes in the kernel
is violating posix.  It sure makes the scheduler simpler to implement.
Much more efficient than user space threading.

> No, they are implemented as separately schedulable entities with lots of 
> shared state.  "process" and "thread" are POSIX terms that don't really 
> mean anything in the kernel.

Certainly process and thread does have meanings in the kernel.

> Pthreads define signal handling.  Signals are delivered to the process 
> as a whole, not to any particular thread.  If you specify a TID that is 
> not a valid PID, then the kernel should return an error.

Well as long as the kernel send the signals sent to any of the PIDs of a
multithreaded process, to that process, then that seems fine to me.

> If the syscall is supposed to operate on processes, it should operate on 
> all threads within a process.  It would be nice to have a way to specify 
> affinity for threads.  POSIX doesn't define one though.

Hmm, well I guess the current way it works you can set the affinity per
thread since you had a PID per thread to operate on.  If you want to do
it for the whole process, perhaps if you set it on the starting thread
before it creates more threads they would probably inherit the affinity
of the original thread.

Have you tried NPTL (native posix threading library) which is supposed
to become the threading standard on linux in the future (if it works
out)?  I was under the impression amd64 systems with 2.6 kernels at
least tend to use that by default, but I might be remembering something
else unrelated.  I wonder if NPTL doesn't do more the way you want than
the way linuxthreads have worked so far.

Len Sorensen
