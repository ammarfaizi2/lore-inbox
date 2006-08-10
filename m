Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWHJUVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWHJUVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWHJUPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:42 -0400
Received: from ns1.suse.de ([195.135.220.2]:28816 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932537AbWHJTfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:55 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [39/145] x86_64: Clean up read write lock assembly
Message-Id: <20060810193553.47E3C13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:53 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

- Move the slow path fallbacks to their own assembly files
This makes them much easier to read and is needed for the next change.
- Add CFI annotations for unwinding (XXX need review)
- Remove constant case which can never happen with out of line spinlocks
- Use patchable LOCK prefixes
- Don't use lock sections anymore for inline code because they can't
be expressed by the unwinder (this adds one taken jump to the lock
fast path)

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/lib/Makefile      |    2 -
 arch/x86_64/lib/rwlock.S      |   38 +++++++++++++++++++++++
 arch/x86_64/lib/thunk.S       |   30 ------------------
 include/asm-x86_64/rwlock.h   |   67 +++++-------------------------------------
 include/asm-x86_64/spinlock.h |   11 +-----
 5 files changed, 50 insertions(+), 98 deletions(-)

Index: linux/arch/x86_64/lib/rwlock.S
===================================================================
--- /dev/null
+++ linux/arch/x86_64/lib/rwlock.S
@@ -0,0 +1,38 @@
+/* Slow paths of read/write spinlocks. */
+
+#include <linux/linkage.h>
+#include <asm/rwlock.h>
+#include <asm/alternative-asm.i>
+#include <asm/dwarf2.h>
+
+/* rdi:	pointer to rwlock_t */
+ENTRY(__write_lock_failed)
+	CFI_STARTPROC
+	LOCK_PREFIX
+	addl $RW_LOCK_BIAS,(%rdi)
+1:	rep
+	nop
+	cmpl $RW_LOCK_BIAS,(%rdi)
+	jne 1b
+	LOCK_PREFIX
+	subl $RW_LOCK_BIAS,(%rdi)
+	jnz  __write_lock_failed
+	ret
+	CFI_ENDPROC
+END(__write_lock_failed)
+
+/* rdi:	pointer to rwlock_t */
+ENTRY(__read_lock_failed)
+	CFI_STARTPROC
+	LOCK_PREFIX
+	incl (%rdi)
+1:	rep
+	nop
+	cmpl $1,(%rdi)
+	js 1b
+	LOCK_PREFIX
+	decl (%rdi)
+	js __read_lock_failed
+	ret
+	CFI_ENDPROC
+END(__read_lock_failed)
Index: linux/arch/x86_64/lib/thunk.S
===================================================================
--- linux.orig/arch/x86_64/lib/thunk.S
+++ linux/arch/x86_64/lib/thunk.S
@@ -67,33 +67,3 @@ restore_norax:	
 	RESTORE_ARGS 1
 	ret
 	CFI_ENDPROC
-
-#ifdef CONFIG_SMP
-/* Support for read/write spinlocks. */
-	.text
-/* rax:	pointer to rwlock_t */	
-ENTRY(__write_lock_failed)
-	lock
-	addl $RW_LOCK_BIAS,(%rax)
-1:	rep
-	nop
-	cmpl $RW_LOCK_BIAS,(%rax)
-	jne 1b
-	lock 
-	subl $RW_LOCK_BIAS,(%rax)
-	jnz  __write_lock_failed
-	ret
-
-/* rax:	pointer to rwlock_t */	
-ENTRY(__read_lock_failed)
-	lock
-	incl (%rax)
-1:	rep
-	nop
-	cmpl $1,(%rax)
-	js 1b
-	lock
-	decl (%rax)
-	js __read_lock_failed
-	ret
-#endif
Index: linux/include/asm-x86_64/rwlock.h
===================================================================
--- linux.orig/include/asm-x86_64/rwlock.h
+++ linux/include/asm-x86_64/rwlock.h
@@ -18,69 +18,20 @@
 #ifndef _ASM_X86_64_RWLOCK_H
 #define _ASM_X86_64_RWLOCK_H
 
-#include <linux/stringify.h>
-
 #define RW_LOCK_BIAS		 0x01000000
-#define RW_LOCK_BIAS_STR	"0x01000000"
 
-#define __build_read_lock_ptr(rw, helper)   \
+#define __build_read_lock(rw)   \
 	asm volatile(LOCK_PREFIX "subl $1,(%0)\n\t" \
-		     "js 2f\n" \
-		     "1:\n" \
-		    LOCK_SECTION_START("") \
-		     "2:\tcall " helper "\n\t" \
-		     "jmp 1b\n" \
-		    LOCK_SECTION_END \
-		     ::"a" (rw) : "memory")
-
-#define __build_read_lock_const(rw, helper)   \
-	asm volatile(LOCK_PREFIX "subl $1,%0\n\t" \
-		     "js 2f\n" \
+		     "jns 1f\n" \
+		     "call __read_lock_failed\n" \
 		     "1:\n" \
-		    LOCK_SECTION_START("") \
-		     "2:\tpushq %%rax\n\t" \
-		     "leaq %0,%%rax\n\t" \
-		     "call " helper "\n\t" \
-		     "popq %%rax\n\t" \
-		     "jmp 1b\n" \
-		    LOCK_SECTION_END \
-		     :"=m" (*((volatile int *)rw))::"memory")
-
-#define __build_read_lock(rw, helper)	do { \
-						if (__builtin_constant_p(rw)) \
-							__build_read_lock_const(rw, helper); \
-						else \
-							__build_read_lock_ptr(rw, helper); \
-					} while (0)
+		     ::"D" (rw), "i" (RW_LOCK_BIAS) : "memory")
 
