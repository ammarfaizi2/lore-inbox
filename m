Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268718AbUHTUPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268718AbUHTUPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268715AbUHTUNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:13:50 -0400
Received: from holomorphy.com ([207.189.100.168]:56266 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268692AbUHTUMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:12:54 -0400
Date: Fri, 20 Aug 2004 13:02:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040820200248.GJ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
	linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820115541.3e68c5be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>> Here's the output part way through a kernbench run:

On Fri, Aug 20, 2004 at 11:55:41AM -0700, Andrew Morton wrote:
> (This doesn't sound like the sort of workload which people would buy an
> Altix for?)

Parallel compilation is an extremely poor benchmark in general, as the
workload is incapable of being effectively scaled to system sizes, the
linking phase is inherently unparallelizable and the compilation phase
too parallelizable to actually stress anything. There is also precisely
zero relevance the benchmark has to anything real users would do.

I suspect it's largely a question of borrowing a commonly-used benchmark
as opposed to attempting to obtain rigorous, useful, or representative
results. And so we see random proddings at the VM, vfs, and scheduler.

I guess that's all smoke-blowing and truism recitation for a part of
the message I should have trimmed instead of replying to.


Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>> 27081955 ia64_pal_call_static                     141051.8490
>> 3175264 ia64_load_scratch_fpregs                 49613.5000
>> 3166434 ia64_save_scratch_fpregs                 49475.5312

On Fri, Aug 20, 2004 at 11:55:41AM -0700, Andrew Morton wrote:
> What do the above three mean?

ia64 has to partial floating point saves and restores for integer
multiplies, and the PAL calls are likely for idling. Kernel compiles
are incapable of busying significant numbers of cpus and I highly
suspect the machine is mostly idle. I found kernel compilation to be
incapable of keeping 32 cpus busy, forget 512.


>> 1603765 ia64_spinlock_contention                 16705.8854

On Fri, Aug 20, 2004 at 11:55:41AM -0700, Andrew Morton wrote:
> That's 0.04% of total non-idle CPU time.  This seems wrong.

It sounds like good news to me. The fact we boot at all instead
of spinning in perpetuity on spinlocks in interrupt context is
very good news to me, with a large added bonus of actually making
forward progress on workloads hitting global locks we've taken
steps to mitigate the locking overhead of.

I suppose the unfortunate thing is that we didn't discover anything
new at all, apart from quantifying certain things, e.g. how effective
the RCU improvements have been. IIRC that question was unanswered after
the last round, apart from (maybe) that things stopped livelocking.

I suppose another way to answer the question of what's going on is to
fiddle with ia64's implementation of profile_pc(). I suspect something
like this may reveal the offending codepaths.



Index: mm2-2.6.8.1/arch/ia64/kernel/head.S
===================================================================
--- mm2-2.6.8.1.orig/arch/ia64/kernel/head.S	2004-08-19 11:50:42.000000000 -0700
+++ mm2-2.6.8.1/arch/ia64/kernel/head.S	2004-08-20 12:45:34.181801134 -0700
@@ -950,6 +950,8 @@
 (p15)	rsm psr.i		// disable interrupts if we reenabled them
 	br.cond.sptk.few b6	// lock is now free, try to acquire
 END(ia64_spinlock_contention_pre3_4)
+.globl ia64_spinlock_contention_pre3_4_end
+ia64_spinlock_contention_pre3_4_end:
 
 #else
 
@@ -979,6 +981,8 @@
 
 	br.ret.sptk.many b6	// lock is now taken
 END(ia64_spinlock_contention)
+.globl ia64_spinlock_contention_end
+ia64_spinlock_contention_end:
 
 #endif
 
Index: mm2-2.6.8.1/arch/ia64/kernel/time.c
===================================================================
--- mm2-2.6.8.1.orig/arch/ia64/kernel/time.c	2004-08-19 11:51:00.000000000 -0700
+++ mm2-2.6.8.1/arch/ia64/kernel/time.c	2004-08-20 12:46:34.850745704 -0700
@@ -186,6 +186,45 @@
 
 EXPORT_SYMBOL(do_gettimeofday);
 
+#ifdef CONFIG_SMP
+#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+extern char ia64_spinlock_contention_pre3_4,
+					ia64_spinlock_contention_pre3_4_end;
+
+static inline unsigned long __profile_pc(struct pt_regs *regs)
+{
+	unsigned long ip = instruction_pointer(regs);
+
+	if (ip >= (unsigned long)&ia64_spinlock_contention_pre3_4 &&
+		ip <= (unsigned long)&ia64_spinlock_contention_pre3_4_end)
+		return regs->b0;
+	else
+		return ip;
+}
+#else
+
+extern char ia64_spinlock_contention, ia64_spinlock_contention_end;
+
+static inline unsigned long __profile_pc(struct pt_regs *regs)
+{
+	unsigned long ip = instruction_pointer(regs);
+
+	if (ip >= (unsigned long)&ia64_spinlock_contention &&
+			ip <= (unsigned long)&ia64_spinlock_contention_end)
+		return regs->b0;
+	else
+		return ip;
+}
+#endif
+
+unsigned long profile_pc(struct pt_regs *regs)
+{
+        unsigned long ip = __profile_pc(regs);
+
+        return (ip & ~3UL) + ((ip & 3UL) << 2);
+}
+#endif
+
 static irqreturn_t
 timer_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
Index: mm2-2.6.8.1/include/asm-ia64/ptrace.h
===================================================================
--- mm2-2.6.8.1.orig/include/asm-ia64/ptrace.h	2004-08-19 11:51:00.000000000 -0700
+++ mm2-2.6.8.1/include/asm-ia64/ptrace.h	2004-08-20 12:39:55.577313095 -0700
@@ -232,12 +232,15 @@
 /* Conserve space in histogram by encoding slot bits in address
  * bits 2 and 3 rather than bits 0 and 1.
  */
+#ifdef CONFIG_SMP
+unsigned long profile_pc(struct pt_regs *);
+#else
 #define profile_pc(regs)						\
 ({									\
 	unsigned long __ip = instruction_pointer(regs);			\
 	(__ip & ~3UL) + ((__ip & 3UL) << 2);				\
 })
-
+#endif
   /* given a pointer to a task_struct, return the user's pt_regs */
 # define ia64_task_regs(t)		(((struct pt_regs *) ((char *) (t) + IA64_STK_OFFSET)) - 1)
 # define ia64_psr(regs)			((struct ia64_psr *) &(regs)->cr_ipsr)
