Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVC2Wbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVC2Wbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVC2Wbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:31:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:55966 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261558AbVC2W3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:29:34 -0500
Message-ID: <4249D6CB.8020206@us.ibm.com>
Date: Tue, 29 Mar 2005 14:29:31 -0800
From: Hien Nguyen <hien@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc1-mm3] [1/2]  kprobes += function-return probes
Content-Type: multipart/mixed;
 boundary="------------060905020900060904030101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060905020900060904030101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds function-return probes (AKA exit probes) to kprobes. 
 When establishing a probepoint at the entry to a function, you can also 
establish a handler to be run when the function returns.

The subsequent post give example of how function-return probes can be used.

Two new registration interfaces are added to kprobes:

int register_kretprobe(struct kprobe *kp, struct rprobe *rp);
Registers a probepoint at the entry to the function whose address is 
kp->addr.  Each time that function returns, rp->handler will be run.

int register_jretprobe(struct jprobe *jp, struct rprobe *rp);
Like register_kretprobe, except a jprobe is established for the probed 
function.

To unregister, you still use unregister_kprobe or unregister_jprobe. To 
probe only a function's returns, call register_kretprobe() and specify 
NULL handlers for the kprobe.

The following fields of struct retprobe are of interest to the user:

handler - This function is run after the ret instruction executes, but 
before control returns to the return address in the caller.

maxactive - The maximum number of instances of the probed function that 
can be active concurrently.  For example, if the function is 
non-recursive and is called with a spinlock or mutex held, maxactive = 1 
should be enough.  If the function is non-recursive and can never 
relinquish the CPU (e.g., via a semaphore or preemption), NR_CPUS should 
be enough. maxactive is used to determine how many rprobe_instance 
objects to allocate for this particular probed function.  If maxactive 
<= 0, it is set to a default value.  See register_kretprobe().

nmissed - Initialized to zero when the rprobe is registered, and 
incremented every time the probed function is entered but there is no 
rprobe_instance object available for establishing the function-return probe.

kprobe - When the rprobe is registered, this field is set to the kprobe 
at the entry to the function.


Signed-off-by: hien Nguyen <hien@us.ibm.com>

--------------060905020900060904030101
Content-Type: text/x-patch;
 name="kernel-2.6.12-rc1-mm3-rprobe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-2.6.12-rc1-mm3-rprobe.patch"

--- linux-2.6.11.mm4/include/linux/kprobes.h	2005-03-01 23:37:50.000000000 -0800
+++ /tmp/linux-2.6.12-rc1.mm3.works/include/linux/kprobes.h	2005-03-29 11:10:46.000000000 -0800
@@ -25,6 +25,9 @@
  *		Rusty Russell).
  * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
  *		interface to access function arguments.
+ * 2005-Mar     Hien Nguyen <hien@us.ibm.com> and Jim Keniston
+ *		<jkenisto@us.ibm.com>  Added function-return probes, aka exit
+ *		probes.
  */
 #include <linux/config.h>
 #include <linux/list.h>
@@ -34,12 +37,15 @@
 
 struct kprobe;
 struct pt_regs;
+struct retprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
 typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
 typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
 				       int trapnr);
+typedef int (*retprobe_handler_t) (struct retprobe_instance *, struct pt_regs *);
+
 struct kprobe {
 	struct hlist_node hlist;
 
@@ -65,6 +71,9 @@
 
 	/* copy of the original instruction */
 	struct arch_specific_insn ainsn;
+	
+	/* point to retprobe */
+	struct retprobe *rp;
 };
 
 /*
@@ -82,6 +91,49 @@
 	kprobe_opcode_t *entry;	/* probe handling code to jump to */
 };
 
+#ifdef arch_supports_retprobes
+extern int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs);
+extern struct task_struct *arch_get_kprobe_task(void *ptr);
+#else 
+#define arch_supports_retprobes		0
+static void retprobe_trampoline(void)
+{
+}
+static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	return 0;
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
+struct retprobe {
+	retprobe_handler_t handler;
+	int maxactive;
+	int nmissed;
+	int num_ri_running;
+	int unregistering;
+	struct kprobe *kprobe;
+	struct retprobe_instance *instances;	/* allocated memory */
+	struct list_head free_instances;
+};
+
+struct retprobe_instance {
+	struct list_head list;
+	struct hlist_node hlist;
+	struct retprobe *rp;
+	void *ret_addr;
+	void *stack_addr;
+};
+
 #ifdef CONFIG_KPROBES
 /* Locks kprobe: irq must be disabled */
 void lock_kprobes(void);
