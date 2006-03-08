Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWCHVcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWCHVcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWCHVcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:32:50 -0500
Received: from mx.pathscale.com ([64.160.42.68]:7913 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932533AbWCHVct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:32:49 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] Define flush_wc, a way to flush write combining store buffers
X-Mercurial-Node: e27c8e0061e03594b3e1e5603c7cc220e68f6380
Message-Id: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
Date: Wed,  8 Mar 2006 13:31:41 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, ak@suse.de, paulus@samba.org, benh@kernel.crashing.org,
       bcrl@kvack.org
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some circumstances, a CPU may perform stores to memory in non-program
order, or held in on-chip store buffers for a potentially long time.
These kinds of circumstances include:

- Stores to a PCI MMIO region that has write combining enabled

- Use of non-temporal store instructions

- The CPU's memory model permitting weak store ordering

This patch introduces a new macro, flush_wc(), that flushes any pending
stores from the local CPU's write combining store buffers, if the CPU has
such a capability.  If the CPU doesn't provide explicit control over write
combining, flush_wc() is simply an alias for wmb().  Here is an example:

    store A
    store B
    store C
    flush_wc()
    store D
    store E
    flush_wc()

flush_wc() says nothing about whether {A,B,C} may be reordered with
respect to each other, or whether {D,E} may, but it guarantees that
{A,B,C} will make it off-CPU before {D,E}.  An arch that implements
flush_wc() should make the stores occur immediately, if possible.

In the case of writes to remote NUMA memory or PCI MMIO space, a
bridge chip may still hold on to stores after they've been issued by
the CPU. Thus flush_wc() makes no guarantees regarding the visibility
of stores to other CPUs, remote memory, or PCI devices.

The intention is that flush_wc() will typically be used for
latency-sensitive MMIO writes where the full cost of guaranteeing that
the writes have made it all the way to their target is not necessary
or desirable.

It is implemented by way of a new header file, <linux/system.h>.
This header can be a site for oft-replicated code from <asm-*/system.h>,
but isn't just yet.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r c89918da5f7b -r e27c8e0061e0 include/asm-i386/system.h
--- a/include/asm-i386/system.h	Sat Feb 25 08:01:07 2006 +0800
+++ b/include/asm-i386/system.h	Wed Mar  8 13:28:29 2006 -0800
@@ -502,6 +502,12 @@ struct alt_instr {
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
 
+/*
+ * Flush the CPU's write combining store buffers.
+ */
+#define flush_wc() alternative("lock; addl $0,0(%%esp)", "sfence", \
+			       X86_FEATURE_XMM)
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
diff -r c89918da5f7b -r e27c8e0061e0 include/asm-powerpc/system.h
--- a/include/asm-powerpc/system.h	Sat Feb 25 08:01:07 2006 +0800
+++ b/include/asm-powerpc/system.h	Wed Mar  8 13:28:29 2006 -0800
@@ -53,6 +53,12 @@
 #define smp_wmb()	barrier()
 #define smp_read_barrier_depends()	do { } while(0)
 #endif /* CONFIG_SMP */
+
+/*
+ * Guarantee store/store ordering.  On some arches, this flushes the CPU's
+ * write combining store buffers.
+ */
+#define flush_wc()	__asm__ __volatile__ ("eieio" : : : "memory")
 
 struct task_struct;
 struct pt_regs;
diff -r c89918da5f7b -r e27c8e0061e0 include/asm-x86_64/system.h
--- a/include/asm-x86_64/system.h	Sat Feb 25 08:01:07 2006 +0800
+++ b/include/asm-x86_64/system.h	Wed Mar  8 13:28:29 2006 -0800
@@ -330,6 +330,11 @@ static inline unsigned long __cmpxchg(vo
 #define set_mb(var, value) do { (void) xchg(&var, value); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
+/*
+ * Flush the CPU's write combining store buffers.
+ */
+#define flush_wc()	asm volatile("sfence" ::: "memory")
+
 #define warn_if_not_ulong(x) do { unsigned long foo; (void) (&(x) == &foo); } while (0)
 
 /* interrupt control.. */
diff -r c89918da5f7b -r e27c8e0061e0 include/linux/system.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/include/linux/system.h	Wed Mar  8 13:28:29 2006 -0800
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2006 PathScale, Inc.  All Rights Reserved.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+#ifndef _LINUX_SYSTEM_H
+#define _LINUX_SYSTEM_H
+
+#include <asm/system.h>
+
+#ifndef flush_wc
+#define flush_wc() wmb()
+#endif
+
+#endif /* _LINUX_SYSTEM_H */
