Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTJTHX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTJTHWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:22:42 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:35813 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262419AbTJTHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Don't reserve root-filesystem memory twice on v850 platforms
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031020072157.8AD203723@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 20 Oct 2003 16:21:57 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This reservation is handled by platform-independent code in 2.6.0, but some
platforms _also_ did it in platform-specific code (left over from 2.4.x).

[Please apply -- this problem prevents these platforms from booting.]

diff -ruN -X../cludes linux-2.6.0-test8-uc0/arch/v850/kernel/as85ep1.c linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/as85ep1.c
--- linux-2.6.0-test8-uc0/arch/v850/kernel/as85ep1.c	2003-10-09 11:54:16.000000000 +0900
+++ linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/as85ep1.c	2003-10-20 13:47:42.000000000 +0900
@@ -114,22 +114,10 @@
 
 void __init mach_reserve_bootmem ()
 {
-	extern char _root_fs_image_start, _root_fs_image_end;
-	u32 root_fs_image_start = (u32)&_root_fs_image_start;
-	u32 root_fs_image_end = (u32)&_root_fs_image_end;
-
 	if (SDRAM_ADDR < RAM_END && SDRAM_ADDR > RAM_START)
 		/* We can't use the space between SRAM and SDRAM, so
 		   prevent the kernel from trying.  */
 		reserve_bootmem (SRAM_END, SDRAM_ADDR - SRAM_END);
-
-	/* Reserve the memory used by the root filesystem image if it's
-	   in RAM.  */
-	if (root_fs_image_end > root_fs_image_start
-	    && root_fs_image_start >= RAM_START
-	    && root_fs_image_start < RAM_END)
-		reserve_bootmem (root_fs_image_start,
-				 root_fs_image_end - root_fs_image_start);
 }
 
 void mach_gettimeofday (struct timespec *tv)
diff -ruN -X../cludes linux-2.6.0-test8-uc0/arch/v850/kernel/rte_me2_cb.c linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/rte_me2_cb.c
--- linux-2.6.0-test8-uc0/arch/v850/kernel/rte_me2_cb.c	2003-07-28 10:13:58.000000000 +0900
+++ linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/rte_me2_cb.c	2003-10-20 13:47:42.000000000 +0900
@@ -53,19 +53,6 @@
 	*ram_len = RAM_END - RAM_START;
 }
 
-void __init mach_reserve_bootmem ()
-{
-	extern char _root_fs_image_start, _root_fs_image_end;
-	u32 root_fs_image_start = (u32)&_root_fs_image_start;
-	u32 root_fs_image_end = (u32)&_root_fs_image_end;
-
-	/* Reserve the memory used by the root filesystem image if it's
-	   in RAM.  */
-	if (root_fs_image_start >= RAM_START && root_fs_image_start < RAM_END)
-		reserve_bootmem (root_fs_image_start,
-				 root_fs_image_end - root_fs_image_start);
-}
-
 void mach_gettimeofday (struct timespec *tv)
 {
 	tv->tv_sec = 0;
diff -ruN -X../cludes linux-2.6.0-test8-uc0/arch/v850/kernel/rte_nb85e_cb.c linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/rte_nb85e_cb.c
--- linux-2.6.0-test8-uc0/arch/v850/kernel/rte_nb85e_cb.c	2003-07-28 10:13:58.000000000 +0900
+++ linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/rte_nb85e_cb.c	2003-10-20 13:47:42.000000000 +0900
@@ -54,21 +54,6 @@
 	*ram_len = SDRAM_SIZE;
 }
 
-void __init mach_reserve_bootmem ()
-{
-	extern char _root_fs_image_start, _root_fs_image_end;
-	u32 root_fs_image_start = (u32)&_root_fs_image_start;
-	u32 root_fs_image_end = (u32)&_root_fs_image_end;
-
-	/* Reserve the memory used by the root filesystem image if it's
-	   in SDRAM.  */
-	if (root_fs_image_end > root_fs_image_start
-	    && root_fs_image_start >= SDRAM_ADDR
-	    && root_fs_image_start < (SDRAM_ADDR + SDRAM_SIZE))
-		reserve_bootmem (root_fs_image_start,
-				 root_fs_image_end - root_fs_image_start);
-}
-
 void mach_gettimeofday (struct timespec *tv)
 {
 	tv->tv_sec = 0;
diff -ruN -X../cludes linux-2.6.0-test8-uc0/arch/v850/kernel/sim85e2.c linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/sim85e2.c
--- linux-2.6.0-test8-uc0/arch/v850/kernel/sim85e2.c	2003-10-09 11:54:17.000000000 +0900
+++ linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/sim85e2.c	2003-10-20 13:47:42.000000000 +0900
@@ -150,21 +150,6 @@
 	*ram_len = RAM_END - RAM_START;
 }
 
-void __init mach_reserve_bootmem ()
-{
-	extern char _root_fs_image_start, _root_fs_image_end;
-	u32 root_fs_image_start = (u32)&_root_fs_image_start;
-	u32 root_fs_image_end = (u32)&_root_fs_image_end;
-
-	/* Reserve the memory used by the root filesystem image if it's
-	   in RAM.  */
-	if (root_fs_image_end > root_fs_image_start
-	    && root_fs_image_start >= RAM_START
-	    && root_fs_image_start < RAM_END)
-		reserve_bootmem (root_fs_image_start,
-				 root_fs_image_end - root_fs_image_start);
-}
-
 void __init mach_sched_init (struct irqaction *timer_action)
 {
 	/* The simulator actually cycles through all interrupts
