Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319215AbSH2SIW>; Thu, 29 Aug 2002 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319251AbSH2SIW>; Thu, 29 Aug 2002 14:08:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3083 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319215AbSH2SIV>;
	Thu, 29 Aug 2002 14:08:21 -0400
Message-ID: <3D6E66D5.A97E5CF3@zip.com.au>
Date: Thu, 29 Aug 2002 11:24:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc. kernel preemption bits
References: <1030635181.978.2559.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
>         - we have a debug check in preempt_schedule that, even
>           on detecting a schedule with irqs disabled, still goes
>           ahead and reschedules.  We should return. (me)
> 

OK, but that warning will still come out of the mess in mm/slab.c.

Reminder:

CPU0:				CPU1:
	local_irq_disable();		resched_task(task on CPU0)
	spin_lock();
	...				p->need_resched = 1;
	spin_unlock(); // reschedules
	local_irq_enable();

There is one code path in slab which fixes this with _raw_spin_unlock()
and a subsequent preempt_disable(), but there are quite a lot of other
code paths which need the same treatment.  Fixing them is messy.

So unless you guys hit me with a brick, I'll create:

#ifdef CONFIG_SMP
#define preempt_disable_irqsave(flags)
	do {
		preempt_disable();
		local_irq_save(flags);
	} while (0)
#define preempt_enable_irqrestore(flags)
	do {
		local_irq_restore(flags);
		preempt_enable();
	} while (0)
#else
#define preempt_disable_irqsave(flags)
	do {
		local_irq_save(flags);
	} while (0)
#define preempt_enable_irqrestore(flags)
	do {
		local_irq_restore(flags);
	} while (0)
#endif

and use that in slab.
