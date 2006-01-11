Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWAKSMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWAKSMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAKSMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:12:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:29851 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932420AbWAKSMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:12:31 -0500
Date: Wed, 11 Jan 2006 10:12:43 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Extend RCU torture module to test tickless idle CPU
Message-ID: <20060111181243.GA22157@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051205110527.GF2385@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205110527.GF2385@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:35:27PM +0530, Srivatsa Vaddagiri wrote:
> This patch forces RCU torture threads off various CPUs in the system
> allowing them to become idle and go tickless.  Meant to test support for 
> such tickless idle CPU in RCU.

Good addition, works on 2.6.15 on x86 and ppc64.

							Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>
> 
> ---
> 
>  linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c |   89 +++++++++++++++++++++++++-
>  1 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff -puN kernel/rcutorture.c~rcutorture kernel/rcutorture.c
> --- linux-2.6.15-rc5-mm1/kernel/rcutorture.c~rcutorture	2005-12-05 15:33:34.000000000 +0530
> +++ linux-2.6.15-rc5-mm1-root/kernel/rcutorture.c	2005-12-05 15:33:42.000000000 +0530
> @@ -51,6 +51,8 @@ static int nreaders = -1;	/* # reader th
>  static int stat_interval = 0;	/* Interval between stats, in seconds. */
>  				/*  Defaults to "only at end of test". */
>  static int verbose = 0;		/* Print more debug info. */
> +static int test_no_idle_hz = 0; /* Test RCU's support for tickless idle CPUs. */
> +static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
>  
>  MODULE_PARM(nreaders, "i");
>  MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
> @@ -58,6 +60,10 @@ MODULE_PARM(stat_interval, "i");
>  MODULE_PARM_DESC(stat_interval, "Number of seconds between stats printk()s");
>  MODULE_PARM(verbose, "i");
>  MODULE_PARM_DESC(verbose, "Enable verbose debugging printk()s");
> +MODULE_PARM(test_no_idle_hz, "i");
> +MODULE_PARM_DESC(test_no_idle_hz, "Test support for tickless idle CPUs");
> +MODULE_PARM(shuffle_interval, "i");
> +MODULE_PARM_DESC(shuffle_interval, "Number of seconds between shuffles");
>  #define TORTURE_FLAG "rcutorture: "
>  #define PRINTK_STRING(s) \
>  	do { printk(KERN_ALERT TORTURE_FLAG s "\n"); } while (0)
> @@ -72,6 +78,7 @@ static int nrealreaders;
>  static struct task_struct *writer_task;
>  static struct task_struct **reader_tasks;
>  static struct task_struct *stats_task;
> +static struct task_struct *shuffler_task;
>  
>  #define RCU_TORTURE_PIPE_LEN 10
>  
> @@ -375,12 +382,77 @@ rcu_torture_stats(void *arg)
>  	return 0;
>  }
>  
> +int rcu_idle_cpu;	/* Force all torture tasks off this CPU */
> +
> +/* Shuffle tasks such that we allow @rcu_idle_cpu to become idle. A special case
> + * is when @rcu_idle_cpu = -1, when we allow the tasks to run on all CPUs.
> + */
> +void rcu_torture_shuffle_tasks(void)
> +{
> +	cpumask_t tmp_mask = CPU_MASK_ALL;
> +	int i;
> +
> +	lock_cpu_hotplug();
> +
> +	/* No point in shuffling if there is only one online CPU (ex: UP) */
> +	if (num_online_cpus() == 1) {
> +		unlock_cpu_hotplug();
> +		return;
> +	}
> +
> +	if (rcu_idle_cpu != -1)
> +		cpu_clear(rcu_idle_cpu, tmp_mask);
> +
> +	set_cpus_allowed(current, tmp_mask);
> +
> +	if (reader_tasks != NULL) {
> +		for (i = 0; i < nrealreaders; i++)
> +			if (reader_tasks[i])
> +				set_cpus_allowed(reader_tasks[i], tmp_mask);
> +	}
> +
> +	if (writer_task)
> +		set_cpus_allowed(writer_task, tmp_mask);
> +
> +	if (stats_task)
> +		set_cpus_allowed(stats_task, tmp_mask);
> +
> +	if (rcu_idle_cpu == -1)
> +		rcu_idle_cpu = num_online_cpus() - 1;
> +	else
> +		rcu_idle_cpu--;
> +
> +	unlock_cpu_hotplug();
> +}
> +
> +/* Shuffle tasks across CPUs, with the intent of allowing each CPU in the
> + * system to become idle at a time and cut off its timer ticks. This is meant
> + * to test the support for such tickless idle CPU in RCU.
> + */
> +static int
> +rcu_torture_shuffle(void *arg)
> +{
> +	VERBOSE_PRINTK_STRING("rcu_torture_shuffle task started");
> +	do {
> +		schedule_timeout_interruptible(shuffle_interval * HZ);
> +		rcu_torture_shuffle_tasks();
> +	} while (!kthread_should_stop());
> +	VERBOSE_PRINTK_STRING("rcu_torture_shuffle task stopping");
> +	return 0;
> +}
> +
>  static void
>  rcu_torture_cleanup(void)
>  {
>  	int i;
>  
>  	fullstop = 1;
> +	if (shuffler_task != NULL) {
> +		VERBOSE_PRINTK_STRING("Stopping rcu_torture_shuffle task");
> +		kthread_stop(shuffler_task);
> +	}
> +	shuffler_task = NULL;
> +
>  	if (writer_task != NULL) {
>  		VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
>  		kthread_stop(writer_task);
> @@ -430,8 +502,9 @@ rcu_torture_init(void)
>  	else
>  		nrealreaders = 2 * num_online_cpus();
>  	printk(KERN_ALERT TORTURE_FLAG
> -	       "--- Start of test: nreaders=%d stat_interval=%d verbose=%d\n",
> -	       nrealreaders, stat_interval, verbose);
> +	       "--- Start of test: nreaders=%d stat_interval=%d verbose=%d test_no_idle_hz=%d shuffle_interval = %d\n",
> +	       nrealreaders, stat_interval, verbose, test_no_idle_hz,
> +	       shuffle_interval);
>  	fullstop = 0;
>  
>  	/* Set up the freelist. */
> @@ -501,6 +574,18 @@ rcu_torture_init(void)
>  			goto unwind;
>  		}
>  	}
> +	if (test_no_idle_hz) {
> +		rcu_idle_cpu = num_online_cpus() - 1;
> +		/* Create the shuffler thread */
> +		shuffler_task = kthread_run(rcu_torture_shuffle, NULL,
> +					  "rcu_torture_shuffle");
> +		if (IS_ERR(shuffler_task)) {
> +			firsterr = PTR_ERR(shuffler_task);
> +			VERBOSE_PRINTK_ERRSTRING("Failed to create shuffler");
> +			shuffler_task = NULL;
> +			goto unwind;
> +		}
> +	}
>  	return 0;
>  
>  unwind:
> 
> _
> -- 
> 
> 
> Thanks and Regards,
> Srivatsa Vaddagiri,
> Linux Technology Center,
> IBM Software Labs,
> Bangalore, INDIA - 560017
> 
