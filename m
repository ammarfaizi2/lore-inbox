Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263286AbTDCFza>; Thu, 3 Apr 2003 00:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbTDCFza>; Thu, 3 Apr 2003 00:55:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25731 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263286AbTDCFzQ>; Thu, 3 Apr 2003 00:55:16 -0500
Message-ID: <3E8BCD21.2050307@us.ibm.com>
Date: Wed, 02 Apr 2003 21:56:49 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Christoph Hellwig <hch@infradead.org>,
       Paolo Zeppegno <zeppegno.paolo@seat.it>, Andi Kleen <ak@muc.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: [rfc][patch] Memory Binding Take 2 (1/1)
References: <3E8BCB96.6090908@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000107000201030708010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000107000201030708010806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Now for the good stuff! ;)

This one has had more changes...  I've changed the syscall from 
sys_membind to sys_mbind.  I liked Paolo's suggestion of aligning the 
naming.  I've fixed up the way the bitmaps are passed.  I pulled out all 
the ZONE_* code, and now just have it use all the zones on the node.  I 
made sure that the binding pointers are not compiled in for non-NUMA 
kernels.  All that is added for non-NUMA kernels is the cond_syscall and 
a small change in the page_cache_alloc callpath.  Now page_cache_alloc 
calls __page_cache_alloc, which is just the old page_cache_alloc for 
non-NUMA.  For NUMA, it's obviously a different function.  I also 
cleaned up the bitmask size issue, by just making sure userspace doesn't 
pass in a bitmask that's way too large.

I guess that's it...  As always, I'm looking forward to any comments!

Cheers!

-Matt

--------------000107000201030708010806
Content-Type: text/plain;
 name="01-membind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-membind.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/arch/i386/kernel/entry.S linux-2.5.66-membind/arch/i386/kernel/entry.S
--- linux-2.5.66-pre_membind/arch/i386/kernel/entry.S	Mon Mar 24 14:00:11 2003
+++ linux-2.5.66-membind/arch/i386/kernel/entry.S	Wed Apr  2 10:46:20 2003
@@ -807,7 +807,7 @@
 	.long sys_getdents64	/* 220 */
 	.long sys_fcntl64
 	.long sys_ni_syscall	/* reserved for TUX */
