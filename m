Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268834AbRHBHCZ>; Thu, 2 Aug 2001 03:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRHBHCQ>; Thu, 2 Aug 2001 03:02:16 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:45574 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S268833AbRHBHCE>; Thu, 2 Aug 2001 03:02:04 -0400
Message-ID: <3B68FAF4.2B3C9064@freesoft.org>
Date: Thu, 02 Aug 2001 03:02:12 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: enhanced spinlock debugging code for intel
Content-Type: multipart/mixed;
 boundary="------------2C3F5AB3B87218E644F484CC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2C3F5AB3B87218E644F484CC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi -

I'm having a problem with my USB CD burner that involves spinlocks - in
particular, some code that trys to grab a spinlock that's already locked
(this on a uni-processor machine).

The existing spinlock debug code on intel only checked for unlocking an
unlocked spinlock, so I added code to check for locking a locked
spinlock as well - it now catches my problem.

I'm attaching the code.  The basic operation is to add a field (when
SPINLOCK_DEBUG is set in include/asm-i386/spinlock.h; no config option)
to the spinlock structure that contains the processor ID that set the
lock.  Then, when we try to grab the lock, check to see if 1) it's
already locked and 2) the current processor is the one that holds the
lock.

I've had to add some hideous code to get the processor ID:

	#define my_processor_id (((int *)current)[13])

since sched.h includes spinlock.h, so task_struct isn't defined when
this file is parsed, so we can't just dereference current to find the
processor ID.  Any better suggestions would be welcome.

The code also adds fields to record the PC and current task_struct when
the lock is grabbed, so if somebody comes along later and trys to grab
it again, we can figure out who already has it.  This information
doesn't show up in a oops, but is easily extracted using remote gdb (see
my previous post).

Try it if you'd like; it's not very complex, but I would like a better
solution for getting the processor ID before I make it an "official"
submission to Linus.

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
--------------2C3F5AB3B87218E644F484CC
Content-Type: text/plain; charset=us-ascii;
 name="linux-spinlock-diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-spinlock-diff"

diff -ru linux-2.4.6-dist/include/asm-i386/spinlock.h linux-2.4.6-kgdb/include/asm-i386/spinlock.h
--- linux-2.4.6-dist/include/asm-i386/spinlock.h	Fri May 25 21:01:26 2001
+++ linux-2.4.6-kgdb/include/asm-i386/spinlock.h	Wed Aug  1 23:11:51 2001
@@ -1,6 +1,8 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#include <asm/smp.h>
+#include <asm/current.h>
 #include <asm/atomic.h>
 #include <asm/rwlock.h>
 #include <asm/page.h>
@@ -12,7 +14,7 @@
  * initialize their spinlocks properly, tsk tsk.
  * Remember to turn this off in 2.4. -ben
  */
-#define SPINLOCK_DEBUG	0
+#define SPINLOCK_DEBUG	1
 
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
@@ -22,13 +24,16 @@
 	volatile unsigned int lock;
 #if SPINLOCK_DEBUG
 	unsigned magic;
+	void *last_lock_addr;
+	void *last_lock_current;
+	int last_lock_processor;
 #endif
 } spinlock_t;
 
 #define SPINLOCK_MAGIC	0xdead4ead
 
 #if SPINLOCK_DEBUG
-#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC
+#define SPINLOCK_MAGIC_INIT	, SPINLOCK_MAGIC, NULL
 #else
 #define SPINLOCK_MAGIC_INIT	/* */
 #endif
@@ -75,6 +80,15 @@
 	return oldval > 0;
 }
 
+/* This is here because the definition of smp_processor_id() pulls the
+ * processor id out of the current task_struct, which is defined in
+ * linux/sched.h, which includes this file because it declares spinlocks.
+ * So we can't use smp_processor_id() because task_struct hasn't been
+ * defined yet.  Damn these computers.
+ */
+
+#define my_processor_id (((int *)current)[13])
+
 static inline void spin_lock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
@@ -84,10 +98,18 @@
 printk("eip: %p\n", &&here);
 		BUG();
 	}
+	if (spin_is_locked(lock)
+	    && lock->last_lock_processor == my_processor_id)
+		BUG();
 #endif
 	__asm__ __volatile__(
 		spin_lock_string
 		:"=m" (lock->lock) : : "memory");
+#if SPINLOCK_DEBUG
+	lock->last_lock_addr = &&here;
+	lock->last_lock_processor = my_processor_id;
+	lock->last_lock_current = current;
+#endif
 }
 
 static inline void spin_unlock(spinlock_t *lock)

--------------2C3F5AB3B87218E644F484CC--

