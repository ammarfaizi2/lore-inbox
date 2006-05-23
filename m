Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWEWWLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWEWWLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWEWWLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:11:03 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31251 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932441AbWEWWLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:11:02 -0400
Message-ID: <44738875.90206@vmware.com>
Date: Tue, 23 May 2006 15:11:01 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, jakub@redhat.com,
       rusty@rustcorp.com.au, kraxel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] vdso: print fatal signals
References: <20060523000119.GB9934@elte.hu>
In-Reply-To: <20060523000119.GB9934@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Index: linux-vdso-rand.q/kernel/signal.c
> ===================================================================
> --- linux-vdso-rand.q.orig/kernel/signal.c
> +++ linux-vdso-rand.q/kernel/signal.c
> @@ -763,6 +763,37 @@ out_set:
>  #define LEGACY_QUEUE(sigptr, sig) \
>  	(((sig) < SIGRTMIN) && sigismember(&(sigptr)->signal, (sig)))
>  
> +int print_fatal_signals = 0;
> +
> +static void print_fatal_signal(struct pt_regs *regs, int signr)
> +{
> +	printk("%s/%d: potentially unexpected fatal signal %d.\n",
> +		current->comm, current->pid, signr);
> +
> +#ifdef __i386__
> +	printk("code at %08lx: ", regs->eip);
> +	{
> +		int i;
> +		for (i = 0; i < 16; i++) {
> +			unsigned char insn;
> +
> +			__get_user(insn, (unsigned char *)(regs->eip + i));
> +			printk("%02x ", insn);
> +		}
> +	}
> +#endif
>   


This looks ok for debugging boot problems.  Perhaps you could print the 
registers too?  The instruction dump won't help much for indirect access.

The get_user of eip+i is ok, but doesn't account for segment offsets.  
Not that I think it needs to here.  But it is one of a many growing 
number of places that now try to inspect or modify a potentially 
segmented area of memory (page fault handler must inspect for prefetch 
instructions, kprobes reads and patches code, FPU emulation).  Perhaps a 
common interface would be a nice thing at some point in time.

Zach
