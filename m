Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVHYWFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVHYWFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVHYWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:05:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58338 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964918AbVHYWEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:04:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 4/7] spufs: spu-side context switch code
Date: Fri, 26 Aug 2005 00:04:28 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508260004.29161.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the source code that is used to generate spu_save_dump.h and
spu_restore_dump.h. Since a full spu tool chain is needed to
generate these files, the default remains to use the shipped
versions in order to keep the number of tools for building the
kernel down.

From: Mark Nutter: <mnutter@us.ibm.com>
Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--

 Makefile           |   46 +++++++
 spu_restore.c      |  336 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 spu_restore_crt0.S |  116 ++++++++++++++++++
 spu_save.c         |  203 ++++++++++++++++++++++++++++++++
 spu_save_crt0.S    |  102 ++++++++++++++++
 spu_utils.h        |  160 +++++++++++++++++++++++++
 6 files changed, 963 insertions(+)

--- linux-cg.orig/fs/spufs/Makefile	2005-08-16 20:11:10.396001984 -0400
+++ linux-cg/fs/spufs/Makefile	2005-08-16 20:11:43.730998928 -0400
@@ -2,4 +2,50 @@ obj-$(CONFIG_SPU_FS) += spufs.o
 
 spufs-y += inode.o file.o context.o switch.o
 
+# Rules to build switch.o with the help of SPU tool chain
+SPU_CROSS	:= spu-
+SPU_CC		:= $(SPU_CROSS)gcc
+SPU_AS		:= $(SPU_CROSS)gcc
+SPU_LD		:= $(SPU_CROSS)ld
+SPU_READELF	:= $(SPU_CROSS)readelf
+SPU_CFLAGS	:= -O2 -Wall -I$(srctree)/include -I$(objtree)/include2
+SPU_AFLAGS	:= -c -D__ASSEMBLY__ -I$(srctree)/include -I$(objtree)/include2
+SPU_LDFLAGS	:= -N -Ttext=0x0
+
 $(obj)/switch.o: $(obj)/spu_save_dump.h $(obj)/spu_restore_dump.h
