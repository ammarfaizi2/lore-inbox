Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUEQS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUEQS3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEQS3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:29:20 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:29993 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262100AbUEQS2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:28:41 -0400
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org
Subject: memcpy_to/fromio cleanups for x86_64
References: <52lljrwvhq.fsf@topspin.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 17 May 2004 11:28:37 -0700
In-Reply-To: <52lljrwvhq.fsf@topspin.com>
Message-ID: <5265auvrfu.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 May 2004 18:28:37.0819 (UTC) FILETIME=[C53F70B0:01C43C3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My query about the types of the parameters for memcpy_toio and
memcpy_fromio was met with silence.  Maybe some code can speak a
little louder.

Here is a patch for x86_64 that brings memcpy_toio and memcpy_fromio
more into line with other architectures (my approach is based on what
ia64 does), and cleans things up a little.

First of all, it makes the IO address parameter an unsigned long, so
that code that treats IO addresses as unsigned long does not get
warnings like

warning: passing arg 1 of `memcpy_toio' makes pointer from integer without a cast

Second, I moved the EXPORT_SYMBOL directly into io.c (shrinking
x8664_ksyms.c by a few lines).  This means that io.o should be moved
from lib-y to obj-y, since otherwise __memcpy_toio and __memcpy_fromio
might not be included in the kernel.

Comments?  Look good?  Does anyone care :)?

Thanks,
  Roland

Index: linux-2.6.6/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.6.orig/arch/x86_64/kernel/x8664_ksyms.c	2004-05-09 19:32:01.000000000 -0700
+++ linux-2.6.6/arch/x86_64/kernel/x8664_ksyms.c	2004-05-17 10:33:54.000000000 -0700
@@ -216,6 +216,3 @@
 #endif
 
 EXPORT_SYMBOL(sys_ioctl);
-
-EXPORT_SYMBOL(memcpy_toio);
-EXPORT_SYMBOL(memcpy_fromio);
Index: linux-2.6.6/arch/x86_64/lib/Makefile
===================================================================
--- linux-2.6.6.orig/arch/x86_64/lib/Makefile	2004-05-09 19:32:01.000000000 -0700
+++ linux-2.6.6/arch/x86_64/lib/Makefile	2004-05-17 11:17:09.000000000 -0700
@@ -4,9 +4,11 @@
 
 CFLAGS_csum-partial.o := -funroll-loops
 
+obj-y := io.o
+
 lib-y := csum-partial.o csum-copy.o csum-wrappers.o delay.o \
 	usercopy.o getuser.o putuser.o  \
-	thunk.o io.o clear_page.o copy_page.o bitstr.o
+	thunk.o clear_page.o copy_page.o bitstr.o
 lib-y += memcpy.o memmove.o memset.o copy_user.o
 
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
Index: linux-2.6.6/arch/x86_64/lib/io.c
===================================================================
--- linux-2.6.6.orig/arch/x86_64/lib/io.c	2004-05-09 19:31:59.000000000 -0700
+++ linux-2.6.6/arch/x86_64/lib/io.c	2004-05-17 10:44:08.000000000 -0700
@@ -2,12 +2,14 @@
 #include <asm/io.h>
 #include <linux/module.h>
 
-void *memcpy_toio(void *dst,const void*src,unsigned len)
+void *__memcpy_toio(unsigned long dst,const void*src,unsigned len)
 {
-	return __inline_memcpy(dst,src,len);
+	return __inline_memcpy((void *) dst,src,len);
 }
+EXPORT_SYMBOL(__memcpy_toio);
 
-void *memcpy_fromio(void *dst,const void*src,unsigned len)
+void *__memcpy_fromio(void *dst,unsigned long src,unsigned len)
 {
-	return __inline_memcpy(dst,src,len);
+	return __inline_memcpy(dst,(const void *) src,len);
 }
+EXPORT_SYMBOL(__memcpy_fromio);
Index: linux-2.6.6/include/asm-x86_64/io.h
===================================================================
--- linux-2.6.6.orig/include/asm-x86_64/io.h	2004-05-09 19:32:28.000000000 -0700
+++ linux-2.6.6/include/asm-x86_64/io.h	2004-05-17 10:35:03.000000000 -0700
@@ -195,8 +195,13 @@
 #define __raw_writel writel
 #define __raw_writeq writeq
 
-void *memcpy_fromio(void*,const void*,unsigned); 
-void *memcpy_toio(void*,const void*,unsigned); 
+void *__memcpy_fromio(void*,unsigned long,unsigned);
+void *__memcpy_toio(unsigned long,const void*,unsigned);
+
+#define memcpy_fromio(to,from,len) \
+  __memcpy_fromio((to),(unsigned long)(from),(len))
+#define memcpy_toio(to,from,len) \
+  __memcpy_toio((unsigned long)(to),(from),(len))
 #define memset_io(a,b,c)	memset((void *)(a),(b),(c))
 
 /*
