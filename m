Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVEFQfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVEFQfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFQfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 12:35:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:37518 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261200AbVEFQd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 12:33:58 -0400
Subject: [RCF][PATCH] kprobes: function-return probes
From: Hien Nguyen <hien@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davem@davemloft.net, ak@muc.de, suparna@in.ibm.com,
       prasanna@in.ibm.com, systemtap@sources.redhat.com
Content-Type: text/plain
Date: Fri, 06 May 2005 09:33:53 -0700
Message-Id: <1115397233.32443.36.camel@dyn319653.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds function-return probes to kprobes for the i386
architecture. This enables you to establish a handler to be run when a
function returns. 

1. API

Two new functions are added to kprobes:

int register_kretprobe(struct kretprobe *rp);
void unregister_kretprobe(struct kretprobe *rp);

2. Registration and unregistration

2.1 Register

To register a function-return probe, the user populates the following 
fields in a kretprobe object and calls register_kretprobe() with the
kretprobe address as an argument:

kp.addr - the function's address

handler - this function is run after the ret instruction executes, 
but before control returns to the return address in the caller.

maxactive - The maximum number of instances of the probed function 
that can be active concurrently.  For example, if the function is non-
recursive and is called with a spinlock or mutex held, maxactive = 1
should be enough.  If the function is non-recursive and can never
relinquish the CPU (e.g., via a semaphore or preemption), NR_CPUS should
be enough. maxactive is used to determine how many kretprobe_instance
objects to allocate for this particular probed function.  If maxactive
<= 0, it is set to a default value (if CONFIG_PREEMPT 
maxactive=max(10, 2 * NR_CPUS) else maxactive=NR_CPUS)

For example:

struct kretprobe rp; 
rp.kp.addr = /* entrypoint address */
rp.handler = /*return probe handler */
rp.maxactive = /* e.g., 1 or NR_CPUS or 0, see the above explanation */  
register_kretprobe(&rp);

The following field may also be of interest:

nmissed - Initialized to zero when the function-return probe is
registered, and incremented every time the probed function is entered
but there is no kretprobe_instance object available for establishing the
function-return probe (i.e., because maxactive was set too low).

2.2 Unregister

To unregiter a function-return probe, the user calls
unregister_kretprobe() with the same kretprobe object as registered
previously. If a probed function is running when the return probe is
unregistered, the function will return as expected, but the handler
won't be run.


3. Limitations

3.1 This patch supports only the i386 architecture, but patches for
x86_64 and ppc64 are anticipated soon.

3.2 Return probes operates by replacing the return address in the stack
(or in a known register, such as the lr register for ppc).  This may
cause __builtin_return_address(0), when invoked from the return-probed
function, to return the address of the return-probes trampoline.

3.3 This implementation uses the "Multiprobes at an address" feature in
2.6.12-rc3-mm3.

3.4 Due to a limitation in multi-probes, you cannot currently establish
a return probe and a jprobe on the same function. A patch to remove this
limitation is being tested.

This feature is required by SystemTap (http://sourceware.org/systemtap),
and reflects ideas contributed by several SystemTap developers,
including Will Cohen and Ananth Mavinakayanahalli.

Signed-off-by: Hien Nguyen <hien@us.ibm.com>



 arch/i386/kernel/kprobes.c |   89 ++++++++++++++++++
 arch/i386/kernel/process.c |   15 +++
 include/asm-i386/kprobes.h |    3 
 include/linux/kprobes.h    |   74 +++++++++++++++
 kernel/kprobes.c           |  211 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 389 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc3-mm3/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/arch/i386/kernel/kprobes.c	2005-05-05 10:24:54.000000000 -0700
+++ linux-2.6.12-rc3-mm3/arch/i386/kernel/kprobes.c	2005-05-05 16:50:40.000000000 -0700
@@ -23,6 +23,9 @@
  *		Rusty Russell).
  * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
  *		interface to access function arguments.
+ * 2005-May	Hien Nguyen <hien@us.ibm.com>, Jim Keniston
+ *		<jkenisto@us.ibm.com> and Prasanna S Panchamukhi
+ *		<prasanna@in.ibm.com> added function-return probes.
  */
 
 #include <linux/config.h>
@@ -91,6 +94,40 @@ static inline void prepare_singlestep(st
 		regs->eip = (unsigned long)&p->ainsn.insn;
 }
 
