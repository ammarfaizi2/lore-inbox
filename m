Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTAJM0A>; Fri, 10 Jan 2003 07:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTAJM0A>; Fri, 10 Jan 2003 07:26:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60817
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264925AbTAJMZ6>; Fri, 10 Jan 2003 07:25:58 -0500
Subject: Re: [PATCH]Re: spin_locks without smp.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0301101308410.25610@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0301101238560.6124@dns.toxicfilms.tv>
	 <20030110114546.GN23814@holomorphy.com>
	 <20030110114855.GO23814@holomorphy.com>
	 <Pine.LNX.4.51.0301101308410.25610@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042204846.28469.75.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 13:20:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 12:09, Maciej Soltysiak wrote:
> > On Fri, Jan 10, 2003 at 03:45:46AM -0800, William Lee Irwin III wrote:
> > > Buggy on preempt. Remove the #ifdef
> Yes sir. :)
> 
> Is that okay?

I'm not convinced its the right way. The driver does the things it does in order
to keep performance acceptable. eexpress, 8390 and one or two other
drivers have a paticular problem that is hard to handle with our current
locks (and which at the time Linus made a decision wasn't a good thing
to try and handle generically). 

We have to ensure that the IRQ path doesn't execute in parallel with
the transmit/timeout path. At the same time the packet upload to the
card is extremely slow. Sufficiently slow in fact that serial ports
just stop working when you use it without the ifdef paths.

On uniprocessor systems even with pre-empt the IRQ handler cannot be 
pre-empted by normal code execution. On SMP they can run across two
processors. What the disable_irq path is doing for uniprocessor is
implementing

	spin_lock_irqsavesomeirqsonly()

and on the kind of boxes that have these old cards its pretty important
to keep this.

I would argue that if we have an IRQ disabled we should forbid pre-empt.
If an IRQ is disabled and we pre-empt to a task that needs to allocate
memory and we swap to a device on that IRQ we may deadlock.

So the fix is either to make disable_irq()/enable_irq() correctly 
adjust the pre-empt restrictions, which is actually quite hard to see
how to do right as the disable/enable may be in different tasks, or to
change the code to do the following


	preempt_disable()
	disable_irq()
#ifdef CONFIG_SMP
	spin_lock_...
#endif

Note that we must disable the irq before taking the spinlock or we 
have another deadlock with our irq path versus disable_irq waiting
for the IRQ completion before returning.

If my analysis of the disable_irq versus pre-empt and memory allocation
deadlock is correct we have some other cases we need to address too.

Alan

