Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbVIVGnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbVIVGnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVIVGnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:43:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030220AbVIVGnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:43:17 -0400
Date: Wed, 21 Sep 2005 23:42:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: Re: Kernel panic during SysRq-b on Alpha
Message-Id: <20050921234232.1034cc02.akpm@osdl.org>
In-Reply-To: <20050922101259.A29179@jurassic.park.msu.ru>
References: <43315BEB.3010909@ens-lyon.org>
	<20050922101259.A29179@jurassic.park.msu.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
>
> On Wed, Sep 21, 2005 at 03:11:07PM +0200, Brice Goglin wrote:
> > Kernel bug at kernel/printk.c:683
> > swapper(0): Kernel Bug 1
> > pc = [<fffffc000032706c>]  ra = [<fffffc00004352d4>]  ps = 0007    Not
> > tainted
> > pc is at acquire_console_sem+0x2c/0x90
> 
> Indeed, acquire_console_sem() does BUG() in interrupt context now,
> as in the case of SysRq-b.
> 
> Ivan.
> 
> --- linux/arch/alpha/kernel/process.c.orig	Mon Aug 29 03:41:01 2005
> +++ linux/arch/alpha/kernel/process.c	Thu Sep 22 09:51:26 2005
> @@ -127,6 +127,10 @@ common_shutdown_1(void *generic_ptr)
>  	/* If booted from SRM, reset some of the original environment. */
>  	if (alpha_using_srm) {
>  #ifdef CONFIG_DUMMY_CONSOLE
> +		/* If we've gotten here after SysRq-b, leave interrupt
> +		   context before taking over the console. */
> +		if (in_interrupt())
> +			irq_exit();
>  		/* This has the effect of resetting the VGA video origin.  */
>  		take_over_console(&dummy_con, 0, MAX_NR_CONSOLES-1, 1);

Wow, never seen that done before.  Does it actually work?  For keyboard,
serial console and /proc/sysrq-trigger?

