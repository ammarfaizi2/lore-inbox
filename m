Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWCZO2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWCZO2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 09:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCZO2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 09:28:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64148 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751197AbWCZO2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 09:28:24 -0500
Date: Sun, 26 Mar 2006 16:25:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 00/10] PI-futex: -V1
Message-ID: <20060326142539.GA26204@elte.hu>
References: <20060326074535.GA9969@elte.hu> <Pine.LNX.4.44L0.0603261045230.32389-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603261045230.32389-100000@lifa03.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On Sun, 26 Mar 2006, Ingo Molnar wrote:
> 
> > i mentioned it further down in the text - PRIO_PROTECT support (which is
> > priority ceiling) is planned for pthread mutexes. It needs no further
> > kernel changes, it's a pure userspace thing.
> 
> Wouldn't this always include a call to sched_setscheduler() even for 
> the fast path? And it would also involve assigning a priority to all 
> locks up front.

correct. Priority ceiling based boosting can be called "manual PI" or 
"open-coded PI". It is quite error-prone for more complex apps, because 
not only has each thread its own priority (which must be well-designed), 
but also every lock used by these threads must be assigned a maximum 
priority that it will boost threads to. That priority is redundant and 
can be mis-assigned.

priority ceiling locks also involve two additional syscalls per critical 
section, so they are significantly slower than the atomic-ops based 
PI-futex solution. [and thus it could degrade worst-case behavior by 
virtue of higher locking overhead alone.]

> There are only 2 good reasons to choose this, as far as I can see. One 
> is that it is more deterministic: The "fast path" is almost as slow as 
> the slow path. So you will not be surprised by a sudden increase CPU 
> use because timing is moved slightly. This is on the other hand 
> something which can happen with PI.

correct. That on the other hand is also a disadvantage: PI is in essence 
'optional boosting on an as-needed basis', while priority-ceiling is 
unconditional boosting. Unconditional boosting will hurt average 
latencies, which are often just as important as the worst-case 
latencies.

For example: there is a high-prio, a medium-prio and a low-prio task.  
There is a critical section lock, only used by the high-prio and the 
low-prio task.

Under the priority ceiling logic, we manually assign 'high-prio' to the 
lock [which step is redundant information, and which is an additional 
source of coding/design bugs]. When the low-prio task takes the lock, 
that will unconditionally boost it to high-prio, and that task might 
delay the medium-prio task - even if there is no high-prio task running 
right then.

If PI is used, then the kernel will automatically boost the low-prio 
task to high-prio, if the high-prio task wants to take that lock too.  
Otherwise the low-prio task will remain on low-prio - not delaying the 
medium-prio task. So the average delays of the medium-prio task improve.  

[ Furthermore, theoretically, if the application has a workflow pattern 
  in which the medium-prio and high-prio tasks will never run at the 
  same time, then priority ceiling logic would degrade the worst-case 
  latency of the medium-prio task too. ]

[ for completeness: PI is transitive as well, so if at such a moment the 
  highprio task preempts the medium prio task (which preempted the 
  lowprio task holding the lock), and the highprio task wants to take 
  the lock, then the lowprio task will be boosted to high-prio and can 
  finish the critical section to hand over the lock to the highprio 
  task. ]

i.e. PI, as implemented by this patchset, is clearly superior to 
priority ceiling logic.

furthermore, there's a usability advantage to PI too: programmers often 
find it more natural to assign priorities to a given 'workflow' 
(task/thread), and not to every lock. I.e. i think PI is more natural. 
(and hence easier to design for)

but nevertheless, the PRIO_PROTECT API for POSIX mutexes does exist, and 
we can (and will) support it from userspace. All that it needed was to 
make sure that setscheduler() is fully PI-aware: it must not decrease 
the priority of a task to below the highest-priority waiter, and it must 
'remember' the setscheduler() priority [and restore to it] after PI 
effects wear off. This is implemented by our PI code anyway, so we get 
correct priority ceiling (PRIO_PROTECT) behavior 'for free'.

	Ingo
