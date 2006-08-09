Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWHIJlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWHIJlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030615AbWHIJlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:41:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58803 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030613AbWHIJlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:41:52 -0400
Date: Wed, 9 Aug 2006 15:13:11 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Jim Keniston <jkenisto@us.ibm.com>
Subject: Re: [PATCH 2/3] Kprobes: Define retval helper
Message-ID: <20060809094311.GA20050@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20060807115537.GA15253@in.ibm.com> <20060807120024.GD15253@in.ibm.com> <20060808162559.GB28647@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808162559.GB28647@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 05:25:59PM +0100, Christoph Hellwig wrote:
> On Mon, Aug 07, 2006 at 05:30:24PM +0530, Ananth N Mavinakayanahalli wrote:
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > Add the KPROBE_RETVAL macro to help extract the return value on
> > different architectures, while using function-return probes.
> 
> Good idea.  You should add parentheses around regs, otherwise the C
> preprocessor might bite users.  Also the shouting name is quite ugly.
> In fact it should probably go to asm/system.h or similar and not have
> a kprobes name - it just extracts the return value from a struct pt_regs
> after all.

Done! How does this look? I added it to asm/ptrace.h so it lives along
with the instruction_pointer() definition.

Ananth

---

Add the "get_retval" macro that just extracts the return value given the
pt_regs. Useful in situations such as while using function-return
probes.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

---
 include/asm-i386/ptrace.h    |    3 +++
 include/asm-ia64/ptrace.h    |    3 +++
 include/asm-powerpc/ptrace.h |    2 ++
 include/asm-x86_64/ptrace.h  |    2 ++
 4 files changed, 10 insertions(+)

Index: linux-2.6.18-rc3/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-i386/ptrace.h
+++ linux-2.6.18-rc3/include/asm-i386/ptrace.h
@@ -79,7 +79,10 @@ static inline int user_mode_vm(struct pt
 {
 	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
 }
+
 #define instruction_pointer(regs) ((regs)->eip)
+#define get_retval(regs) ((regs)->eax)
+
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
Index: linux-2.6.18-rc3/include/asm-ia64/ptrace.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-ia64/ptrace.h
+++ linux-2.6.18-rc3/include/asm-ia64/ptrace.h
@@ -237,6 +237,9 @@ struct switch_stack {
  * the canonical representation by adding to instruction pointer.
  */
 # define instruction_pointer(regs) ((regs)->cr_iip + ia64_psr(regs)->ri)
+
+#define get_retval(regs) ((regs)->r8)
+
 /* Conserve space in histogram by encoding slot bits in address
  * bits 2 and 3 rather than bits 0 and 1.
  */
Index: linux-2.6.18-rc3/include/asm-powerpc/ptrace.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-powerpc/ptrace.h
+++ linux-2.6.18-rc3/include/asm-powerpc/ptrace.h
@@ -73,6 +73,8 @@ struct pt_regs {
 #ifndef __ASSEMBLY__
 
 #define instruction_pointer(regs) ((regs)->nip)
+#define get_retval(regs) ((regs)->gpr[3])
+
 #ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
Index: linux-2.6.18-rc3/include/asm-x86_64/ptrace.h
===================================================================
--- linux-2.6.18-rc3.orig/include/asm-x86_64/ptrace.h
+++ linux-2.6.18-rc3/include/asm-x86_64/ptrace.h
@@ -84,6 +84,8 @@ struct pt_regs {
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define user_mode_vm(regs) user_mode(regs)
 #define instruction_pointer(regs) ((regs)->rip)
+#define get_retval(regs) ((regs)->rax)
+
 extern unsigned long profile_pc(struct pt_regs *regs);
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
