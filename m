Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWDJF5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWDJF5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWDJF5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:57:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44192 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751016AbWDJF5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:57:22 -0400
Date: Mon, 10 Apr 2006 11:27:12 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, systemtap@sources.redhat.com
Subject: [PATCH] [1/5] Switch Kprobes inline functions to __kprobes for i386
Message-ID: <20060410055712.GA24711@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find the set of patches that removes inline for kprobes routines and adds
__kprobes. These patches have been tested on i386, x86_64, ppc64 and
ia64 architectures.

Thanks
Prasanna

Andrew Morton pointed out that compiler might not inline the functions
marked for inline in kprobes. There by allowing the insertion of probes
on these kprobes routines, which might cause recursion. This patch
removes all such inline and adds them to kprobes section there by
disallowing probes on all such routines. Some of the routines can
even still be inlined, since these routines gets executed after
the kprobes had done necessay setup for reentrancy.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/i386/kernel/kprobes.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions arch/i386/kernel/kprobes.c
--- linux-2.6.17-rc1-mm2/arch/i386/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions	2006-04-10 10:58:56.000000000 +0530
+++ linux-2.6.17-rc1-mm2-prasanna/arch/i386/kernel/kprobes.c	2006-04-10 10:58:56.000000000 +0530
@@ -43,7 +43,7 @@ DEFINE_PER_CPU(struct kprobe *, current_
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
 /* insert a jmp code */
-static inline void set_jmp_op(void *from, void *to)
+static __always_inline void set_jmp_op(void *from, void *to)
 {
 	struct __arch_jmp_op {
 		char op;
@@ -57,7 +57,7 @@ static inline void set_jmp_op(void *from
 /*
  * returns non-zero if opcodes can be boosted.
  */
-static inline int can_boost(kprobe_opcode_t opcode)
+static __always_inline int can_boost(kprobe_opcode_t opcode)
 {
 	switch (opcode & 0xf0 ) {
 	case 0x70:
@@ -88,7 +88,7 @@ static inline int can_boost(kprobe_opcod
 /*
  * returns non-zero if opcode modifies the interrupt flag.
  */
-static inline int is_IF_modifier(kprobe_opcode_t opcode)
+static int __kprobes is_IF_modifier(kprobe_opcode_t opcode)
 {
 	switch (opcode) {
 	case 0xfa:		/* cli */
@@ -138,7 +138,7 @@ void __kprobes arch_remove_kprobe(struct
 	mutex_unlock(&kprobe_mutex);
 }
 
-static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
@@ -146,7 +146,7 @@ static inline void save_previous_kprobe(
 	kcb->prev_kprobe.saved_eflags = kcb->kprobe_saved_eflags;
 }
 
-static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
 	kcb->kprobe_status = kcb->prev_kprobe.status;
@@ -154,7 +154,7 @@ static inline void restore_previous_kpro
 	kcb->kprobe_saved_eflags = kcb->prev_kprobe.saved_eflags;
 }
 
-static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 				struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = p;
@@ -164,7 +164,7 @@ static inline void set_current_kprobe(st
 		kcb->kprobe_saved_eflags &= ~IF_MASK;
 }
 
-static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->eflags |= TF_MASK;
 	regs->eflags &= ~IF_MASK;
@@ -507,7 +507,7 @@ no_change:
  * Interrupts are disabled on entry as trap1 is an interrupt gate and they
  * remain disabled thoroughout this function.
  */
-static inline int post_kprobe_handler(struct pt_regs *regs)
+static int __kprobes post_kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
@@ -543,7 +543,7 @@ out:
 	return 1;
 }
 
-static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+static int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 {
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
