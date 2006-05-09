Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWEIHFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWEIHFS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEIHFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:05:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59341 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751435AbWEIHFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:05:15 -0400
Date: Tue, 9 May 2006 12:35:08 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Message-ID: <20060509070508.GC22493@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060509065455.GA11630@in.ibm.com> <20060509065917.GA22493@in.ibm.com> <20060509070106.GB22493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509070106.GB22493@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides two interfaces to insert and remove
user space probes. Each probe is uniquely identified by
inode and offset within that executable/library file.
Insertion of a probe involves getting the code page for
a given offset, mapping it into the memory and then inserting
the breakpoint at the given offset. Also the probe is added
to the uprobe_table hash list. A uprobe_module data structure
is allocated for every probed application/library image on disk.
Removal of a probe involves getting the code page for a given
offset, mapping that page into the memory and then replacing
the breakpoint instruction with a the original opcode.
This patch also provides aggregate probe handler feature,
where user can define multiple handlers per probe.

Signed-off-by : Prasanna S Panchamukhi <prasanna@in.ibm.com>


 arch/i386/kernel/uprobes.c |   71 +++++
 include/linux/kprobes.h    |   61 ++++
 include/linux/list.h       |   16 +
 kernel/Makefile            |    4 
 kernel/kprobes.c           |   19 +
 kernel/uprobes.c           |  579 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 748 insertions(+), 2 deletions(-)

diff -puN include/linux/kprobes.h~kprobes_userspace_probes-base-interface include/linux/kprobes.h
--- linux-2.6.17-rc3-mm1/include/linux/kprobes.h~kprobes_userspace_probes-base-interface	2006-05-09 10:08:47.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/include/linux/kprobes.h	2006-05-09 12:32:50.000000000 +0530
@@ -37,6 +37,10 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
+#include <linux/mm.h>
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>
 
 #ifdef CONFIG_KPROBES
 #include <asm/kprobes.h>
@@ -47,6 +51,13 @@
 #define KPROBE_REENTER		0x00000004
 #define KPROBE_HIT_SSDONE	0x00000008
 
+/* uprobe_status settings */
+#define UPROBE_HIT_ACTIVE	0x00000001
+#define UPROBE_HIT_SS		0x00000002
+#define UPROBE_HIT_SSDONE	0x00000004
+#define UPROBE_SS_INLINE	0x00000008
+#define UPROBE_SSDONE_INLINE	0x00000010
+
 /* Attach to insert probes on any functions which should be ignored*/
 #define __kprobes	__attribute__((__section__(".kprobes.text")))
 
@@ -54,6 +65,7 @@ struct kprobe;
 struct pt_regs;
 struct kretprobe;
 struct kretprobe_instance;
+extern struct uprobe *current_uprobe;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
 typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
@@ -117,6 +129,32 @@ struct jprobe {
 DECLARE_PER_CPU(struct kprobe *, current_kprobe);
 DECLARE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
+struct uprobe {
+	/* pointer to the pathname of the application */
+	char *pathname;
+	/* kprobe structure with user specified handlers */
+	struct kprobe kp;
+	/* hlist of all the userspace probes per application */
+	struct hlist_node ulist;
+	/* inode of the probed application */
+	struct inode *inode;
+	/* probe offset within the file */
+	unsigned long offset;
+};
+
+struct uprobe_module {
+	/* hlist head of all userspace probes per application */
+	struct hlist_head ulist_head;
+	/* list of all uprobe_module for probed application */
+	struct list_head mlist;
+	/* to hold path/dentry etc. */
+	struct nameidata nd;
+	/* original readpage operations */
+	struct address_space_operations *ori_a_ops;
+	/* readpage hooks added operations */
+	struct address_space_operations user_a_ops;
+};
+
 #ifdef ARCH_SUPPORTS_KRETPROBES
 extern void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs);
 #else /* ARCH_SUPPORTS_KRETPROBES */
@@ -153,6 +191,7 @@ struct kretprobe_instance {
 };
 
 extern spinlock_t kretprobe_lock;
