Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269357AbUINOxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbUINOxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUINOxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:53:38 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:3552 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269357AbUINOqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:46:30 -0400
Date: Tue, 14 Sep 2004 07:45:42 -0700 (PDT)
From: Ray Bryant <raybry@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: John Hawkes <hawkes@sgi.com>, Keith Owens <kaos@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Ray Bryant <raybry@sgi.com>,
       lse-tech@lists.sourceforge.net, Dan Higgins <djh@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040914144542.17727.30900.71726@tomahawk.engr.sgi.com>
Subject: [PATCH 1/1] lockmeter: lockmeter for out-of-line-spinlocks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This version of the lockmeter patch has been updated to work with
the out-of-line spinlocks that were recently merged into the mainline.
Basically what is done here is that if CONFIG_LOCKMETER is set, then the
lock routines in kernel/spinlock.c are not used and the corresponding
versions in kernel/lockmeter.c are used instead.  The former set of
lock routines call _raw_ spin lock code defined by the architecture;
the latter call _metered_ versions of the spinlock routines, which in
turn call the _raw_ routines.  The versions in the two files will have
to kept in sync manually, but given that the lock APIs don't change
very often, that should be ok.  The lockmeter.c versions are written
so that the address of the original caller is passed to the _metered_
lock routines; elsewise all lock requests would look like they were
coming from the lockmeter.c versions of the lock routine.

I've had trouble testing this on an Altix so have really only tested this
on i386.  But the changes are almost exclusively in machine independent
code so that should be ok.  I did do some fixup in the Sparc64 arch files,
so someone with such a box should test this stuff.

The existing lockstat routine will work with this patch, although we have
had to add some "#include <errno.h>" lines to that program to get it to
compile properly.  An updated version of lockstat will be posted to
oss.sgi.com in the near future.

Signed-off-by: Ray Bryant <raybry@sgi.com>

=========================================================================

DESC
ia64 CONFIG_LOCKMETER fix
EDESC
From: John Hawkes <hawkes@babylon.engr.sgi.com>

The 2.6.3-mm4 patch seems to have the CONFIG_LOCKMETER in the wrong spot
for ia64.  When I make this change, I can build and run an ia64
Lockmeter'ed kernel.
DESC
lockmeter-build-fix
EDESC
DESC
lockmeter for x86_64
EDESC
From: Alexander Nyberg <alexn@telia.com>

This is basically a cut and paste from i386 code.  At some places however
some unresolved addresses at places like [0x1000211eb38] shows up, which is
a bit weird.  I'm hoping for a comment from any of the SGI guys, as the
code is so similar to i386 I don't know if problem lies below or in the
generic code.

Signed-off-by: Andrew Morton <akpm@osdl.org>
 arch/i386/Kconfig.debug         |    7 
 arch/i386/lib/dec_and_lock.c    |    3 
 arch/ia64/Kconfig.debug         |    7 
 arch/ia64/lib/dec_and_lock.c    |    2 
 arch/sparc64/Kconfig.debug      |    9 
 arch/x86_64/Kconfig.debug       |    7 
 arch/x86_64/lib/dec_and_lock.c  |    2 
 fs/proc/proc_misc.c             |   37 +
 include/asm-alpha/lockmeter.h   |   84 ++
 include/asm-alpha/spinlock.h    |   50 +
 include/asm-i386/lockmeter.h    |  115 +++
 include/asm-i386/spinlock.h     |   69 +
 include/asm-ia64/lockmeter.h    |   72 +
 include/asm-ia64/spinlock.h     |   73 ++
 include/asm-mips/lockmeter.h    |  126 +++
 include/asm-mips/spinlock.h     |    9 
 include/asm-sparc64/lockmeter.h |   45 +
 include/asm-x86_64/lockmeter.h  |  102 ++
 include/asm-x86_64/spinlock.h   |   69 +
 include/linux/lockmeter.h       |  320 ++++++++
 include/linux/spinlock.h        |   11 
 kernel/Makefile                 |    5 
 kernel/lockmeter.c              | 1460 ++++++++++++++++++++++++++++++++++++++++
 23 files changed, 2672 insertions(+), 12 deletions(-)

Index: linus-2.6.9-rc1-bk-09-10-04/arch/i386/Kconfig.debug
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/i386/Kconfig.debug	2004-09-10 09:48:51.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/i386/Kconfig.debug	2004-09-13 15:42:32.000000000 -0700
@@ -67,6 +67,13 @@
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config LOCKMETER
+	bool "Kernel lock metering"
+	depends on SMP
+	help
+	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+	  but allows you to see various statistics using the lockstat command.
+
 config X86_FIND_SMP_CONFIG
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
Index: linus-2.6.9-rc1-bk-09-10-04/arch/i386/lib/dec_and_lock.c
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/i386/lib/dec_and_lock.c	2004-09-10 09:48:31.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/i386/lib/dec_and_lock.c	2004-09-13 15:42:32.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
+#ifndef ATOMIC_DEC_AND_LOCK
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	int counter;
@@ -38,3 +39,5 @@
 	spin_unlock(lock);
 	return 0;
 }
+#endif
+
Index: linus-2.6.9-rc1-bk-09-10-04/arch/ia64/Kconfig.debug
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/ia64/Kconfig.debug	2004-09-10 09:48:48.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/ia64/Kconfig.debug	2004-09-13 15:42:32.000000000 -0700
@@ -61,4 +61,11 @@
 	depends on COMPAT && SYSVIPC
 	default y
 
+config LOCKMETER
+       bool "Kernel lock metering"
+       depends on SMP
+       help
+         Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+         but allows you to see various statistics using the lockstat command.
+
 endmenu
Index: linus-2.6.9-rc1-bk-09-10-04/arch/ia64/lib/dec_and_lock.c
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/ia64/lib/dec_and_lock.c	2004-09-10 09:49:07.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/ia64/lib/dec_and_lock.c	2004-09-13 15:42:32.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
+#ifndef CONFIG_LOCKMETER
 /*
  * Decrement REFCOUNT and if the count reaches zero, acquire the spinlock.  Both of these
  * operations have to be done atomically, so that the count doesn't drop to zero without
@@ -40,3 +41,4 @@
 }
 
 EXPORT_SYMBOL(atomic_dec_and_lock);
+#endif
Index: linus-2.6.9-rc1-bk-09-10-04/arch/sparc64/Kconfig.debug
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/sparc64/Kconfig.debug	2004-09-10 09:48:45.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/sparc64/Kconfig.debug	2004-09-13 15:42:32.000000000 -0700
@@ -33,12 +33,19 @@
 	depends on DEBUG_KERNEL
 	bool "Debug BOOTMEM initialization"
 
+config LOCKMETER
+	bool "Kernel lock metering"
+	depends on SMP && !PREEMPT
+	help
+	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+	  but allows you to see various statistics using the lockstat command.
+
 # We have a custom atomic_dec_and_lock() implementation but it's not
 # compatible with spinlock debugging so we need to fall back on
 # the generic version in that case.
 config HAVE_DEC_LOCK
 	bool
-	depends on SMP && !DEBUG_SPINLOCK
+	depends on SMP && !DEBUG_SPINLOCK && !LOCKMETER
 	default y
 
 config MCOUNT
Index: linus-2.6.9-rc1-bk-09-10-04/arch/x86_64/Kconfig.debug
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/x86_64/Kconfig.debug	2004-09-10 09:48:28.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/x86_64/Kconfig.debug	2004-09-13 15:42:32.000000000 -0700
@@ -65,4 +65,11 @@
 #config X86_REMOTE_DEBUG
 #       bool "kgdb debugging stub"
 
+config LOCKMETER
+	bool "Kernel lock metering"
+	depends on SMP
+	help
+	  Say Y to enable kernel lock metering, which adds overhead to SMP locks,
+	  but allows you to see various statistics using the lockstat command.
+
 endmenu
Index: linus-2.6.9-rc1-bk-09-10-04/arch/x86_64/lib/dec_and_lock.c
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/arch/x86_64/lib/dec_and_lock.c	2004-09-10 09:48:50.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/arch/x86_64/lib/dec_and_lock.c	2004-09-13 15:42:32.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
+#ifndef ATOMIC_DEC_AND_LOCK
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	int counter;
@@ -38,3 +39,4 @@
 	spin_unlock(lock);
 	return 0;
 }
+#endif
Index: linus-2.6.9-rc1-bk-09-10-04/fs/proc/proc_misc.c
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/fs/proc/proc_misc.c	2004-09-10 09:48:27.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/fs/proc/proc_misc.c	2004-09-13 15:42:32.000000000 -0700
@@ -573,6 +573,36 @@
 		entry->proc_fops = f;
 }
 
+#ifdef CONFIG_LOCKMETER
+extern ssize_t get_lockmeter_info(char *, size_t, loff_t *);
+extern ssize_t put_lockmeter_info(const char *, size_t);
+extern int get_lockmeter_info_size(void);
+
+/*
+ * This function accesses lock metering information.
+ */
+static ssize_t read_lockmeter(struct file *file, char *buf,
+			      size_t count, loff_t *ppos)
+{
+	return get_lockmeter_info(buf, count, ppos);
+}
+
+/*
+ * Writing to /proc/lockmeter resets the counters
+ */
+static ssize_t write_lockmeter(struct file * file, const char * buf,
+			       size_t count, loff_t *ppos)
+{
+	return put_lockmeter_info(buf, count);
+}
+
+static struct file_operations proc_lockmeter_operations = {
+	NULL,           /* lseek */
+	read:		read_lockmeter,
+	write:		write_lockmeter,
+};
+#endif  /* CONFIG_LOCKMETER */
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -633,6 +663,13 @@
 	if (entry)
 		entry->proc_fops = &proc_sysrq_trigger_operations;
 #endif
+#ifdef CONFIG_LOCKMETER
+	entry = create_proc_entry("lockmeter", S_IWUSR | S_IRUGO, NULL);
+	if (entry) {
+		entry->proc_fops = &proc_lockmeter_operations;
+		entry->size = get_lockmeter_info_size();
+	}
+#endif
 #ifdef CONFIG_PPC32
 	{
 		extern struct file_operations ppc_htab_operations;
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-alpha/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-alpha/lockmeter.h	2004-09-13 15:42:32.000000000 -0700
@@ -0,0 +1,84 @@
+/*
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ *
+ *  Modified by Peter Rival (frival@zk3.dec.com)
+ */
+
+#ifndef _ALPHA_LOCKMETER_H
+#define _ALPHA_LOCKMETER_H
+
+#include <asm/hwrpb.h>
+#define CPU_CYCLE_FREQUENCY	hwrpb->cycle_freq
+
+#define get_cycles64()		get_cycles()
+
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+#include <linux/version.h>
+
+#define SPINLOCK_MAGIC_INIT /**/
+
+/*
+ * Macros to cache and retrieve an index value inside of a lock
+ * these macros assume that there are less than 65536 simultaneous
+ * (read mode) holders of a rwlock.
+ * We also assume that the hash table has less than 32767 entries.
+ * the high order bit is used for write locking a rw_lock
+ * Note: although these defines and macros are the same as what is being used
+ *       in include/asm-i386/lockmeter.h, they are present here to easily
+ *	 allow an alternate Alpha implementation.
+ */
+/*
+ * instrumented spinlock structure -- never used to allocate storage
+ * only used in macros below to overlay a spinlock_t
+ */
+typedef struct inst_spinlock_s {
+	/* remember, Alpha is little endian */
+	unsigned short lock;
+	unsigned short index;
+} inst_spinlock_t;
+#define PUT_INDEX(lock_ptr,indexv)	((inst_spinlock_t *)(lock_ptr))->index = indexv
+#define GET_INDEX(lock_ptr)		((inst_spinlock_t *)(lock_ptr))->index
+
+/*
+ * macros to cache and retrieve an index value in a read/write lock
+ * as well as the cpu where a reader busy period started
+ * we use the 2nd word (the debug word) for this, so require the
+ * debug word to be present
+ */
+/*
+ * instrumented rwlock structure -- never used to allocate storage
+ * only used in macros below to overlay a rwlock_t
+ */
+typedef struct inst_rwlock_s {
+	volatile int lock;
+	unsigned short index;
+	unsigned short cpu;
+} inst_rwlock_t;
+#define PUT_RWINDEX(rwlock_ptr,indexv)	((inst_rwlock_t *)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)		((inst_rwlock_t *)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)	((inst_rwlock_t *)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)		((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return true if rwlock is write locked
+ * (note that other lock attempts can cause the lock value to be negative)
+ */
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) (((inst_rwlock_t *)rwlock_ptr)->lock & 1)
+#define IABS(x) ((x) > 0 ? (x) : -(x))
+
+#define RWLOCK_READERS(rwlock_ptr)	rwlock_readers(rwlock_ptr)
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+	int tmp = (int) ((inst_rwlock_t *)rwlock_ptr)->lock;
+	/* readers subtract 2, so we have to:		*/
+	/* 	- andnot off a possible writer (bit 0)	*/
+	/*	- get the absolute value		*/
+	/*	- divide by 2 (right shift by one)	*/
+	/* to find the number of readers		*/
+	if (tmp == 0) return(0);
+	else return(IABS(tmp & ~1)>>1);
+}
+
+#endif /* _ALPHA_LOCKMETER_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-alpha/spinlock.h
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/include/asm-alpha/spinlock.h	2004-09-10 09:48:57.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-alpha/spinlock.h	2004-09-13 15:42:32.000000000 -0700
@@ -6,6 +6,10 @@
 #include <linux/kernel.h>
 #include <asm/current.h>
 
