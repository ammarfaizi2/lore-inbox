Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWEBGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWEBGhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWEBGhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:37:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:28630 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932404AbWEBGhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:37:02 -0400
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer TSC check suspend notifier change
References: <1146367406.21486.9.camel@sli10-desk.sh.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 08:36:59 +0200
In-Reply-To: <1146367406.21486.9.camel@sli10-desk.sh.intel.com>
Message-ID: <p73irop6igk.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> writes:

> in suspend time, the TSC CPUFREQ_SUSPENDCHANGE notifier change might wrongly
> enable interrupt. cpufreq driver suspend/resume is in interrupt disabled environment.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
> 
>  linux-2.6.17-rc3-root/arch/i386/kernel/timers/timer_tsc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN arch/i386/kernel/timers/timer_tsc.c~timer_tsc_check_suspend_change arch/i386/kernel/timers/timer_tsc.c
> --- linux-2.6.17-rc3/arch/i386/kernel/timers/timer_tsc.c~timer_tsc_check_suspend_change	2006-04-29 08:25:38.000000000 +0800
> +++ linux-2.6.17-rc3-root/arch/i386/kernel/timers/timer_tsc.c	2006-04-29 08:29:33.000000000 +0800
> @@ -279,7 +279,7 @@ time_cpufreq_notifier(struct notifier_bl
>  {
>  	struct cpufreq_freqs *freq = data;
>  
> -	if (val != CPUFREQ_RESUMECHANGE)
> +	if (val != CPUFREQ_RESUMECHANGE && val != CPUFREQ_SUSPENDCHANGE)
>  		write_seqlock_irq(&xtime_lock);

Better would be to change it to write_seqlock_irqsave() (if that 
exists, if not add it) 


>  	if (!ref_freq) {
>  		if (!freq->old){
> @@ -312,7 +312,7 @@ time_cpufreq_notifier(struct notifier_bl
>  	}
>  
>  end:
> -	if (val != CPUFREQ_RESUMECHANGE)
> +	if (val != CPUFREQ_RESUMECHANGE && val != CPUFREQ_SUSPENDCHANGE)
>  		write_sequnlock_irq(&xtime_lock);

and _restore

-Andi
