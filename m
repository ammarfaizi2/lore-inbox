Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUG0JZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUG0JZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUG0JZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:25:45 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61178 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261159AbUG0JZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:25:43 -0400
Date: Tue, 27 Jul 2004 05:29:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-ID: <Pine.LNX.4.58.0407270432470.23989@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up to the previous patches for ia64 and i386, it will
allow x86_64 to reenable interrupts during contested locks depending on
previous interrupt enable status. It has been runtime and compile tested
on UP and 2x SMP Linux-tiny/x86_64.

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

--- linux-2.6-amd64/include/asm-x86_64/spinlock.h.orig	2004-07-27 03:32:18.689949016 -0400
+++ linux-2.6-amd64/include/asm-x86_64/spinlock.h	2004-07-27 03:45:19.610231088 -0400
@@ -41,7 +41,6 @@ typedef struct {

 #define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
 #define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)

 #define spin_lock_string \
 	"\n1:\t" \
@@ -55,6 +54,23 @@ typedef struct {
 	"jmp 1b\n" \
 	LOCK_SECTION_END

+#define spin_lock_string_flags \
+	"\n1:\t" \
+	"lock ; decb %0\n\t" \
+	"js 2f\n\t" \
+	LOCK_SECTION_START("") \
+	"2:\t" \
+	"test $0x200, %1\n\t" \
+	"jz 3f\n\t" \
+	"sti\n\t" \
+	"3:\t" \
+	"rep;nop\n\t" \
+	"cmpb $0, %0\n\t" \
+	"jle 3b\n\t" \
+	"cli\n\t" \
+	"jmp 1b\n" \
+	LOCK_SECTION_END
+
 /*
  * This works. Despite all the confusion.
  * (except on PPro SMP or if we are using OOSTORE)
@@ -125,6 +141,20 @@ printk("eip: %p\n", &&here);
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
+	__asm__ __volatile__(spin_lock_string_flags
+		:"=m" (lock->lock) : "r" (flags) : "memory");
+}
+

 /*
  * Read-write spinlocks, allowing multiple readers
