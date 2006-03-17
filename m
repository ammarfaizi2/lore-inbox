Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752470AbWCQBGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbWCQBGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbWCQBGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:06:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752470AbWCQBGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:06:03 -0500
Date: Thu, 16 Mar 2006 17:08:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       bryce@osdl.org
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-Id: <20060316170814.02fa55a1.akpm@osdl.org>
In-Reply-To: <20060316174447.GA8184@in.ibm.com>
References: <20060316174447.GA8184@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> Bryce reported a bug wherein offlining CPU0 (on x86 box) and then subsequently
> onlining it resulted in a lockup. 
> 
> On x86, CPU0 is never offlined. The subsequent attempt to online CPU0
> doesn't take that into account. It actually tries to bootup the already
> booted CPU. Following patch fixes the problem (as acknowledged by
> Bryce). Please consider for inclusion in 2.6.16.
> 
> 

Is x86 the only architecture which is exposed to this?

> 
> diff -puN arch/i386/kernel/smpboot.c~cpuhp arch/i386/kernel/smpboot.c
> --- linux-2.6.16-rc5/arch/i386/kernel/smpboot.c~cpuhp	2006-03-14 14:42:26.000000000 +0530
> +++ linux-2.6.16-rc5-root/arch/i386/kernel/smpboot.c	2006-03-14 14:43:21.000000000 +0530
> @@ -1029,6 +1029,12 @@ int __devinit smp_prepare_cpu(int cpu)
>  	int	apicid, ret;
>  
>  	lock_cpu_hotplug();
> +
> +	if (cpu_online(cpu)) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
>  	apicid = x86_cpu_to_apicid[cpu];
>  	if (apicid == BAD_APICID) {
>  		ret = -ENODEV;

a) It's hard for the reader to understand what that test is doing there

b) People copy code from x86, so other architectures which are not
   exposed to this problem will end up having a pointless test in there.

IOW: please comment your code.   I'll fix this one up.
