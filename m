Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262970AbTCUCbm>; Thu, 20 Mar 2003 21:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263012AbTCUCbm>; Thu, 20 Mar 2003 21:31:42 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:53120 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262970AbTCUCbi>; Thu, 20 Mar 2003 21:31:38 -0500
Date: Fri, 21 Mar 2003 11:41:51 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (3/14) misc core
Message-ID: <20030321024151.GC1847@yuzuki.cinet.co.jp>
References: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321022850.GA1767@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac1. (3/14)

Small patches for PC98 core support.
io.h: Using ioport 0x5f to wait is recomended by vendor.
irq.h: Cascade IRQ is 7 for PC98 not 2.
pc98*.h: Add macros to access BIOS parameters.
kernel.h: define "pc98" for other files.
I think these are small and clean.

Regards,
Osamu Tomita

diff -Nru linux/include/asm-i386/io.h linux98/include/asm-i386/io.h
--- linux/include/asm-i386/io.h	2002-10-12 13:22:45.000000000 +0900
+++ linux98/include/asm-i386/io.h	2002-10-12 19:25:19.000000000 +0900
@@ -27,6 +27,8 @@
  *		Linus
  */
 
+#include <linux/config.h>
+
  /*
   *  Bit simplified and optimized by Jan Hubicka
   *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999.
@@ -288,7 +290,11 @@
 #ifdef SLOW_IO_BY_JUMPING
 #define __SLOW_DOWN_IO "jmp 1f; 1: jmp 1f; 1:"
 #else
+#ifdef CONFIG_X86_PC9800
+#define __SLOW_DOWN_IO "outb %%al,$0x5f;"
+#else
 #define __SLOW_DOWN_IO "outb %%al,$0x80;"
+#endif
 #endif
 
 static inline void slow_down_io(void) {
diff -Nru linux/include/asm-i386/irq.h linux98/include/asm-i386/irq.h
--- linux/include/asm-i386/irq.h	2002-09-21 00:20:16.000000000 +0900
+++ linux98/include/asm-i386/irq.h	2002-09-21 07:17:56.000000000 +0900
@@ -17,7 +17,11 @@
 
 static __inline__ int irq_cannonicalize(int irq)
 {
+#ifdef CONFIG_X86_PC9800
+	return ((irq == 7) ? 11 : irq);
+#else
 	return ((irq == 2) ? 9 : irq);
+#endif
 }
 
 extern void disable_irq(unsigned int);
diff -Nru linux/include/asm-i386/pc9800.h linux98/include/asm-i386/pc9800.h
--- linux/include/asm-i386/pc9800.h	1970-01-01 09:00:00.000000000 +0900
+++ linux98/include/asm-i386/pc9800.h	2002-08-17 21:50:18.000000000 +0900
@@ -0,0 +1,27 @@
+/*
+ *  PC-9800 machine types.
+ *
+ *  Copyright (C) 1999	TAKAI Kosuke <tak@kmc.kyoto-u.ac.jp>
+ *			(Linux/98 Project)
+ */
+
+#ifndef _ASM_PC9800_H_
+#define _ASM_PC9800_H_
+
+#include <asm/pc9800_sca.h>
+#include <asm/types.h>
+
+#define __PC9800SCA(type, pa)	(*(type *) phys_to_virt(pa))
+#define __PC9800SCA_TEST_BIT(pa, n)	\
+	((__PC9800SCA(u8, pa) & (1U << (n))) != 0)
+
+#define PC9800_HIGHRESO_P()	__PC9800SCA_TEST_BIT(PC9800SCA_BIOS_FLAG, 3)
+#define PC9800_8MHz_P()		__PC9800SCA_TEST_BIT(PC9800SCA_BIOS_FLAG, 7)
+
+				/* 0x2198 is 98 21 on memory... */
+#define PC9800_9821_P()		(__PC9800SCA(u16, PC9821SCA_ROM_ID) == 0x2198)
+
+/* Note PC9821_...() are valid only when PC9800_9821_P() was true. */
+#define PC9821_IDEIF_DOUBLE_P()	__PC9800SCA_TEST_BIT(PC9821SCA_ROM_FLAG4, 4)
+
+#endif
diff -Nru linux-2.5.65/include/linux/kernel.h linux98-2.5.65/include/linux/kernel.h
--- linux-2.5.65/include/linux/kernel.h	2003-03-18 06:43:37.000000000 +0900
+++ linux98-2.5.65/include/linux/kernel.h	2003-03-20 10:21:22.000000000 +0900
@@ -235,4 +235,10 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+#ifdef CONFIG_X86_PC9800
+#define pc98 1
+#else
+#define pc98 0
+#endif
+
 #endif
