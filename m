Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271394AbTHMGO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 02:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271396AbTHMGO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 02:14:28 -0400
Received: from mail7.speakeasy.net ([216.254.0.207]:43194 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S271394AbTHMGOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 02:14:25 -0400
Date: Tue, 12 Aug 2003 23:14:17 -0700
Message-Id: <200308130614.h7D6EHv07972@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] read_trylock for i386
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Hot pink inflammations
   (2) Ambivalent nylon beef
   (3) Perfidious grief illusions
   (4) Energetic elastic selector captors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus had mentioned that he wished there were a read_trylock that could be
used when taking locks out of order to avoid the usually unnecessary full
treatment with its interrupt-blocked overhead when you unlock and relock.
This came up when adding a lock hierarchy dance to part of do_sigaction,
and the use of it is demonstrated by the patch below (forgive the fuzz).

The following header patches add the read_trylock macro, implementing it
fully for i386 and leaving other architectures with an always-fail fallback.
Other architectures include/asm-foo/spinlock.h files should define
_raw_read_trylock appropriately and define HAVE_ARCH_RAW_READ_TRYLOCK.  But
until they do, machine-independent code can use read_trylock for optimization
purposes (i.e. where it falls back to using read_lock) and architectures that
haven't implemented it will just not be getting the optimization.  

The machine-dependent function is simple enough to add to each architecture.
Even if I didn't know the x86 as well as I do, writing the new function by
looking at the existing assembly code in _raw_read_lock is easy enough
without really grokking the architecture (just tedious, so I'm not doing it
myself).


Enjoy,
Roland


Index: linux-2.5/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/signal.c,v
retrieving revision 1.98
diff -p -u -r1.98 signal.c
--- linux-2.5/kernel/signal.c	7 Aug 2003 20:06:12 -0000	1.98
+++ linux-2.5/kernel/signal.c	12 Aug 2003 21:38:15 -0000
@@ -2255,9 +2267,11 @@ do_sigaction(int sig, const struct k_sig
 			 * dance to maintain the lock hierarchy.
 			 */
 			struct task_struct *t = current;
-			spin_unlock_irq(&t->sighand->siglock);
-			read_lock(&tasklist_lock);
-			spin_lock_irq(&t->sighand->siglock);
+			if (!read_trylock(&tasklist_lock)) {
+				spin_unlock_irq(&t->sighand->siglock);
+				read_lock(&tasklist_lock);
+				spin_lock_irq(&t->sighand->siglock);
+			}
 			*k = *act;
 			sigdelsetmask(&k->sa.sa_mask,
 				      sigmask(SIGKILL) | sigmask(SIGSTOP));


Index: linux-2.5/include/linux/spinlock.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/spinlock.h,v
retrieving revision 1.27
diff -b -p -u -r1.27 spinlock.h
--- linux-2.5/include/linux/spinlock.h	26 Jun 2003 01:19:21 -0000	1.27
+++ linux-2.5/include/linux/spinlock.h	12 Aug 2003 21:58:24 -0000
@@ -38,6 +38,10 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
+# ifndef HAVE_ARCH_RAW_READ_TRYLOCK
+#  define _raw_read_trylock(lock) ({ (void)(lock); (0); })
+# endif
+
 #else
 
 #if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
@@ -178,6 +182,7 @@ typedef struct {
 #define rwlock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_read_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
+#define _raw_read_trylock(lock)	({ (void)(lock); (1); })
 #define _raw_write_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_trylock(lock) ({ (void)(lock); (1); })
@@ -194,8 +199,8 @@ typedef struct {
 
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
-
-/* Where's read_trylock? */
+#define read_trylock(lock)	({preempt_disable();_raw_read_trylock(lock) ? \
+				1 : ({preempt_enable(); 0;});})
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
 void __preempt_spin_lock(spinlock_t *lock);
Index: linux-2.5/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/spinlock.h,v
retrieving revision 1.11
diff -b -p -u -r1.11 spinlock.h
--- linux-2.5/include/asm-i386/spinlock.h	19 May 2003 17:30:30 -0000	1.11
+++ linux-2.5/include/asm-i386/spinlock.h	12 Aug 2003 21:58:24 -0000
@@ -195,5 +195,22 @@ static inline int _raw_write_trylock(rwl
 	atomic_add(RW_LOCK_BIAS, count);
 	return 0;
 }
+
+static inline int _raw_read_trylock(rwlock_t *lock)
+{
+	unsigned char locked;
+	asm volatile(LOCK "subl %2,%0\n\t"
+		     "setns %1\n\t"
+		     "js 2f\n\t"
+		     "1:\n"
+		     LOCK_SECTION_START("")
+		     "2:\t" LOCK "incl %0\n\t"
+		     "jmp 1b\n"
+		     LOCK_SECTION_END
+		     : "=m" (lock->lock), "=qm" (locked)
+		     : "ir" (1), "0" (lock->lock) : "memory");
+	return locked;
+}
+#define HAVE_ARCH_RAW_READ_TRYLOCK 1
 
 #endif /* __ASM_SPINLOCK_H */
