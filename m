Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWAQX5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWAQX5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWAQX5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:57:50 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:63174 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S964910AbWAQX5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:57:49 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: paulmck@us.ibm.com
cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors 
In-reply-to: Your message of "Tue, 17 Jan 2006 09:26:17 -0800."
             <20060117172617.GA9283@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jan 2006 10:57:47 +1100
Message-ID: <22822.1137542267@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" (on Tue, 17 Jan 2006 09:26:17 -0800) wrote:
>On Thu, Jan 12, 2006 at 07:17:41AM -0800, Paul E. McKenney wrote:
>> On Thu, Jan 12, 2006 at 06:50:34PM +1100, Keith Owens wrote:
>> > "Paul E. McKenney" (on Wed, 11 Jan 2006 22:51:15 -0800) wrote:
>> > >On Thu, Jan 12, 2006 at 05:19:01PM +1100, Keith Owens wrote:
>> > >> OK, I have thought about it and ...
>> > >> 
>> > >>   notifier_call_chain_lockfree() must be called with preempt disabled.
>> > >> 
>> > >Fair enough!  A comment, perhaps?  In a former life I would have also
>> > >demanded debug code to verify that preemption/interrupts/whatever were
>> > >actually disabled, given the very subtle nature of any resulting bugs...
>> > 
>> > Comment - OK.  Debug code is not required, the reference to
>> > smp_processor_id() already does all the debug checks that
>> > notifier_call_chain_lockfree() needs.  CONFIG_PREEMPT_DEBUG is your
>> > friend.
>> 
>> Ah, debug_smp_processor_id().  Very cool!!!
>
>One other thing -- given that you are requiring that the read side
>have preemption disabled, another update-side option would be to
>use synchronize_sched() to wait for all preemption-disabled code
>segments to complete.  This would allow you to remove the per-CPU
>reference counters from the read side, but would require that the
>update side either (1) be able to block or (2) be able to defer
>the cleanup to process context.

Originally I looked at that code but the comment scared me off.
synchronize_sched() maps to synchronize_rcu() and the comment says that
this only protects against rcu_read_lock(), not against preempt_disable().

/**
 * synchronize_sched - block until all CPUs have exited any non-preemptive
 * kernel code sequences.
 *
 * This means that all preempt_disable code sequences, including NMI and
 * hardware-interrupt handlers, in progress on entry will have completed
 * before this primitive returns.  However, this does not guarantee that
 * softirq handlers will have completed, since in some kernels
 *
 * This primitive provides the guarantees made by the (deprecated)
 * synchronize_kernel() API.  In contrast, synchronize_rcu() only
 * guarantees that rcu_read_lock() sections will have completed.
 */
#define synchronize_sched() synchronize_rcu()


