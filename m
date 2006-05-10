Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWEJJQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWEJJQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWEJJQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:16:54 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:57741 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S964851AbWEJJQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:16:53 -0400
Date: Wed, 10 May 2006 02:10:26 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: dzickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       oprofile-list@lists.sourceforge.net, perfmon@napali.hpl.hp.com
Subject: Re: [patch 8/8] Add abilty to enable/disable nmi watchdog from sysfs
Message-ID: <20060510091026.GD21833@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060509205035.446349000@drseuss.boston.redhat.com> <20060509205958.578466000@drseuss.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509205958.578466000@drseuss.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don,

Congratulations on the patch. I am glad to see that some of the SMP
issues I reported a long time ago are now fixed.

On Tue, May 09, 2006 at 04:50:43PM -0400, dzickus wrote:
> 
> Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
> watchdog.
> 

This means you can at runtime enable/disbale nmi_watchdog, i.e., reserve
some performance counters on the fly. This gets complicated because now
the perfmon subsystem (and probably oprofile) cannot check register
availability when they are first initialized. Basically each time,
the /sys entry is modified, they would have to scan the list of available
performance counters. I don't know exactly when Oprofile does this checking.
For perfmon, this is done only once, when the PMU description table is loaded.

Also something that I did not see in this code is the error detection in
case enable_lapic_nmi_watchdog() fails. Oprofile runs on all CPUs or none.
Perfmon lets you monitor on subsets on CPUs. In case NMI was disabled and
a monitoring session was active on some CPUs. The enable_lapic_nmi_watchdog()
will fail on some CPUs. How is that handled?

Thanks.

