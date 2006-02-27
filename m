Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWB0IxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWB0IxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWB0IxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:53:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:48305 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751689AbWB0IxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:53:21 -0500
Date: Mon, 27 Feb 2006 09:52:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Patch 2/7] Add sysctl for schedstats
Message-ID: <20060227085203.GB3241@elte.hu>
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141027367.5785.42.camel@elinux04.optonline.net> <1141027923.5785.50.camel@elinux04.optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141027923.5785.50.camel@elinux04.optonline.net>
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


the principle looks OK to me, just a few minor nits:

>  #ifdef CONFIG_SCHEDSTATS
> +
> +int schedstats_sysctl = 0;		/* schedstats turned off by default */

no need to initialize to 0.

> +static DEFINE_PER_CPU(int, schedstats) = 0;

ditto.

> +
> +static void schedstats_set(int val)
> +{
> +	int i;
> +	static spinlock_t schedstats_lock = SPIN_LOCK_UNLOCKED;

move spinlock out of the function and use DEFINE_SPINLOCK. (But ... see 
below for suggestion to get rid of this lock altogether.)

> +	spin_lock(&schedstats_lock);
> +	schedstats_sysctl = val;
> +	for (i = 0; i < NR_CPUS; i++)
> +		per_cpu(schedstats, i) = val;
> +	spin_unlock(&schedstats_lock);
> +}
> +
> +static int __init schedstats_setup_enable(char *str)
> +{
> +	schedstats_sysctl = 1;
> +	schedstats_set(schedstats_sysctl);
> +	return 1;
> +}
> +
> +__setup("schedstats", schedstats_setup_enable);
> +
> +int schedstats_sysctl_handler(ctl_table *table, int write, struct file *filp,
> +			void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret, prev = schedstats_sysctl;
> +	struct task_struct *g, *t;
> +
> +	ret = proc_dointvec(table, write, filp, buffer, lenp, ppos);
> +	if ((ret != 0) || (prev == schedstats_sysctl))
> +		return ret;
> +	if (schedstats_sysctl) {
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g, t) {
> +			memset(&t->sched_info, 0, sizeof(t->sched_info));
> +		} while_each_thread(g, t);
> +		read_unlock(&tasklist_lock);
> +	}
> +	schedstats_set(schedstats_sysctl);

why not just introduce a schedstats_lock mutex, and acquire it for both 
the 'if (schedstats_sysctl)' line and the schedstats_set() line. That 
will make the locking meaningful: two parallel sysctl ops will be atomic 
to each other. [right now they wont be and they can clear schedstat data 
in parallel -> not a big problem but it makes schedstats_lock rather 
meaningless]

> -#define SCHEDSTAT_VERSION 12
> +#define SCHEDSTAT_VERSION 13
>  
>  static int show_schedstat(struct seq_file *seq, void *v)
>  {
> @@ -394,6 +439,10 @@ static int show_schedstat(struct seq_fil
>  
>  	seq_printf(seq, "version %d\n", SCHEDSTAT_VERSION);
>  	seq_printf(seq, "timestamp %lu\n", jiffies);
> +	if (!schedstats_sysctl) {
> +		seq_printf(seq, "State Off\n");
> +		return 0;
> +	}

and show_schedstat() should then also take the schedstats_lock mutex.

	Ingo
