Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317722AbSFSBUc>; Tue, 18 Jun 2002 21:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317723AbSFSBUb>; Tue, 18 Jun 2002 21:20:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23199 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317722AbSFSBUX>; Tue, 18 Jun 2002 21:20:23 -0400
Message-ID: <3D0FD7C8.604@us.ibm.com>
Date: Tue, 18 Jun 2002 18:00:56 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: latest linus-2.5 BK broken
References: <1024443480.1514.33.camel@w-hbaum> <Pine.LNX.4.44.0206190145580.28144-100000@e2>
Content-Type: multipart/mixed;
 boundary="------------040703070509050908020405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040703070509050908020405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> On 18 Jun 2002, Michael Hohnbaum wrote:
>>[...] I would suggest an additional argument be added
>>which would indicate the resource that the process is to be
>>affined to.  That way this interface could be used for binding
>>processes to cpus, memory nodes, perhaps NUMA nodes, and, 
>>as discussed recently in another thread, other processes.
>>Personally, I see NUMA nodes as an overkill, if a process
>>can be bound to cpus and memory nodes.
> 
> 
> are you sure we want one generic, process-based affinity interface?
> 
> i think the affinity to certain memory regions might need to be more
> finegrained than this. Eg. it could be useful to define a per-file
> (per-inode) 'backing store memory node' that the file is affine to. This
> will eg. cause the pagecache to be allocated in the memory node.
> Process-based affinity does not describe this in a natural way. Another
> example, memory maps: we might want to have a certain memory map (vma)  
> allocated in a given memory node, independently of where the process that
> is faulting a given pages resides.
> 
> and it might certainly make sense to have some sort of 'default memory
> affinity' for a process as well, but this should be a different syscall -
> it really does a much different thing than CPU affinity. The CPU resource
> is 'used' only temporarily with little footprint, while memory usage is
> often for a very long timespan, and the affinity strategies differ
> greatly. Also, memory as a resource is much more complex than CPU, eg. it
> must handle things like over-allocation, fallback to 'nearby' nodes if a
> node is full, etc.

I've attatched copies of the patch that Michael referred to in his email so you 
  can see where we're going with this.  I think that we have (at least the 
beginnings) of what you've described.  The patch allows processes to bind to 
specific CPU's (via bitmask) and/or specific memory blocks.  You can set these 
up to complement each other, or to something completely arbitrary (for 
debugging purposes, etc).  It also includes the beginnings of very simple 
topology info with some simple arch-independent calls (cpu_to_node, 
node_to_cpu, node_to_memblk, etc.)  Of course these do require some lower level 
hooks for each architecture that wants to use them, but they should be simple 
calls.  I've been sidetracked on other things for about a month, but I plan on 
getting back to this patch ASAP (this week), and porting it forward to the 
latest version.  It is currently only up to 2.5.14.

If anyone has any suggestions for other features, changes, comments, flames, 
ANYTHING, please let me know.


> so i'd suggest to actually create a good memory-affinity syscall interface
> instead of trying to generalize it into the simple, robust, finite
> CPU-affinity syscalls.
See above ;)


-Matt

> 
> 	Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--------------040703070509050908020405
Content-Type: text/plain;
 name="numa_api-arch_dep-2.5.14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-arch_dep-2.5.14.patch"

