Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVGHLCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVGHLCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVGHLCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:02:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29826 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262495AbVGHLCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:02:24 -0400
Date: Fri, 8 Jul 2005 16:32:32 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [1/6 PATCH] Kprobes : Prevent possible race conditions generic changes
Message-ID: <20050708110232.GE29277@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050707101015.GE12106@in.ibm.com> <20050707032537.7588acb9.akpm@osdl.org> <20050707103421.GU21330@wotan.suse.de> <20050707130134.GA29266@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707130134.GA29266@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I have modified the patches as per your's and Andi's comments.
Also modified entry.S for i386 and x86_64 architecture, to move
few exception handlers page fault, general protection, int3, debug
to .kprobes.text section. Also ia64 specific patch contains more
routines from jprobes.S file as per Anil's comment.

Please let me know if you have any issues.

Thanks
Prasanna


There are possible race conditions if probes are placed on routines within the
kprobes files and routines used by the kprobes. For example if you put probe on
get_kprobe() routines, the system can hang while inserting probes on
any routine such as do_fork(). Because while inserting probes on do_fork(),
register_kprobes() routine grabs the kprobes spin lock and executes get_kprobe()
routine and to handle probe of get_kprobe(), kprobes_handler() gets executed 
and tries to grab kprobes spin lock, and spins forever. This patch avoids such
possible race conditions by preventing probes on routines within the kprobes
file and routines used by kprobes.

I have modified the patches as per Andi Kleen's suggestion to move kprobes
routines and other routines used by kprobes to a seperate section .kprobes.text.
Also moved page fault and exception handlers, general protection fault to 
.kprobes.text section.
These patches have been tested on i386, x86_64 and ppc64 architectures,
also compiled on ia64 and sparc64 architectures.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.13-rc1-mm1-prasanna/include/asm-generic/sections.h    |    1 
 linux-2.6.13-rc1-mm1-prasanna/include/asm-generic/vmlinux.lds.h |    5 
 linux-2.6.13-rc1-mm1-prasanna/include/linux/kprobes.h           |    3 
 linux-2.6.13-rc1-mm1-prasanna/include/linux/linkage.h           |    7 
 linux-2.6.13-rc1-mm1-prasanna/kernel/kprobes.c                  |   72 +++++-----
 5 files changed, 59 insertions(+), 29 deletions(-)

diff -puN kernel/kprobes.c~kprobes-exclude-functions-generic kernel/kprobes.c
--- linux-2.6.13-rc1-mm1/kernel/kprobes.c~kprobes-exclude-functions-generic	2005-07-08 14:05:14.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/kernel/kprobes.c	2005-07-08 14:05:14.000000000 +0530
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
+#include <asm-generic/sections.h>
 #include <asm/cacheflush.h>
 #include <asm/errno.h>
 #include <asm/kdebug.h>
@@ -72,7 +73,7 @@ static struct hlist_head kprobe_insn_pag
  * get_insn_slot() - Find a slot on an executable page for an instruction.
  * We allocate an executable page if there's no room on existing ones.
  */
-kprobe_opcode_t *get_insn_slot(void)
+kprobe_opcode_t __kprobes *get_insn_slot(void)
 {
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;
@@ -117,7 +118,7 @@ kprobe_opcode_t *get_insn_slot(void)
 	return kip->insns;
 }
 