+struct task_struct  *arch_get_kprobe_task(void *ptr)
+{
+	return ((struct thread_info *) (((unsigned long) ptr) &
+					(~(THREAD_SIZE -1))))->task;
+}
+
+void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+{
+	unsigned long *sara = (unsigned long *)&regs->esp;
+	struct kretprobe_instance *ri;
+	static void *orig_ret_addr;
+
+	/*
+	 * Save the return address when the return probe hits
+	 * the first time, and use it to populate the (krprobe
+	 * instance)->ret_addr for subsequent return probes at
+	 * the same addrress since stack address would have
+	 * the kretprobe_trampoline by then.
+	 */
+	if (((void*) *sara) != kretprobe_trampoline)
+		orig_ret_addr = (void*) *sara;
+
+	if ((ri = get_free_rp_inst(rp)) != NULL) {
+		ri->rp = rp;
+		ri->stack_addr = sara;
+		ri->ret_addr = orig_ret_addr;
+		add_rp_inst(ri);
+		/* Replace the return addr with trampoline addr */
+		*sara = (unsigned long) &kretprobe_trampoline;
+	} else {
+		rp->nmissed++;
+	}
+}
+
 /*
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled thorough out this function.
@@ -184,6 +221,55 @@ no_kprobe:
 }
 
 /*
+ * For function-return probes, init_kprobes() establishes a probepoint
+ * here. When a retprobed function returns, this probe is hit and
+ * trampoline_probe_handler() runs, calling the kretprobe's handler.
+ */
+ void kretprobe_trampoline_holder(void)
+ {
+ 	asm volatile (  ".global kretprobe_trampoline\n"
+ 			"kretprobe_trampoline: \n"
+ 			"nop\n");
+ }
+
+/*
+ * Called when we hit the probe point at kretprobe_trampoline
+ */
+int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct task_struct *tsk;
+	struct kretprobe_instance *ri;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	unsigned long *sara = ((unsigned long *) &regs->esp) - 1;
+
+	tsk = arch_get_kprobe_task(sara);
+	head = kretprobe_inst_table_head(tsk);
+
+	hlist_for_each_entry(ri, node, head, hlist) {
+		if (ri->stack_addr == sara && ri->rp) {
+			if (ri->rp->handler)
+				ri->rp->handler(ri, regs);
+		}
+	}
+	return 0;
+}
+
+void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
+						unsigned long flags)
+{
+	struct kretprobe_instance *ri;
+	/* RA already popped */
+	unsigned long *sara = ((unsigned long *)&regs->esp) - 1;
+
+	while ((ri = get_rp_inst(sara))) {
+		regs->eip = (unsigned long)ri->ret_addr;
+		recycle_rp_inst(ri);
+	}
+	regs->eflags &= ~TF_MASK;
+}
+
+/*
  * Called after single-stepping.  p->addr is the address of the
  * instruction whose first byte has been replaced by the "int 3"
  * instruction.  To avoid the SMP problems that can occur when we
@@ -266,7 +352,8 @@ static inline int post_kprobe_handler(st
 	if (current_kprobe->post_handler)
 		current_kprobe->post_handler(current_kprobe, regs, 0);
 
-	resume_execution(current_kprobe, regs);
+	if (current_kprobe->post_handler != trampoline_post_handler)
+		resume_execution(current_kprobe, regs);
 	regs->eflags |= kprobe_saved_eflags;
 
 	unlock_kprobes();
Index: linux-2.6.12-rc3-mm3/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/arch/i386/kernel/process.c	2005-05-05 10:24:54.000000000 -0700
+++ linux-2.6.12-rc3-mm3/arch/i386/kernel/process.c	2005-05-05 16:50:40.000000000 -0700
@@ -39,6 +39,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/kprobes.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -368,6 +369,13 @@ void exit_thread(void)
 {
 	struct task_struct *tsk = current;
 	struct thread_struct *t = &tsk->thread;
+
+	/*
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(tsk);
 
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(NULL != t->io_bitmap_ptr)) {
@@ -393,6 +401,13 @@ void flush_thread(void)
 {
 	struct task_struct *tsk = current;
 
+	/*
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(tsk);
+
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
 	/*
Index: linux-2.6.12-rc3-mm3/include/asm-i386/kprobes.h
===================================================================
--- linux-2.6.12-rc3-mm3.orig/include/asm-i386/kprobes.h	2005-03-01 23:38:12.000000000 -0800
+++ linux-2.6.12-rc3-mm3/include/asm-i386/kprobes.h	2005-05-05 16:50:40.000000000 -0700
@@ -39,6 +39,9 @@ typedef u8 kprobe_opcode_t;
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+#define arch_supports_kretprobes 1
+
+void kretprobe_trampoline(void);
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {
Index: linux-2.6.12-rc3-mm3/include/linux/kprobes.h
===================================================================
--- linux-2.6.12-rc3-mm3.orig/include/linux/kprobes.h	2005-05-05 10:25:16.000000000 -0700
+++ linux-2.6.12-rc3-mm3/include/linux/kprobes.h	2005-05-05 16:50:40.000000000 -0700
@@ -25,6 +25,9 @@
  *		Rusty Russell).
  * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
  *		interface to access function arguments.
+ * 2005-May	Hien Nguyen <hien@us.ibm.com> and Jim Keniston
+ *		<jkenisto@us.ibm.com>  and Prasanna S Panchamukhi
+ *		<prasanna@in.ibm.com> added function-return probes.
  */
 #include <linux/config.h>
 #include <linux/list.h>
