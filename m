Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUKJJ6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUKJJ6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUKJJ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:58:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3517 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261645AbUKJJ5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:57:54 -0500
Date: Wed, 10 Nov 2004 11:59:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Hood <jdthood@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/preempt-locking.txt clarification
Message-ID: <20041110105951.GA3714@elte.hu>
References: <1073302283.1903.85.camel@thanatos.hubertnet> <1074561880.26456.26.camel@localhost> <1100074907.3654.780.camel@thanatos> <20041110005742.35828d2b.akpm@osdl.org> <1100078840.3654.822.camel@thanatos> <20041110014543.143b8ff3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110014543.143b8ff3.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> I think the statement is in fact false.  Ingo, what's your take on
> this paragraph, from preempt-locking.txt?
> 
>   An additional concern is proper usage of local_irq_disable and
>   local_irq_save.  These may be used to protect from preemption,
>   however, on exit, if preemption may be enabled, a test to see if
>   preemption is required should be done.  If these are called from the
>   spin_lock and read/write lock macros, the right thing is done.  They
>   may also be called within a spin-lock protected region, however, if
>   they are ever called outside of this context, a test for preemption
>   should be made.  Do note that calls from interrupt context or bottom
>   half/ tasklets are also protected by preemption locks and so may use
>   the versions which do not check preemption.

seems mostly correct. The issue is that if a wakeup is done from within
an irqs-off critical section (perfectly possible - a simple printk can
trigger a wakeup) then the current task may be marked for rescheduling
but cannot do it just yet. So when interrupts are re-enabled again
(outside of a critical section) a manual preempt_check_resched() is
necessary in the generic case, or else we miss the reschedule.

In special cases, if no wakeup may happen from within the irqs-off
section then the manual preemption can be skipped, because asynchronous
reschedules (e.g. on SMP) always come in the form of interrupts. I'd
wager that in fact these 'special cases' are in the majority, but
there's no guarantee.

	Ingo
