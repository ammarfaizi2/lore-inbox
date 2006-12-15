Return-Path: <linux-kernel-owner+w=401wt.eu-S1752830AbWLOQXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbWLOQXd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbWLOQXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:23:15 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6324 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbWLOQWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:22:52 -0500
Date: Fri, 15 Dec 2006 17:22:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] Save prefix register for dump on panic
Message-ID: <20061215162244.GH4920@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] Save prefix register for dump on panic

The dump tools expect that the saved prefix register points to the
lowcore of the dump cpu. Since we set the prefix register to 0 during
reipl/dump, we have to save the original prefix register. Before we
start the dump program, we copy the original prefix register to the
designated location in the lowcore.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c     |    4 ++++
 arch/s390/kernel/reipl.S   |    6 +++++-
 arch/s390/kernel/reipl64.S |    5 ++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-15 16:55:13.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-15 16:55:13.000000000 +0100
@@ -995,6 +995,7 @@ static void do_reset_calls(void)
 
 extern void reset_mcck_handler(void);
 extern void reset_pgm_handler(void);
+extern __u32 dump_prefix_page;
 
 void s390_reset_system(void)
 {
@@ -1005,6 +1006,9 @@ void s390_reset_system(void)
 	/* Stack for interrupt/machine check handler */
 	lc->panic_stack = S390_lowcore.panic_stack;
 
+	/* Save prefix page address for dump case */
+	dump_prefix_page = (unsigned long) lc;
+
 	/* Disable prefixing */
 	set_prefix(0);
 
diff -urpN linux-2.6/arch/s390/kernel/reipl64.S linux-2.6-patched/arch/s390/kernel/reipl64.S
--- linux-2.6/arch/s390/kernel/reipl64.S	2006-12-15 16:54:49.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reipl64.S	2006-12-15 16:55:13.000000000 +0100
@@ -20,7 +20,7 @@ do_reipl_asm:	basr	%r13,0
 		stg	%r0,__LC_GPREGS_SAVE_AREA-0x1000+8(%r1)
 		stctg	%c0,%c15,__LC_CREGS_SAVE_AREA-0x1000(%r1)
 		stam	%a0,%a15,__LC_AREGS_SAVE_AREA-0x1000(%r1)
-		stpx	__LC_PREFIX_SAVE_AREA-0x1000(%r1)
+		mvc	__LC_PREFIX_SAVE_AREA-0x1000(4,%r1),dump_prefix_page-.Lpg0(%r13)
 		stfpc	__LC_FP_CREG_SAVE_AREA-0x1000(%r1)
 		stckc	.Lclkcmp-.Lpg0(%r13)
 		mvc	__LC_CLOCK_COMP_SAVE_AREA-0x1000(8,%r1),.Lclkcmp-.Lpg0(%r13)
@@ -103,3 +103,6 @@ do_reipl_asm:	basr	%r13,0
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
+	.globl dump_prefix_page
+dump_prefix_page:
+	.long 0x00000000
diff -urpN linux-2.6/arch/s390/kernel/reipl.S linux-2.6-patched/arch/s390/kernel/reipl.S
--- linux-2.6/arch/s390/kernel/reipl.S	2006-12-15 16:54:49.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/reipl.S	2006-12-15 16:55:13.000000000 +0100
@@ -16,7 +16,7 @@ do_reipl_asm:	basr	%r13,0
 		stm	%r0,%r15,__LC_GPREGS_SAVE_AREA
 		stctl	%c0,%c15,__LC_CREGS_SAVE_AREA
 		stam	%a0,%a15,__LC_AREGS_SAVE_AREA
-		stpx	__LC_PREFIX_SAVE_AREA
+		mvc	__LC_PREFIX_SAVE_AREA(4),dump_prefix_page-.Lpg0(%r13)
 		stckc	.Lclkcmp-.Lpg0(%r13)
 		mvc	__LC_CLOCK_COMP_SAVE_AREA(8),.Lclkcmp-.Lpg0(%r13)
 		stpt	__LC_CPU_TIMER_SAVE_AREA
@@ -79,3 +79,7 @@ do_reipl_asm:	basr	%r13,0
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
 		.long	0x00000000,0x00000000
+	.globl dump_prefix_page
+dump_prefix_page:
+	.long 0x00000000
+
