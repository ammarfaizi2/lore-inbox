Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269746AbUJGHvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269746AbUJGHvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 03:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbUJGHvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 03:51:49 -0400
Received: from gprs214-97.eurotel.cz ([160.218.214.97]:54400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269746AbUJGHvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 03:51:46 -0400
Date: Thu, 7 Oct 2004 09:51:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kernel] Fix random crashes in x86-64 swsusp
Message-ID: <20041007075132.GB15057@elf.ucw.cz>
References: <s1648f6e.098@lucius.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1648f6e.098@lucius.provo.novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Maybe not really a final version: The __init should remain there if
> suspend/resume isn't enabled in the configuration. I'd guess you want
> something for this paralleling the __cpuinit/__devinit/module_init stuff
> (if these occur very rarely, then doing this inline may of course also
> be an acceptable choice). Jan

I do not think we care enough about those few bytes to make sources
more complex. These functions are really small.
								Pavel

> >>> pavel@suse.cz 07.10.04 00:06:00 >>>
> Hi!
> 
> fix_processor_context was calling functions marked __init on x86-64;
> bad idea. Maybe we should memset freed memory to zero so such bugs are
> prevented?
> 
> Thanks to Rafael for keeping notifying me about this bug, and someone
> get me yet another brown paper bag.
> 
> Anyway, this should fix it, please apply,
> 								Pavel
> 
> --- clean-suse/arch/x86_64/ia32/syscall32.c	2004-06-22
> 12:36:00.000000000 +0200
> +++ linux-suse/arch/x86_64/ia32/syscall32.c	2004-10-06
> 23:58:27.000000000 +0200
> @@ -76,7 +76,8 @@
>  	
>  __initcall(init_syscall32); 
>  
> -void __init syscall32_cpu_init(void)
> +/* May not be __init: called during resume */
> +void syscall32_cpu_init(void)
>  {
>  	if (use_sysenter < 0)
>   		use_sysenter = (boot_cpu_data.x86_vendor ==
> X86_VENDOR_INTEL);
> --- clean-suse/arch/x86_64/kernel/setup64.c	2004-10-05
> 11:36:21.000000000 +0200
> +++ linux-suse/arch/x86_64/kernel/setup64.c	2004-10-06
> 23:59:08.000000000 +0200
> @@ -195,7 +195,8 @@
>  char boot_exception_stacks[N_EXCEPTION_STACKS * EXCEPTION_STKSZ] 
>  __attribute__((section(".bss.page_aligned")));
>  
> -void __init syscall_init(void)
> +/* May not be marked __init: used by software suspend */
> +void syscall_init(void)
>  {
>  	/* 
>  	 * LSTAR and STAR live in a bit strange symbiosis.
> 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
