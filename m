Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263932AbTCVWhA>; Sat, 22 Mar 2003 17:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263933AbTCVWhA>; Sat, 22 Mar 2003 17:37:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8581
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263932AbTCVWg5>; Sat, 22 Mar 2003 17:36:57 -0500
Date: Sat, 22 Mar 2003 23:52:39 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222352.h2MNqdxY020679@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: abstract out mach_reboot for x86 platforms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/arch/i386/kernel/reboot.c linux-2.5.65-ac3/arch/i386/kernel/reboot.c
--- linux-2.5.65-bk3/arch/i386/kernel/reboot.c	2003-03-22 19:33:19.000000000 +0000
+++ linux-2.5.65-ac3/arch/i386/kernel/reboot.c	2003-02-14 22:48:47.000000000 +0000
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include "mach_reboot.h"
 
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/include/asm-i386/mach-default/mach_reboot.h linux-2.5.65-ac3/include/asm-i386/mach-default/mach_reboot.h
--- linux-2.5.65-bk3/include/asm-i386/mach-default/mach_reboot.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac3/include/asm-i386/mach-default/mach_reboot.h	2003-02-14 22:59:20.000000000 +0000
@@ -0,0 +1,30 @@
+/*
+ *  arch/i386/mach-generic/mach_reboot.h
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/include/asm-i386/mach-pc9800/mach_reboot.h linux-2.5.65-ac3/include/asm-i386/mach-pc9800/mach_reboot.h
--- linux-2.5.65-bk3/include/asm-i386/mach-pc9800/mach_reboot.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.65-ac3/include/asm-i386/mach-pc9800/mach_reboot.h	2003-02-14 22:59:47.000000000 +0000
@@ -0,0 +1,21 @@
+/*
+ *  arch/i386/mach-pc9800/mach_reboot.h
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
