Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVBNVYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVBNVYS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVBNVYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:24:18 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:19921 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261499AbVBNVYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:24:14 -0500
Subject: Re: queue_work from interrupt Real time
	preemption2.6.11-rc2-RT-V0.7.37-03
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Gross <mgross@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200502141240.14355.mgross@linux.intel.com>
References: <200502141240.14355.mgross@linux.intel.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 14 Feb 2005 16:24:09 -0500
Message-Id: <1108416249.8413.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 12:40 -0800, Mark Gross wrote:
> I'm working on a tweak to the preepmtive soft IRQ implementation using work 
> queues and I'm having problems with a BUG assert when trying to queue_work.
> 
> Souldn't I be able to call queue_work form ISR context?

Yes, but not with interrupts disabled.
> 
> --mgross 
> 
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<c0140f5d>] .... print_traces+0x1d/0x60
> .....[<c01042a3>] ..   ( <= dump_stack+0x23/0x30)
> 
> BUG: sleeping function called from invalid context IRQ 20(2039) at kernel/rt.c
> in_atomic():0 [00000000], irqs_disabled():1

Here you have interrupts disabled. Since you are tweaking the softirq I
don't know your code, but the kernel should not schedule after turning
off interrupts, and the spinlocks under the PREEMPT kernel, may now
sleep (unless they are raw_spin_locks).  Here we also see that
queue_work calls spin_lock_irqsave.  I'm suspecting that you turned off
interrupts somewhere.

-- Steve