-	.long sys_ni_syscall
+ 	.long sys_mbind
 	.long sys_gettid
 	.long sys_readahead	/* 225 */
 	.long sys_setxattr
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/fs/inode.c linux-2.5.66-membind/fs/inode.c
--- linux-2.5.66-pre_membind/fs/inode.c	Mon Mar 24 14:01:48 2003
+++ linux-2.5.66-membind/fs/inode.c	Wed Apr  2 10:49:36 2003
@@ -144,6 +144,9 @@
 		mapping->dirtied_when = 0;
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+#ifdef CONFIG_NUMA
+		mapping->binding = NULL;
+#endif
 		if (sb->s_bdev)
 			mapping->backing_dev_info = sb->s_bdev->bd_inode->i_mapping->backing_dev_info;
 		memset(&inode->u, 0, sizeof(inode->u));
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/asm-i386/unistd.h linux-2.5.66-membind/include/asm-i386/unistd.h
--- linux-2.5.66-pre_membind/include/asm-i386/unistd.h	Mon Mar 24 14:00:54 2003
+++ linux-2.5.66-membind/include/asm-i386/unistd.h	Wed Apr  2 10:52:18 2003
@@ -228,7 +228,7 @@
 #define __NR_madvise1		219	/* delete when C lib stub is removed */
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
-/* 223 is unused */
+#define __NR_mbind		223
 #define __NR_gettid		224
 #define __NR_readahead		225
 #define __NR_setxattr		226
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/linux/fs.h linux-2.5.66-membind/include/linux/fs.h
--- linux-2.5.66-pre_membind/include/linux/fs.h	Mon Mar 24 14:00:10 2003
+++ linux-2.5.66-membind/include/linux/fs.h	Wed Apr  2 10:54:17 2003
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/mbind.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -329,6 +330,9 @@
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
+#ifdef CONFIG_NUMA
+	struct binding		*binding;	/* for memory bindings */
+#endif
 };
 
 struct block_device {
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/linux/mbind.h linux-2.5.66-membind/include/linux/mbind.h
--- linux-2.5.66-pre_membind/include/linux/mbind.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.66-membind/include/linux/mbind.h	Wed Apr  2 18:52:41 2003
@@ -0,0 +1,40 @@
+/*
+ * include/linux/mbind.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2003, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#ifndef _LINUX_MBIND_H
+#define _LINUX_MBIND_H
+
+#ifdef CONFIG_NUMA
+
+#include <linux/mmzone.h>
+
+/* Structure to keep track of memory segment (VMA) bindings */
+struct binding {
+	struct zonelist	zonelist;
+};
+
+#endif /* CONFIG_NUMA */
+#endif /* _LINUX_MBIND_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/linux/pagemap.h linux-2.5.66-membind/include/linux/pagemap.h
--- linux-2.5.66-pre_membind/include/linux/pagemap.h	Mon Mar 24 13:59:54 2003
+++ linux-2.5.66-membind/include/linux/pagemap.h	Wed Apr  2 19:49:42 2003
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
+#include <linux/mbind.h>
 #include <asm/uaccess.h>
 
 /*
@@ -27,14 +28,37 @@
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+#ifndef CONFIG_NUMA
+
+static inline struct page *__page_cache_alloc(struct address_space *x, int gfp_mask)
+{
+	return alloc_pages(gfp_mask, 0);
+}
+
+#else /* CONFIG_NUMA */
+
+static inline struct page *__page_cache_alloc(struct address_space *x, int gfp_mask)
+{
+	struct zonelist *zonelist;
+
+	if (!x->binding)
+		zonelist = get_zonelist(gfp_mask);
+	else
+		zonelist = &x->binding->zonelist;
+
+	return __alloc_pages(gfp_mask, 0, zonelist);
+}
+
+#endif /* !CONFIG_NUMA */
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask, 0);
+	return __page_cache_alloc(x, x->gfp_mask);
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask|__GFP_COLD, 0);
+	return __page_cache_alloc(x, x->gfp_mask|__GFP_COLD);
 }
 
 typedef int filler_t(void *, struct page *);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/kernel/sys.c linux-2.5.66-membind/kernel/sys.c
--- linux-2.5.66-pre_membind/kernel/sys.c	Mon Mar 24 14:00:00 2003
+++ linux-2.5.66-membind/kernel/sys.c	Wed Apr  2 11:00:44 2003
@@ -226,6 +226,7 @@
 cond_syscall(sys_sendmsg)
 cond_syscall(sys_recvmsg)
 cond_syscall(sys_socketcall)
+cond_syscall(sys_mbind)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/Makefile linux-2.5.66-membind/mm/Makefile
--- linux-2.5.66-pre_membind/mm/Makefile	Mon Mar 24 14:00:51 2003
+++ linux-2.5.66-membind/mm/Makefile	Wed Apr  2 10:50:59 2003
@@ -7,8 +7,10 @@
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
 			   shmem.o vmalloc.o
 
-obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
+obj-y			:= bootmem.o fadvise.o filemap.o mempool.o oom_kill.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
+
+obj-$(CONFIG_NUMA)	+= mbind.o
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/mbind.c linux-2.5.66-membind/mm/mbind.c
--- linux-2.5.66-pre_membind/mm/mbind.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.66-membind/mm/mbind.c	Wed Apr  2 21:45:39 2003
@@ -0,0 +1,131 @@
+/*
+ * mm/mbind.c
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2003, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/mbind.h>
+#include <asm/string.h>
+#include <asm/topology.h>
+#include <asm/uaccess.h>
+
+/* Translate a cpumask to a nodemask */
+static inline void cpumask_to_nodemask(bitmap_t cpumask, bitmap_t nodemask)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (test_bit(i, cpumask))
+			set_bit(cpu_to_node(i), nodemask);
+}
+
+/*
+ * Adds the zones belonging to @pgdat to @zonelist.  Returns the next 
+ * index in @zonelist.
+ */
+static inline int add_node(pg_data_t *pgdat, struct zonelist *zonelist, int zone_num)
+{
+	int i;
+	struct zone *zone;
+
+	for (i = MAX_NR_ZONES-1; i >=0 ; i--) {
+		zone = pgdat->node_zones + i;
+		if (zone->present_pages)
+			zonelist->zones[zone_num++] = zone;
+	}
+	return zone_num;
+}
+
+/* Top-level function for allocating a binding for a region of memory */
+static inline struct binding *alloc_binding(bitmap_t nodemask)
+{
+	struct binding *binding;
+	int node, zone_num;
+
+	binding = (struct binding *)kmalloc(sizeof(struct binding), GFP_KERNEL);
+	if (!binding)
+		return NULL;
+	memset(binding, 0, sizeof(struct binding));
+
+	/* Build binding zonelist */
+	for (node = 0, zone_num = 0; node < MAX_NUMNODES; node++)
+		if (test_bit(node, nodemask) && node_online(node))
+			zone_num = add_node(NODE_DATA(node), 
+				&binding->zonelist, zone_num);
+	binding->zonelist.zones[zone_num] = NULL;
+
+	if (zone_num == 0) {
+		/* No zones were added to the zonelist.  Let the caller know. */
+		kfree(binding);
+		binding = NULL;
+	}
+	return binding;
+} 
+
+
+/*
+ * membind -  Bind a range of a process' VM space to a set of memory blocks according to
+ *            a predefined policy.
+ * @start:    beginning address of memory region to bind
+ * @len:      length of memory region to bind
+ * @mask_ptr: pointer to bitmask of cpus
+ * @mask_len: length of the bitmask
+ * @policy:   flag specifying the policy to use for the segment
+ */
+asmlinkage unsigned long sys_mbind(unsigned long start, unsigned long len, 
+		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
+{
+	DECLARE_BITMAP(cpu_mask, NR_CPUS);
+	DECLARE_BITMAP(node_mask, MAX_NUMNODES);
+	struct vm_area_struct *vma = NULL;
+	struct address_space *mapping;
+	int copy_len, error = 0;
+
+	/* Deal with getting cpu_mask from userspace & translating to node_mask */
+	copy_len = min(mask_len, (unsigned int)NR_CPUS);
+	CLEAR_BITMAP(cpu_mask, NR_CPUS);
+	CLEAR_BITMAP(node_mask, MAX_NUMNODES);
+	if (copy_from_user(cpu_mask, mask_ptr, (copy_len+7)/8)) {
+		error = -EFAULT;
+		goto out;
+	}
+	cpumask_to_nodemask(cpu_mask, node_mask);
+
+	vma = find_vma(current->mm, start);
+	if (!(vma && vma->vm_file && vma->vm_ops && 
+		vma->vm_ops->nopage == shmem_nopage)) {
+		/* This isn't a shm segment.  For now, we bail. */
+		error = -EINVAL;
+		goto out;
+	}
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	mapping->binding = alloc_binding(node_mask);
+	if (!mapping->binding)
+		error = -EFAULT;
+
+out:
+	return error;
+}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/swap_state.c linux-2.5.66-membind/mm/swap_state.c
--- linux-2.5.66-pre_membind/mm/swap_state.c	Mon Mar 24 14:00:21 2003
+++ linux-2.5.66-membind/mm/swap_state.c	Tue Apr  1 17:12:00 2003
@@ -47,6 +47,9 @@
 	.i_shared_sem	= __MUTEX_INITIALIZER(swapper_space.i_shared_sem),
 	.private_lock	= SPIN_LOCK_UNLOCKED,
 	.private_list	= LIST_HEAD_INIT(swapper_space.private_list),
+#ifdef CONFIG_NUMA
+	.binding	= NULL,
+#endif
 };
 
 #define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)

--------------000107000201030708010806--