@@ -34,12 +37,16 @@
 
 struct kprobe;
 struct pt_regs;
+struct kretprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
 typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
 typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
 				       int trapnr);
+typedef int (*kretprobe_handler_t) (struct kretprobe_instance *,
+				    struct pt_regs *);
+
 struct kprobe {
 	struct hlist_node hlist;
 
@@ -85,6 +92,53 @@ struct jprobe {
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };
 
+#ifdef arch_supports_kretprobes
+extern int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs);
+extern void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
+							unsigned long flags);
+extern struct task_struct *arch_get_kprobe_task(void *ptr);
+#else
+#define arch_supports_kretprobes		0
+static void kretprobe_trampoline(void)
+{
+}
+static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return 0;
+}
+static void trampoline_post_handler(struct kprobe *p, struct pt_regs *regs,
+							unsigned long flags)
+{
+}
+#define arch_get_kprobe_task(ptr) ((struct task_struct *)NULL)
+#endif
+/*
+ * Function-return probe -
+ * Note:
+ * User needs to provide a handler function, and initialize maxactive.
+ * maxactive - The maximum number of instances of the probed function that
+ * can be active concurrently.
+ * nmissed - tracks the number of times the probed function's return was
+ * ignored, due to maxactive being too low.
+ *
+ */
+struct kretprobe {
+	struct kprobe kp;
+	kretprobe_handler_t handler;
+	int maxactive;
+	int nmissed;
+	struct hlist_head free_instances;
+	struct hlist_head used_instances;
+};
+
+struct kretprobe_instance {
+	struct hlist_node uflist; /* either on free list or used list */
+	struct hlist_node hlist;
+	struct kretprobe *rp;
+	void *ret_addr;
+	void *stack_addr;
+};
+
 #ifdef CONFIG_KPROBES
 /* Locks kprobe: irq must be disabled */
 void lock_kprobes(void);
@@ -100,10 +154,12 @@ static inline int kprobe_running(void)
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_copy_kprobe(struct kprobe *p);
 extern void arch_remove_kprobe(struct kprobe *p);
+extern void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs);
 extern void show_registers(struct pt_regs *regs);
 
 /* Get the kprobe at this addr (if any).  Must have called lock_kprobes */
 struct kprobe *get_kprobe(void *addr);
+struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
 
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
@@ -113,6 +169,14 @@ int register_jprobe(struct jprobe *p);
 void unregister_jprobe(struct jprobe *p);
 void jprobe_return(void);
 