> Signed-off-by:  Don Zickus <dzickus@redhat.com>
> 
> Index: linux-don/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux-don.orig/arch/i386/kernel/nmi.c
> +++ linux-don/arch/i386/kernel/nmi.c
> @@ -845,6 +845,56 @@ static int unknown_nmi_panic_callback(st
>  	return 0;
>  }
>  
> +/*
> + * proc handler for /proc/sys/kernel/nmi
> + */
> +int proc_nmi_enabled(struct ctl_table *table, int write, struct file *file,
> +			void __user *buffer, size_t *length, loff_t *ppos)
> +{
> +	int old_state;
> +
> +	nmi_watchdog_enabled = (atomic_read(&nmi_active) > 0) ? 1 : 0;
> +	old_state = nmi_watchdog_enabled;
> +	proc_dointvec(table, write, file, buffer, length, ppos);
> +	if (!!old_state == !!nmi_watchdog_enabled)
> +		return 0;
> +
> +	if (atomic_read(&nmi_active) < 0) {
> +		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
> +		return 0;
> +	}
> +
> +	if (nmi_watchdog == NMI_DEFAULT) {
> +		if (nmi_known_cpu() > 0)
> +			nmi_watchdog = NMI_LOCAL_APIC;
> +		else
> +			nmi_watchdog = NMI_IO_APIC;
> +	}
> +
> +	if (nmi_watchdog == NMI_LOCAL_APIC)
> +	{
> +		if (nmi_watchdog_enabled)
> +			enable_lapic_nmi_watchdog();
> +		else
> +			disable_lapic_nmi_watchdog();
> +	} else if (nmi_watchdog == NMI_IO_APIC) {
> +		/* FIXME
> +		 * for some reason these functions don't work
> +		 */
> +		printk("Can not enable/disable NMI on IO APIC\n");
> +		return 0;
> +		/*if (nmi_watchdog_enabled)
> +			enable_timer_nmi_watchdog();
> +		else
> +			disable_timer_nmi_watchdog();
> +		*/
> +	} else {
> +		printk( KERN_WARNING
> +			"NMI watchdog doesn't know what hardware to touch\n");
> +	}
> +	return 0;
> +}
> +
>  #endif
>  
>  EXPORT_SYMBOL(nmi_active);
> Index: linux-don/arch/x86_64/kernel/nmi.c
> ===================================================================
> --- linux-don.orig/arch/x86_64/kernel/nmi.c
> +++ linux-don/arch/x86_64/kernel/nmi.c
> @@ -751,6 +751,52 @@ static int unknown_nmi_panic_callback(st
>  	return 0;
>  }
>  
> +/*
> + * proc handler for /proc/sys/kernel/nmi
> + */
> +int proc_nmi_enabled(struct ctl_table *table, int write, struct file *file,
> +			void __user *buffer, size_t *length, loff_t *ppos)
> +{
> +	int old_state;
> +
> +	nmi_watchdog_enabled = (atomic_read(&nmi_active) > 0) ? 1 : 0;
> +	old_state = nmi_watchdog_enabled;
> +	proc_dointvec(table, write, file, buffer, length, ppos);
> +	if (!!old_state == !!nmi_watchdog_enabled)
> +		return 0;
> +
> +	if (atomic_read(&nmi_active) < 0) {
> +		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
> +		return 0;
> +	}
> +
> +	/* if nmi_watchdog is not set yet, then set it */
> +	nmi_watchdog_default();
> +
> +	if (nmi_watchdog == NMI_LOCAL_APIC)
> +	{
> +		if (nmi_watchdog_enabled)
> +			enable_lapic_nmi_watchdog();
> +		else
> +			disable_lapic_nmi_watchdog();
> +	} else if (nmi_watchdog == NMI_IO_APIC) {
> +		/* FIXME
> +		 * for some reason these functions don't work
> +		 */
> +		printk("Can not enable/disable NMI on IO APIC\n");
> +		return 0;
> +		/*if (nmi_watchdog_enabled)
> +			enable_timer_nmi_watchdog();
> +		else
> +			disable_timer_nmi_watchdog();
> +		*/
> +	} else {
> +		printk( KERN_WARNING
> +			"NMI watchdog doesn't know what hardware to touch\n");
> +	}
> +	return 0;
> +}
> +
>  #endif
>  
>  EXPORT_SYMBOL(nmi_active);
> Index: linux-don/include/asm-i386/nmi.h
> ===================================================================
> --- linux-don.orig/include/asm-i386/nmi.h
> +++ linux-don/include/asm-i386/nmi.h
> @@ -14,6 +14,7 @@
>   */
>  int do_nmi_callback(struct pt_regs *regs, int cpu);
>  
> +extern int nmi_watchdog_enabled;
>  extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
>  extern int avail_to_resrv_perfctr_nmi(unsigned int);
>  extern int reserve_perfctr_nmi(unsigned int);
> Index: linux-don/include/asm-x86_64/nmi.h
> ===================================================================
> --- linux-don.orig/include/asm-x86_64/nmi.h
> +++ linux-don/include/asm-x86_64/nmi.h
> @@ -43,6 +43,7 @@ extern void die_nmi(char *str, struct pt
>  
>  extern int panic_on_timeout;
>  extern int unknown_nmi_panic;
> +extern int nmi_watchdog_enabled;
>  
>  extern int check_nmi_watchdog(void);
>  extern int avail_to_resrv_perfctr_nmi_bit(unsigned int);
> Index: linux-don/include/linux/sysctl.h
> ===================================================================
> --- linux-don.orig/include/linux/sysctl.h
> +++ linux-don/include/linux/sysctl.h
> @@ -148,6 +148,7 @@ enum
>  	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
>  	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
>  	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
> +	KERN_NMI_ENABLED=73, /* int: enable/disable nmi watchdog */
>  };
>  
>  
> Index: linux-don/kernel/sysctl.c
> ===================================================================
> --- linux-don.orig/kernel/sysctl.c
> +++ linux-don/kernel/sysctl.c
> @@ -75,6 +75,9 @@ extern int percpu_pagelist_fraction;
>  
>  #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
>  int unknown_nmi_panic;
> +int nmi_watchdog_enabled;
> +extern int proc_nmi_enabled(struct ctl_table *, int , struct file *,
> +			void __user *, size_t *, loff_t *);
>  #endif
>  
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
> @@ -630,6 +633,14 @@ static ctl_table kern_table[] = {
>  		.mode           = 0644,
>  		.proc_handler   = &proc_dointvec,
>  	},
> +	{
> +		.ctl_name       = KERN_NMI_ENABLED,
> +		.procname       = "nmi",
> +		.data           = &nmi_watchdog_enabled,
> +		.maxlen         = sizeof (int),
> +		.mode           = 0644,
> +		.proc_handler   = &proc_nmi_enabled,
> +	},
>  #endif
>  #if defined(CONFIG_X86)
>  	{
> 
> --
> 
> 
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list

-- 

-Stephane