diff -Nur linux-2.5.12-vanilla/include/asm-i386/core_ibmnumaq.h linux-2.5.12-api/include/asm-i386/core_ibmnumaq.h
--- linux-2.5.12-vanilla/include/asm-i386/core_ibmnumaq.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.12-api/include/asm-i386/core_ibmnumaq.h	Wed May  1 17:24:25 2002
@@ -0,0 +1,61 @@
+/*
+ * linux/include/asm-i386/mmzone.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
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
+#ifndef _ASM_CORE_IBMNUMAQ_H_
+#define _ASM_CORE_IBMNUMAQ_H_
+
+/*
+ * These functions need to be defined for every architecture.
+ * The first five are necessary for the NUMA API to function.
+ * The last is needed by several pieces of NUMA code.
+ */
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define _cpu_to_node(cpu)	(cpu_to_logical_apicid(cpu) >> 4)
+
+/* Returns the number of the node containing MemBlk 'memblk' */
+#define _memblk_to_node(memblk)	(memblk)
+
+/* Returns the number of the node containing Node 'nid'.  This architecture is flat, 
+   so it is a pretty simple function. */
+#define _node_to_node(nid)	(nid)
+
+/* Returns the number of the first CPU on Node 'node' */
+static inline int _node_to_cpu(int node)
+{
+	int i, cpu, logical_apicid = node << 4;
+
+	for(i = 1; i < 16; i <<= 1)
+		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
+			return cpu;
+
+	return 0;
+}
+
+/* Returns the number of the first MemBlk on Node 'node' */
+#define _node_to_memblk(node)	(node)
+
+#endif /* _ASM_CORE_IBMNUMAQ_H_ */
diff -Nur linux-2.5.12-vanilla/include/asm-i386/mmzone.h linux-2.5.12-api/include/asm-i386/mmzone.h
--- linux-2.5.12-vanilla/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.12-api/include/asm-i386/mmzone.h	Wed May  1 17:24:25 2002
@@ -0,0 +1,45 @@
+/*
+ * linux/include/asm-i386/mmzone.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
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
+#ifndef _ASM_MMZONE_H_
+#define _ASM_MMZONE_H_
+
+#include <asm/smpboot.h>
+
+#ifdef CONFIG_IBMNUMAQ
+#include <asm/core_ibmnumaq.h>
+#else /* !CONFIG_IBMNUMAQ */
+#define _cpu_to_node(cpu)	(0)
+#define _memblk_to_node(memblk)	(0)
+#define _node_to_node(nid)	(0)
+#define _node_to_cpu(node)	(0)
+#define _node_to_memblk(node)	(0)
+#endif /* CONFIG_IBMNUMAQ */
+
+/* Returns the number of the current Node. */
+#define numa_node_id()		(_cpu_to_node(smp_processor_id()))
+
+#endif /* _ASM_MMZONE_H_ */

--------------040703070509050908020405
Content-Type: text/plain;
 name="numa_api-arch_indep-impl-2.5.14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-arch_indep-impl-2.5.14.patch"

