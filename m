Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbSK2XdT>; Fri, 29 Nov 2002 18:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbSK2XdT>; Fri, 29 Nov 2002 18:33:19 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:15752 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S267184AbSK2XdS>;
	Fri, 29 Nov 2002 18:33:18 -0500
Date: Sat, 30 Nov 2002 00:40:35 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Save 8 bytes in __{read,write}_lock_failed...
Message-ID: <20021129234035.GA22666@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   recent bugreport from Chris Rankin pointed out to me
that last jump in both __read_lock_failed and __write_lock_failed
uses 4 byte offset, although 1 byte is enough. It happens
because of __write_lock_failed is .globl, and so gas emits
4 byte offset + R_386_PC32 relocation (should it? I always thought
that only .weak symbols may be overwritten from other file).

   Simple patch below makes SMP kernel 8 bytes shorter.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/arch/i386/kernel/semaphore.c linux/arch/i386/kernel/semaphore.c
--- linux/arch/i386/kernel/semaphore.c	2002-11-26 19:55:59.000000000 +0000
+++ linux/arch/i386/kernel/semaphore.c	2002-11-29 23:24:50.000000000 +0000
@@ -275,12 +275,13 @@
 ".align	4\n"
 ".globl	__write_lock_failed\n"
 "__write_lock_failed:\n\t"
+"0:\n\t"
 	LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
 "1:	rep; nop\n\t"
 	"cmpl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
 	"jne	1b\n\t"
 	LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
-	"jnz	__write_lock_failed\n\t"
+	"jnz	0b\n\t"
 	"ret"
 );
 
@@ -289,12 +290,13 @@
 ".align	4\n"
 ".globl	__read_lock_failed\n"
 "__read_lock_failed:\n\t"
+"0:\n\t"
 	LOCK "incl	(%eax)\n"
 "1:	rep; nop\n\t"
 	"cmpl	$1,(%eax)\n\t"
 	"js	1b\n\t"
 	LOCK "decl	(%eax)\n\t"
-	"js	__read_lock_failed\n\t"
+	"js	0b\n\t"
 	"ret"
 );
 #endif
