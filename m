Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVFQPZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVFQPZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVFQPZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:25:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:31653 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261993AbVFQPXx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:23:53 -0400
Date: Fri, 17 Jun 2005 11:23:06 -0400
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulus@samba.org, anton@samba.org, akpm@osdl.org, ak@muc.de,
       prasanna@in.ibm.com, systemtap@sources.redhat.com
Subject: [PATCH] kprobes: fix single-step out of line - take2
Message-ID: <20050617152306.GA7913@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the second try to fix the single-step out of line issues for
PPC64 now that the kernel has no-execute support.

x86_64 also has no-execute support and kprobes on x86_64 solved this
issue by allocating an executable kernel page and using it as a scratch
area for instructions to be stepped out of line. Reuse that for PPC64 too.

Thanks,
Ananth


Now that PPC64 has no-execute support, here is a second try to fix the
single step out of line during kprobe execution. Kprobes on x86_64 already
solved this problem by allocating an executable page and using it as the
scratch area for stepping out of line. Reuse that.

Patch against 2.6.12-rc6-git8

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

 arch/ppc64/kernel/kprobes.c  |   26 ++++++++-
 arch/x86_64/kernel/kprobes.c |  112 -------------------------------------------
 include/asm-ppc64/kprobes.h  |    2 
 include/linux/kprobes.h      |    2 
 kernel/kprobes.c             |  101 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 117 deletions(-)

Index: linux-2.6.12-rc6/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6.orig/arch/ppc64/kernel/kprobes.c	2005-06-16 14:44:40.000000000 -0400
+++ linux-2.6.12-rc6/arch/ppc64/kernel/kprobes.c	2005-06-16 14:53:51.000000000 -0400
@@ -39,6 +39,8 @@
 #define KPROBE_HIT_ACTIVE	0x00000001
 #define KPROBE_HIT_SS		0x00000002
 
+static DECLARE_MUTEX(kprobe_mutex);
+
 static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_saved_msr;
 static struct pt_regs jprobe_saved_regs;
@@ -55,6 +57,15 @@ int arch_prepare_kprobe(struct kprobe *p
 		printk("Cannot register a kprobe on rfid or mtmsrd\n");
 		ret = -EINVAL;
 	}
+
+	/* insn must be on a special executable page on ppc64 */
+	if (!ret) {
+		up(&kprobe_mutex);
+		p->ainsn.insn = get_insn_slot();
+		down(&kprobe_mutex);
+		if (!p->ainsn.insn)
+			ret = -ENOMEM;
+	}
 	return ret;
 }
 
@@ -65,6 +76,9 @@ void arch_copy_kprobe(struct kprobe *p)
 
 void arch_remove_kprobe(struct kprobe *p)
 {
+	up(&kprobe_mutex);
+	free_insn_slot(p->ainsn.insn);
+	down(&kprobe_mutex);
 }
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
@@ -75,12 +89,15 @@ static inline void disarm_kprobe(struct 
 
 static inline void prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
+	kprobe_opcode_t insn = *p->ainsn.insn;
+
 	regs->msr |= MSR_SE;
-	/*single step inline if it a breakpoint instruction*/
-	if (p->opcode == BREAKPOINT_INSTRUCTION)
+
+	/* single step inline if it is a trap variant */
+	if (IS_TW(insn) || IS_TD(insn) || IS_TWI(insn) || IS_TDI(insn))
 		regs->nip = (unsigned long)p->addr;
 	else
-		regs->nip = (unsigned long)&p->ainsn.insn;
+		regs->nip = (unsigned long)p->ainsn.insn;
 }
 
 static inline int kprobe_handler(struct pt_regs *regs)
@@ -172,9 +189,10 @@ no_kprobe:
 static void resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
 	int ret;
+	unsigned int insn = *p->ainsn.insn;
 
 	regs->nip = (unsigned long)p->addr;
-	ret = emulate_step(regs, p->ainsn.insn[0]);
+	ret = emulate_step(regs, insn);
 	if (ret == 0)
 		regs->nip = (unsigned long)p->addr + 4;
 }
Index: linux-2.6.12-rc6/arch/x86_64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6.orig/arch/x86_64/kernel/kprobes.c	2005-06-06 11:22:29.000000000 -0400
+++ linux-2.6.12-rc6/arch/x86_64/kernel/kprobes.c	2005-06-16 14:58:38.000000000 -0400
@@ -36,7 +36,6 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/preempt.h>
-#include <linux/moduleloader.h>
 
 #include <asm/pgtable.h>
 #include <asm/kdebug.h>
@@ -51,8 +50,6 @@ static struct kprobe *current_kprobe;
 static unsigned long kprobe_status, kprobe_old_rflags, kprobe_saved_rflags;
 static struct pt_regs jprobe_saved_regs;
 static long *jprobe_saved_rsp;
