Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933561AbWKQMfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933561AbWKQMfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933560AbWKQMfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:35:21 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:41647 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S933561AbWKQMfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:35:19 -0500
Message-ID: <455DAC83.3030505@hitachi.com>
Date: Fri, 17 Nov 2006 21:35:15 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "bibo,mao" <bibo.mao@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH][kprobe] enabling booster on the preemptible kernel
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anil,
Could you give me your Ack for this patch?

From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

This patch enables the kprobe-booster on the preemptible kernel.
For this purpose, I introduced a kind of garbage collector of
the instruction slots. This garbage collector checks safety before
releasing the garbage slots.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

---

When we are unregistering a kprobe-booster, we can't release
its instruction buffer immediately on the preemptive kernel,
because some processes might be preempted on the buffer.
The freeze_processes() and thaw_processes() functions can
clean most of processes up from the buffer. There are still
some non-frozen threads who have the PF_NOFREEZE flag. If
those threads are sleeping (not preempted) at the known place
outside the buffer, we can ensure safety of freeing.

However, the processing of this check routine takes a long time.
So, this patch introduces the garbage collection mechanism of
insn_slot. It also introduces the "dirty" flag to free_insn_slot
because of efficiency.
The "clean" instruction slots (dirty flag is cleared) are
released immediately. But the "dirty" slots which are used
by boosted kprobes, are marked as garbages.
collect_garbage_slots() will be invoked to release "dirty"
slots if there are more than INSNS_PER_PAGE garbage slots
or if there are no unused slots.

 arch/i386/kernel/kprobes.c    |    4 -
 arch/ia64/kernel/kprobes.c    |    2
 arch/powerpc/kernel/kprobes.c |    2
 arch/s390/kernel/kprobes.c    |    2
 arch/x86_64/kernel/kprobes.c  |    2
 include/linux/kprobes.h       |    2
 kernel/kprobes.c              |  117 ++++++++++++++++++++++++++++++++++--------
 7 files changed, 103 insertions(+), 28 deletions(-)

Index: linux-2.6.19-rc5-mm2/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/kernel/kprobes.c
+++ linux-2.6.19-rc5-mm2/kernel/kprobes.c
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/kallsyms.h>
+#include <linux/freezer.h>
 #include <asm-generic/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
@@ -83,9 +84,36 @@ struct kprobe_insn_page {
 	kprobe_opcode_t *insns;		/* Page of instruction slots */
 	char slot_used[INSNS_PER_PAGE];
 	int nused;
+	int ngarbage;
 };

 static struct hlist_head kprobe_insn_pages;
+static int kprobe_garbage_slots;
+static int collect_garbage_slots(void);
+
+static int __kprobes check_safety(void)
+{
+	int ret = 0;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_PM)
+	ret = freeze_processes();
+	if (ret == 0) {
+		struct task_struct *p, *q;
+		do_each_thread(p, q) {
+			if (p != current && p->state == TASK_RUNNING &&
+			    p->pid != 0) {
+				printk("Check failed: %s is running\n",p->comm);
+				ret = -1;
+				goto loop_end;
+			}
+		} while_each_thread(p, q);
+	}
+loop_end:
+	thaw_processes();
+#else
+	synchronize_sched();
+#endif
+	return ret;
+}

 /**
  * get_insn_slot() - Find a slot on an executable page for an instruction.
@@ -96,6 +124,7 @@ kprobe_opcode_t __kprobes *get_insn_slot
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;

+      retry:
 	hlist_for_each(pos, &kprobe_insn_pages) {
 		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
 		if (kip->nused < INSNS_PER_PAGE) {
@@ -112,7 +141,11 @@ kprobe_opcode_t __kprobes *get_insn_slot
 		}
 	}

-	/* All out of space.  Need to allocate a new page. Use slot 0.*/
+	/* If there are any garbage slots, collect it and try again. */
+	if (kprobe_garbage_slots && collect_garbage_slots() == 0) {
+		goto retry;
+	}
+	/* All out of space.  Need to allocate a new page. Use slot 0. */
 	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_KERNEL);
 	if (!kip) {
 		return NULL;
@@ -133,10 +166,62 @@ kprobe_opcode_t __kprobes *get_insn_slot
 	memset(kip->slot_used, 0, INSNS_PER_PAGE);
 	kip->slot_used[0] = 1;
 	kip->nused = 1;
+	kip->ngarbage = 0;
 	return kip->insns;
 }