diff -Nur linux-2.5.8-vanilla/kernel/Makefile linux-2.5.8-api/kernel/Makefile
--- linux-2.5.8-vanilla/kernel/Makefile	Sun Apr 14 12:18:47 2002
+++ linux-2.5.8-api/kernel/Makefile	Mon Apr 22 15:35:16 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o numa.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Nur linux-2.5.8-vanilla/kernel/fork.c linux-2.5.8-api/kernel/fork.c
--- linux-2.5.8-vanilla/kernel/fork.c	Sun Apr 14 12:18:45 2002
+++ linux-2.5.8-api/kernel/fork.c	Tue Apr 23 14:49:29 2002
@@ -707,6 +707,20 @@
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
+	if (!null_restrict(&p->numa_launch_policy)){
+		p->numa_binding = p->numa_launch_policy;
+		p->cpus_allowed = p->numa_binding.cpus.list & p->numa_restrict.cpus.list;
+		if (!(p->cpus_allowed & cpu_online_map))
+			BUG();
+		if (p->cpus_allowed & (1UL << smp_processor_id()))
+			p->thread_info->cpu = smp_processor_id();
+		else
+			p->thread_info->cpu = __ffs(p->cpus_allowed & cpu_online_map);
+	} else
+		p->thread_info->cpu = smp_processor_id();
+	numa_set_init(&p->numa_launch_policy);
+	rwlock_init(&p->numa_api_lock);
+
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
diff -Nur linux-2.5.8-vanilla/kernel/numa.c linux-2.5.8-api/kernel/numa.c
--- linux-2.5.8-vanilla/kernel/numa.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.8-api/kernel/numa.c	Mon Apr 29 11:21:27 2002
@@ -0,0 +1,378 @@
+/*
+ * linux/kernel/numa.c
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
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
+#include <linux/kernel.h>
+#include <linux/unistd.h>
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/numa.h>
+#include <linux/mmzone.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+
+#define is_valid_cpu_behavior(x)    (x == CPU_BIND_STRICT)
+#define is_valid_memblk_behavior(x) (((x & 0x7) == MPOL_STRICT) || ((x & 0x7) == MPOL_LOOSE))
+
+#define is_numa_subset(x, y) (!((x) & ~(y)))  /* test whether x is a subset of y */
+
+
+extern int nummemblks;
+extern unsigned long memblk_online_map;
+
+/*
+ * set_restricted_cpus(): Sets up a new CPU Restriction Set
+ */
+int set_restricted_cpus(numa_bitmap_t cpus, numa_set_t *numamap)
+{
+	int ret;
+	unsigned long flags;
+	numa_bitmap_t cpu_binding;
+
+	ret = -ENODEV;
+	/* Make sure that at least one of the cpus in the new restriction set is online. */
+	if (!(cpus & cpu_online_map))
+		goto out;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	cpu_binding = current->numa_binding.cpus.list;
+	/* If there is a binding, at least one of the bound cpus must be valid in the 
+	   new restriction set. */
+	if ((!null_restrict(&current->numa_binding)) &&
+	    (!(cpu_binding & cpus)))
+		goto out_unlock;
+
+	ret = -EPERM;
+	/* If the new restriction expands upon the old restriction, the caller must 
+	   have CAP_SYS_NICE. */
+	if ((!is_numa_subset(cpus, current->numa_restrict.cpus.list)) &&
+	    (!capable(CAP_SYS_NICE)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_restrict.cpus.list = cpus;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	/* Set cpus_allowed to the current binding masked against the new list of allowed cpus. */
+	set_cpus_allowed(current, cpu_binding & cpus);
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * set_restricted_memblks(): Sets up a new MemBlk Restriction Set
+ */
+int set_restricted_memblks(numa_bitmap_t memblks, numa_set_t *numamap)
+{
+	int ret;
+	unsigned long flags;
+
+	ret = -ENODEV;
+	/* Make sure that at least one of the memblks in the new restriction set is online. */
+	if (!(memblks & memblk_online_map))
+		goto out;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	/* If there is a binding, at least one of the bound memblks must be valid in the 
+	   new restriction set. */
+	if ((!null_restrict(&current->numa_binding)) &&
+	    (!(current->numa_binding.memblks.list & memblks)))
+		goto out_unlock;
+
+	ret = -EPERM;
+	/* If the new restriction expands upon the old restriction, the caller
+	   must have CAP_SYS_NICE. */
+	if ((!is_numa_subset(memblks, current->numa_restrict.memblks.list)) &&
+	    (!capable(CAP_SYS_NICE)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_restrict.memblks.list = memblks;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * get_restricted_cpus(): Returns the current CPU Restriction Set
+ */
+inline numa_bitmap_t get_restricted_cpus(void)
+{
+	unsigned long flags;
+	numa_bitmap_t cpu_restriction;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	cpu_restriction = current->numa_restrict.cpus.list;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	return cpu_restriction;
+}
+
+/*
+ * get_restricted_memblks(): Returns the current MemBlk Restriction Set
+ */
+inline numa_bitmap_t get_restricted_memblks(void)
+{
+	unsigned long flags;
+	numa_bitmap_t memblk_restriction;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	memblk_restriction = current->numa_restrict.memblks.list;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	return memblk_restriction;
+}
+
+/*
+ * cpu_to_node(cpu): Returns the number of the most specific Node 
+ * containing CPU 'cpu'.
+ */
+inline int cpu_to_node(int cpu)
+{
+	if (cpu == -1)     /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((cpu < 0) || (cpu >= NR_CPUS) ||
+	    (!(cpu_online_map & (1 << cpu))))   /* invalid cpu # */
+		return -ENODEV;
+
+	return _cpu_to_node(cpu_logical_map(cpu));
+}
+
+/*
+ * memblk_to_node(memblk): Returns the number of the most specific Node 
+ * containing Memory Block 'memblk'.
+ */
+inline int memblk_to_node(int memblk)
+{
+	if (memblk == -1)  /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((memblk < 0) || (memblk >= NR_MEMBLKS) ||
+	    (!(memblk_online_map & (1 << memblk))))   /* invalid memblk # */
+		return -ENODEV;
+
+	return _memblk_to_node(memblk);
+}
+
+/*
+ * node_to_node(nid): Returns the number of the of the most specific Node that
+ * encompasses Node 'nid'.  Some may call this the parent Node of 'nid'.
+ */
+int node_to_node(int nid)
+{
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_node(nid);
+}
+
+/*
+ * node_to_cpu(nid): Returns the lowest numbered CPU on Node 'nid'
+ */
+inline int node_to_cpu(int nid)
+{
+	if (nid == -1)  /* return highest numbered cpu */
+		return (smp_num_cpus - 1);
+
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_cpu(nid);
+}
+
+/*
+ * node_to_memblk(nid): Returns the lowest numbered MemBlk on Node 'nid'
+ */
+inline int node_to_memblk(int nid)
+{
+	if (nid == -1)  /* return highest numbered memblk */
+		return (nummemblks - 1);
+
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_memblk(nid);
+}
+
+/*
+ * get_cpu(): Returns the currently executing CPU number.
+ * For now, this has only mild usefulness, as this information could
+ * change on the return from syscall (which automatically calls schedule()).
+ * Due to this, the data could be stale by the time it gets back to the user.
+ * It will have to do, until a better method is found.
+ */
+inline int get_cpu(void)
+{
+	return smp_processor_id();
+}
+
+/*
+ * get_node(): Returns the number of the Node containing 
+ * the currently executing CPU.  Subject to the same caveat
+ * as the get_cpu() call.
+ */
+inline int get_node(void)
+{
+	return cpu_to_node(get_cpu());
+}
+
+/*
+ * bind_to_cpu(): Sets up a new CPU Binding
+ */
+int bind_to_cpu(numa_bitmap_t cpus, int behavior)
+{
+	int ret;
+	unsigned long flags;
+	numa_bitmap_t cpu_restriction;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	ret = -ENODEV;
+	/* Make sure that at least one of the cpus in the new binding is online, AND
+	   in the current restriction set. */
+	if (!(cpus & cpu_online_map & current->numa_restrict.cpus.list))
+		goto out_unlock;
+	cpu_restriction = current->numa_restrict.cpus.list;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior argument is valid. */
+	if (!is_valid_cpu_behavior(behavior))
+		goto out;
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_binding.cpus.list = cpus;
+	current->numa_binding.cpus.behavior = behavior;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	/* Set cpus_allowed to the new binding masked against the current list of allowed cpus. */
+	set_cpus_allowed(current, cpus & cpu_restriction);
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * bind_to_memblk(): Sets up a new MemBlk Binding
+ */
+int bind_to_memblk(numa_bitmap_t memblks, int behavior)
+{
+	int ret;
+	unsigned long flags;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	ret = -ENODEV;
+	/* Make sure that at least one of the memblks in the new binding is online, AND
+	   in the current restriction set. */
+	if (!(memblks & memblk_online_map & current->numa_restrict.memblks.list))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior argument is valid. */
+	if (!is_valid_memblk_behavior(behavior))
+		goto out;
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_binding.memblks.list = memblks;
+	current->numa_binding.memblks.behavior = behavior;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * bind_memory(): Will eventually set up a memory binding for a specific chunk of memory.
+ * Specifically, the chunk starting at 'start' through 'len' bytes.  As of now, it doesn't
+ * *quite* do that. ;)
+ */
+inline int bind_memory(unsigned long start, size_t len, numa_bitmap_t memblks, int behavior)
+{
+	return -ENOTSUPP;
+}
+
+/*
+ * set_launch_policy(): Sets up a new Launch Policy for current process
+ */
+int set_launch_policy(numa_bitmap_t cpus, int cpu_behavior, 
+		       numa_bitmap_t memblks, int memblk_behavior)
+{
+	int ret;
+	unsigned long flags;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	ret = -ENODEV;
+	/* Make sure that at least one of the cpus and one of the memblks in the new 
+	   binding are online, AND in the current restriction set. */
+	if ((!(cpus & cpu_online_map & current->numa_restrict.cpus.list)) ||
+	    (!(memblks & memblk_online_map & current->numa_restrict.memblks.list)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior arguments are valid. */
+	if ((!is_valid_cpu_behavior(cpu_behavior)) || 
+	    (!is_valid_memblk_behavior(memblk_behavior)))
+		goto out;
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_launch_policy.cpus.list = cpus;
+	current->numa_launch_policy.cpus.behavior = cpu_behavior;
+	current->numa_launch_policy.memblks.list = memblks;
+	current->numa_launch_policy.memblks.behavior = memblk_behavior;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
diff -Nur linux-2.5.8-vanilla/mm/numa.c linux-2.5.8-api/mm/numa.c
--- linux-2.5.8-vanilla/mm/numa.c	Sun Apr 14 12:18:49 2002
+++ linux-2.5.8-api/mm/numa.c	Wed Apr 24 11:26:18 2002
@@ -8,8 +8,11 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/numa.h>
 
 int numnodes = 1;	/* Initialized for UMA platforms */
+int nummemblks = 0;
+unsigned long memblk_online_map = 0UL;  /* Similar to cpu_online_map, but for memory blocks */
 
 static bootmem_data_t contig_bootmem_data;
 pg_data_t contig_page_data = { bdata: &contig_bootmem_data };
@@ -27,6 +30,10 @@
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 
 				zone_start_paddr, zholes_size, pmap);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	nummemblks = 1;
+	memblk_online_map = 1UL;
 }
 
 #endif /* !CONFIG_DISCONTIGMEM */
@@ -71,6 +78,11 @@
 	free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_paddr,
 					zholes_size, pmap);
 	pgdat->node_id = nid;
+	pgdat->memblk_id = nummemblks;
+	if (test_and_set_bit(nummemblks++, &memblk_online_map)){
+		printk("memblk alread counted?!?!\n");
+		BUG();
+	}
 
 	/*
 	 * Get space for the valid bitmap.
@@ -88,6 +100,8 @@
 	return __alloc_pages(gfp_mask, order, pgdat->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+#ifdef CONFIG_NUMA
+
 /*
  * This can be refined. Currently, tries to do round robin, instead
  * should do concentratic circle search, starting from current node.
@@ -96,35 +110,84 @@
 {
 	struct page *ret = 0;
 	pg_data_t *start, *temp;
-#ifndef CONFIG_NUMA
+	int search_twice = 0;
+	numa_bitmap_t memblk_bitmask, memblk_bitmask2;
 	unsigned long flags;
-	static pg_data_t *next = 0;
-#endif
 
 	if (order >= MAX_ORDER)
 		return NULL;
-#ifdef CONFIG_NUMA
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	if (null_restrict(&current->numa_binding))
+		/* if there is no binding, only search the restriction set */
+		memblk_bitmask = current->numa_restrict.memblks.list;
+	else {
+		/* if there is a binding, search it */
+		memblk_bitmask = current->numa_binding.memblks.list;
+		if (current->numa_binding.memblks.behavior == MPOL_LOOSE){
+			/* and if it is a loose binding, remember to search
+			   the restriction if we come up empty */
+                        search_twice = 1;
+			/* no need to search the memblks in the binding again,
+			   so we'll mask them out. */
+			memblk_bitmask2 = current->numa_restrict.memblks.list & ~memblk_bitmask;
+		}
+	}
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+search_through_memblks: 
 	temp = NODE_DATA(numa_node_id());
-#else
-	spin_lock_irqsave(&node_lock, flags);
-	if (!next) next = pgdat_list;
-	temp = next;
-	next = next->node_next;
-	spin_unlock_irqrestore(&node_lock, flags);
-#endif
 	start = temp;
 	while (temp) {
-		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
-			return(ret);
+		if (memblk_bitmask & (1 << temp->memblk_id))
+			if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
+				return(ret);
 		temp = temp->node_next;
 	}
 	temp = pgdat_list;
 	while (temp != start) {
+		if (memblk_bitmask & (1 << temp->memblk_id))
+			if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
+				return(ret);
+		temp = temp->node_next;
+	}
+
+	if (search_twice) {
+		/* 
+		 * If we failed to find a "preferred" memblk, try again 
+		 * looking for anything that's allowed (in restrict), but
+		 * skip those memblks we've already looked at
+		 */
+		search_twice = 0; /* no infinite loops, please */
+		memblk_bitmask = memblk_bitmask2;
+		goto search_through_memblks;
+	}
+	return(0);
+}
+
+#else /* !CONFIG_NUMA */
+
+struct page * _alloc_pages(unsigned int gfp_mask, unsigned int order)
+{
+	struct page *ret = 0;
+	pg_data_t *temp;
+	unsigned long flags;
+
+	if (order >= MAX_ORDER)
+		return NULL;
+
+	spin_lock_irqsave(&node_lock, flags);
+	temp = pgdat_list;
+	spin_unlock_irqrestore(&node_lock, flags);
+
+	while (temp) {
 		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
 			return(ret);
 		temp = temp->node_next;
 	}
 	return(0);
 }
+
+#endif /* CONFIG_NUMA */
 
 #endif /* CONFIG_DISCONTIGMEM */
diff -Nur linux-2.5.8-vanilla/mm/page_alloc.c linux-2.5.8-api/mm/page_alloc.c
--- linux-2.5.8-vanilla/mm/page_alloc.c	Sun Apr 14 12:18:44 2002
+++ linux-2.5.8-api/mm/page_alloc.c	Mon Apr 22 15:35:16 2002
@@ -41,6 +41,9 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
+extern int nummemblks;
+extern unsigned long memblk_online_map;
+
 /*
  * Free_page() adds the page to the free lists. This is optimized for
  * fast normal cases (no error jumps taken normally).
@@ -955,6 +958,10 @@
 void __init free_area_init(unsigned long *zones_size)
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 0, 0, 0);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	nummemblks = 1;
+	memblk_online_map = 1UL;
 }
 
 static int __init setup_mem_frac(char *str)

--------------040703070509050908020405
Content-Type: text/plain;
 name="numa_api-arch_indep-setup-2.5.14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-arch_indep-setup-2.5.14.patch"

diff -Nur linux-2.5.8-vanilla/include/linux/init_task.h linux-2.5.8-api/include/linux/init_task.h
--- linux-2.5.8-vanilla/include/linux/init_task.h	Mon Apr 22 17:20:20 2002
+++ linux-2.5.8-api/include/linux/init_task.h	Fri Apr 26 15:22:52 2002
@@ -59,6 +59,10 @@
     children:		LIST_HEAD_INIT(tsk.children),			\
     sibling:		LIST_HEAD_INIT(tsk.sibling),			\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    numa_restrict:	NEW_NUMA_SET,					\
+    numa_binding:	NEW_NUMA_SET,					\
+    numa_launch_policy:	NEW_NUMA_SET,					\
+    numa_api_lock:	RW_LOCK_UNLOCKED,				\
     wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
     real_timer:		{						\
 	function:		it_real_fn				\
diff -Nur linux-2.5.8-vanilla/include/linux/mmzone.h linux-2.5.8-api/include/linux/mmzone.h
--- linux-2.5.8-vanilla/include/linux/mmzone.h	Mon Apr 22 17:13:25 2002
+++ linux-2.5.8-api/include/linux/mmzone.h	Fri Apr 26 17:15:28 2002
@@ -136,6 +136,7 @@
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
+	int memblk_id; /* A unique ID for each memory block (physical contiguous chunk of memory) */
 	struct pglist_data *node_next;
 } pg_data_t;
 
@@ -163,14 +164,15 @@
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NR_NODES		1
 
-#else /* !CONFIG_DISCONTIGMEM */
+#endif /* !CONFIG_DISCONTIGMEM */
 
-#include <asm/mmzone.h>
+#if defined (CONFIG_DISCONTIGMEM) || defined (CONFIG_NUMA)
 
+#include <asm/mmzone.h>
 /* page->zone is currently 8 bits ... */
 #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
 
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
 
 #define MAP_ALIGN(x)	((((x) % sizeof(mem_map_t)) == 0) ? (x) : ((x) + \
 		sizeof(mem_map_t) - ((x) % sizeof(mem_map_t))))
diff -Nur linux-2.5.8-vanilla/include/linux/numa.h linux-2.5.8-api/include/linux/numa.h
--- linux-2.5.8-vanilla/include/linux/numa.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.8-api/include/linux/numa.h	Mon Apr 29 11:03:20 2002
@@ -0,0 +1,76 @@
+/*
+ * linux/include/linux/numa.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
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
+#ifndef _LINUX_NUMA_H_
+#define _LINUX_NUMA_H_
+
+#include <linux/types.h>
+
+#ifdef CONFIG_NUMA
+#define NR_MEMBLKS	32 /* Max number of Memory Blocks */
+#else
+#define NR_MEMBLKS	1
+#endif
+
+typedef unsigned long		numa_bitmap_t;
+#define NUMA_BITMAP_NONE	(~((numa_bitmap_t) 0))
+
+#define CPU_BIND_STRICT	0
+
+#define MPOL_FIRST	1   /* UNUSED FOR NOW */
+#define MPOL_STRIPE	2   /* UNUSED FOR NOW */
+#define MPOL_RR		4   /* UNUSED FOR NOW */
+#define MPOL_STRICT	8   /* Memory MUST be allocated according to binding */
+#define MPOL_LOOSE	16  /* Memory must try to be allocated according to binding first, 
+			       and can fall back to restriction if necessary */
+
+
+typedef struct numa_list {
+	numa_bitmap_t list;
+	int behavior;
+} numa_list_t;
+
+typedef struct numa_set {
+	numa_list_t cpus;
+	numa_list_t memblks;
+} numa_set_t;
+
+
+/* Initializes a numa_set_t to be an empty set. */
+#define numa_set_init(x) do { (x)->cpus.list = NUMA_BITMAP_NONE;\
+				(x)->memblks.list = NUMA_BITMAP_NONE;\
+				(x)->cpus.behavior = CPU_BIND_STRICT;\
+				(x)->memblks.behavior = MPOL_STRICT; } while(0)
+
+/* Assignment initializer for a numa_set_t to be an empty set */
+#define NEW_NUMA_SET { {NUMA_BITMAP_NONE, CPU_BIND_STRICT}, \
+		       {NUMA_BITMAP_NONE, MPOL_STRICT} }
+
+/* Tests whether a numa_set_t represents an empty restriction (ie: all 1's.  All cpus/memblks allowed.) */
+#define null_restrict(x) (((x)->cpus.list == NUMA_BITMAP_NONE) && \
+				((x)->memblks.list == NUMA_BITMAP_NONE))
+
+#endif /* _LINUX_NUMA_H_ */
diff -Nur linux-2.5.8-vanilla/include/linux/sched.h linux-2.5.8-api/include/linux/sched.h
--- linux-2.5.8-vanilla/include/linux/sched.h	Mon Apr 22 17:13:27 2002
+++ linux-2.5.8-api/include/linux/sched.h	Fri Apr 26 15:14:15 2002
@@ -28,6 +28,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/numa.h>
 
 struct exec_domain;
 
