Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWDJF56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWDJF56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWDJF56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:57:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18116 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751019AbWDJF55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:57:57 -0400
Date: Mon, 10 Apr 2006 11:28:13 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, systemtap@sources.redhat.com
Subject: Re: [PATCH] [2/5] Switch Kprobes inline functions to __kprobes for x86_64
Message-ID: <20060410055813.GA23879@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060410055712.GA24711@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410055712.GA24711@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton pointed out that compiler might not inline the functions
marked for inline in kprobes. There by allowing the insertion of probes
on these kprobes routines, which might cause recursion. This patch
removes all such inline and adds them to kprobes section there by
disallowing probes on all such routines. Some of the routines can
even still be inlined, since these routines gets executed after
the kprobes had done necessay setup for reentrancy.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/x86_64/kernel/kprobes.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/x86_64/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions-x86_64 arch/x86_64/kernel/kprobes.c
--- linux-2.6.17-rc1-mm2/arch/x86_64/kernel/kprobes.c~kprobes-remove-inline-kprobe-functions-x86_64	2006-04-10 10:59:25.000000000 +0530
+++ linux-2.6.17-rc1-mm2-prasanna/arch/x86_64/kernel/kprobes.c	2006-04-10 10:59:25.000000000 +0530
@@ -53,7 +53,7 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kpr
 /*
  * returns non-zero if opcode modifies the interrupt flag.
  */
-static inline int is_IF_modifier(kprobe_opcode_t *insn)
+static __always_inline int is_IF_modifier(kprobe_opcode_t *insn)
 {
 	switch (*insn) {
 	case 0xfa:		/* cli */
@@ -84,7 +84,7 @@ int __kprobes arch_prepare_kprobe(struct
  * If it does, return the address of the 32-bit displacement word.
  * If not, return null.
  */
-static inline s32 *is_riprel(u8 *insn)
+static s32 __kprobes *is_riprel(u8 *insn)
 {
 #define W(row,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,ba,bb,bc,bd,be,bf)		      \
 	(((b0##UL << 0x0)|(b1##UL << 0x1)|(b2##UL << 0x2)|(b3##UL << 0x3) |   \
@@ -229,7 +229,7 @@ void __kprobes arch_remove_kprobe(struct
 	mutex_unlock(&kprobe_mutex);
 }
 
-static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
@@ -237,7 +237,7 @@ static inline void save_previous_kprobe(
 	kcb->prev_kprobe.saved_rflags = kcb->kprobe_saved_rflags;
 }
 
-static inline void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = kcb->prev_kprobe.kp;
 	kcb->kprobe_status = kcb->prev_kprobe.status;
@@ -245,7 +245,7 @@ static inline void restore_previous_kpro
 	kcb->kprobe_saved_rflags = kcb->prev_kprobe.saved_rflags;
 }
 
-static inline void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 				struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = p;

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
