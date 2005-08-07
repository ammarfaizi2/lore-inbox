Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753087AbVHGXUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbVHGXUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbVHGXUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:20:11 -0400
Received: from dvhart.com ([64.146.134.43]:64896 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1753082AbVHGXUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:20:10 -0400
Date: Sun, 07 Aug 2005 16:20:08 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] abstract out bits of ldt.c
Message-ID: <372830000.1123456808@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting on the work to merge xen cleanly as a subarch.
Introduce make_pages_readonly and make_pages_writable where appropriate 
for Xen, defined as a no-op on other subarches. Same for 
add_context_to_unpinned and del_context_from_unpinned.
Abstract out install_ldt_entry().

This will do have no effect whatsover on platforms other than xen.

Compile-tested with every config I can find. Boot tested on i386.

diff -aurpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/ldt.c xen-ldt.c/arch/i386/kernel/ldt.c
--- virgin/arch/i386/kernel/ldt.c	2004-10-24 19:27:13.000000000 -0700
+++ xen-ldt.c/arch/i386/kernel/ldt.c	2005-08-07 10:45:49.000000000 -0700
@@ -18,6 +18,7 @@
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
+#include <mach_ldt.h>
 
 #ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
 static void flush_ldt(void *null)
@@ -58,16 +59,22 @@ static int alloc_ldt(mm_context_t *pc, i
 #ifdef CONFIG_SMP
 		cpumask_t mask;
 		preempt_disable();
+		make_pages_readonly(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / 
+								PAGE_SIZE);
 		load_LDT(pc);
 		mask = cpumask_of_cpu(smp_processor_id());
 		if (!cpus_equal(current->mm->cpu_vm_mask, mask))
 			smp_call_function(flush_ldt, NULL, 1, 1);
 		preempt_enable();
 #else
+		make_pages_readonly(pc->ldt, (pc->size * LDT_ENTRY_SIZE) / 
+								PAGE_SIZE);
 		load_LDT(pc);
 #endif
 	}
 	if (oldsize) {
+		make_pages_writable(oldldt, (oldsize * LDT_ENTRY_SIZE) /
+								PAGE_SIZE);
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
 			vfree(oldldt);
 		else
@@ -82,6 +89,8 @@ static inline int copy_ldt(mm_context_t 
 	if (err < 0)
 		return err;
 	memcpy(new->ldt, old->ldt, old->size*LDT_ENTRY_SIZE);
+	make_pages_readonly(new->ldt, (new->size * LDT_ENTRY_SIZE) /
+								PAGE_SIZE);
 	return 0;
 }
 
@@ -94,14 +103,16 @@ int init_new_context(struct task_struct 
 	struct mm_struct * old_mm;
 	int retval = 0;
 
+	memset(&mm->context, 0, sizeof(mm->context));
 	init_MUTEX(&mm->context.sem);
-	mm->context.size = 0;
 	old_mm = current->mm;
 	if (old_mm && old_mm->context.size > 0) {
 		down(&old_mm->context.sem);
 		retval = copy_ldt(&mm->context, &old_mm->context);
 		up(&old_mm->context.sem);
 	}
+	if (retval == 0)
+		add_context_to_unpinned(mm);
 	return retval;
 }
 
@@ -113,12 +124,16 @@ void destroy_context(struct mm_struct *m
 	if (mm->context.size) {
 		if (mm == current->active_mm)
 			clear_LDT();
+		make_pages_writable(mm->context.ldt,
+				(mm->context.size * LDT_ENTRY_SIZE) /
+				PAGE_SIZE);
 		if (mm->context.size*LDT_ENTRY_SIZE > PAGE_SIZE)
 			vfree(mm->context.ldt);
 		else
 			kfree(mm->context.ldt);
 		mm->context.size = 0;
 	}
+	del_context_from_unpinned(mm);
 }
 
 static int read_ldt(void __user * ptr, unsigned long bytecount)
@@ -223,9 +238,7 @@ static int write_ldt(void __user * ptr, 
 
 	/* Install the new entry ...  */
 install:
-	*lp	= entry_1;
-	*(lp+1)	= entry_2;
-	error = 0;
+	error = install_ldt_entry(lp, entry_1, entry_2);
 
 out_unlock:
 	up(&mm->context.sem);
diff -aurpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/mach-default/mach_ldt.h xen-ldt.c/include/asm-i386/mach-default/mach_ldt.h
--- virgin/include/asm-i386/mach-default/mach_ldt.h	1969-12-31 16:00:00.000000000 -0800
+++ xen-ldt.c/include/asm-i386/mach-default/mach_ldt.h	2005-08-07 10:43:58.000000000 -0700
@@ -0,0 +1,27 @@
+#ifndef __ASM_MACH_LDT_H
+#define __ASM_MACH_LDT_H
+
+static inline void make_pages_readonly(void *va, unsigned int nr)
+{
+}
+
+static inline void make_pages_writable(void *va, unsigned int nr)
+{
+}
+
+static inline void add_context_to_unpinned(struct mm_struct *mm)
+{
+}
+
+static inline void del_context_from_unpinned(struct mm_struct *mm)
+{
+}
+
+static inline int install_ldt_entry (__u32 *lp, __u32 entry_1, __u32 entry_2)
+{
+	*lp     = entry_1;
+	*(lp+1) = entry_2;
+	return 0;
+}
+
+#endif /* __ASM_MACH_LDT_H */
diff -aurpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/mach-xen/mach_ldt.h xen-ldt.c/include/asm-i386/mach-xen/mach_ldt.h
--- virgin/include/asm-i386/mach-xen/mach_ldt.h	1969-12-31 16:00:00.000000000 -0800
+++ xen-ldt.c/include/asm-i386/mach-xen/mach_ldt.h	2005-08-07 10:44:45.000000000 -0700
@@ -0,0 +1,27 @@
+#ifndef __ASM_MACH_LDT_H
+#define __ASM_MACH_LDT_H
+
+static inline void add_context_to_unpinned(struct mm_struct *mm)
+{
+	spin_lock(&mm_unpinned_lock);
+	list_add(&mm->context.unpinned, &mm_unpinned);
+	spin_unlock(&mm_unpinned_lock);
+}
+
+static inline void del_context_from_unpinned(struct mm_struct *mm)
+{
+	if (!mm->context.pinned) {
+		spin_lock(&mm_unpinned_lock);
+		list_del(&mm->context.unpinned);
+		spin_unlock(&mm_unpinned_lock);
+	}
+}
+
+static inline int install_ldt_entry (__u32 *lp, __u32 entry_1, __u32 entry_2)
+{
+	unsigned long mach_lp = arbitrary_virt_to_machine(lp);
+
+	return HYPERVISOR_update_descriptor(mach_lp, entry_1, entry_2);
+}
+
+#endif /* __ASM_MACH_LDT_H */