@@ -286,6 +287,12 @@
 	struct task_struct *pidhash_next;
 	struct task_struct **pidhash_pprev;
 
+	/* additional NUMA stuff */
+	numa_set_t numa_restrict;
+	numa_set_t numa_binding;
+	numa_set_t numa_launch_policy;
+	rwlock_t  numa_api_lock;	/* protects the preceding 3 structs */
+	
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 
diff -Nur linux-2.5.8-vanilla/include/linux/smp.h linux-2.5.8-api/include/linux/smp.h
--- linux-2.5.8-vanilla/include/linux/smp.h	Mon Apr 22 17:13:25 2002
+++ linux-2.5.8-api/include/linux/smp.h	Fri Apr 26 15:14:15 2002
@@ -90,6 +90,7 @@
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
+#define memblk_online_map			1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define __per_cpu_data
diff -Nur linux-2.5.8-vanilla/kernel/sched.c linux-2.5.8-api/kernel/sched.c
--- linux-2.5.8-vanilla/kernel/sched.c	Mon Apr 22 13:17:43 2002
+++ linux-2.5.8-api/kernel/sched.c	Mon Apr 22 15:35:16 2002
@@ -357,7 +357,7 @@
 	runqueue_t *rq;
 
 	preempt_disable();
-	rq = this_rq();
+	rq = task_rq(p);
 	spin_lock_irq(&rq->lock);
 
 	p->state = TASK_RUNNING;
