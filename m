Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVH2ROD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVH2ROD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVH2ROD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:14:03 -0400
Received: from ns.suse.de ([195.135.220.2]:38042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751122AbVH2ROC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:14:02 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [patch 08/16] Add support for X86_64 platforms to KGDB
Date: Mon, 29 Aug 2005 19:13:47 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com
References: <resend.7.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.8.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.8.2982005.trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508291913.48648.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 August 2005 18:10, Tom Rini wrote:

> +void __init early_setup_per_cpu_area(void)
> +{
> +	static char cpu0[PERCPU_ENOUGH_ROOM]
> +		__attribute__ ((aligned (SMP_CACHE_BYTES)));
> +	char *ptr = cpu0;
> +
> +	cpu_pda[0].data_offset = ptr - __per_cpu_start;
> +	memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
> +}

What is that?  It looks totally bogus. Can you tell exactly where you
believe early per cpu data is needed?

> +
>  /*
>   * Great future plan:
>   * Declare PDA itself and support (irqstack,tss,pgd) as per cpu data.
> @@ -97,7 +107,9 @@ void __init setup_per_cpu_areas(void)
>  	for (i = 0; i < NR_CPUS; i++) {
>  		char *ptr;
>
> -		if (!NODE_DATA(cpu_to_node(i))) {
> +		if (cpu_pda[i].data_offset)
> +			continue;

And that looks broken too.

In general I would also advise to mix any other changes outside kgdb* into the 
x86-64 kgdb patch. Either the patch should be merged into mainline in a 
separate patch or kgdb reworked to not need this.

> +	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> +				SIGSEGV) == NOTIFY_STOP)
> +		return;
> +

I can see the point of that. It's ok if you submit it as a separate patch.

Regarding early trap init: I would have no problem to move all of traps_init
into setup_arch (and leave traps_init empty for generic code). I actually
don't know why it runs so late. But doing it half way is ugly.

-Andi
