Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTDGDkX (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTDGDkW (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:40:22 -0400
Received: from chii.cinet.co.jp ([61.197.228.217]:44673 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S263228AbTDGDkO (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:40:14 -0400
Date: Mon, 7 Apr 2003 12:49:56 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-ac2] PC-9800 sub architecture support (3/9) core
Message-ID: <20030407034956.GC4840@yuzuki.cinet.co.jp>
References: <20030407033627.GA4798@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407033627.GA4798@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.66-ac2. (3/9)

Small patches for PC98 core support.
io.h: Using ioport 0x5f to wait is recomended by vendor.
irq.h: Cascade IRQ is 7 for PC98 not 2.
pc9800.h: Add macros to access BIOS parameters.

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
