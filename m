Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSKSJTA>; Tue, 19 Nov 2002 04:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSKSJTA>; Tue, 19 Nov 2002 04:19:00 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:384 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264699AbSKSJSs>; Tue, 19 Nov 2002 04:18:48 -0500
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.48-uc0 (MMU-less fixups)
References: <3DD9C0FF.8090007@snapgear.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 19 Nov 2002 18:25:30 +0900
In-Reply-To: <3DD9C0FF.8090007@snapgear.com>
Message-ID: <buo7kf9x65x.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Here's a v850 update for 2.5.48-uc0 (3 new files):



--=-=-=
Content-Type: text/x-patch; charset=iso-2022-jp
Content-Disposition: attachment;
  filename=linux-2.5.48-uc0-v850-20021119-dist.patch
Content-Description: linux-2.5.48-uc0-v850-20021119-dist.patch

diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/Kconfig arch/v850/Kconfig
--- ../orig/linux-2.5.48-uc0/arch/v850/Kconfig	2002-11-11 13:04:37.000000000 +0900
+++ arch/v850/Kconfig	2002-11-19 15:26:01.000000000 +0900
@@ -63,6 +63,8 @@
       	     bool "NA85E2C-FPGA"
       config V850E2_ANNA
       	     bool "Anna"
+      config V850E_AS85EP1
+      	     bool "AS85EP1"
    endchoice
 
 
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/anna-rom.ld arch/v850/anna-rom.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/anna-rom.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/anna-rom.ld	2002-11-19 15:24:18.000000000 +0900
@@ -81,7 +81,7 @@
 		*(.root)
 		__root_fs_image_end = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/anna.ld arch/v850/anna.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/anna.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/anna.ld	2002-11-19 15:24:18.000000000 +0900
@@ -104,7 +104,7 @@
 		. = ALIGN (4) ;
 		___initcall_end = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/as85ep1.ld arch/v850/as85ep1.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/as85ep1.ld	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/as85ep1.ld	2002-11-19 15:24:18.000000000 +0900
@@ -0,0 +1,145 @@
+/* Linker script for the NEC AS85EP1 V850E evaluation board
+   (CONFIG_V850E_AS85EP1).  */
+
+/* Note, all symbols are prefixed with an extra `_' for compatibility with
+   the existing linux sources.  */
+
+_jiffies = _jiffies_64 ;
+
+MEMORY {
+       /* 1MB of internal memory (内蔵命令RAM).  */
+       iMEM0 : ORIGIN = 0,	    LENGTH = 0x00100000
+
+       /* 1MB of static RAM.  */
+       SRAM  : ORIGIN = 0x00400000, LENGTH = 0x00100000
+
+       /* 64MB of DRAM.  This can actually be at one of two positions,
+       determined by jump JP3; we use the second position because the
+       first only allows access to 56MB.  */
+       SDRAM : ORIGIN = 0x04000000, LENGTH = 0x04000000
+}
+
+SECTIONS {
+	.resetv : {
+		__intv_start = . ;
+			*(.intv.reset)	/* Reset vector */
+	} > iMEM0
+
+	.text : {
+		 __kram_start = . ;
+
+		__stext = . ;
+        	*(.text)
+			*(.exit.text)	/* 2.5 convention */
+			*(.text.exit)	/* 2.4 convention */
+			*(.text.lock)
+			*(.exitcall.exit)
+		__real_etext = . ;	/* There may be data after here.  */
+			*(.rodata)
+
+		. = ALIGN (0x4) ;
+			*(.kstrtab)
+
+		. = ALIGN (4) ;
+		    	*(.call_table_data)
+			*(.call_table_text)
+
+		. = ALIGN (16) ;	/* Exception table.  */
+		___start___ex_table = . ;
+			*(__ex_table)
+		___stop___ex_table = . ;
+
+		___start___ksymtab = . ;/* Kernel symbol table.  */
+			*(__ksymtab)
+		___stop___ksymtab = . ;
+		. = ALIGN (4) ;
+		__etext = . ;
+	} > SRAM
+
+	.data ALIGN (0x4) : {
+		__sdata = . ;
+		___data_start = . ;
+        	*(.data)
+			*(.exit.data)	/* 2.5 convention */
+			*(.data.exit)	/* 2.4 convention */
+		. = ALIGN (16) ;
+		*(.data.cacheline_aligned)
+		. = ALIGN (0x2000) ;
+        	*(.data.init_task)
+		. = ALIGN (0x2000) ;
+		__edata = . ;
+	} > SRAM
+
+	.bss ALIGN (0x4) : {
+		__sbss = . ;
+			*(.bss)
+			*(COMMON)
+		. = ALIGN (4) ;
+		__init_stack_end = . ;
+		__ebss = . ;
+	} > SRAM
+
+	.init ALIGN (4096) : {
+		__init_start = . ;
+			*(.init.text)	/* 2.5 convention */
+			*(.init.data)
+			*(.text.init)	/* 2.4 convention */
+			*(.data.init)
+		. = ALIGN (16) ;
+		___setup_start = . ;
+			*(.init.setup)	/* 2.5 convention */
+			*(.setup.init)	/* 2.4 convention */
+		___setup_end = . ;
+		___initcall_start = . ;
+			*(.initcall.init)
+			*(.initcall1.init)
+			*(.initcall2.init)
+			*(.initcall3.init)
+			*(.initcall4.init)
+			*(.initcall5.init)
+			*(.initcall6.init)
+			*(.initcall7.init)
+		. = ALIGN (4) ;
+		___initcall_end = . ;
+
+		. = ALIGN (4) ;
+		___initramfs_start = . ;
+			*(.init.ramfs)
+		___initramfs_end = . ;
+
+		/* We stick most of the interrupt vectors here; they'll be
+		   copied into the proper location by the early init code (we
+		   can't put them directly in the right place because of
+		   hardware bugs).  The vectors shouldn't need to be
+		   relocated, so we don't have to use `> ...  AT> ...' to
+		   split the load/vm addresses (and we can't because of
+		   problems with the loader).  */
+		. = ALIGN (0x10) ;
+		__intv_copy_src_start = . ;
+			*(.intv.common)	/* Vectors common to all v850e proc. */
+			*(.intv.mach)	/* Machine-specific int. vectors.  */
+		. = ALIGN (0x10) ;
+		__intv_copy_src_end = . ;
+
+		/* This is here so that when we free init memory, the initial
+		   load-area of the interrupt vectors is freed too.  */
+		__init_end = . ;
+		__kram_end = . ;
+		   
+		__bootmap = . ;
+		. = . + 4096 ;		/* enough for 128MB.   */
+	} > SRAM
+
+	/* Where we end up putting the vectors.  */
+	__intv_copy_dst_start = 0x10 ;
+	__intv_copy_dst_end = __intv_copy_dst_start + (__intv_copy_src_end - __intv_copy_src_start) ;
+
+	__intv_end = __intv_copy_dst_end ;
+
+	/* Device contents for the root filesystem.  */
+	.root : {
+		__root_fs_image_start = . ;
+		*(.root)
+		__root_fs_image_end = . ;
+	} > SDRAM
+}
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/kernel/Makefile arch/v850/kernel/Makefile
--- ../orig/linux-2.5.48-uc0/arch/v850/kernel/Makefile	2002-11-05 11:25:21.000000000 +0900
+++ arch/v850/kernel/Makefile	2002-11-19 15:22:34.000000000 +0900
@@ -20,6 +20,7 @@
 obj-$(CONFIG_V850E_MA1)		+= ma.o	nb85e_utils.o nb85e_timer_d.o
 obj-$(CONFIG_V850E_NB85E)	+= nb85e_intc.o
 obj-$(CONFIG_V850E2_ANNA)	+= anna.o nb85e_intc.o nb85e_utils.o nb85e_timer_d.o
