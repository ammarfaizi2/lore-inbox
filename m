Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWFGDxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWFGDxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWFGDxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:53:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:49795 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750803AbWFGDxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:53:14 -0400
Subject: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 13:52:58 +1000
Message-Id: <1149652378.27572.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
> kernel-kernel-cpuc-to-mutexes.patch
> 
>  ug.  We cannot convert the cpu.c semaphore into a mutex until we work out
>  why power4 goes titsup if you enable local interrupts during boot.

What is the exact problem ? Some mutex is forcing local irqs enabled
before init_IRQ() ? (Before the normal enabling of IRQ done by
init/main.c just after init_IRQ() more precisely ?)

This is bad for any architecture. Basically, at this point, the
interrupt controller can be in _any_ state, with possible pending
interrupts for whatever sources, etc...

As we discussed before, that problem should really be fixed in the mutex
code by not hard-enabling.

There is an incredible amount of crap that could be cleaned up for
example by re-ordering a bit the init code and making things like slab
available before init_IRQ/time_init etc... but all of those will break
because of that.

In addition, even without that re-ordering, I'm pretty sure we are
hitting semaphores/mutexes early, before init_IRQ(), already and if not
in generic code, in arch code somewhere down the call stacks.

I don't think that whole pile of problems lurking around the corner is
worth the couple of cycles saved by hard-enabling irq in the mutex
instead of doing a save/restore.

Ben.


