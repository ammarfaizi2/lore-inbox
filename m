Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWAJXJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWAJXJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWAJXJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:09:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:27537 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750805AbWAJXJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:09:44 -0500
Date: Wed, 11 Jan 2006 00:09:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-ID: <20060110230917.GA25285@elte.hu>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com> <20060108094839.GA16887@elte.hu> <43C435B9.5080409@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C435B9.5080409@austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Schopp <jschopp@austin.ibm.com> wrote:

> >interesting. Could you try two things? Firstly, could you add some 
> >minimal delays to the lock/unlock path, of at least 1 usec? E.g.  
> >"synchro-test.ko load=1 interval=1". [but you could try longer delays 
> >too, 10 usecs is still realistic.]
> 
> Graphs attached.  The summary for those who don't like to look at 
> attachments is that the mutex fastpath (threads 1) that I sent the 
> optimized patch for is comparable within the margin of error to 
> semaphores.  The mutex common path (threads > 1) gets embarrassed by 
> semaphores. So mutexes common paths are not yet ready as far as ppc64 
> is concerned.

ok. I'll really need to look at "vmstat" output from these. We could 
easily make the mutex slowpath behave like ppc64 semaphores, via the 
attached (untested) patch, but i really think it's the wrong thing to 
do, because it overloads the system with runnable tasks in an 
essentially unlimited fashion [== overscheduling] - they'll all contend 
for the same single mutex.

in synthetic workloads on idle systems it such overscheduling can help, 
because the 'luck factor' of the 'thundering herd' of tasks can generate 
a higher total throughput - at the expense of system efficiency. At 8 
CPUs i already measured a net performance loss at 3 tasks! So i think 
the current 'at most 2 tasks runnable' approach of mutexes is the right 
one on a broad range of hardware.

still, i'll try a different patch tomorrow, to keep the number of 'in 
flight' tasks within a certain limit (say at 2) - i suspect that would 
close the performance gap too, on this test.

but i really think the current 'at most one task in flight' logic is the 
correct approach. I'm also curious about the VFS-test numbers (already 
on your todo).

> >thirdly, could you run 'vmstat 1' during the tests, and post those lines 
> >too? Here i'm curious about two things: the average runqueue length 
> >(whether we have overscheduling), and CPU utilization and idle time left 
> >(how efficiently cycles are preserved in contention). [btw., does ppc 
> >have an idle=poll equivalent mode of idling?]
> 
> Also queued in my todo list.

thanks!

> >also, there seems to be some fluctuation in the numbers - could you try 
> >to run a few more to see how stable the numbers are?
> 
> For the graphs the line is the average of 5 runs, and the 5 runs are 
> scatter plotted as well.

ok, that should be more than enough.

	Ingo

--- kernel/mutex.c.orig
+++ kernel/mutex.c
@@ -226,6 +226,9 @@ __mutex_unlock_slowpath(atomic_t *lock_c
 
 		debug_mutex_wake_waiter(lock, waiter);
 
+		/* be (much) more agressive about wakeups: */
+		list_move_tail(&waiter.list, &lock->wait_list);
+
 		wake_up_process(waiter->task);
 	}
 
