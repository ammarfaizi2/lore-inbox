Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSGDKW6>; Thu, 4 Jul 2002 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSGDKW5>; Thu, 4 Jul 2002 06:22:57 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:44295 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317385AbSGDKWz>;
	Thu, 4 Jul 2002 06:22:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19-rc1 discard __initdata from modules
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 20:25:17 +1000
Message-ID: <15284.1025778317@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch discards __initdata from modules after they have executed
module_init().  No modutils changes are required.

The patch adds a new vm function, vsplit().  This function takes an
existing vmalloc area and splits it into two vm areas, which can then
be processed individually.  Rusty suggested creating a new allocator
that returned two contiguous vm areas but IMHO this is simpler,
module.c only has to to track one vm area, expect in the few lines that
split then discard the init sections.

Discarding __init (text) as well as data is a trivial change to init.h.
Do NOT make that change until all architectures have been patched to
adjust their tables for exception handling, unwind data etc. to cope
with code areas disappearing.

The patch was done on 2.4.19-rc1.  It needs some work for 2.5.24, I am
not sure what to do with vm_struct phys_addr.

Index: 19-rc1.4/mm/vmalloc.c
--- 19-rc1.4/mm/vmalloc.c Fri, 11 Jan 2002 15:36:30 +1100 kaos (linux-2.4/j/15_vmalloc.c 1.1.2.1.1.1.2.2.3.2.4.1.1.2 644)
+++ 19-rc1.4(w)/mm/vmalloc.c Thu, 04 Jul 2002 20:01:43 +1000 kaos (linux-2.4/j/15_vmalloc.c 1.1.2.1.1.1.2.2.3.2.4.1.1.2 644)
@@ -4,6 +4,7 @@
  *  Copyright (C) 1993  Linus Torvalds
  *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
  *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian <tigran@veritas.com>, May 2000
+ *  vsplit().  Keith Owens <kaos@ocs.com.au>, July 2002
  */
 
 #include <linux/config.h>
@@ -202,6 +203,61 @@ out:
 	return NULL;
 }
 
