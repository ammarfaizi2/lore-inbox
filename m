Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312891AbSDKUL7>; Thu, 11 Apr 2002 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312899AbSDKUL6>; Thu, 11 Apr 2002 16:11:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:60886 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S312891AbSDKULv>; Thu, 11 Apr 2002 16:11:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Define struct page early
Date: Thu, 11 Apr 2002 12:10:27 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020324112659Z16123-25734+21@humbolt.nl.linux.org> <20020324234249.GA10457@holomorphy.com> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020411201146Z16407-11463+58@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the i386 versions of the header split-up patch.  This allows three 
address conversion functions (virt_to_phys, phys_to_virt and VALID_PAGE) to 
be defined as inlines instead of macros.  As detailed in the parent post, 
this is done by defining struct page right at the beginning of mm.h, preceded 
only by the few type definitions it relies on.  Such an arrangement of header 
files is made possible by breaking some of them into two.

It is possible that somebody (you know who you are) may criticize this patch
on the grounds it generates some new header files.  I will therefore explain
why there are only two possible choices:

  1) Don't use inlines (and give up the type safety)
  2) Split up some header files

Here's the proof: Consider three declarations, A, B and C.  A is needed to 
define B and B is needed to define C.  Unfortunately, A and C are defined in 
the same header file H, and B is defined in some other header file G.  Now, 
unless H is split into two files, neither of the two possible include orders 
[G, H] or [H, G] can satify both of the dependencies A<-B and B<-C.  Q.e.d.

As for the number of new header files generated, there are a total of four in 
include/linux and two in include/asm-i386.  So for each additional arch 
converted there will be something like two additional headers generated.  
This is not enough to get excited about, and will not slow down compilation
by any appreciable amount, especially if the rumor is true that gcc explicitly
recognizes and optimizes the case where an entire header is wrapped in an
#ifndef <symbol> bracket.

Backward compatibility is attained by including the new header files from the 
original header files.

I didn't fix any of the mistakes that were exposed by compiling with the 
inlines, e.g., passing ulong to virt_to_phys instead of (void *).  It's 
arguably better to observe firsthand the kind of cruft that the inlines are 
able to expose.

If anyone is willing to put in the time to do some disassemly, I'd be
interested to hear whether or not the inline phys_to_vert etc. generate the
same code as the original macros.

--
Daniel

--- 2.4.17.uml.clean/include/asm-i386/atomic.h	Mon Apr  8 15:06:42 2002
+++ 2.4.17.uml/include/asm-i386/atomic.h	Tue Apr  9 05:28:02 2002
@@ -2,6 +2,7 @@
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <asm/atomic_t.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -13,13 +14,6 @@
 #else
 #define LOCK ""
 #endif
-
-/*
- * Make sure gcc doesn't try to be clever and move things around
- * on us. We need to use _exactly_ the address the user gave us,
- * not some alias that contains the same information.
- */
-typedef struct { volatile int counter; } atomic_t;
 
 #define ATOMIC_INIT(i)	{ (i) }
 
--- 2.4.17.uml.clean/include/asm-i386/atomic_t.h	Tue Apr  9 04:48:29 2002
+++ 2.4.17.uml/include/asm-i386/atomic_t.h	Tue Apr  9 05:28:02 2002
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
--- 2.4.17.uml.clean/include/asm-i386/io.h	Mon Apr  8 15:06:42 2002
+++ 2.4.17.uml/include/asm-i386/io.h	Tue Apr  9 05:28:02 2002
@@ -63,7 +63,7 @@
  * Change virtual addresses to physical addresses and vv.
  * These are pretty trivial
  */
-static inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(void *address)
 {
 	return __pa(address);
 }
--- 2.4.17.uml.clean/include/asm-i386/page.h	Thu Nov 22 20:46:18 2001
+++ 2.4.17.uml/include/asm-i386/page.h	Tue Apr  9 05:28:02 2002
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <linux/mem_map.h>
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -115,13 +116,31 @@
 	return order;
 }
 
-#endif /* __ASSEMBLY__ */
-
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
-#define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
-#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
-#define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+
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
+
+#endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
 
--- 2.4.17.uml.clean/include/asm-i386/spinlock.h	Thu Nov 22 20:46:19 2001
+++ 2.4.17.uml/include/asm-i386/spinlock.h	Tue Apr  9 05:28:02 2002
@@ -1,6 +1,9 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#include <asm/atomic_t.h>
+#include <asm/spinlock_t.h>
+
 #include <asm/atomic.h>
 #include <asm/rwlock.h>
 #include <asm/page.h>
@@ -9,27 +12,6 @@
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
-/* It seems that people are forgetting to
- * initialize their spinlocks properly, tsk tsk.
- * Remember to turn this off in 2.4. -ben
- */
-#if defined(CONFIG_DEBUG_SPINLOCK)
-#define SPINLOCK_DEBUG	1
-#else
-#define SPINLOCK_DEBUG	0
-#endif
-
-/*
- * Your basic SMP spinlocks, allowing only a single CPU anywhere
- */
-
-typedef struct {
-	volatile unsigned int lock;
-#if SPINLOCK_DEBUG
-	unsigned magic;
-#endif
-} spinlock_t;
-
 #define SPINLOCK_MAGIC	0xdead4ead
 
 #if SPINLOCK_DEBUG
