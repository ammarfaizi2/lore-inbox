Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSFSCLI>; Tue, 18 Jun 2002 22:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317736AbSFSCLH>; Tue, 18 Jun 2002 22:11:07 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:2572 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317735AbSFSCLG>; Tue, 18 Jun 2002 22:11:06 -0400
Date: Tue, 18 Jun 2002 19:10:59 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about sched_yield()
Message-ID: <20020618191059.C1001@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <AMEKICHCJFIFEDIBLGOBGEDPCBAA.mgix@mgix.com> <20020618004630.AAA28082@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020618004630.AAA28082@shell.webmaster.com@whenever>; from davids@webmaster.com on Mon, Jun 17, 2002 at 05:46:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lets back up a moment please.

On Mon, Jun 17, 2002 at 05:46:29PM -0700, David Schwartz wrote:
> 
> On Sat, 15 Jun 2002 15:15:32 -0700, mgix@mgix.com wrote:
> >
> >Hello,
> >
> >I am seeing some strange linux scheduler behaviours,
> >and I thought this'd be the best place to ask.
> >
> >I have two processes, one that loops forever and
> >does nothing but calling sched_yield(), and the other
> >is basically benchmarking how fast it can compute
> >some long math calculation.
> [snip]
> 
> 	You seem to have a misconception about what sched_yield is for. It is not a 
> replacement for blocking or a scheduling priority adjustment. It simply lets 
> other ready-to-run tasks be scheduled before returning to the current task.
> 
> 	Here's a quote from SuS3:
> 
> "The sched_yield() function shall force the running thread to relinquish the 
> processor until it again becomes the head of its thread list. It takes no 
> arguments."

.From this description it sounds like sched_yield was
intended to deal with scheduling of threads within a
process not the between processes.  Namely that there is a
"thread list" within a single process context.

This would be used for yielding to another thread within the
same list (context) when the current thread needs a
contended-for resource (an inter-thread/intra-context lock)
or the result of another thread's calculation.  Or simply to
allow switching, round-robin style, between a set of compute
intensive threads by salting the compute loops with
sched_yield.

Am i right?

Linux, as we know, treats threads and independent processes
as equals.  Therefore, the process scheduler now becomes
responsible for dealing with sched_yield and somehow
translating sched_yield's intent to a situation where threads are
contending with other processes instead of just with their
fellows and their fellows can wind up with differing
priorities.

Handled sched_yield wrong could result in a live/deadlock
(i'm fuzzy at the moment on the distinction, sorry) if one
thread is sched_yield/spinning on a resource pending action of a
lower priority thread.  It would seem that sched_yield
should make sure that the calling thread has a priority
lower than the lowest priority thread within the thread
group.

"until it again becomes the head of its thread list"
sounds to me like all other threads in the group should have
an opportunity to run before the calling thread does.

I would suggest that in the case where there are no other
threads in the group that are runnable the process should
sleep(0) so another (lower priority) process can run.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