+/**
+ * vsplit - split an existing vmalloc area into two.
+ * @start: start address of the existing vmalloc area.
+ * @split: address within the existing area where the split is to be done.
+ *
+ * Description: Both start and split must be page aligned addresses.
+ * split must fall within the existing vmalloc area defined by start.
+ * Returns the address of the split data or NULL for any errors.
+ */
+void *
+vsplit(void *start, void *split)
+{
+	struct vm_struct *p, *new;
+	void *ret = NULL;
+
+	new = (struct vm_struct *) kmalloc(sizeof (*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+	if (!start || ((PAGE_SIZE - 1) & (unsigned long) start)) {
+		printk(KERN_ERR "Trying to vsplit() bad start address (%p)\n",
+		       start);
+		goto out;
+	}
+	write_lock(&vmlist_lock);
+	for (p = vmlist; p; p = p->next) {
+		if (p->addr == start)
+			break;
+	}
+	if (!p) {
+		printk(KERN_ERR "Trying to vsplit() nonexistent vm area (%p)\n",
+		       start);
+		goto out_unlock;
+	}
+	if (!split || ((PAGE_SIZE - 1) & (unsigned long) split) ||
+	    (unsigned long) split > (unsigned long) (p->addr) + p->size) {
+		printk(KERN_ERR "Trying to vsplit() bad split address (%p)\n",
+		       split);
+		goto out_unlock;
+	}
+	new->flags = p->flags;
+	new->addr = split;
+	new->size = p->size - ((char *) split - (char *) start);
+	p->size = ((char *) split - (char *) start);
+	new->next = p->next;
+	p->next = new;
+	ret = split;
+
+      out_unlock:
+	write_unlock(&vmlist_lock);
+      out:
+	if (!ret)
+		kfree(new);
+	return ret;
+}
+
 void vfree(void * addr)
 {
 	struct vm_struct **p, *tmp;
Index: 19-rc1.4/kernel/module.c
--- 19-rc1.4/kernel/module.c Mon, 12 Nov 2001 11:34:37 +1100 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1.1.1.2.1 644)
+++ 19-rc1.4(w)/kernel/module.c Thu, 04 Jul 2002 20:09:15 +1000 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1.1.1.2.1 644)
@@ -25,6 +25,7 @@
  *     http://www.uwsg.iu.edu/hypermail/linux/kernel/0008.3/0379.html
  * Replace xxx_module_symbol with inter_module_xxx.  Keith Owens <kaos@ocs.com.au> Oct 2000
  * Add a module list lock for kernel fault race fixing. Alan Cox <alan@redhat.com>
+ * Free any init sections after module loading. Keith Owens <kaos@ocs.com.au> July 2002
  *
  * This source is covered by the GNU GPL, the same as all kernel sources.
  */
@@ -556,6 +557,21 @@ sys_init_module(const char *name_user, s
 			error = -EBUSY;
 		goto err0;
 	}
+
+	/* Discard any init area that is no longer required */
+	if (mod_member_present(mod, runsize) &&
+	    mod->runsize &&
+	    PAGE_ALIGN(mod->runsize) < mod->size) {
+		void *split = (char *)mod + PAGE_ALIGN(mod->runsize);
+		split = vsplit(mod, split);
+		if (split) {
+			vfree(split);
+			mod->size = mod->runsize;
+		}
+		else
+			mod->runsize = 0;
+	}
+
 	atomic_dec(&mod->uc.usecount);
 
 	/* And set it running.  */
Index: 19-rc1.4/include/linux/vmalloc.h
--- 19-rc1.4/include/linux/vmalloc.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/b/b/38_vmalloc.h 1.1 644)
+++ 19-rc1.4(w)/include/linux/vmalloc.h Thu, 04 Jul 2002 17:43:37 +1000 kaos (linux-2.4/b/b/38_vmalloc.h 1.1 644)
@@ -20,6 +20,7 @@ struct vm_struct {
 
 extern struct vm_struct * get_vm_area (unsigned long size, unsigned long flags);
 extern void vfree(void * addr);
+extern void * vsplit(void * start, void * split);
 extern void * __vmalloc (unsigned long size, int gfp_mask, pgprot_t prot);
 extern long vread(char *buf, char *addr, unsigned long count);
 extern void vmfree_area_pages(unsigned long address, unsigned long size);
@@ -55,7 +56,7 @@ static inline void * vmalloc_32(unsigned
 
 /*
  * vmlist_lock is a read-write spinlock that protects vmlist
- * Used in mm/vmalloc.c (get_vm_area() and vfree()) and fs/proc/kcore.c.
+ * Used in mm/vmalloc.c (get_vm_area(), vsplit() and vfree()) and fs/proc/kcore.c.
  */
 extern rwlock_t vmlist_lock;
 
Index: 19-rc1.4/include/linux/module.h
--- 19-rc1.4/include/linux/module.h Sun, 21 Apr 2002 16:26:01 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6.1.1.1.3 644)
+++ 19-rc1.4(w)/include/linux/module.h Thu, 04 Jul 2002 18:28:30 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1.2.6.1.1.1.3 644)
@@ -86,7 +86,7 @@ struct module
 	const struct module_persist *persist_start;
 	const struct module_persist *persist_end;
 	int (*can_unload)(void);
-	int runsize;			/* In modutils, not currently used */
+	int runsize;			/* Size without init sections, 0 if there are no init sections */
 	const char *kallsyms_start;	/* All symbols for kernel debugging */
 	const char *kallsyms_end;
 	const char *archdata_start;	/* arch specific data for module */
Index: 19-rc1.4/include/linux/init.h
--- 19-rc1.4/include/linux/init.h Sat, 08 Dec 2001 10:12:02 +1100 kaos (linux-2.4/f/b/11_init.h 1.1.1.1.1.3 644)
+++ 19-rc1.4(w)/include/linux/init.h Thu, 04 Jul 2002 17:43:37 +1000 kaos (linux-2.4/f/b/11_init.h 1.1.1.1.1.3 644)
@@ -115,13 +115,13 @@ extern struct kernel_param __setup_start
 
 #define __init
 #define __exit
-#define __initdata
+#define __initdata	__attribute__ ((__section__ (".data.init")))
 #define __exitdata
 #define __initcall(fn)
 /* For assembly routines */
 #define __INIT
 #define __FINIT
-#define __INITDATA
+#define __INITDATA	.section	".data.init","aw"
 
 /* These macros create a dummy inline: gcc 2.9x does not count alias
  as usage, hence the `unused function' warning when __init functions

