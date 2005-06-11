Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVFKQfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVFKQfj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVFKQfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:35:38 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:35167 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261727AbVFKQfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:35:22 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050608112801.GA31084@elte.hu>
References: <20050608112801.GA31084@elte.hu>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 18:35:20 +0200
Message-Id: <1118507720.12860.8.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I'm having some difficulty with your latest patches; more specifically
linux-2.6.12-rc6-git4-RT-V0.7.48-10 floods me with BUGs like these:

BUG: sleeping function called from invalid context ksoftirqd/1(7) at kernel/rt.c:1657
in_atomic():0 [20000000], irqs_disabled():536870912
 [<c01041c3>] dump_stack+0x23/0x30 (20)
 [<c011c981>] __might_sleep+0xe1/0x100 (36)
 [<c013dbe8>] __spin_lock+0x38/0x60 (24)
 [<c013dc2d>] _spin_lock+0x1d/0x20 (16)
 [<c02c627f>] rh_report_status+0x2f/0x110 (36)
 [<c012a754>] run_timer_softirq+0x1e4/0x3f0 (64)
 [<c0125c7f>] ___do_softirq+0x7f/0x140 (48)
 [<c0125df7>] _do_softirq+0x27/0x30 (8)
 [<c0126431>] ksoftirqd+0xb1/0x150 (28)
 [<c0137426>] kthread+0xb6/0xf0 (48)
 [<c0101149>] kernel_thread_helper+0x5/0xc (268648476)
---------------------------
| preempt count: 20000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0141bdb>] .... print_traces+0x1b/0x60
.....[<c01041c3>] ..   ( <= dump_stack+0x23/0x30)

I gather these are because of:

drivers/usb/code/hcd.c:rh_report_status

static void rh_report_status (unsigned long ptr)
{
	struct urb	*urb;
	struct usb_hcd	*hcd;
	int		length = 0;
	unsigned long	flags;

	urb = (struct urb *) ptr;
	local_irq_save (flags);
	spin_lock (&urb->lock);


	...
}

where local_irq_save() would disable pre-emption while spin_lock(); the
urb->lock is not a raw lock; can sleep.

I'm not well versed in that code; do you have a suggestion?

On another note; X seems to have trouble getting up. It consumes a full
CPU right after mode switching (afaict) without getting any progress.
I'll try and get a nice trace of X using sysrq-t.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>


