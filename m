Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSGSUxB>; Fri, 19 Jul 2002 16:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSGSUxB>; Fri, 19 Jul 2002 16:53:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19638 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317034AbSGSUxA>;
	Fri, 19 Jul 2002 16:53:00 -0400
Date: Sat, 20 Jul 2002 22:54:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: [announce, patch, RFC] "big IRQ lock" removal, IRQ cleanups.
Message-ID: <Pine.LNX.4.44.0207202235400.23137-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the following patch, against 2.5.26:

  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.26-A2

is a work-in-progress massive cleanup of the IRQ subsystem. It's losely
based on Linus' original idea and DaveM's original implementation, to fold
our various irq, softirq and bh counters into the preemption counter.

with this approach it was possible:

 - to remove the 'big IRQ lock' on SMP - on which sti() and cli() relied.

 - to streamline/simplify arch/i386/kernel/irq.c significantly.

 - to simplify the softirq code.

 - to remove the preemption count increase/decrease code from the lowlevel
   IRQ assembly code.

 - to speed up schedule() a bit.

sti() and cli() is gone forever, there is no more globally synchronizing
irq-disabling capability. All code that relied on sti() and cli() and
restore_flags() must use other locking mechanisms from now on (spinlocks
and __cli()/__sti()).

obviously this patch breaks massive amounts of code, so only limited
.configs are working at the moment, such as:

  http://redhat.com/~mingo/remove-irqlock-patches/config

otherwise the patch was developed and tested on SMP systems, and while the
code is still a bit rough in places, the base IRQ code appears to be
pretty robust and clean.

while it boots already so the worst is over, there is lots of work left:
eg. to fix the serial layer to not use cli()/sti() and bhs ...

RMK, is there any chance to get your new serial layer into 2.5 sometime
soon? ['soon' as in 'tomorrow' :-) ] That is perhaps one of the biggest
kernel subsystems that make use of cli()/sti() currently. The rest is
drivers mostly, which is still not unsignificant, but perhaps a bit easier
to manage.

	Ingo

