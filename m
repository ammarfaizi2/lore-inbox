Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVEZNEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVEZNEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVEZNEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:04:20 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6707
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261413AbVEZNEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:04:12 -0400
Date: Thu, 26 May 2005 15:04:02 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <20050526130402.GN5691@g5.random>
References: <20050525134933.5c22234a.akpm@osdl.org> <17045.36727.602005.757948@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17045.36727.602005.757948@alkaid.it.uu.se>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 10:57:27AM +0200, Mikael Pettersson wrote:
> 2.6.12-rc5-mm1 includes Andrea's seccomp-disable-tsc patch,
> which I believe is broken on SMP. In process.c we find:
> 
>  /*
> + * This function selects if the context switch from prev to next
> + * has to tweak the TSC disable bit in the cr4.
> + */
> +static void disable_tsc(struct thread_info *prev,
> +			struct thread_info *next)
> +{
> +	if (unlikely(has_secure_computing(prev) ||
> +		     has_secure_computing(next))) {
> +		/* slow path here */
> +		if (has_secure_computing(prev) &&
> +		    !has_secure_computing(next)) {
> +			clear_in_cr4(X86_CR4_TSD);
> +		} else if (!has_secure_computing(prev) &&
> +			   has_secure_computing(next))
> +			set_in_cr4(X86_CR4_TSD);
> +	}
> +}
> 
> which it calls from __switch_to().
> 
> The problem is that {set,clear}_in_cr4() both update a single
> global mmu_cr4_features variable, which is asynchronously written
> to all CPUs by {,__}flush_tlb_all(). Hence, the CR4.TSD setting
> is at best probabilistic.

You're right. This won't destabilize the kernel (and it couldn't trigger
in my testing) but it may lead to the tsc to be erroneously disabled on
a non-seccomp task, after a change_page_attr (i.e. insmod) or similar
events using flush_tlb_all (like rmmod). I didn't notice this race
condition sorry (I now recall why we overwrite the cr4 flag in the
global tlb flush: just to flush the global pagetables, since vmalloc
uses global pagetables too).

> I spotted this because perfctr used to flip CR4.PCE in __switch_to()
> ages ago, but I had to abandon that when kernel 2.3.40 changed to
> the current scheme with a global mmu_cr4_features.
> (Another reason was that CR4 writes were and still are very slow.)

Speed is not an issue, cr4 would never be tweaked unless you use
seccomp, the cr4 flip is in an extreme slow path.

I think there are two ways to solve this race:

1) why don't we read the cr4 from the cpu? would movl %%cr4, %%eax
generate a general protection fault? Can the cr4 be read in ring 0?
Why to read it from memory if we've that information in the cpu already?
2) If there's a good reason to read if from memory, then what about
making the mmu_cr4_features per-cpu? That way would solve the problem
too.

Both solutions relay on the fact that the pagetable flush cannot happen
from irqs, so as long as set/clear_in_cr4 is never called from irq (like
in switch_to with this patch), no locking would be required. If the
pagetable flush can be called from irqs (or alternatively if the
set/clear_in_cr4 can be called from irqs) then we'd need to use
test_and_set/clear_bit instead of normal C code despite the structure
being per-cpu, or despite reading the data from the cpu instead of
reading it from memory. In theory we could add a BUG_ON(in_interrupt())
to both, since both set/clear_in_cr4 and the flush_tlb_all aren't fast
paths (probably it worth it just in case).

Comments welcome, thanks!
