Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWBXG1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWBXG1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 01:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWBXG1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 01:27:06 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2981 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932685AbWBXG1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 01:27:03 -0500
Date: Fri, 24 Feb 2006 07:25:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] softlockup detection vs. cpu hotplug
Message-ID: <20060224062533.GA1431@elte.hu>
References: <20060224003146.GJ3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224003146.GJ3293@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Lynch <ntl@pobox.com> wrote:

> @@ -86,10 +92,15 @@ static int watchdog(void * __bind_cpu)
>  	 */
>  	while (!kthread_should_stop()) {
>  		msleep_interruptible(1000);
> -		touch_softlockup_watchdog();
> +		/* When our cpu is offlined the watchdog thread can
> +		 * get migrated before it is stopped.
> +		 */
> +		preempt_disable();
> +		if (likely(smp_processor_id() == bind_cpu))
> +			touch_softlockup_watchdog();
> +		preempt_enable();
> +		__set_current_state(TASK_RUNNING);
>  	}
> -	__set_current_state(TASK_RUNNING);
> -
>  	return 0;
>  }
>  

the above change is unnecessary: there is absolutely no harm from a 
migrated watchdog thread touching another CPU's timestamp for a short 
amount of time. [Furtermore, why doesnt the hotplug CPU code use the 
kthread_should_stop() mechanism to gracefully stop per-CPU threads, 
instead of migrating unsuspecting threads and putting ugly hooks into 
every such thread?]

the other fix (to touch before bringing the CPU up) looks OK, but it's 
simpler to initialize it via the oneliner below. Andrew, this is what 
i'd suggest to do for v2.6.16. [i'll send an updated softirq-rework 
patch in the next mail.]

	Ingo

------

fix from Nathan Lynch: initialize the softlockup timestamp of freshly 
brought up CPUs with jiffies.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- kernel/softlockup.c.orig
+++ kernel/softlockup.c
@@ -110,6 +110,7 @@ cpu_callback(struct notifier_block *nfb,
 			printk("watchdog for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
+  		per_cpu(timestamp, hotcpu) = jiffies;
   		per_cpu(watchdog_task, hotcpu) = p;
 		kthread_bind(p, hotcpu);
  		break;
