Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVC3NB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVC3NB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 08:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVC3NB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 08:01:28 -0500
Received: from general.keba.co.at ([193.154.24.243]:39064 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261877AbVC3NBT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 08:01:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: PREEMPT_RT: Undetected latencies?
Date: Wed, 30 Mar 2005 14:59:26 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231C4@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PREEMPT_RT: Undetected latencies?
Thread-Index: AcU1KE3RU4s8SLt5SoeG4W/IqEmjfw==
From: "kus Kusche Klaus" <kus@keba.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experimenting with a realtime-preempt-2.6.12-rc1-V0.7.41-11 kernel,
preemption fully enabled, and a small RTC test program (see my previous
mail for details).

If my program runs at rtprio 99, most of the time everything is fine:
* My program records intervals of 122 +- 40 microseconds (which
corresponds nicely to the 8192 Hz RTC interrupt).
* Both the kernel's RTC histogram and the kernel's RT latency trace stay
below 40 microseconds.

However, during extensive testing, I found some cases which extend the
intervals unacceptably:
1.) When a test program performs massive mmaps (at base shell prio) and
activates the oom killer, my program measures intervals in the 15
millisecond range.
2.) When I get the USB errors described in a separate mail earlier
today, I also get intervals from 10 to 15 milliseconds.
(a combination of heavy USB and CF card traffic also seems to cause
blackouts in the 1 ms range even for rtprio 99, but I have to look into
that again)

Surprisingly, in both cases the worst latencies traced by the RT latency
trace and the RTC histogram are still less than 40 microseconds!
Moreover, the values read from /dev/rtc do not indicate any lost
interrupts. This seems to indicate that neither the RTC IRQ handler
itself nor timers were executed during these 15 millisecond period,
otherwise, either the RTC IRQ handler or the rtc_dropped_irq watchdog
would have counted lost interrupts! It seems that something locked up
the system completely for 15 ms: No interrupts at all, no scheduling,
...

Now, there are several questions:
* What is causing these 15 ms latencies in the two cases above, and how
can they be fixed?
* Why aren't they detected at all by any traces? 
Are these classical spinlocks which aren't instrumented? 
Are they explicit cli/sti in device drivers? 
Any other possibilities?
How can this be traced and analyzed?

A simple explanation would be that the TSC is reset. Is there any code
in the kernel messing with the TSC?

If my program runs at rtprio 1 instead of rtprio 99, many things cause
long intervals:
* normal working load (up to 1.2 ms)
* heavy mmap load without oom (many samples increased by 0.2 ms)
* heavy USB stick I/O without errors (up to 3 ms)
* core dumps (up to 10 ms)
* heavy USB stick I/O with errors (up to 15 ms)
* oom killer (up to 100 ms)
* heavy CF card I/O (up to 300 ms, see separate mail)
Even on an idle system, I see 1 ms intervals now and then!

Again, the latency traces are in the range of 40 to 50 microseconds
only, so these delays are caused by something not covered by the latency
tracer. How to find that out?

One more question: When my test program runs at rtprio 1, there are huge
delays (up to 100 ms) between the moment the rtc read gets ready and the
moment the program is actually scheduled. However, even then the wakeup
latency trace is not showing it. What is actually measured by the wakeup
latency trace?

Thanks for any help!

Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-8919
> E-Mail: kus@keba.com
> www.keba.com
> 
> 
