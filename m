Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWCZXKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWCZXKX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCZXKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:10:22 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:62438
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932178AbWCZXKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:10:21 -0500
Date: Sun, 26 Mar 2006 15:10:00 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [patch 00/10] PI-futex: -V1
Message-ID: <20060326231000.GA14280@gnuppy.monkey.org>
References: <20060326074535.GA9969@elte.hu> <Pine.LNX.4.44L0.0603261045230.32389-100000@lifa03.phys.au.dk> <20060326142539.GA26204@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326142539.GA26204@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 04:25:39PM +0200, Ingo Molnar wrote:
> If PI is used, then the kernel will automatically boost the low-prio 
> task to high-prio, if the high-prio task wants to take that lock too.  
> Otherwise the low-prio task will remain on low-prio - not delaying the 
> medium-prio task. So the average delays of the medium-prio task improve.  
> 
> [ Furthermore, theoretically, if the application has a workflow pattern 
>   in which the medium-prio and high-prio tasks will never run at the 
>   same time, then priority ceiling logic would degrade the worst-case 
>   latency of the medium-prio task too. ]
> 
> [ for completeness: PI is transitive as well, so if at such a moment the 
>   highprio task preempts the medium prio task (which preempted the 
>   lowprio task holding the lock), and the highprio task wants to take 
>   the lock, then the lowprio task will be boosted to high-prio and can 
>   finish the critical section to hand over the lock to the highprio 
>   task. ]
> 
> i.e. PI, as implemented by this patchset, is clearly superior to 
> priority ceiling logic.
> 
> furthermore, there's a usability advantage to PI too: programmers often 
> find it more natural to assign priorities to a given 'workflow' 
> (task/thread), and not to every lock. I.e. i think PI is more natural. 
> (and hence easier to design for)

It's not quite as a simple as that. The use of a ceiling is a more aggressive
method of controlling priority in an application. The use it can control the
thread preeemption, with regard to thread priority, primarily below the ceiling
by prevent the occurance of priority inversion and the for the need for simple
priority inheritance in the first place. It just simplifies what's going on in
the app as wel as what can happen.

Apps using ceilings don't have to consider the potential of a PI boost chain
in the first place if it was allowed to complete without the effects of floating
priority. Certain RT app needs depend on this kind of ceiling behavior and the
timing that goes with it. I'm sure Esben and company will correctly me if I'm
wrong, but his is how I understand it and I believe this to be correct.

> but nevertheless, the PRIO_PROTECT API for POSIX mutexes does exist, and 
> we can (and will) support it from userspace. All that it needed was to 
> make sure that setscheduler() is fully PI-aware: it must not decrease 
> the priority of a task to below the highest-priority waiter, and it must 
> 'remember' the setscheduler() priority [and restore to it] after PI 
> effects wear off. This is implemented by our PI code anyway, so we get 
> correct priority ceiling (PRIO_PROTECT) behavior 'for free'.

Talking about nearly free things. If your userpace implementation has a crude
notion of TCB, then you might able to a lazy user to kernel space sync of a
thread's priority at an in-kernel preemption point such as an interrupt exit
or some kind of preemption checks. This would maintain the run correctness of
that thraed since it is already running in the first place. Userspace
implementations of pthreead_{get,set}schedparam would just use the cached
userspace value directly in from the TCB instead of a kernel call.

I mention this because this could be a decent method of optimizing out the
opening priority boost and associated setscheduler() with a ceiling. The demotion
hit for a ceiling is unavoiable, but the PI demotion case suffers this as well
if it's contended. That's how I understand the problem and I'm just forwarding
some ideas with regard to the issue, but this is starting to push into scheduler
activations which just about everybody has abandoned these days (Solaris, etc...). 

bill

