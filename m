Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTEXF0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 01:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTEXF0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 01:26:15 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:17538 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263579AbTEXF0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 01:26:14 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 May 2003 22:38:44 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Boehm, Hans" <hans_boehm@hp.com>
cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>,
       "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <75A9FEBA25015040A761C1F74975667D01442109@hplex4.hpl.hp.com>
Message-ID: <Pine.LNX.4.55.0305232225010.3538@bigblue.dev.mcafeelabs.com>
References: <75A9FEBA25015040A761C1F74975667D01442109@hplex4.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Boehm, Hans wrote:

> Thanks for the pointer.  In the statically linked case, I get 200/568/345
> for custom/pthread_mutex/pthread_spin.
>
> I agree that this is not a fair comparison.  That was my point.  An implementation
> with custom yield/sleep
> code can do things that you can't do with blocking pthreads primitives at the
> same performance.  (Of course pthreads_mutex_lock will win in other cases.)
>
> Please forget about the abort() in the contention case.  I put that there for
> brevity since it is not exercised by the test.  The intent was to time the
> noncontention performance of a custom lock that first spins, then yields,
> and then sleeps, as was stated in the comment.
>
> You are forgetting two issues in your analysis of what pthreads is/should be doing
> relative to the spin-lock-like code:
>
> 1) The unlock code is different.  If you potentially do a waitforunlocks()
> in the locking code, you need to at least check whether the corresponding
> notification is necessary when you unlock().  For NPTL that requires another
> atomic operation, and hence another dozen to a couple of hundred cycles,
> depending on the processor.  You need to look at both the lock and unlock
> code.

That code was completely independent by what pthread might do. I didn't
look at the code but I think the new pthread uses futexes for mutexes.
The code wanted only to show that a mutex lock does more than a spinlock.
And this "more" is amplified by your tight loop.



> 2) (I hadn't mentioned this before.) The (standard interpretation of)
> the memory barrier semantics of the pthreads primitives is too strong.
> Arguably they need to be full memory barriers in both directions.
> The pthread_spin_lock code inserts an extra full
> memory barrier on IA64 as a result, instead of just
> using the acquire barrier associated with the cmpxchg.acq instruction.
> (I think the spin unlock code doesn't do this.  One could argue that that's a bug,
> though I would argue that the bug is really  in the pthreads spec.)

You need a write memory barrier even on the unlock. Consider this :

	spinlock = 1;
	...
	protected_resource = NEWVAL;
	spinlock = 0;

( where spinlock = 0/1 strip down, but do not lose the concept, the lock
operation ). If a CPU reorder those writes, another CPU might see the lock
drop before the protected resource assignment. And this is usually bad
for obvious reasons.



- Davide

