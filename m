Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWFGGou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWFGGou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWFGGou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:44:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:6277 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751030AbWFGGot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:44:49 -0400
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, paulus@samba.org
In-Reply-To: <20060606222942.43ed6437.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149652378.27572.109.camel@localhost.localdomain>
	 <20060606212930.364b43fa.akpm@osdl.org>
	 <1149656647.27572.128.camel@localhost.localdomain>
	 <20060606222942.43ed6437.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 16:44:31 +1000
Message-Id: <1149662671.27572.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 22:29 -0700, Andrew Morton wrote:

> Why on earth does the PIC come up pulling an interrupt when it hasn't been
> spoken to yet?

You leave in an ideal world :) Unfortunately the harsh reality is broken
firmwares or bootloaders, PICs that can't mask interrupts, virtual PICs
from hypervisors that want to talk to you as soon as you can take it,
kexec/kdump-style boots which didn't or couldn't completely shut the PIC
up, etc etc etc ....

In addition, on PowerPC (and possibly others), there is the decrementer
too that never stops ticking and interrupting (it simply can't be
stopped).

I'm sure other archs, especially embedded, can come up with a gazillion
other reasons.

> Nonsense.  mutex_lock() can sleep.  Sleeping will enable interrupts. 
> Therefore, hence, ergo ipso facto mutex_lock() can enable interrupts. QED,
> that's it.

Yes, except that we are talking about a well defined path which is the
kernel initialization here where it is guaranteed that there will be no
contention.

I think it's a fairly sane thing to require mutexes and other
synchronisation primitives not to hard enable interrupts when there is
no contention.

> But now, because some broken piece of hardware is coming out of
> reset/firmware asserting an interrupt we need to change the rules to be
> "mutex_lock() must preserve local interrupts if the lock is uncontended". 
> Ditto down(), down_read() and down_write().

I'm fairly convinced that "broken piece of hardware" is the general case
and that an idle PIC the exception :) Ask Linus why we have kept
carfully interrupts disabled until after init_IRQ() in the first place ?

> And why does this bizarre restriction upon the implementation of our
> locking primtives exist?  Because of your broken PIC and because of our
> inability to sort out the early boot code.  And because the early boot code
> has this implicit knowledge that the locks will be uncontended, else we're
> toast.

Because we live in a world where you can't assume that a PIC will be
well behaved. That's not a ppc specific problem, by far. I remember
having similar issues on some ARM bits I did ages ago for example. And
I'm sure kdump kind of things will bite on x86 as well.

> We're doing mutex_lock(), down(), down_read() and down_write() with local
> interrupts disabled, which is a bug.  We have explicit code in there to
> *disable* our runtime debugging checks because we know about this bug but
> don't know how to fix it.
> 
> I call that sucky.

So what can we do ? There is simply no other option I can see else of
having an entire pile of infrastructure and hacks (which is the case
today) dedicated to being able to do IOs and smashing the PIC down
before we can allocate memory in a remotely sane way... I really
need/want to clean that shit up. It all got triggered by the fact that I
need a radix tree at init_IRQ() time, but then I went looking for all
the cases where we hack around the lack of slab from there and it's
really not funny...

> > > But I'll be merging
> > > work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
> > > so we'll just continue to suck I guess.
> > 
> > How so ? Can you tell me how making the mutex debug code path do
> > something sane makes it 'suck' ? Don't argue about the couple of cycles
> > benefit, as you mentionned yourself, it's a debug code path.
> > 
> 
> Would you prefer "wildly idiotic"?

Heh. I still think not but you seem to have a pretty firm idea about
what makes sense and what not... I just happen not to share it ;)

Now, let's talk about solutions :) One is to ignore the problem, I can
do a band aid for PowerPC, I think I know what the problem is (probably
the decrementer, not the PIC) and consider that we must be always safe
to have interrupts enabled during the entire boot sequence of the
kernel. If you do
that, I strongly recommend that you put a local_irq_enable() somewhere
in start_kernel(), maybe as early as setup_arch(), in -mm and see what
breaks :)

I do have a solution in mind though that could work around the problem
of a bad behaved PIC or spurrious decrementer interrupts on powerpc, and
other architectures could probably do something similar. Basically, the
idea is to keep irqs disabled by default at startup (so we still need
your test to silence might_sleep() at leat until the main
local_irq_enable() is done, not later, so we still get useful warnings
during boot). In addition to that, archs need to add something to their
actual interrupt entry:

	if (no_irq_boot) {
		local_irq_disable();
		return;
	}

That will have the effect of "cleaning" up after a mutex/semaphore
re-enabling interrupts at least until no_irq_boot is cleared which would
be done right before the local_irq_enable() in init/main.c

Ben.


