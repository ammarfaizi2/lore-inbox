Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbTCJVoz>; Mon, 10 Mar 2003 16:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCJVoy>; Mon, 10 Mar 2003 16:44:54 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:62214 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261502AbTCJVok>; Mon, 10 Mar 2003 16:44:40 -0500
Date: Mon, 10 Mar 2003 22:54:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: Robert Love <rml@tech9.net>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small fixes in brlock.h
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303102028160.32518-100000@serv>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Linus Torvalds wrote:

> No, I don't think there are even "moved to RCU" users. It's just never 
> been used very much, since the writes are _so_ expensive (in fact, there 
> have been various live-locks on the writer side, the whole brlock thing is 
> really questionable).
> 
> It's entirely possible that the current user could be replaced by RCU 
> and/or seqlocks, and we could get rid of brlocks entirely.

I think now it's a good time to throw the patch below into the ring. :)
This new lock is an extension of the brlock and has an asynchronous and a 
synchronous mode. The synchronous mode can be used to replaced the brlock 
and does something very similiar than the nonatomic version of the brlock, 
but has a better worst case behaviour.
The asynchronous mode can be used to replaced RCU. The read lock is very 
cheap and never sleeps, but it's enough to make the quiescent stage a lot 
cheaper and more flexible to use. This means instead of calling call_rcu() 
it's enough to call brs_read_sync() and immediately after this all reader 
references are gone.
I'm meditating over this patch already some time, but I can't find a flaw. 
OTOH it looks very promising to make locking in several areas a lot 
cheaper. I have another patch laying around, which completely replaces the 
dcache_lock with this lock. Additionally I only need an asynchronous read 
lock during d_lookup and dput and is compatible with the fast walk code, 
so it should be even faster than dcache rcu, but requires of course a few 
more changes. This patch is far away from ready, as some bits are still 
missing, but I think I figured out the basic locking rules. If anyone 
wants to look at it, I'll send him a copy.

bye, Roman

