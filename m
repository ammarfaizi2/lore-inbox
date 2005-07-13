Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVGMPnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVGMPnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVGMPlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:41:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14064 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262945AbVGMPkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:40:52 -0400
Date: Wed, 13 Jul 2005 08:41:25 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: shemminger@osdl.org, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: PREEMPT/PREEMPT_RT question
Message-ID: <20050713154124.GD1304@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050712163031.GA1323@us.ibm.com> <1121187924.6917.75.camel@localhost.localdomain> <20050712192832.GB1323@us.ibm.com> <1121198657.3548.11.camel@localhost.localdomain> <20050712213426.GD1323@us.ibm.com> <1121212035.3548.34.camel@localhost.localdomain> <20050713014627.GF1323@us.ibm.com> <1121226890.3548.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121226890.3548.44.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 11:54:50PM -0400, Steven Rostedt wrote:
> On Tue, 2005-07-12 at 18:46 -0700, Paul E. McKenney wrote:
> 
> > > If you are talking about scheduler_tick, then yes, it is called by the
> > > timer interrupt which is a SA_NODELAY interrupt.  If you don't want to
> > > get interrupted by the timer interrupt, then you will need to disable
> > > interrupts for both. Since currently, the timer interrupt is the only
> > > true hard interrupt in the PREEMPT_RT and that may not change.
> > 
> > OK, so if I take a spinlock in something invoked from scheduler_tick(),
> > then any other acquisitions of that spinlock must disable hardware
> > interrupts, right?
> 
> Yes, otherwise you could have a local CPU deadlock on a SMP machine. And
> I would also say the same is true for any lock that is grabbed by the
> timer interrupt or one of the functions it calls.

OK, I do indeed have critical sections spanning rcu_check_callbacks()
and process-level code.  Since rcu_check_callbacks() is called from
account_user_vtime() and update_process_times(), both of which call
scheduler_tick(), looks like I need to disable hardware interrupts.

Looks to me like I need to use _raw_spin_lock() and
_raw_spin_unlock() from within rcu_check_callbacks(), but to instead
use _raw_spin_lock_irqsave() and _raw_spin_lock_irqrestore() outside of
rcu_check_callbacks() for locks acquired within rcu_check_callbacks().

Of course, for fliplock, which is only acquired conditionally from
a rcu_check_callbacks() callee, I can just use spin_trylock() and
spin_unlock().  Though _raw_spin_lock()/_raw_spin_unlock() might be
faster?

No -wonder- I have been seeing hangs in CONFIG_PREEMPT_RT!!!  ;-)

						Thanx, Paul
