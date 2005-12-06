Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVLFNXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVLFNXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVLFNXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:23:04 -0500
Received: from mail.renesas.com ([202.234.163.13]:6318 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S932197AbVLFNXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:23:03 -0500
Date: Tue, 06 Dec 2005 22:22:59 +0900 (JST)
Message-Id: <20051206.222259.84368946.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.15-rc5-mm1] m32r: Update _port2addr to use
 NONCACHE_OFFSET
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify _port2addr*() routines in arch/m32r/kernel/io_*.c to 
use NONCACHE_OFFSET instead of hard-coding of a constant address.

This modification is also required to support an M3A-ZA36 FPGA eva board
in case an MMU-less synthesizable m32r core is used.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_m32104ut.c |   24 +++++++++----------
 arch/m32r/kernel/io_m32700ut.c |   24 +++++++++----------
 arch/m32r/kernel/io_mappi.c    |    2 -
 arch/m32r/kernel/io_mappi2.c   |   24 +++++++++----------
 arch/m32r/kernel/io_mappi3.c   |   51 ++++++++++++++++++++++++-----------------
 arch/m32r/kernel/io_oaks32r.c  |    2 -
 arch/m32r/kernel/io_opsput.c   |    6 ++--
 include/asm-m32r/m32r.h        |    2 -
 8 files changed, 72 insertions(+), 63 deletions(-)

Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_mappi2.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_mappi2.c	2005-12-06 10:36:03.088915368 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_mappi2.c	2005-12-06 21:03:12.070440664 +0900
@@ -33,7 +33,7 @@ extern void pcc_iowrite_word(int, unsign
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port | (NONCACHE_OFFSET));
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
@@ -42,22 +42,22 @@ static inline void *__port2addr_ata(unsi
 	static int	dummy_reg;
 
 	switch (port) {
-	case 0x1f0:	return (void *)0xac002000;
-	case 0x1f1:	return (void *)0xac012800;
-	case 0x1f2:	return (void *)0xac012002;
-	case 0x1f3:	return (void *)0xac012802;
-	case 0x1f4:	return (void *)0xac012004;
-	case 0x1f5:	return (void *)0xac012804;
-	case 0x1f6:	return (void *)0xac012006;
-	case 0x1f7:	return (void *)0xac012806;
-	case 0x3f6:	return (void *)0xac01200e;
+	case 0x1f0:	return (void *)(0x0c002000 | NONCACHE_OFFSET);
+	case 0x1f1:	return (void *)(0x0c012800 | NONCACHE_OFFSET);
+	case 0x1f2:	return (void *)(0x0c012002 | NONCACHE_OFFSET);
+	case 0x1f3:	return (void *)(0x0c012802 | NONCACHE_OFFSET);
+	case 0x1f4:	return (void *)(0x0c012004 | NONCACHE_OFFSET);
+	case 0x1f5:	return (void *)(0x0c012804 | NONCACHE_OFFSET);
+	case 0x1f6:	return (void *)(0x0c012006 | NONCACHE_OFFSET);
+	case 0x1f7:	return (void *)(0x0c012806 | NONCACHE_OFFSET);
+	case 0x3f6:	return (void *)(0x0c01200e | NONCACHE_OFFSET);
 	default: 	return (void *)&dummy_reg;
 	}
 }
 #endif
 
