Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbSLTFU3>; Fri, 20 Dec 2002 00:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbSLTFU3>; Fri, 20 Dec 2002 00:20:29 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:48057 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266259AbSLTFUH>; Fri, 20 Dec 2002 00:20:07 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Reduce redundancy in v850 linker scripts
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021220052803.B28B23702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 20 Dec 2002 14:28:03 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves most of the duplicated text in the various v850
platform-specific linker scripts (each of which was previously completely
standalone) into cpp macros in vmlinux.lds.S, which are then used by the
platform linker scripts as appropriate.  This should make the scripts a lot
easier to maintain.

Also, a number of linker-script bugs are fixed.


diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/vmlinux.lds.S arch/v850/vmlinux.lds.S
--- ../orig/linux-2.5.52-uc0/arch/v850/vmlinux.lds.S	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/vmlinux.lds.S	2002-12-19 19:54:31.000000000 +0900
@@ -1,5 +1,201 @@
+/*
+ * arch/v850/vmlinux.lds.S -- kernel linker script for v850 platforms
+ *
+ *  Copyright (C) 2002  NEC Electronics Corporation
+ *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
 #include <linux/config.h>
 
+
+/* The following macros contain the usual definitions for various data areas.
+   The prefix `RAMK_' is used to indicate macros suitable for kernels loaded
+   into RAM, and similarly `ROMK_' for ROM-resident kernels.  Note that all
+   symbols are prefixed with an extra `_' for compatibility with the v850
+   toolchain.  */
+
+	
+/* Interrupt vectors.  */
+#define INTV_CONTENTS							      \
+		__intv_start = . ;					      \
+			*(.intv.reset)	/* Reset vector */		      \
+			*(.intv.common)	/* Vectors common to all v850e proc */\
+			*(.intv.mach)	/* Machine-specific int. vectors.  */ \
+		__intv_end = . ;
+
+/* Kernel text segment, and some constant data areas.  */
+#define TEXT_CONTENTS							      \
+		__stext = . ;						      \
+        	*(.text)						      \
+			*(.exit.text)	/* 2.5 convention */		      \
+			*(.text.exit)	/* 2.4 convention */		      \
+			*(.text.lock)					      \
+			*(.exitcall.exit)				      \
+		__real_etext = . ;	/* There may be data after here.  */  \
+			*(.rodata)					      \
+		. = ALIGN (0x4) ;					      \
+			*(.kstrtab)					      \
+		. = ALIGN (4) ;						      \
+		    	*(.call_table_data)				      \
+			*(.call_table_text)				      \
+		. = ALIGN (16) ;	/* Exception table.  */		      \
+		___start___ex_table = . ;				      \
+			*(__ex_table)					      \
+		___stop___ex_table = . ;				      \
+		___start___ksymtab = . ;/* Kernel symbol table.  */	      \
+			*(__ksymtab)					      \
+		___stop___ksymtab = . ;					      \
+		. = ALIGN (4) ;						      \
+		__etext = . ;
+
+/* Kernel data segment.  */
+#define DATA_CONTENTS							      \
+		__sdata = . ;						      \
+        	*(.data)						      \
+			*(.exit.data)	/* 2.5 convention */		      \
+			*(.data.exit)	/* 2.4 convention */		      \
+		. = ALIGN (16) ;					      \
+		*(.data.cacheline_aligned)				      \
+		. = ALIGN (0x2000) ;					      \
+        	*(.data.init_task)					      \
+		. = ALIGN (0x2000) ;					      \
+		__edata = . ;
+
+/* Kernel BSS segment.  */
+#define BSS_CONTENTS							      \
+		__sbss = . ;						      \
+			*(.bss)						      \
+			*(COMMON)					      \
+		. = ALIGN (4) ;						      \
+		__init_stack_end = . ;					      \
+		__ebss = . ;
+
+/* `initcall' tables.  */
+#define INITCALL_CONTENTS						      \
+		. = ALIGN (16) ;					      \
+		___setup_start = . ;					      \
+			*(.init.setup)	/* 2.5 convention */		      \
+			*(.setup.init)	/* 2.4 convention */		      \
+		___setup_end = . ;					      \
+		___start___param = . ;					      \
+			*(__param)					      \
+		___stop___param = . ;					      \
+		___initcall_start = . ;					      \
+			*(.initcall.init)				      \
+			*(.initcall1.init)				      \
+			*(.initcall2.init)				      \
+			*(.initcall3.init)				      \
+			*(.initcall4.init)				      \
+			*(.initcall5.init)				      \
+			*(.initcall6.init)				      \
+			*(.initcall7.init)				      \
+		. = ALIGN (4) ;						      \
+		___initcall_end = . ;
+
+/* Contents of `init' section for a kernel that's loaded into RAM.  */
+#define RAMK_INIT_CONTENTS						      \
+		RAMK_INIT_CONTENTS_NO_END				      \
+		__init_end = . ;
+/* Same as RAMK_INIT_CONTENTS, but doesn't define the `__init_end' symbol.  */
+#define RAMK_INIT_CONTENTS_NO_END					      \
+		. = ALIGN (4096) ;					      \
+		__init_start = . ;					      \
+			*(.init.text)	/* 2.5 convention */		      \
+			*(.init.data)					      \
+			*(.text.init)	/* 2.4 convention */		      \
+			*(.data.init)					      \
+		INITCALL_CONTENTS					      \
+		INITRAMFS_CONTENTS
+
+/* The contents of `init' section for a ROM-resident kernel which
+   should go into RAM.  */	
+#define ROMK_INIT_RAM_CONTENTS						      \
+		. = ALIGN (4096) ;					      \
+		__init_start = . ;					      \
+			*(.init.data)	/* 2.5 convention */		      \
+			*(.data.init)	/* 2.4 convention */		      \
+		__init_end = . ;					      \
+		. = ALIGN (4096) ;
+
+/* The contents of `init' section for a ROM-resident kernel which
+   should go into ROM.  */	
+#define ROMK_INIT_ROM_CONTENTS						      \
+			*(.init.text)	/* 2.5 convention */		      \
+			*(.text.init)	/* 2.4 convention */		      \
+		INITCALL_CONTENTS					      \
+		INITRAMFS_CONTENTS
+
+/* A root filesystem image, for kernels with an embedded root filesystem.  */
+#define ROOT_FS_CONTENTS						      \
+		__root_fs_image_start = . ;				      \
+		*(.root)						      \
+		__root_fs_image_end = . ;
+/* The initramfs archive.  */
+#define INITRAMFS_CONTENTS						      \
+		. = ALIGN (4) ;						      \
+		___initramfs_start = . ;				      \
+			*(.init.ramfs)					      \
+		___initramfs_end = . ;
+/* Where the initial bootmap (bitmap for the boot-time memory allocator) 
+   should be place.  */
+#define BOOTMAP_CONTENTS						      \
+		. = ALIGN (4096) ;					      \
+		__bootmap = . ;						      \
+		. = . + 4096 ;		/* enough for 128MB.   */
+
+/* The contents of a `typical' kram area for a kernel in RAM.  */
+#define RAMK_KRAM_CONTENTS						      \
+		__kram_start = . ;					      \
+		TEXT_CONTENTS						      \
+		DATA_CONTENTS						      \
+		BSS_CONTENTS						      \
+		RAMK_INIT_CONTENTS					      \
+		__kram_end = . ;					      \
+		BOOTMAP_CONTENTS
+
+
+/* Define output sections normally used for a ROM-resident kernel.  
+   ROM and RAM should be appropriate memory areas to use for kernel
+   ROM and RAM data.  This assumes that ROM starts at 0 (and thus can
+   hold the interrupt vectors).  */
+#define ROMK_SECTIONS(ROM, RAM)						      \
+	.rom : {							      \
+		INTV_CONTENTS						      \
+		TEXT_CONTENTS						      \
+		ROMK_INIT_ROM_CONTENTS					      \
+		ROOT_FS_CONTENTS					      \
+	} > ROM								      \
+									      \
+	__rom_copy_src_start = . ;					      \
+									      \
+	.data : {							      \
+		__kram_start = . ;					      \
+		__rom_copy_dst_start = . ;				      \
+		DATA_CONTENTS						      \
+		ROMK_INIT_RAM_CONTENTS					      \
+		__rom_copy_dst_end = . ;				      \
+	} > RAM  AT> ROM						      \
+									      \
+	.bss ALIGN (4) : {						      \
+		BSS_CONTENTS						      \
+		__kram_end = . ;					      \
+		BOOTMAP_CONTENTS					      \
+	} > RAM
+
+
+/* The 32-bit variable `jiffies' is just the lower 32-bits of `jiffies_64'.  */
+_jiffies = _jiffies_64 ;
+
+
+/* Include an appropriate platform-dependent linker-script (which
+   usually should use the above macros to do most of the work).  */
+
 #ifdef CONFIG_V850E_SIM
 # include "sim.ld"
 #endif
@@ -21,15 +217,17 @@
 #endif
 
 #ifdef CONFIG_V850E_AS85EP1
-# include "as85ep1.ld"
+# ifdef CONFIG_ROM_KERNEL
+#  include "as85ep1-rom.ld"
+# else
+#  include "as85ep1.ld"
+# endif
 #endif
 
 #ifdef CONFIG_RTE_CB_MA1
 # ifdef CONFIG_ROM_KERNEL
 #  include "rte_ma1_cb-rom.ld"
-# elif CONFIG_RTE_CB_MA1_KSRAM
-#  include "rte_ma1_cb-ksram.ld"
-# else /* !CONFIG_ROM_KERNEL && !CONFIG_RTE_CB_MA1_KSRAM */
+# else
 #  include "rte_ma1_cb.ld"
-# endif /* CONFIG_ROM_KERNEL */
-#endif /* CONFIG_RTE_CB_MA1 */
+# endif
+#endif
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/anna-rom.ld arch/v850/anna-rom.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/anna-rom.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/anna-rom.ld	2002-12-18 18:08:31.000000000 +0900
@@ -1,132 +1,16 @@
 /* Linker script for the Midas labs Anna V850E2 evaluation board
    (CONFIG_V850E2_ANNA), with kernel in ROM (CONFIG_ROM_KERNEL).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* 8MB of flash ROM.  */
