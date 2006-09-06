Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWIFOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWIFOwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWIFOwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:52:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33733 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751208AbWIFOwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:52:53 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060906125626.GA3718@elte.hu> 
References: <20060906125626.GA3718@elte.hu>  <20060906094301.GA8694@elte.hu> <1157507203.2222.11.camel@localhost> <20060905132530.GD9173@stusta.de> <20060901015818.42767813.akpm@osdl.org> <6260.1157470557@warthog.cambridge.redhat.com> <8430.1157534853@warthog.cambridge.redhat.com> <13982.1157545856@warthog.cambridge.redhat.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, john stultz <johnstul@us.ibm.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] FRV: do_gettimeofday() should no longer use tickadj 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Sep 2006 15:46:02 +0100
Message-ID: <17274.1157553962@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> we'll get rid of that pt_regs thing centrally, from all drivers at once 
> - there's upstream buy-in for that already, and Thomas already generated 
> a test-patch for that a few months ago. But it's not a big issue right 
> now.

Yay!  Can you give me a pointer to the patch?

> this shouldnt be a big issue either - we use indirect jumps all around 
> the kernel.

Yes, I know.  I'm sometimes concerned at just how fast indirect jumps (and even
direct calls) are proliferating.  Look at the read syscall path for something
like ext3 these days: it's like a pile of spaghetti.  That seems particularly
true of direct-IO where it seems to weave in and out of core code and the
filesystem as it goes down.  I'm also concerned about stack usage.

> CPUs are either smart enough to predict it

I was told a while back (2002?) not to use indirect pointers for some stuff
because CPUs _couldn't_ predict it.  Maybe this has changed in modern CPUs.

> >  (3) ACK'ing and controlling interrupts has to be done by groups.
> 
> please be more specific,

Under some circumstances I can work out which sources have triggered which
interrupts (there are various off-CPU FPGAs which implement auxiliary PICs that
do announce their sources), but the aux-PIC channels are grouped together upon
delivery to the CPU PIC, so some of the ACK'ing has to be done at the group
level.

> how is this not possible via genirq?

How is it possible with genirq?

Unless I tie all the grouped sources together into one virtual IRQ line, this
doesn't appear to be possible.  But doing that I might then also have a mixed
set of "flow" types in any particular IRQ.

> >  (4) No account is taken of interrupt priority.
> 
> hm, i'm not sure what you mean - could you be more specific?

The FRV CPU, like many others, supports interrupt prioritisation.  A particular
interrupt level is set in the PSR, and any interrupt of a higher priority can
interrupt.  do_IRQ() can then do the interrupt processing in the interrupt
level of the interrupt that invoked it, thus permitting higher priority
interrupts to still happen.

> but ... somehow the current FRV code does figure out which IRQ source 
> fired, right?

Not always; sometimes it has to fall back to polling the drivers unfortunately.

Btw why are we using IRQ_INPROGRESS, IRQ_DISABLED, IRQ_PENDING and friends?
They would appear unnecessary.

David
