Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVBOKmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVBOKmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVBOKmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:42:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20203 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261673AbVBOKmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:42:03 -0500
Date: Tue, 15 Feb 2005 11:41:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Message-ID: <20050215104153.GB19866@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com> <1108416249.8413.54.camel@localhost.localdomain> <200502141429.11587.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502141429.11587.mgross@linux.intel.com>
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


* Mark Gross <mgross@linux.intel.com> wrote:

> On Monday 14 February 2005 13:24, Steven Rostedt wrote:
> > On Mon, 2005-02-14 at 12:40 -0800, Mark Gross wrote:
> > > I'm working on a tweak to the preepmtive soft IRQ implementation using
> > > work queues and I'm having problems with a BUG assert when trying to
> > > queue_work.
> > >
> > > Souldn't I be able to call queue_work form ISR context?
> >
> > Yes, but not with interrupts disabled.
> 
> Hmm.  It seems to me that one should be able to call queue_work from
> wherever you can call raise_softirq.  This constraint adds a bit of
> asymetry in the deffered processing API's

one solution is to use the local_irq_*_nort() API variants - but it all
depends on why you had to disable interrupts.

Almost always irq-disabling done in conjunction with spinlocks, and the
spin_lock_irq*() variants do not disable interrupts on PREEMPT_RT. I
kept the assymetry of the local_irq*() APIs because in most cases they
are used directly interrupts need to be disabled.

it is also the more conservative approach, since we'll get messages like
the ones you got when it's unsafe to do it - while if local_irq_*() APIs
didnt disable interrupts we'd never know about the cases when they
_must_ be disabled.)

but yes, there's some API assymetry - which mostly comes from the fact
alone that 99.999% of the kernel is now preemptible. There's just so
much we can do to pretend that this is good'old Linux kernel semantics
:-)

	Ingo
