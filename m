Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272191AbRIVU4M>; Sat, 22 Sep 2001 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRIVU4C>; Sat, 22 Sep 2001 16:56:02 -0400
Received: from maile.telia.com ([194.22.190.16]:202 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S272191AbRIVUzx>;
	Sat, 22 Sep 2001 16:55:53 -0400
Message-Id: <200109222056.f8MKu8K24322@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: ksoftirqd? (Was: Re: [PATCH] Preemption Latency Measurement Tool)
Date: Sat, 22 Sep 2001 22:51:16 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Love <rml@tech9.net>, Andre Pang <ozone@algorithm.com.au>,
        linux-kernel@vger.kernel.org, safemode@speakeasy.net,
        Dieter.Nuetzel@hamburg.de, iafilius@xs4all.nl, ilsensine@inwind.it,
        george@mvista.com
In-Reply-To: <1000939458.3853.17.camel@phantasy> <200109221301.f8MD1n129687@mailc.telia.com> <20010922151453.B976@athlon.random>
In-Reply-To: <20010922151453.B976@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 September 2001 15.14, Andrea Arcangeli wrote:
> On Sat, Sep 22, 2001 at 02:56:58PM +0200, Roger Larsson wrote:
> > Hi,
> >
> > We have a new kid on the block since we started thinking of a preemptive
> > kernel.
> >
> > ksoftirqd...
> >
> > Running with nice 19 (shouldn't it really be -19?)

I repeat this question - should it be nice 19 and not nice -19 (not nice)?

> > Or have a RT setting? (maybe not since one of the reasons for
> > softirqd would be lost - would be scheduled in immediately)
> > Can't a high prio or RT process be starved due to missing
> > service (bh) after an interrupt?
>
> It cannot be starved, if ksoftirqd is never scheduled the do_softirq()
> will be run by the next timer irq or apic_timer irq.
>

Then could you please explain the output after adding a printk in
ksoftirqd like this.

--- kernel/softirq.c~   Mon Sep 17 22:37:34 2001
+++ kernel/softirq.c    Sat Sep 22 21:46:49 2001
@@ -387,6 +387,7 @@
                __set_current_state(TASK_RUNNING);

                while (softirq_pending(cpu)) {
+                       printk("ksoftirqd: do_softirq\n");
                        do_softirq();
                        if (current->need_resched)
                                schedule();


Output like this:

Sep 22 22:37:38 jeloin logger: *** ./stress_dbench begin ***
Sep 22 22:37:42 jeloin kernel: ksoftirqd: do_softirq
Sep 22 22:37:44 jeloin last message repeated 2 times
Sep 22 22:37:48 jeloin kernel: Latency   8ms PID     7 %% kupdated
Sep 22 22:37:49 jeloin kernel: ksoftirqd: do_softirq
Sep 22 22:38:19 jeloin last message repeated 18 times
Sep 22 22:38:20 jeloin su: (to root) roger on /dev/pts/2
Sep 22 22:38:20 jeloin PAM-unix2[988]: session started for user root, service 
su
Sep 22 22:38:23 jeloin kernel: ksoftirqd: do_softirq
Sep 22 22:38:24 jeloin modprobe: modprobe: Can't locate module net-pf-10
Sep 22 22:38:24 jeloin kernel: ksoftirqd: do_softirq
Sep 22 22:38:58 jeloin last message repeated 20 times
Sep 22 22:39:05 jeloin last message repeated 4 times
Sep 22 22:42:03 jeloin kernel: ksoftirqd: do_softirq
Sep 22 22:43:58 jeloin logger: *** ./stress_dbench end ***

> > This will not show up in latency profiling patches since
> > the kernel does what is requested...
> >
> > Previously it was run directly after interrupt,
> > before returning to the interrupted process...
>
> It is still the case, that's also the common case actually.
>

Possibly but the other case is quite common too...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
