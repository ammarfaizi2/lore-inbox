Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTKQOk4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 09:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTKQOk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 09:40:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7810 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263528AbTKQOkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 09:40:52 -0500
Date: Mon, 17 Nov 2003 09:42:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: kernwek jalsl <edityacomm@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: softirqd
In-Reply-To: <20031117094551.53765.qmail@web20704.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0311170914580.22131@chaos>
References: <20031117094551.53765.qmail@web20704.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, kernwek jalsl wrote:

> Hi All;
>
> On my embedded board I see that the preemption
> patch(Love etal.) is not of much use because of the
> following reaons:
>
> 1) calling the scheduler after the hardirq returns is
> not of much use because the actual work of puting the
> task in the run queue is done in the bottom half
> executed by ksoftirqd
> 2) ksoftirqd is not a real time thread
>
> Will the preemption patch work better if the ksoftirqd
> is made a real time thread?
>
> Another related question : has anyone thought of
> introducing prioirty among tasklets? Right now
> ksoftirqd treats them in a FIFO manner. Adding
> priority among the various tasklets and making sure
> that ksoftirqd looks ahead in the queue would ensure a
> real time treatment to a real time interrupt...
>

What is the problem that you are attempting to fix?
Stating that x is not y does not mean anything useful.
'Real-time' related to an 'interrupt' has no meaning.

An interrupt occurs as soon as hardware demands it.
The software response to that interrupt, i.e., interrupt-
latency is dependent upon the ISR setup code in the
kernel plus the execution time of any higher-priority
interrupts that may be occurring plus the execution time
of any prior code sharing the same interrupt. By the time
your ISR code gets control, the time is bounded by some
worse-case execution times and real-time has no meaning.

Then your ISR code must handle the immediate requirements
of the hardware as fast and efficiently as possible. Things
that can be deferred may be handed over to the soft-IRQ
stuff. If you have things that can't be deferred, you must
not do it in the soft-IRQ (used to be called bottom-half)
handler(s).

Specifically, the things that can be handled in a soft-IRQ
are hardware configuration changes and such where here are
no deadlines. If you have deadlines, i.e., you must get
the data out of a device now before it gets overwritten by
new data, then it must be done in the top-half handler.

Also, If you ever enable interrupts in your ISR, plan that
the CPU __will__ get taken away. It may be hundreds of
milliseconds before your ISR ever gets the CPU again. It
all depends upon the behavior of other drivers and some
network drivers even loop inside their ISR. Once they get
control, you may not get the CPU until a break in network
traffic!

In the context of a multi-user time-share operating system,
"real-time" means "fast enough". If your complete system can
keep up with the demands of these external events without
ever losing data, then it is "real-time". However, you can't
use these kinds of systems (fast-enough systems) in closed
servo-loops because the time from an interrupting event to
the completion of the necessary response to that event is
not known. For those kinds of "real-time" systems, you need
a "real-time kernel". Real-time kernels define the poles in
the system transfer-function so that the delay is known and
bounded within strict limits. Such systems are not "better".
In fact, they might be much slower in response to the usual
requirements for interactivity.

Realtime kernels do this by scheduling on strict time-boundaries.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