+#ifdef CONFIG_LOCKMETER
+#undef DEBUG_SPINLOCK
+#undef DEBUG_RWLOCK
+#endif
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -96,9 +100,18 @@
 
 typedef struct {
 	volatile int write_lock:1, read_counter:31;
+#ifdef CONFIG_LOCKMETER
+	/* required for LOCKMETER since all bits in lock are used */
+	/* need this storage for CPU and lock INDEX ............. */
+	unsigned magic;
+#endif
 } /*__attribute__((aligned(32)))*/ rwlock_t;
 
+#ifdef CONFIG_LOCKMETER
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0, 0 }
+#else
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#endif
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x)	(*(volatile int *)(x) != 0)
@@ -170,4 +183,41 @@
 	: "m" (*lock) : "memory");
 }
 
+#ifdef CONFIG_LOCKMETER
+static inline int _raw_write_trylock(rwlock_t *lock)
+{
+	long temp,result;
+
+	__asm__ __volatile__(
+	"	ldl_l %1,%0\n"
+	"	mov $31,%2\n"
+	"	bne %1,1f\n"
+	"	or $31,1,%2\n"
+	"	stl_c %2,%0\n"
+	"1:	mb\n"
+	: "=m" (*(volatile int *)lock), "=&r" (temp), "=&r" (result)
+	: "m" (*(volatile int *)lock)
+	);
+
+	return (result);
+}
+
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+	unsigned long temp,result;
+
+	__asm__ __volatile__(
+	"	ldl_l %1,%0\n"
+	"	mov $31,%2\n"
+	"	blbs %1,1f\n"
+	"	subl %1,2,%2\n"
+	"	stl_c %2,%0\n"
+	"1:	mb\n"
+	: "=m" (*(volatile int *)lock), "=&r" (temp), "=&r" (result)
+	: "m" (*(volatile int *)lock)
+	);
+	return (result);
+}
+#endif /* CONFIG_LOCKMETER */
+
 #endif /* _ALPHA_SPINLOCK_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-i386/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-i386/lockmeter.h	2004-09-13 15:42:32.000000000 -0700
@@ -0,0 +1,115 @@
+/*
+ *  Copyright (C) 1999,2000 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ *
+ *  Modified by Ray Bryant (raybry@us.ibm.com)
+ *  Changes Copyright (C) 2000 IBM, Inc.
+ *  Added save of index in spinlock_t to improve efficiency
+ *  of "hold" time reporting for spinlocks.
+ *  Added support for hold time statistics for read and write
+ *  locks.
+ *  Moved machine dependent code here from include/lockmeter.h.
+ *
+ */
+
+#ifndef _I386_LOCKMETER_H
+#define _I386_LOCKMETER_H
+
+#include <asm/spinlock.h>
+#include <asm/rwlock.h>
+
+#include <linux/version.h>
+
+#ifdef __KERNEL__
+extern unsigned long cpu_khz;
+#define CPU_CYCLE_FREQUENCY	(cpu_khz * 1000)
+#else
+#define CPU_CYCLE_FREQUENCY	450000000
+#endif
+
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+/*
+ * macros to cache and retrieve an index value inside of a spin lock
+ * these macros assume that there are less than 65536 simultaneous
+ * (read mode) holders of a rwlock.  Not normally a problem!!
+ * we also assume that the hash table has less than 65535 entries.
+ */
+/*
+ * instrumented spinlock structure -- never used to allocate storage
+ * only used in macros below to overlay a spinlock_t
+ */
+typedef struct inst_spinlock_s {
+	/* remember, Intel is little endian */
+	unsigned short lock;
+	unsigned short index;
+} inst_spinlock_t;
+#define PUT_INDEX(lock_ptr,indexv) ((inst_spinlock_t *)(lock_ptr))->index = indexv
+#define GET_INDEX(lock_ptr)        ((inst_spinlock_t *)(lock_ptr))->index
+
+/*
+ * macros to cache and retrieve an index value in a read/write lock
+ * as well as the cpu where a reader busy period started
+ * we use the 2nd word (the debug word) for this, so require the
+ * debug word to be present
+ */
+/*
+ * instrumented rwlock structure -- never used to allocate storage
+ * only used in macros below to overlay a rwlock_t
+ */
+typedef struct inst_rwlock_s {
+	volatile int lock;
+	unsigned short index;
+	unsigned short cpu;
+} inst_rwlock_t;
+#define PUT_RWINDEX(rwlock_ptr,indexv) ((inst_rwlock_t *)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)        ((inst_rwlock_t *)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    ((inst_rwlock_t *)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)         ((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return the number of readers for a rwlock_t
+ */
+#define RWLOCK_READERS(rwlock_ptr)   rwlock_readers(rwlock_ptr)
+
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+	int tmp = (int) rwlock_ptr->lock;
+	/* read and write lock attempts may cause the lock value to temporarily */
+	/* be negative.  Until it is >= 0 we know nothing (i. e. can't tell if  */
+	/* is -1 because it was write locked and somebody tried to read lock it */
+	/* or if it is -1 because it was read locked and somebody tried to write*/
+	/* lock it. ........................................................... */
+	do {
+		tmp = (int) rwlock_ptr->lock;
+	} while (tmp < 0);
+	if (tmp == 0) return(0);
+	else return(RW_LOCK_BIAS-tmp);
+}
+
+/*
+ * return true if rwlock is write locked
+ * (note that other lock attempts can cause the lock value to be negative)
+ */
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) ((rwlock_ptr)->lock <= 0)
+#define IABS(x) ((x) > 0 ? (x) : -(x))
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)  ((IABS((rwlock_ptr)->lock) % RW_LOCK_BIAS) != 0)
+
+/* this is a lot of typing just to get gcc to emit "rdtsc" */
+static inline long long get_cycles64 (void)
+{
+	union longlong_u {
+		long long intlong;
+		struct intint_s {
+			uint32_t eax;
+			uint32_t edx;
+		} intint;
+	} longlong;
+
+	rdtsc(longlong.intint.eax,longlong.intint.edx);
+	return longlong.intlong;
+}
+
+#endif /* _I386_LOCKMETER_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-i386/spinlock.h
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/include/asm-i386/spinlock.h	2004-09-10 09:48:32.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-i386/spinlock.h	2004-09-13 15:42:32.000000000 -0700
@@ -167,6 +167,11 @@
  */
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_LOCKMETER
+	/* required for LOCKMETER since all bits in lock are used */
+	/* and we need this storage for CPU and lock INDEX        */
+	unsigned lockmeter_magic;
+#endif
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
@@ -174,11 +179,19 @@
 
 #define RWLOCK_MAGIC	0xdeaf1eed
 
+#ifdef CONFIG_LOCKMETER
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define RWLOCK_MAGIC_INIT	, 0, RWLOCK_MAGIC
+#else
+#define RWLOCK_MAGIC_INIT	, 0
+#endif
+#else /* !CONFIG_LOCKMETER */
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
 #else
 #define RWLOCK_MAGIC_INIT	/* */
 #endif
+#endif /* !CONFIG_LOCKMETER */
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
@@ -225,4 +238,60 @@
 	return 0;
 }
 
+#ifdef CONFIG_LOCKMETER
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+/* FIXME -- replace with assembler */
+	atomic_t *count = (atomic_t *)lock;
+	atomic_dec(count);
+	if (count->counter > 0)
+		return 1;
+	atomic_inc(count);
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_LOCKMETER) && defined(CONFIG_HAVE_DEC_LOCK)
+extern void _metered_spin_lock  (spinlock_t *lock, void *caller_pc);
+extern void _metered_spin_unlock(spinlock_t *lock);
+
+/*
+ *  Matches what is in arch/i386/lib/dec_and_lock.c, except this one is
+ *  "static inline" so that the spin_lock(), if actually invoked, is charged
+ *  against the real caller, not against the catch-all atomic_dec_and_lock
+ */
+static inline int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+	int counter;
+	int newcount;
+
+repeat:
+	counter = atomic_read(atomic);
+	newcount = counter-1;
+
+	if (!newcount)
+		goto slow_path;
+
+	asm volatile("lock; cmpxchgl %1,%2"
+		:"=a" (newcount)
+		:"r" (newcount), "m" (atomic->counter), "0" (counter));
+
+	/* If the above failed, "eax" will have changed */
+	if (newcount != counter)
+		goto repeat;
+	return 0;
+
+slow_path:
+	preempt_disable();
+	_metered_spin_lock(lock, __builtin_return_address(0));
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	_metered_spin_unlock(lock);
+	preempt_enable();
+	return 0;
+}
+
+#define ATOMIC_DEC_AND_LOCK
+#endif
+
 #endif /* __ASM_SPINLOCK_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-ia64/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-ia64/lockmeter.h	2004-09-13 15:42:33.000000000 -0700
@@ -0,0 +1,72 @@
+/*
+ *  Copyright (C) 1999,2000 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ */
+
+#ifndef _IA64_LOCKMETER_H
+#define _IA64_LOCKMETER_H
+
+#ifdef local_cpu_data
+#define CPU_CYCLE_FREQUENCY	local_cpu_data->itc_freq
+#else
+#define CPU_CYCLE_FREQUENCY	my_cpu_data.itc_freq
+#endif
+#define get_cycles64()		get_cycles()
+
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+/*
+ * macros to cache and retrieve an index value inside of a lock
+ * these macros assume that there are less than 65536 simultaneous
+ * (read mode) holders of a rwlock.
+ * we also assume that the hash table has less than 32767 entries.
+ */
+/*
+ * instrumented spinlock structure -- never used to allocate storage
+ * only used in macros below to overlay a spinlock_t
+ */
+typedef struct inst_spinlock_s {
+	/* remember, Intel is little endian */
+	volatile unsigned short lock;
+	volatile unsigned short index;
+} inst_spinlock_t;
+#define PUT_INDEX(lock_ptr,indexv) ((inst_spinlock_t *)(lock_ptr))->index = indexv
+#define GET_INDEX(lock_ptr)        ((inst_spinlock_t *)(lock_ptr))->index
+
+/*
+ * macros to cache and retrieve an index value in a read/write lock
+ * as well as the cpu where a reader busy period started
+ * we use the 2nd word (the debug word) for this, so require the
+ * debug word to be present
+ */
+/*
+ * instrumented rwlock structure -- never used to allocate storage
+ * only used in macros below to overlay a rwlock_t
+ */
+typedef struct inst_rwlock_s {
+	volatile int read_counter:31;
+	volatile int write_lock:1;
+	volatile unsigned short index;
+	volatile unsigned short cpu;
+} inst_rwlock_t;
+#define PUT_RWINDEX(rwlock_ptr,indexv) ((inst_rwlock_t *)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)        ((inst_rwlock_t *)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    ((inst_rwlock_t *)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)         ((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return the number of readers for a rwlock_t
+ */
+#define RWLOCK_READERS(rwlock_ptr)	((rwlock_ptr)->read_counter)
+
+/*
+ * return true if rwlock is write locked
+ * (note that other lock attempts can cause the lock value to be negative)
+ */
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) ((rwlock_ptr)->write_lock)
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)  ((rwlock_ptr)->read_counter)
+
+#endif /* _IA64_LOCKMETER_H */
+
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-ia64/spinlock.h
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/include/asm-ia64/spinlock.h	2004-09-10 09:48:25.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-ia64/spinlock.h	2004-09-13 15:42:33.000000000 -0700
@@ -116,8 +116,18 @@
 typedef struct {
 	volatile int read_counter	: 31;
 	volatile int write_lock		:  1;
+#ifdef CONFIG_LOCKMETER
+	/* required for LOCKMETER since all bits in lock are used */
+	/* and we need this storage for CPU and lock INDEX        */
+	unsigned lockmeter_magic;
+#endif
 } rwlock_t;
+
+#ifdef CONFIG_LOCKMETER
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0, 0 }
+#else
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#endif
 
 #define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 #define rwlock_is_locked(x)	(*(volatile int *) (x) != 0)
@@ -133,6 +143,48 @@
 	}										\
 } while (0)
 
+#ifdef CONFIG_LOCKMETER
+/*
+ * HACK: This works, but still have a timing window that affects performance:
+ * we see that no one owns the Write lock, then someone * else grabs for Write
+ * lock before we do a read_lock().
+ * This means that on rare occasions our read_lock() will stall and spin-wait
+ * until we acquire for Read, instead of simply returning a trylock failure.
+ */
+static inline int _raw_read_trylock(rwlock_t *rw)
+{
+	if (rw->write_lock) {
+		return 0;
+	} else {
+		_raw_read_lock(rw);
+		return 1;
+	}
+}
+
+static inline int _raw_write_trylock(rwlock_t *rw)
+{
+	if (!(rw->write_lock)) {
+	    /* isn't currently write-locked... that looks promising... */
+	    if (test_and_set_bit(31, rw) == 0) {
+		/* now it is write-locked by me... */
+		if (rw->read_counter) {
+		    /* really read-locked, so release write-lock and fail */
+		    clear_bit(31, rw);
+		} else {
+		    /* we've the the write-lock, no read-lockers... success! */
+		    barrier();
+		    return 1;
+		}
+
+	    }
+	}
+
+	/* falls through ... fails to write-lock */
+	barrier();
+	return 0;
+}
+#endif
+
 #define _raw_read_unlock(rw)					\
 do {								\
 	rwlock_t *__read_lock_ptr = (rw);			\
@@ -196,4 +248,25 @@
 	clear_bit(31, (x));								\
 })
 
