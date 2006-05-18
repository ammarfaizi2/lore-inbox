Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWERBy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWERBy3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 21:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWERBy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 21:54:28 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:14551 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750787AbWERBy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 21:54:28 -0400
Date: Wed, 17 May 2006 21:49:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.17-rc4] i386: let usermode execute the "enter"
  instruction
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Tomasz Malesinski <tmal@mimuw.edu.pl>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Message-ID: <200605172152_MC3-1-C012-EFCD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The i386 page fault handler does not allow enough slack when
checking for userspace access below the current stack pointer.
This prevents use of the enter instruction by user code.  Fix
this by allowing enough slack for "enter $65535,$31" to execute.

Problem reported by Tomasz Malesinski <tmal@mimuw.edu.pl>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Tested using this program, based on the original from Tomasz:

	.file	"ovflow.S"
	.version	"01.01"
gcc2_compiled.:
.section	.rodata
.LC0:
	.string	"asdf\n"
.text
	.align 4
.globl main
	.type	 main,@function
main:
nest_level=0
.rept 30
	enter $0,$nest_level
nest_level=nest_level+1
.endr
	enter $65535,$30
	enter $65535,$31
	addl $-12,%esp
	pushl $.LC0
	call printf
	addl $16,%esp
.L2:
.rept 32
	leave
.endr
	ret
.Lfe1:
	.size	 main,.Lfe1-main
	.ident	"GCC: (GNU) 2.95.4 20011002 (Debian prerelease)"


--- 2.6.17-rc4-32.orig/arch/i386/mm/fault.c
+++ 2.6.17-rc4-32/arch/i386/mm/fault.c
@@ -380,12 +380,12 @@ fastcall void __kprobes do_page_fault(st
 		goto bad_area;
 	if (error_code & 4) {
 		/*
-		 * accessing the stack below %esp is always a bug.
-		 * The "+ 32" is there due to some instructions (like
-		 * pusha) doing post-decrement on the stack and that
-		 * doesn't show up until later..
+		 * Accessing the stack below %esp is always a bug.
+		 * The large cushion allows instructions like enter
+		 * and pusha to work.  ("enter $65535,$31" pushes
+		 * 32 pointers and then decrements %esp by 65535.)
 		 */
-		if (address + 32 < regs->esp)
+		if (address + 65536 + 32 * sizeof(unsigned long) < regs->esp)
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))
-- 
Chuck
"The x86 isn't all that complex -- it just doesn't make a lot of sense."
                                                        -- Mike Johnson
