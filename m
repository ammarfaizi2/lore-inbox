Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWCQJH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWCQJH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWCQJH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:07:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750971AbWCQJHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:07:02 -0500
Date: Fri, 17 Mar 2006 01:04:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       bryce@osdl.org
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-Id: <20060317010412.3243364c.akpm@osdl.org>
In-Reply-To: <20060317084653.GA4515@in.ibm.com>
References: <20060316174447.GA8184@in.ibm.com>
	<20060316170814.02fa55a1.akpm@osdl.org>
	<20060317084653.GA4515@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> Well ..other arch-es need to have a similar check if they get around to
> implement physical hot-add (even if they allow offlining of all CPUs). This is 
> required since a user can (by mistake maybe) try to bring up an already online 
> CPU by writing a '1' to it's sysfs 'online' file. 'store_online' 
> (drivers/base/cpu.c) unconditionally calls 'smp_prepare_cpu' w/o checking for 
> this error condition. The check added in the patch catches such error 
> conditions as well.

OK..  I guess we should fix those architectures while we're thinking about it.

> --- linux-2.6.16-rc6/arch/i386/kernel/smpboot.c~cpu_hp	2006-03-17 14:27:15.000000000 +0530
> +++ linux-2.6.16-rc6-root/arch/i386/kernel/smpboot.c	2006-03-17 14:38:50.000000000 +0530
> @@ -1029,6 +1029,16 @@ int __devinit smp_prepare_cpu(int cpu)
>  	int	apicid, ret;
>  
>  	lock_cpu_hotplug();
> +
> +	/* Check if CPU is already online. This can happen if user tries to 
> +	 * bringup an already online CPU or a previous offline attempt
> +	 * on this CPU has failed.
> +	 */
> +	if (cpu_online(cpu)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +

How well tested is this?  From my reading, this will cause
enable_nonboot_cpus() to panic.  Is that intended?

