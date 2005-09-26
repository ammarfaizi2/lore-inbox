Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVIZFT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVIZFT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 01:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVIZFTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 01:19:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46548 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932386AbVIZFT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 01:19:29 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: more basic __user annotations
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1EJlOi-00059z-Ij@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 26 Sep 2005 06:19:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git5-sata_qstor/arch/m32r/lib/usercopy.c RC14-rc2-git5-m32r-user/arch/m32r/lib/usercopy.c
--- RC14-rc2-git5-sata_qstor/arch/m32r/lib/usercopy.c	2005-06-17 15:48:29.000000000 -0400
+++ RC14-rc2-git5-m32r-user/arch/m32r/lib/usercopy.c	2005-09-26 00:28:31.000000000 -0400
@@ -13,7 +13,7 @@
 #include <asm/uaccess.h>
 
 unsigned long
-__generic_copy_to_user(void *to, const void *from, unsigned long n)
+__generic_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	prefetch(from);
 	if (access_ok(VERIFY_WRITE, to, n))
@@ -22,7 +22,7 @@
 }
 
 unsigned long
-__generic_copy_from_user(void *to, const void *from, unsigned long n)
+__generic_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	prefetchw(to);
 	if (access_ok(VERIFY_READ, from, n))
@@ -111,7 +111,7 @@
 #endif /* CONFIG_ISA_DUAL_ISSUE */
 
 long
-__strncpy_from_user(char *dst, const char *src, long count)
+__strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	long res;
 	__do_strncpy_from_user(dst, src, count, res);
@@ -119,7 +119,7 @@
 }
 
 long
-strncpy_from_user(char *dst, const char *src, long count)
+strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	long res = -EFAULT;
 	if (access_ok(VERIFY_READ, src, 1))
@@ -222,7 +222,7 @@
 #endif /* not CONFIG_ISA_DUAL_ISSUE */
 
 unsigned long
-clear_user(void *to, unsigned long n)
+clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
 		__do_clear_user(to, n);
@@ -230,7 +230,7 @@
 }
 
 unsigned long
-__clear_user(void *to, unsigned long n)
+__clear_user(void __user *to, unsigned long n)
 {
 	__do_clear_user(to, n);
 	return n;
@@ -244,7 +244,7 @@
 
 #ifdef CONFIG_ISA_DUAL_ISSUE
 
-long strnlen_user(const char *s, long n)
+long strnlen_user(const char __user *s, long n)
 {
 	unsigned long mask = -__addr_ok(s);
 	unsigned long res;
@@ -313,7 +313,7 @@
 
 #else /* not CONFIG_ISA_DUAL_ISSUE */
 
-long strnlen_user(const char *s, long n)
+long strnlen_user(const char __user *s, long n)
 {
 	unsigned long mask = -__addr_ok(s);
 	unsigned long res;
diff -urN RC14-rc2-git5-sata_qstor/include/asm-m32r/uaccess.h RC14-rc2-git5-m32r-user/include/asm-m32r/uaccess.h
--- RC14-rc2-git5-sata_qstor/include/asm-m32r/uaccess.h	2005-09-08 10:07:30.000000000 -0400
+++ RC14-rc2-git5-m32r-user/include/asm-m32r/uaccess.h	2005-09-26 00:33:15.000000000 -0400
@@ -208,7 +208,8 @@
  * On error, the variable @x is set to zero.
  */
 #define get_user(x,ptr)							\
-({	int __ret_gu,__val_gu;						\
+({	int __ret_gu;							\
+	unsigned long __val_gu;						\
 	__chk_user_ptr(ptr);						\
 	switch(sizeof (*(ptr))) {					\
 	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
@@ -403,7 +404,8 @@
 
 #define __get_user_nocheck(x,ptr,size)					\
 ({									\
-	long __gu_err, __gu_val;					\
+	long __gu_err;							\
+	unsigned long __gu_val;						\
 	__get_user_size(__gu_val,(ptr),(size),__gu_err);		\
 	(x) = (__typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
@@ -594,8 +596,8 @@
 	return n;
 }
 
-unsigned long __generic_copy_to_user(void *, const void *, unsigned long);
-unsigned long __generic_copy_from_user(void *, const void *, unsigned long);
+unsigned long __generic_copy_to_user(void __user *, const void *, unsigned long);
+unsigned long __generic_copy_from_user(void *, const void __user *, unsigned long);
 
 /**
  * __copy_to_user: - Copy a block of data into user space, with less checking.
