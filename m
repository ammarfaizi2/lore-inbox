Return-Path: <linux-kernel-owner+w=401wt.eu-S1752818AbWLOQWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbWLOQWh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbWLOQWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:22:37 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32554 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbWLOQW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:22:27 -0500
Date: Fri, 15 Dec 2006 17:22:18 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] Fix reboot hang on LPARs
Message-ID: <20061215162218.GF4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] Fix reboot hang on LPARs

Reboot hangs on LPARs without diag308 support. The reason for this is,
that before the reboot is done, the channel subsystem is shut down.
During the reset on each possible subchannel a "store subchannel" is
done. This operation can end in a program check interruption, if the
specified subchannel set is not implemented by the hardware. During
the reset, currently we do not have a program check handler, which
leads to the described kernel bug. We install now a new program check
handler for the reboot code to fix this problem.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c   |   10 +++++++++-
 arch/s390/kernel/reset.S |   42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/cio.c   |   25 +++++++++++++++++++++++--
 include/asm-s390/reset.h |    1 +
 4 files changed, 75 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-15 16:54:49.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-15 16:55:10.000000000 +0100
@@ -1037,13 +1037,15 @@ static void do_reset_calls(void)
 }
 
 extern void reset_mcck_handler(void);
+extern void reset_pgm_handler(void);
 
 void s390_reset_system(void)
 {
 	struct _lowcore *lc;
 
-	/* Stack for interrupt/machine check handler */
 	lc = (struct _lowcore *)(unsigned long) store_prefix();
+
+	/* Stack for interrupt/machine check handler */
 	lc->panic_stack = S390_lowcore.panic_stack;
 
 	/* Disable prefixing */
@@ -1056,5 +1058,11 @@ void s390_reset_system(void)
 	S390_lowcore.mcck_new_psw.mask = PSW_KERNEL_BITS & ~PSW_MASK_MCHECK;
 	S390_lowcore.mcck_new_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) &reset_mcck_handler;
+
+	/* Set new program check handler */
+	S390_lowcore.program_new_psw.mask = PSW_KERNEL_BITS & ~PSW_MASK_MCHECK;
+	S390_lowcore.program_new_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long) &reset_pgm_handler;
+
 	do_reset_calls();
 }
diff -urpN linux-2.6/arch/s390/kernel/reset.S linux-2.6-patched/arch/s390/kernel/reset.S
--- linux-2.6/arch/s390/kernel/reset.S	2006-12-15 16:54:49.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reset.S	2006-12-15 16:55:10.000000000 +0100
@@ -3,6 +3,7 @@
  *
  *    Copyright (C) IBM Corp. 2006
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ *		 Michael Holzheu <holzheu@de.ibm.com>
  */
 
 #include <asm/ptrace.h>
@@ -27,6 +28,26 @@ reset_mcck_handler:
 s390_reset_mcck_handler:
 	.quad	0
 
+	.globl	reset_pgm_handler
+reset_pgm_handler:
+	stmg	%r0,%r15,__LC_SAVE_AREA
+	basr	%r13,0
+0:	lg	%r15,__LC_PANIC_STACK	# load panic stack
+	aghi	%r15,-STACK_FRAME_OVERHEAD
+	lg	%r1,s390_reset_pgm_handler-0b(%r13)
+	ltgr	%r1,%r1
+	jz	1f
+	basr	%r14,%r1
+	lmg	%r0,%r15,__LC_SAVE_AREA
+	lpswe	__LC_PGM_OLD_PSW
+1:	lpswe	disabled_wait_psw-0b(%r13)
+	.globl s390_reset_pgm_handler
+s390_reset_pgm_handler:
+	.quad	0
+	.align	8
+disabled_wait_psw:
+	.quad	0x0002000180000000,0x0000000000000000 + reset_pgm_handler
+
 #else /* CONFIG_64BIT */
 
 	.globl	reset_mcck_handler
@@ -45,4 +66,25 @@ reset_mcck_handler:
 s390_reset_mcck_handler:
 	.long	0
 
+	.globl	reset_pgm_handler
+reset_pgm_handler:
+	stm	%r0,%r15,__LC_SAVE_AREA
+	basr	%r13,0
+0:	l	%r15,__LC_PANIC_STACK	# load panic stack
+	ahi	%r15,-STACK_FRAME_OVERHEAD
+	l	%r1,s390_reset_pgm_handler-0b(%r13)
+	ltr	%r1,%r1
+	jz	1f
+	basr	%r14,%r1
+	lm	%r0,%r15,__LC_SAVE_AREA
+	lpsw	__LC_PGM_OLD_PSW
+
+1:	lpsw	disabled_wait_psw-0b(%r13)
+	.globl	s390_reset_pgm_handler
+s390_reset_pgm_handler:
+	.long	0
+disabled_wait_psw:
+	.align 8
+	.long	0x000a0000,0x00000000 + reset_pgm_handler
+
 #endif /* CONFIG_64BIT */
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-12-15 16:54:55.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-12-15 16:55:10.000000000 +0100
@@ -871,11 +871,32 @@ __clear_subchannel_easy(struct subchanne
 	return -EBUSY;
 }
 
+static int pgm_check_occured;
+
+static void cio_reset_pgm_check_handler(void)
+{
+	pgm_check_occured = 1;
+}
+
+static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
+{
+	int rc;
+
+	pgm_check_occured = 0;
+	s390_reset_pgm_handler = cio_reset_pgm_check_handler;
+	rc = stsch(schid, addr);
+	s390_reset_pgm_handler = NULL;
+	if (pgm_check_occured)
+		return -EIO;
+	else
+		return rc;
+}
+
 static int __shutdown_subchannel_easy(struct subchannel_id schid, void *data)
 {
 	struct schib schib;
 
-	if (stsch_err(schid, &schib))
+	if (stsch_reset(schid, &schib))
 		return -ENXIO;
 	if (!schib.pmcw.ena)
 		return 0;
@@ -972,7 +993,7 @@ static int __reipl_subchannel_match(stru
 	struct schib schib;
 	struct sch_match_id *match_id = data;
 
-	if (stsch_err(schid, &schib))
+	if (stsch_reset(schid, &schib))
 		return -ENXIO;
 	if (schib.pmcw.dnv &&
 	    (schib.pmcw.dev == match_id->devid.devno) &&
diff -urpN linux-2.6/include/asm-s390/reset.h linux-2.6-patched/include/asm-s390/reset.h
--- linux-2.6/include/asm-s390/reset.h	2006-12-15 16:54:59.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/reset.h	2006-12-15 16:55:10.000000000 +0100
@@ -19,5 +19,6 @@ extern void register_reset_call(struct r
 extern void unregister_reset_call(struct reset_call *reset);
 extern void s390_reset_system(void);
 extern void (*s390_reset_mcck_handler)(void);
+extern void (*s390_reset_pgm_handler)(void);
 
 #endif /* _ASM_S390_RESET_H */
