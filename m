Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUEaHtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUEaHtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 03:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUEaHtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 03:49:11 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:62700 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264206AbUEaHtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 03:49:09 -0400
Date: Mon, 31 May 2004 03:50:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2 mismatched preempt count in arch/i386/kernel/irq.c
In-Reply-To: <15151.1085988908@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0405310347140.1794@montezuma.fsmlabs.com>
References: <15151.1085988908@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004, Keith Owens wrote:

> 2.6.7-rc2 (and earlier) arch/i386/kernel/irq.c::do_IRQ() calls
> irq_exit() which expands into preempt_enable_no_resched(), amongst
> others.  With CONFIG_PREEMPT=y, preempt_enable_no_resched() does
> dec_preempt_count().  Where is the corresponding inc_preempt_count?
> AFAICT the use of preempt_enable_no_resched() is unbalanced.

I believe IRQ_EXIT_OFFSET takes care of that;

#define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)

#define irq_exit()							\
do {									\
		preempt_count() -= IRQ_EXIT_OFFSET;			\
		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
			do_softirq();					\
		preempt_enable_no_resched();				\
} while (0)
