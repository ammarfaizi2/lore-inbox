Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTBQN65>; Mon, 17 Feb 2003 08:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBQN65>; Mon, 17 Feb 2003 08:58:57 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:20096 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267176AbTBQN5p>; Mon, 17 Feb 2003 08:57:45 -0500
Date: Mon, 17 Feb 2003 23:06:19 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (7/26) misc core
Message-ID: <20030217140619.GG4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (7/26).

Small core patches for PC98. I think these are small and clean.

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
+#ifndef CONFIG_X86_PC9800
 #define __SLOW_DOWN_IO "outb %%al,$0x80;"
+#else
+#define __SLOW_DOWN_IO "outb %%al,$0x5f;"
+#endif
 #endif
 
 static inline void slow_down_io(void) {
diff -Nru linux/include/asm-i386/irq.h linux98/include/asm-i386/irq.h
--- linux/include/asm-i386/irq.h	2002-09-21 00:20:16.000000000 +0900
+++ linux98/include/asm-i386/irq.h	2002-09-21 07:17:56.000000000 +0900
@@ -17,7 +17,11 @@
 
 static __inline__ int irq_cannonicalize(int irq)
 {
+#ifndef CONFIG_X86_PC9800
 	return ((irq == 2) ? 9 : irq);
+#else
+	return ((irq == 7) ? 11 : irq);
+#endif
 }
 
 extern void disable_irq(unsigned int);
diff -Nru linux-2.5.50/include/asm-i386/pc9800_sca.h linux98-2.5.50/include/asm-i386/pc9800_sca.h
--- linux-2.5.50/include/asm-i386/pc9800_sca.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.50/include/asm-i386/pc9800_sca.h	2002-10-31 15:06:16.000000000 +0000
@@ -0,0 +1,25 @@
+/*
+ *  System-common area definitions for NEC PC-9800 series
+ *
+ *  Copyright (C) 1999	TAKAI Kousuke <tak@kmc.kyoto-u.ac.jp>,
+ *			Kyoto University Microcomputer Club.
+ */
+
+#ifndef _ASM_I386_PC9800SCA_H_
+#define _ASM_I386_PC9800SCA_H_
+
+#define PC9800SCA_EXPMMSZ		(0x0401)	/* B */
+#define PC9800SCA_SCSI_PARAMS		(0x0460)	/* 8 * 4B */
+#define PC9800SCA_DISK_EQUIPS		(0x0482)	/* B */
+#define PC9800SCA_XROM_ID		(0x04C0)	/* 52B */
+#define PC9800SCA_BIOS_FLAG		(0x0501)	/* B */
+#define PC9800SCA_MMSZ16M		(0x0594)	/* W */
+
+/* PC-9821 have additional system common area in their BIOS-ROM segment. */
+
+#define PC9821SCA__BASE			(0xF8E8 << 4)
+#define PC9821SCA_ROM_ID		(PC9821SCA__BASE + 0x00)
+#define PC9821SCA_ROM_FLAG4		(PC9821SCA__BASE + 0x05)
+#define PC9821SCA_RSFLAGS		(PC9821SCA__BASE + 0x11)	/* B */
+
+#endif /* !_ASM_I386_PC9800SCA_H_ */
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
diff -Nru linux-2.5.60/include/asm-i386/pgtable.h linux98-2.5.60/include/asm-i386/pgtable.h
--- linux-2.5.60/include/asm-i386/pgtable.h	2003-02-11 03:38:48.000000000 +0900
+++ linux98-2.5.60/include/asm-i386/pgtable.h	2003-02-11 12:56:40.000000000 +0900
@@ -49,7 +49,11 @@
 
 #endif
 
+#ifndef CONFIG_X86_PC9800
 #define __beep() asm("movb $0x3,%al; outb %al,$0x61")
+#else
+#define __beep() asm("movb $0x6,%al; outb %al,$0x37")
+#endif
 
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
diff -Nru linux-2.5.50/include/asm-i386/setup.h linux98-2.5.50/include/asm-i386/setup.h
--- linux-2.5.50/include/asm-i386/setup.h	2002-11-25 15:09:32.000000000 +0000
+++ linux98-2.5.50/include/asm-i386/setup.h	2002-10-31 15:06:16.000000000 +0000
@@ -28,6 +28,7 @@
 #define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAM+0x40))
 #define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
 #define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
+#define PC9800_MISC_FLAGS (*(unsigned char *)(PARAM+0x1AF))
 #define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
 #define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
 #define VIDEO_MODE (*(unsigned short *) (PARAM+0x1FA))
diff -Nru linux/include/linux/kernel.h linux98/include/linux/kernel.h
--- linux/include/linux/kernel.h	2003-01-14 14:58:03.000000000 +0900
+++ linux98/include/linux/kernel.h	2003-01-14 23:11:42.000000000 +0900
@@ -224,4 +224,10 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+#ifdef CONFIG_X86_PC9800
+#define pc98 1
+#else
+#define pc98 0
+#endif
+
 #endif
