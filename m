Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVH2QKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVH2QKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVH2QJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:09:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43475 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751092AbVH2QJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:09:52 -0400
Subject: [patch 05/16] Add support for MIPS platforms to KGDB
Date: Mon, 29 Aug 2005 09:09:50 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
       mlachwani@mvista.com, ralf@linux-mips.org
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.5.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.4.2982005.trini@kernel.crashing.org>
References: <resend.4.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds basic support to the MIPS architecture as well as support
specifically for the MIPS Malta and SiByte 1250-SWARM (32 and 64bit), all from
Manish Lachwani.  This looks like it should work on anything with an
8250-compatible uart, and be fairly easy to convert other boards custom uarts
as needed.

---

 linux-2.6.13-trini/arch/mips/Kconfig.debug                   |   19 
 linux-2.6.13-trini/arch/mips/kernel/Makefile                 |    3 
 linux-2.6.13-trini/arch/mips/kernel/irq.c                    |   32 
 linux-2.6.13-trini/arch/mips/kernel/kgdb-jmp.c               |  116 +
 linux-2.6.13-trini/arch/mips/kernel/kgdb-setjmp.S            |   27 
 linux-2.6.13-trini/arch/mips/kernel/kgdb.c                   |  296 ++
 linux-2.6.13-trini/arch/mips/kernel/kgdb_handler.S           |   58 
 linux-2.6.13-trini/arch/mips/kernel/traps.c                  |   26 
 linux-2.6.13-trini/arch/mips/mips-boards/generic/Makefile    |    1 
 linux-2.6.13-trini/arch/mips/mips-boards/generic/init.c      |   62 
 linux-2.6.13-trini/arch/mips/mips-boards/malta/malta_setup.c |    8 
 linux-2.6.13-trini/arch/mips/mm/extable.c                    |    7 
 linux-2.6.13-trini/arch/mips/sibyte/cfe/setup.c              |   14 
 linux-2.6.13-trini/arch/mips/sibyte/sb1250/Makefile          |    1 
 linux-2.6.13-trini/arch/mips/sibyte/sb1250/irq.c             |   57 
 linux-2.6.13-trini/arch/mips/sibyte/sb1250/irq_handler.S     |    2 
 linux-2.6.13-trini/arch/mips/sibyte/sb1250/kgdb_sibyte.c     |  164 +
 linux-2.6.13-trini/arch/mips/sibyte/swarm/Makefile           |    2 
 linux-2.6.13-trini/include/asm-mips/kdebug.h                 |   47 
 linux-2.6.13-trini/include/asm-mips/kgdb.h                   |   22 
 linux-2.6.13-trini/lib/Kconfig.debug                         |    7 
 linux-2.6.13/arch/mips/kernel/gdb-low.S                      |  370 ---
 linux-2.6.13/arch/mips/kernel/gdb-stub.c                     | 1091 ----------
 linux-2.6.13/arch/mips/sibyte/swarm/dbg_io.c                 |   76 
 24 files changed, 791 insertions(+), 1717 deletions(-)

diff -puN arch/mips/Kconfig.debug~mips-lite arch/mips/Kconfig.debug
--- linux-2.6.13/arch/mips/Kconfig.debug~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/Kconfig.debug	2005-08-16 17:32:26.000000000 -0700
@@ -27,25 +27,6 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
-config KGDB
-	bool "Remote GDB kernel debugging"
-	depends on DEBUG_KERNEL
-	select DEBUG_INFO
-	help
-	  If you say Y here, it will be possible to remotely debug the MIPS
-	  kernel using gdb. This enlarges your kernel image disk size by
-	  several megabytes and requires a machine with more than 16 MB,
-	  better 32 MB RAM to avoid excessive linking time. This is only
-	  useful for kernel hackers. If unsure, say N.
-
-config GDB_CONSOLE
-	bool "Console output to GDB"
-	depends on KGDB
-	help
-	  If you are using GDB for remote debugging over a serial port and
-	  would like kernel messages to be formatted into GDB $O packets so
-	  that GDB prints them as program output, say 'Y'.
-
 config SB1XXX_CORELIS
 	bool "Corelis Debugger"
 	depends on SIBYTE_SB1xxx_SOC
