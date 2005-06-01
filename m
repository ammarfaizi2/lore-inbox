Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVFAThd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVFAThd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVFATha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:37:30 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:15850 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261297AbVFATgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:36:06 -0400
Date: Wed, 1 Jun 2005 21:34:58 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Karim Yaghmour <karim@opersys.com>,
       Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050601192224.GV5413@g5.random>
Message-Id: <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Andrea Arcangeli wrote:

> On Wed, Jun 01, 2005 at 07:53:11PM +0200, Thomas Gleixner wrote:
> > Thank god thats not the case. We did a patent research on this last year
> > and the result was that you can replace the cli/sti by a software flag
> > in the OS itself without violating the patent.
> 
> Did you publish something about it (so that people won't have to do it
> over and over again)?
> 
> > The combination of replacing it in the host OS and running said host OS
> > as an idle task of the underlying RTOS would violate the patent.
> > 
> > So if PREEMPT-RT would use a soft cli/sti emulation, no problem should
> > arise.
> 
> So I wonder why it doesn't do that and it leaves local_irq_disable
> uncovered making it a "metal hard" instead of "ruby hard" like rtai.
> 
> Why should preempt-RT leave any driver out there capable of breaking the
> RT guarantee when it can simply redefine local_irq_disable too like
> rtlinux? That sounds just wrong.
> 
> I'm talking about this:
> 
> #define local_irq_disable()    do { __asm__ __volatile__("cli": :
> :"memory"); trace_irqs_off(); } while (0)
> 
> Why is the "cli" still there and capable of breaking the hard-RT every
> time a driver (out of the kernel, whatever kernel module) calls it?
> 
> The software (and not hardware) local_irq_disable is the fundamental
> piece of the "ruby hard" RT-guarantee. Be it done like in rtlinux, or
> with a nanokernel hypervisor like in RTAI.
> 
> I don't get why preempt-RT doesn't fix this _last_ bit too to become a
> "ruby hard" solution fully equivalent to RTAI and rtlinux.
> 
> Perhaps that's planned and not yet implemented?
> 
It is simply not needed: Any driver suitable for SMP is using spin-locks,
which becomes mutexes when CONFIG_PREEMPT_RT is set. Therefore: SMP safe
becomes RT safe.
Ofcourse, you can manually have to grep the code for offending
local_irq_disable() or cli()'s just to make sure.

Doesn't RTAI at least in principle have the same problem? Someone might
have coded a local irq-disable directly in assambler without the official
macros? The Adeos patch wouldn't catch it then, right? (The risc of that
is very small, I know...)

Esben

