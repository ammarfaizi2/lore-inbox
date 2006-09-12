Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbWILMoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWILMoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWILMoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:44:46 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:47264 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S965237AbWILMop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:44:45 -0400
Date: Tue, 12 Sep 2006 07:44:57 -0500
From: Brandon Philips <brandon@ifup.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Robert Love <rml@novell.com>
Subject: Re: [patch] genirq/MSI: restore __do_IRQ() compat logic temporarily
Message-ID: <20060912124457.GA5993@plankton.ifup.org>
References: <20060908174437.GA5926@plankton.ifup.org> <20060908121319.11a5dbb0.akpm@osdl.org> <20060908194300.GA5901@plankton.ifup.org> <20060908125053.c31b76e9.akpm@osdl.org> <20060911021400.GA6163@plankton.ifup.org> <20060911095106.2a7d6d95.akpm@osdl.org> <m1lkop7gi5.fsf@ebiederm.dsl.xmission.com> <20060912075047.GA10641@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912075047.GA10641@elte.hu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:50 Tue 12 Sep 2006, Ingo Molnar wrote:
> * Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Ok.  Looking at it I almost certain the problem is that
> > we lost the hunk of code removed in: 266f0566761cf88906d634727b3d9fc2556f5cbd
> > i386: Fix stack switching in do_IRQ
> > 
> > -       if (!irq_desc[irq].handle_irq) {
> > -               __do_IRQ(irq, regs);
> > -               goto out_exit;
> > -       }
> > 
> > The msi code does not yet set desc->handle_irq.  So when we attempt to 
> > call it we get a NULL pointer dereference.
> 
> indeed ... We thought the MSI cleanup went all the way with the irqchips 
> conversion, that's we suggested to Andrew to drop this chunk in -mm too.
> 
> > Except for adding that hunk back in and breaking 4K stacks I don't 
> > have an immediate fix.
> 
> i've attached a bandaid patch for -mm below. Brandon, does this solve 
> the crash you are seeing?

Indeed- this patch makes the system bootable.

I will keep up on the -mm tree as this conversion continues and let all
of you know if things break again :-)

Thanks,

	Brandon

> ------------------>
> Subject: [patch] genirq/MSI: restore __do_IRQ() compat logic temporarily
> From: Ingo Molnar <mingo@elte.hu>
> 
> restore the __do_IRQ() compat logic temporarily, until the MSI
> genirq conversion has been completed.
> 
> disable 4KSTACKS temporarily too.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ---
>  arch/i386/Kconfig.debug |    4 ++++
>  arch/i386/kernel/irq.c  |    5 +++++
>  2 files changed, 9 insertions(+)
> 
> Index: linux-2.6.18-rc6-mm1/arch/i386/Kconfig.debug
> ===================================================================
> --- linux-2.6.18-rc6-mm1.orig/arch/i386/Kconfig.debug
> +++ linux-2.6.18-rc6-mm1/arch/i386/Kconfig.debug
> @@ -56,8 +56,12 @@ config DEBUG_RODATA
>  	  portion of the kernel code won't be covered by a 2MB TLB anymore.
>  	  If in doubt, say "N".
>  
> +#
> +# FIXME: Disabled temporarily until the MSI genirq conversion is done!
> +#
>  config 4KSTACKS
>  	bool "Use 4Kb + 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
> +	depends on n
>  	default y
>  	help
>  	  If you say Y here the kernel will use a 4Kb stacksize for the
> Index: linux-2.6.18-rc6-mm1/arch/i386/kernel/irq.c
> ===================================================================
> --- linux-2.6.18-rc6-mm1.orig/arch/i386/kernel/irq.c
> +++ linux-2.6.18-rc6-mm1/arch/i386/kernel/irq.c
> @@ -83,6 +83,10 @@ fastcall unsigned int do_IRQ(struct pt_r
>  	}
>  #endif
>  
> +	if (!irq_desc[irq].handle_irq) {
> +		__do_IRQ(irq, regs);
> +		goto out_exit;
> +	}
>  #ifdef CONFIG_4KSTACKS
>  
>  	curctx = (union irq_ctx *) current_thread_info();
> @@ -123,6 +127,7 @@ fastcall unsigned int do_IRQ(struct pt_r
>  #endif
>  		desc->handle_irq(irq, desc, regs);
>  
> +out_exit:
>  	irq_exit();
>  
>  	return 1;

