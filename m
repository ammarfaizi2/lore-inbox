Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVLMUzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVLMUzB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVLMUzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:55:01 -0500
Received: from fmr21.intel.com ([143.183.121.13]:31924 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030211AbVLMUzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:55:00 -0500
Message-Id: <20051213203901.444955819@csdlinux-2.jf.intel.com>
References: <20051213203547.649087523@csdlinux-2.jf.intel.com>
Date: Tue, 13 Dec 2005 12:35:51 -0800
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: ananth@in.ibm.com, akpm@osdl.org, paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [patch 4/4] Kprobes Cleanup arch_remove_kprobe
Content-Disposition: inline; filename=cleanup_arch_remove_kprobe.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Kprobes Cleanup arch_remove_kprobe

Currently arch_remove_kprobes() is only implemented/required
for x86_64 and powerpc. All other architecture like
IA64, i386 and sparc64 implementes a dummy function which
is being called from arch independent kprobes.c file.

This patch removes the dummy functions and replaces it with
#define arch_remove_kprobe(p, s)	do { } while(0)

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-------------------------------------------------------------------------------
 arch/i386/kernel/kprobes.c    |    4 ----
 arch/ia64/kernel/kprobes.c    |    4 ----
 arch/powerpc/kernel/kprobes.c |    4 +++-
 arch/sparc64/kernel/kprobes.c |    4 ----
 arch/x86_64/kernel/kprobes.c  |    4 +++-
 include/asm-i386/kprobes.h    |    1 +
 include/asm-ia64/kprobes.h    |    1 +
 include/asm-powerpc/kprobes.h |    1 +
 include/asm-sparc64/kprobes.h |    1 +
 include/asm-x86_64/kprobes.h  |    1 +
 include/linux/kprobes.h       |    1 -
 kernel/kprobes.c              |    4 +---
 12 files changed, 12 insertions(+), 18 deletions(-)

Index: linux-2.6.15-rc5-mm2/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/i386/kernel/kprobes.c
@@ -77,10 +77,6 @@ void __kprobes arch_disarm_kprobe(struct
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
-{
-}
-
 static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
Index: linux-2.6.15-rc5-mm2/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/ia64/kernel/kprobes.c
@@ -467,10 +467,6 @@ void __kprobes arch_disarm_kprobe(struct
 	flush_icache_range(arm_addr, arm_addr + sizeof(bundle_t));
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
-{
-}
-
 /*
  * We are resuming execution after a single step fault, so the pt_regs
  * structure reflects the register state after we executed the instruction
Index: linux-2.6.15-rc5-mm2/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/powerpc/kernel/kprobes.c
@@ -83,9 +83,11 @@ void __kprobes arch_disarm_kprobe(struct
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
+void __kprobes arch_remove_kprobe(struct kprobe *p, struct semaphore *s)
 {
+	down(s);
 	free_insn_slot(p->ainsn.insn);
+	up(s);
 }
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
Index: linux-2.6.15-rc5-mm2/arch/sparc64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/sparc64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/sparc64/kernel/kprobes.c
@@ -61,10 +61,6 @@ void __kprobes arch_disarm_kprobe(struct
 	flushi(p->addr);
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
-{
-}
-
 static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
Index: linux-2.6.15-rc5-mm2/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/arch/x86_64/kernel/kprobes.c
@@ -220,9 +220,11 @@ void __kprobes arch_disarm_kprobe(struct
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
+void __kprobes arch_remove_kprobe(struct kprobe *p, struct semaphore *s)
 {
+	down(s);
 	free_insn_slot(p->ainsn.insn);
+	up(s);
 }
 
 static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
Index: linux-2.6.15-rc5-mm2/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-i386/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-i386/kprobes.h
@@ -40,6 +40,7 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
+#define arch_remove_kprobe(p, s)	do { } while(0)
 
 void kretprobe_trampoline(void);
 
Index: linux-2.6.15-rc5-mm2/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-ia64/kprobes.h
@@ -89,6 +89,7 @@ struct kprobe_ctlblk {
 #define IP_RELATIVE_PREDICT_OPCODE	(7)
 #define LONG_BRANCH_OPCODE		(0xC)
 #define LONG_CALL_OPCODE		(0xD)
+#define arch_remove_kprobe(p, s)	do { } while(0)
 
 typedef struct kprobe_opcode {
 	bundle_t bundle;
Index: linux-2.6.15-rc5-mm2/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-powerpc/kprobes.h
@@ -49,6 +49,7 @@ typedef unsigned int kprobe_opcode_t;
 
 #define ARCH_SUPPORTS_KRETPROBES
 void kretprobe_trampoline(void);
+extern void arch_remove_kprobe(struct kprobe *p, struct semaphore *s);
 
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
Index: linux-2.6.15-rc5-mm2/include/asm-sparc64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-sparc64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-sparc64/kprobes.h
@@ -12,6 +12,7 @@ typedef u32 kprobe_opcode_t;
 #define MAX_INSN_SIZE 2
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+#define arch_remove_kprobe(p, s)	do { } while(0)
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
Index: linux-2.6.15-rc5-mm2/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-x86_64/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/asm-x86_64/kprobes.h
@@ -78,6 +78,7 @@ static inline void restore_interrupts(st
 		local_irq_enable();
 }
 
+extern void arch_remove_kprobe(struct kprobe *p, struct semaphore *s);
 extern int post_kprobe_handler(struct pt_regs *regs);
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
Index: linux-2.6.15-rc5-mm2/include/linux/kprobes.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/linux/kprobes.h
+++ linux-2.6.15-rc5-mm2/include/linux/kprobes.h
@@ -152,7 +152,6 @@ extern spinlock_t kretprobe_lock;
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
-extern void arch_remove_kprobe(struct kprobe *p);
 extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern kprobe_opcode_t *get_insn_slot(void);
Index: linux-2.6.15-rc5-mm2/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm2/kernel/kprobes.c
@@ -528,9 +528,7 @@ void __kprobes unregister_kprobe(struct 
 			list_del_rcu(&p->list);
 			kfree(old_p);
 		}
-		down(&kprobe_mutex);
-		arch_remove_kprobe(p);
-		up(&kprobe_mutex);
+		arch_remove_kprobe(p, &kprobe_mutex);
 	}
 }
 

--

