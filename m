Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVJKNR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVJKNR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVJKNR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:17:58 -0400
Received: from mail.renesas.com ([202.234.163.13]:5020 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751134AbVJKNR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:17:58 -0400
Date: Tue, 11 Oct 2005 22:17:53 +0900 (JST)
Message-Id: <20051011.221753.35014553.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org, sugai@isl.melco.co.jp
Subject: [PATCH 2.6.13] m32r: trap handler code for illegal traps
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents illegal traps from causing m32r kernel's infinite loop
execution.

Signed-off-by: Naoto Sugai <sugai@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S |    9 +++++++++
 arch/m32r/kernel/traps.c |   33 ++++++++++++++++-----------------
 2 files changed, 25 insertions(+), 17 deletions(-)

Index: linux-2.6.13/arch/m32r/kernel/traps.c
===================================================================
--- linux-2.6.13.orig/arch/m32r/kernel/traps.c	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13/arch/m32r/kernel/traps.c	2005-10-11 21:39:59.397374352 +0900
@@ -5,8 +5,6 @@
  *                            Hitoshi Yamamoto
  */
 
-/* $Id$ */
-
 /*
  * 'traps.c' handles hardware traps and faults after we have saved some
  * state in 'entry.S'.
@@ -35,6 +33,7 @@ asmlinkage void ei_handler(void);
 asmlinkage void rie_handler(void);
 asmlinkage void debug_trap(void);
 asmlinkage void cache_flushing_handler(void);
+asmlinkage void ill_trap(void);
 
 #ifdef CONFIG_SMP
 extern void smp_reschedule_interrupt(void);
@@ -77,22 +76,22 @@ void	set_eit_vector_entries(void)
 	eit_vector[5] = BRA_INSN(default_eit_handler, 5);
 	eit_vector[8] = BRA_INSN(rie_handler, 8);
 	eit_vector[12] = BRA_INSN(alignment_check, 12);
-	eit_vector[16] = 0xff000000UL;
+	eit_vector[16] = BRA_INSN(ill_trap, 16);
 	eit_vector[17] = BRA_INSN(debug_trap, 17);
 	eit_vector[18] = BRA_INSN(system_call, 18);
-	eit_vector[19] = 0xff000000UL;
-	eit_vector[20] = 0xff000000UL;
-	eit_vector[21] = 0xff000000UL;
-	eit_vector[22] = 0xff000000UL;
-	eit_vector[23] = 0xff000000UL;
-	eit_vector[24] = 0xff000000UL;
-	eit_vector[25] = 0xff000000UL;
-	eit_vector[26] = 0xff000000UL;
-	eit_vector[27] = 0xff000000UL;
+	eit_vector[19] = BRA_INSN(ill_trap, 19);
+	eit_vector[20] = BRA_INSN(ill_trap, 20);
+	eit_vector[21] = BRA_INSN(ill_trap, 21);
+	eit_vector[22] = BRA_INSN(ill_trap, 22);
+	eit_vector[23] = BRA_INSN(ill_trap, 23);
+	eit_vector[24] = BRA_INSN(ill_trap, 24);
+	eit_vector[25] = BRA_INSN(ill_trap, 25);
+	eit_vector[26] = BRA_INSN(ill_trap, 26);
+	eit_vector[27] = BRA_INSN(ill_trap, 27);
 	eit_vector[28] = BRA_INSN(cache_flushing_handler, 28);
-	eit_vector[29] = 0xff000000UL;
-	eit_vector[30] = 0xff000000UL;
-	eit_vector[31] = 0xff000000UL;
+	eit_vector[29] = BRA_INSN(ill_trap, 29);
+	eit_vector[30] = BRA_INSN(ill_trap, 30);
+	eit_vector[31] = BRA_INSN(ill_trap, 31);
 	eit_vector[32] = BRA_INSN(ei_handler, 32);
 	eit_vector[64] = BRA_INSN(pie_handler, 64);
 #ifdef CONFIG_MMU
@@ -286,7 +285,8 @@ asmlinkage void do_##name(struct pt_regs
 
 DO_ERROR( 1, SIGTRAP, "debug trap", debug_trap)
 DO_ERROR_INFO(0x20, SIGILL,  "reserved instruction ", rie_handler, ILL_ILLOPC, regs->bpc)
-DO_ERROR_INFO(0x100, SIGILL,  "privilege instruction", pie_handler, ILL_PRVOPC, regs->bpc)
+DO_ERROR_INFO(0x100, SIGILL,  "privileged instruction", pie_handler, ILL_PRVOPC, regs->bpc)
+DO_ERROR_INFO(-1, SIGILL,  "illegal trap", ill_trap, ILL_ILLTRP, regs->bpc)
 
 extern int handle_unaligned_access(unsigned long, struct pt_regs *);
 
@@ -329,4 +329,3 @@ asmlinkage void do_alignment_check(struc
 		set_fs(oldfs);
 	}
 }
-
Index: linux-2.6.13/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.13.orig/arch/m32r/kernel/entry.S	2005-08-29 08:41:01.000000000 +0900
+++ linux-2.6.13/arch/m32r/kernel/entry.S	2005-10-11 21:00:03.606589912 +0900
@@ -681,6 +681,15 @@ ENTRY(debug_trap)
 	bl	do_debug_trap
 	bra	error_code
 
+ENTRY(ill_trap)
+	/* void ill_trap(void) */
+	SWITCH_TO_KERNEL_STACK
+	SAVE_ALL
+	ldi	r1, #0				; error_code ; FIXME
+	mv	r0, sp				; pt_regs
+	bl	do_ill_trap
+	bra	error_code
+
 
 /* Cache flushing handler */
 ENTRY(cache_flushing_handler)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
