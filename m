Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbUDGVrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbUDGVrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:47:05 -0400
Received: from ns.suse.de ([195.135.220.2]:58819 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264189AbUDGVpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:45:31 -0400
Date: Wed, 7 Apr 2004 23:45:25 +0200
From: Andi Kleen <ak@suse.de>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mbligh@aracnet.com
Subject: Re: NUMA API for Linux
Message-Id: <20040407234525.4f775c16.ak@suse.de>
In-Reply-To: <1081374061.9061.26.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis>
	<20040407232712.2595ac16.ak@suse.de>
	<1081374061.9061.26.camel@arrakis>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 14:41:02 -0700
Matthew Dobson <colpatch@us.ibm.com> wrote:

> On Wed, 2004-04-07 at 14:27, Andi Kleen wrote:
> > On Wed, 07 Apr 2004 14:24:19 -0700
> > Matthew Dobson <colpatch@us.ibm.com> wrote:
> > 
> > > 	I must be missing something here, but did you not include mempolicy.h
> > > and policy.c in these patches?  I can't seem to find them anywhere?!? 
> > > It's really hard to evaluate your patches if the core of them is
> > > missing!
> > 
> > It was in the core patch and also in the last patch I sent Andrew.
> > See ftp://ftp.suse.com/pub/people/ak/numa/* for the full patches
> 
> Ok.. I'll check that link, but what you posted didn't have the files
> (mempolicy.h & policy.c) in the patch:

Indeed. Must have gone missing. Here are the files for reference.

The full current broken out patchkit is in 
ftp.suse.com:/pub/people/ak/numa/2.6.5mc2/

Core NUMA API code

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

diff -u linux-2.6.5-mc2-numa/include/linux/gfp.h-o linux-2.6.5-mc2-numa/include/linux/gfp.h
--- linux-2.6.5-mc2-numa/include/linux/gfp.h-o	2004-04-07 11:42:19.000000000 +0200
+++ linux-2.6.5-mc2-numa/include/linux/gfp.h	2004-04-07 11:45:42.000000000 +0200
@@ -4,6 +4,8 @@
 #include <linux/mmzone.h>
 #include <linux/stddef.h>
 #include <linux/linkage.h>
+#include <linux/config.h>
+
 /*
  * GFP bitmasks..
  */
@@ -73,10 +75,29 @@
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
diff -u linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o linux-2.6.5-mc2-numa/include/linux/mempolicy.h
--- linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o	2004-04-07 12:07:18.000000000 +0200
+++ linux-2.6.5-mc2-numa/include/linux/mempolicy.h	2004-04-07 12:07:13.000000000 +0200
@@ -0,0 +1,219 @@
+#ifndef _LINUX_MEMPOLICY_H
+#define _LINUX_MEMPOLICY_H 1
+
+#include <linux/errno.h>
+
+/*
+ * NUMA memory policies for Linux.
+ * Copyright 2003,2004 Andi Kleen SuSE Labs
+ */
+
+/* Policies */
+#define MPOL_DEFAULT     0
+#define MPOL_PREFERRED    1
+#define MPOL_BIND        2
+#define MPOL_INTERLEAVE  3
+
+#define MPOL_MAX MPOL_INTERLEAVE
+
+/* Flags for get_mem_policy */
+#define MPOL_F_NODE   (1<<0)  /* return next IL mode instead of node mask */
+#define MPOL_F_ADDR     (1<<1)  /* look up vma using address */
+
+/* Flags for mbind */
+#define MPOL_MF_STRICT  (1<<0)  /* Verify existing pages in the mapping */
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/mmzone.h>
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <asm/semaphore.h>
+
+struct vm_area_struct;
+
+#ifdef CONFIG_NUMA
+
+/*
+ * Describe a memory policy.
+ *
+ * A mempolicy can be either associated with a process or with a VMA.
+ * For VMA related allocations the VMA policy is preferred, otherwise
+ * the process policy is used. Interrupts ignore the memory policy
+ * of the current process.
+ *
+ * Locking policy for interlave:
+ * In process context there is no locking because only the process accesses
+ * its own state. All vma manipulation is somewhat protected by a down_read on
+ * mmap_sem. For allocating in the interleave policy the page_table_lock
+ * must be also aquired to protect il_next.
+ *
+ * Freeing policy:
+ * When policy is MPOL_BIND v.zonelist is kmalloc'ed and must be kfree'd.
+ * All other policies don't have any external state. mpol_free() handles this.
+ *
+ * Copying policy objects:
+ * For MPOL_BIND the zonelist must be always duplicated. mpol_clone() does this.
+ */
+struct mempolicy {
+	atomic_t   refcnt;
+	short policy; 	/* See MPOL_* above */
+	union {
+		struct zonelist  *zonelist;	/* bind */
+		short 		 preferred_node; /* preferred */
+		DECLARE_BITMAP(nodes, MAX_NUMNODES); /* interleave */
+		/* undefined for default */
+	} v;
+};
+
+/* An NULL mempolicy pointer is a synonym of &default_policy. */
+extern struct mempolicy default_policy;
+
+/*
+ * Support for managing mempolicy data objects (clone, copy, destroy)
+ * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
+ */
+
+extern void __mpol_free(struct mempolicy *pol);
+static inline void mpol_free(struct mempolicy *pol)
+{
+	if (pol)
+		__mpol_free(pol);
+}
+
+extern struct mempolicy *__mpol_copy(struct mempolicy *pol);
+static inline struct mempolicy *mpol_copy(struct mempolicy *pol)
+{
+	if (pol)
+		pol = __mpol_copy(pol);
+	return pol;
+}
+
+#define vma_policy(vma) ((vma)->vm_policy)
+#define vma_set_policy(vma, pol) ((vma)->vm_policy = (pol))
+
+static inline void mpol_get(struct mempolicy *pol)
+{
+	if (pol)
+		atomic_inc(&pol->refcnt);
+}
+
+extern int __mpol_equal(struct mempolicy *a, struct mempolicy *b);
+static inline int mpol_equal(struct mempolicy *a, struct mempolicy *b)
+{
+	if (a == b)
+		return 1;
+	return __mpol_equal(a, b);
+}
+#define vma_mpol_equal(a,b) mpol_equal(vma_policy(a), vma_policy(b))
+
+/* Could later add inheritance of the process policy here. */
+
+#define mpol_set_vma_default(vma) ((vma)->vm_policy = NULL)
+
+/*
+ * Hugetlb policy. i386 hugetlb so far works with node numbers
+ * instead of zone lists, so give it special interfaces for now.
+ */
+extern int mpol_first_node(struct vm_area_struct *vma, unsigned long addr);
+extern int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long addr);
+
+/*
+ * Tree of shared policies for a shared memory region.
+ * Maintain the policies in a pseudo mm that contains vmas. The vmas
+ * carry the policy. As a special twist the pseudo mm is indexed in pages, not
+ * bytes, so that we can work with shared memory segments bigger than
+ * unsigned long.
+ */
+
+struct sp_node {
+	struct rb_node nd;
+	unsigned long start, end;
+	struct mempolicy *policy;
+};
+
+struct shared_policy {
+	struct rb_root root;
+	struct semaphore sem;
+};
+
+static inline void mpol_shared_policy_init(struct shared_policy *info)
+{
+	info->root = RB_ROOT;
+	init_MUTEX(&info->sem);
+}
+
+int mpol_set_shared_policy(struct shared_policy *info,
+				  struct vm_area_struct *vma,
+				  struct mempolicy *new);
+void mpol_free_shared_policy(struct shared_policy *p);
+struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
+					    unsigned long idx);
+
+#else
+
+struct mempolicy {};
+
+static inline int mpol_equal(struct mempolicy *a, struct mempolicy *b)
+{
+	return 1;
+}
+#define vma_mpol_equal(a,b) 1
+
+#define mpol_set_vma_default(vma) do {} while(0)
+
+static inline void mpol_free(struct mempolicy *p)
+{
+}
+
+static inline void mpol_get(struct mempolicy *pol)
+{
+}
+
+static inline struct mempolicy *mpol_copy(struct mempolicy *old)
+{
+	return NULL;
+}
+
+static inline int mpol_first_node(struct vm_area_struct *vma, unsigned long a)
+{
+	return numa_node_id();
+}
+
+static inline int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long a)
+{
+	return 1;
+}
+
+struct shared_policy {};
+
+static inline int mpol_set_shared_policy(struct shared_policy *info,
+				      struct vm_area_struct *vma,
+				      struct mempolicy *new)
+{
+	return -EINVAL;
+}
+
+static inline void mpol_shared_policy_init(struct shared_policy *info)
+{
+}
+
+static inline void mpol_free_shared_policy(struct shared_policy *p)
+{
+}
+
+static inline struct mempolicy *
+mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
+{
+	return NULL;
+}
+
+#define vma_policy(vma) NULL
+#define vma_set_policy(vma, pol) do {} while(0)
+
+#endif /* CONFIG_NUMA */
+#endif /* __KERNEL__ */
+
+#endif
diff -u linux-2.6.5-mc2-numa/include/linux/mm.h-o linux-2.6.5-mc2-numa/include/linux/mm.h
--- linux-2.6.5-mc2-numa/include/linux/mm.h-o	2004-04-07 11:42:19.000000000 +0200
+++ linux-2.6.5-mc2-numa/include/linux/mm.h	2004-04-07 11:45:42.000000000 +0200
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
@@ -434,6 +444,8 @@
 
 struct page *shmem_nopage(struct vm_area_struct * vma,
 			unsigned long address, int *type);
