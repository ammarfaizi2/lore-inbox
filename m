Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310301AbSCKR3L>; Mon, 11 Mar 2002 12:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310441AbSCKR26>; Mon, 11 Mar 2002 12:28:58 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:32779 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S310301AbSCKR2e>;
	Mon, 11 Mar 2002 12:28:34 -0500
Date: Mon, 11 Mar 2002 17:28:26 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] symbols for all out-of-line code
Message-ID: <20020311172825.GA8484@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


2.4.18 includes a patch to set a local symbol for the start of
out-of-line .text.lock (now subsection 1 of .text) code, but it 
merges the entire translation unit's out of line code under the
one symbol, and can give erroneous results when two files have
the same KBUILD_BASENAME. The patch below details exactly where
such code comes from, so you can get :

...
    53 __stabslock-at-dec_and_lock.c-line-35 2.2083
   233 __stabs&pagemap_lru_lock-at-swap.c-line-49 14.5625
   381 __stabs&kernel_flag-at-sched.c-line-701 23.8125
...

from readprofile (actually you need a modified version, attached).

(I haven't yet updated this for kaos' LOCK_START etc. patch)

regards
john


--- linux/arch/i386/config.in.old	Sun Mar 10 23:21:42 2002
+++ linux/arch/i386/config.in	Sun Mar 10 23:32:05 2002
@@ -421,6 +421,7 @@
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  .text.lock debugging symbols' CONFIG_DEBUG_TEXT_LOCK_STABS
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
 fi
 
--- /dev/null	Thu Aug 24 10:00:32 2000
+++ linux/include/asm-i386/text_lock_stabs.h	Mon Mar 11 15:09:59 2002
@@ -0,0 +1,44 @@
+/* text_lock_stabs.h - common stabs symbol code for .text.lock code
+ *
+ * Copyright John Levon 2002
+ */
+
+#ifndef TEXT_LOCK_STABS_H
+#define TEXT_LOCK_STABS_H
+
+#include <linux/config.h>
+#include <linux/stringify.h>
+
+#ifdef CONFIG_DEBUG_TEXT_LOCK_STABS
+
+#define __stabs_string(l) \
+	/* set label to the current address */	\
+	/* in .text.lock */			\
+	"\t.subsection 1\n" 			\
+	"\t7:\n" 				\
+	"\t.subsection 0\n" 			\
+						\
+	/* make a file .stabs */		\
+	"\t.stabs \"" __FILE__ "\""		\
+	",100,0,0,0\n"		 		\
+						\
+	/* and generate the useful entry */	\
+	"\t.stabs " "\"__stabs" #l 		\
+	"-at-" __FILE__ 			\
+	"-line-" __stringify(__LINE__) 		\
+	":F(0,0)\",36,0,6,7b\n"			\
+
+#define __stabs_common(o,l) 			\
+	({ 					\
+	__asm__ __volatile__( 			\
+	__stabs_string(l)			\
+	: : );					\
+	 o(l); 					\
+	})
+ 
+#else
+#define __stabs_string(l)
+#define __stabs_common(o,l) o(l)
+#endif /* CONFIG_DEBUG_SPINLOCK_STABS */
+ 
+#endif /* TEXT_LOCK_STABS_H */
--- linux/include/linux/rwsem.old.h	Sun Mar 10 23:21:52 2002
+++ linux/include/linux/rwsem.h	Mon Mar 11 00:24:17 2002
@@ -35,45 +35,33 @@
 #endif
 #endif
 
