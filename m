Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTAJM4Q>; Fri, 10 Jan 2003 07:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbTAJM4Q>; Fri, 10 Jan 2003 07:56:16 -0500
Received: from holomorphy.com ([66.224.33.161]:54680 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264673AbTAJM4P>;
	Fri, 10 Jan 2003 07:56:15 -0500
Date: Fri, 10 Jan 2003 05:04:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Re: spin_locks without smp.
Message-ID: <20030110130446.GR23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv> <20030110114546.GN23814@holomorphy.com> <20030110114855.GO23814@holomorphy.com> <Pine.LNX.4.51.0301101308410.25610@dns.toxicfilms.tv> <1042204846.28469.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042204846.28469.75.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 12:09, Maciej Soltysiak wrote:
>> Yes sir. :)
>> Is that okay?

On Fri, Jan 10, 2003 at 01:20:48PM +0000, Alan Cox wrote:
> I'm not convinced its the right way. The driver does the things it
> does in order
> to keep performance acceptable. eexpress, 8390 and one or two other
> drivers have a paticular problem that is hard to handle with our current
> locks (and which at the time Linus made a decision wasn't a good thing
> to try and handle generically). 
> We have to ensure that the IRQ path doesn't execute in parallel with
> the transmit/timeout path. At the same time the packet upload to the
> card is extremely slow. Sufficiently slow in fact that serial ports
> just stop working when you use it without the ifdef paths.
> On uniprocessor systems even with pre-empt the IRQ handler cannot be 
> pre-empted by normal code execution. On SMP they can run across two
> processors. What the disable_irq path is doing for uniprocessor is
> implementing

Okay, what I'm getting here is that the UP case already has preempt
disabled b/c the locks are taken in IRQ context?

The thing I don't get is how the spinlock bits cause horrendous
timing issues on UP that are different from SMP, esp. b/c they are
#ifdef'd elsewhere to do nothing but inc/dec preempt_count elsewhere.
There's a bit of "how did it happen" missing in my mind at least.


On Fri, Jan 10, 2003 at 01:20:48PM +0000, Alan Cox wrote:
> 	spin_lock_irqsavesomeirqsonly()
> and on the kind of boxes that have these old cards its pretty important
> to keep this.
> I would argue that if we have an IRQ disabled we should forbid pre-empt.
> If an IRQ is disabled and we pre-empt to a task that needs to allocate
> memory and we swap to a device on that IRQ we may deadlock.
> So the fix is either to make disable_irq()/enable_irq() correctly 
> adjust the pre-empt restrictions, which is actually quite hard to see
> how to do right as the disable/enable may be in different tasks, or to
> change the code to do the following
> 	preempt_disable()
> 	disable_irq()
> #ifdef CONFIG_SMP
> 	spin_lock_...
> #endif

Hmm, the part I'm missing here is why folding the preempt_disable()
into the spin_lock() is wrong. Or is it the implicit local_irq_save()
that's the (massive performance) problem?


On Fri, Jan 10, 2003 at 01:20:48PM +0000, Alan Cox wrote:
> Note that we must disable the irq before taking the spinlock or we 
> have another deadlock with our irq path versus disable_irq waiting
> for the IRQ completion before returning.
> If my analysis of the disable_irq versus pre-empt and memory allocation
> deadlock is correct we have some other cases we need to address too.

Hmm, this is tricky, since it's really disabling interrupts for too
long to make progress on UP; I suspect this issue might have _some_
(negative) impact on SMP, but how much (or for how many relevant
systems) I'm not sure.

Some serious thought may need to go into this, but it's very far afield
for me. I think some ppl more directly involved with these issues
(rml, mingo, others???) might need to get flagged down to fix it for
legacy systems (presumably modern ones won't have the issue at all)
for 2.7.x etc. if it really does matter.

I'm tied up with 64GB at the moment so my wetware cpu cycles are really
totally unavailable for this. =(


Thanks,
Bill
