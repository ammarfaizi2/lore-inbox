Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSKAOno>; Fri, 1 Nov 2002 09:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265036AbSKAOno>; Fri, 1 Nov 2002 09:43:44 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:46725 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265033AbSKAOnn>; Fri, 1 Nov 2002 09:43:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
Date: Fri, 1 Nov 2002 17:49:37 +0100
User-Agent: KMail/1.4.3
Cc: kernel-janitor-discuss@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <3DC285D4.2040305@colorfullife.com>
In-Reply-To: <3DC285D4.2040305@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211011749.37661.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 14:47, Manfred Spraul wrote:

> Good idea.
> There is some abuse of __get_user to identify bad pointers:
> show_registers in the oops codepath, mm/slab.c in the /proc/slabinfo code.
>
> Could you omit the test from the __ versions?

That would we the patch below. But shouldn't those abuses
of __get_user rather be changed to use something else?
The name is just wrong there and the first argument is
never used.

We could instead do something like

#define check_pointer(p) ({				\
	typeof(*(p)) __t;				\
	long __gu_err;					\
	__get_user_size(__t, p, sizeof(__t), __gu_err);	\
	__gu_err;					\
})

	Arnd <><

===== arch/i386/lib/usercopy.c 1.8 vs edited =====
--- 1.8/arch/i386/lib/usercopy.c	Tue Oct 29 22:10:51 2002
+++ edited/arch/i386/lib/usercopy.c	Fri Nov  1 17:10:30 2002
@@ -62,6 +62,7 @@
 strncpy_from_user(char *dst, const char *src, long count)
 {
 	long res = -EFAULT;
+	might_sleep();
 	if (access_ok(VERIFY_READ, src, 1))
 		__do_strncpy_from_user(dst, src, count, res);
 	return res;
@@ -96,6 +97,7 @@
 unsigned long
 clear_user(void *to, unsigned long n)
 {
+	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		__do_clear_user(to, n);
 	return n;
@@ -119,6 +121,7 @@
 	unsigned long mask = -__addr_ok(s);
 	unsigned long res, tmp;
 
+	might_sleep();
 	__asm__ __volatile__(
 		"	testl %0, %0\n"
 		"	jz 3f\n"
@@ -438,6 +441,7 @@
 unsigned long copy_to_user(void *to, const void *from, unsigned long n)
 {
 	prefetch(from);
+	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
 	return n;
@@ -446,6 +450,7 @@
 unsigned long copy_from_user(void *to, const void *from, unsigned long n)
 {
 	prefetchw(to);
+	might_sleep();
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
 	return n;
===== include/asm-i386/uaccess.h 1.12 vs edited =====
--- 1.12/include/asm-i386/uaccess.h	Sat Oct 12 12:18:15 2002
+++ edited/include/asm-i386/uaccess.h	Fri Nov  1 17:07:40 2002
@@ -123,6 +123,7 @@
 /* Careful: we have to cast the result to the type of the pointer for sign reasons */
 #define get_user(x,ptr)							\
 ({	int __ret_gu,__val_gu;						\
+	might_sleep();							\
 	switch(sizeof (*(ptr))) {					\
 	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
 	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
@@ -158,8 +159,9 @@
 
 #define __put_user_check(x,ptr,size)			\
 ({							\
-	long __pu_err = -EFAULT;					\
+	long __pu_err = -EFAULT;			\
 	__typeof__(*(ptr)) *__pu_addr = (ptr);		\
+	might_sleep();					\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))	\
 		__put_user_size((x),__pu_addr,(size),__pu_err);	\
 	__pu_err;					\

