Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTBLNlU>; Wed, 12 Feb 2003 08:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBLNlH>; Wed, 12 Feb 2003 08:41:07 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:34432 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267178AbTBLNk1>; Wed, 12 Feb 2003 08:40:27 -0500
Date: Wed, 12 Feb 2003 22:49:08 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (16/34) video-update
Message-ID: <20030212134908.GQ1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (16/34).

Updates console driver for PC98 in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/drivers/video/console/gdccon.c linux98-2.5.52/drivers/video/console/gdccon.c
--- linux-2.5.50-ac1/drivers/video/console/gdccon.c	2002-12-17 09:07:11.000000000 +0900
+++ linux98-2.5.52/drivers/video/console/gdccon.c	2002-12-17 11:01:09.000000000 +0900
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/console.h>
-#include <linux/console_struct.h>
 #include <linux/string.h>
 #include <linux/kd.h>
 #include <linux/slab.h>
diff -Nru linux-2.5.50-ac1/include/asm-i386/gdc.h.old linux-2.5.50-ac1/include/asm-i386/gdc.h
--- linux-2.5.50-ac1/include/asm-i386/gdc.h	2002-12-11 13:10:08.000000000 +0900
+++ linux98-2.5.52/include/asm-i386/gdc.h	2002-12-11 17:26:46.000000000 +0900
@@ -55,26 +55,29 @@
 _scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
 #ifdef CONFIG_GDC_32BITACCESS
-	__asm__ __volatile__ ("shr%L1 %1
-	jz 2f
-" /*	cld	kernel code now assumes DF = 0 any time */ "\
-	test%L0 %3,%0
-	jz 1f
-	stos%W2
-	dec%L1 %1
-1:	shr%L1 %1
-	rep
-	stos%L2
-	jnc 2f
-	stos%W2
-	rep
-	stos%W2
-2:"
+	__asm__ __volatile__ (
+	"shr%L1 %1\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	kernel code now assumes DF = 0 any time */
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"stos%W2\n\t"
+	"dec%L1 %1\n"
+"1:	shr%L1 %1\n\t"
+	"rep\n\t"
+	"stos%L2\n\t"
+	"jnc 2f\n\t"
+	"stos%W2\n\t"
+	"rep\n\t"
+	"stos%W2\n"
+"2:"
 			      : "=D"(s), "=c"(count)
 			      : "a"((((u32) c) << 16) | c), "g"(2),
 			        "0"(s), "1"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tstosw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"stosw"
 			      : "=D"(s), "=c"(count)
 			      : "0"(s), "1"(count / 2), "a"(c));
 #endif	
@@ -92,23 +95,26 @@
 _scr_memcpyw(u16 *d, u16 *s, unsigned int count)
 {
 #if 1 /* def CONFIG_GDC_32BITACCESS */
-	__asm__ __volatile__ ("shr%L2 %2
-	jz 2f
-" /*	cld	*/ "\
-	test%L0 %3,%0
-	jz 1f
-	movs%W0
-	dec%L2 %2
-1:	shr%L2 %2
-	rep
-	movs%L0
-	jnc 2f
-	movs%W0
-2:"
+	__asm__ __volatile__ (
+	"shr%L2 %2\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	*/
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"movs%W0\n\t"
+	"dec%L2 %2\n"
+"1:	shr%L2 %2\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 2f\n\t"
+	"movs%W0\n"
+"2:"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "0"(d), "1"(s), "2"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tmovsw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"movsw"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"(d), "1"(s), "2"(count / 2));
 #endif
@@ -126,30 +132,35 @@
 #if 1 /* def CONFIG_GDC_32BITACCESS */
 	u16 tmp;
 
-	__asm__ __volatile__ ("shr%L3 %3
-	jz 2f
-	std
-	lea%L1 -4(%1,%3,2),%1
-	lea%L2 -4(%2,%3,2),%2
-	test%L1 %4,%1
-	jz 1f
-	mov%W0 2(%2),%0
-	sub%L2 %4,%2
-	dec%L3 %3
-	mov%W0 %0,2(%1)
-	sub%L1 %4,%1
-1:	shr%L3 %3
-	rep
-	movs%L0
-	jnc 3f
-	mov%W0 2(%2),%0
-	mov%W0 %0,2(%1)
-3:	cld
-2:"
+	__asm__ __volatile__ (
+	"shr%L3 %3\n\t"
+	"jz 2f\n\t"
+	"std\n\t"
+	"lea%L1 -4(%1,%3,2),%1\n\t"
+	"lea%L2 -4(%2,%3,2),%2\n\t"
+	"test%L1 %4,%1\n\t"
+	"jz 1f\n\t"
+	"mov%W0 2(%2),%0\n\t"
+	"sub%L2 %4,%2\n\t"
+	"dec%L3 %3\n\t"
+	"mov%W0 %0,2(%1)\n\t"
+	"sub%L1 %4,%1\n"
+"1:	shr%L3 %3\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 3f\n\t"
+	"mov%W0 2(%2),%0\n\t"
+	"mov%W0 %0,2(%1)\n"
+"3:	cld\n"
+"2:"
 			      : "=r"(tmp), "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "1"(d), "2"(s), "3"(count));
 #else
-	__asm__ __volatile__ ("std\n\trep\n\tmovsw\n\tcld"
+	__asm__ __volatile__ (
+	"std\n\t"
+	"rep\n\t"
+	"movsw\n\t"
+	"cld"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"((void *) d + count - 2),
 			        "1"((void *) s + count - 2), "2"(count / 2));
@@ -179,23 +190,26 @@
 #ifdef CONFIG_GDC_32BITACCESS
 	/* VRAM is quite slow, so we align source pointer (%esi)
 	   to double-word alignment. */
-	__asm__ __volatile__ ("shr%L2 %2
-	jz 2f
-" /*	cld	*/ "\
-	test%L0 %3,%0
-	jz 1f
-	movs%W0
-	dec%L2 %2
-1:	shr%L2 %2
-	rep
-	movs%L0
-	jnc 2f
-	movs%W0
-2:"
+	__asm__ __volatile__ (
+	"shr%L2 %2\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	*/
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"movs%W0\n\t"
+	"dec%L2 %2\n"
+"1:	shr%L2 %2\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 2f\n\t"
+	"movs%W0\n"
+"2:"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "0"(d), "1"(s), "2"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tmovsw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"movsw"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"(d), "1"(s), "2"(count / 2));
 #endif
