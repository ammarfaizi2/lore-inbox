Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUH3PcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUH3PcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268501AbUH3PcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:32:01 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:3352 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268490AbUH3Pb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:31:57 -0400
Date: Mon, 30 Aug 2004 08:28:05 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jim Houston <jim.houston@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC&PATCH] Alternative RCU implementation]
Message-ID: <20040830152805.GA1244@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1093873222.984.12.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093873222.984.12.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 09:40:24AM -0400, Jim Houston wrote:
> Hi Everyone,
> 
> I sent this to the LKML on Friday, but it seems to have been
> lost so I'm sending it again.

Hello, Jim,

I was wondering what happened when my reply showed up without any
connection to your original.  Here is my reply again, just to get
thing tied in.

> The attached patch against linux-2.6.8.1-mm4 is an experimental
> implementation of RCU.
> 
> It uses an active synchronization between the rcu_read_lock(),
> rcu_read_unlock(), and the code which starts a new RCU batch.  A RCU
> batch can be started at an arbitrary point, and it will complete without
> waiting for a timer driven poll.  This should help avoid large batches
> and their adverse cache and latency effects.
> 
> I did this work because Concurrent encourages its customers to 
> isolate critical realtime processes to their own cpu and shield
> them from other processes and interrupts.  This includes disabling
> the local timer interrupt.  The current RCU code relies on the local
> timer to recognize quiescent states.  If it is disabled on any cpu,
> RCU callbacks are never called and the system bleeds memory and hangs
> on calls to synchronize_kernel().

Interesting approach, but I have some concern...

Are these critical realtime processes user-mode only, or do they
also execute kernel code?  If they are user-mode only, a much more
straightforward approach might be to have RCU pretend that they do
not exist.

This approach would have the added benefit of keeping rcu_read_unlock()
atomic-instruction free.  In some cases, the overhead of the atomic
exchange would overwhelm that of the read-side RCU critical section.

Taking this further, if the realtime CPUs are not allowed to execute in
the kernel at all, you can avoid overhead from smp_call_function() and
the like -- and avoid confusing those parts of the kernel that expect to
be able to send IPIs and the like to the realtime CPU (or do you leave
IPIs enabled on the realtime CPU?).

                                                        Thanx, Paul

[ . . . ]
