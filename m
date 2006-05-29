Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWE2Vjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWE2Vjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWE2VZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54226 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751336AbWE2VYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:55 -0400
Date: Mon, 29 May 2006 23:25:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 23/61] lock validator: core
Message-ID: <20060529212501.GW3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

lock validator core changes. Not enabled yet.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/linux/init_task.h      |    1 
 include/linux/lockdep.h        |  280 ++++
 include/linux/sched.h          |   12 
 include/linux/trace_irqflags.h |   13 
 init/main.c                    |   16 
 kernel/Makefile                |    1 
 kernel/fork.c                  |    5 
 kernel/irq/manage.c            |    6 
 kernel/lockdep.c               | 2633 +++++++++++++++++++++++++++++++++++++++++
 kernel/lockdep_internals.h     |   93 +
 kernel/module.c                |    3 
 lib/Kconfig.debug              |    2 
 lib/locking-selftest.c         |    4 
 13 files changed, 3064 insertions(+), 5 deletions(-)

Index: linux/include/linux/init_task.h
===================================================================
--- linux.orig/include/linux/init_task.h
+++ linux/include/linux/init_task.h
@@ -134,6 +134,7 @@ extern struct group_info init_groups;
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
  	INIT_TRACE_IRQFLAGS						\
+ 	INIT_LOCKDEP							\
 }
 
 
Index: linux/include/linux/lockdep.h
===================================================================
--- /dev/null
+++ linux/include/linux/lockdep.h
@@ -0,0 +1,280 @@
+/*
+ * Runtime locking correctness validator
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * see Documentation/lockdep-design.txt for more details.
+ */
+#ifndef __LINUX_LOCKDEP_H
+#define __LINUX_LOCKDEP_H
+
+#include <linux/linkage.h>
+#include <linux/list.h>
+#include <linux/debug_locks.h>
+#include <linux/stacktrace.h>
+
+#ifdef CONFIG_LOCKDEP
+
+/*
+ * Lock-type usage-state bits:
+ */
+enum lock_usage_bit
+{
+	LOCK_USED = 0,
+	LOCK_USED_IN_HARDIRQ,
+	LOCK_USED_IN_SOFTIRQ,
+	LOCK_ENABLED_SOFTIRQS,
+	LOCK_ENABLED_HARDIRQS,
+	LOCK_USED_IN_HARDIRQ_READ,
+	LOCK_USED_IN_SOFTIRQ_READ,
+	LOCK_ENABLED_SOFTIRQS_READ,
+	LOCK_ENABLED_HARDIRQS_READ,
+	LOCK_USAGE_STATES
+};
+
+/*
+ * Usage-state bitmasks:
+ */
+#define LOCKF_USED			(1 << LOCK_USED)
+#define LOCKF_USED_IN_HARDIRQ		(1 << LOCK_USED_IN_HARDIRQ)
+#define LOCKF_USED_IN_SOFTIRQ		(1 << LOCK_USED_IN_SOFTIRQ)
+#define LOCKF_ENABLED_HARDIRQS		(1 << LOCK_ENABLED_HARDIRQS)
+#define LOCKF_ENABLED_SOFTIRQS		(1 << LOCK_ENABLED_SOFTIRQS)
+
+#define LOCKF_ENABLED_IRQS (LOCKF_ENABLED_HARDIRQS | LOCKF_ENABLED_SOFTIRQS)
+#define LOCKF_USED_IN_IRQ (LOCKF_USED_IN_HARDIRQ | LOCKF_USED_IN_SOFTIRQ)
+
+#define LOCKF_USED_IN_HARDIRQ_READ	(1 << LOCK_USED_IN_HARDIRQ_READ)
+#define LOCKF_USED_IN_SOFTIRQ_READ	(1 << LOCK_USED_IN_SOFTIRQ_READ)
+#define LOCKF_ENABLED_HARDIRQS_READ	(1 << LOCK_ENABLED_HARDIRQS_READ)
+#define LOCKF_ENABLED_SOFTIRQS_READ	(1 << LOCK_ENABLED_SOFTIRQS_READ)
+
+#define LOCKF_ENABLED_IRQS_READ \
+		(LOCKF_ENABLED_HARDIRQS_READ | LOCKF_ENABLED_SOFTIRQS_READ)
+#define LOCKF_USED_IN_IRQ_READ \
+		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
+
+#define MAX_LOCKDEP_SUBTYPES		8UL
+
+/*
+ * Lock-types are keyed via unique addresses, by embedding the
+ * locktype-key into the kernel (or module) .data section. (For
+ * static locks we use the lock address itself as the key.)
+ */
+struct lockdep_subtype_key {
+	char __one_byte;
+} __attribute__ ((__packed__));
+
+struct lockdep_type_key {
+	struct lockdep_subtype_key	subkeys[MAX_LOCKDEP_SUBTYPES];
+};
+
+/*
+ * The lock-type itself:
+ */
+struct lock_type {
+	/*
+	 * type-hash:
+	 */
+	struct list_head		hash_entry;
+
+	/*
+	 * global list of all lock-types:
+	 */
+	struct list_head		lock_entry;
+
+	struct lockdep_subtype_key	*key;
+	unsigned int			subtype;
+
+	/*
+	 * IRQ/softirq usage tracking bits:
+	 */
+	unsigned long			usage_mask;
+	struct stack_trace		usage_traces[LOCK_USAGE_STATES];
+
+	/*
+	 * These fields represent a directed graph of lock dependencies,
+	 * to every node we attach a list of "forward" and a list of
+	 * "backward" graph nodes.
+	 */
+	struct list_head		locks_after, locks_before;
+
+	/*
+	 * Generation counter, when doing certain types of graph walking,
+	 * to ensure that we check one node only once:
+	 */
+	unsigned int			version;
+
+	/*
+	 * Statistics counter:
+	 */
+	unsigned long			ops;
+
+	const char			*name;
+	int				name_version;
+};
+
+/*
+ * Map the lock object (the lock instance) to the lock-type object.
+ * This is embedded into specific lock instances:
+ */
+struct lockdep_map {
+	struct lockdep_type_key		*key;
+	struct lock_type		*type[MAX_LOCKDEP_SUBTYPES];
+	const char			*name;
+};
+
+/*
+ * Every lock has a list of other locks that were taken after it.
+ * We only grow the list, never remove from it:
+ */
+struct lock_list {
+	struct list_head		entry;
+	struct lock_type		*type;
+	struct stack_trace		trace;
+};
+
+/*
+ * We record lock dependency chains, so that we can cache them:
+ */
+struct lock_chain {
+	struct list_head		entry;
+	u64				chain_key;
+};
+
+struct held_lock {
+	/*
+	 * One-way hash of the dependency chain up to this point. We
+	 * hash the hashes step by step as the dependency chain grows.
+	 *
+	 * We use it for dependency-caching and we skip detection
+	 * passes and dependency-updates if there is a cache-hit, so
+	 * it is absolutely critical for 100% coverage of the validator
+	 * to have a unique key value for every unique dependency path
+	 * that can occur in the system, to make a unique hash value
+	 * as likely as possible - hence the 64-bit width.
+	 *
+	 * The task struct holds the current hash value (initialized
+	 * with zero), here we store the previous hash value:
+	 */
+	u64				prev_chain_key;
+	struct lock_type		*type;
+	unsigned long			acquire_ip;
+	struct lockdep_map		*instance;
+
+	/*
+	 * The lock-stack is unified in that the lock chains of interrupt
+	 * contexts nest ontop of process context chains, but we 'separate'
+	 * the hashes by starting with 0 if we cross into an interrupt
+	 * context, and we also keep do not add cross-context lock
+	 * dependencies - the lock usage graph walking covers that area
+	 * anyway, and we'd just unnecessarily increase the number of
+	 * dependencies otherwise. [Note: hardirq and softirq contexts
+	 * are separated from each other too.]
+	 *
+	 * The following field is used to detect when we cross into an
+	 * interrupt context:
+	 */
+	int				irq_context;
+	int				trylock;
+	int				read;
+	int				hardirqs_off;
+};
+
+/*
+ * Initialization, self-test and debugging-output methods:
+ */
+extern void lockdep_init(void);
+extern void lockdep_info(void);
+extern void lockdep_reset(void);
+extern void lockdep_reset_lock(struct lockdep_map *lock);
+extern void lockdep_free_key_range(void *start, unsigned long size);
+
+extern void print_lock_types(void);
+extern void lockdep_print_held_locks(struct task_struct *task);
+
+/*
+ * These methods are used by specific locking variants (spinlocks,
+ * rwlocks, mutexes and rwsems) to pass init/acquire/release events
+ * to lockdep:
+ */
+
+extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
+			     struct lockdep_type_key *key);
+
+extern void lockdep_acquire(struct lockdep_map *lock, unsigned int subtype,
+			    int trylock, int read, unsigned long ip);
+
+extern void lockdep_release(struct lockdep_map *lock, int nested,
+			    unsigned long ip);
+
+# define INIT_LOCKDEP				.lockdep_recursion = 0,
+
+extern void early_boot_irqs_off(void);
+extern void early_boot_irqs_on(void);
+
+#else /* LOCKDEP */
+# define lockdep_init()				do { } while (0)
+# define lockdep_info()				do { } while (0)
+# define print_lock_types()			do { } while (0)
+# define lockdep_print_held_locks(task)		do { (void)(task); } while (0)
+# define lockdep_init_map(lock, name, key)	do { } while (0)
+# define INIT_LOCKDEP
+# define lockdep_reset()		do { debug_locks = 1; } while (0)
+# define lockdep_free_key_range(start, size)	do { } while (0)
+# define early_boot_irqs_off()			do { } while (0)
+# define early_boot_irqs_on()			do { } while (0)
+/*
+ * The type key takes no space if lockdep is disabled:
+ */
+struct lockdep_type_key { };
+#endif /* !LOCKDEP */
+
+/*
+ * For trivial one-depth nesting of a lock-type, the following
+ * global define can be used. (Subsystems with multiple levels
+ * of nesting should define their own lock-nesting subtypes.)
+ */
+#define SINGLE_DEPTH_NESTING			1
+
+/*
+ * Map the dependency ops to NOP or to real lockdep ops, depending
+ * on the per lock-type debug mode:
+ */
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+# define spin_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
+# define spin_release(l, n, i)			lockdep_release(l, n, i)
+#else
+# define spin_acquire(l, s, t, i)		do { } while (0)
+# define spin_release(l, n, i)			do { } while (0)
+#endif
+
+#ifdef CONFIG_PROVE_RW_LOCKING
+# define rwlock_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
+# define rwlock_acquire_read(l, s, t, i)	lockdep_acquire(l, s, t, 1, i)
+# define rwlock_release(l, n, i)		lockdep_release(l, n, i)
+#else
+# define rwlock_acquire(l, s, t, i)		do { } while (0)
+# define rwlock_acquire_read(l, s, t, i)	do { } while (0)
+# define rwlock_release(l, n, i)		do { } while (0)
+#endif
+
+#ifdef CONFIG_PROVE_MUTEX_LOCKING
+# define mutex_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
+# define mutex_release(l, n, i)			lockdep_release(l, n, i)
+#else
+# define mutex_acquire(l, s, t, i)		do { } while (0)
+# define mutex_release(l, n, i)			do { } while (0)
+#endif
+
+#ifdef CONFIG_PROVE_RWSEM_LOCKING
+# define rwsem_acquire(l, s, t, i)		lockdep_acquire(l, s, t, 0, i)
+# define rwsem_acquire_read(l, s, t, i)		lockdep_acquire(l, s, t, -1, i)
+# define rwsem_release(l, n, i)			lockdep_release(l, n, i)
+#else
+# define rwsem_acquire(l, s, t, i)		do { } while (0)
+# define rwsem_acquire_read(l, s, t, i)		do { } while (0)
+# define rwsem_release(l, n, i)			do { } while (0)
+#endif
+
+#endif /* __LINUX_LOCKDEP_H */
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -931,6 +931,13 @@ struct task_struct {
 	int hardirq_context;
 	int softirq_context;
 #endif
+#ifdef CONFIG_LOCKDEP
+# define MAX_LOCK_DEPTH 30UL
+	u64 curr_chain_key;
+	int lockdep_depth;
+	struct held_lock held_locks[MAX_LOCK_DEPTH];
+#endif
+	unsigned int lockdep_recursion;
 
 /* journalling filesystem info */
 	void *journal_info;
@@ -1350,6 +1357,11 @@ static inline void task_lock(struct task
 	spin_lock(&p->alloc_lock);
 }
 
+static inline void task_lock_free(struct task_struct *p)
+{
+	spin_lock_nested(&p->alloc_lock, SINGLE_DEPTH_NESTING);
+}
+
 static inline void task_unlock(struct task_struct *p)
 {
 	spin_unlock(&p->alloc_lock);
Index: linux/include/linux/trace_irqflags.h
===================================================================
--- linux.orig/include/linux/trace_irqflags.h
+++ linux/include/linux/trace_irqflags.h
@@ -66,7 +66,18 @@
 		}						\
 	} while (0)
 
