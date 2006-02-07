Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWBGCWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWBGCWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWBGCWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:22:49 -0500
Received: from [198.99.130.12] ([198.99.130.12]:16363 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964938AbWBGCWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:22:47 -0500
Message-Id: <200602070223.k172Nmvq009649@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/8] UML - Compilation warning removal
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Feb 2006 21:23:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.0, I get a bunch of warnings about consts being lost in the
copy_user code.  This patch fixes them by adding consts where necessary.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/skas/uaccess-skas.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/skas/uaccess-skas.h	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/include/skas/uaccess-skas.h	2006-02-06 17:34:21.000000000 -0500
@@ -11,8 +11,8 @@
 /* No SKAS-specific checking. */
 #define access_ok_skas(type, addr, size) 0
 
-extern int copy_from_user_skas(void *to, const void __user *from, int n);
-extern int copy_to_user_skas(void __user *to, const void *from, int n);
+extern int copy_from_user_skas(const void *to, const void __user *from, int n);
+extern int copy_to_user_skas(const void __user *to, const void *from, int n);
 extern int strncpy_from_user_skas(char *dst, const char __user *src, int count);
 extern int __clear_user_skas(void __user *mem, int len);
 extern int clear_user_skas(void __user *mem, int len);
Index: linux-2.6.15/arch/um/include/tt/uaccess-tt.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/tt/uaccess-tt.h	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/include/tt/uaccess-tt.h	2006-02-06 17:34:21.000000000 -0500
@@ -38,8 +38,8 @@ extern int __do_clear_user(void *mem, si
 extern int __do_strnlen_user(const char *str, unsigned long n,
 			     void **fault_addr, void **fault_catcher);
 
-extern int copy_from_user_tt(void *to, const void __user *from, int n);
-extern int copy_to_user_tt(void __user *to, const void *from, int n);
+extern int copy_from_user_tt(const void *to, const void __user *from, int n);
+extern int copy_to_user_tt(const void __user *to, const void *from, int n);
 extern int strncpy_from_user_tt(char *dst, const char __user *src, int count);
 extern int __clear_user_tt(void __user *mem, int len);
 extern int clear_user_tt(void __user *mem, int len);
Index: linux-2.6.15/arch/um/include/um_uaccess.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/um_uaccess.h	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/include/um_uaccess.h	2006-02-06 17:34:24.000000000 -0500
@@ -39,13 +39,13 @@
 	  segment_eq(get_fs(), KERNEL_DS) || \
 	  CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)))
 
-static inline int copy_from_user(void *to, const void __user *from, int n)
+static inline int copy_from_user(const void *to, const void __user *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_from_user_tt, copy_from_user_skas, to,
 				from, n));
 }
 
-static inline int copy_to_user(void __user *to, const void *from, int n)
+static inline int copy_to_user(const void __user *to, const void *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_to_user_tt, copy_to_user_skas, to, 
 				from, n));
Index: linux-2.6.15/arch/um/kernel/skas/uaccess.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/uaccess.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/uaccess.c	2006-02-06 17:34:24.000000000 -0500
@@ -136,10 +136,10 @@ static int copy_chunk_from_user(unsigned
 	return(0);
 }
 
-int copy_from_user_skas(void *to, const void __user *from, int n)
+int copy_from_user_skas(const void *to, const void __user *from, int n)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
-		memcpy(to, (__force void*)from, n);
+		memcpy((void *) to, (__force void*)from, n);
 		return(0);
 	}
 
@@ -157,7 +157,7 @@ static int copy_chunk_to_user(unsigned l
 	return(0);
 }
 
-int copy_to_user_skas(void __user *to, const void *from, int n)
+int copy_to_user_skas(const void __user *to, const void *from, int n)
 {
 	if(segment_eq(get_fs(), KERNEL_DS)){
 		memcpy((__force void*)to, from, n);
Index: linux-2.6.15/arch/um/kernel/tt/uaccess.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/uaccess.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/tt/uaccess.c	2006-02-06 17:34:24.000000000 -0500
@@ -6,7 +6,7 @@
 #include "linux/sched.h"
 #include "asm/uaccess.h"
 
-int copy_from_user_tt(void *to, const void __user *from, int n)
+int copy_from_user_tt(const void *to, const void __user *from, int n)
 {
 	if(!access_ok(VERIFY_READ, from, n))
 		return(n);
@@ -15,7 +15,7 @@ int copy_from_user_tt(void *to, const vo
 				   &current->thread.fault_catcher));
 }
 
-int copy_to_user_tt(void __user *to, const void *from, int n)
+int copy_to_user_tt(const void __user *to, const void *from, int n)
 {
 	if(!access_ok(VERIFY_WRITE, to, n))
 		return(n);
Index: linux-2.6.15/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.15.orig/include/asm-um/uaccess.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-um/uaccess.h	2006-02-06 17:34:24.000000000 -0500
@@ -41,7 +41,7 @@
 
 #define __get_user(x, ptr) \
 ({ \
-        const __typeof__(ptr) __private_ptr = ptr; \
+        const __typeof__(ptr) __user __private_ptr = ptr; \
         __typeof__(*(__private_ptr)) __private_val; \
         int __private_ret = -EFAULT; \
         (x) = (__typeof__(*(__private_ptr)))0; \

