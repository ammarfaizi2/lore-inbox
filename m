Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCKOEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbUCKOEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:04:33 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:56237 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261326AbUCKOE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:04:26 -0500
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
From: "Yury V. Umanets" <umka@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Brad Laue <brad@brad-x.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040311020832.1aa25177.akpm@osdl.org>
References: <404F85A6.6070505@brad-x.com>
	 <20040310155712.7472e31c.akpm@osdl.org> <4050271C.3070103@brad-x.com>
	 <40503120.9000008@brad-x.com>  <20040311020832.1aa25177.akpm@osdl.org>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1079013947.24999.17.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 11 Mar 2004 16:05:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-11 at 12:08, Andrew Morton wrote:
> Brad Laue <brad@brad-x.com> wrote:
> >
> >  Brad Laue wrote:
> >  > Hopefully the attached shows some irregularity. If not, I'll have to 
> >  > reply back in a few weeks when the problem recurs over the course of time.
> > 
> >  And without further ado, the attachment. It's been a long day. :)
> 
> It beats me.  Something must be waking up ksoftirqd all the time.

Hello,

I have impression, that it is somehow related to ACPI and CPU
temperature. When CPU gets more hot ksoftirqd starts to eat 99% of CPU.

It may be checked by disabling ACPI (if enabled) and/or monitoring
/proc/acpi/thermal_zone/THRM/temperature (if any).

> 
> If you have time, could you please apply the below, then wait for ksoftirqd
> to go bad again and then run:
> 
> 
> 	dmesg -c
> 	echo 1 > /proc/sys/debug/0 ; sleep 1; echo 0 > /proc/sys/debug/0
> 	dmesg -s 1000000 > /tmp/foo
> 
> and then send foo?
> 
> 
> diff -puN include/linux/kernel.h~proc-sys-debug include/linux/kernel.h
> --- 25/include/linux/kernel.h~proc-sys-debug	2004-02-25 23:12:56.000000000 -0800
> +++ 25-akpm/include/linux/kernel.h	2004-02-25 23:12:57.000000000 -0800
> @@ -214,6 +214,8 @@ extern void dump_stack(void);
>  	1; \
>  })
>  
> +extern int proc_sys_debug[8];
> +
>  #endif /* __KERNEL__ */
>  
>  #define SI_LOAD_SHIFT	16
> diff -puN -L kernel/ksyms.c /dev/null /dev/null
> diff -puN kernel/sysctl.c~proc-sys-debug kernel/sysctl.c
> --- 25/kernel/sysctl.c~proc-sys-debug	2004-02-25 23:12:56.000000000 -0800
> +++ 25-akpm/kernel/sysctl.c	2004-02-25 23:21:37.000000000 -0800
> @@ -849,7 +849,26 @@ static ctl_table fs_table[] = {
>  	{ .ctl_name = 0 }
>  };
>  
> +int proc_sys_debug[8];
> +EXPORT_SYMBOL(proc_sys_debug);
> +
>  static ctl_table debug_table[] = {
> +	{1, "0", &proc_sys_debug[0], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{2, "1", &proc_sys_debug[1], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{3, "2", &proc_sys_debug[2], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{4, "3", &proc_sys_debug[3], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{5, "4", &proc_sys_debug[4], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{6, "5", &proc_sys_debug[5], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{7, "6", &proc_sys_debug[6], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
> +	{8, "7", &proc_sys_debug[7], sizeof(int), 0644, NULL,
> +	 &proc_dointvec_minmax, &sysctl_intvec, NULL, NULL, NULL},
>  	{ .ctl_name = 0 }
>  };
>  
> 
> _
>  kernel/softirq.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff -puN kernel/softirq.c~a kernel/softirq.c
> --- 25/kernel/softirq.c~a	2004-03-11 02:05:20.000000000 -0800
> +++ 25-akpm/kernel/softirq.c	2004-03-11 02:06:02.000000000 -0800
> @@ -54,8 +54,13 @@ static inline void wakeup_softirqd(void)
>  	/* Interrupts are disabled: no need to stop preemption */
>  	struct task_struct *tsk = __get_cpu_var(ksoftirqd);
>  
> -	if (tsk && tsk->state != TASK_RUNNING)
> +	if (tsk && tsk->state != TASK_RUNNING) {
> +		if (proc_sys_debug[0]) {
> +			printk("%s wakes ksoftirqd\n", current->comm);
> +			dump_stack();
> +		}
>  		wake_up_process(tsk);
> +	}
>  }
>  
>  /*
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
umka

