Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRDAJFl>; Sun, 1 Apr 2001 05:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132077AbRDAJFc>; Sun, 1 Apr 2001 05:05:32 -0400
Received: from colorfullife.com ([216.156.138.34]:11528 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132056AbRDAJFY>;
	Sun, 1 Apr 2001 05:05:24 -0400
Message-ID: <3AC6559E.575C4BAA@colorfullife.com>
Date: Sun, 01 Apr 2001 00:09:34 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac20 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)> <000401c0b828$bbdf7380$5517fea9@local> <20010331003645.F1579@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------3736C7F42ABF3E1F14E70CD9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3736C7F42ABF3E1F14E70CD9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> 
> > >
> > > I've seen similar bugs. If you hook something on schedule_tq and
> > forget
> > > to set current->need_resched, this is exactly what you get.
> > >
> > I'm running with a patch that printk's if cpu_idle() is called while a
> > softirq is pending.
> > If I access the floppy on my K6/200 every track triggers the check, and
> > sometimes the console blanking code triggers it.
> 
> Seems floppy and console is buggy, then.
>

No. The softirq implementation is buggy.
I can trigger the problem with the TASKLET_HI (floppy), and both net rx
and tx (ping -l)

> > What about creating a special cpu_is_idle() function that the idle
> > functions must call before sleeping?
> 
> I'd say just fix all the bugs.
>

Ok, there are 2 bugs that are (afaics) impossible to fix without
checking for pending softirq's in cpu_idle():

a)
queue_task(my_task1, tq_immediate);
mark_bh();
schedule();
;within schedule: do_softirq()
;within my_task1:
mark_bh();
; bh returns, but do_softirq won't loop
; do_softirq returns.
; schedule() clears current->need_resched
; idle thread scheduled.
--> idle can run although softirq's are pending

I assume I trigger this race with the floppy driver.

b)
hw interrupt
do_softirq
within the net_rx handler: another hw interrupt, additional packets are
queued
do_softirq won't loop.
returns to idle thread. --> packets delayed unnecessary.

What about the attached patch? Obviously the other idle cpu must be
converted to use the function as well.

--
	Manfred
--------------3736C7F42ABF3E1F14E70CD9
Content-Type: text/plain; charset=us-ascii;
 name="patch-proc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-proc"

--- 2.4/arch/i386/kernel/process.c	Thu Feb 22 22:28:52 2001
+++ build-2.4/arch/i386/kernel/process.c	Sun Apr  1 00:05:21 2001
@@ -73,6 +73,30 @@
 	hlt_counter--;
 }
 
+/**
+ * cpu_is_idle - helper function for idle functions
+ * 
+ * pm_idle functions must call this function to verify that
+ * the cpu is really idle. It must be called with disabled
+ * local interrupts.
+ * Return values:
+ * 0: cpu was not idle, local interrupts reenabled.
+ * 1: go into power saving mode, local interrupts are
+ *    still disabled.
+*/
+static inline int cpu_is_idle(void)
+{
+	if (current->need_resched) {
+		__sti();
+		return 0;
+	}
+	if (softirq_active(smp_processor_id()) & softirq_mask(smp_processor_id())) {
+		__sti();
+		do_softirq();
+		return 0;
+	}
+	return 1;
+}
 /*
  * We use this if we don't have any better
  * idle routine..
@@ -81,10 +105,8 @@
 {
 	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
 		__cli();
-		if (!current->need_resched)
+		if (cpu_is_idle())
 			safe_halt();
-		else
-			__sti();
 	}
 }
 


--------------3736C7F42ABF3E1F14E70CD9--


