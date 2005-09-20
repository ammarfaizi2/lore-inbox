Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbVITNIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVITNIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVITNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:08:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17542 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965007AbVITNIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:08:47 -0400
Date: Tue, 20 Sep 2005 15:08:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 zaurus: pcmcia now works
Message-ID: <20050920130846.GB14548@atrey.karlin.mff.cuni.cz>
References: <20050920100823.GA16186@elf.ucw.cz> <20050920111851.GA26353@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920111851.GA26353@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > FYI, my hacks now look like (attached). I'll push changes to linux-z
> > in few hours.
> 
> Some questions:
> 
> @@ -57,8 +57,6 @@ void dump_backtrace_entry(unsigned long
>  #ifdef CONFIG_KALLSYMS
>         printk("[<%08lx>] ", where);
>         print_symbol("(%s) ", where);
> -       printk("from [<%08lx>] ", from);
> -       print_symbol("(%s)\n", from);
> 
> The "from" address provides good hints about the exact path we got to
> the called function.  You don't really want to get rid of that because
> it makes following backtraces harder.  I'm not sure why you've made
> the other changes in that file either.

Well, zaurus console is something like 40x20 characters. Normal
backtrace does not fit there, and it has most important info at the
top.


> +/* those must never be empty
> +   unfortunately they cause problems with older binutils
>  ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
>  ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
> +*/
> 
> Get a better binutils. 8)

Yep :-). Those can wait.

> diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
> --- a/drivers/mfd/mcp-core.c
> +++ b/drivers/mfd/mcp-core.c
> @@ -19,6 +19,7 @@
>  #include <asm/dma.h>
>  #include <asm/system.h>
> 
> +#include <asm/arch/mcp.h>
>  #include "mcp.h"
> 
>  #define to_mcp(d)              container_of(d, struct mcp, attached_device)
> 
> This looks bogus - why is this needed?

Can go, fixed. (Remainings of previous patches).

> @@ -186,7 +192,12 @@ static int mcp_sa11x0_probe(struct devic
>          */
>         Ser4MCSR = -1;
>         Ser4MCCR1 = data->mccr1;
> -       Ser4MCCR0 = data->mccr0 | 0x7f7f;
> +#if 1
> +       if (machine_is_collie())
> +               Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
> +       else
> +#endif
> +               Ser4MCCR0 = data->mccr0 | 0x7f7f;
> 
> Ditto.

I tried to kill that one before, and it broke boot. I have little idea
how to debug that one...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
