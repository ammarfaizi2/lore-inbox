Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSKUWVT>; Thu, 21 Nov 2002 17:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSKUWVT>; Thu, 21 Nov 2002 17:21:19 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:30773 "EHLO
	brian.localnet") by vger.kernel.org with ESMTP id <S264934AbSKUWVO>;
	Thu, 21 Nov 2002 17:21:14 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] crc32 static initialization
Message-Id: <E18Ezo0-0002R3-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Thu, 21 Nov 2002 23:28:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on Alan Cox's suggestion this is a patch to the crc32 routines 
to generate the needed tables at compile time rather than run time. 
This means that they can be used at any point, even very early on 
in kernel initialization, where I need them to compute a crc on 
values read from an eeprom.

The current code has two flaws from this viewpoint, it uses dynamic 
memory allocation and is called from the initcall system both of 
which are initalized long after I need the crc functions.

Comments are very welcome.

/Brian

--- lib/crc32.c	9 Jul 2002 15:23:04 -0000	1.3
+++ lib/crc32.c	21 Nov 2002 20:02:42 -0000
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <asm/atomic.h>
+#include "crc32.h"
+#include "crc32table.h"
 
 #if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
 #define attribute(x) __attribute__(x)
@@ -40,35 +42,12 @@
 MODULE_DESCRIPTION("Ethernet CRC32 calculations");
 MODULE_LICENSE("GPL and additional rights");
 
-
-/*
- * There are multiple 16-bit CRC polynomials in common use, but this is
- * *the* standard CRC-32 polynomial, first popularized by Ethernet.
- * x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x^1+x^0
- */
-#define CRCPOLY_LE 0xedb88320
-#define CRCPOLY_BE 0x04c11db7
-
-/* How many bits at a time to use.  Requires a table of 4<<CRC_xx_BITS bytes. */
-/* For less performance-sensitive, use 4 */
-#define CRC_LE_BITS 8
-#define CRC_BE_BITS 8
-
-/*
- * Little-endian CRC computation.  Used with serial bit streams sent
- * lsbit-first.  Be sure to use cpu_to_le32() to append the computed CRC.
- */
-#if CRC_LE_BITS > 8 || CRC_LE_BITS < 1 || CRC_LE_BITS & CRC_LE_BITS-1
-# error CRC_LE_BITS must be a power of 2 between 1 and 8
-#endif
-
 #if CRC_LE_BITS == 1
 /*
  * In fact, the table-based code will work in this case, but it can be
  * simplified by inlining the table in ?: form.
  */
-#define crc32init_le()
-#define crc32cleanup_le()
+
 /**
  * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
  * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
@@ -89,42 +68,6 @@
 }
 #else				/* Table-based approach */
 
-static u32 *crc32table_le;
-/**
- * crc32init_le() - allocate and initialize LE table data
- *
- * crc is the crc of the byte i; other entries are filled in based on the
- * fact that crctable[i^j] = crctable[i] ^ crctable[j].
- *
- */
-static int __init crc32init_le(void)
-{
-	unsigned i, j;
-	u32 crc = 1;
-
-	crc32table_le =
-	    kmalloc((1 << CRC_LE_BITS) * sizeof(u32), GFP_KERNEL);
-	if (!crc32table_le)
-		return 1;
-	crc32table_le[0] = 0;
-
-	for (i = 1 << (CRC_LE_BITS - 1); i; i >>= 1) {
-		crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
-		for (j = 0; j < 1 << CRC_LE_BITS; j += 2 * i)
-			crc32table_le[i + j] = crc ^ crc32table_le[j];
-	}
-	return 0;
-}
-
-/**
- * crc32cleanup_le(): free LE table data
- */
-static void __exit crc32cleanup_le(void)
-{
-	if (crc32table_le) kfree(crc32table_le);
-	crc32table_le = NULL;
-}
-
 /**
  * crc32_le() - Calculate bitwise little-endian Ethernet AUTODIN II CRC32
  * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
@@ -154,21 +97,11 @@
 }
 #endif
 
-/*
- * Big-endian CRC computation.  Used with serial bit streams sent
- * msbit-first.  Be sure to use cpu_to_be32() to append the computed CRC.
- */
-#if CRC_BE_BITS > 8 || CRC_BE_BITS < 1 || CRC_BE_BITS & CRC_BE_BITS-1
-# error CRC_BE_BITS must be a power of 2 between 1 and 8
-#endif
-
 #if CRC_BE_BITS == 1
 /*
  * In fact, the table-based code will work in this case, but it can be
  * simplified by inlining the table in ?: form.
  */