@@ -110,6 +162,14 @@
 void unregister_jprobe(struct jprobe *p);
 void jprobe_return(void);
 
+int register_kretprobe(struct kprobe *p, struct retprobe *rp);
+int register_jretprobe(struct jprobe *p, struct retprobe *rp);
+
+struct retprobe_instance *get_free_rp_inst(struct retprobe *rp);
+struct retprobe_instance *get_rp_inst(void *sara);
+void add_retprobe_inst_to_hash(struct retprobe_instance *ri); 
+void kprobe_flush_task(struct task_struct *tk);
+void recycle_retprobe_instance(struct retprobe_instance *ri);
 #else
 static inline int kprobe_running(void)
 {
@@ -132,5 +192,13 @@
 static inline void jprobe_return(void)
 {
 }
+static inline int register_kretprobe(struct kprobe *p, struct retprobe *rp)
+{
+	return -ENOSYS;
+}
+static inline int register_jretprobe(struct jprobe *p, struct retprobe *rp)
+{
+	return -ENOSYS;
+}
 #endif
 #endif				/* _LINUX_KPROBES_H */
--- linux-2.6.11.mm4/kernel/kprobes.c	2005-03-21 13:44:08.000000000 -0800
+++ /tmp/linux-2.6.12-rc1.mm3.works/kernel/kprobes.c	2005-03-28 16:32:26.000000000 -0800
@@ -27,6 +27,9 @@
  *		interface to access function arguments.
  * 2004-Sep	Prasanna S Panchamukhi <prasanna@in.ibm.com> Changed Kprobes
  *		exceptions notifier to be first on the priority list.
+ * 2005-Mar	Hien Nguyen <hien@us.ibm.com> and Jim Keniston
+ *		<jkenisto@us.ibm.com> Added function-return probes, aka exit 
+ *		probes.
  */
 #include <linux/kprobes.h>
 #include <linux/spinlock.h>
@@ -37,11 +40,19 @@
 #include <asm/errno.h>
 #include <asm/kdebug.h>
 
+#ifndef arch_supports_retprobes
+#define arch_supports_retprobes	0
+#endif 
+
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 
+#define RPROBE_HASH_BITS	KPROBE_HASH_BITS	
+#define RPROBE_INST_TABLE_SIZE  KPROBE_TABLE_SIZE
+static struct hlist_head retprobe_inst_table[RPROBE_INST_TABLE_SIZE];
+
 unsigned int kprobe_cpu = NR_CPUS;
 static DEFINE_SPINLOCK(kprobe_lock);
 
@@ -58,6 +69,26 @@
 	spin_unlock(&kprobe_lock);
 }
 
+struct kprobe trampoline_p = {
+		.addr = (kprobe_opcode_t *) &retprobe_trampoline,
+		.pre_handler = trampoline_probe_handler,
+		.rp = NULL
+};
+
+/* 
+ * Called once to register a probe point at the retprobe trampoline.
+ */
+static void init_retprobes(void)
+{
+	int i;
+
+	register_kprobe(&trampoline_p);
+
+	/* Allocate retprobe instances hash table */	
+	for (i = 0; i < RPROBE_INST_TABLE_SIZE; i++)
+		INIT_HLIST_HEAD(&retprobe_inst_table[i]);
+}
+
 /* You have to be holding the kprobe_lock */
 struct kprobe *get_kprobe(void *addr)
 {
@@ -73,7 +104,84 @@
 	return NULL;
 }
 