-static kprobe_opcode_t *get_insn_slot(void);
-static void free_insn_slot(kprobe_opcode_t *slot);
 void jprobe_return_end(void);
 
 /* copy of the kernel stack at the probe fire time */
@@ -527,112 +524,3 @@ int longjmp_break_handler(struct kprobe 
 	}
 	return 0;
 }
-
-/*
- * kprobe->ainsn.insn points to the copy of the instruction to be single-stepped.
- * By default on x86_64, pages we get from kmalloc or vmalloc are not
- * executable.  Single-stepping an instruction on such a page yields an
- * oops.  So instead of storing the instruction copies in their respective
- * kprobe objects, we allocate a page, map it executable, and store all the
- * instruction copies there.  (We can allocate additional pages if somebody
- * inserts a huge number of probes.)  Each page can hold up to INSNS_PER_PAGE
- * instruction slots, each of which is MAX_INSN_SIZE*sizeof(kprobe_opcode_t)
- * bytes.
- */
-#define INSNS_PER_PAGE (PAGE_SIZE/(MAX_INSN_SIZE*sizeof(kprobe_opcode_t)))
-struct kprobe_insn_page {
-	struct hlist_node hlist;
-	kprobe_opcode_t *insns;		/* page of instruction slots */
-	char slot_used[INSNS_PER_PAGE];
-	int nused;
-};
-
-static struct hlist_head kprobe_insn_pages;
-
-/**
- * get_insn_slot() - Find a slot on an executable page for an instruction.
- * We allocate an executable page if there's no room on existing ones.
- */
-static kprobe_opcode_t *get_insn_slot(void)
-{
-	struct kprobe_insn_page *kip;
-	struct hlist_node *pos;
-
-	hlist_for_each(pos, &kprobe_insn_pages) {
-		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
-		if (kip->nused < INSNS_PER_PAGE) {
-			int i;
-			for (i = 0; i < INSNS_PER_PAGE; i++) {
-				if (!kip->slot_used[i]) {
-					kip->slot_used[i] = 1;
-					kip->nused++;
-					return kip->insns + (i*MAX_INSN_SIZE);
-				}
-			}
-			/* Surprise!  No unused slots.  Fix kip->nused. */
-			kip->nused = INSNS_PER_PAGE;
-		}
-	}
-
-	/* All out of space.  Need to allocate a new page. Use slot 0.*/
-	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_KERNEL);
-	if (!kip) {
-		return NULL;
-	}
-
-	/*
-	 * For the %rip-relative displacement fixups to be doable, we
-	 * need our instruction copy to be within +/- 2GB of any data it
-	 * might access via %rip.  That is, within 2GB of where the
-	 * kernel image and loaded module images reside.  So we allocate
-	 * a page in the module loading area.
-	 */
-	kip->insns = module_alloc(PAGE_SIZE);
-	if (!kip->insns) {
-		kfree(kip);
-		return NULL;
-	}
-	INIT_HLIST_NODE(&kip->hlist);
-	hlist_add_head(&kip->hlist, &kprobe_insn_pages);
-	memset(kip->slot_used, 0, INSNS_PER_PAGE);
-	kip->slot_used[0] = 1;
-	kip->nused = 1;
-	return kip->insns;
-}
-
-/**
- * free_insn_slot() - Free instruction slot obtained from get_insn_slot().
- */
-static void free_insn_slot(kprobe_opcode_t *slot)
-{
-	struct kprobe_insn_page *kip;
-	struct hlist_node *pos;
-
-	hlist_for_each(pos, &kprobe_insn_pages) {
-		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
-		if (kip->insns <= slot
-		    && slot < kip->insns+(INSNS_PER_PAGE*MAX_INSN_SIZE)) {
-			int i = (slot - kip->insns) / MAX_INSN_SIZE;
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
-			}
-			return;
-		}
-	}
-}
Index: linux-2.6.12-rc6/include/linux/kprobes.h
===================================================================
--- linux-2.6.12-rc6.orig/include/linux/kprobes.h	2005-06-06 11:22:29.000000000 -0400
+++ linux-2.6.12-rc6/include/linux/kprobes.h	2005-06-16 15:01:13.000000000 -0400
@@ -101,6 +101,8 @@ extern int arch_prepare_kprobe(struct kp
 extern void arch_copy_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
 extern void show_registers(struct pt_regs *regs);
+extern kprobe_opcode_t *get_insn_slot(void);
+extern void free_insn_slot(kprobe_opcode_t *slot);
 
 /* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
 struct kprobe *get_kprobe(void *addr);
Index: linux-2.6.12-rc6/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc6.orig/kernel/kprobes.c	2005-06-06 11:22:29.000000000 -0400
+++ linux-2.6.12-rc6/kernel/kprobes.c	2005-06-17 08:50:47.000000000 -0400
@@ -33,6 +33,7 @@
 #include <linux/hash.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/kdebug.h>
@@ -46,6 +47,106 @@ unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
 static struct kprobe *curr_kprobe;
 
+/*
+ * kprobe->ainsn.insn points to the copy of the instruction to be
+ * single-stepped. x86_64, POWER4 and above have no-exec support and
+ * stepping on the instruction on a vmalloced/kmalloced/data page
+ * is a recipe for disaster
+ */
+#define INSNS_PER_PAGE	(PAGE_SIZE/(MAX_INSN_SIZE * sizeof(kprobe_opcode_t)))
+
+struct kprobe_insn_page {
+	struct hlist_node hlist;
+	kprobe_opcode_t *insns;		/* Page of instruction slots */
+	char slot_used[INSNS_PER_PAGE];
+	int nused;
+};
+
+static struct hlist_head kprobe_insn_pages;
+
+/**
+ * get_insn_slot() - Find a slot on an executable page for an instruction.
+ * We allocate an executable page if there's no room on existing ones.
+ */
+kprobe_opcode_t *get_insn_slot(void)
+{
+	struct kprobe_insn_page *kip;
+	struct hlist_node *pos;
+
+	hlist_for_each(pos, &kprobe_insn_pages) {
+		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
+		if (kip->nused < INSNS_PER_PAGE) {
+			int i;
+			for (i = 0; i < INSNS_PER_PAGE; i++) {
+				if (!kip->slot_used[i]) {
+					kip->slot_used[i] = 1;
+					kip->nused++;
+					return kip->insns + (i * MAX_INSN_SIZE);
+				}
+			}
+			/* Surprise!  No unused slots.  Fix kip->nused. */
+			kip->nused = INSNS_PER_PAGE;
+		}
+	}
+
+	/* All out of space.  Need to allocate a new page. Use slot 0.*/
+	kip = kmalloc(sizeof(struct kprobe_insn_page), GFP_KERNEL);
+	if (!kip) {
+		return NULL;
+	}
+
+	/*
+	 * Use module_alloc so this page is within +/- 2GB of where the
+	 * kernel image and loaded module images reside. This is required
+	 * so x86_64 can correctly handle the %rip-relative fixups.
+	 */
+	kip->insns = module_alloc(PAGE_SIZE);
+	if (!kip->insns) {
+		kfree(kip);
+		return NULL;
+	}
+	INIT_HLIST_NODE(&kip->hlist);
+	hlist_add_head(&kip->hlist, &kprobe_insn_pages);
+	memset(kip->slot_used, 0, INSNS_PER_PAGE);
+	kip->slot_used[0] = 1;
+	kip->nused = 1;
+	return kip->insns;
+}
+
+void free_insn_slot(kprobe_opcode_t *slot)
+{
+	struct kprobe_insn_page *kip;
+	struct hlist_node *pos;
+
+	hlist_for_each(pos, &kprobe_insn_pages) {
+		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
+		if (kip->insns <= slot &&
+		    slot < kip->insns + (INSNS_PER_PAGE * MAX_INSN_SIZE)) {
+			int i = (slot - kip->insns) / MAX_INSN_SIZE;
+			kip->slot_used[i] = 0;
+			kip->nused--;
+			if (kip->nused == 0) {
+				/*
+				 * Page is no longer in use.  Free it unless
+				 * it's the last one.  We keep the last one
+				 * so as not to have to set it up again the
+				 * next time somebody inserts a probe.
+				 */
+				hlist_del(&kip->hlist);
+				if (hlist_empty(&kprobe_insn_pages)) {
+					INIT_HLIST_NODE(&kip->hlist);
+					hlist_add_head(&kip->hlist,
+						&kprobe_insn_pages);
+				} else {
+					module_free(NULL, kip->insns);
+					kfree(kip);
+				}
+			}
+			return;
+		}
+	}
+}
+
 /* Locks kprobe: irqs must be disabled */
 void lock_kprobes(void)
 {
Index: linux-2.6.12-rc6/include/asm-ppc64/kprobes.h
===================================================================
--- linux-2.6.12-rc6.orig/include/asm-ppc64/kprobes.h	2005-06-17 09:32:24.000000000 -0400
+++ linux-2.6.12-rc6/include/asm-ppc64/kprobes.h	2005-06-17 09:32:49.000000000 -0400
@@ -45,7 +45,7 @@ typedef unsigned int kprobe_opcode_t;
 /* Architecture specific copy of original instruction */
 struct arch_specific_insn {
 	/* copy of original instruction */
-	kprobe_opcode_t insn[MAX_INSN_SIZE];
+	kprobe_opcode_t *insn;
 };
 
 #ifdef CONFIG_KPROBES