-#define LAN_IOSTART	0xa0000300
-#define LAN_IOEND	0xa0000320
+#define LAN_IOSTART	(0x300 | NONCACHE_OFFSET)
+#define LAN_IOEND	(0x320 | NONCACHE_OFFSET)
 #ifdef CONFIG_CHIP_OPSP
 static inline void *_port2addr_ne(unsigned long port)
 {
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_m32104ut.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_m32104ut.c	2005-12-06 21:02:17.790692440 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_m32104ut.c	2005-12-06 21:03:12.076439752 +0900
@@ -31,7 +31,7 @@ extern void pcc_iowrite_word(int, unsign
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
@@ -40,15 +40,15 @@ static inline void *__port2addr_ata(unsi
 	static int	dummy_reg;
 
 	switch (port) {
-	case 0x1f0:	return (void *)0xac002000;
-	case 0x1f1:	return (void *)0xac012800;
-	case 0x1f2:	return (void *)0xac012002;
-	case 0x1f3:	return (void *)0xac012802;
-	case 0x1f4:	return (void *)0xac012004;
-	case 0x1f5:	return (void *)0xac012804;
-	case 0x1f6:	return (void *)0xac012006;
-	case 0x1f7:	return (void *)0xac012806;
-	case 0x3f6:	return (void *)0xac01200e;
+	case 0x1f0:	return (void *)(0x0c002000 | NONCACHE_OFFSET);
+	case 0x1f1:	return (void *)(0x0c012800 | NONCACHE_OFFSET);
+	case 0x1f2:	return (void *)(0x0c012002 | NONCACHE_OFFSET);
+	case 0x1f3:	return (void *)(0x0c012802 | NONCACHE_OFFSET);
+	case 0x1f4:	return (void *)(0x0c012004 | NONCACHE_OFFSET);
+	case 0x1f5:	return (void *)(0x0c012804 | NONCACHE_OFFSET);
+	case 0x1f6:	return (void *)(0x0c012006 | NONCACHE_OFFSET);
+	case 0x1f7:	return (void *)(0x0c012806 | NONCACHE_OFFSET);
+	case 0x3f6:	return (void *)(0x0c01200e | NONCACHE_OFFSET);
 	default: 	return (void *)&dummy_reg;
 	}
 }
@@ -59,8 +59,8 @@ static inline void *__port2addr_ata(unsi
  * from 0x01000000 to 0x01ffffff on physical address.
  * The base address of LAN controller(LAN91C111) is 0x300.
  */
-#define LAN_IOSTART	0x300
-#define LAN_IOEND	0x320
+#define LAN_IOSTART	(0x300 | NONCACHE_OFFSET)
+#define LAN_IOEND	(0x320 | NONCACHE_OFFSET)
 static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + NONCACHE_OFFSET + 0x01000000);
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_m32700ut.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_m32700ut.c	2005-12-06 10:36:01.900096096 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_m32700ut.c	2005-12-06 21:03:12.084438536 +0900
@@ -36,7 +36,7 @@ extern void pcc_iowrite_word(int, unsign
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 #if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
@@ -45,15 +45,15 @@ static inline void *__port2addr_ata(unsi
 	static int	dummy_reg;
 
 	switch (port) {
-	case 0x1f0:	return (void *)0xac002000;
-	case 0x1f1:	return (void *)0xac012800;
-	case 0x1f2:	return (void *)0xac012002;
-	case 0x1f3:	return (void *)0xac012802;
-	case 0x1f4:	return (void *)0xac012004;
-	case 0x1f5:	return (void *)0xac012804;
-	case 0x1f6:	return (void *)0xac012006;
-	case 0x1f7:	return (void *)0xac012806;
-	case 0x3f6:	return (void *)0xac01200e;
+	case 0x1f0:	return (void *)(0x0c002000 | NONCACHE_OFFSET);
+	case 0x1f1:	return (void *)(0x0c012800 | NONCACHE_OFFSET);
+	case 0x1f2:	return (void *)(0x0c012002 | NONCACHE_OFFSET);
+	case 0x1f3:	return (void *)(0x0c012802 | NONCACHE_OFFSET);
+	case 0x1f4:	return (void *)(0x0c012004 | NONCACHE_OFFSET);
+	case 0x1f5:	return (void *)(0x0c012804 | NONCACHE_OFFSET);
+	case 0x1f6:	return (void *)(0x0c012006 | NONCACHE_OFFSET);
+	case 0x1f7:	return (void *)(0x0c012806 | NONCACHE_OFFSET);
+	case 0x3f6:	return (void *)(0x0c01200e | NONCACHE_OFFSET);
 	default: 	return (void *)&dummy_reg;
 	}
 }
@@ -64,8 +64,8 @@ static inline void *__port2addr_ata(unsi
  * from 0x10000000 to 0x13ffffff on physical address.
  * The base address of LAN controller(LAN91C111) is 0x300.
  */
-#define LAN_IOSTART	0xa0000300
-#define LAN_IOEND	0xa0000320
+#define LAN_IOSTART	(0x300 | NONCACHE_OFFSET)
+#define LAN_IOEND	(0x320 | NONCACHE_OFFSET)
 static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + 0x10000000);
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_mappi.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_mappi.c	2005-12-04 14:10:42.000000000 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_mappi.c	2005-12-06 21:03:12.092437320 +0900
@@ -31,7 +31,7 @@ extern void pcc_iowrite(int, unsigned lo
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port | (NONCACHE_OFFSET));
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 static inline void *_port2addr_ne(unsigned long port)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_mappi3.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_mappi3.c	2005-12-06 10:36:01.914093968 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_mappi3.c	2005-12-06 21:03:12.101435952 +0900
@@ -33,7 +33,7 @@ extern void pcc_iowrite_word(int, unsign
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 #if defined(CONFIG_IDE)
@@ -43,33 +43,42 @@ static inline void *__port2addr_ata(unsi
 
 	switch (port) {
 	  /* IDE0 CF */
-	case 0x1f0:	return (void *)0xb4002000;
-	case 0x1f1:	return (void *)0xb4012800;
-	case 0x1f2:	return (void *)0xb4012002;
-	case 0x1f3:	return (void *)0xb4012802;
-	case 0x1f4:	return (void *)0xb4012004;
-	case 0x1f5:	return (void *)0xb4012804;
-	case 0x1f6:	return (void *)0xb4012006;
-	case 0x1f7:	return (void *)0xb4012806;
-	case 0x3f6:	return (void *)0xb401200e;
+	case 0x1f0:	return (void *)(0x14002000 | NONCACHE_OFFSET);
+	case 0x1f1:	return (void *)(0x14012800 | NONCACHE_OFFSET);
+	case 0x1f2:	return (void *)(0x14012002 | NONCACHE_OFFSET);
+	case 0x1f3:	return (void *)(0x14012802 | NONCACHE_OFFSET);
+	case 0x1f4:	return (void *)(0x14012004 | NONCACHE_OFFSET);
+	case 0x1f5:	return (void *)(0x14012804 | NONCACHE_OFFSET);
+	case 0x1f6:	return (void *)(0x14012006 | NONCACHE_OFFSET);
+	case 0x1f7:	return (void *)(0x14012806 | NONCACHE_OFFSET);
+	case 0x3f6:	return (void *)(0x1401200e | NONCACHE_OFFSET);
 	  /* IDE1 IDE */
-	case 0x170:	return (void *)0xb4810000;  /* Data 16bit */
-	case 0x171:	return (void *)0xb4810002;  /* Features / Error */
-	case 0x172:	return (void *)0xb4810004;  /* Sector count */
-	case 0x173:	return (void *)0xb4810006;  /* Sector number */
-	case 0x174:	return (void *)0xb4810008;  /* Cylinder low */
-	case 0x175:	return (void *)0xb481000a;  /* Cylinder high */
-	case 0x176:	return (void *)0xb481000c;  /* Device head */
-	case 0x177:	return (void *)0xb481000e;  /* Command     */
-	case 0x376:	return (void *)0xb480800c;  /* Device control / Alt status */
+	case 0x170:	/* Data 16bit */
+			return (void *)(0x14810000 | NONCACHE_OFFSET);
+	case 0x171:	/* Features / Error */
+			return (void *)(0x14810002 | NONCACHE_OFFSET);
+	case 0x172:	/* Sector count */
+			return (void *)(0x14810004 | NONCACHE_OFFSET);
+	case 0x173:	/* Sector number */
+			return (void *)(0x14810006 | NONCACHE_OFFSET);
+	case 0x174:	/* Cylinder low */
+			return (void *)(0x14810008 | NONCACHE_OFFSET);
+	case 0x175:	/* Cylinder high */
+			return (void *)(0x1481000a | NONCACHE_OFFSET);
+	case 0x176:	/* Device head */
+			return (void *)(0x1481000c | NONCACHE_OFFSET);
+	case 0x177:	/* Command     */
+			return (void *)(0x1481000e | NONCACHE_OFFSET);
+	case 0x376:	/* Device control / Alt status */
+			return (void *)(0x1480800c | NONCACHE_OFFSET);
 
 	default: 	return (void *)&dummy_reg;
 	}
 }
 #endif
 
-#define LAN_IOSTART	0xa0000300
-#define LAN_IOEND	0xa0000320
+#define LAN_IOSTART	(0x300 | NONCACHE_OFFSET)
+#define LAN_IOEND	(0x320 | NONCACHE_OFFSET)
 static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + 0x10000000);
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_oaks32r.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_oaks32r.c	2005-12-04 14:10:42.000000000 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_oaks32r.c	2005-12-06 21:03:12.108434888 +0900
@@ -16,7 +16,7 @@
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port | (NONCACHE_OFFSET));
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 static inline  void *_port2addr_ne(unsigned long port)
Index: linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_opsput.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/m32r/kernel/io_opsput.c	2005-12-06 10:36:01.295188056 +0900
+++ linux-2.6.15-rc5-mm1/arch/m32r/kernel/io_opsput.c	2005-12-06 21:03:12.115433824 +0900
@@ -36,7 +36,7 @@ extern void pcc_iowrite_word(int, unsign
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port | (NONCACHE_OFFSET));
+	return (void *)(port | NONCACHE_OFFSET);
 }
 
 /*
@@ -44,8 +44,8 @@ static inline void *_port2addr(unsigned 
  * from 0x10000000 to 0x13ffffff on physical address.
  * The base address of LAN controller(LAN91C111) is 0x300.
  */
-#define LAN_IOSTART	0xa0000300
-#define LAN_IOEND	0xa0000320
+#define LAN_IOSTART	(0x300 | NONCACHE_OFFSET)
+#define LAN_IOEND	(0x320 | NONCACHE_OFFSET)
 static inline void *_port2addr_ne(unsigned long port)
 {
 	return (void *)(port + 0x10000000);
Index: linux-2.6.15-rc5-mm1/include/asm-m32r/m32r.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/include/asm-m32r/m32r.h	2005-12-06 21:02:17.866680888 +0900
+++ linux-2.6.15-rc5-mm1/include/asm-m32r/m32r.h	2005-12-06 21:03:12.124432456 +0900
@@ -126,7 +126,7 @@
 
 #include <asm/page.h>
 #ifdef CONFIG_MMU
-#define NONCACHE_OFFSET  __PAGE_OFFSET+0x20000000
+#define NONCACHE_OFFSET  (__PAGE_OFFSET + 0x20000000)
 #else
 #define NONCACHE_OFFSET  __PAGE_OFFSET
 #endif /* CONFIG_MMU */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
