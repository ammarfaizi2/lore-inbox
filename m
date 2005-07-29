Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVG2Hie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVG2Hie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVG2Hie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:38:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54414 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262469AbVG2Hic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:38:32 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Molnar <mingo@elte.hu>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function 
In-reply-to: Your message of "Fri, 29 Jul 2005 09:04:48 +0200."
             <20050729070447.GA3032@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jul 2005 17:38:09 +1000
Message-ID: <10462.1122622689@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 09:04:48 +0200, 
Ingo Molnar <mingo@elte.hu> wrote:
>ok, how about the additional patch below? Does this do the trick on 
>ia64? It makes complete sense on every architecture to prefetch from 
>below the current kernel stack, in the expectation of the next task 
>touching the stack. The only difference is that for ia64 the 'expected 
>minimum stack footprint' is larger, due to the switch_stack.
>...
>Index: linux/kernel/sched.c
>===================================================================
>--- linux.orig/kernel/sched.c
>+++ linux/kernel/sched.c
>@@ -2869,7 +2869,14 @@ go_idle:
> 	 * its thread_info, its kernel stack and mm:
> 	 */
> 	prefetch(next->thread_info);
>-	prefetch(kernel_stack(next));
>+	/*
>+	 * Prefetch (at least) a cacheline below the current
>+	 * kernel stack (in expectation of any new task touching
>+	 * the stack at least minimally), and a cacheline above
>+	 * the stack:
>+	 */
>+	prefetch_range(kernel_stack(next) - MIN_KERNEL_STACK_FOOTPRINT,
>+		       MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);
> 	prefetch(next->mm);
> 
> 	if (!rt_task(next) && next->activated > 0) {

Surely the prefetch range has to depend on which direction the stack
grows.  For stacks that grow down, we want esp/ksp upwards,

prefetch_range(kernel_stack(next),
	MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);

For stacks that grow up, we want esp/ksp downwards

prefetch_range(kernel_stack(next) - MIN_KERNEL_STACK_FOOTPRINT,
	MIN_KERNEL_STACK_FOOTPRINT + L1_CACHE_BYTES);

BTW, for ia64 you may as well prefetch pt_regs, that is also quite
large.

#define MIN_KERNEL_STACK_FOOTPRINT (IA64_SWITCH_STACK_SIZE + IA64_PT_REGS_SIZE)