-#define crc32init_be()
-#define crc32cleanup_be()
 
 /**
  * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
@@ -192,40 +125,6 @@
 }
 
 #else				/* Table-based approach */
-static u32 *crc32table_be;
-
-/**
- * crc32init_be() - allocate and initialize BE table data
- */
-static int __init crc32init_be(void)
-{
-	unsigned i, j;
-	u32 crc = 0x80000000;
-
-	crc32table_be =
-	    kmalloc((1 << CRC_BE_BITS) * sizeof(u32), GFP_KERNEL);
-	if (!crc32table_be)
-		return 1;
-	crc32table_be[0] = 0;
-
-	for (i = 1; i < 1 << CRC_BE_BITS; i <<= 1) {
-		crc = (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE : 0);
-		for (j = 0; j < i; j++)
-			crc32table_be[i + j] = crc ^ crc32table_be[j];
-	}
-	return 0;
-}
-
-/**
- * crc32cleanup_be(): free BE table data
- */
-static void __exit crc32cleanup_be(void)
-{
-	if (crc32table_be) kfree(crc32table_be);
-	crc32table_be = NULL;
-}
-
-
 /**
  * crc32_be() - Calculate bitwise big-endian Ethernet AUTODIN II CRC32
  * @crc - seed value for computation.  ~0 for Ethernet, sometimes 0 for
@@ -255,6 +154,9 @@
 }
 #endif
 
+EXPORT_SYMBOL(crc32_le);
+EXPORT_SYMBOL(crc32_be);
+
 /*
  * A brief CRC tutorial.
  *
@@ -508,9 +410,6 @@
 	int i, j;
 	u32 crc1, crc2, crc3;
 
-	crc32init_le();
-	crc32init_be();
-
 	for (i = 0; i <= SIZE; i++) {
 		printf("\rTesting length %d...", i);
 		fflush(stdout);
@@ -532,40 +431,3 @@
 }
 
 #endif				/* UNITTEST */
-
-/**
- * init_crc32(): generates CRC32 tables
- * 
- * On successful initialization, use count is increased.
- * This guarantees that the library functions will stay resident
- * in memory, and prevents someone from 'rmmod crc32' while
- * a driver that needs it is still loaded.
- * This also greatly simplifies drivers, as there's no need
- * to call an initialization/cleanup function from each driver.
- * Since crc32.o is a library module, there's no requirement
- * that the user can unload it.
- */
-static int __init init_crc32(void)
-{
-	int rc1, rc2, rc;
-	rc1 = crc32init_le();
-	rc2 = crc32init_be();
-	rc = rc1 || rc2;
-	if (!rc) MOD_INC_USE_COUNT;
-	return rc;
-}
-
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
-
-EXPORT_SYMBOL(crc32_le);
-EXPORT_SYMBOL(crc32_be);
--- lib/Makefile	2 Nov 2002 20:02:06 -0000	1.14
+++ lib/Makefile	21 Nov 2002 20:56:23 -0000
@@ -32,4 +32,12 @@
 include $(TOPDIR)/fs/Makefile.lib
 include $(TOPDIR)/net/bluetooth/bnep/Makefile.lib
 
+host-progs := gen_crc32table
+clean-files := crc32table.h
+
 include $(TOPDIR)/Rules.make