diff -L arch/mips/kernel/gdb-low.S -puN arch/mips/kernel/gdb-low.S~mips-lite /dev/null
--- linux-2.6.13/arch/mips/kernel/gdb-low.S
+++ /dev/null	2005-08-15 07:19:53.144310000 -0700
@@ -1,370 +0,0 @@
-/*
- * gdb-low.S contains the low-level trap handler for the GDB stub.
- *
- * Copyright (C) 1995 Andreas Busse
- */
-#include <linux/config.h>
-#include <linux/sys.h>
-
-#include <asm/asm.h>
-#include <asm/errno.h>
-#include <asm/mipsregs.h>
-#include <asm/regdef.h>
-#include <asm/stackframe.h>
-#include <asm/gdb-stub.h>
-
-#ifdef CONFIG_MIPS32
-#define DMFC0	mfc0
-#define DMTC0	mtc0
-#define LDC1	lwc1
-#define SDC1	lwc1
-#endif
-#ifdef CONFIG_MIPS64
-#define DMFC0	dmfc0
-#define DMTC0	dmtc0
-#define LDC1	ldc1
-#define SDC1	ldc1
-#endif
-
-/*
- * [jsun] We reserves about 2x GDB_FR_SIZE in stack.  The lower (addressed)
- * part is used to store registers and passed to exception handler.
- * The upper part is reserved for "call func" feature where gdb client
- * saves some of the regs, setups call frame and passes args.
- *
- * A trace shows about 200 bytes are used to store about half of all regs.
- * The rest should be big enough for frame setup and passing args.
- */
-
-/*
- * The low level trap handler
- */
-		.align 	5
-		NESTED(trap_low, GDB_FR_SIZE, sp)
- 		.set	noat
-		.set 	noreorder
-
-		mfc0	k0, CP0_STATUS
-		sll	k0, 3     		/* extract cu0 bit */
-		bltz	k0, 1f
-		move	k1, sp
-
-		/*
-		 * Called from user mode, go somewhere else.
-		 */
-		lui	k1, %hi(saved_vectors)
-		mfc0	k0, CP0_CAUSE
-		andi	k0, k0, 0x7c
-		add	k1, k1, k0
-		lw	k0, %lo(saved_vectors)(k1)
-		jr	k0
-		nop
-1:
-		move	k0, sp
-		subu	sp, k1, GDB_FR_SIZE*2	# see comment above
-		LONG_S	k0, GDB_FR_REG29(sp)
-		LONG_S	$2, GDB_FR_REG2(sp)
-
-/*
- * First save the CP0 and special registers
- */
-
-		mfc0	v0, CP0_STATUS
-		LONG_S	v0, GDB_FR_STATUS(sp)
-		mfc0	v0, CP0_CAUSE
-		LONG_S	v0, GDB_FR_CAUSE(sp)
-		DMFC0	v0, CP0_EPC
-		LONG_S	v0, GDB_FR_EPC(sp)
-		DMFC0	v0, CP0_BADVADDR
-		LONG_S	v0, GDB_FR_BADVADDR(sp)
-		mfhi	v0
-		LONG_S	v0, GDB_FR_HI(sp)
-		mflo	v0
-		LONG_S	v0, GDB_FR_LO(sp)
-
-/*
- * Now the integer registers
- */
-
-		LONG_S	zero, GDB_FR_REG0(sp)		/* I know... */
-		LONG_S	$1, GDB_FR_REG1(sp)
-		/* v0 already saved */
-		LONG_S	$3, GDB_FR_REG3(sp)
-		LONG_S	$4, GDB_FR_REG4(sp)
-		LONG_S	$5, GDB_FR_REG5(sp)
-		LONG_S	$6, GDB_FR_REG6(sp)
-		LONG_S	$7, GDB_FR_REG7(sp)
-		LONG_S	$8, GDB_FR_REG8(sp)
-		LONG_S	$9, GDB_FR_REG9(sp)
-		LONG_S	$10, GDB_FR_REG10(sp)
-		LONG_S	$11, GDB_FR_REG11(sp)
-		LONG_S	$12, GDB_FR_REG12(sp)
-		LONG_S	$13, GDB_FR_REG13(sp)
-		LONG_S	$14, GDB_FR_REG14(sp)
-		LONG_S	$15, GDB_FR_REG15(sp)
-		LONG_S	$16, GDB_FR_REG16(sp)
-		LONG_S	$17, GDB_FR_REG17(sp)
-		LONG_S	$18, GDB_FR_REG18(sp)
-		LONG_S	$19, GDB_FR_REG19(sp)
-		LONG_S	$20, GDB_FR_REG20(sp)
-		LONG_S	$21, GDB_FR_REG21(sp)
-		LONG_S	$22, GDB_FR_REG22(sp)
-		LONG_S	$23, GDB_FR_REG23(sp)
-		LONG_S	$24, GDB_FR_REG24(sp)
-		LONG_S	$25, GDB_FR_REG25(sp)
-		LONG_S	$26, GDB_FR_REG26(sp)
-		LONG_S	$27, GDB_FR_REG27(sp)
-		LONG_S	$28, GDB_FR_REG28(sp)
-		/* sp already saved */
-		LONG_S	$30, GDB_FR_REG30(sp)
-		LONG_S	$31, GDB_FR_REG31(sp)
-
-		CLI				/* disable interrupts */
-
-/*
- * Followed by the floating point registers
- */
-		mfc0	v0, CP0_STATUS		/* FPU enabled? */
-		srl	v0, v0, 16
-		andi	v0, v0, (ST0_CU1 >> 16)
-
-		beqz	v0,2f			/* disabled, skip */
-		 nop
-
-		SDC1	$0, GDB_FR_FPR0(sp)
-		SDC1	$1, GDB_FR_FPR1(sp)
-		SDC1	$2, GDB_FR_FPR2(sp)
-		SDC1	$3, GDB_FR_FPR3(sp)
-		SDC1	$4, GDB_FR_FPR4(sp)
-		SDC1	$5, GDB_FR_FPR5(sp)
-		SDC1	$6, GDB_FR_FPR6(sp)
-		SDC1	$7, GDB_FR_FPR7(sp)
-		SDC1	$8, GDB_FR_FPR8(sp)
-		SDC1	$9, GDB_FR_FPR9(sp)
-		SDC1	$10, GDB_FR_FPR10(sp)
-		SDC1	$11, GDB_FR_FPR11(sp)
-		SDC1	$12, GDB_FR_FPR12(sp)
-		SDC1	$13, GDB_FR_FPR13(sp)
-		SDC1	$14, GDB_FR_FPR14(sp)
-		SDC1	$15, GDB_FR_FPR15(sp)
-		SDC1	$16, GDB_FR_FPR16(sp)
-		SDC1	$17, GDB_FR_FPR17(sp)
-		SDC1	$18, GDB_FR_FPR18(sp)
-		SDC1	$19, GDB_FR_FPR19(sp)
-		SDC1	$20, GDB_FR_FPR20(sp)
-		SDC1	$21, GDB_FR_FPR21(sp)
-		SDC1	$22, GDB_FR_FPR22(sp)
-		SDC1	$23, GDB_FR_FPR23(sp)
-		SDC1	$24, GDB_FR_FPR24(sp)
-		SDC1	$25, GDB_FR_FPR25(sp)
-		SDC1	$26, GDB_FR_FPR26(sp)
-		SDC1	$27, GDB_FR_FPR27(sp)
-		SDC1	$28, GDB_FR_FPR28(sp)
-		SDC1	$29, GDB_FR_FPR29(sp)
-		SDC1	$30, GDB_FR_FPR30(sp)
-		SDC1	$31, GDB_FR_FPR31(sp)
-
-/*
- * FPU control registers
- */
-
-		cfc1	v0, CP1_STATUS
-		LONG_S	v0, GDB_FR_FSR(sp)
-		cfc1	v0, CP1_REVISION
-		LONG_S	v0, GDB_FR_FIR(sp)
-
-/*
- * Current stack frame ptr
- */
-
-2:
-		LONG_S	sp, GDB_FR_FRP(sp)
-
-/*
- * CP0 registers (R4000/R4400 unused registers skipped)
- */
-
-		mfc0	v0, CP0_INDEX
-		LONG_S	v0, GDB_FR_CP0_INDEX(sp)
-		mfc0	v0, CP0_RANDOM
-		LONG_S	v0, GDB_FR_CP0_RANDOM(sp)
-		DMFC0	v0, CP0_ENTRYLO0
-		LONG_S	v0, GDB_FR_CP0_ENTRYLO0(sp)
-		DMFC0	v0, CP0_ENTRYLO1
-		LONG_S	v0, GDB_FR_CP0_ENTRYLO1(sp)
-		DMFC0	v0, CP0_CONTEXT
-		LONG_S	v0, GDB_FR_CP0_CONTEXT(sp)
-		mfc0	v0, CP0_PAGEMASK
-		LONG_S	v0, GDB_FR_CP0_PAGEMASK(sp)
-		mfc0	v0, CP0_WIRED
-		LONG_S	v0, GDB_FR_CP0_WIRED(sp)
-		DMFC0	v0, CP0_ENTRYHI
-		LONG_S	v0, GDB_FR_CP0_ENTRYHI(sp)
-		mfc0	v0, CP0_PRID
-		LONG_S	v0, GDB_FR_CP0_PRID(sp)
-
-		.set	at
-
-/*
- * Continue with the higher level handler
- */
-
-		move	a0,sp
-
-		jal	handle_exception
-		 nop
-
-/*
- * Restore all writable registers, in reverse order
- */
-
-		.set	noat
-
-		LONG_L	v0, GDB_FR_CP0_ENTRYHI(sp)
-		LONG_L	v1, GDB_FR_CP0_WIRED(sp)
-		DMTC0	v0, CP0_ENTRYHI
-		mtc0	v1, CP0_WIRED
-		LONG_L	v0, GDB_FR_CP0_PAGEMASK(sp)
-		LONG_L	v1, GDB_FR_CP0_ENTRYLO1(sp)
-		mtc0	v0, CP0_PAGEMASK
-		DMTC0	v1, CP0_ENTRYLO1
-		LONG_L	v0, GDB_FR_CP0_ENTRYLO0(sp)
-		LONG_L	v1, GDB_FR_CP0_INDEX(sp)
-		DMTC0	v0, CP0_ENTRYLO0
-		LONG_L	v0, GDB_FR_CP0_CONTEXT(sp)
-		mtc0	v1, CP0_INDEX
-		DMTC0	v0, CP0_CONTEXT
-
-
-/*
- * Next, the floating point registers
- */
-		mfc0	v0, CP0_STATUS		/* check if the FPU is enabled */
-		srl	v0, v0, 16
-		andi	v0, v0, (ST0_CU1 >> 16)
-
-		beqz	v0, 3f			/* disabled, skip */
-		 nop
-
-		LDC1	$31, GDB_FR_FPR31(sp)
-		LDC1	$30, GDB_FR_FPR30(sp)
-		LDC1	$29, GDB_FR_FPR29(sp)
-		LDC1	$28, GDB_FR_FPR28(sp)
-		LDC1	$27, GDB_FR_FPR27(sp)
-		LDC1	$26, GDB_FR_FPR26(sp)
-		LDC1	$25, GDB_FR_FPR25(sp)
-		LDC1	$24, GDB_FR_FPR24(sp)
-		LDC1	$23, GDB_FR_FPR23(sp)
-		LDC1	$22, GDB_FR_FPR22(sp)
-		LDC1	$21, GDB_FR_FPR21(sp)
-		LDC1	$20, GDB_FR_FPR20(sp)
-		LDC1	$19, GDB_FR_FPR19(sp)
-		LDC1	$18, GDB_FR_FPR18(sp)
-		LDC1	$17, GDB_FR_FPR17(sp)
-		LDC1	$16, GDB_FR_FPR16(sp)
-		LDC1	$15, GDB_FR_FPR15(sp)
-		LDC1	$14, GDB_FR_FPR14(sp)
-		LDC1	$13, GDB_FR_FPR13(sp)
-		LDC1	$12, GDB_FR_FPR12(sp)
-		LDC1	$11, GDB_FR_FPR11(sp)
-		LDC1	$10, GDB_FR_FPR10(sp)
-		LDC1	$9, GDB_FR_FPR9(sp)
-		LDC1	$8, GDB_FR_FPR8(sp)
-		LDC1	$7, GDB_FR_FPR7(sp)
-		LDC1	$6, GDB_FR_FPR6(sp)
-		LDC1	$5, GDB_FR_FPR5(sp)
-		LDC1	$4, GDB_FR_FPR4(sp)
-		LDC1	$3, GDB_FR_FPR3(sp)
-		LDC1	$2, GDB_FR_FPR2(sp)
-		LDC1	$1, GDB_FR_FPR1(sp)
-		LDC1	$0, GDB_FR_FPR0(sp)
-
-/*
- * Now the CP0 and integer registers
- */
-
-3:
-		mfc0	t0, CP0_STATUS
-		ori	t0, 0x1f
-		xori	t0, 0x1f
-		mtc0	t0, CP0_STATUS
-
-		LONG_L	v0, GDB_FR_STATUS(sp)
-		LONG_L	v1, GDB_FR_EPC(sp)
-		mtc0	v0, CP0_STATUS
-		DMTC0	v1, CP0_EPC
-		LONG_L	v0, GDB_FR_HI(sp)
-		LONG_L	v1, GDB_FR_LO(sp)
-		mthi	v0
-		mtlo	v1
-		LONG_L	$31, GDB_FR_REG31(sp)
-		LONG_L	$30, GDB_FR_REG30(sp)
-		LONG_L	$28, GDB_FR_REG28(sp)
-		LONG_L	$27, GDB_FR_REG27(sp)
-		LONG_L	$26, GDB_FR_REG26(sp)
-		LONG_L	$25, GDB_FR_REG25(sp)
-		LONG_L	$24, GDB_FR_REG24(sp)
-		LONG_L	$23, GDB_FR_REG23(sp)
-		LONG_L	$22, GDB_FR_REG22(sp)
-		LONG_L	$21, GDB_FR_REG21(sp)
-		LONG_L	$20, GDB_FR_REG20(sp)
-		LONG_L	$19, GDB_FR_REG19(sp)
-		LONG_L	$18, GDB_FR_REG18(sp)
-		LONG_L	$17, GDB_FR_REG17(sp)
-		LONG_L	$16, GDB_FR_REG16(sp)
-		LONG_L	$15, GDB_FR_REG15(sp)
-		LONG_L	$14, GDB_FR_REG14(sp)
-		LONG_L	$13, GDB_FR_REG13(sp)
-		LONG_L	$12, GDB_FR_REG12(sp)
-		LONG_L	$11, GDB_FR_REG11(sp)
-		LONG_L	$10, GDB_FR_REG10(sp)
-		LONG_L	$9, GDB_FR_REG9(sp)
-		LONG_L	$8, GDB_FR_REG8(sp)
-		LONG_L	$7, GDB_FR_REG7(sp)
-		LONG_L	$6, GDB_FR_REG6(sp)
-		LONG_L	$5, GDB_FR_REG5(sp)
-		LONG_L	$4, GDB_FR_REG4(sp)
-		LONG_L	$3, GDB_FR_REG3(sp)
-		LONG_L	$2, GDB_FR_REG2(sp)
-		LONG_L	$1, GDB_FR_REG1(sp)
-#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
-		LONG_L	k0, GDB_FR_EPC(sp)
-		LONG_L	$29, GDB_FR_REG29(sp)		/* Deallocate stack */
-		jr	k0
-		rfe
-#else
-		LONG_L	sp, GDB_FR_REG29(sp)		/* Deallocate stack */
-
-		.set	mips3
-		eret
-		.set	mips0
-#endif
-		.set	at
-		.set	reorder
-		END(trap_low)
-
-LEAF(kgdb_read_byte)
-4:		lb	t0, (a0)
-		sb	t0, (a1)
-		li	v0, 0
-		jr	ra
-		.section __ex_table,"a"
-		PTR	4b, kgdbfault
-		.previous
-		END(kgdb_read_byte)
-
-LEAF(kgdb_write_byte)
-5:		sb	a0, (a1)
-		li	v0, 0
-		jr	ra
-		.section __ex_table,"a"
-		PTR	5b, kgdbfault
-		.previous
-		END(kgdb_write_byte)
-
-		.type	kgdbfault@function
-		.ent	kgdbfault
-
-kgdbfault:	li	v0, -EFAULT
-		jr	ra
-		.end	kgdbfault
diff -L arch/mips/kernel/gdb-stub.c -puN arch/mips/kernel/gdb-stub.c~mips-lite /dev/null
--- linux-2.6.13/arch/mips/kernel/gdb-stub.c
+++ /dev/null	2005-08-15 07:19:53.144310000 -0700
@@ -1,1091 +0,0 @@
-/*
- *  arch/mips/kernel/gdb-stub.c
- *
- *  Originally written by Glenn Engel, Lake Stevens Instrument Division
- *
- *  Contributed by HP Systems
- *
- *  Modified for SPARC by Stu Grossman, Cygnus Support.
- *
- *  Modified for Linux/MIPS (and MIPS in general) by Andreas Busse
- *  Send complaints, suggestions etc. to <andy@waldorf-gmbh.de>
- *
- *  Copyright (C) 1995 Andreas Busse
- *
- *  Copyright (C) 2003 MontaVista Software Inc.
- *  Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- */
-
-/*
- *  To enable debugger support, two things need to happen.  One, a
- *  call to set_debug_traps() is necessary in order to allow any breakpoints
- *  or error conditions to be properly intercepted and reported to gdb.
- *  Two, a breakpoint needs to be generated to begin communication.  This
- *  is most easily accomplished by a call to breakpoint().  Breakpoint()
- *  simulates a breakpoint by executing a BREAK instruction.
- *
- *
- *    The following gdb commands are supported:
- *
- * command          function                               Return value
- *
- *    g             return the value of the CPU registers  hex data or ENN
- *    G             set the value of the CPU registers     OK or ENN
- *
- *    mAA..AA,LLLL  Read LLLL bytes at address AA..AA      hex data or ENN
- *    MAA..AA,LLLL: Write LLLL bytes at address AA.AA      OK or ENN
- *
- *    c             Resume at current address              SNN   ( signal NN)
- *    cAA..AA       Continue at address AA..AA             SNN
- *
- *    s             Step one instruction                   SNN
- *    sAA..AA       Step one instruction from AA..AA       SNN
- *
- *    k             kill
- *
- *    ?             What was the last sigval ?             SNN   (signal NN)
- *
- *    bBB..BB	    Set baud rate to BB..BB		   OK or BNN, then sets
- *							   baud rate
- *
- * All commands and responses are sent with a packet which includes a
- * checksum.  A packet consists of
- *
- * $<packet info>#<checksum>.
- *
- * where
- * <packet info> :: <characters representing the command or response>
- * <checksum>    :: < two hex digits computed as modulo 256 sum of <packetinfo>>
- *
- * When a packet is received, it is first acknowledged with either '+' or '-'.
- * '+' indicates a successful transfer.  '-' indicates a failed transfer.
- *
- * Example:
- *
- * Host:                  Reply:
- * $m0,10#2a               +$00010203040506070809101112131415#42
- *
- *
- *  ==============
- *  MORE EXAMPLES:
- *  ==============
- *
- *  For reference -- the following are the steps that one
- *  company took (RidgeRun Inc) to get remote gdb debugging
- *  going. In this scenario the host machine was a PC and the
- *  target platform was a Galileo EVB64120A MIPS evaluation
- *  board.
- *
- *  Step 1:
- *  First download gdb-5.0.tar.gz from the internet.
- *  and then build/install the package.
- *
- *  Example:
- *    $ tar zxf gdb-5.0.tar.gz
- *    $ cd gdb-5.0
- *    $ ./configure --target=mips-linux-elf
- *    $ make
- *    $ install
- *    $ which mips-linux-elf-gdb
- *    /usr/local/bin/mips-linux-elf-gdb
- *
- *  Step 2:
- *  Configure linux for remote debugging and build it.
- *
- *  Example:
- *    $ cd ~/linux
- *    $ make menuconfig <go to "Kernel Hacking" and turn on remote debugging>
- *    $ make
- *
- *  Step 3:
- *  Download the kernel to the remote target and start
- *  the kernel running. It will promptly halt and wait
- *  for the host gdb session to connect. It does this
- *  since the "Kernel Hacking" option has defined
- *  CONFIG_KGDB which in turn enables your calls
- *  to:
- *     set_debug_traps();
- *     breakpoint();
- *
- *  Step 4:
- *  Start the gdb session on the host.
- *
- *  Example:
- *    $ mips-linux-elf-gdb vmlinux
- *    (gdb) set remotebaud 115200
- *    (gdb) target remote /dev/ttyS1
- *    ...at this point you are connected to
- *       the remote target and can use gdb
- *       in the normal fasion. Setting
- *       breakpoints, single stepping,
- *       printing variables, etc.
- */
-#include <linux/config.h>
-#include <linux/string.h>
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/console.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/reboot.h>
-
-#include <asm/asm.h>
-#include <asm/cacheflush.h>
-#include <asm/mipsregs.h>
-#include <asm/pgtable.h>
-#include <asm/system.h>
-#include <asm/gdb-stub.h>
-#include <asm/inst.h>
-
-/*
- * external low-level support routines
- */
-
-extern int putDebugChar(char c);    /* write a single character      */
-extern char getDebugChar(void);     /* read and return a single char */
-extern void trap_low(void);
-
-/*
- * breakpoint and test functions
- */
-extern void breakpoint(void);
-extern void breakinst(void);
-extern void async_breakpoint(void);
-extern void async_breakinst(void);
-extern void adel(void);
-
-/*
- * local prototypes
- */
-
-static void getpacket(char *buffer);
-static void putpacket(char *buffer);
-static int computeSignal(int tt);
-static int hex(unsigned char ch);
-static int hexToInt(char **ptr, int *intValue);
-static int hexToLong(char **ptr, long *longValue);
-static unsigned char *mem2hex(char *mem, char *buf, int count, int may_fault);
-void handle_exception(struct gdb_regs *regs);
-
-int kgdb_enabled;
-
-/*
- * spin locks for smp case
- */
-static spinlock_t kgdb_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t kgdb_cpulock[NR_CPUS] = { [0 ... NR_CPUS-1] = SPIN_LOCK_UNLOCKED};
-
-/*
- * BUFMAX defines the maximum number of characters in inbound/outbound buffers
- * at least NUMREGBYTES*2 are needed for register packets
- */
-#define BUFMAX 2048
-
-static char input_buffer[BUFMAX];
-static char output_buffer[BUFMAX];
-static int initialized;	/* !0 means we've been initialized */
-static int kgdb_started;
-static const char hexchars[]="0123456789abcdef";
-
-/* Used to prevent crashes in memory access.  Note that they'll crash anyway if
-   we haven't set up fault handlers yet... */
-int kgdb_read_byte(unsigned char *address, unsigned char *dest);
-int kgdb_write_byte(unsigned char val, unsigned char *dest);
-
-/*
- * Convert ch from a hex digit to an int
- */
-static int hex(unsigned char ch)
-{
-	if (ch >= 'a' && ch <= 'f')
-		return ch-'a'+10;
-	if (ch >= '0' && ch <= '9')
-		return ch-'0';
-	if (ch >= 'A' && ch <= 'F')
-		return ch-'A'+10;
-	return -1;
-}
-
-/*
- * scan for the sequence $<data>#<checksum>
- */
-static void getpacket(char *buffer)
-{
-	unsigned char checksum;
-	unsigned char xmitcsum;
-	int i;
-	int count;
-	unsigned char ch;
-
-	do {
-		/*
-		 * wait around for the start character,
-		 * ignore all other characters
-		 */
-		while ((ch = (getDebugChar() & 0x7f)) != '$') ;
-
-		checksum = 0;
-		xmitcsum = -1;
-		count = 0;
-
-		/*
-		 * now, read until a # or end of buffer is found
-		 */
-		while (count < BUFMAX) {
-			ch = getDebugChar();
-			if (ch == '#')
-				break;
-			checksum = checksum + ch;
-			buffer[count] = ch;
-			count = count + 1;
-		}
-
-		if (count >= BUFMAX)
-			continue;
-
-		buffer[count] = 0;
-
-		if (ch == '#') {
-			xmitcsum = hex(getDebugChar() & 0x7f) << 4;
-			xmitcsum |= hex(getDebugChar() & 0x7f);
-
-			if (checksum != xmitcsum)
-				putDebugChar('-');	/* failed checksum */
-			else {
-				putDebugChar('+'); /* successful transfer */
-
-				/*
-				 * if a sequence char is present,
-				 * reply the sequence ID
-				 */
-				if (buffer[2] == ':') {
-					putDebugChar(buffer[0]);
-					putDebugChar(buffer[1]);
-
-					/*
-					 * remove sequence chars from buffer
-					 */
-					count = strlen(buffer);
-					for (i=3; i <= count; i++)
-						buffer[i-3] = buffer[i];
-				}
-			}
-		}
-	}
-	while (checksum != xmitcsum);
-}
-
-/*
- * send the packet in buffer.
- */
-static void putpacket(char *buffer)
-{
-	unsigned char checksum;
-	int count;
-	unsigned char ch;
-
-	/*
-	 * $<packet info>#<checksum>.
-	 */
-
-	do {
-		putDebugChar('$');
-		checksum = 0;
-		count = 0;
-
-		while ((ch = buffer[count]) != 0) {
-			if (!(putDebugChar(ch)))
-				return;
-			checksum += ch;
-			count += 1;
-		}
-
-		putDebugChar('#');
-		putDebugChar(hexchars[checksum >> 4]);
-		putDebugChar(hexchars[checksum & 0xf]);
-
-	}
-	while ((getDebugChar() & 0x7f) != '+');
-}
-
-
-/*
- * Convert the memory pointed to by mem into hex, placing result in buf.
- * Return a pointer to the last char put in buf (null), in case of mem fault,
- * return 0.
- * may_fault is non-zero if we are reading from arbitrary memory, but is currently
- * not used.
- */
-static unsigned char *mem2hex(char *mem, char *buf, int count, int may_fault)
-{
-	unsigned char ch;
-
-	while (count-- > 0) {
-		if (kgdb_read_byte(mem++, &ch) != 0)
-			return 0;
-		*buf++ = hexchars[ch >> 4];
-		*buf++ = hexchars[ch & 0xf];
-	}
-
-	*buf = 0;
-
-	return buf;
-}
-
-/*
- * convert the hex array pointed to by buf into binary to be placed in mem
- * return a pointer to the character AFTER the last byte written
- * may_fault is non-zero if we are reading from arbitrary memory, but is currently
- * not used.
- */
-static char *hex2mem(char *buf, char *mem, int count, int binary, int may_fault)
-{
-	int i;
-	unsigned char ch;
-
-	for (i=0; i<count; i++)
-	{
-		if (binary) {
-			ch = *buf++;
-			if (ch == 0x7d)
-				ch = 0x20 ^ *buf++;
-		}
-		else {
-			ch = hex(*buf++) << 4;
-			ch |= hex(*buf++);
-		}
-		if (kgdb_write_byte(ch, mem++) != 0)
-			return 0;
-	}
-
-	return mem;
-}
-
-/*
- * This table contains the mapping between SPARC hardware trap types, and
- * signals, which are primarily what GDB understands.  It also indicates
- * which hardware traps we need to commandeer when initializing the stub.
- */
-static struct hard_trap_info {
-	unsigned char tt;		/* Trap type code for MIPS R3xxx and R4xxx */
-	unsigned char signo;		/* Signal that we map this trap into */
-} hard_trap_info[] = {
-	{ 6, SIGBUS },			/* instruction bus error */
-	{ 7, SIGBUS },			/* data bus error */
-	{ 9, SIGTRAP },			/* break */
-	{ 10, SIGILL },			/* reserved instruction */
-/*	{ 11, SIGILL },		*/	/* CPU unusable */
-	{ 12, SIGFPE },			/* overflow */
-	{ 13, SIGTRAP },		/* trap */
-	{ 14, SIGSEGV },		/* virtual instruction cache coherency */
-	{ 15, SIGFPE },			/* floating point exception */
-	{ 23, SIGSEGV },		/* watch */
-	{ 31, SIGSEGV },		/* virtual data cache coherency */
-	{ 0, 0}				/* Must be last */
-};
-
-/* Save the normal trap handlers for user-mode traps. */
-void *saved_vectors[32];
-
-/*
- * Set up exception handlers for tracing and breakpoints
- */
-void set_debug_traps(void)
-{
-	struct hard_trap_info *ht;
-	unsigned long flags;
-	unsigned char c;
-
-	local_irq_save(flags);
-	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
-		saved_vectors[ht->tt] = set_except_vector(ht->tt, trap_low);
-
-	putDebugChar('+'); /* 'hello world' */
-	/*
-	 * In case GDB is started before us, ack any packets
-	 * (presumably "$?#xx") sitting there.
-	 */
-	while((c = getDebugChar()) != '$');
-	while((c = getDebugChar()) != '#');
-	c = getDebugChar(); /* eat first csum byte */
-	c = getDebugChar(); /* eat second csum byte */
-	putDebugChar('+'); /* ack it */
-
-	initialized = 1;
-	local_irq_restore(flags);
-}
-
-void restore_debug_traps(void)
-{
-	struct hard_trap_info *ht;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
-		set_except_vector(ht->tt, saved_vectors[ht->tt]);
-	local_irq_restore(flags);
-}
-
-/*
- * Convert the MIPS hardware trap type code to a Unix signal number.
- */
-static int computeSignal(int tt)
-{
-	struct hard_trap_info *ht;
-
-	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
-		if (ht->tt == tt)
-			return ht->signo;
-
-	return SIGHUP;		/* default for things we don't know about */
-}
-
-/*
- * While we find nice hex chars, build an int.
- * Return number of chars processed.
- */
-static int hexToInt(char **ptr, int *intValue)
-{
-	int numChars = 0;
-	int hexValue;
-
-	*intValue = 0;
-
-	while (**ptr) {
-		hexValue = hex(**ptr);
-		if (hexValue < 0)
-			break;
-
-		*intValue = (*intValue << 4) | hexValue;
-		numChars ++;
-
-		(*ptr)++;
-	}
-
-	return (numChars);
-}
-
-static int hexToLong(char **ptr, long *longValue)
-{
-	int numChars = 0;
-	int hexValue;
-
-	*longValue = 0;
-
-	while (**ptr) {
-		hexValue = hex(**ptr);
-		if (hexValue < 0)
-			break;
-
-		*longValue = (*longValue << 4) | hexValue;
-		numChars ++;
-
-		(*ptr)++;
-	}
-
-	return numChars;
-}
-
-
-#if 0
-/*
- * Print registers (on target console)
- * Used only to debug the stub...
- */
-void show_gdbregs(struct gdb_regs * regs)
-{
-	/*
-	 * Saved main processor registers
-	 */
-	printk("$0 : %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       regs->reg0, regs->reg1, regs->reg2, regs->reg3,
-               regs->reg4, regs->reg5, regs->reg6, regs->reg7);
-	printk("$8 : %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       regs->reg8, regs->reg9, regs->reg10, regs->reg11,
-               regs->reg12, regs->reg13, regs->reg14, regs->reg15);
-	printk("$16: %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       regs->reg16, regs->reg17, regs->reg18, regs->reg19,
-               regs->reg20, regs->reg21, regs->reg22, regs->reg23);
-	printk("$24: %08lx %08lx %08lx %08lx %08lx %08lx %08lx %08lx\n",
-	       regs->reg24, regs->reg25, regs->reg26, regs->reg27,
-	       regs->reg28, regs->reg29, regs->reg30, regs->reg31);
-
-	/*
-	 * Saved cp0 registers
-	 */
-	printk("epc  : %08lx\nStatus: %08lx\nCause : %08lx\n",
-	       regs->cp0_epc, regs->cp0_status, regs->cp0_cause);
-}
-#endif /* dead code */
-
-/*
- * We single-step by setting breakpoints. When an exception
- * is handled, we need to restore the instructions hoisted
- * when the breakpoints were set.
- *
- * This is where we save the original instructions.
- */
-static struct gdb_bp_save {
-	unsigned long addr;
-	unsigned int val;
-} step_bp[2];
-
-#define BP 0x0000000d  /* break opcode */
-
-/*
- * Set breakpoint instructions for single stepping.
- */
-static void single_step(struct gdb_regs *regs)
-{
-	union mips_instruction insn;
-	unsigned long targ;
-	int is_branch, is_cond, i;
-
-	targ = regs->cp0_epc;
-	insn.word = *(unsigned int *)targ;
-	is_branch = is_cond = 0;
-
-	switch (insn.i_format.opcode) {
-	/*
-	 * jr and jalr are in r_format format.
-	 */
-	case spec_op:
-		switch (insn.r_format.func) {
-		case jalr_op:
-		case jr_op:
-			targ = *(&regs->reg0 + insn.r_format.rs);
-			is_branch = 1;
-			break;
-		}
-		break;
-
-	/*
-	 * This group contains:
-	 * bltz_op, bgez_op, bltzl_op, bgezl_op,
-	 * bltzal_op, bgezal_op, bltzall_op, bgezall_op.
-	 */
-	case bcond_op:
-		is_branch = is_cond = 1;
-		targ += 4 + (insn.i_format.simmediate << 2);
-		break;
-
-	/*
-	 * These are unconditional and in j_format.
-	 */
-	case jal_op:
-	case j_op:
-		is_branch = 1;
-		targ += 4;
-		targ >>= 28;
-		targ <<= 28;
-		targ |= (insn.j_format.target << 2);
-		break;
-
-	/*
-	 * These are conditional.
-	 */
-	case beq_op:
-	case beql_op:
-	case bne_op:
-	case bnel_op:
-	case blez_op:
-	case blezl_op:
-	case bgtz_op:
-	case bgtzl_op:
-	case cop0_op:
-	case cop1_op:
-	case cop2_op:
-	case cop1x_op:
-		is_branch = is_cond = 1;
-		targ += 4 + (insn.i_format.simmediate << 2);
-		break;
-	}
-
-	if (is_branch) {
-		i = 0;
-		if (is_cond && targ != (regs->cp0_epc + 8)) {
-			step_bp[i].addr = regs->cp0_epc + 8;
-			step_bp[i++].val = *(unsigned *)(regs->cp0_epc + 8);
-			*(unsigned *)(regs->cp0_epc + 8) = BP;
-		}
-		step_bp[i].addr = targ;
-		step_bp[i].val  = *(unsigned *)targ;
-		*(unsigned *)targ = BP;
-	} else {
-		step_bp[0].addr = regs->cp0_epc + 4;
-		step_bp[0].val  = *(unsigned *)(regs->cp0_epc + 4);
-		*(unsigned *)(regs->cp0_epc + 4) = BP;
-	}
-}
-
-/*
- *  If asynchronously interrupted by gdb, then we need to set a breakpoint
- *  at the interrupted instruction so that we wind up stopped with a
- *  reasonable stack frame.
- */
-static struct gdb_bp_save async_bp;
-
-/*
- * Swap the interrupted EPC with our asynchronous breakpoint routine.
- * This is safer than stuffing the breakpoint in-place, since no cache
- * flushes (or resulting smp_call_functions) are required.  The
- * assumption is that only one CPU will be handling asynchronous bp's,
- * and only one can be active at a time.
- */
-extern spinlock_t smp_call_lock;
-void set_async_breakpoint(unsigned long *epc)
-{
-	/* skip breaking into userland */
-	if ((*epc & 0x80000000) == 0)
-		return;
-
-	/* avoid deadlock if someone is make IPC */
-	if (spin_is_locked(&smp_call_lock))
-		return;
-
-	async_bp.addr = *epc;
-	*epc = (unsigned long)async_breakpoint;
-}
-
-void kgdb_wait(void *arg)
-{
-	unsigned flags;
-	int cpu = smp_processor_id();
-
-	local_irq_save(flags);
-
-	spin_lock(&kgdb_cpulock[cpu]);
-	spin_unlock(&kgdb_cpulock[cpu]);
-
-	local_irq_restore(flags);
-}
-
-
-/*
- * This function does all command processing for interfacing to gdb.  It
- * returns 1 if you should skip the instruction at the trap address, 0
- * otherwise.
- */
-void handle_exception (struct gdb_regs *regs)
-{
-	int trap;			/* Trap type */
-	int sigval;
-	long addr;
-	int length;
-	char *ptr;
-	unsigned long *stack;
-	int i;
-	int bflag = 0;
-
-	kgdb_started = 1;
-
-	/*
-	 * acquire the big kgdb spinlock
-	 */
-	if (!spin_trylock(&kgdb_lock)) {
-		/* 
-		 * some other CPU has the lock, we should go back to 
-		 * receive the gdb_wait IPC
-		 */
-		return;
-	}
-
-	/*
-	 * If we're in async_breakpoint(), restore the real EPC from
-	 * the breakpoint.
-	 */
-	if (regs->cp0_epc == (unsigned long)async_breakinst) {
-		regs->cp0_epc = async_bp.addr;
-		async_bp.addr = 0;
-	}
-
-	/* 
-	 * acquire the CPU spinlocks
-	 */
-	for (i = num_online_cpus()-1; i >= 0; i--)
-		if (spin_trylock(&kgdb_cpulock[i]) == 0)
-			panic("kgdb: couldn't get cpulock %d\n", i);
-
-	/*
-	 * force other cpus to enter kgdb
-	 */
-	smp_call_function(kgdb_wait, NULL, 0, 0);
-
-	/*
-	 * If we're in breakpoint() increment the PC
-	 */
-	trap = (regs->cp0_cause & 0x7c) >> 2;
-	if (trap == 9 && regs->cp0_epc == (unsigned long)breakinst)
-		regs->cp0_epc += 4;
-
-	/*
-	 * If we were single_stepping, restore the opcodes hoisted
-	 * for the breakpoint[s].
-	 */
-	if (step_bp[0].addr) {
-		*(unsigned *)step_bp[0].addr = step_bp[0].val;
-		step_bp[0].addr = 0;
-
-		if (step_bp[1].addr) {
-			*(unsigned *)step_bp[1].addr = step_bp[1].val;
-			step_bp[1].addr = 0;
-		}
-	}
-
-	stack = (long *)regs->reg29;			/* stack ptr */
-	sigval = computeSignal(trap);
-
-	/*
-	 * reply to host that an exception has occurred
-	 */
-	ptr = output_buffer;
-
-	/*
-	 * Send trap type (converted to signal)
-	 */
-	*ptr++ = 'T';
-	*ptr++ = hexchars[sigval >> 4];
-	*ptr++ = hexchars[sigval & 0xf];
-
-	/*
-	 * Send Error PC
-	 */
-	*ptr++ = hexchars[REG_EPC >> 4];
-	*ptr++ = hexchars[REG_EPC & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex((char *)&regs->cp0_epc, ptr, sizeof(long), 0);
-	*ptr++ = ';';
-
-	/*
-	 * Send frame pointer
-	 */
-	*ptr++ = hexchars[REG_FP >> 4];
-	*ptr++ = hexchars[REG_FP & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex((char *)&regs->reg30, ptr, sizeof(long), 0);
-	*ptr++ = ';';
-
-	/*
-	 * Send stack pointer
-	 */
-	*ptr++ = hexchars[REG_SP >> 4];
-	*ptr++ = hexchars[REG_SP & 0xf];
-	*ptr++ = ':';
-	ptr = mem2hex((char *)&regs->reg29, ptr, sizeof(long), 0);
-	*ptr++ = ';';
-
-	*ptr++ = 0;
-	putpacket(output_buffer);	/* send it off... */
-
-	/*
-	 * Wait for input from remote GDB
-	 */
-	while (1) {
-		output_buffer[0] = 0;
-		getpacket(input_buffer);
-
-		switch (input_buffer[0])
-		{
-		case '?':
-			output_buffer[0] = 'S';
-			output_buffer[1] = hexchars[sigval >> 4];
-			output_buffer[2] = hexchars[sigval & 0xf];
-			output_buffer[3] = 0;
-			break;
-
-		/*
-		 * Detach debugger; let CPU run
-		 */
-		case 'D':
-			putpacket(output_buffer);
-			goto finish_kgdb;
-			break;
-
-		case 'd':
-			/* toggle debug flag */
-			break;
-
-		/*
-		 * Return the value of the CPU registers
-		 */
-		case 'g':
-			ptr = output_buffer;
-			ptr = mem2hex((char *)&regs->reg0, ptr, 32*sizeof(long), 0); /* r0...r31 */
-			ptr = mem2hex((char *)&regs->cp0_status, ptr, 6*sizeof(long), 0); /* cp0 */
-			ptr = mem2hex((char *)&regs->fpr0, ptr, 32*sizeof(long), 0); /* f0...31 */
-			ptr = mem2hex((char *)&regs->cp1_fsr, ptr, 2*sizeof(long), 0); /* cp1 */
-			ptr = mem2hex((char *)&regs->frame_ptr, ptr, 2*sizeof(long), 0); /* frp */
-			ptr = mem2hex((char *)&regs->cp0_index, ptr, 16*sizeof(long), 0); /* cp0 */
-			break;
-
-		/*
-		 * set the value of the CPU registers - return OK
-		 */
-		case 'G':
-		{
-			ptr = &input_buffer[1];
-			hex2mem(ptr, (char *)&regs->reg0, 32*sizeof(long), 0, 0);
-			ptr += 32*(2*sizeof(long));
-			hex2mem(ptr, (char *)&regs->cp0_status, 6*sizeof(long), 0, 0);
-			ptr += 6*(2*sizeof(long));
-			hex2mem(ptr, (char *)&regs->fpr0, 32*sizeof(long), 0, 0);
-			ptr += 32*(2*sizeof(long));
-			hex2mem(ptr, (char *)&regs->cp1_fsr, 2*sizeof(long), 0, 0);
-			ptr += 2*(2*sizeof(long));
-			hex2mem(ptr, (char *)&regs->frame_ptr, 2*sizeof(long), 0, 0);
-			ptr += 2*(2*sizeof(long));
-			hex2mem(ptr, (char *)&regs->cp0_index, 16*sizeof(long), 0, 0);
-			strcpy(output_buffer,"OK");
-		 }
-		break;
-
-		/*
-		 * mAA..AA,LLLL  Read LLLL bytes at address AA..AA
-		 */
-		case 'm':
-			ptr = &input_buffer[1];
-
-			if (hexToLong(&ptr, &addr)
-				&& *ptr++ == ','
-				&& hexToInt(&ptr, &length)) {
-				if (mem2hex((char *)addr, output_buffer, length, 1))
-					break;
-				strcpy (output_buffer, "E03");
-			} else
-				strcpy(output_buffer,"E01");
-			break;
-
-		/*
-		 * XAA..AA,LLLL: Write LLLL escaped binary bytes at address AA.AA
-		 */
-		case 'X':
-			bflag = 1;
-			/* fall through */
-
-		/*
-		 * MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK
-		 */
-		case 'M':
-			ptr = &input_buffer[1];
-
-			if (hexToLong(&ptr, &addr)
-				&& *ptr++ == ','
-				&& hexToInt(&ptr, &length)
-				&& *ptr++ == ':') {
-				if (hex2mem(ptr, (char *)addr, length, bflag, 1))
-					strcpy(output_buffer, "OK");
-				else
-					strcpy(output_buffer, "E03");
-			}
-			else
-				strcpy(output_buffer, "E02");
-			break;
-
-		/*
-		 * cAA..AA    Continue at address AA..AA(optional)
-		 */
-		case 'c':
-			/* try to read optional parameter, pc unchanged if no parm */
-
-			ptr = &input_buffer[1];
-			if (hexToLong(&ptr, &addr))
-				regs->cp0_epc = addr;
-	  
-			goto exit_kgdb_exception;
-			break;
-
-		/*
-		 * kill the program; let us try to restart the machine
-		 * Reset the whole machine.
-		 */
-		case 'k':
-		case 'r':
-			machine_restart("kgdb restarts machine");
-			break;
-
-		/*
-		 * Step to next instruction
-		 */
-		case 's':
-			/*
-			 * There is no single step insn in the MIPS ISA, so we
-			 * use breakpoints and continue, instead.
-			 */
-			single_step(regs);
-			goto exit_kgdb_exception;
-			/* NOTREACHED */
-			break;
-
-		/*
-		 * Set baud rate (bBB)
-		 * FIXME: Needs to be written
-		 */
-		case 'b':
-		{
-#if 0
-			int baudrate;
-			extern void set_timer_3();
-
-			ptr = &input_buffer[1];
-			if (!hexToInt(&ptr, &baudrate))
-			{
-				strcpy(output_buffer,"B01");
-				break;
-			}
-
-			/* Convert baud rate to uart clock divider */
-
-			switch (baudrate)
-			{
-				case 38400:
-					baudrate = 16;
-					break;
-				case 19200:
-					baudrate = 33;
-					break;
-				case 9600:
-					baudrate = 65;
-					break;
-				default:
-					baudrate = 0;
-					strcpy(output_buffer,"B02");
-					goto x1;
-			}
-
-			if (baudrate) {
-				putpacket("OK");	/* Ack before changing speed */
-				set_timer_3(baudrate); /* Set it */
-			}
-#endif
-		}
-		break;
-
-		}			/* switch */
-
-		/*
-		 * reply to the request
-		 */
-
-		putpacket(output_buffer);
-
-	} /* while */
-
-	return;
-
-finish_kgdb:
-	restore_debug_traps();
-
-exit_kgdb_exception:
-	/* release locks so other CPUs can go */
-	for (i = num_online_cpus()-1; i >= 0; i--)
-		spin_unlock(&kgdb_cpulock[i]);
-	spin_unlock(&kgdb_lock);
-
-	__flush_cache_all();
-	return;
-}
-
-/*
- * This function will generate a breakpoint exception.  It is used at the
- * beginning of a program to sync up with a debugger and can be used
- * otherwise as a quick means to stop program execution and "break" into
- * the debugger.
- */
-void breakpoint(void)
-{
-	if (!initialized)
-		return;
-
-	__asm__ __volatile__(
-			".globl	breakinst\n\t" 
-			".set\tnoreorder\n\t"
-			"nop\n"
-			"breakinst:\tbreak\n\t"
-			"nop\n\t"
-			".set\treorder"
-			);
-}
-
-/* Nothing but the break; don't pollute any registers */
-void async_breakpoint(void)
-{
-	__asm__ __volatile__(
-			".globl	async_breakinst\n\t" 
-			".set\tnoreorder\n\t"
-			"nop\n"
-			"async_breakinst:\tbreak\n\t"
-			"nop\n\t"
-			".set\treorder"
-			);
-}
-
-void adel(void)
-{
-	__asm__ __volatile__(
-			".globl\tadel\n\t"
-			"lui\t$8,0x8000\n\t"
-			"lw\t$9,1($8)\n\t"
-			);
-}
-
-/*
- * malloc is needed by gdb client in "call func()", even a private one
- * will make gdb happy
- */
-static void *malloc(size_t size)
-{
-	return kmalloc(size, GFP_ATOMIC);
-}
-
-static void free(void *where)
-{
-	kfree(where);
-}
-
-#ifdef CONFIG_GDB_CONSOLE
-
-void gdb_putsn(const char *str, int l)
-{
-	char outbuf[18];
-
-	if (!kgdb_started)
-		return;
-
-	outbuf[0]='O';
-
-	while(l) {
-		int i = (l>8)?8:l;
-		mem2hex((char *)str, &outbuf[1], i, 0);
-		outbuf[(i*2)+1]=0;
-		putpacket(outbuf);
-		str += i;
-		l -= i;
-	}
-}
-
-static void gdb_console_write(struct console *con, const char *s, unsigned n)
-{
-	gdb_putsn(s, n);
-}
-
-static struct console gdb_console = {
-	.name	= "gdb",
-	.write	= gdb_console_write,
-	.flags	= CON_PRINTBUFFER,
-	.index	= -1
-};
-
-static int __init register_gdb_console(void)
-{
-	register_console(&gdb_console);
-
-	return 0;
-}
-
-console_initcall(register_gdb_console);
-
-#endif
diff -puN arch/mips/kernel/irq.c~mips-lite arch/mips/kernel/irq.c
--- linux-2.6.13/arch/mips/kernel/irq.c~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/irq.c	2005-08-16 17:32:26.000000000 -0700
@@ -26,6 +26,10 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/kgdb.h>
+
+/* Keep track of if we've done certain initialization already or not. */
+int kgdb_early_setup;
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
@@ -103,23 +107,13 @@ skip:
 	return 0;
 }
 
-#ifdef CONFIG_KGDB
-extern void breakpoint(void);
-extern void set_debug_traps(void);
-
-static int kgdb_flag = 1;
-static int __init nokgdb(char *str)
-{
-	kgdb_flag = 0;
-	return 1;
-}
-__setup("nokgdb", nokgdb);
-#endif
-
 void __init init_IRQ(void)
 {
 	int i;
 
+	if (kgdb_early_setup)
+		return;
+
 	for (i = 0; i < NR_IRQS; i++) {
 		irq_desc[i].status  = IRQ_DISABLED;
 		irq_desc[i].action  = NULL;
@@ -129,12 +123,12 @@ void __init init_IRQ(void)
 	}
 
 	arch_init_irq();
-
 #ifdef CONFIG_KGDB
-	if (kgdb_flag) {
-		printk("Wait for gdb client connection ...\n");
-		set_debug_traps();
-		breakpoint();
-	}
+	/*
+	 * We have been called before kgdb_arch_init(). Hence,
+	 * we dont want the traps to be reinitialized
+	 */
+	if (kgdb_early_setup == 0)
+		kgdb_early_setup = 1;
 #endif
 }
diff -puN /dev/null arch/mips/kernel/kgdb.c
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/kgdb.c	2005-08-16 17:32:46.000000000 -0700
@@ -0,0 +1,296 @@
+/*
+ * arch/mips/kernel/kgdb.c
+ *
+ *  Originally written by Glenn Engel, Lake Stevens Instrument Division
+ *
+ *  Contributed by HP Systems
+ *
+ *  Modified for SPARC by Stu Grossman, Cygnus Support.
+ *
+ *  Modified for Linux/MIPS (and MIPS in general) by Andreas Busse
+ *  Send complaints, suggestions etc. to <andy@waldorf-gmbh.de>
+ *
+ *  Copyright (C) 1995 Andreas Busse
+ *
+ *  Copyright (C) 2003 MontaVista Software Inc.
+ *  Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ *
+ *  Copyright (C) 2004-2005 MontaVista Software Inc.
+ *  Author: Manish Lachwani, mlachwani@mvista.com or manish@koffee-break.com
+ *
+ *  This file is licensed under the terms of the GNU General Public License
+ *  version 2. This program is licensed "as is" without any warranty of any
+ *  kind, whether express or implied.
+ */
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>		/* for linux pt_regs struct */
+#include <linux/kgdb.h>
+#include <linux/init.h>
+#include <asm/inst.h>
+#include <asm/gdb-stub.h>
+#include <asm/cacheflush.h>
+#include <asm/kdebug.h>
+
+static struct hard_trap_info {
+	unsigned char tt;	/* Trap type code for MIPS R3xxx and R4xxx */
+	unsigned char signo;	/* Signal that we map this trap into */
+} hard_trap_info[] = {
+	{ 6, SIGBUS },		/* instruction bus error */
+	{ 7, SIGBUS },		/* data bus error */
+	{ 9, SIGTRAP },		/* break */
+/*	{ 11, SIGILL },	*/	/* CPU unusable */
+	{ 12, SIGFPE },		/* overflow */
+	{ 13, SIGTRAP },	/* trap */
+	{ 14, SIGSEGV },	/* virtual instruction cache coherency */
+	{ 15, SIGFPE },		/* floating point exception */
+	{ 23, SIGSEGV },	/* watch */
+	{ 31, SIGSEGV },	/* virtual data cache coherency */
+	{ 0, 0}			/* Must be last */
+};
+
+/* Save the normal trap handlers for user-mode traps. */
+void *saved_vectors[32];
+
+extern void trap_low(void);
+extern void breakinst(void);
+extern void init_IRQ(void);
+
+void kgdb_call_nmi_hook(void *ignored)
+{
+	kgdb_nmihook(smp_processor_id(), (void *)0);
+}
+
+void kgdb_roundup_cpus(unsigned long flags)
+{
+	local_irq_restore(flags);
+	smp_call_function(kgdb_call_nmi_hook, 0, 0, 0);
+	local_irq_save(flags);
+}
+
+static int compute_signal(int tt)
+{
+	struct hard_trap_info *ht;
+
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		if (ht->tt == tt)
+			return ht->signo;
+
+	return SIGHUP;		/* default for things we don't know about */
+}
+
+/*
+ * Set up exception handlers for tracing and breakpoints
+ */
+void handle_exception(struct pt_regs *regs)
+{
+	int trap = (regs->cp0_cause & 0x7c) >> 2;
+
+	if (fixup_exception(regs)) {
+		return;
+	}
+
+	if (atomic_read(&debugger_active))
+		kgdb_nmihook(smp_processor_id(), regs);
+
+	if (atomic_read(&kgdb_setting_breakpoint))
+		if ((trap == 9) && (regs->cp0_epc == (unsigned long)breakinst))
+			regs->cp0_epc += 4;
+
+	kgdb_handle_exception(0, compute_signal(trap), 0, regs);
+
+	/* In SMP mode, __flush_cache_all does IPI */
+	__flush_cache_all();
+}
+
+void set_debug_traps(void)
+{
+	struct hard_trap_info *ht;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		saved_vectors[ht->tt] = set_except_vector(ht->tt, trap_low);
+
+	local_irq_restore(flags);
+}
+
+#if 0
+/* This should be called before we exit kgdb_handle_exception() I believe.
+ * -- Tom
+ */
+void restore_debug_traps(void)
+{
+	struct hard_trap_info *ht;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
+		set_except_vector(ht->tt, saved_vectors[ht->tt]);
+	local_irq_restore(flags);
+}
+#endif
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg = 0;
+	unsigned long *ptr = gdb_regs;
+
+	for (reg = 0; reg < 32; reg++)
+		*(ptr++) = regs->regs[reg];
+
+	*(ptr++) = regs->cp0_status;
+	*(ptr++) = regs->lo;
+	*(ptr++) = regs->hi;
+	*(ptr++) = regs->cp0_badvaddr;
+	*(ptr++) = regs->cp0_cause;
+	*(ptr++) = regs->cp0_epc;
+
+	return;
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+	int reg = 0;
+	unsigned long *ptr = gdb_regs;
+
+	for (reg = 0; reg < 32; reg++)
+		regs->regs[reg] = *(ptr++);
+
+	regs->cp0_status = *(ptr++);
+	regs->lo = *(ptr++);
+	regs->hi = *(ptr++);
+	regs->cp0_badvaddr = *(ptr++);
+	regs->cp0_cause = *(ptr++);
+	regs->cp0_epc = *(ptr++);
+
+	return;
+}
+
+/*
+ * Similar to regs_to_gdb_regs() except that process is sleeping and so
+ * we may not be able to get all the info.
+ */
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+	int reg = 0;
+	struct thread_info *ti = p->thread_info;
+	unsigned long ksp = (unsigned long)ti + THREAD_SIZE - 32;
+	struct pt_regs *regs = (struct pt_regs *)ksp - 1;
+	unsigned long *ptr = gdb_regs;
+
+	for (reg = 0; reg < 16; reg++)
+		*(ptr++) = regs->regs[reg];
+
+	/* S0 - S7 */
+	for (reg = 16; reg < 24; reg++)
+		*(ptr++) = regs->regs[reg];
+
+	for (reg = 24; reg < 28; reg++)
+		*(ptr++) = 0;
+
+	/* GP, SP, FP, RA */
+	for (reg = 28; reg < 32; reg++)
+		*(ptr++) = regs->regs[reg];
+
+	*(ptr++) = regs->cp0_status;
+	*(ptr++) = regs->lo;
+	*(ptr++) = regs->hi;
+	*(ptr++) = regs->cp0_badvaddr;
+	*(ptr++) = regs->cp0_cause;
+	*(ptr++) = regs->cp0_epc;
+
+	return;
+}
+
+/*
+ * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
+ * then try to fall into the debugger
+ */
+static int kgdb_mips_notify(struct notifier_block *self, unsigned long cmd,
+			    void *ptr)
+{
+	struct die_args *args = (struct die_args *)ptr;
+	struct pt_regs *regs = args->regs;
+	int trap = (regs->cp0_cause & 0x7c) >> 2;
+
+	/* See if KGDB is interested. */
+	if (user_mode(regs))
+		/* Userpace events, ignore. */
+		return NOTIFY_DONE;
+
+	kgdb_handle_exception(trap, compute_signal(trap), 0, regs);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kgdb_notifier = {
+	.notifier_call = kgdb_mips_notify,
+};
+
+/*
+ * Handle the 's' and 'c' commands
+ */
+int kgdb_arch_handle_exception(int vector, int signo, int err_code,
+			       char *remcom_in_buffer, char *remcom_out_buffer,
+			       struct pt_regs *regs)
+{
+	char *ptr;
+	unsigned long address;
+	int cpu = smp_processor_id();
+
+	switch (remcom_in_buffer[0]) {
+	case 's':
+	case 'c':
+		/* handle the optional parameter */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &address))
+			regs->cp0_epc = address;
+
+		atomic_set(&cpu_doing_single_step, -1);
+		if (remcom_in_buffer[0] == 's')
+			if (kgdb_contthread)
+				atomic_set(&cpu_doing_single_step, cpu);
+
+		return 0;
+	}
+
+	return -1;
+}
+
+struct kgdb_arch arch_kgdb_ops = {
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	.gdb_bpt_instr = {0xd},
+#else
+	.gdb_bpt_instr = {0x00, 0x00, 0x00, 0x0d},
+#endif
+};
+
+/*
+ * We use kgdb_early_setup so that functions we need to call now don't
+ * cause trouble when called again later.
+ */
+int kgdb_arch_init(void)
+{
+	/* Board-specifics. */
+	/* Force some calls to happen earlier. */
+	if (kgdb_early_setup == 0) {
+		trap_init();
+		init_IRQ();
+		kgdb_early_setup = 1;
+	}
+
+	/* Set our traps. */
+	/* This needs to be done more finely grained again, paired in
+	 * a before/after in kgdb_handle_exception(...) -- Tom */
+	set_debug_traps();
+	notifier_chain_register(&mips_die_chain, &kgdb_notifier);
+
+	return 0;
+}
diff -puN /dev/null arch/mips/kernel/kgdb_handler.S
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/kgdb_handler.S	2005-08-16 17:32:26.000000000 -0700
@@ -0,0 +1,58 @@
+/*
+ * arch/mips/kernel/kgdb_handler.S
+ *
+ * Copyright (C) 2004 MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com or manish@koffee-break.com
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/*
+ * Trap Handler for the new KGDB framework. The main KGDB handler is
+ * handle_exception that will be called from here
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/sys.h>
+
+#include <asm/asm.h>
+#include <asm/errno.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+	.align  5
+	NESTED(trap_low, PT_SIZE, sp)
+		.set    noat
+		.set	noreorder
+		SAVE_ALL
+		/*
+		 * Check for privileged instructions in user mode. For
+		 * this, check the cu0 bit in the CPU status register.
+		 */
+		mfc0	k0, CP0_STATUS
+		sll	k0, 3
+		bltz	k0, 1f
+		move	k1, sp
+
+		/*
+		 * GDB userland from within KGDB. If a user mode address
+		 * then jump to the saved exception handler
+		 */
+		lui	k1, %hi(saved_vectors)
+		mfc0	k0, CP0_CAUSE
+		andi	k0, k0, 0x7c
+		add	k1, k1, k0
+		lw	k0, %lo(saved_vectors)(k1)
+		jr	k0
+		nop
+1:
+		.set    at
+		.set	reorder
+		move    a0, sp
+		jal     handle_exception
+		j       ret_from_exception
+	END(trap_low)
diff -puN /dev/null arch/mips/kernel/kgdb-jmp.c
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/kgdb-jmp.c	2005-08-16 17:32:26.000000000 -0700
@@ -0,0 +1,116 @@
+/*
+ * arch/mips/kernel/kgdb-jmp.c
+ *
+ * Save and restore system registers so that within a limited frame we
+ * may have a fault and "jump back" to a known safe location.
+ *
+ * Author: Tom Rini <trini@kernel.crashing.org>
+ * Author: Manish Lachwani <mlachwani@mvista.com>
+ *
+ * Cribbed from glibc, which carries the following:
+ * Copyright (C) 1996, 1997, 2000, 2002, 2003 Free Software Foundation, Inc.
+ * Copyright (C) 2005 by MontaVista Software.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program as licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#include <linux/kgdb.h>
+#include <asm/interrupt.h>
+
+#ifdef CONFIG_MIPS64
+/*
+ * MIPS 64-bit
+ */
+
+int kgdb_fault_setjmp_aux(unsigned long *curr_context, int sp, int fp)
+{
+	__asm__ __volatile__ ("sd $gp, %0" : : "m" (curr_context[0]));
+	__asm__ __volatile__ ("sd $16, %0" : : "m" (curr_context[1]));
+	__asm__ __volatile__ ("sd $17, %0" : : "m" (curr_context[2]));
+	__asm__ __volatile__ ("sd $18, %0" : : "m" (curr_context[3]));
+	__asm__ __volatile__ ("sd $19, %0" : : "m" (curr_context[4]));
+	__asm__ __volatile__ ("sd $20, %0" : : "m" (curr_context[5]));
+	__asm__ __volatile__ ("sd $21, %0" : : "m" (curr_context[6]));
+	__asm__ __volatile__ ("sd $22, %0" : : "m" (curr_context[7]));
+	__asm__ __volatile__ ("sd $23, %0" : : "m" (curr_context[8]));
+	__asm__ __volatile__ ("sd $31, %0" : : "m" (curr_context[9]));
+	curr_context[10] = (long *)sp;
+	curr_context[11] = (long *)fp;
+
+	return 0;
+}
+
+void kgdb_fault_longjmp(unsigned long *curr_context)
+{
+	unsigned long sp_val, fp_val;
+
+	__asm__ __volatile__ ("ld $gp, %0" : : "m" (curr_context[0]));
+	__asm__ __volatile__ ("ld $16, %0" : : "m" (curr_context[1]));
+	__asm__ __volatile__ ("ld $17, %0" : : "m" (curr_context[2]));
+	__asm__ __volatile__ ("ld $18, %0" : : "m" (curr_context[3]));
+	__asm__ __volatile__ ("ld $19, %0" : : "m" (curr_context[4]));
+	__asm__ __volatile__ ("ld $20, %0" : : "m" (curr_context[5]));
+	__asm__ __volatile__ ("ld $21, %0" : : "m" (curr_context[6]));
+	__asm__ __volatile__ ("ld $22, %0" : : "m" (curr_context[7]));
+	__asm__ __volatile__ ("ld $23, %0" : : "m" (curr_context[8]));
+	__asm__ __volatile__ ("ld $25, %0" : : "m" (curr_context[9]));
+	sp_val = curr_context[10];
+	fp_val = curr_context[11];
+	__asm__ __volatile__ ("ld $29, %0\n\t"
+			      "ld $30, %1\n\t" : : "m" (sp_val), "m" (fp_val));
+
+	__asm__ __volatile__ ("dli $2, 1");
+	__asm__ __volatile__ ("j $25");
+
+	for (;;);
+}
+#else
+/*
+ * MIPS 32-bit
+ */
+
+int kgdb_fault_setjmp_aux(unsigned long *curr_context, int sp, int fp)
+{
+	__asm__ __volatile__("sw $gp, %0" : : "m" (curr_context[0]));
+	__asm__ __volatile__("sw $16, %0" : : "m" (curr_context[1]));
+	__asm__ __volatile__("sw $17, %0" : : "m" (curr_context[2]));
+	__asm__ __volatile__("sw $18, %0" : : "m" (curr_context[3]));
+	__asm__ __volatile__("sw $19, %0" : : "m" (curr_context[4]));
+	__asm__ __volatile__("sw $20, %0" : : "m" (curr_context[5]));
+	__asm__ __volatile__("sw $21, %0" : : "m" (curr_context[6]));
+	__asm__ __volatile__("sw $22, %0" : : "m" (curr_context[7]));
+	__asm__ __volatile__("sw $23, %0" : : "m" (curr_context[8]));
+	__asm__ __volatile__("sw $31, %0" : : "m" (curr_context[9]));
+	curr_context[10] = (long *)sp;
+	curr_context[11] = (long *)fp;
+
+	return 0;
+}
+
+void kgdb_fault_longjmp(unsigned long *curr_context)
+{
+	unsigned long sp_val, fp_val;
+
+	__asm__ __volatile__("lw $gp, %0" : : "m" (curr_context[0]));
+	__asm__ __volatile__("lw $16, %0" : : "m" (curr_context[1]));
+	__asm__ __volatile__("lw $17, %0" : : "m" (curr_context[2]));
+	__asm__ __volatile__("lw $18, %0" : : "m" (curr_context[3]));
+	__asm__ __volatile__("lw $19, %0" : : "m" (curr_context[4]));
+	__asm__ __volatile__("lw $20, %0" : : "m" (curr_context[5]));
+	__asm__ __volatile__("lw $21, %0" : : "m" (curr_context[6]));
+	__asm__ __volatile__("lw $22, %0" : : "m" (curr_context[7]));
+	__asm__ __volatile__("lw $23, %0" : : "m" (curr_context[8]));
+	__asm__ __volatile__("lw $25, %0" : : "m" (curr_context[9]));
+	sp_val = curr_context[10];
+	fp_val = curr_context[11];
+	__asm__ __volatile__("lw $29, %0\n\t"
+			      "lw $30, %1\n\t" : : "m" (sp_val), "m" (fp_val));
+
+	__asm__ __volatile__("li $2, 1");
+	__asm__ __volatile__("jr $25");
+
+	for (;;);
+}
+#endif
diff -puN /dev/null arch/mips/kernel/kgdb-setjmp.S
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/kgdb-setjmp.S	2005-08-16 17:32:26.000000000 -0700
@@ -0,0 +1,27 @@
+/*
+ * arch/mips/kernel/kgdb-jmp.c
+ *
+ * Save and restore system registers so that within a limited frame we
+ * may have a fault and "jump back" to a known safe location.
+ *
+ * Copyright (C) 2005 by MontaVista Software.
+ * Author: Manish Lachwani (mlachwani@mvista.com)
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program as licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+
+ENTRY (kgdb_fault_setjmp)
+	move    a1, sp
+	move	a2, fp
+#ifdef CONFIG_MIPS64
+	nop
+#endif
+	j	kgdb_fault_setjmp_aux
+	.end	kgdb_fault_setjmp
diff -puN arch/mips/kernel/Makefile~mips-lite arch/mips/kernel/Makefile
--- linux-2.6.13/arch/mips/kernel/Makefile~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/Makefile	2005-08-16 17:32:26.000000000 -0700
@@ -52,7 +52,8 @@ obj-$(CONFIG_MIPS32_COMPAT)	+= ioctl32.o
 obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o ptrace32.o
 
-obj-$(CONFIG_KGDB)		+= gdb-low.o gdb-stub.o
+obj-$(CONFIG_KGDB)		+= kgdb_handler.o kgdb.o kgdb-jmp.o	\
+					kgdb-setjmp.o
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_MIPS64)		+= cpu-bugs64.o
diff -puN arch/mips/kernel/traps.c~mips-lite arch/mips/kernel/traps.c
--- linux-2.6.13/arch/mips/kernel/traps.c~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/kernel/traps.c	2005-08-16 17:32:26.000000000 -0700
@@ -10,6 +10,8 @@
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
  * Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
+ *
+ * KGDB specific changes - Manish Lachwani (mlachwani@mvista.com)
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -20,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
+#include <linux/kgdb.h>
 
 #include <asm/bootinfo.h>
 #include <asm/branch.h>
@@ -37,6 +40,7 @@
 #include <asm/mmu_context.h>
 #include <asm/watch.h>
 #include <asm/types.h>
+#include <asm/kdebug.h>
 
 extern asmlinkage void handle_tlbm(void);
 extern asmlinkage void handle_tlbl(void);
@@ -69,6 +73,21 @@ int (*board_be_handler)(struct pt_regs *
  */
 #define MODULE_RANGE (8*1024*1024)
 