-int register_kprobe(struct kprobe *p)
+struct retprobe_instance * get_free_rp_inst(struct retprobe *rp)
+{
+	if (list_empty(&rp->free_instances)) {
+		return NULL;
+	}
+	return (struct retprobe_instance *) rp->free_instances.next;
+}	
+
+struct retprobe_instance *get_rp_inst(void *sara)
+{
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct task_struct *tsk;
+	struct retprobe_instance *ri;
+
+	tsk = arch_get_kprobe_task(sara);
+	head = &retprobe_inst_table[hash_ptr(tsk, RPROBE_HASH_BITS)];
+	hlist_for_each_entry(ri, node, head, hlist) {
+		if (ri->stack_addr == sara)
+			return ri;
+	}
+	return NULL;
+}
+
+void add_retprobe_inst_to_hash(struct retprobe_instance *ri)
+{
+	struct task_struct *tsk;
+	tsk = arch_get_kprobe_task(ri->stack_addr);	
+	hlist_add_head(&ri->hlist, &retprobe_inst_table[hash_ptr(tsk, RPROBE_HASH_BITS)]);
+}
+
+void recycle_retprobe_instance(struct retprobe_instance *ri)
+{
+	/* Put the original return address back to stack */
+	*((unsigned long *)(ri->stack_addr)) = (unsigned long) ri->ret_addr;
+	ri->rp->num_ri_running--;
+	if (ri->rp->num_ri_running == 0 && ri->rp->unregistering == 1) {
+		/* This is the last running ri during unregister. 
+		 * Free memory to complete the unregister.
+		 */
+		kfree(ri->rp->instances);
+		kfree(ri->rp);
+	} else {
+		/* put ri obj back to free list */
+		list_add(&ri->list, &ri->rp->free_instances);
+	}
+}
+
+/*
+ * This function is called from do_exit or do_execv when task tk's stack is
+ * about to be recycled. Recycle any function-return probe instances 
+ * associated with this task. These represent probed functions that have 
+ * been called but will never return.
+ */
+void kprobe_flush_task(struct task_struct *tk)
+{
+	unsigned long flags = 0;
+	struct retprobe_instance *ri;
+	struct task_struct *tsk;
+	struct hlist_head *head;
+	struct hlist_node *node;
+
+	if (!arch_supports_retprobes) {
+		return;
+	}
+	spin_lock_irqsave(&kprobe_lock, flags);	
+	head = &retprobe_inst_table[hash_ptr(tk, RPROBE_HASH_BITS)];
+	hlist_for_each_entry(ri, node, head, hlist) {
+		tsk = arch_get_kprobe_task(ri->stack_addr);
+		if (tsk == tk) {
+			hlist_del_rcu(&ri->hlist);
+			recycle_retprobe_instance(ri);
+		}
+	}
+	spin_unlock_irqrestore(&kprobe_lock, flags);	
+}
+
+int _register_kprobe(struct kprobe *p)
 {
 	int ret = 0;
 	unsigned long flags = 0;
@@ -104,15 +212,47 @@
 	return ret;
 }
 
+int register_kprobe(struct kprobe *p)
+{
+	p->rp = NULL;
+	return _register_kprobe(p);
+}
+
 void unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
 	arch_remove_kprobe(p);
 	spin_lock_irqsave(&kprobe_lock, flags);
+	if (get_kprobe(p->addr) == NULL) {
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		return;
+	}
 	*p->addr = p->opcode;
 	hlist_del(&p->hlist);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+	
+	if (p->rp != NULL) {
+		if (p->rp->num_ri_running != 0) {
+			int i;
+			struct retprobe *rp;
+			struct retprobe_instance *ri;
+			/*
+			 * Make a copy of retprobe so we can relinquish
+			 * the user's original.
+			 */
+			rp = kmalloc(sizeof(struct retprobe), GFP_KERNEL);
+			BUG_ON(rp == NULL);
+			memcpy(rp, p->rp, sizeof(struct retprobe));
+			rp->unregistering = 1;
+			for (i = 0 ; i < p->rp->maxactive; i++) {
+				ri = p->rp->instances + i;
+				ri->rp = rp;
+			}
+		} else {
+			kfree(p->rp->instances);
+		}
+	}
 	spin_unlock_irqrestore(&kprobe_lock, flags);
 }
 
@@ -135,6 +275,67 @@
 	unregister_kprobe(&jp->kp);
 }
 
