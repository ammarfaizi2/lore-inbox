Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVIMQEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVIMQEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVIMQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:04:20 -0400
Received: from serv01.siteground.net ([70.85.91.68]:31378 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964832AbVIMQET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:04:19 -0400
Date: Tue, 13 Sep 2005 09:04:12 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 6/11] mm: Bigrefs -- distributed refcounters
Message-ID: <20050913160412.GH3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Distributed refcounting infrastructure patch originally by Rusty Russel.  
http://lkml.org/lkml/2005/1/14/47
Changes from the original:
- Rediffed and changed to use new alloc_percpu interface
- Added bigref_set for some applications which initialize refcounters to 0
- Donot call release at bigref_put if NULL
- Use synchronize_sched instead of synchronize_kernel

Signed-off-by: Rusty Russel <rusty@rustcorp.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>


Index: alloc_percpu-2.6.13-rc7/include/linux/bigref.h
===================================================================
--- alloc_percpu-2.6.13-rc7.orig/include/linux/bigref.h	2005-08-28 09:48:29.174802240 -0700
+++ alloc_percpu-2.6.13-rc7/include/linux/bigref.h	2005-08-29 08:28:41.000000000 -0700
@@ -0,0 +1,84 @@
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
+/* Initialize reference to val */
+void bigref_set(struct bigref *bigref, int val);
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
+/* Initialize reference to val */
+static inline void bigref_set(struct bigref *bigref, int val)
+{
+	atomic_set(&bigref->ref, val);
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
Index: alloc_percpu-2.6.13-rc7/kernel/Makefile
===================================================================
--- alloc_percpu-2.6.13-rc7.orig/kernel/Makefile	2005-08-29 08:28:30.000000000 -0700
+++ alloc_percpu-2.6.13-rc7/kernel/Makefile	2005-08-29 08:28:41.000000000 -0700
@@ -11,7 +11,7 @@
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-obj-$(CONFIG_SMP) += cpu.o spinlock.o
+obj-$(CONFIG_SMP) += cpu.o spinlock.o bigref.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
Index: alloc_percpu-2.6.13-rc7/kernel/bigref.c
===================================================================
--- alloc_percpu-2.6.13-rc7.orig/kernel/bigref.c	2005-08-28 09:48:29.174802240 -0700
+++ alloc_percpu-2.6.13-rc7/kernel/bigref.c	2005-08-29 08:29:41.000000000 -0700
@@ -0,0 +1,112 @@
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
+	bigref->local_ref = alloc_percpu(local_t, GFP_KERNEL);
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
+/* Initialize reference to val */
+void bigref_set(struct bigref *bigref, int val)
+{
+
+	if (!bigref->local_ref)
+		atomic_set(&bigref->slow_ref, val);
+	else {
+		/* Bump any counter to val. */
+		local_set(__get_cpu_ptr(bigref->local_ref), val);
+		atomic_set(&bigref->slow_ref, 0);
+	}
+}
+
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
+	synchronize_sched();
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
+			if (release)
+				release(bigref);
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