+struct notifier_block *mips_die_chain;
+static spinlock_t die_notifier_lock = SPIN_LOCK_UNLOCKED;
+
+int register_die_notifier(struct notifier_block *nb)
+{
+	int err = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&die_notifier_lock, flags);
+	err = notifier_chain_register(&mips_die_chain, nb);
+	spin_unlock_irqrestore(&die_notifier_lock, flags);
+
+	return err;
+}
+
 /*
  * This routine abuses get_user()/put_user() to reference pointers
  * with at least a bit of error checking ...
@@ -271,8 +290,10 @@ NORET_TYPE void __die(const char * str, 
 void __die_if_kernel(const char * str, struct pt_regs * regs,
 		     const char * file, const char * func, unsigned long line)
 {
-	if (!user_mode(regs))
+	if (!user_mode(regs)) {
+		notify_die(DIE_TRAP, (char *)str, regs, 0);
 		__die(str, regs, file, func, line);
+	}
 }
 
 extern const struct exception_table_entry __start___dbe_table[];
@@ -958,6 +979,9 @@ void __init trap_init(void)
 	extern char except_vec4;
 	unsigned long i;
 
+	if (kgdb_early_setup)
+		return;	/* Already done */
+
 	per_cpu_trap_init();
 
 	/*
diff -puN arch/mips/mips-boards/generic/init.c~mips-lite arch/mips/mips-boards/generic/init.c
--- linux-2.6.13/arch/mips/mips-boards/generic/init.c~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/mips-boards/generic/init.c	2005-08-16 17:32:26.000000000 -0700
@@ -35,15 +35,6 @@
 #include <asm/mips-boards/malta.h>
 #endif
 
-#ifdef CONFIG_KGDB
-extern int rs_kgdb_hook(int, int);
-extern int rs_putDebugChar(char);
-extern char rs_getDebugChar(void);
-extern int saa9730_kgdb_hook(int);
-extern int saa9730_putDebugChar(char);
-extern char saa9730_getDebugChar(void);
-#endif
-
 int prom_argc;
 int *_prom_argv, *_prom_envp;
 
@@ -170,59 +161,6 @@ static void __init console_config(void)
 }
 #endif
 
-#ifdef CONFIG_KGDB
-void __init kgdb_config (void)
-{
-	extern int (*generic_putDebugChar)(char);
-	extern char (*generic_getDebugChar)(void);
-	char *argptr;
-	int line, speed;
-
-	argptr = prom_getcmdline();
-	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
-		argptr += strlen("kgdb=ttyS");
-		if (*argptr != '0' && *argptr != '1')
-			printk("KGDB: Unknown serial line /dev/ttyS%c, "
-			       "falling back to /dev/ttyS1\n", *argptr);
-		line = *argptr == '0' ? 0 : 1;
-		printk("KGDB: Using serial line /dev/ttyS%d for session\n", line);
-
-		speed = 0;
-		if (*++argptr == ',')
-		{
-			int c;
-			while ((c = *++argptr) && ('0' <= c && c <= '9'))
-				speed = speed * 10 + c - '0';
-		}
-#ifdef CONFIG_MIPS_ATLAS
-		if (line == 1) {
-			speed = saa9730_kgdb_hook(speed);
-			generic_putDebugChar = saa9730_putDebugChar;
-			generic_getDebugChar = saa9730_getDebugChar;
-		}
-		else 
-#endif
-		{
-			speed = rs_kgdb_hook(line, speed);
-			generic_putDebugChar = rs_putDebugChar;
-			generic_getDebugChar = rs_getDebugChar;
-		}
-
-		prom_printf("KGDB: Using serial line /dev/ttyS%d at %d for session, "
-			    "please connect your debugger\n", line ? 1 : 0, speed);
-
-		{
-			char *s;
-			for (s = "Please connect GDB to this port\r\n"; *s; )
-				generic_putDebugChar (*s++);
-		}
-
-		kgdb_enabled = 1;
-		/* Breakpoint is invoked after interrupts are initialised */
-	}
-}
-#endif
-
 void __init prom_init(void)
 {
 	prom_argc = fw_arg0;
diff -puN arch/mips/mips-boards/generic/Makefile~mips-lite arch/mips/mips-boards/generic/Makefile
--- linux-2.6.13/arch/mips/mips-boards/generic/Makefile~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/mips-boards/generic/Makefile	2005-08-16 17:32:26.000000000 -0700
@@ -21,6 +21,5 @@
 obj-y				:= mipsIRQ.o reset.o display.o init.o memory.o \
 				   printf.o cmdline.o time.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_KGDB)		+= gdb_hook.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -puN arch/mips/mips-boards/malta/malta_setup.c~mips-lite arch/mips/mips-boards/malta/malta_setup.c