+int shmem_set_policy(struct vm_area_struct *vma, struct mempolicy *new);
+struct mempolicy *shmem_get_policy(struct vm_area_struct *vma, unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
@@ -636,6 +648,11 @@
 	return vma;
 }
 
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
 extern struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr);
 
 extern unsigned int nr_used_zone_pages(void);
diff -u linux-2.6.5-mc2-numa/include/linux/sched.h-o linux-2.6.5-mc2-numa/include/linux/sched.h
--- linux-2.6.5-mc2-numa/include/linux/sched.h-o	2004-04-07 11:42:19.000000000 +0200
+++ linux-2.6.5-mc2-numa/include/linux/sched.h	2004-04-07 11:45:42.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/mempolicy.h>
 
 struct exec_domain;
 
@@ -501,6 +502,9 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+  	struct mempolicy *mempolicy;
+  	short il_next;		/* could be shared with used_math */
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -u linux-2.6.5-mc2-numa/kernel/sys.c-o linux-2.6.5-mc2-numa/kernel/sys.c
--- linux-2.6.5-mc2-numa/kernel/sys.c-o	2004-04-07 11:42:20.000000000 +0200
+++ linux-2.6.5-mc2-numa/kernel/sys.c	2004-04-07 11:48:39.000000000 +0200
@@ -266,6 +266,9 @@
 cond_syscall(sys_mq_timedreceive)
 cond_syscall(sys_mq_notify)
 cond_syscall(sys_mq_getsetattr)
+cond_syscall(sys_mbind)
+cond_syscall(sys_get_mempolicy)
+cond_syscall(sys_set_mempolicy)
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read)
diff -u linux-2.6.5-mc2-numa/mm/Makefile-o linux-2.6.5-mc2-numa/mm/Makefile
--- linux-2.6.5-mc2-numa/mm/Makefile-o	2004-03-21 21:12:13.000000000 +0100
+++ linux-2.6.5-mc2-numa/mm/Makefile	2004-04-07 12:07:49.000000000 +0200
@@ -12,3 +12,4 @@
 			   slab.o swap.o truncate.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+obj-$(CONFIG_NUMA) 	+= mempolicy.o
