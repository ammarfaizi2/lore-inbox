Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSJ1Rcd>; Mon, 28 Oct 2002 12:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSJ1Rat>; Mon, 28 Oct 2002 12:30:49 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:61455 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261401AbSJ1RXr>; Mon, 28 Oct 2002 12:23:47 -0500
Date: Tue, 29 Oct 2002 02:30:09 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 11/23] add support for PC-9800 architecture (kernel)
Message-ID: <20021029023009.A2283@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 11/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
  - add PC-9800 special features.
  - CLOCK_TICK is not constant.

diffstat:
 init/main.c    |    3 +++
 kernel/dma.c   |    3 +++
 kernel/ksyms.c |    4 ++++
 kernel/timer.c |    5 +++++
 4 files changed, 15 insertions(+)

patch:
diff -urN linux/init/main.c linux98/init/main.c
--- linux/init/main.c	Sat Oct 19 13:01:16 2002
+++ linux98/init/main.c	Sat Oct 26 16:51:01 2002
@@ -99,6 +99,9 @@
 
 char *execute_command;
 
+/* Indicates PC-9800 architecture  No:0 Yes:1 */
+int pc98 = 0;
+
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = UINT_MAX;
 
diff -urN linux/kernel/dma.c linux98/kernel/dma.c
--- linux/kernel/dma.c	Sun Aug 11 10:41:22 2002
+++ linux98/kernel/dma.c	Wed Aug 21 09:53:59 2002
@@ -9,6 +9,7 @@
  *   [It also happened to remove the sizeof(char *) == sizeof(int)
  *   assumption introduced because of those /proc/dma patches. -- Hennus]
  */
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -62,10 +63,12 @@
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 },
+#ifndef CONFIG_PC9800
 	{ 1, "cascade" },
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 }
+#endif
 };
 
 
diff -urN linux/kernel/ksyms.c linux98/kernel/ksyms.c
--- linux/kernel/ksyms.c	Sat Oct 19 13:01:08 2002
+++ linux98/kernel/ksyms.c	Sat Oct 26 16:57:37 2002
@@ -599,5 +599,9 @@
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
+/* Indicates PC-9800 architecture  No:0 Yes:1 */
+extern int pc98;
+EXPORT_SYMBOL(pc98);
+
 /* debug */
 EXPORT_SYMBOL(dump_stack);
diff -urN linux/kernel/timer.c linux98/kernel/timer.c
--- linux/kernel/timer.c	Sat Oct 12 13:21:36 2002
+++ linux98/kernel/timer.c	Sat Oct 12 14:18:54 2002
@@ -376,8 +376,13 @@
 /*
  * Timekeeping variables
  */
+#ifndef CONFIG_PC9800
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+#else
+extern unsigned long tick_usec; 		/* ACTHZ   period (usec) */
+extern unsigned long tick_nsec;			/* USER_HZ period (nsec) */
+#endif
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
