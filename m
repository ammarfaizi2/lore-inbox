Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVBOSNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVBOSNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVBOSNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:13:05 -0500
Received: from fmr19.intel.com ([134.134.136.18]:59306 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261799AbVBOSMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:12:54 -0500
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Date: Tue, 15 Feb 2005 10:06:44 -0800
User-Agent: KMail/1.5.4
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
References: <200502141240.14355.mgross@linux.intel.com> <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu>
In-Reply-To: <20050215104153.GB19866@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151006.44809.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 02:41, Ingo Molnar wrote:
> * Mark Gross <mgross@linux.intel.com> wrote:
> > On Monday 14 February 2005 13:24, Steven Rostedt wrote:
> > > On Mon, 2005-02-14 at 12:40 -0800, Mark Gross wrote:
> > > > I'm working on a tweak to the preepmtive soft IRQ implementation
> > > > using work queues and I'm having problems with a BUG assert when
> > > > trying to queue_work.
> > > >
> > > > Souldn't I be able to call queue_work form ISR context?
> > >
> > > Yes, but not with interrupts disabled.
> >
> > Hmm.  It seems to me that one should be able to call queue_work from
> > wherever you can call raise_softirq.  This constraint adds a bit of
> > asymetry in the deffered processing API's
>
> one solution is to use the local_irq_*_nort() API variants - but it all
> depends on why you had to disable interrupts.

I'm attempting to change the softIRQ preemption implementation to use work 
queues (one per softIRQ), that allow for runtime priority changes on a 
per-soft IRQ bases.  To do this I was trying to have raise_softirq call 
queu_work directly.  queue_work, doesn't use the *_nort() api's.

My alternitive is to put the call to queue_work into do_softIRQ.  Which seems 
to  work, but feels like a bit too much indirection to queue up the soft IRQ 
bottom half processing.


>
> Almost always irq-disabling done in conjunction with spinlocks, and the
> spin_lock_irq*() variants do not disable interrupts on PREEMPT_RT. I
> kept the assymetry of the local_irq*() APIs because in most cases they
> are used directly interrupts need to be disabled.
>
> it is also the more conservative approach, since we'll get messages like
> the ones you got when it's unsafe to do it - while if local_irq_*() APIs
> didnt disable interrupts we'd never know about the cases when they
> _must_ be disabled.)
>
> but yes, there's some API assymetry - which mostly comes from the fact
> alone that 99.999% of the kernel is now preemptible. There's just so
> much we can do to pretend that this is good'old Linux kernel semantics
>
> :-)
>
> 	Ingo