-void free_insn_slot(kprobe_opcode_t *slot)
+void __kprobes free_insn_slot(kprobe_opcode_t *slot)
 {
 	struct kprobe_insn_page *kip;
 	struct hlist_node *pos;
@@ -152,20 +153,20 @@ void free_insn_slot(kprobe_opcode_t *slo
 }
 
 /* Locks kprobe: irqs must be disabled */
-void lock_kprobes(void)
+void __kprobes lock_kprobes(void)
 {
 	spin_lock(&kprobe_lock);
 	kprobe_cpu = smp_processor_id();
 }
 
-void unlock_kprobes(void)
+void __kprobes unlock_kprobes(void)
 {
 	kprobe_cpu = NR_CPUS;
 	spin_unlock(&kprobe_lock);
 }
 
 /* You have to be holding the kprobe_lock */
-struct kprobe *get_kprobe(void *addr)
+struct kprobe __kprobes *get_kprobe(void *addr)
 {
 	struct hlist_head *head;
 	struct hlist_node *node;
@@ -183,7 +184,7 @@ struct kprobe *get_kprobe(void *addr)
  * Aggregate handlers for multiple kprobes support - these handlers
  * take care of invoking the individual kprobe handlers on p->list
  */
-static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe *kp;
 
@@ -198,8 +199,8 @@ static int aggr_pre_handler(struct kprob
 	return 0;
 }
 
-static void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
-			      unsigned long flags)
+static void __kprobes aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
+					unsigned long flags)
 {
 	struct kprobe *kp;
 
@@ -213,8 +214,8 @@ static void aggr_post_handler(struct kpr
 	return;
 }
 
-static int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
-			      int trapnr)
+static int __kprobes aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
+					int trapnr)
 {
 	/*
 	 * if we faulted "during" the execution of a user specified
@@ -227,7 +228,7 @@ static int aggr_fault_handler(struct kpr
 	return 0;
 }
 
-static int aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes aggr_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kprobe *kp = curr_kprobe;
 	if (curr_kprobe && kp->break_handler) {
@@ -240,7 +241,7 @@ static int aggr_break_handler(struct kpr
 	return 0;
 }
 
-struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp)
+struct kretprobe_instance __kprobes *get_free_rp_inst(struct kretprobe *rp)
 {
 	struct hlist_node *node;
 	struct kretprobe_instance *ri;
@@ -249,7 +250,8 @@ struct kretprobe_instance *get_free_rp_i
 	return NULL;
 }
 
-static struct kretprobe_instance *get_used_rp_inst(struct kretprobe *rp)
+static struct kretprobe_instance __kprobes *get_used_rp_inst(struct kretprobe
+							      *rp)
 {
 	struct hlist_node *node;
 	struct kretprobe_instance *ri;
@@ -258,7 +260,7 @@ static struct kretprobe_instance *get_us
 	return NULL;
 }
 
-void add_rp_inst(struct kretprobe_instance *ri)
+void __kprobes add_rp_inst(struct kretprobe_instance *ri)
 {
 	/*
 	 * Remove rp inst off the free list -
@@ -276,7 +278,7 @@ void add_rp_inst(struct kretprobe_instan
 	hlist_add_head(&ri->uflist, &ri->rp->used_instances);
 }
 
-void recycle_rp_inst(struct kretprobe_instance *ri)
+void __kprobes recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	/* remove rp inst off the rprobe_inst_table */
 	hlist_del(&ri->hlist);
@@ -291,7 +293,7 @@ void recycle_rp_inst(struct kretprobe_in
 		kfree(ri);
 }
 
-struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk)
+struct hlist_head __kprobes *kretprobe_inst_table_head(struct task_struct *tsk)
 {
 	return &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
 }
@@ -302,7 +304,7 @@ struct hlist_head * kretprobe_inst_table
  * instances associated with this task. These left over instances represent
  * probed functions that have been called but will never return.
  */
-void kprobe_flush_task(struct task_struct *tk)
+void __kprobes kprobe_flush_task(struct task_struct *tk)
 {
         struct kretprobe_instance *ri;
         struct hlist_head *head;
@@ -322,7 +324,8 @@ void kprobe_flush_task(struct task_struc
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.
  */
-static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes pre_handler_kretprobe(struct kprobe *p,
+					   struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
 
@@ -353,7 +356,7 @@ static inline void copy_kprobe(struct kp
 * Add the new probe to old_p->list. Fail if this is the
 * second jprobe at the address - two jprobes can't coexist
 */
-static int add_new_kprobe(struct kprobe *old_p, struct kprobe *p)
+static int __kprobes add_new_kprobe(struct kprobe *old_p, struct kprobe *p)
 {
         struct kprobe *kp;
 
@@ -395,7 +398,8 @@ static inline void add_aggr_kprobe(struc
  * the intricacies
  * TODO: Move kcalloc outside the spinlock
  */
-static int register_aggr_kprobe(struct kprobe *old_p, struct kprobe *p)
+static int __kprobes register_aggr_kprobe(struct kprobe *old_p,
+					  struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap;
@@ -434,15 +438,25 @@ static inline void cleanup_aggr_kprobe(s
 		spin_unlock_irqrestore(&kprobe_lock, flags);
 }
 
-int register_kprobe(struct kprobe *p)
+static int __kprobes in_kprobes_functions(unsigned long addr)
+{
+	if (addr >= (unsigned long)__kprobes_text_start
+		&& addr < (unsigned long)__kprobes_text_end)
+		return -EINVAL;
+	return 0;
+}
+
+int __kprobes register_kprobe(struct kprobe *p)
 {
 	int ret = 0;
 	unsigned long flags = 0;
 	struct kprobe *old_p;
 
-	if ((ret = arch_prepare_kprobe(p)) != 0) {
+	if ((ret = in_kprobes_functions((unsigned long) p->addr)) != 0)
+		return ret;
+	if ((ret = arch_prepare_kprobe(p)) != 0)
 		goto rm_kprobe;
-	}
+
 	spin_lock_irqsave(&kprobe_lock, flags);
 	old_p = get_kprobe(p->addr);
 	p->nmissed = 0;
@@ -466,7 +480,7 @@ rm_kprobe:
 	return ret;
 }
 
-void unregister_kprobe(struct kprobe *p)
+void __kprobes unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
 	struct kprobe *old_p;
@@ -487,7 +501,7 @@ static struct notifier_block kprobe_exce
 	.priority = 0x7fffffff /* we need to notified first */
 };
 
-int register_jprobe(struct jprobe *jp)
+int __kprobes register_jprobe(struct jprobe *jp)
 {
 	/* Todo: Verify probepoint is a function entry point */
 	jp->kp.pre_handler = setjmp_pre_handler;
@@ -496,14 +510,14 @@ int register_jprobe(struct jprobe *jp)
 	return register_kprobe(&jp->kp);
 }
 
-void unregister_jprobe(struct jprobe *jp)
+void __kprobes unregister_jprobe(struct jprobe *jp)
 {
 	unregister_kprobe(&jp->kp);
 }
 
 #ifdef ARCH_SUPPORTS_KRETPROBES
 
-int register_kretprobe(struct kretprobe *rp)
+int __kprobes register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
 	struct kretprobe_instance *inst;
@@ -540,14 +554,14 @@ int register_kretprobe(struct kretprobe 
 
 #else /* ARCH_SUPPORTS_KRETPROBES */
 
-int register_kretprobe(struct kretprobe *rp)
+int __kprobes register_kretprobe(struct kretprobe *rp)
 {
 	return -ENOSYS;
 }
 
 #endif /* ARCH_SUPPORTS_KRETPROBES */
 
-void unregister_kretprobe(struct kretprobe *rp)
+void __kprobes unregister_kretprobe(struct kretprobe *rp)
 {
 	unsigned long flags;
 	struct kretprobe_instance *ri;
diff -puN include/linux/kprobes.h~kprobes-exclude-functions-generic include/linux/kprobes.h
--- linux-2.6.13-rc1-mm1/include/linux/kprobes.h~kprobes-exclude-functions-generic	2005-07-08 14:05:14.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/include/linux/kprobes.h	2005-07-08 14:05:14.000000000 +0530
@@ -42,6 +42,9 @@
 #define KPROBE_REENTER		0x00000004
 #define KPROBE_HIT_SSDONE	0x00000008
 
+/* Attach to insert probes on any functions which should be ignored*/
+#define __kprobes	__attribute__((__section__(".kprobes.text")))
+
 struct kprobe;
 struct pt_regs;
 struct kretprobe;
diff -puN include/asm-generic/vmlinux.lds.h~kprobes-exclude-functions-generic include/asm-generic/vmlinux.lds.h
--- linux-2.6.13-rc1-mm1/include/asm-generic/vmlinux.lds.h~kprobes-exclude-functions-generic	2005-07-08 14:05:14.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/include/asm-generic/vmlinux.lds.h	2005-07-08 14:05:14.000000000 +0530
@@ -95,3 +95,8 @@
 		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
 		VMLINUX_SYMBOL(__lock_text_end) = .;
+
+#define KPROBES_TEXT							\
+		VMLINUX_SYMBOL(__kprobes_text_start) = .;			\
+		*(.kprobes.text)					\
+		VMLINUX_SYMBOL(__kprobes_text_end) = .;
diff -puN include/asm-generic/sections.h~kprobes-exclude-functions-generic include/asm-generic/sections.h
--- linux-2.6.13-rc1-mm1/include/asm-generic/sections.h~kprobes-exclude-functions-generic	2005-07-08 14:05:14.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/include/asm-generic/sections.h	2005-07-08 14:05:14.000000000 +0530
@@ -11,5 +11,6 @@ extern char _sinittext[], _einittext[];
 extern char _sextratext[] __attribute__((weak));
 extern char _eextratext[] __attribute__((weak));
 extern char _end[];
+extern char __kprobes_text_start[], __kprobes_text_end[];
 
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
diff -puN arch/i386/kernel/entry.S~kprobes-exclude-functions-generic arch/i386/kernel/entry.S
diff -puN include/linux/linkage.h~kprobes-exclude-functions-generic include/linux/linkage.h
--- linux-2.6.13-rc1-mm1/include/linux/linkage.h~kprobes-exclude-functions-generic	2005-07-08 14:05:14.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/include/linux/linkage.h	2005-07-08 14:05:27.000000000 +0530
@@ -33,6 +33,13 @@
   ALIGN; \
   name:
 
+#define KPROBE_ENTRY(name) \
+  .section .kprobes.text, "ax"; \
+  .globl name; \
+  ALIGN; \
+  name:
+
+
 #endif
 
 #define NORET_TYPE    /**/

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
