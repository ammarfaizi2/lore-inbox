Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVIZFjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVIZFjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 01:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVIZFjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 01:39:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13198 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932388AbVIZFjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 01:39:08 -0400
Date: Sun, 25 Sep 2005 22:38:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ravi Dubey" <ravi.dubey@conexant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: schedule_work returns FAILURE (0)
Message-Id: <20050925223824.392183e6.akpm@osdl.org>
In-Reply-To: <4D6E93075B31154298572E6B73CA849D02339170@noida-mail.bbnet.ad>
References: <4D6E93075B31154298572E6B73CA849D02339170@noida-mail.bbnet.ad>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ravi Dubey" <ravi.dubey@conexant.com> wrote:
>
> Hi,
> 
> I have ported my USB driver on from Linux Kernel 2.4.20-8 to 2.6.11.12.
> As a part of this porting process, I have replaced the bottom halves
> with work_queues. Now, I am facing problems in the driver execution.
> :-(.
> 
> The schedule_work() function which schedules the work is returning
> FAILURE (0) many times (at least 1 out of 4 times it is called).
> 
> My queries:
> 
> 1. When a work is queued using schedule_work (), does the function (that
> is to be called as bottom half) run at process context OR Interrupt
> context

Process context.

> - The reason why I am getting confused is that in this called
> function, if I print the return value of in_interrupt (), I get 0 (which
> means that is running at process context),

Yup.

> However, if I print the value
> of in_interrupt after I have acquired a spin lock in this function, I
> get the value 256 (which means I am running in interrupt context) ?

Not really.  Bits 8-19 of preempt_count() count the IRQ depth and bits 0..7
count the inc_preempt_count() depth.  If CONFIG_PREEMPT is enabled,
spin_lock() does inc_preempt_count().  See the definitions of
hardirq_count(), softirq_count() and irq_count().

> 2. Why is the schedule_work () function failing.

umm, look at the implementation of schedule_work()?

	if (!test_and_set_bit(0, &work->pending)) {

it's already pending (the scheduled work has not run yet).  You need to
design you schedule_work() caller to queue things up and you need to design
your schedule_work() handler to consume all the thus-far-queued work items.

Just ignore the return value of schedule_work().
