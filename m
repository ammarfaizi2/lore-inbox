Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263814AbUDFNew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUDFNev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:34:51 -0400
Received: from ns.suse.de ([195.135.220.2]:49305 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263814AbUDFNec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:34:32 -0400
Date: Tue, 6 Apr 2004 15:34:31 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 1/ Core NUMA API code
Message-Id: <20040406153431.197de19e.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the core NUMA API code. This includes NUMA policy aware 
wrappers for get_free_pages and alloc_page_vma(). On non NUMA kernels
these are defined away.

The system calls mbind (see http://www.firstfloor.org/~andi/mbind.html),
get_mempolicy (http://www.firstfloor.org/~andi/get_mempolicy.html) and
set_mempolicy (http://www.firstfloor.org/~andi/set_mempolicy.html) are
implemented here.

Adds a vm_policy field to the VMA and to the process. The process
also has field for interleaving. VMA interleaving uses the offset
into the VMA, but that's not possible for process allocations.

diff -u linux-2.6.5-numa/include/linux/gfp.h-o linux-2.6.5-numa/include/linux/gfp.h
--- linux-2.6.5-numa/include/linux/gfp.h-o	2004-03-21 21:11:55.000000000 +0100
+++ linux-2.6.5-numa/include/linux/gfp.h	2004-04-06 13:36:12.000000000 +0200
@@ -4,6 +4,8 @@
 #include <linux/mmzone.h>
 #include <linux/stddef.h>
 #include <linux/linkage.h>
+#include <linux/config.h>
+
 /*
  * GFP bitmasks..
  */
@@ -72,10 +74,29 @@
 	return __alloc_pages(gfp_mask, order, NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+extern struct page *alloc_pages_current(unsigned gfp_mask, unsigned order);
+struct vm_area_struct;
+
+#ifdef CONFIG_NUMA
+static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
+{
+	if (unlikely(order >= MAX_ORDER))
+		return NULL;
+
+	return alloc_pages_current(gfp_mask, order);
+}
+extern struct page *__alloc_page_vma(unsigned gfp_mask, struct vm_area_struct *vma, 
+				   unsigned long off);
+
+extern struct page *alloc_page_vma(unsigned gfp_mask, struct vm_area_struct *vma, 
+				   unsigned long addr);
+#else
 #define alloc_pages(gfp_mask, order) \
 		alloc_pages_node(numa_node_id(), gfp_mask, order)
-#define alloc_page(gfp_mask) \
-		alloc_pages_node(numa_node_id(), gfp_mask, 0)
+#define alloc_page_vma(gfp_mask, vma, addr) alloc_pages(gfp_mask, 0)
+#define __alloc_page_vma(gfp_mask, vma, addr) alloc_pages(gfp_mask, 0)
+#endif
+#define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 
 extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));
 extern unsigned long FASTCALL(get_zeroed_page(unsigned int gfp_mask));
diff -u linux-2.6.5-numa/include/linux/mm.h-o linux-2.6.5-numa/include/linux/mm.h
--- linux-2.6.5-numa/include/linux/mm.h-o	2004-04-06 13:12:23.000000000 +0200
+++ linux-2.6.5-numa/include/linux/mm.h	2004-04-06 13:36:12.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/mmzone.h>
 #include <linux/rbtree.h>
 #include <linux/fs.h>
+#include <linux/mempolicy.h>
 
 #ifndef CONFIG_DISCONTIGMEM          /* Don't use mapnrs, do it properly */
 extern unsigned long max_mapnr;
@@ -47,6 +48,9 @@
  *
  * This structure is exactly 64 bytes on ia32.  Please think very, very hard
  * before adding anything to it.
+ * [Now 4 bytes more on 32bit NUMA machines. Sorry. -AK.
+ * But if you want to recover the 4 bytes justr remove vm_next. It is redundant 
+ * with vm_rb. Will be a lot of editing work though. vm_rb.color is redundant too.] 
  */
 struct vm_area_struct {
 	struct mm_struct * vm_mm;	/* The address space we belong to. */
@@ -77,6 +81,10 @@
 					   units, *not* PAGE_CACHE_SIZE */
 	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
+
+#ifdef CONFIG_NUMA
+	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
 };
 
 /*
@@ -148,6 +156,8 @@
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int *type);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
+	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
+	struct mempolicy *(*get_policy)(struct vm_area_struct *vma, unsigned long addr);
 };
 
 /* forward declaration; pte_chain is meant to be internal to rmap.c */
@@ -435,6 +445,8 @@
 
 struct page *shmem_nopage(struct vm_area_struct * vma,
 			unsigned long address, int *type);
+int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new);
+struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
@@ -633,6 +645,11 @@
 	return vma;
 }
 
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
 extern unsigned int nr_used_zone_pages(void);
diff -u linux-2.6.5-numa/include/linux/sched.h-o linux-2.6.5-numa/include/linux/sched.h
--- linux-2.6.5-numa/include/linux/sched.h-o	2004-04-06 13:12:23.000000000 +0200
+++ linux-2.6.5-numa/include/linux/sched.h	2004-04-06 13:36:12.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/mempolicy.h>
 
 struct exec_domain;
 
@@ -493,6 +494,9 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+  	struct mempolicy *mempolicy;
+  	short il_next;		/* could be shared with used_math */
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -u linux-2.6.5-numa/kernel/sys.c-o linux-2.6.5-numa/kernel/sys.c
--- linux-2.6.5-numa/kernel/sys.c-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-numa/kernel/sys.c	2004-04-06 13:36:12.000000000 +0200
@@ -260,6 +260,9 @@
 cond_syscall(sys_shmget)
 cond_syscall(sys_shmdt)
 cond_syscall(sys_shmctl)
+cond_syscall(sys_mbind)
+cond_syscall(sys_get_mempolicy)
+cond_syscall(sys_set_mempolicy)
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)
diff -u linux-2.6.5-numa/mm/Makefile-o linux-2.6.5-numa/mm/Makefile
--- linux-2.6.5-numa/mm/Makefile-o	2004-03-21 21:12:13.000000000 +0100
+++ linux-2.6.5-numa/mm/Makefile	2004-04-06 13:36:12.000000000 +0200
@@ -12,3 +12,4 @@
 			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_NUMA) 	+= policy.o
