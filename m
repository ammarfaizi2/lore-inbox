Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSFOUAZ>; Sat, 15 Jun 2002 16:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSFOUAY>; Sat, 15 Jun 2002 16:00:24 -0400
Received: from slip-32-103-25-72.ca.us.prserv.net ([32.103.25.72]:18560 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315485AbSFOUAX>; Sat, 15 Jun 2002 16:00:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: put_user/get_user warnings for x86
Date: Sun, 16 Jun 2002 06:03:05 +1000
Message-Id: <E17JJmO-0004ln-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not *neccessarily wrong* to use put_user(int, long *), but it's
probably worth warning for:

Name: put_user/get_user extra checks (x86 only)
Author: Rusty Russell
Status: Trivial

D: This makes put_user and get_user warn if the type of the userspace ptr
D: and the kernel variable are incompatible, eg:
D:   int x;
D:   char *uptr;
D:   ...
D:   put_user(x,uptr); <= Warn here
D:   get_user(x,uptr); <= Warn here

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/asm-i386/uaccess.h working-2.5.21-putusercheck/include/asm-i386/uaccess.h
--- linux-2.5.21/include/asm-i386/uaccess.h	Wed Feb 20 17:56:40 2002
+++ working-2.5.21-putusercheck/include/asm-i386/uaccess.h	Sun Jun 16 05:55:27 2002
@@ -133,16 +133,18 @@
 extern void __put_user_bad(void);
 
 #define put_user(x,ptr)							\
-  __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
+  __put_user_check((x),(ptr),sizeof(*(ptr)))
 
 #define __get_user(x,ptr) \
   __get_user_nocheck((x),(ptr),sizeof(*(ptr)))
 #define __put_user(x,ptr) \
-  __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
+  __put_user_nocheck((x),(ptr),sizeof(*(ptr)))
 
 #define __put_user_nocheck(x,ptr,size)			\
 ({							\
 	long __pu_err;					\
+	/* Elicit warning */				\
+	__typeof__(x) *__pu_check __attribute__((unused)) = ptr; \
 	__put_user_size((x),(ptr),(size),__pu_err);	\
 	__pu_err;					\
 })
@@ -151,7 +153,8 @@
 #define __put_user_check(x,ptr,size)			\
 ({							\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) *__pu_addr = (ptr);		\
+	/* Elicit warning */				\
+	__typeof__(x) *__pu_addr = (ptr);		\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))	\
 		__put_user_size((x),__pu_addr,(size),__pu_err);	\
 	__pu_err;					\


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
