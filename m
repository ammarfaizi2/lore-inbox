Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282502AbRLWWup>; Sun, 23 Dec 2001 17:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282805AbRLWWug>; Sun, 23 Dec 2001 17:50:36 -0500
Received: from d-dialin-2256.addcom.de ([62.96.168.96]:17648 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282502AbRLWWuY>; Sun, 23 Dec 2001 17:50:24 -0500
Date: Sun, 23 Dec 2001 23:50:22 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How to fix false positives on references to discarded text/data?
In-Reply-To: <Pine.LNX.4.33.0112232255500.1676-100000@vaio>
Message-ID: <Pine.LNX.4.33.0112232343180.1676-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Kai Germaschewski wrote:

> But I think, I found a solution: Don't use .text.lock for the out-of-line 
> code, use .text 1 (subsection 1) instead. This will put the out-of-line 
> code out of line, but into the same section - case solved ;-)

So here's the patch (i386 only). Appears to work.

diff -X excl -urN linux-2.5.2-pre1.patches/arch/i386/vmlinux.lds linux-2.5.2-pre1.work/arch/i386/vmlinux.lds
--- linux-2.5.2-pre1.patches/arch/i386/vmlinux.lds	Mon Jul  2 23:40:14 2001
+++ linux-2.5.2-pre1.work/arch/i386/vmlinux.lds	Sun Dec 23 23:41:51 2001
@@ -13,7 +13,6 @@
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
-  .text.lock : { *(.text.lock) }	/* out-of-line lock text */
 
   _etext = .;			/* End of text section */
 
diff -X excl -urN linux-2.5.2-pre1.patches/include/asm-i386/rwlock.h linux-2.5.2-pre1.work/include/asm-i386/rwlock.h
--- linux-2.5.2-pre1.patches/include/asm-i386/rwlock.h	Fri Sep 22 23:07:43 2000
+++ linux-2.5.2-pre1.work/include/asm-i386/rwlock.h	Sun Dec 23 23:08:22 2001
@@ -24,7 +24,7 @@
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
 		     ".previous" \
@@ -34,7 +34,7 @@
 	asm volatile(LOCK "subl $1,%0\n\t" \
 		     "js 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
@@ -54,7 +54,7 @@
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
 		     "2:\tcall " helper "\n\t" \
 		     "jmp 1b\n" \
 		     ".previous" \
@@ -64,7 +64,7 @@
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
-		     ".section .text.lock,\"ax\"\n" \
+		     ".subsection 1\n" \
 		     "2:\tpushl %%eax\n\t" \
 		     "leal %0,%%eax\n\t" \
 		     "call " helper "\n\t" \
diff -X excl -urN linux-2.5.2-pre1.patches/include/asm-i386/rwsem.h linux-2.5.2-pre1.work/include/asm-i386/rwsem.h
--- linux-2.5.2-pre1.patches/include/asm-i386/rwsem.h	Sun Dec 23 23:03:21 2001
+++ linux-2.5.2-pre1.work/include/asm-i386/rwsem.h	Sun Dec 23 23:39:05 2001
@@ -101,7 +101,7 @@
 LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  pushl     %%edx\n\t"
@@ -130,7 +130,7 @@
 		"  testl     %0,%0\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\n\t"
 		"  pushl     %%ecx\n\t"
 		"  call      rwsem_down_write_failed\n\t"
@@ -154,7 +154,7 @@
 LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* do nothing if still outstanding active readers */
 		"  jnz       1b\n\t"
@@ -180,7 +180,7 @@
 LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\n\t"
 		"  decw      %%dx\n\t" /* did the active count reduce to 0? */
 		"  jnz       1b\n\t" /* jump back if not */
diff -X excl -urN linux-2.5.2-pre1.patches/include/asm-i386/semaphore.h linux-2.5.2-pre1.work/include/asm-i386/semaphore.h
--- linux-2.5.2-pre1.patches/include/asm-i386/semaphore.h	Sun Dec 23 23:03:21 2001
+++ linux-2.5.2-pre1.work/include/asm-i386/semaphore.h	Sun Dec 23 23:39:05 2001
@@ -122,7 +122,7 @@
 		LOCK "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\tcall __down_failed\n\t"
 		"jmp 1b\n"
 		".previous"
@@ -149,7 +149,7 @@
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\tcall __down_failed_interruptible\n\t"
 		"jmp 1b\n"
 		".previous"
@@ -177,7 +177,7 @@
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\tcall __down_failed_trylock\n\t"
 		"jmp 1b\n"
 		".previous"
@@ -203,7 +203,7 @@
 		LOCK "incl %0\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
-		".section .text.lock,\"ax\"\n"
+		".subsection 1\n"
 		"2:\tcall __up_wakeup\n\t"
 		"jmp 1b\n"
 		".previous"
diff -X excl -urN linux-2.5.2-pre1.patches/include/asm-i386/softirq.h linux-2.5.2-pre1.work/include/asm-i386/softirq.h
--- linux-2.5.2-pre1.patches/include/asm-i386/softirq.h	Sun Dec 23 23:03:22 2001
+++ linux-2.5.2-pre1.work/include/asm-i386/softirq.h	Sun Dec 23 23:39:05 2001
@@ -33,7 +33,7 @@
 			"jnz 2f;"					\
 			"1:;"						\
 									\
-			".section .text.lock,\"ax\";"			\
+			".subsection 1;"			\
 			"2: pushl %%eax; pushl %%ecx; pushl %%edx;"	\
 			"call %c1;"					\
 			"popl %%edx; popl %%ecx; popl %%eax;"		\
diff -X excl -urN linux-2.5.2-pre1.patches/include/asm-i386/spinlock.h linux-2.5.2-pre1.work/include/asm-i386/spinlock.h
--- linux-2.5.2-pre1.patches/include/asm-i386/spinlock.h	Thu Dec 20 23:36:25 2001
+++ linux-2.5.2-pre1.work/include/asm-i386/spinlock.h	Sun Dec 23 23:39:04 2001
@@ -56,7 +56,7 @@
 	"\n1:\t" \
 	"lock ; decb %0\n\t" \
 	"js 2f\n" \
-	".section .text.lock,\"ax\"\n" \
+	".subsection 1\n" \
 	"2:\t" \
 	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \

