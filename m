Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVEAV3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVEAV3d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVEAV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:28:56 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:30739 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262696AbVEAVSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:38 -0400
Message-Id: <200505012113.j41LD2aI016478@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 18/22] UML - S390 preparation, checksumming done in arch code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:13:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Checksum handling largely depends on the subarch.
Thus, I renamed i386 arch_csum_partial in
arch/um/sys-i386/checksum.S back to csum_partial,
removed csum_partial from arch/um/kernel/checksum.c
and shifted EXPORT_SYMBOL(csum_partial) to
arch/um/sys-i386/ksyms.c.
Then, csum_partial_copy_to and csum_partial_copy_from were
shifted from arch/um/kernel/checksum.c to 
arch/um/include/sysdep-i386/checksum.h and inserted in the
calling functions csum_partial_copy_from_user() and
csum_and_copy_to_user().
Now, arch/um/kernel/checksum.c is empty and removed.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11-mm/arch/um/include/sysdep-i386/checksum.h
===================================================================
--- linux-2.6.11-mm.orig/arch/um/include/sysdep-i386/checksum.h	2005-04-30 12:55:28.000000000 -0400
+++ linux-2.6.11-mm/arch/um/include/sysdep-i386/checksum.h	2005-04-30 13:12:55.000000000 -0400
@@ -24,19 +24,6 @@
 			  unsigned int sum);
 
 /*
- * the same as csum_partial, but copies from src while it
- * checksums, and handles user-space pointer exceptions correctly, when needed.
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
-
-unsigned int csum_partial_copy_to(const unsigned char *src, unsigned char *dst,
-				  int len, int sum, int *err_ptr);
-unsigned int csum_partial_copy_from(const unsigned char *src, unsigned char *dst,
-				    int len, int sum, int *err_ptr);
-
-/*
  *	Note: when you get a NULL pointer exception here this means someone
  *	passed in an incorrect kernel address to one of these functions.
  *
@@ -52,11 +39,24 @@
 	return(csum_partial(dst, len, sum));
 }
 
+/*
+ * the same as csum_partial, but copies from src while it
+ * checksums, and handles user-space pointer exceptions correctly, when needed.
+ *
+ * here even more important to align src and dst on a 32-bit (or even
+ * better 64-bit) boundary
+ */
+
 static __inline__
 unsigned int csum_partial_copy_from_user(const unsigned char *src, unsigned char *dst,
 					 int len, int sum, int *err_ptr)
 {
-	return csum_partial_copy_from(src, dst, len, sum, err_ptr);
+	if(copy_from_user(dst, src, len)){
+		*err_ptr = -EFAULT;
+		return(-1);
+	}
+
+	return csum_partial(dst, len, sum);
 }
 
 /*
@@ -67,7 +67,6 @@
  */
 
 #define csum_partial_copy_fromuser csum_partial_copy_from_user
-unsigned int csum_partial_copy(const unsigned char *src, unsigned char *dst, int len, int sum);
 
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
@@ -196,8 +195,14 @@
 						     unsigned char *dst,
 						     int len, int sum, int *err_ptr)
 {
-	if (access_ok(VERIFY_WRITE, dst, len))
-		return(csum_partial_copy_to(src, dst, len, sum, err_ptr));
+	if (access_ok(VERIFY_WRITE, dst, len)){
+		if(copy_to_user(dst, src, len)){
+			*err_ptr = -EFAULT;
+			return(-1);
+		}
+
+		return csum_partial(src, len, sum);
+	}
 
 	if (len)
 		*err_ptr = -EFAULT;
Index: linux-2.6.11-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/Makefile	2005-04-30 12:59:28.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/Makefile	2005-04-30 13:12:55.000000000 -0400
@@ -5,7 +5,7 @@
 
 extra-y := vmlinux.lds
 
-obj-y = checksum.o config.o exec_kern.o exitcode.o \
+obj-y = config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
 	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
 	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
Index: linux-2.6.11-mm/arch/um/kernel/checksum.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/kernel/checksum.c	2005-04-30 12:55:28.000000000 -0400
+++ linux-2.6.11-mm/arch/um/kernel/checksum.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,36 +0,0 @@
-#include "asm/uaccess.h"
-#include "linux/errno.h"
-#include "linux/module.h"
-
-unsigned int arch_csum_partial(const unsigned char *buff, int len, int sum);
-
-unsigned int csum_partial(unsigned char *buff, int len, int sum)
-{
-        return arch_csum_partial(buff, len, sum);
-}
-
-EXPORT_SYMBOL(csum_partial);
-
-unsigned int csum_partial_copy_to(const unsigned char *src,
-                                  unsigned char __user *dst, int len, int sum,
-                                  int *err_ptr)
-{
-        if(copy_to_user(dst, src, len)){
-                *err_ptr = -EFAULT;
-                return(-1);
-        }
-
-        return(arch_csum_partial(src, len, sum));
-}
-
-unsigned int csum_partial_copy_from(const unsigned char __user *src,
-                                    unsigned char *dst,	int len, int sum,
-                                    int *err_ptr)
-{
-        if(copy_from_user(dst, src, len)){
-                *err_ptr = -EFAULT;
-                return(-1);
-        }
-
-        return arch_csum_partial(dst, len, sum);
-}
Index: linux-2.6.11-mm/arch/um/sys-i386/checksum.S
===================================================================
--- linux-2.6.11-mm.orig/arch/um/sys-i386/checksum.S	2005-04-30 12:55:28.000000000 -0400
+++ linux-2.6.11-mm/arch/um/sys-i386/checksum.S	2005-04-30 13:12:55.000000000 -0400
@@ -38,7 +38,7 @@
 		
 .text
 .align 4
-.globl arch_csum_partial								
+.globl csum_partial
 		
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -49,7 +49,7 @@
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */		
-arch_csum_partial:	
+csum_partial:
 	pushl %esi
 	pushl %ebx
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
@@ -119,7 +119,7 @@
 
 /* Version for PentiumII/PPro */
 
-arch_csum_partial:
+csum_partial:
 	pushl %esi
 	pushl %ebx
 	movl 20(%esp),%eax	# Function arg: unsigned int sum
Index: linux-2.6.11-mm/arch/um/sys-i386/ksyms.c
===================================================================
--- linux-2.6.11-mm.orig/arch/um/sys-i386/ksyms.c	2005-04-30 12:55:28.000000000 -0400
+++ linux-2.6.11-mm/arch/um/sys-i386/ksyms.c	2005-04-30 13:12:55.000000000 -0400
@@ -13,5 +13,4 @@
 EXPORT_SYMBOL(__up_wakeup);
 
 /* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy_from);
-EXPORT_SYMBOL(csum_partial_copy_to);
+EXPORT_SYMBOL(csum_partial);

