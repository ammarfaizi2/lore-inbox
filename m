Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUFAPET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUFAPET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUFAPES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:04:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:35523 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262238AbUFAPDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:03:47 -0400
Date: Tue, 1 Jun 2004 08:03:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1: gcc 2.95 uaccess.h warnings
In-Reply-To: <20040601145515.GC25681@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0406010757160.14095@ppc970.osdl.org>
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040601145515.GC25681@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jun 2004, Adrian Bunk wrote:
>
> It seems to be Linus'
> 
>   sparse: make x86 user pointer checks stricter.
> 
> patch that causes the following warnings for every single file including 
> uaccess.h when using gcc 2.95:

Yes. Apparently gcc-2.95 doesn't like to dereference a "void *" even 
just inside of a "__typeof__". Which is a bit silly, since the result is a 
perfectly valid _type_. It's obviously been fixed since, so I never saw 
this.

(Aside - with anon unions also not working in older gcc's, I suspect we'll 
start requiring gcc-3+ in the 2.7.x timeframe. I know it's a lot slower, 
but apparently at least it now is starting to generate comparable code 
again).

Anyway, the easiest work-around would be to just avoid derefencing the 
pointer, but then you have to add strange modifiers (both "const" and 
"volatile" at the same time) to make sure that gcc won't complain about 
the assignment dropping any modifiers.

So the fix I'm going to check in is to just make "__chk_user_ptr()" be 
something that gcc never even sees, which allows us to simplify it for the 
sparse case too.

In other words, this should work for even old versions of gcc.. Just to be 
anal, you should probably test on gcc-2.95 ;)

		Linus

---
===== include/asm-i386/uaccess.h 1.30 vs edited =====
--- 1.30/include/asm-i386/uaccess.h	Mon May 31 11:19:35 2004
+++ edited/include/asm-i386/uaccess.h	Tue Jun  1 07:55:30 2004
@@ -34,10 +34,6 @@
 
 #define segment_eq(a,b)	((a).seg == (b).seg)
 
-extern long not_a_user_address;
-#define check_user_ptr(x) \
-	(void) ({ void __user * __userptr = (__typeof__(*(x)) *)&not_a_user_address; __userptr; })
-
 /*
  * movsl can be slow when source and dest are not both 8-byte aligned
  */
@@ -60,7 +56,7 @@
  */
 #define __range_ok(addr,size) ({ \
 	unsigned long flag,sum; \
-	check_user_ptr(addr); \
+	__chk_user_ptr(addr); \
 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
 		:"=&r" (flag), "=r" (sum) \
 		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
