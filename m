Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWFYPPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWFYPPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWFYPPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 11:15:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11483 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751079AbWFYPPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 11:15:20 -0400
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
       danial_thom@yahoo.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060625142440.GD8223@atjola.homenet>
References: <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
	 <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
	 <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
	 <1151211993.8519.6.camel@Homer.TheSimpsons.net>
	 <20060625111238.GB8223@atjola.homenet>
	 <20060625142440.GD8223@atjola.homenet>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Jun 2006 17:15:18 +0200
Message-Id: <1151248518.4940.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 16:24 +0200, Björn Steinbrink wrote:
> Copy the softirq bits in preempt_count from the current context into the
> hardirq context when using 4K stacks to make the softirq_count macro work
> correctly and thereby fix softirq cpu time accounting.
> 
> Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
> 
> diff -Nurp a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
> --- a/arch/i386/kernel/irq.c	2006-03-20 06:53:29.000000000 +0100
> +++ b/arch/i386/kernel/irq.c	2006-06-25 15:49:52.000000000 +0200
> @@ -95,6 +95,14 @@ fastcall unsigned int do_IRQ(struct pt_r
>  		irqctx->tinfo.task = curctx->tinfo.task;
>  		irqctx->tinfo.previous_esp = current_stack_pointer;
>  
> +		/*
> +		 * Copy the softirq bits in preempt_count so that the
> +		 * softirq checks work in the hardirq context.
> +		 */
> +		irqctx->tinfo.preempt_count =
> +			irqctx->tinfo.preempt_count & ~SOFTIRQ_MASK |
> +			curctx->tinfo.preempt_count & SOFTIRQ_MASK;
> +
>  		asm volatile(
>  			"       xchgl   %%ebx,%%esp      \n"
>  			"       call    __do_IRQ         \n"

Hi,

at first I got nervous about the asymmetry of this (eg why only do this
copying only on entry, and not a copy back on exit)... but then again
these bits shouldn't change so your patch is ok as is...
it's regrettable that we need to add this for the softirq accounting;
part of me wishes we would just count irq-vs-user time and be done with
it ;)


Acked-by: Arjan van de Ven <arjan@linux.intel.com>

