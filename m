Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSF2NgS>; Sat, 29 Jun 2002 09:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSF2NgR>; Sat, 29 Jun 2002 09:36:17 -0400
Received: from n41.ols.wavesec.net ([209.151.19.41]:12416 "EHLO
	nighthawk.sr71.net") by vger.kernel.org with ESMTP
	id <S310206AbSF2NgL>; Sat, 29 Jun 2002 09:36:11 -0400
Message-ID: <3D1DB84D.50100@us.ibm.com>
Date: Sat, 29 Jun 2002 06:38:21 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] debugging for BKL
Content-Type: multipart/mixed;
 boundary="------------040003020001010701060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003020001010701060003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

For those of you who heard the talk at OLS Friday morning, this patch
won't be too much of a surprise.  But for the rest of you...

The BKL's "magical" properties of allowing recursive holds on a single
cpu and its release-on-sleep semantics make it really hard to replace
with new locking schemes.  Before we can really remove it, we must
first characterize the places where it is used in these crazy ways.

This patch replaces centralizes the declaration of (un)lock_kernel()
and makes all the architecures define __(un)lock_kernel() instead.
The #define is necessary so that __LINE__ and (if I want to, later
__FUNCTION__) will work.

Several macros have been introduced in order to spit out a message
whenever a recursive hold of the BKL is released.  By default, each
message (from a single unlock_kernel() instance) will only be printed
once, but this can be overridden on an individual basis.  This
limit is helpful to indicate if the particular condition is very rare,
or relatively common.  There are plenty of ways to do this, so I
implemented the second-laziest one.  The first is to do nothing :)

There is also a er_lock_kernel(), this call expects the BKL to already
be held (er==expect recursive).  If the BKL isn't held, a message is
printed saying so.

For instance, I saw a lot of these on my ext3 filesystem:
release of recursive BKL hold, depth: 1
	inode:1108
	inode:2607
