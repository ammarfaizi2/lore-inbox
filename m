Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTLOGLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLOGKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:10:04 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:10462 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263269AbTLOGI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:08:58 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide 
In-reply-to: Your message of "Fri, 12 Dec 2003 11:35:59 -0800."
             <20031212193559.GA1614@us.ibm.com> 
Date: Mon, 15 Dec 2003 16:17:47 +1100
Message-Id: <20031215060851.1882C189E1@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031212193559.GA1614@us.ibm.com> you write:
> On Fri, Dec 12, 2003 at 04:24:18PM +1100, Rusty Russell wrote:
> > OK, I've put the html version up for your reading pleasure: the diff
> > is quite extensive and hard to read.
> > 
> > http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/
> > 
> > Feedback welcome,
> > Rusty.
> > --
> >   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 
> Hello, Rusty,
> 
> Good stuff!  A few comments, as always!
> 
> 						Thanx, Paul
> 
> Glossary:
> 
> o	Hardware Interrupt / Hardware IRQ: How does in_irq()
> 	know that interrupts have been blocked?  The local_irq_disable()
> 	does not seem to mess with the counter, and preempt_disable()
> 	just does the standard inc/dec stuff...

You're right, it doesn't.

> 	o	in_irq() is hardirq_count().
> 	o	hardirq_count() is (preempt_count() & HARDIRQ_MASK).
> 	o	preempt_count is an integer, HARDIRQ_MASK is a constant that
> 		is out of the normal inc/dec range.
> 
> 	I see how an interrupt handler causes in_irq() to do its thing
> 	via the irq_enter() and irq_exit() macros, but I don't see how
> 	masking interrupts makes this happen.
> 
> 	Probably just my confusion, but...
> 
> 	Ditto for "in_interrupt()".  That would be for both the
> 	analysis and the probable confusion on my part.

Yes.  I've removed both those: AFAICT they were never true.

> o	Software Interrupt / softirq: formatting botch "of'software".
> 	This would be "o'software", right?

Looks ok here:
	Tasklets and softirqs both fall into the category of 'software interrupts'.

> o	Preemption: Would it be worth changing the first bit
> 	of the second sentence to read something like: "In 2.5.4
> 	and later, when CONFIG_PREEMPT is set, this changes:"?

I was trying to make it a little future-proof: I think CONFIG_PREEMPT
should go away some day.

> Overzealous Prevention Of Deadlocks:  Cute!!!

This is untouched from the old version of the document.  I had a
troubled youth...

> Avoiding Locks: Read Copy Update
> 
> o	Might be worth noting explicitly early on that updaters are
> 	running concurrently with readers.  Should be obvious given
> 	that the readers aren't doing any explicit synchronization,
> 	but I have run into confusion on this point surprisingly often.

OK.  Changed the second paragraph from:

	How do we get rid of read locks?  That is actually quite simple:

to:

	How do we get rid of read locks?  Getting rid of read locks
	means that writers may be changing the list underneath the readers.
	That is actually quite simple:


> o	Please add a note to the list_for_each_entry_rcu() description
> 	saying that writers (who hold appropriate locks) need not use
> 	the _rcu() variant.

OK:

      Once again, there is a
      <function>list_for_each_entry_rcu()</function>
      (<filename>include/linux/list.h</filename>) to help you.  Of
      course, writers can just use
      <function>list_for_each_entry()</function>, since there cannot
      be two simultaneous writers.

> o	Don't understand the blank line before and after the
> 	"struct rcu_head rcu;", but clearly doesn't affect
> 	functionality.  ;-)

Hmm, it would logically be at the start of the structure.  I think I
wanted to avoid associating it with the refcnt_t.

> o	If nothing blocks between the call to __cache_find() and the
> 	eventual object_put(), it is worthwhile to avoid the
> 	reference-count manipulation.  This would make all of
> 	cache_find() be almost as fast as UP, rather than just
> 	__cache_find().

Good point.  Text added at the bottom of that section:

<para>
There is a furthur optimization possible here: remember our original
cache code, where there were no reference counts and the caller simply
held the lock whenever using the object?  This is still possible: if
you hold the lock, noone can delete the object, so you don't need to
get and put the reference count.
</para>

<para>
Now, because the 'read lock' in RCU is simply disabling preemption, a
caller which always preemption disabled between calling
<function>cache_find()</function> and
<function>object_put()</function> does not need to actually get and
put the reference count: we could expose
<function>__cache_find()</function> by making it non-static, and
such callers could simply call that.
</para>
<para>
The benefit here is that the reference count is not written to: the
object is not altered in any way, which is much faster on SMP
machines due to caching.
</para>

I've uploaded a new draft with these and other fixes...

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