+#ifdef CONFIG_LOCKMETER
+extern void _metered_spin_lock  (spinlock_t *lock, void *caller_pc);
+extern void _metered_spin_unlock(spinlock_t *lock);
+
+/*
+ *  Use a less efficient, and inline, atomic_dec_and_lock() if lockmetering
+ *  so we can see the callerPC of who is actually doing the spin_lock().
+ *  Otherwise, all we see is the generic rollup of all locks done by
+ *  atomic_dec_and_lock().
+ */
+static inline int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+	_metered_spin_lock(lock, __builtin_return_address(0));
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	_metered_spin_unlock(lock);
+	return 0;
+}
+#define ATOMIC_DEC_AND_LOCK
+#endif
+
 #endif /*  _ASM_IA64_SPINLOCK_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-mips/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-mips/lockmeter.h	2004-09-13 15:42:33.000000000 -0700
@@ -0,0 +1,126 @@
+/*
+ *  Copyright (C) 1999,2000 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ *  Ported to mips32 for Asita Technologies
+ *   by D.J. Barrow ( dj.barrow@asitatechnologies.com )
+ */
+#ifndef _ASM_LOCKMETER_H
+#define _ASM_LOCKMETER_H
+
+/* do_gettimeoffset is a function pointer on mips */
+/* & it is not included by <linux/time.h> */
+#include <asm/time.h>
+#include <linux/time.h>
+#include <asm/div64.h>
+
+#define SPINLOCK_MAGIC_INIT	/* */
+
+#define CPU_CYCLE_FREQUENCY	get_cpu_cycle_frequency()
+
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+static uint32_t cpu_cycle_frequency = 0;
+
+static uint32_t get_cpu_cycle_frequency(void)
+{
+    /* a total hack, slow and invasive, but ... it works */
+    int sec;
+    uint32_t start_cycles;
+    struct timeval tv;
+
+    if (cpu_cycle_frequency == 0) {	/* uninitialized */
+	do_gettimeofday(&tv);
+	sec = tv.tv_sec;	/* set up to catch the tv_sec rollover */
+	while (sec == tv.tv_sec) { do_gettimeofday(&tv); }
+	sec = tv.tv_sec;	/* rolled over to a new sec value */
+	start_cycles = get_cycles();
+	while (sec == tv.tv_sec) { do_gettimeofday(&tv); }
+	cpu_cycle_frequency = get_cycles() - start_cycles;
+    }
+
+    return cpu_cycle_frequency;
+}
+
+extern struct timeval xtime;
+
+static uint64_t get_cycles64(void)
+{
+    static uint64_t last_get_cycles64 = 0;
+    uint64_t ret;
+    unsigned long sec;
+    unsigned long usec, usec_offset;
+
+again:
+    sec  = xtime.tv_sec;
+    usec = xtime.tv_usec;
+    usec_offset = do_gettimeoffset();
+    if ((xtime.tv_sec != sec)  ||
+	(xtime.tv_usec != usec)||
+	(usec_offset >= 20000))
+	goto again;
+
+    ret = ((uint64_t)(usec + usec_offset) * cpu_cycle_frequency);
+    /* We can't do a normal 64 bit division on mips without libgcc.a */
+    do_div(ret,1000000);
+    ret +=  ((uint64_t)sec * cpu_cycle_frequency);
+
+    /* XXX why does time go backwards?  do_gettimeoffset?  general time adj? */
+    if (ret <= last_get_cycles64)
+	ret  = last_get_cycles64+1;
+    last_get_cycles64 = ret;
+
+    return ret;
+}
+
+/*
+ * macros to cache and retrieve an index value inside of a lock
+ * these macros assume that there are less than 65536 simultaneous
+ * (read mode) holders of a rwlock.
+ * we also assume that the hash table has less than 32767 entries.
+ * the high order bit is used for write locking a rw_lock
+ */
+#define INDEX_MASK   0x7FFF0000
+#define READERS_MASK 0x0000FFFF
+#define INDEX_SHIFT 16
+#define PUT_INDEX(lockp,index)   \
+        lockp->lock = (((lockp->lock) & ~INDEX_MASK) | (index) << INDEX_SHIFT)
+#define GET_INDEX(lockp) \
+        (((lockp->lock) & INDEX_MASK) >> INDEX_SHIFT)
+
+/*
+ * macros to cache and retrieve an index value in a read/write lock
+ * as well as the cpu where a reader busy period started
+ * we use the 2nd word (the debug word) for this, so require the
+ * debug word to be present
+ */
+/*
+ * instrumented rwlock structure -- never used to allocate storage
+ * only used in macros below to overlay a rwlock_t
+ */
+typedef struct inst_rwlock_s {
+	volatile int lock;
+	unsigned short index;
+	unsigned short cpu;
+} inst_rwlock_t;
+#define PUT_RWINDEX(rwlock_ptr,indexv) ((inst_rwlock_t *)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)        ((inst_rwlock_t *)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    ((inst_rwlock_t *)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)         ((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return the number of readers for a rwlock_t
+ */
+#define RWLOCK_READERS(rwlock_ptr)   rwlock_readers(rwlock_ptr)
+
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+	int tmp = (int) rwlock_ptr->lock;
+	return (tmp >= 0) ? tmp : 0;
+}
+
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) ((rwlock_ptr)->lock < 0)
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)  ((rwlock_ptr)->lock > 0)
+
+#endif /* _ASM_LOCKMETER_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-mips/spinlock.h
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/include/asm-mips/spinlock.h	2004-09-10 09:49:11.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-mips/spinlock.h	2004-09-13 15:42:33.000000000 -0700
@@ -92,9 +92,18 @@
 
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_LOCKMETER
+	/* required for LOCKMETER since all bits in lock are used */
+	/* and we need this storage for CPU and lock INDEX        */
+	unsigned lockmeter_magic;
+#endif
 } rwlock_t;
 
+#ifdef CONFIG_LOCKMETER
+#define RW_LOCK_UNLOCKED (rwlock_t) { 0, 0 }
+#else
 #define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+#endif
 
 #define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-sparc64/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-sparc64/lockmeter.h	2004-09-13 15:42:33.000000000 -0700
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2000 Anton Blanchard (anton@linuxcare.com)
+ * Copyright (C) 2003 David S. Miller (davem@redhat.com)
+ */
+
+#ifndef _SPARC64_LOCKMETER_H
+#define _SPARC64_LOCKMETER_H
+
+#include <linux/smp.h>
+#include <asm/spinlock.h>
+#include <asm/timer.h>
+#include <asm/timex.h>
+
+/* Actually, this is not the CPU frequency by the system tick
+ * frequency which is good enough for lock metering.
+ */
+#define CPU_CYCLE_FREQUENCY	(timer_tick_offset * HZ)
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+#define PUT_INDEX(lock_ptr,indexv)	(lock_ptr)->index = (indexv)
+#define GET_INDEX(lock_ptr)		(lock_ptr)->index
+
+#define PUT_RWINDEX(rwlock_ptr,indexv) (rwlock_ptr)->index = (indexv)
+#define GET_RWINDEX(rwlock_ptr)        (rwlock_ptr)->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    (rwlock_ptr)->cpu = (cpuv)
+#define GET_RW_CPU(rwlock_ptr)         (rwlock_ptr)->cpu
+
+#define RWLOCK_READERS(rwlock_ptr)	rwlock_readers(rwlock_ptr)
+
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+	signed int tmp = rwlock_ptr->lock;
+
+	if (tmp > 0)
+		return tmp;
+	else
+		return 0;
+}
+
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr)	((signed int)((rwlock_ptr)->lock) < 0)
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)	((signed int)((rwlock_ptr)->lock) > 0)
+
+#define get_cycles64()	get_cycles()
+
+#endif /* _SPARC64_LOCKMETER_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-x86_64/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-x86_64/lockmeter.h	2004-09-13 15:42:33.000000000 -0700
@@ -0,0 +1,102 @@
+/*
+ *  Copyright (C) 1999,2000 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ *
+ *  Modified by Ray Bryant (raybry@us.ibm.com)
+ *  Changes Copyright (C) 2000 IBM, Inc.
+ *  Added save of index in spinlock_t to improve efficiency
+ *  of "hold" time reporting for spinlocks.
+ *  Added support for hold time statistics for read and write
+ *  locks.
+ *  Moved machine dependent code here from include/lockmeter.h.
+ *
+ */
+
+#ifndef _X8664_LOCKMETER_H
+#define _X8664_LOCKMETER_H
+
+#include <asm/spinlock.h>
+#include <asm/rwlock.h>
+
+#include <linux/version.h>
+
+#ifdef __KERNEL__
+extern unsigned int cpu_khz;
+#define CPU_CYCLE_FREQUENCY	(cpu_khz * 1000)
+#else
+#define CPU_CYCLE_FREQUENCY	450000000
+#endif
+
+#define THIS_CPU_NUMBER		smp_processor_id()
+
+/*
+ * macros to cache and retrieve an index value inside of a spin lock
+ * these macros assume that there are less than 65536 simultaneous
+ * (read mode) holders of a rwlock.  Not normally a problem!!
+ * we also assume that the hash table has less than 65535 entries.
+ */
+/*
+ * instrumented spinlock structure -- never used to allocate storage
+ * only used in macros below to overlay a spinlock_t
+ */
+typedef struct inst_spinlock_s {
+	/* remember, Intel is little endian */
+	unsigned short lock;
+	unsigned short index;
+} inst_spinlock_t;
+#define PUT_INDEX(lock_ptr,indexv) ((inst_spinlock_t *)(lock_ptr))->index = indexv
+#define GET_INDEX(lock_ptr)        ((inst_spinlock_t *)(lock_ptr))->index
+
+/*
+ * macros to cache and retrieve an index value in a read/write lock
+ * as well as the cpu where a reader busy period started
+ * we use the 2nd word (the debug word) for this, so require the
+ * debug word to be present
+ */
+/*
+ * instrumented rwlock structure -- never used to allocate storage
+ * only used in macros below to overlay a rwlock_t
+ */
+typedef struct inst_rwlock_s {
+	volatile int lock;
+	unsigned short index;
+	unsigned short cpu;
+} inst_rwlock_t;
+#define PUT_RWINDEX(rwlock_ptr,indexv) ((inst_rwlock_t *)(rwlock_ptr))->index = indexv
+#define GET_RWINDEX(rwlock_ptr)        ((inst_rwlock_t *)(rwlock_ptr))->index
+#define PUT_RW_CPU(rwlock_ptr,cpuv)    ((inst_rwlock_t *)(rwlock_ptr))->cpu = cpuv
+#define GET_RW_CPU(rwlock_ptr)         ((inst_rwlock_t *)(rwlock_ptr))->cpu
+
+/*
+ * return the number of readers for a rwlock_t
+ */
+#define RWLOCK_READERS(rwlock_ptr)   rwlock_readers(rwlock_ptr)
+
+extern inline int rwlock_readers(rwlock_t *rwlock_ptr)
+{
+	int tmp = (int) rwlock_ptr->lock;
+	/* read and write lock attempts may cause the lock value to temporarily */
+	/* be negative.  Until it is >= 0 we know nothing (i. e. can't tell if  */
+	/* is -1 because it was write locked and somebody tried to read lock it */
+	/* or if it is -1 because it was read locked and somebody tried to write*/
+	/* lock it. ........................................................... */
+	do {
+		tmp = (int) rwlock_ptr->lock;
+	} while (tmp < 0);
+	if (tmp == 0) return(0);
+	else return(RW_LOCK_BIAS-tmp);
+}
+
+/*
+ * return true if rwlock is write locked
+ * (note that other lock attempts can cause the lock value to be negative)
+ */
+#define RWLOCK_IS_WRITE_LOCKED(rwlock_ptr) ((rwlock_ptr)->lock <= 0)
+#define IABS(x) ((x) > 0 ? (x) : -(x))
+#define RWLOCK_IS_READ_LOCKED(rwlock_ptr)  ((IABS((rwlock_ptr)->lock) % RW_LOCK_BIAS) != 0)
+
+#define get_cycles64()	get_cycles()
+
+#endif /* _X8664_LOCKMETER_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/asm-x86_64/spinlock.h
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/include/asm-x86_64/spinlock.h	2004-09-10 09:49:11.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/include/asm-x86_64/spinlock.h	2004-09-13 15:42:33.000000000 -0700
@@ -138,6 +138,11 @@
  */
 typedef struct {
 	volatile unsigned int lock;
+#ifdef CONFIG_LOCKMETER
+	/* required for LOCKMETER since all bits in lock are used */
+	/* and we need this storage for CPU and lock INDEX        */
+	unsigned lockmeter_magic;
+#endif
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
@@ -145,11 +150,19 @@
 
 #define RWLOCK_MAGIC	0xdeaf1eed
 
+#ifdef CONFIG_LOCKMETER
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define RWLOCK_MAGIC_INIT	, 0, RWLOCK_MAGIC
+#else
+#define RWLOCK_MAGIC_INIT	, 0
+#endif
+#else /* !CONFIG_LOCKMETER */
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define RWLOCK_MAGIC_INIT	, RWLOCK_MAGIC
 #else
 #define RWLOCK_MAGIC_INIT	/* */
 #endif
+#endif /* !CONFIG_LOCKMETER */
 
 #define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
 
@@ -196,4 +209,60 @@
 	return 0;
 }
 
