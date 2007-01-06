Return-Path: <linux-kernel-owner+w=401wt.eu-S1751016AbXAFAbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXAFAbl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 19:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbXAFAbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 19:31:41 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:55520 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbXAFAbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 19:31:40 -0500
Message-ID: <459EEDEB.8090800@vmware.com>
Date: Fri, 05 Jan 2007 16:31:39 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
References: <20070106000715.GA6688@elte.hu>
In-Reply-To: <20070106000715.GA6688@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Subject: [patch] paravirt: isolate module ops
> From: Ingo Molnar <mingo@elte.hu>
>
> only export those operations to modules that have been available to them 
> historically: irq disable/enable, io-delay, udelay, etc.
>
> this isolates that functionality from other paravirtualization 
> functionality that modules have no business messing with.
>
> boot and build tested with CONFIG_PARAVIRT=y.
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/i386/kernel/paravirt.c |   41 +++++++++++++++++++++++++++
>  include/asm-i386/delay.h    |    4 +-
>  include/asm-i386/paravirt.h |   65 ++++++++++++++++++++++----------------------
>  3 files changed, 75 insertions(+), 35 deletions(-)
>
> Index: linux/arch/i386/kernel/paravirt.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/paravirt.c
> +++ linux/arch/i386/kernel/paravirt.c
> @@ -492,6 +492,7 @@ struct paravirt_ops paravirt_ops = {
>  
>   	.patch = native_patch,
>  	.banner = default_banner,
> +
>  	.arch_setup = native_nop,
>  	.memory_setup = machine_specific_memory_setup,
>  	.get_wallclock = native_get_wallclock,
> @@ -566,4 +567,42 @@ struct paravirt_ops paravirt_ops = {
>  	.irq_enable_sysexit = native_irq_enable_sysexit,
>  	.iret = native_iret,
>  };
> -EXPORT_SYMBOL(paravirt_ops);
> +
> +/*
> + * These are exported to modules:
> + */
> +struct paravirt_ops paravirt_mod_ops = {
> +	.name = "bare hardware",
> +	.paravirt_enabled = 0,
> +	.kernel_rpl = 0,
> +
> + 	.patch = native_patch,
>   

I don't think you want to leave that one... patching the kernel isn't 
something modules should be doing.

Perhaps a separate structure is better for module ops - this seems error 
prone to calling the wrong one of paravirt_ops vs. paravirt_mod_ops, 
also error prone to set them up in the code which sets paravirt_ops for 
each hypervisor.  Although that does require more dissection, it does 
make sure everyone gets it right, and makes the interface very 
explicitly clear in the header file, which is nice.

If you feel strongly about this, I suggest you push it upstream now, not 
into Andrew's tree (it doesn't apply cleanly there, and breaks the VMI 
patches which are in there).  But this is no problem, I can fix that up 
easily once you get it in.

Zach
