Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbUJ2TTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUJ2TTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUJ2TTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:19:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48806 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S263488AbUJ2SeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:34:13 -0400
Subject: [patch 6/8] KGDB support for ia64
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, davidm@hpl.hp.com,
       Robert.Picco@hp.com, keldon@hp.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <6.29102004.trini@kernel.crashing.org>
In-Reply-To: <5.29102004.trini@kernel.crashing.org>
References: <5.29102004.trini@kernel.crashing.org> <1.29102004.trini@kernel.crashing.org>
Date: Fri, 29 Oct 2004 11:34:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: David Mosberger-Tang <davidm@hpl.hp.com>, Robert Picco <Robert.Picco@hp.com>, Keldon Jones <keldon@hp.com>
This adds support for KGDB to ia64 and was done by Robert Picco and Keldon
Jones.

---

 linux-2.6.10-rc1-trini/arch/ia64/kernel/Makefile  |    1 
 linux-2.6.10-rc1-trini/arch/ia64/kernel/irq.c     |    4 
 linux-2.6.10-rc1-trini/arch/ia64/kernel/ivt.S     |   17 
 linux-2.6.10-rc1-trini/arch/ia64/kernel/kgdb.c    |  991 ++++++++++++++++++++++
 linux-2.6.10-rc1-trini/arch/ia64/kernel/process.c |    6 
 linux-2.6.10-rc1-trini/arch/ia64/kernel/smp.c     |   17 
 linux-2.6.10-rc1-trini/arch/ia64/kernel/traps.c   |   26 
 linux-2.6.10-rc1-trini/arch/ia64/kernel/unwind.c  |   61 +
 linux-2.6.10-rc1-trini/arch/ia64/mm/fault.c       |    3 
 linux-2.6.10-rc1-trini/drivers/firmware/pcdp.c    |   19 
 linux-2.6.10-rc1-trini/include/asm-ia64/kgdb.h    |   34 
 linux-2.6.10-rc1-trini/lib/Kconfig.debug          |    2 
 12 files changed, 1179 insertions(+), 2 deletions(-)

diff -puN arch/ia64/kernel/Makefile~ia64-lite arch/ia64/kernel/Makefile
--- linux-2.6.10-rc1/arch/ia64/kernel/Makefile~ia64-lite	2004-10-29 11:26:45.490207282 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/Makefile	2004-10-29 11:26:45.514201648 -0700
@@ -19,6 +19,7 @@ obj-$(CONFIG_PERFMON)		+= perfmon_defaul
 obj-$(CONFIG_IA64_CYCLONE)	+= cyclone.o
 obj-$(CONFIG_IA64_MCA_RECOVERY)	+= mca_recovery.o
 mca_recovery-y			+= mca_drv.o mca_drv_asm.o
+obj-$(CONFIG_KGDB)		+= kgdb.o
 
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
diff -puN arch/ia64/kernel/irq.c~ia64-lite arch/ia64/kernel/irq.c
--- linux-2.6.10-rc1/arch/ia64/kernel/irq.c~ia64-lite	2004-10-29 11:26:45.492206812 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/irq.c	2004-10-29 11:26:45.515201413 -0700
@@ -42,6 +42,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/kgdb.h>
 #include <linux/notifier.h>
 #include <linux/bitops.h>
 
@@ -543,6 +544,9 @@ unsigned int do_IRQ(unsigned long irq, s
 		desc->handler->end(irq);
 		spin_unlock(&desc->lock);
 	}
+
+	kgdb_process_breakpoint();
+
 	return 1;
 }
 
diff -puN arch/ia64/kernel/ivt.S~ia64-lite arch/ia64/kernel/ivt.S
--- linux-2.6.10-rc1/arch/ia64/kernel/ivt.S~ia64-lite	2004-10-29 11:26:45.494206343 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/ivt.S	2004-10-29 11:26:45.516201178 -0700
@@ -68,6 +68,13 @@
 # define DBG_FAULT(i)
 #endif
 
+#ifdef	CONFIG_KGDB
+#define	KGDB_ENABLE_PSR_DB mov r31=psr;; movl r30=IA64_PSR_DB;; or r31=r31,r30;; \
+		mov psr.l=r31;; srlz.i;;
+#else
+#define	KGDB_ENABLE_PSR_DB
+#endif
+
 #define MINSTATE_VIRT	/* needed by minstate.h */
 #include "minstate.h"
 
@@ -473,6 +480,7 @@ ENTRY(page_fault)
 	movl r14=ia64_leave_kernel
 	;;
 	SAVE_REST
+	KGDB_ENABLE_PSR_DB
 	mov rp=r14
 	;;
 	adds out2=16,r12			// out2 = pointer to pt_regs
@@ -733,6 +741,8 @@ ENTRY(break_fault)
 	;;
 	srlz.i					// guarantee that interruption collection is on
 	;;
+	KGDB_ENABLE_PSR_DB
+	;;
 (p15)	ssm psr.i				// restore psr.i
 	;;
 	mov r3=NR_syscalls - 1
@@ -776,6 +786,7 @@ ENTRY(interrupt)
 	srlz.i			// ensure everybody knows psr.ic is back on
 	;;
 	SAVE_REST
+	KGDB_ENABLE_PSR_DB
 	;;
 	alloc r14=ar.pfs,0,0,2,0 // must be first in an insn group
 	mov out0=cr.ivr		// pass cr.ivr as first arg
@@ -1003,6 +1014,7 @@ ENTRY(non_syscall)
 	movl r15=ia64_leave_kernel
 	;;
 	SAVE_REST
+	KGDB_ENABLE_PSR_DB
 	mov rp=r15
 	;;
 	br.call.sptk.many b6=ia64_bad_break	// avoid WAW on CFM and ignore return addr
@@ -1036,6 +1048,7 @@ ENTRY(dispatch_unaligned_handler)
 	adds r3=8,r2				// set up second base pointer
 	;;
 	SAVE_REST
+	KGDB_ENABLE_PSR_DB
 	movl r14=ia64_leave_kernel
 	;;
 	mov rp=r14
@@ -1078,6 +1091,10 @@ ENTRY(dispatch_to_fault_handler)
 	adds r3=8,r2				// set up second base pointer for SAVE_REST
 	;;
 	SAVE_REST
+	cmp.eq p6,p0=29,out0
+(p6)	br.cond.spnt 1f;;			// debug_vector
+	KGDB_ENABLE_PSR_DB
+1:
 	movl r14=ia64_leave_kernel
 	;;
 	mov rp=r14
