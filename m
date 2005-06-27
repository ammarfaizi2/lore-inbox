Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVF0HG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVF0HG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVF0HD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:03:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261887AbVF0HCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:02:06 -0400
Date: Mon, 27 Jun 2005 00:01:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Levent Serinol <lserinol@gmail.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com, wli@holomorphy.com
Subject: Re: [PATCH] enable/disable profiling via proc/sysctl
Message-Id: <20050627000125.1a6f8a91.akpm@osdl.org>
In-Reply-To: <2c1942a705062623411b7e88c3@mail.gmail.com>
References: <2c1942a705062623411b7e88c3@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Levent Serinol <lserinol@gmail.com> wrote:
>
> This patch enables controlling kernel profiling through proc/sysctl inferface.
> 
>  With this patch profiling will be available without rebooting the
>  machine (especially for
>  production servers) with some drawbacks of vmalloc(tlb). So, bootime
>  algorithm part is left unchanged for anyone who wishes to use
>  profiling as usual without tlb drawback by rebooting the machine.


> --- include/linux/sysctl.h.org	2005-06-13 16:05:17.000000000 +0300
> +++ include/linux/sysctl.h	2005-06-25 15:05:06.000000000 +0300

Patches should be in `patch -p1' form, please.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

> +static int prof_on = 0;
> +static int prof_booton = 0;

There's no need to explicitly initialise these.

> +#ifdef CONFIG_SMP
> +static int remove_hash_tables(void)
> +{
> +	int cpu;
> +
> +	smp_mb();
> +	on_each_cpu(profile_nop, NULL, 0, 1);

Why?

> +	for_each_online_cpu(cpu) {
> +		struct page *page;
> +
> +		if (per_cpu(cpu_profile_hits, cpu)[0]) {
> +			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[0]);
> +			per_cpu(cpu_profile_hits, cpu)[0] = NULL;
> +			__free_page(page);
> +		}
> +		if (per_cpu(cpu_profile_hits, cpu)[1]) {
> +			page = virt_to_page(per_cpu(cpu_profile_hits, cpu)[1]);
> +			per_cpu(cpu_profile_hits, cpu)[1] = NULL;
> +			__free_page(page);
> +		}
> +	}

Can this race against itself?  If two cpus run the sysctl at the same time?
We seem to have lock_kernel() coverage.  It's be nice to do something
firmer.

> +int profile_sysctl_handler(ctl_table *table, int write,
> +	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
> +{
> +	int err;
> +	struct proc_dir_entry *entry;
> +
> +	if (prof_booton && write) return 0;
> +	err=proc_dointvec(table, write, file, buffer, length, ppos);
> +	if ((err >= 0) && write) {
> +	prof_shift = profile_params[1];
> +	switch(profile_params[0])
> +	{
> +	case 0:
> +		if (prof_on) {

Coding style is all over the place here, as well as in most of the rest of
the patch.


	if (prof_booton && write)
		return 0;
	err = proc_dointvec(table, write, file, buffer, length, ppos);
	if (err >= 0 && write) {
		prof_shift = profile_params[1];
		switch (profile_params[0])
		{
		case 0:
			if (prof_on) {

Every line was changed there...

Also, doing multiple returns per function is unpopular, although the
very-early

	if (foo)
		return <something>;

right at the top of the function is OK.  You can use

	if (err < 0 || !write)
		goto out;

to save a tab stop.

> +		     } 
> +		break;

		} 
		break;

> +	case SCHED_PROFILING || CPU_PROFILING:

eh?  I'm surprised the compiler swallowed that.  I guess it's the same as
`case 1:'.  Looks like a bug though.

> +		if (prof_on) return -1;
> +        	prof_len = (_etext - _stext) >> prof_shift;
> +        	prof_buffer = vmalloc(prof_len*sizeof(atomic_t));
> +		if (!prof_buffer) return(-ENOMEM);
> +		if (create_hash_tables()) {
> +			vfree(prof_buffer);
> +			return -1;
> +			}
> +		prof_on = profile_params[0];
> +		if (!(entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL))) {
> +			remove_hash_tables();
> +			vfree(prof_buffer);
> +			return 0;
> +			}
> +		entry->proc_fops = &proc_profile_operations;
> +		entry->size = (1+prof_len) * sizeof(atomic_t);
> +#ifdef CONFIG_HOTPLUG_CPU
> +		register_cpu_notifier(&profile_cpu_notifier);
> +#endif
> +		profile_discard_flip_buffers();
> +        	memset(prof_buffer, 0, prof_len * sizeof(atomic_t));
> +			switch(prof_on)
> +			{
> +			case SCHED_PROFILING:printk(KERN_INFO
> +				"kernel schedule profiling enabled (shift: %ld)\n",
> +				prof_shift);
> +				break;
> +			case CPU_PROFILING:printk(KERN_INFO
> +				"kernel profiling enabled (shift: %ld)\n",
> +				prof_shift);
> +				break;
> +				} 
> +			break;
> +			}
> +		}
> +	return 0;
> +}

Documentation/CodingStyle is your friend ;)

> --- kernel/sysctl.c.org	2005-06-13 16:05:23.000000000 +0300
> +++ kernel/sysctl.c	2005-06-26 02:06:23.000000000 +0300
> ...
> +extern int profile_params[];

Try to place this declaration in a header.

What locking protects prof_boot_on()?  lock_kernel() won't be sufficient
because we're doing sleeping allocations in here.

I suspect it would be best to whap a semaphore around the whole thing.
