Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRJYXhy>; Thu, 25 Oct 2001 19:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276670AbRJYXhp>; Thu, 25 Oct 2001 19:37:45 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:3968 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S276646AbRJYXhh>; Thu, 25 Oct 2001 19:37:37 -0400
Date: Thu, 25 Oct 2001 16:37:12 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: LKML <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>
Subject: [PATCH] 2.4.{12-ac6,13} Yet another multi-line strings patch
Message-ID: <Pine.LNX.4.33.0110251612180.1515-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

The following patch, based on a suggestion from Richard Henderson, removes
several multi-line strings from the kernel source.  This pacifies gcc
3.0.x while maintaining readability.  FWIW, someone on LKML said it is
required by C99.  The patch applies cleanly to 2.4.13 and 2.4.12-ac6 and
should apply cleanly to recent/near-future kernels.  It has been lightly
tested on 2.4.12-ac6.

Mostly it just appends tabs and \n\ to the end of each line in a mult-line
__asm__ string.  The principal exception is the i2c-core chunk--here it
looks like the multi-line string was an accident, as nearby printk()'s do
not have any newlines in their strings.  There is also one line in the
floppy.h chunk where I changed spaces to a tab for consistency with all
the other lines in the __asm__ string.

Please apply.

Best wishes,
Wayne

P.S.  If you like this __asm__ string format, then one could fairly easily
do a one-time mostly-automatic conversion to it.


diff -ru linux-2.4.13/arch/i386/kernel/semaphore.c linux-2.4.13-strings/arch/i386/kernel/semaphore.c
--- linux-2.4.13/arch/i386/kernel/semaphore.c	Thu Apr 12 12:22:53 2001
+++ linux-2.4.13-strings/arch/i386/kernel/semaphore.c	Thu Oct 25 14:31:05 2001
@@ -238,29 +238,29 @@
  */
 #if defined(CONFIG_SMP)
 asm(
-"
-.align	4
-.globl	__write_lock_failed
-__write_lock_failed:
-	" LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)
-1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jne	1b
-
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jnz	__write_lock_failed
-	ret
-
-
-.align	4
-.globl	__read_lock_failed
-__read_lock_failed:
-	lock ; incl	(%eax)
-1:	cmpl	$1,(%eax)
-	js	1b
-
-	lock ; decl	(%eax)
-	js	__read_lock_failed
-	ret
+"							\n\
+.align	4						\n\
+.globl	__write_lock_failed				\n\
+__write_lock_failed:					\n\
+	" LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)	\n\
+1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)		\n\
+	jne	1b					\n\
+							\n\
+	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)	\n\
+	jnz	__write_lock_failed			\n\
+	ret						\n\
+							\n\
+							\n\
+.align	4						\n\
+.globl	__read_lock_failed				\n\
+__read_lock_failed:					\n\
+	lock ; incl	(%eax)				\n\
+1:	cmpl	$1,(%eax)				\n\
+	js	1b					\n\
+							\n\
+	lock ; decl	(%eax)				\n\
+	js	__read_lock_failed			\n\
+	ret						\n\
 "
 );
 #endif
diff -ru linux-2.4.13/drivers/i2c/i2c-core.c linux-2.4.13-strings/drivers/i2c/i2c-core.c
--- linux-2.4.13/drivers/i2c/i2c-core.c	Thu Oct 25 14:25:47 2001
+++ linux-2.4.13-strings/drivers/i2c/i2c-core.c	Thu Oct 25 14:33:56 2001
@@ -381,10 +381,10 @@
 						printk("i2c-core.o: while "
 						       "unregistering driver "
 						       "`%s', the client at "
-						       "address %02x of
-						       adapter `%s' could not
-						       be detached; driver
-						       not unloaded!",
+						       "address %02x of "
+						       "adapter `%s' could not "
+						       "be detached; driver "
+						       "not unloaded!",
 						       driver->name,
 						       client->addr,
 						       adap->name);
