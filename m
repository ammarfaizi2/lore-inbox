Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVGKPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVGKPrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVGKPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:44:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:20136 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262054AbVGKPn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:43:27 -0400
Date: Mon, 11 Jul 2005 08:43:52 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] NMI: Update NMI users of RCU to use new API
Message-ID: <20050711154352.GA1579@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050711153052.GA1615@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711153052.GA1615@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation on how to use RCU to implement dynamically changeable
NMI handlers.

Signed-off-by: <paulmck@us.ibm.com>
---

 NMI-RCU.txt |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+)

diff -urpN -X dontdiff linux-2.6.12-rc6/Documentation/RCU/NMI-RCU.txt linux-2.6.12-rc6-RCUdoc/Documentation/RCU/NMI-RCU.txt
--- linux-2.6.12-rc6/Documentation/RCU/NMI-RCU.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc6-RCUdoc/Documentation/RCU/NMI-RCU.txt	2005-06-28 12:31:48.000000000 -0700
@@ -0,0 +1,112 @@
+Using RCU to Protect Dynamic NMI Handlers
+
+
+Although RCU is usually used to protect read-mostly data structures,
+it is possible to use RCU to provide dynamic non-maskable interrupt
+handlers, as well as dynamic irq handlers.  This document describes
+how to do this, drawing loosely from Zwane Mwaikambo's NMI-timer
+work in "arch/i386/oprofile/nmi_timer_int.c" and in
+"arch/i386/kernel/traps.c".
+
+The relevant pieces of code are listed below, each followed by a
+brief explanation.
+
+	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
+	{
+		return 0;
+	}
+
+The dummy_nmi_callback() function is a "dummy" NMI handler that does
+nothing, but returns zero, thus saying that it did nothing, allowing
+the NMI handler to take the default machine-specific action.
+
+	static nmi_callback_t nmi_callback = dummy_nmi_callback;
+
+This nmi_callback variable is a global function pointer to the current
+NMI handler.
+ 
+	fastcall void do_nmi(struct pt_regs * regs, long error_code)
+	{
+		int cpu;
+
+		nmi_enter();
+
+		cpu = smp_processor_id();
+		++nmi_count(cpu);
+
+		if (!rcu_dereference(nmi_callback)(regs, cpu))
+			default_do_nmi(regs);
+
+		nmi_exit();
+	}
+
+The do_nmi() function processes each NMI.  It first disables preemption
+in the same way that a hardware irq would, then increments the per-CPU
+count of NMIs.  It then invokes the NMI handler stored in the nmi_callback
+function pointer.  If this handler returns zero, do_nmi() invokes the
+default_do_nmi() function to handle a machine-specific NMI.  Finally,
+preemption is restored.
+
+Strictly speaking, rcu_dereference() is not needed, since this code runs
+only on i386, which does not need rcu_dereference() anyway.  However,
+it is a good documentation aid, particularly for anyone attempting to
+do something similar on Alpha.
+
+Quick Quiz:  Why might the rcu_dereference() be necessary on Alpha,
+	     given that the code referenced by the pointer is read-only?
+
+
+Back to the discussion of NMI and RCU...
+
+	void set_nmi_callback(nmi_callback_t callback)
+	{
+		rcu_assign_pointer(nmi_callback, callback);
+	}
+
+The set_nmi_callback() function registers an NMI handler.  Note that any
+data that is to be used by the callback must be initialized up -before-
+the call to set_nmi_callback().  On architectures that do not order
+writes, the rcu_assign_pointer() ensures that the NMI handler sees the
+initialized values.
+
+	void unset_nmi_callback(void)
+	{
+		rcu_assign_pointer(nmi_callback, dummy_nmi_callback);
+	}
+
+This function unregisters an NMI handler, restoring the original
+dummy_nmi_handler().  However, there may well be an NMI handler
+currently executing on some other CPU.  We therefore cannot free
+up any data structures used by the old NMI handler until execution
+of it completes on all other CPUs.
+
+One way to accomplish this is via synchronize_sched(), perhaps as
+follows:
+
+	unset_nmi_callback();
+	synchronize_sched();
+	kfree(my_nmi_data);
+
+This works because synchronize_sched() blocks until all CPUs complete
+any preemption-disabled segments of code that they were executing.
+Since NMI handlers disable preemption, synchronize_sched() is guaranteed
+not to return until all ongoing NMI handlers exit.  It is therefore safe
+to free up the handler's data as soon as synchronize_sched() returns.
+
+
+Answer to Quick Quiz
+
+	Why might the rcu_dereference() be necessary on Alpha, given
+	that the code referenced by the pointer is read-only?
+
+	Answer: The caller to set_nmi_callback() might well have
+		initialized some data that is to be used by the
+		new NMI handler.  In this case, the rcu_dereference()
+		would be needed, because otherwise a CPU that received
+		an NMI just after the new handler was set might see
+		the pointer to the new NMI handler, but the old
+		pre-initialized version of the handler's data.
+
+		More important, the rcu_dereference() makes it clear
+		to someone reading the code that the pointer is being
+		protected by RCU.
