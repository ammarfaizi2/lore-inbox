Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312862AbSC0AYc>; Tue, 26 Mar 2002 19:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312867AbSC0AY0>; Tue, 26 Mar 2002 19:24:26 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:35038 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S312862AbSC0AYK>; Tue, 26 Mar 2002 19:24:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Define struct page early
Date: Tue, 26 Mar 2002 16:22:10 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020324112659Z16123-25734+21@humbolt.nl.linux.org> <20020324234249.GA10457@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020327002358Z16384-8743+61@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch does some surgery on header files so that struct page can
be defined much earlier than it traditionally has been.  With this patch,
we have:

   linux/mm.h
   |
   |--- asm/page.h
   |    |
   |    |--- linux/mem_map.h
   |    |    |
   |    |    |--- linux/list_head.h
   |    |    |
   |    |    |--- linux/spinlock_t.h
   |    |    |
   |    |    |--- linux/wait_queue.h
   |    |    |
   |    |    |--- asm/atomic_t.h
   |    |    |
   |    |    `--- struct page { ... };
   |    |
   |    `--- <per-arch page ops as inlines instead of macros>
   |
   `--- <the rest of mm.h>	

In other words, there are several new header files created, each containing
relatively primitive structure definitions that are dependent only on
built-in types or already-defined structures and types.

Breaking out the primitive structure definitions from their traditional header
files gets rid of the header topology problems that have traditionally forced 
the use of macros in many places where inlines would be preferable for 
reasons of readability and type safety.  The isolated structures are still 
included from the original header files for backward compatibility.  The 
usual #ifdef/#define arrangement prevents the new headers from being included 
more than once.

With this patch I was able to write __pa as an inline function, and the 
compiler was able to compile the expression 'page - mem_map', which otherwise 
would fail due to not knowing the size of struct page.

Now, why is struct page particularly important to define early?  Simple: our 
memory management scheme is based on the ability to directly compute a struct 
page given a physical address.  Without it, we can't write the inlines we 
want in page.h, so we write macros instead.  This are ugly, and the only 
reason we're doing it is because we've got too many things mixed together in 
the header files, which leads to impossible include order problems, which we 
solve with macros.  But macros are no good solution, especially when we're 
using them because we have to, not because we want to.

In a general sense, what I've done is form some headers into separable 
pieces, allowing a strict topological sort on the pieces, which isn't
possible with the traditional arrangment.

In the patch below, I've done just enough to be able to compile uml with
inlines in asm/page.h instead of macros (spin_lock is not properly broken up 
for the smp case in this patch).  I saved some time by taking advantage of 
the fact that, where a pointer to structure A is a field in structure B, 
structure A can be forward-declared, since a pointer has a known size.  Note 
however that if we want to use the fields of a structure early, this shortcut 
isn't possible.  Fortunately, it's always possible to create a strict 
priority sort of the structure definitions, so long as we don't tie them 
arbitrarily to other definitions with conflicting dependencies in the same 
header file.

As soon as I had the inline version of __pa, it picked up an oversight where
Jeff uses virtual addresses in his page tables instead of physical addresses.
It works in the case of uml, but it's quite unexpected and has only gone
unnoticed this long because of weak type checking due to use of macros.

Here's the patch against 2.4.17+uml (patch -p0):

--- ../2.4.17.uml.clean/include/asm-i386/atomic.h	Thu Nov 22 20:46:18 2001
+++ ./include/asm-i386/atomic.h	Tue Mar 26 11:40:34 2002
@@ -14,13 +14,6 @@
 #define LOCK ""
 #endif
 
-/*
- * Make sure gcc doesn't try to be clever and move things around
- * on us. We need to use _exactly_ the address the user gave us,
- * not some alias that contains the same information.
- */
-typedef struct { volatile int counter; } atomic_t;
-
 #define ATOMIC_INIT(i)	{ (i) }
 
 /**
--- ../2.4.17.uml.clean/include/asm-i386/atomic_t.h	Mon Mar 25 17:54:04 2002
+++ ./include/asm-i386/atomic_t.h	Tue Mar 26 11:38:13 2002
@@ -0,0 +1,12 @@
+#ifndef ATOMIC_T_H
+#define ATOMIC_T_H
+
+/*
+ * Make sure gcc doesn't try to be clever and move things around
+ * on us. We need to use _exactly_ the address the user gave us,
+ * not some alias that contains the same information.
+ */
+typedef struct { volatile int counter; } atomic_t;
+
+#endif
+
--- ../2.4.17.uml.clean/include/asm-i386/io.h	Thu Nov 22 20:46:27 2001
+++ ./include/asm-i386/io.h	Tue Mar 26 11:40:36 2002
@@ -63,7 +63,7 @@
  * Change virtual addresses to physical addresses and vv.
  * These are pretty trivial
  */
-static inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(void *address)
 {
 	return __pa(address);
 }
--- ../2.4.17.uml.clean/include/asm-i386/user.h	Thu Nov 22 20:48:21 2001
+++ ./include/asm-i386/user.h	Tue Mar 26 11:43:41 2002
@@ -1,6 +1,7 @@
 #ifndef _I386_USER_H
 #define _I386_USER_H
 
+#include <linux/mem_map.h>
 #include <asm/page.h>
 #include <linux/ptrace.h>
 /* Core file format: The core file is written in such a way that gdb
--- ../2.4.17.uml.clean/include/asm-um/atomic.h	Mon Mar 25 17:27:27 2002
+++ ./include/asm-um/atomic.h	Tue Mar 26 11:40:34 2002
@@ -1,6 +1,7 @@
 #ifndef __UM_ATOMIC_H
 #define __UM_ATOMIC_H
 
+#include "asm/arch/atomic_t.h"
 #include "asm/arch/atomic.h"
 
 #endif
--- ../2.4.17.uml.clean/include/asm-um/atomic_t.h	Tue Mar 26 00:52:46 2002
+++ ./include/asm-um/atomic_t.h	Tue Mar 26 11:38:13 2002
@@ -0,0 +1,6 @@
+#ifndef __UM_ATOMIC_T_H
+#define __UM_ATOMIC_T_H
+
+#include "asm/arch/atomic_t.h"
+
+#endif
--- ../2.4.17.uml.clean/include/asm-um/page.h	Mon Mar 25 17:27:28 2002
+++ ./include/asm-um/page.h	Tue Mar 26 11:38:13 2002
@@ -1,8 +1,7 @@
 #ifndef __UM_PAGE_H
 #define __UM_PAGE_H
 
-struct page;
-
+#include <linux/mem_map.h>
 #include "asm/arch/page.h"
 
 #undef BUG
@@ -26,9 +25,7 @@
 	stop(); \
 } while (0)
 
-#define PAGE_BUG(page) do { \
-	BUG(); \
-} while (0)
+#define PAGE_BUG(page) do { BUG(); } while (0)
 
 #endif /* __ASSEMBLY__ */
 
@@ -36,10 +33,26 @@
 
 #define __va_space (8*1024*1024)
 
-#define __pa(x)	((unsigned long) (x) - (uml_physmem))
-#define __va(x)	((void *) ((unsigned long) (x) + (uml_physmem)))
-
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+static inline unsigned long __pa(void *virt)
+{
+	return (unsigned long) (virt) - PAGE_OFFSET;
+}
+
+static inline void *__va(unsigned long phys)
+{
+	return (void *) ((unsigned long) (phys) + PAGE_OFFSET);
+}
+
+static inline struct page *virt_to_page(void *kaddr)
+{
+	return mem_map + (__pa(kaddr) >> PAGE_SHIFT);
+}
+
+extern unsigned long max_mapnr;
+
+static inline int VALID_PAGE(struct page *page)
+{
+	return page - mem_map < max_mapnr;
+}
 
 #endif
--- ../2.4.17.uml.clean/include/linux/list.h	Fri Dec 21 18:42:03 2001
+++ ./include/linux/list.h	Tue Mar 26 11:40:34 2002
@@ -3,6 +3,7 @@
 
 #if defined(__KERNEL__) || defined(_LVM_H_INCLUDE)
 
+#include <linux/list_head.h>
 #include <linux/prefetch.h>
 
 /*
@@ -14,15 +15,6 @@
  * generate better code by using them directly rather than
  * using the generic single-entry routines.
  */
-
-struct list_head {
-	struct list_head *next, *prev;
-};
-
-#define LIST_HEAD_INIT(name) { &(name), &(name) }
-
-#define LIST_HEAD(name) \
-	struct list_head name = LIST_HEAD_INIT(name)
 
 #define INIT_LIST_HEAD(ptr) do { \
 	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
--- ../2.4.17.uml.clean/include/linux/list_head.h	Mon Mar 25 17:54:04 2002
+++ ./include/linux/list_head.h	Tue Mar 26 11:38:13 2002
@@ -0,0 +1,13 @@
+#ifndef _LINUX_LISTHEAD_H
+#define _LINUX_LISTHEAD_H
+
+struct list_head {
+	struct list_head *next, *prev;
+};
+
+#define LIST_HEAD_INIT(name) { &(name), &(name) }
+
+#define LIST_HEAD(name) \
+	struct list_head name = LIST_HEAD_INIT(name)
+
+#endif
--- ../2.4.17.uml.clean/include/linux/mem_map.h	Mon Mar 25 17:54:04 2002
+++ ./include/linux/mem_map.h	Tue Mar 26 11:38:13 2002
@@ -0,0 +1,50 @@
+#ifndef _MEM_MAP_H
+#define _MEM_MAP_H
+
+#include <linux/list_head.h>
+#include <linux/spinlock_t.h>
+#include <linux/wait_queue.h>
+#include <asm/atomic_t.h>
+
+/*
+ * Each physical page in the system has a struct page associated with
+ * it to keep track of whatever it is we are using the page for at the
+ * moment. Note that we have no way to track which tasks are using
+ * a page.
+ *
+ * Try to keep the most commonly accessed fields in single cache lines
+ * here (16 bytes or greater).  This ordering should be particularly
+ * beneficial on 32-bit processors.
+ *
+ * The first line is data used in page cache lookup, the second line
+ * is used for linear searches (eg. clock algorithm scans).
+ *
+ * TODO: make this structure smaller, it could be as small as 32 bytes.
+ */
+
+struct buffer_head;
+struct zone_struct;
+
+typedef struct page {
+	struct list_head list;		/* ->mapping has some page lists. */
+	struct address_space *mapping;	/* The inode (or ...) we belong to. */
+	unsigned long index;		/* Our offset within mapping. */
+	struct page *next_hash;		/* Next page sharing our hash bucket in
+					   the pagecache hash table. */
+	atomic_t count;			/* Usage count, see below. */
+	unsigned long flags;		/* atomic flags, some possibly
+					   updated asynchronously */
+	struct list_head lru;		/* Pageout list, eg. active_list;
+					   protected by pagemap_lru_lock !! */
+	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
+	struct page **pprev_hash;	/* Complement to *next_hash. */
+	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
+	void *virtual;			/* Kernel virtual address (NULL if
+					   not kmapped, ie. highmem) */
+	struct zone_struct *zone;	/* Memory zone we are in. */
+} mem_map_t;
+
+/* The array of struct pages */
+extern mem_map_t *mem_map;
+
+#endif
\ No newline at end of file
--- ../2.4.17.uml.clean/include/linux/mm.h	Fri Dec 21 18:42:03 2001
+++ ./include/linux/mm.h	Tue Mar 26 11:40:34 2002
@@ -1,6 +1,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <asm/page.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 
@@ -21,7 +22,6 @@
 extern struct list_head active_list;
 extern struct list_head inactive_list;
 
-#include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/atomic.h>
 
@@ -125,7 +125,7 @@
 /*
  * These are the virtual MM functions - opening of an area, closing and
  * unmapping it (needed to keep files on disk up-to-date etc), pointer
- * to the functions called when a no-page or a wp-page exception occurs. 
+ * to the functions called when a no-page or a wp-page exception occurs.
  */
 struct vm_operations_struct {
 	void (*open)(struct vm_area_struct * area);
@@ -134,40 +134,6 @@
 };
 
 /*
- * Each physical page in the system has a struct page associated with
- * it to keep track of whatever it is we are using the page for at the
- * moment. Note that we have no way to track which tasks are using
- * a page.
- *
- * Try to keep the most commonly accessed fields in single cache lines
- * here (16 bytes or greater).  This ordering should be particularly
- * beneficial on 32-bit processors.
- *
- * The first line is data used in page cache lookup, the second line
- * is used for linear searches (eg. clock algorithm scans). 
- *
- * TODO: make this structure smaller, it could be as small as 32 bytes.
- */
-typedef struct page {
-	struct list_head list;		/* ->mapping has some page lists. */
-	struct address_space *mapping;	/* The inode (or ...) we belong to. */
-	unsigned long index;		/* Our offset within mapping. */
-	struct page *next_hash;		/* Next page sharing our hash bucket in
-					   the pagecache hash table. */
-	atomic_t count;			/* Usage count, see below. */
-	unsigned long flags;		/* atomic flags, some possibly
-					   updated asynchronously */
-	struct list_head lru;		/* Pageout list, eg. active_list;
-					   protected by pagemap_lru_lock !! */
-	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
-	struct page **pprev_hash;	/* Complement to *next_hash. */
-	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
-	void *virtual;			/* Kernel virtual address (NULL if
-					   not kmapped, ie. highmem) */
-	struct zone_struct *zone;	/* Memory zone we are in. */
-} mem_map_t;
-
-/*
  * Methods to modify the page usage count.
  *
  * What counts for a page usage:
@@ -344,9 +310,6 @@
  */
 #define NOPAGE_SIGBUS	(NULL)
 #define NOPAGE_OOM	((struct page *) (-1))
-
-/* The array of struct pages */
-extern mem_map_t * mem_map;
 
 /*
  * There is only one page-allocator function, and two main namespaces to
--- ../2.4.17.uml.clean/include/linux/spinlock.h	Thu Nov 22 20:46:19 2001
+++ ./include/linux/spinlock.h	Tue Mar 26 11:40:34 2002
@@ -40,27 +40,12 @@
 
 #elif !defined(spin_lock_init) /* !SMP and spin_lock_init not previously
                                   defined (e.g. by including asm/spinlock.h */
-
-#define DEBUG_SPINLOCKS	0	/* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
+#include <linux/spinlock_t.h>
 
 #if (DEBUG_SPINLOCKS < 1)
 
 #define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
 #define ATOMIC_DEC_AND_LOCK
-
-/*
- * Your basic spinlocks, allowing only a single CPU anywhere
- *
- * Most gcc versions have a nasty bug with empty initializers.
- */
-#if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
-#else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-#endif
-
 #define spin_lock_init(lock)	do { } while(0)
 #define spin_lock(lock)		(void)(lock) /* Not "unused variable". */
 #define spin_is_locked(lock)	(0)
@@ -70,34 +55,21 @@
 
 #elif (DEBUG_SPINLOCKS < 2)
 
-typedef struct {
-	volatile unsigned long lock;
-} spinlock_t;
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-
 #define spin_lock_init(x)	do { (x)->lock = 0; } while (0)
 #define spin_is_locked(lock)	(test_bit(0,(lock)))
 #define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
-
 #define spin_lock(x)		do { (x)->lock = 1; } while (0)
 #define spin_unlock_wait(x)	do { } while (0)
 #define spin_unlock(x)		do { (x)->lock = 0; } while (0)
 
 #else /* (DEBUG_SPINLOCKS >= 2) */
 
-typedef struct {
-	volatile unsigned long lock;
-	volatile unsigned int babble;
-	const char *module;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0, 25, __BASE_FILE__ }
-
 #include <linux/kernel.h>
 
 #define spin_lock_init(x)	do { (x)->lock = 0; } while (0)
 #define spin_is_locked(lock)	(test_bit(0,(lock)))
 #define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
-
 #define spin_lock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_lock(%s:%p) already locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 1; restore_flags(__spinflags);} while (0)
 #define spin_unlock_wait(x)	do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock_wait(%s:%p) deadlock\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} restore_flags(__spinflags);} while (0)
 #define spin_unlock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if (!(x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock(%s:%p) not locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 0; restore_flags(__spinflags);} while (0)
--- ../2.4.17.uml.clean/include/linux/spinlock_t.h	Mon Mar 25 17:54:04 2002
+++ ./include/linux/spinlock_t.h	Tue Mar 26 11:38:13 2002
@@ -0,0 +1,40 @@
+#ifndef _SPINLOCK_H
+#define _SPINLOCK_H
+
+//#include <linux/config.h>
+
+#define DEBUG_SPINLOCKS	0	/* 0 == no debugging, 1 == maintain lock state, 2 == full debug */
+
+#if (DEBUG_SPINLOCKS < 1)
+
+/*
+ * Your basic spinlocks, allowing only a single CPU anywhere
+ *
+ * Most gcc versions have a nasty bug with empty initializers.
+ */
+#if (__GNUC__ > 2)
+  typedef struct { } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+#else
+  typedef struct { int gcc_is_buggy; } spinlock_t;
+  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+#endif
+
+#elif (DEBUG_SPINLOCKS < 2)
+
+typedef struct {
+	volatile unsigned long lock;
+} spinlock_t;
+#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+
+#else /* (DEBUG_SPINLOCKS >= 2) */
+
+typedef struct {
+	volatile unsigned long lock;
+	volatile unsigned int babble;
+	const char *module;
+} spinlock_t;
+
+#endif
+
+#endif
--- ../2.4.17.uml.clean/include/linux/wait.h	Thu Nov 22 20:46:19 2001
+++ ./include/linux/wait.h	Tue Mar 26 11:40:34 2002
@@ -18,72 +18,7 @@
 
 #include <asm/page.h>
 #include <asm/processor.h>
-
-/*
- * Debug control.  Slow but useful.
- */
-#if defined(CONFIG_DEBUG_WAITQ)
-#define WAITQUEUE_DEBUG 1
-#else
-#define WAITQUEUE_DEBUG 0
-#endif
-
-struct __wait_queue {
-	unsigned int flags;
-#define WQ_FLAG_EXCLUSIVE	0x01
-	struct task_struct * task;
-	struct list_head task_list;
-#if WAITQUEUE_DEBUG
-	long __magic;
-	long __waker;
-#endif
-};
-typedef struct __wait_queue wait_queue_t;
-
-/*
- * 'dual' spinlock architecture. Can be switched between spinlock_t and
- * rwlock_t locks via changing this define. Since waitqueues are quite
- * decoupled in the new architecture, lightweight 'simple' spinlocks give
- * us slightly better latencies and smaller waitqueue structure size.
- */
-#define USE_RW_WAIT_QUEUE_SPINLOCK 0
-
-#if USE_RW_WAIT_QUEUE_SPINLOCK
-# define wq_lock_t rwlock_t
-# define WAITQUEUE_RW_LOCK_UNLOCKED RW_LOCK_UNLOCKED
-
-# define wq_read_lock read_lock
-# define wq_read_lock_irqsave read_lock_irqsave
-# define wq_read_unlock_irqrestore read_unlock_irqrestore
-# define wq_read_unlock read_unlock
-# define wq_write_lock_irq write_lock_irq
-# define wq_write_lock_irqsave write_lock_irqsave
-# define wq_write_unlock_irqrestore write_unlock_irqrestore
-# define wq_write_unlock write_unlock
-#else
-# define wq_lock_t spinlock_t
-# define WAITQUEUE_RW_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
-
-# define wq_read_lock spin_lock
-# define wq_read_lock_irqsave spin_lock_irqsave
-# define wq_read_unlock spin_unlock
-# define wq_read_unlock_irqrestore spin_unlock_irqrestore
-# define wq_write_lock_irq spin_lock_irq
-# define wq_write_lock_irqsave spin_lock_irqsave
-# define wq_write_unlock_irqrestore spin_unlock_irqrestore
-# define wq_write_unlock spin_unlock
-#endif
-
-struct __wait_queue_head {
-	wq_lock_t lock;
-	struct list_head task_list;
-#if WAITQUEUE_DEBUG
-	long __magic;
-	long __creator;
-#endif
-};
-typedef struct __wait_queue_head wait_queue_head_t;
-
+#include <linux/wait_queue.h>
 
 /*
  * Debugging macros.  We eschew `do { } while (0)' because gcc can generate
