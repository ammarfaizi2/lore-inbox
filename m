Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136576AbREAFUD>; Tue, 1 May 2001 01:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136577AbREAFTx>; Tue, 1 May 2001 01:19:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40566 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136576AbREAFTp>; Tue, 1 May 2001 01:19:45 -0400
Date: Tue, 1 May 2001 07:18:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
Message-ID: <20010501071849.A16474@athlon.random>
In-Reply-To: <20010430195149.F19620@athlon.random> <Pine.LNX.4.21.0104302335490.19012-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0104302335490.19012-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Apr 30, 2001 at 11:38:23PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 11:38:23PM -0300, Rik van Riel wrote:
> On Mon, 30 Apr 2001, Andrea Arcangeli wrote:
> > On Sun, Apr 29, 2001 at 10:26:57AM +0200, Peter Osterlund wrote:
> 
> > > -	p->counter = current->counter;
> > > -	current->counter = 0;
> > > +	p->counter = (current->counter + 1) >> 1;
> > > +	current->counter >>= 1;
> > > +	current->policy |= SCHED_YIELD;
> > >  	current->need_resched = 1;
> > 
> > please try to reproduce the bad behaviour with 2.4.4aa2. There's a bug
> > in the parent-timeslice patch in 2.4 that I fixed while backporting it
> > to 2.2aa and that I now forward ported the fix to 2.4aa. The fact
> > 2.4.4 gives the whole timeslice to the child just gives more light to
> > such bug.
> 
> The fact that 2.4.4 gives the whole timeslice to the child
> is just bogus to begin with.
> 
> The problem people tried to solve was "make sure the kernel
> runs the child first after a fork", this has just about
> NOTHING to do with how the timeslice is distributed.
> 
> Now, since we are in a supposedly stable branch of the kernel,
> why mess with the timeslice distribution between parent and
> child?  The timeslice distribution that has worked very well
> for the last YEARS...

I'm running with this below patch applied since a some time (I didn't
submitted it because for some reason unless I do p->policy &=
~SCHED_YIELD ksoftirqd deadlocks at boot and I didn't yet investigated
why, and I'd like to have the whole picture on it first):

diff -urN z/include/linux/sched.h z1/include/linux/sched.h
--- z/include/linux/sched.h	Mon Apr 30 04:22:25 2001
+++ z1/include/linux/sched.h	Mon Apr 30 02:45:07 2001
@@ -301,7 +301,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	int counter;
+	volatile int counter;
 	int nice;
 	unsigned int policy;
 	struct mm_struct *mm;
diff -urN z/kernel/fork.c z1/kernel/fork.c
--- z/kernel/fork.c	Mon Apr 30 04:22:25 2001
+++ z1/kernel/fork.c	Mon Apr 30 03:49:26 2001
@@ -666,17 +666,17 @@
 	p->pdeath_signal = 0;
 
 	/*
-	 * Give the parent's dynamic priority entirely to the child.  The
-	 * total amount of dynamic priorities in the system doesn't change
-	 * (more scheduling fairness), but the child will run first, which
-	 * is especially useful in avoiding a lot of copy-on-write faults
-	 * if the child for a fork() just wants to do a few simple things
-	 * and then exec(). This is only important in the first timeslice.
-	 * In the long run, the scheduling behavior is unchanged.
+	 * Scheduling the child first is especially useful in avoiding a
+	 * lot of copy-on-write faults if the child for a fork() just wants
+	 * to do a few simple things and then exec().
 	 */
-	p->counter = current->counter;
-	current->counter = 0;
-	current->need_resched = 1;
+	{
+		int counter = current->counter >> 1;
+		current->counter = p->counter = counter;
+		p->policy &= ~SCHED_YIELD;
+		current->policy |= SCHED_YIELD;
+		current->need_resched = 1;
+	}
 	/* Tell the parent if it can get back its timeslice when child exits */
 	p->get_child_timeslice = 1;
 

The only point of my previous email is that if a fork loop has very
invasive effect on the rest of the system that more probably indicates
people got bitten by the bug in the parent-timeslice logic, furthmore I
never noticed any sluggish behaviour on my systems and before posting my
previous email I had 1 definitive feedback that the bad beahviour
observed on vanilla 2.4.4 with parallel compiles in the background got
cured *completly* by my tree (that in the tested revision didn't
included the above inlined change yet). So I thought it was worth
mentioning about the effect of the parent-timeslice bugfix here too.
This doesn't mean I don't want something like the above inlined patch
integrated.

Andrea
