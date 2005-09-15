Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbVIORJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbVIORJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVIORJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:09:00 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:13249 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030527AbVIORJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:09:00 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Nix <nix@esperi.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Hua Zhong <hzhong@gmail.com>,
       marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Thu, 15 Sep 2005 10:08:41 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Automatic Configuration of a Kernel
In-Reply-To: <87zmqextr5.fsf@amaterasu.srvr.nix>
Message-ID: <Pine.LNX.4.62.0509151005170.9832@qynat.qvtvafvgr.pbz>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com><6bffcb0e05091415533d563c5a@mail.gmail.com><4328B710.5080503@in.tum.de><200509151009.59981.marekw1977@yahoo.com.au><924c288305091417375fea4ec2@mail.gmail.com><Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz><1126753444.13893.123.camel@mindpipe><Pine.LNX.4.62.0509150313500.9384@qynat.qvtvafvgr.pbz>
 <87zmqextr5.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005, Nix wrote:

> On 15 Sep 2005, David Lang yowled:
>> 5. once kmem and mem can be made read-only there is a security
>> advantage in not having kernel modules available (yes the machine can
>> be rebooted into a new kernel, but that's easier to detect then a
>> module getting loaded)
>
> Here, have a small patch (against 2.6.12.x, but easily forward-portable)
> that eliminates that advantage:

it's still easier to say 'don't use modules' then it is to make sure you 
wait until the right time to seal the modules (remember that the current 
hotplug is asyncronous so you don't have any good way to know that it's 
finished detecting everything and loading all the modules it will need to)

David Lang

> diff -durN linux-2.6.12.1-seal-orig/include/linux/kernel.h linux-2.6.12.1-seal/include/linux/kernel.h
> --- linux-2.6.12.1-seal-orig/include/linux/kernel.h	2005-06-27 19:28:54.000000000 +0100
> +++ linux-2.6.12.1-seal/include/linux/kernel.h	2005-06-27 22:21:48.000000000 +0100
> @@ -165,6 +165,9 @@
> extern int tainted;
> extern const char *print_tainted(void);
> extern void add_taint(unsigned);
> +#ifdef CONFIG_MODULE_SEAL
> +extern int module_seal;
> +#endif
>
> /* Values used for system_state */
> extern enum system_states {
> diff -durN linux-2.6.12.1-seal-orig/include/linux/sysctl.h linux-2.6.12.1-seal/include/linux/sysctl.h
> --- linux-2.6.12.1-seal-orig/include/linux/sysctl.h	2005-06-27 19:28:57.000000000 +0100
> +++ linux-2.6.12.1-seal/include/linux/sysctl.h	2005-06-27 22:26:12.000000000 +0100
> @@ -136,6 +136,7 @@
> 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
> 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
> 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
> +	KERN_MODULE_SEAL=69,	/* int: module loading forbidden */
> };
>
>
> @@ -801,6 +802,8 @@
> 			 void __user *, size_t *, loff_t *);
> extern int proc_dointvec_bset(ctl_table *, int, struct file *,
> 			      void __user *, size_t *, loff_t *);
> +extern int proc_dointvec_seal(ctl_table *table, int write, struct file *filp,
> +			      void __user *buffer, size_t *lenp, loff_t *ppos);
> extern int proc_dointvec_minmax(ctl_table *, int, struct file *,
> 				void __user *, size_t *, loff_t *);
> extern int proc_dointvec_jiffies(ctl_table *, int, struct file *,
> diff -durN linux-2.6.12.1-seal-orig/init/Kconfig linux-2.6.12.1-seal/init/Kconfig
> --- linux-2.6.12.1-seal-orig/init/Kconfig	2005-06-27 19:28:59.000000000 +0100
> +++ linux-2.6.12.1-seal/init/Kconfig	2005-06-27 22:21:49.000000000 +0100
> @@ -463,6 +463,16 @@
> 	  the version).  With this option, such a "srcversion" field
> 	  will be created for all modules.  If unsure, say N.
>
> +config MODULE_SEAL
> +	bool "Module sealing support"
> +	depends on MODULES && PROC_FS
> +	help
> +	  This option provides a file /proc/sys/kernel/module_seal,
> +	  initially containing the value 0. If it is set to a non-zero
> +	  value, all module loading and unloading will be prohibited
> +	  until the next reboot: further changes to the flag will be
> +	  ignored.
> +
> config KMOD
> 	bool "Automatic kernel module loading"
> 	depends on MODULES
> diff -durN linux-2.6.12.1-seal-orig/kernel/module.c linux-2.6.12.1-seal/kernel/module.c
> --- linux-2.6.12.1-seal-orig/kernel/module.c	2005-06-27 19:28:59.000000000 +0100
> +++ linux-2.6.12.1-seal/kernel/module.c	2005-06-27 22:21:49.000000000 +0100
> @@ -49,6 +49,10 @@
> #define ARCH_SHF_SMALL 0
> #endif
>
> +#ifdef CONFIG_MODULE_SEAL
> +int module_seal = 0;
> +#endif
> +
> /* If this is set, the section belongs in the init part of the module */
> #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
>
> @@ -1765,6 +1769,12 @@
> 	if (!capable(CAP_SYS_MODULE))
> 		return -EPERM;
>
> +#ifdef CONFIG_MODULE_SEAL
> +	/* Must not be sealed */
> +	if (module_seal)
> +		return -EPERM;
> +#endif
> +
> 	/* Only one module load at a time, please */
> 	if (down_interruptible(&module_mutex) != 0)
> 		return -EINTR;
> diff -durN linux-2.6.12.1-seal-orig/kernel/sysctl.c linux-2.6.12.1-seal/kernel/sysctl.c
> --- linux-2.6.12.1-seal-orig/kernel/sysctl.c	2005-06-27 19:29:00.000000000 +0100
> +++ linux-2.6.12.1-seal/kernel/sysctl.c	2005-06-27 22:21:49.000000000 +0100
> @@ -589,6 +589,16 @@
> 		.mode		= 0644,
> 		.proc_handler	= &proc_dointvec,
> 	},
> +#ifdef CONFIG_MODULE_SEAL
> +        {
> +		.ctl_name	= KERN_MODULE_SEAL,
> +		.procname	= "module_seal",
> +		.data		= &module_seal,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0600,
> +		.proc_handler	= &proc_dointvec_seal,
> +	},
> +#endif
> 	{
> 		.ctl_name	= KERN_PRINTK_RATELIMIT,
> 		.procname	= "printk_ratelimit",
> @@ -1663,6 +1673,22 @@
> 				do_proc_dointvec_bset_conv,&op);
> }
>
> +#ifdef CONFIG_MODULE_SEAL
> +/*
> + *	You can't change the seal unless it's zero.
> + */
> +
> +int proc_dointvec_seal(ctl_table *table, int write, struct file *filp,
> +		       void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	if (module_seal != 0) {
> +		return -EPERM;
> +	}
> +
> +	return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,NULL,NULL);
> +}
> +#endif
> +
> struct do_proc_dointvec_minmax_conv_param {
> 	int *min;
> 	int *max;
>
>
> -- 
> `One cannot, after all, be expected to read every single word
> of a book whose author one wishes to insult.' --- Richard Dawkins
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