-/*
- * lock for reading
- */
-static inline void down_read(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering down_read");
-	__down_read(sem);
-	rwsemtrace(sem,"Leaving down_read");
-}
-
-/*
- * lock for writing
- */
-static inline void down_write(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering down_write");
-	__down_write(sem);
-	rwsemtrace(sem,"Leaving down_write");
-}
-
-/*
- * release a read lock
- */
-static inline void up_read(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering up_read");
-	__up_read(sem);
-	rwsemtrace(sem,"Leaving up_read");
-}
-
-/*
- * release a write lock
- */
-static inline void up_write(struct rw_semaphore *sem)
-{
-	rwsemtrace(sem,"Entering up_write");
-	__up_write(sem);
-	rwsemtrace(sem,"Leaving up_write");
-}
-
+#define down_read(sem)				\
+	do { 					\
+	rwsemtrace(sem,"Entering down_read"); 	\
+	__down_read(sem); 			\
+	rwsemtrace(sem,"Leaving down_read");	\
+	} while (0)				\
+ 
+#define down_write(sem) 			\
+	do { 					\
+	rwsemtrace(sem,"Entering down_write"); 	\
+	__down_write(sem); 			\
+	rwsemtrace(sem,"Leaving down_write");	\
+	} while (0)				\
+ 
+#define up_read(sem) 				\
+	do { 					\
+	rwsemtrace(sem,"Entering up_read"); 	\
+	__up_read(sem); 			\
+	rwsemtrace(sem,"Leaving up_read");	\
+	} while (0)				\
+ 
+#define up_write(sem) 				\
+	do { 					\
+	rwsemtrace(sem,"Entering up_write"); 	\
+	__up_write(sem); 			\
+	rwsemtrace(sem,"Leaving up_write");	\
+	} while (0)				\
+ 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_RWSEM_H */
--- linux/include/asm-i386/semaphore.old.h	Sun Mar 10 23:21:59 2002
+++ linux/include/asm-i386/semaphore.h	Mon Mar 11 00:24:17 2002
@@ -38,6 +38,7 @@
 
 #include <asm/system.h>
 #include <asm/atomic.h>
+#include <asm/text_lock_stabs.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 #include <linux/stringify.h>
@@ -112,7 +113,7 @@
  * "__down_failed" is a special asm handler that calls the C
  * routine that actually waits. See arch/i386/kernel/semaphore.c
  */
