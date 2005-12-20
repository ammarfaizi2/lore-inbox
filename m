Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVLTJyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVLTJyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 04:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbVLTJyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 04:54:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:54992 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750896AbVLTJyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 04:54:52 -0500
Date: Tue, 20 Dec 2005 15:24:32 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       davem@davemloft.net
Subject: [-mm PATCH] kprobes: fix build break in 2.6.15-rc5-mm3
Message-ID: <20051220095432.GA5139@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinkayanahalli <ananth@in.ibm.com>

The following patch (against 2.6.15-rc5-mm3) fixes a kprobes build
break due to changes introduced in the kprobe locking in
2.6.15-rc5-mm3. In addition, the patch reverts back the open-coding
of kprobe_mutex.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 arch/powerpc/kernel/kprobes.c |    6 +++---
 arch/x86_64/kernel/kprobes.c  |    6 +++---
 include/asm-i386/kprobes.h    |    2 +-
 include/asm-ia64/kprobes.h    |    2 +-
 include/asm-powerpc/kprobes.h |    3 ++-
 include/asm-sparc64/kprobes.h |    2 +-
 include/asm-x86_64/kprobes.h  |    3 ++-
 include/linux/kprobes.h       |    1 +
 kernel/kprobes.c              |    4 ++--
 9 files changed, 16 insertions(+), 13 deletions(-)

Index: linux-2.6.15-rc5/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.15-rc5/arch/powerpc/kernel/kprobes.c
@@ -80,11 +80,11 @@ void __kprobes arch_disarm_kprobe(struct
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p, struct semaphore *s)
+void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
-	down(s);
+	down(&kprobe_mutex);
 	free_insn_slot(p->ainsn.insn);
-	up(s);
+	up(&kprobe_mutex);
 }
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
Index: linux-2.6.15-rc5/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.15-rc5/arch/x86_64/kernel/kprobes.c
@@ -220,11 +220,11 @@ void __kprobes arch_disarm_kprobe(struct
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void __kprobes arch_remove_kprobe(struct kprobe *p, struct semaphore *s)
+void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
-	down(s);
+	down(&kprobe_mutex);
 	free_insn_slot(p->ainsn.insn);
-	up(s);
+	up(&kprobe_mutex);
 }
 
 static inline void save_previous_kprobe(struct kprobe_ctlblk *kcb)
Index: linux-2.6.15-rc5/include/linux/kprobes.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/kprobes.h
+++ linux-2.6.15-rc5/include/linux/kprobes.h
@@ -149,6 +149,7 @@ struct kretprobe_instance {
 };
 
 extern spinlock_t kretprobe_lock;
+extern struct semaphore kprobe_mutex;
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
Index: linux-2.6.15-rc5/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5/kernel/kprobes.c
@@ -48,7 +48,7 @@
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
-static DECLARE_MUTEX(kprobe_mutex);	/* Protects kprobe_table */
+DECLARE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
@@ -532,7 +532,7 @@ valid_p:
 			list_del_rcu(&p->list);
 			kfree(old_p);
 		}
-		arch_remove_kprobe(p, &kprobe_mutex);
+		arch_remove_kprobe(p);
 	}
 }
 
Index: linux-2.6.15-rc5/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.15-rc5/include/asm-powerpc/kprobes.h
@@ -32,6 +32,7 @@
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
 
 struct pt_regs;
+struct kprobe;
 
 typedef unsigned int kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0x7fe00008	/* trap */
@@ -49,7 +50,7 @@ typedef unsigned int kprobe_opcode_t;
 
 #define ARCH_SUPPORTS_KRETPROBES
 void kretprobe_trampoline(void);
-extern void arch_remove_kprobe(struct kprobe *p, struct semaphore *s);
+extern void arch_remove_kprobe(struct kprobe *p);
 
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
Index: linux-2.6.15-rc5/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-x86_64/kprobes.h
+++ linux-2.6.15-rc5/include/asm-x86_64/kprobes.h
@@ -30,6 +30,7 @@
 #define  __ARCH_WANT_KPROBES_INSN_SLOT
 
 struct pt_regs;
+struct kprobe;
 
 typedef u8 kprobe_opcode_t;
 #define BREAKPOINT_INSTRUCTION	0xcc
@@ -44,6 +45,7 @@ typedef u8 kprobe_opcode_t;
 #define ARCH_SUPPORTS_KRETPROBES
 
 void kretprobe_trampoline(void);
+extern void arch_remove_kprobe(struct kprobe *p);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
@@ -78,7 +80,6 @@ static inline void restore_interrupts(st
 		local_irq_enable();
 }
 
-extern void arch_remove_kprobe(struct kprobe *p, struct semaphore *s);
 extern int post_kprobe_handler(struct pt_regs *regs);
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
Index: linux-2.6.15-rc5/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-i386/kprobes.h
+++ linux-2.6.15-rc5/include/asm-i386/kprobes.h
@@ -40,7 +40,7 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
-#define arch_remove_kprobe(p, s)	do { } while(0)
+#define arch_remove_kprobe(p)	do {} while (0)
 
 void kretprobe_trampoline(void);
 
Index: linux-2.6.15-rc5/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.15-rc5/include/asm-ia64/kprobes.h
@@ -89,7 +89,7 @@ struct kprobe_ctlblk {
 #define IP_RELATIVE_PREDICT_OPCODE	(7)
 #define LONG_BRANCH_OPCODE		(0xC)
 #define LONG_CALL_OPCODE		(0xD)
-#define arch_remove_kprobe(p, s)	do { } while(0)
+#define arch_remove_kprobe(p)		do {} while (0)
 
 typedef struct kprobe_opcode {
 	bundle_t bundle;
Index: linux-2.6.15-rc5/include/asm-sparc64/kprobes.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-sparc64/kprobes.h
+++ linux-2.6.15-rc5/include/asm-sparc64/kprobes.h
@@ -12,7 +12,7 @@ typedef u32 kprobe_opcode_t;
 #define MAX_INSN_SIZE 2
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
-#define arch_remove_kprobe(p, s)	do { } while(0)
+#define arch_remove_kprobe(p)	do {} while (0)
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
