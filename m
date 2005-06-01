Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFATY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFATY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVFATYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:24:09 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35082
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261250AbVFATWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:22:35 -0400
Date: Wed, 1 Jun 2005 21:22:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Karim Yaghmour <karim@opersys.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601192224.GV5413@g5.random>
References: <20050601143202.GI5413@g5.random> <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk> <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com> <20050601153803.GO5413@g5.random> <1117648391.20785.7.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117648391.20785.7.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 07:53:11PM +0200, Thomas Gleixner wrote:
> Thank god thats not the case. We did a patent research on this last year
> and the result was that you can replace the cli/sti by a software flag
> in the OS itself without violating the patent.

Did you publish something about it (so that people won't have to do it
over and over again)?

> The combination of replacing it in the host OS and running said host OS
> as an idle task of the underlying RTOS would violate the patent.
> 
> So if PREEMPT-RT would use a soft cli/sti emulation, no problem should
> arise.

So I wonder why it doesn't do that and it leaves local_irq_disable
uncovered making it a "metal hard" instead of "ruby hard" like rtai.

Why should preempt-RT leave any driver out there capable of breaking the
RT guarantee when it can simply redefine local_irq_disable too like
rtlinux? That sounds just wrong.

I'm talking about this:

#define local_irq_disable()    do { __asm__ __volatile__("cli": :
:"memory"); trace_irqs_off(); } while (0)

Why is the "cli" still there and capable of breaking the hard-RT every
time a driver (out of the kernel, whatever kernel module) calls it?

The software (and not hardware) local_irq_disable is the fundamental
piece of the "ruby hard" RT-guarantee. Be it done like in rtlinux, or
with a nanokernel hypervisor like in RTAI.

I don't get why preempt-RT doesn't fix this _last_ bit too to become a
"ruby hard" solution fully equivalent to RTAI and rtlinux.

Perhaps that's planned and not yet implemented?
