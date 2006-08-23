Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWHWWuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWHWWuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbWHWWuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:50:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965283AbWHWWuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:50:39 -0400
Date: Wed, 23 Aug 2006 15:40:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 7/18] 2.6.17.9 perfmon2 patch for review: PMU
 interruption support
Message-Id: <20060823154057.4d6d444b.akpm@osdl.org>
In-Reply-To: <200608230805.k7N85wQc000420@frankl.hpl.hp.com>
References: <200608230805.k7N85wQc000420@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:05:58 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> ...
>
> +irqreturn_t pfm_interrupt_handler(int irq, void *arg, struct pt_regs *regs)
> +{
> +	u64 start_cycles, total_cycles;
> +
> +	get_cpu();
> +
> +	start_cycles = pfm_arch_get_itc();
> +
> +	__pfm_interrupt_handler(regs);
> +
> +	total_cycles = pfm_arch_get_itc();
> +
> +	__get_cpu_var(pfm_stats).pfm_ovfl_intr_cycles += total_cycles - start_cycles;
> +
> +	put_cpu_no_resched();
> +	return IRQ_HANDLED;
> +}

If this code is only ever called from interrupt context then I suspect the
get_cpu() is not needed.  __get_cpu_var() requires that preemption be
disabled (so we cannot wander over to a different CPU midway) but IRQ
code doesn't get preempted.