-void __kprobes free_insn_slot(kprobe_opcode_t *slot)
+/* Return 1 if all garbages are collected, otherwise 0. */
+static int __kprobes collect_one_slot(struct kprobe_insn_page *kip, int idx)
+{
+	kip->slot_used[idx] = 0;
+	kip->nused--;
+	if (kip->nused == 0) {
+		/*
+		 * Page is no longer in use.  Free it unless
+		 * it's the last one.  We keep the last one
+		 * so as not to have to set it up again the
+		 * next time somebody inserts a probe.
+		 */
+		hlist_del(&kip->hlist);
+		if (hlist_empty(&kprobe_insn_pages)) {
+			INIT_HLIST_NODE(&kip->hlist);
+			hlist_add_head(&kip->hlist,
+				       &kprobe_insn_pages);
+		} else {
+			module_free(NULL, kip->insns);
+			kfree(kip);
+		}
+		return 1;
+	}
+	return 0;
+}
+
+static int __kprobes collect_garbage_slots(void)
+{
+	struct kprobe_insn_page *kip;
+	struct hlist_node *pos, *next;
+
+	/* Ensure no-one is preepmted on the garbages */
+	if (check_safety() != 0)
+		return -EAGAIN;
+
+	hlist_for_each_safe(pos, next, &kprobe_insn_pages) {
+		int i;
+		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
+		if (kip->ngarbage == 0)
+			continue;
+		kip->ngarbage = 0;	/* we will collect all garbages */
+		for (i = 0; i < INSNS_PER_PAGE; i++) {
+			if (kip->slot_used[i] == -1 &&
+			    collect_one_slot(kip, i))
+				break;
+		}
+	}
+	kprobe_garbage_slots = 0;
+	return 0;
+}
+
+void __kprobes free_insn_slot(kprobe_opcode_t * slot, int dirty)
 {
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;
@@ -146,28 +231,18 @@ void __kprobes free_insn_slot(kprobe_opc
 		if (kip->insns <= slot &&
 		    slot < kip->insns + (INSNS_PER_PAGE * MAX_INSN_SIZE)) {
 			int i = (slot - kip->insns) / MAX_INSN_SIZE;
-			kip->slot_used[i] = 0;
-			kip->nused--;
-			if (kip->nused == 0) {
-				/*
-				 * Page is no longer in use.  Free it unless
-				 * it's the last one.  We keep the last one
-				 * so as not to have to set it up again the
-				 * next time somebody inserts a probe.
-				 */
-				hlist_del(&kip->hlist);
-				if (hlist_empty(&kprobe_insn_pages)) {
-					INIT_HLIST_NODE(&kip->hlist);
-					hlist_add_head(&kip->hlist,
-						&kprobe_insn_pages);
-				} else {
-					module_free(NULL, kip->insns);
-					kfree(kip);
-				}
+			if (dirty) {
+				kip->slot_used[i] = -1;
+				kip->ngarbage++;
+			} else {
+				collect_one_slot(kip, i);
 			}
-			return;
+			break;
 		}
 	}
+	if (dirty && (++kprobe_garbage_slots > INSNS_PER_PAGE)) {
+		collect_garbage_slots();
+	}
 }
 #endif

Index: linux-2.6.19-rc5-mm2/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.19-rc5-mm2/arch/i386/kernel/kprobes.c
@@ -184,7 +184,7 @@ void __kprobes arch_disarm_kprobe(struct
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 	mutex_lock(&kprobe_mutex);
-	free_insn_slot(p->ainsn.insn);
+	free_insn_slot(p->ainsn.insn, (p->ainsn.boostable == 1));
 	mutex_unlock(&kprobe_mutex);
 }

@@ -333,7 +333,7 @@ static int __kprobes kprobe_handler(stru
 		return 1;

 ss_probe:
-#ifndef CONFIG_PREEMPT
+#if !defined(CONFIG_PREEMPT) || defined(CONFIG_PM)
 	if (p->ainsn.boostable == 1 && !p->post_handler){
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
Index: linux-2.6.19-rc5-mm2/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.19-rc5-mm2/arch/ia64/kernel/kprobes.c
@@ -481,7 +481,7 @@ void __kprobes arch_disarm_kprobe(struct
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 	mutex_lock(&kprobe_mutex);
-	free_insn_slot(p->ainsn.insn);
+	free_insn_slot(p->ainsn.insn, 0);
 	mutex_unlock(&kprobe_mutex);
 }
 /*
Index: linux-2.6.19-rc5-mm2/arch/powerpc/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/arch/powerpc/kernel/kprobes.c
+++ linux-2.6.19-rc5-mm2/arch/powerpc/kernel/kprobes.c
@@ -85,7 +85,7 @@ void __kprobes arch_disarm_kprobe(struct
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 	mutex_lock(&kprobe_mutex);
-	free_insn_slot(p->ainsn.insn);
+	free_insn_slot(p->ainsn.insn, 0);
 	mutex_unlock(&kprobe_mutex);
 }

Index: linux-2.6.19-rc5-mm2/arch/s390/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/arch/s390/kernel/kprobes.c
+++ linux-2.6.19-rc5-mm2/arch/s390/kernel/kprobes.c
@@ -200,7 +200,7 @@ void __kprobes arch_disarm_kprobe(struct
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 	mutex_lock(&kprobe_mutex);
-	free_insn_slot(p->ainsn.insn);
+	free_insn_slot(p->ainsn.insn, 0);
 	mutex_unlock(&kprobe_mutex);
 }

Index: linux-2.6.19-rc5-mm2/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/arch/x86_64/kernel/kprobes.c
+++ linux-2.6.19-rc5-mm2/arch/x86_64/kernel/kprobes.c
@@ -224,7 +224,7 @@ void __kprobes arch_disarm_kprobe(struct
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 	mutex_lock(&kprobe_mutex);
-	free_insn_slot(p->ainsn.insn);
+	free_insn_slot(p->ainsn.insn, 0);
 	mutex_unlock(&kprobe_mutex);
 }

Index: linux-2.6.19-rc5-mm2/include/linux/kprobes.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/kprobes.h
+++ linux-2.6.19-rc5-mm2/include/linux/kprobes.h
@@ -165,7 +165,7 @@ extern void arch_disarm_kprobe(struct kp
 extern int arch_init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern kprobe_opcode_t *get_insn_slot(void);
-extern void free_insn_slot(kprobe_opcode_t *slot);
+extern void free_insn_slot(kprobe_opcode_t *slot, int dirty);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);

 /* Get the kprobe at this addr (if any) - called with preemption disabled */


