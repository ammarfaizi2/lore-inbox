Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVA1AQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVA1AQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVA1AQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:16:28 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:19611
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261334AbVA1ANP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:13:15 -0500
Subject: High resolution timers and BH processing on -RT
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: George Anzinger <george@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 01:13:12 +0100
Message-Id: <1106871192.21196.152.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some thoughts and observations. 

I'm running -RT + a port of UTIME (the grandfather of HRT, IIRC) on a
couple of machines (x86,ppc,arm - all UP) here.

One part of the problem is the gettimeofday() issue, which seems to be
already addressed by John Stulz's patches.

The more interresting question in terms of realtime is the processing of
the timer queue(s) and the reprogramming of the timer for the next
event.

With -RT enabled the timer queue is solely processed by ksoftirqd, which
handles all the other bottom halfs too. So pushing the priority of
ksoftirqd up is not a solution. 
If I understood the HRT code correctly then this applies here too.
Please correct me if I'm wrong.

This makes the timer queue dependend on a variety of other softirq
clients, so you can not predict which of those clients are active and
what's the computation time they consume.

One possibility to solve this is seperating the softirqs into different
threads. We have done this already and it seems to be an interesting
approach in terms of scalability of bottom half processing.

Another approach is splitting realtime timers and normal timers, which
introduces the ugliness of different timer queues, but it has the
advantage that the rare realtime queue users can be handled in the
(threaded) top half for accuracy sake and the "normal" users are still
running on the jiffy bound vanilla linux timer queue, which is handled
in the non predictible path of the ksoftirqd thread.

I know that this topic was discussed various times already, but the -RT
view adds a different dimension. The modifications for the splitted
queues are minimal invasive in kernel/timer.c, but still introduce the
same amount of noise in nanosleep, itimer and posix_timer code.

Even if we agree that most of the timers are removed from the queue
before the expiry - especially those of the networking code - moving all
timers into high resolution mode results in non trivial noise injection
due to the short reprogramming intervals. 

Some numbers to make this more transparent.

Machine: PIII Celeron 333MHz
RT - T0: 1ms cyclic
RT - T1: 2ms cyclic
....

Load average is ~4.0 for all tests. The numbers are maximum deviation
from the timeline in microseconds. Test time was ~60 minutes for each
szenario.

Running all timers in high resolution mode (ksoftirqd) results in:
[T0  Prio:  60]  2123
[T1  Prio:  59]  2556
[T2  Prio:  58]  2882
[T3  Prio:  57]  2993
[T4  Prio:  56]  2888

Running all timers in high resolution mode (seperated timer softirqd
PRIO=70) results in:
[T0  Prio:  60]  423
[T1  Prio:  59]  372
[T2  Prio:  58]  756
[T3  Prio:  57]  802
[T4  Prio:  56]  1208

Seperating realtime process related timers into the threaded top half
queue (TIMER IRQ PRIO = 90) and running all other timers inside of
ksoftirqd results in:
[T0  Prio:  60]  84
[T1  Prio:  59]  114
[T2  Prio:  58]  120
[T3  Prio:  57]  117
[T4  Prio:  56]  158

I think that these numbers are significant for low power machines. This
area is my main concern - not the highend SMP szenario - as the main
users of realtime systems can be met in the embedded world.

Offtopic, but related question:

I discovered that the USB subsystem introduces 2-5 ms random chaos when
a device is pluged/unplugged. I had not time to track the culprit down
yet. Any pointers ???

tglx