I went to ext3/inode.c and replaced inode.c:2607's lock_kernel() with
er_lock_kernel().  I'll be notified if the BKL is ever _not_ held
here.  I'm using ext3 as an example because it was making the largest
footprint in the logs the first time I booted.  Actually, it
never did boot, it was too busy printing messages to the serial port
:) (that's when I implemented the print limiter)

unlock_kernel_quiet() will make sure that none of these messages get
printed out.

This is all activated with the config option CONFIG_DEBUG_BKL, which
is accessible in the kernel debugging section.  If the config option
is off, the object code should be exactly the same as a kernel without
this patch.  The kernel is slower, but is quite usable with the patch
applied and turned on.

I also attached a few patches which add some checking to the tty and
ext3 code.  Don't take too much stock in these, they're just a
demonstration and not nearly complete.

P.S. Thanks to Ted Ts'o for suggesting that I print messages instead
of simply bugging on these conditions.  Be careful what you ask for.

-- 
Dave Hansen
haveblue@us.ibm.com





--------------040003020001010701060003
Content-Type: text/plain;
 name="tty_bkl_debug-2.5.24-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tty_bkl_debug-2.5.24-0.patch"

diff --exclude=linux/fs/ext3/ -ur linux-2.5.24-clean/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux-2.5.24-clean/drivers/char/tty_io.c	Thu Jun 20 15:53:54 2002
+++ linux/drivers/char/tty_io.c	Fri Jun 28 20:23:52 2002
@@ -437,7 +437,7 @@
 		return;
 
 	/* inuse_filps is protected by the single kernel lock */
-	lock_kernel();
+	er_lock_kernel();
 	
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();


--------------040003020001010701060003
Content-Type: text/plain;
 name="bkl_debug-2.5.24-8.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bkl_debug-2.5.24-8.patch"

diff -ur linux-2.5.24-clean/arch/i386/Config.help linux/arch/i386/Config.help
--- linux-2.5.24-clean/arch/i386/Config.help	Thu Jun 20 15:53:44 2002
+++ linux/arch/i386/Config.help	Fri Jun 28 21:15:35 2002
@@ -932,6 +932,15 @@
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
 
+CONFIG_DEBUG_BKL
+  Say Y here to get interesting information about the Big Kernel
+  Lock's use in dmesg.  
+  Shows information on the following:
+  - nested holds of BKL
+  - releases in schedule (not yet implemented)
+  - use in interrupts (not yet implemented)
+  Send any interesting output to Dave Hansen <haveblue@us.ibm.com>
+
 CONFIG_DEBUG_BUGVERBOSE
   Say Y here to make BUG() panics output the file name and line number
   of the BUG call as well as the EIP and oops trace.  This aids
diff -ur linux-2.5.24-clean/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.24-clean/arch/i386/config.in	Thu Jun 20 15:53:49 2002
+++ linux/arch/i386/config.in	Fri Jun 28 10:57:50 2002
@@ -416,6 +416,7 @@
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  Big kernel lock (BKL,kernel_flag) debugging' CONFIG_DEBUG_BKL
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi
diff -ur linux-2.5.24-clean/include/asm-alpha/smplock.h linux/include/asm-alpha/smplock.h
--- linux-2.5.24-clean/include/asm-alpha/smplock.h	Thu Jun 20 15:53:49 2002
+++ linux/include/asm-alpha/smplock.h	Fri Jun 28 08:50:16 2002
@@ -39,13 +39,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-static __inline__ void unlock_kernel(void)
+static __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-arm/smplock.h linux/include/asm-arm/smplock.h
--- linux-2.5.24-clean/include/asm-arm/smplock.h	Thu Jun 20 15:53:43 2002
+++ linux/include/asm-arm/smplock.h	Fri Jun 28 09:01:59 2002
@@ -41,7 +41,7 @@
  * so we only need to worry about other
  * CPU's.
  */
-static inline void lock_kernel(void)
+static inline void __lock_kernel(void)
 {
 #ifdef CONFIG_PREEMPT
 	if (current->lock_depth == -1)
@@ -53,7 +53,7 @@
 #endif
 }
 
-static inline void unlock_kernel(void)
+static inline void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-cris/smp_lock.h linux/include/asm-cris/smp_lock.h
--- linux-2.5.24-clean/include/asm-cris/smp_lock.h	Thu Jun 20 15:53:44 2002
+++ linux/include/asm-cris/smp_lock.h	Fri Jun 28 09:01:59 2002
@@ -11,7 +11,7 @@
  *	Locking the kernel 
  */
  
-extern __inline void lock_kernel(void)
+extern __inline void __lock_kernel(void)
 {
 	unsigned long flags;
 	int proc = smp_processor_id();
@@ -49,7 +49,7 @@
 	restore_flags(flags);
 }
 
-extern __inline void unlock_kernel(void)
+extern __inline void __unlock_kernel(void)
 {
 	unsigned long flags;
 	save_flags(flags);
diff -ur linux-2.5.24-clean/include/asm-cris/smplock.h linux/include/asm-cris/smplock.h
--- linux-2.5.24-clean/include/asm-cris/smplock.h	Thu Jun 20 15:53:52 2002
+++ linux/include/asm-cris/smplock.h	Fri Jun 28 08:50:41 2002
@@ -11,8 +11,8 @@
 
 #ifndef CONFIG_SMP
 
-#define lock_kernel()                           do { } while(0)
-#define unlock_kernel()                         do { } while(0)
+#define __lock_kernel()                           do { } while(0)
+#define __unlock_kernel()                         do { } while(0)
 #define release_kernel_lock(task, cpu, depth)   ((depth) = 1)
 #define reacquire_kernel_lock(task, cpu, depth) do { } while(0)
 
diff -ur linux-2.5.24-clean/include/asm-generic/smplock.h linux/include/asm-generic/smplock.h
--- linux-2.5.24-clean/include/asm-generic/smplock.h	Thu Jun 20 15:53:43 2002
+++ linux/include/asm-generic/smplock.h	Fri Jun 28 09:01:59 2002
@@ -38,13 +38,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-i386/smplock.h linux/include/asm-i386/smplock.h
--- linux-2.5.24-clean/include/asm-i386/smplock.h	Thu Jun 20 15:53:49 2002
+++ linux/include/asm-i386/smplock.h	Fri Jun 28 11:05:52 2002
@@ -54,7 +54,7 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static __inline__ void __lock_kernel(void)
 {
 #ifdef CONFIG_PREEMPT
 	if (current->lock_depth == -1)
@@ -76,7 +76,7 @@
 #endif
 }
 
-static __inline__ void unlock_kernel(void)
+static __inline__ void __unlock_kernel(void)
 {
 	if (current->lock_depth < 0)
 		BUG();
diff -ur linux-2.5.24-clean/include/asm-ia64/smplock.h linux/include/asm-ia64/smplock.h
--- linux-2.5.24-clean/include/asm-ia64/smplock.h	Thu Jun 20 15:53:54 2002
+++ linux/include/asm-ia64/smplock.h	Fri Jun 28 08:51:16 2002
@@ -51,14 +51,14 @@
  * CPU's.
  */
 static __inline__ void
-lock_kernel(void)
+__lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
 static __inline__ void
-unlock_kernel(void)
+__unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-m68k/smplock.h linux/include/asm-m68k/smplock.h
--- linux-2.5.24-clean/include/asm-m68k/smplock.h	Thu Jun 20 15:53:48 2002
+++ linux/include/asm-m68k/smplock.h	Fri Jun 28 09:01:59 2002
@@ -38,13 +38,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-mips/smplock.h linux/include/asm-mips/smplock.h
--- linux-2.5.24-clean/include/asm-mips/smplock.h	Thu Jun 20 15:53:49 2002
+++ linux/include/asm-mips/smplock.h	Fri Jun 28 09:01:59 2002
@@ -41,13 +41,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-mips64/smplock.h linux/include/asm-mips64/smplock.h
--- linux-2.5.24-clean/include/asm-mips64/smplock.h	Thu Jun 20 15:53:49 2002
+++ linux/include/asm-mips64/smplock.h	Fri Jun 28 09:01:59 2002
@@ -41,13 +41,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-static __inline__ void unlock_kernel(void)
+static __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-parisc/smplock.h linux/include/asm-parisc/smplock.h
--- linux-2.5.24-clean/include/asm-parisc/smplock.h	Thu Jun 20 15:53:43 2002
+++ linux/include/asm-parisc/smplock.h	Fri Jun 28 09:01:59 2002
@@ -36,13 +36,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-ppc/smplock.h linux/include/asm-ppc/smplock.h
--- linux-2.5.24-clean/include/asm-ppc/smplock.h	Thu Jun 20 15:53:48 2002
+++ linux/include/asm-ppc/smplock.h	Fri Jun 28 09:01:59 2002
@@ -47,7 +47,7 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static __inline__ void __lock_kernel(void)
 {
 #ifdef CONFIG_PREEMPT
 	if (current->lock_depth == -1)
@@ -59,7 +59,7 @@
 #endif /* CONFIG_PREEMPT */
 }
 
-static __inline__ void unlock_kernel(void)
+static __inline__ void __unlock_kernel(void)
 {
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-ppc64/smplock.h linux/include/asm-ppc64/smplock.h
--- linux-2.5.24-clean/include/asm-ppc64/smplock.h	Thu Jun 20 15:53:47 2002
+++ linux/include/asm-ppc64/smplock.h	Fri Jun 28 09:01:59 2002
@@ -43,13 +43,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-static __inline__ void lock_kernel(void)
+static __inline__ void __lock_kernel(void)
 {
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 }
 
-static __inline__ void unlock_kernel(void)
+static __inline__ void __unlock_kernel(void)
 {
 	if (current->lock_depth < 0)
 		BUG();
diff -ur linux-2.5.24-clean/include/asm-s390/smplock.h linux/include/asm-s390/smplock.h
--- linux-2.5.24-clean/include/asm-s390/smplock.h	Thu Jun 20 15:53:55 2002
+++ linux/include/asm-s390/smplock.h	Fri Jun 28 09:01:59 2002
@@ -48,13 +48,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
         if (!++current->lock_depth)
                 spin_lock(&kernel_flag);
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
         if (--current->lock_depth < 0)
                 spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-s390x/smplock.h linux/include/asm-s390x/smplock.h
--- linux-2.5.24-clean/include/asm-s390x/smplock.h	Thu Jun 20 15:53:49 2002
+++ linux/include/asm-s390x/smplock.h	Fri Jun 28 09:01:59 2002
@@ -48,13 +48,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
         if (!++current->lock_depth)
                 spin_lock(&kernel_flag);
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
         if (--current->lock_depth < 0)
                 spin_unlock(&kernel_flag);
diff -ur linux-2.5.24-clean/include/asm-sh/smplock.h linux/include/asm-sh/smplock.h
--- linux-2.5.24-clean/include/asm-sh/smplock.h	Thu Jun 20 15:53:46 2002
+++ linux/include/asm-sh/smplock.h	Fri Jun 28 08:52:21 2002
@@ -11,8 +11,8 @@
 
 #ifndef CONFIG_SMP
 
-#define lock_kernel()				do { } while(0)
-#define unlock_kernel()				do { } while(0)
+#define __lock_kernel()				do { } while(0)
+#define __unlock_kernel()			do { } while(0)
 #define release_kernel_lock(task, cpu, depth)	((depth) = 1)
 #define reacquire_kernel_lock(task, cpu, depth)	do { } while(0)
 
diff -ur linux-2.5.24-clean/include/asm-sparc/smplock.h linux/include/asm-sparc/smplock.h
--- linux-2.5.24-clean/include/asm-sparc/smplock.h	Thu Jun 20 15:53:53 2002
+++ linux/include/asm-sparc/smplock.h	Fri Jun 28 08:52:37 2002
@@ -42,13 +42,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-#define lock_kernel()				\
+#define __lock_kernel()				\
 do {						\
 	if (!++current->lock_depth)		\
 		spin_lock(&kernel_flag);	\
 } while(0)
 
-#define unlock_kernel()				\
+#define __unlock_kernel()			\
 do {						\
 	if (--current->lock_depth < 0)		\
 		spin_unlock(&kernel_flag);	\
diff -ur linux-2.5.24-clean/include/asm-sparc64/smplock.h linux/include/asm-sparc64/smplock.h
--- linux-2.5.24-clean/include/asm-sparc64/smplock.h	Thu Jun 20 15:53:56 2002
+++ linux/include/asm-sparc64/smplock.h	Fri Jun 28 08:52:53 2002
@@ -50,13 +50,13 @@
  * so we only need to worry about other
  * CPU's.
  */
-#define lock_kernel()				\
+#define __lock_kernel()				\
 do {						\
 	if (!++current->lock_depth)		\
 		spin_lock(&kernel_flag);	\
 } while(0)
 
-#define unlock_kernel()				\
+#define __unlock_kernel()			\
 do {						\
 	if (--current->lock_depth < 0)		\
 		spin_unlock(&kernel_flag);	\
diff -ur linux-2.5.24-clean/include/asm-x86_64/smplock.h linux/include/asm-x86_64/smplock.h
--- linux-2.5.24-clean/include/asm-x86_64/smplock.h	Thu Jun 20 15:53:51 2002
+++ linux/include/asm-x86_64/smplock.h	Fri Jun 28 09:01:59 2002
@@ -54,7 +54,7 @@
  * so we only need to worry about other
  * CPU's.
  */
-extern __inline__ void lock_kernel(void)
+extern __inline__ void __lock_kernel(void)
 {
 #ifdef CONFIG_PREEMPT
 	if (current->lock_depth == -1)
@@ -76,7 +76,7 @@
 #endif
 }
 
-extern __inline__ void unlock_kernel(void)
+extern __inline__ void __unlock_kernel(void)
 {
 	if (current->lock_depth < 0)
 		BUG();
diff -ur linux-2.5.24-clean/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.24-clean/include/linux/sched.h	Thu Jun 20 15:53:44 2002
+++ linux/include/linux/sched.h	Fri Jun 28 11:03:17 2002
@@ -28,6 +28,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/spinlock.h>
 
 struct exec_domain;
 
@@ -255,6 +256,8 @@
 	unsigned long ptrace;
 
 	int lock_depth;		/* Lock depth */
+	struct lock_trace lt[MAX_LOCK_TRACE_DEPTH];
+	int lt_dirty; 		/* don't print redundant stuff */
 
 	int prio, static_prio;
 	list_t run_list;
diff -ur linux-2.5.24-clean/include/linux/smp_lock.h linux/include/linux/smp_lock.h
--- linux-2.5.24-clean/include/linux/smp_lock.h	Thu Jun 20 15:53:48 2002
+++ linux/include/linux/smp_lock.h	Fri Jun 28 08:53:15 2002
@@ -5,8 +5,8 @@
 
 #if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
 
-#define lock_kernel()				do { } while(0)
-#define unlock_kernel()				do { } while(0)
+#define __lock_kernel()				do { } while(0)
+#define __unlock_kernel()			do { } while(0)
 #define release_kernel_lock(task, cpu)		do { } while(0)
 #define reacquire_kernel_lock(task)		do { } while(0)
 #define kernel_locked() 1
diff -ur linux-2.5.24-clean/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.24-clean/include/linux/spinlock.h	Thu Jun 20 15:53:52 2002
+++ linux/include/linux/spinlock.h	Fri Jun 28 21:40:44 2002
@@ -197,6 +197,91 @@
 #define write_trylock(lock)		_raw_write_trylock(lock)
 #endif
 
+#ifdef CONFIG_DEBUG_BKL
+/*
+ *  This will increase size of task_struct by 
+ *  MAX_LOCK_RECURSION*sizeof(lock_trace)
+ *
+ *  the longest filename that I can find is 28
+ *  KBUILD_BASENAME is 2 shorter than that
+ *  find -name '*.[ch]' | awk -F/ '{print length($(NF)), $NF}' | sort -n
+ */
+#define MAX_LOCK_TRACE_DEPTH 16
+struct lock_trace {
+	char func_name[32];
+	unsigned int line;
+};
+
+#define LT_ENTRY(i) (current->lt[(i)])
+#define CURR_LT_ENTRY	(LT_ENTRY(current->lock_depth))
+#define LT_LABEL	(__stringify(KBUILD_BASENAME))
+#define lock_kernel()						\
+do {								\
+	__lock_kernel();					\
+	strncpy(CURR_LT_ENTRY.func_name,LT_LABEL,32);		\
+	CURR_LT_ENTRY.func_name[31] = '\0';			\
+	CURR_LT_ENTRY.line = __LINE__;				\
+	current->lt_dirty = 1;					\
+								\
+} while (0)
+/* 
+ * er == expect recursive hold, print if that isn't found
+ */
+#define er_lock_kernel() er_lock_kernel_c(1)
+#define er_lock_kernel_c(PRINT_COUNT) 				\
+do {								\
+	static int prints_allowed = PRINT_COUNT;		\
+	if( current->lock_depth == -1 && (prints_allowed-->0)) {\
+		printk( "BKL not held, %s:%s:%d\n", 		\
+				(__stringify(KBUILD_BASENAME)),	\
+				__FUNCTION__,			\
+				__LINE__ );			\
+	}							\
+	lock_kernel();						\
+} while (0)
+

+/* 
+ * default number of times to print, and allow overriding it
+ */
+#define unlock_kernel()		unlock_kernel_c(1)
+
+#define unlock_kernel_c(PRINT_COUNT)					\
+do {									\
+	static int prints_allowed = PRINT_COUNT;			\
+	int i;								\
+	if( current->lt_dirty && current->lock_depth > 0 && 		\
+	    (prints_allowed-->0) ) {					\
+		printk( "release of recursive BKL hold, depth: %d\n", 	\
+			current->lock_depth ); 				\
+		for( i=0; 						\
+		     current->lt_dirty && i<=current->lock_depth; 	\
+		     i++ ) {	\					\
+			printk( "[%2d]%s:%d\n", i, 			\
+						LT_ENTRY(i).func_name, 	\
+					        LT_ENTRY(i).line );	\
+		}							\
+	}								\
+	current->lt_dirty = 0;						\
+	__unlock_kernel();						\
+} while (0)
+#define unlock_kernel_quiet() 	\
+do {				\
+	current->lt_dirty = 0;	\
+	__unlock_kernel(); 	\
+} while(0)
+
+#else
+#define MAX_LOCK_TRACE_DEPTH 1
+struct lock_trace {};
+#define lock_kernel() __lock_kernel()
+#define lock_kernel_c(x) __lock_kernel()
+#define er_lock_kernel_c(x) __lock_kernel()
+#define er_lock_kernel() __lock_kernel()
+#define unlock_kernel() __unlock_kernel()
+#define unlock_kernel_c(x) __unlock_kernel()
+#define unlock_kernel_quiet() __unlock_kernel()
+#endif
+
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>


--------------040003020001010701060003
Content-Type: text/plain;
 name="ext3_bkl_debug-2.5.24-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext3_bkl_debug-2.5.24-1.patch"

diff -ur linux-2.5.24-clean/fs/ext3/inode.c linux/fs/ext3/inode.c
--- linux-2.5.24-clean/fs/ext3/inode.c	Thu Jun 20 15:53:55 2002
+++ linux/fs/ext3/inode.c	Fri Jun 28 20:29:49 2002
@@ -32,6 +32,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/string.h>
+#include <linux/spinlock.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
 
@@ -754,7 +755,7 @@
 	if (depth == 0)
 		goto out;
 
-	lock_kernel();
+	er_lock_kernel_c(5);
 reread:
 	partial = ext3_get_branch(inode, depth, offsets, chain, &err);
 
@@ -779,7 +780,7 @@
 			partial--;
 		}
 		BUFFER_TRACE(bh_result, "returned");
-		unlock_kernel();
+		unlock_kernel_c(5);
 out:
 		return err;
 	}
@@ -883,7 +884,7 @@
 			   For now, regular file writes use
 			   ext3_get_block instead, so it's not a
 			   problem. */
-			lock_kernel();
+			er_lock_kernel();
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
 			fatal = ext3_journal_get_create_access(handle, bh);
@@ -896,7 +897,7 @@
 			BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
 			err = ext3_journal_dirty_metadata(handle, bh);
 			if (!fatal) fatal = err;
-			unlock_kernel();
+			unlock_kernel_c(5);
 		} else {
 			BUFFER_TRACE(bh, "not a new buffer");
 		}
@@ -1900,7 +1901,7 @@
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		return;
 
-	lock_kernel();
+	er_lock_kernel();
 	ext3_discard_prealloc(inode);
 
 	handle = start_transaction(inode);
@@ -2605,6 +2606,7 @@
 	handle_t *handle;
 
 	lock_kernel();
+	
 	handle = ext3_journal_start(inode, 1);
 	if (IS_ERR(handle))
 		goto out;
@@ -2620,7 +2622,7 @@
 	}
 	ext3_journal_stop(handle, inode);
 out:
-	unlock_kernel();
+	unlock_kernel_c(5);
 }
 
 #ifdef AKPM
diff -ur linux-2.5.24-clean/fs/jbd/commit.c linux/fs/jbd/commit.c
--- linux-2.5.24-clean/fs/jbd/commit.c	Thu Jun 20 15:53:49 2002
+++ linux/fs/jbd/commit.c	Fri Jun 28 18:48:31 2002
@@ -72,7 +72,7 @@
 	spin_unlock(&journal_datalist_lock);
 #endif
 
-	lock_kernel();
+	er_lock_kernel();
 	
 	J_ASSERT (journal->j_running_transaction != NULL);
 	J_ASSERT (journal->j_committing_transaction == NULL);
@@ -164,7 +164,7 @@
 
 	commit_transaction->t_log_start = journal->j_head;
 
-	unlock_kernel();
+	unlock_kernel_quiet();
 	
 	jbd_debug (3, "JBD: commit phase 2\n");
 
diff -ur linux-2.5.24-clean/fs/jbd/journal.c linux/fs/jbd/journal.c
--- linux-2.5.24-clean/fs/jbd/journal.c	Thu Jun 20 15:53:46 2002
+++ linux/fs/jbd/journal.c	Fri Jun 28 18:53:03 2002
@@ -544,7 +544,7 @@
 {
 	tid_t target = journal->j_commit_request;
 
-	lock_kernel(); /* Protect journal->j_running_transaction */
+	er_lock_kernel(); /* Protect journal->j_running_transaction */
 	
 	/*
 	 * A NULL transaction asks us to commit the currently running
@@ -577,7 +577,7 @@
 	wake_up(&journal->j_wait_commit);
 
 out:
-	unlock_kernel();
+	unlock_kernel_quiet();
 	return target;
 }
 
@@ -587,7 +587,7 @@
  */
 void log_wait_commit (journal_t *journal, tid_t tid)
 {
-	lock_kernel();
+	er_lock_kernel();
 #ifdef CONFIG_JBD_DEBUG
 	lock_journal(journal);
 	if (!tid_geq(journal->j_commit_request, tid)) {
@@ -603,7 +603,7 @@
 		wake_up(&journal->j_wait_commit);
 		sleep_on(&journal->j_wait_done_commit);
 	}
-	unlock_kernel();
+	unlock_kernel_quiet();
 }
 
 /*


--------------040003020001010701060003--

