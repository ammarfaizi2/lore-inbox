Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbRFTMTJ>; Wed, 20 Jun 2001 08:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264356AbRFTMS7>; Wed, 20 Jun 2001 08:18:59 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60428 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264355AbRFTMSq>;
	Wed, 20 Jun 2001 08:18:46 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15152.38018.523162.191937@cargo.ozlabs.ibm.com>
Date: Wed, 20 Jun 2001 22:18:10 +1000 (EST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
In-Reply-To: <20010620055413.A849@athlon.random>
In-Reply-To: <20010619210312.Z11631@athlon.random>
	<15152.6527.366544.713462@cargo.ozlabs.ibm.com>
	<20010620055413.A849@athlon.random>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> We should release the stack before running the softirq (some place uses
> softirqs to release the stack and avoid overflows).

Well if they are relying on having a lot of stack available then those
places are buggy.  Once the softirq is made pending it can run at any
time that interrupts are enabled.  You can't rely on a softirq handler
having any more stack available than a hard interrupt handler has.

> ip + tcp are more intensive than just queueing a packet in a blacklog.
> That's why they're not done in irq context in first place.

Ah, ok, I misunderstood, I thought you were saying that that softirq
framework itself had a lot of overhead.

> I don't have gigabit ethernet so I cannot flood my boxes to death.
> But I think it's real, and a softirq marking itself runnable again is
> another case to handle without live lockups or starvation.

As for the gigabit ethernet case, if we are having packets coming in
and generating hard interrupts at that sort of a rate then what we
really need is the sort of interrupt throttling that Jamal talked
about at the 2.5 kernel kickoff.

It seems to me that possibly softirqs are being used in some places
where a kernel thread would be more appropriate.  Instead of making
softirqs use a kernel thread, I think it would be better to find the
places that should use a thread and make them do so.  Softirqs are
still after all interrupt handlers (ones that run at a lower priority
than any hardware interrupt) and should be treated as such.

Paul.