diff -u linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o linux-2.6.5-mc2-numa/include/linux/mempolicy.h
--- linux-2.6.5-mc2-numa/include/linux/mempolicy.h-o	2004-04-07 12:07:18.000000000 +0200
+++ linux-2.6.5-mc2-numa/include/linux/mempolicy.h	2004-04-07 12:07:13.000000000 +0200
@@ -0,0 +1,219 @@
+#ifndef _LINUX_MEMPOLICY_H
+#define _LINUX_MEMPOLICY_H 1
+
+#include <linux/errno.h>
+
+/*
+ * NUMA memory policies for Linux.
+ * Copyright 2003,2004 Andi Kleen SuSE Labs
+ */
+
+/* Policies */
+#define MPOL_DEFAULT     0
+#define MPOL_PREFERRED    1
+#define MPOL_BIND        2
+#define MPOL_INTERLEAVE  3
+
+#define MPOL_MAX MPOL_INTERLEAVE
+
+/* Flags for get_mem_policy */
+#define MPOL_F_NODE   (1<<0)  /* return next IL mode instead of node mask */
+#define MPOL_F_ADDR     (1<<1)  /* look up vma using address */
+
+/* Flags for mbind */
+#define MPOL_MF_STRICT  (1<<0)  /* Verify existing pages in the mapping */
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/mmzone.h>
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <asm/semaphore.h>
+
+struct vm_area_struct;
+
+#ifdef CONFIG_NUMA
+
+/*
+ * Describe a memory policy.
+ *
+ * A mempolicy can be either associated with a process or with a VMA.
+ * For VMA related allocations the VMA policy is preferred, otherwise
+ * the process policy is used. Interrupts ignore the memory policy
+ * of the current process.
+ *
+ * Locking policy for interlave:
+ * In process context there is no locking because only the process accesses
+ * its own state. All vma manipulation is somewhat protected by a down_read on
+ * mmap_sem. For allocating in the interleave policy the page_table_lock
+ * must be also aquired to protect il_next.
+ *
+ * Freeing policy:
+ * When policy is MPOL_BIND v.zonelist is kmalloc'ed and must be kfree'd.
+ * All other policies don't have any external state. mpol_free() handles this.
+ *
+ * Copying policy objects:
+ * For MPOL_BIND the zonelist must be always duplicated. mpol_clone() does this.
+ */
+struct mempolicy {
+	atomic_t   refcnt;
+	short policy; 	/* See MPOL_* above */
+	union {
+		struct zonelist  *zonelist;	/* bind */
+		short 		 preferred_node; /* preferred */
+		DECLARE_BITMAP(nodes, MAX_NUMNODES); /* interleave */
+		/* undefined for default */
+	} v;
+};
+
+/* An NULL mempolicy pointer is a synonym of &default_policy. */
+extern struct mempolicy default_policy;
+
+/*
+ * Support for managing mempolicy data objects (clone, copy, destroy)
+ * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
+ */
+
+extern void __mpol_free(struct mempolicy *pol);
+static inline void mpol_free(struct mempolicy *pol)
+{
+	if (pol)
+		__mpol_free(pol);
+}
+
+extern struct mempolicy *__mpol_copy(struct mempolicy *pol);
+static inline struct mempolicy *mpol_copy(struct mempolicy *pol)
+{
+	if (pol)
+		pol = __mpol_copy(pol);
+	return pol;
+}
+
+#define vma_policy(vma) ((vma)->vm_policy)
+#define vma_set_policy(vma, pol) ((vma)->vm_policy = (pol))
+
+static inline void mpol_get(struct mempolicy *pol)
+{
+	if (pol)
+		atomic_inc(&pol->refcnt);
+}
+
+extern int __mpol_equal(struct mempolicy *a, struct mempolicy *b);
+static inline int mpol_equal(struct mempolicy *a, struct mempolicy *b)
+{
+	if (a == b)
+		return 1;
+	return __mpol_equal(a, b);
+}
+#define vma_mpol_equal(a,b) mpol_equal(vma_policy(a), vma_policy(b))
+
+/* Could later add inheritance of the process policy here. */
+
+#define mpol_set_vma_default(vma) ((vma)->vm_policy = NULL)
+
+/*
+ * Hugetlb policy. i386 hugetlb so far works with node numbers
+ * instead of zone lists, so give it special interfaces for now.
+ */
+extern int mpol_first_node(struct vm_area_struct *vma, unsigned long addr);
+extern int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long addr);
+
+/*
+ * Tree of shared policies for a shared memory region.
+ * Maintain the policies in a pseudo mm that contains vmas. The vmas
+ * carry the policy. As a special twist the pseudo mm is indexed in pages, not
+ * bytes, so that we can work with shared memory segments bigger than
+ * unsigned long.
+ */
+
+struct sp_node {
+	struct rb_node nd;
+	unsigned long start, end;
+	struct mempolicy *policy;
+};
+
+struct shared_policy {
+	struct rb_root root;
+	struct semaphore sem;
+};
+
+static inline void mpol_shared_policy_init(struct shared_policy *info)
+{
+	info->root = RB_ROOT;
+	init_MUTEX(&info->sem);
+}
+
+int mpol_set_shared_policy(struct shared_policy *info,
+				  struct vm_area_struct *vma,
+				  struct mempolicy *new);
+void mpol_free_shared_policy(struct shared_policy *p);
+struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
+					    unsigned long idx);
+
+#else
+
+struct mempolicy {};
+
+static inline int mpol_equal(struct mempolicy *a, struct mempolicy *b)
+{
+	return 1;
+}
+#define vma_mpol_equal(a,b) 1
+
+#define mpol_set_vma_default(vma) do {} while(0)
+
+static inline void mpol_free(struct mempolicy *p)
+{
+}
+
+static inline void mpol_get(struct mempolicy *pol)
+{
+}
+
+static inline struct mempolicy *mpol_copy(struct mempolicy *old)
+{
+	return NULL;
+}
+
+static inline int mpol_first_node(struct vm_area_struct *vma, unsigned long a)
+{
+	return numa_node_id();
+}
+
+static inline int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long a)
+{
+	return 1;
+}
+
+struct shared_policy {};
+
+static inline int mpol_set_shared_policy(struct shared_policy *info,
+				      struct vm_area_struct *vma,
+				      struct mempolicy *new)
+{
+	return -EINVAL;
+}
+
+static inline void mpol_shared_policy_init(struct shared_policy *info)
+{
+}
+
+static inline void mpol_free_shared_policy(struct shared_policy *p)
+{
+}
+
+static inline struct mempolicy *
+mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
+{
+	return NULL;
+}
+
+#define vma_policy(vma) NULL
+#define vma_set_policy(vma, pol) do {} while(0)
+
+#endif /* CONFIG_NUMA */
+#endif /* __KERNEL__ */
+
+#endif
diff -u linux-2.6.5-mc2-numa/mm/mempolicy.c-o linux-2.6.5-mc2-numa/mm/mempolicy.c
--- linux-2.6.5-mc2-numa/mm/mempolicy.c-o	2004-04-07 12:07:41.000000000 +0200
+++ linux-2.6.5-mc2-numa/mm/mempolicy.c	2004-04-07 13:07:02.000000000 +0200
@@ -0,0 +1,981 @@
+/*
+ * Simple NUMA memory policy for the Linux kernel.
+ *
+ * Copyright 2003,2004 Andi Kleen, SuSE Labs.
+ * Subject to the GNU Public License, version 2.
+ *
+ * NUMA policy allows the user to give hints in which node(s) memory should
+ * be allocated.
+ *
+ * Support four policies per VMA and per process:
+ *
+ * The VMA policy has priority over the process policy for a page fault.
+ *
+ * interleave     Allocate memory interleaved over a set of nodes,
+ *                with normal fallback if it fails.
+ *                For VMA based allocations this interleaves based on the
+ *                offset into the backing object or offset into the mapping
+ *                for anonymous memory. For process policy an process counter
+ *                is used.
+ * bind           Only allocate memory on a specific set of nodes,
+ *                no fallback.
+ * preferred       Try a specific node first before normal fallback.
+ *                As a special case node -1 here means do the allocation
+ *                on the local CPU. This is normally identical to default,
+ *                but useful to set in a VMA when you have a non default
+ *                process policy.
+ * default        Allocate on the local node first, or when on a VMA
+ *                use the process policy. This is what Linux always did
+ *		         in a NUMA aware kernel and still does by, ahem, default.
+ *
+ * The process policy is applied for most non interrupt memory allocations
+ * in that process' context. Interrupts ignore the policies and always
+ * try to allocate on the local CPU. The VMA policy is only applied for memory
+ * allocations for a VMA in the VM.
+ *
+ * Currently there are a few corner cases in swapping where the policy
+ * is not applied, but the majority should be handled. When process policy
+ * is used it is not remembered over swap outs/swap ins.
+ *
+ * Only the highest zone in the zone hierarchy gets policied. Allocations
+ * requesting a lower zone just use default policy. This implies that
+ * on systems with highmem kernel lowmem allocation don't get policied.
+ * Same with GFP_DMA allocations.
+ *
+ * For shmfs/tmpfs/hugetlbfs shared memory the policy is shared between
+ * all users and remembered even when nobody has memory mapped.
+ */
+
+/* Notebook:
+   fix mmap readahead to honour policy and enable policy for any page cache
+   object
+   statistics for bigpages
+   global policy for page cache? currently it uses process policy. Requires
+   first item above.
+   handle mremap for shared memory (currently ignored for the policy)
+   grows down?
+   make bind policy root only? It can trigger oom much faster and the
+   kernel is not always grateful with that.
+   could replace all the switch()es with a mempolicy_ops structure.
+*/
+
+#include <linux/mempolicy.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+static kmem_cache_t *policy_cache;
+static kmem_cache_t *sn_cache;
+
+#define round_up(x,y) (((x) + (y) - 1) & ~((y)-1))
+#define PDprintk(fmt...)
+
+/* Highest zone. An specific allocation for a zone below that is not
+   policied. */
+static int policy_zone;
+
+static struct mempolicy default_policy = {
+	.refcnt = ATOMIC_INIT(1), /* never free it */
+	.policy = MPOL_DEFAULT,
+};
+
+/* Check if all specified nodes are online */
+static int check_online(unsigned long *nodes)
+{
+	DECLARE_BITMAP(offline, MAX_NUMNODES);
+	bitmap_copy(offline, node_online_map, MAX_NUMNODES);
+	if (bitmap_empty(offline, MAX_NUMNODES))
+		set_bit(0, offline);
+	bitmap_complement(offline, MAX_NUMNODES);
+	bitmap_and(offline, offline, nodes, MAX_NUMNODES);
+	if (!bitmap_empty(offline, MAX_NUMNODES))
+		return -EINVAL;
+	return 0;
+}
+
+/* Do sanity checking on a policy */
+static int check_policy(int mode, unsigned long *nodes)
+{
+	int empty = bitmap_empty(nodes, MAX_NUMNODES);
+	switch (mode) {
+	case MPOL_DEFAULT:
+		if (!empty)
+			return -EINVAL;
+		break;
+	case MPOL_BIND:
+	case MPOL_INTERLEAVE:
+		/* Preferred will only use the first bit, but allow
+		   more for now. */
+		if (empty)
+			return -EINVAL;
+		break;
+	}
+	return check_online(nodes);
+}
+
+/* Copy a node mask from user space. */
+static int get_nodes(unsigned long *nodes, unsigned long *nmask,
+		     unsigned long maxnode, int mode)
+{
+	unsigned long k;
+	unsigned long nlongs;
+	unsigned long endmask;
+
+	--maxnode;
+	nlongs = BITS_TO_LONGS(maxnode);
+	if ((maxnode % BITS_PER_LONG) == 0)
+		endmask = ~0UL;
+	else
+		endmask = (1UL << (maxnode % BITS_PER_LONG)) - 1;
+
+	/* When the user specified more nodes than supported just check
+	   if the non supported part is all zero. */
+	if (nmask && nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
+		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
+			unsigned long t;
+			if (get_user(t,  nmask + k))
+				return -EFAULT;
+			if (k == nlongs - 1) {
+				if (t & endmask)
+					return -EINVAL;
+			} else if (t)
+				return -EINVAL;
+		}
+		nlongs = BITS_TO_LONGS(MAX_NUMNODES);
+		endmask = ~0UL;
+	}
+
+	bitmap_clear(nodes, MAX_NUMNODES);
+	if (nmask && copy_from_user(nodes, nmask, nlongs*sizeof(unsigned long)))
+		return -EFAULT;
+	nodes[nlongs-1] &= endmask;
+	return check_policy(mode, nodes);
+}
+
+/* Generate a custom zonelist for the BIND policy. */
+static struct zonelist *bind_zonelist(unsigned long *nodes)
+{
+	struct zonelist *zl;
+	int num, max, nd;
+
+	max = 1 + MAX_NR_ZONES * bitmap_weight(nodes, MAX_NUMNODES);
+	zl = kmalloc(sizeof(void *) * max, GFP_KERNEL);
+	if (!zl)
+		return NULL;
+	num = 0;
+	for (nd = find_first_bit(nodes, MAX_NUMNODES);
+	     nd < MAX_NUMNODES;
+	     nd = find_next_bit(nodes, MAX_NUMNODES, 1+nd)) {
+		int k;
+		for (k = MAX_NR_ZONES-1; k >= 0; k--) {
+			struct zone *z = &NODE_DATA(nd)->node_zones[k];
+			if (!z->present_pages)
+				continue;
+			zl->zones[num++] = z;
+			if (k > policy_zone)
+				policy_zone = k;
+		}
+	}
+	BUG_ON(num >= max);
+	zl->zones[num] = NULL;
+	return zl;
+}
+
+/* Create a new policy */
+static struct mempolicy *new_policy(int mode, unsigned long *nodes)
+{
+	struct mempolicy *policy;
+	PDprintk("setting mode %d nodes[0] %lx\n", mode, nodes[0]);
+	if (mode == MPOL_DEFAULT)
+		return NULL;
+	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
+	if (!policy)
+		return ERR_PTR(-ENOMEM);
+	atomic_set(&policy->refcnt, 1);
+	switch (mode) {
+	case MPOL_INTERLEAVE:
+		bitmap_copy(policy->v.nodes, nodes, MAX_NUMNODES);
+		break;
+	case MPOL_PREFERRED:
+		policy->v.preferred_node = find_first_bit(nodes, MAX_NUMNODES);
+		if (policy->v.preferred_node >= MAX_NUMNODES)
+			policy->v.preferred_node = -1;
+		break;
+	case MPOL_BIND:
+		policy->v.zonelist = bind_zonelist(nodes);
+		if (policy->v.zonelist == NULL) {
+			kmem_cache_free(policy_cache, policy);
+			return ERR_PTR(-ENOMEM);
+		}
+		break;
+	}
+	policy->policy = mode;
+	return policy;
+}
+
+/* Ensure all existing pages follow the policy. */
+static int
+verify_pages(unsigned long addr, unsigned long end, unsigned long *nodes)
+{
+	while (addr < end) {
+		struct page *p;
+		pte_t *pte;
+		pmd_t *pmd;
+		pgd_t *pgd = pgd_offset_k(addr);
+		if (pgd_none(*pgd)) {
+			addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
+			continue;
+		}
+		pmd = pmd_offset(pgd, addr);
+		if (pmd_none(*pmd)) {
+			addr = (addr + PMD_SIZE) & PMD_MASK;
+			continue;
+		}
+		p = NULL;
+		pte = pte_offset_map(pmd, addr);
+		if (pte_present(*pte))
+			p = pte_page(*pte);
+		pte_unmap(pte);
+		if (p) {
+			unsigned nid = page_zone(p)->zone_pgdat->node_id;
+			if (!test_bit(nid, nodes))
+				return -EIO;
+		}
+		addr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+/* Step 1: check the range */
+static struct vm_area_struct *
+check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
+	    unsigned long *nodes, unsigned long flags)
+{
+	int err;
+	struct vm_area_struct *first, *vma, *prev;
+
+	first = find_vma(mm, start);
+	if (!first)
+		return ERR_PTR(-EFAULT);
+	prev = NULL;
+	for (vma = first; vma->vm_start < end; vma = vma->vm_next) {
+		if (!vma->vm_next && vma->vm_end < end)
+			return ERR_PTR(-EFAULT);
+		if (prev && prev->vm_end < vma->vm_start)
+			return ERR_PTR(-EFAULT);
+		if ((flags & MPOL_MF_STRICT) && !is_vm_hugetlb_page(vma)) {
+			err = verify_pages(vma->vm_start, vma->vm_end, nodes);
+			if (err) {
+				first = ERR_PTR(err);
+				break;
+			}
+		}
+		prev = vma;
+	}
+	return first;
+}
+
+/* Apply policy to a single VMA */
+static int policy_vma(struct vm_area_struct *vma, struct mempolicy *new)
+{
+	int err = 0;
+	struct mempolicy *old = vma->vm_policy;
+
+	PDprintk("vma %lx-%lx/%lx vm_ops %p vm_file %p set_policy %p\n",
+		 vma->vm_start, vma->vm_end, vma->vm_pgoff,
+		 vma->vm_ops, vma->vm_file,
+		 vma->vm_ops ? vma->vm_ops->set_policy : NULL);
+
+	if (vma->vm_file)
+		down(&vma->vm_file->f_mapping->i_shared_sem);
+	if (vma->vm_ops && vma->vm_ops->set_policy)
+		err = vma->vm_ops->set_policy(vma, new);
+	if (!err) {
+		mpol_get(new);
+		vma->vm_policy = new;
+		mpol_free(old);
+	}
+	if (vma->vm_file)
+		up(&vma->vm_file->f_mapping->i_shared_sem);
+	return err;
+}
+
+/* Step 2: apply policy to a range and do splits. */
+static int mbind_range(struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end, struct mempolicy *new)
+{
+	struct vm_area_struct *next;
+	int err;
+
+	err = 0;
+	for (; vma->vm_start < end; vma = next) {
+		next = vma->vm_next;
+		if (vma->vm_start < start)
+			err = split_vma(vma->vm_mm, vma, start, 1);
+		if (!err && vma->vm_end > end)
+			err = split_vma(vma->vm_mm, vma, end, 0);
+		if (!err)
+			err = policy_vma(vma, new);
+		if (err)
+			break;
+	}
+	return err;
+}
+
+/* Change policy for a memory range */
+asmlinkage long sys_mbind(unsigned long start, unsigned long len,
+			  unsigned long mode,
+			  unsigned long *nmask, unsigned long maxnode,
+			  unsigned flags)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	struct mempolicy *new;
+	unsigned long end;
+	DECLARE_BITMAP(nodes, MAX_NUMNODES);
+	int err;
+
+	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
+		return -EINVAL;
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+	if (mode == MPOL_DEFAULT)
+		flags &= ~MPOL_MF_STRICT;
+	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
+
+	err = get_nodes(nodes, nmask, maxnode, mode);
+	if (err)
+		return err;
+
+	new = new_policy(mode, nodes);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
+			mode,nodes[0]);
+
+	down_write(&mm->mmap_sem);
+	vma = check_range(mm, start, end, nodes, flags);
+	err = PTR_ERR(vma);
+	if (!IS_ERR(vma))
+		err = mbind_range(vma, start, end, new);
+	up_write(&mm->mmap_sem);
+	mpol_free(new);
+	return err;
+}
+
+/* Set the process memory policy */
+asmlinkage long sys_set_mempolicy(int mode, unsigned long *nmask,
+				   unsigned long maxnode)
+{
+	int err;
+	struct mempolicy *new;
+	DECLARE_BITMAP(nodes, MAX_NUMNODES);
+
+	if (mode > MPOL_MAX)
+		return -EINVAL;
+	err = get_nodes(nodes, nmask, maxnode, mode);
+	if (err)
+		return err;
+	new = new_policy(mode, nodes);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+	mpol_free(current->mempolicy);
+	current->mempolicy = new;
+	if (new && new->policy == MPOL_INTERLEAVE)
+		current->il_next = find_first_bit(new->v.nodes, MAX_NUMNODES);
+	return 0;
+}
+
+/* Fill a zone bitmap for a policy */
+static void get_zonemask(struct mempolicy *p, unsigned long *nodes)
+{
+	int i;
+	bitmap_clear(nodes, MAX_NUMNODES);
+	switch (p->policy) {
+	case MPOL_BIND:
+		for (i = 0; p->v.zonelist->zones[i]; i++)
+			__set_bit(p->v.zonelist->zones[i]->zone_pgdat->node_id, nodes);
+		break;
+	case MPOL_DEFAULT:
+		break;
+	case MPOL_INTERLEAVE:
+		bitmap_copy(nodes, p->v.nodes, MAX_NUMNODES);
+		break;
+	case MPOL_PREFERRED:
+		/* or use current node instead of online map? */
+		if (p->v.preferred_node < 0)
+			bitmap_copy(nodes, node_online_map, MAX_NUMNODES);
+		else	
+			__set_bit(p->v.preferred_node, nodes);
+		break;
+	default:
+		BUG();
+	}	
+}
+
+static int lookup_node(struct mm_struct *mm, unsigned long addr)
+{
+	struct page *p;
+	int err;
+	err = get_user_pages(current, mm, addr & PAGE_MASK, 1, 0, 0, &p, NULL);
+	if (err >= 0) {
+		err = page_zone(p)->zone_pgdat->node_id;
+		put_page(p);
+	}	
+	return err;
+}
+
+/* Copy a kernel node mask to user space */
+static int copy_nodes_to_user(unsigned long *user_mask, unsigned long maxnode,
+			      unsigned long *nodes)
+{
+	unsigned long copy = round_up(maxnode-1, BITS_PER_LONG) / 8;
+	if (copy > sizeof(nodes)) {
+		if (copy > PAGE_SIZE)
+			return -EINVAL;
+		if (clear_user((char*)user_mask + sizeof(nodes), copy - sizeof(nodes)))
+			return -EFAULT;
+		copy = sizeof(nodes);
+	}
+	return copy_to_user(user_mask, nodes, copy) ? -EFAULT : 0;
+}
+
+/* Retrieve NUMA policy */
+asmlinkage long sys_get_mempolicy(int *policy,
+				  unsigned long *nmask, unsigned long maxnode,
+				  unsigned long addr, unsigned long flags)	
+{
+	int err, pval;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL; 	
+	struct mempolicy *pol = current->mempolicy;
+
+	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
+		return -EINVAL;
+	if (nmask != NULL && maxnode < numnodes)
+		return -EINVAL;
+	if (flags & MPOL_F_ADDR) {
+		down_read(&mm->mmap_sem);
+		vma = find_vma_intersection(mm, addr, addr+1);
+		if (!vma) {
+			up_read(&mm->mmap_sem);
+			return -EFAULT;
+		}
+		if (vma->vm_ops && vma->vm_ops->get_policy)
+			pol = vma->vm_ops->get_policy(vma, addr);
+		else
+			pol = vma->vm_policy;
+	} else if (addr)
+		return -EINVAL;
+		
+	if (!pol)
+		pol = &default_policy;
+		
+	if (flags & MPOL_F_NODE) {
+		if (flags & MPOL_F_ADDR) {
+			err = lookup_node(mm, addr);
+			if (err < 0)
+				goto out;
+			pval = err;	
+		} else if (pol == current->mempolicy && pol->policy == MPOL_INTERLEAVE)
+			pval = current->il_next;
+		else {
+			err = -EINVAL;
+			goto out;
+		}	
+	} else
+		pval = pol->policy;
+
+	err = -EFAULT;
+	if (policy && put_user(pval, policy))
+		goto out;
+
+	err = 0;
+	if (nmask) {
+		DECLARE_BITMAP(nodes, MAX_NUMNODES);
+		get_zonemask(pol, nodes);
+		err = copy_nodes_to_user(nmask, maxnode, nodes);
+	}	
+
+ out:
+	if (vma)
+		up_read(&current->mm->mmap_sem);
+	return err;
+}
+
+/* Return effective policy for a VMA */
+static struct mempolicy *
+get_vma_policy(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = current->mempolicy;
+	if (vma) {
+		if (vma->vm_ops && vma->vm_ops->get_policy)
+		        pol = vma->vm_ops->get_policy(vma, addr);
+		else if (vma->vm_policy && vma->vm_policy->policy != MPOL_DEFAULT)
+			pol = vma->vm_policy;
+	}
+	if (!pol)
+		pol = &default_policy;
+	return pol;
+}
+
+/* Return a zonelist representing a mempolicy */
+static struct zonelist *zonelist_policy(unsigned gfp, struct mempolicy *policy)
+{
+	int nd;
+	switch (policy->policy) {
+	case MPOL_PREFERRED:
+		nd = policy->v.preferred_node;
+		if (nd < 0)
+			nd = numa_node_id();
+		break;
+	case MPOL_BIND:
+		/* Lower zones don't get a policy applied */
+		if (gfp >= policy_zone)
+			return policy->v.zonelist;
+		/*FALL THROUGH*/
+	case MPOL_INTERLEAVE: /* should not happen */
+	case MPOL_DEFAULT:
+		nd = numa_node_id();
+		break;
+	default:
+		nd = 0;
+		BUG();
+	}
+	return NODE_DATA(nd)->node_zonelists + (gfp & GFP_ZONEMASK);
+}
+
+/* Do dynamic interleaving for a process */
+static unsigned interleave_nodes(struct mempolicy *policy)
+{
+	unsigned nid, next; 	
+	struct task_struct *me = current;
+	nid = me->il_next;
+	BUG_ON(nid >= MAX_NUMNODES);
+	next = find_next_bit(policy->v.nodes, MAX_NUMNODES, 1+nid);
+	if (next >= MAX_NUMNODES)
+		next = find_first_bit(policy->v.nodes, MAX_NUMNODES);
+	me->il_next = next;
+	return nid;
+}
+
+/* Do static interleaving for a VMA with known offset. */
+static unsigned
+offset_il_node(struct mempolicy *pol, struct vm_area_struct *vma, unsigned long off)
+{
+	unsigned target = (unsigned)off % (unsigned)numnodes;
+	int c;
+	int nid = -1;
+	c = 0;
+	do {
+		nid = find_next_bit(pol->v.nodes, MAX_NUMNODES, nid+1);
+		if (nid >= MAX_NUMNODES) {
+			nid = -1; 		
+			continue;
+		}
+		c++;
+	} while (c <= target);
+	BUG_ON(nid >= MAX_NUMNODES);
+	return nid;
+}
+
+/* Allocate a page in interleaved policy for a VMA. Use the offset
+   into the VMA as key. Own path because it needs to do special accounting. */
+static struct page *alloc_page_interleave(unsigned gfp, unsigned nid)
+{
+	struct zonelist *zl;
+	struct page *page;
+	BUG_ON(!test_bit(nid, node_online_map));
+	zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
+	page = __alloc_pages(gfp, 0, zl);
+	if (page && page_zone(page) == zl->zones[0]) {
+		zl->zones[0]->pageset[get_cpu()].interleave_hit++;
+		put_cpu();
+	}
+	return page;
+}
+
+/**
+ * 	alloc_page_vma	- Allocate a page for a VMA.
+ *
+ * 	@gfp:
+ *      %GFP_USER    user allocation.
+ *      %GFP_KERNEL  kernel allocations,
+ *      %GFP_HIGHMEM highmem/user allocations,
+ *      %GFP_FS      allocation should not call back into a file system.
+ *      %GFP_ATOMIC  don't sleep.
+ *
+ * 	@vma:  Pointer to VMA or NULL if not available.
+ *	@addr: Virtual Address of the allocation. Must be inside the VMA.
+ *
+ * 	This function allocates a page from the kernel page pool and applies
+ *	a NUMA policy associated with the VMA or the current process.
+ *	When VMA is not NULL caller must hold down_read on the mmap_sem of the
+ *	mm_struct of the VMA to prevent it from going away. Should be used for i
+ *	all allocations for pages that will be mapped into
+ * 	user space. Returns NULL when no page can be allocated.
+ *
+ *	Should be called with the mm_sem of the vma hold.
+ */
+struct page *
+alloc_page_vma(unsigned gfp, struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = get_vma_policy(vma, addr);
+	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
+		unsigned nid;
+		if (vma) { 	
+			unsigned long off;
+			BUG_ON(addr >= vma->vm_end);
+			BUG_ON(addr < vma->vm_start);
+			off = vma->vm_pgoff;
+			off += (addr - vma->vm_start) >> PAGE_SHIFT;
+			nid = offset_il_node(pol, vma, off);		
+		} else {
+			/* fall back to process interleaving */
+			nid = interleave_nodes(pol);
+		}
+		return alloc_page_interleave(gfp, nid);
+	}
+	return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
+}
+
+/**
+ * 	alloc_pages_current - Allocate pages.
+ *
+ *	@gfp:  %GFP_USER   user allocation,
+ *      %GFP_KERNEL kernel allocation,
+ *      %GFP_HIGHMEM highmem allocation,
+ *      %GFP_FS     don't call back into a file system.
+ *      %GFP_ATOMIC don't sleep.
+ *	@order: Power of two of allocation size in pages. 0 is a single page.
+ *
+ *	Allocate a page from the kernel page pool.  When not in
+ *	interrupt context and apply the current process NUMA policy.
+ *	Returns NULL when no page can be allocated.
+ */
+struct page *alloc_pages_current(unsigned gfp, unsigned order)
+{ 	
+	struct mempolicy *pol = current->mempolicy;
+	if (!pol || in_interrupt())
+		pol = &default_policy;
+	if (pol->policy == MPOL_INTERLEAVE && order == 0)
+		return alloc_page_interleave(gfp, interleave_nodes(pol));
+	return __alloc_pages(gfp, order, zonelist_policy(gfp, pol));
+}
+
+EXPORT_SYMBOL(alloc_pages_current);
+
+/* Slow path of a mempolicy copy */
+struct mempolicy *__mpol_copy(struct mempolicy *old)
+{	
+	struct mempolicy *new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+	*new = *old;		
+	atomic_set(&new->refcnt, 1);
+	if (new->policy == MPOL_BIND) {
+		int sz = ksize(old->v.zonelist);
+		new->v.zonelist = kmalloc(sz, SLAB_KERNEL);
+		if (!new->v.zonelist) {
+			kmem_cache_free(policy_cache, new);
+			return ERR_PTR(-ENOMEM);
+		}
+		memcpy(new->v.zonelist, old->v.zonelist, sz);
+	}
+	return new;
+}
+
+/* Slow path of a mempolicy comparison */
+int __mpol_equal(struct mempolicy *a, struct mempolicy *b)
+{
+	if (!a || !b)
+		return 0;
+	if (a->policy != b->policy)
+		return 0;
+	switch (a->policy) {
+	case MPOL_DEFAULT:
+		return 1;
+	case MPOL_INTERLEAVE:
+		return bitmap_equal(a->v.nodes, b->v.nodes, MAX_NUMNODES);
+	case MPOL_PREFERRED:
+		return a->v.preferred_node == b->v.preferred_node;
+	case MPOL_BIND: {
+		int i;
+		for (i = 0; a->v.zonelist->zones[i]; i++)
+			if (a->v.zonelist->zones[i] != b->v.zonelist->zones[i])
+				return 0; 		
+		return b->v.zonelist->zones[i] == NULL;
+	}
+	default:
+		BUG();
+		return 0;
+	}
+}
+
+/* Slow path of a mpol destructor. */
+extern void __mpol_free(struct mempolicy *p)
+{
+	if (!atomic_dec_and_test(&p->refcnt))
+		return;
+	if (p->policy == MPOL_BIND)
+		kfree(p->v.zonelist);
+	p->policy = MPOL_DEFAULT;
+	kmem_cache_free(policy_cache, p);
+}
+
+/*
+ * Hugetlb policy. Same as above, just works with node numbers instead of
+ * zonelists.
+ */
+
+/* Find first node suitable for an allocation */
+int mpol_first_node(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = get_vma_policy(vma, addr);
+	switch (pol->policy) {
+	case MPOL_DEFAULT:
+		return numa_node_id();
+	case MPOL_BIND:
+		return pol->v.zonelist->zones[0]->zone_pgdat->node_id;
+	case MPOL_INTERLEAVE:
+		return interleave_nodes(pol);
+	case MPOL_PREFERRED:
+		return pol->v.preferred_node >= 0 ? pol->v.preferred_node:numa_node_id();
+	}
+	BUG();
+	return 0;
+}
+
+/* Find secondary valid nodes for an allocation */
+int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = get_vma_policy(vma, addr);
+	switch (pol->policy) {
+	case MPOL_PREFERRED:
+	case MPOL_DEFAULT:
+	case MPOL_INTERLEAVE:
+		return 1;
+	case MPOL_BIND: {
+		struct zone **z;
+		for (z = pol->v.zonelist->zones; *z; z++)
+			if ((*z)->zone_pgdat->node_id == nid)
+				return 1;
+		return 0;
+	}
+	default:
+		BUG();
+		return 0;
+	}
+}
+
+/*
+ * Shared memory backing store policy support.
+ *
+ * Remember policies even when nobody has shared memory mapped.
+ * The policies are kept in Red-Black tree linked from the inode.
+ * They are protected by the sp->sem semaphore, which should be held
+ * for any accesses to the tree.
+ */
+
+/* lookup first element intersecting start-end */
+/* Caller holds sp->sem */
+static struct sp_node *
+sp_lookup(struct shared_policy *sp, unsigned long start, unsigned long end)
+{
+	struct rb_node *n = sp->root.rb_node;
+	while (n) {
+		struct sp_node *p = rb_entry(n, struct sp_node, nd);
+		if (start >= p->end) {
+			n = n->rb_right;
+		} else if (end < p->start) {
+			n = n->rb_left;
+		} else {
+			break;
+		}
+	}
+	if (!n)
+		return NULL;
+	for (;;) {
+		struct sp_node *w = NULL;
+		struct rb_node *prev = rb_prev(n);
+		if (!prev)
+			break;
+		w = rb_entry(prev, struct sp_node, nd);
+		if (w->end <= start)
+			break;
+		n = prev;
+	}
+	return rb_entry(n, struct sp_node, nd);
+}
+
+/* Insert a new shared policy into the list. */
+/* Caller holds sp->sem */
+static void sp_insert(struct shared_policy *sp, struct sp_node *new)
+{
+	struct rb_node **p = &sp->root.rb_node;
+	struct rb_node *parent = NULL;
+	struct sp_node *nd;
+	while (*p) {
+		parent = *p;
+		nd = rb_entry(parent, struct sp_node, nd);
+		if (new->start < nd->start)
+			p = &(*p)->rb_left;
+		else if (new->end > nd->end)
+			p = &(*p)->rb_right;
+		else
+			BUG();
+	}
+	rb_link_node(&new->nd, parent, p);
+	rb_insert_color(&new->nd, &sp->root);
+	PDprintk("inserting %lx-%lx: %d\n", new->start, new->end,
+		 new->policy ? new->policy->policy : 0);
+}
+
+/* Find shared policy intersecting idx */
+struct mempolicy *
+mpol_shared_policy_lookup(struct shared_policy *sp, unsigned long idx)
+{
+	struct mempolicy *pol = NULL;
+	struct sp_node *sn;
+	down(&sp->sem);
+	sn = sp_lookup(sp, idx, idx+1);
+	if (sn) {
+		mpol_get(sn->policy);
+		pol = sn->policy;
+	}
+	up(&sp->sem);
+	return pol;
+}
+
+static void sp_delete(struct shared_policy *sp, struct sp_node *n)
+{
+	PDprintk("deleting %lx-l%x\n", n->start, n->end);
+	rb_erase(&n->nd, &sp->root);
+	mpol_free(n->policy);
+	kmem_cache_free(sn_cache, n);
+}
+
+struct sp_node *
+sp_alloc(unsigned long start, unsigned long end, struct mempolicy *pol)
+{
+	struct sp_node *n = kmem_cache_alloc(sn_cache, GFP_KERNEL);
+	if (!n)
+		return NULL;
+	n->start = start;
+	n->end = end;
+	mpol_get(pol);
+	n->policy = pol;
+	return n;
+}
+
+/* Replace a policy range. */
+static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
+				 unsigned long end, struct sp_node *new)
+{
+	struct sp_node *n, *new2;
+
+	down(&sp->sem);
+	n = sp_lookup(sp, start, end);
+	/* Take care of old policies in the same range. */
+	while (n && n->start < end) {
+		struct rb_node *next = rb_next(&n->nd);
+		if (n->start >= start) {
+			if (n->end <= end)
+				sp_delete(sp, n);
+			else
+				n->start = end;
+		} else {
+			/* Old policy spanning whole new range. */
+			if (n->end > end) {
+				new2 = sp_alloc(end, n->end, n->policy);
+				if (!new2) {
+					up(&sp->sem);
+					return -ENOMEM;
+				}
+				n->end = end;
+				sp_insert(sp, new2);
+			}
+			/* Old crossing beginning, but not end (easy) */
+			if (n->start < start && n->end > start)
+				n->end = start;
+		}
+		if (!next)
+			break;
+		n = rb_entry(next, struct sp_node, nd);
+	}
+	if (new)
+		sp_insert(sp, new);
+	up(&sp->sem);
+	return 0;
+}
+
+int mpol_set_shared_policy(struct shared_policy *info, struct vm_area_struct *vma,
+			   struct mempolicy *npol)
+{
+	int err;
+	struct sp_node *new = NULL;
+	unsigned long sz = vma_pages(vma);
+
+	PDprintk("set_shared_policy %lx sz %lu %d %lx\n",
+		 vma->vm_pgoff,
+		 sz, npol? npol->policy : -1,
+		npol ? npol->v.nodes[0] : -1);
+		
+	if (npol) {
+		new = sp_alloc(vma->vm_pgoff, vma->vm_pgoff + sz, npol);
+		if (!new)
+			return -ENOMEM;
+	}
+	err = shared_policy_replace(info, vma->vm_pgoff, vma->vm_pgoff+sz, new);
+	if (err && new)
+		kmem_cache_free(sn_cache, new);
+	return err;
+}
+
+/* Free a backing policy store on inode delete. */
+void mpol_free_shared_policy(struct shared_policy *p)
+{
+	struct sp_node *n;
+	struct rb_node *next;
+	down(&p->sem);
+	next = rb_first(&p->root);
+	while (next) {
+		n = rb_entry(next, struct sp_node, nd);		
+		next = rb_next(&n->nd);
+		rb_erase(&n->nd, &p->root);
+		mpol_free(n->policy);
+		kmem_cache_free(sn_cache, n);		
+	}
+	up(&p->sem);
+}
+
+static __init int numa_policy_init(void)
+{
+	policy_cache = kmem_cache_create("numa_policy",
+					 sizeof(struct mempolicy),
+					 0, 0, NULL, NULL);
+
+	sn_cache = kmem_cache_create("shared_policy_node",
+				     sizeof(struct sp_node),
+				     0, 0, NULL, NULL);
+
+	if (!policy_cache || !sn_cache)
+		panic("Cannot create NUMA policy cache");
+	return 0;
+}
+__initcall(numa_policy_init);