-static inline void down(struct semaphore * sem)
+static inline void p__down(struct semaphore * sem)
 {
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
@@ -124,9 +125,6 @@
 		"js 2f\n"
 		"1:\n"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
 		".subsection 0\n"
@@ -139,7 +137,7 @@
  * Interruptible try to acquire a semaphore.  If we obtained
  * it, return zero.  If we were interrupted, returns -EINTR
  */
-static inline int down_interruptible(struct semaphore * sem)
+static inline int p__down_interruptible(struct semaphore * sem)
 {
 	int result;
 
@@ -154,9 +152,6 @@
 		"xorl %0,%0\n"
 		"1:\n"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		".subsection 0\n"
@@ -170,7 +165,7 @@
  * Non-blockingly attempt to down() a semaphore.
  * Returns zero if we acquired it
  */
-static inline int down_trylock(struct semaphore * sem)
+static inline int p__down_trylock(struct semaphore * sem)
 {
 	int result;
 
@@ -185,9 +180,6 @@
 		"xorl %0,%0\n"
 		"1:\n"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		".subsection 0\n"
@@ -203,7 +195,7 @@
  * The default case (no contention) will result in NO
  * jumps for both down() and up().
  */
-static inline void up(struct semaphore * sem)
+static inline void p__up(struct semaphore * sem)
 {
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
@@ -214,9 +206,6 @@
 		"jle 2f\n"
 		"1:\n"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
 		".subsection 0\n"
@@ -224,6 +213,11 @@
 		:"c" (sem)
 		:"memory");
 }
+
+#define down(s) __stabs_common(p__down, s)
+#define down_interruptible(s) __stabs_common(p__down_interruptible, s)
+#define down_trylock(s) __stabs_common(p__down_trylock, s)
+#define up(s) __stabs_common(p__up, s)
 
 #endif
 #endif
--- linux/include/asm-i386/rwsem.old.h	Sun Mar 10 23:22:05 2002
+++ linux/include/asm-i386/rwsem.h	Mon Mar 11 00:24:17 2002
@@ -38,6 +38,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/text_lock_stabs.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/stringify.h>
@@ -95,7 +96,7 @@
 /*
  * lock for reading
  */
-static inline void __down_read(struct rw_semaphore *sem)
+static inline void p__down_read(struct rw_semaphore *sem)
 {
 	__asm__ __volatile__(
 		"# beginning down_read\n\t"
@@ -103,9 +104,6 @@
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  pushl     %%edx\n\t"
@@ -123,7 +121,7 @@
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+static inline void p__down_write(struct rw_semaphore *sem)
 {
 	int tmp;
 
@@ -135,9 +133,6 @@
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  call      rwsem_down_write_failed\n\t"
@@ -153,7 +148,7 @@
 /*
  * unlock after reading
  */
-static inline void __up_read(struct rw_semaphore *sem)
+static inline void p__up_read(struct rw_semaphore *sem)
 {
 	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
 	__asm__ __volatile__(
@@ -162,9 +157,6 @@
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
@@ -182,7 +174,7 @@
 /*
  * unlock after writing
  */
-static inline void __up_write(struct rw_semaphore *sem)
+static inline void p__up_write(struct rw_semaphore *sem)
 {
 	__asm__ __volatile__(
 		"# beginning __up_write\n\t"
@@ -191,9 +183,6 @@
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		".subsection 1\n"
-		".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"
-		"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"
-		".endif\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
 		"  jnz       1b\n\t" /* jump back if not */
@@ -235,5 +224,10 @@
 	return tmp+delta;
 }
 
+#define __down_read(s) __stabs_common(p__down_read, s)
+#define __down_write(s) __stabs_common(p__down_write, s)
+#define __up_read(s) __stabs_common(p__up_read, s)
+#define __up_write(s) __stabs_common(p__up_write, s)
+ 
 #endif /* __KERNEL__ */
 #endif /* _I386_RWSEM_H */
--- linux/include/asm-i386/spinlock.old.h	Sun Mar 10 23:22:10 2002
+++ linux/include/asm-i386/spinlock.h	Mon Mar 11 00:24:17 2002
@@ -3,6 +3,7 @@
 
 #include <asm/atomic.h>
 #include <asm/rwlock.h>
+#include <asm/text_lock_stabs.h>
 #include <asm/page.h>
 #include <linux/config.h>
 #include <linux/stringify.h>
@@ -58,9 +59,6 @@
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
 	".subsection 1\n" \
-	".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-	"_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-	".endif\n" \
 	"2:\t" \
 	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
@@ -127,7 +125,7 @@
 	return oldval > 0;
 }
 
-static inline void spin_lock(spinlock_t *lock)
+static inline void p__spin_lock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	__label__ here;
@@ -142,6 +140,7 @@
 		:"=m" (lock->lock) : : "memory");
 }
 
+#define spin_lock(l) __stabs_common(p__spin_lock,l)
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -183,7 +182,7 @@
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
-static inline void read_lock(rwlock_t *rw)
+static inline void p__read_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic != RWLOCK_MAGIC)
@@ -192,7 +191,7 @@
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void write_lock(rwlock_t *rw)
+static inline void p__write_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic != RWLOCK_MAGIC)
@@ -200,6 +199,9 @@
 #endif
 	__build_write_lock(rw, "__write_lock_failed");
 }
+
+#define read_lock(r) __stabs_common(p__read_lock, r)
+#define write_lock(r) __stabs_common(p__write_lock, r)
 
 #define read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
 #define write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
--- linux/include/asm-i386/rwlock.old.h	Sun Mar 10 23:22:14 2002
+++ linux/include/asm-i386/rwlock.h	Mon Mar 11 00:14:04 2002
@@ -27,9 +27,6 @@
 		     "js 2f\n" \
 		     "1:\n" \
 		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
 		     ".subsection 0\n" \
@@ -40,9 +37,6 @@
 		     "js 2f\n" \
 		     "1:\n" \
 		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
@@ -63,9 +57,6 @@
 		     "jnz 2f\n" \
 		     "1:\n" \
 		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
 		     ".subsection 0\n" \
@@ -76,9 +67,6 @@
 		     "jnz 2f\n" \
 		     "1:\n" \
 		     ".subsection 1\n" \
-		     ".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n" \
-		     "_text_lock_" __stringify(KBUILD_BASENAME) ":\n" \
-		     ".endif\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
--- linux/include/asm-i386/softirq.old.h	Sun Mar 10 23:22:20 2002
+++ linux/include/asm-i386/softirq.h	Mon Mar 11 15:10:40 2002
@@ -3,6 +3,7 @@
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
+#include <asm/text_lock_stabs.h>
 #include <linux/stringify.h>
 
 #define __cpu_bh_enable(cpu) \
@@ -34,10 +35,9 @@
 			"jnz 2f;"					\
 			"1:;"						\
 									\
+			__stabs_string(local_bh_enable)			\
+									\
 			".subsection 1;"				\
-			".ifndef _text_lock_" __stringify(KBUILD_BASENAME) "\n"		\
-			"_text_lock_" __stringify(KBUILD_BASENAME) ":\n"		\
-			".endif\n"					\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
 			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
--- linux/include/asm-i386/smplock.old.h	Sun Mar 10 23:22:24 2002
+++ linux/include/asm-i386/smplock.h	Mon Mar 11 00:24:17 2002
@@ -40,36 +40,15 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
-{
-#if 1
-	if (!++current->lock_depth)
-		spin_lock(&kernel_flag);
-#else
-	__asm__ __volatile__(
-		"incl %1\n\t"
-		"jne 9f"
-		spin_lock_string
-		"\n9:"
-		:"=m" (__dummy_lock(&kernel_flag)),
-		 "=m" (current->lock_depth));
-#endif
-}
+#define lock_kernel() do { 					\
+	if (!++current->lock_depth) 				\
+		__stabs_common(p__spin_lock, &kernel_flag); 	\
+	} while (0)
 
 static __inline__ void unlock_kernel(void)
 {
 	if (current->lock_depth < 0)
 		BUG();
-#if 1
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
-#else
-	__asm__ __volatile__(
-		"decl %1\n\t"
-		"jns 9f\n\t"
-		spin_unlock_string
-		"\n9:"
-		:"=m" (__dummy_lock(&kernel_flag)),
-		 "=m" (current->lock_depth));
-#endif
 }
--- linux/Documentation/Configure.help.old	Sun Mar 10 23:22:30 2002
+++ linux/Documentation/Configure.help	Sun Mar 10 23:32:05 2002
@@ -24006,6 +24006,12 @@
   verbose debugging messages.  If you suspect a semaphore problem or a
   kernel hacker asks for this option then say Y.  Otherwise say N.
 
+Lock debugging
+CONFIG_DEBUG_TEXT_LOCK_STABS
+  If you say Y here then debugging symbols will be created for each
+  piece of .text.lock code that corresponds to the contention path for
+  the locking primitives.
+ 
 Verbose BUG() reporting (adds 70K)
 CONFIG_DEBUG_BUGVERBOSE
   Say Y here to make BUG() panics output the file name and line number
--- linux/Makefile.old	Sun Mar 10 23:24:33 2002
+++ linux//Makefile	Mon Mar 11 13:13:49 2002
@@ -229,6 +229,7 @@
 	.version .config* config.in config.old \
 	scripts/tkparse scripts/kconfig.tk scripts/kconfig.tmp \
 	scripts/lxdialog/*.o scripts/lxdialog/lxdialog \
+	scripts/add_lock_syms scripts/add_lock_syms.o \
 	.menuconfig.log \
 	include/asm \
 	.hdepend scripts/mkdep scripts/split-include scripts/docproc \
@@ -268,6 +269,17 @@
 		--end-group \
 		-o vmlinux
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
+	if [ "$(CONFIG_DEBUG_TEXT_LOCK_STABS)" = "y" ]; then \
+		$(MAKE) map-stabs; \
+	fi
+
+map-stabs: scripts/add_lock_syms
+	cp System.map System.map.tmp
+	scripts/add_lock_syms vmlinux >> System.map.tmp
+	cat System.map.tmp | sort -u >System.map
+
+scripts/add_lock_syms: scripts/add_lock_syms.c
+	$(MAKE) -C scripts add_lock_syms
 
 symlinks:
 	rm -f include/asm
--- linux/scripts/Makefile.old	Sun Mar 10 23:28:10 2002
+++ linux/scripts/Makefile	Sun Mar 10 23:29:15 2002
@@ -42,4 +42,7 @@
 clean:
 	rm -f *~ kconfig.tk *.o tkparse mkdep split-include docproc
 
+add_lock_syms: add_lock_syms.c
+	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
+ 
 include $(TOPDIR)/Rules.make
--- /dev/null	Thu Aug 24 10:00:32 2000
+++ linux/scripts/add_lock_syms.c	Sun Mar 10 23:53:28 2002
@@ -0,0 +1,102 @@
+/* Copyright 2002 John Levon <moz@compsoc.man.ac.uk>
+ *
+ * usage: add_lock_syms vmlinux | sort -u >>System.map
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+typedef unsigned long addr_t;
+ 
+char * get_lock_name(char * raw)
+{
+	char * name = strdup(raw);
+
+	if (!name) {
+		fprintf(stderr, "add_lock_syms: Failed to strdup.\n");
+		exit(1);
+	}
+ 
+	name[strlen(name) - 3] = '\0';
+	return name;
+}
+ 
+ 
+addr_t get_vma(char * raw)
+{
+	addr_t vma;
+ 
+	if (sscanf(raw, "%lx", &vma) != 1) {
+		fprintf(stderr, "add_lock_syms: Malformed line.\n");
+		exit(1);
+	}
+
+	return vma;
+}
+ 
+
+#if 0
+<undefined> text_lock_&bdev_lock-at-block_dev.c-line-333 ()
+{ /* 0xc01f9df4 */
+} /* 0x0 */
+#endif
+void read_objdump_g(FILE * fp)
+{
+	char * lock_name = NULL;
+	char * line = NULL;
+	size_t max_len = 0;
+	ssize_t len;
+
+	while ((len = getline(&line, &max_len, fp)) != -1) {
+		if ((size_t)len > strlen("<undefined> ") && line[0] == '<') {
+			lock_name = get_lock_name(line + strlen("<undefined> "));
+		} else if ((size_t)len > strlen("{ /* 0x") && line[0] == '{') {
+			printf("%lx t %s\n", get_vma(line + 7), lock_name);
+			free(lock_name);
+		}
+	}
+ 
+	if (line) {
+		free(line);
+	}
+}
+
+
+int main(int argc, char **argv)
+{
+	char * odcmd = "objdump -g ";
+	char * cmd;
+	char const * vmlinux;
+	FILE * fp;
+
+	if (argc < 2) {
+		fprintf(stderr, "add_lock_syms: no vmlinux file specified.\n");
+		return 1;
+	}
+
+	vmlinux = argv[1];
+
+	cmd = malloc(strlen(odcmd) + strlen(vmlinux) + 1);
+	if (!cmd) {
+		fprintf(stderr, "add_lock_syms: malloc failed.\n");
+		return 1;
+	}
+
+	strcpy(cmd, odcmd);
+	strcat(cmd, vmlinux);
+
+	fp = popen(cmd, "r");
+ 
+	if (!fp) {
+		fprintf(stderr, "add_lock_syms: couldn't open objdump pipe.\n");
+		return 1;
+	}
+
+	read_objdump_g(fp);
+ 
+	pclose(fp);
+ 
+	return 0;
+}

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="readprofile2.c"
Content-Transfer-Encoding: 8bit

