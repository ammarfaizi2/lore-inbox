Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbTDBCkE>; Tue, 1 Apr 2003 21:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTDBCkD>; Tue, 1 Apr 2003 21:40:03 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:21146 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261358AbTDBCj4>; Tue, 1 Apr 2003 21:39:56 -0500
Message-ID: <3E8A4DF8.8010504@us.ibm.com>
Date: Tue, 01 Apr 2003 18:42:00 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [patch][rfc] Memory Binding (1/1)
References: <3E8A135B.3030106@us.ibm.com>	<3E8A151A.1040800@us.ibm.com> <20030401153945.17d26219.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------040907040602030106070906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040907040602030106070906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>Okee dokee...  Here's the real core of the patch.
> 
> 
> Looks saneish to me.  I'd like to see thorough benchmark results when it is
> complete.  And it would be nice to make address_space.binding go away if
> !CONFIG_NUMA.
Yeah... I figured the one pointer wouldn't be a big deal, and it would 
save a few more ifdefs, but I guess consistency is better.  If I ifdef 
most of it, may as well ifdef it all!

> The explicit knowledge of ZONE_DMA/ZONE_NORMAL/ZONE_HIGHMEM in get_zonetype()
> should not be necessary - you don't want it to explode if ZONE_DMA32 is
> added.  It should be indexing into node_zonelists in some manner.
> 
> Will this code work if all memory is in ZONE_DMA, as some architectures do?

Well, what I do for now is use the gfp_mask in the address_space that is 
already there for the shm segments.  This means I have to look at that 
to decide if they want DMA, NORMAL, or HIGHMEM.  So it already would 
need to be changed if we added a new zone.  If the thing we're creating 
a binding for only can use DMA, for example, I need to make sure I use 
only the DMA zones.  I can't easily see a way to make sure I add only 
the appropriate zones to the zonelist, and also don't look at the 
gfp_flag to determine the zones they want.  I'll ponder it more deeply 
tonight, though.

New patch, sans binding pointer attatched.

Cheers!

-Matt

--------------040907040602030106070906
Content-Type: text/plain;
 name="01-membind.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-membind.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/arch/i386/kernel/entry.S linux-2.5.66-membind/arch/i386/kernel/entry.S
--- linux-2.5.66-pre_membind/arch/i386/kernel/entry.S	Mon Mar 24 14:00:11 2003
+++ linux-2.5.66-membind/arch/i386/kernel/entry.S	Mon Mar 31 17:45:20 2003
@@ -852,6 +852,7 @@
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+ 	.long sys_membind
  
  
 nr_syscalls=(.-sys_call_table)/4
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/fs/inode.c linux-2.5.66-membind/fs/inode.c
--- linux-2.5.66-pre_membind/fs/inode.c	Mon Mar 24 14:01:48 2003
+++ linux-2.5.66-membind/fs/inode.c	Mon Mar 31 17:45:20 2003
@@ -141,6 +141,7 @@
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->gfp_mask = GFP_HIGHUSER;
+		mapping->binding = NULL;
 		mapping->dirtied_when = 0;
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/asm-i386/unistd.h linux-2.5.66-membind/include/asm-i386/unistd.h
--- linux-2.5.66-pre_membind/include/asm-i386/unistd.h	Mon Mar 24 14:00:54 2003
+++ linux-2.5.66-membind/include/asm-i386/unistd.h	Mon Mar 31 17:45:20 2003
@@ -273,8 +273,9 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_membind		268
 
