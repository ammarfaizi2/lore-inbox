Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVDEDdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVDEDdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 23:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDEDdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 23:33:31 -0400
Received: from [24.24.2.57] ([24.24.2.57]:36847 "EHLO ms-smtp-03.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S261370AbVDEDd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 23:33:26 -0400
Subject: Re: scheduler/SCHED_FIFO behaviour
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: juhl-lkml@dif.dk, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY10-F20EDF8B5558E2E8945A4DAD93C0@phx.gbl>
References: <BAY10-F20EDF8B5558E2E8945A4DAD93C0@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 04 Apr 2005 23:33:05 -0400
Message-Id: <1112671985.5147.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 07:46 +0530, Arun Srinivas wrote:

> 
> So, what I want from the above code is whenever process1 or process2 is 
> being scheduled measure the time and print the timedifference. But, when I 
> run my 2 processes as SCHED_FIFO processes i get only one set of 
> readings....indicating they have been scheduled only once and run till 
> completion.
> 
> But, as we saw above if interrupts have been processed they must have been 
> scheduled several times(i.e., schedule() called several times). Is my 
> measurement procedure not correct?

No! Interrupts are not scheduled. When an interrupt goes off, the
interrupt service routine (ISR) is executed. It doesn't need to be
scheduled. It runs right where it interrupted the CPU. That's why you
need to be careful about protecting data that ISRs manipulate with
spin_lock_irqsave. This not only protects against multiple CPUs, but
turns off interrupts so that an interrupt wont be called and one of the
ISRs modify the data you need to be atomic.

Your tasks are running and will be interrupted by an ISR, on return from
the routine, a check is made to see if your tasks should be preempted.
But since they are the highest running tasks and in FIFO mode, the check
determines that schedule should not be called.  So you will not see any
schedules while your tasks are running.

Now, if you where running Ingo's RT patch with PREEMPT_HARDIRQ enabled,
and your tasks were of lower priority than the ISR thread handlers, then
you would see the scheduling. Maybe that is what you want?

-- Steve


