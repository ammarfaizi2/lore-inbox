Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbVGMTKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVGMTKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVGMTIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:08:20 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:34748 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262493AbVGMTHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:07:41 -0400
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress, part 3
From: Steven Rostedt <rostedt@goodmis.org>
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com,
       shemminger@osdl.org, rusty@au1.ibm.com
In-Reply-To: <20050713184800.GA1983@us.ibm.com>
References: <20050713184800.GA1983@us.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 13 Jul 2005 15:06:38 -0400
Message-Id: <1121281598.25810.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 11:48 -0700, Paul E. McKenney wrote:
> Hello!
> 
> Ported to CONFIG_PREEMPT_RT, and it actually boots!  Running tests,

Good! :)

> working thus far.  But thought I would post the patch and get feedback
> in the meantime, since I am not sure that my approach is correct.
> The questions:
> 
> 1.	Is use of spin_trylock() and spin_unlock() in hardirq code
> 	(e.g., rcu_check_callbacks() and callees) a Bad Thing?
> 	Seems to result in boot-time hangs when I try it, and switching
> 	to _raw_spin_trylock() and _raw_spin_unlock() seems to work
> 	better.  But I don't see why the other primitives hang --
> 	after all, you can call wakeup functions in irq context in
> 	stock kernels...

I never use _raw_spin_*.  I just declare the lock as a raw_spinlock_t
and the macro's determine to use them instead.  So I just keep the
spin_lock in the code. Or do you mean that you get problems using the
spin_locks when the code is already defined as raw_spinlock_t?

> 
> 2.	Is _raw_spin_lock_irqsave() intended for general use?  Its
> 	API differs from that of spin_lock_irqsave(), so am wondering
> 	if it is internal-use-only or something.  I currently
> 	use it from process context to acquire locks shared with
> 	rcu_check_callbacks().

I would assume not, but Ingo would be better at answering this.

> 
> 3.	Since SPIN_LOCK_UNLOCKED now takes the lock itself as an
> 	argument, what is the best way to initialize per-CPU
> 	locks?  An explicit initialization function, or is there
> 	some way that I am missing to make an initializer?

Ouch, I just notice that (been using an older version for some time). 

Ingo, is this to force the initialization of the lists instead of at
runtime?


-- Steve


