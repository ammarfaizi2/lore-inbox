Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVBPFRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVBPFRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVBPFRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:17:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44444 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261986AbVBPFRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:17:19 -0500
Date: Wed, 16 Feb 2005 06:16:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>, Mark_H_Johnson@raytheon.com
Subject: Re: queue_work from interrupt Real time preemption2.6.11-rc2-RT-V0.7.37-03
Message-ID: <20050216051645.GB15197@elte.hu>
References: <200502141240.14355.mgross@linux.intel.com> <200502141429.11587.mgross@linux.intel.com> <20050215104153.GB19866@elte.hu> <200502151006.44809.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502151006.44809.mgross@linux.intel.com>
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

> I'm attempting to change the softIRQ preemption implementation to use
> work queues (one per softIRQ), that allow for runtime priority changes
> on a per-soft IRQ bases.  To do this I was trying to have
> raise_softirq call queu_work directly.  queue_work, doesn't use the
> *_nort() api's.
> 
> My alternitive is to put the call to queue_work into do_softIRQ. 
> Which seems to work, but feels like a bit too much indirection to
> queue up the soft IRQ bottom half processing.

correct, that may be too much of an indirection.

we cannot turn queue_work()'s spinlocks into raw spinlocks, because that
would necessiate waitqueue locks to be raw spinlocks too, which would be
generally bad. Check out how entangled the cwq->work_done and
cwq->more_work waitqueues are with cwq->lock.

also, i'm not sure about how correctly this maps to the upstream softirq
semantics. Right now softirqs are processed by a single context (per
CPU), and each softirq type is processed serially. Softirqs are
preemptable, but they dont preempt each other.  Maybe the networking
stack would break if we allowed the TIMER softirq (thread) to preempt
the NET softirq (threads) (and vice versa)?

but, prioritizing individual softirqs (within the PREEMPT_RT framework)
is something that needs to be thought about - e.g.  Mark H. Johnson
reported various PREEMPT_RT (and softirq threading) SMP artifacts that
seem to be related to the current 'all softirqs are processed by a
single thread' approach. (check Mark's postings for 'ping' latency
anomalies)

	Ingo
