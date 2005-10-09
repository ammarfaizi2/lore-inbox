Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVJIQW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVJIQW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVJIQW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:22:57 -0400
Received: from mail3.uklinux.net ([80.84.72.33]:13271 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750800AbVJIQW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:22:57 -0400
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Message-Id: <E1EOe2Z-000187-Ow@localhost.localdomain>
Date: Sun, 09 Oct 2005 17:28:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 7 Steven Rostedt wrote:

>Here's an addon patch to my last one.  I don't know x86_64 very well, but
>I believe the the asm is pretty much the same, so this patch removes the
>check for __i386__ and also defines STACK_WARN.

>Index: linux-rt-quilt/include/asm-x86_64/page.h
>===================================================================
>--- linux-rt-quilt.orig/include/asm-x86_64/page.h	2005-10-06 08:04:00.000000000 -0400
>+++ linux-rt-quilt/include/asm-x86_64/page.h	2005-10-07 15:34:20.000000000 -0400
>@@ -21,6 +21,8 @@
> #endif
> #define CURRENT_MASK (~(THREAD_SIZE-1))
>
>+#define STACK_WARN             (THREAD_SIZE/8)
>+
> #define LARGE_PAGE_MASK (~(LARGE_PAGE_SIZE-1))
> #define LARGE_PAGE_SIZE (1UL << PMD_SHIFT)
>
>Index: linux-rt-quilt/kernel/latency.c
>===================================================================
>--- linux-rt-quilt.orig/kernel/latency.c	2005-10-06 08:04:56.000000000 -0400
>+++ linux-rt-quilt/kernel/latency.c	2005-10-07 15:31:20.000000000 -0400
>@@ -377,7 +377,8 @@
> 	atomic_inc(&tr->disabled);
>
> 	/* Debugging check for stack overflow: is there less than 1KB free? */
>-#ifdef __i386__
>+#if 1 // def __i386__
>+	/* Hopefully this works on x86_64!  */
> 	__asm__ __volatile__("andl %%esp,%0" :
> 				"=r" (stack_left) : "0" (THREAD_SIZE - 1));
> #else

Steve, thanks for these patches. I got it to compile with 2.6.14-rc3-rt12
but had to change the assembly lines in (patched) latency.c to

__asm__ __volatile__("and %%rsp,%0" :
 				"=r" (stack_left) : "0" (THREAD_SIZE - 1));

ie. `and' instead of `andl' and `%%rsp' instead of `%%esp'.
Somebody who understands x86_64 assembly better than I do should probably check 
this before anyone tries using it.
While I was at it I changed a printk arg in line 335 of (patched) latency.c - 
I think the last %d should be %ld, ie. 

printk("| new stack-footprint maximum: %s/%d, %ld bytes (out of %ld bytes).\n",
	worst_stack_comm, worst_stack_pid, MAX_STACK-worst_stack_left, MAX_STACK); 

John