-       ROM   : ORIGIN = 0,          LENGTH = 0x00800000
+	/* 8MB of flash ROM.  */
+	ROM   : ORIGIN = 0,          LENGTH = 0x00800000
 
-       /* 1MB of static RAM.  This memory is mirrored 64 times.  */
-       SRAM  : ORIGIN = 0x04000000, LENGTH = 0x00100000
-       /* 64MB of DRAM.  */
-       SDRAM : ORIGIN = 0x08000000, LENGTH = 0x04000000
+	/* 1MB of static RAM.  This memory is mirrored 64 times.  */
+	SRAM  : ORIGIN = 0x04000000, LENGTH = 0x00100000
+	/* 64MB of DRAM.  */
+	SDRAM : ORIGIN = 0x08000000, LENGTH = 0x04000000
 }
 
 SECTIONS {
-	.intv : {
-		__intv_start = . ;
-			*(.intv.reset)	/* Reset vector */
-			*(.intv.common)	/* Vectors common to all v850e proc. */
-			*(.intv.mach)	/* Machine-specific int. vectors.  */
-		__intv_end = . ;
-	} > ROM
-
-	.text ALIGN (0x10) : {
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > ROM
-
-	.init_text ALIGN (4096) : {
-			*(.init.text)	/* 2.5 convention */
-			*(.text.init)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-	} > ROM
-
-	/* Device contents for the root filesystem.  */
-	.root ALIGN (4096) : {
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-	} > ROM
-
-	__rom_copy_src_start = . ;
-
-	.data : {
-		__kram_start = . ;
-		__rom_copy_dst_start = . ;
-
-		__sdata = . ;
-		___data_start = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > SRAM  AT> ROM
-
-	.init_data ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.data)	/* 2.5 convention */
-			*(.data.init)	/* 2.4 convention */
-		__init_end = . ;
-		__rom_copy_dst_end = . ;
-	} > SRAM  AT> ROM
-
-	.bss ALIGN (4096) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-
-		__kram_end = . ;
-	} > SRAM
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
-	} > SRAM
+	ROMK_SECTIONS(ROM, SRAM)
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/anna.ld arch/v850/anna.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/anna.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/anna.ld	2002-12-19 14:21:49.000000000 +0900
@@ -1,128 +1,20 @@
 /* Linker script for the Midas labs Anna V850E2 evaluation board
    (CONFIG_V850E2_ANNA).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* 256KB of internal memory (followed by one mirror).  */