+
+$(obj)/crc32.o: $(obj)/crc32table.h
+
+$(obj)/crc32table.h: $(obj)/gen_crc32table
+	./$< > $@
--- /dev/null	2002-09-09 21:28:31.000000000 +0200
+++ lib/crc32.h	2002-11-21 21:57:51.000000000 +0100
@@ -0,0 +1,28 @@
+/*
+ * There are multiple 16-bit CRC polynomials in common use, but this is
+ * *the* standard CRC-32 polynomial, first popularized by Ethernet.
+ * x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x^1+x^0
+ */
+#define CRCPOLY_LE 0xedb88320
+#define CRCPOLY_BE 0x04c11db7
+
+/* How many bits at a time to use.  Requires a table of 4<<CRC_xx_BITS bytes. */
+/* For less performance-sensitive, use 4 */
+#define CRC_LE_BITS 8
+#define CRC_BE_BITS 8
+
+/*
+ * Little-endian CRC computation.  Used with serial bit streams sent
+ * lsbit-first.  Be sure to use cpu_to_le32() to append the computed CRC.
+ */
+#if CRC_LE_BITS > 8 || CRC_LE_BITS < 1 || CRC_LE_BITS & CRC_LE_BITS-1
+# error CRC_LE_BITS must be a power of 2 between 1 and 8
+#endif
+
+/*
+ * Big-endian CRC computation.  Used with serial bit streams sent
+ * msbit-first.  Be sure to use cpu_to_be32() to append the computed CRC.
+ */
+#if CRC_BE_BITS > 8 || CRC_BE_BITS < 1 || CRC_BE_BITS & CRC_BE_BITS-1
+# error CRC_BE_BITS must be a power of 2 between 1 and 8
+#endif
--- /dev/null	2002-09-09 21:28:31.000000000 +0200
+++ lib/gen_crc32table.c	2002-11-21 21:39:02.000000000 +0100
@@ -0,0 +1,80 @@
+#include <stdio.h>
+#include "crc32.h"
+#include <sys/types.h>
+
+#define LE_TABLE_SIZE (1 << CRC_LE_BITS)
+#define BE_TABLE_SIZE (1 << CRC_BE_BITS)
+
+static u_int32_t crc32table_le[LE_TABLE_SIZE];
+static u_int32_t crc32table_be[BE_TABLE_SIZE];
+
+/**
+ * crc32init_le() - allocate and initialize LE table data
+ *
+ * crc is the crc of the byte i; other entries are filled in based on the
+ * fact that crctable[i^j] = crctable[i] ^ crctable[j].
+ *
+ */
+static void crc32init_le(void)
+{
+	unsigned i, j;
+	u_int32_t crc = 1;
+
+	crc32table_le[0] = 0;
+
+	for (i = 1 << (CRC_LE_BITS - 1); i; i >>= 1) {
+		crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
+		for (j = 0; j < LE_TABLE_SIZE; j += 2 * i)
+			crc32table_le[i + j] = crc ^ crc32table_le[j];
+	}
+}
+
+/**
+ * crc32init_be() - allocate and initialize BE table data
+ */
+static void crc32init_be(void)
+{
+	unsigned i, j;
+	u_int32_t crc = 0x80000000;
+
+	crc32table_be[0] = 0;
+
+	for (i = 1; i < BE_TABLE_SIZE; i <<= 1) {
+		crc = (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE : 0);
+		for (j = 0; j < i; j++)
+			crc32table_be[i + j] = crc ^ crc32table_be[j];
+	}
+}
+
+static void output_table(u_int32_t table[], int len)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++) {
+		if (i % 6 == 0)
+			printf("\n");
+		printf("0x%8.8xL, ", table[i]);
+	}
+	printf("0x%8.8xL\n", table[len - 1]);
+}
+
+int main(int argc, char** argv)
+{
+	printf("/* this file is generated - do not edit */\n\n");
+
+	if (CRC_LE_BITS > 1) {
+		crc32init_le();
+		printf("static u32 crc32table_le[] = {");
+		output_table(crc32table_le, LE_TABLE_SIZE);
+		printf("};\n");
+	}
+
+	if (CRC_BE_BITS > 1) {
+		crc32init_be();
+		printf("static u32 crc32table_be[] = {");
+		output_table(crc32table_be, BE_TABLE_SIZE);
+		printf("};\n");
+	}
+
+	return 0;
+}
