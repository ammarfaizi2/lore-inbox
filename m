Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317690AbSFSAPr>; Tue, 18 Jun 2002 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317691AbSFSAPq>; Tue, 18 Jun 2002 20:15:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317690AbSFSAPq>; Tue, 18 Jun 2002 20:15:46 -0400
Date: Tue, 18 Jun 2002 17:12:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken 
In-Reply-To: <E17KSLb-0007Dj-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0206181701240.2562-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Rusty Russell wrote:
>  
> -	new_mask &= cpu_online_map;
> +	/* Eliminate offline cpus from the mask */
> +	for (i = 0; i < NR_CPUS; i++)
> +		if (!cpu_online(i))
> +			new_mask &= ~(1<<i);
> +

And why can't cpu_online_map be a bitmap?

What's your beef against sane and efficient data structures? The above is 
just crazy. 

Just add a

	#define NRCPUWORDS ROUND_UP(NR_CPU, BITS_PER_LONG)

	struct cpu_mask {
		unsigned long mask[NRCPUWORDS];
	} cpu_mask_t;

and then add a few simple operations like

	cpumask_and(cpu_mask_t * res, cpu_mask_t *a, cpu_mask_t *b);

and friends.. See how we handle this issue in <linux/signal.h>, which has 
perfectly efficient things to do all the same issues (ie see how 
"sigemptyset()" and friends compile to efficient code for the "normal" 
cases.

This is not rocket science, and I find it ridiculous that you claim to
worry about scaling up to thousands of CPU's, and then you try to send me
absolute crap like the above which clearly is unacceptable for lots of
CPU's.

No, C doesn't have built-in support for bitmap operations except on a 
small scale level (ie single words), and yes, clearly that's why Linux 
tends to prefer only small bitmaps, but NO, that does not make bitmaps 
evil.

		Linus

