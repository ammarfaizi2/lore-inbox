Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWAYXvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWAYXvB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWAYXvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:51:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:57779 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751218AbWAYXvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:51:00 -0500
Subject: Re: [patch, validator] fix clocksource_lock deadlock
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060125180032.GA11734@elte.hu>
References: <20060125180032.GA11734@elte.hu>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 15:50:57 -0800
Message-Id: <1138233057.14289.54.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 19:00 +0100, Ingo Molnar wrote:
> clocksource_lock is used in softirq-context via e.g.  
> timeofday_periodic_hook() -> get_next_clocksource(), but the lock is not 
> acquired in a softirq-safe manner - which could lead to deadlocks.

Nice catch. Andrew also noticed this issue just a few hours before you
sent this. Great minds...


> this bug was found via the lock validator i'm working on:
> 
>   ============================
>   [ BUG: illegal lock usage! ]
>   ----------------------------
>   illegal {used-in-softirq} -> {enabled-softirqs} usage.
>   swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes {clocksource_lock [u:21]}, at:
>    [<c013f526>] register_clocksource+0x16/0xf0
>   {used-in-softirq} state was registered at:
>    [<c013f22d>] get_next_clocksource+0xd/0x40
>   hardirqs last enabled at: [<c011d31a>] vprintk+0x28a/0x3e0
>   softirqs last enabled at: [<c0122999>] irq_exit+0x39/0x50
>   
>   other info that might help in debugging this:
>   ------------------------------
>   | showing all locks held by: |  (swapper/1 [c30d7790, 125]): <none>
>   ------------------------------
>   
>    [<c010432d>] show_trace+0xd/0x10
>    [<c0104347>] dump_stack+0x17/0x20
>    [<c01379b2>] print_usage_bug+0x1e2/0x200
>    [<c013817d>] mark_lock+0x28d/0x2a0
>    [<c0138835>] debug_lock_chain+0x6a5/0x10d0
>    [<c013929d>] debug_lock_chain_spin+0x3d/0x60
>    [<c026570d>] _raw_spin_lock+0x2d/0x90
>    [<c04d88d8>] _spin_lock+0x8/0x10
>    [<c013f526>] register_clocksource+0x16/0xf0
>    [<c0681137>] init_pit_clocksource+0x57/0x90
>    [<c01003fa>] init+0xfa/0x3e0
>    [<c0100ef5>] kernel_thread_helper+0x5/0x10
> 
> the fix is to lock clocksource_lock in a softirq-safe way.
> 
> (with this patch applied, the timeofday code validates fine.)

I'm getting lots of local_bh_disable warnings with this patch on my
timeofday tree (interrupts are disabled in timefoday_periodic_hook which
calls get_next_clocksource). Wouldn't using spin_lock_irqsave/restore be
better here (seems to work for me)?

thanks
-john

