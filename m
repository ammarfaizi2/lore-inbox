Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWHJUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWHJUVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWHJUPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:44 -0400
Received: from ns1.suse.de ([195.135.220.2]:26512 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932487AbWHJTfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:50 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [35/145] x86_64: Simplify profile_pc on x86-64
Message-Id: <20060810193549.0C59D13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:49 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Use knowledge about EFLAGS layout (bits 22:63 are always 0) to distingush
EFLAGS word and kernel address in the spin lock stack frame.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/time.c |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -189,20 +189,15 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	/* Assume the lock function has either no stack frame or only a single 
-	   word.  This checks if the address on the stack looks like a kernel 
-	   text address.
-	   There is a small window for false hits, but in that case the tick
-	   is just accounted to the spinlock function.
-	   Better would be to write these functions in assembler again
-	   and check exactly. */
+	/* Assume the lock function has either no stack frame or a copy
+	   of eflags from PUSHF
+	   Eflags always has bits 22 and up cleared unlike kernel addresses. */
 	if (!user_mode(regs) && in_lock_functions(pc)) {
-		char *v = *(char **)regs->rsp;
-		if ((v >= _stext && v <= _etext) ||
-			(v >= _sinittext && v <= _einittext) ||
-			(v >= (char *)MODULES_VADDR  && v <= (char *)MODULES_END))
-			return (unsigned long)v;
-		return ((unsigned long *)regs->rsp)[1];
+		unsigned long *sp = (unsigned long *)regs->rsp;
+		if (sp[0] >> 22)
+			return sp[0];
+		if (sp[1] >> 22)
+			return sp[1];
 	}
 	return pc;
 }
