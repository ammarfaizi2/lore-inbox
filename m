Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbTHUIqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 04:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbTHUIqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 04:46:25 -0400
Received: from [61.34.11.200] ([61.34.11.200]:48347 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262533AbTHUIqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 04:46:20 -0400
Date: Thu, 21 Aug 2003 17:48:07 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: linux-kernel@vger.kernel.org
Subject: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030821084807.GA29913@atj.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I've been reading i386 interrupt handling code for a couple of days
and encountered something that looks like a race condition.  It's
between include/asm-i386/hardirq.h:irq_enter() and
arch/i386/kernel/irq.c:get_irqlock().  They seem to be using lockless
synchronization with local_irq_count of each cpu and global_irq_lock
variable.

 A. locking CPU

 1. Do test_and_set_bit() on global_irq_lock, if fail, repeat.
 2. If all local_irq_count's are zero, we're the winner.  Check other
    stuff; otherwise, clear global_irq_lock and retry.

 B. other CPUs

 1. Increment local_irq_count
 2. test_bit() on global_irq_lock, if zero, continue handling interrupt;
    otherwise, wait till it's cleared.

 For this to work, the locking CPU should fetch the value of
local_irq_count after global_irq_lock value becomes visible to other
CPUs, and other CPUs should fetch the value of global_irq_lock after
making the incremented local_irq_count visible to other CPUs.

 The locking CPU is OK because test_and_set_bit() forces ordering on
x86, but there should be a mb() betweewn step 1 and 2 for other CPUs
because none of ++ and test_bit is ordering.  The B part is irq_enter()
in hardirq.h which looks like the following.

static inline void irq_enter(int cpu, int irq)
{
	++local_irq_count(cpu);

	while (test_bit(0,&global_irq_lock)) {
		cpu_relax();
	}
}

 Is it a race condition or am I getting it horribly wrong?  Thx in
advance.
