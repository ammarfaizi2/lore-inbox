Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUHDJJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUHDJJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUHDJJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:09:01 -0400
Received: from tapuz.safe-mail.net ([212.68.149.115]:46279 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S261711AbUHDJIy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:08:54 -0400
X-SMType: Regular
X-SMRef: N1-Yp2-6sYC
Message-ID: <4110A7AF.2060903@safe-mail.net>
Date: Wed, 04 Aug 2004 17:09:03 +0800
From: Liu Tao <liutao@safe-mail.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] Add a writer prior lock methord for rwlock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds the write_forcelock() methord, which has higher priority than
read_lock() and write_lock(). The original read_lock() and write_lock() 
is not
touched, and the unlock methord is still write_unlock();
The patch gives implemention on i386, for kernel 2.6.7.

Regards

-----------------------

diff -Naur linux-2.6.7/include/asm-i386/rwlock.h 
linux-2.6.7-dev/include/asm-i386/rwlock.h
--- linux-2.6.7/include/asm-i386/rwlock.h    2004-06-16 
13:20:04.000000000 +0800
+++ linux-2.6.7-dev/include/asm-i386/rwlock.h    2004-08-03 
09:15:02.000000000 +0800
@@ -80,4 +80,37 @@
                             __build_write_lock_ptr(rw, helper); \
                     } while (0)
 
+#define __build_write_forcelock_ptr(rw) \
+    asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+             "jnz 2f\n" \
+             "1:\n" \
+             LOCK_SECTION_START("") \
+             "2:\t" \
+             "rep;nop\n\t" \
+             "cmpl $0,(%0)\n\t" \
+             "jnz 2b\n\t" \
+             "jmp 1b\n" \
+             LOCK_SECTION_END \
+             ::"a" (rw) : "memory")
+
+#define __build_write_forcelock_const(rw) \
+    asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
+             "jnz 2f\n" \
+             "1:\n" \
+             LOCK_SECTION_START("") \
+             "2:\t" \
+             "rep;nop\n\t" \
+             "cmpl $0,%0\n\t" \
+             "jnz 2b\n\t" \
+             "jmp 1b\n" \
+             LOCK_SECTION_END \
+             :"=m" (*(volatile int *)rw) : : "memory")
+
+#define __build_write_forcelock(rw)    do { \
+                        if (__builtin_constant_p(rw)) \
+                            __build_write_forcelock_const(rw); \
+                        else \
+                            __build_write_forcelock_ptr(rw); \
+                    } while (0)
+                             
 #endif
diff -Naur linux-2.6.7/include/asm-i386/spinlock.h 
linux-2.6.7-dev/include/asm-i386/spinlock.h
--- linux-2.6.7/include/asm-i386/spinlock.h    2004-06-16 
13:19:02.000000000 +0800
+++ linux-2.6.7-dev/include/asm-i386/spinlock.h    2004-08-02 
16:42:26.000000000 +0800
@@ -139,11 +139,13 @@
  */
 typedef struct {
     volatile unsigned int lock;
+    spinlock_t forcelock;
 #ifdef CONFIG_DEBUG_SPINLOCK
     unsigned magic;
 #endif
 } rwlock_t;
 
+#define RWLOCK_FORCELOCK    , {1 SPINLOCK_MAGIC_INIT}
 #define RWLOCK_MAGIC    0xdeaf1eed
 
 #ifdef CONFIG_DEBUG_SPINLOCK
@@ -152,7 +154,7 @@
 #define RWLOCK_MAGIC_INIT    /* */
 #endif
 
-#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_MAGIC_INIT }
+#define RW_LOCK_UNLOCKED (rwlock_t) { RW_LOCK_BIAS RWLOCK_FORCELOCK 
RWLOCK_MAGIC_INIT }
 
 #define rwlock_init(x)    do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
@@ -185,6 +187,16 @@
     __build_write_lock(rw, "__write_lock_failed");
 }
 
+static inline void _raw_write_forcelock(rwlock_t *rw)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK
+    BUG_ON(rw->magic != RWLOCK_MAGIC);
+#endif
+    _raw_spin_lock(&rw->forcelock);
+    __build_write_forcelock(rw);
+    _raw_spin_unlock(&rw->forcelock);
+}
+
 #define _raw_read_unlock(rw)        asm volatile("lock ; incl %0" :"=m" 
((rw)->lock) : : "memory")
 #define _raw_write_unlock(rw)    asm volatile("lock ; addl $" 
RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
diff -Naur linux-2.6.7/include/linux/spinlock.h 
linux-2.6.7-dev/include/linux/spinlock.h
--- linux-2.6.7/include/linux/spinlock.h    2004-06-16 
13:19:23.000000000 +0800
+++ linux-2.6.7-dev/include/linux/spinlock.h    2004-08-04 
16:25:37.000000000 +0800
@@ -231,6 +231,12 @@
 } while(0)
 #endif
 
+#define write_forcelock(lock) \
+do { \
+    preempt_disable(); \
+    _raw_write_forcelock(lock); \
+} while (0)
+
 #define read_lock(lock)    \
 do { \
     preempt_disable(); \
@@ -318,6 +324,27 @@
     _raw_write_lock(lock); \
 } while (0)
 
+#define write_forcelock_irqsave(lock, flags) \
+do { \
+    local_irq_save(flags); \
+    preempt_disable(); \
+    _raw_write_forcelock(lock); \
+} while (0)
+
+#define write_forcelock_irq(lock) \
+do { \
+    local_irq_disable(); \
+    preempt_disable(); \
+    _raw_write_forcelock(lock); \
+} while (0)
+
+#define write_forcelock_bh(lock) \
+do { \
+    local_bh_disable(); \
+    preempt_disable(); \
+    _raw_write_forcelock(lock); \
+} while (0)
+
 #define spin_unlock_irqrestore(lock, flags) \
 do { \
     _raw_spin_unlock(lock); \