+obj-$(CONFIG_V850E_AS85EP1)	+= as85ep1.o nb85e_intc.o nb85e_utils.o nb85e_timer_d.o
 # platform-specific code
 obj-$(CONFIG_V850E_SIM)		+= sim.o simcons.o
 obj-$(CONFIG_V850E2_SIM85E2C)	+= sim85e2c.o nb85e_intc.o memcons.o
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/kernel/anna.c arch/v850/kernel/anna.c
--- ../orig/linux-2.5.48-uc0/arch/v850/kernel/anna.c	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/kernel/anna.c	2002-11-19 15:22:34.000000000 +0900
@@ -47,7 +47,7 @@
 	ANNA_BPC    = 0;
 	ANNA_BSC    = 0xAAAA;
 	ANNA_BEC    = 0;
-	ANNA_BHC    = 0x00FF;	/* icache all memory, dcache none */
+	ANNA_BHC    = 0xFFFF;	/* icache all memory, dcache all */
 	ANNA_BCT(0) = 0xB088;
 	ANNA_BCT(1) = 0x0008;
 	ANNA_DWC(0) = 0x0027;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/kernel/as85ep1.c arch/v850/kernel/as85ep1.c
--- ../orig/linux-2.5.48-uc0/arch/v850/kernel/as85ep1.c	1970-01-01 09:00:00.000000000 +0900
+++ arch/v850/kernel/as85ep1.c	2002-11-19 15:22:34.000000000 +0900
@@ -0,0 +1,241 @@
+/*
+ * arch/v850/kernel/as85ep1.c -- AS85EP1 V850E evaluation chip/board
+ *
+ *  Copyright (C) 2002  NEC Corporation
+ *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/major.h>
+#include <linux/irq.h>
+
+#include <asm/machdep.h>
+#include <asm/atomic.h>
+#include <asm/page.h>
+#include <asm/nb85e_timer_d.h>
+#include <asm/nb85e_uart.h>
+
+#include "mach.h"
+
+
+/* SRAM and SDRAM are vaguely contiguous (with a big hole in between; see
+   mach_reserve_bootmem for details); use both as one big area.  */
+#define RAM_START 	SRAM_ADDR
+#define RAM_END		(SDRAM_ADDR + SDRAM_SIZE)
+
+/* The bits of this port are connected to an 8-LED bar-graph.  */
+#define LEDS_PORT	4
+
+
+static void as85ep1_led_tick (void);
+
+extern char _intv_copy_src_start, _intv_copy_src_end;
+extern char _intv_copy_dst_start;
+
+
+void __init mach_early_init (void)
+{
+	const u32 *src;
+	register u32 *dst asm ("ep");
+
+	AS85EP1_CSC(0) = 0x0403;
+	AS85EP1_BCT(0) = 0xB8B8;
+	AS85EP1_DWC(0) = 0x0104;
+	AS85EP1_BCC    = 0x0012;
+	AS85EP1_ASC    = 0;
+	AS85EP1_LBS    = 0x00A9;
+	AS85EP1_RFS(1) = 0x8205;
+	AS85EP1_RFS(3) = 0x8205;
+	AS85EP1_SCR(1) = 0x20A9;
+	AS85EP1_SCR(3) = 0x20A9;
+
+	AS85EP1_PORT_PMC(6)  = 0xFF; /* A20-25, A0,A1 有効 */
+	AS85EP1_PORT_PMC(7)  = 0x0E; /* CS1,2,3       有効 */
+	AS85EP1_PORT_PMC(9)  = 0xFF; /* D16-23        有効 */
+	AS85EP1_PORT_PMC(10) = 0xFF; /* D24-31        有効 */
+
+	AS85EP1_IRAMM = 0x3;	/* 内蔵命令RAMは「write-mode」になります */
+
+	/* The early chip we have is buggy, so that writing the interrupt
+	   vectors into low RAM may screw up, so for non-ROM kernels, we
+	   only rely on the reset vector being downloaded, and copy the
+	   rest of the interrupt vectors into place here.  The specific bug
+	   is that writing address N, where (N & 0x10) == 0x10, will _also_
+	   write to address (N - 0x10).  We avoid this (effectively) by
+	   writing in 16-byte chunks backwards from the end.  */
+	src = (u32 *)(((u32)&_intv_copy_src_end - 1) & ~0xF);
+	dst = (u32 *)&_intv_copy_dst_start
+		+ (src - (u32 *)&_intv_copy_src_start);
+	do {
+		u32 t0 = src[0], t1 = src[1], t2 = src[2], t3 = src[3];
+		dst[0] = t0; dst[1] = t1; dst[2] = t2; dst[3] = t3;
+		dst -= 4;
+		src -= 4;
+	} while (src > (u32 *)&_intv_copy_src_start);
+
+	AS85EP1_IRAMM = 0x0;	/* 内蔵命令RAMは「read-mode」になります */
+
+	nb85e_intc_disable_irqs ();
+}
+
+void __init mach_setup (char **cmdline)
+{
+#ifdef CONFIG_V850E_NB85E_UART_CONSOLE
+	nb85e_uart_cons_init (1);
+#endif
+
+	AS85EP1_PORT_PMC (LEDS_PORT) = 0; /* Make the LEDs port an I/O port. */
+	AS85EP1_PORT_PM (LEDS_PORT) = 0; /* Make all the bits output pins.  */
+	mach_tick = as85ep1_led_tick;
+
+	ROOT_DEV = MKDEV (BLKMEM_MAJOR, 0);
+}
+
+void __init mach_get_physical_ram (unsigned long *ram_start,
+				   unsigned long *ram_len)
+{
+	*ram_start = RAM_START;
+	*ram_len = RAM_END - RAM_START;
+}
+
+void __init mach_reserve_bootmem ()
+{
+	extern char _root_fs_image_start, _root_fs_image_end;
+	u32 root_fs_image_start = (u32)&_root_fs_image_start;
+	u32 root_fs_image_end = (u32)&_root_fs_image_end;
+
+	/* We can't use the space between SRAM and SDRAM, so prevent the
+	   kernel from trying.  */
+	reserve_bootmem (SRAM_ADDR + SRAM_SIZE,
+			 SDRAM_ADDR - (SRAM_ADDR + SRAM_SIZE));
+
+	/* Reserve the memory used by the root filesystem image if it's
+	   in RAM.  */
+	if (root_fs_image_end > root_fs_image_start
+	    && root_fs_image_start >= RAM_START
+	    && root_fs_image_start < RAM_END)
+		reserve_bootmem (root_fs_image_start,
+				 root_fs_image_end - root_fs_image_start);
+}
+
+void mach_gettimeofday (struct timeval *tv)
+{
+	tv->tv_sec = 0;
+	tv->tv_usec = 0;
+}
+
+void __init mach_sched_init (struct irqaction *timer_action)
+{
+	/* Start hardware timer.  */
+	nb85e_timer_d_configure (0, HZ);
+	/* Install timer interrupt handler.  */
+	setup_irq (IRQ_INTCMD(0), timer_action);
+}
+
+static struct nb85e_intc_irq_init irq_inits[] = {
+	{ "IRQ", 0, 		NUM_MACH_IRQS,	1, 7 },
+	{ "CCC", IRQ_INTCCC(0),	IRQ_INTCCC_NUM, 1, 5 },
+	{ "CMD", IRQ_INTCMD(0), IRQ_INTCMD_NUM,	1, 5 },
+	{ "SRE", IRQ_INTSRE(0), IRQ_INTSRE_NUM,	3, 3 },
+	{ "SR",	 IRQ_INTSR(0),	IRQ_INTSR_NUM, 	3, 4 },
+	{ "ST",  IRQ_INTST(0), 	IRQ_INTST_NUM, 	3, 5 },
+	{ 0 }
+};
+#define NUM_IRQ_INITS ((sizeof irq_inits / sizeof irq_inits[0]) - 1)
+
+static struct hw_interrupt_type hw_itypes[NUM_IRQ_INITS];
+
+void __init mach_init_irqs (void)
+{
+	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
+}
+
+void machine_restart (char *__unused)
+{
+#ifdef CONFIG_RESET_GUARD
+	disable_reset_guard ();
+#endif
+	asm ("jmp r0"); /* Jump to the reset vector.  */
+}
+
+void machine_halt (void)
+{
+#ifdef CONFIG_RESET_GUARD
+	disable_reset_guard ();
+#endif
+	local_irq_disable ();	/* Ignore all interrupts.  */
+	AS85EP1_PORT_IO (LEDS_PORT) = 0xAA;	/* Note that we halted.  */
+	for (;;)
+		asm ("halt; nop; nop; nop; nop; nop");
+}
+
+void machine_power_off (void)
+{
+	machine_halt ();
+}
+
+/* Called before configuring an on-chip UART.  */
+void as85ep1_uart_pre_configure (unsigned chan, unsigned cflags, unsigned baud)
+{
+	/* Make the shared uart/port pins be uart pins.  */
+	AS85EP1_PORT_PMC(3) |= (0x5 << chan);
+
+	/* The AS85EP1 connects some general-purpose I/O pins on the CPU to
+	   the RTS/CTS lines of UART 1's serial connection.  I/O pins P53
+	   and P54 are RTS and CTS respectively.  */
+	if (chan == 1) {
+		/* Put P53 & P54 in I/O port mode.  */
+		AS85EP1_PORT_PMC(5) &= ~0x18;
+		/* Make P53 an output, and P54 an input.  */
+		AS85EP1_PORT_PM(5) |=  0x10;
+	}
+}
+
+/* Minimum and maximum bounds for the moving upper LED boundary in the
+   clock tick display.  */
+#define MIN_MAX_POS 0
+#define MAX_MAX_POS 7
+
+/* There are MAX_MAX_POS^2 - MIN_MAX_POS^2 cycles in the animation, so if
+   we pick 6 and 0 as above, we get 49 cycles, which is when divided into
+   the standard 100 value for HZ, gives us an almost 1s total time.  */
+#define TICKS_PER_FRAME \
+	(HZ / (MAX_MAX_POS * MAX_MAX_POS - MIN_MAX_POS * MIN_MAX_POS))
+
+static void as85ep1_led_tick ()
+{
+	static unsigned counter = 0;
+	
+	if (++counter == TICKS_PER_FRAME) {
+		static int pos = 0, max_pos = MAX_MAX_POS, dir = 1;
+
+		if (dir > 0 && pos == max_pos) {
+			dir = -1;
+			if (max_pos == MIN_MAX_POS)
+				max_pos = MAX_MAX_POS;
+			else
+				max_pos--;
+		} else {
+			if (dir < 0 && pos == 0)
+				dir = 1;
+
+			if (pos + dir <= max_pos) {
+				/* Each bit of port 0 has a LED. */
+				set_bit (pos, &AS85EP1_PORT_IO(LEDS_PORT));
+				pos += dir;
+				clear_bit (pos, &AS85EP1_PORT_IO(LEDS_PORT));
+			}
+		}
+
+		counter = 0;
+	}
+}
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/kernel/entry.S arch/v850/kernel/entry.S
--- ../orig/linux-2.5.48-uc0/arch/v850/kernel/entry.S	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/kernel/entry.S	2002-11-19 16:12:26.000000000 +0900
@@ -908,10 +908,10 @@
 	.long CSYM(sys_adjtimex)
 	.long CSYM(sys_ni_syscall)	// 125 - sys_mprotect
 	.long CSYM(sys_sigprocmask)
