Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSJVK4u>; Tue, 22 Oct 2002 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSJVK4u>; Tue, 22 Oct 2002 06:56:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1469 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262464AbSJVK4o>;
	Tue, 22 Oct 2002 06:56:44 -0400
Date: Tue, 22 Oct 2002 16:46:25 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, tom <hanharat@us.ibm.com>,
       richard <richardj_moore@uk.ibm.com>, suparna@in.ibm.com,
       bharata <bharata@in.ibm.com>
Subject: [patch 4/4] kprobes - user space probes for 2.5.44
Message-ID: <20021022164625.D26617@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch that enhances base kprobes infrastructure to
enable user space probes.

I have taken the approach of tacking user space extensions to
struct kprobe to minimise code duplication, while the most
intutive approach could have been to define a new struct uprobe.

The code which will be part the new dprobes external driver,
to exploit this interface is yet to be written. It will be
done once the interface is accepeted.

Comments welcome.
-
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
diff -urN -X /home/vamsi/.dontdiff 44-pure/arch/i386/kernel/kprobes.c 44-kprobes/arch/i386/kernel/kprobes.c
--- 44-pure/arch/i386/kernel/kprobes.c	2002-10-22 12:52:07.000000000 +0530
+++ 44-kprobes/arch/i386/kernel/kprobes.c	2002-10-22 14:19:35.000000000 +0530
@@ -33,8 +33,12 @@
 
 static inline void disarm_kprobe(struct kprobe *p, struct pt_regs *regs)
 {
-	*p->addr = p->opcode;
-	regs->eip = (unsigned long)p->addr;
+	if (!p->at.inode) {
+		/* remember the address to be used when rearming the probe. */
+		p->at.addr = (void *)(regs->eip - 1);
+	}
+	*p->at.addr = p->opcode;
+	regs->eip = (unsigned long)p->at.addr;
 }
 
 /*
@@ -99,7 +103,7 @@
 static void rearm_kprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	regs->eflags &= ~TF_MASK;
-	*p->addr = BREAKPOINT_INSTRUCTION;
+	*p->at.addr = BREAKPOINT_INSTRUCTION;
 }
 	
 /*
@@ -121,8 +125,14 @@
 	 * trap occurs in kernel space.
 	 */
 	if (current_kprobe->opcode == 0x9c) { /* pushfl */
-		regs->esp &= ~(TF_MASK | IF_MASK);
-		regs->esp |= kprobe_old_eflags;
+		unsigned long *tos;
+
+		if (regs->eip > PAGE_OFFSET)
+			tos = &regs->esp;
+		else
+			tos = (unsigned long *)regs->esp;
+		*tos &= ~(TF_MASK | IF_MASK);
+		*tos |= kprobe_old_eflags;
 	}
 
 	rearm_kprobe(current_kprobe, regs);
diff -urN -X /home/vamsi/.dontdiff 44-pure/include/linux/kprobes.h 44-kprobes/include/linux/kprobes.h
--- 44-pure/include/linux/kprobes.h	2002-10-22 12:52:07.000000000 +0530
+++ 44-kprobes/include/linux/kprobes.h	2002-10-22 14:19:35.000000000 +0530
@@ -2,6 +2,7 @@
 #define _LINUX_KPROBES_H
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/fs.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
 #include <asm/kprobes.h>
@@ -14,13 +15,18 @@
 				      unsigned long flags);
 typedef int (*kprobe_fault_handler_t)(struct kprobe *, struct pt_regs *,
 				      int trapnr);
+struct probe_at {
+	kprobe_opcode_t *addr;
+	struct inode *inode;	/* for user space probes */
+	unsigned long offset;	/* for user space probes */
+};
 
 struct kprobe {
 	struct list_head list;
 
 	/* location of the probe point */
-	kprobe_opcode_t *addr;
-
+	struct probe_at at;
+ 
 	 /* Called before addr is executed. */
 	kprobe_pre_handler_t pre_handler;
 
diff -urN -X /home/vamsi/.dontdiff 44-pure/kernel/kprobes.c 44-kprobes/kernel/kprobes.c
--- 44-pure/kernel/kprobes.c	2002-10-22 12:52:07.000000000 +0530
+++ 44-kprobes/kernel/kprobes.c	2002-10-22 14:19:35.000000000 +0530
@@ -30,34 +30,100 @@
 	spin_unlock(&kprobe_lock);
 }
 
