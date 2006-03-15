Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWCOXb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWCOXb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbWCOXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:31:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1768 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752162AbWCOXbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:31:55 -0500
Date: Thu, 16 Mar 2006 00:31:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 24/24] i386 Vmi no idle hz
Message-ID: <20060315233128.GD1919@elf.ucw.cz>
References: <200603131817.k2DIHkMa005792@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131817.k2DIHkMa005792@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When a VCPU enters its idle loop, it disables its periodic
> alarm and sets up a one shot alarm for the next time event.
> That way, it does not become ready to run just to service
> the periodic alarm interrupt. Instead, it can remain halted
> until there is some real work pending for it.  This allows
> the hypervisor to use the physical resources more
> effectively since idle VCPUs will have lower overhead.

Does this NO_IDLE_HZ work only on VMI-enabled runs or globally? We are
trying to get NO_IDLE_HZ working to save some power on notebooks; how
is it related to this?

> @@ -579,6 +569,17 @@ static ctl_table kern_table[] = {
>  		.proc_handler	= &proc_dointvec,
>  	},
>  #endif
> +#if defined(CONFIG_NO_IDLE_HZ) && (defined(CONFIG_ARCH_S390) || \
> +				   defined(CONFIG_X86) && defined(CONFIG_X86_VMI))
> +	{
> +		.ctl_name       = KERN_HZ_TIMER,
> +		.procname       = "hz_timer",
> +		.data           = &sysctl_hz_timer,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0644,
> +		.proc_handler   = &proc_dointvec,
> +	},
> +#endif
>  	{
>  		.ctl_name	= KERN_PIDMAX,
>  		.procname	= "pid_max",

But this seems to disable it for non-VMI machines :-(.

> Index: linux-2.6.16-rc6/include/asm-i386/mach-default/mach_idletimer.h
> ===================================================================
> --- linux-2.6.16-rc6.orig/include/asm-i386/mach-default/mach_idletimer.h	2006-03-12 19:57:53.000000000 -0800
> +++ linux-2.6.16-rc6/include/asm-i386/mach-default/mach_idletimer.h	2006-03-12 19:57:53.000000000 -0800
> @@ -0,0 +1,19 @@
> +
> +/*
> + * NO_IDLE_HZ callbacks.
> + */
> +
> +#ifndef __ASM_MACH_IDLETIMER_H
> +#define __ASM_MACH_IDLETIMER_H
> +
> +static inline void stop_hz_timer(void) 
> +{
> +
> +}
> +
> +static inline void restart_hz_timer(struct pt_regs *regs)
> +{
> +
> +}
> +
> +#endif /* __ASM_MACH_IDLETIMER_H */

And I guess these would need to be implemented.

Can you use NO_IDLE_HZ patches that are already floating around?

								Pavel


-- 
180:        alg = Rijndael.Create();