--- linux-2.6.13/arch/mips/mips-boards/malta/malta_setup.c~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/mips-boards/malta/malta_setup.c	2005-08-16 17:32:26.000000000 -0700
@@ -48,10 +48,6 @@ extern void mips_time_init(void);
 extern void mips_timer_setup(struct irqaction *irq);
 extern unsigned long mips_rtc_get_time(void);
 
-#ifdef CONFIG_KGDB
-extern void kgdb_config(void);
-#endif
-
 struct resource standard_io_resources[] = {
 	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
 	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
@@ -124,10 +120,6 @@ static int __init malta_setup(void)
 	 */
 	enable_dma(4);
 
-#ifdef CONFIG_KGDB
-	kgdb_config ();
-#endif
-
 	if ((mips_revision_corid == MIPS_REVISION_CORID_BONITO64) ||
 	    (mips_revision_corid == MIPS_REVISION_CORID_CORE_20K) ||
 	    (mips_revision_corid == MIPS_REVISION_CORID_CORE_EMUL_BON)) {
diff -puN arch/mips/mm/extable.c~mips-lite arch/mips/mm/extable.c
--- linux-2.6.13/arch/mips/mm/extable.c~mips-lite	2005-08-16 17:32:25.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/mm/extable.c	2005-08-16 17:32:26.000000000 -0700
@@ -3,6 +3,7 @@
  */
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/kgdb.h>
 #include <asm/branch.h>
 #include <asm/uaccess.h>
 
@@ -16,6 +17,12 @@ int fixup_exception(struct pt_regs *regs
 
 		return 1;
 	}
+#ifdef CONFIG_KGDB
+	if (atomic_read(&debugger_active) && kgdb_may_fault)
+		/* Restore our previous state. */
+		kgdb_fault_longjmp(kgdb_fault_jmp_regs);
+		/* Not reached. */
+#endif
 
 	return 0;
 }
diff -puN arch/mips/sibyte/cfe/setup.c~mips-lite arch/mips/sibyte/cfe/setup.c
--- linux-2.6.13/arch/mips/sibyte/cfe/setup.c~mips-lite	2005-08-16 17:32:26.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/sibyte/cfe/setup.c	2005-08-16 17:32:26.000000000 -0700
@@ -58,10 +58,6 @@ int cfe_cons_handle;
 extern unsigned long initrd_start, initrd_end;
 #endif
 
-#ifdef CONFIG_KGDB
-extern int kgdb_port;
-#endif
-
 static void ATTRIB_NORET cfe_linux_exit(void *arg)
 {
 	int warm = *(int *)arg;
@@ -242,9 +238,6 @@ void __init prom_init(void)
 	int argc = fw_arg0;
 	char **envp = (char **) fw_arg2;
 	int *prom_vec = (int *) fw_arg3;
-#ifdef CONFIG_KGDB
-	char *arg;
-#endif
 
 	_machine_restart   = cfe_linux_restart;
 	_machine_halt      = cfe_linux_halt;
@@ -308,13 +301,6 @@ void __init prom_init(void)
 		}
 	}
 
