Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLMCks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTLMCks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:40:48 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:44927 "EHLO
	DYN320019.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S263488AbTLMCkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:40:45 -0500
Date: Fri, 12 Dec 2003 11:35:59 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
Message-ID: <20031212193559.GA1614@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20031212052812.E80972C085@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212052812.E80972C085@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 04:24:18PM +1100, Rusty Russell wrote:
> OK, I've put the html version up for your reading pleasure: the diff
> is quite extensive and hard to read.
> 
> http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/
> 
> Feedback welcome,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Hello, Rusty,

Good stuff!  A few comments, as always!

						Thanx, Paul

Glossary:

o	Hardware Interrupt / Hardware IRQ: How does in_irq()
	know that interrupts have been blocked?  The local_irq_disable()
	does not seem to mess with the counter, and preempt_disable()
	just does the standard inc/dec stuff...

	o	in_irq() is hardirq_count().
	o	hardirq_count() is (preempt_count() & HARDIRQ_MASK).
	o	preempt_count is an integer, HARDIRQ_MASK is a constant that
		is out of the normal inc/dec range.

	I see how an interrupt handler causes in_irq() to do its thing
	via the irq_enter() and irq_exit() macros, but I don't see how
	masking interrupts makes this happen.

	Probably just my confusion, but...

	Ditto for "in_interrupt()".  That would be for both the
	analysis and the probable confusion on my part.

o	Software Interrupt / softirq: formatting botch "of'software".
	This would be "o'software", right?

o	Preemption: Would it be worth changing the first bit
	of the second sentence to read something like: "In 2.5.4
	and later, when CONFIG_PREEMPT is set, this changes:"?

Overzealous Prevention Of Deadlocks:  Cute!!!

Avoiding Locks: Read Copy Update

o	Might be worth noting explicitly early on that updaters are
	running concurrently with readers.  Should be obvious given
	that the readers aren't doing any explicit synchronization,
	but I have run into confusion on this point surprisingly often.

o	Please add a note to the list_for_each_entry_rcu() description
	saying that writers (who hold appropriate locks) need not use
	the _rcu() variant.

o	Don't understand the blank line before and after the
	"struct rcu_head rcu;", but clearly doesn't affect
	functionality.  ;-)

o	If nothing blocks between the call to __cache_find() and the
	eventual object_put(), it is worthwhile to avoid the
	reference-count manipulation.  This would make all of
	cache_find() be almost as fast as UP, rather than just
	__cache_find().
