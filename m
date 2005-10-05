Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVJENhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVJENhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 09:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVJENhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 09:37:11 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:38802 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965171AbVJENhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 09:37:10 -0400
Date: Wed, 5 Oct 2005 09:36:31 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051004084405.GA24296@elte.hu>
Message-ID: <Pine.LNX.4.58.0510050928440.23350@localhost.localdomain>
References: <20051004084405.GA24296@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I just notice that I get the following output:

BUG: gdm:4351 task might have lost a preemption check!
 [<c010433f>] dump_stack+0x1f/0x30 (20)
 [<c011c06f>] preempt_enable_no_resched+0x5f/0x70 (20)
 [<c011b6c9>] sys_sched_yield+0x69/0xb0 (24)
 [<c01033d6>] syscall_call+0x7/0xb (-8116)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (gdm/4351 [dbb727a0, 118]):
------------------------------


I looked at this a little and the offending code is here in
sys_sched_yield:

	/*
	 * Since we are going to call schedule() anyway, there's
	 * no need to preempt or enable interrupts:
	 */
	spin_unlock_no_resched(&rq->lock);

	__schedule();

So what's the reason for the message?  Is it to detect when a preemption
count goes to zero and isn't rescheduled?  At least in this part of the
kernel it's ok because it is just about to call schedule.  So is there
some way to flag this call to not produce the message?  Since the message
is only outputed once, it seems useless if it only gets outputted on a
false positive.

-- Steve