/*
 *  readprofile.c - used to read /proc/profile
 *
 *  Copyright (C) 1994,1996 Alessandro Rubini (rubini@ipvvis.unipv.it)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/*
 * 1999-02-22 Arkadiusz Mi¶kiewicz <misiek@pld.ORG.PL>
 * - added Native Language Support
 * 1999-09-01 Stephane Eranian <eranian@cello.hpl.hp.com>
 * - 64bit clean patch
 * 3Feb2001 Andrew Morton <andrewm@uow.edu.au>
 * - -M option to write profile multiplier.
 * 2001-11-07 Werner Almesberger <wa@almesberger.net>
 * - byte order auto-detection and -n option
 * 2001-11-09 Werner Almesberger <wa@almesberger.net>
 * - skip step size (index 0)
 * 2002-03-09 John Levon <moz@compsoc.man.ac.uk>
 * - make maplineno do something
 * 2002-03-11 John Levon <moz@compsoc.man.ac.uk>
 * - rework for lock syms: no static buffers, no early quit
 */

#define _GNU_SOURCE

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#if 0
#include "nls.h"
#else
#define _(s) s
#endif

#define RELEASE "2.1, March 2002"

static char *prgname;

/* These are the defaults */
static char defaultmap[]="/usr/src/linux/System.map";
static char defaultpro[]="/proc/profile";
static char optstring[]="M:m:np:itvarV";

