Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVAVEOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVAVEOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 23:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVAVEOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 23:14:17 -0500
Received: from ozlabs.org ([203.10.76.45]:16109 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262660AbVAVEOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 23:14:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.53894.984665.337289@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 15:11:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, Craig Chaney <cchaney@us.ibm.com>
Subject: [PATCH] PPC64 Clear MSR_RI earlier in syscall exit path
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Craig Chaney <cchaney@us.ibm.com>.

This patch moves the restoring of the stack pointer in the system call
exit path to after the point where we clear the RI (recoverable
interrupt) bit in the MSR.  Normally, loading the stack pointer before
clearing RI doesn't cause any problem because there is no trap that
can normally occur in between.  But if we are tracing the code using a
tool that single-steps instructions, this can cause a problem.  In
this case, clearing RI serves as an indication that the following code
can't be safely single-stepped.

Signed-off-by: Craig Chaney <cchaney@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -Naur clean/arch/ppc64/kernel/entry.S edited/arch/ppc64/kernel/entry.S
--- clean/arch/ppc64/kernel/entry.S	2004-09-26 14:24:27.000000000 +0000
+++ edited/arch/ppc64/kernel/entry.S	2004-09-27 14:36:29.221308744 +0000
@@ -185,10 +185,10 @@
 	beq-	1f			/* only restore r13 if */
 	ld	r13,GPR13(r1)		/* returning to usermode */
 1:	ld	r2,GPR2(r1)
-	ld	r1,GPR1(r1)
 	li	r12,MSR_RI
 	andc	r10,r10,r12
 	mtmsrd	r10,1			/* clear MSR.RI */
+	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
 	mtspr	SRR0,r7