-	.long CSYM(sys_create_module)
+	.long CSYM(sys_ni_syscall)	// sys_create_module
 	.long CSYM(sys_init_module)
 	.long CSYM(sys_delete_module)
-	.long CSYM(sys_get_kernel_syms) // 130
+	.long CSYM(sys_ni_syscall)	// 130 - sys_get_kernel_syms
 	.long CSYM(sys_quotactl)
 	.long CSYM(sys_getpgid)
 	.long CSYM(sys_fchdir)
@@ -948,7 +948,7 @@
 	.long CSYM(sys_setresuid)
 	.long CSYM(sys_getresuid)	// 165
 	.long CSYM(sys_ni_syscall)	// for vm86
-	.long CSYM(sys_query_module)
+	.long CSYM(sys_ni_syscall)	// sys_query_module
 	.long CSYM(sys_poll)
 	.long CSYM(sys_nfsservctl)
 	.long CSYM(sys_setresgid)	// 170
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/kernel/procfs.c arch/v850/kernel/procfs.c
--- ../orig/linux-2.5.48-uc0/arch/v850/kernel/procfs.c	2002-11-19 10:11:31.000000000 +0900
+++ arch/v850/kernel/procfs.c	2002-11-19 15:22:34.000000000 +0900
@@ -24,7 +24,7 @@
 #else
 	seq_printf (m, "CPU-Model:	%s\n", CPU_MODEL);
 #endif