+extern spinlock_t uprobe_lock;
 extern struct mutex kprobe_mutex;
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
@@ -162,9 +201,16 @@ extern void show_registers(struct pt_reg
 extern kprobe_opcode_t *get_insn_slot(void);
 extern void free_insn_slot(kprobe_opcode_t *slot);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
+extern void copy_kprobe(struct kprobe *old_p, struct kprobe *p);
+extern int arch_copy_uprobe(struct kprobe *p, kprobe_opcode_t *address);
+extern void arch_arm_uprobe(kprobe_opcode_t *address);
+extern void arch_disarm_uprobe(struct kprobe *p, kprobe_opcode_t *address);
+extern void init_uprobes(void);
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
+struct kprobe *get_uprobe(void *addr);
+extern int arch_alloc_insn(struct kprobe *p);
 struct hlist_head * kretprobe_inst_table_head(struct task_struct *tsk);
 
 /* kprobe_running() will just return the current_kprobe on this CPU */
@@ -183,6 +229,16 @@ static inline struct kprobe_ctlblk *get_
 	return (&__get_cpu_var(kprobe_ctlblk));
 }
 
+static inline void set_uprobe_instance(struct kprobe *p)
+{
+	current_uprobe = container_of(p, struct uprobe, kp);
+}
+
+static inline void reset_uprobe_instance(void)
+{
+	current_uprobe = NULL;
+}
+
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int setjmp_pre_handler(struct kprobe *, struct pt_regs *);
@@ -194,10 +250,15 @@ void jprobe_return(void);
 int register_kretprobe(struct kretprobe *rp);
 void unregister_kretprobe(struct kretprobe *rp);
 
+int register_uprobe(struct uprobe *uprobe);
+void unregister_uprobe(struct uprobe *uprobe);
+
 struct kretprobe_instance *get_free_rp_inst(struct kretprobe *rp);
 void add_rp_inst(struct kretprobe_instance *ri);
 void kprobe_flush_task(struct task_struct *tk);
 void recycle_rp_inst(struct kretprobe_instance *ri);
+void kprobes_add_pagefault_notifier(void);
+void kprobes_remove_pagefault_notifier(void);
 #else /* CONFIG_KPROBES */
 
 #define __kprobes	/**/
