Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbUJaMTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbUJaMTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUJaMTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:19:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:3563 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261538AbUJaMSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:18:43 -0500
Date: Sun, 31 Oct 2004 13:19:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031121937.GA20036@elte.hu>
References: <1099158570.1972.5.camel@krustophenia.net> <20041030191725.GA29747@elte.hu> <20041030214738.1918ea1d@mango.fruits.de> <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099189225.1754.1.camel@krustophenia.net> <20041031110039.4575e49c@mango.fruits.de> <1099224598.1459.28.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099224598.1459.28.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Actually this raises an interesting point.  Maybe all IRQ threads
> should get the same RT priority by default, so we get FIFO scheduling
> among IRQ threads.  It seems like this would make it harder for IRQ
> threads to starve each other.  Then we only have to elevate the
> priority of the IRQ thread(s) we are interested in.

we could do this too. The reason why i picked the current "start at
SCHED_FIFO prio 49 and decrease it by 1 until it reaches 25, then stay
constant" logic is that typically the irqs registered first are 'more
important' - e.g. the timer interrupt.

> Another idea is to allow SCHED_FIFO processes of equal priority to
> preempt one another on a LIFO basis.  Wouldn't this be very close to
> the traditional Linux interrupt model, where interrupts can interrupt
> each other and we handle the most recent interrupt first?

well, it's called SCHED_*FIFO* for a reason :-) What might make sense is
a SCHED_LIFO policy. But, i'm not so sure it's the right thing to do:
the best work-queueing model is almost always FIFO, as it gives the best
possible fairness between equals.

Fairness also often translates into better performance, because a system
that 'fluctuates' due to LIFO often underperforms a FIFO one because
when it fluctuates towards lower load it under-utilizes the resources,
and when it fluctuates up it overloads.  LIFO makes sense for anonymous
resources like pages/slabs where LIFO allocation leads to better cache
utilization. But i'd say for non-anonymous workloads it's almost always
a loss.

	Ingo
