Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUB0WwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbUB0Wuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:50:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41711 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263174AbUB0Wtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:49:45 -0500
Message-ID: <403FC980.8040905@mvista.com>
Date: Fri, 27 Feb 2004 14:49:36 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [KGDB PATCH][3/7] SysRq-G
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net> <20040227213254.GE1052@smtp.west.cox.net>
In-Reply-To: <20040227213254.GE1052@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There may be a need to change the keyboard driver for this.  I have had trouble 
with it in the past.  Seems it doesn't like to not get control back for a very 
long time.  I am not sure what the problem is but, be warned.

-g

Tom Rini wrote:
> Hello.  The following adds SysRq-G.  This is always configured in on
> CONFIG_KGDB && CONFIG_SYSRQ.
> 
> diff -zrupN linux-2.6.3+config+serial/drivers/char/sysrq.c linux-2.6.3+config+serial+sysrq+arch_hooks/drivers/char/sysrq.c
> --- linux-2.6.3+config+serial/drivers/char/sysrq.c	2004-02-27 12:06:22.000000000 -0700
> +++ linux-2.6.3+config+serial+sysrq+arch_hooks/drivers/char/sysrq.c	2004-02-27 12:16:14.000000000 -0700
> @@ -31,6 +31,7 @@
>  #include <linux/suspend.h>
>  #include <linux/writeback.h>
>  #include <linux/buffer_head.h>		/* for fsync_bdev() */
> +#include <linux/kgdb.h>			/* for breakpoint() */
>  
>  #include <linux/spinlock.h>
>  
> @@ -44,6 +45,25 @@ int sysrq_enabled = 1;
>  /* Machine specific power off function */
>  void (*sysrq_power_off)(void);
>  
> +/* Make a breakpoint() right now. */
> +#ifdef CONFIG_KGDB
> +#define  GDB_OP &kgdb_op
> +static void kgdb_sysrq(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
> +{
> +	printk("kgdb sysrq\n");
> +	breakpoint();
> +}
> +
> +static struct sysrq_key_op kgdb_op = {
> +	.handler	= kgdb_sysrq,
> +	.help_msg	= "kGdb|Fgdb",
> +	.action_msg	= "Debug breakpoint\n",
> +};
> +
> +#else
> +#define  GDB_OP NULL
> +#endif
> +
>  /* Loglevel sysrq handler */
>  static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
>  				  struct tty_struct *tty) 
> @@ -239,7 +259,7 @@ static struct sysrq_key_op *sysrq_key_ta
>  /* d */	NULL,
>  /* e */	&sysrq_term_op,
>  /* f */	NULL,
> -/* g */	NULL,
> +/* g */	GDB_OP,
>  /* h */	NULL,
>  /* i */	&sysrq_kill_op,
>  /* j */	NULL,
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

