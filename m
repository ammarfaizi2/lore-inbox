Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTFOWmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTFOWms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:42:48 -0400
Received: from are.twiddle.net ([64.81.246.98]:29846 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262945AbTFOWmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:42:47 -0400
Date: Sun, 15 Jun 2003 15:56:23 -0700
From: Richard Henderson <rth@twiddle.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@colin.muc.de>, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
Message-ID: <20030615225623.GA14869@twiddle.net>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Andi Kleen <ak@colin.muc.de>,
	Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <m3of0zdzuz.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0306151021440.8088-100000@home.transmeta.com> <20030615193256.29257@colin.muc.de> <Pine.LNX.4.44.0306151943100.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306151943100.12110-100000@serv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 07:48:56PM +0200, Roman Zippel wrote:
> Does the patch below work better?
> 
> bye, Roman
> 
> --- linux/init/main.c	14 Jun 2003 23:01:48 -0000	1.1.1.41
> +++ linux/init/main.c	15 Jun 2003 17:46:16 -0000
> @@ -383,7 +383,7 @@ asmlinkage void __init start_kernel(void
>  {
>  	char * command_line;
>  	extern char saved_command_line[];
> -	extern struct kernel_param __start___param, __stop___param;
> +	extern struct kernel_param __start___param[], __stop___param[];
>  /*
>   * Interrupts are still disabled. Do necessary setups, then
>   * enable them
> @@ -403,8 +403,8 @@ asmlinkage void __init start_kernel(void
>  	build_all_zonelists();
>  	page_alloc_init();
>  	printk("Kernel command line: %s\n", saved_command_line);
> -	parse_args("Booting kernel", command_line, &__start___param,
> -		   &__stop___param - &__start___param,
> +	parse_args("Booting kernel", command_line, __start___param,
> +		   __stop___param - __start___param,
>  		   &unknown_bootoption);
>  	trap_init();
>  	rcu_init();

Linus, I'd REALLY prefer this patch be applied, even though
the problem turned out to be one of amd64 alignment, which
can be worked around.

Even if struct kernel_param doesn't suffer from .sdata problems,
this formulation is closer to Correct.  I'd really prefer that
all such linker-script generated arrays used the [] form, and
not worry about the size of the data object involved.


r~