diff -puN /dev/null arch/ia64/kernel/kgdb.c
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/kgdb.c	2004-10-29 11:26:45.518200709 -0700
@@ -0,0 +1,991 @@
+/*
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+/*
+ * Copyright (C) 2000-2001 VERITAS Software Corporation.
+ */
+/*
+ *  Contributor:     Lake Stevens Instrument Division$
+ *  Written by:      Glenn Engel $
+ *  Updated by:	     Amit Kale<akale@veritas.com>
+ *  Modified for 386 by Jim Kingdon, Cygnus Support.
+ *  Origianl kgdb, compatibility with 2.1.xx kernel by David Grothe <dave@gcom.com>
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
+#include <asm/unwind.h>
+#include <asm/rse.h>
+#include <linux/kgdb.h>
+#include <linux/init.h>
+#include <linux/debugger.h>
+
+#define NUM_REGS 590
+#define REGISTER_BYTES (NUM_REGS*8+128*8)
+#define REGISTER_BYTE(N) (((N) * 8) \
+  + ((N) <= IA64_FR0_REGNUM ? 0 : 8 * (((N) > IA64_FR127_REGNUM) ? 128 : (N) - IA64_FR0_REGNUM)))
+#define	REGISTER_SIZE(N) (((N) >= IA64_FR0_REGNUM && (N) <= IA64_FR127_REGNUM) ? 16 : 8)
+#define IA64_GR0_REGNUM         0
+#define IA64_FR0_REGNUM         128
+#define IA64_FR127_REGNUM       (IA64_FR0_REGNUM+127)
+#define IA64_PR0_REGNUM         256
+#define IA64_BR0_REGNUM         320
+#define IA64_VFP_REGNUM         328
+#define IA64_PR_REGNUM          330
+#define IA64_IP_REGNUM          331
+#define IA64_PSR_REGNUM         332
+#define IA64_CFM_REGNUM         333
+#define IA64_AR0_REGNUM         334
+#define IA64_NAT0_REGNUM        462
+#define IA64_NAT31_REGNUM       (IA64_NAT0_REGNUM+31)
+#define IA64_NAT32_REGNUM       (IA64_NAT0_REGNUM+32)
+#define IA64_RSC_REGNUM		(IA64_AR0_REGNUM+16)
+#define IA64_BSP_REGNUM		(IA64_AR0_REGNUM+17)
+#define IA64_BSPSTORE_REGNUM	(IA64_AR0_REGNUM+18)
+#define IA64_RNAT_REGNUM	(IA64_AR0_REGNUM+19)
+#define IA64_FCR_REGNUM		(IA64_AR0_REGNUM+21)
+#define IA64_EFLAG_REGNUM	(IA64_AR0_REGNUM+24)
+#define IA64_CSD_REGNUM		(IA64_AR0_REGNUM+25)
+#define IA64_SSD_REGNUM		(IA64_AR0_REGNUM+26)
+#define IA64_CFLG_REGNUM	(IA64_AR0_REGNUM+27)
+#define IA64_FSR_REGNUM		(IA64_AR0_REGNUM+28)
+#define IA64_FIR_REGNUM		(IA64_AR0_REGNUM+29)
+#define IA64_FDR_REGNUM		(IA64_AR0_REGNUM+30)
+#define IA64_CCV_REGNUM		(IA64_AR0_REGNUM+32)
+#define IA64_UNAT_REGNUM	(IA64_AR0_REGNUM+36)
+#define IA64_FPSR_REGNUM	(IA64_AR0_REGNUM+40)
+#define IA64_ITC_REGNUM		(IA64_AR0_REGNUM+44)
+#define IA64_PFS_REGNUM		(IA64_AR0_REGNUM+64)
+#define IA64_LC_REGNUM		(IA64_AR0_REGNUM+65)
+#define IA64_EC_REGNUM		(IA64_AR0_REGNUM+66)
+
+#define	REGISTER_INDEX(N)	(REGISTER_BYTE(N) / sizeof (unsigned long))
+
+#define	ptoff(V)	((unsigned int) &((struct pt_regs *)0x0)->V)
+struct  reg_to_ptreg_index {
+	unsigned int	reg;
+	unsigned int	ptregoff;
+};
+struct reg_to_ptreg_index gr_reg_to_ptreg_index[] = {
+	{IA64_GR0_REGNUM+8, ptoff(r8)},
+	{IA64_GR0_REGNUM+9, ptoff(r9)},
+	{IA64_GR0_REGNUM+10, ptoff(r10)},
+	{IA64_GR0_REGNUM+11, ptoff(r11)},
+	{IA64_GR0_REGNUM+1, ptoff(r1)},
+	{IA64_GR0_REGNUM+12, ptoff(r12)},
+	{IA64_GR0_REGNUM+13, ptoff(r13)},
+	{IA64_GR0_REGNUM+14, ptoff(r14)},
+	{IA64_GR0_REGNUM+15, ptoff(r15)},
+};
+
+struct reg_to_ptreg_index br_reg_to_ptreg_index[] = {
+	{IA64_BR0_REGNUM, ptoff(b0)},
+	{IA64_BR0_REGNUM+6, ptoff(b6)},
+	{IA64_BR0_REGNUM+7, ptoff(b7)},
+};
+
+extern atomic_t cpu_doing_single_step;
+
+void kgdb_get_reg(char *outbuffer, int regnum, struct unw_frame_info *info, struct pt_regs *ptregs)
+{
+	unsigned long reg, size = 0, *mem = &reg;
+	char nat;
+	struct ia64_fpreg freg;
+	int i;
+
+	if ((regnum >= IA64_GR0_REGNUM && regnum <= (IA64_GR0_REGNUM+1)) ||
+		(regnum >= (IA64_GR0_REGNUM+4) && regnum <= (IA64_GR0_REGNUM+7)) ||
+		(regnum >= (IA64_GR0_REGNUM+16) && regnum <= (IA64_GR0_REGNUM+31))) {
+		unw_access_gr(info, regnum - IA64_GR0_REGNUM, &reg, &nat, 0);
+		size = sizeof(reg);
+	}
+	else if ((regnum >= (IA64_GR0_REGNUM+2) && regnum <= (IA64_GR0_REGNUM+3)) ||
+		(regnum >= (IA64_GR0_REGNUM+8) && regnum <= (IA64_GR0_REGNUM+15))) {
+		if (ptregs) {
+			for (i = 0; i < (sizeof (gr_reg_to_ptreg_index) /
+				sizeof(gr_reg_to_ptreg_index[0])); i++)
+				if (gr_reg_to_ptreg_index[0].reg == regnum) {
+					reg = * ((unsigned long *)
+					(((void *) ptregs) + gr_reg_to_ptreg_index[i].ptregoff));
+					break;
+				}
+		} else
+			unw_access_gr(info, regnum - IA64_GR0_REGNUM, &reg, &nat, 0);
+		size = sizeof(reg);
+	}
+	else if (regnum >= IA64_BR0_REGNUM && regnum <= (IA64_BR0_REGNUM+7)) switch(regnum) {
+	case IA64_BR0_REGNUM:
+	case IA64_BR0_REGNUM+6:
+	case IA64_BR0_REGNUM+7:
+		if (ptregs) {
+			for (i = 0; i < (sizeof(br_reg_to_ptreg_index) /
+				sizeof(br_reg_to_ptreg_index[0])); i++)
+				if (br_reg_to_ptreg_index[i].reg == regnum) {
+					reg = * ((unsigned long *)
+					(((void *) ptregs) + br_reg_to_ptreg_index[i].ptregoff));
+					break;
+				}
+		} else
+			unw_access_br(info, regnum - IA64_BR0_REGNUM, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_BR0_REGNUM+1:
+	case IA64_BR0_REGNUM+2:
+	case IA64_BR0_REGNUM+3:
+	case IA64_BR0_REGNUM+4:
+	case IA64_BR0_REGNUM+5:
+		unw_access_br(info, regnum - IA64_BR0_REGNUM, &reg, 0);
+		size = sizeof(reg);
+		break;
+	}
+	else if (regnum >= IA64_FR0_REGNUM && regnum <= (IA64_FR0_REGNUM + 127)) switch (regnum) {
+	case IA64_FR0_REGNUM+6:
+	case IA64_FR0_REGNUM+7:
+	case IA64_FR0_REGNUM+8:
+	case IA64_FR0_REGNUM+9:
+	case IA64_FR0_REGNUM+10:
+	case IA64_FR0_REGNUM+11:
+	case IA64_FR0_REGNUM+12:
+		if (!ptregs)
+			unw_access_fr(info, regnum - IA64_FR0_REGNUM, &freg, 0);
+		else {
+			freg = *(&ptregs->f6 + (regnum - (IA64_FR0_REGNUM+6)));
+		}
+		size = sizeof(freg);
+		mem = (unsigned long *) &freg;
+		break;
+	default:
+		unw_access_fr(info, regnum - IA64_FR0_REGNUM, &freg, 0);
+		break;
+	}
+	else if (regnum == IA64_IP_REGNUM) {
+		if (!ptregs)
+			unw_get_ip(info, &reg);
+		else
+			reg = ptregs->cr_iip;
+		size = sizeof(reg);
+	}
+	else if (regnum == IA64_CFM_REGNUM) {
+		if (!ptregs)
+			unw_get_cfm(info, &reg);
+		else
+			reg = ptregs->cr_ifs;
+		size = sizeof(reg);
+	}
+	else if (regnum == IA64_PSR_REGNUM) {
+		if (!ptregs && kgdb_usethread)
+			ptregs = (struct pt_regs *)
+				((unsigned long) kgdb_usethread + IA64_STK_OFFSET) - 1;
+		if (ptregs)
+			reg = ptregs->cr_ipsr;
+		size = sizeof(reg);
+	}
+	else if (regnum == IA64_PR_REGNUM) {
+		if (ptregs)
+			reg = ptregs->pr;
+		else
+			unw_access_pr(info, &reg, 0);
+		size = sizeof(reg);
+	}
+	else if (regnum == IA64_BSP_REGNUM) {
+		unw_get_bsp(info, &reg);
+		size = sizeof(reg);
+	}
+	else if (regnum >= IA64_AR0_REGNUM && regnum <= IA64_EC_REGNUM) switch (regnum) {
+	case IA64_CSD_REGNUM:
+		if (ptregs)
+			reg = ptregs->ar_csd;
+		else
+			unw_access_ar(info, UNW_AR_CSD, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_SSD_REGNUM:
+		if (ptregs)
+			reg = ptregs->ar_ssd;
+		else
+			unw_access_ar(info, UNW_AR_SSD, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_UNAT_REGNUM:
+		if (ptregs)
+			reg = ptregs->ar_unat;
+		else
+			unw_access_ar(info, UNW_AR_UNAT, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_RNAT_REGNUM:
+		unw_access_ar(info, UNW_AR_RNAT, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_BSPSTORE_REGNUM:
+		unw_access_ar(info, UNW_AR_BSPSTORE, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_PFS_REGNUM:
+		unw_access_ar(info, UNW_AR_PFS, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_LC_REGNUM:
+		unw_access_ar(info, UNW_AR_LC, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_EC_REGNUM:
+		unw_access_ar(info, UNW_AR_EC, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_FPSR_REGNUM:
+		if (ptregs)
+			reg = ptregs->ar_fpsr;
+		else
+			unw_access_ar(info, UNW_AR_FPSR, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_RSC_REGNUM:
+		if (ptregs)
+			reg = ptregs->ar_rsc;
+		else
+			unw_access_ar(info, UNW_AR_RNAT, &reg, 0);
+		size = sizeof(reg);
+		break;
+	case IA64_CCV_REGNUM:
+		unw_access_ar(info, UNW_AR_CCV, &reg, 0);
+		size = sizeof(reg);
+		break;
+	}
+
+	if (size) {
+		kgdb_mem2hex((char *) mem, outbuffer, size);
+		outbuffer[size*2] = 0;
+	}
+	else
+		strcpy(outbuffer, "E0");
+
+	return;
+}
+
+void kgdb_put_reg(char *inbuffer, char *outbuffer, int regnum,
+	struct unw_frame_info *info, struct pt_regs *ptregs)
+{
+	unsigned long reg;
+	char nat = 0;
+	struct ia64_fpreg freg;
+	int i;
+	char *ptr;
+
+	ptr = inbuffer;
+	kgdb_hex2long(&ptr, &reg);
+	strcpy(outbuffer, "OK");
+
+	if ((regnum >= IA64_GR0_REGNUM && regnum <= (IA64_GR0_REGNUM+1)) ||
+		(regnum >= (IA64_GR0_REGNUM+4) && regnum <= (IA64_GR0_REGNUM+7)) ||
+		(regnum >= (IA64_GR0_REGNUM+16) && regnum <= (IA64_GR0_REGNUM+31))) {
+		unw_access_gr(info, regnum - IA64_GR0_REGNUM, &reg, &nat, 1);
+	}
+	else if ((regnum >= (IA64_GR0_REGNUM+2) && regnum <= (IA64_GR0_REGNUM+3)) ||
+		(regnum >= (IA64_GR0_REGNUM+8) && regnum <= (IA64_GR0_REGNUM+15))) {
+		for (i = 0; i < (sizeof (gr_reg_to_ptreg_index) /
+			sizeof(gr_reg_to_ptreg_index[0])); i++)
+			if (gr_reg_to_ptreg_index[0].reg == regnum) {
+				* ((unsigned long *)
+				(((void *) ptregs) + gr_reg_to_ptreg_index[i].ptregoff)) = reg;
+				break;
+			}
+	}
+	else if (regnum >= IA64_BR0_REGNUM && regnum <= (IA64_BR0_REGNUM+7)) switch(regnum) {
+	case IA64_BR0_REGNUM:
+	case IA64_BR0_REGNUM+6:
+	case IA64_BR0_REGNUM+7:
+		for (i = 0; i < (sizeof(br_reg_to_ptreg_index) /
+			sizeof(br_reg_to_ptreg_index[0])); i++)
+			if (br_reg_to_ptreg_index[i].reg == regnum) {
+				* ((unsigned long *)
+				(((void *) ptregs) + br_reg_to_ptreg_index[i].ptregoff)) = reg;
+				break;
+			}
+		break;
+	case IA64_BR0_REGNUM+1:
+	case IA64_BR0_REGNUM+2:
+	case IA64_BR0_REGNUM+3:
+	case IA64_BR0_REGNUM+4:
+	case IA64_BR0_REGNUM+5:
+		unw_access_br(info, regnum - IA64_BR0_REGNUM, &reg, 1);
+		break;
+	}
+	else if (regnum >= IA64_FR0_REGNUM && regnum <= (IA64_FR0_REGNUM + 127)) switch (regnum) {
+	case IA64_FR0_REGNUM+6:
+	case IA64_FR0_REGNUM+7:
+	case IA64_FR0_REGNUM+8:
+	case IA64_FR0_REGNUM+9:
+	case IA64_FR0_REGNUM+10:
+	case IA64_FR0_REGNUM+11:
+	case IA64_FR0_REGNUM+12:
+		freg.u.bits[0] = reg;
+		kgdb_hex2long(&ptr, &freg.u.bits[1]);
+		*(&ptregs->f6 + (regnum - (IA64_FR0_REGNUM+6))) = freg;
+		break;
+	default:
+		break;
+	}
+	else if (regnum == IA64_IP_REGNUM)
+		ptregs->cr_iip = reg;
+	else if (regnum == IA64_CFM_REGNUM)
+		ptregs->cr_ifs = reg;
+	else if (regnum == IA64_PSR_REGNUM)
+		ptregs->cr_ipsr = reg;
+	else if (regnum == IA64_PR_REGNUM)
+		ptregs->pr = reg;
+	else if (regnum >= IA64_AR0_REGNUM && regnum <= IA64_EC_REGNUM) switch (regnum) {
+	case IA64_CSD_REGNUM:
+		ptregs->ar_csd = reg;
+		break;
+	case IA64_SSD_REGNUM:
+		ptregs->ar_ssd = reg;
+	case IA64_UNAT_REGNUM:
+		ptregs->ar_unat = reg;
+	case IA64_RNAT_REGNUM:
+		unw_access_ar(info, UNW_AR_RNAT, &reg, 1);
+		break;
+	case IA64_BSPSTORE_REGNUM:
+		unw_access_ar(info, UNW_AR_BSPSTORE, &reg, 1);
+		break;
+	case IA64_PFS_REGNUM:
+		unw_access_ar(info, UNW_AR_PFS, &reg, 1);
+		break;
+	case IA64_LC_REGNUM:
+		unw_access_ar(info, UNW_AR_LC, &reg, 1);
+		break;
+	case IA64_EC_REGNUM:
+		unw_access_ar(info, UNW_AR_EC, &reg, 1);
+		break;
+	case IA64_FPSR_REGNUM:
+		ptregs->ar_fpsr = reg;
+		break;
+	case IA64_RSC_REGNUM:
+		ptregs->ar_rsc = reg;
+		break;
+	case IA64_CCV_REGNUM:
+		unw_access_ar(info, UNW_AR_CCV, &reg, 1);
+		break;
+	}
+	else
+		strcpy(outbuffer, "E01");
+
+	return;
+}
+
+void regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+}
+
+void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
+{
+}
+
+void gdb_regs_to_regs(unsigned long *gdb_regs, struct pt_regs *regs)
+{
+
+}
+
+#define	MAX_HW_BREAKPOINT	(20)
+long hw_break_total_dbr, hw_break_total_ibr;
+#define	HW_BREAKPOINT	(hw_break_total_dbr + hw_break_total_ibr)
+#define	WATCH_INSTRUCTION	0x0
+#define WATCH_WRITE		0x1
+#define	WATCH_READ		0x2
+#define	WATCH_ACCESS		0x3
+
+#define	HWCAP_DBR	((1 << WATCH_WRITE) | (1 << WATCH_READ))
+#define	HWCAP_IBR	(1 << WATCH_INSTRUCTION)
+struct hw_breakpoint {
+	unsigned enabled;
+	unsigned long capable;
+	unsigned long type;
+	unsigned long mask;
+	unsigned long addr;
+} *breakinfo;
+
+static struct hw_breakpoint hwbreaks[MAX_HW_BREAKPOINT];
+
+enum instruction_type {A, I, M, F, B, L, X, u};
+
+static enum instruction_type bundle_encoding[32][3] = {
+  { M, I, I },				/* 00 */
+  { M, I, I },				/* 01 */
+  { M, I, I },				/* 02 */
+  { M, I, I },				/* 03 */
+  { M, L, X },				/* 04 */
+  { M, L, X },				/* 05 */
+  { u, u, u },  			/* 06 */
+  { u, u, u },  			/* 07 */
+  { M, M, I },				/* 08 */
+  { M, M, I },				/* 09 */
+  { M, M, I },				/* 0A */
+  { M, M, I },				/* 0B */
+  { M, F, I },				/* 0C */
+  { M, F, I },				/* 0D */
+  { M, M, F },				/* 0E */
+  { M, M, F },				/* 0F */
+  { M, I, B },				/* 10 */
+  { M, I, B },				/* 11 */
+  { M, B, B },				/* 12 */
+  { M, B, B },				/* 13 */
+  { u, u, u },  			/* 14 */
+  { u, u, u },  			/* 15 */
+  { B, B, B },				/* 16 */
+  { B, B, B },				/* 17 */
+  { M, M, B },				/* 18 */
+  { M, M, B },				/* 19 */
+  { u, u, u },  			/* 1A */
+  { u, u, u },  			/* 1B */
+  { M, F, B },				/* 1C */
+  { M, F, B },				/* 1D */
+  { u, u, u },  			/* 1E */
+  { u, u, u },  			/* 1F */
+};
+
+static int kgdb_arch_set_breakpoint(unsigned long addr, char *saved_instr)
+{
+	extern unsigned long _start[];
+	unsigned long slot = addr & 0xf, bundle_addr;
+	unsigned long template;
+	struct bundle {
+		struct {
+			unsigned long long template : 5;
+			unsigned long long slot0 : 41;
+			unsigned long long slot1_p0 : 64-46;
+		} quad0;
+		struct {
+			unsigned long long slot1_p1 : 41 - (64-46);
+			unsigned long long slot2 : 41;
+		} quad1;
+	} bundle;
+	int ret;
+
+	bundle_addr = addr & ~0xFULL;
+
+	if (bundle_addr == (unsigned long) _start)
+		return 0;
+
+	ret = kgdb_get_mem((char *) bundle_addr, (char *) &bundle, BREAK_INSTR_SIZE);
+	if (ret < 0)
+		return ret;
+
+	if (slot > 2)
+		slot = 0;
+
+	memcpy(saved_instr, &bundle, BREAK_INSTR_SIZE);
+	template = bundle.quad0.template;
+
+	if (slot == 1 && bundle_encoding[template][1] == L)
+		slot = 2;
+
+	switch (slot) {
+	case 0:
+		bundle.quad0.slot0 = BREAKNUM;
+		break;
+	case 1:
+		bundle.quad0.slot1_p0 = BREAKNUM;
+		bundle.quad1.slot1_p1 = (BREAKNUM >> (64-46));
+		break;
+	case 2:
+		bundle.quad1.slot2 = BREAKNUM;
+		break;
+	}
+
+	return kgdb_set_mem((char *) bundle_addr, (char *) &bundle, BREAK_INSTR_SIZE);
+}
+
+static int kgdb_arch_remove_breakpoint(unsigned long addr, char *bundle)
+{
+	extern unsigned long _start[];
+
+	addr = addr & ~0xFULL;
+	if (addr == (unsigned long) _start)
+		return 0;
+	return kgdb_set_mem((char *) addr, (char *) bundle, BREAK_INSTR_SIZE);
+}
+
+static int hw_breakpoint_init;
+
+void do_init_hw_break(void)
+{
+	s64 status;
+	int i;
+
+	hw_breakpoint_init = 1;
+
+#ifdef	CONFIG_IA64_HP_SIM
+	hw_break_total_ibr = 8;
+	hw_break_total_dbr = 8;
+	status = 0;
+#else
+	status = ia64_pal_debug_info(&hw_break_total_ibr, &hw_break_total_dbr);
+#endif
+
+	if (status) {
+		printk(KERN_INFO "do_init_hw_break: pal call failed %d\n", (int) status);
+		return;
+	}
+
+	if (HW_BREAKPOINT > MAX_HW_BREAKPOINT) {
+		printk(KERN_INFO "do_init_hw_break: %d exceeds max %d\n", (int) HW_BREAKPOINT,
+			(int) MAX_HW_BREAKPOINT);
+
+		while ((HW_BREAKPOINT > MAX_HW_BREAKPOINT) && hw_break_total_ibr != 1)
+			hw_break_total_ibr--;
+		while (HW_BREAKPOINT > MAX_HW_BREAKPOINT)
+			hw_break_total_dbr--;
+	}
+
+	breakinfo = hwbreaks;
+
+	memset(breakinfo, 0, HW_BREAKPOINT * sizeof(struct hw_breakpoint));
+
+	for (i = 0; i < hw_break_total_dbr; i++)
+		breakinfo[i].capable = HWCAP_DBR;
+
+	for (; i < HW_BREAKPOINT; i++)
+		breakinfo[i].capable = HWCAP_IBR;
+
+	return;
+}
+
+void kgdb_correct_hw_break(void)
+{
+	int breakno;
+
+	if (!breakinfo)
+		return;
+
+	for (breakno = 0; breakno < HW_BREAKPOINT; breakno++) {
+		if (breakinfo[breakno].enabled) {
+			if (breakinfo[breakno].capable & HWCAP_IBR) {
+				int ibreakno = breakno - hw_break_total_dbr;
+				ia64_set_ibr(ibreakno << 1, breakinfo[breakno].addr);
+				ia64_set_ibr((ibreakno << 1) + 1,
+					(~breakinfo[breakno].mask & ((1UL << 56UL) - 1)) |
+					(1UL << 56UL) | (1UL << 63UL));
+			}
+			else {
+				ia64_set_dbr(breakno << 1, breakinfo[breakno].addr);
+				ia64_set_dbr((breakno << 1) + 1,
+					(~breakinfo[breakno].mask & ((1UL << 56UL) - 1)) |
+					(1UL << 56UL) | (breakinfo[breakno].type << 62UL));
+			}
+		}
+		else  {
+			if (breakinfo[breakno].capable & HWCAP_IBR)
+				ia64_set_ibr(((breakno - hw_break_total_dbr) << 1) + 1, 0);
+			else
+				ia64_set_dbr((breakno << 1) + 1, 0);
+		}
+	}
+
+	return;
+}
+
+int hardware_breakpoint(unsigned long addr, int length, int type, int action)
+{
+	int breakno, found, watch;
+	unsigned long mask;
+	extern unsigned long _start[];
+
+	if (!hw_breakpoint_init)
+		do_init_hw_break();
+
+	if (!breakinfo)
+		return 0;
+	else if (addr == (unsigned long) _start)
+		return 1;
+
+	if (type == WATCH_ACCESS)
+		mask = HWCAP_DBR;
+	else
+		mask = 1UL << type;
+
+	for (watch = 0, found = 0, breakno = 0; breakno < HW_BREAKPOINT; breakno++) {
+		if (action) {
+			if (breakinfo[breakno].enabled || !(breakinfo[breakno].capable & mask))
+				continue;
+			breakinfo[breakno].enabled = 1;
+			breakinfo[breakno].type = type;
+			breakinfo[breakno].mask = length - 1;
+			breakinfo[breakno].addr = addr;
+			watch = breakno;
+		} else if (breakinfo[breakno].enabled &&
+			((length < 0 && breakinfo[breakno].addr == addr) ||
+			((breakinfo[breakno].capable & mask) &&
+			(breakinfo[breakno].mask == (length - 1)) &&
+			(breakinfo[breakno].addr == addr)))) {
+			breakinfo[breakno].enabled = 0;
+			breakinfo[breakno].type = 0UL;
+		}
+		else
+			continue;
+		found++;
+		if (type != WATCH_ACCESS)
+			break;
+		else if (found == 2)
+			break;
+		else
+			mask = HWCAP_IBR;
+	}
+
+	if (type == WATCH_ACCESS && found == 1) {
+		breakinfo[watch].enabled = 0;
+		found = 0;
+	}
+
+	return found;
+}
+
+int kgdb_arch_set_hw_breakpoint(unsigned long addr, int len, enum kgdb_bptype type)
+{
+	return hardware_breakpoint(addr, len, type - '1', 1);
+}
+
+int kgdb_arch_remove_hw_breakpoint(unsigned long addr, int len, enum kgdb_bptype type)
+{
+	return hardware_breakpoint(addr, len, type - '1', 0);
+}
+
+int kgdb_remove_hw_break(unsigned long addr)
+{
+	return hardware_breakpoint(addr, 8, WATCH_INSTRUCTION, 0);
+
+}
+
+void kgdb_remove_all_hw_break(void)
+{
+	int i;
+
+	for (i = 0; i < HW_BREAKPOINT; i++)
+		memset(&breakinfo[i], 0, sizeof(struct hw_breakpoint));
+}
+
+int kgdb_set_hw_break(unsigned long addr)
+{
+	return hardware_breakpoint(addr, 8, WATCH_INSTRUCTION, 1);
+}
+
+void kgdb_disable_hw_debug(struct pt_regs *regs)
+{
+	unsigned long hw_breakpoint_status;
+
+	hw_breakpoint_status = ia64_getreg(_IA64_REG_PSR);
+	if (hw_breakpoint_status & IA64_PSR_DB)
+		ia64_setreg(_IA64_REG_PSR_L, hw_breakpoint_status ^ IA64_PSR_DB);
+}
+
+volatile static struct smp_unw {
+	struct unw_frame_info *unw;
+	struct task_struct *task;
+} smp_unw[NR_CPUS];
+
+static int inline kgdb_get_blocked_state(struct task_struct *p, struct unw_frame_info *unw)
+{
+	unsigned long ip;
+	int count = 0;
+
+	unw_init_from_blocked_task(unw, p);
+	ip = 0UL;
+	do {
+		if (unw_unwind(unw) < 0)
+			return -1;
+		unw_get_ip(unw, &ip);
+		if (!in_sched_functions(ip))
+			break;
+	} while (count++ < 16);
+
+	if (!ip)
+		return -1;
+	else
+		return 0;
+}
+
+static void inline kgdb_wait(struct pt_regs *regs)
+{
+	unsigned long hw_breakpoint_status = ia64_getreg(_IA64_REG_PSR);
+	if (hw_breakpoint_status & IA64_PSR_DB)
+		ia64_setreg(_IA64_REG_PSR_L, hw_breakpoint_status ^ IA64_PSR_DB);
+	kgdb_nmihook(smp_processor_id(), regs);
+	if (hw_breakpoint_status & IA64_PSR_DB)
+		ia64_setreg(_IA64_REG_PSR_L, hw_breakpoint_status);
+	return;
+}
+
+static void inline normalize(struct unw_frame_info *running, struct pt_regs *regs)
+{
+	unsigned long sp;
+
+	do {
+		unw_get_sp(running, &sp);
+		if ((sp + 0x10) >= (unsigned long) regs)
+			break;
+	} while (unw_unwind(running) >= 0);
+
+	return;
+}
+
+static void kgdb_init_running(struct unw_frame_info *unw, void *data)
+{
+	struct pt_regs *regs;
+
+	regs = data;
+	normalize(unw, regs);
+	smp_unw[smp_processor_id()].unw = unw;
+	kgdb_wait(regs);
+}
+
+void kgdb_wait_ipi(struct pt_regs *regs)
+{
+	struct unw_frame_info unw;
+
+	smp_unw[smp_processor_id()].task = current;
+
+	if (user_mode(regs)) {
+		smp_unw[smp_processor_id()].unw = (struct unw_frame_info *) 1;
+		kgdb_wait(regs);
+	}
+	else {
+		if (current->state == TASK_RUNNING)
+			unw_init_running(kgdb_init_running, regs);
+		else {
+			if (kgdb_get_blocked_state(current, &unw))
+				smp_unw[smp_processor_id()].unw = (struct unw_frame_info *) 1;
+			else
+				smp_unw[smp_processor_id()].unw = &unw;
+			kgdb_wait(regs);
+		}
+	}
+
+	smp_unw[smp_processor_id()].unw = NULL;
+	return;
+}
+
+void kgdb_post_master_code(struct pt_regs *regs, int eVector, int err_code)
+{
+	if (num_online_cpus() > 1)
+		smp_send_nmi_allbutself();
+}
+
+static void do_kgdb_handle_exception(struct unw_frame_info *, void *data);
+
+struct kgdb_state {
+	int exceptionVector;
+	int signo;
+	unsigned long err_code;
+	struct pt_regs *regs;
+	struct unw_frame_info *unw;
+	char *inbuf;
+	char *outbuf;
+	int unwind;
+	int ret;
+};
+
+static void inline kgdb_pc(struct pt_regs *regs, unsigned long pc)
+{
+	regs->cr_iip = pc & ~0xf;
+	ia64_psr(regs)->ri = pc & 0x3;
+	return;
+}
+
+volatile int kgdb_hwbreak_sstep[NR_CPUS];
+
+int kgdb_arch_handle_exception(int exceptionVector, int signo,
+		int err_code, char *remcom_in_buffer,
+		char *remcom_out_buffer, struct pt_regs *linux_regs)
+{
+	struct kgdb_state info;
+
+	info.exceptionVector = exceptionVector;
+	info.signo = signo;
+	info.err_code = err_code;
+	info.unw = (void *) 0;
+	info.inbuf = remcom_in_buffer;
+	info.outbuf = remcom_out_buffer;
+	info.unwind = 0;
+	info.ret = -1;
+
+	if (remcom_in_buffer[0] == 'c' || remcom_in_buffer[0] == 's') {
+		info.regs = linux_regs;
+		do_kgdb_handle_exception(NULL, &info);
+	}
+	else if (kgdb_usethread == current) {
+		info.unwind = 1;
+		info.regs = linux_regs;
+		unw_init_running(do_kgdb_handle_exception, &info);
+	} else if (kgdb_usethread->state != TASK_RUNNING) {
+		struct unw_frame_info unw_info;
+
+		if (kgdb_get_blocked_state(kgdb_usethread, &unw_info)) {
+			info.ret = 1;
+			goto bad;
+		}
+		info.regs = NULL;
+		do_kgdb_handle_exception(&unw_info, &info);
+	}
+	else {
+		int i;
+
+		for (i = 0; i < NR_CPUS; i++)
+			if (smp_unw[i].task == kgdb_usethread && smp_unw[i].unw &&
+				smp_unw[i].unw != (struct unw_frame_info *) 1) {
+				info.regs = NULL;
+				do_kgdb_handle_exception(smp_unw[i].unw, &info);
+				break;
+			}
+			else {
+				info.ret = 1;
+				goto bad;
+			}
+	}
+
+bad:
+	if (info.ret != -1 && remcom_in_buffer[0] == 'p') {
+		unsigned long bad = 0xbad4badbadbadbadUL;
+
+		printk("kgdb_arch_handle_exception: p packet bad\n");
+		kgdb_mem2hex((char *) &bad, remcom_out_buffer, sizeof (bad));
+		remcom_out_buffer[sizeof (bad) * 2] = 0;
+		info.ret = -1;
+	}
+	return info.ret;
+}
+
+
+
+static void do_kgdb_handle_exception(struct unw_frame_info *unw_info, void *data)
+{
+	long addr;
+	char *ptr;
+	unsigned long newPC;
+	int exceptionVector, signo;
+	unsigned long err_code;
+	struct pt_regs *linux_regs;
+	struct kgdb_state *info;
+	char *remcom_in_buffer, *remcom_out_buffer;
+
+	info = data;
+	info->unw = unw_info;
+	exceptionVector = info->exceptionVector;
+	signo = info->signo;
+	err_code = info->err_code;
+	remcom_in_buffer = info->inbuf;
+	remcom_out_buffer = info->outbuf;
+	linux_regs = info->regs;
+
+	if (info->unwind)
+		normalize(unw_info, linux_regs);
+
+	switch (remcom_in_buffer[0]) {
+	case 'p':
+	{
+		int regnum;
+
+		kgdb_hex2mem(&remcom_in_buffer[1], (char *) &regnum, sizeof(regnum));
+		if (regnum >= NUM_REGS) {
+			remcom_out_buffer[0] = 'E';
+			remcom_out_buffer[1] = 0;
+		}
+		else
+			kgdb_get_reg(remcom_out_buffer, regnum, unw_info, linux_regs);
+		break;
+	}
+	case 'P':
+	{
+		int regno;
+		long v;
+		char *ptr;
+
+		ptr = &remcom_in_buffer[1];
+		if ((!kgdb_usethread || kgdb_usethread == current) &&
+			kgdb_hex2long(&ptr, &v) &&
+		   	*ptr++ == '=' && (v >= 0)) {
+			regno = (int) v;
+			regno = (regno >= NUM_REGS ? 0 : regno);
+			kgdb_put_reg(ptr, remcom_out_buffer, regno,
+				unw_info, linux_regs);
+		} else
+			strcpy(remcom_out_buffer, "E01");
+		break;
+	}
+	case 'c':
+	case 's':
+		if (kgdb_contthread && kgdb_contthread != current) {
+			strcpy(remcom_out_buffer, "E00");
+			break;
+		}
+
+		if (exceptionVector == 11 && err_code == KGDBBREAKNUM) {
+			if (ia64_psr(linux_regs)->ri < 2)
+				kgdb_pc(linux_regs, linux_regs->cr_iip +
+					ia64_psr(linux_regs)->ri + 1);
+			else
+				kgdb_pc(linux_regs, linux_regs->cr_iip + 16);
+		}
+
+		/* try to read optional parameter, pc unchanged if no parm */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
+			linux_regs->cr_iip = addr;
+		}
+		newPC = linux_regs->cr_iip;
+
+		/* clear the trace bit */
+		linux_regs->cr_ipsr &= ~IA64_PSR_SS;
+
+		atomic_set(&cpu_doing_single_step,-1);
+
+		/* set the trace bit if we're stepping or took a hardware break*/
+		if (remcom_in_buffer[0] == 's' || exceptionVector == 29) {
+			linux_regs->cr_ipsr |= IA64_PSR_SS;
+			debugger_step = 1;
+			if (kgdb_contthread)
+				atomic_set(&cpu_doing_single_step,smp_processor_id());
+		}
+
+		kgdb_correct_hw_break();
+
+		/* if not hardware breakpoint, then reenable them */
+		if (exceptionVector != 29)
+			linux_regs->cr_ipsr |= IA64_PSR_DB;
+		else {
+			kgdb_hwbreak_sstep[smp_processor_id()] = 1;
+			linux_regs->cr_ipsr &= ~IA64_PSR_DB;
+		}
+
+		info->ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return;
+}
+
+struct kgdb_arch arch_kgdb_ops = {
+	.set_breakpoint = kgdb_arch_set_breakpoint,
+	.remove_breakpoint = kgdb_arch_remove_breakpoint,
+	.set_hw_breakpoint = kgdb_arch_set_hw_breakpoint,
+	.remove_hw_breakpoint = kgdb_arch_remove_hw_breakpoint,
+	.gdb_bpt_instr = {0xcc},
+	.flags = KGDB_HW_BREAKPOINT,
+};
diff -puN arch/ia64/kernel/process.c~ia64-lite arch/ia64/kernel/process.c
--- linux-2.6.10-rc1/arch/ia64/kernel/process.c~ia64-lite	2004-10-29 11:26:45.496205873 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/process.c	2004-10-29 11:26:45.518200709 -0700
@@ -415,6 +415,9 @@ copy_thread (int nr, unsigned long clone
 	 */
 	child_ptregs->cr_ipsr = ((child_ptregs->cr_ipsr | IA64_PSR_BITS_TO_SET)
 				 & ~(IA64_PSR_BITS_TO_CLEAR | IA64_PSR_PP | IA64_PSR_UP));
+#ifdef	CONFIG_KGDB
+	child_ptregs->cr_ipsr |= IA64_PSR_DB;
+#endif
 
 	/*
 	 * NOTE: The calling convention considers all floating point
@@ -643,6 +646,9 @@ kernel_thread (int (*fn)(void *), void *
 	regs.pt.r11 = (unsigned long) arg;	/* 2nd argument */
 	/* Preserve PSR bits, except for bits 32-34 and 37-45, which we can't read.  */
 	regs.pt.cr_ipsr = ia64_getreg(_IA64_REG_PSR) | IA64_PSR_BN;
+#ifdef	CONFIG_KGDB
+	regs.pt.cr_ipsr |= IA64_PSR_DB;
+#endif
 	regs.pt.cr_ifs = 1UL << 63;		/* mark as valid, empty frame */
 	regs.sw.ar_fpsr = regs.pt.ar_fpsr = ia64_getreg(_IA64_REG_AR_FPSR);
 	regs.sw.ar_bspstore = (unsigned long) current + IA64_RBS_OFFSET;
diff -puN arch/ia64/kernel/smp.c~ia64-lite arch/ia64/kernel/smp.c
--- linux-2.6.10-rc1/arch/ia64/kernel/smp.c~ia64-lite	2004-10-29 11:26:45.498205404 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/smp.c	2004-10-29 11:26:45.519200474 -0700
@@ -47,6 +47,7 @@
 #include <asm/tlbflush.h>
 #include <asm/unistd.h>
 #include <asm/mca.h>
+#include <linux/kgdb.h>
 
 /*
  * Structure and data for smp_call_function(). This is designed to minimise static memory
@@ -66,6 +67,9 @@ static volatile struct call_data_struct 
 
 #define IPI_CALL_FUNC		0
 #define IPI_CPU_STOP		1
+#ifdef	CONFIG_KGDB
+#define	IPI_KGDB_INTERRUPT	2
+#endif
 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
 static DEFINE_PER_CPU(u64, ipi_operation) ____cacheline_aligned;
@@ -155,6 +159,11 @@ handle_IPI (int irq, void *dev_id, struc
 			      case IPI_CPU_STOP:
 				stop_this_cpu();
 				break;
+#ifdef	CONFIG_KGDB
+			      case IPI_KGDB_INTERRUPT:
+				kgdb_wait_ipi(regs);
+				break;
+#endif
 
 			      default:
 				printk(KERN_CRIT "Unknown IPI on CPU %d: %lu\n", this_cpu, which);
@@ -303,6 +312,14 @@ smp_call_function_single (int cpuid, voi
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
+#ifdef	CONFIG_KGDB
+void
+smp_send_nmi_allbutself(void)
+{
+	send_IPI_allbutself(IPI_KGDB_INTERRUPT);
+}
+#endif
+
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
diff -puN arch/ia64/kernel/traps.c~ia64-lite arch/ia64/kernel/traps.c
--- linux-2.6.10-rc1/arch/ia64/kernel/traps.c~ia64-lite	2004-10-29 11:26:45.500204934 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/traps.c	2004-10-29 11:26:45.520200239 -0700
@@ -15,6 +15,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/module.h>       /* for EXPORT_SYMBOL */
 #include <linux/hardirq.h>
+#include <linux/kgdb.h>
 
 #include <asm/fpswa.h>
 #include <asm/ia32.h>
@@ -92,6 +93,8 @@ die (const char *str, struct pt_regs *re
   	} else
 		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
 
+	CHK_DEBUGGER(1, SIGTRAP, err, regs,);
+
 	bust_spinlocks(0);
 	die.lock_owner = -1;
 	spin_unlock_irq(&die.lock);
@@ -119,7 +122,9 @@ ia64_bad_break (unsigned long break_num,
 
 	switch (break_num) {
 	      case 0: /* unknown error (used by GCC for __builtin_abort()) */
+#ifndef	CONFIG_KGDB
 		die_if_kernel("bugcheck!", regs, break_num);
+#endif
 		sig = SIGILL; code = ILL_ILLOPC;
 		break;
 
@@ -172,8 +177,10 @@ ia64_bad_break (unsigned long break_num,
 		break;
 
 	      default:
+#ifndef	CONFIG_KGDB
 		if (break_num < 0x40000 || break_num > 0x100000)
 			die_if_kernel("Bad break", regs, break_num);
+#endif
 
 		if (break_num < 0x80000) {
 			sig = SIGILL; code = __ILL_BREAK;
@@ -181,6 +188,13 @@ ia64_bad_break (unsigned long break_num,
 			sig = SIGTRAP; code = TRAP_BRKPT;
 		}
 	}
+#ifdef	CONFIG_KGDB
+	/*
+	 * We don't want to trap simulator system calls.
+	 */
+	if (break_num != 0x80001)
+		CHK_DEBUGGER(11, sig, break_num, regs, return);
+#endif
 	siginfo.si_signo = sig;
 	siginfo.si_errno = 0;
 	siginfo.si_code = code;
@@ -487,9 +501,18 @@ ia64_fault (unsigned long vector, unsign
 		sprintf(buf, "Unsupported data reference");
 		break;
 
+	      case 36: /* Single Step Trap */
+#ifdef	CONFIG_KGDB
+		if (linux_debug_hook != (gdb_debug_hook *) NULL && !user_mode(regs) &&
+			kgdb_hwbreak_sstep[smp_processor_id()]) {
+			kgdb_hwbreak_sstep[smp_processor_id()] = 0;
+			regs->cr_ipsr &= ~IA64_PSR_SS;
+			return;
+		}
+#endif
 	      case 29: /* Debug */
+		CHK_DEBUGGER(vector, SIGTRAP, isr, regs, return);
 	      case 35: /* Taken Branch Trap */
-	      case 36: /* Single Step Trap */
 		if (fsys_mode(current, regs)) {
 			extern char __kernel_syscall_via_break[];
 			/*
@@ -604,6 +627,7 @@ ia64_fault (unsigned long vector, unsign
 		sprintf(buf, "Fault %lu", vector);
 		break;
 	}
+	CHK_DEBUGGER(vector, SIGTRAP, isr, regs,);
 	die_if_kernel(buf, regs, error);
 	force_sig(SIGILL, current);
 }
diff -puN arch/ia64/kernel/unwind.c~ia64-lite arch/ia64/kernel/unwind.c
--- linux-2.6.10-rc1/arch/ia64/kernel/unwind.c~ia64-lite	2004-10-29 11:26:45.502204465 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/kernel/unwind.c	2004-10-29 11:26:45.522199770 -0700
@@ -74,10 +74,68 @@
 # define STAT(x...)
 #endif
 
+#ifdef	CONFIG_KGDB
+#define	KGDB_EARLY_SIZE	100
+static struct unw_reg_state __initdata kgdb_reg_state[KGDB_EARLY_SIZE];
+static struct unw_labeled_state __initdata kgdb_labeled_state[KGDB_EARLY_SIZE];
+void __initdata *kgdb_reg_state_free, __initdata *kgdb_labeled_state_free;
+
+static void __init
+kgdb_malloc_init(void)
+{
+	int i;
+
+	kgdb_reg_state_free = kgdb_reg_state;
+	for (i = 1; i < KGDB_EARLY_SIZE; i++) {
+		*((unsigned long *) &kgdb_reg_state[i]) = (unsigned long) kgdb_reg_state_free;
+		kgdb_reg_state_free = &kgdb_reg_state[i];
+	}
+
+	kgdb_labeled_state_free = kgdb_labeled_state;
+	for (i = 1; i < KGDB_EARLY_SIZE; i++) {
+		*((unsigned long *) &kgdb_labeled_state[i]) =
+			(unsigned long) kgdb_labeled_state_free;
+		kgdb_labeled_state_free = &kgdb_labeled_state[i];
+	}
+
+}
+
+static void * __init
+kgdb_malloc(void **mem)
+{
+	void *p;
+
+	p = *mem;
+	*mem = *((void **) p);
+	return p;
+}
+
+static void __init
+kgdb_free(void **mem, void *p)
+{
+	*((void **)p) = *mem;
+	*mem = p;
+}
+
+#define alloc_reg_state()	(!malloc_sizes[0].cs_cachep ? 		\
+		kgdb_malloc(&kgdb_reg_state_free) : 			\
+		kmalloc(sizeof(struct unw_reg_state), GFP_ATOMIC))
+#define free_reg_state(usr)	(!malloc_sizes[0].cs_cachep ?		\
+		kgdb_free(&kgdb_reg_state_free, usr) :			\
+		kfree(usr))
+#define alloc_labeled_state()	(!malloc_sizes[0].cs_cachep ?		\
+		kgdb_malloc(&kgdb_labeled_state_free) :			\
+		kmalloc(sizeof(struct unw_labeled_state), GFP_ATOMIC))
+#define free_labeled_state(usr)	(!malloc_sizes[0].cs_cachep ?		\
+		kgdb_free(&kgdb_labeled_state_free, usr) :		\
+		kfree(usr))
+
+#else
 #define alloc_reg_state()	kmalloc(sizeof(struct unw_reg_state), GFP_ATOMIC)
 #define free_reg_state(usr)	kfree(usr)
 #define alloc_labeled_state()	kmalloc(sizeof(struct unw_labeled_state), GFP_ATOMIC)
 #define free_labeled_state(usr)	kfree(usr)
+#endif
 
 typedef unsigned long unw_word;
 typedef unsigned char unw_hash_index_t;
@@ -2261,6 +2319,9 @@ unw_init (void)
 
 	init_unwind_table(&unw.kernel_table, "kernel", KERNEL_START, (unsigned long) __gp,
 			  __start_unwind, __end_unwind);
+#ifdef	CONFIG_KGDB
+	kgdb_malloc_init();
+#endif
 }
 
 /*
diff -puN arch/ia64/mm/fault.c~ia64-lite arch/ia64/mm/fault.c
--- linux-2.6.10-rc1/arch/ia64/mm/fault.c~ia64-lite	2004-10-29 11:26:45.504203995 -0700
+++ linux-2.6.10-rc1-trini/arch/ia64/mm/fault.c	2004-10-29 11:26:45.522199770 -0700
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
+#include <linux/kgdb.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -232,6 +233,8 @@ ia64_do_page_fault (unsigned long addres
 	 */
 	bust_spinlocks(1);
 
+	CHK_DEBUGGER(14, SIGSEGV, isr, regs,);
+
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference (address %016lx)\n", address);
 	else
diff -puN drivers/firmware/pcdp.c~ia64-lite drivers/firmware/pcdp.c
--- linux-2.6.10-rc1/drivers/firmware/pcdp.c~ia64-lite	2004-10-29 11:26:45.506203526 -0700
+++ linux-2.6.10-rc1-trini/drivers/firmware/pcdp.c	2004-10-29 11:26:45.523199535 -0700
@@ -56,7 +56,11 @@ uart_edge_level(int rev, struct pcdp_uar
 }
 
 static void __init
+#ifndef	CONFIG_KGDB
 setup_serial_console(int rev, struct pcdp_uart *uart)
+#else
+setup_serial_console(int rev, struct pcdp_uart *uart, int line)
+#endif
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	struct uart_port port;
@@ -64,6 +68,9 @@ setup_serial_console(int rev, struct pcd
 	int mapsize = 64;
 
 	memset(&port, 0, sizeof(port));
+#ifdef	CONFIG_KGDB
+	port.line = line;
+#endif
 	port.uartclk = uart->clock_rate;
 	if (!port.uartclk)	/* some FW doesn't supply this */
 		port.uartclk = BASE_BAUD * 16;
@@ -110,6 +117,9 @@ setup_serial_console(int rev, struct pcd
 
 	snprintf(options, sizeof(options), "%lun%d", uart->baud,
 		uart->bits ? uart->bits : 8);
+#ifdef	CONFIG_KGDB
+	if (!line)
+#endif
 	add_preferred_console("ttyS", port.line, options);
 
 	printk(KERN_INFO "PCDP: serial console at %s 0x%lx (ttyS%d, options %s)\n",
@@ -156,10 +166,19 @@ efi_setup_pcdp_console(char *cmdline)
 	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
 		if (uart->flags & PCDP_UART_PRIMARY_CONSOLE || serial) {
 			if (uart->type == PCDP_CONSOLE_UART) {
+#ifndef	CONFIG_KGDB
 				setup_serial_console(pcdp->rev, uart);
 				return;
+#else
+				setup_serial_console(pcdp->rev, uart, 0);
+				serial = 0;
+#endif
 			}
 		}
+#ifdef	CONFIG_KGDB
+		else if (uart->type == PCDP_DEBUG_UART)
+				setup_serial_console(pcdp->rev, uart, 1);
+#endif
 	}
 
 	end = (struct pcdp_device *) ((u8 *) pcdp + pcdp->length);
diff -puN /dev/null include/asm-ia64/kgdb.h
--- /dev/null	2004-10-25 00:35:20.587727328 -0700
+++ linux-2.6.10-rc1-trini/include/asm-ia64/kgdb.h	2004-10-29 11:26:45.523199535 -0700
@@ -0,0 +1,34 @@
+#ifndef _ASM_KGDB_H_
+#define _ASM_KGDB_H_
+
+/*
+ * Copyright (C) 2001-2004 Amit S. Kale
+ */
+
+#include <linux/ptrace.h>
+
+/************************************************************************/
+/* BUFMAX defines the maximum number of characters in inbound/outbound buffers*/
+/* at least NUMREGBYTES*2 are needed for register packets */
+/* Longer buffer is needed to list all threads */
+#define BUFMAX 1024
+
+/* Number of bytes of registers.  */
+#define NUMREGBYTES 0
+
+#define BREAKNUM        0x00003333300LL
+#define KGDBBREAKNUM    0x6665UL
+
+extern volatile int kgdb_hwbreak_sstep[NR_CPUS];
+
+#define BREAKPOINT() asm volatile ("break.m 0x6665")
+#define BREAK_INSTR_SIZE       16
+
+#define CHECK_EXCEPTION_STACK() 	1
+
+#define	SERIAL_PORT_DFNS	{0,}, {0,}, {0,}, {0,}
+
+extern void smp_send_nmi_allbutself(void);
+extern void kgdb_wait_ipi(struct pt_regs *);
+
+#endif				/* _ASM_KGDB_H_ */
diff -puN lib/Kconfig.debug~ia64-lite lib/Kconfig.debug
--- linux-2.6.10-rc1/lib/Kconfig.debug~ia64-lite	2004-10-29 11:26:45.510202587 -0700
+++ linux-2.6.10-rc1-trini/lib/Kconfig.debug	2004-10-29 11:32:55.162382599 -0700
@@ -115,7 +115,7 @@ endif
 
 config KGDB
 	bool "KGDB: kernel debugging with remote gdb"
-	depends on DEBUG_KERNEL && (X86 || MIPS32 || ((!SMP || BROKEN) && PPC32))
+	depends on DEBUG_KERNEL && (X86 || MIPS32 || IA64 || ((!SMP || BROKEN) && PPC32))
 	help
 	  If you say Y here, it will be possible to remotely debug the
 	  kernel using gdb. This enlarges your kernel image disk size by
_
