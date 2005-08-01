Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVHAHzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVHAHzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVHAHzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:55:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:23692 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261259AbVHAHzC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:55:02 -0400
Date: Mon, 1 Aug 2005 09:54:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: kexec fixes and improvements.
Message-ID: <20050801075456.GA4687@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Disable pseudo page fault handling before starting the new kernel and try to
use diag308 to reset the machine.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/machine_kexec.c     |    7 +++++
 arch/s390/kernel/relocate_kernel.S   |   41 +++++++++++++++++++++++++++++++
 arch/s390/kernel/relocate_kernel64.S |   45 +++++++++++++++++++++++++++++++++--
 arch/s390/kernel/smp.c               |    6 +++-
 arch/s390/kernel/traps.c             |   15 +++++++++++
 5 files changed, 109 insertions(+), 5 deletions(-)

diff -urN a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
--- a/arch/s390/kernel/machine_kexec.c	2005-07-24 17:07:34.000000000 +0200
+++ b/arch/s390/kernel/machine_kexec.c	2005-07-24 17:11:41.000000000 +0200
@@ -70,6 +70,8 @@
 	for (;;);
 }
 
+extern void pfault_fini(void);
+
 static void
 kexec_halt_all_cpus(void *kernel_image)
 {
@@ -78,6 +80,11 @@
 	struct kimage *image;
 	relocate_kernel_t data_mover;
 
+#ifdef CONFIG_PFAULT
+	if (MACHINE_IS_VM)
+		pfault_fini();
+#endif
+
 	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
 		signal_processor(smp_processor_id(), sigp_stop);
 
diff -urN a/arch/s390/kernel/relocate_kernel64.S b/arch/s390/kernel/relocate_kernel64.S
--- a/arch/s390/kernel/relocate_kernel64.S	2005-07-24 17:07:34.000000000 +0200
+++ b/arch/s390/kernel/relocate_kernel64.S	2005-07-24 17:10:39.000000000 +0200
@@ -4,6 +4,7 @@
  * (C) Copyright IBM Corp. 2005
  *
  * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
+ *	      Heiko Carstens <heiko.carstens@de.ibm.com>
  *
  */
 
@@ -26,8 +27,34 @@
 	relocate_kernel:
 		basr	%r13,0		#base address
 	.base:
+		stnsm	sys_msk-.base(%r13),0xf8	#disable DAT and IRQs
 		spx	zero64-.base(%r13)	#absolute addressing mode
-		stnsm	sys_msk-.base(%r13),0xf8	#disable DAT and IRQ (external)
+		stctg	%c0,%c15,ctlregs-.base(%r13)
+		stmg	%r0,%r15,gprregs-.base(%r13)
+		lghi	%r0,3
+		sllg	%r0,%r0,31
+		stg	%r0,0x1d0(%r0)
+		la	%r0,.back_pgm-.base(%r13)
+		stg	%r0,0x1d8(%r0)
+		la	%r1,load_psw-.base(%r13)
+		mvc     0(8,%r0),0(%r1)
+		la	%r0,.back-.base(%r13)
+		st	%r0,4(%r0)
+		oi	4(%r0),0x80
+		lghi	%r0,0
+		diag	%r0,%r0,0x308
+	.back:
+		lhi	%r1,1		#mode 1 = esame
+		sigp	%r1,%r0,0x12	#switch to esame mode
+		sam64			#switch to 64 bit addressing mode
+		basr	%r13,0
+	.back_base:
+		oi	have_diag308-.back_base(%r13),0x01
+		lctlg	%c0,%c15,ctlregs-.back_base(%r13)
+		lmg	%r0,%r15,gprregs-.back_base(%r13)
+		j	.top
+	.back_pgm:
+		lmg	%r0,%r15,gprregs-.base(%r13)
 	.top:
 		lghi	%r7,4096	#load PAGE_SIZE in r7
 		lghi	%r9,4096	#load PAGE_SIZE in r9
@@ -62,6 +89,10 @@
 		o	%r3,4(%r4)	#or load address into psw
 		st	%r3,4(%r4)
 		mvc     0(8,%r0),0(%r4)	#copy psw to absolute address 0
+		tm	have_diag308-.base(%r13),0x01
+		jno	.no_diag308
+		diag	%r0,%r0,0x308
+	.no_diag308:
 		sam31			#31 bit mode
 		sr      %r1,%r1		#erase register r1
 		sr      %r2,%r2		#erase register r2
@@ -75,8 +106,18 @@
 		.long	0x00080000,0x80000000
 	sys_msk:
 		.quad	0
+	ctlregs:
+		.rept	16
+		.quad	0
+		.endr
+	gprregs:
+		.rept	16
+		.quad	0
+		.endr
+	have_diag308:
+		.byte	0
+		.align	8
 	relocate_kernel_end:
 	.globl	relocate_kernel_len
 	relocate_kernel_len:
 		.quad	relocate_kernel_end - relocate_kernel
-
diff -urN a/arch/s390/kernel/relocate_kernel.S b/arch/s390/kernel/relocate_kernel.S
--- a/arch/s390/kernel/relocate_kernel.S	2005-07-24 17:07:34.000000000 +0200
+++ b/arch/s390/kernel/relocate_kernel.S	2005-07-24 17:10:39.000000000 +0200
@@ -4,6 +4,7 @@
  * (C) Copyright IBM Corp. 2005
  *
  * Author(s): Rolf Adelsberger <adelsberger@de.ibm.com>
+ *	      Heiko Carstens <heiko.carstens@de.ibm.com>
  *
  */
 
@@ -25,8 +26,31 @@
 	relocate_kernel:
 		basr	%r13,0		#base address
 	.base:
-		spx	zero64-.base(%r13)	#absolute addressing mode
 		stnsm	sys_msk-.base(%r13),0xf8	#disable DAT and IRQ (external)
+		spx	zero64-.base(%r13)	#absolute addressing mode
+		stctl	%c0,%c15,ctlregs-.base(%r13)
+		stm	%r0,%r15,gprregs-.base(%r13)
+		la	%r1,load_psw-.base(%r13)
+		mvc     0(8,%r0),0(%r1)
+		la	%r0,.back-.base(%r13)
+		st	%r0,4(%r0)
+		oi	4(%r0),0x80
+		mvc	0x68(8,%r0),0(%r1)
+		la	%r0,.back_pgm-.base(%r13)
+		st	%r0,0x6c(%r0)
+		oi	0x6c(%r0),0x80
+		lhi	%r0,0
+		diag	%r0,%r0,0x308
+	.back:
+		basr	%r13,0
+	.back_base:
+		oi	have_diag308-.back_base(%r13),0x01
+		lctl	%c0,%c15,ctlregs-.back_base(%r13)
+		lm	%r0,%r15,gprregs-.back_base(%r13)
+		j	.start_reloc
+	.back_pgm:
+		lm	%r0,%r15,gprregs-.base(%r13)
+	.start_reloc:	
 		lhi	%r10,-1		#preparing the mask
 		sll	%r10,12		#shift it such that it becomes 0xf000
 	.top:
@@ -63,6 +87,10 @@
 		o	%r3,4(%r4)	#or load address into psw
 		st	%r3,4(%r4)
 		mvc	0(8,%r0),0(%r4)	#copy psw to absolute address 0
+		tm	have_diag308-.base(%r13),0x01
+		jno	.no_diag308
+		diag	%r0,%r0,0x308
+	.no_diag308:
 		sr	%r1,%r1		#clear %r1
 		sr	%r2,%r2		#clear %r2
 		sigp	%r1,%r2,0x12	#set cpuid to zero
@@ -75,6 +103,17 @@
 		.long	0x00080000,0x80000000
 	sys_msk:
 		.quad	0
+	ctlregs:
+		.rept	16
+		.long	0
+		.endr
+	gprregs:
+		.rept	16
+		.long	0
+		.endr
+	have_diag308:
+		.byte	0
+		.align	8
 	relocate_kernel_end:
 	.globl	relocate_kernel_len
 	relocate_kernel_len:
diff -urN a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
--- a/arch/s390/kernel/smp.c	2005-07-24 17:07:34.000000000 +0200
+++ b/arch/s390/kernel/smp.c	2005-07-24 17:10:39.000000000 +0200
@@ -537,7 +537,8 @@
 #endif
 #ifdef CONFIG_PFAULT
 	/* Enable pfault pseudo page faults on this cpu. */
-	pfault_init();
+	if (MACHINE_IS_VM)
+		pfault_init();
 #endif
 	/* Mark this cpu as online */
 	cpu_set(smp_processor_id(), cpu_online_map);
@@ -690,7 +691,8 @@
 
 #ifdef CONFIG_PFAULT
 	/* Disable pfault pseudo page faults on this cpu. */
-	pfault_fini();
+	if (MACHINE_IS_VM)
+		pfault_fini();
 #endif
 
 	/* disable all external interrupts */
diff -urN a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
--- a/arch/s390/kernel/traps.c	2005-07-24 17:07:34.000000000 +0200
+++ b/arch/s390/kernel/traps.c	2005-07-24 17:23:54.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/reboot.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -675,6 +676,19 @@
 	panic("Corrupt kernel stack, can't continue.");
 }
 
+#ifndef CONFIG_ARCH_S390X
+static int
+pagex_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	if (MACHINE_IS_VM)
+		cpcmd("SET PAGEX OFF", NULL, 0, NULL);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pagex_reboot_notifier = {
+	.notifier_call = &pagex_reboot_event,
+};
+#endif
 
 /* init is done in lowcore.S and head.S */
 
@@ -735,6 +749,7 @@
 						    &ext_int_pfault);
 #endif
 #ifndef CONFIG_ARCH_S390X
+		register_reboot_notifier(&pagex_reboot_notifier);
 		cpcmd("SET PAGEX ON", NULL, 0, NULL);
 #endif
 	}
