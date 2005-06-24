Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263299AbVFXRN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbVFXRN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 13:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbVFXRNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 13:13:55 -0400
Received: from dvhart.com ([64.146.134.43]:17074 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S263299AbVFXRJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 13:09:31 -0400
Date: Fri, 24 Jun 2005 10:09:27 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <320710000.1119632967@flay>
In-Reply-To: <20050624170112.GD6393@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, still broken with the last 3 backed out, but works with the last 4 
>> backed out. So I guess it's scheduler-cache-hot-autodetect.patch that 
>> breaks it. Con just sent me something else to try to fix it in order 
>> to run next ... will do that.
> 
> hm. Does it work if you disable migration-autodetect via passing in e.g.  
> migration_cost=1000,2000,3000 on the boot line? Is it perhaps the 
> excessive debugging that hurts.
> 
> or does it work if you undo the chunk below? Seemed harmless, but has 
> CONFIG_NUMA relevance.
> 
> 	Ingo
> 
> --- linux/arch/i386/kernel/timers/timer_tsc.c.orig
> +++ linux/arch/i386/kernel/timers/timer_tsc.c
> @@ -133,18 +133,15 @@ static unsigned long long monotonic_cloc
>  
>  /*
>   * Scheduler clock - returns current time in nanosec units.
> + *
> + * it's not a problem if the TSC is unsynchronized,
> + * as the scheduler will carefully compensate for it.
>   */
>  unsigned long long sched_clock(void)
>  {
>  	unsigned long long this_offset;
>  
> -	/*
> -	 * In the NUMA case we dont use the TSC as they are not
> -	 * synchronized across all CPUs.
> -	 */
> -#ifndef CONFIG_NUMA
> -	if (!use_tsc)
> -#endif
> +	if (!cpu_has_tsc)
>  		/* no locking but a rare wrong value is not a big deal */
>  		return jiffies_64 * (1000000000 / HZ);

Humpf. That does look dangerous on a NUMA-Q. The TSCs aren't synced,
and we can't use them .... have to use PIT, whether the CPUs have TSC
or not.

M.