struct qstr {
	char * str;
	size_t len;
};

static void
usage(void) {
  fprintf(stderr,
		  _("%s: Usage: \"%s [options]\n"
		  "\t -m <mapfile>  (default = \"%s\")\n"
		  "\t -p <pro-file> (default = \"%s\")\n"
		  "\t -M <mult>     set the profiling multiplier to <mult>\n"
		  "\t -i            print only info about the sampling step\n"
		  "\t -v            print verbose data\n"
		  "\t -a            print all symbols, even if count is 0\n"
		  "\t -r            reset all the counters (root only)\n"
		  "\t -n            disable byte order auto-detection\n"
		  "\t -V            print version and exit\n")
		  ,prgname,prgname,defaultmap,defaultpro);
  exit(1);
}

static void *
xmalloc (size_t size) {
	void *t;

	if (size == 0)
		return NULL;

	t = malloc (size);
	if (t == NULL) {
		fprintf(stderr, _("out of memory"));
		exit(1);
	}

	return t;
}

static FILE *
myopen(char *name, char *mode, int *flag) {
	int len = strlen(name);

	if (!strcmp(name+len-3,".gz")) {
		FILE *res;
		char *cmdline = xmalloc(len+6);
		sprintf(cmdline, "zcat %s", name);
		res = popen(cmdline,mode);
		free(cmdline);
		*flag = 1;
		return res;
	}
	*flag = 0;
	return fopen(name,mode);
}

