Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWDTXvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWDTXvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWDTXvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:51:19 -0400
Received: from mga07.intel.com ([143.182.124.22]:60687 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932150AbWDTXvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:51:04 -0400
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831857:sNHT24867486"
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="25831821:sNHT19736556"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,142,1144047600"; 
   d="scan'208"; a="26631648:sNHT27088432"
Message-Id: <20060420233912.570729645@csdlinux-2.jf.intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com>
Date: Thu, 20 Apr 2006 16:25:03 -0700
From: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
To: Anderw Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Owens <kaos@americas.sgi.com>,
       Dean Nelson <dnc@americas.sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [(take 2)patch 7/7] Notify page fault call chain
Content-Disposition: inline; filename=kprobes_noitfy_register.patch
X-OriginalArrivalTime: 20 Apr 2006 23:51:00.0989 (UTC) FILETIME=[471332D0:01C664D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch Kprobes now registers for page fault notifications only
when their is an active probe registered. Once all the active probes are
unregistered their is no need to be notified of page faults and kprobes
unregisters itself from the page fault notifications. Hence we
will have ZERO side effects when no probes are active.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---
 include/asm-i386/kprobes.h    |    1 +
 include/asm-ia64/kprobes.h    |    1 +
 include/asm-powerpc/kprobes.h |    2 ++
 include/asm-sparc64/kprobes.h |    1 +
 include/asm-x86_64/kprobes.h  |    1 +
 kernel/kprobes.c              |   30 +++++++++++++++++++++++-------
 6 files changed, 29 insertions(+), 7 deletions(-)

Index: linux-2.6.17-rc1-mm3/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-i386/kprobes.h
+++ linux-2.6.17-rc1-mm3/include/asm-i386/kprobes.h
@@ -44,6 +44,7 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
+#define  ARCH_INACTIVE_KPROBE_COUNT 0
 
 void arch_remove_kprobe(struct kprobe *p);
 void kretprobe_trampoline(void);
Index: linux-2.6.17-rc1-mm3/include/asm-ia64/kprobes.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-ia64/kprobes.h
+++ linux-2.6.17-rc1-mm3/include/asm-ia64/kprobes.h
@@ -82,6 +82,7 @@ struct kprobe_ctlblk {
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 
 #define ARCH_SUPPORTS_KRETPROBES
+#define  ARCH_INACTIVE_KPROBE_COUNT 1
 
 #define SLOT0_OPCODE_SHIFT	(37)
 #define SLOT1_p1_OPCODE_SHIFT	(37 - (64-46))
Index: linux-2.6.17-rc1-mm3/include/asm-powerpc/kprobes.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-powerpc/kprobes.h
+++ linux-2.6.17-rc1-mm3/include/asm-powerpc/kprobes.h
@@ -50,6 +50,8 @@ typedef unsigned int kprobe_opcode_t;
 			IS_TWI(instr) || IS_TDI(instr))
 
 #define ARCH_SUPPORTS_KRETPROBES
+#define  ARCH_INACTIVE_KPROBE_COUNT 1
+
 void kretprobe_trampoline(void);
 extern void arch_remove_kprobe(struct kprobe *p);
 
Index: linux-2.6.17-rc1-mm3/include/asm-sparc64/kprobes.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-sparc64/kprobes.h
+++ linux-2.6.17-rc1-mm3/include/asm-sparc64/kprobes.h
@@ -13,6 +13,7 @@ typedef u32 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define arch_remove_kprobe(p)	do {} while (0)
+#define  ARCH_INACTIVE_KPROBE_COUNT 0
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
Index: linux-2.6.17-rc1-mm3/include/asm-x86_64/kprobes.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/include/asm-x86_64/kprobes.h
+++ linux-2.6.17-rc1-mm3/include/asm-x86_64/kprobes.h
@@ -43,6 +43,7 @@ typedef u8 kprobe_opcode_t;
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
 #define ARCH_SUPPORTS_KRETPROBES
+#define  ARCH_INACTIVE_KPROBE_COUNT 1
 
 void kretprobe_trampoline(void);
 extern void arch_remove_kprobe(struct kprobe *p);
Index: linux-2.6.17-rc1-mm3/kernel/kprobes.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/kprobes.c
+++ linux-2.6.17-rc1-mm3/kernel/kprobes.c
@@ -47,11 +47,17 @@
 
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
+static atomic_t kprobe_count;
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
 
+static struct notifier_block kprobe_page_fault_nb = {
+	.notifier_call = kprobe_exceptions_notify,
+	.priority = 0x7fffffff /* we need to notified first */
+};
+
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
  * kprobe->ainsn.insn points to the copy of the instruction to be
@@ -464,6 +470,8 @@ static int __kprobes __register_kprobe(s
 	old_p = get_kprobe(p->addr);
 	if (old_p) {
 		ret = register_aggr_kprobe(old_p, p);
+		if (!ret)
+			atomic_inc(&kprobe_count);
 		goto out;
 	}
 
@@ -474,6 +482,10 @@ static int __kprobes __register_kprobe(s
 	hlist_add_head_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
+	if (atomic_add_return(1, &kprobe_count) == \
+				(ARCH_INACTIVE_KPROBE_COUNT + 1))
+		register_page_fault_notifier(&kprobe_page_fault_nb);
+
   	arch_arm_kprobe(p);
 
 out:
@@ -537,6 +549,16 @@ valid_p:
 		}
 		arch_remove_kprobe(p);
 	}
+
+	/* Call unregister_page_fault_notifier()
+	 * if no probes are active
+	 */
+	mutex_lock(&kprobe_mutex);
+	if (atomic_add_return(-1, &kprobe_count) == \
+				ARCH_INACTIVE_KPROBE_COUNT)
+		unregister_page_fault_notifier(&kprobe_page_fault_nb);
+	mutex_unlock(&kprobe_mutex);
+	return;
 }
 
 static struct notifier_block kprobe_exceptions_nb = {
@@ -544,10 +566,6 @@ static struct notifier_block kprobe_exce
 	.priority = 0x7fffffff /* we need to notified first */
 };
 
-static struct notifier_block kprobe_page_fault_nb = {
-	.notifier_call = kprobe_exceptions_notify,
-	.priority = 0x7fffffff /* we need to notified first */
-};
 
 int __kprobes register_jprobe(struct jprobe *jp)
 {
@@ -654,14 +672,12 @@ static int __init init_kprobes(void)
 		INIT_HLIST_HEAD(&kprobe_table[i]);
 		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
 	}
+	atomic_set(&kprobe_count, 0);
 
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
 
-	if (!err)
-		err = register_page_fault_notifier(&kprobe_page_fault_nb);
-
 	return err;
 }
 

--
