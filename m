Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbTBQONL>; Mon, 17 Feb 2003 09:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267215AbTBQOMZ>; Mon, 17 Feb 2003 09:12:25 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:32640 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267242AbTBQOLm>; Mon, 17 Feb 2003 09:11:42 -0500
Date: Mon, 17 Feb 2003 23:20:18 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.61 (22/26) reboot
Message-ID: <20030217142018.GV4799@yuzuki.cinet.co.jp>
References: <20030217134333.GA4734@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217134333.GA4734@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.61 (22/26).

Support difference of machine reboot method, using mach-* scheme.

diff -Nru linux-2.5.53/arch/i386/kernel/reboot.c linux98-2.5.53/arch/i386/kernel/reboot.c
--- linux-2.5.53/arch/i386/kernel/reboot.c	2002-12-24 14:19:53.000000000 +0900
+++ linux98-2.5.53/arch/i386/kernel/reboot.c	2002-12-26 10:46:08.000000000 +0900
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <mach_reboot.h>
 
 /*
  * Power off function, if any
@@ -125,15 +126,6 @@
 	0xea, 0x00, 0x00, 0xff, 0xff		/*    ljmp  $0xffff,$0x0000  */
 };
 
-static inline void kb_wait(void)
-{
-	int i;
-
-	for (i=0; i<0x10000; i++)
-		if ((inb_p(0x64) & 0x02) == 0)
-			break;
-}
-
 /*
  * Switch to real mode and then execute the code
  * specified by the code and length parameters.
@@ -264,13 +256,7 @@
 		/* rebooting needs to touch the page at absolute addr 0 */
 		*((unsigned short *)__va(0x472)) = reboot_mode;
 		for (;;) {
-			int i;
-			for (i=0; i<100; i++) {
-				kb_wait();
-				udelay(50);
-				outb(0xfe,0x64);         /* pulse reset low */
-				udelay(50);
-			}
+			mach_reboot();
 			/* That didn't work - force a triple fault.. */
 			__asm__ __volatile__("lidt %0": :"m" (no_idt));
 			__asm__ __volatile__("int3");
diff -Nru linux-2.5.53/include/asm-i386/mach-default/mach_reboot.h linux98-2.5.53/include/asm-i386/mach-default/mach_reboot.h
--- linux-2.5.53/include/asm-i386/mach-default/mach_reboot.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-default/mach_reboot.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  include/asm-i386/mach-default/mach_reboot.h
+ *
+ *  Machine specific reboot functions for generic.
+ *  Split out from reboot.c by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_REBOOT_H
+#define _MACH_REBOOT_H
+
+static inline void kb_wait(void)
+{
+	int i;
+
+	for (i = 0; i < 0x10000; i++)
+		if ((inb_p(0x64) & 0x02) == 0)
+			break;
+}
+
+static inline void mach_reboot(void)
+{
+	int i;
+	for (i = 0; i < 100; i++) {
+		kb_wait();
+		udelay(50);
+		outb(0xfe, 0x64);         /* pulse reset low */
+		udelay(50);
+	}
+}
+
+#endif /* !_MACH_REBOOT_H */
diff -Nru linux-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h linux98-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h
--- linux-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h	1970-01-01 01:00:00.000000000 +0100
+++ linux98-2.5.53/include/asm-i386/mach-pc9800/mach_reboot.h	2002-10-31 15:05:52.000000000 +0000
@@ -0,0 +1,21 @@
+/*
+ *  include/asm-i386/mach-pc9800/mach_reboot.h
+ *
+ *  Machine specific reboot functions for PC-9800.
+ *  Written by Osamu Tomita <tomita@cinet.co.jp>
+ */
+#ifndef _MACH_REBOOT_H
+#define _MACH_REBOOT_H
+
+#ifdef CMOS_WRITE
+#undef CMOS_WRITE
+#define CMOS_WRITE(a,b)	do{}while(0)
+#endif
+
+static inline void mach_reboot(void)
+{
+	outb(0, 0xf0);		/* signal CPU reset */
+	mdelay(1);
+}
+
+#endif /* !_MACH_REBOOT_H */