+int register_kretprobe(struct kprobe *p, struct retprobe *rp)
+{
+	int ret = 0;
+	static int retprobe_init_setup = 0;
+	struct retprobe_instance *inst;
+	int maxinst, i;
+	
+	if (!arch_supports_retprobes) {
+		return -ENOSYS;
+	}
+	if (retprobe_init_setup == 0) {
+		init_retprobes();
+		retprobe_init_setup = 1;
+	}
+	/* Pre-allocate memory for max retprobe instances */
+	if (rp->maxactive > 0) {
+		maxinst = rp->maxactive;
+	} else {
+#ifdef CONFIG_PREEMPT
+		maxinst = max(10, 2 * NR_CPUS);
+#else
+		maxinst = NR_CPUS;
+#endif
+	} 
+	rp->instances = kmalloc(maxinst * sizeof(struct retprobe_instance), 
+					GFP_KERNEL);
+	if (rp->instances == NULL) {
+		return -ENOMEM;
+	}
+	
+	INIT_LIST_HEAD(&rp->free_instances);
+	/* Put all retprobe_instance objects on the free list */
+	for (i = 0; i < maxinst; i++) {
+		inst = rp->instances + i;
+		list_add(&inst->list, &rp->free_instances);
+	}
+	rp->num_ri_running = 0;
+	rp->nmissed = 0;
+	rp->unregistering = 0;
+	rp->kprobe = p;
+	p->rp = rp;
+
+	/* Establish function entry probe point */
+	/* todo: we need to deal with probe that has been registered */
+	
+	if((ret = _register_kprobe(p)) != 0) {
+		kfree(rp->instances);
+		return ret;
+	}
+	return ret;
+}
+
+int register_jretprobe(struct jprobe *jp, struct retprobe *rp)
+{
+
+	jp->kp.pre_handler = setjmp_pre_handler;
+	jp->kp.break_handler = longjmp_break_handler;
+
+	return register_kretprobe(&jp->kp, rp);
+}
+	
 static int __init init_kprobes(void)
 {
 	int i, err = 0;
@@ -155,3 +356,5 @@
 EXPORT_SYMBOL_GPL(register_jprobe);
 EXPORT_SYMBOL_GPL(unregister_jprobe);
 EXPORT_SYMBOL_GPL(jprobe_return);
+EXPORT_SYMBOL_GPL(register_kretprobe);
+EXPORT_SYMBOL_GPL(register_jretprobe);
--- linux-2.6.11.mm4/arch/i386/kernel/kprobes.c	2005-03-01 23:38:08.000000000 -0800
+++ /tmp/linux-2.6.12-rc1.mm3.works/arch/i386/kernel/kprobes.c	2005-03-28 16:32:26.000000000 -0800
@@ -23,6 +23,9 @@
  *		Rusty Russell).
  * 2004-July	Suparna Bhattacharya <suparna@in.ibm.com> added jumper probes
  *		interface to access function arguments.
+ * 2005-Mar     Hien Nguyen <hien@us.ibm.com> and Jim Keniston
+ *		<jkenisto@us.ibm.com> Added function return-probes, aka exit
+ *		 probes.
  */
 
 #include <linux/config.h>
@@ -60,6 +63,12 @@
 	return 0;
 }
 
+struct task_struct  *arch_get_kprobe_task(void *ptr)
+{
+	return ((struct thread_info *) (((unsigned long) ptr) & (~(THREAD_SIZE -1))))->task;
+}
+
+
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	return 0;
@@ -159,6 +168,35 @@
 	if (is_IF_modifier(p->opcode))
 		kprobe_saved_eflags &= ~IF_MASK;
 
+	if (p->rp != NULL) {
+		/* 
+	 	 * Get a retprobe instance off the free list and populate it
+	 	 * with the return addr, stack addr, and rp.
+	 	 */
+		struct retprobe_instance *ri;
+		unsigned long *sara = (unsigned long *)&regs->esp;
+
+		if ((ri = get_free_rp_inst(p->rp)) != NULL) {
+			INIT_HLIST_NODE(&ri->hlist);
+			ri->rp = p->rp;
+			ri->stack_addr = sara;
+			ri->ret_addr =  (void *) *sara;
+			add_retprobe_inst_to_hash(ri);
+			/* Replace the return addr with trampoline addr */
+			*sara = (unsigned long) &retprobe_trampoline;
+			/* 
+			 * Remove obj in free list - 
+			 * will add it back when probed function returns 
+			 */
+			list_del(&ri->list);
+			p->rp->num_ri_running++;
+		} else {
+			p->rp->nmissed++;
+		}
+		/* retprobe allows kprobe handle to be null */
+		if (!p->pre_handler)
+			goto ss_probe;
+	} 	
 	if (p->pre_handler(p, regs)) {
 		/* handler has already set things up, so skip ss setup */
 		return 1;
@@ -173,6 +211,22 @@
 	preempt_enable_no_resched();
 	return ret;
 }