- 
+
 #ifdef CPU_CLOCK_FREQ
 	seq_printf (m, "CPU-Clock:	%ld (%ld MHz)\n",
 		    (long)CPU_CLOCK_FREQ,
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/kernel/setup.c arch/v850/kernel/setup.c
--- ../orig/linux-2.5.48-uc0/arch/v850/kernel/setup.c	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/kernel/setup.c	2002-11-19 15:22:34.000000000 +0900
@@ -270,6 +270,16 @@
 	zones_size[ZONE_DMA]
 		= ADDR_TO_PAGE (ram_len + (ram_start - PAGE_OFFSET));
 
+	/* The allocator is very picky about the address of the first
+	   allocatable page -- it must be at least as aligned as the
+	   maximum allocation -- so try to detect cases where it will get
+	   confused and signal them at compile time (this is a common
+	   problem when porting to a new platform with ).  There is a
+	   similar runtime check in free_area_init_core.  */
+#if ((PAGE_OFFSET >> PAGE_SHIFT) & ((1UL << (MAX_ORDER - 1)) - 1))
+#error MAX_ORDER is too large for given PAGE_OFFSET (use CONFIG_FORCE_MAX_ZONEORDER to change it)
+#endif
+
 	free_area_init_node (0, NODE_DATA(0), 0, zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
 	mem_map = NODE_DATA(0)->node_mem_map;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/rte_ma1_cb-ksram.ld arch/v850/rte_ma1_cb-ksram.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/rte_ma1_cb-ksram.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/rte_ma1_cb-ksram.ld	2002-11-19 15:24:18.000000000 +0900
@@ -94,7 +94,7 @@
 		. = ALIGN (4) ;
 		___initcall_end = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/rte_ma1_cb-rom.ld arch/v850/rte_ma1_cb-rom.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/rte_ma1_cb-rom.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/rte_ma1_cb-rom.ld	2002-11-19 15:24:17.000000000 +0900
@@ -46,7 +46,7 @@
 		. = ALIGN (4) ;
 		__etext = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/rte_ma1_cb.ld arch/v850/rte_ma1_cb.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/rte_ma1_cb.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/rte_ma1_cb.ld	2002-11-19 15:24:17.000000000 +0900
@@ -99,7 +99,7 @@
 		. = ALIGN (4) ;
 		___initcall_end = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/sim.ld arch/v850/sim.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/sim.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/sim.ld	2002-11-19 15:24:17.000000000 +0900
@@ -97,7 +97,7 @@
 		. = ALIGN (4) ;
 		___initcall_end = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/sim85e2c.ld arch/v850/sim85e2c.ld
--- ../orig/linux-2.5.48-uc0/arch/v850/sim85e2c.ld	2002-11-19 15:00:05.000000000 +0900
+++ arch/v850/sim85e2c.ld	2002-11-19 15:24:17.000000000 +0900
@@ -87,7 +87,7 @@
 		. = ALIGN (4) ;
 		___initcall_end = . ;
 
-		. = ALIGN (4096) ;
+		. = ALIGN (4) ;
 		___initramfs_start = . ;
 			*(.init.ramfs)
 		___initramfs_end = . ;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/arch/v850/vmlinux.lds.S arch/v850/vmlinux.lds.S
--- ../orig/linux-2.5.48-uc0/arch/v850/vmlinux.lds.S	2002-11-05 11:25:22.000000000 +0900
+++ arch/v850/vmlinux.lds.S	2002-11-19 15:26:12.000000000 +0900
@@ -20,6 +20,10 @@
 # endif
 #endif
 
+#ifdef CONFIG_V850E_AS85EP1
+# include "as85ep1.ld"
+#endif
+
 #ifdef CONFIG_RTE_CB_MA1
 # ifdef CONFIG_ROM_KERNEL
 #  include "rte_ma1_cb-rom.ld"
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/drivers/serial/Kconfig drivers/serial/Kconfig
--- ../orig/linux-2.5.48-uc0/drivers/serial/Kconfig	2002-11-19 10:11:44.000000000 +0900
+++ drivers/serial/Kconfig	2002-11-19 15:26:01.000000000 +0900
@@ -365,7 +365,7 @@
 
 config V850E_NB85E_UART
 	bool "NEC V850E on-chip UART support"
-	depends on V850E_NB85E || V850E2_ANNA
+	depends on V850E_NB85E || V850E2_ANNA || V850E_AS85EP1
 	default y
 
 config V850E_NB85E_UART_CONSOLE
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/include/asm-v850/as85ep1.h include/asm-v850/as85ep1.h
--- ../orig/linux-2.5.48-uc0/include/asm-v850/as85ep1.h	1970-01-01 09:00:00.000000000 +0900
+++ include/asm-v850/as85ep1.h	2002-11-19 15:22:34.000000000 +0900
@@ -0,0 +1,160 @@
+/*
+ * include/asm-v850/as85ep1.h -- AS85EP1 evaluation CPU chip/board
+ *
+ *  Copyright (C) 2001,2002  NEC Corporation
+ *  Copyright (C) 2001,2002  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_AS85EP1_H__
+#define __V850_AS85EP1_H__
+
+
+#define CPU_ARCH 	"v850e"
+#define CPU_MODEL	"as85ep1"
+#define CPU_MODEL_LONG	"NEC V850E/AS85EP1"
+#define PLATFORM	"AS85EP1"
+#define PLATFORM_LONG	"NEC V850E/AS85EP1 evaluation board"
+
+#define CPU_CLOCK_FREQ	100000000 /*  100MHz */
+#define SYS_CLOCK_FREQ	CPU_CLOCK_FREQ
+
+
+/* 1MB of static RAM.  */
+#define SRAM_ADDR	0x00400000
+#define SRAM_SIZE	0x00100000 /* 1MB */
+/* 64MB of DRAM.  This can actually be at one of two positions, determined
+   by jump JP3; we use the second position because the first only allows
+   access to 56MB.  */
+#define SDRAM_ADDR	0x04000000
+#define SDRAM_SIZE	0x04000000 /* 64MB */
+
+
+/* For <asm/page.h> */
+#define PAGE_OFFSET 	SRAM_ADDR
+
+/* We use on-chip RAM, for a few miscellaneous variables that must be
+   accessible using a load instruction relative to R0.  The AS85EP1 chip
+   16K of internal RAM located slightly before I/O space.  */
+#define R0_RAM_ADDR	0xFFFF8000
+
+
+/* AS85EP1 specific control registers.  */
+#define AS85EP1_CSC_ADDR(n)	(0xFFFFF060 + (n) * 2)
+#define AS85EP1_CSC(n)		(*(volatile u16 *)AS85EP1_CSC_ADDR(n))
+#define AS85EP1_BSC_ADDR	0xFFFFF066
+#define AS85EP1_BSC		(*(volatile u16 *)AS85EP1_BSC_ADDR)
+#define AS85EP1_BCT_ADDR(n)	(0xFFFFF480 + (n) * 2)
+#define AS85EP1_BCT(n)		(*(volatile u16 *)AS85EP1_BCT_ADDR(n))
+#define AS85EP1_DWC_ADDR(n)	(0xFFFFF484 + (n) * 2)
+#define AS85EP1_DWC(n)		(*(volatile u16 *)AS85EP1_DWC_ADDR(n))
+#define AS85EP1_BCC_ADDR	0xFFFFF488
+#define AS85EP1_BCC		(*(volatile u16 *)AS85EP1_BCC_ADDR)
+#define AS85EP1_ASC_ADDR	0xFFFFF48A
+#define AS85EP1_ASC		(*(volatile u16 *)AS85EP1_ASC_ADDR)
+#define AS85EP1_BCP_ADDR	0xFFFFF48C
+#define AS85EP1_BCP		(*(volatile u16 *)AS85EP1_BCP_ADDR)
+#define AS85EP1_LBS_ADDR	0xFFFFF48E
+#define AS85EP1_LBS		(*(volatile u16 *)AS85EP1_LBS_ADDR)
+#define AS85EP1_BMC_ADDR	0xFFFFF498
+#define AS85EP1_BMC		(*(volatile u16 *)AS85EP1_BMC_ADDR)
+#define AS85EP1_PRC_ADDR	0xFFFFF49A
+#define AS85EP1_PRC		(*(volatile u16 *)AS85EP1_PRC_ADDR)
+#define AS85EP1_SCR_ADDR(n)	(0xFFFFF4A0 + (n) * 4)
+#define AS85EP1_SCR(n)		(*(volatile u16 *)AS85EP1_SCR_ADDR(n))
+#define AS85EP1_RFS_ADDR(n)	(0xFFFFF4A2 + (n) * 4)
+#define AS85EP1_RFS(n)		(*(volatile u16 *)AS85EP1_RFS_ADDR(n))
+#define AS85EP1_IRAMM_ADDR	0xFFFFF80A
+#define AS85EP1_IRAMM		(*(volatile u8 *)AS85EP1_IRAMM_ADDR)
+
+
+
+/* I/O port P0-P13. */
+/* Direct I/O.  Bits 0-7 are pins Pn0-Pn7.  */
+#define AS85EP1_PORT_IO_ADDR(n)	(0xFFFFF400 + (n) * 2)
+#define AS85EP1_PORT_IO(n)	(*(volatile u8 *)AS85EP1_PORT_IO_ADDR(n))
+/* Port mode (for direct I/O, 0 = output, 1 = input).  */
+#define AS85EP1_PORT_PM_ADDR(n)	(0xFFFFF420 + (n) * 2)
+#define AS85EP1_PORT_PM(n)	(*(volatile u8 *)AS85EP1_PORT_PM_ADDR(n))
+/* Port mode control (0 = direct I/O mode, 1 = alternative I/O mode).  */
+#define AS85EP1_PORT_PMC_ADDR(n) (0xFFFFF440 + (n) * 2)
+#define AS85EP1_PORT_PMC(n)	(*(volatile u8 *)AS85EP1_PORT_PMC_ADDR(n))
+
+
+/* NB85E-style interrupt system.  */
+#include <asm/nb85e_intc.h>
+
+/* Hardware-specific interrupt numbers (in the kernel IRQ namespace).  */
+#define IRQ_INTCCC(n)	(0x0C + (n))
+#define IRQ_INTCCC_NUM	8
+#define IRQ_INTCMD(n)	(0x14 + (n)) /* interval timer interrupts 0-5 */
+#define IRQ_INTCMD_NUM	6
+#define IRQ_INTSRE(n)	(0x1E + (n)*3) /* UART 0-1 reception error */
+#define IRQ_INTSRE_NUM	2
+#define IRQ_INTSR(n)	(0x1F + (n)*3) /* UART 0-1 reception completion */
+#define IRQ_INTSR_NUM	2
+#define IRQ_INTST(n)	(0x20 + (n)*3) /* UART 0-1 transmission completion */
+#define IRQ_INTST_NUM	2
+
+#define NUM_CPU_IRQS	64
+
+#ifndef __ASSEMBLY__
+/* Initialize chip interrupts.  */
+extern void as85ep1_init_irqs (void);
+#endif
+
+
+/* AS85EP1 UART details (basically the same as the V850E/MA1, but 2 channels).  */
+#define NB85E_UART_NUM_CHANNELS		2
+#define NB85E_UART_BASE_FREQ		(SYS_CLOCK_FREQ / 4)
+#define NB85E_UART_CHIP_NAME 		"V850E/NA85E"
+
+/* This is a function that gets called before configuring the UART.  */
+#define NB85E_UART_PRE_CONFIGURE	as85ep1_uart_pre_configure
+#ifndef __ASSEMBLY__
+extern void as85ep1_uart_pre_configure (unsigned chan,
+					unsigned cflags, unsigned baud);
+#endif
+
+/* This board supports RTS/CTS for the on-chip UART, but only for channel 1. */
+
+/* CTS for UART channel 1 is pin P54 (bit 4 of port 5).  */
+#define NB85E_UART_CTS(chan)   ((chan) == 1 ? !(AS85EP1_PORT_IO(5) & 0x10) : 1)
+/* RTS for UART channel 1 is pin P53 (bit 3 of port 5).  */
+#define NB85E_UART_SET_RTS(chan, val)					      \
+   do {									      \
+	   if (chan == 1) {						      \
+		   unsigned old = AS85EP1_PORT_IO(5); 			      \
+		   if (val)						      \
+			   AS85EP1_PORT_IO(5) = old & ~0x8;		      \
+		   else							      \
+			   AS85EP1_PORT_IO(5) = old | 0x8;		      \
+	   }								      \
+   } while (0)
+
+
+/* Timer C details.  */
+#define NB85E_TIMER_C_BASE_ADDR		0xFFFFF600
+
+/* Timer D details (the AS85EP1 actually has 5 of these; should change later). */
+#define NB85E_TIMER_D_BASE_ADDR		0xFFFFF540
+#define NB85E_TIMER_D_TMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x0)
+#define NB85E_TIMER_D_CMD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x2)
+#define NB85E_TIMER_D_TMCD_BASE_ADDR 	(NB85E_TIMER_D_BASE_ADDR + 0x4)
+
+#define NB85E_TIMER_D_BASE_FREQ		SYS_CLOCK_FREQ
+#define NB85E_TIMER_D_TMCD_CS_MIN	2 /* min 2^2 divider */
+
+
+/* For <asm/param.h> */
+#ifndef HZ
+#define HZ	100
+#endif
+
+
+#endif /* __V850_AS85EP1_H__ */
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/include/asm-v850/hardirq.h include/asm-v850/hardirq.h
--- ../orig/linux-2.5.48-uc0/include/asm-v850/hardirq.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/hardirq.h	2002-11-19 15:29:53.000000000 +0900
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
+#include <linux/cache.h>
 
 typedef struct {
 	unsigned int __softirq_pending;
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/include/asm-v850/machdep.h include/asm-v850/machdep.h
--- ../orig/linux-2.5.48-uc0/include/asm-v850/machdep.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/machdep.h	2002-11-19 15:22:34.000000000 +0900
@@ -24,10 +24,13 @@
 #include <asm/teg.h>
 #endif
 
-/* Anna is both a chip _and_ a platform, so put it in the middle... */
+/* These are both chips _and_ platforms, so put them in the middle... */
 #ifdef CONFIG_V850E2_ANNA
 #include <asm/anna.h>
 #endif
+#ifdef CONFIG_V850E_AS85EP1
+#include <asm/as85ep1.h>
+#endif
 
 /* platforms */
 #ifdef CONFIG_RTE_CB_MA1
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/include/asm-v850/stat.h include/asm-v850/stat.h
--- ../orig/linux-2.5.48-uc0/include/asm-v850/stat.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/stat.h	2002-11-19 15:36:30.000000000 +0900
@@ -46,13 +46,13 @@
 	unsigned long	__unused4; /* future possible st_blocks high bits */
 
 	unsigned long	st_atime;
-	unsigned long	__unused5;
+	unsigned long	st_atime_nsec;
 
 	unsigned long	st_mtime;
-	unsigned long	__unused6;
+	unsigned long	st_mtime_nsec;
 
 	unsigned long	st_ctime;
-	unsigned long	__unused7; /* high 32 bits of ctime someday */
+	unsigned long	st_ctime_nsec;
 
 	unsigned long	__unused8;
 };
diff -ruN -X../cludes ../orig/linux-2.5.48-uc0/include/asm-v850/unistd.h include/asm-v850/unistd.h
--- ../orig/linux-2.5.48-uc0/include/asm-v850/unistd.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/unistd.h	2002-11-19 15:22:34.000000000 +0900
@@ -239,11 +239,18 @@
 #define SYSCALL_SHORT_CLOBBERS	SYSCALL_CLOBBERS, "r13", "r14"
 
 
+/* User programs sometimes end up including this header file
+   (indirectly, via uClibc header files), so I'm a bit nervous just
+   including <linux/compiler.h>.  */
+#if !defined(__builtin_expect) && __GNUC__ == 2 && __GNUC_MINOR__ < 96
+#define __builtin_expect(x, expected_value) (x)
+#endif
+
 #define __syscall_return(type, res)					      \
   do {									      \
 	  /* user-visible error numbers are in the range -1 - -124:	      \
 	     see <asm-v850/errno.h> */					      \
-	  if ((unsigned long)(res) >= (unsigned long)(-125)) {		      \
+	  if (__builtin_expect ((unsigned long)(res) >= (unsigned long)(-125), 0)) { \
 		  errno = -(res);					      \
 		  res = -1;						      \
 	  }								      \
@@ -340,6 +347,30 @@
   __syscall_return (type, __ret);					      \
 }
 
+#if __GNUC__ < 3
+/* In older versions of gcc, `asm' statements with more than 10
+   input/output arguments produce a fatal error.  To work around this
+   problem, we use two versions, one for gcc-3.x and one for earlier
+   versions of gcc (the `earlier gcc' version doesn't work with gcc-3.x
+   because gcc-3.x doesn't allow clobbers to also be input arguments).  */
+#define __SYSCALL6_TRAP(syscall, ret, a, b, c, d, e, f)			      \
+  __asm__ __volatile__ ("trap " SYSCALL_LONG_TRAP			      \
+			: "=r" (ret), "=r" (syscall)			      \
+			: "1" (syscall),				      \
+			"r" (a), "r" (b), "r" (c), "r" (d),		      \
+ 			"r" (e), "r" (f)				      \
+			: SYSCALL_CLOBBERS, SYSCALL_ARG4, SYSCALL_ARG5);
+#else /* __GNUC__ >= 3 */
+#define __SYSCALL6_TRAP(syscall, ret, a, b, c, d, e, f)			      \
+  __asm__ __volatile__ ("trap " SYSCALL_LONG_TRAP			      \
+			: "=r" (ret), "=r" (syscall),			      \
+ 			"=r" (e), "=r" (f)				      \
+			: "1" (syscall),				      \
+			"r" (a), "r" (b), "r" (c), "r" (d),		      \
+			"2" (e), "3" (f)				      \
+			: SYSCALL_CLOBBERS);
+#endif
+
 #define _syscall6(type, name, atype, a, btype, b, ctype, c, dtype, d, etype, e, ftype, f) \
 type name (atype a, btype b, ctype c, dtype d, etype e, ftype f)	      \
 {									      \
@@ -351,13 +382,7 @@
   register etype __f __asm__ (SYSCALL_ARG5) = f;			      \
   register unsigned long __syscall __asm__ (SYSCALL_NUM) = __NR_##name;	      \
   register unsigned long __ret __asm__ (SYSCALL_RET);			      \
-  __asm__ __volatile__ ("trap " SYSCALL_LONG_TRAP			      \
-			: "=r" (__ret), "=r" (__syscall), 		      \
- 			"=r" (__e), "=r" (__f)				      \
-			: "1" (__syscall),				      \
-			"r" (__a), "r" (__b), "r" (__c), "r" (__d),	      \
-			"2" (__e), "3" (__f)				      \
-			: SYSCALL_CLOBBERS);				      \
+  __SYSCALL6_TRAP(__syscall, __ret, __a, __b, __c, __d, __e, __f);	      \
   __syscall_return (type, __ret);					      \
 }
 		
@@ -398,8 +423,8 @@
 /*
  * "Conditional" syscalls
  */
-#define cond_syscall(name)						\
-  asm (".weak\t" C_SYMBOL_STRING(name) ";"				\
+#define cond_syscall(name)						      \
+  asm (".weak\t" C_SYMBOL_STRING(name) ";"				      \
        ".set\t" C_SYMBOL_STRING(name) "," C_SYMBOL_STRING(sys_ni_syscall));
 #if 0
 /* This doesn't work if there's a function prototype for NAME visible,

--=-=-=
Content-Type: text/plain; charset=iso-2022-jp



Thanks,

-Miles
-- 
自らを空にして、心を開く時、道は開かれる

--=-=-=--