-#define __build_write_lock_ptr(rw, helper) \
-	asm volatile(LOCK_PREFIX "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
-		     "jnz 2f\n" \
+#define __build_write_lock(rw) \
+	asm volatile(LOCK_PREFIX "subl %1,(%0)\n\t" \
+		     "jz 1f\n" \
+		     "\tcall __write_lock_failed\n\t" \
 		     "1:\n" \
-		     LOCK_SECTION_START("") \
-		     "2:\tcall " helper "\n\t" \
-		     "jmp 1b\n" \
-		     LOCK_SECTION_END \
-		     ::"a" (rw) : "memory")
-
-#define __build_write_lock_const(rw, helper) \
-	asm volatile(LOCK_PREFIX "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
-		     "jnz 2f\n" \
-		     "1:\n" \
-		    LOCK_SECTION_START("") \
-		     "2:\tpushq %%rax\n\t" \
-		     "leaq %0,%%rax\n\t" \
-		     "call " helper "\n\t" \
-		     "popq %%rax\n\t" \
-		     "jmp 1b\n" \
-		    LOCK_SECTION_END \
-		     :"=m" (*((volatile long *)rw))::"memory")
-
-#define __build_write_lock(rw, helper)	do { \
-						if (__builtin_constant_p(rw)) \
-							__build_write_lock_const(rw, helper); \
-						else \
-							__build_write_lock_ptr(rw, helper); \
-					} while (0)
+		     ::"D" (rw), "i" (RW_LOCK_BIAS) : "memory")
 
 #endif
Index: linux/include/asm-x86_64/spinlock.h
===================================================================
--- linux.orig/include/asm-x86_64/spinlock.h
+++ linux/include/asm-x86_64/spinlock.h
@@ -82,13 +82,6 @@ static inline void __raw_spin_unlock(raw
  *
  * On x86, we implement read-write locks as a 32-bit counter
  * with the high bit (sign) being the "contended" bit.
- *
- * The inline assembly is non-obvious. Think about it.
- *
- * Changed to use the same technique as rw semaphores.  See
- * semaphore.h for details.  -ben
- *
- * the helpers are in arch/i386/kernel/semaphore.c
  */
 
 #define __raw_read_can_lock(x)		((int)(x)->lock > 0)
@@ -96,12 +89,12 @@ static inline void __raw_spin_unlock(raw
 
 static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
-	__build_read_lock(rw, "__read_lock_failed");
+	__build_read_lock(rw);
 }
 
 static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
-	__build_write_lock(rw, "__write_lock_failed");
+	__build_write_lock(rw);
 }
 
 static inline int __raw_read_trylock(raw_rwlock_t *lock)
Index: linux/arch/x86_64/lib/Makefile
===================================================================
--- linux.orig/arch/x86_64/lib/Makefile
+++ linux/arch/x86_64/lib/Makefile
@@ -9,4 +9,4 @@ obj-y := io.o iomap_copy.o
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
 	thunk.o clear_page.o copy_page.o bitstr.o bitops.o
-lib-y += memcpy.o memmove.o memset.o copy_user.o
+lib-y += memcpy.o memmove.o memset.o copy_user.o rwlock.o
