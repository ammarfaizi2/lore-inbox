Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132473AbRDDVTI>; Wed, 4 Apr 2001 17:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132481AbRDDVS7>; Wed, 4 Apr 2001 17:18:59 -0400
Received: from colorfullife.com ([216.156.138.34]:49668 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132473AbRDDVSp>;
	Wed, 4 Apr 2001 17:18:45 -0400
Message-ID: <000901c0bd4c$c16fd5f0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)> <000401c0b828$bbdf7380$5517fea9@local> <20010331003645.F1579@atrey.karlin.mff.cuni.cz> <3AC6559E.575C4BAA@colorfullife.com> <20010404010759.A102@bug.ucw.cz>
Subject: Re: softirq buggy [Re: Serial port latency]
Date: Wed, 4 Apr 2001 23:18:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Pavel Machek" <pavel@ucw.cz>
>
> > Ok, there are 2 bugs that are (afaics) impossible to fix without
> > checking for pending softirq's in cpu_idle():
> >
> > a)
> > queue_task(my_task1, tq_immediate);
> > mark_bh();
> > schedule();
> > ;within schedule: do_softirq()
> > ;within my_task1:
> > mark_bh();
> > ; bh returns, but do_softirq won't loop
> > ; do_softirq returns.
> > ; schedule() clears current->need_resched
> > ; idle thread scheduled.
> > --> idle can run although softirq's are pending
>
> Or anything else can run altrough softirqs are pending. If it is
> computation job, softinterrupts are delayed quiet a bit, right?
>
> So right fix seems to be "loop in do_softirq".
>
No, it's the wrong fix.
A network server under high load would loop forever within the softirq,
never returning to process level.

do_softirq cannot loop, the right fix is "check often for pending
softirq's".
It's checked before a process returns to user space, it's checked when a
process schedules. What's missing is that the idle functions must check
for pending softirqs, too.

--
    Manfred

