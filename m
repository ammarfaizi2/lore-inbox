Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCNIM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCNIM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVCNIM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:12:27 -0500
Received: from ozlabs.org ([203.10.76.45]:61832 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261327AbVCNIMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:12:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.18241.693676.943000@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 19:11:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@austin.ibm.com>,
       anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: kill might_sleep() warnings in __copy_*_user_inatomic
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Arnd Bergmann and Olof Johansson.

This implements the __copy_{to,from}_user_inatomic() functions on ppc64.
The only difference between the inatomic and regular version is that
inatomic does not call might_sleep() to detect possible faults while
holding locks/elevated preempt counts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- linux-2.6-ppc.orig/include/asm-ppc64/uaccess.h	2005-03-10 14:54:18.000000000 -0500
+++ linux-2.6-ppc/include/asm-ppc64/uaccess.h	2005-03-11 06:55:02.792926304 -0500
@@ -119,6 +119,7 @@ extern long __put_user_bad(void);
 #define __put_user_nocheck(x,ptr,size)				\
 ({								\
 	long __pu_err;						\
+	might_sleep();						\
 	__chk_user_ptr(ptr);					\
 	__put_user_size((x),(ptr),(size),__pu_err,-EFAULT);	\
 	__pu_err;						\
@@ -128,6 +129,7 @@ extern long __put_user_bad(void);
 ({									\
 	long __pu_err = -EFAULT;					\
 	void __user *__pu_addr = (ptr);					\
+	might_sleep();							\
 	if (access_ok(VERIFY_WRITE,__pu_addr,size))			\
 		__put_user_size((x),__pu_addr,(size),__pu_err,-EFAULT);	\
 	__pu_err;							\
@@ -135,7 +137,6 @@ extern long __put_user_bad(void);
 
 #define __put_user_size(x,ptr,size,retval,errret)			\
 do {									\
-	might_sleep();							\
 	retval = 0;							\
 	switch (size) {							\
 	  case 1: __put_user_asm(x,ptr,retval,"stb",errret); break;	\
@@ -170,6 +171,7 @@ do {									\
 #define __get_user_nocheck(x,ptr,size)				\
 ({								\
 	long __gu_err, __gu_val;				\
+	might_sleep();						\
 	__get_user_size(__gu_val,(ptr),(size),__gu_err,-EFAULT);\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -179,6 +181,7 @@ do {									\
 ({									\
 	long __gu_err = -EFAULT, __gu_val = 0;				\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	might_sleep();							\
 	if (access_ok(VERIFY_READ,__gu_addr,size))			\
 		__get_user_size(__gu_val,__gu_addr,(size),__gu_err,-EFAULT);\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
@@ -189,7 +192,6 @@ extern long __get_user_bad(void);
 
 #define __get_user_size(x,ptr,size,retval,errret)			\
 do {									\
-	might_sleep();							\
 	retval = 0;							\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
@@ -223,9 +225,8 @@ extern unsigned long __copy_tofrom_user(
 					unsigned long size);
 
 static inline unsigned long
-__copy_from_user(void *to, const void __user *from, unsigned long n)
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	might_sleep();
 	if (__builtin_constant_p(n)) {
 		unsigned long ret;
 
@@ -248,9 +249,15 @@ __copy_from_user(void *to, const void __
 }
 
 static inline unsigned long
-__copy_to_user(void __user *to, const void *from, unsigned long n)
+__copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_sleep();
+	return __copy_from_user_inatomic(to, from, n);
+}
+
+static inline unsigned long
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
 	if (__builtin_constant_p(n)) {
 		unsigned long ret;
 
@@ -272,6 +279,13 @@ __copy_to_user(void __user *to, const vo
 	return __copy_tofrom_user(to, (__force const void __user *) from, n);
 }
 
+static inline unsigned long
+__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	might_sleep();
+	return __copy_to_user_inatomic(to, from, n);
+}
+
 #define __copy_in_user(to, from, size) \
 	__copy_tofrom_user((to), (from), (size))
 
@@ -284,9 +298,6 @@ extern unsigned long copy_in_user(void _
 
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
-
 static inline unsigned long
 clear_user(void __user *addr, unsigned long size)
 {