+/*
+ * We need to look up the inode and offset from the vma. We can't depend on
+ * the page->(mapping, index) as that would be incorrect if we ever swap this
+ * page out (possible for pages which are dirtied by GDB breakpoints etc)
+ * 
+ * We acquire page_table_lock here to ensure that:
+ *	- current page doesn't go away from under us (kswapd)
+ *	- mm->mmap consistancy (vma are always added under this lock)
+ *
+ * We will never deadlock on page_table_lock, we always come here due to a
+ * probe in user space, no kernel code could have executed to take the
+ * page_table_lock.
+ */
+static struct kprobe *get_uprobe_at(struct inode *inode, unsigned long offset)
+{
+	struct list_head *head;
+	struct kprobe *p;
+	
+	head = &kprobe_table[hash_long((unsigned long)inode*offset, 
+					KPROBE_HASH_BITS)];
+	list_for_each_entry(p, head, list) {
+		if (p->at.inode == inode && p->at.offset == offset)
+			return p;
+	}
+	return NULL;
+}
+
+static struct kprobe *get_uprobe(void *addr)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct inode *inode;
+	unsigned long offset;
+
+	spin_lock(&mm->page_table_lock); 
+	vma = find_vma(mm, (unsigned long)addr);
+	offset = (unsigned long)addr - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
+	if (!vma->vm_file) {
+		spin_unlock(&mm->page_table_lock);
+		return NULL;
+	}
+	inode = vma->vm_file->f_dentry->d_inode;
+	spin_unlock(&mm->page_table_lock);
+
+	return get_uprobe_at(inode, offset);
+}
+
 /* You have to be holding the kprobe_lock */
 struct kprobe *get_kprobe(void *addr)
 {
 	struct list_head *head, *tmp;
 
+	if ((unsigned long)addr < PAGE_OFFSET)
+		return get_uprobe(addr);
+
 	head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
 	list_for_each(tmp, head) {
 		struct kprobe *p = list_entry(tmp, struct kprobe, list);
-		if (p->addr == addr)
+		if (p->at.addr == addr)
 			return p;
 	}
 	return NULL;
 }
 
+/*
+ * p->at.addr has to be writeable address for uspace probes.
+ */
 int register_kprobe(struct kprobe *p)
 {
 	int ret = 0;
+	kprobe_opcode_t *addr = p->at.addr;
 
 	spin_lock_irq(&kprobe_lock);
-	if (get_kprobe(p->addr)) {
-		ret = -EEXIST;
-		goto out;
+	if (!p->at.inode) {
+		if (get_kprobe(addr)) {
+			ret = -EEXIST;
+			goto out;
+		}
+		list_add(&p->list, &kprobe_table[hash_ptr(addr, 
+						 KPROBE_HASH_BITS)]);
+	} else {
+		if (get_uprobe_at(p->at.inode, p->at.offset)) {
+			ret = -EEXIST;
+			goto out;
+		}
+		list_add(&p->list, 
+			 &kprobe_table[hash_long(
+			 	(unsigned long)p->at.inode * p->at.offset,
+				KPROBE_HASH_BITS)]);
 	}
-	list_add(&p->list, &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
-	p->opcode = *p->addr;
-	*p->addr = BREAKPOINT_INSTRUCTION;
-	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
+	p->opcode = *addr;
+	*addr = BREAKPOINT_INSTRUCTION;
+	flush_icache_range(addr, addr + sizeof(kprobe_opcode_t));
  out:
 	spin_unlock_irq(&kprobe_lock);
 	return ret;
@@ -65,10 +131,12 @@
 
 void unregister_kprobe(struct kprobe *p)
 {
+	kprobe_opcode_t *addr = p->at.addr;
+
 	spin_lock_irq(&kprobe_lock);
-	*p->addr = p->opcode;
+	*addr = p->opcode;
 	list_del(&p->list);
-	flush_icache_range(p->addr, p->addr + sizeof(kprobe_opcode_t));
+	flush_icache_range(addr, addr + sizeof(kprobe_opcode_t));
 	spin_unlock_irq(&kprobe_lock);
 }
 
