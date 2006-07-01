Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWGAL4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWGAL4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWGAL4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:56:08 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:33229 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750938AbWGAL4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:56:08 -0400
Date: Sat, 1 Jul 2006 07:51:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: RFC: unlazy fpu for frequent fpu users
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607010753_MC3-1-C3ED-2040@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1151705536.11434.69.camel@laptopd505.fenrus.org>

On Sat, 01 Jul 2006 00:12:16 +0200, Arjan van de Ven wrote:

> right now the kernel on x86-64 has a 100% lazy fpu behavior: after
> *every* context switch a trap is taken for the first FPU use to restore
> the FPU context lazily. This is of course great for applications that
> have very sporadic or no FPU use (since then you avoid doing the
> expensive save/restore all the time). However for very frequent FPU
> users... you take an extra trap every context switch.
> 
> The patch below adds a simple heuristic to this code: After 5
> consecutive context switches of FPU use, the lazy behavior is disabled
> and the context gets restored every context switch. If the app indeed
> uses the FPU, the trap is avoided. (the chance of the 6th time slice
> using FPU after the previous 5 having done so are quite high obviously).
> 

You can do better that that.  FXSR doesn't destroy the FPU contents; if
you track the context carefully you can completely avoid the restore.
This requires keeping a per-cpu variable that holds a pointer to the
thread that last used the FPU and a per-thread variable containing the
CPU number on which the thread last used FP math. Unfortunately this
won't work in x86_64 because of the 'fxsave information leak' workaround.

> --- linux-2.6.17-sleazyfpu.orig/arch/x86_64/kernel/process.c
> +++ linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
> @@ -515,6 +515,9 @@ __switch_to(struct task_struct *prev_p, 
>       int cpu = smp_processor_id();  
>       struct tss_struct *tss = &per_cpu(init_tss, cpu);
>  
> +     /* prefetch the fxsave area into the cache */
> +     prefetch(&next->i387.fxsave);
> +
>       /*
>        * Reload esp0, LDT and the page table pointer:
>        */

This prefetch is probably a bad idea.  I ported your patch to i386 and it was
actually slower until I changed it:

+       if (next_p->fpu_counter > 5)
+               /* prefetch the fxsave area into the cache */
+               prefetch(&next->i387.fxsave);
+

Now it's ~.4% faster.  The test was an FP program doing a simple benchmark
while a non-FP program ran in a tight loop.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
