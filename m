Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbSJHRzO>; Tue, 8 Oct 2002 13:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSJHRzO>; Tue, 8 Oct 2002 13:55:14 -0400
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:29263 "EHLO
	brian.localnet") by vger.kernel.org with ESMTP id <S261336AbSJHRzI>;
	Tue, 8 Oct 2002 13:55:08 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] explicit CRC32 (early) initialization
Message-Id: <E17yyew-0000s7-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Tue, 08 Oct 2002 20:00:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to the crc32 library routine to allow explicit
initialization of the tables used by the routines. 

I need this to be able to use the crc routines in the early 
start up code for my platform which saves crc protected 
information (clock speed, machine type) in an eeprom.

The option CONFIG_CRC32_EXPLICIT is defined for the platforms 
which need it in the config.in file.

I have removed dynamic allocation of memory because the 
memory subsystem is also not initialised at the stage where I
need the crc functions.

/Brian

--- include/linux/crc32.h	5 Jul 2002 05:05:27 -0000	1.2
+++ include/linux/crc32.h	8 Oct 2002 17:46:39 -0000
@@ -6,6 +6,11 @@
 #define _LINUX_CRC32_H
 
 #include <linux/types.h>
+#include <linux/config.h>
+
+#ifdef CONFIG_CRC32_EXPLICIT
+extern int init_crc32(void);
+#endif
 
 extern u32  crc32_le(u32 crc, unsigned char const *p, size_t len);
 extern u32  crc32_be(u32 crc, unsigned char const *p, size_t len);
--- lib/crc32.c	9 Jul 2002 15:23:04 -0000	1.3
+++ lib/crc32.c	8 Oct 2002 17:46:40 -0000
@@ -68,7 +68,6 @@
  * simplified by inlining the table in ?: form.
  */
 #define crc32init_le()
-#define crc32cleanup_le()
 /**
  * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
  * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
@@ -89,7 +88,7 @@
 }
 #else				/* Table-based approach */
 
-static u32 *crc32table_le;
+static u32 crc32table_le[1 << CRC_LE_BITS];
 /**
  * crc32init_le() - allocate and initialize LE table data
  *
@@ -102,10 +101,6 @@
 	unsigned i, j;
 	u32 crc = 1;
 
-	crc32table_le =
-	    kmalloc((1 << CRC_LE_BITS) * sizeof(u32), GFP_KERNEL);
-	if (!crc32table_le)
-		return 1;
 	crc32table_le[0] = 0;
 
 	for (i = 1 << (CRC_LE_BITS - 1); i; i >>= 1) {
@@ -117,15 +112,6 @@
 }
 
 /**
- * crc32cleanup_le(): free LE table data
- */
-static void __exit crc32cleanup_le(void)
-{
-	if (crc32table_le) kfree(crc32table_le);
-	crc32table_le = NULL;
-}
-
-/**
  * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
  * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
  *        other uses, or the previous crc32 value if computing incrementally.
@@ -168,7 +154,6 @@
  * simplified by inlining the table in ?: form.
  */
 #define crc32init_be()
-#define crc32cleanup_be()
 
 /**
  * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
@@ -192,7 +177,7 @@
 }
 
 #else				/* Table-based approach */
-static u32 *crc32table_be;
+static u32 crc32table_be[1 << CRC_BE_BITS];
 
 /**
  * crc32init_be() - allocate and initialize BE table data
@@ -202,10 +187,6 @@
 	unsigned i, j;
 	u32 crc = 0x80000000;
 
-	crc32table_be =
-	    kmalloc((1 << CRC_BE_BITS) * sizeof(u32), GFP_KERNEL);
-	if (!crc32table_be)
-		return 1;
 	crc32table_be[0] = 0;
 
 	for (i = 1; i < 1 << CRC_BE_BITS; i <<= 1) {
@@ -217,16 +198,6 @@
 }
 
 /**
- * crc32cleanup_be(): free BE table data
- */
-static void __exit crc32cleanup_be(void)
-{
-	if (crc32table_be) kfree(crc32table_be);
-	crc32table_be = NULL;
-}
-
-
-/**
  * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
  * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
  *        other uses, or the previous crc32 value if computing incrementally.
@@ -545,7 +516,10 @@
  * Since crc32.o is a library module, there's no requirement
  * that the user can unload it.
  */
-static int __init init_crc32(void)
+#ifndef CONFIG_CRC32_EXPLICIT
+static 
+#endif
+int __init init_crc32(void)
 {
 	int rc1, rc2, rc;
 	rc1 = crc32init_le();
@@ -555,17 +529,9 @@
 	return rc;
 }
 
-/**
- * cleanup_crc32(): frees crc32 data when no longer needed
- */
-static void __exit cleanup_crc32(void)
-{
-	crc32cleanup_le();
-	crc32cleanup_be();
-}
-
-fs_initcall(init_crc32);
-module_exit(cleanup_crc32);
+#ifndef CONFIG_CRC32_EXPLICIT
+core_initcall(init_crc32);
+#endif
 
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(crc32_be);
