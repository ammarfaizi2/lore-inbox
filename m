Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWBGPPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWBGPPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWBGPPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:15:45 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:35702 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965127AbWBGPPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:15:44 -0500
Date: Tue, 7 Feb 2006 16:15:41 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Ingo Molnar <mingo@elte.hu>, Jens Axboe <axboe@suse.de>,
       Anton Blanchard <anton@samba.org>, William Irwin <wli@holomorphy.com>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060207151541.GA32139@osiris.boeblingen.de.ibm.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602051959.k15JxoHK001630@hera.kernel.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> tree 8c30052a0d7fadec37c785a42a71b28d0a9c5fcf
> parent cef5076987dd545ac74f4efcf1c962be8eac34b0
> author Eric Dumazet <dada1@cosmosbay.com> Sun, 05 Feb 2006 15:27:36 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 06 Feb 2006 03:06:51 -0800
> 
> [PATCH] percpu data: only iterate over possible CPUs
> 
> percpu_data blindly allocates bootmem memory to store NR_CPUS instances of
> cpudata, instead of allocating memory only for possible cpus.
> 
> As a preparation for changing that, we need to convert various 0 -> NR_CPUS
> loops to use for_each_cpu().
> 
> (The above only applies to users of asm-generic/percpu.h.  powerpc has gone it
> alone and is presently only allocating memory for present CPUs, so it's
> currently corrupting memory).

This patch is broken since it replaces several loops that iterate NR_CPUS
times with for_each_cpu before cpu_possible_map is setup:

> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -379,7 +379,6 @@ static void __devinit fdtable_defer_list
>  void __init files_defer_init(void)
>  {
>  	int i;
> -	/* Really early - can't use for_each_cpu */
> -	for (i = 0; i < NR_CPUS; i++)
> +	for_each_cpu(i)
>  		fdtable_defer_list_init(i);
>  }

The old comment indicates it: called before smp_prepare_cpus gets called
which sets up cpu_possible_map.

> diff --git a/kernel/sched.c b/kernel/sched.c
> index f77f23f..839466f 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -6109,7 +6109,7 @@ void __init sched_init(void)
>  	runqueue_t *rq;
>  	int i, j, k;
>  
> -	for (i = 0; i < NR_CPUS; i++) {
> +	for_each_cpu(i) {
>  		prio_array_t *array;

Same here.

I didn't check the rest, but it looks like we end up with a bit of
uninitialized stuff.

Heiko
