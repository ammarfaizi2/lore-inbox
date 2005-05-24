Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVEXVNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVEXVNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVEXVNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:13:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21176 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262188AbVEXVMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:12:05 -0400
Date: Tue, 24 May 2005 14:11:57 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
cc: linux-ia64@kvack.org
Subject: [RFC] Hierarchical BackOff Locks
Message-ID: <Pine.LNX.4.62.0505241401100.5688@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spinlocks cause a lot of contention if more than 4 processors are trying 
to acquire the lock. If a lock is under contention by more than 8 
processors then the majority of the time is spent waiting for spinlocks 
rather than doing productive work.

See http://www.sgi.com/products/software/linux/downloads/sync_linux.pdf

The contention could be limited by introducing a method for NUMA aware 
node backoff first proposed by Zoran Radovich called "HBO Locks". 
The patch here is just implementing the spinlock piece for ia64.

HBO locks can:

1. Detect the distance to the processor holding the lock.
2. Do a NUMA aware backoff so that local processors have a higher chance
   of getting to lock to avoid excessive transfer across the NUMA link
3. Avoid multiple processors from the same node trying to acquire the same
   remote lock.
4. Avoid starvation by an "angry" mode that forces another node to give up
   its ownership of the lock.
5. Have a fast uncontended case that is competitive with regular 
spinlocks.

Performance graphs are included in the paper. Performance benefits start 
at 8 processors and get up to 3 fold for 60 processors.

Does something like this have any chance of making it into the kernel?

Index: linux-2.6.11/include/asm-ia64/spinlock.h
===================================================================
--- linux-2.6.11.orig/include/asm-ia64/spinlock.h	2005-03-01 23:37:48.000000000 -0800
+++ linux-2.6.11/include/asm-ia64/spinlock.h	2005-05-24 13:54:21.000000000 -0700
@@ -11,7 +11,8 @@
 
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-
+#include <linux/config.h>
+#include <linux/cache.h>
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <asm/intrinsics.h>
@@ -24,10 +25,13 @@ typedef struct {
 #endif
 } spinlock_t;
 
+/* These definitions do not mean much. Lots of code for IA64 depends on
+ * zeroed memory containing unlocked spinlocks
+ */
 #define SPIN_LOCK_UNLOCKED			(spinlock_t) { 0 }
 #define spin_lock_init(x)			((x)->lock = 0)
 
-#ifdef ASM_SUPPORTED
+#if defined(ASM_SUPPORTED) & !defined(CONFIG_HBO_LOCKS)
 /*
  * Try to get the lock.  If we fail to get the lock, make a non-standard call to
  * ia64_spinlock_contention().  We do not use a normal call because that would force all
@@ -95,6 +99,35 @@ _raw_spin_lock_flags (spinlock_t *lock, 
 }
 #define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
 #else /* !ASM_SUPPORTED */
+
+#ifdef CONFIG_HBO_LOCKS
+
+void hbo_spinlock_contention(__u32 *, unsigned long, unsigned long);
+void hbo_spinlock_wait_remote(__u32 *, unsigned long);
+
+struct node_lock_s {
+	void *spin_at;
+} ____cacheline_aligned;
+
+extern struct node_lock_s ndata[MAX_NUMNODES];
+
+#define _raw_spin_lock_flags(__x, __flags)						\
+do {											\
+	__u32 *ia64_spinlock_ptr = (__u32 *) (__x);					\
+	__u64 ia64_spinlock_val;							\
+							\
+	if (unlikely(ndata[numa_node_id()].spin_at == ia64_spinlock_ptr))		\
+		hbo_spinlock_wait_remote(ia64_spinlock_ptr, __flags);			\
+							\
+	ia64_spinlock_val = ia64_cmpxchg4_acq(ia64_spinlock_ptr, numa_node_id()+ 1, 0);	\
+							\
+	if (unlikely(ia64_spinlock_val))						\
+		hbo_spinlock_contention(ia64_spinlock_ptr, ia64_spinlock_val, __flags);	\
+} while (0)
+
+#define _raw_spin_lock(lock) _raw_spin_lock_flags(lock, 0)
+
+#else
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
 # define _raw_spin_lock(x)								\
 do {											\
@@ -109,11 +142,16 @@ do {											\
 		} while (ia64_spinlock_val);						\
 	}										\
 } while (0)
