Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUEATNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUEATNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 15:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUEATNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 15:13:19 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:56809 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261984AbUEATNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 15:13:14 -0400
Date: Sat, 1 May 2004 15:13:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>
Subject: [PATCH][2.6-mm] Allow i386 to reenable interrupts on lock contention
In-Reply-To: <2015.1083331968@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.58.0405010628030.2332@montezuma.fsmlabs.com>
References: <2015.1083331968@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Keith, Andrew,

Following up on Keith's code, i adapted the i386 code to allow enabling
interrupts during contested locks depending on previous interrupt
enable status. Obviously there will be a text increase (only for non
CONFIG_SPINLINE case), although it doesn't seem so bad, there will be an
increased exit latency when we attempt a lock acquisition after spinning
due to the extra instructions. How much this will affect performance i'm
not sure yet as i haven't had time to micro bench.

   text    data     bss     dec     hex filename
2628024  921731       0 3549755  362a3b vmlinux-after
2621369  921731       0 3543100  36103c vmlinux-before
2618313  919222       0 3537535  35fa7f vmlinux-spinline

The code has been stress tested on a 16x NUMAQ (courtesy OSDL).

Andrew, does this email have a whitespace problem too?

Index: linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 spinlock.h
--- linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h	1 May 2004 08:19:15 -0000	1.1.1.1
+++ linux-2.6.6-rc3-mm1/include/asm-i386/spinlock.h	1 May 2004 18:21:41 -0000
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
@@ -72,6 +86,26 @@ typedef struct {
 		"jmp 1b\n" \
 		LOCK_SECTION_END

+	#define spin_lock_string_flags \
+		"\n1:\t" \
+		"lock ; decb %0\n\t" \
+		"jns 4f\n" \
+		"testl $0x200, %1\n\t" \
+		"jz 2f\n\t" \
+		"sti\n\t" \
+		"jmp 2f\n\t" \
+		LOCK_SECTION_START("") \
+		"2:\t" \
+		"rep;nop\n\t" \
+		"cmpb $0, %0\n\t" \
+		"jle 2b\n\t" \
+		"jmp 3f\n\t" \
+		LOCK_SECTION_END \
+		"3:\t" \
+		"cli\n\t" \
+		"jmp 1b\n" \
+		"4:\t"
+
 #endif /* CONFIG_SPINLINE */
 /*
  * This works. Despite all the confusion.
@@ -143,6 +177,20 @@ here:
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
