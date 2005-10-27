Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVJ0Hvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVJ0Hvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 03:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVJ0Hvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 03:51:54 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:26339 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S964983AbVJ0Hvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 03:51:54 -0400
Date: Thu, 27 Oct 2005 16:50:27 +0900 (JST)
Message-Id: <20051027.165027.97297370.noboru.obata.ar@hitachi.com>
To: fastboot@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [KDUMP] pending interrupts problem
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Oct_27_16:50:27_2005_805)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Thu_Oct_27_16:50:27_2005_805)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

I'm having a problem in kdump on a Pentium 4 box when using SMP
kernel as the second (dump capturing) kernel.  Although the use
of SMP kernel as the second kernel is discouraged in
Documentation/kdump/kdump.txt, I hope discussing the problem
here will benefit users in the future.

I tracked down the problem to write a small module (attached)
that can reproduce the problem.

How to reproduce:

    - Configure both the first and the second kernels to be
      CONFIG_SMP=y
    - Boot the first kernel with "maxcpus=1"
    - Run "insmod pending-IPI.ko" to oops the second kernel

The module makes IPI (Inter-Processor Interrupt) pending upon a
crash.  This is done by:

    - Disable local interrupts.
    - Send IPI to CPU#0.
    - Call panic().

What happens in the second kernel is that it receives the
pending IPI at the first local_irq_enable() in init/main.c, and
the IPI handler calls the uninitialized function pointer
call_data->func in arch/i386/kernel/smp.c.

One way to solve this problem is to implement some blocking
mechanism in the IPI handler so that it prevents itself from
calling the uninitialized pointer.

But pending interrupts on other vectors may cause another
problem.  They would cause misrouted IRQs, which are now
addressed by "irqpoll" kernel parameter.  But I'm not sure this
solves all the problems.

So another way to solve this problem is to clear all such
pending interrupts before booting the second kernel.  This is
more challenging because the pending status (IRR bits ON) in a
local APIC can only be cleared by the acceptance of the
interrupt by CPU core (See section 8.8.4 in "IA-32 Intel(R)
Architecture Software Developer's Manual Vol.3").  That is, we
need to enable the interrupt somewhere in a crashed kernel to
clear the pending status.

Any other ideas to deal with pending interrupts?

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)


----Next_Part(Thu_Oct_27_16:50:27_2005_805)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="pending-IPI.c"

/* pending-IPI.c - Panic a kernel with IPI pending  */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/smp.h>

int init_module(void)
{
	local_irq_disable();

	apic_wait_icr_idle();
	apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(1));
	apic_write_around(APIC_ICR, (APIC_DM_FIXED
				     | APIC_DEST_LOGICAL | 0xfb));

	panic("pending-IPI: Bye-bye.");

	return 0;
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR("OBATA Noboru <noboru.obata.ar@hitachi.com>");
MODULE_DESCRIPTION("Panic a kernel with IPI pending");

----Next_Part(Thu_Oct_27_16:50:27_2005_805)----