-#ifdef CONFIG_KGDB
-	if ((arg = strstr(arcs_cmdline,"kgdb=duart")) != NULL)
-		kgdb_port = (arg[10] == '0') ? 0 : 1;
-	else
-		kgdb_port = 1;
-#endif
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	{
 		char *ptr;
diff -puN arch/mips/sibyte/sb1250/irq.c~mips-lite arch/mips/sibyte/sb1250/irq.c
--- linux-2.6.13/arch/mips/sibyte/sb1250/irq.c~mips-lite	2005-08-16 17:32:26.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/sibyte/sb1250/irq.c	2005-08-16 17:32:26.000000000 -0700
@@ -31,6 +31,7 @@
 #include <asm/system.h>
 #include <asm/ptrace.h>
 #include <asm/io.h>
+#include <asm/kgdb.h>
 
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_int.h>
@@ -60,16 +61,6 @@ static void sb1250_set_affinity(unsigned
 extern unsigned long ldt_eoi_space;
 #endif
 
-#ifdef CONFIG_KGDB
-static int kgdb_irq;
-
-/* Default to UART1 */
-int kgdb_port = 1;
-#ifdef CONFIG_SIBYTE_SB1250_DUART
-extern char sb1250_duart_present[];
-#endif
-#endif
-
 static struct hw_interrupt_type sb1250_irq_type = {
 	"SB1250-IMR",
 	startup_sb1250_irq,
@@ -338,6 +329,11 @@ void __init arch_init_irq(void)
 	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
 		STATUSF_IP1 | STATUSF_IP0;
 
+#ifdef CONFIG_KGDB
+	if (kgdb_early_setup)
+		return;
+#endif
+
 	/* Default everything to IP2 */
 	for (i = 0; i < SB1250_NR_IRQS; i++) {	/* was I0 */
 		bus_writeq(IMR_IP2_VAL,
@@ -387,45 +383,4 @@ void __init arch_init_irq(void)
 	/* Enable necessary IPs, disable the rest */
 	change_c0_status(ST0_IM, imask);
 	set_except_vector(0, sb1250_irq_handler);
-
-#ifdef CONFIG_KGDB
-	if (kgdb_flag) {
-		kgdb_irq = K_INT_UART_0 + kgdb_port;
-
-#ifdef CONFIG_SIBYTE_SB1250_DUART	
-		sb1250_duart_present[kgdb_port] = 0;
-#endif
-		/* Setup uart 1 settings, mapper */
-		bus_writeq(M_DUART_IMR_BRK, IOADDR(A_DUART_IMRREG(kgdb_port)));
-
-		sb1250_steal_irq(kgdb_irq);
-		bus_writeq(IMR_IP6_VAL,
-			   IOADDR(A_IMR_REGISTER(0, R_IMR_INTERRUPT_MAP_BASE) +
-				  (kgdb_irq<<3)));
-		sb1250_unmask_irq(0, kgdb_irq);
-	}
-#endif
 }
-
-#ifdef CONFIG_KGDB
-
-#include <linux/delay.h>
-
-#define duart_out(reg, val)     csr_out32(val, IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
-#define duart_in(reg)           csr_in32(IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
-
-void sb1250_kgdb_interrupt(struct pt_regs *regs)
-{
-	/*
-	 * Clear break-change status (allow some time for the remote
-	 * host to stop the break, since we would see another
-	 * interrupt on the end-of-break too)
-	 */
-	kstat_this_cpu.irqs[kgdb_irq]++;
-	mdelay(500);
-	duart_out(R_DUART_CMD, V_DUART_MISC_CMD_RESET_BREAK_INT |
-				M_DUART_RX_EN | M_DUART_TX_EN);
-	set_async_breakpoint(&regs->cp0_epc);
-}
-
-#endif 	/* CONFIG_KGDB */
diff -puN arch/mips/sibyte/sb1250/irq_handler.S~mips-lite arch/mips/sibyte/sb1250/irq_handler.S
--- linux-2.6.13/arch/mips/sibyte/sb1250/irq_handler.S~mips-lite	2005-08-16 17:32:26.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/sibyte/sb1250/irq_handler.S	2005-08-16 17:32:26.000000000 -0700
@@ -102,7 +102,7 @@
 2:
 #endif
 
-#ifdef CONFIG_KGDB
+#ifdef CONFIG_KGDB_SIBYTE
 	/* KGDB (uart 1) interrupt is routed to IP[6] */
 	andi	t1, s0, CAUSEF_IP6
 	beqz	t1, 1f
diff -puN /dev/null arch/mips/sibyte/sb1250/kgdb_sibyte.c
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/arch/mips/sibyte/sb1250/kgdb_sibyte.c	2005-08-16 17:32:26.000000000 -0700
@@ -0,0 +1,164 @@
+/*
+ * arch/mips/sibyte/sb1250/kgdb_sibyte.c
+ *
+ * Author: Manish Lachwani, mlachwani@mvista.com or manish@koffee-break.com
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+/*
+ * Support for KGDB on the Broadcom Sibyte. The SWARM board
+ * for example does not have a 8250/16550 compatible serial
+ * port. Hence, we need to have a driver for the serial
+ * ports to handle KGDB.  This board needs nothing in addition
+ * to what is normally provided by the gdb portion of the stub.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel_stat.h>
+#include <linux/init.h>
+#include <linux/kgdb.h>
+
+#include <asm/io.h>
+#include <asm/sibyte/sb1250.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_uart.h>
+#include <asm/sibyte/sb1250_int.h>
+#include <asm/addrspace.h>
+
+int kgdb_port = 1;
+static int kgdb_irq;
+
+extern char sb1250_duart_present[];
+extern int sb1250_steal_irq(int irq);
+
+/* Forward declarations. */
+static void kgdbsibyte_init_duart(void);
+static int kgdb_init_io(void);
+
+#define IMR_IP6_VAL	K_INT_MAP_I4
+#define	duart_out(reg, val)	csr_out32(val, IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
+#define duart_in(reg)		csr_in32(IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
+
+static void kgdb_swarm_write_char(int c)
+{
+	while ((duart_in(R_DUART_STATUS) & M_DUART_TX_RDY) == 0) ;
+	duart_out(R_DUART_TX_HOLD, c);
+}
+
+static int kgdb_swarm_read_char(void)
+{
+	int ret_char;
+	unsigned int status;
+
+	status = duart_in(R_DUART_STATUS);
+	while ((status & M_DUART_RX_RDY) == 0) {
+		status = duart_in(R_DUART_STATUS);
+	}
+
+	/*
+	 * Check for framing error
+	 */
+	if (status & M_DUART_FRM_ERR) {
+		kgdbsibyte_init_duart();
+		kgdb_swarm_write_char('-');
+		return '-';
+	}
+
+	ret_char = duart_in(R_DUART_RX_HOLD);
+
+	return ret_char;
+}
+
+void sb1250_kgdb_interrupt(struct pt_regs *regs)
+{
+	int kgdb_irq = K_INT_UART_0 + kgdb_port;
+	/*
+	 * Clear break-change status (allow some time for the remote
+	 * host to stop the break, since we would see another
+	 * interrupt on the end-of-break too)
+	 */
+	kstat_this_cpu.irqs[kgdb_irq]++;
+	mdelay(500);
+	duart_out(R_DUART_CMD, V_DUART_MISC_CMD_RESET_BREAK_INT |
+		  M_DUART_RX_EN | M_DUART_TX_EN);
+	if (kgdb_io_ops.init != kgdb_init_io) {
+		/* Throw away the data if another I/O routine is
+		 * active.
+		 */
+		unsigned int status;
+
+		status = duart_in(R_DUART_STATUS);
+		while ((status & M_DUART_RX_RDY) == 0) {
+			status = duart_in(R_DUART_STATUS);
+		}
+		/*
+		 * Check for framing error
+		 */
+		if (status & M_DUART_FRM_ERR) {
+			kgdbsibyte_init_duart();
+		}
+		duart_in(R_DUART_RX_HOLD);
+	} else
+		breakpoint();
+
+}
+
+/*
+ * We use port #1 and we set it for 115200 BAUD, 8n1.
+ */
+static void kgdbsibyte_init_duart(void)
+{
+	/* Set 8n1. */
+	duart_out(R_DUART_MODE_REG_1,
+		  V_DUART_BITS_PER_CHAR_8 | V_DUART_PARITY_MODE_NONE);
+	duart_out(R_DUART_MODE_REG_2, M_DUART_STOP_BIT_LEN_1);
+	/* Set baud rate of 115200. */
+	duart_out(R_DUART_CLK_SEL, V_DUART_BAUD_RATE(115200));
+	/* Enable rx and tx */
+	duart_out(R_DUART_CMD, M_DUART_RX_EN | M_DUART_TX_EN);
+}
+
+static int kgdb_init_io(void)
+{
+#ifdef CONFIG_SIBYTE_SB1250_DUART
+	sb1250_duart_present[kgdb_port] = 0;
+#endif
+
+	kgdbsibyte_init_duart();
+
+	return 0;
+}
+
+/*
+ * Hookup our IRQ line.  We will already have been initialized a
+ * this point.
+ */
+static void __init kgdbsibyte_hookup_irq(void)
+{
+	/* Steal the IRQ. */
+	kgdb_irq = K_INT_UART_0 + kgdb_port;
+
+	/* Setup uart 1 settings, mapper */
+	__raw_writeq(M_DUART_IMR_BRK, IOADDR(A_DUART_IMRREG(kgdb_port)));
+
+	sb1250_steal_irq(kgdb_irq);
+
+	__raw_writeq(IMR_IP6_VAL,
+		     IOADDR(A_IMR_REGISTER(0, R_IMR_INTERRUPT_MAP_BASE) +
+			    (kgdb_irq << 3)));
+
+	sb1250_unmask_irq(0, kgdb_irq);
+}
+
+struct kgdb_io kgdb_io_ops = {
+	.read_char = kgdb_swarm_read_char,
+	.write_char = kgdb_swarm_write_char,
+	.init = kgdb_init_io,
+	.late_init = kgdbsibyte_hookup_irq,
+	.pre_exception = NULL,
+	.post_exception = NULL
+};
diff -puN arch/mips/sibyte/sb1250/Makefile~mips-lite arch/mips/sibyte/sb1250/Makefile
--- linux-2.6.13/arch/mips/sibyte/sb1250/Makefile~mips-lite	2005-08-16 17:32:26.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/sibyte/sb1250/Makefile	2005-08-16 17:32:26.000000000 -0700
@@ -4,5 +4,6 @@ obj-$(CONFIG_SMP)			+= smp.o
 obj-$(CONFIG_SIBYTE_TBPROF)		+= bcm1250_tbprof.o
 obj-$(CONFIG_SIBYTE_STANDALONE)		+= prom.o
 obj-$(CONFIG_SIBYTE_BUS_WATCHER)	+= bus_watcher.o
+obj-$(CONFIG_KGDB_SIBYTE)		+= kgdb_sibyte.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -L arch/mips/sibyte/swarm/dbg_io.c -puN arch/mips/sibyte/swarm/dbg_io.c~mips-lite /dev/null
--- linux-2.6.13/arch/mips/sibyte/swarm/dbg_io.c
+++ /dev/null	2005-08-15 07:19:53.144310000 -0700
@@ -1,76 +0,0 @@
-/*
- * kgdb debug routines for SiByte boards.
- *
- * Copyright (C) 2001 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- */
-
-/* -------------------- BEGINNING OF CONFIG --------------------- */
-
-#include <linux/delay.h>
-#include <asm/io.h>
-#include <asm/sibyte/sb1250.h>
-#include <asm/sibyte/sb1250_regs.h>
-#include <asm/sibyte/sb1250_uart.h>
-#include <asm/sibyte/sb1250_int.h>
-#include <asm/addrspace.h>
-
-/*
- * We use the second serial port for kgdb traffic.
- * 	115200, 8, N, 1.
- */
-
-#define	BAUD_RATE		115200
-#define	CLK_DIVISOR		V_DUART_BAUD_RATE(BAUD_RATE)
-#define	DATA_BITS		V_DUART_BITS_PER_CHAR_8		/* or 7    */
-#define	PARITY			V_DUART_PARITY_MODE_NONE	/* or even */
-#define	STOP_BITS		M_DUART_STOP_BIT_LEN_1		/* or 2    */
-
-static int duart_initialized = 0;	/* 0: need to be init'ed by kgdb */
-
-/* -------------------- END OF CONFIG --------------------- */
-extern int kgdb_port;
-
-#define	duart_out(reg, val)	csr_out32(val, IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
-#define duart_in(reg)		csr_in32(IOADDR(A_DUART_CHANREG(kgdb_port,reg)))
-
-void putDebugChar(unsigned char c);
-unsigned char getDebugChar(void);
-static void
-duart_init(int clk_divisor, int data, int parity, int stop)
-{
-	duart_out(R_DUART_MODE_REG_1, data | parity);
-	duart_out(R_DUART_MODE_REG_2, stop);
-	duart_out(R_DUART_CLK_SEL, clk_divisor);
-
-	duart_out(R_DUART_CMD, M_DUART_RX_EN | M_DUART_TX_EN);	/* enable rx and tx */
-}
-
-void
-putDebugChar(unsigned char c)
-{
-	if (!duart_initialized) {
-		duart_initialized = 1;
-		duart_init(CLK_DIVISOR, DATA_BITS, PARITY, STOP_BITS);
-	}
-	while ((duart_in(R_DUART_STATUS) & M_DUART_TX_RDY) == 0);
-	duart_out(R_DUART_TX_HOLD, c);
-}
-
-unsigned char
-getDebugChar(void)
-{
-	if (!duart_initialized) {
-		duart_initialized = 1;
-		duart_init(CLK_DIVISOR, DATA_BITS, PARITY, STOP_BITS);
-	}
-	while ((duart_in(R_DUART_STATUS) & M_DUART_RX_RDY) == 0) ;
-	return duart_in(R_DUART_RX_HOLD);
-}
-
diff -puN arch/mips/sibyte/swarm/Makefile~mips-lite arch/mips/sibyte/swarm/Makefile
--- linux-2.6.13/arch/mips/sibyte/swarm/Makefile~mips-lite	2005-08-16 17:32:26.000000000 -0700
+++ linux-2.6.13-trini/arch/mips/sibyte/swarm/Makefile	2005-08-16 17:32:26.000000000 -0700
@@ -1,3 +1 @@
 lib-y				= setup.o rtc_xicor1241.o rtc_m41t81.o
-
-lib-$(CONFIG_KGDB)		+= dbg_io.o
diff -puN /dev/null include/asm-mips/kdebug.h
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/include/asm-mips/kdebug.h	2005-08-16 17:32:26.000000000 -0700
@@ -0,0 +1,47 @@
+/*
+ *
+ * Copyright (C) 2004  MontaVista Software Inc.
+ * Author: Manish Lachwani, mlachwani@mvista.com or manish@koffee-break.com
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef _MIPS_KDEBUG_H
+#define _MIPS_KDEBUG_H
+
+#include <linux/notifier.h>
+
+struct pt_regs;
+
+struct die_args {
+	struct pt_regs *regs;
+	const char *str;
+	long err;
+};
+
+int register_die_notifier(struct notifier_block *nb);
+extern struct notifier_block *mips_die_chain;
+
+enum die_val {
+	DIE_OOPS = 1,
+	DIE_PANIC,
+	DIE_DIE,
+	DIE_KERNELDEBUG,
+	DIE_TRAP,
+	DIE_PAGE_FAULT,
+};
+
+/*
+ * trap number can be computed from regs and signr can be computed using
+ * compute_signal()
+ */
+static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err)
+{
+	struct die_args args = { .regs=regs, .str=str, .err=err };
+	return notifier_call_chain(&mips_die_chain, val, &args);
+}
+
+#endif /* _MIPS_KDEBUG_H */
diff -puN /dev/null include/asm-mips/kgdb.h
--- /dev/null	2005-08-15 07:19:53.144310000 -0700
+++ linux-2.6.13-trini/include/asm-mips/kgdb.h	2005-08-16 17:32:26.000000000 -0700
@@ -0,0 +1,22 @@
+#ifdef __KERNEL__
+#ifndef _ASM_KGDB_H_
+#define _ASM_KGDB_H_
+
+#define BUFMAX			2048
+#define NUMREGBYTES		(90*sizeof(long))
+#define NUMCRITREGBYTES		(12*sizeof(long))
+#define BREAK_INSTR_SIZE	4
+#define BREAKPOINT()		__asm__ __volatile__(		\
+					".globl breakinst\n\t"	\
+					".set\tnoreorder\n\t"	\
+					"nop\n"			\
+					"breakinst:\tbreak\n\t"	\
+					"nop\n\t"		\
+					".set\treorder")
+#define CHECK_EXCEPTION_STACK()	1
+#define CACHE_FLUSH_IS_SAFE	0
+
+extern int kgdb_early_setup;
+
+#endif				/* _ASM_KGDB_H_ */
+#endif				/* __KERNEL__ */
diff -puN lib/Kconfig.debug~mips-lite lib/Kconfig.debug
--- linux-2.6.13/lib/Kconfig.debug~mips-lite	2005-08-16 17:32:26.000000000 -0700
+++ linux-2.6.13-trini/lib/Kconfig.debug	2005-08-16 17:32:26.000000000 -0700
@@ -163,7 +163,7 @@ config FRAME_POINTER
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
 	select WANT_EXTRA_DEBUG_INFORMATION
-	depends on DEBUG_KERNEL && (X86 || ((!SMP || BROKEN) && (PPC32)))
+	depends on DEBUG_KERNEL && (X86 || MIPS32 || ((!SMP || BROKEN) && PPC32))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. It is strongly suggested that you enable
@@ -189,6 +189,7 @@ choice
 	prompt "Method for KGDB communication"
 	depends on KGDB
 	default KGDB_8250_NOMODULE
+	default KGDB_SIBYTE if SIBYTE_SB1xxx_SOC
 	default KGDB_MPSC if SERIAL_MPSC
 	help
 	  There are a number of different ways in which you can communicate
@@ -222,6 +223,10 @@ config KGDB_MPSC
 	  Controller (MPSC) channel. Note that the GT64260A is not
 	  supported.
 
+config KGDB_SIBYTE
+	bool "KGDB: On the Broadcom SWARM serial port"
+	depends on MIPS && SIBYTE_SB1xxx_SOC
+
 endchoice
 
 config KGDB_8250
_