--- ../2.4.17.uml.clean/include/linux/wait_queue.h	Mon Mar 25 17:54:04 2002
+++ ./include/linux/wait_queue.h	Tue Mar 26 11:38:13 2002
@@ -0,0 +1,69 @@
+#ifndef _WAIT_QUEUE_H
+#define _WAIT_QUEUE_H
+
+/*
+ * Debug control.  Slow but useful.
+ */
+#if defined(CONFIG_DEBUG_WAITQ)
+#define WAITQUEUE_DEBUG 1
+#else
+#define WAITQUEUE_DEBUG 0
+#endif
+
+/*
+ * 'dual' spinlock architecture. Can be switched between spinlock_t and
+ * rwlock_t locks via changing this define. Since waitqueues are quite
+ * decoupled in the new architecture, lightweight 'simple' spinlocks give
+ * us slightly better latencies and smaller waitqueue structure size.
+ */
+#define USE_RW_WAIT_QUEUE_SPINLOCK 0
+
+#if USE_RW_WAIT_QUEUE_SPINLOCK
+# define wq_lock_t rwlock_t
+# define WAITQUEUE_RW_LOCK_UNLOCKED RW_LOCK_UNLOCKED
+
+# define wq_read_lock read_lock
+# define wq_read_lock_irqsave read_lock_irqsave
+# define wq_read_unlock_irqrestore read_unlock_irqrestore
+# define wq_read_unlock read_unlock
+# define wq_write_lock_irq write_lock_irq
+# define wq_write_lock_irqsave write_lock_irqsave
+# define wq_write_unlock_irqrestore write_unlock_irqrestore
+# define wq_write_unlock write_unlock
+#else
+# define wq_lock_t spinlock_t
+# define WAITQUEUE_RW_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+
+# define wq_read_lock spin_lock
+# define wq_read_lock_irqsave spin_lock_irqsave
+# define wq_read_unlock spin_unlock
+# define wq_read_unlock_irqrestore spin_unlock_irqrestore
+# define wq_write_lock_irq spin_lock_irq
+# define wq_write_lock_irqsave spin_lock_irqsave
+# define wq_write_unlock_irqrestore spin_unlock_irqrestore
+# define wq_write_unlock spin_unlock
+#endif
+
+struct task_struct;
+
+typedef struct __wait_queue {
+	unsigned int flags;
+#define WQ_FLAG_EXCLUSIVE	0x01
+	struct task_struct *task;
+	struct list_head task_list;
+#if WAITQUEUE_DEBUG
+	long __magic;
+	long __waker;
+#endif
+} wait_queue_t;
+
+typedef struct __wait_queue_head {
+	wq_lock_t lock;
+	struct list_head task_list;
+#if WAITQUEUE_DEBUG
+	long __magic;
+	long __creator;
+#endif
+} wait_queue_head_t;
+
+#endif
