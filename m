Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVLLVtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVLLVtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVLLVtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:49:22 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:45554 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751289AbVLLVtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:49:21 -0500
Subject: Re: 2.6.15-rc5-rt1 will not compile (was Re: 2.6.14-rt15: cannot
	build with !PREEMPT_RT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: david singleton <dsingleton@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134409469.15074.1.camel@mindpipe>
References: <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe>
	 <1133230103.5640.0.camel@mindpipe> <20051129072922.GA21696@elte.hu>
	 <20051129093231.GA5028@elte.hu>  <1134090316.11053.3.camel@mindpipe>
	 <1134174330.18432.46.camel@mindpipe>  <1134409469.15074.1.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 16:49:02 -0500
Message-Id: <1134424143.24145.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 12:44 -0500, Lee Revell wrote:
> On Fri, 2005-12-09 at 19:25 -0500, Lee Revell wrote:
> > > We are unable to build a similar .config (PREEMPT_DESKTOP with soft and
> > > hardirq preemption disabled) on x86-64:
> > 
> > Here is the build output, .config attached.
> 
> Similar problem with 2.6.15-rc5-rt1:
> 
> $ make
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-x86_64
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   CC      arch/x86_64/kernel/asm-offsets.s
> In file included from include/asm/semaphore.h:48,
>                  from include/linux/sched.h:20,
>                  from arch/x86_64/kernel/asm-offsets.c:7:
> include/linux/rwsem.h:43:66: error: asm/rwsem.h: No such file or
> directory
> In file included from include/asm/semaphore.h:48,
>                  from include/linux/sched.h:20,
>                  from arch/x86_64/kernel/asm-offsets.c:7:

Looks like Ingo has a generic rwsem to work with, but if your arch turns
on CONFIG_RWSEM_XCHGADD_ALGORITHM, it will compile lib/rwsem.c which
won't compile as you've seen.

Try out this patch:  I changed the Makefile, instead of going to each
and every arch and change its Kconfig to do it properly.

-- Steve

Index: linux-2.6.15-rc5-rt1/lib/Makefile
===================================================================
--- linux-2.6.15-rc5-rt1.orig/lib/Makefile	2005-12-12 10:56:37.000000000 -0500
+++ linux-2.6.15-rc5-rt1/lib/Makefile	2005-12-12 16:23:47.000000000 -0500
@@ -19,7 +19,9 @@
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_PREEMPT_RT) += plist.o
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
+ifneq ($(CONFIG_RWSEM_GENERIC_SPINLOCK),y)
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+endif
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
Index: linux-2.6.15-rc5-rt1/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.15-rc5-rt1.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-12-12 10:56:37.000000000 -0500
+++ linux-2.6.15-rc5-rt1/arch/x86_64/kernel/x8664_ksyms.c	2005-12-12 16:27:40.000000000 -0500
@@ -165,7 +165,7 @@
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(__memcpy);
 
-#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
+#if defined(CONFIG_RWSEM_XCHGADD_ALGORITHM) && !defined(CONFIG_RWSEM_GENERIC_SPINLOCK)
 /* prototypes are wrong, these are assembly with custom calling functions */
 extern void rwsem_down_read_failed_thunk(void);
 extern void rwsem_wake_thunk(void);


