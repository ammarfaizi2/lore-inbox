Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWCWFgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWCWFgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWCWFgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:36:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932148AbWCWFgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:36:02 -0500
Date: Wed, 22 Mar 2006 21:32:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [trival patch]disable warning in cpu_init for cpu hotplug
Message-Id: <20060322213240.6ab28346.akpm@osdl.org>
In-Reply-To: <1143091268.11430.49.camel@sli10-desk.sh.intel.com>
References: <1143091268.11430.49.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> The patch seems missed.
>  GFP_KERNEL isn't ok for runtime (cpu hotplug).
> 
>  Signed-off-by: Shaohua Li<shaohua.li@intel.com>
>  ---
> 
>   linux-2.6.15-root/arch/i386/kernel/cpu/common.c |    2 +-
>   1 files changed, 1 insertion(+), 1 deletion(-)
> 
>  diff -puN arch/i386/kernel/cpu/common.c~cpuhp arch/i386/kernel/cpu/common.c
>  --- linux-2.6.15/arch/i386/kernel/cpu/common.c~cpuhp	2006-03-14 12:13:43.000000000 +0800
>  +++ linux-2.6.15-root/arch/i386/kernel/cpu/common.c	2006-03-14 12:14:12.000000000 +0800
>  @@ -605,7 +605,7 @@ void __devinit cpu_init(void)
>   		/* alloc_bootmem_pages panics on failure, so no check */
>   		memset(gdt, 0, PAGE_SIZE);
>   	} else {
>  -		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
>  +		gdt = (struct desc_struct *)get_zeroed_page(GFP_ATOMIC);
>   		if (unlikely(!gdt)) {
>   			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
>   			for (;;)


This isn't good.  GFP_ATOMIC can fail, and if it does, we'll lose this CPU
and probably the entire machine.  It's OK to do this during initial boot,
but not so OK to do it during CPU hotplug.

So can we please fix it better?

You don't describe _why_ the CPU is running atomically here - I wish you had.

One approach would be to allocate the page earlier, before we enter the
atomic region, and to pass that page down to cpu_init(), or to save a
pointer to it in an array of page*'s somewhere.

