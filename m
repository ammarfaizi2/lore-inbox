Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSKYCz4>; Sun, 24 Nov 2002 21:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSKYCz4>; Sun, 24 Nov 2002 21:55:56 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:58324 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S262392AbSKYCzx>; Sun, 24 Nov 2002 21:55:53 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.49-uc0 (MMU-less fix ups)
References: <3DDF81F5.5050809@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Nov 2002 11:59:51 +0900
In-Reply-To: <3DDF81F5.5050809@snapgear.com>
Message-ID: <buok7j2cq1k.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

v850 update for 2.5.49-uc0:



--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.5.49-uc0-v850-20021125-dist.patch
Content-Description: linux-2.5.49-uc0-v850-20021125-dist.patch

diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/as85ep1.ld arch/v850/as85ep1.ld
--- ../orig/linux-2.5.49-uc0/arch/v850/as85ep1.ld	2002-11-25 10:34:43.000000000 +0900
+++ arch/v850/as85ep1.ld	2002-11-25 11:40:26.000000000 +0900
@@ -13,10 +13,11 @@
        /* 1MB of static RAM.  */
        SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
 
-       /* 64MB of DRAM.  This can actually be at one of two positions,
-       determined by jump JP3; we use the second position because the
-       first only allows access to 56MB.  */
-       SDRAM : ORIGIN = 0x04000000, LENGTH = 0x04000000
+       /* About 58MB of DRAM.  This can actually be at one of two positions,
+	  determined by jump JP3; we have to use the first position because the
+	  second is partially out of processor instruction addressing range
+	  (though in the second position there's actually 64MB available).  */
+       SDRAM : ORIGIN = 0x00600000, LENGTH = 0x039F8000
 }
 
 SECTIONS {
@@ -138,6 +139,7 @@
 
 	/* Device contents for the root filesystem.  */
 	.root : {
+		. = ALIGN (4096) ;
 		__root_fs_image_start = . ;
 		*(.root)
 		__root_fs_image_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/anna.c arch/v850/kernel/anna.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/anna.c	2002-11-25 10:34:43.000000000 +0900
+++ arch/v850/kernel/anna.c	2002-11-25 11:40:26.000000000 +0900
@@ -33,7 +33,7 @@
 #define RAM_END		(SDRAM_ADDR + SDRAM_SIZE)
 
 /* The bits of this port are connected to an 8-LED bar-graph.  */
-#define LEDS_PORT	4
+#define LEDS_PORT	0
 
 
 static void anna_led_tick (void);
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/arch/v850/kernel/process.c arch/v850/kernel/process.c
--- ../orig/linux-2.5.49-uc0/arch/v850/kernel/process.c	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/kernel/process.c	2002-11-25 10:48:50.000000000 +0900
@@ -231,7 +231,7 @@
    are in entry.S).  */
 int fork_common (int flags, unsigned long new_sp, struct pt_regs *regs)
 {
-	struct task_struct *p = do_fork (flags, new_sp, regs, 0, 0);
+	struct task_struct *p = do_fork (flags, new_sp, regs, 0, 0, 0);
 	return IS_ERR (p) ? PTR_ERR (p) : p->pid;
 }
 
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/asm-v850/as85ep1.h include/asm-v850/as85ep1.h
--- ../orig/linux-2.5.49-uc0/include/asm-v850/as85ep1.h	2002-11-25 10:34:44.000000000 +0900
+++ include/asm-v850/as85ep1.h	2002-11-25 11:40:26.000000000 +0900
@@ -21,19 +21,19 @@
 #define PLATFORM	"AS85EP1"
 #define PLATFORM_LONG	"NEC V850E/AS85EP1 evaluation board"
 
-#define CPU_CLOCK_FREQ	100000000 /*  100MHz */
+#define CPU_CLOCK_FREQ	96000000 /*  96MHz */
 #define SYS_CLOCK_FREQ	CPU_CLOCK_FREQ
 
 
 /* 1MB of static RAM.  */
 #define SRAM_ADDR	0x00400000
 #define SRAM_SIZE	0x00100000 /* 1MB */
-/* 64MB of DRAM.  This can actually be at one of two positions, determined
-   by jump JP3; we use the second position because the first only allows
-   access to 56MB.  */
-#define SDRAM_ADDR	0x04000000
-#define SDRAM_SIZE	0x04000000 /* 64MB */
-
+/* About 58MB of DRAM.  This can actually be at one of two positions,
+   determined by jump JP3; we have to use the first position because the
+   second is partially out of processor instruction addressing range
+   (though in the second position there's actually 64MB available).  */
+#define SDRAM_ADDR	0x00600000
+#define SDRAM_SIZE	0x039F8000 /* approx 58MB */
 
 /* For <asm/page.h> */
 #define PAGE_OFFSET 	SRAM_ADDR
diff -ruN -X../cludes ../orig/linux-2.5.49-uc0/include/asm-v850/nb85e_uart.h include/asm-v850/nb85e_uart.h
--- ../orig/linux-2.5.49-uc0/include/asm-v850/nb85e_uart.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/nb85e_uart.h	2002-11-25 11:40:26.000000000 +0900
@@ -43,6 +43,9 @@
 #define NB85E_UART_BRGC_ADDR(n)		(NB85E_UART_BASE_ADDR(n) + 0x7)
 #endif
 
+#ifndef NB85E_UART_CKSR_MAX_FREQ
+#define NB85E_UART_CKSR_MAX_FREQ (25*1000*1000)
+#endif
 
 /* UART config registers.  */
 #define NB85E_UART_ASIM(n)	(*(volatile u8 *)NB85E_UART_ASIM_ADDR(n))
@@ -81,7 +84,6 @@
 /* UART baud-rate generator control registers.  */
 #define NB85E_UART_CKSR(n)	(*(volatile u8 *)NB85E_UART_CKSR_ADDR(n))
 #define NB85E_UART_CKSR_MAX	11
-#define NB85E_UART_CKSR_MAX_FREQ (25*1000*1000)
 #define NB85E_UART_BRGC(n)	(*(volatile u8 *)NB85E_UART_BRGC_ADDR(n))
 
 

--=-=-=



Thanks,

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that 
            will  make every christian in the world foamm at the mouth? 
[iddt]      nurg, that's the goal 

--=-=-=--
