Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbSIPVKB>; Mon, 16 Sep 2002 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbSIPVKB>; Mon, 16 Sep 2002 17:10:01 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:21262
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263062AbSIPVKA>; Mon, 16 Sep 2002 17:10:00 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0209161157300.1352-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209161157300.1352-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 17:14:56 -0400
Message-Id: <1032210898.1010.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 15:01, Linus Torvalds wrote:

> Would it not be a lot better to just mask off PREEMPT_ACTIVE() instead of 
> checking for it explicitly.
> 
> The in_interrupt() etc stuff already effectively do this by masking off
> the HARDIRQ_MASK etc. I would prefer a patch to hardirq.h that just adds a
> #define to make preempt_count() not contain PREEMPT_ACTIVE - and make the
> PREEMPT_ACTIVE checks be a totally separate check (logic: it's not a
> count, so it shouldn't show up in preempt_count())

I liked this idea, and was working on implementing it when I ran into a
few roadblocks.  Your ideas are welcome.

First, "preempt_count()" is used as an l-value in a lot of places, i.e.
look at all the "preempt_count() += foo" in the IRQ code.  We cannot
mask things out of it.

Thus, I then looked into doing a separate function for the raw value,
say an "atomic_count()" ... the code just looked ugly mixing
"atomic_count()" and "preempt_count()" for no apparent reason.

Third, PREEMPT_ACTIVE actually _is_ part of the count.  It helps assure
us a task is not preempted repeatedly.  If we did not have it, we would
have to bump preempt_count on preemption.  So we still need it in the
preempt_count().

Simplest solution is to:

	#define in_atomic() \
		(preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())

although I still dislike the masking just to make the schedule()
code-path cleaner.

Oh, and there is another problem: printk() from schedule() implicitly
calls wake_up().  My machine dies even with just a printk() and not a
BUG()... I suspect there may be some SMP issue in that whole mess too,
because setting oops_in_progress prior did not help.

Comments?

	Robert Love