diff -Nur linux-2.5.org/include/linux/brslock.h linux-2.5/include/linux/brslock.h
--- linux-2.5.org/include/linux/brslock.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5/include/linux/brslock.h	2003-03-02 02:59:24.000000000 +0100
@@ -0,0 +1,154 @@
+#ifndef __LINUX_BRSLOCK_H
+#define __LINUX_BRSLOCK_H
+
+/*
+ * 'Big Reader / Sync' read-write spinlocks.
+ *
+ * super-fast read/write locks, with write-side penalty and
+ * a synchronous and asynchronous version.
+ *
+ * (c) 2003, Roman Zippel <zippel@linux-m68k.org>
+ * Released under the terms of the GNU GPL v2.0.
+ * 
+ * This lock is based on the brlock by Ingo Molnar and David S. Miller
+ * and rcu techniques.
+ * 
+ * The asynchronous read lock only marks the critical regions, but never waits
+ * for any writer, so the writer can only detect active readers, this is
+ * sufficient for asynchronous list updates as used by the rcu mechanism, but
+ * has the advantage that after a call to brs_read_sync the update is finished
+ * and no further callback is required.
+ * The synchronous read lock extends the asynchronous lock by adding a write
+ * test, but since it's in the same cache line as the count, it's very cheap.
+ * The writer can now prevent new readers from entering the critical region
+ * and only needs to wait for other readers to leave it.
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_SMP
+
+#include <linux/cache.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+enum brslock_indices {
+	__BRS_END
+};
+
+/*
+ * This causes a link-time bug message if an
+ * invalid index is used:
+ */
+extern void __brs_lock_usage_bug(void);
+#define __brs_lock_idx_check(idx)	\
+	if (idx >= __BRS_END)		\
+		__brs_lock_usage_bug()
+
+struct brs_lock {
+	unsigned int count;
+	unsigned int wlock;
+};
+
+/*
+ * align last allocated index to the next cacheline:
+ */
+#define __BRS_IDX_MAX \
+	(((sizeof(struct brs_lock)*__BRS_END + SMP_CACHE_BYTES-1) & ~(SMP_CACHE_BYTES-1)) / sizeof(struct brs_lock))
+
+extern struct brs_lock __brslock_array[NR_CPUS][__BRS_IDX_MAX];
+extern spinlock_t __brs_write_locks[__BRS_END];
+
+extern void __brs_read_lock_sync(enum brslock_indices idx);
+extern void __brs_read_sync(enum brslock_indices idx);
+extern void __brs_write_lock_sync(enum brslock_indices idx);
+extern void __brs_write_unlock_sync(enum brslock_indices idx);
+
+static inline void __brs_read_lock_async(enum brslock_indices idx, int id)
+{
+	__brslock_array[id][idx].count++;
+	mb();
+}
+
+static inline void brs_read_lock_async(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	__brs_read_lock_async(idx, get_cpu());
+}
+
+static inline void __brs_read_unlock_async(enum brslock_indices idx, int id)
+{
+	mb();
+	__brslock_array[id][idx].count--;
+}
+
+static inline void brs_read_unlock_async(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	__brs_read_unlock_async(idx, smp_processor_id());
+	put_cpu();
+}
+
+static inline void brs_write_lock_async(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	spin_lock(&__brs_write_locks[idx]);
+}
+
+static inline void brs_write_unlock_async(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	spin_unlock(&__brs_write_locks[idx]);
+}
+
+static inline void brs_read_sync(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	__brs_read_sync(idx);
+}
+
+static inline void brs_read_lock_sync(enum brslock_indices idx)
+{
+	int id;
+restart:
+	id = get_cpu();
+	__brs_lock_idx_check(idx);
+	__brs_read_lock_async(idx, id);
+	if (unlikely(__brslock_array[id][idx].wlock)) {
+		__brs_read_lock_sync(idx);
+		goto restart;
+	}
+}
+
+static inline void brs_read_unlock_sync(enum brslock_indices idx)
+{
+	brs_read_unlock_async(idx);
+}
+
+static inline void brs_write_lock_sync(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	__brs_write_lock_sync(idx);
+}
+
+static inline void brs_write_unlock_sync(enum brslock_indices idx)
+{
+	__brs_lock_idx_check(idx);
+	__brs_write_unlock_sync(idx);
+}
+
+#else
+
+#define brs_read_lock_async(idx)	({ (void)(idx); preempt_disable(); })
+#define brs_read_unlock_async(idx)	({ (void)(idx); preempt_enable(); })
+#define brs_write_lock_async(idx)	({ (void)(idx); preempt_disable(); })
+#define brs_write_unlock_async(idx)	({ (void)(idx); preempt_enable(); })
+#define brs_read_sync(idx)		({ (void)(idx); })
+#define brs_read_lock_sync(idx)		({ (void)(idx); preempt_disable(); })
+#define brs_read_unlock_sync(idx)	({ (void)(idx); preempt_enable(); })
+#define brs_write_lock_sync(idx)	({ (void)(idx); preempt_disable(); })
+#define brs_write_unlock_sync(idx)	({ (void)(idx); preempt_enable(); })
+
+#endif	/* CONFIG_SMP */
+
+#endif /* __LINUX_BRSLOCK_H */
diff -Nur linux-2.5.org/lib/Makefile linux-2.5/lib/Makefile
--- linux-2.5.org/lib/Makefile	2003-03-10 20:38:48.000000000 +0100
+++ linux-2.5/lib/Makefile	2003-03-10 20:39:39.000000000 +0100
@@ -8,7 +8,7 @@
 
 L_TARGET := lib.a
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o brslock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o idr.o
 
diff -Nur linux-2.5.org/lib/brslock.c linux-2.5/lib/brslock.c
--- linux-2.5.org/lib/brslock.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5/lib/brslock.c	2003-03-10 19:59:42.000000000 +0100
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2003 Roman Zippel <zippel@linux-m68k.org>
+ * Released under the terms of the GNU GPL v2.0.
+ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_SMP
+
+#include <linux/brslock.h>
+
+struct brs_lock __brslock_array[NR_CPUS][__BRS_IDX_MAX];
+spinlock_t __brs_write_locks[__BRS_END];
+
+void __brs_read_lock_sync(enum brslock_indices idx)
+{
+	brs_read_unlock(idx);
+	while (__brslock_array[smp_processor_id()][idx].wlock)
+		cpu_relax();
+}
+
+void __brs_read_sync(enum brslock_indices idx)
+{
+	int mask, i, j;
+
+	mask = cpu_online_map & ~(1 << smp_processor_id());
+	while (mask) {
+		for (i = 0, j = 1; i < NR_CPUS; j <<= 1, i++) {
+			if ((mask & j) && !__brslock_array[i][idx].count)
+				mask &= ~j;
+		}
+		cpu_relax();
+	}
+}
+
+void __brs_write_lock_sync(enum brslock_indices idx)
+{
+	int i;
+
+	spin_lock(&__brs_write_locks[idx]);
+	for (i = 0; i < NR_CPUS; i++)
+		__brslock_array[i][idx].wlock = 1;
+	mb();
+	__brs_read_sync(idx);
+}
+
+void __brs_write_unlock_sync(enum brslock_indices idx)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		__brslock_array[i][idx].wlock = 0;
+	spin_unlock(&__brs_write_locks[idx]);
+}
+
+#endif /* CONFIG_SMP */