+#ifdef CONFIG_LOCKMETER
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+/* FIXME -- replace with assembler */
+	atomic_t *count = (atomic_t *)lock;
+	atomic_dec(count);
+	if (count->counter > 0)
+		return 1;
+	atomic_inc(count);
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_LOCKMETER) && defined(CONFIG_HAVE_DEC_LOCK)
+extern void _metered_spin_lock  (spinlock_t *lock, void *caller_pc);
+extern void _metered_spin_unlock(spinlock_t *lock);
+
+/*
+ *  Matches what is in arch/x86_64/lib/dec_and_lock.c, except this one is
+ *  "static inline" so that the spin_lock(), if actually invoked, is charged
+ *  against the real caller, not against the catch-all atomic_dec_and_lock
+ */
+static inline int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+{
+	int counter;
+	int newcount;
+
+repeat:
+	counter = atomic_read(atomic);
+	newcount = counter-1;
+
+	if (!newcount)
+		goto slow_path;
+
+	asm volatile("lock; cmpxchgl %1,%2"
+		:"=a" (newcount)
+		:"r" (newcount), "m" (atomic->counter), "0" (counter));
+
+	/* If the above failed, "eax" will have changed */
+	if (newcount != counter)
+		goto repeat;
+	return 0;
+
+slow_path:
+	preempt_disable();
+	_metered_spin_lock(lock, __builtin_return_address(0));
+	if (atomic_dec_and_test(atomic))
+		return 1;
+	_metered_spin_unlock(lock);
+	preempt_enable();
+	return 0;
+}
+
+#define ATOMIC_DEC_AND_LOCK
+#endif
+
 #endif /* __ASM_SPINLOCK_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/linux/lockmeter.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/include/linux/lockmeter.h	2004-09-13 15:42:33.000000000 -0700
@@ -0,0 +1,320 @@
+/*
+ *  Copyright (C) 1999-2002 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.h by Jack Steiner (steiner@sgi.com)
+ *
+ *  Modified by Ray Bryant (raybry@us.ibm.com) Feb-Apr 2000
+ *  Changes Copyright (C) 2000 IBM, Inc.
+ *  Added save of index in spinlock_t to improve efficiency
+ *  of "hold" time reporting for spinlocks
+ *  Added support for hold time statistics for read and write
+ *  locks.
+ *  Moved machine dependent code to include/asm/lockmeter.h.
+ *
+ */
+
+#ifndef _LINUX_LOCKMETER_H
+#define _LINUX_LOCKMETER_H
+
+
+/*---------------------------------------------------
+ *	architecture-independent lockmeter.h
+ *-------------------------------------------------*/
+
+/*
+ * raybry -- version 2: added efficient hold time statistics
+ *           requires lstat recompile, so flagged as new version
+ * raybry -- version 3: added global reader lock data
+ * hawkes -- version 4: removed some unnecessary fields to simplify mips64 port
+ */
+#define LSTAT_VERSION	5
+
+int	lstat_update(void*, void*, int);
+int	lstat_update_time(void*, void*, int, uint32_t);
+
+/*
+ * Currently, the mips64 and sparc64 kernels talk to a 32-bit lockstat, so we
+ * need to force compatibility in the inter-communication data structure.
+ */
+
+#if defined(CONFIG_MIPS32_COMPAT)
+#define TIME_T		uint32_t
+#elif defined(CONFIG_SPARC) || defined(CONFIG_SPARC64)
+#define TIME_T		uint64_t
+#else
+#define TIME_T		time_t
+#endif
+
+#if defined(__KERNEL__) || (!defined(CONFIG_MIPS32_COMPAT) && !defined(CONFIG_SPARC) && !defined(CONFIG_SPARC64)) || (_MIPS_SZLONG==32)
+#define POINTER		void *
+#else
+#define	POINTER		int64_t
+#endif
+
+/*
+ * Values for the "action" parameter passed to lstat_update.
+ *	ZZZ - do we want a try-success status here???
+ */
+#define LSTAT_ACT_NO_WAIT	0
+#define LSTAT_ACT_SPIN		1
+#define LSTAT_ACT_REJECT	2
+#define LSTAT_ACT_WW_SPIN       3
+#define LSTAT_ACT_SLEPT		4 /* UNUSED */
+
+#define LSTAT_ACT_MAX_VALUES	4 /* NOTE: Increase to 5 if use ACT_SLEPT */
+
+/*
+ * Special values for the low 2 bits of an RA passed to
+ * lstat_update.
+ */
+/* we use these values to figure out what kind of lock data */
+/* is stored in the statistics table entry at index ....... */
+#define LSTAT_RA_SPIN           0  /* spin lock data */
+#define LSTAT_RA_READ           1  /* read lock statistics */
+#define LSTAT_RA_SEMA		2  /* RESERVED */
+#define LSTAT_RA_WRITE          3  /* write lock statistics*/
+
+#define LSTAT_RA(n)	\
+	((void*)( ((unsigned long) caller_pc & ~3) | n) )
+
+/*
+ * Constants used for lock addresses in the lstat_directory
+ * to indicate special values of the lock address.
+ */
+#define	LSTAT_MULTI_LOCK_ADDRESS	NULL
+
+/*
+ * Maximum size of the lockstats tables. Increase this value
+ * if its not big enough. (Nothing bad happens if its not
+ * big enough although some locks will not be monitored.)
+ * We record overflows of this quantity in lstat_control.dir_overflows
+ *
+ * Note:  The max value here must fit into the field set
+ * and obtained by the macro's PUT_INDEX() and GET_INDEX().
+ * This value depends on how many bits are available in the
+ * lock word in the particular machine implementation we are on.
+ */
+#define LSTAT_MAX_STAT_INDEX		2000
+
+/*
+ * Size and mask for the hash table into the directory.
+ */
+#define LSTAT_HASH_TABLE_SIZE		4096		/* must be 2**N */
+#define LSTAT_HASH_TABLE_MASK		(LSTAT_HASH_TABLE_SIZE-1)
+
+#define DIRHASH(ra)      ((unsigned long)(ra)>>2 & LSTAT_HASH_TABLE_MASK)
+
+/*
+ *	This defines an entry in the lockstat directory. It contains
+ *	information about a lock being monitored.
+ *	A directory entry only contains the lock identification -
+ *	counts on usage of the lock are kept elsewhere in a per-cpu
+ *	data structure to minimize cache line pinging.
+ */
+typedef struct {
+	POINTER	caller_ra;		  /* RA of code that set lock */
+	POINTER	lock_ptr;		  /* lock address */
+	ushort	next_stat_index;  /* Used to link multiple locks that have the same hash table value */
+} lstat_directory_entry_t;
+
+/*
+ *	A multi-dimensioned array used to contain counts for lock accesses.
+ *	The array is 3-dimensional:
+ *		- CPU number. Keep from thrashing cache lines between CPUs
+ *		- Directory entry index. Identifies the lock
+ *		- Action. Indicates what kind of contention occurred on an
+ *		  access to the lock.
+ *
+ *	The index of an entry in the directory is the same as the 2nd index
+ *	of the entry in the counts array.
+ */
+/*
+ *  This table contains data for spin_locks, write locks, and read locks
+ *  Not all data is used for all cases.  In particular, the hold time
+ *  information is not stored here for read locks since that is a global
+ *  (e. g. cannot be separated out by return address) quantity.
+ *  See the lstat_read_lock_counts_t structure for the global read lock
+ *  hold time.
+ */
+typedef struct {
+	uint64_t    cum_wait_ticks;	/* sum of wait times               */
+	                                /* for write locks, sum of time a  */
+					/* writer is waiting for a reader  */
+	int64_t	    cum_hold_ticks;	/* cumulative sum of holds         */
+	                                /* not used for read mode locks    */
+					/* must be signed. ............... */
+	uint32_t    max_wait_ticks;	/* max waiting time                */
+	uint32_t    max_hold_ticks;	/* max holding time                */
+	uint64_t    cum_wait_ww_ticks;  /* sum times writer waits on writer*/
+	uint32_t    max_wait_ww_ticks;  /* max wait time writer vs writer  */
+	                                /* prev 2 only used for write locks*/
+	uint32_t    acquire_time;       /* time lock acquired this CPU     */
+	uint32_t    count[LSTAT_ACT_MAX_VALUES];
+} lstat_lock_counts_t;
+
+typedef lstat_lock_counts_t	lstat_cpu_counts_t[LSTAT_MAX_STAT_INDEX];
+
+/*
+ * User request to:
+ *	- turn statistic collection on/off, or to reset
+ */
+#define LSTAT_OFF	 0
+#define LSTAT_ON	 1
+#define LSTAT_RESET      2
+#define LSTAT_RELEASE    3
+
+#define LSTAT_MAX_READ_LOCK_INDEX 1000
+typedef struct {
+	POINTER	    lock_ptr;            /* address of lock for output stats */
+	uint32_t    read_lock_count;
+	int64_t     cum_hold_ticks;       /* sum of read lock hold times over */
+	                                  /* all callers. ....................*/
+	uint32_t    write_index;          /* last write lock hash table index */
+	uint32_t    busy_periods;         /* count of busy periods ended this */
+	uint64_t    start_busy;           /* time this busy period started. ..*/
+	uint64_t    busy_ticks;           /* sum of busy periods this lock. ..*/
+	uint64_t    max_busy;             /* longest busy period for this lock*/
+	uint32_t    max_readers;          /* maximum number of readers ...... */
+#ifdef USER_MODE_TESTING
+	rwlock_t    entry_lock;           /* lock for this read lock entry... */
+	                                  /* avoid having more than one rdr at*/
+	                                  /* needed for user space testing... */
+	                                  /* not needed for kernel 'cause it  */
+					  /* is non-preemptive. ............. */
+#endif
+} lstat_read_lock_counts_t;
+typedef lstat_read_lock_counts_t	lstat_read_lock_cpu_counts_t[LSTAT_MAX_READ_LOCK_INDEX];
+
+#if defined(__KERNEL__) || defined(USER_MODE_TESTING)
+
+#ifndef USER_MODE_TESTING
+#include <asm/lockmeter.h>
+#else
+#include "asm_newlockmeter.h"
+#endif
+
+/*
+ * Size and mask for the hash table into the directory.
+ */
+#define LSTAT_HASH_TABLE_SIZE		4096		/* must be 2**N */
+#define LSTAT_HASH_TABLE_MASK		(LSTAT_HASH_TABLE_SIZE-1)
+
+#define DIRHASH(ra)      ((unsigned long)(ra)>>2 & LSTAT_HASH_TABLE_MASK)
+
+/*
+ * This version eliminates the per processor lock stack.  What we do is to
+ * store the index of the lock hash structure in unused bits in the lock
+ * itself.  Then on unlock we can find the statistics record without doing
+ * any additional hash or lock stack lookup.  This works for spin_locks.
+ * Hold time reporting is now basically as cheap as wait time reporting
+ * so we ignore the difference between LSTAT_ON_HOLD and LSTAT_ON_WAIT
+ * as in version 1.1.* of lockmeter.
+ *
+ * For rw_locks, we store the index of a global reader stats structure in
+ * the lock and the writer index is stored in the latter structure.
+ * For read mode locks we hash at the time of the lock to find an entry
+ * in the directory for reader wait time and the like.
+ * At unlock time for read mode locks, we update just the global structure
+ * so we don't need to know the reader directory index value at unlock time.
+ *
+ */
+
+/*
+ * Protocol to change lstat_control.state
+ *   This is complicated because we don't want the cum_hold_time for
+ * a rw_lock to be decremented in _read_lock_ without making sure it
+ * is incremented in _read_lock_ and vice versa.  So here is the
+ * way we change the state of lstat_control.state:
+ * I.  To Turn Statistics On
+ *     After allocating storage, set lstat_control.state non-zero.
+ * This works because we don't start updating statistics for in use
+ * locks until the reader lock count goes to zero.
+ * II. To Turn Statistics Off:
+ * (0)  Disable interrupts on this CPU
+ * (1)  Seize the lstat_control.directory_lock
+ * (2)  Obtain the current value of lstat_control.next_free_read_lock_index
+ * (3)  Store a zero in lstat_control.state.
+ * (4)  Release the lstat_control.directory_lock
+ * (5)  For each lock in the read lock list up to the saved value
+ *      (well, -1) of the next_free_read_lock_index, do the following:
+ *      (a)  Check validity of the stored lock address
+ *           by making sure that the word at the saved addr
+ *           has an index that matches this entry.  If not
+ *           valid, then skip this entry.
+ *      (b)  If there is a write lock already set on this lock,
+ *           skip to (d) below.
+ *      (c)  Set a non-metered write lock on the lock
+ *      (d)  set the cached INDEX in the lock to zero
+ *      (e)  Release the non-metered write lock.
+ * (6)  Re-enable interrupts
+ *
+ * These rules ensure that a read lock will not have its statistics
+ * partially updated even though the global lock recording state has
+ * changed.  See put_lockmeter_info() for implementation.
+ *
+ * The reason for (b) is that there may be write locks set on the
+ * syscall path to put_lockmeter_info() from user space.  If we do
+ * not do this check, then we can deadlock.  A similar problem would
+ * occur if the lock was read locked by the current CPU.  At the
+ * moment this does not appear to happen.
+ */
+
+/*
+ * Main control structure for lockstat. Used to turn statistics on/off
+ * and to maintain directory info.
+ */
+typedef struct {
+	int				state;
+	spinlock_t		control_lock;		/* used to serialize turning statistics on/off   */
+	spinlock_t		directory_lock;		/* for serialize adding entries to directory     */
+	volatile int	next_free_dir_index;/* next free entry in the directory */
+	/* FIXME not all of these fields are used / needed .............. */
+                /* the following fields represent data since     */
+		/* first "lstat on" or most recent "lstat reset" */
+	TIME_T      first_started_time;     /* time when measurement first enabled */
+	TIME_T      started_time;           /* time when measurement last started  */
+	TIME_T      ending_time;            /* time when measurement last disabled */
+	uint64_t    started_cycles64;       /* cycles when measurement last started          */
+	uint64_t    ending_cycles64;        /* cycles when measurement last disabled         */
+	uint64_t    enabled_cycles64;       /* total cycles with measurement enabled         */
+	int         intervals;              /* number of measurement intervals recorded      */
+	                                    /* i. e. number of times did lstat on;lstat off  */
+	lstat_directory_entry_t	*dir;		/* directory */
+	int         dir_overflow;           /* count of times ran out of space in directory  */
+	int         rwlock_overflow;        /* count of times we couldn't allocate a rw block*/
+	ushort		*hashtab;		 	    /* hash table for quick dir scans */
+	lstat_cpu_counts_t	*counts[NR_CPUS];	 /* Array of pointers to per-cpu stats */
+    int         next_free_read_lock_index;   /* next rwlock reader (global) stats block  */
+    lstat_read_lock_cpu_counts_t *read_lock_counts[NR_CPUS]; /* per cpu read lock stats  */
+} lstat_control_t;
+
+#endif	/* defined(__KERNEL__) || defined(USER_MODE_TESTING) */
+
+typedef struct {
+	short		lstat_version;		/* version of the data */
+	short		state;			/* the current state is returned */
+	int		maxcpus;		/* Number of cpus present */
+	int		next_free_dir_index;	/* index of the next free directory entry */
+	TIME_T          first_started_time;	/* when measurement enabled for first time */
+	TIME_T          started_time;		/* time in secs since 1969 when stats last turned on  */
+	TIME_T		ending_time;		/* time in secs since 1969 when stats last turned off */
+	uint32_t	cycleval;		/* cycles per second */
+#ifdef notyet
+	void		*kernel_magic_addr;	/* address of kernel_magic */
+	void		*kernel_end_addr;	/* contents of kernel magic (points to "end") */
+#endif
+	int              next_free_read_lock_index; /* index of next (global) read lock stats struct */
+	uint64_t         started_cycles64;	/* cycles when measurement last started        */
+	uint64_t         ending_cycles64;	/* cycles when stats last turned off           */
+	uint64_t         enabled_cycles64;	/* total cycles with measurement enabled       */
+	int              intervals;		/* number of measurement intervals recorded      */
+						/* i.e. number of times we did lstat on;lstat off*/
+	int              dir_overflow;		/* number of times we wanted more space in directory */
+	int              rwlock_overflow;	/* # of times we wanted more space in read_locks_count */
+	struct new_utsname   uts;		/* info about machine where stats are measured */
+						/* -T option of lockstat allows data to be     */
+						/* moved to another machine. ................. */
+} lstat_user_request_t;
+
+#endif /* _LINUX_LOCKMETER_H */
Index: linus-2.6.9-rc1-bk-09-10-04/include/linux/spinlock.h
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/include/linux/spinlock.h	2004-09-10 09:48:51.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/include/linux/spinlock.h	2004-09-13 15:42:33.000000000 -0700
@@ -449,17 +449,6 @@
 
 #define spin_trylock_bh(lock)			_spin_trylock_bh(lock)
 
