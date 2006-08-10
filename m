Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWHJUCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWHJUCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWHJT7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:59:31 -0400
Received: from mail.suse.de ([195.135.220.2]:5521 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932650AbWHJTg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:56 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [97/145] x86_64: Add sparse annotations to quiet sparse in arch/x86_64/mm/fault.c
Message-Id: <20060810193654.E353813C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:54 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Fixes

linux/arch/x86_64/mm/fault.c:125:7: warning: incorrect type in argument 1 (different address spaces)
linux/arch/x86_64/mm/fault.c:125:7:    expected void [noderef] *<noident><asn:1>
linux/arch/x86_64/mm/fault.c:125:7:    got unsigned char *[assigned] instr
linux/arch/x86_64/mm/fault.c:163:8: warning: incorrect type in argument 1 (different address spaces)
linux/arch/x86_64/mm/fault.c:163:8:    expected void [noderef] *<noident><asn:1>
linux/arch/x86_64/mm/fault.c:163:8:    got unsigned char *[assigned] instr
linux/arch/x86_64/mm/fault.c:179:9: warning: incorrect type in argument 1 (different address spaces)
linux/arch/x86_64/mm/fault.c:179:9:    expected void [noderef] *<noident><asn:1>
linux/arch/x86_64/mm/fault.c:179:9:    got unsigned long *<noident>


Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/mm/fault.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/arch/x86_64/mm/fault.c
===================================================================
--- linux.orig/arch/x86_64/mm/fault.c
+++ linux/arch/x86_64/mm/fault.c
@@ -102,7 +102,7 @@ void bust_spinlocks(int yes)
 static noinline int is_prefetch(struct pt_regs *regs, unsigned long addr,
 				unsigned long error_code)
 { 
-	unsigned char *instr;
+	unsigned char __user *instr;
 	int scan_more = 1;
 	int prefetch = 0; 
 	unsigned char *max_instr;
@@ -111,7 +111,7 @@ static noinline int is_prefetch(struct p
 	if (error_code & PF_INSTR)
 		return 0;
 	
-	instr = (unsigned char *)convert_rip_to_linear(current, regs);
+	instr = (unsigned char __user *)convert_rip_to_linear(current, regs);
 	max_instr = instr + 15;
 
 	if (user_mode(regs) && instr >= (unsigned char *)TASK_SIZE)
@@ -122,7 +122,7 @@ static noinline int is_prefetch(struct p
 		unsigned char instr_hi;
 		unsigned char instr_lo;
 
-		if (__get_user(opcode, instr))
+		if (__get_user(opcode, (char __user *)instr))
 			break; 
 
 		instr_hi = opcode & 0xf0; 
@@ -160,7 +160,7 @@ static noinline int is_prefetch(struct p
 		case 0x00:
 			/* Prefetch instruction is 0x0F0D or 0x0F18 */
 			scan_more = 0;
-			if (__get_user(opcode, instr)) 
+			if (__get_user(opcode, (char __user *)instr))
 				break;
 			prefetch = (instr_lo == 0xF) &&
 				(opcode == 0x0D || opcode == 0x18);
@@ -176,7 +176,7 @@ static noinline int is_prefetch(struct p
 static int bad_address(void *p) 
 { 
 	unsigned long dummy;
-	return __get_user(dummy, (unsigned long *)p);
+	return __get_user(dummy, (unsigned long __user *)p);
 } 
 
 void dump_pagetable(unsigned long address)
