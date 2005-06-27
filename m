Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVF0QhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVF0QhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVF0PCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:02:11 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:54498 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261957AbVF0OHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:07:43 -0400
Date: Sun, 26 Jun 2005 22:02:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, dipankar@in.ibm.com,
       ak@suse.de, akpm@osdl.org, maneesh@in.ibm.com
Subject: Re: [RFC,PATCH] RCU: clean up a few remaining synchronize_kernel() calls
Message-ID: <20050627050206.GA2139@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050618002021.GA2892@us.ibm.com> <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506191150300.26045@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 11:53:24AM -0600, Zwane Mwaikambo wrote:
> On Fri, 17 Jun 2005, Paul E. McKenney wrote:
> 
> > Please let me know if there are any problems with any of these changes.
> 
> Hi Paul,
> 	Do you have any pending patches to update Documentation/RCU/* too? 
> The best i can find explaining usage is from;
> 
> http://lwn.net/Articles/130341/
> 
> Thanks,
> 	Zwane

Hello, Zwane,

How does the following look for NMI-RCU documentation?

						Thanx, Paul

------------------------------------------------------------------------

Using RCU to Protect Dynamic NMI Handlers


Although RCU is usually used to protect read-mostly data structures,
it is possible to use RCU to provide dynamic non-maskable interrupt
handlers, as well as dynamic irq handlers.  This document describes
how to do this, drawing loosely from Zwane Mwaikambo's NMI-timer
work in "arch/i386/oprofile/nmi_timer_int.c" and in
"arch/i386/kernel/traps.c".

The relevant pieces of code are listed below each followed by a
brief explanation.

	static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
	{
		return 0;
	}

This is a "dummy" NMI handler that does nothing, but returns zero,
thus saying that it did nothing, allowing the NMI handler to take
the default machine-specific action.
 
	static nmi_callback_t nmi_callback = dummy_nmi_callback;

This is a global function pointer to the current NMI handler.
 
	fastcall void do_nmi(struct pt_regs * regs, long error_code)
	{
		int cpu;

		nmi_enter();

		cpu = smp_processor_id();
		++nmi_count(cpu);

		if (!nmi_callback(regs, cpu))
			default_do_nmi(regs);

		nmi_exit();
	}

The do_nmi() function processes each NMI.  It first disables preemption
in the same way that a hardware irq would, then increments the per-CPU
count of NMIs.  It then invokes the NMI handler stored in the nmi_callback
function pointer.  If this handler returns zero, do_nmi() invokes
the default_do_nmi() function to handle a machine-specific NMI.
Finally, preemption is restored.

Purists might argue that the invocation of nmi_callback() should use
rcu_dereference as follows:

		if (!rcu_dereference(nmi_callback)(regs, cpu))

Strictly speaking, rcu_dereference() is not needed, since this code
runs only on i386, which does not need rcu_dereference() anyway.
However, it may be helpful as a documentation aid, particularly for
anyone attempting to do something similar on Alpha.

Quick Quiz:  Why might the rcu_dereference() be necessary on Alpha,
	     given that the code reference by the pointer is read-only?

	void set_nmi_callback(nmi_callback_t callback)
	{
		nmi_callback = callback;
	}

This function registers an NMI handler.

	void unset_nmi_callback(void)
	{
		nmi_callback = dummy_nmi_callback;
	}

This function unregisters an NMI handler, restoring the original
dummy_nmi_handler().  However, there may well be an NMI handler
currently executing on some other CPU.  We therefore cannot free
up any data structures used by the old NMI handler until execution
of it completes on all other CPUs.

One way to accomplish this is via synchronize_sched(), perhaps as
follows:

	unset_nmi_callback();
	synchronize_sched();
	kfree(my_nmi_data);

This works because synchronize_sched() blocks until all CPUs complete
any preemption-disabled segments of code that they were executing.
Since NMI handlers disable preemption, synchronize_sched() is guaranteed
no to return until all ongoing NMI handlers exit.  It is therefore safe
to free up the handler's data as soon as synchronize_sched() returns.


Answer to Quick Quiz

	Why might the rcu_dereference() be necessary on Alpha, given
	that the code reference by the pointer is read-only?

	Answer: The caller to set_nmi_callback() might well have
		initialized some data that is to be used by the
		new NMI handler.  In this case, the rcu_dereference()
		would be needed, because otherwise a CPU that received
		an NMI just after the new handler was set might see
		the pointer to the new NMI handler, but the old
		pre-initialized version of the handler's data.