-#define local_irq_enable_in_hardirq()	local_irq_enable()
+/*
+ * On lockdep we dont want to enable hardirqs in hardirq
+ * context. NOTE: in theory this might break fragile code
+ * that relies on hardirq delivery - in practice we dont
+ * seem to have such places left. So the only effect should
+ * be slightly increased irqs-off latencies.
+ */
+#ifdef CONFIG_LOCKDEP
+# define local_irq_enable_in_hardirq()	do { } while (0)
+#else
+# define local_irq_enable_in_hardirq()	local_irq_enable()
+#endif
 
 #define safe_halt()						\
 	do {							\
Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -54,6 +54,7 @@
 #include <linux/root_dev.h>
 #include <linux/buffer_head.h>
 #include <linux/debug_locks.h>
+#include <linux/lockdep.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -80,6 +81,7 @@
 
 static int init(void *);
 
+extern void early_init_irq_lock_type(void);
 extern void init_IRQ(void);
 extern void fork_init(unsigned long);
 extern void mca_init(void);
@@ -461,6 +463,17 @@ asmlinkage void __init start_kernel(void
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
+
+	/*
+	 * Need to run as early as possible, to initialize the
+	 * lockdep hash:
+	 */
+	lockdep_init();
+
+	local_irq_disable();
+	early_boot_irqs_off();
+	early_init_irq_lock_type();
+
 /*
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
@@ -512,8 +525,11 @@ asmlinkage void __init start_kernel(void
 	if (panic_later)
 		panic(panic_later, panic_param);
 	profile_init();
+	early_boot_irqs_on();
 	local_irq_enable();
 
+	lockdep_info();
+
 	/*
 	 * Need to run this when irqs are enabled, because it wants
 	 * to self-test [hard/soft]-irqs on/off lock inversion bugs
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -12,6 +12,7 @@ obj-y     = sched.o fork.o exec_domain.o
 
 obj-y += time/
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
+obj-$(CONFIG_LOCKDEP) += lockdep.o
 obj-$(CONFIG_FUTEX) += futex.o
 ifeq ($(CONFIG_COMPAT),y)
 obj-$(CONFIG_FUTEX) += futex_compat.o
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c
+++ linux/kernel/fork.c
@@ -1049,6 +1049,11 @@ static task_t *copy_process(unsigned lon
  	}
 	mpol_fix_fork_child_flag(p);
 #endif
+#ifdef CONFIG_LOCKDEP
+	p->lockdep_depth = 0; /* no locks held yet */
+	p->curr_chain_key = 0;
+	p->lockdep_recursion = 0;
+#endif
 
 	rt_mutex_init_task(p);
 
Index: linux/kernel/irq/manage.c
===================================================================
--- linux.orig/kernel/irq/manage.c
+++ linux/kernel/irq/manage.c
@@ -406,6 +406,12 @@ int request_irq(unsigned int irq,
 		   immediately, so let's make sure....
 		   We do this before actually registering it, to make sure that a 'real'
 		   IRQ doesn't run in parallel with our fake. */
+#ifdef CONFIG_LOCKDEP
+		/*
+		 * Lockdep wants atomic interrupt handlers:
+		 */
+		irqflags |= SA_INTERRUPT;
+#endif
 		if (irqflags & SA_INTERRUPT) {
 			unsigned long flags;
 
Index: linux/kernel/lockdep.c
===================================================================
--- /dev/null
+++ linux/kernel/lockdep.c
@@ -0,0 +1,2633 @@
+/*
+ * kernel/lockdep.c
+ *
+ * Runtime locking correctness validator
+ *
+ * Started by Ingo Molnar:
+ *
+ *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ *
+ * this code maps all the lock dependencies as they occur in a live kernel
+ * and will warn about the following types of locking bugs:
+ *
+ * - lock inversion scenarios
+ * - circular lock dependencies
+ * - hardirq/softirq safe/unsafe locking bugs
+ *
+ * Bugs are reported even if the current locking scenario does not cause
+ * any deadlock at this point.
+ *
+ * I.e. if anytime in the past two locks were taken in a different order,
+ * even if it happened for another task, even if those were different
+ * locks (but of the same type as this lock), this code will detect it.
+ *
+ * Thanks to Arjan van de Ven for coming up with the initial idea of
+ * mapping lock dependencies runtime.
+ */
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/interrupt.h>
+#include <linux/stacktrace.h>
+#include <linux/debug_locks.h>
+#include <linux/trace_irqflags.h>
+
+#include <asm/sections.h>
+
+#include "lockdep_internals.h"
+
+/*
+ * hash_lock: protects the lockdep hashes and type/list/hash allocators.
+ *
+ * This is one of the rare exceptions where it's justified
+ * to use a raw spinlock - we really dont want the spinlock
+ * code to recurse back into the lockdep code.
+ */
+static raw_spinlock_t hash_lock = (raw_spinlock_t)__RAW_SPIN_LOCK_UNLOCKED;
+
+static int lockdep_initialized;
+
+unsigned long nr_list_entries;
+static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
+
+/*
+ * Allocate a lockdep entry. (assumes hash_lock held, returns
+ * with NULL on failure)
+ */
+static struct lock_list *alloc_list_entry(void)
+{
+	if (nr_list_entries >= MAX_LOCKDEP_ENTRIES) {
+		__raw_spin_unlock(&hash_lock);
+		debug_locks_off();
+		printk("BUG: MAX_LOCKDEP_ENTRIES too low!\n");
+		printk("turning off the locking correctness validator.\n");
+		return NULL;
+	}
+	return list_entries + nr_list_entries++;
+}
+
+/*
+ * All data structures here are protected by the global debug_lock.
+ *
+ * Mutex key structs only get allocated, once during bootup, and never
+ * get freed - this significantly simplifies the debugging code.
+ */
+unsigned long nr_lock_types;
+static struct lock_type lock_types[MAX_LOCKDEP_KEYS];
+
+/*
+ * We keep a global list of all lock types. The list only grows,
+ * never shrinks. The list is only accessed with the lockdep
+ * spinlock lock held.
+ */
+LIST_HEAD(all_lock_types);
+
+/*
+ * The lockdep types are in a hash-table as well, for fast lookup:
+ */
+#define TYPEHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
+#define TYPEHASH_SIZE		(1UL << TYPEHASH_BITS)
+#define TYPEHASH_MASK		(TYPEHASH_SIZE - 1)
+#define __typehashfn(key)	((((unsigned long)key >> TYPEHASH_BITS) + (unsigned long)key) & TYPEHASH_MASK)
+#define typehashentry(key)	(typehash_table + __typehashfn((key)))
+
+static struct list_head typehash_table[TYPEHASH_SIZE];
+
+unsigned long nr_lock_chains;
+static struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
+
+/*
+ * We put the lock dependency chains into a hash-table as well, to cache
+ * their existence:
+ */
+#define CHAINHASH_BITS		(MAX_LOCKDEP_CHAINS_BITS-1)
+#define CHAINHASH_SIZE		(1UL << CHAINHASH_BITS)
+#define CHAINHASH_MASK		(CHAINHASH_SIZE - 1)
+#define __chainhashfn(chain) \
+		(((chain >> CHAINHASH_BITS) + chain) & CHAINHASH_MASK)
+#define chainhashentry(chain)	(chainhash_table + __chainhashfn((chain)))
+
+static struct list_head chainhash_table[CHAINHASH_SIZE];
+
+/*
+ * The hash key of the lock dependency chains is a hash itself too:
+ * it's a hash of all locks taken up to that lock, including that lock.
+ * It's a 64-bit hash, because it's important for the keys to be
+ * unique.
+ */
+#define iterate_chain_key(key1, key2) \
+	(((key1) << MAX_LOCKDEP_KEYS_BITS/2) ^ \
+	((key1) >> (64-MAX_LOCKDEP_KEYS_BITS/2)) ^ \
+	(key2))
+
+/*
+ * Debugging switches:
+ */
+#define LOCKDEP_OFF		0
+
+#define VERBOSE			0
+
+#if VERBOSE
+# define HARDIRQ_VERBOSE	1
+# define SOFTIRQ_VERBOSE	1
+#else
+# define HARDIRQ_VERBOSE	0
+# define SOFTIRQ_VERBOSE	0
+#endif
+
+#if VERBOSE || HARDIRQ_VERBOSE || SOFTIRQ_VERBOSE
+/*
+ * Quick filtering for interesting events:
+ */
+static int type_filter(struct lock_type *type)
+{
+	if (type->name_version == 2 &&
+			!strcmp(type->name, "xfrm_state_afinfo_lock"))
+		return 1;
+	if ((type->name_version == 2 || type->name_version == 4) &&
+			!strcmp(type->name, "&mc->mca_lock"))
+		return 1;
+	return 0;
+}
+#endif
+
+static int verbose(struct lock_type *type)
+{
+#if VERBOSE
+	return type_filter(type);
+#endif
+	return 0;
+}
+
+static int hardirq_verbose(struct lock_type *type)
+{
+#if HARDIRQ_VERBOSE
+	return type_filter(type);
+#endif
+	return 0;
+}
+
+static int softirq_verbose(struct lock_type *type)
+{
+#if SOFTIRQ_VERBOSE
+	return type_filter(type);
+#endif
+	return 0;
+}
+
+/*
+ * Stack-trace: tightly packed array of stack backtrace
+ * addresses. Protected by the hash_lock.
+ */
+unsigned long nr_stack_trace_entries;
+static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
+
+static int save_trace(struct stack_trace *trace)
+{
+	trace->nr_entries = 0;
+	trace->max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries;
+	trace->entries = stack_trace + nr_stack_trace_entries;
+
+	save_stack_trace(trace, NULL, 0, 3);
+
+	trace->max_entries = trace->nr_entries;
+
+	nr_stack_trace_entries += trace->nr_entries;
+	if (DEBUG_WARN_ON(nr_stack_trace_entries > MAX_STACK_TRACE_ENTRIES))
+		return 0;
+
+	if (nr_stack_trace_entries == MAX_STACK_TRACE_ENTRIES) {
+		__raw_spin_unlock(&hash_lock);
+		if (debug_locks_off()) {
+			printk("BUG: MAX_STACK_TRACE_ENTRIES too low!\n");
+			printk("turning off the locking correctness validator.\n");
+			dump_stack();
+		}
+		return 0;
+	}
+
+	return 1;
+}
+
+unsigned int nr_hardirq_chains;
+unsigned int nr_softirq_chains;
+unsigned int nr_process_chains;
+unsigned int max_lockdep_depth;
+unsigned int max_recursion_depth;
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+/*
+ * We cannot printk in early bootup code. Not even early_printk()
+ * might work. So we mark any initialization errors and printk
+ * about it later on, in lockdep_info().
+ */
+int lockdep_init_error;
+
+/*
+ * Various lockdep statistics:
+ */
+atomic_t chain_lookup_hits;
+atomic_t chain_lookup_misses;
+atomic_t hardirqs_on_events;
+atomic_t hardirqs_off_events;
+atomic_t redundant_hardirqs_on;
+atomic_t redundant_hardirqs_off;
+atomic_t softirqs_on_events;
+atomic_t softirqs_off_events;
+atomic_t redundant_softirqs_on;
+atomic_t redundant_softirqs_off;
+atomic_t nr_unused_locks;
+atomic_t nr_hardirq_safe_locks;
+atomic_t nr_softirq_safe_locks;
+atomic_t nr_hardirq_unsafe_locks;
+atomic_t nr_softirq_unsafe_locks;
+atomic_t nr_hardirq_read_safe_locks;
+atomic_t nr_softirq_read_safe_locks;
+atomic_t nr_hardirq_read_unsafe_locks;
+atomic_t nr_softirq_read_unsafe_locks;
+atomic_t nr_cyclic_checks;
+atomic_t nr_cyclic_check_recursions;
+atomic_t nr_find_usage_forwards_checks;
+atomic_t nr_find_usage_forwards_recursions;
+atomic_t nr_find_usage_backwards_checks;
+atomic_t nr_find_usage_backwards_recursions;
+# define debug_atomic_inc(ptr)		atomic_inc(ptr)
+# define debug_atomic_dec(ptr)		atomic_dec(ptr)
+# define debug_atomic_read(ptr)		atomic_read(ptr)
+#else
+# define debug_atomic_inc(ptr)		do { } while (0)
+# define debug_atomic_dec(ptr)		do { } while (0)
+# define debug_atomic_read(ptr)		0
+#endif
+
+/*
+ * Locking printouts:
+ */
+
+static const char *usage_str[] =
+{
+	[LOCK_USED] =			"initial-use ",
+	[LOCK_USED_IN_HARDIRQ] =	"in-hardirq-W",
+	[LOCK_USED_IN_SOFTIRQ] =	"in-softirq-W",
+	[LOCK_ENABLED_SOFTIRQS] =	"softirq-on-W",
+	[LOCK_ENABLED_HARDIRQS] =	"hardirq-on-W",
+	[LOCK_USED_IN_HARDIRQ_READ] =	"in-hardirq-R",
+	[LOCK_USED_IN_SOFTIRQ_READ] =	"in-softirq-R",
+	[LOCK_ENABLED_SOFTIRQS_READ] =	"softirq-on-R",
+	[LOCK_ENABLED_HARDIRQS_READ] =	"hardirq-on-R",
+};
+
+static void printk_sym(unsigned long ip)
+{
+	printk(" [<%08lx>]", ip);
+	print_symbol(" %s\n", ip);
+}
+
+const char * __get_key_name(struct lockdep_subtype_key *key, char *str)
+{
+	unsigned long offs, size;
+	char *modname;
+
+	return kallsyms_lookup((unsigned long)key, &size, &offs, &modname, str);
+}
+
+void
+get_usage_chars(struct lock_type *type, char *c1, char *c2, char *c3, char *c4)
+{
+	*c1 = '.', *c2 = '.', *c3 = '.', *c4 = '.';
+
+	if (type->usage_mask & LOCKF_USED_IN_HARDIRQ)
+		*c1 = '+';
+	else
+		if (type->usage_mask & LOCKF_ENABLED_HARDIRQS)
+			*c1 = '-';
+
+	if (type->usage_mask & LOCKF_USED_IN_SOFTIRQ)
+		*c2 = '+';
+	else
+		if (type->usage_mask & LOCKF_ENABLED_SOFTIRQS)
+			*c2 = '-';
+
+	if (type->usage_mask & LOCKF_ENABLED_HARDIRQS_READ)
+		*c3 = '-';
+	if (type->usage_mask & LOCKF_USED_IN_HARDIRQ_READ) {
+		*c3 = '+';
+		if (type->usage_mask & LOCKF_ENABLED_HARDIRQS_READ)
+			*c3 = (char)'??';
+	}
+
+	if (type->usage_mask & LOCKF_ENABLED_SOFTIRQS_READ)
+		*c4 = '-';
+	if (type->usage_mask & LOCKF_USED_IN_SOFTIRQ_READ) {
+		*c4 = '+';
+		if (type->usage_mask & LOCKF_ENABLED_SOFTIRQS_READ)
+			*c4 = (char)'??';
+	}
+}
+
+static void print_lock_name(struct lock_type *type)
+{
+	char str[128], c1, c2, c3, c4;
+	const char *name;
+
+	get_usage_chars(type, &c1, &c2, &c3, &c4);
+
+	name = type->name;
+	if (!name) {
+		name = __get_key_name(type->key, str);
+		printk(" (%s", name);
+	} else {
+		printk(" (%s", name);
+		if (type->name_version > 1)
+			printk("#%d", type->name_version);
+		if (type->subtype)
+			printk("/%d", type->subtype);
+	}
+	printk("){%c%c%c%c}", c1, c2, c3, c4);
+}
+
+static void print_lock_name_field(struct lock_type *type)
+{
+	const char *name;
+	char str[128];
+
+	name = type->name;
+	if (!name) {
+		name = __get_key_name(type->key, str);
+		printk("%30s", name);
+	} else {
+		printk("%30s", name);
+		if (type->name_version > 1)
+			printk("#%d", type->name_version);
+		if (type->subtype)
+			printk("/%d", type->subtype);
+	}
+}
+
+static void print_lockdep_cache(struct lockdep_map *lock)
+{
+	const char *name;
+	char str[128];
+
+	name = lock->name;
+	if (!name)
+		name = __get_key_name(lock->key->subkeys, str);
+
+	printk("%s", name);
+}
+
+static void print_lock(struct held_lock *hlock)
+{
+	print_lock_name(hlock->type);
+	printk(", at:");
+	printk_sym(hlock->acquire_ip);
+}
+
+void lockdep_print_held_locks(struct task_struct *curr)
+{
+	int i;
+
+	if (!curr->lockdep_depth) {
+		printk("no locks held by %s/%d.\n", curr->comm, curr->pid);
+		return;
+	}
+	printk("%d locks held by %s/%d:\n",
+		curr->lockdep_depth, curr->comm, curr->pid);
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		printk(" #%d: ", i);
+		print_lock(curr->held_locks + i);
+	}
+}
+/*
+ * Helper to print a nice hierarchy of lock dependencies:
+ */
+static void print_spaces(int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		printk("  ");
+}
+
+void print_lock_type_header(struct lock_type *type, int depth)
+{
+	int bit;
+
+	print_spaces(depth);
+	printk("->");
+	print_lock_name(type);
+	printk(" ops: %lu", type->ops);
+	printk(" {\n");
+
+	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
+		if (type->usage_mask & (1 << bit)) {
+			int len = depth;
+
+			print_spaces(depth);
+			len += printk("   %s", usage_str[bit]);
+			len += printk(" at:\n");
+			print_stack_trace(type->usage_traces + bit, len);
+		}
+	}
+	print_spaces(depth);
+	printk(" }\n");
+
+	print_spaces(depth);
+	printk(" ... key      at:");
+	printk_sym((unsigned long)type->key);
+}
+
+/*
+ * printk all lock dependencies starting at <entry>:
+ */
+static void print_lock_dependencies(struct lock_type *type, int depth)
+{
+	struct lock_list *entry;
+
+	if (DEBUG_WARN_ON(depth >= 20))
+		return;
+
+	print_lock_type_header(type, depth);
+
+	list_for_each_entry(entry, &type->locks_after, entry) {
+		DEBUG_WARN_ON(!entry->type);
+		print_lock_dependencies(entry->type, depth + 1);
+
+		print_spaces(depth);
+		printk(" ... acquired at:\n");
+		print_stack_trace(&entry->trace, 2);
+		printk("\n");
+	}
+}
+
+/*
+ * printk all locks that are taken after this lock:
+ */
+static void print_flat_dependencies(struct lock_type *type)
+{
+	struct lock_list *entry;
+	int nr = 0;
+
+	printk(" {\n");
+	list_for_each_entry(entry, &type->locks_after, entry) {
+		nr++;
+		DEBUG_WARN_ON(!entry->type);
+		printk("    -> ");
+		print_lock_name_field(entry->type);
+		if (entry->type->subtype)
+			printk("/%d", entry->type->subtype);
+		print_stack_trace(&entry->trace, 2);
+	}
+	printk(" } [%d]", nr);
+}
+
+void print_lock_type(struct lock_type *type)
+{
+	print_lock_type_header(type, 0);
+	if (!list_empty(&type->locks_after))
+		print_flat_dependencies(type);
+	printk("\n");
+}
+
+void print_lock_types(void)
+{
+	struct list_head *head;
+	struct lock_type *type;
+	int i, nr;
+
+	printk("lock types:\n");
+
+	for (i = 0; i < TYPEHASH_SIZE; i++) {
+		head = typehash_table + i;
+		if (list_empty(head))
+			continue;
+		printk("\nhash-list at %d:\n", i);
+		nr = 0;
+		list_for_each_entry(type, head, hash_entry) {
+			printk("\n");
+			print_lock_type(type);
+			nr++;
+		}
+	}
+}
+
+/*
+ * Add a new dependency to the head of the list:
+ */
+static int add_lock_to_list(struct lock_type *type, struct lock_type *this,
+			    struct list_head *head, unsigned long ip)
+{
+	struct lock_list *entry;
+	/*
+	 * Lock not present yet - get a new dependency struct and
+	 * add it to the list:
+	 */
+	entry = alloc_list_entry();
+	if (!entry)
+		return 0;
+
+	entry->type = this;
+	save_trace(&entry->trace);
+
+	/*
+	 * Since we never remove from the dependency list, the list can
+	 * be walked lockless by other CPUs, it's only allocation
+	 * that must be protected by the spinlock. But this also means
+	 * we must make new entries visible only once writes to the
+	 * entry become visible - hence the RCU op:
+	 */
+	list_add_tail_rcu(&entry->entry, head);
+
+	return 1;
+}
+
+/*
+ * Recursive, forwards-direction lock-dependency checking, used for
+ * both noncyclic checking and for hardirq-unsafe/softirq-unsafe
+ * checking.
+ *
+ * (to keep the stackframe of the recursive functions small we
+ *  use these global variables, and we also mark various helper
+ *  functions as noinline.)
+ */
+static struct held_lock *check_source, *check_target;
+
+/*
+ * Print a dependency chain entry (this is only done when a deadlock
+ * has been detected):
+ */
+static noinline int
+print_circular_bug_entry(struct lock_list *target, unsigned int depth)
+{
+	if (debug_locks_silent)
+		return 0;
+	printk("\n-> #%u", depth);
+	print_lock_name(target->type);
+	printk(":\n");
+	print_stack_trace(&target->trace, 6);
+
+	return 0;
+}
+
+/*
+ * When a circular dependency is detected, print the
+ * header first:
+ */
+static noinline int
+print_circular_bug_header(struct lock_list *entry, unsigned int depth)
+{
+	struct task_struct *curr = current;
+
+	__raw_spin_unlock(&hash_lock);
+	debug_locks_off();
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n=====================================================\n");
+	printk(  "[ BUG: possible circular locking deadlock detected! ]\n");
+	printk(  "-----------------------------------------------------\n");
+	printk("%s/%d is trying to acquire lock:\n",
+		curr->comm, curr->pid);
+	print_lock(check_source);
+	printk("\nbut task is already holding lock:\n");
+	print_lock(check_target);
+	printk("\nwhich lock already depends on the new lock,\n");
+	printk("which could lead to circular deadlocks!\n");
+	printk("\nthe existing dependency chain (in reverse order) is:\n");
+
+	print_circular_bug_entry(entry, depth);
+
+	return 0;
+}
+
+static noinline int print_circular_bug_tail(void)
+{
+	struct task_struct *curr = current;
+	struct lock_list this;
+
+	if (debug_locks_silent)
+		return 0;
+
+	this.type = check_source->type;
+	save_trace(&this.trace);
+	print_circular_bug_entry(&this, 0);
+
+	printk("\nother info that might help us debug this:\n\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+static int noinline print_infinite_recursion_bug(void)
+{
+	__raw_spin_unlock(&hash_lock);
+	DEBUG_WARN_ON(1);
+
+	return 0;
+}
+
+/*
+ * Prove that the dependency graph starting at <entry> can not
+ * lead to <target>. Print an error and return 0 if it does.
+ */
+static noinline int
+check_noncircular(struct lock_type *source, unsigned int depth)
+{
+	struct lock_list *entry;
+
+	debug_atomic_inc(&nr_cyclic_check_recursions);
+	if (depth > max_recursion_depth)
+		max_recursion_depth = depth;
+	if (depth >= 20)
+		return print_infinite_recursion_bug();
+	/*
+	 * Check this lock's dependency list:
+	 */
+	list_for_each_entry(entry, &source->locks_after, entry) {
+		if (entry->type == check_target->type)
+			return print_circular_bug_header(entry, depth+1);
+		debug_atomic_inc(&nr_cyclic_checks);
+		if (!check_noncircular(entry->type, depth+1))
+			return print_circular_bug_entry(entry, depth+1);
+	}
+	return 1;
+}
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+/*
+ * Forwards and backwards subgraph searching, for the purposes of
+ * proving that two subgraphs can be connected by a new dependency
+ * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ */
+static enum lock_usage_bit find_usage_bit;
+static struct lock_type *forwards_match, *backwards_match;
+
+/*
+ * Find a node in the forwards-direction dependency sub-graph starting
+ * at <source> that matches <find_usage_bit>.
+ *
+ * Return 2 if such a node exists in the subgraph, and put that node
+ * into <forwards_match>.
+ *
+ * Return 1 otherwise and keep <forwards_match> unchanged.
+ * Return 0 on error.
+ */
+static noinline int
+find_usage_forwards(struct lock_type *source, unsigned int depth)
+{
+	struct lock_list *entry;
+	int ret;
+
+	if (depth > max_recursion_depth)
+		max_recursion_depth = depth;
+	if (depth >= 20)
+		return print_infinite_recursion_bug();
+
+	debug_atomic_inc(&nr_find_usage_forwards_checks);
+	if (source->usage_mask & (1 << find_usage_bit)) {
+		forwards_match = source;
+		return 2;
+	}
+
+	/*
+	 * Check this lock's dependency list:
+	 */
+	list_for_each_entry(entry, &source->locks_after, entry) {
+		debug_atomic_inc(&nr_find_usage_forwards_recursions);
+		ret = find_usage_forwards(entry->type, depth+1);
+		if (ret == 2 || ret == 0)
+			return ret;
+	}
+	return 1;
+}
+
+/*
+ * Find a node in the backwards-direction dependency sub-graph starting
+ * at <source> that matches <find_usage_bit>.
+ *
+ * Return 2 if such a node exists in the subgraph, and put that node
+ * into <backwards_match>.
+ *
+ * Return 1 otherwise and keep <backwards_match> unchanged.
+ * Return 0 on error.
+ */
+static noinline int
+find_usage_backwards(struct lock_type *source, unsigned int depth)
+{
+	struct lock_list *entry;
+	int ret;
+
+	if (depth > max_recursion_depth)
+		max_recursion_depth = depth;
+	if (depth >= 20)
+		return print_infinite_recursion_bug();
+
+	debug_atomic_inc(&nr_find_usage_backwards_checks);
+	if (source->usage_mask & (1 << find_usage_bit)) {
+		backwards_match = source;
+		return 2;
+	}
+
+	/*
+	 * Check this lock's dependency list:
+	 */
+	list_for_each_entry(entry, &source->locks_before, entry) {
+		debug_atomic_inc(&nr_find_usage_backwards_recursions);
+		ret = find_usage_backwards(entry->type, depth+1);
+		if (ret == 2 || ret == 0)
+			return ret;
+	}
+	return 1;
+}
+
+static int
+print_bad_irq_dependency(struct task_struct *curr,
+			 struct held_lock *prev,
+			 struct held_lock *next,
+			 enum lock_usage_bit bit1,
+			 enum lock_usage_bit bit2,
+			 const char *irqtype)
+{
+	__raw_spin_unlock(&hash_lock);
+	debug_locks_off();
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n======================================================\n");
+	printk(  "[ BUG: %s-safe -> %s-unsafe lock order detected! ]\n",
+		irqtype, irqtype);
+	printk(  "------------------------------------------------------\n");
+	printk("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
+		curr->comm, curr->pid,
+		curr->hardirq_context, hardirq_count() >> HARDIRQ_SHIFT,
+		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
+		curr->hardirqs_enabled,
+		curr->softirqs_enabled);
+	print_lock(next);
+
+	printk("\nand this task is already holding:\n");
+	print_lock(prev);
+	printk("which would create a new lock dependency:\n");
+	print_lock_name(prev->type);
+	printk(" ->");
+	print_lock_name(next->type);
+	printk("\n");
+
+	printk("\nbut this new dependency connects a %s-irq-safe lock:\n",
+		irqtype);
+	print_lock_name(backwards_match);
+	printk("\n... which became %s-irq-safe at:\n", irqtype);
+
+	print_stack_trace(backwards_match->usage_traces + bit1, 1);
+
+	printk("\nto a %s-irq-unsafe lock:\n", irqtype);
+	print_lock_name(forwards_match);
+	printk("\n... which became %s-irq-unsafe at:\n", irqtype);
+	printk("...");
+
+	print_stack_trace(forwards_match->usage_traces + bit2, 1);
+
+	printk("\nwhich could potentially lead to deadlocks!\n");
+
+	printk("\nother info that might help us debug this:\n\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nthe %s-irq-safe lock's dependencies:\n", irqtype);
+	print_lock_dependencies(backwards_match, 0);
+
+	printk("\nthe %s-irq-unsafe lock's dependencies:\n", irqtype);
+	print_lock_dependencies(forwards_match, 0);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+static int
+check_usage(struct task_struct *curr, struct held_lock *prev,
+	    struct held_lock *next, enum lock_usage_bit bit_backwards,
+	    enum lock_usage_bit bit_forwards, const char *irqtype)
+{
+	int ret;
+
+	find_usage_bit = bit_backwards;
+	/* fills in <backwards_match> */
+	ret = find_usage_backwards(prev->type, 0);
+	if (!ret || ret == 1)
+		return ret;
+
+	find_usage_bit = bit_forwards;
+	ret = find_usage_forwards(next->type, 0);
+	if (!ret || ret == 1)
+		return ret;
+	/* ret == 2 */
+	return print_bad_irq_dependency(curr, prev, next,
+			bit_backwards, bit_forwards, irqtype);
+}
+
+#endif
+
+static int
+print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
+		   struct held_lock *next)
+{
+	debug_locks_off();
+	__raw_spin_unlock(&hash_lock);
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n====================================\n");
+	printk(  "[ BUG: possible deadlock detected! ]\n");
+	printk(  "------------------------------------\n");
+	printk("%s/%d is trying to acquire lock:\n",
+		curr->comm, curr->pid);
+	print_lock(next);
+	printk("\nbut task is already holding lock:\n");
+	print_lock(prev);
+	printk("\nwhich could potentially lead to deadlocks!\n");
+
+	printk("\nother info that might help us debug this:\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+/*
+ * Check whether we are holding such a type already.
+ *
+ * (Note that this has to be done separately, because the graph cannot
+ * detect such types of deadlocks.)
+ *
+ * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ */
+static int
+check_deadlock(struct task_struct *curr, struct held_lock *next,
+	       struct lockdep_map *next_instance, int read)
+{
+	struct held_lock *prev;
+	int i;
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		prev = curr->held_locks + i;
+		if (prev->type != next->type)
+			continue;
+		/*
+		 * Allow read-after-read recursion of the same
+		 * lock instance (i.e. read_lock(lock)+read_lock(lock)):
+		 */
+		if ((read > 0) && prev->read &&
+				(prev->instance == next_instance))
+			return 2;
+		return print_deadlock_bug(curr, prev, next);
+	}
+	return 1;
+}
+
+/*
+ * There was a chain-cache miss, and we are about to add a new dependency
+ * to a previous lock. We recursively validate the following rules:
+ *
+ *  - would the adding of the <prev> -> <next> dependency create a
+ *    circular dependency in the graph? [== circular deadlock]
+ *
+ *  - does the new prev->next dependency connect any hardirq-safe lock
+ *    (in the full backwards-subgraph starting at <prev>) with any
+ *    hardirq-unsafe lock (in the full forwards-subgraph starting at
+ *    <next>)? [== illegal lock inversion with hardirq contexts]
+ *
+ *  - does the new prev->next dependency connect any softirq-safe lock
+ *    (in the full backwards-subgraph starting at <prev>) with any
+ *    softirq-unsafe lock (in the full forwards-subgraph starting at
+ *    <next>)? [== illegal lock inversion with softirq contexts]
+ *
+ * any of these scenarios could lead to a deadlock.
+ *
+ * Then if all the validations pass, we add the forwards and backwards
+ * dependency.
+ */
+static int
+check_prev_add(struct task_struct *curr, struct held_lock *prev,
+	       struct held_lock *next)
+{
+	struct lock_list *entry;
+	int ret;
+
+	/*
+	 * Prove that the new <prev> -> <next> dependency would not
+	 * create a circular dependency in the graph. (We do this by
+	 * forward-recursing into the graph starting at <next>, and
+	 * checking whether we can reach <prev>.)
+	 *
+	 * We are using global variables to control the recursion, to
+	 * keep the stackframe size of the recursive functions low:
+	 */
+	check_source = next;
+	check_target = prev;
+	if (!(check_noncircular(next->type, 0)))
+		return print_circular_bug_tail();
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/*
+	 * Prove that the new dependency does not connect a hardirq-safe
+	 * lock with a hardirq-unsafe lock - to achieve this we search
+	 * the backwards-subgraph starting at <prev>, and the
+	 * forwards-subgraph starting at <next>:
+	 */
+	if (!check_usage(curr, prev, next, LOCK_USED_IN_HARDIRQ,
+					LOCK_ENABLED_HARDIRQS, "hard"))
+		return 0;
+
+	/*
+	 * Prove that the new dependency does not connect a hardirq-safe-read
+	 * lock with a hardirq-unsafe lock - to achieve this we search
+	 * the backwards-subgraph starting at <prev>, and the
+	 * forwards-subgraph starting at <next>:
+	 */
+	if (!check_usage(curr, prev, next, LOCK_USED_IN_HARDIRQ_READ,
+					LOCK_ENABLED_HARDIRQS, "hard-read"))
+		return 0;
+
+	/*
+	 * Prove that the new dependency does not connect a softirq-safe
+	 * lock with a softirq-unsafe lock - to achieve this we search
+	 * the backwards-subgraph starting at <prev>, and the
+	 * forwards-subgraph starting at <next>:
+	 */
+	if (!check_usage(curr, prev, next, LOCK_USED_IN_SOFTIRQ,
+					LOCK_ENABLED_SOFTIRQS, "soft"))
+		return 0;
+	/*
+	 * Prove that the new dependency does not connect a softirq-safe-read
+	 * lock with a softirq-unsafe lock - to achieve this we search
+	 * the backwards-subgraph starting at <prev>, and the
+	 * forwards-subgraph starting at <next>:
+	 */
+	if (!check_usage(curr, prev, next, LOCK_USED_IN_SOFTIRQ_READ,
+					LOCK_ENABLED_SOFTIRQS, "soft"))
+		return 0;
+#endif
+	/*
+	 * For recursive read-locks we do all the dependency checks,
+	 * but we dont store read-triggered dependencies (only
+	 * write-triggered dependencies). This ensures that only the
+	 * write-side dependencies matter, and that if for example a
+	 * write-lock never takes any other locks, then the reads are
+	 * equivalent to a NOP.
+	 */
+	if (next->read == 1 || prev->read == 1)
+		return 1;
+	/*
+	 * Is the <prev> -> <next> dependency already present?
+	 *
+	 * (this may occur even though this is a new chain: consider
+	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
+	 *  chains - the second one will be new, but L1 already has
+	 *  L2 added to its dependency list, due to the first chain.)
+	 */
+	list_for_each_entry(entry, &prev->type->locks_after, entry) {
+		if (entry->type == next->type)
+			return 2;
+	}
+
+	/*
+	 * Ok, all validations passed, add the new lock
+	 * to the previous lock's dependency list:
+	 */
+	ret = add_lock_to_list(prev->type, next->type,
+			       &prev->type->locks_after, next->acquire_ip);
+	if (!ret)
+		return 0;
+	/*
+	 * Return value of 2 signals 'dependency already added',
+	 * in that case we dont have to add the backlink either.
+	 */
+	if (ret == 2)
+		return 2;
+	ret = add_lock_to_list(next->type, prev->type,
+			       &next->type->locks_before, next->acquire_ip);
+
+	/*
+	 * Debugging printouts:
+	 */
+	if (verbose(prev->type) || verbose(next->type)) {
+		__raw_spin_unlock(&hash_lock);
+		print_lock_name_field(prev->type);
+		printk(" => ");
+		print_lock_name_field(next->type);
+		printk("\n");
+		dump_stack();
+		__raw_spin_lock(&hash_lock);
+	}
+	return 1;
+}
+
+/*
+ * Add the dependency to all directly-previous locks that are 'relevant'.
+ * The ones that are relevant are (in increasing distance from curr):
+ * all consecutive trylock entries and the final non-trylock entry - or
+ * the end of this context's lock-chain - whichever comes first.
+ */
+static int
+check_prevs_add(struct task_struct *curr, struct held_lock *next)
+{
+	int depth = curr->lockdep_depth;
+	struct held_lock *hlock;
+
+	/*
+	 * Debugging checks.
+	 *
+	 * Depth must not be zero for a non-head lock:
+	 */
+	if (!depth)
+		goto out_bug;
+	/*
+	 * At least two relevant locks must exist for this
+	 * to be a head:
+	 */
+	if (curr->held_locks[depth].irq_context !=
+			curr->held_locks[depth-1].irq_context)
+		goto out_bug;
+
+	for (;;) {
+		hlock = curr->held_locks + depth-1;
+		/*
+		 * Only non-recursive-read entries get new dependencies
+		 * added:
+		 */
+		if (hlock->read != 2) {
+			check_prev_add(curr, hlock, next);
+			/*
+			 * Stop after the first non-trylock entry,
+			 * as non-trylock entries have added their
+			 * own direct dependencies already, so this
+			 * lock is connected to them indirectly:
+			 */
+			if (!hlock->trylock)
+				break;
+		}
+		depth--;
+		/*
+		 * End of lock-stack?
+		 */
+		if (!depth)
+			break;
+		/*
+		 * Stop the search if we cross into another context:
+		 */
+		if (curr->held_locks[depth].irq_context !=
+				curr->held_locks[depth-1].irq_context)
+			break;
+	}
+	return 1;
+out_bug:
+	__raw_spin_unlock(&hash_lock);
+	DEBUG_WARN_ON(1);
+
+	return 0;
+}
+
+
+/*
+ * Is this the address of a static object:
+ */
+static int static_obj(void *obj)
+{
+	unsigned long start = (unsigned long) &_stext,
+		      end   = (unsigned long) &_end,
+		      addr  = (unsigned long) obj;
+	int i;
+
+	/*
+	 * static variable?
+	 */
+	if ((addr >= start) && (addr < end))
+		return 1;
+
+#ifdef CONFIG_SMP
+	/*
+	 * percpu var?
+	 */
+	for_each_possible_cpu(i) {
+		start = (unsigned long) &__per_cpu_start + per_cpu_offset(i);
+		end   = (unsigned long) &__per_cpu_end   + per_cpu_offset(i);
+
+		if ((addr >= start) && (addr < end))
+			return 1;
+	}
+#endif
+
+	/*
+	 * module var?
+	 */
+	return __module_address(addr);
+}
+
+/*
+ * To make lock name printouts unique, we calculate a unique
+ * type->name_version generation counter:
+ */
+int count_matching_names(struct lock_type *new_type)
+{
+	struct lock_type *type;
+	int count = 0;
+
+	if (!new_type->name)
+		return 0;
+
+	list_for_each_entry(type, &all_lock_types, lock_entry) {
+		if (new_type->key - new_type->subtype == type->key)
+			return type->name_version;
+		if (!strcmp(type->name, new_type->name))
+			count = max(count, type->name_version);
+	}
+
+	return count + 1;
+}
+
+extern void __error_too_big_MAX_LOCKDEP_SUBTYPES(void);
+
+/*
+ * Register a lock's type in the hash-table, if the type is not present
+ * yet. Otherwise we look it up. We cache the result in the lock object
+ * itself, so actual lookup of the hash should be once per lock object.
+ */
+static inline struct lock_type *
+register_lock_type(struct lockdep_map *lock, unsigned int subtype)
+{
+	struct lockdep_subtype_key *key;
+	struct list_head *hash_head;
+	struct lock_type *type;
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+	/*
+	 * If the architecture calls into lockdep before initializing
+	 * the hashes then we'll warn about it later. (we cannot printk
+	 * right now)
+	 */
+	if (unlikely(!lockdep_initialized)) {
+		lockdep_init();
+		lockdep_init_error = 1;
+	}
+#endif
+
+	/*
+	 * Static locks do not have their type-keys yet - for them the key
+	 * is the lock object itself:
+	 */
+	if (unlikely(!lock->key))
+		lock->key = (void *)lock;
+
+	/*
+	 * Debug-check: all keys must be persistent!
+ 	 */
+	if (DEBUG_WARN_ON(!static_obj(lock->key))) {
+		debug_locks_off();
+		printk("BUG: trying to register non-static key!\n");
+		printk("turning off the locking correctness validator.\n");
+		dump_stack();
+		return NULL;
+	}
+
+	/*
+	 * NOTE: the type-key must be unique. For dynamic locks, a static
+	 * lockdep_type_key variable is passed in through the mutex_init()
+	 * (or spin_lock_init()) call - which acts as the key. For static
+	 * locks we use the lock object itself as the key.
+	 */
+	if (sizeof(struct lockdep_type_key) > sizeof(struct lock_type))
+		__error_too_big_MAX_LOCKDEP_SUBTYPES();
+
+	key = lock->key->subkeys + subtype;
+
+	hash_head = typehashentry(key);
+
+	/*
+	 * We can walk the hash lockfree, because the hash only
+	 * grows, and we are careful when adding entries to the end:
+	 */
+	list_for_each_entry(type, hash_head, hash_entry)
+		if (type->key == key)
+			goto out_set;
+
+	__raw_spin_lock(&hash_lock);
+	/*
+	 * We have to do the hash-walk again, to avoid races
+	 * with another CPU:
+	 */
+	list_for_each_entry(type, hash_head, hash_entry)
+		if (type->key == key)
+			goto out_unlock_set;
+	/*
+	 * Allocate a new key from the static array, and add it to
+	 * the hash:
+	 */
+	if (nr_lock_types >= MAX_LOCKDEP_KEYS) {
+		__raw_spin_unlock(&hash_lock);
+		debug_locks_off();
+		printk("BUG: MAX_LOCKDEP_KEYS too low!\n");
+		printk("turning off the locking correctness validator.\n");
+		return NULL;
+	}
+	type = lock_types + nr_lock_types++;
+	debug_atomic_inc(&nr_unused_locks);
+	type->key = key;
+	type->name = lock->name;
+	type->subtype = subtype;
+	INIT_LIST_HEAD(&type->lock_entry);
+	INIT_LIST_HEAD(&type->locks_before);
+	INIT_LIST_HEAD(&type->locks_after);
+	type->name_version = count_matching_names(type);
+	/*
+	 * We use RCU's safe list-add method to make
+	 * parallel walking of the hash-list safe:
+	 */
+	list_add_tail_rcu(&type->hash_entry, hash_head);
+
+	if (verbose(type)) {
+		__raw_spin_unlock(&hash_lock);
+		printk("new type %p: %s", type->key, type->name);
+		if (type->name_version > 1)
+			printk("#%d", type->name_version);
+		printk("\n");
+		dump_stack();
+		__raw_spin_lock(&hash_lock);
+	}
+out_unlock_set:
+	__raw_spin_unlock(&hash_lock);
+
+out_set:
+	lock->type[subtype] = type;
+
+	DEBUG_WARN_ON(type->subtype != subtype);
+
+	return type;
+}
+
+/*
+ * Look up a dependency chain. If the key is not present yet then
+ * add it and return 0 - in this case the new dependency chain is
+ * validated. If the key is already hashed, return 1.
+ */
+static inline int lookup_chain_cache(u64 chain_key)
+{
+	struct list_head *hash_head = chainhashentry(chain_key);
+	struct lock_chain *chain;
+
+	DEBUG_WARN_ON(!irqs_disabled());
+	/*
+	 * We can walk it lock-free, because entries only get added
+	 * to the hash:
+	 */
+	list_for_each_entry(chain, hash_head, entry) {
+		if (chain->chain_key == chain_key) {
+cache_hit:
+			debug_atomic_inc(&chain_lookup_hits);
+			/*
+			 * In the debugging case, force redundant checking
+			 * by returning 1:
+			 */
+#ifdef CONFIG_DEBUG_LOCKDEP
+			__raw_spin_lock(&hash_lock);
+			return 1;
+#endif
+			return 0;
+		}
+	}
+	/*
+	 * Allocate a new chain entry from the static array, and add
+	 * it to the hash:
+	 */
+	__raw_spin_lock(&hash_lock);
+	/*
+	 * We have to walk the chain again locked - to avoid duplicates:
+	 */
+	list_for_each_entry(chain, hash_head, entry) {
+		if (chain->chain_key == chain_key) {
+			__raw_spin_unlock(&hash_lock);
+			goto cache_hit;
+		}
+	}
+	if (unlikely(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+		__raw_spin_unlock(&hash_lock);
+		debug_locks_off();
+		printk("BUG: MAX_LOCKDEP_CHAINS too low!\n");
+		printk("turning off the locking correctness validator.\n");
+		return 0;
+	}
+	chain = lock_chains + nr_lock_chains++;
+	chain->chain_key = chain_key;
+	list_add_tail_rcu(&chain->entry, hash_head);
+	debug_atomic_inc(&chain_lookup_misses);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	if (current->hardirq_context)
+		nr_hardirq_chains++;
+	else {
+		if (current->softirq_context)
+			nr_softirq_chains++;
+		else
+			nr_process_chains++;
+	}
+#else
+	nr_process_chains++;
+#endif
+
+	return 1;
+}
+
+/*
+ * We are building curr_chain_key incrementally, so double-check
+ * it from scratch, to make sure that it's done correctly:
+ */
+static void check_chain_key(struct task_struct *curr)
+{
+#ifdef CONFIG_DEBUG_LOCKDEP
+	struct held_lock *hlock, *prev_hlock = NULL;
+	unsigned int i, id;
+	u64 chain_key = 0;
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		hlock = curr->held_locks + i;
+		if (chain_key != hlock->prev_chain_key) {
+			debug_locks_off();
+			printk("hm#1, depth: %u [%u], %016Lx != %016Lx\n",
+				curr->lockdep_depth, i, chain_key,
+				hlock->prev_chain_key);
+			WARN_ON(1);
+			return;
+		}
+		id = hlock->type - lock_types;
+		DEBUG_WARN_ON(id >= MAX_LOCKDEP_KEYS);
+		if (prev_hlock && (prev_hlock->irq_context !=
+							hlock->irq_context))
+			chain_key = 0;
+		chain_key = iterate_chain_key(chain_key, id);
+		prev_hlock = hlock;
+	}
+	if (chain_key != curr->curr_chain_key) {
+		debug_locks_off();
+		printk("hm#2, depth: %u [%u], %016Lx != %016Lx\n",
+			curr->lockdep_depth, i, chain_key,
+			curr->curr_chain_key);
+		WARN_ON(1);
+	}
+#endif
+}
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+/*
+ * print irq inversion bug:
+ */
+static int
+print_irq_inversion_bug(struct task_struct *curr, struct lock_type *other,
+			struct held_lock *this, int forwards,
+			const char *irqtype)
+{
+	__raw_spin_unlock(&hash_lock);
+	debug_locks_off();
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n==================================================\n");
+	printk(  "[ BUG: possible irq lock inversion bug detected! ]\n");
+	printk(  "--------------------------------------------------\n");
+	printk("%s/%d just changed the state of lock:\n",
+		curr->comm, curr->pid);
+	print_lock(this);
+	if (forwards)
+		printk("but this lock took another, %s-irq-unsafe lock in the past:\n", irqtype);
+	else
+		printk("but this lock was taken by another, %s-irq-safe lock in the past:\n", irqtype);
+	print_lock_name(other);
+	printk("\n\nand interrupts could create inverse lock ordering between them,\n");
+
+	printk("which could potentially lead to deadlocks!\n");
+
+	printk("\nother info that might help us debug this:\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nthe first lock's dependencies:\n");
+	print_lock_dependencies(this->type, 0);
+
+	printk("\nthe second lock's dependencies:\n");
+	print_lock_dependencies(other, 0);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+/*
+ * Prove that in the forwards-direction subgraph starting at <this>
+ * there is no lock matching <mask>:
+ */
+static int
+check_usage_forwards(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit bit, const char *irqtype)
+{
+	int ret;
+
+	find_usage_bit = bit;
+	/* fills in <forwards_match> */
+	ret = find_usage_forwards(this->type, 0);
+	if (!ret || ret == 1)
+		return ret;
+
+	return print_irq_inversion_bug(curr, forwards_match, this, 1, irqtype);
+}
+
+/*
+ * Prove that in the backwards-direction subgraph starting at <this>
+ * there is no lock matching <mask>:
+ */
+static int
+check_usage_backwards(struct task_struct *curr, struct held_lock *this,
+		      enum lock_usage_bit bit, const char *irqtype)
+{
+	int ret;
+
+	find_usage_bit = bit;
+	/* fills in <backwards_match> */
+	ret = find_usage_backwards(this->type, 0);
+	if (!ret || ret == 1)
+		return ret;
+
+	return print_irq_inversion_bug(curr, backwards_match, this, 0, irqtype);
+}
+
+static inline void print_irqtrace_events(struct task_struct *curr)
+{
+	printk("irq event stamp: %u\n", curr->irq_events);
+	printk("hardirqs last  enabled at (%u): [<%08lx>]",
+		curr->hardirq_enable_event, curr->hardirq_enable_ip);
+	print_symbol(" %s\n", curr->hardirq_enable_ip);
+	printk("hardirqs last disabled at (%u): [<%08lx>]",
+		curr->hardirq_disable_event, curr->hardirq_disable_ip);
+	print_symbol(" %s\n", curr->hardirq_disable_ip);
+	printk("softirqs last  enabled at (%u): [<%08lx>]",
+		curr->softirq_enable_event, curr->softirq_enable_ip);
+	print_symbol(" %s\n", curr->softirq_enable_ip);
+	printk("softirqs last disabled at (%u): [<%08lx>]",
+		curr->softirq_disable_event, curr->softirq_disable_ip);
+	print_symbol(" %s\n", curr->softirq_disable_ip);
+}
+
+#else
+static inline void print_irqtrace_events(struct task_struct *curr)
+{
+}
+#endif
+
+static int
+print_usage_bug(struct task_struct *curr, struct held_lock *this,
+		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
+{
+	__raw_spin_unlock(&hash_lock);
+	debug_locks_off();
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n============================\n");
+	printk(  "[ BUG: illegal lock usage! ]\n");
+	printk(  "----------------------------\n");
+
+	printk("illegal {%s} -> {%s} usage.\n",
+		usage_str[prev_bit], usage_str[new_bit]);
+
+	printk("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
+		curr->comm, curr->pid,
+		trace_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		trace_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
+		trace_hardirqs_enabled(curr),
+		trace_softirqs_enabled(curr));
+	print_lock(this);
+
+	printk("{%s} state was registered at:\n", usage_str[prev_bit]);
+	print_stack_trace(this->type->usage_traces + prev_bit, 1);
+
+	print_irqtrace_events(curr);
+	printk("\nother info that might help us debug this:\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+/*
+ * Print out an error if an invalid bit is set:
+ */
+static inline int
+valid_state(struct task_struct *curr, struct held_lock *this,
+	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
+{
+	if (unlikely(this->type->usage_mask & (1 << bad_bit)))
+		return print_usage_bug(curr, this, bad_bit, new_bit);
+	return 1;
+}
+
+#define STRICT_READ_CHECKS	1
+
+/*
+ * Mark a lock with a usage bit, and validate the state transition:
+ */
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit new_bit, unsigned long ip)
+{
+	unsigned int new_mask = 1 << new_bit, ret = 1;
+
+	/*
+	 * If already set then do not dirty the cacheline,
+	 * nor do any checks:
+	 */
+	if (likely(this->type->usage_mask & new_mask))
+		return 1;
+
+	__raw_spin_lock(&hash_lock);
+	/*
+	 * Make sure we didnt race:
+	 */
+	if (unlikely(this->type->usage_mask & new_mask)) {
+		__raw_spin_unlock(&hash_lock);
+		return 1;
+	}
+
+	this->type->usage_mask |= new_mask;
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	if (new_bit == LOCK_ENABLED_HARDIRQS ||
+			new_bit == LOCK_ENABLED_HARDIRQS_READ)
+		ip = curr->hardirq_enable_ip;
+	else if (new_bit == LOCK_ENABLED_SOFTIRQS ||
+			new_bit == LOCK_ENABLED_SOFTIRQS_READ)
+		ip = curr->softirq_enable_ip;
+#endif
+	if (!save_trace(this->type->usage_traces + new_bit))
+		return 0;
+
+	switch (new_bit) {
+#ifdef CONFIG_TRACE_IRQFLAGS
+	case LOCK_USED_IN_HARDIRQ:
+		if (!valid_state(curr, this, new_bit, LOCK_ENABLED_HARDIRQS))
+			return 0;
+		if (!valid_state(curr, this, new_bit,
+				 LOCK_ENABLED_HARDIRQS_READ))
+			return 0;
+		/*
+		 * just marked it hardirq-safe, check that this lock
+		 * took no hardirq-unsafe lock in the past:
+		 */
+		if (!check_usage_forwards(curr, this,
+					  LOCK_ENABLED_HARDIRQS, "hard"))
+			return 0;
+#if STRICT_READ_CHECKS
+		/*
+		 * just marked it hardirq-safe, check that this lock
+		 * took no hardirq-unsafe-read lock in the past:
+		 */
+		if (!check_usage_forwards(curr, this,
+				LOCK_ENABLED_HARDIRQS_READ, "hard-read"))
+			return 0;
+#endif
+		debug_atomic_inc(&nr_hardirq_safe_locks);
+		if (hardirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_USED_IN_SOFTIRQ:
+		if (!valid_state(curr, this, new_bit, LOCK_ENABLED_SOFTIRQS))
+			return 0;
+		if (!valid_state(curr, this, new_bit,
+				 LOCK_ENABLED_SOFTIRQS_READ))
+			return 0;
+		/*
+		 * just marked it softirq-safe, check that this lock
+		 * took no softirq-unsafe lock in the past:
+		 */
+		if (!check_usage_forwards(curr, this,
+					  LOCK_ENABLED_SOFTIRQS, "soft"))
+			return 0;
+#if STRICT_READ_CHECKS
+		/*
+		 * just marked it softirq-safe, check that this lock
+		 * took no softirq-unsafe-read lock in the past:
+		 */
+		if (!check_usage_forwards(curr, this,
+				LOCK_ENABLED_SOFTIRQS_READ, "soft-read"))
+			return 0;
+#endif
+		debug_atomic_inc(&nr_softirq_safe_locks);
+		if (softirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_USED_IN_HARDIRQ_READ:
+		if (!valid_state(curr, this, new_bit, LOCK_ENABLED_HARDIRQS))
+			return 0;
+		/*
+		 * just marked it hardirq-read-safe, check that this lock
+		 * took no hardirq-unsafe lock in the past:
+		 */
+		if (!check_usage_forwards(curr, this,
+					  LOCK_ENABLED_HARDIRQS, "hard"))
+			return 0;
+		debug_atomic_inc(&nr_hardirq_read_safe_locks);
+		if (hardirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_USED_IN_SOFTIRQ_READ:
+		if (!valid_state(curr, this, new_bit, LOCK_ENABLED_SOFTIRQS))
+			return 0;
+		/*
+		 * just marked it softirq-read-safe, check that this lock
+		 * took no softirq-unsafe lock in the past:
+		 */
+		if (!check_usage_forwards(curr, this,
+					  LOCK_ENABLED_SOFTIRQS, "soft"))
+			return 0;
+		debug_atomic_inc(&nr_softirq_read_safe_locks);
+		if (softirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_ENABLED_HARDIRQS:
+		if (!valid_state(curr, this, new_bit, LOCK_USED_IN_HARDIRQ))
+			return 0;
+		if (!valid_state(curr, this, new_bit,
+				 LOCK_USED_IN_HARDIRQ_READ))
+			return 0;
+		/*
+		 * just marked it hardirq-unsafe, check that no hardirq-safe
+		 * lock in the system ever took it in the past:
+		 */
+		if (!check_usage_backwards(curr, this,
+					   LOCK_USED_IN_HARDIRQ, "hard"))
+			return 0;
+#if STRICT_READ_CHECKS
+		/*
+		 * just marked it hardirq-unsafe, check that no
+		 * hardirq-safe-read lock in the system ever took
+		 * it in the past:
+		 */
+		if (!check_usage_backwards(curr, this,
+				   LOCK_USED_IN_HARDIRQ_READ, "hard-read"))
+			return 0;
+#endif
+		debug_atomic_inc(&nr_hardirq_unsafe_locks);
+		if (hardirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_ENABLED_SOFTIRQS:
+		if (!valid_state(curr, this, new_bit, LOCK_USED_IN_SOFTIRQ))
+			return 0;
+		if (!valid_state(curr, this, new_bit,
+				 LOCK_USED_IN_SOFTIRQ_READ))
+			return 0;
+		/*
+		 * just marked it softirq-unsafe, check that no softirq-safe
+		 * lock in the system ever took it in the past:
+		 */
+		if (!check_usage_backwards(curr, this,
+					   LOCK_USED_IN_SOFTIRQ, "soft"))
+			return 0;
+#if STRICT_READ_CHECKS
+		/*
+		 * just marked it softirq-unsafe, check that no
+		 * softirq-safe-read lock in the system ever took
+		 * it in the past:
+		 */
+		if (!check_usage_backwards(curr, this,
+				   LOCK_USED_IN_SOFTIRQ_READ, "soft-read"))
+			return 0;
+#endif
+		debug_atomic_inc(&nr_softirq_unsafe_locks);
+		if (softirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_ENABLED_HARDIRQS_READ:
+		if (!valid_state(curr, this, new_bit, LOCK_USED_IN_HARDIRQ))
+			return 0;
+#if STRICT_READ_CHECKS
+		/*
+		 * just marked it hardirq-read-unsafe, check that no
+		 * hardirq-safe lock in the system ever took it in the past:
+		 */
+		if (!check_usage_backwards(curr, this,
+					   LOCK_USED_IN_HARDIRQ, "hard"))
+			return 0;
+#endif
+		debug_atomic_inc(&nr_hardirq_read_unsafe_locks);
+		if (hardirq_verbose(this->type))
+			ret = 2;
+		break;
+	case LOCK_ENABLED_SOFTIRQS_READ:
+		if (!valid_state(curr, this, new_bit, LOCK_USED_IN_SOFTIRQ))
+			return 0;
+#if STRICT_READ_CHECKS
+		/*
+		 * just marked it softirq-read-unsafe, check that no
+		 * softirq-safe lock in the system ever took it in the past:
+		 */
+		if (!check_usage_backwards(curr, this,
+					   LOCK_USED_IN_SOFTIRQ, "soft"))
+			return 0;
+#endif
+		debug_atomic_inc(&nr_softirq_read_unsafe_locks);
+		if (softirq_verbose(this->type))
+			ret = 2;
+		break;
+#endif
+	case LOCK_USED:
+		/*
+		 * Add it to the global list of types:
+		 */
+		list_add_tail_rcu(&this->type->lock_entry, &all_lock_types);
+		debug_atomic_dec(&nr_unused_locks);
+		break;
+	default:
+		debug_locks_off();
+		WARN_ON(1);
+		return 0;
+	}
+
+	__raw_spin_unlock(&hash_lock);
+
+	/*
+	 * We must printk outside of the hash_lock:
+	 */
+	if (ret == 2) {
+		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
+		print_lock(this);
+		print_irqtrace_events(curr);
+		dump_stack();
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+/*
+ * Mark all held locks with a usage bit:
+ */
+static int
+mark_held_locks(struct task_struct *curr, int hardirq, unsigned long ip)
+{
+	enum lock_usage_bit usage_bit;
+	struct held_lock *hlock;
+	int i;
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		hlock = curr->held_locks + i;
+
+		if (hardirq) {
+			if (hlock->read)
+				usage_bit = LOCK_ENABLED_HARDIRQS_READ;
+			else
+				usage_bit = LOCK_ENABLED_HARDIRQS;
+		} else {
+			if (hlock->read)
+				usage_bit = LOCK_ENABLED_SOFTIRQS_READ;
+			else
+				usage_bit = LOCK_ENABLED_SOFTIRQS;
+		}
+		if (!mark_lock(curr, hlock, usage_bit, ip))
+			return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * Debugging helper: via this flag we know that we are in
+ * 'early bootup code', and will warn about any invalid irqs-on event:
+ */
+static int early_boot_irqs_enabled;
+
+void early_boot_irqs_off(void)
+{
+	early_boot_irqs_enabled = 0;
+}
+
+void early_boot_irqs_on(void)
+{
+	early_boot_irqs_enabled = 1;
+}
+
+/*
+ * Hardirqs will be enabled:
+ */
+void trace_hardirqs_on(void)
+{
+	struct task_struct *curr = current;
+	unsigned long ip;
+
+	if (unlikely(!debug_locks))
+		return;
+
+	if (DEBUG_WARN_ON(unlikely(!early_boot_irqs_enabled)))
+		return;
+
+	if (unlikely(curr->hardirqs_enabled)) {
+		debug_atomic_inc(&redundant_hardirqs_on);
+		return;
+	}
+	/* we'll do an OFF -> ON transition: */
+	curr->hardirqs_enabled = 1;
+	ip = (unsigned long) __builtin_return_address(0);
+
+	if (DEBUG_WARN_ON(!irqs_disabled()))
+		return;
+	if (DEBUG_WARN_ON(current->hardirq_context))
+		return;
+	/*
+	 * We are going to turn hardirqs on, so set the
+	 * usage bit for all held locks:
+	 */
+	if (!mark_held_locks(curr, 1, ip))
+		return;
+	/*
+	 * If we have softirqs enabled, then set the usage
+	 * bit for all held locks. (disabled hardirqs prevented
+	 * this bit from being set before)
+	 */
+	if (curr->softirqs_enabled)
+		if (!mark_held_locks(curr, 0, ip))
+			return;
+
+	curr->hardirq_enable_ip = ip;
+	curr->hardirq_enable_event = ++curr->irq_events;
+	debug_atomic_inc(&hardirqs_on_events);
+}
+
+EXPORT_SYMBOL(trace_hardirqs_on);
+
+/*
+ * Hardirqs were disabled:
+ */
+void trace_hardirqs_off(void)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks))
+		return;
+
+	if (DEBUG_WARN_ON(!irqs_disabled()))
+		return;
+
+	if (curr->hardirqs_enabled) {
+		/*
+		 * We have done an ON -> OFF transition:
+		 */
+		curr->hardirqs_enabled = 0;
+		curr->hardirq_disable_ip = _RET_IP_;
+		curr->hardirq_disable_event = ++curr->irq_events;
+		debug_atomic_inc(&hardirqs_off_events);
+	} else
+		debug_atomic_inc(&redundant_hardirqs_off);
+}
+
+EXPORT_SYMBOL(trace_hardirqs_off);
+
+/*
+ * Softirqs will be enabled:
+ */
+void trace_softirqs_on(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks))
+		return;
+
+	if (DEBUG_WARN_ON(!irqs_disabled()))
+		return;
+
+	if (curr->softirqs_enabled) {
+		debug_atomic_inc(&redundant_softirqs_on);
+		return;
+	}
+
+	/*
+	 * We'll do an OFF -> ON transition:
+	 */
+	curr->softirqs_enabled = 1;
+	curr->softirq_enable_ip = ip;
+	curr->softirq_enable_event = ++curr->irq_events;
+	debug_atomic_inc(&softirqs_on_events);
+	/*
+	 * We are going to turn softirqs on, so set the
+	 * usage bit for all held locks, if hardirqs are
+	 * enabled too:
+	 */
+	if (curr->hardirqs_enabled)
+		mark_held_locks(curr, 0, ip);
+}
+
+/*
+ * Softirqs were disabled:
+ */
+void trace_softirqs_off(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks))
+		return;
+
+	if (DEBUG_WARN_ON(!irqs_disabled()))
+		return;
+
+	if (curr->softirqs_enabled) {
+		/*
+		 * We have done an ON -> OFF transition:
+		 */
+		curr->softirqs_enabled = 0;
+		curr->softirq_disable_ip = ip;
+		curr->softirq_disable_event = ++curr->irq_events;
+		debug_atomic_inc(&softirqs_off_events);
+		DEBUG_WARN_ON(!softirq_count());
+	} else
+		debug_atomic_inc(&redundant_softirqs_off);
+}
+
+#endif
+
+/*
+ * Initialize a lock instance's lock-type mapping info:
+ */
+void lockdep_init_map(struct lockdep_map *lock, const char *name,
+		      struct lockdep_type_key *key)
+{
+	if (unlikely(!debug_locks))
+		return;
+
+	if (DEBUG_WARN_ON(!key))
+		return;
+
+	/*
+	 * Sanity check, the lock-type key must be persistent:
+	 */
+	if (!static_obj(key)) {
+		printk("BUG: key %p not in .data!\n", key);
+		DEBUG_WARN_ON(1);
+		return;
+	}
+	lock->name = name;
+	lock->key = key;
+	memset(lock->type, 0, sizeof(lock->type[0])*MAX_LOCKDEP_SUBTYPES);
+}
+
+EXPORT_SYMBOL_GPL(lockdep_init_map);
+
+/*
+ * This gets called for every mutex_lock*()/spin_lock*() operation.
+ * We maintain the dependency maps and validate the locking attempt:
+ */
+static int __lockdep_acquire(struct lockdep_map *lock, unsigned int subtype,
+			     int trylock, int read, int hardirqs_off,
+			     unsigned long ip)
+{
+	struct task_struct *curr = current;
+	struct held_lock *hlock;
+	struct lock_type *type;
+	unsigned int depth, id;
+	int chain_head = 0;
+	u64 chain_key;
+
+	if (unlikely(!debug_locks))
+		return 0;
+
+	if (DEBUG_WARN_ON(!irqs_disabled()))
+		return 0;
+
+	if (unlikely(subtype >= MAX_LOCKDEP_SUBTYPES)) {
+		debug_locks_off();
+		printk("BUG: MAX_LOCKDEP_SUBTYPES too low!\n");
+		printk("turning off the locking correctness validator.\n");
+		return 0;
+	}
+
+	type = lock->type[subtype];
+	/* not cached yet? */
+	if (unlikely(!type)) {
+		type = register_lock_type(lock, subtype);
+		if (!type)
+			return 0;
+	}
+	debug_atomic_inc((atomic_t *)&type->ops);
+
+	/*
+	 * Add the lock to the list of currently held locks.
+	 * (we dont increase the depth just yet, up until the
+	 * dependency checks are done)
+	 */
+	depth = curr->lockdep_depth;
+	if (DEBUG_WARN_ON(depth >= MAX_LOCK_DEPTH))
+		return 0;
+
+	hlock = curr->held_locks + depth;
+
+	hlock->type = type;
+	hlock->acquire_ip = ip;
+	hlock->instance = lock;
+	hlock->trylock = trylock;
+	hlock->read = read;
+	hlock->hardirqs_off = hardirqs_off;
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/*
+	 * If non-trylock use in a hardirq or softirq context, then
+	 * mark the lock as used in these contexts:
+	 */
+	if (!trylock) {
+		if (read) {
+			if (curr->hardirq_context)
+				if (!mark_lock(curr, hlock,
+						LOCK_USED_IN_HARDIRQ_READ, ip))
+					return 0;
+			if (curr->softirq_context)
+				if (!mark_lock(curr, hlock,
+						LOCK_USED_IN_SOFTIRQ_READ, ip))
+					return 0;
+		} else {
+			if (curr->hardirq_context)
+				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ, ip))
+					return 0;
+			if (curr->softirq_context)
+				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ, ip))
+					return 0;
+		}
+	}
+	if (!hardirqs_off) {
+		if (read) {
+			if (!mark_lock(curr, hlock,
+					LOCK_ENABLED_HARDIRQS_READ, ip))
+				return 0;
+			if (curr->softirqs_enabled)
+				if (!mark_lock(curr, hlock,
+						LOCK_ENABLED_SOFTIRQS_READ, ip))
+					return 0;
+		} else {
+			if (!mark_lock(curr, hlock,
+					LOCK_ENABLED_HARDIRQS, ip))
+				return 0;
+			if (curr->softirqs_enabled)
+				if (!mark_lock(curr, hlock,
+						LOCK_ENABLED_SOFTIRQS, ip))
+					return 0;
+		}
+	}
+#endif
+	/* mark it as used: */
+	if (!mark_lock(curr, hlock, LOCK_USED, ip))
+		return 0;
+	/*
+	 * Calculate the chain hash: it's the combined has of all the
+	 * lock keys along the dependency chain. We save the hash value
+	 * at every step so that we can get the current hash easily
+	 * after unlock. The chain hash is then used to cache dependency
+	 * results.
+	 *
+	 * The 'key ID' is what is the most compact key value to drive
+	 * the hash, not type->key.
+	 */
+	id = type - lock_types;
+	if (DEBUG_WARN_ON(id >= MAX_LOCKDEP_KEYS))
+		return 0;
+
+	chain_key = curr->curr_chain_key;
+	if (!depth) {
+		if (DEBUG_WARN_ON(chain_key != 0))
+			return 0;
+		chain_head = 1;
+	}
+
+	hlock->prev_chain_key = chain_key;
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/*
+	 * Keep track of points where we cross into an interrupt context:
+	 */
+	hlock->irq_context = 2*(curr->hardirq_context ? 1 : 0) +
+				curr->softirq_context;
+	if (depth) {
+		struct held_lock *prev_hlock;
+
+		prev_hlock = curr->held_locks + depth-1;
+		/*
+		 * If we cross into another context, reset the
+		 * hash key (this also prevents the checking and the
+		 * adding of the dependency to 'prev'):
+		 */
+		if (prev_hlock->irq_context != hlock->irq_context) {
+			chain_key = 0;
+			chain_head = 1;
+		}
+	}
+#endif
+	chain_key = iterate_chain_key(chain_key, id);
+	curr->curr_chain_key = chain_key;
+
+	/*
+	 * Trylock needs to maintain the stack of held locks, but it
+	 * does not add new dependencies, because trylock can be done
+	 * in any order.
+	 *
+	 * We look up the chain_key and do the O(N^2) check and update of
+	 * the dependencies only if this is a new dependency chain.
+	 * (If lookup_chain_cache() returns with 1 it acquires
+	 * hash_lock for us)
+	 */
+	if (!trylock && lookup_chain_cache(chain_key)) {
+		/*
+		 * Check whether last held lock:
+		 *
+		 * - is irq-safe, if this lock is irq-unsafe
+		 * - is softirq-safe, if this lock is hardirq-unsafe
+		 *
+		 * And check whether the new lock's dependency graph
+		 * could lead back to the previous lock.
+		 *
+		 * any of these scenarios could lead to a deadlock. If
+		 * All validations
+		 */
+		int ret = check_deadlock(curr, hlock, lock, read);
+
+		if (!ret)
+			return 0;
+		/*
+		 * Mark recursive read, as we jump over it when
+		 * building dependencies (just like we jump over
+		 * trylock entries):
+		 */
+		if (ret == 2)
+			hlock->read = 2;
+		/*
+		 * Add dependency only if this lock is not the head
+		 * of the chain, and if it's not a secondary read-lock:
+		 */
+		if (!chain_head && ret != 2)
+			if (!check_prevs_add(curr, hlock))
+				return 0;
+		__raw_spin_unlock(&hash_lock);
+	}
+	curr->lockdep_depth++;
+	check_chain_key(curr);
+	if (unlikely(curr->lockdep_depth >= MAX_LOCK_DEPTH)) {
+		debug_locks_off();
+		printk("BUG: MAX_LOCK_DEPTH too low!\n");
+		printk("turning off the locking correctness validator.\n");
+		return 0;
+	}
+	if (unlikely(curr->lockdep_depth > max_lockdep_depth))
+		max_lockdep_depth = curr->lockdep_depth;
+
+	return 1;
+}
+
+static int
+print_unlock_order_bug(struct task_struct *curr, struct lockdep_map *lock,
+		       struct held_lock *hlock, unsigned long ip)
+{
+	debug_locks_off();
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n======================================\n");
+	printk(  "[ BUG: bad unlock ordering detected! ]\n");
+	printk(  "--------------------------------------\n");
+	printk("%s/%d is trying to release lock (",
+		curr->comm, curr->pid);
+	print_lockdep_cache(lock);
+	printk(") at:\n");
+	printk_sym(ip);
+	printk("but the next lock to release is:\n");
+	print_lock(hlock);
+	printk("\nother info that might help us debug this:\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+static int
+print_unlock_inbalance_bug(struct task_struct *curr, struct lockdep_map *lock,
+			   unsigned long ip)
+{
+	debug_locks_off();
+	if (debug_locks_silent)
+		return 0;
+
+	printk("\n=====================================\n");
+	printk(  "[ BUG: bad unlock balance detected! ]\n");
+	printk(  "-------------------------------------\n");
+	printk("%s/%d is trying to release lock (",
+		curr->comm, curr->pid);
+	print_lockdep_cache(lock);
+	printk(") at:\n");
+	printk_sym(ip);
+	printk("but there are no more locks to release!\n");
+	printk("\nother info that might help us debug this:\n");
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+
+	return 0;
+}
+
+/*
+ * Common debugging checks for both nested and non-nested unlock:
+ */
+static int check_unlock(struct task_struct *curr, struct lockdep_map *lock,
+			unsigned long ip)
+{
+	if (unlikely(!debug_locks))
+		return 0;
+	if (DEBUG_WARN_ON(!irqs_disabled()))
+		return 0;
+
+	if (curr->lockdep_depth <= 0)
+		return print_unlock_inbalance_bug(curr, lock, ip);
+
+	return 1;
+}
+
+/*
+ * Remove the lock to the list of currently held locks - this gets
+ * called on mutex_unlock()/spin_unlock*() (or on a failed
+ * mutex_lock_interruptible()). This is done for unlocks that nest
+ * perfectly. (i.e. the current top of the lock-stack is unlocked)
+ */
+static int lockdep_release_nested(struct task_struct *curr,
+				  struct lockdep_map *lock, unsigned long ip)
+{
+	struct held_lock *hlock;
+	unsigned int depth;
+
+	/*
+	 * Pop off the top of the lock stack:
+	 */
+	depth = --curr->lockdep_depth;
+	hlock = curr->held_locks + depth;
+
+	if (hlock->instance != lock)
+		return print_unlock_order_bug(curr, lock, hlock, ip);
+
+	if (DEBUG_WARN_ON(!depth && (hlock->prev_chain_key != 0)))
+		return 0;
+
+	curr->curr_chain_key = hlock->prev_chain_key;
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+	hlock->prev_chain_key = 0;
+	hlock->type = NULL;
+	hlock->acquire_ip = 0;
+	hlock->irq_context = 0;
+#endif
+	return 1;
+}
+
+/*
+ * Remove the lock to the list of currently held locks in a
+ * potentially non-nested (out of order) manner. This is a
+ * relatively rare operation, as all the unlock APIs default
+ * to nested mode (which uses lockdep_release()):
+ */
+static int
+lockdep_release_non_nested(struct task_struct *curr,
+			   struct lockdep_map *lock, unsigned long ip)
+{
+	struct held_lock *hlock, *prev_hlock;
+	unsigned int depth;
+	int i;
+
+	/*
+	 * Check whether the lock exists in the current stack
+	 * of held locks:
+	 */
+	depth = curr->lockdep_depth;
+	if (DEBUG_WARN_ON(!depth))
+		return 0;
+
+	prev_hlock = NULL;
+	for (i = depth-1; i >= 0; i--) {
+		hlock = curr->held_locks + i;
+		/*
+		 * We must not cross into another context:
+		 */
+		if (prev_hlock && prev_hlock->irq_context != hlock->irq_context)
+			break;
+		if (hlock->instance == lock)
+			goto found_it;
+		prev_hlock = hlock;
+	}
+	return print_unlock_inbalance_bug(curr, lock, ip);
+
+found_it:
+	/*
+	 * We have the right lock to unlock, 'hlock' points to it.
+	 * Now we remove it from the stack, and add back the other
+	 * entries (if any), recalculating the hash along the way:
+	 */
+	curr->lockdep_depth = i;
+	curr->curr_chain_key = hlock->prev_chain_key;
+
+	for (i++; i < depth; i++) {
+		hlock = curr->held_locks + i;
+		if (!__lockdep_acquire(hlock->instance,
+			hlock->type->subtype, hlock->trylock,
+				hlock->read, hlock->hardirqs_off,
+				hlock->acquire_ip))
+			return 0;
+	}
+
+	if (DEBUG_WARN_ON(curr->lockdep_depth != depth - 1))
+		return 0;
+	return 1;
+}
+
+/*
+ * Remove the lock to the list of currently held locks - this gets
+ * called on mutex_unlock()/spin_unlock*() (or on a failed
+ * mutex_lock_interruptible()). This is done for unlocks that nest
+ * perfectly. (i.e. the current top of the lock-stack is unlocked)
+ */
+static void __lockdep_release(struct lockdep_map *lock, int nested,
+			      unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (!check_unlock(curr, lock, ip))
+		return;
+
+	if (nested) {
+		if (!lockdep_release_nested(curr, lock, ip))
+			return;
+	} else {
+		if (!lockdep_release_non_nested(curr, lock, ip))
+			return;
+	}
+
+	check_chain_key(curr);
+}
+
+/*
+ * Check whether we follow the irq-flags state precisely:
+ */
+static void check_flags(unsigned long flags)
+{
+#if defined(CONFIG_DEBUG_LOCKDEP) && defined(CONFIG_TRACE_IRQFLAGS)
+	if (!debug_locks)
+		return;
+
+	if (irqs_disabled_flags(flags))
+		DEBUG_WARN_ON(current->hardirqs_enabled);
+	else
+		DEBUG_WARN_ON(!current->hardirqs_enabled);
+
+	/*
+	 * We dont accurately track softirq state in e.g.
+	 * hardirq contexts (such as on 4KSTACKS), so only
+	 * check if not in hardirq contexts:
+	 */
+	if (!hardirq_count()) {
+		if (softirq_count())
+			DEBUG_WARN_ON(current->softirqs_enabled);
+		else
+			DEBUG_WARN_ON(!current->softirqs_enabled);
+	}
+
+	if (!debug_locks)
+		print_irqtrace_events(current);
+#endif
+}
+
+/*
+ * We are not always called with irqs disabled - do that here,
+ * and also avoid lockdep recursion:
+ */
+void lockdep_acquire(struct lockdep_map *lock, unsigned int subtype,
+		     int trylock, int read, unsigned long ip)
+{
+	unsigned long flags;
+
+	if (LOCKDEP_OFF)
+		return;
+
+	raw_local_irq_save(flags);
+	check_flags(flags);
+
+	if (unlikely(current->lockdep_recursion))
+		goto out;
+	current->lockdep_recursion = 1;
+	__lockdep_acquire(lock, subtype, trylock, read, irqs_disabled_flags(flags), ip);
+	current->lockdep_recursion = 0;
+out:
+	raw_local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL_GPL(lockdep_acquire);
+
+void lockdep_release(struct lockdep_map *lock, int nested, unsigned long ip)
+{
+	unsigned long flags;
+
+	if (LOCKDEP_OFF)
+		return;
+
+	raw_local_irq_save(flags);
+	check_flags(flags);
+	if (unlikely(current->lockdep_recursion))
+		goto out;
+	current->lockdep_recursion = 1;
+	__lockdep_release(lock, nested, ip);
+	current->lockdep_recursion = 0;
+out:
+	raw_local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL_GPL(lockdep_release);
+
+/*
+ * Used by the testsuite, sanitize the validator state
+ * after a simulated failure:
+ */
+
+void lockdep_reset(void)
+{
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	current->curr_chain_key = 0;
+	current->lockdep_depth = 0;
+	current->lockdep_recursion = 0;
+	memset(current->held_locks, 0, MAX_LOCK_DEPTH*sizeof(struct held_lock));
+	nr_hardirq_chains = 0;
+	nr_softirq_chains = 0;
+	nr_process_chains = 0;
+	debug_locks = 1;
+	raw_local_irq_restore(flags);
+}
+
+static void zap_type(struct lock_type *type)
+{
+	int i;
+
+	/*
+	 * Remove all dependencies this lock is
+	 * involved in:
+	 */
+	for (i = 0; i < nr_list_entries; i++) {
+		if (list_entries[i].type == type)
+			list_del_rcu(&list_entries[i].entry);
+	}
+	/*
+	 * Unhash the type and remove it from the all_lock_types list:
+	 */
+	list_del_rcu(&type->hash_entry);
+	list_del_rcu(&type->lock_entry);
+
+}
+
+static inline int within(void *addr, void *start, unsigned long size)
+{
+	return addr >= start && addr < start + size;
+}
+
+void lockdep_free_key_range(void *start, unsigned long size)
+{
+	struct lock_type *type, *next;
+	struct list_head *head;
+	unsigned long flags;
+	int i;
+
+	raw_local_irq_save(flags);
+	__raw_spin_lock(&hash_lock);
+
+	/*
+	 * Unhash all types that were created by this module:
+	 */
+	for (i = 0; i < TYPEHASH_SIZE; i++) {
+		head = typehash_table + i;
+		if (list_empty(head))
+			continue;
+		list_for_each_entry_safe(type, next, head, hash_entry)
+			if (within(type->key, start, size))
+				zap_type(type);
+	}
+
+	__raw_spin_unlock(&hash_lock);
+	raw_local_irq_restore(flags);
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	struct lock_type *type, *next, *entry;
+	struct list_head *head;
+	unsigned long flags;
+	int i, j;
+
+	raw_local_irq_save(flags);
+	__raw_spin_lock(&hash_lock);
+
+	/*
+	 * Remove all types this lock has:
+	 */
+	for (i = 0; i < TYPEHASH_SIZE; i++) {
+		head = typehash_table + i;
+		if (list_empty(head))
+			continue;
+		list_for_each_entry_safe(type, next, head, hash_entry) {
+			for (j = 0; j < MAX_LOCKDEP_SUBTYPES; j++) {
+				entry = lock->type[j];
+				if (type == entry) {
+					zap_type(type);
+					lock->type[j] = NULL;
+					break;
+				}
+			}
+		}
+	}
+
+	/*
+	 * Debug check: in the end all mapped types should
+	 * be gone.
+	 */
+	for (j = 0; j < MAX_LOCKDEP_SUBTYPES; j++) {
+		entry = lock->type[j];
+		if (!entry)
+			continue;
+		__raw_spin_unlock(&hash_lock);
+		DEBUG_WARN_ON(1);
+		raw_local_irq_restore(flags);
+		return;
+	}
+
+	__raw_spin_unlock(&hash_lock);
+	raw_local_irq_restore(flags);
+}
+
+void __init lockdep_init(void)
+{
+	int i;
+
+	/*
+	 * Some architectures have their own start_kernel()
+	 * code which calls lockdep_init(), while we also
+	 * call lockdep_init() from the start_kernel() itself,
+	 * and we want to initialize the hashes only once:
+	 */
+	if (lockdep_initialized)
+		return;
+
+	for (i = 0; i < TYPEHASH_SIZE; i++)
+		INIT_LIST_HEAD(typehash_table + i);
+
+	for (i = 0; i < CHAINHASH_SIZE; i++)
+		INIT_LIST_HEAD(chainhash_table + i);
+
+	lockdep_initialized = 1;
+}
+
+void __init lockdep_info(void)
+{
+	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
+
+	printk("... MAX_LOCKDEP_SUBTYPES:    %lu\n", MAX_LOCKDEP_SUBTYPES);
+	printk("... MAX_LOCK_DEPTH:          %lu\n", MAX_LOCK_DEPTH);
+	printk("... MAX_LOCKDEP_KEYS:        %lu\n", MAX_LOCKDEP_KEYS);
+	printk("... TYPEHASH_SIZE:           %lu\n", TYPEHASH_SIZE);
+	printk("... MAX_LOCKDEP_ENTRIES:     %lu\n", MAX_LOCKDEP_ENTRIES);
+	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
+	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
+
+	printk(" memory used by lock dependency info: %lu kB\n",
+		(sizeof(struct lock_type) * MAX_LOCKDEP_KEYS +
+		sizeof(struct list_head) * TYPEHASH_SIZE +
+		sizeof(struct lock_list) * MAX_LOCKDEP_ENTRIES +
+		sizeof(struct lock_chain) * MAX_LOCKDEP_CHAINS +
+		sizeof(struct list_head) * CHAINHASH_SIZE) / 1024);
+
+	printk(" per task-struct memory footprint: %lu bytes\n",
+		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+	if (lockdep_init_error)
+		printk("WARNING: lockdep init error! Arch code didnt call lockdep_init() early enough?\n");
+#endif
+}
+
Index: linux/kernel/lockdep_internals.h
===================================================================
--- /dev/null
+++ linux/kernel/lockdep_internals.h
@@ -0,0 +1,93 @@
+/*
+ * kernel/lockdep_internals.h
+ *
+ * Runtime locking correctness validator
+ *
+ * lockdep subsystem internal functions and variables.
+ */
+
+/*
+ * MAX_LOCKDEP_ENTRIES is the maximum number of lock dependencies
+ * we track.
+ *
+ * We use the per-lock dependency maps in two ways: we grow it by adding
+ * every to-be-taken lock to all currently held lock's own dependency
+ * table (if it's not there yet), and we check it for lock order
+ * conflicts and deadlocks.
+ */
+#define MAX_LOCKDEP_ENTRIES	8192UL
+
+#define MAX_LOCKDEP_KEYS_BITS	11
+#define MAX_LOCKDEP_KEYS	(1UL << MAX_LOCKDEP_KEYS_BITS)
+
+#define MAX_LOCKDEP_CHAINS_BITS	13
+#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
+
+/*
+ * Stack-trace: tightly packed array of stack backtrace
+ * addresses. Protected by the hash_lock.
+ */
+#define MAX_STACK_TRACE_ENTRIES	131072UL
+
+extern struct list_head all_lock_types;
+
+extern void
+get_usage_chars(struct lock_type *type, char *c1, char *c2, char *c3, char *c4);
+
+extern const char * __get_key_name(struct lockdep_subtype_key *key, char *str);
+
+extern unsigned long nr_lock_types;
+extern unsigned long nr_list_entries;
+extern unsigned long nr_lock_chains;
+extern unsigned long nr_stack_trace_entries;
+
+extern unsigned int nr_hardirq_chains;
+extern unsigned int nr_softirq_chains;
+extern unsigned int nr_process_chains;
+extern unsigned int max_lockdep_depth;
+extern unsigned int max_recursion_depth;
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+/*
+ * We cannot printk in early bootup code. Not even early_printk()
+ * might work. So we mark any initialization errors and printk
+ * about it later on, in lockdep_info().
+ */
+extern int lockdep_init_error;
+
+/*
+ * Various lockdep statistics:
+ */
+extern atomic_t chain_lookup_hits;
+extern atomic_t chain_lookup_misses;
+extern atomic_t hardirqs_on_events;
+extern atomic_t hardirqs_off_events;
+extern atomic_t redundant_hardirqs_on;
+extern atomic_t redundant_hardirqs_off;
+extern atomic_t softirqs_on_events;
+extern atomic_t softirqs_off_events;
+extern atomic_t redundant_softirqs_on;
+extern atomic_t redundant_softirqs_off;
+extern atomic_t nr_unused_locks;
+extern atomic_t nr_hardirq_safe_locks;
+extern atomic_t nr_softirq_safe_locks;
+extern atomic_t nr_hardirq_unsafe_locks;
+extern atomic_t nr_softirq_unsafe_locks;
+extern atomic_t nr_hardirq_read_safe_locks;
+extern atomic_t nr_softirq_read_safe_locks;
+extern atomic_t nr_hardirq_read_unsafe_locks;
+extern atomic_t nr_softirq_read_unsafe_locks;
+extern atomic_t nr_cyclic_checks;
+extern atomic_t nr_cyclic_check_recursions;
+extern atomic_t nr_find_usage_forwards_checks;
+extern atomic_t nr_find_usage_forwards_recursions;
+extern atomic_t nr_find_usage_backwards_checks;
+extern atomic_t nr_find_usage_backwards_recursions;
+# define debug_atomic_inc(ptr)		atomic_inc(ptr)
+# define debug_atomic_dec(ptr)		atomic_dec(ptr)
+# define debug_atomic_read(ptr)		atomic_read(ptr)
+#else
+# define debug_atomic_inc(ptr)		do { } while (0)
+# define debug_atomic_dec(ptr)		do { } while (0)
+# define debug_atomic_read(ptr)		0
+#endif
Index: linux/kernel/module.c
===================================================================
--- linux.orig/kernel/module.c
+++ linux/kernel/module.c
@@ -1151,6 +1151,9 @@ static void free_module(struct module *m
 	if (mod->percpu)
 		percpu_modfree(mod->percpu);
 
+	/* Free lock-types: */
+	lockdep_free_key_range(mod->module_core, mod->core_size);
+
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
 }
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -57,7 +57,7 @@ config DEBUG_KERNEL
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 21
-	default 17 if S390
+	default 17 if S390 || LOCKDEP
 	default 16 if X86_NUMAQ || IA64
 	default 15 if SMP
 	default 14
Index: linux/lib/locking-selftest.c
===================================================================
--- linux.orig/lib/locking-selftest.c
+++ linux/lib/locking-selftest.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/lockdep.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
@@ -872,9 +873,6 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_
 #include "locking-selftest-softirq.h"
 // GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft)
 
-#define lockdep_reset()
-#define lockdep_reset_lock(x)
-
 #ifdef CONFIG_PROVE_SPIN_LOCKING
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
 #else