@@ -371,7 +371,6 @@
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio = effective_prio(p);
 	}
-	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 
 	spin_unlock_irq(&rq->lock);
@@ -1662,8 +1661,7 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	if (!(new_mask & cpu_online_map))
 		BUG();
 
 	preempt_disable();

--------------040703070509050908020405
Content-Type: text/plain;
 name="numa_api-prctl-2.5.14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-prctl-2.5.14.patch"

diff -Nur linux-2.5.8-vanilla/include/linux/prctl.h linux-2.5.8-api/include/linux/prctl.h
--- linux-2.5.8-vanilla/include/linux/prctl.h	Sun Apr 14 12:18:54 2002
+++ linux-2.5.8-api/include/linux/prctl.h	Wed Apr 24 17:31:33 2002
@@ -26,4 +26,31 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */

+/* Get/Set Restricted CPUs and MemBlks */
+#define PR_SET_RESTRICTED_CPUS		11
+#define PR_SET_RESTRICTED_MEMBLKS	12
+#define PR_GET_RESTRICTED_CPUS		13
+#define PR_GET_RESTRICTED_MEMBLKS	14
+
+/* Get CPU/Node */
+#define PR_GET_CPU	15
+#define PR_GET_NODE    	16
+
+/* X to Node conversion functions */
+#define PR_CPU_TO_NODE		17
+#define PR_MEMBLK_TO_NODE      	18
+#define PR_NODE_TO_NODE		19
+
+/* Node to X conversion functions */
+#define PR_NODE_TO_CPU		20
+#define PR_NODE_TO_MEMBLK      	21
+
+/* Set CPU/MemBlk/Memory Bindings */
+#define PR_BIND_TO_CPUS		22
+#define PR_BIND_TO_MEMBLKS	23
+#define PR_BIND_MEMORY		24
+
+/* Set Launch Policy */
+#define PR_SET_LAUNCH_POLICY	25
+
 #endif /* _LINUX_PRCTL_H */
