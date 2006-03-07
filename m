Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWCGDqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWCGDqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWCGDqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:46:49 -0500
Received: from ns.suse.de ([195.135.220.2]:19100 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932649AbWCGDqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:46:48 -0500
To: GOTO Masanori <gotom@sanori.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] x86: Fix i386 nmi_watchdog that does not trigger die_nmi
References: <81irqrknnh.wl%gotom@sanori.org>
From: Andi Kleen <ak@suse.de>
Date: 07 Mar 2006 04:46:44 +0100
In-Reply-To: <81irqrknnh.wl%gotom@sanori.org>
Message-ID: <p73y7zmgbmj.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GOTO Masanori <gotom@sanori.org> writes:

> It fixes i386 nmi_watchdog that does not meet watchdog timeout
> condition.  It does not hit die_nmi when it should be triggered,
> because the current nmi_watchdog_tick in arch/i386/kernel/nmi.c never
> count up alert_counter like this:
> 
> 	void nmi_watchdog_tick (struct pt_regs * regs) {
> 	if (last_irq_sums[cpu] == sum) {
> 		alert_counter[cpu]++;		<- count up alert_counter, but
> 		if (alert_counter[cpu] == 5*nmi_hz)
> 			die_nmi(regs, "NMI Watchdog detected LOCKUP");
> 		alert_counter[cpu] = 0;		<- reset alert_counter
> 
> This patch changes it back to the previous and working version.
> Tested with 2.6.15.  It's also OK for 2.6.16-rc5.
> 
> This was found and originally written by Kohta NAKASHIMA.

Oops. Looks quite bad. Real 2.6.16 candidate I guess.

-Andi

> 
> -- gotom
> 
> Signed-Off-By: GOTO Masanori <gotom@sanori.org>
> ---
> 
> --- linux-2.6.15/arch/i386/kernel/nmi.c.gotom	2006-03-02 17:52:49.021365056 +0900
> +++ linux-2.6.15/arch/i386/kernel/nmi.c	2006-03-02 17:53:19.939664760 +0900
> @@ -544,7 +544,7 @@ void nmi_watchdog_tick (struct pt_regs *
>  			 * die_nmi will return ONLY if NOTIFY_STOP happens..
>  			 */
>  			die_nmi(regs, "NMI Watchdog detected LOCKUP");
> -
> +	} else {
>  		last_irq_sums[cpu] = sum;
>  		alert_counter[cpu] = 0;
>  	}