void
realloc_string(struct qstr * str, size_t len)
{
	if (len > str->len) {
		str->str = realloc(str->str, len);
		if (!str->str) {
			fprintf(stderr, "%s: malloc(%u) failed.\n", prgname, len);
			exit(1);
		}
		str->len = len;
	}
}

void
copy_string(struct qstr * str, struct qstr * new)
{
	realloc_string(str, new->len);
	strcpy(str->str, new->str);
}

int
main (int argc, char **argv) {
	FILE *map;
	int proFd;
	char *mapFile, *proFile, *mult=0;
	unsigned long len=0, add0=0, indx=1;
	unsigned int step;
	unsigned int *buf, total, fn_len;
	unsigned long fn_add, next_add; /* current and next address */
	struct qstr fn_name = { NULL, 0 }; /* current and next name */
	struct qstr next_name = { NULL, 0 };
	char mode;
	int c;
	int optAll=0, optInfo=0, optReset=0, optVerbose=0, optNative=0;
	char * mapline = NULL;
	int maplineno=1;
	int popenMap;   /* flag to tell if popen() has been used */
	size_t size;
	ssize_t chars_read;

#define next (current^1)

#if 0
	setlocale(LC_ALL, "");
	bindtextdomain(PACKAGE, LOCALEDIR);
	textdomain(PACKAGE);
#endif

	prgname=argv[0];
	proFile=defaultpro;
	mapFile=defaultmap;

	while ((c = getopt(argc,argv,optstring)) != -1) {
		switch(c) {
		case 'm': mapFile=optarg; break;
		case 'n': optNative++;	  break;
		case 'p': proFile=optarg; break;
		case 'a': optAll++;       break;
		case 'i': optInfo++;      break;
		case 'M': mult=optarg;    break;
		case 'r': optReset++;     break;
		case 'v': optVerbose++;   break;
		case 'V': printf(_("%s Version %s\n"),prgname,RELEASE);
			exit(0);
		default: usage();
		}
	}

	if (optReset || mult) {
		int multiplier, fd, to_write;

		/*
		 * When writing the multiplier, if the length of the write is
		 * not sizeof(int), the multiplier is not changed
		 */
		if (mult) {
			multiplier = strtoul(mult, 0, 10);
			to_write = sizeof(int);
		} else {
			multiplier = 0;
			to_write = 1;	/* sth different from sizeof(int) */
		}
		/* try to become root, just in case */
		setuid(0);
		fd = open(defaultpro,O_WRONLY);
		if (fd < 0) {
			perror(defaultpro);
			exit(1);
		}
		if (write(fd, &multiplier, to_write) != to_write) {
			fprintf(stderr, "readprofile: error writing %s: %s\n",
				defaultpro, strerror(errno));
			exit(1);
		}
		close(fd);
		exit(0);
	}

	/*
	 * Use an fd for the profiling buffer, to skip stdio overhead
	 */
	if ( ((proFd=open(proFile,O_RDONLY)) < 0)
	     || ((int)(len=lseek(proFd,0,SEEK_END)) < 0)
	     || (lseek(proFd,0,SEEK_SET)<0) ) {
		fprintf(stderr,"%s: %s: %s\n",prgname,proFile,strerror(errno));
		exit(1);
	}

	if ( !(buf=malloc(len)) ) {
		fprintf(stderr,"%s: malloc(): %s\n",prgname, strerror(errno));
		exit(1);
	}

	if (read(proFd,buf,len) != len) {
		fprintf(stderr,"%s: %s: %s\n",prgname,proFile,strerror(errno));
		exit(1);
	}
	close(proFd);

	if (!optNative) {
		int entries = len/sizeof(*buf);
		int big = 0,small = 0,i;
		unsigned *p;

		for (p = buf+1; p < buf+entries; p++)
			if (*p) {
				if (*p >= 1 << (sizeof(*buf)/2)) big++;
				else small++;
			}
		if (big > small) {
			fprintf(stderr,"Assuming reversed byte order. "
			   "Use -n to force native byte order.\n");
			for (p = buf; p < buf+entries; p++)
				for (i = 0; i < sizeof(*buf)/2; i++) {
					unsigned char *b = (unsigned char *) p;
					unsigned char tmp;

					tmp = b[i];
					b[i] = b[sizeof(*buf)-i-1];
					b[sizeof(*buf)-i-1] = tmp;
				}
		}
	}

	step=buf[0];
	if (optInfo) {
		printf(_("Sampling_step: %i\n"),step);
		exit(0);
	}

	total=0;

	if (!(map=myopen(mapFile,"r",&popenMap))) {
		fprintf(stderr,"%s: ",prgname);perror(mapFile);
		exit(1);
	}

	while ((chars_read = getline(&mapline, &size, map)) != -1) {
		realloc_string(&fn_name, (size_t)(chars_read + 1));
		if (sscanf(mapline,"%lx %c %s",&fn_add, &mode, fn_name.str) != 3) {
			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
				prgname, mapFile, maplineno);
			exit(1);
		}

		if (!strcmp(fn_name.str,"_stext")) /* only elf works like this */ {
			add0=fn_add;
			break;
		}
		maplineno++;
	}

	if (!add0) {
		fprintf(stderr,_("%s: can't find \"_stext\" in %s\n"),
			prgname, mapFile);
		exit(1);
	}

	/*
	 * Main loop.
	 */
	while ((chars_read = getline(&mapline, &size, map)) != -1) {
		unsigned int this=0;

		realloc_string(&next_name, (size_t)(chars_read + 1));

		if (sscanf(mapline,"%lx %c %s",&next_add, &mode, next_name.str)!=3) {
			fprintf(stderr,_("%s: %s(%i): wrong map line\n"),
				prgname,mapFile, maplineno);
			exit(1);
		}

		/* ignore anything past _etext */
		if (mode == 'A')
			break;
		
		if (mode != 'T' && mode != 't')
			continue;

		if (indx >= len / sizeof(*buf)) {
			fprintf(stderr, _("%s: profile address out of range for %s. "
					  "Wrong map file?\n"), prgname, next_name.str);
			exit(1);
		}

		while (indx < (next_add-add0)/step)
			this += buf[indx++];
		total += this;

		fn_len = next_add-fn_add;
		if (fn_len && (this || optAll)) {
			if (optVerbose)
				printf("%08lx %-60s %6i %8.4f\n", fn_add,
				       fn_name.str,this,this/(double)fn_len);
			else
				printf("%6i %-60s %8.4f\n",
				       this,fn_name.str,this/(double)fn_len);
		}
		fn_add=next_add;

		copy_string(&fn_name, &next_name);

		maplineno++;
	}

	free(mapline);

	/* trailer */
	if (optVerbose)
		printf("%08x %-60s %6i %8.4f\n",
		       0,"total",total,total/(double)(fn_add-add0));
	else
		printf("%6i %-60s %8.4f\n",
		       total,_("total"),total/(double)(fn_add-add0));
	
	popenMap ? pclose(map) : fclose(map);
	exit(0);
}

--6c2NcOVqGQ03X4Wi--
