Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUJ1Lmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUJ1Lmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUJ1Lk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:40:58 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55532 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262974AbUJ1Lh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:37:29 -0400
Date: Thu, 28 Oct 2004 17:08:45 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>, ak@muc.de,
       suparna@in.ibm.com, dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [3/3] PATCH Kprobes for x86_64- 2.6.9-final
Message-ID: <20041028113845.GC5812@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041028113208.GA11182@in.ibm.com> <20041028113444.GA5812@in.ibm.com> <20041028113558.GB5812@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028113558.GB5812@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[3/3] kprobes-arch-sparc64-changes.patch


Minor changes required to port kprobes for x86_64.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>



---

 linux-2.6.9-final-prasanna/arch/sparc64/kernel/kprobes.c |   28 ++++++++++-----
 linux-2.6.9-final-prasanna/include/asm-sparc64/kprobes.h |    6 +++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff -puN arch/sparc64/kernel/kprobes.c~kprobes-arch-sparc64-changes arch/sparc64/kernel/kprobes.c
--- linux-2.6.9-final/arch/sparc64/kernel/kprobes.c~kprobes-arch-sparc64-changes	2004-10-28 16:47:08.000000000 +0530
+++ linux-2.6.9-final-prasanna/arch/sparc64/kernel/kprobes.c	2004-10-28 16:47:08.000000000 +0530
@@ -15,7 +15,7 @@
  * traps.  The top-level scheme is similar to that used
  * in the x86 kprobes implementation.
  *
- * In the kprobe->insn[] array we store the original
+ * At kprobe->insn we allocate enough bytes and then store the original
  * instruction at index zero and a break instruction at
  * index one.
  *
@@ -38,10 +38,20 @@
  * - Mark that we are no longer actively in a kprobe.
  */
 
-void arch_prepare_kprobe(struct kprobe *p)
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	p->ainsn.insn = (kprobe_opcode_t *) kmalloc(MAX_INSN_SIZE, GFP_ATOMIC);
+	if (!p->ainsn.insn) {
+		return -ENOMEM;
+	}
+
+	p->ainsn.insn[0] = *p->addr;
+	p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
+	return 0;
+}
+
+void arch_remove_kprobe(struct kprobe *p)
 {
-	p->insn[0] = *p->addr;
-	p->insn[1] = BREAKPOINT_INSTRUCTION_2;
 }
 
 /* kprobe_status settings */
@@ -59,8 +69,8 @@ static inline void prepare_singlestep(st
 	current_kprobe_orig_tstate_pil = (regs->tstate & TSTATE_PIL);
 	regs->tstate |= TSTATE_PIL;
 
-	regs->tpc = (unsigned long) &p->insn[0];
-	regs->tnpc = (unsigned long) &p->insn[1];
+	regs->tpc = (unsigned long) &p->ainsn.insn[0];
+	regs->tnpc = (unsigned long) &p->ainsn.insn[1];
 }
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
@@ -199,19 +209,19 @@ static void retpc_fixup(struct pt_regs *
  * instruction.  To avoid the SMP problems that can occur when we
  * temporarily put back the original opcode to single-step, we
  * single-stepped a copy of the instruction.  The address of this
- * copy is p->insn.
+ * copy is p->ainsn.insn.
  *
  * This function prepares to return from the post-single-step
  * breakpoint trap.
  */
 static void resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
-	u32 insn = p->insn[0];
+	u32 insn = p->ainsn.insn[0];
 
 	regs->tpc = current_kprobe_orig_tnpc;
 	regs->tnpc = relbranch_fixup(insn,
 				     (unsigned long) p->addr,
-				     (unsigned long) &p->insn[0],
+				     (unsigned long) &p->ainsn.insn[0],
 				     regs->tnpc);
 	retpc_fixup(regs, insn, (unsigned long) p->addr);
 
diff -puN include/asm-sparc64/kprobes.h~kprobes-arch-sparc64-changes include/asm-sparc64/kprobes.h
--- linux-2.6.9-final/include/asm-sparc64/kprobes.h~kprobes-arch-sparc64-changes	2004-10-28 16:47:08.000000000 +0530
+++ linux-2.6.9-final-prasanna/include/asm-sparc64/kprobes.h	2004-10-28 16:47:08.000000000 +0530
@@ -10,6 +10,12 @@ typedef u32 kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION_2 0x91d02071 /* ta 0x71 */
 #define MAX_INSN_SIZE 2
 
+/* Architecture specific copy of original instruction*/
+struct arch_specific_insn {
+	/* copy of the original instruction */
+	kprobe_opcode_t insn[MAX_INSN_SIZE];
+};
+
 #ifdef CONFIG_KPROBES
 extern int kprobe_exceptions_notify(struct notifier_block *self,
 				    unsigned long val, void *data);

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
