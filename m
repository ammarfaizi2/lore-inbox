Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSKYRmT>; Mon, 25 Nov 2002 12:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSKYRmT>; Mon, 25 Nov 2002 12:42:19 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:55875 "EHLO
	brian.localnet") by vger.kernel.org with ESMTP id <S262067AbSKYRmM>;
	Mon, 25 Nov 2002 12:42:12 -0500
To: alan@lxorguk.ukuu.org.uk, linus@transmeta.com
Subject: [PATCH 2.5] crc32 static initialisation/code speedup
Cc: linux-kernel@vger.kernel.org
Message-Id: <E18GNLJ-0000Ly-00@brian.localnet>
From: Brian Murphy <brm@murphy.dk>
Date: Mon, 25 Nov 2002 18:48:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	this patch combines my patch which statically initialises the 
crc32 tables so they can be used at any time (during initialisation) 
and Joakim Tjernlund's patch to speed up the crc calculations by doing word
operations instead of exclusively byte.

The crc routines are used extensively in jffs2 where speed is very important.
I need the crc32 routines to calculate a checksum on values read from an 
eeprom which contain cpu speed and memory size information - so they are 
needed very much earlier in the initialisation process than they are currently
available.

Please apply.

/Brian

Index: lib/crc32.c
===================================================================
RCS file: /cvs/linux/lib/crc32.c,v
retrieving revision 1.3
diff -u -r1.3 crc32.c
--- lib/crc32.c	9 Jul 2002 15:23:04 -0000	1.3
+++ lib/crc32.c	23 Nov 2002 18:17:08 -0000
@@ -22,6 +22,15 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <asm/atomic.h>
+#include "crc32defs.h"
+#if CRC_LE_BITS == 8
+#define tole(x) __constant_cpu_to_le32(x)
+#define tobe(x) __constant_cpu_to_be32(x)
+#else
+#define tole(x) (x)
+#define tobe(x) (x)
+#endif
+#include "crc32table.h"
 
 #if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
 #define attribute(x) __attribute__(x)
@@ -40,35 +49,12 @@
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
@@ -89,42 +75,6 @@
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
@@ -135,40 +85,82 @@
  */
 u32 attribute((pure)) crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
-	while (len--) {
 # if CRC_LE_BITS == 8
-		crc = (crc >> 8) ^ crc32table_le[(crc ^ *p++) & 255];
+	const u32      *b =(u32 *)p;
+	const u32      *e;
+	/* load data 32 bits wide, xor data 32 bits wide. */
+
+	crc = __cpu_to_le32(crc);
+	/* Align it */
+	for ( ; ((u32)b)&3 && len ; len--){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	e = (u32 *) ( (u8 *)b + (len & ~7));
+	while (b < e) {
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+# endif
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+# endif
+	}
+	/* And the last few bytes */
+	e = (u32 *)((u8 *)b + (len & 7));
+	while (b < e){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	return __le32_to_cpu(crc) ;
 # elif CRC_LE_BITS == 4
+	while (len--) {
 		crc ^= *p++;
 		crc = (crc >> 4) ^ crc32table_le[crc & 15];
 		crc = (crc >> 4) ^ crc32table_le[crc & 15];
+	}
+	return crc;
 # elif CRC_LE_BITS == 2
+	while (len--) {
 		crc ^= *p++;
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
-# endif
 	}
 	return crc;
+# endif
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
@@ -192,40 +184,6 @@
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
@@ -236,25 +194,80 @@
  */
 u32 attribute((pure)) crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
-	while (len--) {
 # if CRC_BE_BITS == 8
-		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
+	const u32      *b =(u32 *)p;
+	const u32      *e;
+	/* load data 32 bits wide, xor data 32 bits wide. */
+
+	crc = __cpu_to_be32(crc);
+	/* Align it */
+	for ( ; ((u32)b)&3 && len ; len--){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_be[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_be[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	e = (u32 *) ( (u8 *)b + (len & ~7));
+	while (b < e) {
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+# endif
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+# endif
+	}
+	/* And the last few bytes */
+	e = (u32 *)((u8 *)b + (len & 7));
+	while (b < e){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_be[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_be[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	return __be32_to_cpu(crc) ;
 # elif CRC_BE_BITS == 4
+	while (len--) {
 		crc ^= *p++ << 24;
 		crc = (crc << 4) ^ crc32table_be[crc >> 28];
 		crc = (crc << 4) ^ crc32table_be[crc >> 28];
+	}
+	return crc;
 # elif CRC_BE_BITS == 2
+	while (len--) {
 		crc ^= *p++ << 24;
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
-# endif
 	}
 	return crc;
+# endif
 }
 #endif
 
+EXPORT_SYMBOL(crc32_le);
+EXPORT_SYMBOL(crc32_be);
+
 /*
  * A brief CRC tutorial.
  *
@@ -508,9 +521,6 @@
 	int i, j;
 	u32 crc1, crc2, crc3;
 
-	crc32init_le();
-	crc32init_be();
-
 	for (i = 0; i <= SIZE; i++) {
 		printf("\rTesting length %d...", i);
 		fflush(stdout);
@@ -532,40 +542,3 @@
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
Index: lib/Makefile
===================================================================
RCS file: /cvs/linux/lib/Makefile,v
retrieving revision 1.14
diff -u -r1.14 Makefile
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
+++ lib/gen_crc32table.c	2002-11-24 10:58:41.000000000 +0100
@@ -0,0 +1,82 @@
+#include <stdio.h>
+#include "crc32defs.h"
+#include <sys/types.h>
+
+#define ENTRIES_PER_LINE 4
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
+static void output_table(u_int32_t table[], int len, char *trans)
+{
+	int i;
+
+	for (i = 0; i < len - 1; i++) {
+		if (i % ENTRIES_PER_LINE == 0)
+			printf("\n");
+		printf("%s(0x%8.8xL), ", trans, table[i]);
+	}
+	printf("%s(0x%8.8xL)\n", trans, table[len - 1]);
+}
+
+int main(int argc, char** argv)
+{
+	printf("/* this file is generated - do not edit */\n\n");
+
+	if (CRC_LE_BITS > 1) {
+		crc32init_le();
+		printf("static const u32 crc32table_le[] = {");
+		output_table(crc32table_le, LE_TABLE_SIZE, "tole");
+		printf("};\n");
+	}
+
+	if (CRC_BE_BITS > 1) {
+		crc32init_be();
+		printf("static const u32 crc32table_be[] = {");
+		output_table(crc32table_be, BE_TABLE_SIZE, "tobe");
+		printf("};\n");
+	}
+
+	return 0;
+}
--- /dev/null	2002-09-09 21:28:31.000000000 +0200
+++ lib/crc32defs.h	2002-11-21 21:57:51.000000000 +0100
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
