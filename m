Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSGXCLZ>; Tue, 23 Jul 2002 22:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSGXCLZ>; Tue, 23 Jul 2002 22:11:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1554 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315481AbSGXCLY>; Tue, 23 Jul 2002 22:11:24 -0400
Date: Tue, 23 Jul 2002 19:15:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: george anzinger <george@mvista.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruption in
 2.5.27?]
In-Reply-To: <Pine.LNX.4.44.0207240155550.5644-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207231904200.6943-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo,
 you really shouldn't use a generic #define like IRQ_MASK for something as
obscure as the mask for preemption bits (that apparently gets used
exactly _once_ in the same header file that defines it).

That #define is already used in the kernel inside various files, and from
the things I looked at, other users had more reason to call their stuff
IRQ_MASK than the new code has.

Also, please don't do things like

	#define NR_PREEMPT 256

when what you really are doing is doling out bits rather than "numbers".

So I think you'd be better off doing

	#define PREEMPT_BITS	8
	#define HARDIRQ_BITS	8
	#define SOFTIRQ_BITS	8

	#define PREEMPT_SHIFT	0
	#define HARDIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
	#define SOFTIRQ_SHIFT	(HARDIRQ_SHIFT + PREEMPT_BITS)

	#define __MASK(x)	((1UL << (x))-1)

	#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
	#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
	#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)

	#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
	#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
	#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))

which creates bitmasks from bit-operations rather than doing non-bitwise
arithmetic to get them from magic values that have to be powers-of-2.

And avoids using too generic a name (ie IRQ_MASK is gone).

Ehh?

		Linus