-#ifdef CONFIG_LOCKMETER
-extern void _metered_spin_lock   (spinlock_t *lock);
-extern void _metered_spin_unlock (spinlock_t *lock);
-extern int  _metered_spin_trylock(spinlock_t *lock);
-extern void _metered_read_lock    (rwlock_t *lock);
-extern void _metered_read_unlock  (rwlock_t *lock);
-extern void _metered_write_lock   (rwlock_t *lock);
-extern void _metered_write_unlock (rwlock_t *lock);
-extern int  _metered_write_trylock(rwlock_t *lock);
-#endif
-
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>
Index: linus-2.6.9-rc1-bk-09-10-04/kernel/Makefile
===================================================================
--- linus-2.6.9-rc1-bk-09-10-04.orig/kernel/Makefile	2004-09-10 13:03:33.000000000 -0700
+++ linus-2.6.9-rc1-bk-09-10-04/kernel/Makefile	2004-09-13 15:42:33.000000000 -0700
@@ -11,7 +11,12 @@
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
+ifneq ($(CONFIG_LOCKMETER),y)
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
+else
+obj-$(CONFIG_SMP) += cpu.o
+obj-$(CONFIG_LOCKMETER) += lockmeter.o
+endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
Index: linus-2.6.9-rc1-bk-09-10-04/kernel/lockmeter.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linus-2.6.9-rc1-bk-09-10-04/kernel/lockmeter.c	2004-09-13 15:42:33.000000000 -0700
@@ -0,0 +1,1460 @@
+/*
+ *  Copyright (C) 1999,2000 Silicon Graphics, Inc.
+ *
+ *  Written by John Hawkes (hawkes@sgi.com)
+ *  Based on klstat.c by Jack Steiner (steiner@sgi.com)
+ *
+ *  Modified by Ray Bryant (raybry@us.ibm.com)
+ *  Changes Copyright (C) 2000 IBM, Inc.
+ *  Added save of index in spinlock_t to improve efficiency
+ *  of "hold" time reporting for spinlocks
+ *  Added support for hold time statistics for read and write
+ *  locks.
+ *
+ *  Modified by Ray Bryant (raybry@sgi.com)
+ *  Changes Copyright (C) 2004, Silicon Graphics, Inc.
+ *  Fix to work with out-of-line spinlocks.
+ */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <linux/preempt.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/spinlock.h>
+#include <linux/utsname.h>
+#include <linux/module.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#include <linux/lockmeter.h>
+
+#define ASSERT(cond)
+#define bzero(loc,size)		memset(loc,0,size)
+
+/*<---------------------------------------------------*/
+/*              lockmeter.c                           */
+/*>---------------------------------------------------*/
+
+static lstat_control_t lstat_control __cacheline_aligned =
+	{ LSTAT_OFF, SPIN_LOCK_UNLOCKED, SPIN_LOCK_UNLOCKED,
+	  19 * 0, NR_CPUS * 0, 0, NR_CPUS * 0 };
+
+static ushort lstat_make_dir_entry(void *, void *);
+
+/*
+ * lstat_lookup
+ *
+ * Given a RA, locate the directory entry for the lock.
+ */
+static ushort
+lstat_lookup(void *lock_ptr, void *caller_ra)
+{
+	ushort index;
+	lstat_directory_entry_t *dirp;
+
+	dirp = lstat_control.dir;
+
+	index = lstat_control.hashtab[DIRHASH(caller_ra)];
+	while (dirp[index].caller_ra != caller_ra) {
+		if (index == 0) {
+			return lstat_make_dir_entry(lock_ptr, caller_ra);
+		}
+		index = dirp[index].next_stat_index;
+	}
+
+	if (dirp[index].lock_ptr != NULL && dirp[index].lock_ptr != lock_ptr) {
+		dirp[index].lock_ptr = NULL;
+	}
+
+	return index;
+}
+
+/*
+ * lstat_make_dir_entry
+ * Called to add a new lock to the lock directory.
+ */
+static ushort
+lstat_make_dir_entry(void *lock_ptr, void *caller_ra)
+{
+	lstat_directory_entry_t *dirp;
+	ushort index, hindex;
+	unsigned long flags;
+
+	/* lock the table without recursively reentering this metering code */
+	local_irq_save(flags);
+	_raw_spin_lock(&lstat_control.directory_lock);
+
+	hindex = DIRHASH(caller_ra);
+	index = lstat_control.hashtab[hindex];
+	dirp = lstat_control.dir;
+	while (index && dirp[index].caller_ra != caller_ra)
+		index = dirp[index].next_stat_index;
+
+	if (index == 0) {
+		if (lstat_control.next_free_dir_index < LSTAT_MAX_STAT_INDEX) {
+			index = lstat_control.next_free_dir_index++;
+			lstat_control.dir[index].caller_ra = caller_ra;
+			lstat_control.dir[index].lock_ptr = lock_ptr;
+			lstat_control.dir[index].next_stat_index =
+				lstat_control.hashtab[hindex];
+			lstat_control.hashtab[hindex] = index;
+		} else {
+			lstat_control.dir_overflow++;
+		}
+	}
+	_raw_spin_unlock(&lstat_control.directory_lock);
+	local_irq_restore(flags);
+	return index;
+}
+
+int
+lstat_update(void *lock_ptr, void *caller_ra, int action)
+{
+	int index;
+	int cpu;
+
+	ASSERT(action < LSTAT_ACT_MAX_VALUES);
+
+	if (lstat_control.state == LSTAT_OFF)
+		return 0;
+
+	index = lstat_lookup(lock_ptr, caller_ra);
+	cpu = THIS_CPU_NUMBER;
+	(*lstat_control.counts[cpu])[index].count[action]++;
+	(*lstat_control.counts[cpu])[index].acquire_time = get_cycles();
+
+	return index;
+}
+
+int
+lstat_update_time(void *lock_ptr, void *caller_ra, int action, uint32_t ticks)
+{
+	ushort index;
+	int cpu;
+
+	ASSERT(action < LSTAT_ACT_MAX_VALUES);
+
+	if (lstat_control.state == LSTAT_OFF)
+		return 0;
+
+	index = lstat_lookup(lock_ptr, caller_ra);
+	cpu = THIS_CPU_NUMBER;
+	(*lstat_control.counts[cpu])[index].count[action]++;
+	(*lstat_control.counts[cpu])[index].cum_wait_ticks += (uint64_t) ticks;
+	if ((*lstat_control.counts[cpu])[index].max_wait_ticks < ticks)
+		(*lstat_control.counts[cpu])[index].max_wait_ticks = ticks;
+
+	(*lstat_control.counts[cpu])[index].acquire_time = get_cycles();
+
+	return index;
+}
+
+void
+_metered_spin_lock(spinlock_t * lock_ptr, void *caller_pc)
+{
+	if (lstat_control.state == LSTAT_OFF) {
+		_raw_spin_lock(lock_ptr);	/* do the real lock */
+		PUT_INDEX(lock_ptr, 0);	/* clean index in case lockmetering  */
+		/* gets turned on before unlock */
+	} else {
+		void *this_pc = LSTAT_RA(LSTAT_RA_SPIN);
+		int index;
+
+		if (_raw_spin_trylock(lock_ptr)) {
+			index = lstat_update(lock_ptr, this_pc,
+						LSTAT_ACT_NO_WAIT);
+		} else {
+			uint32_t start_cycles = get_cycles();
+			_raw_spin_lock(lock_ptr);	/* do the real lock */
+			index = lstat_update_time(lock_ptr, this_pc,
+				LSTAT_ACT_SPIN, get_cycles() - start_cycles);
+		}
+		/* save the index in the lock itself for use in spin unlock */
+		PUT_INDEX(lock_ptr, index);
+	}
+}
+/* some archs require this for atomic_dec_and_lock in modules */
+EXPORT_SYMBOL(_metered_spin_lock);
+
+void
+_metered_spin_lock_flags(spinlock_t * lock_ptr, unsigned long flags, 
+			 void *caller_pc)
+{
+	if (lstat_control.state == LSTAT_OFF) {
+		_raw_spin_lock(lock_ptr);	/* do the real lock */
+		PUT_INDEX(lock_ptr, 0);	/* clean index in case lockmetering  */
+		/* gets turned on before unlock */
+	} else {
+		void *this_pc = LSTAT_RA(LSTAT_RA_SPIN);
+		int index;
+
+		if (_raw_spin_trylock(lock_ptr)) {
+			index = lstat_update(lock_ptr, this_pc,
+						LSTAT_ACT_NO_WAIT);
+		} else {
+			uint32_t start_cycles = get_cycles();
+			/* do the real lock */
+			_raw_spin_lock_flags(lock_ptr, flags);	
+			index = lstat_update_time(lock_ptr, this_pc,
+				LSTAT_ACT_SPIN, get_cycles() - start_cycles);
+		}
+		/* save the index in the lock itself for use in spin unlock */
+		PUT_INDEX(lock_ptr, index);
+	}
+}
+
+int
+_metered_spin_trylock(spinlock_t * lock_ptr, void *caller_pc)
+{
+	if (lstat_control.state == LSTAT_OFF) {
+		return _raw_spin_trylock(lock_ptr);
+	} else {
+		int retval;
+		void *this_pc = LSTAT_RA(LSTAT_RA_SPIN);
+
+		if ((retval = _raw_spin_trylock(lock_ptr))) {
+			int index = lstat_update(lock_ptr, this_pc,
+						LSTAT_ACT_NO_WAIT);
+			/*
+			 * save the index in the lock itself for use in spin
+			 * unlock
+			 */
+			PUT_INDEX(lock_ptr, index);
+		} else {
+			lstat_update(lock_ptr, this_pc, LSTAT_ACT_REJECT);
+		}
+
+		return retval;
+	}
+}
+
+void
+_metered_spin_unlock(spinlock_t * lock_ptr)
+{
+	int index = -1;
+
+	if (lstat_control.state != LSTAT_OFF) {
+		index = GET_INDEX(lock_ptr);
+		/*
+		 * If statistics were turned off when we set the lock,
+		 * then the index can be zero.  If that is the case,
+		 * then collect no stats on this call.
+		 */
+		if (index > 0) {
+			uint32_t hold_time;
+			int cpu = THIS_CPU_NUMBER;
+			hold_time = get_cycles() -
+			 (*lstat_control.counts[cpu])[index].acquire_time;
+			(*lstat_control.counts[cpu])[index].cum_hold_ticks +=
+				(uint64_t) hold_time;
+			if ((*lstat_control.counts[cpu])[index].max_hold_ticks <
+			    hold_time)
+				(*lstat_control.counts[cpu])[index].
+				    max_hold_ticks = hold_time;
+		}
+	}
+
+	/* make sure we don't have a stale index value saved */
+	PUT_INDEX(lock_ptr, 0);
+	_raw_spin_unlock(lock_ptr);	/* do the real unlock */
+}
+/* some archs require this for atomic_dec_and_lock in modules*/
+EXPORT_SYMBOL(_metered_spin_unlock);
+
+/*
+ * allocate the next global read lock structure and store its index
+ * in the rwlock at "lock_ptr".
+ */
+uint32_t
+alloc_rwlock_struct(rwlock_t * rwlock_ptr)
+{
+	int index;
+	unsigned long flags;
+	int cpu = THIS_CPU_NUMBER;
+
+	/* If we've already overflowed, then do a quick exit */
+	if (lstat_control.next_free_read_lock_index >
+			LSTAT_MAX_READ_LOCK_INDEX) {
+		lstat_control.rwlock_overflow++;
+		return 0;
+	}
+
+	local_irq_save(flags);
+	_raw_spin_lock(&lstat_control.directory_lock);
+
+	/* It is possible this changed while we were waiting for the directory_lock */
+	if (lstat_control.state == LSTAT_OFF) {
+		index = 0;
+		goto unlock;
+	}
+
+	/* It is possible someone else got here first and set the index */
+	if ((index = GET_RWINDEX(rwlock_ptr)) == 0) {
+		/*
+		 * we can't turn on read stats for this lock while there are
+		 * readers (this would mess up the running hold time sum at
+		 * unlock time)
+		 */
+		if (RWLOCK_READERS(rwlock_ptr) != 0) {
+			index = 0;
+			goto unlock;
+		}
+
+		/*
+		 * if stats are turned on after being off, we may need to
+		 * return an old index from when the statistics were on last
+		 * time.
+		 */
+		for (index = 1; index < lstat_control.next_free_read_lock_index;
+				index++)
+			if ((*lstat_control.read_lock_counts[cpu])[index].
+					lock_ptr == rwlock_ptr)
+				goto put_index_and_unlock;
+
+		/* allocate the next global read lock structure */
+		if (lstat_control.next_free_read_lock_index >=
+		    LSTAT_MAX_READ_LOCK_INDEX) {
+			lstat_control.rwlock_overflow++;
+			index = 0;
+			goto unlock;
+		}
+		index = lstat_control.next_free_read_lock_index++;
+
+		/*
+		 * initialize the global read stats data structure for each
+		 * cpu
+		 */
+		for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+			(*lstat_control.read_lock_counts[cpu])[index].lock_ptr =
+				rwlock_ptr;
+		}
+put_index_and_unlock:
+		/* store the index for the read lock structure into the lock */
+		PUT_RWINDEX(rwlock_ptr, index);
+	}
+
+unlock:
+	_raw_spin_unlock(&lstat_control.directory_lock);
+	local_irq_restore(flags);
+	return index;
+}
+
+void
+_metered_read_lock(rwlock_t * rwlock_ptr, void *caller_pc)
+{
+	void *this_pc;
+	uint32_t start_cycles;
+	int index;
+	int cpu;
+	unsigned long flags;
+	int readers_before, readers_after;
+	uint64_t cycles64;
+
+	if (lstat_control.state == LSTAT_OFF) {
+		_raw_read_lock(rwlock_ptr);
+		/* clean index in case lockmetering turns on before an unlock */
+		PUT_RWINDEX(rwlock_ptr, 0);
+		return;
+	}
+
+	this_pc = LSTAT_RA(LSTAT_RA_READ);
+	cpu = THIS_CPU_NUMBER;
+	index = GET_RWINDEX(rwlock_ptr);
+
+	/* allocate the global stats entry for this lock, if needed */
+	if (index == 0)
+		index = alloc_rwlock_struct(rwlock_ptr);
+
+	readers_before = RWLOCK_READERS(rwlock_ptr);
+	if (_raw_read_trylock(rwlock_ptr)) {
+		/*
+		 * We have decremented the lock to count a new reader,
+		 * and have confirmed that no writer has it locked.
+		 */
+		/* update statistics if enabled */
+		if (index > 0) {
+			local_irq_save(flags);
+			lstat_update((void *) rwlock_ptr, this_pc,
+					LSTAT_ACT_NO_WAIT);
+			/* preserve value of TSC so cum_hold_ticks and start_busy use same value */
+			cycles64 = get_cycles64();
+			(*lstat_control.read_lock_counts[cpu])[index].
+				cum_hold_ticks -= cycles64;
+
+			/* record time and cpu of start of busy period */
+			/* this is not perfect (some race conditions are possible) */
+			if (readers_before == 0) {
+				(*lstat_control.read_lock_counts[cpu])[index].
+					start_busy = cycles64;
+				PUT_RW_CPU(rwlock_ptr, cpu);
+			}
+			readers_after = RWLOCK_READERS(rwlock_ptr);
+			if (readers_after >
+				(*lstat_control.read_lock_counts[cpu])[index].
+					max_readers)
+				(*lstat_control.read_lock_counts[cpu])[index].
+					max_readers = readers_after;
+			local_irq_restore(flags);
+		}
+
+		return;
+	}
+	/* If we get here, then we could not quickly grab the read lock */
+
+	start_cycles = get_cycles();	/* start counting the wait time */
+
+	/* Now spin until read_lock is successful */
+	_raw_read_lock(rwlock_ptr);
+
+	lstat_update_time((void *) rwlock_ptr, this_pc, LSTAT_ACT_SPIN,
+			  get_cycles() - start_cycles);
+
+	/* update statistics if they are enabled for this lock */
+	if (index > 0) {
+		local_irq_save(flags);
+		cycles64 = get_cycles64();
+		(*lstat_control.read_lock_counts[cpu])[index].cum_hold_ticks -=
+				cycles64;
+
+		/* this is not perfect (some race conditions are possible) */
+		if (readers_before == 0) {
+			(*lstat_control.read_lock_counts[cpu])[index].
+				start_busy = cycles64;
+			PUT_RW_CPU(rwlock_ptr, cpu);
+		}
+		readers_after = RWLOCK_READERS(rwlock_ptr);
+		if (readers_after >
+		    (*lstat_control.read_lock_counts[cpu])[index].max_readers)
+			(*lstat_control.read_lock_counts[cpu])[index].
+				max_readers = readers_after;
+		local_irq_restore(flags);
+	}
+}
+
+void
+_metered_read_unlock(rwlock_t * rwlock_ptr)
+{
+	int index;
+	int cpu;
+	unsigned long flags;
+	uint64_t busy_length;
+	uint64_t cycles64;
+
+	if (lstat_control.state == LSTAT_OFF) {
+		_raw_read_unlock(rwlock_ptr);
+		return;
+	}
+
+	index = GET_RWINDEX(rwlock_ptr);
+	cpu = THIS_CPU_NUMBER;
+
+	if (index > 0) {
+		local_irq_save(flags);
+		/*
+		 * preserve value of TSC so cum_hold_ticks and busy_ticks are
+		 * consistent.
+		 */
+		cycles64 = get_cycles64();
+		(*lstat_control.read_lock_counts[cpu])[index].cum_hold_ticks +=
+			cycles64;
+		(*lstat_control.read_lock_counts[cpu])[index].read_lock_count++;
+
+		/*
+		 * once again, this is not perfect (some race conditions are
+		 * possible)
+		 */
+		if (RWLOCK_READERS(rwlock_ptr) == 1) {
+			int cpu1 = GET_RW_CPU(rwlock_ptr);
+			uint64_t last_start_busy =
+				(*lstat_control.read_lock_counts[cpu1])[index].
+					start_busy;
+			(*lstat_control.read_lock_counts[cpu])[index].
+				busy_periods++;
+			if (cycles64 > last_start_busy) {
+				busy_length = cycles64 - last_start_busy;
+				(*lstat_control.read_lock_counts[cpu])[index].
+					busy_ticks += busy_length;
+				if (busy_length >
+					(*lstat_control.
+						read_lock_counts[cpu])[index].
+							max_busy)
+					(*lstat_control.
+					 read_lock_counts[cpu])[index].
+						max_busy = busy_length;
+			}
+		}
+		local_irq_restore(flags);
+	}
+	_raw_read_unlock(rwlock_ptr);
+}
+
+void
+_metered_write_lock(rwlock_t * rwlock_ptr, void *caller_pc)
+{
+	uint32_t start_cycles;
+	void *this_pc;
+	uint32_t spin_ticks = 0; /* in anticipation of a potential wait */
+	int index;
+	int write_index = 0;
+	int cpu;
+	enum {
+		writer_writer_conflict,
+		writer_reader_conflict
+	} why_wait = writer_writer_conflict;
+
+	if (lstat_control.state == LSTAT_OFF) {
+		_raw_write_lock(rwlock_ptr);
+		/* clean index in case lockmetering turns on before an unlock */
+		PUT_RWINDEX(rwlock_ptr, 0);
+		return;
+	}
+
+	this_pc = LSTAT_RA(LSTAT_RA_WRITE);
+	cpu = THIS_CPU_NUMBER;
+	index = GET_RWINDEX(rwlock_ptr);
+
+	/* allocate the global stats entry for this lock, if needed */
+	if (index == 0) {
+		index = alloc_rwlock_struct(rwlock_ptr);
+	}
+
+	if (_raw_write_trylock(rwlock_ptr)) {
+		/* We acquired the lock on the first try */
+		write_index = lstat_update((void *) rwlock_ptr, this_pc,
+					LSTAT_ACT_NO_WAIT);
+		/* save the write_index for use in unlock if stats enabled */
+		if (index > 0)
+			(*lstat_control.read_lock_counts[cpu])[index].
+				write_index = write_index;
+		return;
+	}
+
+	/* If we get here, then we could not quickly grab the write lock */
+	start_cycles = get_cycles();	/* start counting the wait time */
+
+	why_wait = RWLOCK_READERS(rwlock_ptr) ?
+			writer_reader_conflict : writer_writer_conflict;
+
+	/* Now set the lock and wait for conflicts to disappear */
+	_raw_write_lock(rwlock_ptr);
+
+	spin_ticks = get_cycles() - start_cycles;
+
+	/* update stats -- if enabled */
+	if (index > 0 && spin_ticks) {
+		if (why_wait == writer_reader_conflict) {
+			/* waited due to a reader holding the lock */
+			write_index = lstat_update_time((void *)rwlock_ptr,
+					this_pc, LSTAT_ACT_SPIN, spin_ticks);
+		} else {
+			/*
+			 * waited due to another writer holding the lock
+			 */
+			write_index = lstat_update_time((void *)rwlock_ptr,
+				this_pc, LSTAT_ACT_WW_SPIN, spin_ticks);
+			(*lstat_control.counts[cpu])[write_index].
+				cum_wait_ww_ticks += spin_ticks;
+			if (spin_ticks >
+				(*lstat_control.counts[cpu])[write_index].
+					max_wait_ww_ticks) {
+				(*lstat_control.counts[cpu])[write_index].
+					max_wait_ww_ticks = spin_ticks;
+			}
+		}
+
+		/* save the directory index for use on write_unlock */
+		(*lstat_control.read_lock_counts[cpu])[index].
+			write_index = write_index;
+	}
+}
+
+void
+_metered_write_unlock(rwlock_t * rwlock_ptr)
+{
+	int index;
+	int cpu;
+	int write_index;
+	uint32_t hold_time;
+
+	if (lstat_control.state == LSTAT_OFF) {
+		_raw_write_unlock(rwlock_ptr);
+		return;
+	}
+
+	cpu = THIS_CPU_NUMBER;
+	index = GET_RWINDEX(rwlock_ptr);
+
+	/* update statistics if stats enabled for this lock */
+	if (index > 0) {
+		write_index =
+		    (*lstat_control.read_lock_counts[cpu])[index].write_index;
+
+		hold_time = get_cycles() -
+			(*lstat_control.counts[cpu])[write_index].acquire_time;
+		(*lstat_control.counts[cpu])[write_index].cum_hold_ticks +=
+			(uint64_t) hold_time;
+		if ((*lstat_control.counts[cpu])[write_index].max_hold_ticks <
+				hold_time)
+			(*lstat_control.counts[cpu])[write_index].
+				max_hold_ticks = hold_time;
+	}
+	_raw_write_unlock(rwlock_ptr);
+}
+
+int
+_metered_write_trylock(rwlock_t * rwlock_ptr, void *caller_pc)
+{
+	int retval;
+	void *this_pc = LSTAT_RA(LSTAT_RA_WRITE);
+
+	if ((retval = _raw_write_trylock(rwlock_ptr))) {
+		lstat_update(rwlock_ptr, this_pc, LSTAT_ACT_NO_WAIT);
+	} else {
+		lstat_update(rwlock_ptr, this_pc, LSTAT_ACT_REJECT);
+	}
+
+	return retval;
+}
+
+static void
+init_control_space(void)
+{
+	/* Set all control space pointers to null and indices to "empty" */
+	int cpu;
+
+	/*
+	 * Access CPU_CYCLE_FREQUENCY at the outset, which in some
+	 * architectures may trigger a runtime calculation that uses a
+	 * spinlock.  Let's do this before lockmetering is turned on.
+	 */
+	if (CPU_CYCLE_FREQUENCY == 0)
+		BUG();
+
+	lstat_control.hashtab = NULL;
+	lstat_control.dir = NULL;
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		lstat_control.counts[cpu] = NULL;
+		lstat_control.read_lock_counts[cpu] = NULL;
+	}
+}
+
+static int
+reset_lstat_data(void)
+{
+	int cpu, flags;
+
+	flags = 0;
+	lstat_control.next_free_dir_index = 1;	/* 0 is for overflows */
+	lstat_control.next_free_read_lock_index = 1;
+	lstat_control.dir_overflow = 0;
+	lstat_control.rwlock_overflow = 0;
+
+	lstat_control.started_cycles64 = 0;
+	lstat_control.ending_cycles64 = 0;
+	lstat_control.enabled_cycles64 = 0;
+	lstat_control.first_started_time = 0;
+	lstat_control.started_time = 0;
+	lstat_control.ending_time = 0;
+	lstat_control.intervals = 0;
+
+	/*
+	 * paranoia -- in case someone does a "lockstat reset" before
+	 * "lockstat on"
+	 */
+	if (lstat_control.hashtab) {
+		bzero(lstat_control.hashtab,
+			LSTAT_HASH_TABLE_SIZE * sizeof (short));
+		bzero(lstat_control.dir, LSTAT_MAX_STAT_INDEX *
+				sizeof (lstat_directory_entry_t));
+
+		for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+			bzero(lstat_control.counts[cpu],
+				sizeof (lstat_cpu_counts_t));
+			bzero(lstat_control.read_lock_counts[cpu],
+				sizeof (lstat_read_lock_cpu_counts_t));
+		}
+	}
+#ifdef NOTDEF
+	_raw_spin_unlock(&lstat_control.directory_lock);
+	local_irq_restore(flags);
+#endif
+	return 1;
+}
+
+static void
+release_control_space(void)
+{
+	/*
+	 * Called when either (1) allocation of kmem
+	 * or (2) when user writes LSTAT_RELEASE to /pro/lockmeter.
+	 * Assume that all pointers have been initialized to zero,
+	 * i.e., nonzero pointers are valid addresses.
+	 */
+	int cpu;
+
+	if (lstat_control.hashtab) {
+		kfree(lstat_control.hashtab);
+		lstat_control.hashtab = NULL;
+	}
+
+	if (lstat_control.dir) {
+		vfree(lstat_control.dir);
+		lstat_control.dir = NULL;
+	}
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (lstat_control.counts[cpu]) {
+			vfree(lstat_control.counts[cpu]);
+			lstat_control.counts[cpu] = NULL;
+		}
+		if (lstat_control.read_lock_counts[cpu]) {
+			kfree(lstat_control.read_lock_counts[cpu]);
+			lstat_control.read_lock_counts[cpu] = NULL;
+		}
+	}
+}
+
+int
+get_lockmeter_info_size(void)
+{
+	return sizeof (lstat_user_request_t)
+		+ num_online_cpus() * sizeof (lstat_cpu_counts_t)
+		+ num_online_cpus() * sizeof (lstat_read_lock_cpu_counts_t)
+		+ (LSTAT_MAX_STAT_INDEX * sizeof (lstat_directory_entry_t));
+}
+
+ssize_t
+get_lockmeter_info(char *buffer, size_t max_len, loff_t * last_index)
+{
+	lstat_user_request_t req;
+	struct timeval tv;
+	ssize_t next_ret_bcount;
+	ssize_t actual_ret_bcount = 0;
+	int cpu;
+
+	*last_index = 0;	/* a one-shot read */
+
+	req.lstat_version = LSTAT_VERSION;
+	req.state = lstat_control.state;
+	req.maxcpus = num_online_cpus();
+	req.cycleval = CPU_CYCLE_FREQUENCY;
+#ifdef notyet
+	req.kernel_magic_addr = (void *) &_etext;
+	req.kernel_end_addr = (void *) &_etext;
+#endif
+	req.uts = system_utsname;
+	req.intervals = lstat_control.intervals;
+
+	req.first_started_time = lstat_control.first_started_time;
+	req.started_time = lstat_control.started_time;
+	req.started_cycles64 = lstat_control.started_cycles64;
+
+	req.next_free_dir_index = lstat_control.next_free_dir_index;
+	req.next_free_read_lock_index = lstat_control.next_free_read_lock_index;
+	req.dir_overflow = lstat_control.dir_overflow;
+	req.rwlock_overflow = lstat_control.rwlock_overflow;
+
+	if (lstat_control.state == LSTAT_OFF) {
+		if (req.intervals == 0) {
+			/* mesasurement is off and no valid data present */
+			next_ret_bcount = sizeof (lstat_user_request_t);
+			req.enabled_cycles64 = 0;
+
+			if ((actual_ret_bcount + next_ret_bcount) > max_len)
+				return actual_ret_bcount;
+
+			copy_to_user(buffer, (void *) &req, next_ret_bcount);
+			actual_ret_bcount += next_ret_bcount;
+			return actual_ret_bcount;
+		} else {
+			/*
+			 * measurement is off but valid data present
+			 * fetch time info from lstat_control
+			 */
+			req.ending_time = lstat_control.ending_time;
+			req.ending_cycles64 = lstat_control.ending_cycles64;
+			req.enabled_cycles64 = lstat_control.enabled_cycles64;
+		}
+	} else {
+		/*
+		 * this must be a read while data active--use current time,
+		 * etc
+		 */
+		do_gettimeofday(&tv);
+		req.ending_time = tv.tv_sec;
+		req.ending_cycles64 = get_cycles64();
+		req.enabled_cycles64 = req.ending_cycles64 -
+			req.started_cycles64 + lstat_control.enabled_cycles64;
+	}
+
+	next_ret_bcount = sizeof (lstat_user_request_t);
+	if ((actual_ret_bcount + next_ret_bcount) > max_len)
+		return actual_ret_bcount;
+
+	copy_to_user(buffer, (void *) &req, next_ret_bcount);
+	actual_ret_bcount += next_ret_bcount;
+
+	if (!lstat_control.counts[0])	/* not initialized? */
+		return actual_ret_bcount;
+
+	next_ret_bcount = sizeof (lstat_cpu_counts_t);
+	for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+		if ((actual_ret_bcount + next_ret_bcount) > max_len)
+			return actual_ret_bcount;	/* leave early */
+		copy_to_user(buffer + actual_ret_bcount,
+				lstat_control.counts[cpu], next_ret_bcount);
+		actual_ret_bcount += next_ret_bcount;
+	}
+
+	next_ret_bcount = LSTAT_MAX_STAT_INDEX *
+			sizeof (lstat_directory_entry_t);
+	if (((actual_ret_bcount + next_ret_bcount) > max_len)
+			|| !lstat_control.dir)
+		return actual_ret_bcount;	/* leave early */
+
+	copy_to_user(buffer + actual_ret_bcount, lstat_control.dir,
+			next_ret_bcount);
+	actual_ret_bcount += next_ret_bcount;
+
+	next_ret_bcount = sizeof (lstat_read_lock_cpu_counts_t);
+	for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+		if (actual_ret_bcount + next_ret_bcount > max_len)
+			return actual_ret_bcount;
+		copy_to_user(buffer + actual_ret_bcount,
+				lstat_control.read_lock_counts[cpu],
+				next_ret_bcount);
+		actual_ret_bcount += next_ret_bcount;
+	}
+
+	return actual_ret_bcount;
+}
+
+/*
+ *  Writing to the /proc lockmeter node enables or disables metering.
+ *  based upon the first byte of the "written" data.
+ *  The following values are defined:
+ *  LSTAT_ON: 1st call: allocates storage, intializes and turns on measurement
+ *            subsequent calls just turn on measurement
+ *  LSTAT_OFF: turns off measurement
+ *  LSTAT_RESET: resets statistics
+ *  LSTAT_RELEASE: releases statistics storage
+ *
+ *  This allows one to accumulate statistics over several lockstat runs:
+ *
+ *  lockstat on
+ *  lockstat off
+ *  ...repeat above as desired...
+ *  lockstat get
+ *  ...now start a new set of measurements...
+ *  lockstat reset
+ *  lockstat on
+ *  ...
+ *
+ */
+ssize_t
+put_lockmeter_info(const char *buffer, size_t len)
+{
+	int error = 0;
+	int dirsize, countsize, read_lock_countsize, hashsize;
+	int cpu;
+	char put_char;
+	int i, read_lock_blocks;
+	unsigned long flags;
+	rwlock_t *lock_ptr;
+	struct timeval tv;
+
+	if (len <= 0)
+		return -EINVAL;
+
+	_raw_spin_lock(&lstat_control.control_lock);
+
+	get_user(put_char, buffer);
+	switch (put_char) {
+
+	case LSTAT_OFF:
+		if (lstat_control.state != LSTAT_OFF) {
+			/*
+			 * To avoid seeing read lock hold times in an
+			 * inconsisent state, we have to follow this protocol
+			 * to turn off statistics
+			 */
+			local_irq_save(flags);
+			/*
+			 * getting this lock will stop any read lock block
+			 * allocations
+			 */
+			_raw_spin_lock(&lstat_control.directory_lock);
+			/*
+			 * keep any more read lock blocks from being
+			 * allocated
+			 */
+			lstat_control.state = LSTAT_OFF;
+			/* record how may read lock blocks there are */
+			read_lock_blocks =
+				lstat_control.next_free_read_lock_index;
+			_raw_spin_unlock(&lstat_control.directory_lock);
+			/* now go through the list of read locks */
+			cpu = THIS_CPU_NUMBER;
+			for (i = 1; i < read_lock_blocks; i++) {
+				lock_ptr =
+				    (*lstat_control.read_lock_counts[cpu])[i].
+				    lock_ptr;
+				/* is this saved lock address still valid? */
+				if (GET_RWINDEX(lock_ptr) == i) {
+					/*
+					 * lock address appears to still be
+					 * valid because we only hold one lock
+					 * at a time, this can't cause a
+					 * deadlock unless this is a lock held
+					 * as part of the current system call
+					 * path. At the moment there
+					 * are no READ mode locks held to get
+					 * here from user space, so we solve
+					 * this by skipping locks held in
+					 * write mode.
+					 */
+					if (RWLOCK_IS_WRITE_LOCKED(lock_ptr)) {
+						PUT_RWINDEX(lock_ptr, 0);
+						continue;
+					}
+					/*
+					 * now we know there are no read
+					 * holders of this lock! stop
+					 * statistics collection for this
+					 * lock
+					 */
+					_raw_write_lock(lock_ptr);
+					PUT_RWINDEX(lock_ptr, 0);
+					_raw_write_unlock(lock_ptr);
+				}
+				/*
+				 * it may still be possible for the hold time
+				 * sum to be negative e.g. if a lock is
+				 * reallocated while "busy" we will have to fix
+				 * this up in the data reduction program.
+				 */
+			}
+			local_irq_restore(flags);
+			lstat_control.intervals++;
+			lstat_control.ending_cycles64 = get_cycles64();
+			lstat_control.enabled_cycles64 +=
+				lstat_control.ending_cycles64 -
+				lstat_control.started_cycles64;
+			do_gettimeofday(&tv);
+			lstat_control.ending_time = tv.tv_sec;
+			/*
+			 * don't deallocate the structures -- we may do a
+			 * lockstat on to add to the data that is already
+			 * there. Use LSTAT_RELEASE to release storage
+			 */
+		} else {
+			error = -EBUSY;	/* already OFF */
+		}
+		break;
+
+	case LSTAT_ON:
+		if (lstat_control.state == LSTAT_OFF) {
+#ifdef DEBUG_LOCKMETER
+			printk("put_lockmeter_info(cpu=%d): LSTAT_ON\n",
+				THIS_CPU_NUMBER);
+#endif
+			lstat_control.next_free_dir_index = 1;	/* 0 is for overflows */
+
+			dirsize = LSTAT_MAX_STAT_INDEX *
+					sizeof (lstat_directory_entry_t);
+			hashsize =
+				(1 + LSTAT_HASH_TABLE_SIZE) * sizeof (ushort);
+			countsize = sizeof (lstat_cpu_counts_t);
+			read_lock_countsize =
+				sizeof (lstat_read_lock_cpu_counts_t);
+#ifdef DEBUG_LOCKMETER
+			printk(" dirsize:%d", dirsize);
+			printk(" hashsize:%d", hashsize);
+			printk(" countsize:%d", countsize);
+			printk(" read_lock_countsize:%d\n",
+				read_lock_countsize);
+#endif
+#ifdef DEBUG_LOCKMETER
+			{
+				int secs;
+				unsigned long cycles;
+				uint64_t cycles64;
+
+				do_gettimeofday(&tv);
+				secs = tv.tv_sec;
+				do {
+					do_gettimeofday(&tv);
+				} while (secs == tv.tv_sec);
+				cycles = get_cycles();
+				cycles64 = get_cycles64();
+				secs = tv.tv_sec;
+				do {
+					do_gettimeofday(&tv);
+				} while (secs == tv.tv_sec);
+				cycles = get_cycles() - cycles;
+				cycles64 = get_cycles64() - cycles;
+				printk("lockmeter: cycleFrequency:%d "
+					"cycles:%d cycles64:%d\n",
+					CPU_CYCLE_FREQUENCY, cycles, cycles64);
+			}
+#endif
+
+			/*
+			 * if this is the first call, allocate storage and
+			 * initialize
+			 */
+			if (!lstat_control.hashtab) {
+
+				spin_lock_init(&lstat_control.directory_lock);
+
+				/* guarantee all pointers at zero */
+				init_control_space();
+
+				lstat_control.hashtab =
+				    kmalloc(hashsize, GFP_KERNEL);
+				if (!lstat_control.hashtab) {
+					error = -ENOSPC;
+#ifdef DEBUG_LOCKMETER
+					printk("!!error kmalloc of hashtab\n");
+#endif
+				}
+				lstat_control.dir = vmalloc(dirsize);
+				if (!lstat_control.dir) {
+					error = -ENOSPC;
+#ifdef DEBUG_LOCKMETER
+					printk("!!error kmalloc of dir\n");
+#endif
+				}
+
+				for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+					lstat_control.counts[cpu] =
+						vmalloc(countsize);
+					if (!lstat_control.counts[cpu]) {
+						error = -ENOSPC;
+#ifdef DEBUG_LOCKMETER
+						printk("!!error vmalloc of "
+							"counts[%d]\n", cpu);
+#endif
+					}
+					lstat_control.read_lock_counts[cpu] =
+						(lstat_read_lock_cpu_counts_t *)
+						kmalloc(read_lock_countsize,
+							GFP_KERNEL);
+					if (!lstat_control.
+							read_lock_counts[cpu]) {
+						error = -ENOSPC;
+#ifdef DEBUG_LOCKMETER
+						printk("!!error kmalloc of "
+						  "read_lock_counts[%d]\n",
+							cpu);
+#endif
+					}
+				}
+			}
+
+			if (error) {
+				/*
+				 * One or more kmalloc failures -- free
+				 * everything
+				 */
+				release_control_space();
+			} else {
+
+				if (!reset_lstat_data()) {
+					error = -EINVAL;
+					break;
+				};
+
+				/*
+				 * record starting and ending times and the
+				 * like
+				 */
+				if (lstat_control.intervals == 0) {
+					do_gettimeofday(&tv);
+					lstat_control.first_started_time =
+						tv.tv_sec;
+				}
+				lstat_control.started_cycles64 = get_cycles64();
+				do_gettimeofday(&tv);
+				lstat_control.started_time = tv.tv_sec;
+
+				lstat_control.state = LSTAT_ON;
+			}
+		} else {
+			error = -EBUSY;	/* already ON */
+		}
+		break;
+
+	case LSTAT_RESET:
+		if (lstat_control.state == LSTAT_OFF) {
+			if (!reset_lstat_data())
+				error = -EINVAL;
+		} else {
+			error = -EBUSY;	/* still on; can't reset */
+		}
+		break;
+
+	case LSTAT_RELEASE:
+		if (lstat_control.state == LSTAT_OFF) {
+			release_control_space();
+			lstat_control.intervals = 0;
+			lstat_control.enabled_cycles64 = 0;
+		} else {
+			error = -EBUSY;
+		}
+		break;
+
+	default:
+		error = -EINVAL;
+	}			/* switch */
+
+	_raw_spin_unlock(&lstat_control.control_lock);
+	return error ? error : len;
+}
+
+#ifdef USER_MODE_TESTING
+/* following used for user mode testing */
+void
+lockmeter_init()
+{
+	int dirsize, hashsize, countsize, read_lock_countsize, cpu;
+
+	printf("lstat_control is at %x size=%d\n", &lstat_control,
+		sizeof (lstat_control));
+	printf("sizeof(spinlock_t)=%d\n", sizeof (spinlock_t));
+	lstat_control.state = LSTAT_ON;
+
+	lstat_control.directory_lock = SPIN_LOCK_UNLOCKED;
+	lstat_control.next_free_dir_index = 1;	/* 0 is for overflows */
+	lstat_control.next_free_read_lock_index = 1;
+
+	dirsize = LSTAT_MAX_STAT_INDEX * sizeof (lstat_directory_entry_t);
+	hashsize = (1 + LSTAT_HASH_TABLE_SIZE) * sizeof (ushort);
+	countsize = sizeof (lstat_cpu_counts_t);
+	read_lock_countsize = sizeof (lstat_read_lock_cpu_counts_t);
+
+	lstat_control.hashtab = (ushort *) malloc(hashsize);
+
+	if (lstat_control.hashtab == 0) {
+		printf("malloc failure for at line %d in lockmeter.c\n",
+			__LINE__);
+		exit(0);
+	}
+
+	lstat_control.dir = (lstat_directory_entry_t *) malloc(dirsize);
+
+	if (lstat_control.dir == 0) {
+		printf("malloc failure for at line %d in lockmeter.c\n", cpu,
+			__LINE__);
+		exit(0);
+	}
+
+	for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+		int j, k;
+		j = (int) (lstat_control.counts[cpu] =
+			   (lstat_cpu_counts_t *) malloc(countsize));
+		k = (int) (lstat_control.read_lock_counts[cpu] =
+			   (lstat_read_lock_cpu_counts_t *)
+			   malloc(read_lock_countsize));
+		if (j * k == 0) {
+			printf("malloc failure for cpu=%d at line %d in "
+				"lockmeter.c\n", cpu, __LINE__);
+			exit(0);
+		}
+	}
+
+	memset(lstat_control.hashtab, 0, hashsize);
+	memset(lstat_control.dir, 0, dirsize);
+
+	for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+		memset(lstat_control.counts[cpu], 0, countsize);
+		memset(lstat_control.read_lock_counts[cpu], 0,
+			read_lock_countsize);
+	}
+}
+
+asm(" \
+.align	4 \
+.globl	__write_lock_failed \
+__write_lock_failed: \
+	" LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax) \
+1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax) \
+	jne	1b \
+\
+	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax) \
+	jnz	__write_lock_failed \
+	ret \
+\
+\
+.align	4 \
+.globl	__read_lock_failed \
+__read_lock_failed: \
+	lock ; incl	(%eax) \
+1:	cmpl	$1,(%eax) \
+	js	1b \
+\
+	lock ; decl	(%eax) \
+	js	__read_lock_failed \
+	ret \
+");
+#endif
+
+/*
+ * these definitions need to match what is in kernel/spinlock.c
+ * except for the fact tht calls to _raw_ routines are replaced by 
+ * corresponding calls to the _metered_ routines
+ */
+int __lockfunc _spin_trylock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (_metered_spin_trylock(lock, __builtin_return_address(0)))
+		return 1;
+	
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_spin_trylock);
+
+int __lockfunc _write_trylock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (_metered_write_trylock(lock, __builtin_return_address(0)))
+		return 1;
+
+	preempt_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_write_trylock);
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+void __lockfunc _spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_metered_spin_trylock(lock, __builtin_return_address(0))))
+		__preempt_spin_lock(lock);
+}
+
+void __lockfunc _write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	if (unlikely(!_metered_write_trylock(lock, __builtin_return_address(0))))
+		__preempt_write_lock(lock);
+}
+#else
+void __lockfunc _spin_lock(spinlock_t *lock)
+{
+	preempt_disable();
+	_metered_spin_lock(lock, __builtin_return_address(0));
+}
+
+void __lockfunc _write_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_metered_write_lock(lock, __builtin_return_address(0));
+}
+#endif
+EXPORT_SYMBOL(_spin_lock);
+EXPORT_SYMBOL(_write_lock);
+
+void __lockfunc _read_lock(rwlock_t *lock)
+{
+	preempt_disable();
+	_metered_read_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_read_lock);
+
+void __lockfunc _spin_unlock(spinlock_t *lock)
+{
+	_metered_spin_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock);
+
+void __lockfunc _write_unlock(rwlock_t *lock)
+{
+	_metered_write_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock);
+
+void __lockfunc _read_unlock(rwlock_t *lock)
+{
+	_metered_read_unlock(lock);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock);
+
+unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_metered_spin_lock_flags(lock, flags, __builtin_return_address(0));
+	return flags;
+}
+EXPORT_SYMBOL(_spin_lock_irqsave);
+
+void __lockfunc _spin_lock_irq(spinlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_metered_spin_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_spin_lock_irq);
+
+void __lockfunc _spin_lock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_metered_spin_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_spin_lock_bh);
+
+unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_metered_read_lock(lock, __builtin_return_address(0));
+	return flags;
+}
+EXPORT_SYMBOL(_read_lock_irqsave);
+
+void __lockfunc _read_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_metered_read_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_read_lock_irq);
+
+void __lockfunc _read_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_metered_read_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_read_lock_bh);
+
+unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	_metered_write_lock(lock, __builtin_return_address(0));
+	return flags;
+}
+EXPORT_SYMBOL(_write_lock_irqsave);
+
+void __lockfunc _write_lock_irq(rwlock_t *lock)
+{
+	local_irq_disable();
+	preempt_disable();
+	_metered_write_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_write_lock_irq);
+
+void __lockfunc _write_lock_bh(rwlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	_metered_write_lock(lock, __builtin_return_address(0));
+}
+EXPORT_SYMBOL(_write_lock_bh);
+
+void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+{
+	_metered_spin_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_irqrestore);
+
+void __lockfunc _spin_unlock_irq(spinlock_t *lock)
+{
+	_metered_spin_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_irq);
+
+void __lockfunc _spin_unlock_bh(spinlock_t *lock)
+{
+	_metered_spin_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(_spin_unlock_bh);
+
+void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+{
+	_metered_read_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock_irqrestore);
+
+void __lockfunc _read_unlock_irq(rwlock_t *lock)
+{
+	_metered_read_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(_read_unlock_irq);
+
+void __lockfunc _read_unlock_bh(rwlock_t *lock)
+{
+	_metered_read_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(_read_unlock_bh);
+
+void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+{
+	_metered_write_unlock(lock);
+	local_irq_restore(flags);
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock_irqrestore);
+
+void __lockfunc _write_unlock_irq(rwlock_t *lock)
+{
+	_metered_write_unlock(lock);
+	local_irq_enable();
+	preempt_enable();
+}
+EXPORT_SYMBOL(_write_unlock_irq);
+
+void __lockfunc _write_unlock_bh(rwlock_t *lock)
+{
+	_metered_write_unlock(lock);
+	preempt_enable();
+	local_bh_enable();
+}
+EXPORT_SYMBOL(_write_unlock_bh);
+
+int __lockfunc _spin_trylock_bh(spinlock_t *lock)
+{
+	local_bh_disable();
+	preempt_disable();
+	if (_metered_spin_trylock(lock, __builtin_return_address(0)))
+		return 1;
+
+	preempt_enable();
+	local_bh_enable();
+	return 0;
+}
+EXPORT_SYMBOL(_spin_trylock_bh);

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