diff -puN /dev/null kernel/uprobes.c
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/kernel/uprobes.c	2006-05-09 12:32:57.000000000 +0530
@@ -0,0 +1,579 @@
+/*
+ *  User-space Probes (UProbes)
+ *  kernel/uprobes.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * 2006-Mar	Created by Prasanna S Panchamukhi <prasanna@in.ibm.com>
+ *		User-space probes initial implementation based on IBM's
+ *		Dprobes.
+ */
+#include <linux/kprobes.h>
+#include <linux/hash.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/moduleloader.h>
+#include <asm-generic/sections.h>
+#include <asm/cacheflush.h>
+#include <asm/errno.h>
+#include <asm/kdebug.h>
+
+#define UPROBE_HASH_BITS 6
+#define UPROBE_TABLE_SIZE (1 << UPROBE_HASH_BITS)
+
+/* user space probes lists */
+static struct list_head uprobe_module_list;
+static struct hlist_head uprobe_table[UPROBE_TABLE_SIZE];
+DEFINE_SPINLOCK(uprobe_lock);		/* Protects uprobe_table*/
+DEFINE_MUTEX(uprobe_mutex);		/* Protects uprobe_module_table */
+
+/*
+ * Aggregate handlers for multiple uprobes support - these handlers
+ * take care of invoking the individual uprobe handlers on p->list
+ */
+static int __kprobes aggr_user_pre_handler(struct kprobe *p,
+							 struct pt_regs *regs)
+{
+	struct kprobe *kp;
+
+	list_for_each_entry(kp, &p->list, list) {
+		if (kp->pre_handler) {
+			set_uprobe_instance(kp);
+			if (kp->pre_handler(kp, regs))
+				return 1;
+		}
+	}
+	return 0;
+}
+
+static void __kprobes aggr_user_post_handler(struct kprobe *p,
+				struct pt_regs *regs, unsigned long flags)
+{
+	struct kprobe *kp;
+
+	list_for_each_entry(kp, &p->list, list) {
+		if (kp->post_handler) {
+			set_uprobe_instance(kp);
+			kp->post_handler(kp, regs, flags);
+		}
+	}
+}
+
+static int __kprobes aggr_user_fault_handler(struct kprobe *p,
+					struct pt_regs *regs, int trapnr)
+{
+	struct kprobe *cur;
+
+	/*
+	 * if we faulted "during" the execution of a user specified
+	 * probe handler, invoke just that probe's fault handler
+	 */
+	cur = &current_uprobe->kp;
+	if (cur && cur->fault_handler)
+		if (cur->fault_handler(cur, regs, trapnr))
+			return 1;
+	return 0;
+}
+
+/*
+ * This routine looks for an existing uprobe at the given offset and inode.
+ * If it's found, returns the corresponding kprobe pointer.
+ * This should be called with uprobe_lock held.
+ */
+static struct kprobe __kprobes *get_kprobe_user(struct inode *inode,
+							unsigned long offset)
+{
+	struct hlist_head *head;
+	struct hlist_node *node;
+	struct kprobe *p, *kpr;
+	struct uprobe *uprobe;
+
+	head = &uprobe_table[hash_ptr((kprobe_opcode_t *)
+			(((unsigned long)inode) * offset), UPROBE_HASH_BITS)];
+
+	hlist_for_each_entry(p, node, head, hlist) {
+		if (p->pre_handler == aggr_user_pre_handler) {
+			kpr = list_entry(p->list.next, typeof(*kpr), list);
+			uprobe = container_of(kpr, struct uprobe, kp);
+		} else
+			uprobe = container_of(p, struct uprobe, kp);
+
+		if ((uprobe->inode == inode) && (uprobe->offset == offset))
+			return p;
+	}
+
+	return NULL;
+}
+
+/*
+ * Finds a uprobe at the specified user-space address in the current task.
+ * Points current_uprobe at that uprobe and returns the corresponding kprobe.
+ */
+struct kprobe __kprobes *get_uprobe(void *addr)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct inode *inode;
+	unsigned long offset;
+	struct kprobe *p, *kpr;
+	struct uprobe *uprobe;
+
+	if (!down_read_trylock(&mm->mmap_sem))
+		down_read(&mm->mmap_sem);
+	vma = find_vma(mm, (unsigned long)addr);
+
+	BUG_ON(!vma);	/* this should not happen, not in our memory map */
+
+	offset = (unsigned long)addr - (vma->vm_start +
+						(vma->vm_pgoff << PAGE_SHIFT));
+	if (!vma->vm_file) {
+		up_read(&mm->mmap_sem);
+		return NULL;
+	}
+
+	inode = vma->vm_file->f_dentry->d_inode;
+	up_read(&mm->mmap_sem);
+
+	p = get_kprobe_user(inode, offset);
+	if (!p)
+		return NULL;
+
+	if (p->pre_handler == aggr_user_pre_handler) {
+		/*
+		 * Walk the uprobe aggregate list and return firt
+		 * element on aggregate list.
+		 */
+		kpr = list_entry((p)->list.next, typeof(*kpr), list);
+		uprobe = container_of(kpr, struct uprobe, kp);
+	} else
+		uprobe = container_of(p, struct uprobe, kp);
+
+	if (uprobe)
+		current_uprobe = uprobe;
+
+	return p;
+}
+
+/*
+ * Fill in the required fields of the "manager uprobe". Replace the
+ * earlier kprobe in the hlist with the manager uprobe
+ */
+static inline void add_aggr_uprobe(struct kprobe *ap, struct kprobe *p)
+{
+	copy_kprobe(p, ap);
+	ap->addr = p->addr;
+	ap->pre_handler = aggr_user_pre_handler;
+	ap->post_handler = aggr_user_post_handler;
+	ap->fault_handler = aggr_user_fault_handler;
+
+	INIT_LIST_HEAD(&ap->list);
+	list_add(&p->list, &ap->list);
+
+	hlist_replace(&p->hlist, &ap->hlist);
+}
+
+/*
+ * This is the second or subsequent uprobe at the address - handle
+ * the intricacies
+ */
+static int __kprobes register_aggr_uprobe(struct kprobe *old_p,
+					  struct kprobe *p)
+{
+	struct kprobe *ap;
+
+	if (old_p->pre_handler == aggr_user_pre_handler) {
+		copy_kprobe(old_p, p);
+		list_add(&p->list, &old_p->list);
+	} else {
+		ap = kzalloc(sizeof(struct kprobe), GFP_ATOMIC);
+		if (!ap)
+			return -ENOMEM;
+		add_aggr_uprobe(ap, old_p);
+		copy_kprobe(ap, p);
+		list_add(&p->list, &old_p->list);
+	}
+	return 0;
+}
+
+typedef int (*process_uprobe_func_t)(struct uprobe *uprobe,
+				kprobe_opcode_t *address);
+
+/*
+ * Saves the original instruction in the uprobe structure and
+ * inserts the breakpoint at the given address.
+ */
+int __kprobes insert_kprobe_user(struct uprobe *uprobe,
+				kprobe_opcode_t *address)
+{
+	int ret = 0;
+
+	ret = arch_copy_uprobe(&uprobe->kp, address);
+	if (ret) {
+		printk("Breakpoint already present\n");
+		return ret;
+	}
+	arch_arm_uprobe(address);
+
+	return 0;
+}
+
+/*
+ * Wait for the page to be unlocked if someone else had locked it,
+ * then map the page and insert or remove the breakpoint.
+ */
+static int __kprobes map_uprobe_page(struct page *page, struct uprobe *uprobe,
+				     process_uprobe_func_t process_kprobe_user)
+{
+	int ret = 0;
+	kprobe_opcode_t *uprobe_address;
+
+	if (!page)
+		return -EINVAL; /* TODO: more suitable errno */
+
+	lock_page(page);
+
+	uprobe_address = (kprobe_opcode_t *)kmap_atomic(page, KM_USER0);
+	uprobe_address = (kprobe_opcode_t *)((unsigned long)uprobe_address +
+						(uprobe->offset & ~PAGE_MASK));
+	ret = (*process_kprobe_user)(uprobe, uprobe_address);
+	kunmap_atomic(uprobe_address, KM_USER0);
+
+	unlock_page(page);
+
+	return ret;
+}
+
+/*
+ * flush_vma walks through the list of process private mappings,
+ * gets the vma containing the offset and flushes all the vmas
+ * containing the probed page.
+ */
+static void __kprobes flush_vma(struct address_space *mapping,
+				struct page *page, struct uprobe *uprobe)
+{
+	struct vm_area_struct *vma = NULL;
+	struct prio_tree_iter iter;
+	struct prio_tree_root *head = &mapping->i_mmap;
+	unsigned long start, end, offset = uprobe->offset;
+
+	spin_lock(&mapping->i_mmap_lock);
+	vma_prio_tree_foreach(vma, &iter, head, offset, offset) {
+		start = vma->vm_start - (vma->vm_pgoff << PAGE_SHIFT);
+		end = vma->vm_end - (vma->vm_pgoff << PAGE_SHIFT);
+
+		if ((start + offset) < end)
+			flush_icache_user_range(vma, page,
+					(unsigned long)uprobe->kp.addr,
+						sizeof(kprobe_opcode_t));
+	}
+	spin_unlock(&mapping->i_mmap_lock);
+}
+
+/*
+ * Walk the uprobe_module_list and return the uprobe module with matching
+ * inode.
+ */
+struct uprobe_module __kprobes *get_module_by_inode(struct inode *inode)
+{
+	struct uprobe_module *umodule;
+
+	list_for_each_entry(umodule, &uprobe_module_list, mlist) {
+		if (umodule->nd.dentry->d_inode == inode)
+			return umodule;
+	}
+
+	return NULL;
+}
+
+/*
+ * Add uprobe and uprobe_module to the appropriate hash list.
+ */
+static void __kprobes get_inode_ops(struct uprobe *uprobe,
+				   struct uprobe_module *umodule)
+{
+	INIT_HLIST_HEAD(&umodule->ulist_head);
+	hlist_add_head(&uprobe->ulist, &umodule->ulist_head);
+	list_add(&umodule->mlist, &uprobe_module_list);
+}
+
+/*
+ * Removes the specified uprobe from either aggregate uprobe list
+ * or individual uprobe hash table.
+ */
+
+static int __kprobes remove_uprobe(struct uprobe *uprobe)
+{
+	struct kprobe *old_p, *list_p, *p;
+	int ret = 0;
+
+	p = &uprobe->kp;
+	old_p = get_kprobe_user(uprobe->inode, uprobe->offset);
+	if (unlikely(!old_p))
+		return 0;
+
+	if (p != old_p) {
+		list_for_each_entry(list_p, &old_p->list, list)
+			if (list_p == p)
+			/* kprobe p is a valid probe */
+				goto valid_p;
+		return 0;
+	}
+
+valid_p:
+	if ((old_p == p) ||
+			((old_p->pre_handler == aggr_user_pre_handler) &&
+			(p->list.next == &old_p->list) &&
+			(p->list.prev == &old_p->list))) {
+		/*
+		 * Only probe on the hash list, mark the corresponding
+		 * instruction slot for freeing by return 1.
+		 */
+		ret = 1;
+		hlist_del(&old_p->hlist);
+		if (p != old_p) {
+			list_del(&p->list);
+			kfree(old_p);
+		}
+	} else
+		list_del(&p->list);
+
+	return ret;
+}
+
+/*
+ * Disarms the probe and frees the corresponding instruction slot.
+ */
+static int __kprobes remove_kprobe_user(struct uprobe *uprobe,
+				kprobe_opcode_t *address)
+{
+	struct kprobe *p = &uprobe->kp;
+
+	arch_disarm_uprobe(p, address);
+	arch_remove_kprobe(p);
+
+	return 0;
+}
+
+/*
+ * Adds the given uprobe to the uprobe_hash table if it is
+ * the first probe to be inserted at the given address else
+ * adds to the aggregate uprobe's list.
+ */
+static int __kprobes insert_uprobe(struct uprobe *uprobe)
+{
+	struct kprobe *old_p;
+	int ret = 0;
+	unsigned long offset = uprobe->offset;
+	unsigned long inode = (unsigned long) uprobe->inode;
+	struct hlist_head *head;
+	unsigned long flags;
+
+	spin_lock_irqsave(&uprobe_lock, flags);
+	uprobe->kp.nmissed = 0;
+
+	old_p = get_kprobe_user(uprobe->inode, uprobe->offset);
+
+	if (old_p)
+		register_aggr_uprobe(old_p, &uprobe->kp);
+	else {
+		head = &uprobe_table[hash_ptr((kprobe_opcode_t *)
+					(offset * inode), UPROBE_HASH_BITS)];
+		INIT_HLIST_NODE(&uprobe->kp.hlist);
+		hlist_add_head(&uprobe->kp.hlist, head);
+		/*
+		 * The original instruction must be copied into the instruction
+		 * slot, hence return 1.
+		 */
+		ret = 1;
+	}
+
+	spin_unlock_irqrestore(&uprobe_lock, flags);
+
+	return ret;
+}
+
+/*
+ * unregister_uprobe: Disarms the probe, removes the uprobe
+ * pointers from the hash list and unhooks readpage routines.
+ */
+void __kprobes unregister_uprobe(struct uprobe *uprobe)
+{
+	struct address_space *mapping;
+	struct uprobe_module *umodule;
+	struct page *page;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!uprobe->inode)
+		return;
+
+	mapping = uprobe->inode->i_mapping;
+
+	page = find_get_page(mapping, uprobe->offset >> PAGE_CACHE_SHIFT);
+
+	spin_lock_irqsave(&uprobe_lock, flags);
+	ret = remove_uprobe(uprobe);
+	spin_unlock_irqrestore(&uprobe_lock, flags);
+
+	mutex_lock(&uprobe_mutex);
+	if (!(umodule = get_module_by_inode(uprobe->inode)))
+		goto out;
+
+	hlist_del(&uprobe->ulist);
+	if (hlist_empty(&umodule->ulist_head)) {
+		list_del(&umodule->mlist);
+		write_access_to_inode(uprobe->inode);
+		path_release(&umodule->nd);
+		kfree(umodule);
+	}
+	/* Unregister pagefault notifier, if no probes. */
+	mutex_lock(&kprobe_mutex);
+	kprobes_remove_pagefault_notifier();
+	mutex_unlock(&kprobe_mutex);
+out:
+	mutex_unlock(&uprobe_mutex);
+	if (ret)
+		ret = map_uprobe_page(page, uprobe, remove_kprobe_user);
+
+	if (ret == -EINVAL)
+		return;
+	/*
+	 * TODO: unregister_uprobe should not fail, need to handle
+	 * if it fails.
+	 */
+	flush_vma(mapping, page, uprobe);
+
+	if (page)
+		page_cache_release(page);
+}
+
+/*
+ * register_uprobe(): combination of inode and offset is used to
+ * identify each probe uniquely. Each uprobe can be found from the
+ * uprobes_hash table by using inode and offset. register_uprobe(),
+ * inserts the breakpoint at the given address by locating and mapping
+ * the page. return 0 on success and error on failure.
+ */
+int __kprobes register_uprobe(struct uprobe *uprobe)
+{
+	struct address_space *mapping;
+	struct uprobe_module *umodule = NULL;
+	struct inode *inode;
+	struct nameidata nd;
+	struct page *page;
+	int error = 0;
+
+	INIT_HLIST_NODE(&uprobe->ulist);
+
+	/*
+	 * TODO: Need to calculate the absolute file offset for dynamic
+	 * shared libraries.
+	 */
+	if ((error = path_lookup(uprobe->pathname, LOOKUP_FOLLOW, &nd)))
+		return error;
+
+	mutex_lock(&uprobe_mutex);
+
+	inode = nd.dentry->d_inode;
+	error = deny_write_access_to_inode(inode);
+	if (error)
+		goto out;
+
+	error = arch_alloc_insn(&uprobe->kp);
+	if (error) {
+		write_access_to_inode(inode);
+		goto out;
+	}
+
+	/*
+	 * Check if there are probes already on this application and
+	 * add the corresponding uprobe to per application probe's list.
+	 */
+	umodule = get_module_by_inode(inode);
+	if (!umodule) {
+		/*
+		 * Allocate a uprobe_module structure for this
+		 * application if not allocated before.
+		 */
+		umodule = kzalloc(sizeof(struct uprobe_module), GFP_KERNEL);
+		if (!umodule) {
+			error = -ENOMEM;
+			write_access_to_inode(inode);
+			arch_remove_kprobe(&uprobe->kp);
+			goto out;
+		}
+		memcpy(&umodule->nd, &nd, sizeof(struct nameidata));
+		get_inode_ops(uprobe, umodule);
+	} else {
+		path_release(&nd);
+		write_access_to_inode(inode);
+		hlist_add_head(&uprobe->ulist, &umodule->ulist_head);
+	}
+	mutex_unlock(&uprobe_mutex);
+	/*
+	 * Register pagefault notifier, if not one registered.
+	 */
+	mutex_lock(&kprobe_mutex);
+	kprobes_add_pagefault_notifier();
+	mutex_unlock(&kprobe_mutex);
+
+	uprobe->inode = inode;
+	mapping = inode->i_mapping;
+	page = find_get_page(mapping, (uprobe->offset >> PAGE_CACHE_SHIFT));
+
+	if (insert_uprobe(uprobe))
+		error = map_uprobe_page(page, uprobe, insert_kprobe_user);
+	else
+		arch_remove_kprobe(&uprobe->kp);
+
+	/*
+	 * If error == -EINVAL, return success, probes will inserted by
+	 * readpage hooks.
+	 * TODO: Use a more suitable errno?
+	 */
+	if (error == -EINVAL)
+		error = 0;
+	flush_vma(mapping, page, uprobe);
+
+	if (page)
+		page_cache_release(page);
+
+	return error;
+out:
+	path_release(&nd);
+	mutex_unlock(&uprobe_mutex);
+
+	return error;
+}
+
+void init_uprobes(void)
+{
+	int i;
+
+	/* FIXME allocate the probe table, currently defined statically */
+	/* initialize all list heads */
+	for (i = 0; i < UPROBE_TABLE_SIZE; i++)
+		INIT_HLIST_HEAD(&uprobe_table[i]);
+
+	INIT_LIST_HEAD(&uprobe_module_list);
+}
+
+EXPORT_SYMBOL_GPL(register_uprobe);
+EXPORT_SYMBOL_GPL(unregister_uprobe);
+
+
diff -puN /dev/null arch/i386/kernel/uprobes.c
--- /dev/null	2004-06-24 23:34:38.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/arch/i386/kernel/uprobes.c	2006-05-09 12:32:52.000000000 +0530
@@ -0,0 +1,71 @@
+/*
+ *  User-space Probes (UProbes)
+ *  arch/i386/kernel/uprobes.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006.
+ *
+ * 2006-Mar	Created by Prasanna S Panchamukhi <prasanna@in.ibm.com>
+ *		User-space probes initial implementation based on IBM's
+ *		Dprobes.
+ */
+
+#include <linux/config.h>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/preempt.h>
+#include <asm/cacheflush.h>
+#include <asm/kdebug.h>
+#include <asm/desc.h>
+
+int __kprobes arch_alloc_insn(struct kprobe *p)
+{
+	mutex_lock(&kprobe_mutex);
+	p->ainsn.insn = get_insn_slot();
+	mutex_unlock(&kprobe_mutex);
+
+	if (!p->ainsn.insn)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void __kprobes arch_disarm_uprobe(struct kprobe *p, kprobe_opcode_t *address)
+{
+	if (p->opcode != BREAKPOINT_INSTRUCTION)
+		*address = p->opcode;
+}
+
+void __kprobes arch_arm_uprobe(kprobe_opcode_t *address)
+{
+	*address = BREAKPOINT_INSTRUCTION;
+}
+
+int __kprobes arch_copy_uprobe(struct kprobe *p, kprobe_opcode_t *address)
+{
+	int ret = 1;
+
+	/*
+	 * TODO: Check if the given address is a valid to access user memory.
+	 */
+	if (*address != BREAKPOINT_INSTRUCTION) {
+		memcpy(p->ainsn.insn, address, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
+		ret = 0;
+	}
+	p->opcode = *(kprobe_opcode_t *)address;
+
+	return ret;
+}
diff -puN kernel/kprobes.c~kprobes_userspace_probes-base-interface kernel/kprobes.c
--- linux-2.6.17-rc3-mm1/kernel/kprobes.c~kprobes_userspace_probes-base-interface	2006-05-09 10:08:47.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/kernel/kprobes.c	2006-05-09 10:08:47.000000000 +0530
@@ -47,7 +47,7 @@
 
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
-static atomic_t kprobe_count;
+atomic_t kprobe_count;
 
 DEFINE_MUTEX(kprobe_mutex);		/* Protects kprobe_table */
 DEFINE_SPINLOCK(kretprobe_lock);	/* Protects kretprobe_inst_table */
@@ -58,6 +58,20 @@ static struct notifier_block kprobe_page
 	.priority = 0x7fffffff /* we need to notified first */
 };
 
+void kprobes_add_pagefault_notifier(void)
+{
+	if (atomic_add_return(1, &kprobe_count) == \
+				(ARCH_INACTIVE_KPROBE_COUNT + 1))
+		register_page_fault_notifier(&kprobe_page_fault_nb);
+}
+
+void kprobes_remove_pagefault_notifier(void)
+{
+	if (atomic_add_return(-1, &kprobe_count) == \
+				ARCH_INACTIVE_KPROBE_COUNT)
+		unregister_page_fault_notifier(&kprobe_page_fault_nb);
+}
+
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 /*
  * kprobe->ainsn.insn points to the copy of the instruction to be
@@ -362,7 +376,7 @@ static inline void free_rp_inst(struct k
 /*
  * Keep all fields in the kprobe consistent
  */
-static inline void copy_kprobe(struct kprobe *old_p, struct kprobe *p)
+void copy_kprobe(struct kprobe *old_p, struct kprobe *p)
 {
 	memcpy(&p->opcode, &old_p->opcode, sizeof(kprobe_opcode_t));
 	memcpy(&p->ainsn, &old_p->ainsn, sizeof(struct arch_specific_insn));
@@ -693,6 +707,7 @@ static int __init init_kprobes(void)
 	}
 	atomic_set(&kprobe_count, 0);
 
+	init_uprobes();
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
diff -puN include/linux/list.h~kprobes_userspace_probes-base-interface include/linux/list.h
--- linux-2.6.17-rc3-mm1/include/linux/list.h~kprobes_userspace_probes-base-interface	2006-05-09 10:08:47.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/include/linux/list.h	2006-05-09 10:08:47.000000000 +0530
@@ -655,6 +655,22 @@ static inline void hlist_replace_rcu(str
 	old->pprev = LIST_POISON2;
 }
 
+/*
+ * The old entry will be replaced with the new entry atomically.
+ */
+static inline void hlist_replace(struct hlist_node *old,
+					struct hlist_node *new)
+{
+	struct hlist_node *next = old->next;
+
+	new->next = next;
+	new->pprev = old->pprev;
+	if (next)
+		new->next->pprev = &new->next;
+	*new->pprev = new;
+	old->pprev = LIST_POISON2;
+}
+
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
diff -puN kernel/Makefile~kprobes_userspace_probes-base-interface kernel/Makefile
--- linux-2.6.17-rc3-mm1/kernel/Makefile~kprobes_userspace_probes-base-interface	2006-05-09 10:08:47.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/kernel/Makefile	2006-05-09 10:08:47.000000000 +0530
@@ -35,7 +35,11 @@ obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+ifeq ($(CONFIG_X86_32),y)
+obj-$(CONFIG_KPROBES) += kprobes.o uprobes.o
+else
 obj-$(CONFIG_KPROBES) += kprobes.o
+endif
 obj-$(CONFIG_KGDB) += kgdb.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
