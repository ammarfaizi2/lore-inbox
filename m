Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162238AbWKPCn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162238AbWKPCn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162240AbWKPCn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:43:59 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:14223 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162238AbWKPCnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:43:43 -0500
Message-Id: <20061116024414.118486000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:34 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [patch 02/30] POWERPC: Make alignment exception always check exception table
Content-Disposition: inline; filename=make-alignment-exception-always-check-exception-table.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The alignment exception used to only check the exception table for
-EFAULT, not for other errors. That opens an oops window if we can
coerce the kernel into getting an alignment exception for other reasons
in what would normally be a user-protected accessor, which can be done
via some of the futex ops. This fixes it by always checking the
exception tables.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/powerpc/kernel/traps.c |   18 ++++++++++--------
 arch/ppc/kernel/traps.c     |   18 ++++++++++--------
 2 files changed, 20 insertions(+), 16 deletions(-)

--- linux-2.6.18.2.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6.18.2/arch/powerpc/kernel/traps.c
@@ -818,7 +818,7 @@ void __kprobes program_check_exception(s
 
 void alignment_exception(struct pt_regs *regs)
 {
-	int fixed = 0;
+	int sig, code, fixed = 0;
 
 	/* we don't implement logging of alignment exceptions */
 	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
@@ -832,14 +832,16 @@ void alignment_exception(struct pt_regs 
 
 	/* Operand address was bad */
 	if (fixed == -EFAULT) {
-		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
-		else
-			/* Search exception table */
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		return;
+		sig = SIGSEGV;
+		code = SEGV_ACCERR;
+	} else {
+		sig = SIGBUS;
+		code = BUS_ADRALN;
 	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+	if (user_mode(regs))
+		_exception(sig, regs, code, regs->dar);
+	else
+		bad_page_fault(regs, regs->dar, sig);
 }
 
 void StackOverflow(struct pt_regs *regs)
--- linux-2.6.18.2.orig/arch/ppc/kernel/traps.c
+++ linux-2.6.18.2/arch/ppc/kernel/traps.c
@@ -708,7 +708,7 @@ void single_step_exception(struct pt_reg
 
 void alignment_exception(struct pt_regs *regs)
 {
-	int fixed;
+	int sig, code, fixed = 0;
 
 	fixed = fix_alignment(regs);
 	if (fixed == 1) {
@@ -717,14 +717,16 @@ void alignment_exception(struct pt_regs 
 		return;
 	}
 	if (fixed == -EFAULT) {
-		/* fixed == -EFAULT means the operand address was bad */
-		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
-		else
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		return;
+		sig = SIGSEGV;
+		code = SEGV_ACCERR;
+	} else {
+		sig = SIGBUS;
+		code = BUS_ADRALN;
 	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+	if (user_mode(regs))
+		_exception(sig, regs, code, regs->dar);
+	else
+		bad_page_fault(regs, regs->dar, sig);
 }
 
 void StackOverflow(struct pt_regs *regs)

--
