Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWIIFyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWIIFyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 01:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIIFyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 01:54:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:64715 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932174AbWIIFyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 01:54:49 -0400
Date: Sat, 9 Sep 2006 07:46:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj
Message-ID: <20060909054642.GA8859@elte.hu>
References: <20060906125626.GA3718@elte.hu> <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> <17274.1157553962@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17274.1157553962@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Howells <dhowells@redhat.com> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > we'll get rid of that pt_regs thing centrally, from all drivers at once 
> > - there's upstream buy-in for that already, and Thomas already generated 
> > a test-patch for that a few months ago. But it's not a big issue right 
> > now.
> 
> Yay!  Can you give me a pointer to the patch?

i cannot find Thomas' recent 2.6 one (Thomas, do you have a link to 
it?), but i did one 5 years ago:

 http://people.redhat.com/mingo/irq-rewrite-patches/irq-cleanup-2.4.15-B1.bz2

in general it's a large but otherwise pretty dumb patch.

> > this shouldnt be a big issue either - we use indirect jumps all around 
> > the kernel.
> 
> Yes, I know.  I'm sometimes concerned at just how fast indirect jumps 
> (and even direct calls) are proliferating.  Look at the read syscall 
> path for something like ext3 these days: it's like a pile of 
> spaghetti.  That seems particularly true of direct-IO where it seems 
> to weave in and out of core code and the filesystem as it goes down.  
> I'm also concerned about stack usage.

yeah - but unless you can suggest some low-maintainance-overhead 
solution, not much can be done i suspect: being a few cycles slower is a 
lot less of a problem than being less flexible in the design. In general 
CPUs do optimize this quite well, but it is true that not every CPU 
does.

> > CPUs are either smart enough to predict it
> 
> I was told a while back (2002?) not to use indirect pointers for some 
> stuff because CPUs _couldn't_ predict it.  Maybe this has changed in 
> modern CPUs.

indirect pointers are very common both in OSs and in applications, 
especially in C++ based ones, where lots of execution goes off dynamic 
objects which have function pointers associated to them. So _lots_ of 
effort goes into branch prediction on the hardware side - and yes, 
modern CPUs do quite well with indirect pointers too.

The worst-case scenario is when the indirect branch flip-flops between 
multiple destination addresses - but that shouldnt be an issue for 
genirq because most systems have _one_ preferred way of handling 
interrupts that the majority of interrupt traffic uses. (for example on 
i686 it's level-triggered PCI irqs)

But even if there's multiple destinations from the indirect jump, newest 
CPUs (such as Core 2) can actually store _multiple_ branch history 
targets and can prefetch all of them at once (if there's idle capacity 
left).

(And i wouldnt be surprised if some modern CPUs already stored the 
indirection register's index in the BHT, and used that for the 
prediction. Most indirect calls happen off registers, and if the 
compiler loads the register early enough (which it typically does) then 
the branch target value is available to the CPU. Other context 
information can be included in a BHT too.)

Also, in general, if something is arguably a smart thing to do in an OS 
(and more design flexibility via function pointers is a smart thing for 
which there is no viable alternative), we can expect CPUs to get 
gradually better at handling them.

> > >  (4) No account is taken of interrupt priority.
> > 
> > hm, i'm not sure what you mean - could you be more specific?
> 
> The FRV CPU, like many others, supports interrupt prioritisation.  A 
> particular interrupt level is set in the PSR, and any interrupt of a 
> higher priority can interrupt.  do_IRQ() can then do the interrupt 
> processing in the interrupt level of the interrupt that invoked it, 
> thus permitting higher priority interrupts to still happen.

ah, ok. For PREEMPT_HARDIRQS we thought about possibly utilizing 
hw-level IRQ prioritization too - but it's quite inflexible in most IRQ 
controller designs: the prioritization is rarely integrated with the CPU 
and is often attached to the ACK/EOI-ing of the IRQ line (and an 
unACK-ed IRQ can have side-effects).

So the thing we chose for PREEMPT_HARDIRQS was to do the prioritization 
at the OS/scheduler level. And OS level handling of this is what we need 
anyway: IRQ handlers are just the first, often tiny portion in a 
critical workload that a system must perform. (we have softirqs, 
signals, tasks, etc.) Nevertheless the door is open to utilize hw 
capabilities of IRQ prioritization - we 'only' need standard driver and 
/sys APIs to make use of them.

	Ingo
