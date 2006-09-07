Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWIGMBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWIGMBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWIGMBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:01:36 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:13931 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751004AbWIGMBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:01:36 -0400
Date: Thu, 7 Sep 2006 14:01:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: Kernel stack overflow handling.
Message-ID: <20060907120133.GA6997@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Kernel stack overflow handling.

Substract the size of the initial stack frame from the correct
register. Otherwise we will end up in a program check loop.
Fix the offset into the save area as well.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry64.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2006-09-07 12:39:04.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2006-09-07 12:39:25.000000000 +0200
@@ -827,7 +827,7 @@ restart_go:
  */
 stack_overflow:
 	lg	%r15,__LC_PANIC_STACK	# change to panic stack
-	aghi	%r1,-SP_SIZE
+	aghi	%r15,-SP_SIZE
 	mvc	SP_PSW(16,%r15),0(%r12)	# move user PSW to stack
 	stmg	%r0,%r11,SP_R0(%r15)	# store gprs %r0-%r11 to kernel stack
 	la	%r1,__LC_SAVE_AREA
@@ -835,7 +835,7 @@ stack_overflow:
 	je	0f
 	chi	%r12,__LC_PGM_OLD_PSW
 	je	0f
-	la	%r1,__LC_SAVE_AREA+16
+	la	%r1,__LC_SAVE_AREA+32
 0:	mvc	SP_R12(32,%r15),0(%r1)  # move %r12-%r15 to stack
         xc      __SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15) # clear back chain
         la      %r2,SP_PTREGS(%r15)	# load pt_regs
