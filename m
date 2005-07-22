Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVGVSQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVGVSQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVGVSQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:16:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261319AbVGVSQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:16:50 -0400
Date: Fri, 22 Jul 2005 11:13:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <20050722081417.GJ3160@stusta.de>
Message-ID: <Pine.LNX.4.58.0507221028070.6074@g5.osdl.org>
References: <200507212309_MC3-1-A534-95EF@compuserve.com> <20050722081417.GJ3160@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jul 2005, Adrian Bunk wrote:
> 
> If this patch makes a difference, could you do me a favour and check 
> whether replacing the current cpu_has_fxsr #define in
> include/asm-i386/cpufeature.h with
> 
>   #define cpu_has_fxsr           1
> 
> on top of your patch brings an additional improvement?

It would be really sad if it made a difference. There might be a branch
mispredict, but the real expense of the fnsave/fxsave will be that
instruction itself, and any cache misses associated with it. The 9%
performace difference would almost have to be due to a memory bank
conflict or something (likely some unnecessary I$ prefetching that
interacts badly with the writeback needed for the _big_ memory write
forced by the fxsave).

I can't see any way that a single branch mispredict could make that big of 
a difference, but I _can_ see how bad memory access patterns could do it.

Btw, the switch from fnsave to fxsave (and thus the change from a 112-byte
save area to a 512-byte one, or whatever the exact details are) caused
_huge_ performance degradation for various context switching benchmarks. I
really hated that, but obviously the need to support SSE2 made it
non-optional. The point being that the real overhead is that big memory 
read/write in fxrestor/fxsave.

What _could_ make a bigger difference is not doing the lazy FPU at all.  
That lazy FPU is a huge optimization on 99.9% of all loads, but it sounds
like java/volanomark are broken and always use the FPU, and then we take a
big hit on doing the FP restore exception (an exception is a lot more
expensive than a mispredict).

Something like the following (totally untested) should make it be
non-lazy. It's going to slow down normal task switches, but might speed up 
the "restoring FP context all the time" case.

Chuck? This should work fine with or without your inline thing. Does it 
make any difference?

		Linus

-----
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -678,8 +678,16 @@ struct task_struct fastcall * __switch_t
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
-
-	__unlazy_fpu(prev_p);
+	if (prev_p->thread_info->status & TS_USEDFPU) {
+		__save_init_fpu(prev_p);
+		if (tsk_used_math(next_p))
+			init_fpu(next_p);
+		restore_fpu(next_p);
+		next_p->thread_info->status |= TS_USEDFPU;
+	} else {
+		stts();
+		next_p->thread_info->status &= ~TS_USEDFPU;
+	}
 
 	/*
 	 * Reload esp0, LDT and the page table pointer:
@@ -710,13 +718,13 @@ struct task_struct fastcall * __switch_t
 	 * Now maybe reload the debug registers
 	 */
 	if (unlikely(next->debugreg[7])) {
-		set_debugreg(current->thread.debugreg[0], 0);
-		set_debugreg(current->thread.debugreg[1], 1);
-		set_debugreg(current->thread.debugreg[2], 2);
-		set_debugreg(current->thread.debugreg[3], 3);
+		set_debugreg(next->debugreg[0], 0);
+		set_debugreg(next->debugreg[1], 1);
+		set_debugreg(next->debugreg[2], 2);
+		set_debugreg(next->debugreg[3], 3);
 		/* no 4 and 5 */
-		set_debugreg(current->thread.debugreg[6], 6);
-		set_debugreg(current->thread.debugreg[7], 7);
+		set_debugreg(next->debugreg[6], 6);
+		set_debugreg(next->debugreg[7], 7);
 	}
 
 	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
