Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVCGTK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCGTK4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCGTJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:09:18 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:2566 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261243AbVCGTHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:07:38 -0500
Message-Id: <200503072037.j27Kb7bc003942@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/16] UML - 2.6.11 updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:07 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some small changes that parallel changes in 2.6.11:
	The csum buffers are now unsigned char.
	Got rid of an unused define from pgtable-2level.h.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/sysdep-x86_64/checksum.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/sysdep-x86_64/checksum.h	2005-03-04 14:16:38.000000000 -0500
+++ linux-2.6.11/arch/um/include/sysdep-x86_64/checksum.h	2005-03-04 19:28:02.000000000 -0500
@@ -9,7 +9,7 @@
 #include "linux/in6.h"
 #include "asm/uaccess.h"
 
-extern unsigned int csum_partial_copy_from(const char *src, char *dst, int len,
+extern unsigned int csum_partial_copy_from(const unsigned char *src, unsigned char *dst, int len,
 					   int sum, int *err_ptr);
 extern unsigned csum_partial(const unsigned char *buff, unsigned len,
                              unsigned sum);
@@ -23,7 +23,7 @@
  */
 
 static __inline__
-unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
+unsigned int csum_partial_copy_nocheck(const unsigned char *src, unsigned char *dst,
 				       int len, int sum)
 {
 	memcpy(dst, src, len);
@@ -31,7 +31,7 @@
 }
 
 static __inline__
-unsigned int csum_partial_copy_from_user(const char *src, char *dst,
+unsigned int csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst,
 					 int len, int sum, int *err_ptr)
 {
 	return csum_partial_copy_from(src, dst, len, sum, err_ptr);
Index: linux-2.6.11/arch/um/kernel/checksum.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/checksum.c	2005-03-04 14:16:38.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/checksum.c	2005-03-04 19:31:26.000000000 -0500
@@ -6,40 +6,31 @@
 
 unsigned int csum_partial(unsigned char *buff, int len, int sum)
 {
-	return arch_csum_partial(buff, len, sum);
+        return arch_csum_partial(buff, len, sum);
 }
 
 EXPORT_SYMBOL(csum_partial);
 
-unsigned int csum_partial_copy_to(const unsigned char *src, char __user *dst,
-				int len, int sum, int *err_ptr)
+unsigned int csum_partial_copy_to(const unsigned char *src, 
+                                  unsigned char __user *dst, int len, int sum,
+                                  int *err_ptr)
 {
-	if(copy_to_user(dst, src, len)){
-		*err_ptr = -EFAULT;
-		return(-1);
-	}
+        if(copy_to_user(dst, src, len)){
+                *err_ptr = -EFAULT;
+                return(-1);
+        }
 
-	return(arch_csum_partial(src, len, sum));
+        return(arch_csum_partial(src, len, sum));
 }
 
-unsigned int csum_partial_copy_from(const unsigned char __user *src, char *dst,
-				int len, int sum, int *err_ptr)
+unsigned int csum_partial_copy_from(const unsigned char __user *src, 
+                                    unsigned char *dst,	int len, int sum, 
+                                    int *err_ptr)
 {
-	if(copy_from_user(dst, src, len)){
-		*err_ptr = -EFAULT;
-		return(-1);
-	}
+        if(copy_from_user(dst, src, len)){
+                *err_ptr = -EFAULT;
+                return(-1);
+        }
 
-	return arch_csum_partial(dst, len, sum);
+        return arch_csum_partial(dst, len, sum);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.11/include/asm-um/pgtable-2level.h
===================================================================
--- linux-2.6.11.orig/include/asm-um/pgtable-2level.h	2005-03-04 14:17:00.000000000 -0500
+++ linux-2.6.11/include/asm-um/pgtable-2level.h	2005-03-04 19:38:54.000000000 -0500
@@ -21,7 +21,6 @@
  * we don't really have any PMD directory physically.
  */
 #define PTRS_PER_PTE	1024
-#define PTRS_PER_PMD	1
 #define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD	1024
 #define FIRST_USER_PGD_NR       0

