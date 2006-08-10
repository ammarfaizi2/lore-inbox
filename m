Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWHJUFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWHJUFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWHJUEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:56464 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932621AbWHJTgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:39 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [81/145] i386: Remove lock section support in mutex.h, semaphore.h 
Message-Id: <20060810193637.EFBCF13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:37 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Lock sections don't work the new dwarf2 unwinder 
This generates slightly smaller code. It adds one more taken
jump to the fast path.

Also move the trampolines into semaphore.S and add proper CFI
annotations.

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/lib/semaphore.S    |   63 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/mutex.h     |   16 ++--------
 include/asm-i386/rwsem.h     |   62 ++++++++----------------------------------
 include/asm-i386/semaphore.h |   49 +++++++++++----------------------
 4 files changed, 96 insertions(+), 94 deletions(-)

Index: linux/include/asm-i386/mutex.h
===================================================================
--- linux.orig/include/asm-i386/mutex.h
+++ linux/include/asm-i386/mutex.h
@@ -30,14 +30,10 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 		LOCK_PREFIX "   decl (%%eax)	\n"			\
-			"   js 2f		\n"			\
+			"   jns 1f		\n"			\
+			"   call "#fail_fn"	\n"			\
 			"1:			\n"			\
 									\
-		LOCK_SECTION_START("")					\
-			"2: call "#fail_fn"	\n"			\
-			"   jmp 1b		\n"			\
-		LOCK_SECTION_END					\
-									\
 		:"=a" (dummy)						\
 		: "a" (count)						\
 		: "memory", "ecx", "edx");				\
@@ -86,14 +82,10 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 		LOCK_PREFIX "   incl (%%eax)	\n"			\
-			"   jle 2f		\n"			\
+			"   jg	1f		\n"			\
+			"   call "#fail_fn"	\n"			\
 			"1:			\n"			\
 									\
-		LOCK_SECTION_START("")					\
-			"2: call "#fail_fn"	\n"			\
-			"   jmp 1b		\n"			\
-		LOCK_SECTION_END					\
-									\
 		:"=a" (dummy)						\
 		: "a" (count)						\
 		: "memory", "ecx", "edx");				\
Index: linux/arch/i386/lib/semaphore.S
===================================================================
--- linux.orig/arch/i386/lib/semaphore.S
+++ linux/arch/i386/lib/semaphore.S
@@ -130,3 +130,66 @@ ENTRY(__read_lock_failed)
 	END(__read_lock_failed)
 
 #endif
