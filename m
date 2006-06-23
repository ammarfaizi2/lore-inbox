Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933007AbWFWKrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007AbWFWKrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933009AbWFWKrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:47:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50845 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933007AbWFWKrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:47:25 -0400
Date: Fri, 23 Jun 2006 12:42:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 18/61] lock validator: irqtrace: core
Message-ID: <20060623104226.GO4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212432.GR3155@elte.hu> <20060529183416.d1ab7d82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183416.d1ab7d82.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.2 required=5.9 tests=AWL,BAYES_50,RISK_FREE autolearn=no SpamAssassin version=3.0.3
	0.2 RISK_FREE              BODY: Risk free.  Suuurreeee....
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 29 May 2006 23:24:32 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > accurate hard-IRQ-flags state tracing. This allows us to attach 
> > extra functionality to IRQ flags on/off events (such as 
> > trace-on/off).
> 
> That's a fairly skimpy description of some fairly substantial new 
> infrastructure.

ok, here's some more info (i'll add this to the irq-flags-tracing core 
patch):

the "irq state tracing" feature "traces" hardirq and softirq state, in 
that it gives interested subsystems an opportunity to be notified of 
every hardirqs-off/hardirqs-on, softirqs-off/softirqs-on event that 
happens in the kernel.

CONFIG_TRACE_IRQFLAGS_SUPPORT is needed for CONFIG_PROVE_SPIN_LOCKING 
and CONFIG_PROVE_RW_LOCKING to be offered by the generic lock debugging 
code. Otherwise only CONFIG_PROVE_MUTEX_LOCKING and 
CONFIG_PROVE_RWSEM_LOCKING will be offered on an architecture - these 
are locking APIs that are not used in IRQ context. (the one exception 
for rwsems is worked around)

Right now the only interested subsystem is the lock validator, but 
things like RTLinux, ADEOS, the -rt tree and the latency tracer would 
certainly be interested in managing irq-flags state too. (I did not add 
any expansive (and probably expensive) notifier mechanism yet, before 
someone actually tries to mix multiple users of this infrastructure and 
comes up with the right abstraction.)

architecture support for this is certainly not in the "trivial" 
category, because lots of lowlevel assembly code deal with irq-flags 
state changes. But an architecture can be irq-flags-tracing enabled in a 
rather straightforward and risk-free manner.

Architectures that want to support this need to do a couple of 
code-organizational changes first:

- move their irq-flags manipulation code from their asm/system.h header 
  to asm/irqflags.h

- rename local_irq_disable()/etc to raw_local_irq_disable()/etc. so that 
  the linux/irqflags.h code can inject callbacks and can construct the 
  real local_irq_disable()/etc APIs.

- add and enable TRACE_IRQFLAGS_SUPPORT in their arch level Kconfig file

and then a couple of functional changes are needed as well to implement 
irq-flags-tracing support:

- in lowlevel entry code add (build-conditional) calls to the
  trace_hardirqs_off()/trace_hardirqs_on() functions. The lock validator 
  closely guards whether the 'real' irq-flags matches the 'virtual' 
  irq-flags state, and complains loudly (and turns itself off) if the 
  two do not match. Usually most of the time for arch support for 
  irq-flags-tracing is spent in this state: look at the lockdep 
  complaint, try to figure out the assembly code we did not cover yet, 
  fix and repeat. Once the system has booted up and works without a 
  lockdep complaint in the irq-flags-tracing functions arch support is 
  complete.

- if the architecture has non-maskable interrupts then those need to be 
  excluded from the irq-tracing [and lock validation] mechanism via
  lockdep_off()/lockdep_on().

in general there is no risk from having an incomplete irq-flags-tracing 
implementation in an architecture: lockdep will detect that and will 
turn itself off. I.e. the lock validator will still be reliable. There 
should be no crashes due to irq-tracing bugs. (except if the assembly 
changes break other code by modifying conditions or registers that 
shouldnt be)

	Ingo
