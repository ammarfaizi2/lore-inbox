Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVANKmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVANKmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 05:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVANKmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 05:42:24 -0500
Received: from ozlabs.org ([203.10.76.45]:54200 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261943AbVANKlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 05:41:22 -0500
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <20050114095827.GA3832@in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com>
	 <1105669487.7311.11.camel@localhost.localdomain>
	 <20050114095827.GA3832@in.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 21:41:05 +1100
Message-Id: <1105699265.22689.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 15:28 +0530, Ravikiran G Thirumalai wrote:
> On Fri, Jan 14, 2005 at 01:24:47PM +1100, Rusty Russell wrote:
> > On Thu, 2005-01-13 at 14:04 +0530, Ravikiran G Thirumalai wrote:
> > > ...
> > > 
> > > The following patch re-implements the linux dynamic percpu memory allocator
> > > so that:
> > > 1. Percpu memory dereference is faster 
> > > 	- One less memory reference compared to existing simple alloc_percpu
> > > 	- As fast as with static percpu areas, one mem ref less actually.
> > 
> > Hmm, for me one point of a good dynamic per-cpu implementation is that
> > the same per_cpu_offset be used as for the static per-cpu variables.
> > This means that architectures can put it in a register.  
> 
> The allocator I have posted can be easily fixed for that.  In fact, I had a
> version which used per_cpu_offset.  My earlier experiments proved that
> pointer arithmetic is  marginally faster than the per_cpu_offset
> based version.  Also, why waste a register if we can achieve same dereference
> speeds without using a register?  But as I said, we can modify the allocator I
> posted to use per_cpu_offset.

Because we ALSO use per_cpu_offset for static per-cpu.  In fact, it
starts to make sense to make smp_processor_id a normal per-cpu variable,
since increasingly we just want "this cpu's version of the
datastructure".

ie. increasingly, this cpu's per_cpu_offset is fundamental.  The fact
that currently smp_processor_id() is fundamental and per_cpu_offset
derived warps current timings.

> As regards tiny allocations, many existing users of alloc_percpu are
> structures which are aggregations of many counters -- like the mib statistics,
> disk_stats etc.  So IMHO, dynamic percpu allocator should work well for
> both small and large objects.  I have done some user space measurements
> with my version and the allocator behaves well with both small and random sized
> objects.

See this experimental kref replacement to see what I mean.

BTW, I'm really glad someone's working on this.  Thanks!
Rusty.

Author: Rusty Russell
Status: Experimental
Depends: Percpu/kmalloc_percpu-full.patch.gz

This is an implementation of cache-friendly reference counts, using
kmalloc_percpu.

The refcounters work in two modes: the normal mode just incs and
decs a per-cpu counter.  When someone is waiting for the reference
count to hit 0, a common counter is used.

Index: linux-2.6.10-rc2-bk13-Percpu/kernel/bigref.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2-bk13-Percpu/kernel/bigref.c	2004-12-02 14:50:54.070536528 +1100
@@ -0,0 +1,98 @@
+#include <linux/bigref.h>
+#include <linux/compiler.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+#include <linux/module.h>
+#include <asm/system.h>
+
+static inline int is_slow_mode(const struct bigref *bigref)
+{
+	return atomic_read(&bigref->slow_ref) != 0;
+}
+
+/* Initialize reference to 1. */
+void bigref_init(struct bigref *bigref)
+{
+	bigref->local_ref = alloc_percpu(local_t);
+
+	/* If we can't allocate, we just stay in slow mode. */
+	if (!bigref->local_ref)
+		atomic_set(&bigref->slow_ref, 1);
+	else {
+		/* Bump any counter to 1. */
+		local_set(__get_cpu_ptr(bigref->local_ref), 1);
+		atomic_set(&bigref->slow_ref, 0);
+	}
+}
+
+/* Disown reference: next bigref_put can hit zero */
+void bigref_disown(struct bigref *bigref)
+{
+	int i, bias = 0x7FFFFFFF;
+	if (unlikely(is_slow_mode(bigref))) {
+		/* Must have been alloc fail, not double disown. */
+		BUG_ON(bigref->local_ref);
+		return;
+	}
+
+	/* Insert high number so this doesn't go to zero now. */
+	atomic_set(&bigref->slow_ref, bias);
+
+	/* Make sure everyone sees it and is using slow mode. */
+	synchronize_kernel();
+
+	/* Take away bias, and add sum of local counters. */
+	for_each_cpu(i)
+		bias -= local_read(per_cpu_ptr(bigref->local_ref, i));
+	atomic_sub(bias, &bigref->slow_ref);
+
+	/* This caller should be holding one reference. */
+	BUG_ON(atomic_read(&bigref->slow_ref) == 0);
+}
+
+/* Grab reference */
+void bigref_get(struct bigref *bigref)
+{
+	if (unlikely(is_slow_mode(bigref)))
+		atomic_inc(&bigref->slow_ref);
+	else
+		local_inc(__get_cpu_ptr(bigref->local_ref));
+}
+
+/* Drop reference */
+void bigref_put(struct bigref *bigref, void (*release)(struct bigref *bigref))
+{
+	if (unlikely(is_slow_mode(bigref))) {
+		if (atomic_dec_and_test(&bigref->slow_ref)) {
+			free_percpu(bigref->local_ref);
+			release(bigref);
+		}
+	} else
+		local_dec(__get_cpu_ptr(bigref->local_ref));
+}
+
+void bigref_destroy(struct bigref *bigref)
+{
+	if (bigref->local_ref)
+		free_percpu(bigref->local_ref);
+}
+
+/* Get current value of reference, useful for debugging info. */
+unsigned int bigref_val(struct bigref *bigref)
+{
+	unsigned int sum = 0, i;
+
+	if (unlikely(is_slow_mode(bigref)))
+		sum = atomic_read(&bigref->slow_ref);
+	else
+		for_each_cpu(i)
+			sum += local_read(per_cpu_ptr(bigref->local_ref, i));
+	return sum;
+}
+
+EXPORT_SYMBOL(bigref_init);
+EXPORT_SYMBOL(bigref_disown);
+EXPORT_SYMBOL(bigref_get);
+EXPORT_SYMBOL(bigref_put);
+EXPORT_SYMBOL(bigref_destroy);
+EXPORT_SYMBOL(bigref_val);
Index: linux-2.6.10-rc2-bk13-Percpu/include/linux/bigref.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10-rc2-bk13-Percpu/include/linux/bigref.h	2004-12-02 14:50:37.216098792 +1100
@@ -0,0 +1,76 @@
+#ifndef _LINUX_BIGREF_H
+#define _LINUX_BIGREF_H
+/* Per-cpu reference counters.  Useful when speed is important, and
+   counter will only hit zero after some explicit event (such as being
+   discarded from a list).
+
+   (C) 2003 Rusty Russell, IBM Corporation.
+*/
+#include <linux/config.h>
+#include <asm/atomic.h>
+#include <asm/local.h>
+
+#ifdef CONFIG_SMP
+struct bigref
+{
+	/* If this is zero, we use per-cpu counters. */
+	atomic_t slow_ref;
+	local_t *local_ref;
+};
+
+/* Initialize reference to 1. */
+void bigref_init(struct bigref *bigref);
+/* Disown reference: next bigref_put can hit zero */
+void bigref_disown(struct bigref *bigref);
+/* Grab reference */
+void bigref_get(struct bigref *bigref);
+/* Drop reference */
+void bigref_put(struct bigref *bigref, void (*release)(struct bigref *bigref));
+/* Destroy bigref prematurely (which might not have hit zero) */
+void bigref_destroy(struct bigref *bigref);
+
+/* Get current value of reference, useful for debugging info. */
+unsigned int bigref_val(struct bigref *bigref);
+#else  /* ... !SMP */
+struct bigref
+{
+	atomic_t ref;
+};
+
+/* Initialize reference to 1. */
+static inline void bigref_init(struct bigref *bigref)
+{
+	atomic_set(&bigref->ref, 1);
+}
+
+/* Disown reference: next bigref_put can hit zero */
+static inline void bigref_disown(struct bigref *bigref)
+{
+}
+
+/* Grab reference */
+static inline void bigref_get(struct bigref *bigref)
+{
+	atomic_inc(&bigref->ref);
+}
+
+/* Drop reference */
+static inline void bigref_put(struct bigref *bigref,
+			      void (*release)(struct bigref *bigref))
+{
+	if (atomic_dec_and_test(&bigref->ref))
+		release(bigref);
+}
+
+/* Get current value of reference, useful for debugging info. */
+static inline unsigned int bigref_val(struct bigref *bigref)
+{
+	return atomic_read(&bigref->ref);
+}
+
+static inline void bigref_destroy(struct bigref *bigref)
+{
+}
+#endif /* !SMP */
+
+#endif /* _LINUX_BIGREF_H */
Index: linux-2.6.10-rc2-bk13-Percpu/kernel/Makefile
===================================================================
--- linux-2.6.10-rc2-bk13-Percpu.orig/kernel/Makefile	2004-11-16 15:30:10.000000000 +1100
+++ linux-2.6.10-rc2-bk13-Percpu/kernel/Makefile	2004-12-02 14:50:37.216098792 +1100
@@ -11,7 +11,7 @@
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-obj-$(CONFIG_SMP) += cpu.o spinlock.o
+obj-$(CONFIG_SMP) += cpu.o spinlock.o bigref.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