+
+/* Fix up special calling conventions */
+ENTRY(call_rwsem_down_read_failed)
+	CFI_STARTPROC
+	push %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ecx,0
+	push %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edx,0
+	call rwsem_down_read_failed
+	pop %edx
+	CFI_ADJUST_CFA_OFFSET -4
+	pop %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	ret
+	CFI_ENDPROC
+	END(call_rwsem_down_read_failed)
+
+ENTRY(call_rwsem_down_write_failed)
+	CFI_STARTPROC
+	push %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ecx,0
+	calll rwsem_down_write_failed
+	pop %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	ret
+	CFI_ENDPROC
+	END(call_rwsem_down_write_failed)
+
+ENTRY(call_rwsem_wake)
+	CFI_STARTPROC
+	decw %dx    /* do nothing if still outstanding active readers */
+	jnz 1f
+	push %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ecx,0
+	call rwsem_wake
+	pop %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+1:	ret
+	CFI_ENDPROC
+	END(call_rwsem_wake)
+
+/* Fix up special calling conventions */
+ENTRY(call_rwsem_downgrade_wake)
+	CFI_STARTPROC
+	push %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ecx,0
+	push %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edx,0
+	call rwsem_downgrade_wake
+	pop %edx
+	CFI_ADJUST_CFA_OFFSET -4
+	pop %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	ret
+	CFI_ENDPROC
+	END(call_rwsemgrade_wake)
+
Index: linux/include/asm-i386/rwsem.h
===================================================================
--- linux.orig/include/asm-i386/rwsem.h
+++ linux/include/asm-i386/rwsem.h
@@ -99,17 +99,9 @@ static inline void __down_read(struct rw
 	__asm__ __volatile__(
 		"# beginning down_read\n\t"
 LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
-		"  js        2f\n\t" /* jump if we weren't granted the lock */
+		"  jns        1f\n"
+		"  call call_rwsem_down_read_failed\n"
 		"1:\n\t"
-		LOCK_SECTION_START("")
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  pushl     %%edx\n\t"
-		"  call      rwsem_down_read_failed\n\t"
-		"  popl      %%edx\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		LOCK_SECTION_END
 		"# ending down_read\n\t"
 		: "+m" (sem->count)
 		: "a" (sem)
@@ -151,15 +143,9 @@ static inline void __down_write_nested(s
 		"# beginning down_write\n\t"
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
 		"  testl     %%edx,%%edx\n\t" /* was the count 0 before? */
-		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
-		"1:\n\t"
-		LOCK_SECTION_START("")
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_down_write_failed\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		LOCK_SECTION_END
+		"  jz        1f\n"
+		"  call call_rwsem_down_write_failed\n"
+		"1:\n"
 		"# ending down_write"
 		: "+m" (sem->count), "=d" (tmp)
 		: "a" (sem), "1" (tmp)
@@ -193,17 +179,9 @@ static inline void __up_read(struct rw_s
 	__asm__ __volatile__(
 		"# beginning __up_read\n\t"
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
-		"1:\n\t"
-		LOCK_SECTION_START("")
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
-		"  jnz       1b\n\t"
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		LOCK_SECTION_END
+		"  jns        1f\n\t"
+		"  call call_rwsem_wake\n"
+		"1:\n"
 		"# ending __up_read\n"
 		: "+m" (sem->count), "=d" (tmp)
 		: "a" (sem), "1" (tmp)
@@ -219,17 +197,9 @@ static inline void __up_write(struct rw_
 		"# beginning __up_write\n\t"
 		"  movl      %2,%%edx\n\t"
 LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
-		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
+		"  jz       1f\n"
+		"  call call_rwsem_wake\n"
 		"1:\n\t"
-		LOCK_SECTION_START("")
-		"2:\n\t"
-		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
-		"  jnz       1b\n\t" /* jump back if not */
-		"  pushl     %%ecx\n\t"
-		"  call      rwsem_wake\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		LOCK_SECTION_END
 		"# ending __up_write\n"
 		: "+m" (sem->count)
 		: "a" (sem), "i" (-RWSEM_ACTIVE_WRITE_BIAS)
@@ -244,17 +214,9 @@ static inline void __downgrade_write(str
 	__asm__ __volatile__(
 		"# beginning __downgrade_write\n\t"
 LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* transitions 0xZZZZ0001 -> 0xYYYY0001 */
-		"  js        2f\n\t" /* jump if the lock is being waited upon */
+		"  jns       1f\n\t"
+		"  call call_rwsem_downgrade_wake\n"
 		"1:\n\t"
-		LOCK_SECTION_START("")
-		"2:\n\t"
-		"  pushl     %%ecx\n\t"
-		"  pushl     %%edx\n\t"
-		"  call      rwsem_downgrade_wake\n\t"
-		"  popl      %%edx\n\t"
-		"  popl      %%ecx\n\t"
-		"  jmp       1b\n"
-		LOCK_SECTION_END
 		"# ending __downgrade_write\n"
 		: "+m" (sem->count)
 		: "a" (sem), "i" (-RWSEM_WAITING_BIAS)
Index: linux/include/asm-i386/semaphore.h
===================================================================
--- linux.orig/include/asm-i386/semaphore.h
+++ linux/include/asm-i386/semaphore.h
@@ -100,13 +100,10 @@ static inline void down(struct semaphore
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
 		LOCK_PREFIX "decl %0\n\t"     /* --sem->count */
-		"js 2f\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tlea %0,%%eax\n\t"
-		"call __down_failed\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"jns 2f\n"
+		"\tlea %0,%%eax\n\t"
+		"call __down_failed\n"
+		"2:"
 		:"+m" (sem->count)
 		:
 		:"memory","ax");
@@ -123,15 +120,12 @@ static inline int down_interruptible(str
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
+		"xorl %0,%0\n\t"
 		LOCK_PREFIX "decl %1\n\t"     /* --sem->count */
-		"js 2f\n\t"
-		"xorl %0,%0\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tlea %1,%%eax\n\t"
-		"call __down_failed_interruptible\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"jns 2f\n\t"
+		"lea %1,%%eax\n\t"
+		"call __down_failed_interruptible\n"
+		"2:"
 		:"=a" (result), "+m" (sem->count)
 		:
 		:"memory");
@@ -148,15 +142,12 @@ static inline int down_trylock(struct se
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
+		"xorl %0,%0\n\t"
 		LOCK_PREFIX "decl %1\n\t"     /* --sem->count */
-		"js 2f\n\t"
-		"xorl %0,%0\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tlea %1,%%eax\n\t"
+		"jns 2f\n\t"
+		"lea %1,%%eax\n\t"
 		"call __down_failed_trylock\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
+		"2:\n"
 		:"=a" (result), "+m" (sem->count)
 		:
 		:"memory");
@@ -166,22 +157,16 @@ static inline int down_trylock(struct se
 /*
  * Note! This is subtle. We jump to wake people up only if
  * the semaphore was negative (== somebody was waiting on it).
- * The default case (no contention) will result in NO
- * jumps for both down() and up().
  */
 static inline void up(struct semaphore * sem)
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
 		LOCK_PREFIX "incl %0\n\t"     /* ++sem->count */
-		"jle 2f\n"
-		"1:\n"
-		LOCK_SECTION_START("")
-		"2:\tlea %0,%%eax\n\t"
-		"call __up_wakeup\n\t"
-		"jmp 1b\n"
-		LOCK_SECTION_END
-		".subsection 0\n"
+		"jg 1f\n\t"
+		"lea %0,%%eax\n\t"
+		"call __up_wakeup\n"
+		"1:"
 		:"+m" (sem->count)
 		:
 		:"memory","ax");