-       iMEM0 : ORIGIN = 0,	    LENGTH = 0x00040000
-       /* 256KB of internal memory (followed by one mirror).  */
-       iMEM1 : ORIGIN = 0x00040000, LENGTH = 0x00040000
-
-       /* 1MB of static RAM.  This memory is mirrored 64 times.  */
-       SRAM  : ORIGIN = 0x04000000, LENGTH = 0x00100000
-       /* 64MB of DRAM.  */
-       SDRAM : ORIGIN = 0x08000000, LENGTH = 0x04000000
+	/* 256KB of internal memory (followed by one mirror).  */
+	iMEM0 : ORIGIN = 0,	    LENGTH = 0x00040000
+	/* 256KB of internal memory (followed by one mirror).  */
+	iMEM1 : ORIGIN = 0x00040000, LENGTH = 0x00040000
+
+	/* 1MB of static RAM.  This memory is mirrored 64 times.  */
+	SRAM  : ORIGIN = 0x04000000, LENGTH = 0x00100000
+	/* 64MB of DRAM.  */
+	SDRAM : ORIGIN = 0x08000000, LENGTH = 0x04000000
 }
 
 SECTIONS {
-	.intv : {
-		__intv_start = . ;
-			*(.intv.reset)	/* Reset vector */
-			*(.intv.common)	/* Vectors common to all v850e proc. */
-			*(.intv.mach)	/* Machine-specific int. vectors.  */
-		__intv_end = . ;
-	} > iMEM0
-
-	.text : {
-		 __kram_start = . ;
-
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > SRAM
-
-	.data ALIGN (0x4) : {
-		__sdata = . ;
-		___data_start = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > SRAM
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > SRAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-
-		__init_end = . ;
-
-		__kram_end = . ;
-	} > SRAM
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
-	} > SRAM
-
-	/* Device contents for the root filesystem.  */
-	.root : {
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > SDRAM
+	.intv : { INTV_CONTENTS } > iMEM0
+	.sram : { RAMK_KRAM_CONTENTS } > SRAM
+	.root : { ROOT_FS_CONTENTS } > SDRAM
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/as85ep1-rom.ld arch/v850/as85ep1-rom.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/as85ep1-rom.ld	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/as85ep1-rom.ld	2002-12-18 18:05:14.000000000 +0900
@@ -0,0 +1,24 @@
+/* Linker script for the NEC AS85EP1 V850E evaluation board
+   (CONFIG_V850E_AS85EP1), with kernel in ROM (CONFIG_ROM_KERNEL).  */
+
+/* Note, all symbols are prefixed with an extra `_' for compatibility with
+   the existing linux sources.  */
+
+MEMORY {
+	/* 4MB of flash ROM.  */
+	ROM   : ORIGIN = 0,          LENGTH = 0x00400000
+
+	/* 1MB of static RAM.  */
+	SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
+
+	/* About 58MB of DRAM.  This can actually be at one of two
+	   positions, determined by jump JP3; we have to use the first
+	   position because the second is partially out of processor
+	   instruction addressing range (though in the second position
+	   there's actually 64MB available).  */
+	SDRAM : ORIGIN = 0x00600000, LENGTH = 0x039F8000
+}
+
+SECTIONS {
+	ROMK_SECTIONS(ROM, SRAM)
+}
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/as85ep1.ld arch/v850/as85ep1.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/as85ep1.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/as85ep1.ld	2002-12-19 14:25:40.000000000 +0900
@@ -1,23 +1,19 @@
 /* Linker script for the NEC AS85EP1 V850E evaluation board
    (CONFIG_V850E_AS85EP1).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* 1MB of internal memory (内蔵命令RAM).  */
-       iMEM0 : ORIGIN = 0,	    LENGTH = 0x00100000
+	/* 1MB of internal memory (内蔵命令RAM).  */
+	iMEM0 : ORIGIN = 0,	    LENGTH = 0x00100000
 
-       /* 1MB of static RAM.  */
-       SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
+	/* 1MB of static RAM.  */
+	SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
 
-       /* About 58MB of DRAM.  This can actually be at one of two positions,
-	  determined by jump JP3; we have to use the first position because the
-	  second is partially out of processor instruction addressing range
-	  (though in the second position there's actually 64MB available).  */
-       SDRAM : ORIGIN = 0x00600000, LENGTH = 0x039F8000
+	/* About 58MB of DRAM.  This can actually be at one of two
+	   positions, determined by jump JP3; we have to use the first
+	   position because the second is partially out of processor
+	   instruction addressing range (though in the second position
+	   there's actually 64MB available).  */
+	SDRAM : ORIGIN = 0x00600000, LENGTH = 0x039F8000
 }
 
 SECTIONS {
@@ -26,87 +22,8 @@
 			*(.intv.reset)	/* Reset vector */
 	} > iMEM0
 
-	.text : {
-		 __kram_start = . ;
-
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > SRAM
-
-	.data ALIGN (0x4) : {
-		__sdata = . ;
-		___data_start = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > SRAM
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > SRAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
+	.sram : {
+		RAMK_KRAM_CONTENTS
 
 		/* We stick most of the interrupt vectors here; they'll be
 		   copied into the proper location by the early init code (we
@@ -121,27 +38,12 @@
 			*(.intv.mach)	/* Machine-specific int. vectors.  */
 		. = ALIGN (0x10) ;
 		__intv_copy_src_end = . ;
-
-		/* This is here so that when we free init memory, the initial
-		   load-area of the interrupt vectors is freed too.  */
-		__init_end = . ;
-		__kram_end = . ;
-		   
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
 	} > SRAM
 
 	/* Where we end up putting the vectors.  */
 	__intv_copy_dst_start = 0x10 ;
 	__intv_copy_dst_end = __intv_copy_dst_start + (__intv_copy_src_end - __intv_copy_src_start) ;
-
 	__intv_end = __intv_copy_dst_end ;
 
-	/* Device contents for the root filesystem.  */
-	.root : {
-		. = ALIGN (4096) ;
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > SDRAM
+	.root : { ROOT_FS_CONTENTS } > SDRAM
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/fpga85e2c.ld arch/v850/fpga85e2c.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/fpga85e2c.ld	2002-11-05 11:25:21.000000000 +0900
+++ arch/v850/fpga85e2c.ld	2002-12-18 18:07:30.000000000 +0900
@@ -1,108 +1,36 @@
 /* Linker script for the FPGA implementation of the V850E2 NA85E2C cpu core
    (CONFIG_V850E2_FPGA85E2C).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* Reset vector.  */
-       RESET	 : ORIGIN = 0, LENGTH = 0x10
-       /* Interrupt vectors.  */
-       INTV      : ORIGIN = 0x10, LENGTH = 0x470
-       /* The `window' in RAM were we're allowed to load stuff.  */
-       RAM_LOW   : ORIGIN = 0x480, LENGTH = 0x0005FB80
-       /* Some more ram above the window were we can put bss &c.  */
-       RAM_HIGH  : ORIGIN = 0x00060000, LENGTH = 0x000A0000
-       /* This is the area visible from the outside world (we can use
-	  this only for uninitialized data).  */
-       VISIBLE   : ORIGIN = 0x00200000, LENGTH = 0x00060000
+	/* Reset vector.  */
+	RESET	 : ORIGIN = 0, LENGTH = 0x10
+	/* Interrupt vectors.  */
+	INTV      : ORIGIN = 0x10, LENGTH = 0x470
+	/* The `window' in RAM were we're allowed to load stuff.  */
+	RAM_LOW   : ORIGIN = 0x480, LENGTH = 0x0005FB80
+	/* Some more ram above the window were we can put bss &c.  */
+	RAM_HIGH  : ORIGIN = 0x00060000, LENGTH = 0x000A0000
+	/* This is the area visible from the outside world (we can use
+	   this only for uninitialized data).  */
+	VISIBLE   : ORIGIN = 0x00200000, LENGTH = 0x00060000
 }
 
 SECTIONS {
 	.reset : {
-	        __kram_start = . ;
+		__kram_start = . ;
 		__intv_start = . ;
 	        	*(.intv.reset)	/* Reset vector */
 	} > RESET
 
-	.r0_ram : {
-		__r0_ram = . ;
+	.ram_low : {
+		__r0_ram = . ;		/* Must be near address 0.  */
 		. = . + 32 ;
-	} > RAM_LOW
-
-	.text : {
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > RAM_LOW
-
-	.data : {
-		__sdata = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > RAM_LOW
-
-	/* Device contents for the root filesystem.  */
-	.root : {
-		. =  ALIGN (4096) ;
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > RAM_LOW
 
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
+		TEXT_CONTENTS
+		DATA_CONTENTS
+		ROOT_FS_CONTENTS
+		RAMK_INIT_CONTENTS_NO_END
+		INITRAMFS_CONTENTS
 	} > RAM_LOW
 
         /* Where the interrupt vectors are initially loaded.  */
@@ -114,26 +42,16 @@
 		__intv_end = . ;
 	} > INTV  AT> RAM_LOW
 
-	.bss : {
+	.ram_high : {
 		/* This is here so that when we free init memory the
 		   load-time copy of the interrupt vectors and any empty
 		   space at the end of the `RAM_LOW' area is freed too.  */
 		. = ALIGN (4096);
 		__init_end = . ;
 
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-
-	        __kram_end = . ;
-	} > RAM_HIGH
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
+		BSS_CONTENTS
+		__kram_end = . ;
+		BOOTMAP_CONTENTS
 	} > RAM_HIGH
 
 	.visible : {
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/rte_ma1_cb-ksram.ld arch/v850/rte_ma1_cb-ksram.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/rte_ma1_cb-ksram.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/rte_ma1_cb-ksram.ld	1970-01-01 09:00:00.000000000 +0900
@@ -1,157 +0,0 @@
-/* Linker script for the Midas labs RTE-V850E/MA1-CB evaluation board
-   (CONFIG_RTE_CB_MA1), with kernel in SRAM, under Multi debugger.  */
-
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
-MEMORY {
-       /* 1MB of SRAM; we can't use the last 32KB, because it's used by
-          the monitor scratch-RAM.  This memory is mirrored 4 times.  */
-       SRAM  : ORIGIN = 0x00400000, LENGTH = 0x000F8000
-       /* Monitor scratch RAM; only the interrupt vectors should go here.  */
-       MRAM  : ORIGIN = 0x004F8000, LENGTH = 0x00008000
-       /* 32MB of SDRAM.  */
-       SDRAM : ORIGIN = 0x00800000, LENGTH = 0x02000000
-}
-
-SECTIONS {
-	.text : {
-	        __kram_start = . ;
-
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		*(.call_table_data)
-		*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > SRAM
-
-	.data ALIGN (0x4) : {
-		__sdata = . ;
-		___data_start = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > SRAM
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > SRAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-	} > SRAM
-
-	/* This provides address at which the interrupt vectors are
-	   initially loaded by the loader.  */
-	__intv_load_start = ALIGN (0x10) ;
-
-	/* Interrupt vector space.  Because we're using the monitor
-	   ROM, Instead of the native interrupt vector, we must use the
-	   `alternate interrupt vector' area.  Note that this is in
-	   `SRAM' space, which is not currently used by the kernel (the
-	   kernel uses `SDRAM' space).  */
-
-	/* We can't load the interrupt vectors directly into their
-	   target location, because the monitor ROM for the GHS Multi
-	   debugger barfs if we try.  Unfortunately, Multi also doesn't
-	   deal correctly with ELF sections where the LMA and VMA differ
-	   (it just ignores the LMA), so we can't use that feature to
-	   work around the problem!  What we do instead is just put the
-	   interrupt vectors into a normal section, and have the
-	   `mach_early_init' function for Midas boards do the necessary
-	   copying and relocation at runtime (this section basically
-	   only contains `jr' instructions, so it's not that hard).
-
-	   This the section structure I initially tried to use (which more
-	   accurately expresses the intent):
-
-		.intv 0x007F8000 : AT (ADDR (.init) + SIZEOF (.init)) {
-		    ...
-		} > MRAM
-	*/
-
-	.intv ALIGN (0x10) : {
-		__intv_start = . ;
-	        	*(.intv.reset)	/* Reset vector */
-			*(.intv.common) /* Vectors common to all v850e proc. */
-			*(.intv.mach)   /* Machine-specific int. vectors.  */
-		__intv_end = . ;
-
-		/* This is here so that when we free init memory, the initial
-		   load-area of the interrupt vectors is freed too.  */
-		__init_end = __intv_end;
-
-		__kram_end = __init_end ;
-	} > SRAM
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
-	} > SRAM
-
-	/* Device contents for the root filesystem.  */
-	.root : {
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > SDRAM
-}
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/rte_ma1_cb-rom.ld arch/v850/rte_ma1_cb-rom.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/rte_ma1_cb-rom.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/rte_ma1_cb-rom.ld	2002-12-18 18:08:27.000000000 +0900
@@ -1,120 +1,14 @@
 /* Linker script for the Midas labs RTE-V850E/MA1-CB evaluation board
    (CONFIG_RTE_CB_MA1), with kernel in ROM.  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       ROM   : ORIGIN = 0x00000000, LENGTH = 0x00100000
-       /* 1MB of SRAM.  This memory is mirrored 4 times.  */
-       SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
-       /* 32MB of SDRAM.  */
-       SDRAM : ORIGIN = 0x00800000, LENGTH = 0x02000000
+	ROM   : ORIGIN = 0x00000000, LENGTH = 0x00100000
+	/* 1MB of SRAM.  This memory is mirrored 4 times.  */
+	SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
+	/* 32MB of SDRAM.  */
+	SDRAM : ORIGIN = 0x00800000, LENGTH = 0x02000000
 }
 
 SECTIONS {
-	/* Interrupt vector space.  */
-	.intv {
-		__intv_start = . ;
-	        	*(.intv.reset)	/* Reset vector */
-			*(.intv.common) /* Vectors common to all v850e proc. */
-			*(.intv.mach)   /* Machine-specific int. vectors.  */
-		__intv_end = . ;
-	} > ROM
-
-	.text : {
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-	} > ROM
-
-	__rom_copy_src_start = . ;
-
-	.data : {
-	        __kram_start = . ;
-
-		__sdata = . ;
-		___data_start = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > SRAM  AT> ROM
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > SRAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-		__init_end = . ;
-
-		__kram_end = . ;
-	} > SRAM
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
-	} > SRAM
-
-	/* device contents for the root filesystem.  */
-	.root ALIGN (4096) {
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > SDRAM
+	ROMK_SECTIONS(ROM, SRAM)
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/rte_ma1_cb.ld arch/v850/rte_ma1_cb.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/rte_ma1_cb.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/rte_ma1_cb.ld	2002-12-20 11:24:13.000000000 +0900
@@ -1,157 +1,57 @@
 /* Linker script for the Midas labs RTE-V850E/MA1-CB evaluation board
    (CONFIG_RTE_CB_MA1), with kernel in SDRAM, under Multi debugger.  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* 1MB of SRAM; we can't use the last 32KB, because it's used by
-          the monitor scratch-RAM.  This memory is mirrored 4 times.  */
-       SRAM  : ORIGIN = 0x00400000, LENGTH = 0x000F8000
-       /* Monitor scratch RAM; only the interrupt vectors should go here.  */
-       MRAM  : ORIGIN = 0x004F8000, LENGTH = 0x00008000
-       /* 32MB of SDRAM.  */
-       SDRAM : ORIGIN = 0x00800000, LENGTH = 0x02000000
+	/* 1MB of SRAM; we can't use the last 32KB, because it's used by
+	   the monitor scratch-RAM.  This memory is mirrored 4 times.  */
+	SRAM  : ORIGIN = 0x00400000, LENGTH = 0x000F8000
+	/* Monitor scratch RAM; only the interrupt vectors should go here.  */
+	MRAM  : ORIGIN = 0x004F8000, LENGTH = 0x00008000
+	/* 32MB of SDRAM.  */
+	SDRAM : ORIGIN = 0x00800000, LENGTH = 0x02000000
 }
 
+#ifdef CONFIG_RTE_CB_MA1_KSRAM
+# define KRAM SRAM
+#else
+# define KRAM SDRAM
+#endif
+
 SECTIONS {
-	.bootmap : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
-	} > SRAM
+	/* We can't use RAMK_KRAM_CONTENTS because that puts the whole
+	   kernel in a single ELF segment, and the Multi debugger (which
+	   we use to load the kernel) appears to have bizarre problems
+	   dealing with it.  */
 
 	.text : {
-		 __kram_start = . ;
-
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > SDRAM
-
-	.data ALIGN (0x4) : {
-		__sdata = . ;
-		___data_start = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > SDRAM
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > SDRAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-	} > SDRAM
-
-	/* The address at which the interrupt vectors are initially
-	   loaded by the loader.  */
-	__intv_load_start = ALIGN (0x10) ;
-
-	/* Interrupt vector space.  Because we're using the monitor
-	   ROM, Instead of the native interrupt vector, we must use the
-	   `alternate interrupt vector' area.  Note that this is in
-	   `SRAM' space, which is not currently used by the kernel (the
-	   kernel uses `SDRAM' space).  */
-
-	/* We can't load the interrupt vectors directly into their
-	   target location, because the monitor ROM for the GHS Multi
-	   debugger barfs if we try.  Unfortunately, Multi also doesn't
-	   deal correctly with ELF sections where the LMA and VMA differ
-	   (it just ignores the LMA), so we can't use that feature to
-	   work around the problem!  What we do instead is just put the
-	   interrupt vectors into a normal section, and have the
-	   `mach_early_init' function for Midas boards do the necessary
-	   copying and relocation at runtime (this section basically
-	   only contains `jr' instructions, so it's not that hard).
-
-	   This the section structure I initially tried to use (which more
-	   accurately expresses the intent):
-
-		.intv 0x007F8000 : AT (ADDR (.init) + SIZEOF (.init)) {
-		    ...
-		} > MRAM
-	*/
-
-	.intv ALIGN (0x10) : {
-		__intv_start = . ;
-	        	*(.intv.reset)	/* Reset vector */
-			*(.intv.common) /* Vectors common to all v850e proc. */
-			*(.intv.mach)   /* Machine-specific int. vectors.  */
-		__intv_end = . ;
-
-		/* This is here so that when we free init memory, the initial
-		   load-area of the interrupt vectors is freed too.  */
-		__init_end = __intv_end;
-
+		__kram_start = . ;
+		TEXT_CONTENTS
+	} > KRAM
+
+	.data : {
+		DATA_CONTENTS
+		BSS_CONTENTS
+		RAMK_INIT_CONTENTS
 		__kram_end = . ;
-	} > SDRAM
+		BOOTMAP_CONTENTS
+
+		/* The address at which the interrupt vectors are initially
+		   loaded by the loader.  We can't load the interrupt vectors
+		   directly into their target location, because the monitor
+		   ROM for the GHS Multi debugger barfs if we try.
+		   Unfortunately, Multi also doesn't deal correctly with ELF
+		   sections where the LMA and VMA differ (it just ignores the
+		   LMA), so we can't use that feature to work around the
+		   problem!  What we do instead is just put the interrupt
+		   vectors into a normal section, and have the
+		   `mach_early_init' function for Midas boards do the
+		   necessary copying and relocation at runtime (this section
+		   basically only contains `jr' instructions, so it's not
+		   that hard).  */
+		. = ALIGN (0x10) ;
+		__intv_load_start = . ;
+		INTV_CONTENTS
+	} > KRAM
 
-	/* Device contents for the root filesystem.  */
-	.root ALIGN (4096) : {
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > SDRAM
+	.root ALIGN (4096) : { ROOT_FS_CONTENTS } > SDRAM
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/sim.ld arch/v850/sim.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/sim.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/sim.ld	2002-12-19 14:23:24.000000000 +0900
@@ -1,114 +1,14 @@
 /* Linker script for the gdb v850e simulator (CONFIG_V850E_SIM).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* Interrupt vectors.  */
-       INTV  : ORIGIN = 0x0, LENGTH = 0xe0
-       /* 16MB of RAM.
-          This must match RAM_ADDR and RAM_SIZE in include/asm-v580/sim.h  */
-       RAM   : ORIGIN = 0x8F000000, LENGTH = 0x01000000
+	/* Interrupt vectors.  */
+	INTV  : ORIGIN = 0x0, LENGTH = 0xe0
+	/* 16MB of RAM.
+	   This must match RAM_ADDR and RAM_SIZE in include/asm-v850/sim.h  */
+	RAM   : ORIGIN = 0x8F000000, LENGTH = 0x01000000
 }
 
 SECTIONS {
-	.intv : {
-		__intv_start = . ;
-			*(.intv.reset)	/* Reset vector */
-			*(.intv.common)	/* Vectors common to all v850e proc. */
-			*(.intv.mach)	/* Machine-specific int. vectors.  */
-		__intv_end = . ;
-	} > INTV
-
-	.text : {
-		__kram_start = . ;
-
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
-	} > RAM
-
-	.data ALIGN (0x4) : {
-		__sdata = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > RAM
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > RAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-
-		__init_end = . ;
-
-		__kram_end = . ;
-	} > RAM
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
-	} > RAM
+	.intv : { INTV_CONTENTS } > INTV
+	.ram : { RAMK_KRAM_CONTENTS } > RAM
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/sim85e2c.ld arch/v850/sim85e2c.ld
--- ../orig/linux-2.5.52-uc0/arch/v850/sim85e2c.ld	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/sim85e2c.ld	2002-12-18 18:06:50.000000000 +0900
@@ -1,141 +1,44 @@
 /* Linker script for the sim85e2c simulator, which is a verilog simulation of
    the V850E2 NA85E2C cpu core (CONFIG_V850E2_SIM85E2C).  */
 
-/* Note, all symbols are prefixed with an extra `_' for compatibility with
-   the existing linux sources.  */
-
-_jiffies = _jiffies_64 ;
-
 MEMORY {
-       /* 1MB of `instruction RAM', starting at 0.
-          Instruction fetches are much faster from IRAM than from DRAM.
-	  This should match IRAM_ADDR in "include/asm-v580/sim85e2c.h".    */
-       IRAM	: ORIGIN = 0x00000000, LENGTH = 0x00100000
-
-       /* 1MB of `data RAM', below and contiguous with the I/O space.
-          Data fetches are much faster from DRAM than from IRAM.
-	  This should match DRAM_ADDR in "include/asm-v580/sim85e2c.h".  */
-       DRAM	: ORIGIN = 0xfff00000, LENGTH = 0x000ff000
-       /* We have to load DRAM at a mirror-address of 0x1ff00000,
-          because the simulator's preprocessing script isn't smart
-          enough to deal with the above LMA.  */
-       DRAM_LOAD : ORIGIN = 0x1ff00000, LENGTH = 0x000ff000
-
-       /* `external ram' (CS1 area), comes after IRAM.
-          This should match ERAM_ADDR in "include/asm-v580/sim85e2c.h".  */
-       ERAM	: ORIGIN = 0x00100000, LENGTH = 0x07f00000
+	/* 1MB of `instruction RAM', starting at 0.
+	   Instruction fetches are much faster from IRAM than from DRAM.
+	   This should match IRAM_ADDR in "include/asm-v580/sim85e2c.h".    */
+	IRAM	: ORIGIN = 0x00000000, LENGTH = 0x00100000
+
+	/* 1MB of `data RAM', below and contiguous with the I/O space.
+	   Data fetches are much faster from DRAM than from IRAM.
+	   This should match DRAM_ADDR in "include/asm-v580/sim85e2c.h".  */
+	DRAM	: ORIGIN = 0xfff00000, LENGTH = 0x000ff000
+	/* We have to load DRAM at a mirror-address of 0x1ff00000,
+	   because the simulator's preprocessing script isn't smart
+	   enough to deal with the above LMA.  */
+	DRAM_LOAD : ORIGIN = 0x1ff00000, LENGTH = 0x000ff000
+
+	/* `external ram' (CS1 area), comes after IRAM.
+	   This should match ERAM_ADDR in "include/asm-v580/sim85e2c.h".  */
+	ERAM	: ORIGIN = 0x00100000, LENGTH = 0x07f00000
 }
 
 SECTIONS {
-	.intv : {
-		__intv_start = . ;
-		*(.intv)		/* Interrupt vectors.  */
-	        	*(.intv.reset)	/* Reset vector */
-			*(.intv.common) /* Vectors common to all v850e proc. */
-			*(.intv.mach)   /* Machine-specific int. vectors.  */
-		__intv_end = . ;
-	} > IRAM
-
-	.text : {
-		__stext = . ;
-        	*(.text)
-			*(.exit.text)	/* 2.5 convention */
-			*(.text.exit)	/* 2.4 convention */
-			*(.text.lock)
-			*(.exitcall.exit)
-		__real_etext = . ;	/* There may be data after here.  */
-			*(.rodata)
-		. = ALIGN (0x4) ;
-			*(.kstrtab)
-
-		. = ALIGN (4) ;
-		    	*(.call_table_data)
-			*(.call_table_text)
-
-		. = ALIGN (16) ;	/* Exception table.  */
-		___start___ex_table = . ;
-			*(__ex_table)
-		___stop___ex_table = . ;
-
-		___start___ksymtab = . ;/* Kernel symbol table.  */
-			*(__ksymtab)
-		___stop___ksymtab = . ;
-		. = ALIGN (4) ;
-		__etext = . ;
+	.iram : {
+		INTV_CONTENTS
+		TEXT_CONTENTS
+		RAMK_INIT_CONTENTS
 	} > IRAM
-
-	.init ALIGN (4096) : {
-		__init_start = . ;
-			*(.init.text)	/* 2.5 convention */
-			*(.init.data)
-			*(.text.init)	/* 2.4 convention */
-			*(.data.init)
-		. = ALIGN (16) ;
-		___setup_start = . ;
-			*(.init.setup)	/* 2.5 convention */
-			*(.setup.init)	/* 2.4 convention */
-		___setup_end = . ;
-		___initcall_start = . ;
-			*(.initcall.init)
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
-		. = ALIGN (4) ;
-		___initcall_end = . ;
-
-		. = ALIGN (4) ;
-		___initramfs_start = . ;
-			*(.init.ramfs)
-		___initramfs_end = . ;
-
-		__init_end = . ;
-	} > IRAM
-
 	.data : {
-	        __kram_start = . ;
+		__kram_start = . ;
+		DATA_CONTENTS
+		BSS_CONTENTS
+		ROOT_FS_CONTENTS
 
-		__sdata = . ;
-        	*(.data)
-			*(.exit.data)	/* 2.5 convention */
-			*(.data.exit)	/* 2.4 convention */
-		. = ALIGN (16) ;
-		*(.data.cacheline_aligned)
-		. = ALIGN (0x2000) ;
-        	*(.data.init_task)
-		. = ALIGN (0x2000) ;
-		__edata = . ;
-	} > DRAM  AT> DRAM_LOAD
-
-	.bss ALIGN (0x4) : {
-		__sbss = . ;
-			*(.bss)
-			*(COMMON)
-		. = ALIGN (4) ;
-		__init_stack_end = . ;
-		__ebss = . ;
-	} > DRAM  AT> DRAM_LOAD
-
-	/* Device contents for the root filesystem.  */
-	.root ALIGN (4096) : {
-		__root_fs_image_start = . ;
-		*(.root)
-		__root_fs_image_end = . ;
-	} > DRAM  AT> DRAM_LOAD
-
-	.memcons : {
+		/* We stick console output into a buffer here.  */
 		_memcons_output = . ;
 		. = . + 0x8000 ;
 		_memcons_output_end = . ;
 
-	        __kram_end = . ;
-	} > DRAM  AT> DRAM_LOAD
-
-	.bootmap ALIGN (4096) : {
-		__bootmap = . ;
-		. = . + 4096 ;		/* enough for 128MB.   */
+		__kram_end = . ;
+		BOOTMAP_CONTENTS
 	} > DRAM  AT> DRAM_LOAD
 }
