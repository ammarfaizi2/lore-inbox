Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132142AbRDDUQm>; Wed, 4 Apr 2001 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132137AbRDDUQc>; Wed, 4 Apr 2001 16:16:32 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:21764 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132124AbRDDUQU>;
	Wed, 4 Apr 2001 16:16:20 -0400
Message-ID: <20010404010759.A102@bug.ucw.cz>
Date: Wed, 4 Apr 2001 01:07:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: softirq buggy [Re: Serial port latency]
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)> <000401c0b828$bbdf7380$5517fea9@local> <20010331003645.F1579@atrey.karlin.mff.cuni.cz> <3AC6559E.575C4BAA@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AC6559E.575C4BAA@colorfullife.com>; from Manfred Spraul on Sun, Apr 01, 2001 at 12:09:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Seems floppy and console is buggy, then.
> >
> 
> No. The softirq implementation is buggy.
> I can trigger the problem with the TASKLET_HI (floppy), and both net rx
> and tx (ping -l)
> 
> > > What about creating a special cpu_is_idle() function that the idle
> > > functions must call before sleeping?
> > 
> > I'd say just fix all the bugs.
> >
> 
> Ok, there are 2 bugs that are (afaics) impossible to fix without
> checking for pending softirq's in cpu_idle():
> 
> a)
> queue_task(my_task1, tq_immediate);
> mark_bh();
> schedule();
> ;within schedule: do_softirq()
> ;within my_task1:
> mark_bh();
> ; bh returns, but do_softirq won't loop
> ; do_softirq returns.
> ; schedule() clears current->need_resched
> ; idle thread scheduled.
> --> idle can run although softirq's are pending

Or anything else can run altrough softirqs are pending. If it is
computation job, softinterrupts are delayed quiet a bit, right?

So right fix seems to be "loop in do_softirq".

								Pavel

> I assume I trigger this race with the floppy driver.
> 
> b)
> hw interrupt
> do_softirq
> within the net_rx handler: another hw interrupt, additional packets are
> queued
> do_softirq won't loop.
> returns to idle thread. --> packets delayed unnecessary.
> 
> What about the attached patch? Obviously the other idle cpu must be
> converted to use the function as well.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
