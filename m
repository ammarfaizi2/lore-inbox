Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTEaS0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264469AbTEaS0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:26:31 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:14208
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264454AbTEaS03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:26:29 -0400
Date: Sat, 31 May 2003 14:29:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Pasi Savolainen <psavo@iki.fi>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] amd76x_pm port to 2.5.70
In-Reply-To: <20030531183321.GA3408@varg.dyndns.org>
Message-ID: <Pine.LNX.4.50.0305311422250.32537-100000@montezuma.mastecende.com>
References: <20030531183321.GA3408@varg.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Pasi Savolainen wrote:

> Attached is a simplistic port of amd76x_pm to 2.5.70.
> There is a mention about being non-preempt safe, and I can't tell
> spinlock from semaphore, so can do nada about it.
> zwane told me on #kernelnewbies that 
> 
>   pm_idle = old_pm_idle; wmb();
> 
> should take care about the processor syncing, but I do get total hangs
> on rmmod.

pm_idle = NULL_or_previous_handler;
synchronize_kernel();
unload_module;

> +amd76x_up_idle(void)
> +{
> +	// FIXME: Optionally add non-smp idle loop here
> +}
> +#endif

This is going to really suck power wise, at least do a rep_nop or some 
such otherwise you spin in a tight polling loop around need_resched.

> +static void
> +amd76x_smp_idle(void)
> +{
> +	/*
> +	 * Exit idle mode immediately if the CPU does not change.
> +	 * Usually that means that we have some load on another CPU.
> +	 */
> +
> +	if (prs[0].idle && prs[1].idle && amd76x_pm_cfg.last_pr == smp_processor_id()) {
> +		prs[0].idle = 0;
> +		prs[1].idle = 0;
> +		/* This looks redundent as it was just checked in the if() */
> +		/* amd76x_pm_cfg.last_pr = smp_processor_id(); */

One is a comparison the other an assignment, what's going on here?

> +static void __exit
> +amd76x_pm_cleanup(void)
> +{
> +#ifndef AMD76X_NTH
> +	pm_idle = amd76x_pm_cfg.orig_idle;
> +	wmb();
> +	//__asm__ __volatile__ ("wbinvd;"); // propagate through SMP

synchronize_kernel() here, then you should be safe to unload.

-- 
function.linuxpower.ca
