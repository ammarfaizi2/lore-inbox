Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUIOVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUIOVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUIOVUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:20:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:32164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267509AbUIOVTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:19:02 -0400
Date: Wed, 15 Sep 2004 14:22:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][2/6]Memory preserving reboot using kexec
Message-Id: <20040915142242.2d3f7cba.akpm@osdl.org>
In-Reply-To: <20040915125322.GC15450@in.ibm.com>
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll add these to -mm.  Minor things:


> +config BACKUP_BASE
> +	int "location of the crash dumps backup region"
> +	depends on CRASH_DUMP
> +	default 16
> +	help
> +	This is the location where the second kernel will boot from.
> +
> +config BACKUP_SIZE
> +	int "Size of the crash dumps backup region"
> +	depends on CRASH_DUMP
> +	range 16 64
> +	default 32
> +	help
> +	The size of the second kernel's memory.

You should tell the user the units of the parameter.  So

	"location of the crash dumps backup region (MB)"

would be nice.

> +++ linux-2.6.9-rc1-hari/include/asm-i386/crash_dump.h	2004-09-15 17:36:30.000000000 +0530
> @@ -0,0 +1,44 @@
> +/* asm-i386/crash_dump.h */
> +#include <linux/bootmem.h>
> +
> +extern unsigned int dump_enabled;
> +
> +void __crash_relocate_mem(unsigned long, unsigned long);
> +unsigned long __init find_max_low_pfn(void);
> +void __init find_max_pfn(void);
> +
> +extern unsigned int crashed;

Should the above declarations be inside CONFIG_CRASH_DUMP?  We don't want
to leave them in scope if they don't exist.

> +static inline void crash_machine_kexec(void)
> +{
> +	struct kimage *image;
> +
> +	if ((!crash_dump_on) || (crashed))
> +		return;
> +
> +	image = xchg(&kexec_image, 0);
> +	if (image) {
> +		crashed = 1;
> +		device_shutdown();
> +		printk(KERN_EMERG "kexec: opening parachute\n");
> +		machine_kexec(image);
> +		while (1);
> +	} else {
> +		printk(KERN_EMERG "kexec: No kernel image loaded!\n");
> +	}
> +}

I don't see why this is inlined??

> +#ifdef CONFIG_CRASH_DUMP
> +/*
> + * Enable kexec reboot upon panic; for dumping
> + */
> +static ssize_t write_crash_dump_on(struct file *file, const char __user *buf,
> +					size_t count, loff_t *ppos)
> +{
> +	if (count) {
> +		if (get_user(crash_dump_on, buf))
> +			return -EFAULT;
> +	}
> +	return count;
> +}
> +
> +static struct file_operations proc_crash_dump_on_operations = {
> +	.write		= write_crash_dump_on,
> +};
> +#endif
> +
>  struct proc_dir_entry *proc_root_kcore;
>  
>  static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
> @@ -663,6 +683,11 @@ void __init proc_misc_init(void)
>  	if (entry)
>  		entry->proc_fops = &proc_sysrq_trigger_operations;
>  #endif
> +#ifdef CONFIG_CRASH_DUMP
> +	entry = create_proc_entry("kexec-dump", S_IWUSR, NULL);
> +	if (entry)
> +		entry->proc_fops = &proc_crash_dump_on_operations;
> +#endif
>  #ifdef CONFIG_LOCKMETER
>  	entry = create_proc_entry("lockmeter", S_IWUSR | S_IRUGO, NULL);
>  	if (entry) {

Please do all the above in a crashdump-specific file, not inside proc_misc.c


