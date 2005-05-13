Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVEMSSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVEMSSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVEMSSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:18:39 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:9125 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262454AbVEMSSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:18:30 -0400
Subject: Does smp_reschedule_interrupt really reschedule?
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 13 May 2005 14:18:19 -0400
Message-Id: <1116008299.4728.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working mostly with Ingo's RT patched kernel, but this may also be a
problem with the vanilla kernel.

Sending out a smp_send_reschedule which causes the
smp_reschedule_interrupt to go off on each CPU. (In Ingo's I was more
concerned with the smp_send_reschedule_allbutself).  In
arch/i386/kernel/smp.c there's the following code:

/*
 * Reschedule call back. Nothing to do,
 * all the work is done automatically when
 * we return from the interrupt.
 */
fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
{
        ack_APIC_irq();
}



As the comment says, do nothing since all the work is automatically done
at the return from interrupt. But is it?  Doesn't the need_resched need
to be set?  Here's what I'm seeing with Ingo's kernel.  I capture the
time in sched.c when the smp_send_reschedule_allbutself is called, and
also a capture of the time when the schedule actually takes place.  I'm
finding differences up to 2 tenths of a second.  That's TENTHS!  I added
the following patch:

--- arch/i386/kernel/smp.c	(revision 181)
+++ arch/i386/kernel/smp.c	(working copy)
@@ -593,6 +593,7 @@
 {
 	trace_special(regs->eip, 0, 0);
 	ack_APIC_irq();
+	set_tsk_need_resched(current);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)


(OK the trace_special is from Ingo's patch, but that's what I was
working with)

Now the largest latency between the call smp_send_reschedule and
schedule being called on another CPU is now 200 micro seconds, which is
much more reasonable.  But it also shows that a schedule is not taking
place without it.

Now, is there more logic that I'm missing to determine if the schedule
is not needed.  With Ingo's patch, he sends this when two RT tasks are
scheduled on the same CPU and one should migrate.  But the time this
takes varies tremendously.

Thanks,


-- Steve


Here's the patch for 2.6.11.6, just in case this is an issue. You just
need to delete the one for Ingo's. And Ingo would need to delete this.
Then again, the above is for a -p0 and this is -p1.

--- a/arch/i386/kernel/smp.c.orig	2005-05-13 14:06:54.000000000 -0400
+++ a/arch/i386/kernel/smp.c	2005-05-13 14:07:28.000000000 -0400
@@ -582,6 +582,7 @@
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+	set_tsk_need_resched(current);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)


