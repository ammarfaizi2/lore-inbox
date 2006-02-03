Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWBCMG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBCMG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWBCMG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:06:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36007 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750721AbWBCMG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:06:56 -0500
Date: Fri, 3 Feb 2006 13:05:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch -mm4] sched: only print migration_cost once
Message-ID: <20060203120526.GC8665@elte.hu>
References: <200602030212_MC3-1-B773-7D06@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602030212_MC3-1-B773-7D06@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hm, why not use system_state for this?

	Ingo

* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> migration_cost prints after every CPU hotplug event.  Make it
> print only once at boot.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.16-rc1-mm4-386.orig/kernel/sched.c
> +++ 2.6.16-rc1-mm4-386/kernel/sched.c
> @@ -5656,6 +5656,7 @@ static void calibrate_migration_costs(co
>  	int cpu1 = -1, cpu2 = -1, cpu, orig_cpu = raw_smp_processor_id();
>  	unsigned long j0, j1, distance, max_distance = 0;
>  	struct sched_domain *sd;
> +	static int printed_cost = 0; /* has cost already been printed? */
>  
>  	j0 = jiffies;
>  
> @@ -5699,13 +5700,16 @@ static void calibrate_migration_costs(co
>  			-1
>  #endif
>  		);
> -	printk("migration_cost=");
> -	for (distance = 0; distance <= max_distance; distance++) {
> -		if (distance)
> -			printk(",");
> -		printk("%ld", (long)migration_cost[distance] / 1000);
> +	if (!printed_cost) {
> +		printed_cost++;
> +		printk("migration_cost=");
> +		for (distance = 0; distance <= max_distance; distance++) {
> +			if (distance)
> +				printk(",");
> +			printk("%ld", (long)migration_cost[distance] / 1000);
> +		}
> +		printk("\n");
>  	}
> -	printk("\n");
>  	j1 = jiffies;
>  	if (migration_debug)
>  		printk("migration: %ld seconds\n", (j1-j0)/HZ);
> -- 
> Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
