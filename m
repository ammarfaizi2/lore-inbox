Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCaLF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCaLF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCaLF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:05:56 -0500
Received: from general.keba.co.at ([193.154.24.243]:34232 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261327AbVCaLF0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:05:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Thu, 31 Mar 2005 13:05:19 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231CE@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Thread-Index: AcU1Nqop1GfrHPWNTiiF+BWwihQLFQApo8MA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Mark Hahn" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The test system runs a 2.6.11 kernel (no SMP) on a Pentium3 500 MHz 
> > embedded hardware.
> 
> which probably has memory bandwidth of at most a couple hundred MB/s,
> which is really horrible by modern standards.

It's my job to find out if linux can be used for control systems 
on this (and smaller: ARM, embedded PPC) hardware. 
It's not my job to discuss the hardware.

This hardware is quite fast for embedded control system standards,
where product lifetimes exceed 10 years. AFAIK, intel does not
offer any P4 products with industrial availability and lifetime
gurantee (and they would run too hot anyway).

> > However, things break seriously when exercising the CF card 
> in parallel 
> > (e.g. with a dd if=/dev/hda of=/dev/null):
> > 
> > * The rtc *interrupt handler* is delayed for up to 250 
> *micro*seconds. 
> > This is very bad for my purpose, but easy to explain: It is 
> roughly the 
> > time needed to transfer 512 Bytes from a CF card which can 
> transfer 2 
> > Mbyte/sec, and obviously, the CPU blocks all interrupts 
> while making pio
> > 
> > transfers. (Why? Is this really necessary?)
> 
> even with -u1, isn't there still a softirq queue that will 
> delay the wakeup
> of your user-space tester?

I assume your comment belongs to the timings of my test program
(below), not to the timings of the rtc irq handler (above):
The softirq queue should not block the rtc irq handler I think.

The softirq queue should not even block user-space rt programs
for 60-300 ms. If something takes that long, it should perhaps 
be implemented as threads with a well-known rtprio, not in the 
softirq queue.

> > * The *test program* is regularly blocked for 63 *milli*seconds, 
> > sometimes for up to 300 *milli*seconds, which is absolutely
> > unacceptable.
> 
> guessing that's VM housekeeping.

I would feel better if I knew instead of guessing.
Moreover, VM housekeeping caused by non-rtpri programs should not
block memory-resident rt programs.
And the VM housekeeping in this case is just too simple to waste 
milliseconds on it: Just take one page of free mem (there is
plenty of it) and use it as a buffer...

> > Now the big question:
> > *** Why doesn't my rt test program get *any* CPU for 63 jiffies? ***
> > (the system ticks at 1000 HZ)
> 
> because it's user-space.  the 'rt' is a bit of a misnomer - 
> it's merely
> a higher priority, less preemptable job.
> 
> > * The dd program obviously gets some CPU regularly (because 
> it copies 2 
> > MB/s, and because no other program could cause the 1 % user 
> CPU load). 
> > The dd runs at normal shell scheduling priority, so it should be 
> > preempted immediately by my test program!
> 
> out of curiosity, does running it with "nice -n 19" change anything?

no.

> > 2.) Using a realtime-preempt-2.6.12-rc1-V0.7.41-11 kernel with
> > PREEMPT_RT:
> >     If my test program runs at rtpri 99, the problem is gone: It is 
> >     scheduled within 30 microseconds after the rtc interrupt.
> >     If my test program runs at rtpri 1, it still suffers 
> from delays 
> >     in the 30 to 300 millisecond range.
> 
> so your problem is solved, no?

No, running at an rtpri above the irq handlers is not an option 
in practice: My program would block irq handling...

> also, did you try a (plain) preemptable kernel?

What I called "vanilla" was configured with "plain" preemption.
 

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com
 