@@ -175,7 +171,7 @@
  */
 #define get_user(x,ptr)							\
 ({	int __ret_gu,__val_gu;						\
-	check_user_ptr(ptr);						\
+	__chk_user_ptr(ptr);						\
 	switch(sizeof (*(ptr))) {					\
 	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
 	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
@@ -294,7 +290,7 @@
 #define __put_user_size(x,ptr,size,retval,errret)			\
 do {									\
 	retval = 0;							\
-	check_user_ptr(ptr);						\
+	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1: __put_user_asm(x,ptr,retval,"b","b","iq",errret);break;	\
 	case 2: __put_user_asm(x,ptr,retval,"w","w","ir",errret);break; \
@@ -353,7 +349,7 @@
 #define __get_user_size(x,ptr,size,retval,errret)			\
 do {									\
 	retval = 0;							\
-	check_user_ptr(ptr);						\
+	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1: __get_user_asm(x,ptr,retval,"b","b","=q",errret);break;	\
 	case 2: __get_user_asm(x,ptr,retval,"w","w","=r",errret);break;	\
===== include/asm-ppc64/uaccess.h 1.16 vs edited =====
--- 1.16/include/asm-ppc64/uaccess.h	Mon May 31 10:39:25 2004
+++ edited/include/asm-ppc64/uaccess.h	Tue Jun  1 07:55:30 2004
@@ -16,10 +16,6 @@
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
 
-extern long not_a_user_address;
-#define check_user_ptr(x) \
-	(void) ({ void __user * __userptr = (__typeof__(*(x)) *)&not_a_user_address; __userptr; })
-
 /*
  * The fs value determines whether argument validity checking should be
  * performed or not.  If get_fs() == USER_DS, checking is performed, with
@@ -120,7 +116,7 @@
 #define __put_user_nocheck(x,ptr,size)				\
 ({								\
 	long __pu_err;						\
-	check_user_ptr(ptr);					\
+	__chk_user_ptr(ptr);					\
 	__put_user_size((x),(ptr),(size),__pu_err,-EFAULT);	\
 	__pu_err;						\
 })
@@ -192,7 +188,7 @@
 do {									\
 	might_sleep();							\
 	retval = 0;							\
-	check_user_ptr(ptr);						\
+	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	  case 1: __get_user_asm(x,ptr,retval,"lbz",errret); break;	\
 	  case 2: __get_user_asm(x,ptr,retval,"lhz",errret); break;	\
===== include/asm-sparc/uaccess.h 1.11 vs edited =====
--- 1.11/include/asm-sparc/uaccess.h	Mon May 31 19:07:59 2004
+++ edited/include/asm-sparc/uaccess.h	Tue Jun  1 07:55:00 2004
@@ -83,10 +83,6 @@
 
 extern void __ret_efault(void);
 
-extern long not_a_user_address;
-#define check_user_ptr(x) \
-	(void) ({ void __user * __userptr = (__typeof__(*(x)) *)&not_a_user_address; __userptr; })
-
 /* Uh, these should become the main single-value transfer routines..
  * They automatically use the right size if we just have the right
  * pointer type..
@@ -98,12 +94,12 @@
  */
 #define put_user(x,ptr) ({ \
 unsigned long __pu_addr = (unsigned long)(ptr); \
-check_user_ptr(ptr); \
+__chk_user_ptr(ptr); \
 __put_user_check((__typeof__(*(ptr)))(x),__pu_addr,sizeof(*(ptr))); })
 
 #define get_user(x,ptr) ({ \
 unsigned long __gu_addr = (unsigned long)(ptr); \
-check_user_ptr(ptr); \
+__chk_user_ptr(ptr); \
 __get_user_check((x),__gu_addr,sizeof(*(ptr)),__typeof__(*(ptr))); })
 
 /*
===== include/asm-sparc64/uaccess.h 1.10 vs edited =====
--- 1.10/include/asm-sparc64/uaccess.h	Mon May 31 16:25:29 2004
+++ edited/include/asm-sparc64/uaccess.h	Tue Jun  1 07:55:00 2004
@@ -90,10 +90,6 @@
 
 extern void __ret_efault(void);
 
-extern long not_a_user_address;
-#define check_user_ptr(x) \
-	(void) ({ void __user * __userptr = (__typeof__(*(x)) *)&not_a_user_address; __userptr; })
-
 /* Uh, these should become the main single-value transfer routines..
  * They automatically use the right size if we just have the right
  * pointer type..
@@ -105,12 +101,12 @@
  */
 #define put_user(x,ptr) ({ \
 unsigned long __pu_addr = (unsigned long)(ptr); \
-check_user_ptr(ptr); \
+__chk_user_ptr(ptr); \
 __put_user_nocheck((__typeof__(*(ptr)))(x),__pu_addr,sizeof(*(ptr))); })
 
 #define get_user(x,ptr) ({ \
 unsigned long __gu_addr = (unsigned long)(ptr); \
-check_user_ptr(ptr); \
+__chk_user_ptr(ptr); \
 __get_user_nocheck((x),__gu_addr,sizeof(*(ptr)),__typeof__(*(ptr))); })
 
 #define __put_user(x,ptr) put_user(x,ptr)
===== include/linux/compiler.h 1.26 vs edited =====
--- 1.26/include/linux/compiler.h	Mon May 31 10:38:43 2004
+++ edited/include/linux/compiler.h	Tue Jun  1 07:44:56 2004
@@ -6,11 +6,13 @@
 # define __kernel	/* default address space */
 # define __safe		__attribute__((safe))
 # define __force	__attribute__((force))
+extern void __chk_user_ptr(void __user *);
 #else
 # define __user
 # define __kernel
 # define __safe
 # define __force
+# define __chk_user_ptr(x) (void)0
 #endif
 
 #ifdef __KERNEL__
