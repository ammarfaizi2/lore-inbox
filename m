Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVCRPxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVCRPxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVCRPxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:53:06 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17052 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261648AbVCRPwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:52:36 -0500
Date: Fri, 18 Mar 2005 07:48:20 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318154820.GB1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050318002026.GA2693@us.ibm.com> <20050318100339.GA15386@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318100339.GA15386@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 11:03:39AM +0100, Ingo Molnar wrote:
> 
> there's a problem in #5's rcu_read_lock():
> 
>         void
>         rcu_read_lock(void)
>         {
>                 preempt_disable();
>                 if (current->rcu_read_lock_nesting++ == 0) {
>                         current->rcu_read_lock_ptr =
>                                 &__get_cpu_var(rcu_data).lock;
>                         read_lock(current->rcu_read_lock_ptr);
>                 }
>                 preempt_enable();
>         }
> 
> not only are read_lock()-ed sections preemptible, read_lock() itself may
> block, so it cannot be called from within preempt_disable(). How about
> something like:
> 
>         void
>         rcu_read_lock(void)
>         {
>                 preempt_disable();
>                 if (current->rcu_read_lock_nesting++ == 0) {
>                         current->rcu_read_lock_ptr =
>                                 &__get_cpu_var(rcu_data).lock;
>                         preempt_enable();
>                         read_lock(current->rcu_read_lock_ptr);
>                 } else
>                         preempt_enable();
>         }
> 
> this would still make it 'statistically scalable' - but is it correct?

Good catch!

Also good question...

Strictly speaking, it is not necessary to block callback invocation until
just after rcu_read_lock() returns.

It is correct as long as there is no sort of "upcall" or "callback" that
can masquerade as this task.  I know of no such thing in the Linux kernel.
In fact such a thing would break a lot of code, right?

Any tool that relied on the ->rcu_read_lock_nesting counter to deduce
RCU state would be confused by this change, but there might be other
ways of handling this.  Also, we are currently making do without such
a tool.

It should be possible to move the preempt_enable() further forward
ahead of the assignment to ->rcu_read_lock_ptr, since the assignment
to ->rcu_read_lock_ptr is strictly local.  Not sure that this is
worthwhile, thoughts?

        void
        rcu_read_lock(void)
        {
                preempt_disable();
                if (current->rcu_read_lock_nesting++ == 0) {
                        preempt_enable();
                        current->rcu_read_lock_ptr =
                                &__get_cpu_var(rcu_data).lock;
                        read_lock(current->rcu_read_lock_ptr);
                } else
                        preempt_enable();
        }

The other question is whether preempt_disable() is needed in the first
place.  The two task-structure fields are not accessed except by the
task itself.  I bet that the following is just fine:

        void
        rcu_read_lock(void)
        {
                if (current->rcu_read_lock_nesting++ == 0) {
                        current->rcu_read_lock_ptr =
                                &__get_cpu_var(rcu_data).lock;
                        read_lock(current->rcu_read_lock_ptr);
                }
        }

Thoughts?

					Thanx, Paul
