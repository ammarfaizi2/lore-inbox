Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSKAMgS>; Fri, 1 Nov 2002 07:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSKAMgS>; Fri, 1 Nov 2002 07:36:18 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:37002 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264956AbSKAMgR>; Fri, 1 Nov 2002 07:36:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
Date: Fri, 1 Nov 2002 15:42:09 +0100
User-Agent: KMail/1.4.3
Cc: kernel-janitor-discuss@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200211011302.05461.arnd@bergmann-dalldorf.de> <3DC25CA5.B15848E0@digeo.com>
In-Reply-To: <3DC25CA5.B15848E0@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211011542.09097.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 11:51, Andrew Morton wrote:

> I don't think we need to add the check to anything other than
> ia32.  That will pick up the great bulk of any problems, and
> arch-specific code won't be doing these copies much anyway.
>
> So if you could prepare a patch which adds these checks for
> ia32 it would be muchly appreciated.

Ok. This is the patch I was using, forward ported to
today's bitkeeper version.

	Arnd <><

===== arch/i386/lib/usercopy.c 1.8 vs edited =====
--- 1.8/arch/i386/lib/usercopy.c	Tue Oct 29 22:10:51 2002
+++ edited/arch/i386/lib/usercopy.c	Fri Nov  1 15:09:23 2002
@@ -25,6 +25,7 @@
 #define __do_strncpy_from_user(dst,src,count,res)			   \
 do {									   \
 	int __d0, __d1, __d2;						   \
+	might_sleep();							   \
 	__asm__ __volatile__(						   \
 		"	testl %1,%1\n"					   \
 		"	jz 2f\n"					   \
@@ -75,7 +76,8 @@
 #define __do_clear_user(addr,size)					\
 do {									\
 	int __d0;							\
-  	__asm__ __volatile__(						\
+	might_sleep();							\
+	__asm__ __volatile__(						\
 		"0:	rep; stosl\n"					\
 		"	movl %2,%0\n"					\
 		"1:	rep; stosb\n"					\
@@ -119,6 +121,7 @@
 	unsigned long mask = -__addr_ok(s);
 	unsigned long res, tmp;
 
+	might_sleep();
 	__asm__ __volatile__(
 		"	testl %0, %0\n"
 		"	jz 3f\n"
@@ -419,6 +422,7 @@
 
 unsigned long __copy_to_user(void *to, const void *from, unsigned long n)
 {
+	might_sleep();
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else
@@ -428,6 +432,7 @@
 
 unsigned long __copy_from_user(void *to, const void *from, unsigned long n)
 {
+	might_sleep();
 	if (movsl_is_ok(to, from, n))
 		__copy_user_zeroing(to, from, n);
 	else
===== include/asm-i386/uaccess.h 1.12 vs edited =====
--- 1.12/include/asm-i386/uaccess.h	Sat Oct 12 12:18:15 2002
+++ edited/include/asm-i386/uaccess.h	Fri Nov  1 14:44:32 2002
@@ -123,6 +123,7 @@
 /* Careful: we have to cast the result to the type of the pointer for sign reasons */
 #define get_user(x,ptr)							\
 ({	int __ret_gu,__val_gu;						\
+	might_sleep();							\
 	switch(sizeof (*(ptr))) {					\
 	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
 	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
@@ -185,6 +186,7 @@
 #define __put_user_size(x,ptr,size,retval)				\
 do {									\
 	retval = 0;							\
+	might_sleep();							\
 	switch (size) {							\
 	  case 1: __put_user_asm(x,ptr,retval,"b","b","iq"); break;	\
 	  case 2: __put_user_asm(x,ptr,retval,"w","w","ir"); break;	\
@@ -231,6 +233,7 @@
 #define __get_user_size(x,ptr,size,retval)				\
 do {									\
 	retval = 0;							\
+	might_sleep();							\
 	switch (size) {							\
 	  case 1: __get_user_asm(x,ptr,retval,"b","b","=q"); break;	\
 	  case 2: __get_user_asm(x,ptr,retval,"w","w","=r"); break;	\

