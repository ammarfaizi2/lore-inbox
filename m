Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDHI0v>; Sun, 8 Apr 2001 04:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDHI0l>; Sun, 8 Apr 2001 04:26:41 -0400
Received: from colorfullife.com ([216.156.138.34]:34318 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132520AbRDHI0W>;
	Sun, 8 Apr 2001 04:26:22 -0400
Message-ID: <3ACF7B95.DB4FF928@colorfullife.com>
Date: Sat, 07 Apr 2001 22:41:57 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-0.1.9smp i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rep nop question
Content-Type: multipart/mixed;
 boundary="------------084D0176503690352E3567E2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------084D0176503690352E3567E2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The Intel documentation recommends that spinlocks should use

loop:
	rep;nop;
	cmp $0,lock_var
	jne loop

ftp://download.intel.com/design/perftool/cbts/appnotes/sse2/w_spinlock.pdf

but the linux spinlock implementation uses

loop:
	cmp $0, lock_var
	rep; nop;
	jne loop.

Why?
According to the Intel documentation, rep nop is a predefined delay that
slows down the cpu to the speed of the memory bus. The linux
implementation will delay again _after_ the lock was released.

What about the attached patch? It also adds 'rep;nop' into the rw
spinlock implementation.

It boots with my Pentium III, but the cpu doesn't support 'rep nop'
(i.e. returns immediately)

--
	Manfred
--------------084D0176503690352E3567E2
Content-Type: text/plain; charset=us-ascii;
 name="patch-rep-nop"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rep-nop"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 3
//  EXTRAVERSION = -ac3
--- 2.4/arch/i386/kernel/semaphore.c	Sun Nov 19 02:31:25 2000
+++ build-2.4/arch/i386/kernel/semaphore.c	Sat Apr  7 21:26:35 2001
@@ -430,7 +430,8 @@
 .globl	__write_lock_failed
 __write_lock_failed:
 	" LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)
-1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)
+1:	rep; nop
+	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)
 	jne	1b
 
 	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
@@ -442,7 +443,8 @@
 .globl	__read_lock_failed
 __read_lock_failed:
 	lock ; incl	(%eax)
-1:	cmpl	$1,(%eax)
+1:	rep; nop
+	cmpl	$1,(%eax)
 	js	1b
 
 	lock ; decl	(%eax)
--- 2.4/include/asm-i386/spinlock.h	Sat Apr  7 22:02:23 2001
+++ build-2.4/include/asm-i386/spinlock.h	Sat Apr  7 22:01:43 2001
@@ -58,10 +58,10 @@
 	"js 2f\n" \
 	".section .text.lock,\"ax\"\n" \
 	"2:\t" \
-	"cmpb $0,%0\n\t" \
 	"rep;nop\n\t" \
-	"jle 2b\n\t" \
-	"jmp 1b\n" \
+	"cmpb $0,%0\n\t" \
+	"jg 1b\n\t" \
+	"jmp 2b\n" \
 	".previous"
 
 /*

--------------084D0176503690352E3567E2--


