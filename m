Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbRFTDkA>; Tue, 19 Jun 2001 23:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbRFTDju>; Tue, 19 Jun 2001 23:39:50 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:34827 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264838AbRFTDjp>;
	Tue, 19 Jun 2001 23:39:45 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15152.6527.366544.713462@cargo.ozlabs.ibm.com>
Date: Wed, 20 Jun 2001 13:33:19 +1000 (EST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
In-Reply-To: <20010619210312.Z11631@athlon.random>
In-Reply-To: <20010619210312.Z11631@athlon.random>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> With pre3 there are bugs introduced into mainline that are getting
> extended to all architectures.
> 
> First of all nucking the handle_softirq from entry.S is wrong. ppc
> copied without thinking and we'll need to resurrect it too for example

Well, I object to the "without thinking" bit.  It seems to me that
code that raises a softirq without having either hard interrupts or
BHs disabled is buggy - why would you want to do that?  And if we do
want to allow that, shouldn't we put the check in raise_softirq or the
equivalent, to get the minimum latency?

> Fourth if the tasklet or softirq or bottom half hander is been marked
> running again because of another even (like a nested irq) the kernel can
> starve userspace too. (softirqs are much heavier than the irq handler so
> it can also live lockup much more easily this way)

Soft irqs should definitely not be much heavier than an irq handler,
if they are then we have implemented them wrongly somehow.

> So I recommend Linus merging this patch that fixes all the above
> mentioned bugs (the anti starvation/live lockup logic is called
> ksoftirqd):

ksoftirqd seems like the wrong solution to the problem to me, if we
really getting starved by softirqs then we need to look at whether
whatever is doing it should be a kernel thread itself rather than
doing it in softirqs.  Do you have a concrete example of the
starvation/live lockup that you can describe to us?

Regards,
Paul.
