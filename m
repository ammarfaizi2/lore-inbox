Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWGAVuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWGAVuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWGAVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:50:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:5817 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750741AbWGAVuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:50:02 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 1/2] sLeAZY FPU feature - x86_64 support
Date: Sat, 1 Jul 2006 23:49:36 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1151773893.3195.45.camel@laptopd505.fenrus.org> <1151773956.3195.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1151773956.3195.47.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607012349.36091.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> After 256 switches, this is reset and lazy behavior is returned (until
> there are 5 consecutive ones again). The reason for this is to give apps
> that do longer bursts of FPU use still the lazy behavior back after some
> time.

Cool. This has been on my todo list forever.

However I'm not sure 256 is a good number. It seems a bit too high.

> Index: linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
> ===================================================================
> --- linux-2.6.17-sleazyfpu.orig/arch/x86_64/kernel/process.c
> +++ linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
> @@ -515,6 +515,10 @@ __switch_to(struct task_struct *prev_p, 
>  	int cpu = smp_processor_id();  
>  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
>  
> +	/* we're going to use this soon, after a few expensive things */
> +	if (next_p->fpu_counter>5)
> +		prefetch(&next->i387.fxsave);

Did you measure this prefetch makes a difference? I would expect it to
be too soon to be really worth while (normally you need hundreds of
instructions for them to make sense and that's probably not the case here) 

>  #endif
> +	/*
> +	 * fpu_counter contains the number of consecutive context switches
> +	 * that the FPU is used. If this is over a threshold, the lazy fpu
> +	 * saving becomes unlazy to save the trap. This is an unsigned char
> +	 * so that after 256 times the counter wraps and the behavior turns
> +	 * lazy again; this to deal with bursty apps that only use FPU for
> +	 * a short time
> +	 */
> +	unsigned char fpu_counter;

Putting it at the end is also not good because there are the rarely used
cachelines. Probably better in the thread structure
-Andi
