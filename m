Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268176AbRGZQNp>; Thu, 26 Jul 2001 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbRGZQNf>; Thu, 26 Jul 2001 12:13:35 -0400
Received: from t2.redhat.com ([199.183.24.243]:5875 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S268176AbRGZQN0>; Thu, 26 Jul 2001 12:13:26 -0400
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
Cc: David Howells <dhowells@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.4.7] enabling RWSEM_DEBUG 
In-Reply-To: Message from "Brian J. Watson" <Brian.J.Watson@compaq.com> 
   of "Wed, 25 Jul 2001 10:56:41 PDT." <3B5F0859.94557FF5@compaq.com> 
Date: Thu, 26 Jul 2001 17:13:32 +0100
Message-ID: <1722.996164012@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


> Unfortunately, I ran into a bug with enabling RWSEM_DEBUG. The bug still
> exists in 2.4.7.

Could you try applying the attached patch, please.

David

_______________________________________________________________________________

diff -uNr linux-2.4.7/include/linux/rwsem.h linux-rwsem/include/linux/rwsem.h
--- linux-2.4.7/include/linux/rwsem.h	Mon Jul 23 08:19:21 2001
+++ linux-rwsem/include/linux/rwsem.h	Thu Jul 26 16:42:50 2001
@@ -9,7 +9,7 @@
 
 #include <linux/linkage.h>
 
-#define RWSEM_DEBUG 0
+#define RWSEM_DEBUG 1
 
 #ifdef __KERNEL__
 
@@ -27,11 +27,13 @@
 #include <asm/rwsem.h> /* use an arch-specific implementation */
 #endif
 
-#ifndef rwsemtrace
+#ifndef rwsemtrace_defined
+#define rwsemtrace_defined
 #if RWSEM_DEBUG
-extern void FASTCALL(rwsemtrace(struct rw_semaphore *sem, const char *str));
+extern void FASTCALL(__rwsemtrace(struct rw_semaphore *sem, const char *str));
+#define rwsemtrace(SEM,STR) __rwsemtrace(SEM,STR)
 #else
-#define rwsemtrace(SEM,FMT)
+#define rwsemtrace(SEM,STR)
 #endif
 #endif
 
diff -uNr linux-2.4.7/lib/rwsem-spinlock.c linux-rwsem/lib/rwsem-spinlock.c
--- linux-2.4.7/lib/rwsem-spinlock.c	Mon Jul 23 08:19:18 2001
+++ linux-rwsem/lib/rwsem-spinlock.c	Thu Jul 26 16:41:02 2001
@@ -18,7 +18,7 @@
 };
 
 #if RWSEM_DEBUG
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
+void __rwsemtrace(struct rw_semaphore *sem, const char *str)
 {
 	if (sem->debug)
 		printk("[%d] %s({%d,%d})\n",
@@ -235,5 +235,5 @@
 EXPORT_SYMBOL(__up_read);
 EXPORT_SYMBOL(__up_write);
 #if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
+EXPORT_SYMBOL(__rwsemtrace);
 #endif
diff -uNr linux-2.4.7/lib/rwsem.c linux-rwsem/lib/rwsem.c
--- linux-2.4.7/lib/rwsem.c	Mon Jul 23 08:21:25 2001
+++ linux-rwsem/lib/rwsem.c	Thu Jul 26 16:40:56 2001
@@ -16,8 +16,7 @@
 };
 
 #if RWSEM_DEBUG
-#undef rwsemtrace
-void rwsemtrace(struct rw_semaphore *sem, const char *str)
+void __rwsemtrace(struct rw_semaphore *sem, const char *str)
 {
 	printk("sem=%p\n",sem);
 	printk("(sem)=%08lx\n",sem->count);
@@ -206,5 +205,5 @@
 EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
 EXPORT_SYMBOL_NOVERS(rwsem_wake);
 #if RWSEM_DEBUG
-EXPORT_SYMBOL(rwsemtrace);
+EXPORT_SYMBOL(__rwsemtrace);
 #endif
