Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265248AbUENLSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUENLSS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUENLSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:18:18 -0400
Received: from ozlabs.org ([203.10.76.45]:13997 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265248AbUENLSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:18:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16548.43760.741791.655701@cargo.ozlabs.ibm.com>
Date: Fri, 14 May 2004 21:18:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Move declarations into headers
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below moves some declarations from C files into the
appropriate header file in include/asm-ppc (and removes an unused
local variable in a function).  Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/kernel/traps.c ppc-2.5/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2004-03-27 11:28:16.000000000 +1100
+++ ppc-2.5/arch/ppc/kernel/traps.c	2004-05-14 16:27:49.909643872 +1000
@@ -41,9 +41,6 @@
 #include <asm/backlight.h>
 #endif
 
-extern int fix_alignment(struct pt_regs *);
-extern void bad_page_fault(struct pt_regs *, unsigned long, int sig);
-
 #ifdef CONFIG_XMON
 void (*debugger)(struct pt_regs *regs) = xmon;
 int (*debugger_bpt)(struct pt_regs *regs) = xmon_bpt;
diff -urN linux-2.5/arch/ppc/mm/fault.c ppc-2.5/arch/ppc/mm/fault.c
--- linux-2.5/arch/ppc/mm/fault.c	2003-09-24 10:55:53.000000000 +1000
+++ ppc-2.5/arch/ppc/mm/fault.c	2004-05-14 16:28:48.265557688 +1000
@@ -51,11 +51,6 @@
 unsigned long pte_errors;	/* updated by do_page_fault() */
 unsigned int probingmem;
 
-extern void die_if_kernel(char *, struct pt_regs *, long);
-void bad_page_fault(struct pt_regs *, unsigned long, int sig);
-void do_page_fault(struct pt_regs *, unsigned long, unsigned long);
-extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
-
 /*
  * Check whether the instruction at regs->nip is a store using
  * an update addressing form which will update r1.
@@ -332,7 +327,6 @@
 void
 bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 {
-	extern void die(const char *,struct pt_regs *,long);
 	const struct exception_table_entry *entry;
 
 	/* Are we prepared to handle this fault?  */
@@ -359,7 +353,6 @@
 	pgd_t *dir;
 	pmd_t *pmd;
 	pte_t *pte;
-	struct mm_struct *mm;
 
 	if (address < TASK_SIZE)
 		return NULL;
diff -urN linux-2.5/include/asm-ppc/pgtable.h ppc-2.5/include/asm-ppc/pgtable.h
--- linux-2.5/include/asm-ppc/pgtable.h	2004-02-16 08:19:48.000000000 +1100
+++ ppc-2.5/include/asm-ppc/pgtable.h	2004-05-14 16:25:28.455588680 +1000
@@ -672,6 +672,8 @@
 
 typedef pte_t *pte_addr_t;
 
+extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep);
+
 #endif /* !__ASSEMBLY__ */
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
diff -urN linux-2.5/include/asm-ppc/system.h ppc-2.5/include/asm-ppc/system.h
--- linux-2.5/include/asm-ppc/system.h	2004-02-25 18:39:39.000000000 +1100
+++ ppc-2.5/include/asm-ppc/system.h	2004-05-14 16:25:19.642596344 +1000
@@ -76,11 +76,15 @@
 extern void enable_kernel_fp(void);
 extern void giveup_altivec(struct task_struct *);
 extern void load_up_altivec(struct task_struct *);
+extern int fix_alignment(struct pt_regs *);
 extern void cvt_fd(float *from, double *to, unsigned long *fpscr);
 extern void cvt_df(double *from, float *to, unsigned long *fpscr);
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
 extern int abs(int);
 extern void cacheable_memzero(void *p, unsigned int nb);
+extern void do_page_fault(struct pt_regs *, unsigned long, unsigned long);
+extern void bad_page_fault(struct pt_regs *, unsigned long, int);
+extern void die(const char *, struct pt_regs *, long);
 
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