+int register_kretprobe(struct kretprobe *rp);
+void unregister_kretprobe(struct kretprobe *rp);
+
+struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp);
+struct kretprobe_instance *get_rp_inst(void *sara);
+void add_rp_inst(struct kretprobe_instance *ri);
+void kprobe_flush_task(struct task_struct *tk);
+void recycle_rp_inst(struct kretprobe_instance *ri);
 #else
 static inline int kprobe_running(void)
 {
@@ -135,5 +199,15 @@ static inline void unregister_jprobe(str
 static inline void jprobe_return(void)
 {
 }
+static inline int register_kretprobe(struct kretprobe *rp)
+{
+	return -ENOSYS;
+}
+static inline void unregister_kretprobe(struct kretprobe *rp)
+{
+}
+static inline void kprobe_flush_task(struct task_struct *tk)
+{
+}
 #endif
 #endif				/* _LINUX_KPROBES_H */
Index: linux-2.6.12-rc3-mm3/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc3-mm3.orig/kernel/kprobes.c	2005-05-05 10:25:18.000000000 -0700
+++ linux-2.6.12-rc3-mm3/kernel/kprobes.c	2005-05-05 16:50:40.000000000 -0700
@@ -27,6 +27,9 @@
  *		interface to access function arguments.
  * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
  *		exceptions notifier to be first on the priority list.
+ * 2005-May	Hien Nguyen <hien@us.ibm.com>, Jim Keniston
+ *		<jkenisto@us.ibm.com> and Prasanna S Panchamukhi
+ *		<prasanna@in.ibm.com> added function-return probes.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -41,6 +44,7 @@
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
+static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
 unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
@@ -120,6 +124,148 @@ int aggr_fault_handler(struct kprobe *p,
 	return 0;
 }
 
+struct kprobe trampoline_p = {
+		.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
+		.pre_handler = trampoline_probe_handler,
+		.post_handler = trampoline_post_handler
+};
+
+struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp)
+{
+	struct hlist_node *node;
+	struct kretprobe_instance *ri;
+	hlist_for_each_entry(ri, node, &rp->free_instances, uflist)
+		return ri;
+	return NULL;
+}
+
+struct kretprobe_instance *get_used_rp_inst(struct kretprobe *rp)
+{
+	struct hlist_node *node;
+	struct kretprobe_instance *ri;
+	hlist_for_each_entry(ri, node, &rp->used_instances, uflist)
+		return ri;
+	return NULL;
+}
+
+struct kretprobe_instance *get_rp_inst(void *sara)
+{
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct task_struct *tsk;
+	struct kretprobe_instance *ri;
+
+	tsk = arch_get_kprobe_task(sara);
+	head = &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
+	hlist_for_each_entry(ri, node, head, hlist) {
+		if (ri->stack_addr == sara)
+			return ri;
+	}
+	return NULL;
+}
+
+void add_rp_inst(struct kretprobe_instance *ri)
+{
+	struct task_struct *tsk;
+	/*
+	 * Remove rp inst off the free list -
+	 * Add it back when probed function returns
+	 */
+	hlist_del(&ri->uflist);
+	tsk = arch_get_kprobe_task(ri->stack_addr);
+	/* Add rp inst onto table */
+	INIT_HLIST_NODE(&ri->hlist);
+	hlist_add_head(&ri->hlist,
+			&kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)]);
+
+	/* Also add this rp inst to the used list. */
+	INIT_HLIST_NODE(&ri->uflist);
+	hlist_add_head(&ri->uflist, &ri->rp->used_instances);
+}
+
+void recycle_rp_inst(struct kretprobe_instance *ri)
+{
+	/* remove rp inst off the rprobe_inst_table */
+	hlist_del(&ri->hlist);
+	if (ri->rp) {
+		/* remove rp inst off the used list */
+		hlist_del(&ri->uflist);
+		/* put rp inst back onto the free list */
+		INIT_HLIST_NODE(&ri->uflist);
+		hlist_add_head(&ri->uflist, &ri->rp->free_instances);
+	} else
+		/* Unregistering */
+		kfree(ri);
+}
+
+struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk)
+{
+	return &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
+}
+
+struct kretprobe_instance *get_rp_inst_tsk(struct task_struct *tk)
+{
+	struct task_struct *tsk;
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct kretprobe_instance *ri;
+
+	head = &kretprobe_inst_table[hash_ptr(tk, KPROBE_HASH_BITS)];
+
+	hlist_for_each_entry(ri, node, head, hlist) {
+		tsk = arch_get_kprobe_task(ri->stack_addr);
+		if (tsk == tk)
+			return ri;
+	}
+	return NULL;
+}
+
+/*
+ * This function is called from do_exit or do_execv when task tk's stack is
+ * about to be recycled. Recycle any function-return probe instances
+ * associated with this task. These represent probed functions that have
+ * been called but may never return.
+ */
+void kprobe_flush_task(struct task_struct *tk)
+{
+	unsigned long flags = 0;
+	struct kretprobe_instance *ri;
+
+	if (!arch_supports_kretprobes)
+		return;
+
+	spin_lock_irqsave(&kprobe_lock, flags);
+	while ((ri = get_rp_inst_tsk(tk)) != NULL) {
+		/* TODO: arch specific */
+		*((unsigned long *)(ri->stack_addr)) =
+					(unsigned long) ri->ret_addr;
+		recycle_rp_inst(ri);
+	}
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+}
+
+/*
+ * This kprobe pre_handler is registered with every kretprobe. When probe
+ * hits it will set up the return probe.
+ */
+int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
+
+	/*TODO: consider to only swap the RA after the last pre_handler fired */
+	arch_prepare_kretprobe(rp, regs);
+	return 0;
+}
+
+inline void free_rp_inst(struct kretprobe *rp)
+{
+	struct kretprobe_instance *ri;
+	while ((ri = get_free_rp_inst(rp)) != NULL) {
+		hlist_del(&ri->uflist);
+		kfree(ri);
+	}
+}
+
 /*
  * Fill in the required fields of the "manager kprobe". Replace the
  * earlier kprobe in the hlist with the manager kprobe
@@ -257,16 +403,74 @@ void unregister_jprobe(struct jprobe *jp
 	unregister_kprobe(&jp->kp);
 }
 
+int register_kretprobe(struct kretprobe *rp)
+{
+	int ret = 0;
+	struct kretprobe_instance *inst;
+	int i;
+
+	if (!arch_supports_kretprobes)
+		return -ENOSYS;
+
+	rp->kp.pre_handler = pre_handler_kretprobe;
+
+	/* Pre-allocate memory for max kretprobe instances */
+	if (rp->maxactive <= 0) {
+#ifdef CONFIG_PREEMPT
+		rp->maxactive = max(10, 2 * NR_CPUS);
+#else
+		rp->maxactive = NR_CPUS;
+#endif
+	}
+	INIT_HLIST_HEAD(&rp->used_instances);
+	INIT_HLIST_HEAD(&rp->free_instances);
+	for (i = 0; i < rp->maxactive; i++) {
+		inst = kmalloc(sizeof(struct kretprobe_instance), GFP_KERNEL);
+		if (inst == NULL) {
+			free_rp_inst(rp);
+			return -ENOMEM;
+		}
+		INIT_HLIST_NODE(&inst->uflist);
+		hlist_add_head(&inst->uflist, &rp->free_instances);
+	}
+
+	rp->nmissed = 0;
+	/* Establish function entry probe point */
+	if ((ret = register_kprobe(&rp->kp)) != 0)
+		free_rp_inst(rp);
+	return ret;
+}
+
+void unregister_kretprobe(struct kretprobe *rp)
+{
+	unsigned long flags;
+	struct kretprobe_instance *ri;
+
+	unregister_kprobe(&rp->kp);
+	/* No race here */
+	spin_lock_irqsave(&kprobe_lock, flags);
+	free_rp_inst(rp);
+	while ((ri = get_used_rp_inst(rp)) != NULL) {
+		ri->rp = NULL;
+		hlist_del(&ri->uflist);
+	}
+	spin_unlock_irqrestore(&kprobe_lock, flags);
+}
+
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
-	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
-		INIT_HLIST_HEAD(&kprobe_table[i]);
+	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
+		INIT_HLIST_HEAD(&kprobe_table[i]);
+		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
+	}
 
 	err = register_die_notifier(&kprobe_exceptions_nb);
+	/* Register the trampoline probe for return probe */
+	register_kprobe(&trampoline_p);
 	return err;
 }
 
@@ -277,3 +481,6 @@ EXPORT_SYMBOL_GPL(unregister_kprobe);
 EXPORT_SYMBOL_GPL(register_jprobe);
 EXPORT_SYMBOL_GPL(unregister_jprobe);
 EXPORT_SYMBOL_GPL(jprobe_return);
+EXPORT_SYMBOL_GPL(register_kretprobe);
+EXPORT_SYMBOL_GPL(unregister_kretprobe);
+


