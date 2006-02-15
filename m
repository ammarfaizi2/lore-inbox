Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWBOUpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWBOUpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBOUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:45:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51342 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750964AbWBOUpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:45:51 -0500
Date: Wed, 15 Feb 2006 21:43:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060215204357.GA4895@elte.hu>
References: <20060215151711.GA31569@elte.hu> <p73lkwc5xv2.fsf@verdi.suse.de> <43F36A00.602@redhat.com> <200602151942.20494.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602151942.20494.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Wednesday 15 February 2006 18:50, Ulrich Drepper wrote:
> > Andi Kleen wrote:
> > > e.g. you could add a new VMA flag that says "when one user
> > > of this dies unexpectedly by a signal kill all" 
> > 
> > "kill all"?  
> 
> It would solve the problem statement given by Ingo in the rationale 
> for this kernel patch - cleaning up after a hanging yum.

no, it wouldnt solve it. How do you know in userspace that the futex got 
orphan? Say the futex value is stuck at '2'. How do you know it's hung 
due to the premature exit of its owner?

Premature exit while holding locks is a fundamental property of the 
locking abstraction - which, in the case of futex based locks, cannot be 
implemented without kernel help. It's a tough problem that we struggled 
with for years to solve properly.

> If there are any other problems this is intended to solve then they 
> should be stated in the rationale.

i really only wrote that quick and light preamble to introduce the topic 
- not to start any discussion whether the topic exists. The topic 
obviously exists, check out pthread_mutex_t robustness APIs in other 
OSs:

  http://docs.sun.com/app/docs/doc/816-5137/6mba5vpjf?a=view#sync-103
  http://docs.sun.com/app/docs/doc/816-5137/6mba5vpjg?a=view#sync-116

the vma-based robust-futex patches have been circulating on lkml for 
quite some time, they were even in -mm for some time. Check out:

   http://developer.osdl.org/dev/robustmutexes/

for a background. To make sure: our patch handles the 'robust' portion, 
not the PI portion - just like the previous vma-based patches previously 
sent to lkml. I.e. robustness comes first - it's a feature orthogonal to 
priority inheritance.

just in case you were wondering: this is not an ad-hoc topic we made up
:-|

> > > And what happens if the patch is rejected? I don't really think you
> > > can force patches in this way ("do it or I break glibc")
> > 
> > Nothing which relies on the syscalls goes into cvs unless the kernel
> > side is first committed. I never do this. 

Andi, what were you thinking by suggesting that we want to "force 
patches"? Really, have we ever done that? Ulrich is known to be very 
strict about ABI issues, and he probably wont even trust Linus himself 
saying that a syscall will go in - he'll only trust the commit log.

Frankly, i thought we are offering a cool new feature as a solution to a 
hard problem, and i'm really startled (and saddened) to see such a 
default assumption of malice from you :-( I dont think we deserved that.

> > > What happens when the list gets corrupted? Does the kernel go
> > > into an endless loop? Kernel going through arbitary user 
> > > structures like this seems very risky to me. There are ways to do
> > > list walking with cycle detection, but they still have quite
> > > bad worst case detection times.
> >
> > The list being corrupted means that the mutexes are corrupted. In 
> > which case the application would crash anyway.
>
> I'm not concerned about the application, just about the kernel.

i said it multiple times in the announcement:

> > > > If the thread/process crashed or terminated in some incorrect 
> > > > way then the list might be non-empty: in this case the kernel 
> > > > carefully walks the list [not trusting it],
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
and:

> > > > i've tested the new syscalls on x86 and x86_64, and have made 
> > > > sure the parsing of the userspace list is robust [ ;-) ]
> > > > even if the list is deliberately corrupted.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You could even have read the code - the function is called 
exit_robust_list(), and is commented quite extensively:

+/*
+ * Walk curr->robust_list (very carefully, it's a userspace list!)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ * and mark any locks found there dead, and notify any waiters.
+ *
+ * We silently return on any sign of list-walking problem.
+ */
+void exit_robust_list(struct task_struct *curr)

again, i'm startled at your clearly baseless negative reaction :-(

> > As for the "endless loop".  You didn't read the code, it seems.  There
> > are two mechanisms to prevent this: the list is destroyed when the
> > individual elements are handled and there is an upper limit on the
> > number of robust mutexes which can be registered.  The limit is
> > ridiculously high so it'll no problem for correct programs and it also
> > will eliminate run-away list following code.
> 
> Ok good that's handled. How about long blocking on swapped out pages 
> in exit?

We already touch userspace pages in do_exit() (and had been for years), 
so we may already 'block' on a swapped out page - which will become 
swapped in and then the kernel continues. The maximum amount of delay 
depends on how many pages are touched. You can think of the list-walking 
as a 'preamble' to the thread exiting - it could have been triggered by 
userspace, straight before the do_exit() was executed.

Furthermore, there is a limit on the maximum number of list entries 
walked (ROBUST_LIST_LIMIT) - i set it to a quite high number [to be able 
to test performance], but we could reduce it significantly.  
Realistically there wont be more than say a dozen locks held at exit 
time.

	Ingo