+#endif
 #endif /* !ASM_SUPPORTED */
 
 #define spin_is_locked(x)	((x)->lock != 0)
 #define _raw_spin_unlock(x)	do { barrier(); ((spinlock_t *) x)->lock = 0; } while (0)
+#ifdef CONFIG_HBO_LOCKS
+#define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, numa_node_id() + 1) == 0)
+#else
 #define _raw_spin_trylock(x)	(cmpxchg_acq(&(x)->lock, 0, 1) == 0)
+#endif
 #define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
 
 typedef struct {
Index: linux-2.6.11/arch/ia64/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/ia64/Kconfig	2005-05-24 13:40:29.000000000 -0700
+++ linux-2.6.11/arch/ia64/Kconfig	2005-05-24 13:40:46.000000000 -0700
@@ -296,6 +296,19 @@ config PREEMPT
           Say Y here if you are building a kernel for a desktop, embedded
           or real-time system.  Say N if you are unsure.
 
+config HBO_LOCKS
+	bool "HBO GT SD Locks"
+	help
+	depends on (SMP && NUMA)
+	default y
+	help
+	  HBO locks reduces contention for spinlocks by saving the node id when the
+	  lock is taken. The cpu waiting on the spinlock can then select an appropriate
+	  backoff algorithm depending on the distance to the node. This also insures that
+	  it is highly likely that another cpu on the same node gets to a spinlock before
+	  remote nodes to avoid too much cacheline bouncing. A node may "get angry" in
+	  order to avoid starvation and stop local nodes from getting the lock.
+
 config HAVE_DEC_LOCK
 	bool
 	depends on (SMP || PREEMPT)
Index: linux-2.6.11/arch/ia64/mm/numa.c
===================================================================
--- linux-2.6.11.orig/arch/ia64/mm/numa.c	2005-03-01 23:37:52.000000000 -0800
+++ linux-2.6.11/arch/ia64/mm/numa.c	2005-05-24 13:40:46.000000000 -0700
@@ -17,9 +17,11 @@
 #include <linux/node.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/proc_fs.h>
+#include <linux/nodemask.h>
 #include <asm/mmzone.h>
 #include <asm/numa.h>
-
+#include <asm/uaccess.h>
 
 /*
  * The following structures are usually initialized by ACPI or
@@ -47,3 +49,296 @@ paddr_to_nid(unsigned long paddr)
 
 	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
 }
+
+#ifdef CONFIG_HBO_LOCKS
+
+struct node_lock_s ndata[MAX_NUMNODES];
+
+/* Counters and statistics available via /proc/hbo */
+struct hbo_c_s {
+	unsigned long contention;
+	unsigned long local_block;
+	unsigned long remote_block;
+	unsigned long remote_lock;
+	unsigned long retry;
+};
+
+DEFINE_PER_CPU(struct hbo_c_s, counters);
+
+#define INC_HC(member) __get_cpu_var(counters).member++
+#define DEC_HC(member) __get_cpu_var(counters).member--
+
+static inline void maybe_enable_irq(unsigned long flags)
+{
+	if (flags & IA64_PSR_I_BIT)
+	 	local_irq_enable();
+}
+
+static inline void maybe_disable_irq(unsigned long flags)
+{
+	if (flags & IA64_PSR_I_BIT)
+		local_irq_disable();
+}
+
+/*
+ * Number of retries until we get so angry that we block the locks from the
+ * node they originate from
+ */
+static unsigned int anger_limit = 50;
+static unsigned int backoff_factor = 2*8;
+/*
+ * Backoff parameters for node local locks
+ */
+static unsigned int local_backoff = 20;
+static unsigned int local_cap = 20;
+
+/*
+ * Backoff parameters for the case that a lock is held
+ * by a processor on a remote node
+ */
+static unsigned int remote_backoff = 1000;
+static unsigned int remote_cap = 200000;
+
+void hbo_spinlock_contention(__u32 *lock, unsigned long lockval, unsigned long flags)
+{
+	INC_HC(contention);
+	do {
+		unsigned int backoff = local_backoff;
+		unsigned int cap = local_cap;
+		unsigned int remote = 0;
+		unsigned int anger_level = 0;
+		unsigned int stopped_nodes = 0;
+
+		maybe_enable_irq(flags);
+
+		if (unlikely(lockval-1 != numa_node_id())) {
+			/* remote backoff */
+			backoff = remote_backoff;
+			cap = remote_cap;
+			/*
+			 * Make sure that no other cpu of this node tries
+			 * to acquire the same remote lock.
+			 */
+			ndata[numa_node_id()].spin_at = lock;
+			remote = 1;
+			INC_HC(remote_lock);
+		}
+
+		for(;;) {
+			int i;
+
+			for(i = 0; i < backoff; i++)
+				cpu_relax();
+
+			/* Increase backoff for next cycle */
+			backoff = min(((backoff * backoff_factor) << 8), cap);
+
+			ia64_barrier();
+
+			/* No cmpxchg so that we will not get an exclusive cache line */
+			lockval = *lock;
+
+			if (likely(lockval ==0))
+				break;
+
+			if (remote) {
+				anger_level++;
+				if (anger_level == anger_limit) {
+					INC_HC(remote_block);
+					/*
+					 * Block any remote threads that attempt
+					 * to get the lock and make them spin locally
+					 * on that node.
+					 */
+					ndata[lockval-1].spin_at = lock;
+					stopped_nodes++;
+					/*
+					 * Use local backoff instead of remote
+					 * to have more of a chance to get the lock
+					 */
+					backoff = local_backoff;
+					cap = local_backoff;
+					anger_level = 0;
+				}
+			}
+
+		};
+
+		maybe_disable_irq(flags);
+		INC_HC(retry);
+		/* Lock was unlocked. Now use cmpxchg acquiring an exclusive cache line */
+		lockval = ia64_cmpxchg4_acq(lock, numa_node_id()+1, 0);
+
+		/* Release eventually spinning other cpus on this node since either
+		 * the lock has been acquired by this cpu or the node holding the lock
+		 * may have changed.
+		 */
+		if (unlikely(remote)) {
+			/* Remove off-node block */
+			ndata[numa_node_id()].spin_at = NULL;
+			if (stopped_nodes) {
+				int i;
+				/*
+				 * Remove any remote blocks we established when we
+				 * got angry
+				 */
+				for_each_online_node(i)
+					cmpxchg(&(ndata[i].spin_at), lock, NULL);
+			}
+		}
+
+        } while (likely(lockval));
+}
+
+void hbo_spinlock_wait_remote(__u32 *lock, unsigned long flags)
+{
+	INC_HC(local_block);
+	maybe_enable_irq(flags);
+	while (ndata[numa_node_id()].spin_at == lock)
+		cpu_relax();
+	maybe_disable_irq(flags);
+}
+
+static int hbo_read_proc(char *page, char **start, off_t off,
+	int count, int *eof, void *data)
+{
+	int cpu = (long)data;
+	struct hbo_c_s summary, *x;
+	int n;
+	int len;
+
+	if (cpu >=0)
+		x = &per_cpu(counters, cpu);
+	else {
+		memcpy(&summary, &per_cpu(counters, 0), sizeof(summary));
+		for(n = 1; n < num_possible_cpus(); n++) {
+                        struct hbo_c_s *c = &per_cpu(counters, n);
+
+			summary.contention += c->contention;
+			summary.local_block += c->local_block;
+			summary.remote_block += c->remote_block;
+			summary.remote_lock += c->remote_lock;
+			summary.retry += c->retry;
+		}
+		x = &summary;
+	}
+
+	len = 0;
+	len += sprintf(page+len, "Contentions      : %lu\n",x->contention);
+	len += sprintf(page+len, "Remote Lock      : %lu\n",x->remote_lock);
+	len += sprintf(page+len, "Retry            : %lu\n",x->retry);
+	len += sprintf(page+len, "Local block      : %lu\n",x->local_block);
+	len += sprintf(page+len, "Remote block     : %lu\n",x->remote_block);
+
+	if (len <= off+count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count)
+		len = count;
+	if (len<0)
+		len = 0;
+        return len;
+}
+
+static int hbo_reset_write(struct file *file, const char __user *buffer,
+	unsigned long count, void *data)
+{
+	int i;
+
+	for (i = 0; i < num_possible_cpus(); i++) {
+		struct hbo_c_s *c = &per_cpu(counters, i);
+		memset(c, 0, sizeof(struct hbo_c_s));
+	}
+	return count;
+}
+
+static int hbo_write_int(struct file *file, const char __user *buffer,
+	unsigned long count, void *data)
+{
+	unsigned int * v = data;
+	char c[11];
+
+	if (count < 1)
+		return -EINVAL;
+
+	if (copy_from_user(c, buffer, 10))
+		return -EFAULT;
+
+	*v = simple_strtoul(buffer,NULL, 10);
+	return count;
+}
+
+static int hbo_read_int(char *page, char **start, off_t off, int count,
+			int *eof, void *data)
+{
+	unsigned int *v = data;
+	int len;
+
+	len = sprintf(page, "%u\n",*v);
+	if (len <= off+count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count)
+		len = count;
+	if (len<0)
+		len = 0;
+	return len;
+}
+
+static __init int init_hbolock(void)
+{
+	int i;
+	struct proc_dir_entry *proc_hbo, *hbo_reset, *x;
+
+	proc_hbo = proc_mkdir("hbo",NULL);
+	hbo_reset = create_proc_entry("reset", S_IWUGO, proc_hbo);
+	hbo_reset->write_proc = hbo_reset_write;
+
+	x = create_proc_entry("all", S_IRUGO, proc_hbo);
+	x->read_proc = &hbo_read_proc;
+	x->data = (void *)-1;
+
+	/* ints */
+	x = create_proc_entry("local_backoff", 0664, proc_hbo);
+	x->read_proc = hbo_read_int;
+	x->write_proc = hbo_write_int;
+	x->data = &local_backoff;
+	x = create_proc_entry("local_cap", 0664, proc_hbo);
+	x->read_proc = hbo_read_int;
+	x->write_proc = hbo_write_int;
+	x->data = &local_cap;
+	x = create_proc_entry("remote_backoff", 0664, proc_hbo);
+	x->read_proc = hbo_read_int;
+	x->write_proc = hbo_write_int;
+	x->data = &remote_backoff;
+	x = create_proc_entry("remote_cap", 0664, proc_hbo);
+	x->read_proc = hbo_read_int;
+	x->write_proc = hbo_write_int;
+	x->data = &remote_cap;
+	x = create_proc_entry("backoff_factor", 0664, proc_hbo);
+	x->read_proc = hbo_read_int;
+	x->write_proc = hbo_write_int;
+	x->data = &backoff_factor;
+	x = create_proc_entry("anger_limit", 0664, proc_hbo);
+	x->read_proc = hbo_read_int;
+	x->write_proc = hbo_write_int;
+	x->data = &anger_limit;
+
+	for(i = 0; i < num_possible_cpus(); i++) {
+		char name[20];
+		struct proc_dir_entry *p;
+
+		sprintf(name, "%d", i);
+		p = create_proc_entry(name, S_IRUGO, proc_hbo);
+
+		p->read_proc = hbo_read_proc;
+		p->data = (void *)(unsigned long)i;
+	}
+	return 0;
+}
+
+__initcall(init_hbolock);
+#endif
+