diff -Nur linux-2.5.8-vanilla/kernel/sys.c linux-2.5.8-api/kernel/sys.c
--- linux-2.5.8-vanilla/kernel/sys.c	Sun Apr 14 12:18:45 2002
+++ linux-2.5.8-api/kernel/sys.c	Wed Apr 24 17:32:17 2002
@@ -16,6 +16,7 @@
 #include <linux/highuid.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/numa.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1277,6 +1278,51 @@
 				break;
 			}
 			current->keep_capabilities = arg2;
+			break;
+		case PR_SET_RESTRICTED_CPUS:
+			error = (long) set_restricted_cpus((numa_bitmap_t)arg2, (numa_set_t *)arg3);
+			break;
+		case PR_SET_RESTRICTED_MEMBLKS:
+			error = (long) set_restricted_memblks((numa_bitmap_t)arg2, (numa_set_t *)arg3);
+			break;
+		case PR_GET_RESTRICTED_CPUS:
+			error = (long) get_restricted_cpus();
+			break;
+		case PR_GET_RESTRICTED_MEMBLKS:
+			error = (long) get_restricted_memblks();
+			break;
+		case PR_GET_CPU:
+			error = (long) get_cpu();
+			break;
+		case PR_GET_NODE:
+			error = (long) get_node();
+			break;
+		case PR_CPU_TO_NODE:
+			error = (long) cpu_to_node((int)arg2);
+			break;
+		case PR_MEMBLK_TO_NODE:
+			error = (long) memblk_to_node((int)arg2);
+			break;
+		case PR_NODE_TO_NODE:
+			error = (long) node_to_node((int)arg2);
+			break;
+		case PR_NODE_TO_CPU:
+			error = (long) node_to_cpu((int)arg2);
+			break;
+		case PR_NODE_TO_MEMBLK:
+			error = (long) node_to_memblk((int)arg2);
+			break;
+		case PR_BIND_TO_CPUS:
+			error = (long) bind_to_cpu((numa_bitmap_t)arg2, (int)arg3);
+			break;
+		case PR_BIND_TO_MEMBLKS:
+			error = (long) bind_to_memblk((numa_bitmap_t)arg2, (int)arg3);
+			break;
+		case PR_BIND_MEMORY:
+			error = (long) bind_memory((unsigned long)arg2, (size_t)arg3, (numa_bitmap_t)arg4, (int)arg5);
+			break;
+		case PR_SET_LAUNCH_POLICY:
+			error = (long) set_launch_policy((numa_bitmap_t)arg2, (int)arg3, (numa_bitmap_t)arg4, (int)arg5);
 			break;
 		default:
 			error = -EINVAL;

--------------040703070509050908020405--