-#define NR_syscalls 268
+#define NR_syscalls 269
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/linux/binding.h linux-2.5.66-membind/include/linux/binding.h
--- linux-2.5.66-pre_membind/include/linux/binding.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.66-membind/include/linux/binding.h	Tue Apr  1 17:14:16 2003
@@ -0,0 +1,40 @@
+/*
+ * include/linux/binding.h
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
+#ifndef _LINUX_BINDING_H
+#define _LINUX_BINDING_H
+
+#ifdef CONFIG_NUMA
+
+#include <linux/mmzone.h>
+
+/* Structure to keep track of shared memory segment bindings */
+struct binding {
+	struct zonelist	zonelist;
+};
+
+#endif /* CONFIG_NUMA */
+#endif /* _LINUX_BINDING_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/linux/fs.h linux-2.5.66-membind/include/linux/fs.h
--- linux-2.5.66-pre_membind/include/linux/fs.h	Mon Mar 24 14:00:10 2003
+++ linux-2.5.66-membind/include/linux/fs.h	Tue Apr  1 17:14:37 2003
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/binding.h>
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/include/linux/pagemap.h linux-2.5.66-membind/include/linux/pagemap.h
--- linux-2.5.66-pre_membind/include/linux/pagemap.h	Mon Mar 24 13:59:54 2003
+++ linux-2.5.66-membind/include/linux/pagemap.h	Tue Apr  1 17:13:53 2003
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
+#include <linux/binding.h>
 #include <asm/uaccess.h>
 
 /*
@@ -27,6 +28,8 @@
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
+#ifndef CONFIG_NUMA
+
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
 	return alloc_pages(x->gfp_mask, 0);
@@ -37,6 +40,29 @@
 	return alloc_pages(x->gfp_mask|__GFP_COLD, 0);
 }
 
+#else /* CONFIG_NUMA */
+
+static inline struct page *__page_cache_alloc(struct address_space *x, int cold)
+{
+	int gfp_mask;
+	struct zonelist *zonelist;
+
+	gfp_mask = x->gfp_mask;
+	if (cold)
+		gfp_mask |= __GFP_COLD;
+	if (!x->binding)
+		zonelist = get_zonelist(gfp_mask);
+	else
+		zonelist = &x->binding->zonelist;
+
+	return __alloc_pages(gfp_mask, 0, zonelist);
+}
+
+#define page_cache_alloc(x)	 __page_cache_alloc((x), 0)
+#define page_cache_alloc_cold(x) __page_cache_alloc((x), 1)
+
+#endif /* !CONFIG_NUMA */
+
 typedef int filler_t(void *, struct page *);
 
 extern struct page * find_get_page(struct address_space *mapping,
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/Makefile linux-2.5.66-membind/mm/Makefile
--- linux-2.5.66-pre_membind/mm/Makefile	Mon Mar 24 14:00:51 2003
+++ linux-2.5.66-membind/mm/Makefile	Mon Mar 31 17:45:20 2003
@@ -7,7 +7,7 @@
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
 			   shmem.o vmalloc.o
 
-obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
+obj-y			:= binding.o bootmem.o fadvise.o filemap.o mempool.o oom_kill.o \
 			   page_alloc.o page-writeback.o pdflush.o readahead.o \
 			   slab.o swap.o truncate.o vcache.o vmscan.o $(mmu-y)
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-pre_membind/mm/binding.c linux-2.5.66-membind/mm/binding.c
--- linux-2.5.66-pre_membind/mm/binding.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.66-membind/mm/binding.c	Tue Apr  1 18:32:45 2003
@@ -0,0 +1,199 @@
+/*
+ * mm/binding.c
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
+
+#ifndef CONFIG_NUMA
+
+asmlinkage unsigned long sys_membind(unsigned long start, unsigned long len, 
+		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
+{
+	return -ENOSYS;
+}
+
+#else /* CONFIG_NUMA */
+
+#include <linux/binding.h>
+#include <asm/string.h>
+#include <asm/topology.h>
+#include <asm/uaccess.h>
+
+/* Translate a cpumask to a nodemask */
+static inline void cpumask_to_nodemask(DECLARE_BITMAP(cpumask, NR_CPUS), 
+		DECLARE_BITMAP(nodemask, MAX_NUMNODES))
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (test_bit(i, (cpumask)))
+			set_bit(cpu_to_node(i), (nodemask));
+}
+
+/*
+ * Takes a BITMAP of nodes as an argument, and ensures that at least one of 
+ * the nodes in the bitmap are actually online.
+ * Returns 0 if at least one specified node is online, -EINVAL otherwise.
+ */
+static inline int check_binding_nodemask(DECLARE_BITMAP(nodemask, MAX_NUMNODES))
+{
+	int i;
+
+	/* Make sure at least one specified node is online */
+	for (i = 0; i < MAX_NUMNODES; i++)
+		if (test_bit(i, nodemask) && node_online(i))
+			return 0;
+	return -EINVAL;
+}
+
+/*
+ * Adds the zones belonging to @pgdat to @zonelist.  Returns the next 
+ * index in @zonelist.
+ */
+static inline int add_zones(pg_data_t *pgdat, struct zonelist *zonelist, 
+			int zone_num, int zone_type)
+{
+	switch (zone_type) {
+		struct zone *zone;
+	default:
+		BUG();
+	case ZONE_HIGHMEM:
+		zone = pgdat->node_zones + ZONE_HIGHMEM;
+		if (zone->present_pages)
+			zonelist->zones[zone_num++] = zone;
+	case ZONE_NORMAL:
+		zone = pgdat->node_zones + ZONE_NORMAL;
+		if (zone->present_pages)
+			zonelist->zones[zone_num++] = zone;
+	case ZONE_DMA:
+		zone = pgdat->node_zones + ZONE_DMA;
+		if (zone->present_pages)
+			zonelist->zones[zone_num++] = zone;
+	}
+	return zone_num;
+}
+
+/* Determine the appropriate ZONE_* flag based on the given GFP_* flags */
+static inline int get_zonetype(int gfp_flag)
+{
+	int zone_type;
+
+	gfp_flag &= GFP_ZONEMASK;
+	if (gfp_flag & __GFP_HIGHMEM)
+		zone_type = ZONE_HIGHMEM;
+	else if (gfp_flag & __GFP_DMA)
+		zone_type = ZONE_DMA;
+	else
+		zone_type = ZONE_NORMAL;
+
+	return zone_type;
+}
+
+/* Top-level function for allocating a binding for a region of memory */
+static struct binding *alloc_binding(DECLARE_BITMAP(nodemask, MAX_NUMNODES), 
+		int gfp_flag, unsigned long policy)
+{
+	struct binding *binding;
+	int node, zone_num, zone_type;
+
+	if (check_binding_nodemask(nodemask))
+		return NULL;
+
+	binding = (struct binding *)kmalloc(sizeof(struct binding), GFP_KERNEL);
+	if (!binding)
+		return NULL;
+	memset(binding, 0, sizeof(struct binding));
+
+	/* Build binding zonelist */
+	zone_type = get_zonetype(gfp_flag);
+	zone_num = 0;
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		if (test_bit(node, nodemask) && node_online(node))
+			zone_num = add_zones(NODE_DATA(node), &binding->zonelist, zone_num, zone_type);
+	}
+	binding->zonelist.zones[zone_num] = NULL;
+
+	if (!zone_num) {
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
+asmlinkage unsigned long sys_membind(unsigned long start, unsigned long len, 
+		unsigned long *mask_ptr, unsigned int mask_len, unsigned long policy)
+{
+	DECLARE_BITMAP(cpu_mask, NR_CPUS);
+	DECLARE_BITMAP(node_mask, MAX_NUMNODES);
+	struct vm_area_struct *vma = NULL;
+	struct address_space *mapping;
+	int error = 0;
+
+	/* Deal with getting cpu_mask from userspace & translating to node_mask */
+	if (mask_len > NR_CPUS) {
+		error = -EINVAL;
+		goto out;
+	}
+	CLEAR_BITMAP(cpu_mask, NR_CPUS);
+	CLEAR_BITMAP(node_mask, MAX_NUMNODES);
+	if (copy_from_user(cpu_mask, mask_ptr, (mask_len+7)/8)) {
+		error = -EFAULT;
+		goto out;
+	}
+	cpumask_to_nodemask(cpu_mask, node_mask);
+
+	vma = find_vma(current->mm, start);
+	if (!(vma && vma->vm_file && vma->vm_ops && 
+		vma->vm_ops->nopage == shmem_nopage)) {
+		/* This isn't a shm segment.  For now, we bail. */
+		printk("%s: Can only bind shm(em) segments for now!\n", __FUNCTION__);
+		error = -EINVAL;
+		goto out;
+	}
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	mapping->binding = alloc_binding(node_mask, mapping->gfp_mask, policy);
+	if (!mapping->binding) {
+		printk("%s: Error while building memory binding!\n", __FUNCTION__);
+		error = -EFAULT;
+	}
+
+out:
+	return error;
+}
+
+#endif /* !CONFIG_NUMA */
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

--------------040907040602030106070906--

