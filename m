Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161232AbWGNQc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbWGNQc7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161229AbWGNQc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:32:59 -0400
Received: from relay01.pair.com ([209.68.5.15]:45837 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1161216AbWGNQc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:32:58 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 14 Jul 2006 11:32:48 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Linus Torvalds <torvalds@osdl.org>
cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from nmi.c
In-Reply-To: <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0607141131390.27161@turbotaz.ourhouse>
References: <1152882288.1883.30.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006, Linus Torvalds wrote:

> diff --git a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
> index 2dd928a..eb8bbbb 100644
> --- a/arch/i386/kernel/nmi.c
> +++ b/arch/i386/kernel/nmi.c
> @@ -106,7 +106,7 @@ #ifdef CONFIG_SMP
>  */
> static __init void nmi_cpu_busy(void *data)
> {
> -	volatile int *endflag = data;
> +	int *endflag = data;
> 	local_irq_enable_in_hardirq();
> 	/* Intentionally don't use cpu_relax here. This is
> 	   to make sure that the performance counter really ticks,
> @@ -121,10 +121,14 @@ #endif
>
> static int __init check_nmi_watchdog(void)
> {
> -	volatile int endflag = 0;
> +	static int endflag = 0;

Now that this is static, isn't this a candidate for __initdata?

> 	unsigned int *prev_nmi_count;
> 	int cpu;
>
> +	/* Have we done this already? */
> +	if (endflag)
> +		return 0;
> +
> 	if (nmi_watchdog == NMI_NONE)
> 		return 0;
>

Thanks,
Chase