@@ -138,23 +120,6 @@
 		:"=m" (lock->lock) : : "memory");
 }
 
-
-/*
- * Read-write spinlocks, allowing multiple readers
- * but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts
- * but no interrupt writers. For those circumstances we
- * can "mix" irq-safe locks - any writer needs to get a
- * irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- */
-typedef struct {
-	volatile unsigned int lock;
-#if SPINLOCK_DEBUG
-	unsigned magic;
-#endif
-} rwlock_t;
 
 #define RWLOCK_MAGIC	0xdeaf1eed
 
--- 2.4.17.uml.clean/include/asm-i386/spinlock_t.h	Tue Apr  9 04:48:29 2002
+++ 2.4.17.uml/include/asm-i386/spinlock_t.h	Tue Apr  9 05:28:02 2002
@@ -0,0 +1,42 @@
+#ifndef ASM_i386_SPINLOCK_T_H
+#define ASM_i386_SPINLOCK_T_H
+
+/* It seems that people are forgetting to
+ * initialize their spinlocks properly, tsk tsk.
+ * Remember to turn this off in 2.4. -ben
+ */
+#if defined(CONFIG_DEBUG_SPINLOCK)
+#define SPINLOCK_DEBUG	1
+#else
+#define SPINLOCK_DEBUG	0
+#endif
+
+/*
+ * Your basic SMP spinlocks, allowing only a single CPU anywhere
+ */
+
+typedef struct {
+	volatile unsigned int lock;
+#if SPINLOCK_DEBUG
+	unsigned magic;
+#endif
+} spinlock_t;
+
+/*
+ * Read-write spinlocks, allowing multiple readers
+ * but only one writer.
+ *
+ * NOTE! it is quite common to have readers in interrupts
+ * but no interrupt writers. For those circumstances we
+ * can "mix" irq-safe locks - any writer needs to get a
+ * irq-safe write-lock, but readers can get non-irqsafe
+ * read-locks.
+ */
+typedef struct {
+	volatile unsigned int lock;
+#if SPINLOCK_DEBUG
+	unsigned magic;
+#endif
+} rwlock_t;
+
+#endif
--- 2.4.17.uml.clean/include/asm-i386/user.h	Mon Apr  8 15:06:42 2002
+++ 2.4.17.uml/include/asm-i386/user.h	Tue Apr  9 05:28:02 2002
@@ -1,6 +1,7 @@
 #ifndef _I386_USER_H
 #define _I386_USER_H
 
+#include <linux/mem_map.h>
 #include <asm/page.h>
 #include <linux/ptrace.h>
 /* Core file format: The core file is written in such a way that gdb
--- 2.4.17.uml.clean/include/linux/list.h	Mon Apr  8 15:06:42 2002
+++ 2.4.17.uml/include/linux/list.h	Tue Apr  9 05:28:02 2002
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
--- 2.4.17.uml.clean/include/linux/list_head.h	Tue Apr  9 04:48:29 2002
+++ 2.4.17.uml/include/linux/list_head.h	Tue Apr  9 05:28:02 2002
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
--- 2.4.17.uml.clean/include/linux/mem_map.h	Tue Apr  9 04:48:29 2002
+++ 2.4.17.uml/include/linux/mem_map.h	Tue Apr  9 05:28:02 2002
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
--- 2.4.17.uml.clean/include/linux/mm.h	Mon Apr  8 15:06:43 2002
+++ 2.4.17.uml/include/linux/mm.h	Tue Apr  9 05:28:02 2002
@@ -1,12 +1,13 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/config.h>
+#include <asm/page.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 
 #ifdef __KERNEL__
 
-#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
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
--- 2.4.17.uml.clean/include/linux/spinlock.h	Mon Apr  8 15:06:43 2002
+++ 2.4.17.uml/include/linux/spinlock.h	Tue Apr  9 05:28:02 2002
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
--- 2.4.17.uml.clean/include/linux/spinlock_t.h	Tue Apr  9 04:48:29 2002
+++ 2.4.17.uml/include/linux/spinlock_t.h	Tue Apr  9 05:28:02 2002
@@ -0,0 +1,47 @@
+#ifndef _SPINLOCK_H
+#define _SPINLOCK_H
+
+#ifdef CONFIG_SMP
+#include <asm/spinlock_t.h>
+
+#else
+
+#include <linux/config.h>
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
+#endif /* #ifndef CONFIG_SMP */
+
+#endif
--- 2.4.17.uml.clean/include/linux/wait.h	Mon Apr  8 15:06:43 2002
+++ 2.4.17.uml/include/linux/wait.h	Tue Apr  9 05:28:02 2002
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
--- 2.4.17.uml.clean/include/linux/wait_queue.h	Tue Apr  9 04:48:30 2002
+++ 2.4.17.uml/include/linux/wait_queue.h	Tue Apr  9 05:28:02 2002
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

