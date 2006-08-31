Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWHaILw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWHaILw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 04:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHaILw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 04:11:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:28653 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751229AbWHaILv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 04:11:51 -0400
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] i386: rwlock.h fix smp alternatives fix
Date: Thu, 31 Aug 2006 10:11:45 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20060831075322.GA20873@sequoia.sous-sol.org>
In-Reply-To: <20060831075322.GA20873@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311011.45844.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 09:53, Chris Wright wrote:
> This last patch smp alternatives code did not actually compile on
> x86 with CONFIG_SMP.  This fixes the __build_read/write_lock helpers.
> I've boot tested on SMP.

Oops, I think that was a quilt unrefreshed patch. Sorry. I fixed
those before testing, but then still send out the old patch.

-Andi

Here's the patch as intended for reference :/ Or Chris' incremental
is fine.

i386: Remove alternative_smp

The .fill causes miscompilations with some binutils version.

Instead just patch the lock prefix in the lock constructs. That is the
majority of the cost and should be good enough.

Cc: kraxel@suse.de

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-i386/alternative.h |   20 --------------------
 include/asm-i386/rwlock.h      |   14 ++++++--------
 include/asm-i386/spinlock.h    |   19 ++++++-------------
 3 files changed, 12 insertions(+), 41 deletions(-)

Index: linux/include/asm-i386/alternative.h
===================================================================
--- linux.orig/include/asm-i386/alternative.h
+++ linux/include/asm-i386/alternative.h
@@ -88,9 +88,6 @@ static inline void alternatives_smp_swit
 /*
  * Alternative inline assembly for SMP.
  *
- * alternative_smp() takes two versions (SMP first, UP second) and is
- * for more complex stuff such as spinlocks.
- *
  * The LOCK_PREFIX macro defined here replaces the LOCK and
  * LOCK_PREFIX macros used everywhere in the source tree.
  *
@@ -110,21 +107,6 @@ static inline void alternatives_smp_swit
  */
 
 #ifdef CONFIG_SMP
-#define alternative_smp(smpinstr, upinstr, args...)			\
-	asm volatile ("661:\n\t" smpinstr "\n662:\n" 			\
-		      ".section .smp_altinstructions,\"a\"\n"		\
-		      "  .align 4\n"					\
-		      "  .long 661b\n"            /* label */		\
-		      "  .long 663f\n"		  /* new instruction */	\
-		      "  .byte " __stringify(X86_FEATURE_UP) "\n"	\
-		      "  .byte 662b-661b\n"       /* sourcelen */	\
-		      "  .byte 664f-663f\n"       /* replacementlen */	\
-		      ".previous\n"					\
-		      ".section .smp_altinstr_replacement,\"awx\"\n"   	\
-		      "663:\n\t" upinstr "\n"     /* replacement */	\
-		      "664:\n\t.fill 662b-661b,1,0x42\n" /* space for original */ \
-		      ".previous" : args)
-
 #define LOCK_PREFIX \
 		".section .smp_locks,\"a\"\n"	\
 		"  .align 4\n"			\
@@ -133,8 +115,6 @@ static inline void alternatives_smp_swit
 	       	"661:\n\tlock; "
 
 #else /* ! CONFIG_SMP */
-#define alternative_smp(smpinstr, upinstr, args...) \
-	asm volatile (upinstr : args)
 #define LOCK_PREFIX ""
 #endif
 
Index: linux/include/asm-i386/rwlock.h
===================================================================
--- linux.orig/include/asm-i386/rwlock.h
+++ linux/include/asm-i386/rwlock.h
@@ -21,19 +21,17 @@
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
 #define __build_read_lock(rw, helper)   \
-	alternative_smp("lock; subl $1,(%0)\n\t" \
+	asm volatile(LOCK_PREFIX " ; subl $1,(%0)\n\t" \
 			"jns 1f\n" \
 			"call " helper "\n\t" \
-			"1:\n", \
-			"subl $1,(%0)\n\t", \
-			:"a" (rw) : "memory")
+			"1:\n" \
+			::"a" (rw) : "memory")
 
 #define __build_write_lock(rw, helper) \
-	alternative_smp("lock; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 			"jz 1f\n" \
 			"call " helper "\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",(%0)\n\t", \
-			:"a" (rw) : "memory")
+			"1:\n" \
+			::"a" (rw) : "memory")
 
 #endif
Index: linux/include/asm-i386/spinlock.h
===================================================================
--- linux.orig/include/asm-i386/spinlock.h
+++ linux/include/asm-i386/spinlock.h
@@ -22,7 +22,7 @@
 
 #define __raw_spin_lock_string \
 	"\n1:\t" \
-	"lock ; decb %0\n\t" \
+	LOCK_PREFIX " ; decb %0\n\t" \
 	"jns 3f\n" \
 	"2:\t" \
 	"rep;nop\n\t" \
@@ -38,7 +38,7 @@
  */
 #define __raw_spin_lock_string_flags \
 	"\n1:\t" \
-	"lock ; decb %0\n\t" \
+	LOCK_PREFIX " ; decb %0\n\t" \
 	"jns 5f\n" \
 	"2:\t" \
 	"testl $0x200, %1\n\t" \
@@ -57,15 +57,9 @@
 	"jmp 4b\n" \
 	"5:\n\t"
 
-#define __raw_spin_lock_string_up \
-	"\n\tdecb %0"
-
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-	alternative_smp(
-		__raw_spin_lock_string,
-		__raw_spin_lock_string_up,
-		"+m" (lock->slock) : : "memory");
+	asm volatile(__raw_spin_lock_string : "+m" (lock->slock) : : "memory");
 }
 
 /*
@@ -76,10 +70,9 @@ static inline void __raw_spin_lock(raw_s
 #ifndef CONFIG_PROVE_LOCKING
 static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
-	alternative_smp(
-		__raw_spin_lock_string_flags,
-		__raw_spin_lock_string_up,
-		"+m" (lock->slock) : "r" (flags) : "memory");
+	asm volatile(
+		__raw_spin_lock_string_flags
+		: "+m" (lock->slock) : "r" (flags) : "memory");
 }
 #endif
 



