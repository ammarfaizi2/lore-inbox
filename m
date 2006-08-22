Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWHVF1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWHVF1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWHVF1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:27:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63695 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750757AbWHVF1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:27:24 -0400
Date: Tue, 22 Aug 2006 10:58:41 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: hch@infradead.org, Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>, davem@davemloft.net,
       schwidefsky@de.ibm.com
Subject: [PATCH 2/3] Add retval_value helper (updated)
Message-ID: <20060822052841.GB26279@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060822052448.GA26279@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822052448.GA26279@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Add the return_value() macro to extract the return value in an
architecture agnostic manner, given the pt_regs.

Other architecture maintainers may want to add similar helpers.

---

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
 include/asm-i386/ptrace.h    |    3 +++
 include/asm-ia64/ptrace.h    |    3 +++
 include/asm-powerpc/ptrace.h |    2 ++
 include/asm-s390/ptrace.h    |    1 +
 include/asm-x86_64/ptrace.h  |    2 ++
 5 files changed, 11 insertions(+)

Index: linux-2.6.18-rc4/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-i386/ptrace.h
+++ linux-2.6.18-rc4/include/asm-i386/ptrace.h
@@ -79,7 +79,10 @@ static inline int user_mode_vm(struct pt
 {
 	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
 }
+
 #define instruction_pointer(regs) ((regs)->eip)
+#define return_value(regs) ((regs)->eax)
+
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
Index: linux-2.6.18-rc4/include/asm-ia64/ptrace.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-ia64/ptrace.h
+++ linux-2.6.18-rc4/include/asm-ia64/ptrace.h
@@ -237,6 +237,9 @@ struct switch_stack {
  * the canonical representation by adding to instruction pointer.
  */
 # define instruction_pointer(regs) ((regs)->cr_iip + ia64_psr(regs)->ri)
+
+#define return_value(regs) ((regs)->r8)
+
 /* Conserve space in histogram by encoding slot bits in address
  * bits 2 and 3 rather than bits 0 and 1.
  */
Index: linux-2.6.18-rc4/include/asm-powerpc/ptrace.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-powerpc/ptrace.h
+++ linux-2.6.18-rc4/include/asm-powerpc/ptrace.h
@@ -73,6 +73,8 @@ struct pt_regs {
 #ifndef __ASSEMBLY__
 
 #define instruction_pointer(regs) ((regs)->nip)
+#define return_value(regs) ((regs)->gpr[3])
+
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
Index: linux-2.6.18-rc4/include/asm-s390/ptrace.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-s390/ptrace.h
+++ linux-2.6.18-rc4/include/asm-s390/ptrace.h
@@ -472,6 +472,7 @@ struct user_regs_struct
 
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
+#define return_value(regs)((regs)->gprs[2])
 #define profile_pc(regs) instruction_pointer(regs)
 extern void show_regs(struct pt_regs * regs);
 #endif
Index: linux-2.6.18-rc4/include/asm-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-rc4.orig/include/asm-x86_64/ptrace.h
+++ linux-2.6.18-rc4/include/asm-x86_64/ptrace.h
@@ -84,6 +84,8 @@ struct pt_regs {
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define user_mode_vm(regs) user_mode(regs)
 #define instruction_pointer(regs) ((regs)->rip)
+#define return_value(regs) ((regs)->rax)
+
 extern unsigned long profile_pc(struct pt_regs *regs);
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
