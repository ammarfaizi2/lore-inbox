Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVCWEst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVCWEst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVCWEst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:48:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30632 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262667AbVCWEsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:48:46 -0500
Date: Tue, 22 Mar 2005 20:48:49 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050323044849.GA1294@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322093201.GA21945@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 10:32:01AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > seems to be a true SMP race: when i boot with 1 CPU it doesnt trigger,
> > the same kernel image and 2 CPUs triggers it on CPU#1. (CPU#0 is the
> > boot CPU) Note that the timing of the crash is not deterministic
> > (sometimes i get it during net startup, sometimes during ACPI
> > startup), but it always crashes within rcu_advance_callbacks().
> > 
> > one difference between your tests and mine is that your kernel is
> > doing _synchronize_kernel() from preempt-off sections (correct?),
> > while my kernel with PREEMPT_RT does it on preemptable sections.
> 
> hm, another thing: i think call_rcu() needs to take the read-lock. Right
> now it assumes that it has the data structure private, but that's only
> statistically true on PREEMPT_RT: another CPU may have this CPU's RCU
> control structure in use. So IRQs-off (or preempt-off) is not a
> guarantee to have the data structure, the read lock has to be taken.

!!!  The difference is that in the stock kernel, rcu_check_callbacks()
is invoked from irq.  In PREEMPT_RT, it is invoked from process context
and appears to be preemptible.  This means that rcu_advance_callbacks()
can be preempted, resulting in all sorts of problems.  Need to disable
preemption over this.

There are probably other bugs of this sort, I will track them down.

But, just to make sure I understand -- if I have preempt disabled over
all accesses to a per-CPU variable, and that variable is -not- accessed
from a real interrupt handler, then I am safe without a lock, right?

						Thanx, Paul

PS.  Fixing my stupid bugs that you pointed out in earlier email,
     as well.  :-/