+
+# Compile SPU files
+      cmd_spu_cc = $(SPU_CC) $(SPU_CFLAGS) -c -o $@ $<
+quiet_cmd_spu_cc = SPU_CC  $@
+$(obj)/spu_%.o: $(src)/spu_%.c
+	$(call if_changed,spu_cc)
+
+# Assemble SPU files
+      cmd_spu_as = $(SPU_AS) $(SPU_AFLAGS) -o $@ $<
+quiet_cmd_spu_as = SPU_AS  $@
+$(obj)/spu_%.o: $(src)/spu_%.S
+	$(call if_changed,spu_as)
+
+# Link SPU Executables
+      cmd_spu_ld = $(SPU_LD) $(SPU_LDFLAGS) -o $@ $^
+quiet_cmd_spu_ld = SPU_LD  $@
+$(obj)/spu_%: $(obj)/spu_%.o $(obj)/spu_%_crt0.o
+	$(call if_changed,spu_ld)
+
+# create C code from ELF executable
+cmd_hexdump   = ( \
+		echo "/*" ; \
+		echo " * $@: Copyright (C) 2005 IBM." ; \
+		echo " * Hex-dump auto generated from $<.c." ; \
+		echo " * Do not edit!" ; \
+		echo " */" ; \
+		echo "static unsigned int $*_code[] __page_aligned = {" ; \
+		$(SPU_READELF) -x1 -x2 $< | \
+		grep -v "Hex dump of section" | \
+		grep -v "^$$" | \
+		$(AWK) -- '{ print "0x"$$2", 0x"$$3", 0x"$$4", 0x"$$5", " }' ; \
+		echo "};" ; \
+		) > $@
+quiet_cmd_hexdump = HEXDUMP $@
+$(obj)/%_dump.h: $(obj)/%
+	$(call if_changed,hexdump)
--- linux-cg.orig/fs/spufs/spu_restore.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spu_restore.c	2005-08-16 20:11:43.737997864 -0400
@@ -0,0 +1,336 @@
+/*
+ * spu_restore.c
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * SPU-side context restore sequence outlined in
+ * Synergistic Processor Element Book IV
+ *
+ * Author: Mark Nutter <mnutter@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+
+#ifndef LS_SIZE
+#define LS_SIZE                 0x40000	/* 256K (in bytes) */
+#endif
+
+typedef unsigned int u32;
+typedef unsigned long long u64;
+
+#include <spu_intrinsics.h>
+#include <asm/spu_csa.h>
+#include "spu_utils.h"
+
+#define BR_INSTR		0x327fff80	/* br -4         */
+#define NOP_INSTR		0x40200000	/* nop           */
+#define HEQ_INSTR		0x7b000000	/* heq $0, $0    */
+#define STOP_INSTR		0x00000000	/* stop 0x0      */
+#define ILLEGAL_INSTR		0x00800000	/* illegal instr */
+#define RESTORE_COMPLETE	0x00003ffc	/* stop 0x3ffc   */
+
+static inline void fetch_regs_from_mem(addr64 lscsa_ea)
+{
+	unsigned int ls = (unsigned int)&regs_spill[0];
+	unsigned int size = sizeof(regs_spill);
+	unsigned int tag_id = 0;
+	unsigned int cmd = 0x40;	/* GET */
+
+	spu_writech(mfc_ls_addr, ls);
+	spu_writech(mfc_ea_hi, lscsa_ea.ui[0]);
+	spu_writech(mfc_ea_low, lscsa_ea.ui[1]);
+	spu_writech(mfc_dma_size, size);
+	spu_writech(mfc_tag_id, tag_id);
+	spu_writech(mfc_cmd_queue, cmd);
+}
+
+static inline void restore_upper_240kb(addr64 lscsa_ea)
+{
+	unsigned int ls = 16384;
+	unsigned int list = (unsigned int)&dma_list[0];
+	unsigned int size = sizeof(dma_list);
+	unsigned int tag_id = 0;
+	unsigned int cmd = 0x44;	/* GETL */
+
+	/* Restore, Step 4:
+	 *    Enqueue the GETL command (tag 0) to the MFC SPU command
+	 *    queue to transfer the upper 240 kb of LS from CSA.
+	 */
+	spu_writech(mfc_ls_addr, ls);
+	spu_writech(mfc_ea_hi, lscsa_ea.ui[0]);
+	spu_writech(mfc_ea_low, list);
+	spu_writech(mfc_dma_size, size);
+	spu_writech(mfc_tag_id, tag_id);
+	spu_writech(mfc_cmd_queue, cmd);
+}
+
+static inline void restore_decr(void)
+{
+	unsigned int offset;
+	unsigned int decr_running;
+	unsigned int decr;
+
+	/* Restore, Step 6:
+	 *    If the LSCSA "decrementer running" flag is set
+	 *    then write the SPU_WrDec channel with the
+	 *    decrementer value from LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(decr_status);
+	decr_running = regs_spill[offset].slot[0];
+	if (decr_running) {
+		offset = LSCSA_QW_OFFSET(decr);
+		decr = regs_spill[offset].slot[0];
+		spu_writech(spu_wr_decr_count, decr);
+	}
+}
+
+static inline void write_ppu_mb(void)
+{
+	unsigned int offset;
+	unsigned int data;
+
+	/* Restore, Step 11:
+	 *    Write the MFC_WrOut_MB channel with the PPU_MB
+	 *    data from LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(ppu_mb);
+	data = regs_spill[offset].slot[0];
+	spu_writech(mfc_wr_mailbox, data);
+}
+
+static inline void write_ppuint_mb(void)
+{
+	unsigned int offset;
+	unsigned int data;
+
+	/* Restore, Step 12:
+	 *    Write the MFC_WrInt_MB channel with the PPUINT_MB
+	 *    data from LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(ppuint_mb);
+	data = regs_spill[offset].slot[0];
+	spu_writech(mfc_wr_intr_mailbox, data);
+}
+
+static inline void restore_fpcr(void)
+{
+	unsigned int offset;
+	vector unsigned int fpcr;
+
+	/* Restore, Step 13:
+	 *    Restore the floating-point status and control
+	 *    register from the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(fpcr);
+	fpcr = regs_spill[offset].v;
+	spu_mtfpscr(fpcr);
+}
+
+static inline void restore_srr0(void)
+{
+	unsigned int offset;
+	unsigned int srr0;
+
+	/* Restore, Step 14:
+	 *    Restore the SPU SRR0 data from the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(srr0);
+	srr0 = regs_spill[offset].slot[0];
+	spu_writech(spu_wr_srr0, srr0);
+}
+
+static inline void restore_event_mask(void)
+{
+	unsigned int offset;
+	unsigned int event_mask;
+
+	/* Restore, Step 15:
+	 *    Restore the SPU_RdEventMsk data from the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(event_mask);
+	event_mask = regs_spill[offset].slot[0];
+	spu_writech(spu_wr_event_mask, event_mask);
+}
+
+static inline void restore_tag_mask(void)
+{
+	unsigned int offset;
+	unsigned int tag_mask;
+
+	/* Restore, Step 16:
+	 *    Restore the SPU_RdTagMsk data from the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(tag_mask);
+	tag_mask = regs_spill[offset].slot[0];
+	spu_writech(mfc_wr_tag_mask, tag_mask);
+}
+
+static inline void restore_complete(void)
+{
+	extern void exit_fini(void);
+	unsigned int *exit_instrs = (unsigned int *)exit_fini;
+	unsigned int offset;
+	unsigned int stopped_status;
+	unsigned int stopped_code;
+
+	/* Restore, Step 18:
+	 *    Issue a stop-and-signal instruction with
+	 *    "good context restore" signal value.
+	 *
+	 * Restore, Step 19:
+	 *    There may be additional instructions placed
+	 *    here by the PPE Sequence for SPU Context
+	 *    Restore in order to restore the correct
+	 *    "stopped state".
+	 *
+	 *    This step is handled here by analyzing the
+	 *    LSCSA.stopped_status and then modifying the
+	 *    exit() function to behave appropriately.
+	 */
+
+	offset = LSCSA_QW_OFFSET(stopped_status);
+	stopped_status = regs_spill[offset].slot[0];
+	stopped_code = regs_spill[offset].slot[1];
+
+	switch (stopped_status) {
+	case SPU_STOPPED_STATUS_P_I:
+		/* SPU_Status[P,I]=1.  Add illegal instruction
+		 * followed by stop-and-signal instruction after
+		 * end of restore code.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = ILLEGAL_INSTR;
+		exit_instrs[2] = STOP_INSTR | stopped_code;
+		break;
+	case SPU_STOPPED_STATUS_P_H:
+		/* SPU_Status[P,H]=1.  Add 'heq $0, $0' followed
+		 * by stop-and-signal instruction after end of
+		 * restore code.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = HEQ_INSTR;
+		exit_instrs[2] = STOP_INSTR | stopped_code;
+		break;
+	case SPU_STOPPED_STATUS_S_P:
+		/* SPU_Status[S,P]=1.  Add nop instruction
+		 * followed by 'br -4' after end of restore
+		 * code.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = STOP_INSTR | stopped_code;
+		exit_instrs[2] = NOP_INSTR;
+		exit_instrs[3] = BR_INSTR;
+		break;
+	case SPU_STOPPED_STATUS_S_I:
+		/* SPU_Status[S,I]=1.  Add  illegal instruction
+		 * followed by 'br -4' after end of restore code.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = ILLEGAL_INSTR;
+		exit_instrs[2] = NOP_INSTR;
+		exit_instrs[3] = BR_INSTR;
+		break;
+	case SPU_STOPPED_STATUS_I:
+		/* SPU_Status[I]=1. Add illegal instruction followed
+		 * by infinite loop after end of restore sequence.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = ILLEGAL_INSTR;
+		exit_instrs[2] = NOP_INSTR;
+		exit_instrs[3] = BR_INSTR;
+		break;
+	case SPU_STOPPED_STATUS_S:
+		/* SPU_Status[S]=1. Add two 'nop' instructions. */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = NOP_INSTR;
+		exit_instrs[2] = NOP_INSTR;
+		exit_instrs[3] = BR_INSTR;
+		break;
+	case SPU_STOPPED_STATUS_H:
+		/* SPU_Status[H]=1. Add 'heq $0, $0' instruction
+		 * after end of restore code.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = HEQ_INSTR;
+		exit_instrs[2] = NOP_INSTR;
+		exit_instrs[3] = BR_INSTR;
+		break;
+	case SPU_STOPPED_STATUS_P:
+		/* SPU_Status[P]=1. Add stop-and-signal instruction
+		 * after end of restore code.
+		 */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = STOP_INSTR | stopped_code;
+		break;
+	case SPU_STOPPED_STATUS_R:
+		/* SPU_Status[I,S,H,P,R]=0. Add infinite loop. */
+		exit_instrs[0] = RESTORE_COMPLETE;
+		exit_instrs[1] = NOP_INSTR;
+		exit_instrs[2] = NOP_INSTR;
+		exit_instrs[3] = BR_INSTR;
+		break;
+	default:
+		/* SPU_Status[R]=1. No additonal instructions. */
+		break;
+	}
+	spu_sync();
+}
+
+/**
+ * main - entry point for SPU-side context restore.
+ *
+ * This code deviates from the documented sequence in the
+ * following aspects:
+ *
+ * 	1. The EA for LSCSA is passed from PPE in the
+ *	   signal notification channels.
+ *	2. The register spill area is pulled by SPU
+ *	   into LS, rather than pushed by PPE.
+ *	3. All 128 registers are restored by exit().
+ *	4. The exit() function is modified at run
+ *	   time in order to properly restore the
+ *	   SPU_Status register.
+ */
+int main()
+{
+	addr64 lscsa_ea;
+
+	lscsa_ea.ui[0] = spu_readch(mfc_rd_signal_1);
+	lscsa_ea.ui[1] = spu_readch(mfc_rd_signal_2);
+	fetch_regs_from_mem(lscsa_ea);
+
+	set_event_mask();		/* Step 1.  */
+	set_tag_mask();			/* Step 2.  */
+	build_dma_list(lscsa_ea);	/* Step 3.  */
+	restore_upper_240kb(lscsa_ea);	/* Step 4.  */
+					/* Step 5: done by 'exit'. */
+	restore_decr();			/* Step 6. */
+	enqueue_putllc(lscsa_ea);	/* Step 7. */
+	set_tag_update();		/* Step 8. */
+	read_tag_status();		/* Step 9. */
+	read_llar_status();		/* Step 10. */
+	write_ppu_mb();			/* Step 11. */
+	write_ppuint_mb();		/* Step 12. */
+	restore_fpcr();			/* Step 13. */
+	restore_srr0();			/* Step 14. */
+	restore_event_mask();		/* Step 15. */
+	restore_tag_mask();		/* Step 16. */
+					/* Step 17. done by 'exit'. */
+	restore_complete();		/* Step 18. */
+
+	return 0;
+}
--- linux-cg.orig/fs/spufs/spu_restore_crt0.S	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spu_restore_crt0.S	2005-08-16 20:11:43.737997864 -0400
@@ -0,0 +1,116 @@
+/*
+ * crt0_r.S: Entry function for SPU-side context restore.
+ *
+ * Copyright (C) 2005 IBM
+ *
+ * Entry and exit function for SPU-side of the context restore
+ * sequence.  Sets up an initial stack frame, then branches to
+ * 'main'.  On return, restores all 128 registers from the LSCSA
+ * and exits.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/spu_csa.h>
+
+.data
+.align 7
+.globl regs_spill
+regs_spill:
+.space SIZEOF_SPU_SPILL_REGS, 0x0
+
+.text
+.global _start
+_start:
+	/* Initialize the stack pointer to point to 16368
+	 * (16kb-16). The back chain pointer is initialized
+	 * to NULL.
+	 */
+	il      $0, 0
+	il      $SP, 16368
+	stqd    $0, 0($SP)
+
+	/* Allocate a minimum stack frame for the called main.
+	 * This is needed so that main has a place to save the
+	 * link register when it calls another function.
+	 */
+	stqd    $SP, -160($SP)
+	ai      $SP, $SP, -160
+
+	/* Call the program's main function. */
+	brsl    $0, main
+
+.global exit
+.global	_exit
+exit:		
+_exit:		
+	/* SPU Context Restore, Step 5: Restore the remaining 112 GPRs. */
+	ila     $3, regs_spill + 256
+restore_regs:
+	lqr     $4, restore_reg_insts
+restore_reg_loop:
+	ai      $4, $4, 4
+	.balignl 16, 0x40200000
+restore_reg_insts:       /* must be quad-word aligned. */
+	lqd     $16, 0($3)
+	lqd     $17, 16($3)
+	lqd     $18, 32($3)
+	lqd     $19, 48($3)
+	andi    $5, $4, 0x7F
+	stqr    $4, restore_reg_insts
+	ai      $3, $3, 64
+	brnz    $5, restore_reg_loop
+
+	/* SPU Context Restore Step 17: Restore the first 16 GPRs. */
+	lqa $0, regs_spill + 0
+	lqa $1, regs_spill + 16
+	lqa $2, regs_spill + 32
+	lqa $3, regs_spill + 48
+	lqa $4, regs_spill + 64
+	lqa $5, regs_spill + 80
+	lqa $6, regs_spill + 96
+	lqa $7, regs_spill + 112
+	lqa $8, regs_spill + 128
+	lqa $9, regs_spill + 144
+	lqa $10, regs_spill + 160
+	lqa $11, regs_spill + 176
+	lqa $12, regs_spill + 192
+	lqa $13, regs_spill + 208
+	lqa $14, regs_spill + 224
+	lqa $15, regs_spill + 240
+
+	/* Under normal circumstances, the 'exit' function
+	 * terminates with 'stop SPU_RESTORE_COMPLETE',
+	 * indicating that the SPU-side restore code has
+	 * completed.
+	 *
+	 * However it is possible that instructions immediately
+	 * following the 'stop 0x3ffc' have been modified at run
+	 * time so as to recreate the exact SPU_Status settings
+	 * from the application, e.g. illegal instruciton, halt,
+	 * etc.
+	 */
+.global exit_fini
+.global	_exit_fini
+exit_fini:		
+_exit_fini:		
+	stop	SPU_RESTORE_COMPLETE
+	stop	0
+	stop	0
+	stop	0
+
+	/* Pad the size of this crt0.o to be multiple of 16 bytes. */
+.balignl 16, 0x0
--- linux-cg.orig/fs/spufs/spu_save.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spu_save.c	2005-08-16 20:11:43.741997256 -0400
@@ -0,0 +1,203 @@
+/*
+ * spu_save.c
+ *
+ * (C) Copyright IBM Corp. 2005
+ *
+ * SPU-side context save sequence outlined in
+ * Synergistic Processor Element Book IV
+ *
+ * Author: Mark Nutter <mnutter@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+
+#ifndef LS_SIZE
+#define LS_SIZE                 0x40000	/* 256K (in bytes) */
+#endif
+
+typedef unsigned int u32;
+typedef unsigned long long u64;
+
+#include <spu_intrinsics.h>
+#include <asm/spu_csa.h>
+#include "spu_utils.h"
+
+/* Hack! These two are not present in old DD1 spu_intrinsics.h!  */
+#ifndef spu_rd_event_mask
+#define spu_rd_event_mask 11
+#endif
+#ifndef mfc_rd_tag_mask
+#define mfc_rd_tag_mask 12
+#endif
+
+static inline void save_event_mask(void)
+{
+	unsigned int offset;
+
+	/* Save, Step 2:
+	 *    Read the SPU_RdEventMsk channel and save to the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(event_mask);
+	regs_spill[offset].slot[0] = spu_readch(spu_rd_event_mask);
+}
+
+static inline void save_tag_mask(void)
+{
+	unsigned int offset;
+
+	/* Save, Step 3:
+	 *    Read the SPU_RdTagMsk channel and save to the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(tag_mask);
+	regs_spill[offset].slot[0] = spu_readch(mfc_rd_tag_mask);
+}
+
+static inline void save_upper_240kb(addr64 lscsa_ea)
+{
+	unsigned int ls = 16384;
+	unsigned int list = (unsigned int)&dma_list[0];
+	unsigned int size = sizeof(dma_list);
+	unsigned int tag_id = 0;
+	unsigned int cmd = 0x24;	/* PUTL */
+
+	/* Save, Step 7:
+	 *    Enqueue the PUTL command (tag 0) to the MFC SPU command
+	 *    queue to transfer the remaining 240 kb of LS to CSA.
+	 */
+	spu_writech(mfc_ls_addr, ls);
+	spu_writech(mfc_ea_hi, lscsa_ea.ui[0]);
+	spu_writech(mfc_ea_low, list);
+	spu_writech(mfc_dma_size, size);
+	spu_writech(mfc_tag_id, tag_id);
+	spu_writech(mfc_cmd_queue, cmd);
+}
+
+static inline void save_fpcr(void)
+{
+	// vector unsigned int fpcr;
+	unsigned int offset;
+
+	/* Save, Step 9:
+	 *    Issue the floating-point status and control register
+	 *    read instruction, and save to the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(fpcr);
+	regs_spill[offset].v = spu_mffpscr();
+}
+
+static inline void save_decr(void)
+{
+	unsigned int offset;
+
+	/* Save, Step 10:
+	 *    Read and save the SPU_RdDec channel data to
+	 *    the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(decr);
+	regs_spill[offset].slot[0] = spu_readch(spu_rd_decr_count);
+}
+
+static inline void save_srr0(void)
+{
+	unsigned int offset;
+
+	/* Save, Step 11:
+	 *    Read and save the SPU_WSRR0 channel data to
+	 *    the LSCSA.
+	 */
+	offset = LSCSA_QW_OFFSET(srr0);
+	regs_spill[offset].slot[0] = spu_readch(spu_rd_srr0);
+}
+
+static inline void spill_regs_to_mem(addr64 lscsa_ea)
+{
+	unsigned int ls = (unsigned int)&regs_spill[0];
+	unsigned int size = sizeof(regs_spill);
+	unsigned int tag_id = 0;
+	unsigned int cmd = 0x20;	/* PUT */
+
+	/* Save, Step 13:
+	 *    Enqueue a PUT command (tag 0) to send the LSCSA
+	 *    to the CSA.
+	 */
+	spu_writech(mfc_ls_addr, ls);
+	spu_writech(mfc_ea_hi, lscsa_ea.ui[0]);
+	spu_writech(mfc_ea_low, lscsa_ea.ui[1]);
+	spu_writech(mfc_dma_size, size);
+	spu_writech(mfc_tag_id, tag_id);
+	spu_writech(mfc_cmd_queue, cmd);
+}
+
+static inline void enqueue_sync(addr64 lscsa_ea)
+{
+	unsigned int tag_id = 0;
+	unsigned int cmd = 0xCC;
+
+	/* Save, Step 14:
+	 *    Enqueue an MFC_SYNC command (tag 0).
+	 */
+	spu_writech(mfc_tag_id, tag_id);
+	spu_writech(mfc_cmd_queue, cmd);
+}
+
+static inline void save_complete(void)
+{
+	/* Save, Step 18:
+	 *    Issue a stop-and-signal instruction indicating
+	 *    "save complete".  Note: This function will not
+	 *    return!!
+	 */
+	spu_stop(SPU_SAVE_COMPLETE);
+}
+
+/**
+ * main - entry point for SPU-side context save.
+ *
+ * This code deviates from the documented sequence as follows:
+ *
+ *      1. The EA for LSCSA is passed from PPE in the
+ *         signal notification channels.
+ *      2. All 128 registers are saved by crt0.o.
+ */
+int main()
+{
+	addr64 lscsa_ea;
+
+	lscsa_ea.ui[0] = spu_readch(mfc_rd_signal_1);
+	lscsa_ea.ui[1] = spu_readch(mfc_rd_signal_2);
+
+	/* Step 1: done by exit(). */
+	save_event_mask();	/* Step 2.  */
+	save_tag_mask();	/* Step 3.  */
+	set_event_mask();	/* Step 4.  */
+	set_tag_mask();		/* Step 5.  */
+	build_dma_list(lscsa_ea);	/* Step 6.  */
+	save_upper_240kb(lscsa_ea);	/* Step 7.  */
+	/* Step 8: done by exit(). */
+	save_fpcr();		/* Step 9.  */
+	save_decr();		/* Step 10. */
+	save_srr0();		/* Step 11. */
+	enqueue_putllc(lscsa_ea);	/* Step 12. */
+	spill_regs_to_mem(lscsa_ea);	/* Step 13. */
+	enqueue_sync(lscsa_ea);	/* Step 14. */
+	set_tag_update();	/* Step 15. */
+	read_tag_status();	/* Step 16. */
+	read_llar_status();	/* Step 17. */
+	save_complete();	/* Step 18. */
+
+	return 0;
+}
--- linux-cg.orig/fs/spufs/spu_save_crt0.S	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spu_save_crt0.S	2005-08-16 20:11:43.742997104 -0400
@@ -0,0 +1,102 @@
+/*
+ * crt0_s.S: Entry function for SPU-side context save.
+ *
+ * Copyright (C) 2005 IBM
+ *
+ * Entry function for SPU-side of the context save sequence.
+ * Saves all 128 GPRs, sets up an initial stack frame, then
+ * branches to 'main'.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <asm/spu_csa.h>
+
+.data
+.align 7
+.globl regs_spill
+regs_spill:
+.space SIZEOF_SPU_SPILL_REGS, 0x0
+
+.text
+.global _start
+_start:
+	/* SPU Context Save Step 1: Save the first 16 GPRs. */
+	stqa $0, regs_spill + 0
+	stqa $1, regs_spill + 16
+	stqa $2, regs_spill + 32
+	stqa $3, regs_spill + 48
+	stqa $4, regs_spill + 64
+	stqa $5, regs_spill + 80
+	stqa $6, regs_spill + 96
+	stqa $7, regs_spill + 112
+	stqa $8, regs_spill + 128
+	stqa $9, regs_spill + 144
+	stqa $10, regs_spill + 160
+	stqa $11, regs_spill + 176
+	stqa $12, regs_spill + 192
+	stqa $13, regs_spill + 208
+	stqa $14, regs_spill + 224
+	stqa $15, regs_spill + 240
+
+	/* SPU Context Save, Step 8: Save the remaining 112 GPRs. */
+	ila     $3, regs_spill + 256
+save_regs:
+	lqr     $4, save_reg_insts
+save_reg_loop:
+	ai      $4, $4, 4
+	.balignl 16, 0x40200000
+save_reg_insts:       /* must be quad-word aligned. */
+	stqd    $16, 0($3)
+	stqd    $17, 16($3)
+	stqd    $18, 32($3)
+	stqd    $19, 48($3)
+	andi    $5, $4, 0x7F
+	stqr    $4, save_reg_insts
+	ai      $3, $3, 64
+	brnz    $5, save_reg_loop
+
+	/* Initialize the stack pointer to point to 16368
+	 * (16kb-16). The back chain pointer is initialized
+	 * to NULL.
+	 */
+	il	$0, 0
+	il	$SP, 16368
+	stqd	$0, 0($SP)
+	
+	/* Allocate a minimum stack frame for the called main.
+	 * This is needed so that main has a place to save the
+	 * link register when it calls another function.
+	 */
+	stqd	$SP, -160($SP)
+	ai	$SP, $SP, -160
+	
+	/* Call the program's main function. */
+	brsl	$0, main
+
+	/* In this case main should not return; if it does
+	 * there has been an error in the sequence.  Execute
+	 * stop-and-signal with code=0.
+	 */
+.global exit
+.global	_exit
+exit:		
+_exit:		
+	stop	0x0
+	
+	/* Pad the size of this crt0.o to be multiple of 16 bytes. */
+.balignl 16, 0x0
+
--- linux-cg.orig/fs/spufs/spu_utils.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/fs/spufs/spu_utils.h	2005-08-16 20:11:43.745996648 -0400
@@ -0,0 +1,160 @@
+/*
+ * utils.h: Utilities for SPU-side of the context switch operation.
+ *
+ * (C) Copyright IBM 2005
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _SPU_CONTEXT_UTILS_H_
+#define _SPU_CONTEXT_UTILS_H_
+
+/*
+ * 64-bit safe EA.
+ */
+typedef union {
+	unsigned long long ull;
+	unsigned int ui[2];
+} addr64;
+
+/*
+ * 128-bit register template.
+ */
+typedef union {
+	unsigned int slot[4];
+	vector unsigned int v;
+} spu_reg128v;
+
+/*
+ * DMA list structure.
+ */
+struct dma_list_elem {
+	unsigned int size;
+	unsigned int ea_low;
+};
+
+/*
+ * Declare storage for 8-byte aligned DMA list.
+ */
+struct dma_list_elem dma_list[15] __attribute__ ((aligned(8)));
+
+/*
+ * External definition for storage
+ * declared in crt0.
+ */
+extern spu_reg128v regs_spill[NR_SPU_SPILL_REGS];
+
+/*
+ * Compute LSCSA byte offset for a given field.
+ */
+static struct spu_lscsa *dummy = (struct spu_lscsa *)0;
+#define LSCSA_BYTE_OFFSET(_field)  \
+	((char *)(&(dummy->_field)) - (char *)(&(dummy->gprs[0].slot[0])))
+#define LSCSA_QW_OFFSET(_field)  (LSCSA_BYTE_OFFSET(_field) >> 4)
+
+static inline void set_event_mask(void)
+{
+	unsigned int event_mask = 0;
+
+	/* Save, Step 4:
+	 * Restore, Step 1:
+	 *    Set the SPU_RdEventMsk channel to zero to mask
+	 *    all events.
+	 */
+	spu_writech(spu_wr_event_mask, event_mask);
+}
+
+static inline void set_tag_mask(void)
+{
+	unsigned int tag_mask = 1;
+
+	/* Save, Step 5:
+	 * Restore, Step 2:
+	 *    Set the SPU_WrTagMsk channel to '01' to unmask
+	 *    only tag group 0.
+	 */
+	spu_writech(mfc_wr_tag_mask, tag_mask);
+}
+
+static inline void build_dma_list(addr64 lscsa_ea)
+{
+	unsigned int ea_low;
+	int i;
+
+	/* Save, Step 6:
+	 * Restore, Step 3:
+	 *    Update the effective address for the CSA in the
+	 *    pre-canned DMA-list in local storage.
+	 */
+	ea_low = lscsa_ea.ui[1];
+	ea_low += LSCSA_BYTE_OFFSET(ls[16384]);
+
+	for (i = 0; i < 15; i++, ea_low += 16384) {
+		dma_list[i].size = 16384;
+		dma_list[i].ea_low = ea_low;
+	}
+}
+
+static inline void enqueue_putllc(addr64 lscsa_ea)
+{
+	unsigned int ls = 0;
+	unsigned int size = 128;
+	unsigned int tag_id = 0;
+	unsigned int cmd = 0xB4;	/* PUTLLC */
+
+	/* Save, Step 12:
+	 * Restore, Step 7:
+	 *    Send a PUTLLC (tag 0) command to the MFC using
+	 *    an effective address in the CSA in order to
+	 *    remove any possible lock-line reservation.
+	 */
+	spu_writech(mfc_ls_addr, ls);
+	spu_writech(mfc_ea_hi, lscsa_ea.ui[0]);
+	spu_writech(mfc_ea_low, lscsa_ea.ui[1]);
+	spu_writech(mfc_dma_size, size);
+	spu_writech(mfc_tag_id, tag_id);
+	spu_writech(mfc_cmd_queue, cmd);
+}
+
+static inline void set_tag_update(void)
+{
+	unsigned int update_any = 1;
+
+	/* Save, Step 15:
+	 * Restore, Step 8:
+	 *    Write the MFC_TagUpdate channel with '01'.
+	 */
+	spu_writech(mfc_wr_tag_update, update_any);
+}
+
+static inline void read_tag_status(void)
+{
+	/* Save, Step 16:
+	 * Restore, Step 9:
+	 *    Read the MFC_TagStat channel data.
+	 */
+	spu_readch(mfc_rd_tag_status);
+}
+
+static inline void read_llar_status(void)
+{
+	/* Save, Step 17:
+	 * Restore, Step 10:
+	 *    Read the MFC_AtomicStat channel data.
+	 */
+	spu_readch(mfc_rd_llar_status);
+}
+
+#endif				/* _SPU_CONTEXT_UTILS_H_ */

