Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUETIfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUETIfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUETIfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 04:35:25 -0400
Received: from ozlabs.org ([203.10.76.45]:6543 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265029AbUETIfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 04:35:15 -0400
Subject: Re: [patch] bug in cpuid & msr on nosmp machine
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: matthieu castet <castet.matthieu@free.fr>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040520003240.75fd355d.akpm@osdl.org>
References: <40AB8CDF.8060408@free.fr>
	 <20040520003240.75fd355d.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085042076.7541.27.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 18:34:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-20 at 17:32, Andrew Morton wrote:
> I think what you want here is
> 
> 	if (!cpu_possible(cpu) || !cpu_online(cpu))
> 		return -ENXIO;

It works, but it's not really correct.  cpu_possible() is correct, but
cpu_online() might no longer be true by the time do_cpu_read() calls
do_cpu_id().

One way would be to do lock_cpu_hotplug() in cpuid_open() and introduce
a cpuid_close() which would do unlock_cpu_hotplug().  Another would be
to drop the check here, and fail the actual read.  A final way is to do
no checks, in which case it becomes a noop if the cpu is offline.

> --- 25/arch/i386/kernel/cpuid.c~cpuid-msr-range-checking-fix	2004-05-20 00:30:21.812166544 -0700
> +++ 25-akpm/arch/i386/kernel/cpuid.c	2004-05-20 00:31:16.607836336 -0700
> @@ -133,10 +133,12 @@ static ssize_t cpuid_read(struct file *f
>  static int cpuid_open(struct inode *inode, struct file *file)
>  {
>  	int cpu = iminor(file->f_dentry->d_inode);
> -	struct cpuinfo_x86 *c = &(cpu_data)[cpu];
> +	struct cpuinfo_x86 *c;
>  
> -	if (!cpu_online(cpu))
> +	if (!cpu_possible(cpu) || !cpu_online(cpu))
>  		return -ENXIO;	/* No such CPU */
> +
> +	c = &(cpu_data)[cpu];
>  	if (c->cpuid_level < 0)
>  		return -EIO;	/* CPUID not supported */
>  
> diff -puN arch/i386/kernel/msr.c~cpuid-msr-range-checking-fix arch/i386/kernel/msr.c
> --- 25/arch/i386/kernel/msr.c~cpuid-msr-range-checking-fix	2004-05-20 00:30:21.836162896 -0700
> +++ 25-akpm/arch/i386/kernel/msr.c	2004-05-20 00:31:56.952702984 -0700
> @@ -239,10 +239,12 @@ static ssize_t msr_write(struct file * f
>  static int msr_open(struct inode *inode, struct file *file)
>  {
>    int cpu = iminor(file->f_dentry->d_inode);
> -  struct cpuinfo_x86 *c = &(cpu_data)[cpu];
> -  
> -  if (!cpu_online(cpu))
> -    return -ENXIO;		/* No such CPU */
> +  struct cpuinfo_x86 *c;
> +
> +  if (!cpu_possible(cpu) || !cpu_online(cpu))
> +    return -ENXIO;	/* No such CPU */
> +
> +  c = &(cpu_data)[cpu];
>    if ( !cpu_has(c, X86_FEATURE_MSR) )
>      return -EIO;		/* MSR not supported */
>    
> 
> _
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

