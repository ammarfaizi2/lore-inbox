Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUEAWVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUEAWVa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbUEAWVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:21:30 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:47348 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262431AbUEAWVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:21:04 -0400
Date: Sat, 1 May 2004 18:21:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH][2.6-mm] Allow i386 to reenable interrupts on lock
 contention
In-Reply-To: <20040501143955.10d1cea1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405011750070.2332@montezuma.fsmlabs.com>
References: <2015.1083331968@ocs3.ocs.com.au> <Pine.LNX.4.58.0405010628030.2332@montezuma.fsmlabs.com>
 <20040501143955.10d1cea1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Andrew Morton wrote:

> Could we move all the irq-handling stuff into the out-of-line section, to
> keep the fast-path cache footprint smaller?

Of course, oversight on my part. Done and restested.

Index: linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h	1 May 2004 08:19:15 -0000	1.1.1.1
+++ linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h	1 May 2004 21:53:36 -0000
@@ -42,7 +42,6 @@ typedef struct {

 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)

 #ifdef CONFIG_SPINLINE

@@ -58,6 +57,21 @@ typedef struct {
 		"jmp 1b\n" \
 		"3:\t"

+	#define spin_lock_string_flags \
+		"\n1:\t" \
+		"lock ; decb %0\n\t" \
+		"jns 3f\n" \
+		"testl $0x200, %1\n\t" \
+		"jz 2f\n\t" \
+		"sti\n\t" \
+		"2:\t" \
+		"rep;nop\n\t" \
+		"cmpb $0, %0\n\t" \
+		"jle 2b\n\t" \
+		"cli\n\t" \
+		"jmp 1b\n" \
+		"3:\t"
+
 #else /* !CONFIG_SPINLINE */

 	#define spin_lock_string \
@@ -72,6 +86,23 @@ typedef struct {
 		"jmp 1b\n" \
 		LOCK_SECTION_END

+	#define spin_lock_string_flags \
+		"\n1:\t" \
+		"lock ; decb %0\n\t" \
+		"js 2f\n\t" \
+		LOCK_SECTION_START("") \
+		"2:\t" \
+		"testl $0x200, %1\n\t" \
+		"jz 3f\n\t" \
+		"sti\n\t" \
+		"3:\t" \
+		"rep;nop\n\t" \
+		"cmpb $0, %0\n\t" \
+		"jle 3b\n\t" \
+		"cli\n\t" \
+		"jmp 1b\n" \
+		LOCK_SECTION_END
+
 #endif /* CONFIG_SPINLINE */
 /*
  * This works. Despite all the confusion.
@@ -143,6 +174,20 @@ here:
 		:"=m" (lock->lock) : : "memory");
 }

+static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK
+	__label__ here;
+here:
+	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
+		printk("eip: %p\n", &&here);
+		BUG();
+	}
+#endif
+	__asm__ __volatile__(
+		spin_lock_string_flags
+		:"=m" (lock->lock) : "r" (flags) : "memory");
+}

 /*
  * Read-write spinlocks, allowing multiple readers