+/*
+ * Called when we hit the probe point at retprobe_trampoline
+ */  
+int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct retprobe_instance *ri;
+	unsigned long *sara = ((unsigned long *) &regs->esp) - 1;
+	
+	if ((ri = get_rp_inst(sara)) == NULL) {
+		return 0;
+	}
+	if (ri->rp && !ri->rp->unregistering) {
+		return ri->rp->handler(ri, regs);
+	}
+	return 0;
+}
 
 /*
  * Called after single-stepping.  p->addr is the address of the
@@ -226,6 +280,19 @@
 	case 0xea:		/* jmp absolute -- eip is correct */
 		next_eip = regs->eip;
 		break;
+	case 0x90: 	/* nop */
+		/* Check to make sure this is from the trampoline probe */
+		if (orig_eip  == (unsigned long) retprobe_trampoline) {
+			struct retprobe_instance *ri;
+			unsigned long *sara = tos - 1;	/* RA already popped */
+			ri = get_rp_inst(sara);
+			if (ri != NULL) {
+				next_eip = (unsigned long)ri->ret_addr;
+				hlist_del(&ri->hlist);
+				recycle_retprobe_instance(ri);
+			}
+		}
+		break;
 	default:
 		break;
 	}
--- linux-2.6.11.mm4/arch/i386/kernel/entry.S	2005-03-21 13:43:34.000000000 -0800
+++ /tmp/linux-2.6.12-rc1.mm3.works/arch/i386/kernel/entry.S	2005-03-28 16:32:26.000000000 -0800
@@ -136,6 +136,17 @@
 .previous
 
 
+#ifdef CONFIG_KPROBES
+/*
+ * For function-return probes, init_retprobes() establishes a probepoint
+ * here. When a retprobed function returns, this probe is hit and
+ * trampoline_probe_handler() runs, calling the retprobe's handler.
+ */
+ENTRY(retprobe_trampoline)
+	nop
+/* NOT REACHED */
+#endif
+
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
--- linux-2.6.11.mm4/arch/i386/kernel/process.c	2005-03-21 13:43:34.000000000 -0800
+++ /tmp/linux-2.6.12-rc1.mm3.works/arch/i386/kernel/process.c	2005-03-29 11:08:37.000000000 -0800
@@ -39,6 +39,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/kprobes.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -371,7 +372,14 @@
 {
 	struct task_struct *tsk = current;
 	struct thread_struct *t = &tsk->thread;
-
+#ifdef CONFIG_KPROBES
+	/* 
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do. 
+	 */
+	kprobe_flush_task(tsk);
+#endif
 	/* The process may have allocated an io port bitmap... nuke it. */
 	if (unlikely(NULL != t->io_bitmap_ptr)) {
 		int cpu = get_cpu();
@@ -395,7 +403,14 @@
 void flush_thread(void)
 {
 	struct task_struct *tsk = current;
-
+#ifdef CONFIG_KPROBES
+	/* 
+	 * Remove function-return probe instances associated with this task
+	 * and put them back on the free list. Do not insert an exit probe for
+	 * this function, it will be disabled by kprobe_flush_task if you do.
+	 */
+	kprobe_flush_task(tsk);
+#endif
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
 	/*
--- linux-2.6.11.mm4/include/asm-i386/kprobes.h	2005-03-01 23:38:12.000000000 -0800
+++ /tmp/linux-2.6.12-rc1.mm3.works/include/asm-i386/kprobes.h	2005-03-29 08:58:39.000000000 -0800
@@ -39,6 +39,9 @@
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
 #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)pentry
+#define arch_supports_retprobes 1
+
+asmlinkage void retprobe_trampoline(void) __asm__("retprobe_trampoline");
 
 /* Architecture specific copy of original instruction*/
 struct arch_specific_insn {

--------------060905020900060904030101--
