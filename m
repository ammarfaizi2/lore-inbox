Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132581AbRDHSQi>; Sun, 8 Apr 2001 14:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132583AbRDHSQ2>; Sun, 8 Apr 2001 14:16:28 -0400
Received: from colorfullife.com ([216.156.138.34]:22800 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132581AbRDHSQP>;
	Sun, 8 Apr 2001 14:16:15 -0400
Message-ID: <003801c0c058$15978340$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200104081758.VAA15670@ms2.inr.ac.ru>
Subject: Re: softirq buggy [Re: Serial port latency]
Date: Sun, 8 Apr 2001 20:16:49 +0200
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

From: <kuznet@ms2.inr.ac.ru>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.redhat.com>
Sent: Sunday, April 08, 2001 7:58 PM
Subject: Re: softirq buggy [Re: Serial port latency]


> Hello!
>
> > But with a huge overhead. I'd prefer to call it directly from within
the
> > idle functions, the overhead of schedule is IMHO too high.
>
>
> + if (current->need_resched) {
> + return 0;
> ^^^^^^^^
> + }
> + if (softirq_active(smp_processor_id()) &
softirq_mask(smp_processor_id())) {
> + do_softirq();
> + return 0;
> ^^^^^^^^^
> You return one value in both casesand I decided it means "schedule".
8)
> Apparently you meaned return 1 in the first case. 8)
>
No, the code is correct. 0 means "don't stop the cpu".
The pm_idle function pointer will return to cpu_idle()
(arch/i386/kernel/process.c), and that function contains another

    while(!current->need_resched)
        idle();

loop ;-)

> But in this case it becomes wrong. do_softirq() can raise need_reshed
> and moreover irqs arrive during it. Order of check should be
different.
>
Yes, I'll correct that.

>
> BTW what's about overhead... I suspect it is _lower_ in the case
> of schedule(). In the case of networking at least, when softirq
> most likely wakes some socket.
>
I'm not sure - what if the computer is just a router?
But OTHO: the cpu is idle, so it doesn't matter at all if the idle cpu
spends it's time within schedule() or within safe_hlt(), I'll change my
patch.

I have another question:
I added cpu_is_idle() into <linux/interrupt.h>. Is that acceptable, or
is there a better header file for such a function?

--
    Manfred

