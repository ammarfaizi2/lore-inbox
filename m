Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268128AbTAJEFP>; Thu, 9 Jan 2003 23:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbTAJEFP>; Thu, 9 Jan 2003 23:05:15 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:39665 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S268128AbTAJEFO>; Thu, 9 Jan 2003 23:05:14 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Add support for ROM kernel on v850 AS85EP1 target [try #2]
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030110041345.E4EBE3701@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 10 Jan 2003 13:13:45 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This differs from the patch I sent yesterday in that the file-encoding
 matches what's in the distribution, so should apply cleanly]

diff -ruN -X../cludes linux-2.5.55-moo.orig/arch/v850/kernel/as85ep1.c linux-2.5.55-moo/arch/v850/kernel/as85ep1.c
--- linux-2.5.55-moo.orig/arch/v850/kernel/as85ep1.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.55-moo/arch/v850/kernel/as85ep1.c	2003-01-09 14:07:36.000000000 +0900
@@ -44,8 +44,10 @@
 
 void __init mach_early_init (void)
 {
+#ifndef CONFIG_ROM_KERNEL
 	const u32 *src;
 	register u32 *dst asm ("ep");
+#endif
 
 	AS85EP1_CSC(0) = 0x0403;
 	AS85EP1_BCT(0) = 0xB8B8;
@@ -53,25 +55,28 @@
 	AS85EP1_BCC    = 0x0012;
 	AS85EP1_ASC    = 0;
 	AS85EP1_LBS    = 0x00A9;
-	AS85EP1_RFS(1) = 0x8205;
-	AS85EP1_RFS(3) = 0x8205;
-	AS85EP1_SCR(1) = 0x20A9;
-	AS85EP1_SCR(3) = 0x20A9;
 
 	AS85EP1_PORT_PMC(6)  = 0xFF; /* A20-25, A0,A1 有効 */
 	AS85EP1_PORT_PMC(7)  = 0x0E; /* CS1,2,3       有効 */
 	AS85EP1_PORT_PMC(9)  = 0xFF; /* D16-23        有効 */
 	AS85EP1_PORT_PMC(10) = 0xFF; /* D24-31        有効 */
 
-	AS85EP1_IRAMM = 0x3;	/* 内蔵命令RAMは「write-mode」になります */
+	AS85EP1_RFS(1) = 0x800c;
+	AS85EP1_RFS(3) = 0x800c;
+	AS85EP1_SCR(1) = 0x20A9;
+	AS85EP1_SCR(3) = 0x20A9;
 
-	/* The early chip we have is buggy, so that writing the interrupt
+#ifndef CONFIG_ROM_KERNEL
+	/* The early chip we have is buggy, and writing the interrupt
 	   vectors into low RAM may screw up, so for non-ROM kernels, we
 	   only rely on the reset vector being downloaded, and copy the
 	   rest of the interrupt vectors into place here.  The specific bug
 	   is that writing address N, where (N & 0x10) == 0x10, will _also_
 	   write to address (N - 0x10).  We avoid this (effectively) by
 	   writing in 16-byte chunks backwards from the end.  */
+
+	AS85EP1_IRAMM = 0x3;	/* 内蔵命令RAMは「write-mode」になります */
+
 	src = (u32 *)(((u32)&_intv_copy_src_end - 1) & ~0xF);
 	dst = (u32 *)&_intv_copy_dst_start
 		+ (src - (u32 *)&_intv_copy_src_start);
@@ -83,6 +88,7 @@
 	} while (src > (u32 *)&_intv_copy_src_start);
 
 	AS85EP1_IRAMM = 0x0;	/* 内蔵命令RAMは「read-mode」になります */
+#endif /* !CONFIG_ROM_KERNEL */
 
 	nb85e_intc_disable_irqs ();
 }
@@ -107,16 +113,20 @@
 	*ram_len = RAM_END - RAM_START;
 }
 
+/* Convenience macros.  */
+#define SRAM_END	(SRAM_ADDR + SRAM_SIZE)
+#define SDRAM_END	(SDRAM_ADDR + SDRAM_SIZE)
+
 void __init mach_reserve_bootmem ()
 {
 	extern char _root_fs_image_start, _root_fs_image_end;
 	u32 root_fs_image_start = (u32)&_root_fs_image_start;
 	u32 root_fs_image_end = (u32)&_root_fs_image_end;
 
-	/* We can't use the space between SRAM and SDRAM, so prevent the
-	   kernel from trying.  */
-	reserve_bootmem (SRAM_ADDR + SRAM_SIZE,
-			 SDRAM_ADDR - (SRAM_ADDR + SRAM_SIZE));
+	if (SDRAM_ADDR < RAM_END && SDRAM_ADDR > RAM_START)
+		/* We can't use the space between SRAM and SDRAM, so
+		   prevent the kernel from trying.  */
+		reserve_bootmem (SRAM_END, SDRAM_ADDR - SRAM_END);
 
 	/* Reserve the memory used by the root filesystem image if it's
 	   in RAM.  */
