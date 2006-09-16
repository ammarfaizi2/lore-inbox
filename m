Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWIPUwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWIPUwA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWIPUwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 16:52:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16616 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751749AbWIPUv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 16:51:59 -0400
Date: Sat, 16 Sep 2006 22:43:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
Message-ID: <20060916204342.GA5208@elte.hu>
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060916202939.GA4520@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916202939.GA4520@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> the patch below brings the overhead down to 420 cycles:
> 
>      sys_getpid() kprobes-speedup:       737 cycles   [ 0.341 usecs ]

the patch below reduces the kprobes overhead to 305 cycles. The current 
performance table is:

  sys_getpid() unmodified latency:    317 cycles   [ 0.146 usecs ]    0
  sys_getpid() djprobes latency:      380 cycles   [ 0.176 usecs ]  +63
  sys_getpid() kprobes latency:       815 cycles   [ 0.377 usecs ] +498
  sys_getpid() kprobes-speedup:       740 cycles   [ 0.342 usecs ] +423
  sys_getpid() kprobes-speedup2:      737 cycles   [ 0.341 usecs ] +420
  sys_getpid() kprobes-speedup3:      622 cycles   [ 0.287 usecs ] +305

the 3 speedups i did today eliminated 63% of the kprobes overhead in 
this test.

this too shows that there's lots of performance potential even in 
INT3-based kprobes.

	Ingo

--------------->
Subject: [patch] kprobes: move from struct_hlist to struct_list
From: Ingo Molnar <mingo@elte.hu>

kprobes is using hlists for no good reason: the hash-table is 64 entries 
so there's no significant RAM footprint difference. hlists are more 
complicated to handle though and cause runtime overhead and cacheline 
inefficiencies.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/kernel/kprobes.c |    7 +--
 include/linux/djprobe.h    |    3 -
 include/linux/kprobes.h    |   15 +++----
 init/main.c                |    3 +
 kernel/djprobe.c           |   23 ++++++----
 kernel/kprobes.c           |   96 +++++++++++++++++++++------------------------
 6 files changed, 75 insertions(+), 72 deletions(-)

