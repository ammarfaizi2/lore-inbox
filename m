Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283009AbRLXH6s>; Mon, 24 Dec 2001 02:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284254AbRLXH6i>; Mon, 24 Dec 2001 02:58:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21679 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283009AbRLXH6Z>;
	Mon, 24 Dec 2001 02:58:25 -0500
Date: Mon, 24 Dec 2001 10:55:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ashok Raj <ashokr2@attbi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: affinity and tasklets...
In-Reply-To: <PPENJLMFIMGBGDDHEPBBKELMCAAA.ashokr2@attbi.com>
Message-ID: <Pine.LNX.4.33.0112241042540.2073-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Dec 2001, Ashok Raj wrote:

> #2: You got it right. The hw is designed to generate a fewer # of
> interrupts, since the information necessary is available in other
> means, and there is a lot of time saved by not taking the interrupt.

point is, there is no time saved by not taking the interrupt. In fact it's
slightly more expensive to use smp_call_function() instead of getting the
proper hardware interrupts. (because there is some setup cost of inter-CPU
APIC interrupts, and also you have to load-balance manually.)

the IRQ latency itself does not show up as lost CPU time on modern IRQ
delivery systems - while the IRQ latency is around 5-10 microseconds, the
true 'null interrupt cost' is only around 1-3 microseconds on 8-way
systems. And by generating cross-CPU interrupts for smp_call_function()
there are almost no savings anyway - they are normal interrupts and have
similar IRQ entry overhead as hardware-IRQs.

so it's almost always the better idea to use multiple interrupts if there
are multiple, more or less orthogonal devices. There might be cases where
it's the best solution to keep a single IRQ source (eg. hw simplicity, or
conserving IRQ space) - but almost never for performance reasons,
software-driven IRQ distribution is not going to be more efficient than a
hardware-based one.

	Ingo

