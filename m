Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424452AbWKPU1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424452AbWKPU1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423801AbWKPU1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:27:25 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:40645 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1424452AbWKPU1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:27:25 -0500
Date: Thu, 16 Nov 2006 15:27:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Thomas Gleixner <tglx@timesys.com>
cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: BUG: cpufreq notification broken
In-Reply-To: <1163707250.10333.24.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0611161515430.2399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006, Thomas Gleixner wrote:

> [PATCH] cpufreq: make the transition_notifier chain use SRCU
> (b4dfdbb3c707474a2254c5b4d7e62be31a4b7da9)
> 
> breaks cpu frequency notification users, which register the callback on
> core_init level. Interestingly enough the registration survives the
> uninitialized head, but the registered user is lost by:
> 
> static int __init init_cpufreq_transition_notifier_list(void)
> {
> 	srcu_init_notifier_head(&cpufreq_transition_notifier_list);
> 	return 0;
> }
> core_initcall(init_cpufreq_transition_notifier_list);
> 
> This affects i386, x86_64 and sparc64 AFAICT, which call
> register_notifier early in the arch code.
> 
> > The head of the notifier chain needs to be initialized before use;
> > this is done by an __init routine at core_initcall time. If this turns
> > out not to be a good choice, it can easily be changed.
> 
> Hmm, there are no static initializers for srcu and the only way to fix
> this up is to move the arch calls to postcore_init.

If you can find a way to invoke init_cpufreq_transition_notifier_list 
earlier than core_initcall time, that would be okay.  I did it this way 
because it was easiest, but earlier should be just as good.

The only requirement is that alloc_percpu() has to be working, so that the 
SRCU per-cpu data values can be set up.  I don't know how early in the 
boot process you can do per-cpu memory allocation.

As an alternative approach, initialization of srcu_notifiers could be 
broken up into two pieces, one of which could be done statically.  The 
part that has to be done dynamically (the SRCU initialization) wouldn't 
mess up the notifier chain.  Provided the dynamic part is carried out 
while the system is still single-threaded, it would be safe.

Alan Stern