Index: linux/arch/i386/kernel/kprobes.c
===================================================================
--- linux.orig/arch/i386/kernel/kprobes.c
+++ linux/arch/i386/kernel/kprobes.c
@@ -354,9 +354,8 @@ no_kprobe:
  */
 fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
 {
-        struct kretprobe_instance *ri = NULL;
-        struct hlist_head *head;
-        struct hlist_node *node, *tmp;
+        struct kretprobe_instance *ri = NULL, *tmp;
+        struct list_head *head;
 	unsigned long flags, orig_ret_address = 0;
 	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
 
@@ -376,7 +375,7 @@ fastcall void *__kprobes trampoline_hand
 	 *       real return address, and all the rest will point to
 	 *       kretprobe_trampoline
 	 */
-	hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
+	list_for_each_entry_safe(ri, tmp, head, hlist) {
                 if (ri->task != current)
 			/* another task is sharing our hash bucket */
                         continue;
Index: linux/include/linux/djprobe.h
===================================================================
--- linux.orig/include/linux/djprobe.h
+++ linux/include/linux/djprobe.h
@@ -36,7 +36,7 @@ struct djprobe_instance {
 	struct list_head plist; /* list of djprobes for multiprobe support */
 	struct arch_djprobe_stub stub;
 	struct kprobe kp;
-	struct hlist_node hlist; /* list of djprobe_instances */
+	struct list_head hlist; /* list of djprobe_instances */
 };
 #define DJPI_EMPTY(djpi)  (list_empty(&djpi->plist))
 
@@ -65,6 +65,7 @@ extern int djprobe_pre_handler(struct kp
 extern void arch_install_djprobe_instance(struct djprobe_instance *djpi);
 extern void arch_uninstall_djprobe_instance(struct djprobe_instance *djpi);
 struct djprobe_instance * __get_djprobe_instance(void *addr, int size);
+extern int init_djprobe(void);
 
 int register_djprobe(struct djprobe *p, void *addr, int size);
 void unregister_djprobe(struct djprobe *p);
Index: linux/include/linux/kprobes.h
===================================================================
--- linux.orig/include/linux/kprobes.h
+++ linux/include/linux/kprobes.h
@@ -39,7 +39,7 @@
 #include <linux/mutex.h>
 
 struct kprobe_insn_page_list {
-	struct hlist_head list;
+	struct list_head list;
 	int insn_size;		/* size of an instruction slot */
 };
 
@@ -69,7 +69,7 @@ typedef int (*kretprobe_handler_t) (stru
 				    struct pt_regs *);
 
 struct kprobe {
-	struct hlist_node hlist;
+	struct list_head hlist;
 
 	/* list of kprobes for multi-handler support */
 	struct list_head list;
@@ -145,13 +145,13 @@ struct kretprobe {
 	kretprobe_handler_t handler;
 	int maxactive;
 	int nmissed;
-	struct hlist_head free_instances;
-	struct hlist_head used_instances;
+	struct list_head free_instances;
+	struct list_head used_instances;
 };
 
 struct kretprobe_instance {
-	struct hlist_node uflist; /* either on free list or used list */
-	struct hlist_node hlist;
+	struct list_head uflist; /* either on free list or used list */
+	struct list_head hlist;
 	struct kretprobe *rp;
 	kprobe_opcode_t *ret_addr;
 	struct task_struct *task;
@@ -163,6 +163,7 @@ extern int arch_prepare_kprobe(struct kp
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
 extern int arch_init_kprobes(void);
+extern int init_kprobes(void);
 extern void show_registers(struct pt_regs *regs);
 extern kprobe_opcode_t *get_insn_slot(void);
 extern void free_insn_slot(kprobe_opcode_t *slot);
@@ -175,7 +176,7 @@ extern int in_kprobes_functions(unsigned
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
-struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
+struct list_head * kretprobe_inst_table_head(struct task_struct *tsk);
 
 /* kprobe_running() will just return the current_kprobe on this CPU */
 static inline struct kprobe *kprobe_running(void)
Index: linux/init/main.c
===================================================================
--- linux.orig/init/main.c
+++ linux/init/main.c
@@ -530,6 +530,9 @@ asmlinkage void __init start_kernel(void
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
+#ifdef CONFIG_KPROBES
+	init_kprobes();
+#endif
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
Index: linux/kernel/djprobe.c
===================================================================
--- linux.orig/kernel/djprobe.c
+++ linux/kernel/djprobe.c
@@ -47,7 +47,7 @@
 #define DJPROBE_TABLE_MASK (DJPROBE_TABLE_SIZE - 1)
 
 /* djprobe instance hash table */
-static struct hlist_head djprobe_inst_table[DJPROBE_TABLE_SIZE];
+static struct list_head djprobe_inst_table[DJPROBE_TABLE_SIZE];
 
 #define hash_djprobe(key) \
 	(((unsigned long)(key) >> DJPROBE_BLOCK_BITS) & DJPROBE_TABLE_MASK)
@@ -59,12 +59,12 @@ static atomic_t djprobe_count = ATOMIC_I
 
 /* Instruction pages for djprobe's stub code */
 static struct kprobe_insn_page_list djprobe_insn_pages = {
-	HLIST_HEAD_INIT, 0
+	LIST_HEAD_INIT(djprobe_insn_pages.list), 0
 };
 
 static inline void __free_djprobe_instance(struct djprobe_instance *djpi)
 {
-	hlist_del(&djpi->hlist);
+	list_del(&djpi->hlist);
 	if (djpi->kp.addr) {
 		unregister_kprobe(&(djpi->kp));
 	}
@@ -100,8 +100,8 @@ static inline
 	djpi->kp.pre_handler = djprobe_pre_handler;
 	arch_prepare_djprobe_instance(djpi, size);
 
-	INIT_HLIST_NODE(&djpi->hlist);
-	hlist_add_head(&djpi->hlist, &djprobe_inst_table[hash_djprobe(addr)]);
+	INIT_LIST_HEAD(&djpi->hlist);
+	list_add(&djpi->hlist, &djprobe_inst_table[hash_djprobe(addr)]);
       out:
 	return djpi;
 }
@@ -110,13 +110,12 @@ struct djprobe_instance *__kprobes __get
 							  int size)
 {
 	struct djprobe_instance *djpi;
-	struct hlist_node *node;
 	unsigned long idx, eidx;
 
 	idx = hash_djprobe(addr - ARCH_STUB_INSN_MAX);
 	eidx = ((hash_djprobe(addr + size) + 1) & DJPROBE_TABLE_MASK);
 	do {
-		hlist_for_each_entry(djpi, node, &djprobe_inst_table[idx],
+		list_for_each_entry(djpi, &djprobe_inst_table[idx],
 				     hlist) {
 			if (((long)addr <
 			     (long)djpi->kp.addr + DJPI_ARCH_SIZE(djpi))
@@ -234,13 +233,17 @@ void __kprobes unregister_djprobe(struct
 	up(&djprobe_mutex);
 }
 
-static int __init init_djprobe(void)
+int __init init_djprobe(void)
 {
+	int i;
+
+	for (i = 0; i < DJPROBE_TABLE_SIZE; i++)
+		INIT_LIST_HEAD(&djprobe_inst_table[i]);
+
 	djprobe_insn_pages.insn_size = ARCH_STUB_SIZE;
+
 	return 0;
 }
 
-__initcall(init_djprobe);
-
 EXPORT_SYMBOL_GPL(register_djprobe);
 EXPORT_SYMBOL_GPL(unregister_djprobe);
Index: linux/kernel/kprobes.c
===================================================================
--- linux.orig/kernel/kprobes.c
+++ linux/kernel/kprobes.c
@@ -46,8 +46,8 @@
 #define KPROBE_HASH_BITS 6
 #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
 
-static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
-static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
+static struct list_head kprobe_table[KPROBE_TABLE_SIZE];
+static struct list_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
@@ -63,14 +63,14 @@ static DEFINE_PER_CPU(struct kprobe *, k
 #define INSNS_PER_PAGE(size) (PAGE_SIZE/(size * sizeof(kprobe_opcode_t)))
 
 struct kprobe_insn_page {
-	struct hlist_node hlist;
+	struct list_head hlist;
 	kprobe_opcode_t *insns;		/* Page of instruction slots */
 	int nused;
 	char slot_used[1];
 };
 
 static struct kprobe_insn_page_list kprobe_insn_pages = {
-	HLIST_HEAD_INIT, MAX_INSN_SIZE
+	LIST_HEAD_INIT(kprobe_insn_pages.list), MAX_INSN_SIZE
 };
 
 /**
@@ -81,10 +81,10 @@ kprobe_opcode_t
 	__kprobes * __get_insn_slot(struct kprobe_insn_page_list *pages)
 {
 	struct kprobe_insn_page *kip;
-	struct hlist_node *pos;
+	struct list_head *pos;
 	int ninsns = INSNS_PER_PAGE(pages->insn_size);
 
-	hlist_for_each(pos, &pages->list) {
+	list_for_each(pos, &pages->list) {
 		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
 		if (kip->nused < ninsns) {
 			int i;
@@ -118,8 +118,8 @@ kprobe_opcode_t
 		kfree(kip);
 		return NULL;
 	}
-	INIT_HLIST_NODE(&kip->hlist);
-	hlist_add_head(&kip->hlist, &pages->list);
+	INIT_LIST_HEAD(&kip->hlist);
+	list_add(&kip->hlist, &pages->list);
 	memset(kip->slot_used, 0, ninsns);
 	kip->slot_used[0] = 1;
 	kip->nused = 1;
@@ -130,10 +130,10 @@ void __kprobes __free_insn_slot(struct k
 				kprobe_opcode_t * slot)
 {
 	struct kprobe_insn_page *kip;
-	struct hlist_node *pos;
+	struct list_head *pos;
 	int ninsns = INSNS_PER_PAGE(pages->insn_size);
 
-	hlist_for_each(pos, &pages->list) {
+	list_for_each(pos, &pages->list) {
 		kip = hlist_entry(pos, struct kprobe_insn_page, hlist);
 		if (kip->insns <= slot &&
 		    slot < kip->insns + (ninsns * pages->insn_size)) {
@@ -147,10 +147,10 @@ void __kprobes __free_insn_slot(struct k
 				 * so as not to have to set it up again the
 				 * next time somebody inserts a probe.
 				 */
-				hlist_del(&kip->hlist);
-				if (hlist_empty(&pages->list)) {
-					INIT_HLIST_NODE(&kip->hlist);
-					hlist_add_head(&kip->hlist,
+				list_del(&kip->hlist);
+				if (list_empty(&pages->list)) {
+					INIT_LIST_HEAD(&kip->hlist);
+					list_add(&kip->hlist,
 						       &pages->list);
 				} else {
 					module_free(NULL, kip->insns);
@@ -192,12 +192,11 @@ static inline void reset_kprobe_instance
  */
 struct kprobe __kprobes *get_kprobe(void *addr)
 {
-	struct hlist_head *head;
-	struct hlist_node *node;
+	struct list_head *head;
 	struct kprobe *p;
 
 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
-	hlist_for_each_entry_rcu(p, node, head, hlist) {
+	list_for_each_entry_rcu(p, head, hlist) {
 		if (p->addr == addr)
 			return p;
 	}
@@ -283,9 +282,9 @@ void __kprobes kprobes_inc_nmissed_count
 /* Called with kretprobe_lock held */
 struct kretprobe_instance __kprobes *get_free_rp_inst(struct kretprobe *rp)
 {
-	struct hlist_node *node;
 	struct kretprobe_instance *ri;
-	hlist_for_each_entry(ri, node, &rp->free_instances, uflist)
+
+	list_for_each_entry(ri, &rp->free_instances, uflist)
 		return ri;
 	return NULL;
 }
@@ -294,9 +293,9 @@ struct kretprobe_instance __kprobes *get
 static struct kretprobe_instance __kprobes *get_used_rp_inst(struct kretprobe
 							      *rp)
 {
-	struct hlist_node *node;
 	struct kretprobe_instance *ri;
-	hlist_for_each_entry(ri, node, &rp->used_instances, uflist)
+
+	list_for_each_entry(ri, &rp->used_instances, uflist)
 		return ri;
 	return NULL;
 }
@@ -308,35 +307,35 @@ void __kprobes add_rp_inst(struct kretpr
 	 * Remove rp inst off the free list -
 	 * Add it back when probed function returns
 	 */
-	hlist_del(&ri->uflist);
+	list_del(&ri->uflist);
 
 	/* Add rp inst onto table */
-	INIT_HLIST_NODE(&ri->hlist);
-	hlist_add_head(&ri->hlist,
+	INIT_LIST_HEAD(&ri->hlist);
+	list_add(&ri->hlist,
 			&kretprobe_inst_table[hash_ptr(ri->task, KPROBE_HASH_BITS)]);
 
 	/* Also add this rp inst to the used list. */
-	INIT_HLIST_NODE(&ri->uflist);
-	hlist_add_head(&ri->uflist, &ri->rp->used_instances);
+	INIT_LIST_HEAD(&ri->uflist);
+	list_add(&ri->uflist, &ri->rp->used_instances);
 }
 
 /* Called with kretprobe_lock held */
 void __kprobes recycle_rp_inst(struct kretprobe_instance *ri)
 {
 	/* remove rp inst off the rprobe_inst_table */
-	hlist_del(&ri->hlist);
+	list_del(&ri->hlist);
 	if (ri->rp) {
 		/* remove rp inst off the used list */
-		hlist_del(&ri->uflist);
+		list_del(&ri->uflist);
 		/* put rp inst back onto the free list */
-		INIT_HLIST_NODE(&ri->uflist);
-		hlist_add_head(&ri->uflist, &ri->rp->free_instances);
+		INIT_LIST_HEAD(&ri->uflist);
+		list_add(&ri->uflist, &ri->rp->free_instances);
 	} else
 		/* Unregistering */
 		kfree(ri);
 }
 
-struct hlist_head __kprobes *kretprobe_inst_table_head(struct task_struct *tsk)
+struct list_head __kprobes *kretprobe_inst_table_head(struct task_struct *tsk)
 {
 	return &kretprobe_inst_table[hash_ptr(tsk, KPROBE_HASH_BITS)];
 }
@@ -349,14 +348,13 @@ struct hlist_head __kprobes *kretprobe_i
  */
 void __kprobes kprobe_flush_task(struct task_struct *tk)
 {
-        struct kretprobe_instance *ri;
-        struct hlist_head *head;
-	struct hlist_node *node, *tmp;
+        struct kretprobe_instance *ri, *tmp;
+        struct list_head *head;
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&kretprobe_lock, flags);
         head = kretprobe_inst_table_head(tk);
-        hlist_for_each_entry_safe(ri, node, tmp, head, hlist) {
+        list_for_each_entry_safe(ri, tmp, head, hlist) {
                 if (ri->task == tk)
                         recycle_rp_inst(ri);
         }
@@ -367,7 +365,7 @@ static inline void free_rp_inst(struct k
 {
 	struct kretprobe_instance *ri;
 	while ((ri = get_free_rp_inst(rp)) != NULL) {
-		hlist_del(&ri->uflist);
+		list_del(&ri->uflist);
 		kfree(ri);
 	}
 }
@@ -416,7 +414,7 @@ static inline void add_aggr_kprobe(struc
 	INIT_LIST_HEAD(&ap->list);
 	list_add_rcu(&p->list, &ap->list);
 
-	hlist_replace_rcu(&p->hlist, &ap->hlist);
+	list_replace_rcu(&p->hlist, &ap->hlist);
 }
 
 /*
@@ -499,8 +497,8 @@ static int __kprobes __register_kprobe(s
 	if ((ret = arch_prepare_kprobe(p)) != 0)
 		goto out;
 
-	INIT_HLIST_NODE(&p->hlist);
-	hlist_add_head_rcu(&p->hlist,
+	INIT_LIST_HEAD(&p->hlist);
+	list_add_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
   	arch_arm_kprobe(p);
@@ -551,7 +549,7 @@ valid_p:
 		(p->list.prev == &old_p->list))) {
 		/* Only probe on the hash list */
 		arch_disarm_kprobe(p);
-		hlist_del_rcu(&old_p->hlist);
+		list_del_rcu(&old_p->hlist);
 		cleanup_p = 1;
 	} else {
 		list_del_rcu(&p->list);
@@ -632,16 +630,16 @@ int __kprobes register_kretprobe(struct 
 		rp->maxactive = NR_CPUS;
 #endif
 	}
-	INIT_HLIST_HEAD(&rp->used_instances);
-	INIT_HLIST_HEAD(&rp->free_instances);
+	INIT_LIST_HEAD(&rp->used_instances);
+	INIT_LIST_HEAD(&rp->free_instances);
 	for (i = 0; i < rp->maxactive; i++) {
 		inst = kmalloc(sizeof(struct kretprobe_instance), GFP_KERNEL);
 		if (inst == NULL) {
 			free_rp_inst(rp);
 			return -ENOMEM;
 		}
-		INIT_HLIST_NODE(&inst->uflist);
-		hlist_add_head(&inst->uflist, &rp->free_instances);
+		INIT_LIST_HEAD(&inst->uflist);
+		list_add(&inst->uflist, &rp->free_instances);
 	}
 
 	rp->nmissed = 0;
@@ -671,21 +669,21 @@ void __kprobes unregister_kretprobe(stru
 	spin_lock_irqsave(&kretprobe_lock, flags);
 	while ((ri = get_used_rp_inst(rp)) != NULL) {
 		ri->rp = NULL;
-		hlist_del(&ri->uflist);
+		list_del(&ri->uflist);
 	}
 	spin_unlock_irqrestore(&kretprobe_lock, flags);
 	free_rp_inst(rp);
 }
 
-static int __init init_kprobes(void)
+int __init init_kprobes(void)
 {
 	int i, err = 0;
 
 	/* FIXME allocate the probe table, currently defined statically */
 	/* initialize all list heads */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
-		INIT_HLIST_HEAD(&kprobe_table[i]);
-		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
+		INIT_LIST_HEAD(&kprobe_table[i]);
+		INIT_LIST_HEAD(&kretprobe_inst_table[i]);
 	}
 
 	err = arch_init_kprobes();
@@ -695,8 +693,6 @@ static int __init init_kprobes(void)
 	return err;
 }
 
-__initcall(init_kprobes);
-
 EXPORT_SYMBOL_GPL(register_kprobe);
 EXPORT_SYMBOL_GPL(unregister_kprobe);
 EXPORT_SYMBOL_GPL(register_jprobe);
