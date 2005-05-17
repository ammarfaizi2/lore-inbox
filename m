Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVEQPLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVEQPLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVEQPLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:11:33 -0400
Received: from fmr19.intel.com ([134.134.136.18]:14015 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261581AbVEQPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:10:38 -0400
Message-Id: <20050517144658.807957000@penguin2.jf.intel.com>
Date: Tue, 17 May 2005 07:46:58 -0700
From: rusty.lynch@intel.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       ananth@in.ibm.com, davem@davemloft.net, vamsi_krishna@in.ibm.com
Subject: [PATCH]Moving kprobe [dis]arming into arch specific
Content-Disposition: inline; filename=arch_break_inst.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The architecture independent code of the current kprobes implementation 
is arming and disarming kprobes at registration time.  The problem is that
the code is assuming that arming and disarming is a just done by a simple
write of some magic value to an address.  This is problematic for ia64 where
our instructions look more like structures, and we can not insert break points
by just doing something like:

*p->addr = BREAKPOINT_INSTRUCTION;

The following patch to 2.6.12-rc4-mm2 adds two new architecture dependent 
functions:
     * void arch_arm_kprobe(struct kprobe *p)
     * void arch_disarm_kprobe(struct kprobe *p)

.and then adds the new functions for each of the architectures that
already implement kprobes (spar64/ppc64/i386/x86_64).

I thought arch_[dis]arm_kprobe was the most descriptive of what was really 
happening, but each of the architectures already had a disarm_kprobe() function
that was really a "disarm and do some other clean-up items as needed when
you stumble across a recursive kprobe."  So... I took the liberty of changing
the code that was calling disarm_kprobe() to call arch_disarm_kprobe(), and
then do the cleanup in the block of code dealing with the recursive kprobe
case. 

So far this patch as been tested on i386, x86_64, and ppc64, but still needs to be tested in sparc64. 

    --rusty

Signed-off-by: Rusty Lynch <rusty.lynch@intel.com>
Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

 arch/i386/kernel/kprobes.c    |   19 +++++++++++++++----
 arch/ppc64/kernel/kprobes.c   |   19 +++++++++++++++----
 arch/sparc64/kernel/kprobes.c |   31 ++++++++++++++++++-------------
 arch/x86_64/kernel/kprobes.c  |   26 ++++++++++++++++++--------
 include/linux/kprobes.h       |    2 ++
 kernel/kprobes.c              |   12 ++++--------
 6 files changed, 72 insertions(+), 37 deletions(-)

Index: linux-2.6.12-rc4-mm2/include/linux/kprobes.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/linux/kprobes.h
+++ linux-2.6.12-rc4-mm2/include/linux/kprobes.h
@@ -166,6 +166,8 @@ static inline int kprobe_running(void)
 
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_copy_kprobe(struct kprobe *p);
+extern void arch_arm_kprobe(struct kprobe *p);
+extern void arch_disarm_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
 extern void show_registers(struct pt_regs *regs);
 
Index: linux-2.6.12-rc4-mm2/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/kernel/kprobes.c
+++ linux-2.6.12-rc4-mm2/kernel/kprobes.c
@@ -260,7 +260,7 @@ inline void free_rp_inst(struct kretprob
 static inline void add_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	ap->addr = p->addr;
-	ap->opcode = p->opcode;
+	memcpy(&ap->opcode, &p->opcode, sizeof(kprobe_opcode_t));
 	memcpy(&ap->ainsn, &p->ainsn, sizeof(struct arch_specific_insn));
 
 	ap->pre_handler = aggr_pre_handler;
@@ -303,10 +303,8 @@ static int register_aggr_kprobe(struct k
 /* kprobe removal house-keeping routines */
 static inline void cleanup_kprobe(struct kprobe *p, unsigned long flags)
 {
-	*p->addr = p->opcode;
+	arch_disarm_kprobe(p);
 	hlist_del(&p->hlist);
-	flush_icache_range((unsigned long) p->addr,
-		   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 	arch_remove_kprobe(p);
 }
@@ -343,10 +341,8 @@ int register_kprobe(struct kprobe *p)
 	hlist_add_head(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
-	p->opcode = *p->addr;
-	*p->addr = BREAKPOINT_INSTRUCTION;
-	flush_icache_range((unsigned long) p->addr,
-			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+  	arch_arm_kprobe(p);
+
 out:
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 rm_kprobe:
Index: linux-2.6.12-rc4-mm2/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.12-rc4-mm2/arch/i386/kernel/kprobes.c
@@ -33,6 +33,7 @@
 #include <linux/ptrace.h>
 #include <linux/spinlock.h>
 #include <linux/preempt.h>
+#include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 #include <asm/desc.h>
 
@@ -71,16 +72,25 @@ int arch_prepare_kprobe(struct kprobe *p
 void arch_copy_kprobe(struct kprobe *p)
 {
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	p->opcode = *p->addr;
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void arch_arm_kprobe(struct kprobe *p)
 {
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	flush_icache_range((unsigned long) p->addr,
+			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+void arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
-	regs->eip = (unsigned long)p->addr;
+	flush_icache_range((unsigned long) p->addr,
+			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+}
+
+void arch_remove_kprobe(struct kprobe *p)
+{
 }
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
@@ -177,7 +187,8 @@ static int kprobe_handler(struct pt_regs
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			disarm_kprobe(p, regs);
+			arch_disarm_kprobe(p);
+			regs->eip = (unsigned long)p->addr;
 			ret = 1;
 		} else {
 			p = current_kprobe;
Index: linux-2.6.12-rc4-mm2/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/ppc64/kernel/kprobes.c
+++ linux-2.6.12-rc4-mm2/arch/ppc64/kernel/kprobes.c
@@ -32,6 +32,7 @@
 #include <linux/ptrace.h>
 #include <linux/spinlock.h>
 #include <linux/preempt.h>
+#include <asm/cacheflush.h>
 #include <asm/kdebug.h>
 #include <asm/sstep.h>
 
@@ -56,16 +57,25 @@ int arch_prepare_kprobe(struct kprobe *p
 void arch_copy_kprobe(struct kprobe *p)
 {
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+	p->opcode = *p->addr;
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void arch_arm_kprobe(struct kprobe *p)
 {
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	flush_icache_range((unsigned long) p->addr,
+			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+void arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
-	regs->nip = (unsigned long)p->addr;
+	flush_icache_range((unsigned long) p->addr,
+			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+}
+
+void arch_remove_kprobe(struct kprobe *p)
+{
 }
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
@@ -96,7 +106,8 @@ static inline int kprobe_handler(struct 
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			disarm_kprobe(p, regs);
+			arch_disarm_kprobe(p);
+			regs->nip = (unsigned long)p->addr;
 			ret = 1;
 		} else {
 			p = current_kprobe;
Index: linux-2.6.12-rc4-mm2/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/sparc64/kernel/kprobes.c
+++ linux-2.6.12-rc4-mm2/arch/sparc64/kernel/kprobes.c
@@ -6,7 +6,6 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
-
 #include <asm/kdebug.h>
 #include <asm/signal.h>
 
@@ -47,6 +46,19 @@ void arch_copy_kprobe(struct kprobe *p)
 {
 	p->ainsn.insn[0] = *p->addr;
 	p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
+	p->opcode = *p->addr;
+}
+
+void arch_arm_kprobe(struct kprobe *p)
+{
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	flushi(p->addr);
+}
+
+void arch_disarm_kprobe(struct kprobe *p)
+{
+	*p->addr = p->opcode;
+	flushi(p->addr);
 }
 
 void arch_remove_kprobe(struct kprobe *p)
@@ -78,17 +90,6 @@ static inline void prepare_singlestep(st
 	}
 }
 
-static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
-{
-	*p->addr = p->opcode;
-	flushi(p->addr);
-
-	regs->tpc = (unsigned long) p->addr;
-	regs->tnpc = current_kprobe_orig_tnpc;
-	regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
-			current_kprobe_orig_tstate_pil);
-}
-
 static int kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
@@ -109,7 +110,11 @@ static int kprobe_handler(struct pt_regs
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			disarm_kprobe(p, regs);
+			arch_disarm_kprobe(p);
+			regs->tpc = (unsigned long) p->addr;
+			regs->tnpc = current_kprobe_orig_tnpc;
+			regs->tstate = ((regs->tstate & ~TSTATE_PIL) |
+					current_kprobe_orig_tstate_pil);
 			ret = 1;
 		} else {
 			p = current_kprobe;
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/kprobes.c
@@ -37,7 +37,7 @@
 #include <linux/slab.h>
 #include <linux/preempt.h>
 #include <linux/moduleloader.h>
-
+#include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
 
@@ -214,19 +214,28 @@ void arch_copy_kprobe(struct kprobe *p)
 		BUG_ON((s64) (s32) disp != disp); /* Sanity check.  */
 		*ripdisp = disp;
 	}
+	p->opcode = *p->addr;
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void arch_arm_kprobe(struct kprobe *p)
 {
-	up(&kprobe_mutex);
-	free_insn_slot(p->ainsn.insn);
-	down(&kprobe_mutex);
+	*p->addr = BREAKPOINT_INSTRUCTION;
+	flush_icache_range((unsigned long) p->addr,
+			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
+void arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
-	regs->rip = (unsigned long)p->addr;
+	flush_icache_range((unsigned long) p->addr,
+			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+}
+
+void arch_remove_kprobe(struct kprobe *p)
+{
+	up(&kprobe_mutex);
+	free_insn_slot(p->ainsn.insn);
+	down(&kprobe_mutex);
 }
 
 static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
@@ -265,7 +274,8 @@ int kprobe_handler(struct pt_regs *regs)
 				unlock_kprobes();
 				goto no_kprobe;
 			}
-			disarm_kprobe(p, regs);
+			arch_disarm_kprobe(p);
+			regs->rip = (unsigned long)p->addr;
 			ret = 1;
 		} else {
 			p = current_kprobe;

--