diff -ru linux-2.4.13/include/asm-i386/checksum.h linux-2.4.13-strings/include/asm-i386/checksum.h
--- linux-2.4.13/include/asm-i386/checksum.h	Thu Oct 25 14:03:21 2001
+++ linux-2.4.13-strings/include/asm-i386/checksum.h	Thu Oct 25 14:26:44 2001
@@ -69,24 +69,24 @@
 					  unsigned int ihl) {
 	unsigned int sum;
 
-	__asm__ __volatile__("
-	    movl (%1), %0
-	    subl $4, %2
-	    jbe 2f
-	    addl 4(%1), %0
-	    adcl 8(%1), %0
-	    adcl 12(%1), %0
-1:	    adcl 16(%1), %0
-	    lea 4(%1), %1
-	    decl %2
-	    jne	1b
-	    adcl $0, %0
-	    movl %0, %2
-	    shrl $16, %0
-	    addw %w2, %w0
-	    adcl $0, %0
-	    notl %0
-2:
+	__asm__ __volatile__("	\n\
+	    movl (%1), %0	\n\
+	    subl $4, %2		\n\
+	    jbe 2f		\n\
+	    addl 4(%1), %0	\n\
+	    adcl 8(%1), %0	\n\
+	    adcl 12(%1), %0	\n\
+1:	    adcl 16(%1), %0	\n\
+	    lea 4(%1), %1	\n\
+	    decl %2		\n\
+	    jne	1b		\n\
+	    adcl $0, %0		\n\
+	    movl %0, %2		\n\
+	    shrl $16, %0	\n\
+	    addw %w2, %w0	\n\
+	    adcl $0, %0		\n\
+	    notl %0		\n\
+2:				\n\
 	    "
 	/* Since the input registers which are loaded with iph and ipl
 	   are modified, we must also specify them as outputs, or gcc
@@ -102,9 +102,9 @@
 
 static inline unsigned int csum_fold(unsigned int sum)
 {
-	__asm__("
-		addl %1, %0
-		adcl $0xffff, %0
+	__asm__("			\n\
+		addl %1, %0		\n\
+		adcl $0xffff, %0	\n\
 		"
 		: "=r" (sum)
 		: "r" (sum << 16), "0" (sum & 0xffff0000)
@@ -118,11 +118,11 @@
 						   unsigned short proto,
 						   unsigned int sum) 
 {
-    __asm__("
-	addl %1, %0
-	adcl %2, %0
-	adcl %3, %0
-	adcl $0, %0
+    __asm__("		\n\
+	addl %1, %0	\n\
+	adcl %2, %0	\n\
+	adcl %3, %0	\n\
+	adcl $0, %0	\n\
 	"
 	: "=r" (sum)
 	: "g" (daddr), "g"(saddr), "g"((ntohs(len)<<16)+proto*256), "0"(sum));
@@ -158,18 +158,18 @@
 						     unsigned short proto,
 						     unsigned int sum) 
 {
-	__asm__("
-		addl 0(%1), %0
-		adcl 4(%1), %0
-		adcl 8(%1), %0
-		adcl 12(%1), %0
-		adcl 0(%2), %0
-		adcl 4(%2), %0
-		adcl 8(%2), %0
-		adcl 12(%2), %0
-		adcl %3, %0
-		adcl %4, %0
-		adcl $0, %0
+	__asm__("			\n\
+		addl 0(%1), %0		\n\
+		adcl 4(%1), %0		\n\
+		adcl 8(%1), %0		\n\
+		adcl 12(%1), %0		\n\
+		adcl 0(%2), %0		\n\
+		adcl 4(%2), %0		\n\
+		adcl 8(%2), %0		\n\
+		adcl 12(%2), %0		\n\
+		adcl %3, %0		\n\
+		adcl %4, %0		\n\
+		adcl $0, %0		\n\
 		"
 		: "=&r" (sum)
 		: "r" (saddr), "r" (daddr), 
diff -ru linux-2.4.13/include/asm-i386/floppy.h linux-2.4.13-strings/include/asm-i386/floppy.h
--- linux-2.4.13/include/asm-i386/floppy.h	Sun Oct 14 12:45:06 2001
+++ linux-2.4.13-strings/include/asm-i386/floppy.h	Thu Oct 25 14:26:44 2001
@@ -75,27 +75,27 @@
 
 #ifndef NO_FLOPPY_ASSEMBLER
 	__asm__ (
-       "testl %1,%1
-	je 3f
-1:	inb %w4,%b0
-	andb $160,%b0
-	cmpb $160,%b0
-	jne 2f
-	incw %w4
-	testl %3,%3
-	jne 4f
-	inb %w4,%b0
-	movb %0,(%2)
-	jmp 5f
-4:     	movb (%2),%0
-	outb %b0,%w4
-5:	decw %w4
-	outb %0,$0x80
-	decl %1
-	incl %2
-	testl %1,%1
-	jne 1b
-3:	inb %w4,%b0
+       "testl %1,%1	\n\
+	je 3f		\n\
+1:	inb %w4,%b0	\n\
+	andb $160,%b0	\n\
+	cmpb $160,%b0	\n\
+	jne 2f		\n\
+	incw %w4	\n\
+	testl %3,%3	\n\
+	jne 4f		\n\
+	inb %w4,%b0	\n\
+	movb %0,(%2)	\n\
+	jmp 5f		\n\
+4:	movb (%2),%0	\n\
+	outb %b0,%w4	\n\
+5:	decw %w4	\n\
+	outb %0,$0x80	\n\
+	decl %1		\n\
+	incl %2		\n\
+	testl %1,%1	\n\
+	jne 1b		\n\
+3:	inb %w4,%b0	\n\
 2:	"
        : "=a" ((char) st), 
        "=c" ((long) virtual_dma_count), 

